Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB334642D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949328; cv=fail; b=mCkkhi5lzCgt1YwjCrxRB2yJ8E+MNyJ57AGclfsUtDYU62MMFxTDmaapg+Jh4oIfGIAQU2dqgGoQIHX4+oW54jOE1KxtfawC7DXWpnqagWZmrVWQMZSh4Iw4jgZ2xCOlsRRHS8LkCGD/VBEOC2u3MMPE90PBOXx3ODhfcIl0mjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949328; c=relaxed/simple;
	bh=/Nyqy/68Kh7eRtPv1rEqUgATksdq2geBo2SS3/yJAd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1zLmozmEIuzYSXcDgquaNckoSpzUkl4lOS/F/aUoQ6YK6DfV2cbRAWEL6Z47Mb3CITsb4tvf2azjLITDKd3gxGw4axTVHPZxBxNbCtOUf6CXBQ6Z8nW66WFz3e2ne5P/CdUM9ohmD2x2mQPnVxGRJF4b66losPc0dO20X5tPmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QNQ12LuI; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QNQ12LuI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d234aw9H62B3I7rrO7rQtl3umvi4vazGEmeoXh4+Sr0kdawsYGXbAu9cPJyjSWLc8aTeg7qwuqRUOPOrH07XFGRYRXPOb9maLl0pWBBio5HO9462pxV7sWUwuJwh/bR7ymRGbw1A0VBMQCALy3Y1w3Jc2cIqFiSoiJcIAOA86sbB9iUELiH8Ce/VOYXTVcRqBSxuY9BeaWp1DIrdArYuW8AZCbHyq+5bC5b/DDVnBaFqrTm9fwO9N9Gr6dF8ZVIsPbsx4N+9kQSUSNN30taHzGhQ+d1BDhOv7f/85ST8D/gfgtags8kCzwJwmnEzfjk1TCJVFr6qt707DXC0PScF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhSrGx32/Yy41Iwx2LPjAAT6oXUevPw8EPAEhBE32Zs=;
 b=gs0ZJlqInI1Zdc50kLFWDkYm0L/sssnPN2xtJ1EKiIjZA/fQDHdhseTdnyjqbliq76mmCwfawIPty8Nyyly9fObOu0OCPmiXZp9xmkUjr1wClNejqCbYBhh/4MAV8bWc8h+5JbKLnXYj9SRgBZ2wq1nztV6HmjwGuyGFUDuP9sKZuvog3SVoau/vw1UsaQJtwPjiNI72mJFxL3ABFzYJeRF1+ZMkm7GZP8/WyDDpRHsM2QdzvcqdIc+oPzoCMViQuToKyp6Cmqbx2dcEDhD20tjF09p8LKF8io8j5cngNRVB+nghPs1XMJ+2T91MNv+DgVxmcQAMg3mzSNG3ph+tsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhSrGx32/Yy41Iwx2LPjAAT6oXUevPw8EPAEhBE32Zs=;
 b=QNQ12LuIEyHcTq35B+5a5xbiXHuJhILRXh1vnTNzvSRKnL6JcsD+QsCJSgzae3S0LDAQaUTsrpvaEEcEkSWsOpNsMZjV06MrUhUeDucYYkthH3ogygg1ZtLjpSApbadPMskrdyaa8/oTRg3l3wlExfZjHhOolz6T4HfhRtR0HH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8362.eurprd04.prod.outlook.com (2603:10a6:10:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 12:35:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:35:22 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/5] test-bap: Add Broadcast Sink SCC tests
