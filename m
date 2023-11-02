Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D22C4167D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 15:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347661AbjKBP67 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377055AbjKBP6w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607D5194
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 08:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7yV8NhqBtCa/tcqdw3CvINO2apfChMrYNYiHPfIrjR9CmrB0OOjJ3gKM8ajV1rdIxcUiVvpmcUifU+WyUThlaUiv1jHA5iDuiILwoJZDxtXVtoMAbW40ZRU9pJg98zc6gxDBid5AN4iub4TKZO0skKzISevMet+t5uKHubKnKFKOUOH6ih3Xbjq3j6CLh78S3AOzShvxqP1NYMJG8bKhMIEknhIXXt+FdHvEHLHIq5ealIRhwwCTflEL3VH8E3MLaJH8Ga4t3N2Gc9BoedggGzAAeIUtZMEOHj52d/acTsWKztJC454W0iSHutUPVOKZmNr7TldSlKK+zHaYJDWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnZxmAeS4RTDrsgKe6tnrqNOso53wFTFGxyhd2zqjLA=;
 b=fgWKXQkVUZkQ3iXeYAn3eyy4Uw579k0/m4XiXCVyvbPnABP0ogoYCPKmJJsiEmermrYKH+Vg2ELudYGTJH1u3pyIJJtZdKtdvq6QZE1psRjaxWLc2Z5jshOFzu8BtQQcsfqpkia3CYUf/RlCnMI5wev8CR4lWqgUjx09313xn23OlfrEJlsawrPuXxG7fbESGG2tfeRfw2zmHOcFTGqmPi2V2qoLBM7zrpU5uZMX3y8f16vzO5Usi1mROCeMuVNolT4fW9yqrtWTYDaZQuwYERx0bd8goqEpiRQffesulgIKKXlXOafsF6GgHtoNJNMI++yyAoRE2D6oaw+189lO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnZxmAeS4RTDrsgKe6tnrqNOso53wFTFGxyhd2zqjLA=;
 b=kTUATC5van6Vt+yLB9IzkJzvRKuJunfgA3XfDC3naK4bv//5VIBrdhe1AwLPcUesaPM7fmERDokfS6WQBKLTxK7xjxz5vTghPXPu2h+EldJ3OK3JtTrG+m00YzFmTP9itS2zInA1n5JBOsYo6zsuwGDl454vYMx2bNY3cW7ivnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Thu, 2 Nov
 2023 15:58:39 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:58:39 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 3/5] Add support for bcast multiple BISes
