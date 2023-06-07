Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F1BC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 12:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbjFGMOZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbjFGMOW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 08:14:22 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6E1BD8
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 05:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJN4doBa2bw6NDCGSZ4ylQVeeFcFjXFUTuLYpFrSMyXcKazSDnf1HvOMibo+HHcgi3SrAU0inHDmjs3PfN2/iUDIVyZMXW4Lh9q8HQ5+nMIwobS84W022ynSlVKq3WGwQtMKFVPe/ccegEtHzQ4FuXQ7kjKtWRwEDP40GE2L5C8T2FMbdDwICW77hovxJacVbwMbLapkXl4YoUFUG59ymxqpfl7VJ/TMoAiTaP5QjzMx76tmvcq9kU4jlAcZJPAUuaGya7vjd9lqjiigjTAdakdsfWxDxesrKV62fZGKcmAb+B9oLty4p2UC3wukVl9UKh+PVxJIZbacvO9JDPxaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VdJrrgsoYmzClxNlDtXp5U62qtfa2xsLXVBOLCo+Qk=;
 b=Cn6qAD3yqv+7Z1mYoffGRpd30lWviFtbJXlPOb+HmZuug8HHkNbRgHcc8MYoKrfCRT41/nF60Pbsx0hb+Hnofz5x0CFgSr3ylalzaIltLx/xR6OD4oiT6o9yKkP46hv3o7eJW88Wra1ugEJYhYxnpIdx0MbfTGnNjYM1rxdEC8hgT0fdG890PWJSMKxAJn/HpR50WarjqewFVYs2wFUNFJXxj3UAxkGy1qOo4/RPhvdDadmQlaKOi1u1AVG+NctfMb0IVxEg9ZS2WryyVxZIHkQQ7TWRed71TRb+tKnT7K95Y7dHfnjPZrVTx9FXOjIBI+relNC9L+9iDgaTR/wkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VdJrrgsoYmzClxNlDtXp5U62qtfa2xsLXVBOLCo+Qk=;
 b=a1l+nXqa9rSGsNz0/CpfSgkx6B/+YqZIk525zhiCzEu+KmGF0j3Zx1mwCWyBji8vwsztRU2wuVzm255mW/02ObWbXyjE4gtYyeHwfdeaC6Y9IYsZIDDVdY7oTey9UD0tu5IiL0YFXBXNfoelFyoMuunHdg7b1DsHrpW4N3tCPH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:14:15 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:14:15 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 1/2] Added initial code for handling VOCS
