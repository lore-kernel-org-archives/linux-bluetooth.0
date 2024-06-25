Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D8146A83
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300450; cv=fail; b=oC9XKRtM6n/bQNFXyaJkJqkaggRslBIB3UI3LR548ucbG/0ys1y9kP4zwYBJyq0H7qsFosURlIBvLpPe2WvXKxWUTTVk0PwOlAiFvQN3zir9Sa6VCus1rtYYKHriTJicTkmFi5YTpNZZ+Sxde74cZ6lJF6Bc6EyHzFL9QlygGuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300450; c=relaxed/simple;
	bh=FzztdB77/ZU+tMHHRUsfBk6KmmTncWZAiVVN2Omw3YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QElF7LPqzc4RLMMk7dpEVMscyK9c5jGVUgdLsBoV4ioUR7OO1l/4BJ5LuCCpJ/6eC/1AKencVGgp92LX6sAed/x+lnbCF3Bf2zGbisJVsFuTQNtgtgXh4EOpdiL3P9HjInu74Vfs72jUXtzYKJCOP9G30kIOPn4sVoBurBa6tig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GKcW/XVQ; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GKcW/XVQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4CYYXdRcMnDQlY8QrXm4WK3/9ppY5IKm/Khgcrsuf6J+h3m2oibC8CiF2KBPyStcI2SqP+CJmI3oJ8TVo2f1896gMq3IJgEi68vReSokihknu8mPLcTMKloA7XiWs5QCf6wfZt4Av5lX/YN/V1BT1yPoCMwayN4Whuzb8+LodC8UxAXdcyJe2KKwEad9otfWjUOjW7MDN3KPf+yTvkQeCNqQipIqfa2Q+cMYUa3BxN1PA/MXfHjyDHC7xdUbiiIYdH9segKusTRao3sVu/x34ygKnFI7J+C8EhrrvvkOOHWmTqHaUUj/gWcy9g+bbvGbfCwvovJgRLJ6dPOCSHIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90/imfpZJ4uOz+NgUbg0112kCf6BjA/SHmuwWTRFf5o=;
 b=dDq2leVFG5gHWzOXDI/KKEdVnqRwFBDs9cUjBfSOtzktSUZ+mGaEokRNukLz8P+ekDn79OO+hGYPw8w8PbuB0b0o+6xB2hmZZFNHWN9P2xteNdAWXX2Ca1+lSudYC2dHTFI7L/5tLkEjwfDrHFzuV+2hUTrOmoyNgoemqor2DNHGY/9rhuKIpLm5C2DPrtI8mmnw9zBmiOGvLgzIySTKZur/WGvodzuI+EKWA0ljwDwpXtbG4B917xFPsixdy/slfDFpcd/VLMbUnQLzYKC8RH13H1B/x+aLDu8Y3MFobzRH8Fvrr+eDD0hD/8jLw6+Srk1bqmGchut/A6lCfmQ7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90/imfpZJ4uOz+NgUbg0112kCf6BjA/SHmuwWTRFf5o=;
 b=GKcW/XVQq89intLjjCWl4xhL0ljW0y3y7hduCSC14SeYFDQZSx1iqYtpSuS18q/c+t4N0Qi5ORIsMzlSwizFFKkKciqvi11PlbSafQtbiYYfeOfPZH4DvReMdERYvf5ndBOhZnONJlEsOPtvleBMIqNafvEqIHGKfqGAJvE1iL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10431.eurprd04.prod.outlook.com (2603:10a6:150:1eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:27:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:27:24 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 2/5] test-bap: Move BASE defines to lc3.h