Date:   Thu,  2 Nov 2023 17:58:25 +0200
Message-Id: <20231102155827.4219-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
References: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::35) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f652074-44bc-4620-88b0-08dbdbbc9477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJuK0mV+fza6yCFkSmdFtXAqj5q5l56yUezhIDgriJckrEfq7LYqThmxUjxf+NHyYillr4moPXn6hG+MHlEG9pFND5U8KFS3dC50u+NI1rFpf4RcijKeDI/1qBXRcfDkrPFz8hS9SkP0RUcO8C5lSPyTQD2crguY/Xodr56qgTmQbWVxlMTuNB6Whvhw/nW4NS5lqH0Hec2xfImguVeOjJ7QJYAx/nPwXgtvLb2kXPWNio20rzNfdhCq+Z/DHS+OSeig5LMFH6WnIKgDuaz5PBz3eYR5i+QbUAuGWz0MeS1jxOn14XJ4R3X5LzdXPd+TYjCocgrRwM/VhUaZujFuPKVDOuGLfkg9YOkbzLAVviJAYAE+ScPPqNWN+grWBandltmjrW3pHWmQyrEbPWzZLK94sSsQZU2IA0wCryuKYqEOS2dK3EeHJ6Ct7aBNaaCrp1W1rStXZaaz8pE17Yqd+Tsv3Quf8cjAotP0XhLn86jYv2pLtg0iEEE/UvW0kOQ1mMnggHG2gMxBc7PSvEMdg627U7MAGKVRwyQtWf0v5Hs6Z3kP19WLPpyvAlOUfAHh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6512007)(1076003)(478600001)(6506007)(83380400001)(6666004)(8936002)(30864003)(8676002)(66946007)(41300700001)(5660300002)(66556008)(6486002)(2616005)(66476007)(6916009)(316002)(4326008)(38100700002)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F1IFJ5siVHCxsVcDKUTLxlZ9I5VBMGY2OeVD1Ka8T3Xub9F1DnE+W12tdpu/?=
 =?us-ascii?Q?AO/hTjBYhFC+C9/tT+lN6PU3mA/sL+Uxui8+Zvz57sQEXthY1448cNBSc95Z?=
 =?us-ascii?Q?IVOJIQWyqTcJchS+eIr9tPxdTsAwCdKmLqYLQPhDp+OmQ99BF8oZQQT3qiLt?=
 =?us-ascii?Q?2VB/S93BggT7vrQLgvY2TGEZX7/nrYNqHfAo8b6Cj4vUH720vUJQzDHpm4ty?=
 =?us-ascii?Q?Gz74E8dSoYsMpNINEd3HuHMaSG2JZDCqG7yogtYArimn5zXi8RegyPGvQTZi?=
 =?us-ascii?Q?zxyF+JqC1VS14FLeIWniDaT27kJ1nRKZ6VfZ/RNkt8vnWThXCSIlN+1t4Cj0?=
 =?us-ascii?Q?Iu7oWie1ESMKCIe0any6Q7Pj55MrU9E2qWZfDqvSus2Kt283hX+Lre1auAKj?=
 =?us-ascii?Q?KbF4G4IjJZcps3FLnV5vaE/NvfcMjwV2qy2LoXmMhLs3Ccht0j3je9D+/0Pm?=
 =?us-ascii?Q?w0MKRt7A23/zUm7QKhucL44HZfl9NV90cUD33FOWU/IxDYBKR+0O58udXhkm?=
 =?us-ascii?Q?c5hLa45Ton2Kfwi/7y8XM1z8GZMk72uFnDRTng4QnL5NMPw4TmogiXy1qFWp?=
 =?us-ascii?Q?kCK3scapQYSq9r8HAEFBP00ELvTEKu0wY6eCnq4pRoxvjw0rWwDcl2u2Mk9z?=
 =?us-ascii?Q?sOidNgOv6bpEOSmXWUVNuwmPJbjgRY6zxn/cBPS5rH3bHQeXNQbxkREI51tq?=
 =?us-ascii?Q?sly/uDArKsCLaI5rFrk9mBPXvvDsqx+WohTJCfKn8z/+U5jeTPkUOnGqnPT0?=
 =?us-ascii?Q?EKsFHQ42dTYz5Eok7chyhWzL14u2rIhqsSRiIs/aNNywJLA9wkCl+iHuiCpg?=
 =?us-ascii?Q?M/add1gjWtRWqZpo0vJrGS5AssXUJcGpNIClA9PcFySqfc70nMcb1b90C90O?=
 =?us-ascii?Q?kXMxGA7emPhgVQAOl7VSBCtIh6LI1ZRMLgnS8gbXE6fg5X5ubVPQ1xmcjptn?=
 =?us-ascii?Q?B0Y/jJbjPg0UjGCtJtf/0WX/i+xOcbFFXJXV6g7MfLwBaJy2lySrqkEZN4Xp?=
 =?us-ascii?Q?3kLGA/dSr7GU8+crpxSlIyE9H0LZJp68sTMRGQNAypw4cmNl3yPaa5CSmDca?=
 =?us-ascii?Q?m/XTQuQ9T67IxJ/XFIU3EROJqpLGeZuw8j21JqZ24NN78q0YrgTjrDg/OLLG?=
 =?us-ascii?Q?P8r7mXLvDTCOeyHVaf6BgP5Cv1UF3i1o9TJDzu/UF0QpLZFgeWaU0uuxDyyr?=
 =?us-ascii?Q?kLDnlUelJO8d3LLMsCgUTPf+FDkT0T+k8m5kco2d/t3oS/Gxh2kZIbI9zm+n?=
 =?us-ascii?Q?sQsVmI2xJ+AKPj/4+qpHxsO4+UtAH44SvDri9MiZjg3MYwEtsA8cRlj/Ef8A?=
 =?us-ascii?Q?TSm3FJfiC2fWgZIEdeWlo1suQFrBvShqaZUxbzWY9VOKVZnKYmNhYJXZAsxd?=
 =?us-ascii?Q?mOnkjt3X0fTQCbd9hErc1Xva7JFPFcbPtL4az1UaCMudIDetSamzzx2iri3Q?=
 =?us-ascii?Q?GnDTB+R7VG7aZrwEQvYgDFa4Xx4of1pIvGBiU3W0fQLpjQXTYkfneY9bcOJ4?=
 =?us-ascii?Q?Oxku+zC9r9L5die+wS9RjvgEgeYBgcYgjVWCkcklpf52Tk3Tyhqcm7T/StUj?=
 =?us-ascii?Q?ivIDSqRnydDfYHeql4TSt3+Zyo6rLdA6Ipinmx5y52zkdLwG0QhzZtd8NDcK?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f652074-44bc-4620-88b0-08dbdbbc9477
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:58:39.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUPmx3mlbzPudNqk60NP6dqtfKsuaBOmXuwSZq+nbGzQ8xH6Xoxo2CCHpSLh52vSmm0Tzsl4N6aHbZ7nkOFPo9FT8NaC27PIdy+FSbMOS+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for bcast multiple BISes

---
 profiles/audio/bap.c | 557 ++++++++++++++++++++++++++++++-------------
 src/shared/bap.c     | 226 ++++++++++++++----
 src/shared/bap.h     |  32 ++-
 unit/test-bap.c      |  12 +-
 4 files changed, 617 insertions(+), 210 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a84181e1a..a7a362bc6 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -97,6 +97,35 @@ struct bap_data {
 	void *user_data;
 };
 
+#define DEFAULT_IO_QOS \
+{ \
+	.interval	= 10000, \
+	.latency	= 10, \
+	.sdu		= 40, \
+	.phy		= 0x02, \
+	.rtn		= 2, \
+}
+
+static struct bt_iso_qos default_qos = {
+	.bcast = {
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.sync_factor	= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in			= DEFAULT_IO_QOS,
+		.out			= DEFAULT_IO_QOS,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout		= 0x4000,
+		.sync_cte_type		= 0x00,
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+	}
+};
+
 static struct queue *sessions;
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
@@ -254,7 +283,11 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	const char *path;
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		path = adapter_get_path(ep->data->adapter);
+		/*
+		 *Use remote endpoint path as fake device path
+		 *for the remote broadcast source endpoint
+		 */
+		path = ep->path;
 	else
 		path = device_get_path(ep->data->device);
 
