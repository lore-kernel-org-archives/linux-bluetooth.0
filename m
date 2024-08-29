Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDF1A7047
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937920; cv=fail; b=dafsRj5gC7c44qF0sZyaf1P5h1FC5nTZ5HwBTb+o6o5+sRzoNdK7OUl1HtGwjwnxxVZCxX+2EHSqKNPD9rjipJSrLtJBV144mu50kpNMaDB1+OTQr1iAUeMQMBAHwHpS9mSmohyBpx6amB0nMQnzB536/yEOg0ruTmhE67ORpt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937920; c=relaxed/simple;
	bh=5z/xPXbLHu15le3Wd2Ep7/KUfsSbeFzBXQF3jgFRoxg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=vF/cGNQGQXbcYzoWcVO5SQ3rHntnHAsNIjG04FqMCNw4BI994YkJYOJrVjlf5tNwescanM9cVOA6wgOritPKc4rVXeRCkzNkociFmxeIQc7FlD9qvZ59okt3MCIVC7rpFBwOJ/cfkFZ8G31LVr3mSPYA+qez6WecNTTA7i/AspY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BFp+96ln; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BFp+96ln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiZDU4feEKw5Bbs3Vy0r/RBwQVO0Jk38LOICaJsLkIX2/IUY24Rf0r0oFr1f/xhtPIpwm5vI//p0YYDpDUJWMknyqoc1PnMHXvYJtvvlfXCverXGGuFZFmmpl/O7P1yO0EHZatRqOczdCheB7uX+t6+jcseNKGYwQfhrJ5dyNYWn3JGi+qz55LAFLOR9pzIxLdHaIrJdQsNO4p8VPWUKeTha5ryFfrkuCfrBdr9nwkRz/4wWO7554XKUNVhvuxfY4Sz7JJXVnsqV+IIMxcfdJrF0c0z+RUS/TRYtkp7mVgMhqVzD6HQizaMQJOGL/j/vcp1Z57ekt1tGNDAOezEPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUQW3TreaiVkPu8pReYKP1DvHWPaTOT3hEYLVHqaWxs=;
 b=EvoGzYeVY7KQ6smkICDcmH7o8Px7bpvwqER7Mpd2nbohUV9S4n6x7nnqHi5btR+6iXLLWHsMlnHF87QFEDwT9AOwN5WAGyYnVMqQI4KK/CSU9F7Szbapa+j2ZyXeA/i4RYvISUI4D0Pe3zpZwaUttEJLlpfC8Zjt8jy3aHfPyPGpIPdxhwuD2EbHqsvn82HYz1JqPDe7CsP9688cxlemGzH07veY9QpyT8MsqBaX3LEwBWdfpM8Vl3QvnFI8I/OXxOM5jU8y0ItuHRyV9NeGjMgb4mdlPMExOXFORzxfIqXLnfEoQp8cyitfXerZJja5dkOpaRaa/PgfHrU8OWec/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUQW3TreaiVkPu8pReYKP1DvHWPaTOT3hEYLVHqaWxs=;
 b=BFp+96lnlBPQ3z6/G4fQj8yh1C2jHWmhY/ii77QSRO9pi1gBwPkPoKsl45GTo9o/PLtR5dIdMbkx3MssM421I72J9tDlJQNUWH7aCvdhxG4TVlWtiwJZvX9LKQh69nK/FNwk64/AFrrCh0IE0d+182Na5qM+uTTXPixO5BOnjri+ulxB6icHAAGvJQrv/ocNb66Z4FyNtsIo/8IRukQAE6D+WRQCiWoequxoj0GK8LSa7qyUbFt9JAGuWkebdHwawYqCNX12EJ8uzmbZEJ1ebpfAXBi3yDMnjxSBrqfGevs8ljQDsV56d0s1n8mkm6KaKcH1lDgp+utmaCZQWmjSdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9385.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 13:25:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 13:25:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] client/assistant: Enter Broadcast Code as string