Date: Tue, 25 Jun 2024 10:27:08 +0300
Message-Id: <20240625072711.7011-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
References: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0082.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10431:EE_
X-MS-Office365-Filtering-Correlation-Id: b90a1d2c-8e08-446e-4582-08dc94e841f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFUEIJOdY162L+DTX0dHha7WseqNhm+14wi/OsBAX1DDWuIo31t2+4jrPkyw?=
 =?us-ascii?Q?rAZwReilEoKXzbA+rP6+IF/aB0xOfFQ174czxHlii0JapWK9veS1Wz1sPA1l?=
 =?us-ascii?Q?CpE9tO2DIIMOUQIiQjZGCTTHaJvMuz4qCbYyZ0EWjyi9ksEm0CIJ6nx13hdI?=
 =?us-ascii?Q?nd/xkKIiGuyDO2aCxyFY58mJrlcOPN/hh9Vr7UH+0HPp3rOheEXTmcTwu/E+?=
 =?us-ascii?Q?b7soOuGbTEKIQYPJh05af1GileZjZmz96DRVkGRHCmNBICZNLFhpKdKuFMCa?=
 =?us-ascii?Q?HALjp7dtagj3JvNJJ2lxcJ6BGP6T9L9moLaT/VYVSWD9zelBOzIGpik9o2F3?=
 =?us-ascii?Q?dKdji9pX63MNu3Cqpdh0rGm8kRmJVUQodYUu3blH+J+nVz6e/MYvNGMSzGtj?=
 =?us-ascii?Q?yN6J1oXAeFDTShZ9St6UC4/jf9m8jiGRP51f2MSNJJW1SLeRr0tg+oDwlAZi?=
 =?us-ascii?Q?UVWscw6K56vefONNZFaJ8B0zZai4YyiSKZcjVOj/gwrMrRlyHD9eTYLb+GdE?=
 =?us-ascii?Q?zKXasZZLsMXMi3ZETVtZKijCXY/zMRe6FUbowJzoCDeJQMlSVyZAeab3FASo?=
 =?us-ascii?Q?xCac8fbSnDrGMxZXtPtOviW4ryC097VRFfyYqxslmUgAk6ZJ3GZ9YKzGIbgx?=
 =?us-ascii?Q?tWuuxKGRU1uRCQF+2CDdxF+95qp4ktNWpAF/WS/HTK72sZ8CkCwIVtq7qRmH?=
 =?us-ascii?Q?XGqpEu3jgAYmCeq4ZUGIBE9bhu5JLhANBrdUehy8AV5ANlaer/cSAJnMJQJd?=
 =?us-ascii?Q?8S2s/64cSYx/pQKKu4RgcYSvAnwOiq7yiTKF1Pyye9+z5ZP1YfyvggGfSYzl?=
 =?us-ascii?Q?nccHfV0oSxbTaHy1Yo9046vgk63ecRBAWZGZzD2B+sqs9+ce2qDPN0WutEJ+?=
 =?us-ascii?Q?+zDT7HrcZcvEFmco7bvL+RGT9T5B/p592zmAHdX0hIOybd3T9NdKqOTR0PfC?=
 =?us-ascii?Q?9ISyQnGkmremGv+Il3tc17VXnclpZ06+G3rq313b455Wn1kwyRQm05uwdq6b?=
 =?us-ascii?Q?Sq6oPdPQGwQROheT3YUvTrSTj2qnF2h/GYxsLI9gSnXUm1qt77nNu1FSXH3l?=
 =?us-ascii?Q?L8fo7CXP28Q0n54bTPA75sJvii6swG2PnozPgy/Q8ZGIJY/L6FSWhklUnypw?=
 =?us-ascii?Q?LH7jTlw5p0LVg6u3eQ7cGSdhicBbXAdpkT3dK8fOyHu2DXpLLFk2ByKacM5b?=
 =?us-ascii?Q?VhbzqvlLVMCX0sAhwK+ToSbj3IwNxkrrcv2KUx3M/dw1viOK8OM/HD3iDsXn?=
 =?us-ascii?Q?0lJHdKkcnKb5ADZTNfWeAWwxi9HFXXIAzaoVJx5+Wve+MOJDx2mF6UFwdNJ+?=
 =?us-ascii?Q?P/Ri4AbOyteIwZML0I3Ye2jmkWFLgMg+IJveor25SRrBwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAx5UO2jefb9hjo9V+PRe7vox62QnEoc4NSOqs6bqXqqbgN0Z65tZ5CQqKXv?=
 =?us-ascii?Q?Bws5swu/lSWTMN9LpLkol6kouxO6jAJScm0fW9qsy7fOsjqhTISfPCZep3Gl?=
 =?us-ascii?Q?zcQAldeid8IF/1pOGMjZeG+GsvlyNRDjVmiLndICOzwrqZL90kQiIqOw6cLR?=
 =?us-ascii?Q?pslq6UJYlHnfpkT6wqLrZOBwN+Y5CuRrgTcu+XF+GXMuCi47C/4dgpaaSx6e?=
 =?us-ascii?Q?8GUAIQrH3m4NvkvDqa4+j4z4mLRIPUv5JHcBpLMN6CCmeB0wDCM3HhKQwwXA?=
 =?us-ascii?Q?9rte/Fs82Jw0iEAhxItcLnqQiyk6dS+IVhNbZxgwNjUkOHu2xwY2hAgFDYhe?=
 =?us-ascii?Q?AAO3Pzl57uHXUCFDWOsoW8qJSnMm8jc+SrRGxY+Zd7Jy/ZJTm2U57KWVz2Kk?=
 =?us-ascii?Q?f/WT4P6N5Gk8gxw+OWmJZJNfAZ7nQt7P9jTE+A822kSj/0xb4B1aH/ZMDIy2?=
 =?us-ascii?Q?O9VCA8DhNPiIlmTC0ca+1rEj4grLDSYwlV17tjoVmShp8Mfr1rOrxhiUj8Sk?=
 =?us-ascii?Q?WEOx33bT6zYBHAgzBrscBxvnHQh/eMlEnaVvFlz0YkJhIPQHo6Rvvcb8ldis?=
 =?us-ascii?Q?1Ua1UKSDElF5jvS3nUwVHzizT54s0Ci6JsDru2QqF0kaxc5OcfdR3UKosRWG?=
 =?us-ascii?Q?AdieFkTcNRrwusnZFmMGJK32pyprYAUu6ynNg86wJkXIeRDa7eo9oKzD4DFl?=
 =?us-ascii?Q?UX7BrlNgo3xmoy/8vsVMjAOrJmD6ULRthHrIFCXZ3xMdLRdnGTgKMHqVPnwx?=
 =?us-ascii?Q?4SeM3wVV3Ng/fjxZLWXdw2vKC4sH629B1o6PWyLQ17vb2PhnWNKRV8c3G4Dc?=
 =?us-ascii?Q?+ynoWZkj1Zf00y1eMihU3hjpdDSSDrI80T9cIs4l75CfF0h41wVSoFLSniUX?=
 =?us-ascii?Q?P3P/R6+Ud0Qp1w0O/0AKm6RdNCG6Nm5zOH6nPdNXejyZf8euCFIbUlDtjS4Z?=
 =?us-ascii?Q?z03Sgqiape1Su8PrERsT7Qe3UnLE240NQuPBc0C+hKyAvUbse8I5nVpuwyob?=
 =?us-ascii?Q?eSBKLk6brP4HG4I8DQOpax1g2K4pg20EU9S//aksKf3qUtJkm4I1iJKaa+w7?=
 =?us-ascii?Q?7+E+MHFls8+HfvZyieZAVwA247ArPDyN1YBdKtecLRs3ZAxiC7vhhK+gfGHO?=
 =?us-ascii?Q?oZi2yE4Ke1ayT4gIoyCwI2M7BUI1bGkDI0EXUGPisjtEpZdk2oAeSf4DLqBb?=
 =?us-ascii?Q?rbrcNwIWG85KidlkHjTSdgLeyZ4Jb989d7TFdi66TlXgF0x/pXibZsuOZrBT?=
 =?us-ascii?Q?O47rZnFvmF39YF95f56SkBF2qpUmeNagoHuayEbRljh91Tj96Hl8Jv16kdbn?=
 =?us-ascii?Q?3Dn41YgPCyDkdyMbY8fC0+rWfr7z81vKhr2/2AOiv3pDoe7a8RZZtAeJtSkf?=
 =?us-ascii?Q?+dmvssN6y5jmIupO0tl08xG9HnhVzNiJpeR1xgQMKHO8Bqb2V8V0WJdoc0n4?=
 =?us-ascii?Q?4b+22805LkACLQl0PCa7xoxKj+WUXRLuhkR6DgiSCR/0ZpTrmtdd4TQsh26p?=
 =?us-ascii?Q?fesmCK2wqrtMZCROANNnvGl7HgJYG4IRTCbyhhYwv2SyVexAyiy+ima0npXV?=
 =?us-ascii?Q?GhAjEpsNqBG6BpNonZG56d3tiSgJBIP4+kWTVP8wjUNHKBtRnP1AgMbrq2qs?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90a1d2c-8e08-446e-4582-08dc94e841f2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:27:24.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1Cqv6HQiRLHEZQ7/4HpIHCJ74MKGaxyeIHnjHPFbNJFEHOuac9EmvzriXgMg6qrkNO+XVHtW0U4Mvo6pGqWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10431

