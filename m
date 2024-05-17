Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA547F7F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949322; cv=fail; b=uPoOl7nwgiWNazJWopeedu+tPBX9J62G0mLANHhKiPnnOo2VX3UCe/Ghn36wdPnkJXoVuTcYFsRd2Nu0+EetLGDpCgW70MLxJB8w6a/2DA4/eAXc5DmAKoVIdiXE5tt0HlLJ2HUvp2XrROCgBbvdbei8GiMb/ErTXVaoW/9Dzm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949322; c=relaxed/simple;
	bh=c6dMa51jBq+v/MTrljsH9kDkmSYRHg2UEtC2ZJ6AfqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALpnXQKJDSfLHrj+kSag3HS/w5UNp2vB1RrbxRiSkI50KLpaXzsWuIuUihZyEBhXVdMYbcNyXyPc4KmpRmh5K0DSZfcx0049ti36rHO1X4/TkvdJ1DdYfCtOgL64Kez6OrQKZF1oxjJNdK8F6UjJ8rkD4pRLtz44jCVGnODAopc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZkWSybwi; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZkWSybwi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgNWAtOvdqMSJ0j3JuDyIkp08k7xu0+uMBmzGmW3MfZkm0PDhYGVuAz/VxEhrr9xUxWAtJbEgXjoHCJ3oJYLA2XhiR7UrIVA0R1n6EiXolpi4IKH3RAe9yb8kR4+DLw5IZ+40f02csVXyHQP9XVCmr6A2RMiL/alMhPCKi8cIH+OhKh17rwk+scP54OzVBaAUntjnLjeVL6wxtYTzDAQJrc++ebJUuFwSLwDS+lQdkdRNHXW3ZhqYfEdmBt0aLAXtHBgY5g6SYVeSM8g5dUKwAAZph9boFHevKhYZSh+lHkczW8b1s3fcXhNB+9j1K5cT/IDPpBlpAQyHsi9FVY9Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZwWolUlkRiZ1moOv7v1VNHRHSgKLXFsIGtdXfKZhHM=;
 b=aCGFsymoIfWtcqOmIE/tP3kUl+b58o++3N1LbJXHk2cfC7Van6byvCffjZTzTI62jSDTN2lUwirV9Z4HlFGNdqzamRwR6QdUqOdn3bsB69klKkEPVtuT2aqT/xNMzXKlu02qBPVMv7Wb8lPmKZHw4zIwQ0cd91ZnwRsUTafpnUOI9yd1f0qcqA6pTOmerRd1UwRgAqclHcuZHjJl0YqQLw9yM8fOEx5Z87/91wR+cqzrAVhT3B9zo7E8q72182HURqHX/fuzn96wU456fN9rbxPAfhenT9tIi8X77nasWa98vHmzSoCFfgXLHgtF6olJC+JwC1Dc1z9oa8C4fSSs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZwWolUlkRiZ1moOv7v1VNHRHSgKLXFsIGtdXfKZhHM=;
 b=ZkWSybwi83PNC/ZB7x/zys4Cuyk1yGTHon8qlBe7TsTCy0hpvacQOdlX5WjoXVqaZhUuIn6/Ub6wYua7Jwv9KwJM9SDRyOC0c0Ucm+zyjMXUeyPQQqI9XGWVneBNqGuNecxgK01U4FuI3KRgX/hgbz7sR5KYOWYScEAM5Rar3UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8934.eurprd04.prod.outlook.com (2603:10a6:10:2e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 12:35:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:35:17 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/5] test-bap: Update caps to accommodate 8_1 config