Date: Fri, 17 May 2024 15:34:36 +0300
Message-Id: <20240517123436.146332-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
References: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0096.eurprd03.prod.outlook.com
 (2603:10a6:208:69::37) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: a2eafe7e-f3e4-439f-31b7-08dc766dd1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TO3n/WYvUJkC201QayUfxlHjR+fcfwGxZuwe9UJfL1X0/kC+ry9EuF9dfOHm?=
 =?us-ascii?Q?Hksp7oYvoA9R3mvP8RNkMQcF1reHYOVFZnHJ3jS0EinnrUa+6x8SzBspaTka?=
 =?us-ascii?Q?CiTyz9TG2RMeKp2y3cKA7jcZsEZZA/zKEqcPHzscDgDwxuDTHi1TZMaISxmH?=
 =?us-ascii?Q?O3UDps6foNxiKdEwJIg/+B/HTRg7Fs62IsIMludDYDcoiqfwT7ZKjE31fyjX?=
 =?us-ascii?Q?vWSxenXHL5M4n0dT/1FFSxToCLzy0/II0e/uljUwsm7EzbXHalSYlt5YLn7u?=
 =?us-ascii?Q?ydbxJoV0Sdhxis8ime2DWQ0CwEUL/zaO04FnPbE8RB/c6XhQSaCoMbOIDuK9?=
 =?us-ascii?Q?V2SQa2qnxwfHbWks6wnGK8e9FWkT80tyLXTR3JDSsuKSakJVlErzj9l8Pz33?=
 =?us-ascii?Q?0i0qgF328F4+G6yn+QJF94B93i/GLKL1Q8oXUTp3h1esyNZxH+J65kAO2wSe?=
 =?us-ascii?Q?uynceWCh7O3qnVLUCcy0XWD2i6ukQGMew05ZglFlJqsNN88Bg7jEol+UjXbb?=
 =?us-ascii?Q?YVyy5sUhR32C0lrIij4lAX2o/2FLnTmc2aTX1oBWBOCPOTt8hnPQnVHmSQLL?=
 =?us-ascii?Q?xWvTJK3azcM4tAfCC9GYkj6taV7/n48PtFYVxJs5V9b17kA5nAvzVOryomKF?=
 =?us-ascii?Q?FijxLAHO7OwnX/AsPa/0P4yIPnWzZCvoK+/4GyjKFywEMX7MrDsN12HYy842?=
 =?us-ascii?Q?IhGFQ/MAZx4R1URPPFfC+ipV501iyuncqWvJNzCwUcF8mKCNqlk1JnRR9SUp?=
 =?us-ascii?Q?DslUc3nSl3t5IG1L1W7KCHHQjcNbZGNiIvkQ+WfGlYdIfZHyzKq1HveH1kAH?=
 =?us-ascii?Q?pkuDTNkf+LYgXWxvurKlqePZKjOWKxEh7Xb8DGUl14fJUESpYi/uv6DRrxOw?=
 =?us-ascii?Q?vDsf2gGKmFV771kzLr/+alJ/jMzsSsmATXPQYfQ9jAKnYWlGEV6owsVCtMFJ?=
 =?us-ascii?Q?mDbgpyaYV+POPmh/Fm5gkrzAwBRFBXVDAl9AklVQSrSZwwXud6rXKBcRLSxB?=
 =?us-ascii?Q?fWWAkROtQ5sozjVLWKkx/o9GuH4C5M5BhBSTb5+LuiPU13LDLTPdFEp/qnA7?=
 =?us-ascii?Q?CDA1smQV++5q16secay+59YhFHr1iXjDmRmaCkWdL0wouPvuROIWtzY0Gua7?=
 =?us-ascii?Q?oFAOk4rUGlZZEdpq5hx8jLcbV3fxCqyah+InSF3M/VHxiMXMTO2aEbj9L5jq?=
 =?us-ascii?Q?6VkkV5knzrjF6EZTv2Dv2fRDQh5LP2Rc0s8NWuiL0c1F+6iP0lO9g2gBOBoi?=
 =?us-ascii?Q?52ru5gw1vbNf3I0E7VP7qmwAx7IfuJvMhXHEMbRWdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Z4P5N4jxuHylF0BNq3OP+SSTxYxrgofgh2wos/oqK9f0Ok9QExshLONoLpE?=
 =?us-ascii?Q?FVJFTTnQunW4AiOMsqwFYbRHZZHCLjQOfKnmcakFuU4xB1EV+yCzAbMiqMfM?=
 =?us-ascii?Q?cd9JeZRu3ZtOe76rs2s9LMndA5cB39ttXbva/vQlN+elWYlyz9T0wSaozgXh?=
 =?us-ascii?Q?EO7K/Ed+1AHIIl19EONsPTNdxFDQLfQ6FQaPzBs0iPfrp5tk11elHQJs1iBN?=
 =?us-ascii?Q?vcH0YxmtzVTNfnCDVTEun8WfbKkFz1EGR9aHE1xMuOfODTEcL8ogJTpvSLb3?=
 =?us-ascii?Q?SrOK/wah0z5GtP7OsUDnqGsy65TkYdTd7oPlREW6Gib2Wj8lZprDH93h5MOn?=
 =?us-ascii?Q?Fs6WrJ8+phQIuctiA4DPXAntMd/vQkvRqdP+t7iXeoaIgltx/JECKvjwoA1Z?=
 =?us-ascii?Q?Xc4+euNgQzHoXb/7ZYXGxAZ53Z8WQrR/qPCpzsWZvzc59eG5e6/OhRCjOyu8?=
 =?us-ascii?Q?x9ps40aCXs2VltLJirCSUBU2S0y1zXsNva1srj5UsTPY313zjTgYo4/k9xwL?=
 =?us-ascii?Q?poprW7pCJ5eD/3VNOjVydM4BTLursrbH2P81R7AAf1FBXz6Byme7fPo+x+KJ?=
 =?us-ascii?Q?uTbiCrYPLn9/jck/6mvDFyypkCqlzjWqe0P2L1CC8ogY0dR2v2JvBfT2OH8W?=
 =?us-ascii?Q?OOsCs7q70legOpXxqxe5XseoN4dzx/KFv3OlvWZhjojeDPKJjBLlZRod25pi?=
 =?us-ascii?Q?xMOAv7rmcAmTabz3oFrnzdUg+6Yo9crfCGWnyKIy3sTP+rnxqm6yAuIiCtV+?=
 =?us-ascii?Q?u+oQQoPf/jPEThKxWn9NvfdOMt+KaGxcsx/fpyvBtMzgPqQvwEInbtiL99k3?=
 =?us-ascii?Q?bSfhybmDOH6Z6AxGOw7Jgt6G1E5d01fUczwEbysDKiu4uHAKpbTMNIoXweKs?=
 =?us-ascii?Q?YB1FGoZnCVEkzSTaUMFcZ4gjykPGgwnVUuY9ORd7K5Pugr+84XeYyPDfOOeO?=
 =?us-ascii?Q?PAt8m5mTkbkX2rv1MgL1A33vEh7DM4nzNaUA/8Mo4NMPRYfpptXe8/2FexNX?=
 =?us-ascii?Q?wa7w+bjNoFYqmtDiYT/aN6X3vAw82ICeaeNH5vQjYlRRpfUwl8W3/2ydHJRm?=
 =?us-ascii?Q?6cbUoFPF9uNA0GaLC4ymrjCU8k62a+9JWNehb56bik0NKaWKnjsXS+JxVqga?=
 =?us-ascii?Q?CDoOswnZTO/LRavnqxuhQ+RtLKbQOKwWnlzb2v4nLXzps1FHF99E0B8Nplik?=
 =?us-ascii?Q?wiVWftyo1bc/JrlUBQnlXOmba0W54wDxHavG7XYCUCxJWPz1PmDsanfUx6lw?=
 =?us-ascii?Q?KBCrwZGU35rXwGEun+uyGEPj4VEHXg9MgRaDDfdi8rWDPtC05ryzflQtxDlj?=
 =?us-ascii?Q?LTVKmgoc4mKmAhmv4hZ5DN8ICvySIE8CDeYgpFiIyHrnRcvgOypesbQviGqK?=
 =?us-ascii?Q?uNY4TF8/01591IjH6DxA7ZB1IVhNLnemDg9pwwtmiFBW99q/hGYyipOzH86f?=
 =?us-ascii?Q?ciG4l/GobygN5BSYmjDmJZ6QumtbAxWVhCru/4gLwpHC0GrqcaDjUxmhm+dM?=
 =?us-ascii?Q?rWCcs8wvMJ1LsVCQpn9DtRkPLIJjo1eRzMNx6raV/eizx4KYZ9stkH2T0R/3?=
 =?us-ascii?Q?K/Q41LJWXbQcY6XweM+y7zmzps8WMq43ZoZKRW1P/4r6xF8tEehN9ji0H+Hk?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eafe7e-f3e4-439f-31b7-08dc766dd1f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:35:22.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK3V72Nyd1SWSkBDcLsBpUmMsy0+7f0J4m+jCTwW2mmZH/j/emJzzqsWFPNikoHGk0CUmA0tpVEJ2VV7hLOHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362