This moves the BASE related defines introduced in
test-bap to lc3.h.
---
 src/shared/lc3.h | 150 ++++++++++++++++++++++++++++++++++++++++++++++
 unit/test-bap.c  | 151 +----------------------------------------------
 2 files changed, 152 insertions(+), 149 deletions(-)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index abd9b29a3..944f574b0 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -275,6 +275,156 @@
 	LC3_CONFIG_48_AC(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_6, \
 			_ac)
 
+#define BASE(_pd, _sgrp, _nbis, _cfg...) \
+	_pd & 0xff, _pd >> 8, _pd >> 16, \
+	_sgrp, \
+	_nbis, \
+	_cfg
+
+#define BASE_LC3(_pd, _sgrp, _nbis, _cc...) \
+	BASE(_pd, _sgrp, _nbis, \
+		0x06, 0x00, 0x00, 0x00, 0x00, \
+		_cc)
+
+#define LC3_CFG(_freq, _dur, _len) \
+	0x0a, \
+	0x02, LC3_CONFIG_FREQ, _freq, \
+	0x02, LC3_CONFIG_DURATION, _dur, \
+	0x03, LC3_CONFIG_FRAME_LEN, _len, _len >> 8
+
+#define LC3_CFG_8_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_8KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_8_1)
+
+#define BASE_LC3_8_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_8_1, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_8_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_8KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_8_2)
+
+#define BASE_LC3_8_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_8_2, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_16_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_16KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_16_1)
+
+#define BASE_LC3_16_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_16_1, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_16_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_16KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_16_2)
+
+#define BASE_LC3_16_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_16_2, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_24_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_24KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_24_1)
+
+#define BASE_LC3_24_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_24_1, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_24_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_24KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_24_2)
+
+#define BASE_LC3_24_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_24_2, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_32_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_32KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_32_1)
+
+#define BASE_LC3_32_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_32_1, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_32_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_32KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_32_2)
+
+#define BASE_LC3_32_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_32_2, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_44_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_44KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_44_1)
+
+#define BASE_LC3_44_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_44_1, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_44_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_44KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_44_2)
+
+#define BASE_LC3_44_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_44_2, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_48_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_48_1)
+
+#define BASE_LC3_48_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_1, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_48_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_48_2)
+
+#define BASE_LC3_48_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_2, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_48_3 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_48_3)
+
+#define BASE_LC3_48_3 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_3, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_48_4 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_48_4)
+
+#define BASE_LC3_48_4 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_4, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_48_5 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_48_5)
+
+#define BASE_LC3_48_5 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_5, 0x00, 0x01, 0x00)
+
+#define LC3_CFG_48_6 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_48_6)
+
+#define BASE_LC3_48_6 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_6, 0x00, 0x01, 0x00)
+
+#define BASE_VS(_cc) \
+	BASE(40000, 1, 1, \
+		0xFF, 0x00, 0x00, 0x00, 0x00, \
+		_cc, 0x00, 0x01, 0x00)
+
 #define LC3_QOS_UNFRAMED	0x00
 #define LC3_QOS_FRAMED		0x01
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 638717afc..c92c4f671 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -5574,29 +5574,6 @@ static void test_scc(void)
 	test_str_1_1_1_lc3();
 }
 