Date: Thu, 29 Aug 2024 16:25:05 +0300
Message-Id: <20240829132507.4545-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0053.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d47b81-16bd-4d02-83fe-08dcc82e0496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AsH7oUxrie4LxmiZto6kC/SK0n+qqg9dbVOM9HUIOzY0sS5hOOD3Hg/Iegw3?=
 =?us-ascii?Q?DW7TTSeWc+bzumzBTQuRP1Rz34AN+uUjnLXRdJOmP1WH7vcsARIuMuWTIMJV?=
 =?us-ascii?Q?sbH+iBuWYRIbxUuhWlo+dKalo3gohBR7xVZVW1imbgYOO4w7HTTYQkafluKM?=
 =?us-ascii?Q?6OBQ1n0IlFmkfkQXr/YHxPmKJw/vf0lE5XZuJ/Vl3DZYanj1hyIwlM6QsJ7A?=
 =?us-ascii?Q?QGW5fMRXbpgTYdXjC4H+g6NZFlHoRPvQAutT8RN1YTZJ3SQHoxA12kU/ft6Q?=
 =?us-ascii?Q?hKQ8ilZYVjoLWMz58z1h8q0UQ5SJO443WY2pH74N/ny01Ds1IpN2y7Z6/D1S?=
 =?us-ascii?Q?DF4DpNBNF/NRPDoxRae5pvR90f55SDhFMoEZWPO/y0IZeIlQDdoxro7Cuxcc?=
 =?us-ascii?Q?FR01vJ0J7zafEEs2g00s754zNy3dYrZmtLrZLrHeL6KVoIKoLFcCK7JnPyCU?=
 =?us-ascii?Q?zCveXiFjpgDWL/94RA06oJECDqFr508FKr2mUoAeC4Vl3emk+n/70UKDnGKg?=
 =?us-ascii?Q?t/KK1ny9wnRAcZY6GbM/IChJEaMlh4Hc9VUcqKQ6gDHDtOIJ+hsh3uGIFbsp?=
 =?us-ascii?Q?9TSQXDSGcwTOuTo9wyJzer4OY6nLaulwx4PtmxqFW/maLACtU3SAqIlz/MlU?=
 =?us-ascii?Q?2JsGop2aoVYoFXo/5/2Jddde0hn0FNsj/vTOrEFrj3cPMdn0fWqxe0rqhUvB?=
 =?us-ascii?Q?gzFS8f9dw6u47q5LHNzDmJgV3prtKpaFirL/vo2HbOjPcT5PsxFaUffY4Poh?=
 =?us-ascii?Q?MhhRxZwqj0y5B7HSo+1nZ59MAO8KCJSYQfWaj+l5nc6rb+2LdDR3YMVZjKWf?=
 =?us-ascii?Q?Tm3oPAFxn7VSnjmt/Exwtd1xrhUkE2jLJEW6hzK1TNoCo0UNoHb0cyqG+/5X?=
 =?us-ascii?Q?urv/JHTKml9S9H9mGw+SVISN4OfyeP+N9MLRn4E85JXBpI7QMjW/W9Ks1ow3?=
 =?us-ascii?Q?/cjGu8nGd6ee+BeETxLsr6qjluK4eWiB/MJ9cMJnUgy45C+4KhOmoXvkpUGh?=
 =?us-ascii?Q?Vci3yhlIldaFLt0IkYHUiWSds+YxwP7NWrs4hrCq5Bj5GUecO5aONMnpx5Yx?=
 =?us-ascii?Q?SeeY3+tDvtMDt+2379VAdxAD0JAxaDzUf7CW8iCN8gjN44uixvOEEv8tCgK0?=
 =?us-ascii?Q?HUFsU8j5TaiG6mt2aVYDgN1b+Jnt1Lyo/SnYjXm7FWufVt1j9UFMPGI/ZL/O?=
 =?us-ascii?Q?FYaCr6tVU2ESSDUK9E5i1zzYv7zhEGzy1dkHFjgsahgCnw9ehC8MdsE6ZKr8?=
 =?us-ascii?Q?DnF89k3l5EXBa0zvrNlZ/E47qVAaPy02BgQ8/vexbbUc8KiWulm8O2YQbrq3?=
 =?us-ascii?Q?iIZaOGCbR/UYY2nli3gPdAqWVu7kRPyHSWWdGv9SnTptwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0obdB4bBttbWPCxvAbuAlMVK43s/sCOYNa7HJlhVO1Ow9yWRDb059AsXxz9?=
 =?us-ascii?Q?srVJDwktLpdrp/bhZro4jTHuuAEXND5JS5030Mj7WhYaGxZK9s0KfbG5grMB?=
 =?us-ascii?Q?vKTsS4UAjbAUDoQ37GRJgxyoS9Fy9EReLvGyz88CWTFxsGqjb4ByQbE2wv1S?=
 =?us-ascii?Q?y3tsP6TqVqmUsk5a3uk0w6NLBy3pZXrJ6QT+uQIt73aW4v9mMuZHjElhmXGS?=
 =?us-ascii?Q?UzXLVm8F9Tpae4GYYH3oRvSr8JKoA18VUYoNspiVM6cKsdhc9tQuEf//aLIR?=
 =?us-ascii?Q?pePKnz1gdhG17VZToxoJWY8sqacvneJy5zMFMvpqWd09iyprQzv+E0n19C+l?=
 =?us-ascii?Q?FOFwOUZ4j9+3yjazf0ZJgXTnPnJmxBcs4Ho7C5w4FB/oQVs/wYXfg4rzqu8p?=
 =?us-ascii?Q?x0is3ddNkYbT4KmqefQ6EA9pZgvr3F16q1h6GjcENx3ry+39EArksjf33ZrE?=
 =?us-ascii?Q?TVjqPuBWlt4MdQCCvSrxZhh4bpI7uddOcecPveaN/WKXNCfYQpV9FU2ETAVL?=
 =?us-ascii?Q?vn6M7oAO0dTZYbcUtCUo2yhCRnW9h0Kq4BNRSfA10E5QTey+syTF53tZTSGm?=
 =?us-ascii?Q?lASdlsRg8WuMiZ1vCSmSWEE2dI7kacp8K3z93bqt58ipl3TK7elr28qMbI6V?=
 =?us-ascii?Q?ZgTc48wXqUDVHhPErUnICE9377+DVs1mD//yCvu7qvp/m6pOf6etXkd3wsJ2?=
 =?us-ascii?Q?gAH97ZzWfAaozin5gYeR11dlvMtK3P7P+41wF7WoPmBLUph2GpkarLiY/K1s?=
 =?us-ascii?Q?kCUki+sokwCv7d6FABTZcXKhkXarQ4hBbYHmv+D2xW63Xtnraz2qBsWj/qts?=
 =?us-ascii?Q?nkVZQigQMLPgVDR+XiLJnKg5vfW13EATEi2G1+2nefVGalXeIv7rEB6mTnmk?=
 =?us-ascii?Q?lk4RWgsjOLM6HCeg+VIjHg54Pf32zt6ILuhHm6uKaQODNPiDKDcR5XK5fT6u?=
 =?us-ascii?Q?CEsiXS0nx8EWzb8Fg2ECVS16U0fiqZlbdqziYr6u9JyiYIX+JHrxmQk/AxyK?=
 =?us-ascii?Q?AmUo5p+syi2EL5Po4332wX1TbA1IYHtGValT7vAUG/3s3RUW9vGG5p2x6w4g?=
 =?us-ascii?Q?A06FnV8gHQP+ILnKK1aUDzCWKXAMW5n3U1U++NO1Z7gGiGES4rjPiTNusOO2?=
 =?us-ascii?Q?PZQlj2ZebUA+KvnM7kzaDuZldOraHzptPkAZTsrvm2WaMSv+cQ0XrJIOkKkB?=
 =?us-ascii?Q?j9K2TPvwqNg7Jo7u9UTGSIWaKKWE6z3HB0ju+4kalsE6puFhOCC871ep/37S?=
 =?us-ascii?Q?S60EoLrR1HaPKh4qCIdxRcDAW490F1WddAZmh8AIjfMhOCp5sI7jnklJvN6n?=
 =?us-ascii?Q?OuzX3Hk4qt3fvbZ2twA8zUVe+fB7WMqh90NqyKsaa5CN/4Ccq/FU84CVlYHF?=
 =?us-ascii?Q?9dhRSSM/QI2NsCd4up8ZRLvZJTn9yDGz85HdvC5TabUDYXO9ks1EYIjbukrP?=
 =?us-ascii?Q?dkTn1L0MtKyCUasvGKVwt21tYjJ+g91n0/seDs+1CcMTJ+JJq48Iex1Tez9m?=
 =?us-ascii?Q?tJukiewDyDlezjDqEcaFfUxco73JKStsc4cFq26p/3LXMPD5lrtXBJTOnGx/?=
 =?us-ascii?Q?Jo6rLRawU97R+mzNecgI1LeKjEbXBIJ6tVRfM1qYkhQ6AMP3TzCc6g9pfwVI?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d47b81-16bd-4d02-83fe-08dcc82e0496
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 13:25:15.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhT8wQAJr1BOcTYzaWSWljELZ6qw/23iE1Yk4AEwR2VQyYY6WHjYNA5yJnSgzHZDFl8NpBoJ0yF12iMVAjiq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9385