4.13.2 Broadcast Sink Synchronizes to PA (page 177)

     Test Purpose:
     Verify that a Broadcast Sink IUT can synchronize to the PA
     associated with a broadcast Audio Stream transmitted by a
     Broadcast Source.

     Test Case Configuration:
     BAP/BSNK/SCC/BV-01-C [Sync to PA, LC3 8_1_1]
     BAP/BSNK/SCC/BV-02-C [Sync to PA, LC3 8_2_1]
     BAP/BSNK/SCC/BV-03-C [Sync to PA, LC3 16_1_1]
     BAP/BSNK/SCC/BV-04-C [Sync to PA, LC3 16_2_1]
     BAP/BSNK/SCC/BV-05-C [Sync to PA, LC3 24_1_1]
     BAP/BSNK/SCC/BV-06-C [Sync to PA, LC3 24_2_1]
     BAP/BSNK/SCC/BV-07-C [Sync to PA, LC3 32_1_1]
     BAP/BSNK/SCC/BV-08-C [Sync to PA, LC3 32_2_1]
     BAP/BSNK/SCC/BV-09-C [Sync to PA, LC3 44.1_1_1]
     BAP/BSNK/SCC/BV-10-C [Sync to PA, LC3 44.1_2_1]
     BAP/BSNK/SCC/BV-11-C [Sync to PA, LC3 48_1_1]
     BAP/BSNK/SCC/BV-12-C [Sync to PA, LC3 48_2_1]
     BAP/BSNK/SCC/BV-13-C [Sync to PA, LC3 48_3_1]
     BAP/BSNK/SCC/BV-14-C [Sync to PA, LC3 48_4_1]
     BAP/BSNK/SCC/BV-15-C [Sync to PA, LC3 48_5_1]
     BAP/BSNK/SCC/BV-16-C [Sync to PA, LC3 48_6_1]
     BAP/BSNK/SCC/BV-17-C [Sync to PA, LC3 8_1_2]
     BAP/BSNK/SCC/BV-18-C [Sync to PA, LC3 8_2_2]
     BAP/BSNK/SCC/BV-19-C [Sync to PA, LC3 16_1_2]
     BAP/BSNK/SCC/BV-20-C [Sync to PA, LC3 16_2_2]
     BAP/BSNK/SCC/BV-21-C [Sync to PA, LC3 24_1_2]
     BAP/BSNK/SCC/BV-22-C [Sync to PA, LC3 24_2_2]
     BAP/BSNK/SCC/BV-23-C [Sync to PA, LC3 32_1_2]
     BAP/BSNK/SCC/BV-24-C [Sync to PA, LC3 32_2_2]
     BAP/BSNK/SCC/BV-25-C [Sync to PA, LC3 44.1_1_2]
     BAP/BSNK/SCC/BV-26-C [Sync to PA, LC3 44.1_2_2]
     BAP/BSNK/SCC/BV-27-C [Sync to PA, LC3 48_1_2]
     BAP/BSNK/SCC/BV-28-C [Sync to PA, LC3 48_2_2]
     BAP/BSNK/SCC/BV-29-C [Sync to PA, LC3 48_3_2]
     BAP/BSNK/SCC/BV-30-C [Sync to PA, LC3 48_4_2]
     BAP/BSNK/SCC/BV-31-C [Sync to PA, LC3 48_5_2]
     BAP/BSNK/SCC/BV-32-C [Sync to PA, LC3 48_6_2]
     BAP/BSNK/SCC/BV-33-C [Sync to PA, VS]

     Pass verdict:
     The received AdvData field of AUX_SYNC_IND and optionally
     AUX_CHAIN_IND PDUs contains the configured BASE information.