Date:   Wed,  7 Jun 2023 15:13:41 +0300
Message-Id: <20230607121342.6136-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607121342.6136-1-nitin.jadhav@nxp.com>
References: <20230607121342.6136-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9bea25-1554-4058-031d-08db6750b64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHpCvgiyEL4V4SduvpjfHhRyDBhBr0/pU5zGqJE07tBHAsYbSXl0ALktUPVOYUn5PJ8VIJpqObsMyYLXnFv2AMi0wDy3iPfCNGtLdIpuxxwj4xYLurzxJlkDeH6oF/M8ML/8hGqhklIVYgfYBMYO7c9KAuFdEu1r0+1OWbKilFMG7f+don4bf9Ax8/zeoWDiPKGUkwPPywdyFMexq1ds44EY0Thm9DDwkCjh2zeBqBloHzkS6sHuxQD2keN5viMFDkdBWmgFqJsUVa9UfMNoIvU4/N6h6/vARO6aO15FLgiU0H3KZK1W4gf2QNMDOKkLd0SVmUKmTrZvGq5bUjedG6qlL5jfii67pEFcoKGLOXGhOZZppECnfywwq/n7dN/lmASO3R3pIW3LntXRbm0i/AQj3jPVHOivB6i74W+y+UN4xZVTELAUv+dOZxlB/X+A57OF9bLRTlOGHxYf0zYF/itZ44/x9HBGD+bVrIo7UPdSLmokmZOlUb3/t/ZuCE0J+B02xuHxwESQufXXN8qQcGK9VFSEneZbjor2ax1qSppiuSMqoNiafRm8m9ocLISj1LcZZNrSa6LovvBXKuBOSzsDV3byZIeviVYr/x29ognhfICoUdCKWyhNeAig+XdG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(478600001)(5660300002)(8936002)(44832011)(8676002)(36756003)(86362001)(2906002)(30864003)(66556008)(66476007)(6916009)(66946007)(316002)(4326008)(6506007)(41300700001)(38350700002)(2616005)(38100700002)(6512007)(1076003)(26005)(83380400001)(6486002)(52116002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hCHz4d2gNkNG1xzBl7tkcJ/5QPCGyYN/QL6iGE6Vp9f0/WIFl71Dz2Jh6UN7?=
 =?us-ascii?Q?1cpH1QGNTiRRPjKBJuOYgaIZegt6B5NlFff1vO7k5u+dUERHEdeR5Glj7KSE?=
 =?us-ascii?Q?sU+MxS/J0slXR1z5/5x35UyaINrM8anZCTRKdEhfRtRQdjTJMCwtwUWjtU4W?=
 =?us-ascii?Q?Ohi8TM/MKM3DTgikqn4B+3lShl8DUFF+/pZxkrcIAr6mM/tudnTgDx/Fgzuc?=
 =?us-ascii?Q?XPKApvTXl1UjIEkDL8aMKADI/tXtq89x9pmPLf0xGvcK97AMJk38f43h73Nj?=
 =?us-ascii?Q?i/7qx6J82S8OztdmywCqHNTW2nwVGJ36x8gfk3AS20gtvCPfRVoSnpxG3gaB?=
 =?us-ascii?Q?MqpqQb07VX4cx7Xdgl0bCe5lpexUBuxbVmmytCZHIASFxC88whxUmXAn4bRk?=
 =?us-ascii?Q?t4inyzFvwkRR9a7+aQLkdw8uXw5K5O6hj364JcmkvHXvWWGlXO50dlhSazeI?=
 =?us-ascii?Q?RkInpa0MweK4B79H6IYa2doNZSgnUtWFhQK4t9eFQpPgp2NADhXhfPxzoec0?=
 =?us-ascii?Q?U3aykPttXfu18WN+8wXzEk8vQCv9Px4DU/ikyydddmsAp5IFL8JwNv8DKOBU?=
 =?us-ascii?Q?2zqZgbT2Xl8AjD8kQAxPkDpONyFe2qf4xAhWjAcSR8PDfM3VnZkrtdow+uUc?=
 =?us-ascii?Q?NLcAh+B77kDIlhL7nAk6rBTAXRMEm3LeBls/iRpCyJeJg6YL7wnrZfrJXbHw?=
 =?us-ascii?Q?7EzWYeVJJjiFp7v77OKDbUX5sycgk0lmPSFmguxNefVdVssM8NskV6xdjXDO?=
 =?us-ascii?Q?pGj0vYA3JIwrd8tZXb6DhpuT8pajrSp5ZL3vVOH+TpbIqdTwzeeDqS8NG12j?=
 =?us-ascii?Q?8x0juAIuxQP/0Te9UCGInq5yEYiVfc2y/u8xTgfLmDvpZLKRjnK0V7Kt5rVe?=
 =?us-ascii?Q?MEv8ZV9zAYXnxlYnV/BA3/Dv6awqHmXXQjlNE6u9NiBMFTIATJX6lgeb/UYK?=
 =?us-ascii?Q?/QpMG5b7zHcvK5BDzOaE/tM7rGE7a9oXu6Hq51xq06GEF22LnFx7HKASV0sL?=
 =?us-ascii?Q?i0M0X8L3Yf/x7LWgqW3FZ8Su9mxZIynT0TqKPdtgg8lKwNk1EkCuXd603/Rg?=
 =?us-ascii?Q?vf5NXRWwFpFwQX+uiy0ksygxsYkaX4LZcuzJ/Xsny+oop3KaFKXUOedPOQOd?=
 =?us-ascii?Q?vQZal9qvLW54MoP1O1K6GDZUC4VilowCQKJKt1zEtcRINN+RRsgvTNel+M1q?=
 =?us-ascii?Q?YxUwoLGV57w1RRG+hqGyKacfg91zzstbPWpoCQDZb5vhD4F1F+XiCKLCxi3N?=
 =?us-ascii?Q?6biFF27NsM0c4t+f8gTq3Ik4xH8sb95/7B3aplbNk3ZP/fAUt/+Z9sWs2Qws?=
 =?us-ascii?Q?yzz3ZGv6pC3k+NNcQcqg1Fp8qZd73EmtSJ5doUakrQCy5elaavsO71i0COWF?=
 =?us-ascii?Q?43QVpDrlPitGBJ1qWG+Zr+QRdKfYOBXwT5v3Y6RLsZk8RXZ1tu4nJ5Li+zXt?=
 =?us-ascii?Q?RUaeg2R5dyhvZtxWV5mCva7nSkut8vaY7/hZFz67R5ZOgAi2hw87qNuXjgUl?=
 =?us-ascii?Q?CYZzDzbHOsqztbqvF59hP9Ki/zdwcYgp8cvdFlkLcN/jN02mKLzDkmkYZbd1?=
 =?us-ascii?Q?97CkT6YVPJ4L4bFNI2l/uUGwDk4PbvbEE2k+hi0K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9bea25-1554-4058-031d-08db6750b64a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:14:15.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPuPpljHmB17jyDEqDBYcqw80uEwUcVV/fGtfItslOkgeyPHoziPIdnyOfsbY747kfPKRD5+wXmYEPOr+9dqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation for VOCS service and characteristics
---
v2: Corrected prefixs and cosmetic changes (Luiz Augusto von Dentz)
---
 lib/uuid.h       |   5 +
 src/shared/vcp.c | 537 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 542 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 5cdfedb4b..cd3b3655f 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -179,6 +179,11 @@ extern "C" {
 #define VOL_CP_CHRC_UUID				0x2B7E
 #define VOL_FLAG_CHRC_UUID				0x2B7F
 
+#define VOCS_STATE_CHAR_UUID			0x2B80
+#define VOCS_AUDIO_LOC_CHRC_UUID		0x2B81
+#define VOCS_CP_CHRC_UUID			0x2B82
+#define VOCS_AUDIO_OP_DESC_CHAR_UUID		0x2B83
+
 #define GMCS_UUID                               0x1849
 #define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
 #define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 5459cf892..e9bd6e88b 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -36,9 +36,40 @@
 #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER	0x80
 #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED	0x81
 
+#define BT_VCP_NA                   0x00000000
+#define BT_VCP_FRONT_LEFT           0x00000001
+#define BT_VCP_FRONT_RIGHT          0x00000002
+#define BT_VCP_FRONT_CENTER         0x00000004
+#define BT_VCP_LOW_FRQ_EFF_1        0x00000008
+#define BT_VCP_BACK_LEFT            0x00000010
+#define BT_VCP_BACK_RIGHT           0x00000020
+#define BT_VCP_FRONT_LEFT_CENTER    0x00000040
+#define BT_VCP_FRONT_RIGHT_CENTER   0x00000080
+#define BT_VCP_BACK_CENTER          0x00000100
+#define BT_VCP_LOW_FRQ_EFF_2        0x00000200
+#define BT_VCP_SIDE_LEFT            0x00000400
+#define BT_VCP_SIDE_RIGHT           0x00000800
+#define BT_VCP_TOP_FRONT_LEFT       0x00001000
+#define BT_VCP_TOP_FRONT_RIGHT      0x00002000
+#define BT_VCP_TOP_FRONT_CENTER     0x00004000
+#define BT_VCP_TOP_CENTER           0x00008000
+#define BT_VCP_TOP_BACK_LEFT        0x00010000
+#define BT_VCP_TOP_BACK_RIGHT       0x00020000
+#define BT_VCP_TOP_SIDE_LEFT        0x00040000
+#define BT_VCP_TOP_SIDE_RIGHT       0x00080000
+#define BT_VCP_TOP_BACK_CENTER      0x00100000
+#define BT_VCP_BOTTOM_FRONT_CENTER  0x00200000
+#define BT_VCP_BOTTOM_FRONT_LEFT    0x00400000
+#define BT_VCP_BOTTOM_FRONT_RIGHT   0x00800000
+#define BT_VCP_FRONT_LEFT_WIDE      0x01000000
+#define BT_VCP_FRONT_RIGHT_WIDE     0x02000000
+#define BT_VCP_LEFT_SURROUND        0x04000000
+#define BT_VCP_RIGHT_SURROUND       0x08000000
+
 struct bt_vcp_db {
 	struct gatt_db *db;
 	struct bt_vcs *vcs;
+	struct bt_vocs *vocs;
 };
 
 typedef void (*vcp_func_t)(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
@@ -57,11 +88,21 @@ struct bt_vcs_param {
 	uint8_t	change_counter;
 } __packed;
 
+struct bt_vocs_param {
+	uint8_t	op;
+	uint8_t	change_counter;
+} __packed;
+
 struct bt_vcs_ab_vol {
 	uint8_t	change_counter;
 	uint8_t	vol_set;
 } __packed;
 
+struct bt_vocs_set_vol_off {
+	uint8_t	change_counter;
+	uint8_t	set_vol_offset;
+} __packed;
+
 struct bt_vcp_cb {
 	unsigned int id;
 	bt_vcp_func_t attached;
@@ -89,6 +130,10 @@ struct bt_vcp {
 	unsigned int vstate_id;
 	unsigned int vflag_id;
 
+	unsigned int state_id;
+	unsigned int audio_loc_id;
+	unsigned int ao_dec_id;
+
 	struct queue *notify;
 	struct queue *pending;
 
@@ -120,6 +165,27 @@ struct bt_vcs {
 	struct gatt_db_attribute *vf_ccc;
 };
 
+/* Contains local bt_vcp_db */
+struct vol_offset_state {
+	uint16_t vol_offset;
+	uint8_t counter;
+} __packed;
+
+struct bt_vocs {
+	struct bt_vcp_db *vdb;
+	struct vol_offset_state *vostate;
+	uint32_t vocs_audio_loc;
+	char *vocs_ao_dec;
+	struct gatt_db_attribute *service;
+	struct gatt_db_attribute *vos;
+	struct gatt_db_attribute *vos_ccc;
+	struct gatt_db_attribute *voal;
+	struct gatt_db_attribute *voal_ccc;
+	struct gatt_db_attribute *vo_cp;
+	struct gatt_db_attribute *voaodec;
+	struct gatt_db_attribute *voaodec_ccc;
+};
+
 static struct queue *vcp_db;
 static struct queue *vcp_cbs;
 static struct queue *sessions;
@@ -159,6 +225,17 @@ static struct vol_state *vdb_get_vstate(struct bt_vcp_db *vdb)
 	return NULL;
 }
 
+static struct vol_offset_state *vdb_get_vostate(struct bt_vcp_db *vdb)
+{
+	if (!vdb->vocs)
+		return NULL;
+
+	if (vdb->vocs->vostate)
+		return vdb->vocs->vostate;
+
+	return NULL;
+}
+
 static struct bt_vcs *vcp_get_vcs(struct bt_vcp *vcp)
 {
 	if (!vcp)
@@ -173,6 +250,20 @@ static struct bt_vcs *vcp_get_vcs(struct bt_vcp *vcp)
 	return vcp->rdb->vcs;
 }
 
+static struct bt_vocs *vcp_get_vocs(struct bt_vcp *vcp)
+{
+	if (!vcp)
+		return NULL;
+
+	if (vcp->rdb->vocs)
+		return vcp->rdb->vocs;
+
+	vcp->rdb->vocs = new0(struct bt_vocs, 1);
+	vcp->rdb->vocs->vdb = vcp->rdb;
+
+	return vcp->rdb->vocs;
+}
+
 static void vcp_detached(void *data, void *user_data)
 {
 	struct bt_vcp_cb *cb = data;
@@ -202,6 +293,7 @@ static void vcp_db_free(void *data)
 	gatt_db_unref(vdb->db);
 
 	free(vdb->vcs);
+	free(vdb->vocs);
 	free(vdb);
 }
 
@@ -583,6 +675,45 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 	return 0;
 }
 
+static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
+				struct iovec *iov)
+{
+	struct bt_vcp_db *vdb;
+	struct vol_offset_state *vstate;
+	struct bt_vocs_set_vol_off *req;
+
+	DBG(vcp, "Set Volume Offset");
+
+	vdb = vcp_get_vdb(vcp);
+	if (!vdb) {
+		DBG(vcp, "error: VDB not available");
+		return 0;
+	}
+
+	vstate = vdb_get_vostate(vdb);
+	if (!vstate) {
+		DBG(vcp, "error: VSTATE not available");
+		return 0;
+	}
+
+	req = iov_pull_mem(iov, sizeof(*req));
+	if (!req)
+		return 0;
+
+	if (req->change_counter != vstate->counter) {
+		DBG(vcp, "Change Counter Mismatch Volume not decremented!");
+		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
+	}
+
+	vstate->vol_offset = req->set_vol_offset;
+	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
+
+	gatt_db_attribute_notify(vdb->vocs->vos, (void *)vstate,
+				 sizeof(struct vol_offset_state),
+				 bt_vcp_get_att(vcp));
+	return 0;
+}
+
 #define	BT_VCS_REL_VOL_DOWN		0x00
 #define	BT_VCS_REL_VOL_UP		0x01
 #define	BT_VCS_UNMUTE_REL_VOL_DOWN	0x02
@@ -591,6 +722,8 @@ static uint8_t vcs_mute(struct bt_vcs *vcs, struct bt_vcp *vcp,
 #define	BT_VCS_UNMUTE			0x05
 #define	BT_VCS_MUTE			0x06
 
+#define BT_VOCS_SET_VOL_OFFSET	0x01
+
 #define VCS_OP(_str, _op, _size, _func) \
 	{ \
 		.str = _str, \
@@ -623,6 +756,26 @@ struct vcs_op_handler {
 	{}
 };
 
+#define VOCS_OP(_str, _op, _size, _func) \
+	{ \
+		.str = _str, \
+		.op = _op, \
+		.size = _size, \
+		.func = _func, \
+	}
+
+struct vocs_op_handler {
+	const char *str;
+	uint8_t	op;
+	size_t	size;
+	uint8_t	(*func)(struct bt_vocs *vocs, struct bt_vcp *vcp,
+			struct iovec *iov);
+} vocp_handlers[] = {
+	VOCS_OP("Set Volume Offset", BT_VOCS_SET_VOL_OFFSET,
+		sizeof(uint8_t), vocs_set_vol_offset),
+	{}
+};
+
 static void vcs_cp_write(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				const uint8_t *value, size_t len,
@@ -683,6 +836,66 @@ respond:
 	gatt_db_attribute_write_result(attrib, id, ret);
 }
 
+static void vocs_cp_write(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *value, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_vocs *vocs = user_data;
+	struct bt_vcp *vcp = vcp_get_session(att, vocs->vdb->db);
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = len,
+	};
+	uint8_t	*vcp_op;
+	struct vocs_op_handler *handler;
+	uint8_t ret = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+
+	DBG(vcp, "VOCP Control Point Write");
+
+	if (offset) {
+		DBG(vcp, "invalid offset %d", offset);
+		ret = BT_ATT_ERROR_INVALID_OFFSET;
+		goto respond;
+	}
+
+	if (len < sizeof(*vcp_op)) {
+		DBG(vcp, "invalid len %ld < %ld sizeof(*param)", len,
+							sizeof(*vcp_op));
+		ret = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto respond;
+	}
+
+	vcp_op = iov_pull_mem(&iov, sizeof(*vcp_op));
+
+	for (handler = vocp_handlers; handler && handler->str; handler++) {
+		if (handler->op != *vcp_op)
+			continue;
+
+		if (iov.iov_len < handler->size) {
+			DBG(vcp, "invalid len %ld < %ld handler->size", len,
+			    handler->size);
+			ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
+			goto respond;
+		}
+
+		break;
+	}
+
+	if (handler && handler->str) {
+		DBG(vcp, "%s", handler->str);
+
+		ret = handler->func(vocs, vcp, &iov);
+	} else {
+		DBG(vcp, "Unknown opcode 0x%02x", *vcp_op);
+		ret = BT_ATT_ERROR_OPCODE_NOT_SUPPORTED;
+	}
+
+respond:
+	gatt_db_attribute_write_result(attrib, id, ret);
+}
+
 static void vcs_state_read(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				uint8_t opcode, struct bt_att *att,
@@ -698,6 +911,21 @@ static void vcs_state_read(struct gatt_db_attribute *attrib,
 							iov.iov_len);
 }
 
+static void vocs_state_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_vocs *vocs = user_data;
+	struct iovec iov;
+
+	iov.iov_base = vocs->vostate;
+	iov.iov_len = sizeof(*vocs->vostate);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
 static void vcs_flag_read(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				uint8_t opcode, struct bt_att *att,
@@ -713,6 +941,36 @@ static void vcs_flag_read(struct gatt_db_attribute *attrib,
 							iov.iov_len);
 }
 
+static void vocs_voal_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_vocs *vocs = user_data;
+	struct iovec iov;
+
+	iov.iov_base = &vocs->vocs_audio_loc;
+	iov.iov_len = sizeof(vocs->vocs_audio_loc);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
+static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct bt_vocs *vocs = user_data;
+	struct iovec iov;
+
+	iov.iov_base = &vocs->vocs_ao_dec;
+	iov.iov_len = strlen(vocs->vocs_ao_dec);
+
+	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
+							iov.iov_len);
+}
+
 static struct bt_vcs *vcs_new(struct gatt_db *db)
 {
 	struct bt_vcs *vcs;
@@ -771,6 +1029,74 @@ static struct bt_vcs *vcs_new(struct gatt_db *db)
 	return vcs;
 }
 
+static struct bt_vocs *vocs_new(struct gatt_db *db)
+{
+	struct bt_vocs *vocs;
+	struct vol_offset_state *vostate;
+	bt_uuid_t uuid;
+
+	if (!db)
+		return NULL;
+
+	vocs = new0(struct bt_vocs, 1);
+
+	vostate = new0(struct vol_offset_state, 1);
+
+	vocs->vostate = vostate;
+	vocs->vocs_audio_loc = BT_VCP_FRONT_LEFT;
+	vocs->vocs_ao_dec = "Left Speaker";
+
+	/* Populate DB with VOCS attributes */
+	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
+	vocs->service = gatt_db_add_service(db, &uuid, true, 9);
+
+	bt_uuid16_create(&uuid, VOCS_STATE_CHAR_UUID);
+	vocs->vos = gatt_db_service_add_characteristic(vocs->service,
+					&uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_NOTIFY,
+					vocs_state_read, NULL,
+					vocs);
+
+	vocs->vos_ccc = gatt_db_service_add_ccc(vocs->service,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, VOCS_AUDIO_LOC_CHRC_UUID);
+	vocs->voal = gatt_db_service_add_characteristic(vocs->service,
+					&uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_NOTIFY,
+					vocs_voal_read, NULL,
+					vocs);
+
+	vocs->voal_ccc = gatt_db_service_add_ccc(vocs->service,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	bt_uuid16_create(&uuid, VOCS_CP_CHRC_UUID);
+	vocs->vo_cp = gatt_db_service_add_characteristic(vocs->service,
+					&uuid,
+					BT_ATT_PERM_WRITE,
+					BT_GATT_CHRC_PROP_WRITE,
+					NULL, vocs_cp_write,
+					vocs);
+
+	bt_uuid16_create(&uuid, VOCS_AUDIO_OP_DESC_CHAR_UUID);
+	vocs->voaodec = gatt_db_service_add_characteristic(vocs->service,
+					&uuid,
+					BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ |
+					BT_GATT_CHRC_PROP_NOTIFY,
+					vocs_voaodec_read, NULL,
+					vocs);
+
+	vocs->voaodec_ccc = gatt_db_service_add_ccc(vocs->service,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE);
+
+	return vocs;
+}
+
 static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
 {
 	struct bt_vcp_db *vdb;
@@ -787,6 +1113,9 @@ static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
 	vdb->vcs = vcs_new(db);
 	vdb->vcs->vdb = vdb;
 
+	vdb->vocs = vocs_new(db);
+	vdb->vocs->vdb = vdb;
+
 	queue_push_tail(vcp_db, vdb);
 
 	return vdb;
@@ -911,6 +1240,41 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
 	DBG(vcp, "Vol Counter 0x%x", vstate.counter);
 }
 
+static void vcp_voffset_state_notify(struct bt_vcp *vcp, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct vol_offset_state vostate;
+
+	memcpy(&vostate, value, sizeof(struct vol_offset_state));
+
+	DBG(vcp, "Vol Offset 0x%x", vostate.vol_offset);
+	DBG(vcp, "Vol Offset Counter 0x%x", vostate.counter);
+}
+
+static void vcp_audio_loc_notify(struct bt_vcp *vcp, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	uint32_t *vocs_audio_loc_n = 0;
+
+	memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
+
+	DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
+}
+
+
+static void vcp_audio_descriptor_notify(struct bt_vcp *vcp,
+				uint16_t value_handle, const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	char vocs_audio_dec_n[256] = {'\0'};
+
+	memcpy(vocs_audio_dec_n, value, length);
+
+	DBG(vcp, "VOCS Audio Descriptor 0x%s", *vocs_audio_dec_n);
+}
+
 static void vcp_vflag_notify(struct bt_vcp *vcp, uint16_t value_handle,
 			     const uint8_t *value, uint16_t length,
 			     void *user_data)
@@ -972,6 +1336,81 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 	DBG(vcp, "Vol Counter:%x", vs->counter);
 }
 
+static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
+				uint8_t att_ecode, const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	struct vol_offset_state *vos;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(vcp, "Unable to read Vol Offset State: error 0x%02x", att_ecode);
+		return;
+	}
+
+	vos = iov_pull_mem(&iov, sizeof(*vos));
+	if (!vos) {
+		DBG(vcp, "Unable to get Vol Offset State");
+		return;
+	}
+
+	DBG(vcp, "Vol Set:%x", vos->vol_offset);
+	DBG(vcp, "Vol Counter:%x", vos->counter);
+}
+
+static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
+				uint8_t att_ecode, const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	uint32_t *vocs_audio_loc;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x", att_ecode);
+		return;
+	}
+
+	vocs_audio_loc = iov_pull_mem(&iov, sizeof(uint32_t));
+	if (!*vocs_audio_loc) {
+		DBG(vcp, "Unable to get VOCS Audio Location");
+		return;
+	}
+
+	DBG(vcp, "VOCS Audio Loc:%x", *vocs_audio_loc);
+}
+
+
+static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
+				uint8_t att_ecode, const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	char *vocs_ao_dec_r;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x",
+			att_ecode);
+		return;
+	}
+
+	vocs_ao_dec_r = iov_pull_mem(&iov, length);
+	if (!*vocs_ao_dec_r) {
+		DBG(vcp, "Unable to get VOCS Audio Descriptor");
+		return;
+	}
+
+	DBG(vcp, "VOCS Audio Descriptor:%s", *vocs_ao_dec_r);
+}
+
 static void vcp_pending_destroy(void *data)
 {
 	struct bt_vcp_pending *pending = data;
@@ -1128,6 +1567,88 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
 	}
 }
 
