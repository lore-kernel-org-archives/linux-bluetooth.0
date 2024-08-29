Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600361B1415
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935807; cv=fail; b=LBXH1WEuh0aZR/4VFylEQXXKajCHZfInxbGhjDBIHYufLQ6CzoNAlhMI7oR23l6YaIwE91o3bT4kY2Axd4r++Bi68zfZpTL/BjULwxwESSSDXPtog3aAtQH0E/mwhX6WoADHP0xXV+vhkNudBLKJQ8NpoHeYUz8ApwkAUlQm21A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935807; c=relaxed/simple;
	bh=ik7y9/ysnwickFshVrx4ZZ3k7LZuo8sEbpJyRsfkxjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5QpxTEkb1ZD1pRJ4o6Z6cBLRv2kpGyHSJVO9zQlXgQiEg7TZEPUe8bvqp9YlkkoyLrjSc/a8oJTf9lGtnkrFX5/IjVdSJdWiMmqUbslY1v0LYYlCE3MFOoB8R8oGMUaZbL0AZrlYFyFjYOcg/ehhPCSEDBvqSHV+7Dtq6oCRio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ffQ4yFcp; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ffQ4yFcp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrFXH/2t6JSQou38JEGhfw/2q8SCARHpPnQtA5VGyop3F0AbBsd2V09sXPCc+whtMMrSZnN/Il5q3GUNMDdHAQX8FjNsixIlOoWVp6t4ILxYPbP8klfE/QgfC+k3bYO/qYtkeKrnCCZUhYsx/hSc/lgCeOfnD6bDd0bsCc67SxbSCvMWqMvpZOsLSXGBSh+Faxt52NieTwQIIYHSJzF1twACVSqYtHUDy5vFyjZtiB6n4SVdDUL2aYJyNfHFaTWVz0RC0JJjzNIxZgJJFA0wiEH2OI/ZLc8j0CJKDf4IJ3DloxuZKz9nt6NqNj9h2oV5fsK0wD9qT+p9fxY7NX+aYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWWcPuzPkQrGyggI5XxerOGnp0d3BAmxDNTfRK3K0Uw=;
 b=PBMroRNX9q+pAygaJwYJbTNvDiSMIaafW/5CYYu8iKs684Ef8VKe/Eo8QeyQq4AWp5QoxrtAC66fAm4zdhgXzFjPvRHi8dvSwz5QzBCiYdwj0RTLzHIl0Irw1tAH88q2mlUANt98ykC+rYPsWwFvlyeuR/SZCEc40BgG8INgopaqYYe9P/B8YMdtfeiu8MFInMQ95qyouNPHYBd905nP554LSxSTM79PcTwJpDjHKNk9grHRmSZSNq4y2hH9Wp+vtP/Me5cwcDC48xEOfWf4u2kwHfED8lk1WzH26Ec5uwvSvaJRAh4MyNcpqmCR/FVp2INt9j2kr1Uh5FBzKVOGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWWcPuzPkQrGyggI5XxerOGnp0d3BAmxDNTfRK3K0Uw=;
 b=ffQ4yFcpLKcLYwdE2ICqmw8wADbUA2uO2xHqiSmXUGYXwNspahMNP+K7hSvM5z8gkMdfn/lXwq+LCAXDiJWu2cfZ5vIim2jZ5wFzd0xGVMLgssg/aXbcrMaeVOm1be18BOmvyB7gWmgbVJSL6nrBPpSyyW8KltJbj4O3Kf7oXH56bYZ47ozD6uiSvMJZ+7pmDbE0eBdSA4dw2F5m8xZ2v/t3K/rKi6K0KAWkZ/g2jHANLKrjfnv6+XhP4bFeHeH40IZycOpuqZ4+8iR5scTZJ4lub1v2/GkJ2fsAVZqLDwYNgBwSlwUyD/6gtPR7Mzftrey/jhlFzDq5FPuNHKNK2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:50:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:50:02 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 13/16] bass: Register BAP state changed cb