Test Summary
------------
BAP/BSNK/SCC/BV-01-C [Sync to PA, LC3 8_1_1]         Passed
BAP/BSNK/SCC/BV-02-C [Sync to PA, LC3 8_2_1]         Passed
BAP/BSNK/SCC/BV-03-C [Sync to PA, LC3 16_1_1]        Passed
BAP/BSNK/SCC/BV-04-C [Sync to PA, LC3 16_2_1]        Passed
BAP/BSNK/SCC/BV-05-C [Sync to PA, LC3 24_1_1]        Passed
BAP/BSNK/SCC/BV-06-C [Sync to PA, LC3 24_2_1]        Passed
BAP/BSNK/SCC/BV-07-C [Sync to PA, LC3 32_1_1]        Passed
BAP/BSNK/SCC/BV-08-C [Sync to PA, LC3 32_2_1]        Passed
BAP/BSNK/SCC/BV-09-C [Sync to PA, LC3 44.1_1_1]      Passed
BAP/BSNK/SCC/BV-10-C [Sync to PA, LC3 44.1_2_1]      Passed
BAP/BSNK/SCC/BV-11-C [Sync to PA, LC3 48_1_1]        Passed
BAP/BSNK/SCC/BV-12-C [Sync to PA, LC3 48_2_1]        Passed
BAP/BSNK/SCC/BV-13-C [Sync to PA, LC3 48_3_1]        Passed
BAP/BSNK/SCC/BV-14-C [Sync to PA, LC3 48_4_1]        Passed
BAP/BSNK/SCC/BV-15-C [Sync to PA, LC3 48_5_1]        Passed
BAP/BSNK/SCC/BV-16-C [Sync to PA, LC3 48_6_1]        Passed
BAP/BSNK/SCC/BV-17-C [Sync to PA, LC3 8_1_2]         Passed
BAP/BSNK/SCC/BV-18-C [Sync to PA, LC3 8_2_2]         Passed
BAP/BSNK/SCC/BV-19-C [Sync to PA, LC3 16_1_2]        Passed
BAP/BSNK/SCC/BV-20-C [Sync to PA, LC3 16_2_2]        Passed
BAP/BSNK/SCC/BV-21-C [Sync to PA, LC3 24_1_2]        Passed
BAP/BSNK/SCC/BV-22-C [Sync to PA, LC3 24_2_2]        Passed
BAP/BSNK/SCC/BV-23-C [Sync to PA, LC3 32_1_2]        Passed
BAP/BSNK/SCC/BV-24-C [Sync to PA, LC3 32_2_2]        Passed
BAP/BSNK/SCC/BV-25-C [Sync to PA, LC3 44.1_1_2]      Passed
BAP/BSNK/SCC/BV-26-C [Sync to PA, LC3 44.1_2_2]      Passed
BAP/BSNK/SCC/BV-27-C [Sync to PA, LC3 48_1_2]        Passed
BAP/BSNK/SCC/BV-28-C [Sync to PA, LC3 48_2_2]        Passed
BAP/BSNK/SCC/BV-29-C [Sync to PA, LC3 48_3_2]        Passed
BAP/BSNK/SCC/BV-30-C [Sync to PA, LC3 48_4_2]        Passed
BAP/BSNK/SCC/BV-31-C [Sync to PA, LC3 48_5_2]        Passed
BAP/BSNK/SCC/BV-32-C [Sync to PA, LC3 48_6_2]        Passed
BAP/BSNK/SCC/BV-33-C [Sync to PA, VS]                Passed
---
 unit/test-bap.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index a6e24e605..46ee0e4e5 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -52,6 +52,7 @@ struct test_data {
 	struct bt_bap_pac *snk;
 	struct bt_bap_pac *src;
 	struct bt_bap_pac *bsrc;
+	struct bt_bap_pac *bsnk;
 	struct iovec *base;
 	struct iovec *caps;
 	struct test_config *cfg;
@@ -565,6 +566,59 @@ static void bsrc_state(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
+static void bsnk_pac_added(struct bt_bap_pac *pac, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct bt_bap_pac *lpac;
+	struct iovec *cc;
+	struct bt_bap_codec codec = {0};
+
+	if (data->cfg->vs)
+		codec.id = 0xff;
+	else
+		codec.id = LC3_ID;
+
+	bt_bap_verify_bis(data->bap, 1, &codec,
+			&data->cfg->cc, NULL, &lpac, &cc);
+
+	g_assert(lpac);
+	g_assert(pac == lpac);
+	g_assert(cc);
+
+	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
+
+	data->stream = bt_bap_stream_new(data->bap,
+		pac, NULL, &data->cfg->qos, cc);
+
+	g_assert(data->stream);
+
+	bt_bap_stream_config(data->stream, &data->cfg->qos,
+			cc, NULL, NULL);
+
+	util_iov_free(cc, 1);
+}
+
+static void bsnk_state(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct iovec *cc;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		/* Check that stream has been configured as expected */
+		cc = bt_bap_stream_get_config(stream);
+
+		g_assert(cc);
+		g_assert(cc->iov_len == data->cfg->cc.iov_len);
+		g_assert(memcmp(cc->iov_base, data->cfg->cc.iov_base,
+				cc->iov_len) == 0);
+
+		tester_test_passed();
+		break;
+	}
+}
+
 static void test_bcast_config(struct test_data *data)
 {
 	if (!data->cfg)
@@ -590,6 +644,27 @@ static void test_bcast_config(struct test_data *data)
 
 		g_assert(data->bsrc);
 	}
+
+	if (data->cfg->snk) {
+		bt_bap_pac_register(data->bap, bsnk_pac_added,
+						NULL, data, NULL);
+
+		if (data->cfg->vs)
+			data->bsnk = bt_bap_add_vendor_pac(data->db,
+							"test-bap-bsnk",
+							BT_BAP_BCAST_SINK,
+							0xff, 0x0000, 0x0000,
+							NULL, data->caps,
+							NULL);
+		else
+			data->bsnk = bt_bap_add_pac(data->db, "test-bap-bsnk",
+							BT_BAP_BCAST_SINK,
+							LC3_ID,
+							NULL, data->caps,
+							NULL);
+
+		g_assert(data->bsnk);
+	}
 }
 
 static void test_bcast(const void *user_data)
