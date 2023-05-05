Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46653C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 08:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjEEIcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 04:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEEIcP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 04:32:15 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A518DC3
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 01:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5vNMLWne2dnz/szezrWRspGYKqBOMbAsmxxOw01bcCJRBW2Ov4VOpz8M0E7hCExoizGuUYDPlvbAF4qyIRZugsCZdhdGfcFayZ+H8OpBBVNSuP6oezHl/HMwMh6jN5wdX0Wl5z0BhHqqzQrV9OmrSjQhPU7Ddj1H6BLrSFUQReZWnBNKig+Rye87T2XfXCK43giLtIxYwdIUiyaov4KZX92XyjJuIdpyRDxT8XcBeonHI3Y4sWyqMxn2eGXXl/RAOOALUFbyyTJgZmGqcdc5/MAP8zjXLDK5wSdibbwiqArhbU+OXO9ICqu8N2Vam2+sZ7IMnLbPkGi2g1Qocp1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUxK6Xl5KFDUyCR9bSXzDY1SgDCIv08OlXJE/3mET7c=;
 b=NXOLqliMgI7QCnWLpof0RMyhzPXTdGXVfzLPeG4MQ1PVcPZS2sM4mBKvw0fN0BHQnqjlBPvbR41W2iOnelFuxIhSMGZskGpDm/4KHtHKNsynLMKyBEJqjXQpZHk1ItgZ1TTXeYzLSAOGAAEdI2Atwnt85S9VUxrBFHTmejg2MlbIUO9OLHQLntU9k05wIzECtZJBZF9ogg8pu9ZbYxZgp6tTI4mlmAcBQzwQMtUxyqgaLsgAQiUtEvjStjGcuXUYcNuZr565hbaAzFkZOR3qV0m3z/ag6o2AfPvY8aqDQsvJcqpi+N1vrET1gx/5O8vxjKyaQBsOoL24+rS/tD6ekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUxK6Xl5KFDUyCR9bSXzDY1SgDCIv08OlXJE/3mET7c=;
 b=JX4GEIbjL6khNkH0VKPVHMvNShA+w9HLLrMWj38DLJQ0Dlz3FkdwNnKz0/DfMBPNFPEdcOplR59ehveTGP/cHo1Rp/qVITOPrA/E+Nlicr54S4zGChADhSNooTXlk9Yga97q5ngR53riJeCF2e0Ih2sCn8DtCTG2HOKwa1CBi5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:30:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 08:30:32 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/5] shared/util: Add iovec helpers for pulling/pushing le32 and le24 values
