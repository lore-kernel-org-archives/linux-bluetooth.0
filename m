Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2119.outbound.protection.outlook.com [40.107.249.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B111187
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694160; cv=fail; b=OiiD9XEXTlMG+8dVP2yJ56QMoUgLyFNrtBM51DNfcDkLVyc0Pfjssmsrmx+aHVgTjH+KauHJgwDbRSaMGpXsZXmnvKhjEG7JN8/fYFpmKHKcEI2vbq+0WRnxhtJ6GHmbjTSqx2GDO8bhJFgMhKS9NXYpEOahrwmSsw+DIovuEQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694160; c=relaxed/simple;
	bh=Yc9+Kq3jsRUcHD3LGkbCRevpJKilQ3ai2CS6rAoPxsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B1Z1Lsn6YDGnffmQRHb6SPFgGuVpGyqaBCwTDauhP6b4hGCvzQcLTEZVOCmtxVC/I05UKc/jookINke4TEf2LifmBkD+jp3mEWSBQsIO9I2P56/5Zzr3vnMi2CMdWatbV4QJC4FAKor64zLDQQq6f3uxNsdNBiuAi2ROeu2upek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ClUdZ1ip; arc=fail smtp.client-ip=40.107.249.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ClUdZ1ip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoRVj8A2ahLiDluHtbG6IuEFb0tifBqnIw05ygFIfKTCJbwO8UAUtL3xv8XB8ZRZT42OD36Nt5UfiFzhGsSBcwCx7raEOLl+2B1Y2JPK/zznW65Dq2J4psfknBvuuhMYF0vJTMux9bid27cNpbOACP9Et80wwrGRb4guuwzw/JaeoKa+lnzdDYKeD6yrSH1wWcQOrVNdoiVuniP97HanrFvpW/px50fj0yPV++mnOt80I89uhaCiDD+qqzgBaLIwvb8P9FVZgxwgtGEucxyVCcG2S1gHFtKUh0P00F0E7O9YY/mtAyFLGDTF8ATNjCklnUCkpMzs0by8qwzZoZbQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWt/J2QDKbm3Zbr7v/xJwvAPiygJ+IprMBCbOEHduNc=;
 b=lhalziy8f1ZM9s3lO+meX+8qH1P0M3iSfdUhumEROWevLwHfW6xg3h/D3yftgEQwWB6WRZEOcvH/dK8GHp6fA2KUm489pY0yud9jUcOlHV0doEJzJRRAZBUkxkTMEXhaP7RfGLgEEYKnOpT5pAM8KCqNZvstNznq5QQu/I/4ULaQ3tFXpJ6CeWafs5G9ZsVYsiTWPDe7+cfaKVcsL9rjodZR4lWDwxXaYlV9rN14zYHNjcdPCvNdKTHI1nAGEGe6y9/i7Rn/hPkxaHzmh6qSaPz55dQK3k357/MuHXd1kN+2Qm37QtfVV6aHwP2EEpLMcFSgMmG+gXkCsXHEhEc3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWt/J2QDKbm3Zbr7v/xJwvAPiygJ+IprMBCbOEHduNc=;
 b=ClUdZ1ipk8vdLBBErBMS6sWLHiS4wGJVTHogur/GQ6XpbNyMGXeRrYyC6ZKT11IWWVe1T+d83lNpLrH4hKs9+1tm0Hc8MXLCEsclBquwwK0SbiryaDdE5nqi7dyiIfkmdfDGBS4xVV2BfVeFv5j6T7btmBAzBWH7/OBW4/J8ALE=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by AM8PR04MB8017.eurprd04.prod.outlook.com (2603:10a6:20b:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 06:35:56 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e%3]) with mapi id 15.20.7409.028; Fri, 29 Mar 2024
 06:35:55 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 1/1] Autoconnecttimeout max value increased to 20000 msecs from 16384 msecs