+static void foreach_vocs_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_vostate, uuid_audio_loc, uuid_vo_cp,
+			uuid_audio_op_decs;
+	struct bt_vocs *vocs;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_vostate, VOCS_STATE_CHAR_UUID);
+	bt_uuid16_create(&uuid_audio_loc, VOCS_AUDIO_LOC_CHRC_UUID);
+	bt_uuid16_create(&uuid_vo_cp, VOCS_CP_CHRC_UUID);
+	bt_uuid16_create(&uuid_audio_op_decs, VOCS_AUDIO_OP_DESC_CHAR_UUID);
+
+	if (!bt_uuid_cmp(&uuid, &uuid_vostate)) {
+		DBG(vcp, "VOCS Vol state found: handle 0x%04x", value_handle);
+
+		vocs = vcp_get_vocs(vcp);
+		if (!vocs || vocs->vos)
+			return;
+
+		vocs->vos = attr;
+
+		vcp_read_value(vcp, value_handle, read_vol_offset_state, vcp);
+
+		vcp->state_id = vcp_register_notify(vcp, value_handle,
+						     vcp_voffset_state_notify, NULL);
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_audio_loc)) {
+		DBG(vcp, "VOCS Volume Audio Location found: handle 0x%04x",
+			value_handle);
+
+		vocs = vcp_get_vocs(vcp);
+		if (!vocs || vocs->voal)
+			return;
+
+		vocs->voal = attr;
+
+		vcp_read_value(vcp, value_handle, read_vocs_audio_location, vcp);
+
+		vcp->audio_loc_id = vcp_register_notify(vcp, value_handle,
+						     vcp_audio_loc_notify, NULL);
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_vo_cp)) {
+		DBG(vcp, "VOCS Volume CP found: handle 0x%04x", value_handle);
+
+		vocs = vcp_get_vocs(vcp);
+		if (!vocs || vocs->vo_cp)
+			return;
+
+		vocs->vo_cp = attr;
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_audio_op_decs)) {
+		DBG(vcp, "VOCS Vol Audio Descriptor found: handle 0x%04x",
+			value_handle);
+
+		vocs = vcp_get_vocs(vcp);
+		if (!vocs || vocs->voaodec)
+			return;
+
+		vocs->voaodec = attr;
+
+		vcp_read_value(vcp, value_handle, read_vocs_audio_descriptor, vcp);
+		vcp->ao_dec_id = vcp_register_notify(vcp, value_handle,
+						    vcp_audio_descriptor_notify, NULL);
+
+	}
+
+}
+
 static void foreach_vcs_service(struct gatt_db_attribute *attr,
 						void *user_data)
 {
@@ -1141,6 +1662,19 @@ static void foreach_vcs_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(attr, foreach_vcs_char, vcp);
 }
 
+static void foreach_vocs_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+	struct bt_vocs *vocs = vcp_get_vocs(vcp);
+
+	vocs->service = attr;
+
+	gatt_db_service_set_claimed(attr, true);
+
+	gatt_db_service_foreach_char(attr, foreach_vocs_char, vcp);
+}
+
 bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
@@ -1163,6 +1697,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	bt_uuid16_create(&uuid, VCS_UUID);
 	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service, vcp);
 
+	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
+	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service, vcp);
+
 	return true;
 }
 
-- 
2.34.1