@@ -379,101 +412,203 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 	return 0;
 }
 
-static bool parse_base(void *data, size_t len, util_debug_func_t func,
-		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
-		struct bt_bap_codec *codec, struct iovec **caps,
-		struct iovec **meta)
+static void cleanup_subgroup(struct bt_bap_base_subgroup *subGroup)
+{
+	if (!subGroup)
+		return;
+
+	if (subGroup->meta)
+		util_iov_free(subGroup->meta, 1);
+
+	if (subGroup->caps)
+		util_iov_free(subGroup->caps, 1);
+
+	while (!queue_isempty(subGroup->bises)) {
+		struct bt_bap_bis *bis = queue_peek_head(subGroup->bises);
+
+		if (bis->caps)
+			util_iov_free(bis->caps, 1);
+		queue_remove(subGroup->bises, bis);
+		subGroup->numBises--;
+	}
+	queue_destroy(subGroup->bises, NULL);
+
+	if (subGroup)
+		free(subGroup);
+}
+
+static bool parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base)
 {
+	uint8_t numSubgroups;
+	uint8_t numBis;
+
 	struct iovec iov = {
 		.iov_base = data,
 		.iov_len = len,
 	};
+	util_debug(func, NULL, "BASE len %ld", len);
+	if (!base)
+		return false;
 
-	uint8_t capsLen, metaLen;
-	uint8_t *hexstream;
+	if (!util_iov_pull_le24(&iov, &base->presDelay))
+		return false;
+	util_debug(func, NULL, "PresentationDelay %d", base->presDelay);
 
-	if (presDelay) {
-		if (!util_iov_pull_le24(&iov, presDelay))
-			return false;
-		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
-	}
+	if (!util_iov_pull_u8(&iov, &base->numSubgroups))
+		return false;
+	util_debug(func, NULL, "NumSubgroups %d", base->numSubgroups);
+	numSubgroups = base->numSubgroups;
 
-	if (numSubgroups) {
-		if (!util_iov_pull_u8(&iov, numSubgroups))
-			return false;
-		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
-	}
+	for (int sg = 0; sg < numSubgroups; sg++) {
+		struct bt_bap_base_subgroup *subGroup = new0(
+						struct bt_bap_base_subgroup, 1);
+		uint8_t capsLen, metaLen;
+		uint8_t *hexstream;
 
-	if (numBis) {
-		if (!util_iov_pull_u8(&iov, numBis))
-			return false;
-		util_debug(func, NULL, "NumBis %d", *numBis);
-	}
+		subGroup->subGroupIndex = sg;
 
-	if (codec) {
-		codec = util_iov_pull_mem(&iov, sizeof(*codec));
-		if (!codec)
-			return false;
+		util_debug(func, NULL, "Subgroup #%d", sg);
+		subGroup->bap = bap;
+		subGroup->bises = queue_new();
+
+		if (!util_iov_pull_u8(&iov, &numBis)) {
+			cleanup_subgroup(subGroup);
+			goto fail;
+		}
+		util_debug(func, NULL, "NumBis %d", numBis);
+		subGroup->numBises = numBis;
+
+		memcpy(&subGroup->codec, util_iov_pull_mem(&iov,
+		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
 		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
-				"Codec", codec->id, codec->cid, codec->vid);
-	}
+			"Codec", subGroup->codec.id, subGroup->codec.cid,
+				subGroup->codec.vid);
+		if (!util_iov_pull_u8(&iov, &capsLen)) {
+			cleanup_subgroup(subGroup);
+			goto fail;
+		}
 
-	if (!util_iov_pull_u8(&iov, &capsLen))
-		return false;
-	util_debug(func, NULL, "CC Len %d", capsLen);
+		util_debug(func, NULL, "CC Len %d", capsLen);
 
-	if (!capsLen)
-		return false;
-	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
-	}
+		subGroup->caps = new0(struct iovec, 1);
+		util_iov_memcpy(subGroup->caps, iov.iov_base, capsLen);
+		DBG("subgroup caps len %ld", subGroup->caps->iov_len);
 
-	for (int i = 0; capsLen > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *caps;
+		for (int i = 0; capsLen > 1; i++) {
+			struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+			uint8_t *caps;
 
-		if (!ltv) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"Capabilities");
-			return false;
+			if (!ltv) {
+				util_debug(func, NULL, "Unable to parse %s",
+							"Capabilities");
+				cleanup_subgroup(subGroup);
+				goto fail;
+			}
+
+			util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+			caps = util_iov_pull_mem(&iov, ltv->len - 1);
+			if (!caps) {
+				util_debug(func, NULL, "Unable to parse %s",
+									"CC");
+				cleanup_subgroup(subGroup);
+				goto fail;
+			}
+			util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+
+			capsLen -= (ltv->len + 1);
 		}
 
-		util_debug(func, NULL, "%s #%u: len %u type %u",
-					"CC", i, ltv->len, ltv->type);
+		if (!util_iov_pull_u8(&iov, &metaLen)) {
+			cleanup_subgroup(subGroup);
+			goto fail;
+		}
+		util_debug(func, NULL, "Metadata Len %d", metaLen);
 
-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!caps) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"CC");
-			return false;
+		subGroup->meta = new0(struct iovec, 1);
+		subGroup->meta->iov_len = metaLen;
+		subGroup->meta->iov_base = iov.iov_base;
+
+		hexstream = util_iov_pull_mem(&iov, metaLen);
+		if (!hexstream) {
+			cleanup_subgroup(subGroup);
+			goto fail;
 		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+		util_hexdump(' ', hexstream, metaLen, func, NULL);
 
-		capsLen -= (ltv->len + 1);
-	}
+		for (int bis_sg = 0; bis_sg < subGroup->numBises; bis_sg++) {
+			struct bt_bap_bis *bis;
+			uint8_t capsLen;
+			uint8_t crtBis;
 
-	if (!util_iov_pull_u8(&iov, &metaLen))
-		return false;
-	util_debug(func, NULL, "Metadata Len %d", metaLen);
+			if (!util_iov_pull_u8(&iov, &crtBis)) {
+				cleanup_subgroup(subGroup);
+				goto fail;
+			}
+			util_debug(func, NULL, "BIS #%d", crtBis);
 
-	if (!metaLen)
-		return false;
-	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
-	}
+			bis = new0(struct bt_bap_bis, 1);
+			bis->bisIndex = crtBis;
 