Date: Fri, 29 Mar 2024 08:35:34 +0200
Message-Id: <20240329063534.56892-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063534.56892-1-mahesh.talewad@nxp.com>
References: <20240329063534.56892-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::17) To AS5PR04MB9754.eurprd04.prod.outlook.com
 (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|AM8PR04MB8017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/GMDN5aY2yC+Md9REV1ejnGA73wkaQ26m/RnrxEXxmZbQcR6Lk810RQiN3UiiigN+5XOjZBlgCIU7Fl7mMn1u0yc99v7yxm4j6jKUHEVVJLyKZbMWThO4cLoPPP8/b32BQ9LWF+a5qEKKY089Sm/wMcHR8XCpNhHLubc3pZ3cGcXizuQovoH6o7ATHbzisUTFM9Vh6recSI0vMZtMBE1LN2b3kmZEuD+lgCUEVsnLdpHvz4EPj9d/tfGCqfitugZScmEuqX06ndCTwKM5JCyeCc7eu70p/1NYQ9XbgRsNqwUNHWkViuSMBmuFmK36beNAdPIID0s8CHyyk0vOVHiSSgN9iYZbewiVC/GOWp71cyCg5o5uihzI5ATW4GcY52QltnhUxx2Ry1Cg/b4aUIx2xywmGqeleg2bD6jf20EJdMg6G4UX7KmTuF2C/tKQFUF5c+grXVC0V22zQgm7LU3Rhts+fANEDnZ+mcej/t/ZT2lcXYWx8bFAHFWlenvE7Lr0FpComX89p0FEXLQ9vDoc6OFsnpBV6ioVy1K+FjLSOHYxz8Ff8efOEdAxatgJp10ZDwf67cQMWNbMPlaG3Y+//uxVahY26FMN98T8VR0lD9sitgkewm9FjiXjAg05aIVZIQPLzJGXZezKRJI4RGYzM6yrKyMZ5w5wnQpBf3PHFc2JzjSXYNiazJhxokBIPG6dkijSBQJt6zRN6zO3PAYIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CV/8gJl6kUXjW8pqkH2Rw66zAJVxISjfksYRu4ymXc9VU8SChUy/TupDatj?=
 =?us-ascii?Q?lkBZhgQddO+18K+XjzfQZNE+tTh7hx9Arul42iIqWZdkYQiQM3H653W9IG2M?=
 =?us-ascii?Q?02o6QZtsdk71/LF2JuyS1nSOQbb/lqDai8a2qZGkjxTn9huT9CJs9k6VY3mJ?=
 =?us-ascii?Q?TCvrhz+RLd2xWaexsHZMHS9yOivDoEYKqvONMeC7aI422C4SW3Be3JF4Qgqq?=
 =?us-ascii?Q?7XVjwJnIc6vIydEa9ZBjucg6CcOe+cLU7vZXM5Nyj8LXYMHkXi5+Q7hm0tW1?=
 =?us-ascii?Q?FoiB7oW4tMfVIeQlFTVZHN3TsC3M+GN1OKVtbSyc+hiV5rPszIKfZKLUveNX?=
 =?us-ascii?Q?NVdmwWGgk8Gpr/I2HmDQTNRdaNzShZkZkUg2pOjUTlK4OG+Wb2gJ/Ukwn0Yl?=
 =?us-ascii?Q?TkoVycxwOlXWQAM4RXT79XOdXmiztUspa6tum2taeHYt2qkRZ5PzHELL0D0/?=
 =?us-ascii?Q?4yvK+JDYl5CQ3WeLPEBCom54qwJePDS2JFMHFG+rhCrkxmNY/+6tg5OcM+t9?=
 =?us-ascii?Q?DI60L+CZBRq7H6Nfy++RQaJiKAuLIxw3je7IiL+zncKU8wkow/v+v0sVtoBR?=
 =?us-ascii?Q?Y+jxjYZXtgqSb8XZtXoWpYEwWHnAbHjisMmvDgZMjcJvCwUIzFt1956NjKN0?=
 =?us-ascii?Q?d8/8pqkR/H/h0w5LYaGRSE4hNT8baGZNHOKZQmngEreS8fOZUHojUTN761dQ?=
 =?us-ascii?Q?maOJZnM/0lvrwXKMwYZz3gDWu5duMwKN1V4u5JqoqkJpOTkZy2iJZTPgyDHX?=
 =?us-ascii?Q?LPbuG+rJazORK+joab4Fp70Fg2ipXKRH6TWJdEKCE1YHhUOXvjmoUKjnfecV?=
 =?us-ascii?Q?84cI8L/DMolvQYcyWg3IGscjAhJPTbkDCjd9qZZXt41VG9QjWSNP/EQ+4Rsa?=
 =?us-ascii?Q?lwQ94klhhedt3TxUxlS49yV88ZGNa3IPxVfwfplUDNE4BKteat5gIiFKMhe2?=
 =?us-ascii?Q?mdZgQabD1j5ylHQ7+RDiLBMH5161IMt0YnOaiE3IH8siYUAPIq6hBFEDhrP5?=
 =?us-ascii?Q?ucnhRYjmmjoEj373JB+VM2l4oIpzltacCdI+/zM69KzoDlbspKIc79KUMqwc?=
 =?us-ascii?Q?otNq5xFm0XE0/I/wEKPkbJk+yqQSpbdcwGLJeP/J0la8/uU5gbLAVFnBSFZX?=
 =?us-ascii?Q?ixj8AZPBZ17PwPwXEJtYTBETibjLl+hCWiemRIADdLRpRRqifJLQTsTBONVq?=
 =?us-ascii?Q?sVq8T2d24Oo8XNpuq7IAza/cruyRuoH52mgkm19vUAeScdphM6hD1yZDUzJt?=
 =?us-ascii?Q?wojuYc60LurWCYblC/Rskrnl+CbsgI5BI3zNtCZ5t+VICBPeo/YC76d4g2vw?=
 =?us-ascii?Q?7EjnySmojupffWYx8As0KlA2GskG8/ODxn8mLLQArf3JNqjIKOZ4BthasOhP?=
 =?us-ascii?Q?t9Ieg2pwJmORZFKm4xU5MuVX/zkXp1WtwvRmyDwDIXtAGNH+wYp4YXvdEABg?=
 =?us-ascii?Q?LQRQP8lsdXaJlW5u5BaixkLe9Ips0t6LYA3hoIetNFzKD4BkOqKPknVhvWKB?=
 =?us-ascii?Q?6qORNtjLDJtADddwLRSrKbdEwM/AscFJJoOcyewmGKyuHE/bAa96nxsRTOJI?=
 =?us-ascii?Q?S9BGdia8BB7PRddaJBhNRYlujOZMdX24SsZDZxkjGHYMJlpQRiZnlMFbtoxL?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ba8743-c81d-45f6-2b28-08dc4fba7ced
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:35:55.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZxhP8G7/AXeulNjUybRHphuZZdVscXbyldDlIOHyzVgPU7QdM2dOqi/ECCQiIv3NzXFDiB4LZ0Yf8xM5Anfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8017

 - In implementation Autoconnecttimeout max value is 16384 msecs.
   Increased this Autoconnecttimeout max value to 20000 msecs.

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index b1339c230..8ce72badc 100644
--- a/src/main.c
+++ b/src/main.c
@@ -656,7 +656,7 @@ static void parse_le_config(GKeyFile *config)
 		  &btd_opts.defaults.le.autoconnect_timeout,
 		  sizeof(btd_opts.defaults.le.autoconnect_timeout),
 		  0x0001,
-		  0x4000},
+		  0x4E20},
 		{ "AdvMonAllowlistScanDuration",
 		  &btd_opts.defaults.le.advmon_allowlist_scan_duration,
 		  sizeof(btd_opts.defaults.le.advmon_allowlist_scan_duration),
-- 
2.34.1

