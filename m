Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767ACC71148
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 13:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377183AbjHRNgl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 09:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377184AbjHRNgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 09:36:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD53589
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 06:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBR4epwxx7SOwZ/MNsCjLlL3M3L1dEvMSSerbZQcGJHjXUrdmU8h0BFjJ1raDetuvH/nXlLNrj3s3fN1it6nIMjsGFVk9CoRQnSu8U6DDTOB0X2SZzBl38QbFMdk6smsh2HjxxSSYqWMR/edfDiopRnRkrdZcv5yS3E239/1pq+wUubtcnUGvXWMg4R5r8S4HyuL4sL2Sn5ObAQVBCfZdbwAqcHzh9065qYrbjlsZR0gQlMXE92tcooCdK2jZyk9tLiG0+V3Ts201CKH4pu1DUzGAdpboFeFjdViD7ML6E3W+KdIMFkrVQksJfo3ZLkGSkyT7EJfWA57y2uZsdoVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrcWmWMlk0dzhODJgQkn2+oEoK+Df/qZDkiBPZz1b9g=;
 b=ntQIp18qB1DXku+tJ9QUMWKHyyrvqNaj0bYpo4iLMSlTEbQm1Wm8MXvNvWbwnKll/Cj1Ju3RTw+CD6aDagkDf7nDcHzH/SxS40QFFErI6KieisjBiaXQe9KqBaIoRE2j18uLRA015MyYk0/dN3Nu9L4uyjDVok5uNTAyLQq0JZFtYbR7ca5tMgwLkscaNDhxQeyzbcyJsndNQhuE4oN7NaOHICzdOdjYq7wm575phjf5xakmyC06/D14m2Ybn3T0Qg+rrOYq2BMTOECTj3lPkiYIg3hqCd/BoowHTO81juuVxcQeyz1dG4npjLDRQ5+tXJSWSqh20u965vmFV0lzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrcWmWMlk0dzhODJgQkn2+oEoK+Df/qZDkiBPZz1b9g=;
 b=XMG5rszV8lqt55a1ttzyeVHhrla5ugRgR7KBQv1nFz4qD4HHXWabazYxMOePbPuTmrEJiYNmFHQ4oCursm6DVw5+W7emdmTX9nEA/2cpa3tpGjd5frXNnbWAqygzPJdumrLCFbiF1858etaJu/nX8tD+9waowvpAIOcnVA/nzIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB8263.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:36:14 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 13:36:14 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v3 1/3] shared/bap: Add function that parses a BASE structure