Date: Thu, 29 Aug 2024 15:49:15 +0300
Message-Id: <20240829124918.84809-14-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 497ffbd7-b612-48cb-8664-08dcc829194d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHzxpeJ16oUDW3LP4cUlLlb4IwN9FzPEbQSFtL1mopiV45fJacGumxe86L0g?=
 =?us-ascii?Q?N2depyF0jU//J1R395m2XxiUw4MsYci/7MAMehR1kXuCZaNSaJ0uAWV5j6rV?=
 =?us-ascii?Q?YpooTQUvlVJ1M1KYXjyVbK2CETzwO3SMffCmBnjDAaRe25h8vH8k8JirXuCl?=
 =?us-ascii?Q?NZd53HOzXkF4stn1zQZOKB53wiXrKxstqFvg0AzWlV1Fg5i2aqg9bKI7LP6n?=
 =?us-ascii?Q?Win9JqW26revspKhRq9ftKOs7URLDnJ9VhHwRw29l37YkaAObC5K7Jo9txWL?=
 =?us-ascii?Q?O1SzK5rthjD7IIszWSihn9TU0ZWTQEvgdev8DuKRJfJRgu83m2hpvhOcGtZH?=
 =?us-ascii?Q?OVnnfsDomM0vQfy2M1I05VVJHuPIqi0EExb0Avwv8WmMMN9ZBybEdxtasCaC?=
 =?us-ascii?Q?dRbdnxoa7jqMYBtU7nOCD7ggd0SgmCHeEGZBtIt9mRVlW5UyRTImBTwbmJxP?=
 =?us-ascii?Q?YUS4wrbHvbPtStxpnvSoQ+WmiOag8UG9Kl43By1ARgk90EheDcl2r6mYnP5e?=
 =?us-ascii?Q?4ot1PYt0QTPjHPN0kwyLZ1coqyr4TKGZzXnn2IZfDlwUPai84ZHQaj6uPg4/?=
 =?us-ascii?Q?zD/f5tb08JZIVHsTBnxoJ6tAGz4Nu+mBqbNqFSmWBRYdwzihVobXEDryJhpQ?=
 =?us-ascii?Q?EHidfEnKxG02QmNMEkfrgtTnPK3R5Oes4sw9pDLGRMpjoOtnuxM9iquidbaG?=
 =?us-ascii?Q?kISx1h4r/TDA1Ry3qTOZnDmyLYKcdvhOKgS6lIiGPcIoMzL9x85AfdMJKN5P?=
 =?us-ascii?Q?JLxijgVlJMklcZzA1faeyP5cPzXpEB5lcxVNFKzsk324QzTcQmYcAIfnsvFw?=
 =?us-ascii?Q?91udOs/MNJXV8fjzsTXEbrdD9x1rUR/DYjj2HaiOwzLymq6JieJjsL+oJ8+e?=
 =?us-ascii?Q?TTGGC+BcDlCjpeI6g3/yE1Np1xnsDQ8H8/iK27eEyMWwfFNR9PlbOpkKiNsw?=
 =?us-ascii?Q?EFeBkE6k+Jef71rtPu8cPx/t1XOWeVX4XpdYraEPbZcm4Pb3OCEuDEHxB/AO?=
 =?us-ascii?Q?jleGMekUPHDiA8Nbjz96j/GedydzxZmO+8OWJfNTqqyE4Yjm9c6JDF5DF+lk?=
 =?us-ascii?Q?5Ab7K6AR4tCEJ2S77HCRbvl5op90LofSouDWK+67Ksv5+CZC7sOYt29jJFmO?=
 =?us-ascii?Q?J4iyKyXGZeUAVtblwMUnf/AJRguwbP6vVAa9C0jqSHvKTwErR8683PLl8vnk?=
 =?us-ascii?Q?7pIh1gHgS/FlGNrWslYQpD3jqyBPI0SKl0TG/bQqw3McEibSLN+nOfUVDO1f?=
 =?us-ascii?Q?Gwi7hvrrkHDH891nYApqCKqUxbCpNajiJ40rZf2n0ckjsyb5YY5BZkRa0faf?=
 =?us-ascii?Q?ti4RASwWJroz4GSbFaWJFKsG0JI8i/CtWBE0i39A5Vqd4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h6XLiW2vcZmdvgCahKl5nX2OMFnOrZWhUDAlp8GubhNQXOZFj4HJ1YdPqj2l?=
 =?us-ascii?Q?m+4ZBg00H6z9iIaDpUFSPwKoC66xnzpuYE9T0kwmkbnroiCtb/5TCnQeYwIz?=
 =?us-ascii?Q?fNbFbaKVPCoX4cxMoKIq7+T6bIMI1kDyKelVjZKV0fiDRgOBPK7VtrSYAAZ3?=
 =?us-ascii?Q?/lkWX1F8tWIepwpWKGLBWBYwYi9oSkQaxYtXSaHT0DFBjFgOAOq5BHw1+QQF?=
 =?us-ascii?Q?k1JDrW0OqyHkgzPi7WA5UX/iVOTaeGTapUjOnMf5/sLHLwX9GDdkihSLEvZu?=
 =?us-ascii?Q?SMqcc94upXd6pkJJDisiCWoCj7JV3RPFTd4pTNTFedcIBZrkc8jNQ3SFeQCC?=
 =?us-ascii?Q?bJEyXSyzE0mbhxypWMOi9FNRcTDo1oA+fNb8ZhbF86xko/rHNvK1K+zGWtFj?=
 =?us-ascii?Q?XCkN29fGLeJenPk7MKjuI+PvZND3TT0kSi4dmiYULcZOw+aTtIbSRwi3a2l/?=
 =?us-ascii?Q?xCYLuIRPC8UAWKtJnQld9IwVlg2Hnu6aWh0BS9h4OXNr8yhMlKpDjvuzrb2O?=
 =?us-ascii?Q?aBkmMRIIbFJEj1hfsZl0P0EHzflTKyuT8OjYX4MI6pdIuQRRq/jqRbQueJqO?=
 =?us-ascii?Q?jVFKaYucYZCg8JR09rlp8PSyff+6+m7o9u7OFe9LaPO+AeygvwLT05BMT9BU?=
 =?us-ascii?Q?YXccm5PcM6W5G5NHyEm6jpM7s47tEyi6ExFJUG1/v0reyQ4QQTNy3TZB2oJ2?=
 =?us-ascii?Q?TK11/Wdc1Z3VygBEE8DY4psWJVef8O09PrdQB1+BxVsH1FLbbCVJXQGy0nXj?=
 =?us-ascii?Q?dtTB0wdOufMdkz2Jio5UBkcBVZKAVdQTp0MXsX8mpsTqR2rDEBz9UGEBDj/u?=
 =?us-ascii?Q?aslLuyc0uZNilosltPALCqaT7DyOQsXNibrXbqk0FXM28UyaqDj1Tb9FYJ8W?=
 =?us-ascii?Q?lYYJbJJxUueBQ7paV6OzpiUjn+vk8HBSKlGfuXsECNJLJQpoAEhEyJGqdpdD?=
 =?us-ascii?Q?LyrLbITwn4IVXXchaMkrmuyELSPSOX/h0AWLBGSw/JbRUavnNMd4NeeJgm84?=
 =?us-ascii?Q?7hzHGfh51I6VwWjrPv7wd21N3cVTOp+zgoCflXODm3SpPR+U/jiuSnBsLNI7?=
 =?us-ascii?Q?g+phSson1CE4F7Nrxzcr4SYLbkEZJ05ZAfI3/71NPFOvXl7BsujpaU3r8Vem?=
 =?us-ascii?Q?9+jUUGdZWYtpo3qF3jrzltLGEMtoH9Av+c97s9SQlllvPyQH9tUkENCiWuLC?=
 =?us-ascii?Q?o8P83FqA1URPwrDSo9aJiex4KSp6guMboiLT1YYEiO7xe1yITm42bSHxd3ft?=
 =?us-ascii?Q?sd7UrLfjFna2vTM+XV6oxibLxnPnB9acoh0h0vczyrZ4PL4ZfXC51s1vwbK+?=
 =?us-ascii?Q?dq/vY5GS2HivwbrbJQpPTuec/AP7cNM5K8lh1fRp2KhhPo01xJdg1CWKWtc+?=
 =?us-ascii?Q?EAKxF47PZcaCDgq061a9TAfoypr7BnLaHJn6JjLpByEthbVQKhAflFHEO2Hw?=
 =?us-ascii?Q?Z6a+J8SlX6Ipc4gmT/VtecJf0YLseUyYTj+MeX0pUh1JR7yzTWWoB92yKEqI?=
 =?us-ascii?Q?ikCHkq/A6LcSM+0d+sxzsrJuG0v31egcplsHKVgGy/4E5fyRybfV6BkkBf3F?=
 =?us-ascii?Q?4rl7rvORK0uE3nOUn5K/MiSWYfFQqvHKdzCjMjDg0Vc15wZsakGbGsfV0nQW?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497ffbd7-b612-48cb-8664-08dcc829194d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:50:02.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjJAC3D+64+ePz/ZkT2PVSat+h3gjPFBXqet9tWv6tdeH8iubk+ozxJ1WOea4kF6KHmL8dEsAT49VxskM1/lNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939