@@ -626,6 +701,7 @@ static void test_teardown(const void *user_data)
 	bt_bap_remove_pac(data->snk);
 	bt_bap_remove_pac(data->src);
 	bt_bap_remove_pac(data->bsrc);
+	bt_bap_remove_pac(data->bsnk);
 	gatt_db_unref(data->db);
 
 	tester_teardown_complete();
@@ -6045,6 +6121,228 @@ static void test_bsrc_scc(void)
 		NULL, test_bcast, &cfg_bsrc_vs, IOV_NULL);
 }
 
+static struct test_config cfg_bsnk_8_1 = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_8_2 = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_16_1 = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_16_2 = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_24_1 = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_24_2 = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_32_1 = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_32_2 = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_44_1 = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_44_2 = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_48_1 = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_48_2 = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_48_3 = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_48_4 = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_48_5 = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_48_6 = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state,
+};
+
+static struct test_config cfg_bsnk_vs = {
+	.cc = UTIL_IOV_INIT(VS_CC),
+	.qos = QOS_BCAST,
+	.snk = true,
+	.vs = true,
+	.state_func = bsnk_state,
+};
+
+static void test_bsnk_scc(void)
+{
+	define_test("BAP/BSNK/SCC/BV-01-C [Sync to PA, LC3 8_1_1]",
+		NULL, test_bcast, &cfg_bsnk_8_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-02-C [Sync to PA, LC3 8_2_1]",
+		NULL, test_bcast, &cfg_bsnk_8_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-03-C [Sync to PA, LC3 16_1_1]",
+		NULL, test_bcast, &cfg_bsnk_16_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-04-C [Sync to PA, LC3 16_2_1]",
+		NULL, test_bcast, &cfg_bsnk_16_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-05-C [Sync to PA, LC3 24_1_1]",
+		NULL, test_bcast, &cfg_bsnk_24_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-06-C [Sync to PA, LC3 24_2_1]",
+		NULL, test_bcast, &cfg_bsnk_24_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-07-C [Sync to PA, LC3 32_1_1]",
+		NULL, test_bcast, &cfg_bsnk_32_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-08-C [Sync to PA, LC3 32_2_1]",
+		NULL, test_bcast, &cfg_bsnk_32_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-09-C [Sync to PA, LC3 44.1_1_1]",
+		NULL, test_bcast, &cfg_bsnk_44_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-10-C [Sync to PA, LC3 44.1_2_1]",
+		NULL, test_bcast, &cfg_bsnk_44_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-11-C [Sync to PA, LC3 48_1_1]",
+		NULL, test_bcast, &cfg_bsnk_48_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-12-C [Sync to PA, LC3 48_2_1]",
+		NULL, test_bcast, &cfg_bsnk_48_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-13-C [Sync to PA, LC3 48_3_1]",
+		NULL, test_bcast, &cfg_bsnk_48_3, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-14-C [Sync to PA, LC3 48_4_1]",
+		NULL, test_bcast, &cfg_bsnk_48_4, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-15-C [Sync to PA, LC3 48_5_1]",
+		NULL, test_bcast, &cfg_bsnk_48_5, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-16-C [Sync to PA, LC3 48_6_1]",
+		NULL, test_bcast, &cfg_bsnk_48_6, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-17-C [Sync to PA, LC3 8_1_2]",
+		NULL, test_bcast, &cfg_bsnk_8_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-18-C [Sync to PA, LC3 8_2_2]",
+		NULL, test_bcast, &cfg_bsnk_8_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-19-C [Sync to PA, LC3 16_1_2]",
+		NULL, test_bcast, &cfg_bsnk_16_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-20-C [Sync to PA, LC3 16_2_2]",
+		NULL, test_bcast, &cfg_bsnk_16_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-21-C [Sync to PA, LC3 24_1_2]",
+		NULL, test_bcast, &cfg_bsnk_24_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-22-C [Sync to PA, LC3 24_2_2]",
+		NULL, test_bcast, &cfg_bsnk_24_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-23-C [Sync to PA, LC3 32_1_2]",
+		NULL, test_bcast, &cfg_bsnk_32_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-24-C [Sync to PA, LC3 32_2_2]",
+		NULL, test_bcast, &cfg_bsnk_32_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-25-C [Sync to PA, LC3 44.1_1_2]",
+		NULL, test_bcast, &cfg_bsnk_44_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-26-C [Sync to PA, LC3 44.1_2_2]",
+		NULL, test_bcast, &cfg_bsnk_44_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-27-C [Sync to PA, LC3 48_1_2]",
+		NULL, test_bcast, &cfg_bsnk_48_1, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-28-C [Sync to PA, LC3 48_2_2]",
+		NULL, test_bcast, &cfg_bsnk_48_2, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-29-C [Sync to PA, LC3 48_3_2]",
+		NULL, test_bcast, &cfg_bsnk_48_3, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-30-C [Sync to PA, LC3 48_4_2]",
+		NULL, test_bcast, &cfg_bsnk_48_4, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-31-C [Sync to PA, LC3 48_5_2]",
+		NULL, test_bcast, &cfg_bsnk_48_5, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-32-C [Sync to PA, LC3 48_6_2]",
+		NULL, test_bcast, &cfg_bsnk_48_6, IOV_NULL);
+
+	define_test("BAP/BSNK/SCC/BV-33-C [Sync to PA, VS]",
+		NULL, test_bcast, &cfg_bsnk_vs, IOV_NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -6052,6 +6350,7 @@ int main(int argc, char *argv[])
 	test_disc();
 	test_scc();
 	test_bsrc_scc();
+	test_bsnk_scc();
 
 	return tester_run();
 }
-- 
2.39.2

