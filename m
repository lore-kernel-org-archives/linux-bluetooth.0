Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C2A4085A
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377653; cv=fail; b=MRSjc/jwSefz+oQVb93p+JBKtzpsJ6xSYG1yGcNO63+J7gxgn+T1itAJEFYze73SciZylZ8ghH8JMGqSvhmJJzbyWHlkGB+7rKgsaXLXiiMm7niSw0y512R44yse8pNTatt2nf1tp6z+d2m7OylDSDinN6elNkY90hnp7ipH3EQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377653; c=relaxed/simple;
	bh=qExDV7ycmM3BramvlseDUOqqwhw9dHdpnCmRhFNEb04=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HFlwtjgKNIi4jwkrcbnExlCFBG3T+MiYLC4oeqEbJsf7GcSPEoR7nq1j7HeSL2uZIjWm1GFzEabbeGUmxe9fzFx0HA/7LGjByRvycOuB0KOhnkeqn6mO72KmlSK2sYtUbhQs0ctbamX3yDn8SoD18aNKNRoUMkE+BTGyD11ukhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nsw2u+y1; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nsw2u+y1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUSoLxzA80jOvo6LIlZ/b8p378/FLb/E0DAFCi96LJ2wQOQYGE5Se6iuL3onoWSRZJkrRV0fgwwen56qlU+4ExSaM6gZwQ7MY3Xwznb2Su9GRqGup3LiNZ+NTlU6QPecV++IhSrKwcZ4PedDFDOnU3NwxM82vQmPRSQRqXSP2HnVMn/SD8wQfNtGwi9c1EfeGyzFEK7THtqMK7nzEMAx1DH3ImNjF1FnM2zllMa6uqrHSg9qQFULVBFNUs4+DP8pzDvrHTDFMRRie/7fys2sx8Z7pICm2FyLi7vQhuYo4pRZaSDAL+YLL2cIGmVtO8/UMtMUaNII2rGXleeP8ZINVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyS3dJHxAaMqkKxGgSeQ466vIdApgvshEIwEL/nE0mU=;
 b=T03IGSSIG+v6cuKeBJhryc25WgvAmwlDzpcqR4/N8wk4A3djRcLrsQ6X1y6QE2j+pnozdNgHUGGI+hlpeAHt7Pv7dyYrillNqvGFWQg8JvzS419LyW0OvQ91YoMdHfhccdLb8IqmtRVpPuBH76qtXRcsWWc/hcTRoLzOvfUVnjqlwWSCo53OcaFajzAUR6REevdh1Gc5XdYyOoiCJkFQVSsstbRH2H2f3/sp2TLR8XOXTmG6/Lw11wPEPL6/Al3Lm80YP8Ng7eJSFmI0bWI51Ugnzsn/Y8XmDAc1CRkB0TsdqSG4zXQBv4m8NL+PwL1B3vudYlwJ0awc01Rs+uzemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyS3dJHxAaMqkKxGgSeQ466vIdApgvshEIwEL/nE0mU=;
 b=nsw2u+y1djFXs3IjmD3DGZgykO92U1m/3V91GlirHMMOkONfoMopw7MZIj1aVI2RgSydGjUpprhICnr8qlUZpGr1WweXcBazHrcF62fGLVuneCVGFDklt6a6gqvE0LCcjttEqqGaSZMBq+qtk4Z2jG1diV6BpcqAuPt2pltFBAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Mon, 25 Mar
 2024 14:40:47 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:40:47 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Fix transport.send command's transfer of packets