This registers a BAP stream state changed callback inside BASS, to monitor
the state of BAP streams created by the Scan Delegator and to notify
the peer Broadcast Assistants about updates.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for a BIS added by a Broadcast Assistant through the
Add Source operation. The transport is then acquired and then
released:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Endpoint: SetConfiguration
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Properties.Device:
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA
[00-60-37-31-7E-3F]# Auto Accepting...
[00-60-37-31-7E-3F]# transport.select
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: broadcasting
[00-60-37-31-7E-3F]# transport.acquire
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
auto acquiring...
Transport /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring complete
[00-60-37-31-7E-3F]# Acquire successful: fd 8 MTU 40:0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: active
[00-60-37-31-7E-3F]# transport.release
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Transport fd disconnected
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: idle
[00-60-37-31-7E-3F]# Release successful

The btmon log below shows the Scan Delegator notifying the
peer each time the state of the stream changes:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 0201da5711c0e203001a2d5602ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 03:E2:C0:11:57:DA
            Source_Adv_SID: 0
            Broadcast_ID: 0x562d1a
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044)
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -64 dBm (0xc0)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x22
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
              BIS #0:
              Index: 1
> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 1
        NSE: 3
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00
> HCI Event: LE Meta Event (0x3e) plen 17
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 912 us (0x000390)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c)
        BIG Handle: 0x00