-#define LC3_CFG(_freq, _dur, _len) \
-	0x0a, \
-	0x02, 0x01, _freq, \
-	0x02, 0x02, _dur, \
-	0x03, 0x04, _len, _len >> 8
-
-#define BASE(_pd, _sgrp, _nbis, _cfg...) \
-	_pd & 0xff, _pd >> 8, _pd >> 16, \
-	_sgrp, \
-	_nbis, \
-	_cfg
-
-#define BASE_LC3(_pd, _sgrp, _nbis, _cc...) \
-	BASE(_pd, _sgrp, _nbis, 0x06, 0x00, 0x00, 0x00, 0x00, _cc)
-
-#define LC3_CFG_8_1 \
-	LC3_CFG(LC3_CONFIG_FREQ_8KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_8_1)
-
-#define BASE_LC3_8_1 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_8_1, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_8_1_1 = {
 	.cc = LC3_CONFIG_8_1,
 	.qos = LC3_QOS_8_1_1_B,
@@ -5613,14 +5590,6 @@ static struct test_config cfg_bsrc_8_1_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_8_2 \
-	LC3_CFG(LC3_CONFIG_FREQ_8KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_8_2)
-
-#define BASE_LC3_8_2 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_8_2, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_8_2_1 = {
 	.cc = LC3_CONFIG_8_2,
 	.qos = LC3_QOS_8_2_1_B,