-	hexstream = util_iov_pull_mem(&iov, metaLen);
-	if (!hexstream)
-		return false;
-	util_hexdump(' ', hexstream, metaLen, func, NULL);
+			if (!util_iov_pull_u8(&iov, &capsLen)) {
+				cleanup_subgroup(subGroup);
+				goto fail;
+			}
+			util_debug(func, NULL, "CC Len %d", capsLen);
+
+			bis->caps = new0(struct iovec, 1);
+			bis->caps->iov_len = capsLen;
+			util_iov_memcpy(bis->caps, iov.iov_base, capsLen);
+			DBG("bis caps len %ld", bis->caps->iov_len);
+
+			for (int i = 0; capsLen > 1; i++) {
+				struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+				uint8_t *caps;
 
+				if (!ltv) {
+					util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+					cleanup_subgroup(subGroup);
+					goto fail;
+				}
+
+				util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+				caps = util_iov_pull_mem(&iov, ltv->len - 1);
+				if (!caps) {
+					util_debug(func, NULL,
+						"Unable to parse %s", "CC");
+					cleanup_subgroup(subGroup);
+					goto fail;
+				}
+				util_hexdump(' ', caps, ltv->len - 1, func,
+									NULL);
+
+				capsLen -= (ltv->len + 1);
+			}
+
+			queue_push_tail(subGroup->bises, bis);
+		}
+
+		queue_push_tail(base->subgroups, subGroup);
+	}
 	return true;
+
+fail:
+		while (!queue_isempty(base->subgroups)) {
+			struct bt_bap_base_subgroup *subGroup =
+					queue_peek_head(base->subgroups);
+			cleanup_subgroup(subGroup);
+			base->numSubgroups--;
+		}
+		util_debug(func, NULL, "Unable to parse %s", "Base");
+
+		return false;
 }
 
 static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
@@ -556,6 +691,16 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.encryption);
+	} else if (!strcasecmp(key, "BIG")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.big);
+	}  else if (!strcasecmp(key, "BIS")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.bis);
 	} else if (!strcasecmp(key, "Options")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -653,10 +798,12 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
 
 static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 				struct iovec **metadata, struct iovec **base,
-				struct bt_bap_qos *qos)
+				struct bt_bap_qos *qos,
+				struct bt_bap_base *base_s)
 {
 	const char *key;
 	struct iovec iov;
+	base_s->subgroups = NULL;
 
 	memset(&iov, 0, sizeof(iov));
 
@@ -702,14 +849,10 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 	}
 
 	if (*base) {
-		uint32_t presDelay;
-		uint8_t numSubgroups, numBis;
-		struct bt_bap_codec codec;
-
 		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
-		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis, &codec,
-			caps, NULL);
+		base_s->subgroups = queue_new();
+		parse_base(NULL, (*caps)->iov_base, (*caps)->iov_len,
+							bap_debug, base_s);
 	}
 
 	return 0;
@@ -796,12 +939,40 @@ static void bap_io_close(struct bap_ep *ep)
 	ep->cig_active = false;
 }
 