Date:   Fri, 18 Aug 2023 16:35:50 +0300
Message-Id: <20230818133552.20673-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818133552.20673-1-silviu.barbulescu@nxp.com>
References: <20230818133552.20673-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b272e3-f2b6-47e3-fe5d-08db9ff01784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWxpGWwpiCn7cwXBqETZJOD4yBRnByQn8f5EI3ogrKmAMKAlbB58OvU0cnrBKOemjEG1oUJe8Ik9f6851FFkJ6avby0PA48a3uu0osndVpXpU/ljcgKP8rvXYzavzkKFBcEN07UQw5BkmNLWL6RdOTO+d77LFTLl/KE7mfWZuCnsDmkVBI+wF1IgXTBefmJ1Dv715quY0aRq+HlUg7QqV//Gfr1hDIrshUZVnVYHfWv1P8GqiylrYW2XalUU9zXNDX5Z9V2o1PTK7Ib8a8uLCJ+AbfQM04VLzeCeJakLJ5OpfU0cPWMvR9h47KpQDlEv0QzoPJYWVT7TvlL8CK48dqMEeWWUdOqJ+ydnHSzIIGW0f3RQJOUL/6DAudR+l8tgFdnGj1lNRbPqUGl3NAxrcf7SRQ82IiDV53OpVjPVLtRi35AmGYwr97LaFN61IM26rwspOLlVrw2tovKkRae3bvm3pYlif50PvAR1XN+1msyvqDGNxb8ssWpvcBkzMObBTJb3HQPlg1CZ7QZAod6GiqZoOZM8IFhMsDKrdzomnO7rBJPntjrC7aONeDbqKb+y4FLIWd5LjRnUiMu8pM5pohEl++P7FrfXrf7TEhY+TmFhreykPLltS7Rj5Yuk1MhX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(86362001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(41300700001)(38350700002)(38100700002)(6512007)(6486002)(6666004)(26005)(6506007)(52116002)(1076003)(2616005)(8676002)(5660300002)(8936002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CkhywyHVk4wgv5DrryCjjlcqcfLv8pOhEcEwtPKC6hc7b2JeuSmGWrRlc6k3?=
 =?us-ascii?Q?1Q+Evy5CVW6iLjS7oayMBGdr3g7DWVyIruVR15cJ3TlcD2QXE/e7OnYVBIWt?=
 =?us-ascii?Q?9gwjss+lkEahAnQmMMlDKWqrSWDTcWXK+WJn/6d5F7Dcxxz7tghKF/b+Kho4?=
 =?us-ascii?Q?LussaDff0kr5n1/qEJy9VbT4MzXyDmKyZKoXgpVgbybkG5+FUJJgsK4W+/Ou?=
 =?us-ascii?Q?b+F4CLZD7RM6kL01EPEI2JvpiB3Z8pftNVKkopEdIUmoAJdRSp9NcmQf2ERX?=
 =?us-ascii?Q?DCsQgYrcxXZnl5QEttjcYDuuff5JhGqB1MCej/oFf/UZbXMvHBlFYjKQiRBZ?=
 =?us-ascii?Q?YsLHuTcURmN1vtW2uc8Bm2hpNQ1/KypXXI8f6avN0r4UX46tq80QSuzzt6ok?=
 =?us-ascii?Q?fRvi4WXHPQRgKv2FjTBonw/8KzNL54Pb7nHPJmEaiwWXSdsMXrlL+pgmmc4F?=
 =?us-ascii?Q?LHr4Sd/D+QlXju7hteF0YPlvUAYtZP79VUFw1HpnfkhM9Mmuuh37T3F01/eL?=
 =?us-ascii?Q?3ldPP14ctVDaiM2MbpMe6paoHFY3uxiyztnO7Uo9vNs2U1rUDDYhV9G6zkPW?=
 =?us-ascii?Q?bOq4keZftzyJH8rIe/9BAE2r4qET0fAkWkpma3W0EFir+L1zN1/yuSJcaub3?=
 =?us-ascii?Q?YF+POYTj868dV6zdRpVbXCyF1VJX7+eq2l4ZR5QJVKluVQSrm71b7q0vCjDl?=
 =?us-ascii?Q?k4OdHEDq0+zS5VTI1fKKrY8A/GsFnbE0awUVUS+jq279DfuKKu3gZm93fsG5?=
 =?us-ascii?Q?w/UIPxu2I9pqXvVYLpt47idpODP8qAhN96B+CGbQ1juP7l2069SEsWwbdl9l?=
 =?us-ascii?Q?kPJ0xTN8OBqOBDyFrdR4owWWLBLNcidIzjHqflx49sT5MTpZmoZF2wRVUXJc?=
 =?us-ascii?Q?0myhgHkoBrG4Zz53O/61JalVUx3SOsO7TxpfRw6E99ma6vuFGZZFYPeOY61L?=
 =?us-ascii?Q?BgTcKaIvcO7LxPRn5W/aeWI4a7Q9e1Cs+keFgthUbZ3Ian3yyQiGFEeOgfhG?=
 =?us-ascii?Q?C7Co4a6yEzTafL/zpeE9dZgqQoRI7PhNoBI70CbjzWlD7bvk+RIt71wsUC8q?=
 =?us-ascii?Q?sKkhop+330Z+eJHwbNA9kdLpeliKAUG2OrdSaL0LdCZrfbVN2HQ+CTMTq709?=
 =?us-ascii?Q?h5M9PpAY4A0qHCSELBYd6sDD5MxsCazeVVEiuUsgX8h1U8h15gZ60PGpaVxx?=
 =?us-ascii?Q?sRCiP/MVznyFbqSXEhGwXKPp7cHhdVDrFzihKEPSFk/xE2iA5PTDn//8lFeP?=
 =?us-ascii?Q?vVcbqBAnZ3V9KO9+xEXSC5MC2+m2ATDre6eDbI0C1VPIrvy0iG837gcaWsHo?=
 =?us-ascii?Q?RcCOuhajtoj173jkWAkgMhjEgEclBbdtPpc0PE1blqDxV16UuM4q2cbGJRpI?=
 =?us-ascii?Q?ftiH/JuXXoJ8k6s+jGqUgmkkUSYPgjFUDHgr021j5TbooW69Vn7tN7b0WSk7?=
 =?us-ascii?Q?8dSFFhEPXb97iUBbno7mlrOi407zWLGtFPR3Q4KJTwmd2JdPYBqn5zZqtKOC?=
 =?us-ascii?Q?R77j3V1oNkgL6HDOUeGVKh2l9KtvrZmczRsseXuIwlVc3QRIEA67eE6v1ysB?=
 =?us-ascii?Q?Z6H7XitqqVvZ/bYwjB5jvnSIlznPKknyItMgeFnauIjpAs+k5dQLGMdLJqFy?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b272e3-f2b6-47e3-fe5d-08db9ff01784
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:36:14.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVA4YNTmkYWbsKyDKAUjfHDJgq9MAG9DK6kYneca7KWltN37Om471oLkGuNOcn7EQ0CuqyfWKfmRPKO/C6OVWxbbMqFL6KZ4qpea21LCXUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8263
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Claudia Draghicescu <claudia.rosu@nxp.com>

