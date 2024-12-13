Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B51DED5F
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089493; cv=fail; b=SrF47KoRiINqnXNgV/b+ACWJZ1FO7oNqCYwsafiM9v9ekvUPPnRj7eoatA69eMingtLABnkBJo4cKAOAxe1ldeAvPmdn8aRqCG0NagxP9ITnXEjK7L+Y/RC0YZ4uAUUgaPY1bC3k6x7LAAJFK94SSnbzLDexT/KPrxAT+KgZZGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089493; c=relaxed/simple;
	bh=2xQUuxNZQaQaPrs1knFxfcqRmTAYeud4gmxA2Fm9JVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jGjgg29I5RyKqx5qxfk20zMiHT57M/k/Kg8GBIcjsCzDWaz/WlthKS/PC8UkvroHkzJf2gbY6kxnnx7a85iNkhcdeRJ4j78WyVx8dukI1LzgxgLnSa4UAUeAaHOlwlMjLNn6IPgwydWiAwvnitF4g4fznV2rENFCj6F4RMZYklA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W03ebI4h; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W03ebI4h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpmNF2t9g4HGGIvLzh1/VfC9w1svl4Pp0QIpHV3i757JUr05BXK4LTnbUZEjEA89hDDZzps8uIYts7knNStw7uKMq9Vx2dCKAbnfu/0vZnslwV4oyOwkROGxg/Ho0ArmY728KR3VzufjwnTVxcvciHA+RkOn6pXEiv/liD2G4nRgPP1jR56oiRiysdb8jjxJrd1ftx7Rmo56XAZtLugQrjMtT9d/EXEB9ISyJ8taFf4OPqkZyJYPgKdx3l2Ui5Xmk4Os1zht+dWFyotNXI2/kMTXqWn1LN0DvCThhgeifsb++FPZzzCE+bTR4/qvZF+HewRFfDCrjwkynuCig7hJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+6VRUWGiu/cS326gn7fV3x8ujgPt1opgGiaHTSIFpc=;
 b=iU1Sxi5cY/qdXE1+mbeKq/twydhYu73vUz79H26+ibrqdSI8mj6zLYWNSnQtWUVegQSPb7+M5IDFAUaem6EyvlBQNmelG+ZkOuokresPBagm2y0nUeqLzNelCW0J3Q07HBWXQpEPyYEGcqNPOpYusm3N3dZrHjmAtIzihGu5/KFUuEojagbbwRsO5fM6kgxLrMRTPtJKxuOBqJqej+P6ntgkaM1OZ5XvEdUGUeat2BJvBP54PkswAyrtwUjATn1wyDvSsYyEdL2zDYukS27gLWJFtrWtI6cABup1++dP4W6yRPOO0psW1On2noy0Os4LskYY5xqSP1lUjl09WmW0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+6VRUWGiu/cS326gn7fV3x8ujgPt1opgGiaHTSIFpc=;
 b=W03ebI4hsFlSmbQfxdIX0/+WsM0Dl49qyPRywMvh70RpgtrM//YtrdosHUqVZ/GpYVAdRJfGERUW45YT4OZasbGb/ONs/wjj3eOwQewv2vYLIPrI2RBOe5ucbnbzo7MEExmz6aEEwfuqyE+sccyuIHiZtgnFR4GESUVPL2Hf9ksegQDWkC3DqoZsmm5qbo3kM+QgjuISQtg4gYqL+PLkifzB0bjVaEtAUevjyca1fl0OvT9i9FBLPq/Cy5MFFtnL59pG6J+EFNvLGwf7IgJOI2WxVJyec7cMrnJ97EOvortFqE4j4ZE8TxhgrRiQIfIaI9W3QaxqVH4hdlbbL3j6Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10438.eurprd04.prod.outlook.com (2603:10a6:800:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:31:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 11:31:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] lib: Add BT_ISO_SYNC_FACTOR
