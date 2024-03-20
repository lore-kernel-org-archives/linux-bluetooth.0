Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E198592E
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968643; cv=fail; b=ageE+2RzfWz4+4r5rD6q57ojwY3F8zt5keHb99mbcJdeS0R5QgOCWCwNNbU0evbGO6Q1Mp5KGcpJ91rQEm7iUslSV4akWpXAYXy4AmygBKlKfv1yCt4TNVeHQ9PssHg4CyZOB7PN+zGAG9XpBabiloWzgs5u8/Eq8gGbcCXhNa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968643; c=relaxed/simple;
	bh=6+fC/kS81bmBdf48gnRFVeckXcOhosjZ1R/EOPVq53c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cUa/3IGTwXg7Hj/FaflvhUy2rtUQ1JATv5+XwPsbaE0UMPTW0dUERqqhLZ839+TCxrCq6CdgtzPavg3AN5XHXfQXxRSevMayiATDEiz1dZ3pEwDjEKoqgXW3IuThglTtGRm4KwoffLWMQBcGKU5NNBVkJ3fe49wjqMHPKM2L+Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PJfFF3+O; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PJfFF3+O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9GdYBwz8tou+q7afEUxPQGhPWw1sO34m1nylUyac/hX0jeuwZeht3mRHXfJHar/AJzZEEbRd93VcvVhIr/s92Inm2/jCg0oInD4GpjBqYWjzfaU7Hfi5WTrwg12Qdvu/VF+MHtW17G+9jXytcWYbEenWAlCk5aTtbd8q1GAYp6GxGVvCppFzzn0aIU+0uWaI+Sslb9eJFaOpkIe8qfr0swRgo6D0K1LSjYyDlTkbBBfyU9qwZa3HqE7ob9n0FOpXYJ4EOAQwm4HQGCdN4Q2z+qOgghhyoXc1/X94BWWBy29O2vA8ggc+8ikPNOGe1CinGdk2zQsETRWiwDUK11GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFab84SpAoX6ftJyaUl8qq7ooyh+DKn6uSmjITiRxNI=;
 b=fLsiXIRR/h+FQfpp/I9LOzGisHe0P7zb3hHldGc/iNwxZhZsh4iRozaiCVRnPsJixZ0hKDUdHhqt9PpeLfTY+26ArUYsgOXgl8jYRLSF35yhnZNM9RmjD5KM01TgM/m0odWZXW2Jh13WmKmSLe9Lz//QHMgpMJsNVAULnooYajOZLavKRu0LTUmW0YzaZ0ugTmbkErqdtWd/O5pIHeJIxP3LM55wRsrCcLrfZEoPh95DLhbDPgEoa4HRDZ+uQo+fvVzCC2MqO8PQqu4ryQrybz5hqwWdAOpbRypjVFkDKygbzQTwTk0AcUjfGvTxbsyKxj6ESuVjjOY4iAqICeN03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFab84SpAoX6ftJyaUl8qq7ooyh+DKn6uSmjITiRxNI=;
 b=PJfFF3+OiK7WFwskTvrKwGL8CJuZE+5CfLvtabSf6QfHTTYmtK/v9BeULM4wYvZTp2ZpjgnCzL1CDyTCNR538CKJOzoRbtYU1cP75Bu4PsQnbfkx+o+Uuis1fL6t03lDN5iyJlJ4+HJi3augsEY3H/8JNLl3TE2jtmMsgye7uIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM0PR04MB6931.eurprd04.prod.outlook.com (2603:10a6:208:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 21:03:58 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 21:03:58 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] Fix crash in iov_append_ltv function
