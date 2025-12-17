Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021104.outbound.protection.outlook.com [52.101.52.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A4136349
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043711; cv=fail; b=I0INNVuNRWqCyw4HCwdx83lKh9zHWwCZP/8whEaySz2ZZnQwrJqjGEiTjIPG3r5ZuEr4V8poVj7a/Zgm5XKwH+O5YezYzkLbwCjHccfQrW5FlERMKtjJb5Fog14r7hGPAXtjfmIexHyblHTBBSBlBx2DgGVyqHnlYZ93WjJBAIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043711; c=relaxed/simple;
	bh=kBzrlLedGInYepbpprr5+merKJTab1mWagxD19AuqV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AVeJBikie1cdPhMOQbw+a6z/mwwdbw1UG5A6DpMHz8TxZwJMK7BnJBJcao/9ABWfyC0blsNQgJqKcA3OKMEzXvsS0R3CJxFceiKeZxuUsrSGJ10o3nk8MXUwYcQOCsdF2UAOC+wMtba9EalL+IvmFOVTF24p/FAp0s2t+qFlxz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=3aC1LD4H; arc=fail smtp.client-ip=52.101.52.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="3aC1LD4H"
Received: from PH7PR01MB8665.prod.exchangelabs.com (2603:10b6:510:30d::20) by
 CY1PR01MB9337.prod.exchangelabs.com (2603:10b6:930:107::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 03:06:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHnuMwFscizUgu/V1j1SyNjbbYkMqDj3nyRl5zZWorP05wT0Pb5rDs2GOvYdIYZp6FLIdPtlG3fQK+nGDdbmqeQsqZ5rxKGdrG7NIqbBcw4vsl29tVrN2/5f/GWmPZVC6ueVHIdSZ5jVKMNWMV3dkIEyqemgQTMaxIBSKdCXGLErd+Bmekaib5QmoF5m2ozKKBkFRmW0Hke+TkTfK/4C+WvmMsJINKDl3G6v9slLAOmid5R+yd6SzkXyEVUrwgbuNPAshRsDJO2jirWEVKvqsLbvutLnanN9DwXWIZ2J/57yrV7aIgk0wAdXRWvGuG6E64401xKxMMtWeU1nMufHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky0wTESARTywaf9d53MhogVjZBzzk8tT7c/rVcmtqss=;
 b=H2nvpLDImtjECzI2nKh/vXgoqwlyFdVV92JV4o3RilQK2cfyz1bti5sm3w1KfcHPpcW9477b2nztHpv5t/wBtEagnOcwiYacpYP2/NKSvNh3gxvwVNW/Kus36d5oqV3+R9ZuoTqDRzpMeRmR6nCP2pH/grzBFOqY2h3jELZNvilkWdJOgyvkZoSod3baA9KnOOsNFOZ5wRJmhsg6sc0aZLL/r62/zw2LM2y5/7cmlLTxT0IOdYk8SOxGLCulvPcS0JhEA0gUlfoxzwutG00ULbdR6mcqR6XkvLqbBLHwi3GK3GiNVawleFW3znI9Uu6AouECymEpk7EFxBDSqYWxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky0wTESARTywaf9d53MhogVjZBzzk8tT7c/rVcmtqss=;
 b=3aC1LD4HOoh0SCIFYFWDdZqvggaLCHD2C5Xft7y8I02eKUF7GgG+JWnr84m2qJ96mQ+3GzUdBmm9mD/6RmDrPZryWVDZoHsKYa+rMw3/fMCkAD+6VJNx3p1mWT2mteJwFqYV9KBGOxR5fEVz6WNYwKdl4I/DFTlXKhCQBIy8PHKqES12ufWghztVUptxtbGZtcVBc1UstwVPkWYaCWWd4KEyCM5zcDL3+PHInR08J+4gVLXAghfpoHJTh0altEAPRaNt+FRdPEc+aPq7q/2ji3OgrihtkEu85eyE5h+FAOBbZ2TjH6tCktvN/gdlmNeY5GX2Ze2nt2xbrSQ8o1NH0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 PH7PR01MB8665.prod.exchangelabs.com (2603:10b6:510:30d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:03:41 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:03:41 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH BlueZ 3/4] monitor: Decode MGMT read/set default system parameters
Date: Wed, 17 Dec 2025 17:02:55 +0100
Message-ID: <20251217160256.441737-4-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217160256.441737-1-ssorensen@roku.com>
References: <20251217160256.441737-1-ssorensen@roku.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:408:e9::6) To SJ2PR01MB8282.prod.exchangelabs.com
 (2603:10b6:a03:540::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	SJ2PR01MB8282:EE_|PH7PR01MB8665:EE_|CY1PR01MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8adf5a-69fe-458a-3c6a-08de3d85d89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?QCzoEd7fa+u9OudFpR2I9uF9jk9QUIJm2R8dt2QzO+B4L8ybLZXL5mFuQmzA?=
 =?us-ascii?Q?GuFw5oQDla7qDWkoThMsrmV+QLvfMJTKREsx2EZE9bzOBrsphv8h4DcWLN8F?=
 =?us-ascii?Q?HpCyBsmCF2U455HN2+kdm11Ha7N3F1IkNA4ORyP0xjyMhtQh5o4U3lHddxUd?=
 =?us-ascii?Q?sW+YTVlUiVSqSKHquMWmcDcVOPt6seGL065SYVfUtTjMrHpfM3+ccrAJt4we?=
 =?us-ascii?Q?alb1IIuyAQJMFFeu+KGf+rqDMyJ9LbBdVeJ6yKHgyDFKELAVmhnrwgJKcBMR?=
 =?us-ascii?Q?Bajnr6qeSzv47h2aLvCib2HYSAOq1FOzoQ5FySQB04HSLWgPb6N+WvjVvet/?=
 =?us-ascii?Q?vsO/SOAF4GyAfkzFtGP9Tp11EbBht5Z76GuhysZKIV4j11Tm5qsEYRgu8TMa?=
 =?us-ascii?Q?KiMwSzNvPoaszLv6lpbhZ8KLFxQaTwUtVktxnVLKtlDqgIyv1FnyIW/ezSGV?=
 =?us-ascii?Q?bsaxx3xjNo2VdzCM+zoeVBV1Lx5WXpYaCYEBtoRM9bvxlyHbqwMM4/NuasiO?=
 =?us-ascii?Q?umEamZ0IP0BTBtR/j2lZfTLl67cyZz4XQN2+unn/hYgZeQ5uFNeM5PkzK8Oe?=
 =?us-ascii?Q?vy75Xj6tMywFQddcblRNUjwOhcGEAoIuZvqnV6K+duS6qlxh6wuUhHfoAf0T?=
 =?us-ascii?Q?Db3kjWWRyB2k2CMXml3zPCgw+igbAe3nCdsh/RZ/XsYVq9pqL39cOMG253/q?=
 =?us-ascii?Q?D1/LtFOOBXcp2XV5xD9SWkAhv3aFfwcAUjpZMPoibX7p4RTKL+WFH0JAU+Km?=
 =?us-ascii?Q?17nJpmWubRny14n5mg2n6LSm/PNSOD1uW7kl/RVtwOr0+58lA82BNkHOk7WA?=
 =?us-ascii?Q?jvA++eGrG8b8CVF3hzkMlfTC2KzHnapJMEFLQ9pe2AUyTmyTzMjE/jFQ66cN?=
 =?us-ascii?Q?mbbWmtnFXl4UKsRJxVXqPYVWEQReMXraZprarJSHJe9u1nIEKMMjkke3oiwk?=
 =?us-ascii?Q?N3gmOWOZPo8k8wfOVANL2nFjNkU2M7rsWHTAAWus0+gMxpv74iKbreBxHgH2?=
 =?us-ascii?Q?qPaQgKKOk4jYD1cBkUJyKU+6aYIajFlOW1urK6xphefK/KENA+8pQXIe4nJ8?=
 =?us-ascii?Q?ANi3PvI+g3ElzUPitNu2i134naCFdi9u834wj9RvUR8svEfrGDur9q8KBGht?=
 =?us-ascii?Q?tmqnFxa8TKHf9sBx2lq1rmEWf3LoLe5pmayO8EwMIxGnQgfzKG5uukDo3q5K?=
 =?us-ascii?Q?qyAMadhvdr/wc4mnZq/nLZAuln9vgJ21V5B+8U1K2psDPQ5NiwAmLwnVA186?=
 =?us-ascii?Q?n1V8AZFvCJJhwUIT5lj6eNuVV0DKbKYZCbDjPtdFBbqp6dCAIN1XYdWmX/Rg?=
 =?us-ascii?Q?0XHN2YjjXYUKTdFkwOKTlOypmU/jkm2xmeCU2deaOI9KCC6O/e0lEAurWT1A?=
 =?us-ascii?Q?OpIsBTlWtKljCqWuAgk4ErHGf/+xFMUoKmmZrXh5EFdKvZZzPg7wOpfxLKPo?=
 =?us-ascii?Q?OGJgzQokATTp2ue5MbVTF101fX4cr6Fk?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?4unJkC5K2afFMQkuXUGlNNZhEcdZ/WjlrbmhBir51eoRQ9fHS3W/V0RFnlIQ?=
 =?us-ascii?Q?vKvkfFL0SGY9t12kck61FjM6DfpS9cKJhqcErelzVq1yg9O6GCtcrsggLQ2P?=
 =?us-ascii?Q?QmLmE3gbaG1ffG/dlwbKMx+uA7daQQhBLKePuAKxJhlq/9ZBcmzaYN8h4ZLD?=
 =?us-ascii?Q?lOKJaoCJjd80cbg/RAvY50MQJOcH4xPQyAACFfaXWl08p3xIFr4hE9fouIDR?=
 =?us-ascii?Q?E5sRwhfDxLaw5P+UHI9IHGKrDzPNobMfpKJmwTrC6RopMg71WeM6BMUJ8PxN?=
 =?us-ascii?Q?vwyBLwtnHUdtX6qS6rP5WrvdjURXKYmbg0lySinhIxLdHDynVAobjbzpaQr8?=
 =?us-ascii?Q?isxYlW6LLBmtu6VN0PbQ30JfMd4A51tTxA/yINLLEBiN+FYA5S96fEELgSm6?=
 =?us-ascii?Q?byqPPqlZTMK8mkKeKdKcHMoQxXtQhGmAhL31AZaLz6wkDfuKDxwvK6Z4HQKK?=
 =?us-ascii?Q?t4J/rg3mMXq12RKE5EymljAn0aaQPvj9HscB5n6M4Rf5ktIaHlYHz1ViTxYr?=
 =?us-ascii?Q?QAcXIGpi59vaSOTlzmEUnvx19SW35WYdCxctR4ZI2FK90U+7BHluaDczYps8?=
 =?us-ascii?Q?DVh0vlBBU3x9G8SNmQi8LAcmD5sKWmP1x0wonnxjnoHNERzfpKzdW0uQ9Bb5?=
 =?us-ascii?Q?0dn7WOmVDDau1r4nW9jO6LPWvoe1iDh+EJ4a7e0SlLphR0DvPVrlaLl1WCJq?=
 =?us-ascii?Q?Crxo17YswD+EX79svvHY8NunC58Xr67CnTEbFhHZit+YLmSyItlHe1Xn/5EW?=
 =?us-ascii?Q?gN5qaoqzyQAS6tk3RLLjk4ZGTlkKV+aZspmZr9c2vt2wigmdVD+26L/6X/pH?=
 =?us-ascii?Q?P6+z4GjPcrDkAN+3ol+PUMoTWnEkPvTbjyyZhh6q9XuP9hzePiNtdsaGG0V5?=
 =?us-ascii?Q?9bpLQ2/BLkYILuN9+fq70wbcShaycDk37ACZMeW682twcH1OgRjM0sjX1iUh?=
 =?us-ascii?Q?0RRedZ26QAvikW0jS3IyG1dO8/74EbBig0oXPHmEV9PTTEYWTRQaZ/0rYZ1Z?=
 =?us-ascii?Q?qiqs72E1aXN7jjZs2UGY2SxvUOYirsPMeLzxnChPtEAvcxqHJLCeaqiDaNhR?=
 =?us-ascii?Q?isI7RCxmIg6j5+mN+jp3TGm9vVskWPCgNl7KLnz9uLOmifgmS9Jvo/X2J9Az?=
 =?us-ascii?Q?CMiPXwEjS6RAiZ0bNUuh0nrn4JfdsvPUEHVIINPkvSYOoHcXfBo/KZpwRoBz?=
 =?us-ascii?Q?cypE3UZbisYbF0Ax55OeDZghJO0CNu9DVAReqxKsmGo0GvossfV4J+9QGDSN?=
 =?us-ascii?Q?Ou4pzN241Hsay7ijU4VZfSV8wRIby3/BeNEkIJMNZqbfkyklx8OOv8aLb9Q4?=
 =?us-ascii?Q?yvIOxdiqFCIDu6fUcFvMoZ5UwWWbntDPsQGlksEQOfegvD8Q4iRPhhKoxVrV?=
 =?us-ascii?Q?mV8LeK3ZUwsrtoN0Nt7Q0HjgCARyqqMijhKyNPgIw2ekOokUpv4ssJ5xx54l?=
 =?us-ascii?Q?hm+Af2GMwQ+avvf7kycKFVYBM3HgQByjDSNVgrAenqxAaZVdNREpE70DGOV9?=
 =?us-ascii?Q?uw4SBr10bhnlqDpZTEs0eV/W+dm+E+Kb/Qw5P8my7sPHe+R6QE9hwX8kGeMC?=
 =?us-ascii?Q?VZ6mKTu+eHIy2miiGZ6Dl/uC8jEAB1LL4KoVMiF7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8adf5a-69fe-458a-3c6a-08de3d85d89b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:03:41.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5x8JbJreFtDEIevH51Y2w4qCdJVTZ33c+sKEnSybQiu46QD7IaZs22+u4R8MPD0qYQbrkCUgeO3vohKGt2YfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8665
X-OriginatorOrg: roku.com

Add decoding of the payload of the Read Default System Configuration
and Set Default System Configuration MGMT commands and replies:

@ MGMT Command: Set Default System Configuration (0x004c) plen 15
        BR/EDR Page Timeout: 200
        BR/EDR Min Sniff Interval: 50
        BR/EDR Max Sniff Interval: 200
---
 monitor/packet.c | 116 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 110 insertions(+), 6 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 254fe840d..bd316d842 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -32,11 +32,13 @@
 #include "bluetooth/uuid.h"
 #include "bluetooth/hci.h"
 #include "bluetooth/hci_lib.h"
+#include "bluetooth/mgmt.h"
 
 #include "src/shared/util.h"
 #include "src/shared/btsnoop.h"
 #include "src/shared/queue.h"
 #include "src/shared/bap-debug.h"
+#include "src/shared/mgmt.h"
 #include "display.h"
 #include "bt.h"
 #include "ll.h"
@@ -14683,10 +14685,6 @@ static const struct bitfield_data mgmt_adv_flags_table[] = {
 	{  16, "Contain Scan Response Data"		},
 	{ }
 };
-#define MGMT_ADV_PARAM_DURATION		(1 << 12)
-#define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
-#define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
-#define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
 
 static void mgmt_print_adv_flags(uint32_t flags)
 {
@@ -15994,6 +15992,108 @@ static void mgmt_set_exp_feature_rsp(const void *data, uint16_t size)
 	mgmt_print_exp_feature(data);
 }
 
+static const struct {
+	uint16_t val;
+	const char *str;
+} default_system_config_table[] = {
+	{0x0000, "BR/EDR Page Scan Type"                              },
+	{0x0001, "BR/EDR Page Scan Interval"                          },
+	{0x0002, "BR/EDR Page Scan Window"                            },
+	{0x0003, "BR/EDR Inquiry Scan Type"                           },
+	{0x0004, "BR/EDR Inquiry Scan Interval"                       },
+	{0x0005, "BR/EDR Inquiry Scan Window"                         },
+	{0x0006, "BR/EDR Link Supervision Timeout"                    },
+	{0x0007, "BR/EDR Page Timeout"                                },
+	{0x0008, "BR/EDR Min Sniff Interval"                          },
+	{0x0009, "BR/EDR Max Sniff Interval"                          },
+	{0x000a, "LE Advertisement Min Interval"                      },
+	{0x000b, "LE Advertisement Max Interval"                      },
+	{0x000c, "LE Multi Advertisement Rotation Interval"           },
+	{0x000d, "LE Scanning Interval for auto connect"              },
+	{0x000e, "LE Scanning Window for auto connect"                },
+	{0x000f, "LE Scanning Interval for wake scenarios"            },
+	{0x0010, "LE Scanning Window for wake scenarios"              },
+	{0x0011, "LE Scanning Interval for discovery"                 },
+	{0x0012, "LE Scanning Window for discovery"                   },
+	{0x0013, "LE Scanning Interval for adv monitoring"            },
+	{0x0014, "LE Scanning Window for adv monitoring"              },
+	{0x0015, "LE Scanning Interval for connect"                   },
+	{0x0016, "LE Scanning Window for connect"                     },
+	{0x0017, "LE Min Connection Interval"                         },
+	{0x0018, "LE Max Connection Interval"                         },
+	{0x0019, "LE Connection Latency"                              },
+	{0x001a, "LE Connection Supervision Timeout"                  },
+	{0x001b, "LE Autoconnect Timeout"                             },
+	{0x001d, "LE Allow List Scanning Duration for adv monitoring" },
+	{0x001e, "LE No Filter Scanning Duration for adv monitoring"  },
+	{0x001f, "LE Enable Interleave Scan for adv monitoring"       },
+	{ }
+};
+
+static const char *default_system_config(uint16_t val)
+{
+	int i;
+
+	for (i = 0; default_system_config_table[i].str; i++) {
+		if (default_system_config_table[i].val == val)
+			return default_system_config_table[i].str;
+	}
+
+	return NULL;
+}
+
+static void mgmt_print_system_config_tlv(void *data, void *user_data)
+{
+	const struct mgmt_tlv *entry = data;
+	uint16_t type = get_le16(&entry->type);
+	const char *desc = default_system_config(type);
+	uint32_t value;
+	char buf[8];
+
+	if (!desc) {
+		snprintf(buf, sizeof(buf), "0x%4.4x", entry->type);
+		desc = buf;
+	}
+
+	if (entry->length == 1 || entry->length == 2 || entry->length == 4) {
+		if (entry->length == 1)
+			value = get_u8(entry->value);
+		else if (entry->length == 2)
+			value = get_le16(entry->value);
+		else if (entry->length == 4)
+			value = get_le32(entry->value);
+		print_field("%s: %u", desc, value);
+	} else {
+		print_hex_field(desc, entry->value, entry->length);
+	}
+}
+
+static void mgmt_read_default_system_config_rsp(const void *data, uint16_t size)
+{
+	struct mgmt_tlv_list *tlv_list;
+
+	tlv_list = mgmt_tlv_list_load_from_buf(data, size);
+	if (!tlv_list) {
+		print_text(COLOR_ERROR, "  Unable to parse response of read system configuration");
+		return;
+	}
+	mgmt_tlv_list_foreach(tlv_list, mgmt_print_system_config_tlv, NULL);
+	mgmt_tlv_list_free(tlv_list);
+}
+
+static void mgmt_set_default_system_config_cmd(const void *data, uint16_t size)
+{
+	struct mgmt_tlv_list *tlv_list;
+
+	tlv_list = mgmt_tlv_list_load_from_buf(data, size);
+	if (!tlv_list) {
+		print_text(COLOR_ERROR, "  Unable to parse command of set system configuration");
+		return;
+	}
+	mgmt_tlv_list_foreach(tlv_list, mgmt_print_system_config_tlv, NULL);
+	mgmt_tlv_list_free(tlv_list);
+}
+
 static const struct bitfield_data mgmt_added_device_flags_table[] = {
 	{ 0, "Remote Wakeup"		},
 	{ 1, "Device Privacy Mode"	},
@@ -16574,8 +16674,12 @@ static const struct mgmt_data mgmt_command_table[] = {
 	{ 0x004a, "Set Experimental Feature",
 				mgmt_set_exp_feature_cmd, 17, true,
 				mgmt_set_exp_feature_rsp, 20, true },
-	{ 0x004b, "Read Default System Configuration" },
-	{ 0x004c, "Set Default System Configuration" },
+	{ 0x004b, "Read Default System Configuration",
+				mgmt_null_cmd, 0, true,
+				mgmt_read_default_system_config_rsp, 4, false},
+	{ 0x004c, "Set Default System Configuration",
+				mgmt_set_default_system_config_cmd, 4, false,
+				mgmt_null_rsp, 0, true},
 	{ 0x004d, "Read Default Runtime Configuration" },
 	{ 0x004e, "Set Default Runtime Configuration" },
 	{ 0x004f, "Get Device Flags",
-- 
2.52.0