Date:   Fri,  5 May 2023 11:29:41 +0300
Message-Id: <20230505082943.92033-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
References: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba2263e-5044-4382-5e3c-08db4d42fd48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyIix3IpEjkx4QkdPTOxS4IycklQfB7VXM2OALhXiawDBkPFUNKbBDjswvewRue/vMVCuMFB/quAf54U95kpm7NW4Bc3Z3IWW0IzpnptGX0+Y4UxbTJ94yYo+X4DG0r6UqPoZky+uJ5N+RZPg5/26zdh1tOT64LwFCTCRwkcy+uICeAHX/HagBDUIfCP1/oseq53kHfQHco7zhY0N7gwVlTN+aXz5/S+w2YgHGRUXINwdxr9o6zo5EwWXBjQAxp06FOps2ilvskfSucZGZZLeJy+4IcYKDcq8nHAM78QJxI3YV1zgdtDUmJ3npCmLR7P1Kurld13OuhEtQNkPzCqgD4/bwzRGYT+L1j02Ck20oW3dzJ+oTfKLa7KFmL9AnGO9mjz9ljDaTr6lCfn+mhbW4MZT0/+vDnb1i2XhcN24sGpKQ4csiLET0vMQ7UObMc26O0CwGSdSmHTpjs8xWqkhr8Rgj3yEYk7jkagSY3XKS4JX6MwEZc8rBXmH4mgh6f63SqKZbAUiY6aWmknPuw5Xmx/DMuuZ0Qkky/aeQqbt+zlpNI2dkwbThwkmj1CpoSYMSnkXUIl5SOEdJ175vhpKo+LIjsCTZSwm5UOvP0BpyaKCm7Z+2Cvlp3x89Wq6B9t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(52116002)(6916009)(4326008)(66946007)(66556008)(66476007)(6666004)(478600001)(316002)(36756003)(86362001)(6486002)(2616005)(55236004)(6506007)(6512007)(1076003)(26005)(8676002)(5660300002)(8936002)(44832011)(2906002)(41300700001)(38100700002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ge13dI7c73lYaQofkhutVWKoz1mcmtLu8JLKDEOfKDoGWSGpub7E4lohdfjI?=
 =?us-ascii?Q?6dMNwC17j1OQeXFftddzFV7NUsP4SSSsl8wl0/8PZw0AR1AUPE3RMygLvY5N?=
 =?us-ascii?Q?/+UP6Xblg+kqeaTNNlNufv0cENJses9qJhFg3QrthvPq6NR63QJOJ+tZ8o0h?=
 =?us-ascii?Q?YmVRe7W7791JHH40ET1H2tBR75SI5wkG+3OrC8J9drkVpOkMBvdQHn3D+kUc?=
 =?us-ascii?Q?NT96sLTKfqbBrVOw7t+6d1eRc2+A6bKOjBK2lTbykQuZkZZqxkykLlJXmet1?=
 =?us-ascii?Q?lfaFUjk+X8ktgvF1yoTitJX9fp7wBSrzR/7ehQLnTY8YAiGhGJ2CC/vKEYnd?=
 =?us-ascii?Q?WDRkQSJeSWv8yYFO67vY/JHhfB8WiFlzVdkx+hyoXD3uoVitk5jkvaWLwlyN?=
 =?us-ascii?Q?jJOD7p0lXnMfjDeAY4FHcnJ1W/H1lo1cl84ROPSNxCtu9D4TUjtZQ4h7USry?=
 =?us-ascii?Q?rF3XqRmDRccPyPOv2cf+WGGk0W0eOK+uRv27pcOxO4XKn6oK0kh88pkQy9Ht?=
 =?us-ascii?Q?yQ7eeiKa8X415GXuvV05khcD3k4k3bPwjVk6b/dfOjh4m7E2bpkHs9pxyqo2?=
 =?us-ascii?Q?7L5pRfhAR1yRR7DGQIlTdvKHzQDzViEuZDJc5W6XAS38qtPVodULqk6cr/q4?=
 =?us-ascii?Q?yuhiSrFF5XdtIXvBJjG3S60qnt7Ekh8Om3rG5/VeMAwLHF/prmTXMRXEULV5?=
 =?us-ascii?Q?DjObXb+xwk9ov/TiALr+UD+S9BFaWVWlDaae8R77o/niRzakEEC+W9kSEKDF?=
 =?us-ascii?Q?ow76pRKEPvdskRXHBluUYXiD0LkEUaSU8QQRfGa3BfiwtBlAc7yd74RLyRl2?=
 =?us-ascii?Q?63hqcUuZnYUPM8moUCSSWfZX4dXgPLmSMPKD4JqwekPdoG/y9h0YPxEnJ00L?=
 =?us-ascii?Q?O5xGb5XDr3H+tuhnB3WSlNk6jeYM/g1X0Uy7SWzGn4VzQq6lhsrNEsOyQhHt?=
 =?us-ascii?Q?iEM0uTnwsLcyGDZs82l/atbJ/1h8joE1mH4CK3hPO3Yuf5HB7dWomN2XnTW+?=
 =?us-ascii?Q?lX68WrowuReNHYJmgq5wJXtltcmajDujAtOBABf5WA0aVv5edj7+oQFiQyjk?=
 =?us-ascii?Q?tAAEL8AYEaylbrhrp9F25g1AiCKWX3DN52bbbGOay7WZXfOHSrLKWTSEB1/s?=
 =?us-ascii?Q?hzsG4dpsjH56KBQXESjbknzW+oc1pKUhlcHqnz9G1Enz1ndWwB2M18VDONn7?=
 =?us-ascii?Q?y7bOQy+KvUonCHWVcjbzKWMB2+QUG2/74wECEhFziIiaCBFlEysKtAeeZyzC?=
 =?us-ascii?Q?0YmB0I/0bSig58T8rSAdZFgM5ISvRyVNeU5oymxeiAnvRA7APjK9kHxmDGs7?=
 =?us-ascii?Q?pDbwfS0rgGtPDy7mL5xyf3JE99iEnMRrV8g0jNorHcRoVK9eDDDGs+uAY7l0?=
 =?us-ascii?Q?ZAlmwKaVmjF3cm5DcsLXBqPVSukkpaiu5MIhbXlPmwRw5t0efiDwNzyayx8o?=
 =?us-ascii?Q?C/tr+2PX9I51rnJbdg494aF5x8NfcPVDA4oZQSAgDdZxprnbkz9CZBo5f5C2?=
 =?us-ascii?Q?Z3esHpKm0q9HLYBVLNzEZY9VUWFkts/JWgXeJAqcdYtAMVVoR1S1hj2jczGL?=
 =?us-ascii?Q?QLr6ADYeNyTo4r9YtR9ri5COyAZ//DYGfoVE2ybxsEcVDNwHMSMf1/LGj+Xz?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba2263e-5044-4382-5e3c-08db4d42fd48
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:30:32.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77UAGm7EIQo6tjZ4RFItWNg5FlK2PXuDXEDanjoGHeGxruQprxuAa3WpZHYrcJQuT4y0xI9P/CqQEC428joHbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds iovec helper functions for handling le32 and le24 values.

---
 src/shared/util.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  5 +++++
 2 files changed, 58 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 9a4a8d77a..f9d8ecbaa 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -28,6 +29,8 @@
 #include <sys/random.h>
 #endif
 
+#include <lib/bluetooth.h>
+
 /* define MAX_INPUT for musl */
 #ifndef MAX_INPUT
 #define MAX_INPUT _POSIX_MAX_INPUT
@@ -274,6 +277,32 @@ void *util_iov_push_mem(struct iovec *iov, size_t len, const void *data)
 	return p;
 }
 