shared/bap: Add utility function that parses a BASE structure

---
 src/shared/bap.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  5 +++
 2 files changed, 102 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72ce67c08..318fcc74f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2923,6 +2923,103 @@ bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
 	return bap_print_ltv("CC", data, len, func, user_data);
 }
 
+bool bap_parse_base(void *data, size_t len, util_debug_func_t func,
+		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
+		struct bt_bap_codec *codec, struct iovec **caps,
+		struct iovec **meta)
+{
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = len,
+	};
+
+	uint8_t capsLen, metaLen;
+	uint8_t *hexstream;
+
+	if (presDelay) {
+		if (!util_iov_pull_le24(&iov, presDelay))
+			return false;
+		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
+	}
+
+	if (numSubgroups) {
+		if (!util_iov_pull_u8(&iov, numSubgroups))
+			return false;
+		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
+	}
+
+	if (numBis) {
+		if (!util_iov_pull_u8(&iov, numBis))
+			return false;
+		util_debug(func, NULL, "NumBis %d", *numBis);
+	}
+
+	if (codec) {
+		codec = util_iov_pull_mem(&iov, sizeof(*codec));
+		if (!codec)
+			return false;
+		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
+				"Codec", codec->id, codec->cid, codec->vid);
+	}
+
+	if (!util_iov_pull_u8(&iov, &capsLen))
+		return false;
+	util_debug(func, NULL, "CC Len %d", capsLen);
+
+	if (!capsLen)
+		return false;
+	if (caps) {
+		if (!(*caps))
+			*caps = new0(struct iovec, 1);
+		(*caps)->iov_len = capsLen;
+		(*caps)->iov_base = iov.iov_base;
+	}
+
+	for (int i = 0; capsLen > 1; i++) {
+		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
+		uint8_t *caps;
+
+		if (!ltv) {
+			util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+			return false;
+		}
+
+		util_debug(func, NULL, "%s #%u: len %u type %u",
+					"CC", i, ltv->len, ltv->type);
+
+		caps = util_iov_pull_mem(&iov, ltv->len - 1);
+		if (!caps) {
+			util_debug(func, NULL, "Unable to parse %s",
+								"CC");
+			return false;
+		}
+		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+		capsLen -= (ltv->len + 1);
+	}
+
+	if (!util_iov_pull_u8(&iov, &metaLen))
+		return false;
+	util_debug(func, NULL, "Metadata Len %d", metaLen);
+
+	if (!metaLen)
+		return false;
+	if (meta) {
+		if (!(*meta))
+			*meta = new0(struct iovec, 1);
+		(*meta)->iov_len = metaLen;
+		(*meta)->iov_base = iov.iov_base;
+	}
+
+	hexstream = util_iov_pull_mem(&iov, metaLen);
+	if (!hexstream)
+		return false;
+	util_hexdump(' ', hexstream, metaLen, func, NULL);
+
+	return true;
+}
+
 static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 				struct queue *queue,
 				const uint8_t *value,
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 50b567663..be1c7e343 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -195,6 +195,11 @@ bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
 bool bap_print_cc(void *data, size_t len, util_debug_func_t func,
 						void *user_data);
 
+bool bap_parse_base(void *data, size_t len, util_debug_func_t func,
+		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
+		struct bt_bap_codec *codec, struct iovec **caps,
+		struct iovec **meta);
+
 unsigned int bt_bap_pac_register(struct bt_bap *bap, bt_bap_pac_func_t added,
 				bt_bap_pac_func_t removed, void *user_data,
 				bt_bap_destroy_func_t destroy);
-- 
2.34.1