Date: Fri, 13 Dec 2024 13:31:11 +0200
Message-ID: <20241213113113.64818-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
References: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0023.eurprd03.prod.outlook.com
 (2603:10a6:205:2::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: 08701339-9994-483d-090e-08dd1b69af2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4Wyz5aaZkH2Rxm/34xindAu5v+mRHWvFDVaOGi909PQCY55YIi8+xWA5p1V?=
 =?us-ascii?Q?Bz1MxpW03t0HHof5CWtcnxs+DeKpzyrQN8ZevX72XW+KLc0HX67E90IATdd2?=
 =?us-ascii?Q?6qZxXVEtVmw5hzJysgi64fMcSoWHSHadEJnDMCYzjFHoUci5k2yAYZYe6pIt?=
 =?us-ascii?Q?zsnfnOJ0dD+razEbMctp85r5MiWevjrDi5UX3RsiaxUOObj4Uae+MChvYJN2?=
 =?us-ascii?Q?UjSiDPpMXjJWURcX1FQgTHTO9YRy+V4m5CVL6+kdWSg3ha+SWbws5+twDZMH?=
 =?us-ascii?Q?ffUSSj9G/17Mpp8418o+FhPNNidhEtqYYcf2n8C1oBHZm4w8Vo9Ha2fGW6ZV?=
 =?us-ascii?Q?/ThHNA53vKa668vNPIbdSuWhwm4l9DhO4zNrQOrMbC0tKf5bohVWxyfbjk79?=
 =?us-ascii?Q?9hO4litNZU4pO/ApPSrrYIHAwy5jBNZvFrgu0I1+os8gfqPAovaXpqhJVXGJ?=
 =?us-ascii?Q?AllYg7TpbjkXVDq2abekUzQrLOPHu8OJ9sRIzS0l6g6qrlsU8t5WBJhbxUg/?=
 =?us-ascii?Q?yQAfVHwIuY6YBboZkoXtXR9GXlx/jS2PJaSe1rnRmt86NAN/3gz1nBX7ooTD?=
 =?us-ascii?Q?a7SIiVr0Y1ow5o8ycqSKoznCLdNq/vUhQ8z+8mk0B1kB62nwSAcb84TtVuXm?=
 =?us-ascii?Q?F83lpnDWjdr1DZKmj/YwdMhiBu8NQPvFOQes4d3zgmPRCvOw0+rrO5Jfwngx?=
 =?us-ascii?Q?29xn+xY0gJ3RquKJtVuwCzB/otcLSKhEK8TBYhHPZGW36gV75CaTfVsXb7Xn?=
 =?us-ascii?Q?xoEf+pxxGYwwinLtylmG7QqYKuHwbck82GXTDJujKBOWC3bmpew7P4Qtqsa+?=
 =?us-ascii?Q?UnllAMK08+SlCGAIa7yYPQ9nFxRly9CUATAHW0LvLFEpkbPYA6/o9hVBr06z?=
 =?us-ascii?Q?QqF4TMl5XUKvpn9a+q8fN52bzY+xrSrTpQM0AL+aj4nKcO94dsS4X3ny4/g5?=
 =?us-ascii?Q?EJ7BStn9jdZIN5orgMal6KR++QgUhzpZ0wUxdZ4u9bWwtAK+CRxXCokFKZy4?=
 =?us-ascii?Q?okJGMNcNWpweWVs2wb0T7atMQSYFyWYvGqL88y2GgUlzjicouB1INn1i5Jqf?=
 =?us-ascii?Q?NhmXwARVYfaGXo/0mgygF/N/XvyyhL1mA/czBvugqe6R+tHUniLTtG+OZQcz?=
 =?us-ascii?Q?uBcxXQIE9L8Y0dQTZPJuo7k10isnpf66W3NFe7wHKL922TVojTyFZZo6jne/?=
 =?us-ascii?Q?yyQ75dhYh3ET5CHgf8PWlropckL2rhrge8GOVB3aZ4pzMcnmQLatbPK2WG6p?=
 =?us-ascii?Q?VMQnWiR9dkrpc3R2o6dxlQJVjWT1tOg1ln0tr1F90lsdo//AyCVBS21Awn1x?=
 =?us-ascii?Q?rMGF/xDuygfnpweFjEcsagDrJz92HPxU1y62jTvCWFXXrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKC48Uh77y6IY12WHJSdilvmVSXKk6SGiLbXkMz2jdiSLkWnUYSwf3FRjMqs?=
 =?us-ascii?Q?aSiizRG4snxI+5adskmNaGMc3nOPqug9zI+GeKNx7joJPKFDUWLxkX/YiFTT?=
 =?us-ascii?Q?upNw6sUYclcYzOpZuK2nDsCKKArAn2rD/es+mT5x8b7N+nygHdVVl5N3JgdR?=
 =?us-ascii?Q?PhBlL0rU9Yk3CgQ8td4Sr29snAbrw5BrymkEVN10c5YUXjnx1jA2eZpD5C7D?=
 =?us-ascii?Q?+R8pbg9rDIGdznuen2iu3l0b2S/6UMcJ1KxPe7bDPNdvbu/yxm3Pu3uQtr1T?=
 =?us-ascii?Q?4tq1z8xCzoAfGSzEqrhL0zHkdnXeBAQ5JSV4WBPhe6WsOBFb3tWbe9qqDZZR?=
 =?us-ascii?Q?RLPW2S7J3ZdmkFYi3OBtCg3638fJKej41YeAeAlFX8Bs+A16ml8Kfyif/j8n?=
 =?us-ascii?Q?UWE4dAAVoYfDL0fH7JASxdeOhDnqFao3n/uwJ3BXNYcOLzu3vzMbpJWnKaW6?=
 =?us-ascii?Q?Jo3+W1dYXpLv6YFAoUBU2QMWSYAVI5u4zUyTDiQmQchtm+y14qD5pm/RAtiz?=
 =?us-ascii?Q?q/SbPhGl0IXYkhC7HCpPxrEZMsK2A6fan+879F1S1z9SXZF2xLEJ/sTf+J/I?=
 =?us-ascii?Q?uA79gBbCy2LTwXanC3pD44PcsffOeeTBGJ2SgiucE73ek/K+LZvDI++s2Qsg?=
 =?us-ascii?Q?cSTP7Dff8uZietbyARded2QCe5CyIrRIY2VB9ZigBUZeHpvH8JODdcyntALa?=
 =?us-ascii?Q?Zc4y1UYROLFJsf8hXjubOxnSyF5kEQGCIUJSWeHRvTE1PVP0hoGLQJxgoAqm?=
 =?us-ascii?Q?o2i0f3ZhyrDkYxI1XplbTIw63epIHRYa0PnGFwhWMbOtrsoKS/UhjzRUUQJr?=
 =?us-ascii?Q?136plCazQ7xMMaajXk3H/4LE98Hchh5csYeriYPtDJ/tO5kHUCI65bZR8f/r?=
 =?us-ascii?Q?6ER9BvKO7uH1mmsq5s7lor1A6nmG3XdmoB7xdGCk0WxlVn3J1EJX7YQjOAx7?=
 =?us-ascii?Q?PCFvJr4/KXF/2zpm9tAe+o+en5oYQHoW+NnBHOdXZSzfAbYa/mG76KtZeQRk?=
 =?us-ascii?Q?4heJDIwbTa+TXnVs3nhJdrYXelK/m+YqZz0SXT3C9VT7r1IO/+wqTL8bdaO9?=
 =?us-ascii?Q?syYUu9brT3ucd538Y41WwN1N37+mFW1MfonqhLOT0SWiEl3b6eOjR9K8e7Zc?=
 =?us-ascii?Q?HTALvIkesWLr+zSlEzTXPI1pKn3kawkuicwUpUNb3xNZ/a+4lKs/1RiRVH22?=
 =?us-ascii?Q?ku+21hDg8+XmvfrhnBS21L+BMXZZpcMUrFcVMq+iTfFgCkQdnqqwiLjKB8tt?=
 =?us-ascii?Q?L2v3Zwz+eWibrIYqQNJbBfoQuciRCDQMjSxcf54+aG2e5Gp9a3MIY+tdnLKb?=
 =?us-ascii?Q?1Q02UjrtxjBHasMrhnbbgC1iRwfzpHEMFIqVcIgTcj9V7qNdDD2WweRLGogH?=
 =?us-ascii?Q?SnSE2Hsqe/eE7BWFuDn2p4d+WOplLkTnVzsMAgkLzS0/GJGi7UFy1lXuulmY?=
 =?us-ascii?Q?M8+xl6U09hkYZWCfxv1DVWc/CEmn8Mn/n+KT8jwyOZpfq3+hReOIySTV3MaX?=
 =?us-ascii?Q?5faYPECwSnqNljUBxfRICkvCFGb3yS8pw54ImwWMGBxHf81RyLV7VivtWvqR?=
 =?us-ascii?Q?HcodQRDhsoNWNr2b6uJH9Chr3gYpK5YJZL6pqt2OopxJZyMiNcfe1tBaG7gB?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08701339-9994-483d-090e-08dd1b69af2a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:31:28.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F0jnjuk81YKVYS4mnuhWdWmBZ9FBFbPHQdrE4dK//RSFkoirfLl3vDPsXduIVQHgu7KMLwP3gSZdKsarVtsqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10438

This defines the default sync factor value to be used by ISO Broadcasters.
---
 lib/bluetooth.h      | 12 ++++++++++++
 profiles/audio/bap.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 073ed875d..ea9adb83b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -153,6 +153,18 @@ struct bt_voice {
 
 #define BT_ISO_SYNC_TIMEOUT	0x07d0 /* 20 secs */
 
+/* For an ISO Broadcaster, this value is used to compute
+ * the desired Periodic Advertising Interval as a function
+ * of SDU interval, based on the formula:
+ *
+ * PA_Interval = SDU_Interval * sync_factor
+ *
+ * This is useful for adjusting how frequent to send PA
+ * announcements for Broadcast Sinks to discover, depending
+ * on scenario.
+ */
+#define BT_ISO_SYNC_FACTOR	0x01
+
 #define BT_ISO_QOS_GROUP_UNSET	0xff
 #define BT_ISO_QOS_STREAM_UNSET	0xff
 
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a561c446a..f382b43a5 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -847,7 +847,7 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 		/* Mark BIG and BIS to be auto assigned */
 		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
-		setup->qos.bcast.sync_factor = 0x01;
+		setup->qos.bcast.sync_factor = BT_ISO_SYNC_FACTOR;
 		setup->qos.bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
 		setup->qos.bcast.timeout = BT_ISO_SYNC_TIMEOUT;
 		setup->qos_parser = setup_parse_bcast_qos;
-- 
2.43.0