+void *util_iov_push_le32(struct iovec *iov, uint32_t val)
+{
+	void *p;
+
+	p = util_iov_push(iov, sizeof(uint32_t));
+	if (!p)
+		return NULL;
+
+	put_le32(val, p);
+
+	return p;
+}
+
+void *util_iov_push_le24(struct iovec *iov, uint32_t val)
+{
+	void *p;
+
+	p = util_iov_push(iov, sizeof(uint24_t));
+	if (!p)
+		return NULL;
+
+	put_le24(val, p);
+
+	return p;
+}
+
 void *util_iov_pull(struct iovec *iov, size_t len)
 {
 	if (!iov)
@@ -298,6 +327,30 @@ void *util_iov_pull_mem(struct iovec *iov, size_t len)
 	return NULL;
 }
 
+void *util_iov_pull_le32(struct iovec *iov, uint32_t *val)
+{
+	void *data = iov->iov_base;
+
+	if (util_iov_pull(iov, sizeof(uint32_t))) {
+		*val = get_le32(data);
+		return data;
+	}
+
+	return NULL;
+}
+
+void *util_iov_pull_le24(struct iovec *iov, uint32_t *val)
+{
+	void *data = iov->iov_base;
+
+	if (util_iov_pull(iov, sizeof(uint24_t))) {
+		*val = get_le24(data);
+		return data;
+	}
+
+	return NULL;
+}
+
 static const struct {
 	uint16_t uuid;
 	const char *str;
diff --git a/src/shared/util.h b/src/shared/util.h
index dc84f9635..b99a959b8 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -115,8 +116,12 @@ int util_iov_memcmp(const struct iovec *iov1, const struct iovec *iov2);
 void util_iov_memcpy(struct iovec *iov, void *src, size_t len);
 void *util_iov_push(struct iovec *iov, size_t len);
 void *util_iov_push_mem(struct iovec *iov, size_t len, const void *data);
+void *util_iov_push_le32(struct iovec *iov, uint32_t val);
+void *util_iov_push_le24(struct iovec *iov, uint32_t val);
 void *util_iov_pull(struct iovec *iov, size_t len);
 void *util_iov_pull_mem(struct iovec *iov, size_t len);
+void *util_iov_pull_le32(struct iovec *iov, uint32_t *val);
+void *util_iov_pull_le24(struct iovec *iov, uint32_t *val);
 void util_iov_free(struct iovec *iov, size_t cnt);
 
 const char *bt_uuid16_to_str(uint16_t uuid);
-- 
2.34.1