+static bool match_bis_by_id(const void *data, const void *user_data)
+{
+	int32_t bis_id = PTR_TO_INT(user_data);
+	const struct bt_bap_bis *bis = data;
+
+	return bis->bisIndex == bis_id;
+}
+
+static int get_number_bcast_source_ep(struct bap_ep *ep)
+{
+	const struct queue_entry *entry;
+	struct bap_ep *current_ep;
+	int nr_ep = 0;
+
+	for (entry = queue_get_entries(ep->data->bcast); entry;
+						entry = entry->next) {
+		current_ep = entry->data;
+		if (bt_bap_pac_get_type(current_ep->lpac) ==
+						BT_BAP_BCAST_SOURCE)
+			nr_ep++;
+	}
+
+	return nr_ep;
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct bap_ep *ep = data;
 	const char *path;
 	DBusMessageIter args, props;
+	struct bt_bap_base parse_bap_base;
+	struct bt_bap_bis *curent_bis;
+	struct bt_bap_base_subgroup *subgroup;
 
 	if (ep->msg)
 		return btd_error_busy(msg);
@@ -832,11 +1003,46 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (parse_configuration(&props, &ep->caps, &ep->metadata,
-				&ep->base, &ep->qos) < 0) {
+				&ep->base, &ep->qos, &parse_bap_base) < 0) {
 		DBG("Unable to parse configuration");
 		return btd_error_invalid_args(msg);
 	}
 
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
+		unsigned int nr_ep = 1;
+
+		subgroup = queue_peek_head(parse_bap_base.subgroups);
+		curent_bis = queue_find(subgroup->bises, match_bis_by_id,
+						INT_TO_PTR(ep->qos.bcast.bis));
+		if (curent_bis == NULL) {
+			DBG("Unable to find BIS");
+			return btd_error_invalid_args(msg);
+		}
+		util_iov_free(ep->caps, 1);
+		ep->caps = new0(struct iovec, 1);
+		bt_bap_ltv_merge(ep->caps, subgroup->caps, false);
+		bt_bap_ltv_merge(ep->caps, curent_bis->caps, false);
+
+		nr_ep = get_number_bcast_source_ep(ep);
+		if (nr_ep < queue_length(subgroup->bises)) {
+			for (uint8_t i = 0;
+				i < queue_length(subgroup->bises)-1; i++)
+				bt_bap_add_vendor_pac_from_pac(ep->lpac);
+		}
+	} else if ((bt_bap_pac_get_type(ep->rpac) == BT_BAP_BCAST_SOURCE) &&
+			(bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)) {
+		util_iov_free(ep->caps, 1);
+		ep->caps = new0(struct iovec, 1);
+		bt_bap_ltv_merge(ep->caps, bt_bap_pac_get_data(ep->rpac),
+									false);
+	}
+	/*
+	 * Kernel uses bis id as advertising handler. To open all BISes from
+	 * a big on the same advertisng handler set the bis
+	 * to BT_ISO_QOS_BIS_UNSET
+	 */
+	ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
@@ -848,7 +1054,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 						config_cb, ep);
 	if (!ep->id) {
 		DBG("Unable to config stream");
-		free(ep->caps);
+		util_iov_free(ep->caps, 1);
 		ep->caps = NULL;
 		return btd_error_invalid_args(msg);
 	}
@@ -901,31 +1107,16 @@ static void update_bcast_qos(struct bt_iso_qos *qos,
 		sizeof(qos->bcast.bcode));
 }
 
-static bool match_ep_type(const void *data, const void *user_data)
-{
-	const struct bap_ep *ep = data;
-
-	return (bt_bap_pac_get_type(ep->lpac) == PTR_TO_INT(user_data));
-}
-
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
-	struct bap_data *data = user_data;
+	struct bap_ep *ep = user_data;
 	struct bt_iso_qos qos;
-	struct bt_iso_base base;
 	char address[18];
-	struct bap_ep *ep;
 	int fd;
-	struct iovec *base_io;
-	uint32_t presDelay;
-	uint8_t numSubgroups;
-	uint8_t numBis;
-	struct bt_bap_codec codec;
 
 	bt_io_get(io, &err,
 			BT_IO_OPT_DEST, address,
 			BT_IO_OPT_QOS, &qos,
-			BT_IO_OPT_BASE, &base,
 			BT_IO_OPT_INVALID);
 	if (err) {
 		error("%s", err->message);
@@ -934,29 +1125,15 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	}
 
 	g_io_channel_ref(io);
-	btd_service_connecting_complete(data->service, 0);
+	btd_service_connecting_complete(ep->data->service, 0);
 	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
 					address, qos.bcast.big, qos.bcast.bis);
 
-	ep = queue_find(data->bcast, match_ep_type,
-			INT_TO_PTR(BT_BAP_BCAST_SINK));
-	if (!ep)
-		return;
-
 	update_bcast_qos(&qos, &ep->qos);
 
-	base_io = new0(struct iovec, 1);
-	util_iov_memcpy(base_io, base.base, base.base_len);
-
-	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis,
-			&codec, &ep->caps, &ep->metadata);
-
-	/* Update pac with BASE information */
-	bt_bap_update_bcast_source(ep->rpac, &codec, ep->caps, ep->metadata);
 	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
 					ep->caps, NULL, NULL);
-	data->listen_io = io;
+	ep->data->listen_io = io;
 
 	bt_bap_stream_set_user_data(ep->stream, ep->path);
 
@@ -968,25 +1145,39 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
-
 	return;
 
 drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
-
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
+	struct bt_iso_base base;
+	char address[18];
+	struct bt_bap_base base_s;
+	struct bap_data *data = user_data;
+	struct bt_iso_qos qos;
 
-	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
-		error("bt_io_bcast_accept: %s", err->message);
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
 		g_error_free(err);
-		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
 	}
+	g_io_channel_ref(io);
+	data->listen_io = io;
+	btd_service_connecting_complete(data->service, 0);
 
+	base_s.subgroups = queue_new();
+	parse_base(data->bap, base.base, base.base_len, bap_debug, &base_s);
+
+	bt_bap_update_bcast_source(NULL, &base_s);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1082,6 +1273,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
+		ep->io = data->listen_io;
 		ep->base = new0(struct iovec, 1);
 		break;
 	}
@@ -1582,9 +1774,12 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 
 	bap_io_close(ep);
 
-	/* Check if connecting recreate IO */
-	if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
-		recreate_cig(ep);
+	if (bt_bap_stream_get_type(ep->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST) {
+		/* Check if connecting recreate IO */
+		if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
+			recreate_cig(ep);
+	}
 
 	return FALSE;
 }
@@ -1675,7 +1870,7 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 
 static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream,