Date: Fri, 17 May 2024 15:34:34 +0300
Message-Id: <20240517123436.146332-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
References: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: ccad2d98-291b-4f36-290e-08dc766dcf14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1g3jcbMOMl+JuXl4jMuhxEGDYMB/8Cmw2j4h85HewSOER1yvtE4CzjRmsDY6?=
 =?us-ascii?Q?EcaQTXpCnmRNxWqflXXuYQX4Xe89zPHCmht3n3xb+OBdYmHdQOnCplWilyyf?=
 =?us-ascii?Q?KixFGQczgVMJHSxgra3kmLgQ00IR8Sdedm4MTO9czTxh1lFVjElQo2nbCJ4o?=
 =?us-ascii?Q?jiV9A3nmKfFllbs1M99paOLfeibnhxiJQkqqO3T+Ldk5ZUAjHt99l5nqjMe8?=
 =?us-ascii?Q?d/oqqNULKjcRlnm0VQsWY2VSPgTyAJg89TfSez3XX0aWESLEp86Uv50CoLJl?=
 =?us-ascii?Q?oPUZ2o47mC4MqFwqlpfN186JvYOrQ2mrTkneahZbEEZ1whdAc6us7sBa3FAB?=
 =?us-ascii?Q?Y60pPt04Deu4JqjvFLPqKk91Jbx58X+X5kM+hqZFq2yiLlmWQQ0Qe68z7c2d?=
 =?us-ascii?Q?jygdFp0oiXUK8jcdCj0zh05RiOpVD472uhIJ7Wz9oPnqH9kF5TYvZdyqgwP/?=
 =?us-ascii?Q?Qh29MTrP5md2nLgXrmRuGnvaFxLXtkRRHgUkywUDatslhizQntnksksDO79M?=
 =?us-ascii?Q?t+Xg958p3JgeDVovZWncT+YdgDxBWqm5R3tcJdTkOQypYsvYRcv+SfD1CMyo?=
 =?us-ascii?Q?rHJ9Kza8EJUyyB26shyDahsXQxQ2YSKgHhAc3eabdNXSOeDVk1IH1M8pJ7k4?=
 =?us-ascii?Q?zK017PVF2vJ1RbpWFhCJ8tJqoFl9ryqa5sByvl1Bciy3W2LpXFZ6sdg31pVb?=
 =?us-ascii?Q?FUg3ssZg/7j1FiDKCgQGWTV44SVbj/TyHgFmhcuGgtC77yWK8ZsvV6l9Lvri?=
 =?us-ascii?Q?e8hSrYrw8ZEWcLGPfndbFeTusmpcWB0+XU1BOUIUh6KEd36rRa+/x/RR31ym?=
 =?us-ascii?Q?qfWMq/jkIfYRvEacm+LcLRJ6G73r1RXYx6R6vh84qnvnpjOqRbWqMiADRrbS?=
 =?us-ascii?Q?nzQt+auBf2YOpY8141n5l9VPXtfgwGKQUGEoyvpDEOunOG35pZezxAQu5hLY?=
 =?us-ascii?Q?avIlwzx2BorJPqZ1g5c+7UXBZ8DypD4UykHNp7rOY8Vo95H42JJtlZ7aauqn?=
 =?us-ascii?Q?fa4KjgPTDf+7IO14K0/WhQH9+DAaHSQgiFw6H7iSOrfUeUJ2sIXwzW44pFQY?=
 =?us-ascii?Q?lcBJyW64gPNBq27LG1QkrvZ6sgtuO0FAgc7YDal9fDLFIifHbmc4Kt/QfZuU?=
 =?us-ascii?Q?we3BREZyKiG1EGU3Hd42GHcCDH1DSEGYG9L7psA39638ccSC41T60rdz15Um?=
 =?us-ascii?Q?WPq8QueHGHj6jAPc4FnCC5RUv9qSV9Fpeg2PrOD/G1IT7QxfBuP6a0yEplb0?=
 =?us-ascii?Q?yyT4lAJCIW/N6AhQae0iAmuJeRGpNRGRkNIvLXZz/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hBwnEvb6QatR4j8TFXdvi33eNmy+KzWsF/QUBCeE3BatIVC5rSZWdmxQfEPY?=
 =?us-ascii?Q?wnkRCeE1Y0xef1O9J4EWaNhsQTztaGuSwBNYczppezOraeOmOc+0nGHB9iX/?=
 =?us-ascii?Q?hO4vkzHW7UC2CbyU0ZekBl6z5r8BNM02O2aFrfjsJd0+aUt7suXLLGf5/KMG?=
 =?us-ascii?Q?nBQ7QilvNeB56ni/QJYuZcfAGJnPCt4fNgGuegklyMfT9qSCFh5wsK4Az89J?=
 =?us-ascii?Q?TRTJIjEgiDMOQC9ADr3vfbMbliBJ5nMCQ4SeMEqmvS+bXDhTLUuglU65buO9?=
 =?us-ascii?Q?RD9/xC0q3YEL5G+aHp8eUVfkNTnIIVLhW4XOo3bCtWwNW20VQUo626RYZtDJ?=
 =?us-ascii?Q?dfVM0WR9/8vTtJMtkqFqqokeukZaYoAT8UiEOuecPGYozytd5yyGowCA/jPJ?=
 =?us-ascii?Q?hk8tso2/i5he4fsaUSWqqnLa4AHfzI8Yjk+G97OgMRzOU45faFb1KXTy1oFM?=
 =?us-ascii?Q?Sg5bx57R8cCr9qMkz40Ia+CvmJthuSCqP2VJ2+eyJNJlKdl1q79FyjpFAfWu?=
 =?us-ascii?Q?313nUrhmnXg69VbprBF52wnHNwYC5+ycqs3r9IU0pIpQuUCmUG8G4ikKLPGJ?=
 =?us-ascii?Q?yWjs5OFsCrpQ7CZH27My8uRRkOmECRT3FjLiq3z+Tm9Q43MmguqaEIVI1nbk?=
 =?us-ascii?Q?Z6sRjL85UVujsXumXnET7ZOTPLCXCRG9ttgaMdpzygNOAtmvUs9TDOY0qyMr?=
 =?us-ascii?Q?WyJGjK8ENdWxmk5H1g9H+e4fpAzOEX6kMIfqnMMZmE7SB3BAh8xTrpO5bY+t?=
 =?us-ascii?Q?NzgMWMMrHl1ngHF+ZM6fPgQzegiqols/EB4BWeYFSq9jzBxF+BO1E8+8/oa5?=
 =?us-ascii?Q?0VPhQhjMTxy9Q1UwSW7jgkbLv5nRbUDzjAEklFbqMfvxI+7GszygtoEtwZ/G?=
 =?us-ascii?Q?HLPOJBRNLSiwgZ8GLmSQjAo9xTzysoj5bUo4iAcwnImGOVxXpDokHNESo5Xf?=
 =?us-ascii?Q?pJzb2wThhGZHFdXMShXtDs7wgCgsiCVx/fRUzPzAihcgpj6dqTm+TCxQQtQ0?=
 =?us-ascii?Q?oXm+TBDcXz867mOPSmZhzyfL1CUlnWmmm1bisMuqwd3MHBxLK9LOPyXY3kS7?=
 =?us-ascii?Q?Kf3yOkMik87b1NTlf4aTGWPVSDIKNTJjUZtPIFgmqD0xIChYh5D6yLRLQ+nO?=
 =?us-ascii?Q?SmRRbE3NnYeuhmsK3HucdlDf8WDjCui2fn/QBmReJCTQ20SeheyJqvakp897?=
 =?us-ascii?Q?uWfYnJPwMShXyzzckuYAp+q5PaVd9EUJrG2YjUGFbxHZ21jxdMcoelUqaMKh?=
 =?us-ascii?Q?Fg79jHnAmqjtCHJ3mt7a6zbp/jdknvWN1pvDe9R+XNUrene+rXxuvKTaCaRo?=
 =?us-ascii?Q?ETBxESp9XSqmQMnhGkE5YQJgKD4k4gFysHPcDWm8VuXS6Iw7/22TG5Y3K7YW?=
 =?us-ascii?Q?+qJjqfQpzVJrtgTc3fWjtbbTJUE+UrazAX9WBJ9IYsGbbaJi9Z4q5Xs4P0uF?=
 =?us-ascii?Q?4TCprFPJOddTAKlJX1MhMZ5/a/D0jwWC/xgbiTCkEzS8DNd4x+5haMDny+yI?=
 =?us-ascii?Q?5O+CtT0Ekp6khZgH7r59ASlZzvy5qVK/rNYEXovO3hPZ6MujKABmFj8d03zS?=
 =?us-ascii?Q?REwzx0Qm2JNBITzxyVQiSUcVhk/A9fumTnBaAIfm+g+q8zyDX+r0g9W29UJB?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccad2d98-291b-4f36-290e-08dc766dcf14
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:35:17.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exVYdChkm4C3KnSKplGSYSqiRbJG/Y/4nDYo7ykRoEILjmgY4r+sZZguVzUqGK65MSakhERsonlT0H+7LR6n8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8934

This adjusts the min SDU size in lc3_caps, to accommodate the 8_1 config.
---
 unit/test-bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index ac9d7ff38..e930ca604 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -64,10 +64,10 @@ struct test_data {
  * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
  * Duration: 7.5 ms 10 ms
  * Channel count: 3
- * Frame length: 30-240
+ * Frame length: 26-240
  */
 static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
-								3u, 30, 240);
+								3u, 26, 240);
 
 #define iov_data(args...) ((const struct iovec[]) { args })
 
-- 
2.39.2