@@ -5637,14 +5606,6 @@ static struct test_config cfg_bsrc_8_2_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_16_1 \
-	LC3_CFG(LC3_CONFIG_FREQ_16KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_16_1)
-
-#define BASE_LC3_16_1 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_16_1, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_16_1_1 = {
 	.cc = LC3_CONFIG_16_1,
 	.qos = LC3_QOS_16_1_1_B,
@@ -5661,14 +5622,6 @@ static struct test_config cfg_bsrc_16_1_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_16_2 \
-	LC3_CFG(LC3_CONFIG_FREQ_16KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_16_2)
-
-#define BASE_LC3_16_2 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_16_2, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_16_2_1 = {
 	.cc = LC3_CONFIG_16_2,
 	.qos = LC3_QOS_16_2_1_B,
@@ -5685,14 +5638,6 @@ static struct test_config cfg_bsrc_16_2_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_24_1 \
-	LC3_CFG(LC3_CONFIG_FREQ_24KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_24_1)
-
-#define BASE_LC3_24_1 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_24_1, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_24_1_1 = {
 	.cc = LC3_CONFIG_24_1,
 	.qos = LC3_QOS_24_1_1_B,
@@ -5709,14 +5654,6 @@ static struct test_config cfg_bsrc_24_1_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_24_2 \
-	LC3_CFG(LC3_CONFIG_FREQ_24KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_24_2)
-
-#define BASE_LC3_24_2 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_24_2, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_24_2_1 = {
 	.cc = LC3_CONFIG_24_2,
 	.qos = LC3_QOS_24_2_1_B,
@@ -5733,14 +5670,6 @@ static struct test_config cfg_bsrc_24_2_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_32_1 \
-	LC3_CFG(LC3_CONFIG_FREQ_32KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_32_1)
-
-#define BASE_LC3_32_1 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_32_1, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_32_1_1 = {
 	.cc = LC3_CONFIG_32_1,
 	.qos = LC3_QOS_32_1_1_B,
@@ -5757,14 +5686,6 @@ static struct test_config cfg_bsrc_32_1_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_32_2 \
-	LC3_CFG(LC3_CONFIG_FREQ_32KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_32_2)
-
-#define BASE_LC3_32_2 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_32_2, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_32_2_1 = {
 	.cc = LC3_CONFIG_32_2,
 	.qos = LC3_QOS_32_2_1_B,
@@ -5781,14 +5702,6 @@ static struct test_config cfg_bsrc_32_2_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_44_1 \
-	LC3_CFG(LC3_CONFIG_FREQ_44KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_44_1)
-
-#define BASE_LC3_44_1 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_44_1, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_44_1_1 = {
 	.cc = LC3_CONFIG_44_1,
 	.qos = LC3_QOS_44_1_1_B,