-				struct bt_iso_qos *qos)
+				struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1711,7 +1906,7 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -1763,42 +1958,28 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 			struct bt_bap_stream *stream, struct bt_iso_qos *qos)
 {
-	GIOChannel *io;
 	GError *err = NULL;
 	struct sockaddr_iso_bc iso_bc_addr;
 
 	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
 	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
 			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = 1;
 	iso_bc_addr.bc_num_bis = 1;
+	iso_bc_addr.bc_bis[0] = strtol(bt_bap_pac_get_name(ep->rpac), NULL, 10);
 
 	DBG("stream %p", stream);
 
-	/* If IO already set skip creating it again */
-	if (bt_bap_stream_get_io(stream) || data->listen_io)
-		return;
-
-	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
-			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(ep->data->adapter),
-			BT_IO_OPT_DEST_BDADDR,
-			device_get_address(data->device),
-			BT_IO_OPT_DEST_TYPE,
-			btd_device_get_bdaddr_type(data->device),
-			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-			BT_IO_OPT_QOS, &qos->bcast,
-			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
-			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
-			BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
+	if (!bt_io_bcast_accept(ep->data->listen_io, iso_bcast_confirm_cb,
+				ep, NULL, &err,
+				BT_IO_OPT_ISO_BC_NUM_BIS,
+				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
+		g_io_channel_shutdown(ep->data->listen_io, TRUE, NULL);
 	}
-	ep->io = io;
-	ep->data->listen_io = io;
-
 }
+
 static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer)
 {
@@ -1833,9 +2014,6 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
-
 	iso_qos.bcast.big = ep->qos.bcast.big;
 	iso_qos.bcast.bis = ep->qos.bcast.bis;
 	iso_qos.bcast.sync_factor = ep->qos.bcast.sync_factor;
@@ -1852,9 +2030,9 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 	iso_qos.bcast.timeout = ep->qos.bcast.timeout;
 	memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
-done:
+
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		bap_connect_io_broadcast(data, ep, stream, &iso_qos);
+		bap_connect_io_broadcast(data, ep, stream, &iso_qos, defer);
 	else
 		bap_listen_io_broadcast(data, ep, stream, &iso_qos);
 }
@@ -1879,6 +2057,31 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 		break;
 	}
 }
+/*
+ * Function  test_linked_streams_state will check if all linked streams
+ * have the test state.
+ * If all streams are in test_state returns true; Else returns false
+ */
+static bool test_linked_streams_state(struct bt_bap_stream *stream,
+						uint8_t test_state)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_stream *linked_stream;
+	struct queue *links;
+
+	links = bt_bap_stream_io_get_links(stream);
+
+	if (!links)
+		return true;
+
+	for (entry = queue_get_entries(links); entry; entry = entry->next) {
+		linked_stream = entry->data;
+		if (bt_bap_stream_get_state(linked_stream) != test_state)
+			return false;
+	}
+
+	return true;
+}
 
 static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
@@ -1906,15 +2109,26 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
-			bap_create_io(data, ep, stream, true);
-			if (!ep->io) {
-				error("Unable to create io");
-				bt_bap_stream_release(stream, NULL, NULL);
-				return;
-			}
-
 			if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_BCAST) {
+				bool defer = !test_linked_streams_state(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+				bap_create_io(data, ep, stream, defer);
+				if (!ep->io) {
+					error("Unable to create io");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+					return;
+				}
+			} else if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
+				bap_create_io(data, ep, stream, true);
+				if (!ep->io) {
+					error("Unable to create io");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+					return;
+				}
 				/* Wait QoS response to respond */
 				ep->id = bt_bap_stream_qos(stream, &ep->qos,
 								qos_cb,	ep);
@@ -2222,6 +2436,12 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
 	char addr[18];
+	GIOChannel *io;
+	GError *err = NULL;
+	struct sockaddr_iso_bc iso_bc_addr;
+
+	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_num_bis = 1;
 
 	ba2str(device_get_address(device), addr);
 
@@ -2260,7 +2480,24 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	DBG("Create PA sync with source");
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &default_qos,
+			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
+			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
 	return 0;
 }
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index d8a3adde6..8ba0320d6 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -254,6 +254,8 @@ static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+static bool bt_bap_new_bcast_sink(struct bt_bap *bap);
+
 static bool bap_db_match(const void *data, const void *match_data)
 {
 	const struct bt_bap_db *bdb = data;
@@ -1111,7 +1113,8 @@ static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 		return stream->io;
 
 	io = NULL;
-	queue_foreach(stream->links, stream_find_io, &io);
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, stream_find_io, &io);
 
 	return io;
 }
@@ -1323,6 +1326,12 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 
 	bt_bap_ref(bap);
 
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_QOS:
+		bap_stream_update_io_links(stream);
+		break;
+	}
+
 	for (entry = queue_get_entries(bap->state_cbs); entry;
 							entry = entry->next) {
 		struct bt_bap_state *state = entry->data;
@@ -2357,33 +2366,18 @@ static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
 	return NULL;
 }
 