Date: Wed, 20 Mar 2024 23:03:50 +0200
Message-Id: <20240320210350.101941-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320210350.101941-1-silviu.barbulescu@nxp.com>
References: <20240320210350.101941-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::43) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM0PR04MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: bd34e805-6a6a-4188-2d60-08dc492142bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iGMYfmNBhKPK1jGJeVutP/FylfVwpYTycTVTLAZrcup0ZZOi0ml7E2D77Zq2ycL84XRc5eTdeoLHpnYVDFX7CB0Y4sLDh5QTRCWIohm/5Vyw3jcuh0OSM/fvFnTS+QemFMEAKcsaQ5mT7o5dzOBZ9/mAq8u3clD6XGMw1eCwL3eB+moPTkkOyvYtRYvSqQ8GsAxf7PdNMDXMtBFdhYu2hm5ukni3pXYC8yYDDUgqR1e2rKamfYKygoWxMcykDZpODu+xNQHXwmpqVG3GDzzbDwbO6RVZQVkK4sWCnDIo+UmR4GlaoN2wzJqDgJLBeq0Yc4xIV7RqytgYBjuaTNs+EC5cC82u96F7mlB18DhjokFtM1Tc4DB4E9fQrnaB4zFcru+RPmK2ivnktaamMfATgAJgH9/K4kosZLgx3ytzJW3tdM/V98CvRyoDeO7fjPKrvWEy369AYkubqYwKHfL5NZbPj05krYPoy95/3sG/Gd+BmyRAKsX7L2JXutY30P/+QWnGmU0jx9S6N7aiXLPkAyBqfGCQScgyDvO5z2+EnLFSebLkJHs06yZ6mGpmxUjGVOjmxCFTFr0/yWks4l9GRup0a4LGAxqDv6V6Z5kw5+8niazYJc75VC7ooHFXXPOAzUSiVdO4R34cZaFDpjFLKTGTTgxP0VZBQ48Bm0qo8ss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJy3bpg3WnmWt3HNXdkJNULcBuZWV/eCq1bwD7qOXA1oE3PYjiYAuK2axH8I?=
 =?us-ascii?Q?7SmRw7Z32HRIoUYzyJ2hyvLr0nAEExPhjiX2PH62EfttrE3EeulhQXaZ3G7v?=
 =?us-ascii?Q?3iJ8H+OqHkdHtacgE3FMsiHJ5j2285HELMR2yh2fV/NzeMbDhGG0zKLNrSOE?=
 =?us-ascii?Q?Xq0IQ95GCkl0vIj85t2aorcw9O7p8B4QmFlKmwbjM5ExL0MtmgNbNbObqqSE?=
 =?us-ascii?Q?BsFa7q1P3YSmqGLtdlpSrjA94D/cSPfj39IFbNVHhgMEiZNx67zBVmnk5fr1?=
 =?us-ascii?Q?nuWT8KOuHv3atbpX1FBrQPGScZk7g3RBT7Mp3RXCfRSDBtjIciHwD6YTjySk?=
 =?us-ascii?Q?21OztuQQliAJnGASaLCA/D3iG059rwb9zBmBH0OT7JyR1a8WtrcotvndMzhr?=
 =?us-ascii?Q?MOGBE+An30PQ/Ty1H6DYxKEZ0IKaAmQTvZXeYJVk0RBXNFujiebjgkU+yCl3?=
 =?us-ascii?Q?EQKJ9FOePPpCflrr3/qc9hiahWfN5xjQ/MoXS3IdgeIZuDjOCk1+HpOimnVF?=
 =?us-ascii?Q?m23kWTnr8YfiZHKQ6PytdlvE2shQPv+lUth6qMYsc4mt96lkjuW8H7+SVGVt?=
 =?us-ascii?Q?b4AbAF98a5FnJgH3yrFaNa01lE4qLNMoQ3DLMQWPP7yU4YxzKuwdjAmYnudt?=
 =?us-ascii?Q?fxZnhDd3BdYxwOBpafhAUSyVEYhqe/ZNQX3lAIhIm6dLimP/zNccK2Ht8MWb?=
 =?us-ascii?Q?W2MF1Udy6lLeQA35MtHSC62jQpz26hEYL/eukRwAIn4DxiYgC7Ms8dQe9jpK?=
 =?us-ascii?Q?g2pMOEaeJnlEfWoG/+lHhOcD9VvsukNhnM5aVzZT0n93aYNEFThgI8pSidrI?=
 =?us-ascii?Q?ahNQirZM6ixPPvl50E9NNQl3ngvZE8/X0Pwz4XHRjccLbGqqJixQKrd3Bfcs?=
 =?us-ascii?Q?DKTYDhAwkws/FtZ5d/E4bkMAs11b/ndlj5ytoA8BIgpNtFNbQ8cqCKd1FNV+?=
 =?us-ascii?Q?fSjs5Vz47H4jRG4aG5tPuuS0Y+qt8zR3AH97chgMhTUUY3xpELP4AroUNN4E?=
 =?us-ascii?Q?2r3ye3deyXcjC8GRNGob3ciw3Sjvr7OYd2zSTOOnIIG8nwGm9o8ToRGzKaKF?=
 =?us-ascii?Q?MNKCfPEkZrWK6STprI7byLS1nzJnBXzJkGNhHblGY76qrRLXVHfYSvat9pcd?=
 =?us-ascii?Q?YVQ+3WwroZO7/b5L+kfIG+FtI9W98gh3+XwP8jJ6SrRcmJ/QhNnrcKpnES93?=
 =?us-ascii?Q?MLA75W+pFlB0ipr+WOa3jRcHVq7GkaFAqJ7P8BWvQqeYAZ9vqWayDe8+22z0?=
 =?us-ascii?Q?i5UJnjhtmWrWT/YSKSrL83i3cffRBZLj6Qg3NC4+pARiS434ZVRSKuu9p124?=
 =?us-ascii?Q?UEfO8MNNX9RRmJaRN/PUn7EVCiXiaTxtc3I24gW57oy4hdKMOXkqOQmluyZy?=
 =?us-ascii?Q?hfabpLMwUnkc1X1n+hR45Po/x9nL3U9oIKXNbA3K2ywUhSSKZG98ZVBwQP9A?=
 =?us-ascii?Q?aP/uXynJEOPofDjjmMWL8bVZW0RbJxCx8rmmPL0ARoU153AjGjLv75K6F/cL?=
 =?us-ascii?Q?iM6Q20qu5ypWyJmB8ZzaTcNPb9w/r09eEYFKalUJ7YHTAQgqA0i7geoJ87MN?=
 =?us-ascii?Q?goJkjSP9/x8Ye6dogmwEFqvCvPqHg4WRyd64yNAvbtEw4jh0Xo14J0TDUU01?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd34e805-6a6a-4188-2d60-08dc492142bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 21:03:58.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyacFy4zWusH8gGF6hwIH0Ys8rwJWGFCBGnvGg3nmONPrqRpeSjE+1AQ0Hyfok9ckMkxv4fhWz0yDehYtcGkpnrXhr5KHu/bpAPa7yYDgco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6931