Date: Mon, 25 Mar 2024 16:40:30 +0200
Message-Id: <20240325144031.335354-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1810a5-60df-423b-5c93-08dc4cd98f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tuhKvOAQ7ClHY4628EVefa/XVtpI1bFuiekeBK+qq4ofVBytPFNkzyWR8yxC/Odr1ok6Mh7cI/CMk8OE/bDxjTVqZtw1r5RihXQ8GXPRB8V6rcLjK+7aD72U6ds0chBjCuxrwMegJ13/OM64V+hs4A/vBDt2uVVb9YJWYzAxCRTwNjW4aP5lchIoNGJLg3ekmOLXDnmNNs9BZgRQrwVpbtJZhFCAWahbBlsbppznuc7YWMg7eGXQwVAzBS7MAYdPix2dwB16rB3RBraFLSwhO73nskcCZDckSFZe2hHkdQn+0lBp8jRgcmh1/WvDE6B0CxSxs7sxtPNz+sJ2MbB8e7VPnIGGEjx/gAwAh5xNt0mEhlK1C3UGA4bxGWOZvUIFKL1h/V1qB/AhRnVAPiwz9JSzZ+NVj13r6BH6r1dF9Jmyc5tkpohXqQ/Ar/QwEQxtUdZxHSaLPlqP4l4ewGnuvxazqjBK0fwXEJrUNkE3GiXr6NUVC2f/TmBvkjADVTtn8FHZ3cnoXE681UwfZ4n/7V7366FVskOk8Qo+PeEqy/vHIGwUcqNJQMC+rDbNbQJMYriMJdyJ2rQmpd359N+3mbOtGlyRuTz1Co5SsBOw02XqGGVdeKJ7j8uge2jOWIsMInn2849GOXYqCMpgc9pfedqMyIh/MKuu+eQFPRNoBMDn/+1c5kCgLpPmxg1WxzkJ0a1KCoIUb0fF8mOu5wgOkI0JRuCNpFO+jxzA1pHbj1k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8t8g34Jc4XOK5ztAoRmcz4qJJ7fxsD/IODoGhNIOxXxZJLSP0wEUG9iyrrNE?=
 =?us-ascii?Q?SYC7SPT4oPvbab1GIsfHpepx9Na/oMdWWhxgRACIY6b6XUDjlks1BosgnITj?=
 =?us-ascii?Q?zaM+yUHD97FKejIFA0Bt4eWN5WJobaZxSmYNEJbgilkU7gZoJRAfw0+hlDxC?=
 =?us-ascii?Q?KUaQ8cp8IE0mQyJNMjWCn+/qmqM7/t70pSUQlb3vA6ujiwvUYadQienrVX3v?=
 =?us-ascii?Q?ry/tGZgv8V6C6GulE4c/tUGZxkahOr/jXzcJA0FugbnbYHjOqZuaydjCAOYL?=
 =?us-ascii?Q?nMVTauxhi/KilDc/ViukbslBwYmyY1zBEUabzkV1aDKQx1qBe1JmT974qmez?=
 =?us-ascii?Q?pKZg+b9fLckAEm+8mglIwjcV6NMDsM/Q5z7U7mrGrerM8sp5yxh7JhCvJvco?=
 =?us-ascii?Q?zoRF2hZi+j8F4yUHW/r0SVvqdNa7K1vEuMCFa/3wG0Fuj3pb3Lv/H5LNHxjU?=
 =?us-ascii?Q?HyILEwZsEdaaP5mV5Zt6vAOxnu+uvyu6rheYLhV94vMQkxRjyJ1ZJXBENj+j?=
 =?us-ascii?Q?wlTrau5ESQml6z66DN2tbAbnU5ZPeOSn1TiQw65coF+xirsta9CocT/KRhvv?=
 =?us-ascii?Q?PaynpUmWZoumwpQiWqEW+0fWGUItC6afUdqrNiGio0K/EnhszWY29uuv9ha4?=
 =?us-ascii?Q?6JjPwn/HzqHBqwkWVfIYIIf9huO3Jb+FIxTx5svQbKhJu+Dqj1TJ87Kymcmj?=
 =?us-ascii?Q?J6N7+DZ75PjPpIRmLUxuo2Ghn1yD5D6U8oXrz9Luwpd03v75y0aFbcXa6tBI?=
 =?us-ascii?Q?5M0BEH2hOiCtWHQ+V3PDDP81OHFEDb7fGWv085+DmbTqMlrXkGvVq488t85a?=
 =?us-ascii?Q?QCRRArjucq2NgKuaQR8qbHs9NN9BKxTRYRRnh+Kc+ELmDWkCoa8qnkPwcsj8?=
 =?us-ascii?Q?m6/A6yOPK8OkoboY7US77dONHW4ijf7MLiybBhCABuISdWlzsuojwIZ+3aC8?=
 =?us-ascii?Q?z3y2LTc+l1ktgMzrDaK1zXCmiGZb3RoiKNO8+8JCpDpYLV+JJeNKrCMMIJRQ?=
 =?us-ascii?Q?dRr9di177zLlmVLSSX97HubzThhPK4gUJP5yI0kL192SutE2zCwNQlJysHoo?=
 =?us-ascii?Q?RJzXikJ62VA6BKKkR6DbOVniEwJqXuVVX69eWt8tKIFVEl+lFBOvlpW5AJSx?=
 =?us-ascii?Q?iBM65m7tn6kJlCI6SiJMJ6Nyab92M1k2BPAPhaLw7W7XxFtp7rtcru4Kh5Gp?=
 =?us-ascii?Q?+Hm4IaInv3t2LVGgLOeQ+Dxd/D7VIpZuIhqynjZuCDmYwCqL3QmRG3UIljCV?=
 =?us-ascii?Q?bFZKoX3suWPl2bTv4A8xHEomPhg9kEYfCthqTT+tQmj+sQxeNuUvJaNHf8PF?=
 =?us-ascii?Q?XlQ7Rk/kkO94p1c7JhXaf+C8aGOaeC7h+IOl3qzJQQZ9v5Hp+6tQyVt3BqT3?=
 =?us-ascii?Q?adW/uNDW84dZXmJZPHcQHjx9r5XSh5UkL/nfDVyCA8VwXYYBpofMeRXQHfYt?=
 =?us-ascii?Q?mMCQxvlF0Ly+5xPrEgwzuH0zwmzgHGA4vkloG2wrQ8HoBjx4R/ppyxNXxHYC?=
 =?us-ascii?Q?sOI5WjPK8CsppWJ7gQEPRwnrg1zn/YN+VD5fUXjxkeIh45JHj93rnrfypv/O?=
 =?us-ascii?Q?Pb1SWTmN3FihgdQHybrVjL9sDybeYRrF3bK1MHYU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1810a5-60df-423b-5c93-08dc4cd98f08
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:40:47.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA4ZNO1OzMRs/tv663dtK0Ni8fgFipxl15YfSob+cN7StWsL/odWzQGTUnEyhHtCN/uhf7Wh1S6OWxkTAfjhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459

The transport.send command sends a number num of packets at intervals
specified by the transport latency reported by the CIS Establsihed event.
Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interval.
Since this latency could be smaller than the SDU interval for some presets,
the resulting num would be 0, causing the file transfer to stop after the
first packet. Instead, one packet should be sent at SDU interval distance
apart.

Vlad Pruteanu (1):
  client/player: Fix transport.send command's transfer of packets

 client/player.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

-- 
2.39.2