-static void *ltv_merge(struct iovec *data, struct iovec *cont)
-{
-	uint8_t delimiter = 0;
-
-	if (!data)
-		return NULL;
-
-	if (!cont || !cont->iov_len || !cont->iov_base)
-		return data->iov_base;
-
-	iov_append(data, sizeof(delimiter), &delimiter);
-
-	return iov_append(data, cont->iov_len, cont->iov_base);
-}
-
 static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 					struct iovec *metadata)
 {
 	/* Merge data into existing record */
 	if (pac->data)
-		ltv_merge(pac->data, data);
+		bt_bap_ltv_merge(pac->data, data, true);
 	else
 		pac->data = util_iov_dup(data, 1);
 
 	/* Merge metadata into existing record */
 	if (pac->metadata)
-		ltv_merge(pac->metadata, metadata);
+		bt_bap_ltv_merge(pac->metadata, metadata, true);
 	else
 		pac->metadata = util_iov_dup(metadata, 1);
 }
@@ -2614,6 +2608,20 @@ static void notify_session_pac_added(void *data, void *user_data)
 	queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
 }
 
+struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac)
+{
+	struct bt_bap_pac *new_pac;
+
+	new_pac = bt_bap_add_vendor_pac(pac->bdb->db, pac->name, pac->type,
+							pac->codec.id,
+							pac->codec.cid,
+							pac->codec.cid,
+							&pac->qos, pac->data,
+							pac->metadata);
+	bt_bap_pac_set_ops(new_pac, pac->ops, pac->user_data);
+	return new_pac;
+}
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
@@ -2671,7 +2679,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *metadata)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+						    data, metadata);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
@@ -2701,6 +2709,14 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	}
 }
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
+{
+	if (!pac)
+		return 0x00;
+
+	return pac->data;
+}
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac)
 {
 	struct bt_pacs *pacs;
@@ -2783,12 +2799,26 @@ static void notify_session_pac_removed(void *data, void *user_data)
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data)
 {
+	const struct queue_entry *entry = NULL;
+	struct bt_bap_pac *pac_entry;
+
 	if (!pac)
 		return false;
 
 	pac->ops = ops;
 	pac->user_data = user_data;
 
+	if (pac->type == BT_BAP_BCAST_SOURCE) {
+		for (entry = queue_get_entries(pac->bdb->broadcast_sources);
+					entry != NULL; entry = entry->next) {
+			pac_entry = entry->data;
+			if (pac_entry != pac) {
+				pac_entry->ops = ops;
+				pac_entry->user_data = user_data;
+			}
+		}
+	}
+
 	return true;
 }
 
@@ -2807,8 +2837,13 @@ static void remove_streams(void *data, void *user_data)
 	struct bt_bap_stream *stream;
 
 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream)
+	if (stream) {
+		/* Mark stream->lpac to NULL,
+		 * as it will be freed in bt_bap_remove_pac
+		 */
+		stream->lpac = NULL;
 		bt_bap_stream_release(stream, NULL, NULL);
+	}
 }
 
 static void bap_pac_sink_removed(void *data, void *user_data)
@@ -4471,6 +4506,11 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
 	return false;
 }
 
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac)
+{
+	return pac->name;
+}
+
 static bool find_ep_unused(const void *data, const void *user_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -4682,7 +4722,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac)
+		if ((!match.lpac) || (!lpac))
 			return NULL;
 		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
@@ -4699,7 +4739,15 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 	if (!ep) {
 		/* Check for unused ASE */
 		ep = queue_find(bap->remote_eps, find_ep_unused, &match);
-		if (!ep) {
+		if (!ep && lpac->type == BT_BAP_BCAST_SOURCE) {
+			bt_bap_new_bcast_sink(bap);
+			ep = queue_find(bap->remote_eps, find_ep_unused,
+								&match);
+			if (!ep) {
+				DBG(bap, "Unable to find unused ASE");
+				return NULL;
+			}
+		} else if (!ep) {
 			DBG(bap, "Unable to find unused ASE");
 			return NULL;
 		}
@@ -4839,7 +4887,16 @@ static void bap_stream_enable_link(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	struct iovec *metadata = user_data;
 
-	bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, NULL, NULL);
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata,
+								NULL, NULL);
+		break;
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+		break;
+	}
 }
 
 unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
@@ -4866,13 +4923,14 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		queue_foreach(stream->links, bap_stream_enable_link, metadata);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		if (!bt_bap_stream_io_dir(stream))
+		if (!bt_bap_stream_io_dir(stream)) {
 			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_CONFIG);
-		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+						BT_BAP_STREAM_STATE_CONFIG);
+			queue_foreach(stream->links, bap_stream_enable_link,
+									NULL);
+		} else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
 				 BT_BAP_STREAM_STATE_STREAMING);
-
 		return 1;
 	}
 
@@ -4933,17 +4991,27 @@ static void bap_stream_disable_link(void *data, void *user_data)
 	struct iovec iov;
 	struct bt_ascs_disable disable;
 
-	memset(&disable, 0, sizeof(disable));
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		memset(&disable, 0, sizeof(disable));
 
-	disable.ase = stream->ep->id;
+		disable.ase = stream->ep->id;
 
-	iov.iov_base = &disable;
-	iov.iov_len = sizeof(disable);
+		iov.iov_base = &disable;
+		iov.iov_len = sizeof(disable);
 
-	req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, NULL, NULL);
+		req = bap_req_new(stream, BT_ASCS_DISABLE, &iov,
+							1, NULL, NULL);
 
-	if (!bap_queue_req(stream->bap, req))
-		bap_req_free(req);
+		if (!bap_queue_req(stream->bap, req))
+			bap_req_free(req);
+	break;
+
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+				BT_BAP_STREAM_STATE_RELEASING);
+	break;
+	}
 }
 
 unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