Currently, the user sets the Broadcast Code as an array of bytes
when prompted from the assistant submenu. However, the Bluetooth
Core Specification requires that, on the UI level, the Broadcast
Code shall be represented as a string (Vol 3, Part C, 3.2.6).

This patch makes the Broadcast Code be parsed as a string from
the assistant prompt. The bluetoothctl-assistant.rst is also
updated.

The bluetoothctl log below shows a Broadcast
Assistant pushing an encrypted stream to a peer:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 19:9A:7A:71:E5:8B 19-9A-7A-71-E5-8B
[00-60-37-31-7E-3F]# [NEW] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): a
[Assistant] Enter Broadcast Code (auto/value): Borne House
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: pending
[00-60-37-31-7E-3F]# Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: requesting
[00-60-37-31-7E-3F]# [CHG] Assistant
    /org/bluez/hci0/src_19_9A_7A_71_E5_8B/dev_00_60_37_31_7E_3F/bis1
    State: active

The btmon log below shows the way the Broadcast Code string is converted
into a byte array and sent to the peer via GATT:

bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 28
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 02018be5717a9a1900db5e3a02ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 19:9A:7A:71:E5:8B
            Source_Adv_SID: 0
            Broadcast_ID: 0x3a5edb
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
> ACL Data RX: Handle 0 flags 0x01 dlen 2
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 01018be5717a9a1900db5e3a0201010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 19:9A:7A:71:E5:8B
          Source_Adv_SID: 0
          Broadcast_ID: 0x3a5edb
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
bluetoothd[6013]: < ACL Data TX: Handle 0 flags 0x00 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 040142c3b8726e6520486f75736500000000
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 426f726e6520486f7573650000000000
> ACL Data RX: Handle 0 flags 0x01 dlen 2
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 01018be5717a9a1900db5e3a0202010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 19:9A:7A:71:E5:8B
          Source_Adv_SID: 0
          Broadcast_ID: 0x3a5edb
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001

Iulia Tanasescu (2):
  client/assistant: Enter Broadcast Code as string
  bluetoothctl-assistant.1: Update push command example

 client/assistant.c                | 24 ++++++++++++++----------
 client/bluetoothctl-assistant.rst | 16 ++++++++++------
 2 files changed, 24 insertions(+), 16 deletions(-)


base-commit: 4ed7060ca9dfcc89c55801f818b0b43db6f5acdd
-- 
2.39.2

