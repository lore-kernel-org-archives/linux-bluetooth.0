Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3012F59A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280074; cv=fail; b=uTUVLvDg5gWMqcQWnQtk0A4FzU6kM7O63REUAeGJLBGqD64Rt16yAIy9kFC8SxT/X1Ss6WKD4xTa1nu7MgtAdTXL3u7PHzspitOnl57/adFTbtKFWzvqjU2fGdOASYHYHgLqBlyralKhEZRJlkKZU4FuSHaYQdgJahJBGNbGjAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280074; c=relaxed/simple;
	bh=a/NMnCWYo+cVHxseqlJDacUXEFRM/DxMmaJNdg8bfmU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Yp+dygQuKGzUz2PmNFG2XAJeGcnPD4yyMMuSe5p6tnqKpqxY4fR8Y5PuKUdwPQnPPhPaf8a0Oak7MB6KVk9K9CKIq70Qck4zQowgbFurDJJ8lbhfwQ6c6H6n7VXDPTK7jIeRUY+yzTuqPyrZHK+0CW2PTVvdPlUvGyq5Tuc1wnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iSbr+RfK; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iSbr+RfK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHfZq91OFuQaH8YKsA4q+ivWm6IlbkOI1izZtwahc+zqzILE9xs9iN7KU7TeZ2sg66v46tvW0h02ECi4aGOO1lnYT9UskLlxitF0/xWmK3bPJTiIT3+yY88/66tALd2me3VOZcF0Bf2cdsELzZdv8k1iY9O3bTGjldHn/AzWoNTWrnquH6Oqv92NL8xl3i4MTGW33Xi3oxIV547G1Bk4M9rcEiimdNQsxYVFveGNtlmm6o433QSkQS2fJYdjZyOpmSCPY5jZi4QGkNLZ8xDPqAZ7SKuFwFpQgeC3x5SA/t0yXbTaSWcYlsePbHBt2RW5uJaBTEtMjpag3rVvbROpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmQMVK/raJaRBxbFURaUHlXmz3aoqpEMCp3Y5WLY8IU=;
 b=jke7VolU4JZKLCVQ2To22YxRwbRrdqTGfQYhTf1HEq/9z1cUUqd/jc33caGS5nN7cAllXpSlDarzC5BlAtKSC/tD/eRef6q/QYiyNQG/RG52A5zW2eWZfEvJ59YbHbnNdPFvBm/eEW9avPrCHeoAdt61z5fNRO2jJrZ7SvT0aQakiUR0gR5SXELp0DuuYUCrVWB5pDTf+ASihEuUF/luBzB2MYiteSMIqCUW0u8alEIwxxMKceUJDFq47RQ0Ny3iXgwBvowTP/ctj8aAZRQ4VaVDywky+CZtbwepvNilEFvuJ9SC+cD299ML3qi0KiOjH0t0fgp4jer4Dz/7ybrrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmQMVK/raJaRBxbFURaUHlXmz3aoqpEMCp3Y5WLY8IU=;
 b=iSbr+RfKbaKJyC0ac+bLs9Pv+bV70K9caSCRy0f4faX7PKBNE+v1oJs0kwJNp5Jq4bPbhNKbw/QAfWPMFtmfKT9DulgLQhA2n+5k7Ne5EgyoS7Oi1Osbubkf1A/6T2eIF1vLw9Z3k/RWme7VwCF70bv3gjyTJpG0mJ8EEuu2Pxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by DU4PR04MB10337.eurprd04.prod.outlook.com (2603:10a6:10:562::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:07:50 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:07:50 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: hci_event: Fix setting of broadcast qos interval and latency
Date: Tue, 16 Apr 2024 18:07:31 +0300
Message-Id: <20240416150732.101088-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|DU4PR04MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c35414-280b-4b2e-11fe-08dc5e26fb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	doiS6psK+2UkRTdaaHsQDxnCk9+8S8R40sexA8AeCc4cz928Ec4vvKv/uRsgyAX/86FR+saSF7x/3/69aOZH6gTqnA1bGU/zoThYxvTITgSy86dLIMZQugizRsAPV7kZPYiJJQ57vj00uYnvNqCnGIvZA+Buc6Zs0JPeDmvsR/KL2N2EsGwNvUI1Q1dm8BhpeAj8ryLtw6re2/t2jLz9IlXpH+Q/HFtP2aWTENI14P36PqbnMCsRb5ZHtcYCpBvPd4j2300J3AaMp39+AMccDMzIuNWIHHj/Gf3UTHqq492nXm3U3L8ZuwqUFUjUJeDkOjZlZ14hN9CkwgxULUPZIsH4k655q+HwMu83EflrkOozWJAWH2CdZnFfLEfxGRUzszW+hVfCwMfd3Ea1zNHT8836JiArsSEcfThpbURxpfjJxR3CDW7vDkUp4tZQpeTCDoDwsZfdpRq1zY/SJyzGCRBgQe/r9wDjOh4pHaadZEDzFDnvDOuypU/UGO8/Y7gk0q45HYJTunDrKHpxj/MTCVN8XI6xCyYsZwWi/qTDGvllC55mVdgKkw6jxMdKLE4s2Nrj4YzLU3k6r1SsJVRZkmjLsPnK04KlZlZecLC4YTrJgNbDbmKFMr5Gx49GsnYpPsy+S47/T5drf9vCxUd42sG/G4FmURpcpi7KrLR2K77+d4pbrK2RCHCzI9NwTepYsH4FjOGLgRPZSsVyuNbbwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxVJ8ee3wVCIkC8V6vUcYitjM/FI6qbkB6dRPG00P4K7qLDpDN/QeIJ5zxd6?=
 =?us-ascii?Q?I6Gdi4CR8PPB3obKwvYrmh+k4KlP304plShgDNSuxExOgqRFYaexYmu/8BR+?=
 =?us-ascii?Q?zYOPGMZjXzc3KR9fsBnQMjgaibjbeVcLYs16DGKz2Rnd7nP3hTxeQcAQu7QH?=
 =?us-ascii?Q?4w6iyMXqAcWqs4j8IwclFifdgVBLw6XxxzJtq9BZczazvobsAN9n68YJf9c5?=
 =?us-ascii?Q?03a6BesFgRyc0Nulc3yKqzVQJnEFadN9tUSIkYVkcDl61938Yh5+dhio3DOV?=
 =?us-ascii?Q?UUdThY26WIYtU++ZnP2qngfpP5QWDZ+UHec9rNkdwl+7Je+DaPzJqy8h7d1V?=
 =?us-ascii?Q?kq0z7offiNjQDyMIE+gBHDEnxTJJVdE7uWzkD2TgRg9Ayct7N32qbh8ZIJj6?=
 =?us-ascii?Q?Sceh46BovUL2kNWC151+MDKFcWxpObB8mbPxGYsQrhhIZgRdn5ArDZuDbY7P?=
 =?us-ascii?Q?nkEX2rirn1qu3e/s9WZgm6nMBs57pN0XXApO8sph3pvP6gw6NaAPXEQehxS/?=
 =?us-ascii?Q?PUNWNPkBko5HLGmq4mZnkNSiARx5e0Kz/7SfuQcs25lJc33Y+5K/+hCUGf1R?=
 =?us-ascii?Q?1MBXi4UbmgbunjC4nCfHfIIypNm14gtBVZeHnc3opt13o/nDKkHwG4JApjKc?=
 =?us-ascii?Q?qHdoZSdIC4kkpmx7oV08xffX2kkLYvjyco89zKsm7p7Xt9pkjpO01LE6Jx+0?=
 =?us-ascii?Q?CR2UQsgVP9ylwXhWjqH/ENSlfEaFueUfti5+RlinoRr9rX3SBU7No916D8um?=
 =?us-ascii?Q?Ua0MgkQJD4zx/D85hP/j3t14j/+SAweg3CCXAt2Da2dhKQZSmZiRRGzI2Aln?=
 =?us-ascii?Q?BUQ8hwl5qVZfzLeGW6TwxKLEkC/QHAAXdUG6tL0b7zDJ7uZ4irT31ufVrJTj?=
 =?us-ascii?Q?taHgut2N7RJ6SSFUGQ+SwXb1lc6dRVTs/edu+aN9aSx9tYfaeTa3x8P5f3cu?=
 =?us-ascii?Q?St2Cc0YU+CMB5ukD/+azux3RIeYIUeRXhy9wH/MRFuJ61/S5GARI13O5hyj5?=
 =?us-ascii?Q?LYqWp8HG+LE81lMPCOB0D/iZSDRgtRX6wBDj2NgAc2H60WYKq0mo29cs6t1/?=
 =?us-ascii?Q?bM7qC6KT9n3PZ0TmZj/YEoIJLnCxBISn/3L8UbtQp0X8WiLtjXtJghlGDKtt?=
 =?us-ascii?Q?s4WmqgLDLEioqmbs/XDZbYnoWiPfzCN9ZfMJvz3TGBtLwXJhCZ8eP+DTQ2m6?=
 =?us-ascii?Q?4q2ppLaGkbxyUUxDCc3r4KHzMdKNn9MjJ9fKQuDOCC30XHOHO1uchY8nuFle?=
 =?us-ascii?Q?El6wEK+yLpD0u5Offq7HNE0C9lq1n6+tqnmumBm9RcgyYhPTofiNhWPE2rsC?=
 =?us-ascii?Q?KKUDwkezBEzOKSFENaNcHUxhGsSMcdbgqL7l8qcNzNE/3RXCb5kbu+wzPLyD?=
 =?us-ascii?Q?VoA3Jc/AVuaXjKWPpxthQ+0GOv3q9IvG7Pt6Ty7wc48tdmDH5Y/OzuEsrR0i?=
 =?us-ascii?Q?asc5qbXi60rdhqxcWi3jS7MtLhrXHgRjmeGBvG8h4qV8pxRkVDm3BZS88cOJ?=
 =?us-ascii?Q?bR1G9tRcRGrL+Saoklqx5yBNNUSEwUTtCPa/CLpOfvUhESsaptM38aPW+s0M?=
 =?us-ascii?Q?+toFQ9QttM7UTJ7Rh8qnOsUg2SokGnwvVPtPnbyb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c35414-280b-4b2e-11fe-08dc5e26fb6a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:07:50.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2r5NZ/3jTutbizIpmj6pVSZfEPbG8+TmIKwZ6U1HNXFWEqOUzUeBEjXU9mUEsrYFI65NJ/exEwVNXJooyKvemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10337

The latency parameter of the broadcast qos is calculated wrongly.
In fact, no calculation should be made. For broadcast sink the
latency should be taken directly from the BIG Sync Established
event and for the source it should be taken from the Create BIG
Complete event.

The interval parameter of the broadcast qos reffers to the SDU
Interval and shouldn't be set based on the latency. The Host will
read this value from the BASE.

Vlad Pruteanu (1):
  Bluetooth: hci_event: Fix setting of broadcast qos interval and
    latency

 net/bluetooth/hci_event.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.40.1

