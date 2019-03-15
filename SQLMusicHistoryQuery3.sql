[2019-03-14T12:49:38.1194202-07:00 Begin Query] URN:Server/Information
[2019-03-14T12:49:38.1497120-07:00 End Query] URN:Server/Information 

                                   Elapsed time:16.6352 ms 

                                   Query: 
                                           create table #SVer(ID int,  Name  sysname, Internal_Value int, Value nvarchar(512))
                                           insert #SVer exec master.dbo.xp_msver
                                           if exists (select 1 from sys.all_objects where name = 'dm_os_host_info' and type = 'V' and is_ms_shipped = 1)
                                           begin
                                           insert #SVer select t.*
                                           from sys.dm_os_host_info
                                           CROSS APPLY (
                                           VALUES
                                           (1001, 'host_platform', 0, host_platform),
                                           (1002, 'host_distribution', 0, host_distribution),
                                           (1003, 'host_release', 0, host_release),
                                           (1004, 'host_service_pack_level', 0, host_service_pack_level),
                                           (1005, 'host_sku', host_sku, '')
                                           ) t(id, [name], internal_value, [value])
                                           end
                                         
                                   SELECT
                                   CAST(
                                           serverproperty(N'Servername')
                                          AS sysname) AS [Server_Name],
                                   'Server[@Name=' + quotename(CAST(
                                           serverproperty(N'Servername')
                                          AS sysname),'''') + ']' AS [Server_Urn],
                                   CAST(null AS int) AS [Server_ServerType],
                                   0 AS [Server_IsContainedAuthentication],
                                   (@@microsoftversion / 0x1000000) & 0xff AS [VersionMajor],
                                   (@@microsoftversion / 0x10000) & 0xff AS [VersionMinor],
                                   @@microsoftversion & 0xffff AS [BuildNumber],
                                   CAST(SERVERPROPERTY('IsSingleUser') AS bit) AS [IsSingleUser],
                                   CAST(SERVERPROPERTY(N'Edition') AS sysname) AS [Edition],
                                   CAST(SERVERPROPERTY('EngineEdition') AS int) AS [EngineEdition],
                                   CAST(ISNULL(SERVERPROPERTY(N'IsXTPSupported'), 0) AS bit) AS [IsXTPSupported],
                                   SERVERPROPERTY(N'ProductVersion') AS [VersionString],
                                   ( select Value from #SVer where Name =N'host_platform') AS [HostPlatform],
                                   CAST(FULLTEXTSERVICEPROPERTY('IsFullTextInstalled') AS bit) AS [IsFullTextInstalled]
                                   ORDER BY
                                   [Server_Name] ASC
                                           drop table #SVer
                                         

[2019-03-14T12:50:31.9750675-07:00 Begin Query] URN:Server[@Name='HNEAL-PC\SQLEXPRESS']/Database[@IsSystemObject = 0 and @IsDatabaseSnapshot = 0]/Option
[2019-03-14T12:50:31.9917714-07:00 End Query] URN:Server[@Name='HNEAL-PC\SQLEXPRESS']/Database[@IsSystemObject = 0 and @IsDatabaseSnapshot = 0]/Option 

                                   Elapsed time:30.0626 ms 

                                   Query: 
                                   SELECT
                                   dtb.name AS [Database_Name],
                                   'Server[@Name=' + quotename(CAST(
                                           serverproperty(N'Servername')
                                          AS sysname),'''') + ']' + '/Database[@Name=' + quotename(dtb.name,'''') + ']' AS [Database_Urn],
                                   dtb.containment AS [Database_ContainmentType],
                                   dtb.recovery_model AS [Database_RecoveryModel],
                                   ISNULL(suser_sname(dtb.owner_sid),'') AS [Database_Owner],
                                           case
                                           when dtb.collation_name is null then 0x200
                                           else 0
                                           end |
                                           case
                                           when 1 = dtb.is_in_standby then 0x40
                                           else 0
                                           end |
                                           case dtb.state
                                           when 1 then 0x2
                                           when 2 then 0x8
                                           when 3 then 0x4
                                           when 4 then 0x10
                                           when 5 then 0x100
                                           when 6 then 0x20
                                           else 1
                                           end
                                          AS [Database_Status],
                                   dtb.compatibility_level AS [Database_CompatibilityLevel],
                                   ISNULL(dmi.mirroring_role,0) AS [Database_MirroringRole],
                                   ISNULL(dmi.mirroring_state + 1, 0) AS [Database_MirroringStatus],
                                   drs.database_guid AS [Database_DatabaseGuid],
                                   CAST(
                                           case
                                           when SERVERPROPERTY('EngineEdition') = 6 then cast(1 as bit)
                                           else cast(0 as bit)
                                           end
                                          AS bit) AS [Database_IsSqlDw],
                                   dtb.recovery_model AS [RecoveryModel],
                                   dtb.user_access AS [UserAccess],
                                   dtb.is_read_only AS [ReadOnly],
                                   dtb.name AS [Database_DatabaseName2]
                                   FROM
                                   master.sys.databases AS dtb
                                   LEFT OUTER JOIN sys.database_mirroring AS dmi ON dmi.database_id = dtb.database_id
                                   LEFT OUTER JOIN sys.database_recovery_status AS drs ON drs.database_id = dtb.database_id
                                   WHERE
                                   (CAST(case when dtb.name in ('master','model','msdb','tempdb') then 1 else dtb.is_distributor end AS bit)=0 and CAST(isnull(dtb.source_database_id, 0) AS bit)=0)
                                   ORDER BY
                                   [Database_Name] ASC

[2019-03-14T12:50:46.4134452-07:00 Begin Query] URN:Server[@Name='HNEAL-PC\SQLEXPRESS']/Database[@Name='MusicHistory']/Option
[2019-03-14T12:50:46.4440171-07:00 End Query] URN:Server[@Name='HNEAL-PC\SQLEXPRESS']/Database[@Name='MusicHistory']/Option 

                                   Elapsed time:23.503 ms 

                                   Query: 
                                   SELECT
                                   dtb.name AS [Database_Name],
                                   'Server[@Name=' + quotename(CAST(
                                           serverproperty(N'Servername')
                                          AS sysname),'''') + ']' + '/Database[@Name=' + quotename(dtb.name,'''') + ']' AS [Database_Urn],
                                   dtb.containment AS [Database_ContainmentType],
                                   dtb.recovery_model AS [Database_RecoveryModel],
                                   ISNULL(suser_sname(dtb.owner_sid),'') AS [Database_Owner],
                                           case
                                           when dtb.collation_name is null then 0x200
                                           else 0
                                           end |
                                           case
                                           when 1 = dtb.is_in_standby then 0x40
                                           else 0
                                           end |
                                           case dtb.state
                                           when 1 then 0x2
                                           when 2 then 0x8
                                           when 3 then 0x4
                                           when 4 then 0x10
                                           when 5 then 0x100
                                           when 6 then 0x20
                                           else 1
                                           end
                                          AS [Database_Status],
                                   dtb.compatibility_level AS [Database_CompatibilityLevel],
                                   ISNULL(dmi.mirroring_role,0) AS [Database_MirroringRole],
                                   ISNULL(dmi.mirroring_state + 1, 0) AS [Database_MirroringStatus],
                                   drs.database_guid AS [Database_DatabaseGuid],
                                   CAST(
                                           case
                                           when SERVERPROPERTY('EngineEdition') = 6 then cast(1 as bit)
                                           else cast(0 as bit)
                                           end
                                          AS bit) AS [Database_IsSqlDw],
                                   dtb.recovery_model AS [RecoveryModel],
                                   dtb.user_access AS [UserAccess],
                                   dtb.is_read_only AS [ReadOnly],
                                   dtb.name AS [Database_DatabaseName2]
                                   FROM
                                   master.sys.databases AS dtb
                                   LEFT OUTER JOIN sys.database_mirroring AS dmi ON dmi.database_id = dtb.database_id
                                   LEFT OUTER JOIN sys.database_recovery_status AS drs ON drs.database_id = dtb.database_id
                                   WHERE
                                   (dtb.name=MusicHistory)
                                   ORDER BY
                                   [Database_Name] ASC