@@ -5189,7 +5257,8 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
-	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
 
 	return true;
 }
@@ -5210,6 +5279,23 @@ static bool match_name(const void *data, const void *match_data)
 	return (!strcmp(pac->name, name));
 }
 
+void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
+						bool add_delimiter)
+{
+	uint8_t delimiter = 0;
+
+	if (!data)
+		return NULL;
+
+	if (!cont || !cont->iov_len || !cont->iov_base)
+		return data->iov_base;
+
+	if (add_delimiter)
+		iov_append(data, sizeof(delimiter), &delimiter);
+
+	return iov_append(data, cont->iov_len, cont->iov_base);
+}
+
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 {
 	struct bt_bap_req *req;
@@ -5245,10 +5331,15 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 	if (queue_find(stream->links, NULL, link))
 		return -EALREADY;
 
-	if (stream->client != link->client ||
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
+		if (stream->qos.bcast.big != link->qos.bcast.big)
+			return -EINVAL;
+	} else {
+		if (stream->client != link->client ||
 			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
 			stream->qos.ucast.cis_id != link->qos.ucast.cis_id)
-		return -EINVAL;
+			return -EINVAL;
+	}
 
 	if (!stream->links)
 		stream->links = queue_new();
@@ -5377,7 +5468,9 @@ int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_io_connecting(stream, INT_TO_PTR(fd));
 
-	queue_foreach(stream->links, bap_stream_io_connecting, INT_TO_PTR(fd));
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, bap_stream_io_connecting,
+						INT_TO_PTR(fd));
 
 	return 0;
 }
@@ -5433,11 +5526,58 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
 	return true;
 }
 
+static bool bt_bap_new_bcast_sink(struct bt_bap *bap)
+{
+	struct bt_bap_endpoint *ep;
+
+	/* Push remote endpoint with direction source */
+	ep = bap_endpoint_new_broadcast(bap->ldb, BT_BAP_BCAST_SOURCE);
+
+	if (ep)
+		queue_push_tail(bap->remote_eps, ep);
+
+	ep->bap = bap;
+	return true;
+}
+
+static void bis_to_pac(void *data, void *user_data)
+{
+	struct bt_bap_bis *bis = data;
+	struct bt_bap_base_subgroup *subgroup = user_data;
+	struct bt_bap_pac *pac_source_bis;
+	struct bt_bap_endpoint *ep;
+	int err = 0;
+
+	bt_bap_ltv_merge(bis->caps, subgroup->caps, false);
+	pac_source_bis = bap_pac_new(subgroup->bap->rdb, NULL,
+				BT_BAP_BCAST_SOURCE, &subgroup->codec, NULL,
+				bis->caps, subgroup->meta);
+
+	err = asprintf(&pac_source_bis->name, "%d", bis->bisIndex);
+
+	if (err < 0)
+		DBG(subgroup->bap, "error in asprintf");
+
+		/* Add remote source endpoint */
+	if (!subgroup->bap->rdb->broadcast_sources)
+		subgroup->bap->rdb->broadcast_sources = queue_new();
+	queue_push_tail(subgroup->bap->rdb->broadcast_sources, pac_source_bis);
+
+	queue_foreach(subgroup->bap->pac_cbs, notify_pac_added, pac_source_bis);
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(subgroup->bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(subgroup->bap->remote_eps, ep);
+}
+static void parse_bis(void *data, void *user_data)
+{
+	struct bt_bap_base_subgroup *subgroup = data;
+
+	queue_foreach(subgroup->bises, bis_to_pac, subgroup);
+}
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata)
+				struct bt_bap_base *base)
 {
-	bap_pac_merge(pac, data, metadata);
-	pac->codec = *codec;
+	queue_foreach(base->subgroups, parse_bis, NULL);
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c8f9208e..ea49b13a4 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -97,6 +97,27 @@ struct bt_bap_qos {
 	};
 };
 
+struct bt_bap_base {
+	uint32_t presDelay;
+	uint8_t numSubgroups;
+	struct queue *subgroups;
+};
+
+struct bt_bap_base_subgroup {
+	uint8_t subGroupIndex;
+	struct bt_bap *bap;
+	uint8_t numBises;
+	struct bt_bap_codec codec;
+	struct iovec *caps;
+	struct iovec *meta;
+	struct queue *bises;
+};
+
+struct bt_bap_bis {
+	uint8_t bisIndex;
+	struct iovec *caps;
+};
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
@@ -168,6 +189,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac);
 
 uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
@@ -176,6 +199,8 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
+struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
@@ -231,6 +256,7 @@ int bt_bap_pac_get_codec(struct bt_bap_pac *pac, uint8_t *id,
 
 void bt_bap_pac_set_user_data(struct bt_bap_pac *pac, void *user_data);
 void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac);
 
 /* Stream related functions */
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -314,9 +340,9 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
 
 bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata);
+				struct bt_bap_base *base);
+void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
+						bool add_delimiter);
 
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index adade07db..d308d42f9 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -377,11 +377,13 @@ static void test_client_config(struct test_data *data)
 							"test-bap-snk",
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		else
 			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
 							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		g_assert(data->snk);
 	}
 
@@ -391,11 +393,13 @@ static void test_client_config(struct test_data *data)
 							"test-bap-src",
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		else
 			data->src = bt_bap_add_pac(data->db, "test-bap-src",
 							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL);
 		g_assert(data->src);
 	}
 }
-- 
2.39.2