Fix function iov_append_ltv crashes because is not reallocating memory
Use util_ltv_push from util.c

[bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
[bluetooth]# Endpoint /local/endpoint/ep0 registered
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 3
=================================================================
==80806==ERROR: AddressSanitizer: heap-buffer-overflow on
 address 0x60200000a8ba at pc 0x561971611e0e bp 0x7ffd45ab1f00
 sp 0x7ffd45ab1ef0 WRITE of size 1 at 0x60200000a8ba thread T0
  0x561971611e0d in put_u8 src/shared/util.h:254
  0x561971611e0d in util_iov_push_u8 src/shared/util.c:534
  0x5619715c28f0 in iov_append_ltv client/player.c:3565
  0x5619715c28f0 in config_endpoint_channel_location client/player.c:3593
  0x5619716226ce in bt_shell_release_prompt src/shared/shell.c:744
  0x561971623087 in rl_handler src/shared/shell.c:769
---
 client/player.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/client/player.c b/client/player.c
index ab33bfc46..d3ff15adb 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3553,22 +3553,6 @@ done:
 	endpoint_set_config(cfg);
 }
 
-static struct iovec *iov_append_ltv(struct iovec **iov, uint8_t l,
-					uint8_t t, void *v)
-{
-	if (!*iov)
-		*iov = new0(struct iovec, 1);
-
-	if (!((*iov)->iov_base))
-		(*iov)->iov_base = new0(uint8_t, l + 1);
-
-	util_iov_push_u8(*iov, l);
-	util_iov_push_u8(*iov, t);
-	util_iov_push_mem(*iov, l - 1, v);
-
-	return *iov;
-}
-
 static void config_endpoint_channel_location(const char *input, void *user_data)
 {
 	struct endpoint_config *cfg = user_data;
@@ -3587,7 +3571,7 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 
 	/* Add Channel Allocation LTV in capabilities */
 	location = cpu_to_le32(location);
-	iov_append_ltv(&cfg->caps, LC3_CONFIG_CHAN_ALLOC_LEN,
+	util_ltv_push(cfg->caps, LC3_CONFIG_CHAN_ALLOC_LEN - 1,
 			LC3_CONFIG_CHAN_ALLOC, &location);
 
 add_meta:
-- 
2.39.2