@@ -5805,14 +5718,6 @@ static struct test_config cfg_bsrc_44_1_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_44_2 \
-	LC3_CFG(LC3_CONFIG_FREQ_44KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_44_2)
-
-#define BASE_LC3_44_2 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_44_2, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_44_2_1 = {
 	.cc = LC3_CONFIG_44_2,
 	.qos = LC3_QOS_44_2_1_B,
@@ -5829,14 +5734,6 @@ static struct test_config cfg_bsrc_44_2_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_48_1 \
-	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_48_1)
-
-#define BASE_LC3_48_1 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_48_1, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_48_1_1 = {
 	.cc = LC3_CONFIG_48_1,
 	.qos = LC3_QOS_48_1_1_B,
@@ -5853,14 +5750,6 @@ static struct test_config cfg_bsrc_48_1_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_48_2 \
-	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_48_2)
-
-#define BASE_LC3_48_2 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_48_2, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_48_2_1 = {
 	.cc = LC3_CONFIG_48_2,
 	.qos = LC3_QOS_48_2_1_B,
@@ -5877,14 +5766,6 @@ static struct test_config cfg_bsrc_48_2_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_48_3 \
-	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_48_3)
-
-#define BASE_LC3_48_3 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_48_3, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_48_3_1 = {
 	.cc = LC3_CONFIG_48_3,
 	.qos = LC3_QOS_48_3_1_B,
@@ -5901,14 +5782,6 @@ static struct test_config cfg_bsrc_48_3_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_48_4 \
-	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_48_4)
-
-#define BASE_LC3_48_4 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_48_4, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_48_4_1 = {
 	.cc = LC3_CONFIG_48_4,
 	.qos = LC3_QOS_48_4_1_B,
@@ -5925,14 +5798,6 @@ static struct test_config cfg_bsrc_48_4_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_48_5 \
-	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
-		LC3_CONFIG_DURATION_7_5, \
-		LC3_CONFIG_FRAME_LEN_48_5)
-
-#define BASE_LC3_48_5 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_48_5, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_48_5_1 = {
 	.cc = LC3_CONFIG_48_5,
 	.qos = LC3_QOS_48_5_1_B,
@@ -5949,14 +5814,6 @@ static struct test_config cfg_bsrc_48_5_2 = {
 	.state_func = bsrc_state_cfg,
 };
 
-#define LC3_CFG_48_6 \
-	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
-		LC3_CONFIG_DURATION_10, \
-		LC3_CONFIG_FRAME_LEN_48_6)
-
-#define BASE_LC3_48_6 \
-	BASE_LC3(40000, 1, 1, LC3_CFG_48_6, 0x00, 0x01, 0x00)
-
 static struct test_config cfg_bsrc_48_6_1 = {
 	.cc = LC3_CONFIG_48_6,
 	.qos = LC3_QOS_48_6_1_B,
@@ -5983,10 +5840,6 @@ static struct test_config cfg_bsrc_48_6_2 = {
 	0x10, \
 	VS_CC
 
-#define BASE_VS \
-	BASE(40000, 1, 1, 0xFF, 0x00, 0x00, 0x00, 0x00, \
-	VS_CFG, 0x00, 0x01, 0x00)
-
 #define QOS_BCAST \
 { \
 	.bcast.big = 0x00, \
@@ -6003,7 +5856,7 @@ static struct test_config cfg_bsrc_48_6_2 = {
 static struct test_config cfg_bsrc_vs = {
 	.cc = UTIL_IOV_INIT(VS_CC),
 	.qos = QOS_BCAST,
-	.base = UTIL_IOV_INIT(BASE_VS),
+	.base = UTIL_IOV_INIT(BASE_VS(VS_CFG)),
 	.vs = true,
 	.src = true,
 	.state_func = bsrc_state_cfg,
@@ -7106,7 +6959,7 @@ static struct test_config cfg_bsrc_str_48_6 = {
 static struct test_config cfg_bsrc_str_vs = {
 	.cc = UTIL_IOV_INIT(VS_CC),
 	.qos = QOS_BCAST,
-	.base = UTIL_IOV_INIT(BASE_VS),
+	.base = UTIL_IOV_INIT(BASE_VS(VS_CFG)),
 	.src = true,
 	.state_func = bsrc_state_str,
 	.streams = 1,
-- 
2.39.2