> HCI Event: Command Complete (0x0e) plen 5
      LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c) ncmd 1
        Status: Success (0x00)
---
 profiles/audio/bass.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 933eecabd..ca20d6e30 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -103,6 +103,7 @@ struct bass_delegator {
 	struct btd_device *device;	/* Broadcast source device */
 	struct bt_bcast_src *src;
 	struct bt_bap *bap;
+	unsigned int state_id;
 };
 
 static struct queue *sessions;
@@ -124,6 +125,54 @@ static bool delegator_match_device(const void *data, const void *match_data)
 	return dg->device == device;
 }
 
+static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct bass_delegator *dg = user_data;
+	int bis;
+	char *path = bt_bap_stream_get_user_data(stream);
+	struct bt_bap *bap = bt_bap_stream_get_session(stream);
+	const char *strbis;
+	int err;
+
+	if (dg->bap != bap)
+		return;
+
+	strbis = strstr(path, "/bis");
+	if (strbis == NULL) {
+		DBG("bis index cannot be found");
+		return;
+	}
+
+	err = sscanf(strbis, "/bis%d", &bis);
+	if (err < 0) {
+		DBG("sscanf error");
+		return;
+	}
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_STREAMING:
+		/* BAP stream was started. Mark BIS index as synced inside the
+		 * Broadcast Receive State characteristic and notify peers about
+		 * the update.
+		 */
+		bt_bass_set_bis_sync(dg->src, bis);
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (old_state == BT_BAP_STREAM_STATE_STREAMING)
+			/* BAP stream was disabled. Clear BIS index from the
+			 * bitmask inside the Broadcast Receive State
+			 * characteristic and notify peers about the update.
+			 */
+			bt_bass_clear_bis_sync(dg->src, bis);
+		break;
+	}
+}
+
 bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
 {
 	struct bass_delegator *dg;
@@ -142,6 +191,12 @@ bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
 	if (bt_bass_set_pa_sync(dg->src, BT_BASS_SYNCHRONIZED_TO_PA))
 		DBG("Failed to update Broadcast Receive State characteristic");
 
+	/* Register BAP stream state changed callback, to keep up to
+	 * date with BIG/PA sync state.
+	 */
+	dg->state_id = bt_bap_state_register(bap, bap_state_changed,
+			NULL, dg, NULL);
+
 	return true;
 }
 
@@ -161,6 +216,9 @@ bool bass_bcast_remove(struct btd_device *device)
 	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
 		DBG("Failed to update Broadcast Receive State characteristic");
 
+	/* Unregister BAP stream state changed callback. */
+	bt_bap_state_unregister(dg->bap, dg->state_id);
+
 	free(dg);
 
 	return true;
-- 
2.39.2

