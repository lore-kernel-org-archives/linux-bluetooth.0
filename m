Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C64C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jun 2023 12:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjFFMJZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jun 2023 08:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjFFMJW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jun 2023 08:09:22 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BD4E7E
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 05:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw7mr/p+z8uaYCrWkRYOxgUsPEhjWFVd9lRvj/UBDnlA+lLvIoYbwEAwP5wRg0/9PoMsitljEP1t8EdkB521EC7rlAljrU1B4qQgs2AxQ37yEC9UiKsCGW+82tp9DLTvgAhyhOfCSB4rG6A3b0nzooUZYu2GmKXKvDYgnRnzatymgBFW/he49BcRAFKrzm5OWdfcdZq6R2JzjSk8bKuQY+NRIaFk7xpa6LhRd6RbOrpUaG8wIIhPBLObaJjFnRwrbS0c0XI39+Wv4hLjyeOfQEl65kDzzR5MVJ4k7ZNiXtOBjd/EEikWUxsZnKLsBZRbZs9OPbvGO5HFICXN0nseUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yv5DfZIOdnFjSB8ExsDmNUXFNKUd+xcMd0XGjXkO4mA=;
 b=ggUn7yrDdN+Lf2g9LqbKRzx257POSytECKrqwFZA1Kw9aZ3SSN22VTDwHhzMgZLfZ5lPJKco/fSSKM5n/LaOzr+sTt1azNar5K+BX5DWuqmSPr0SrLMQjTBRUVpk2YphrjCyf4+/k2wWNjv54sc+vGKNTz89G5l2tAM5jOiT3is/EZiH/jkhevzF9OCh+TAIfhtkTSs+TNq4Yx2uZWR1yLd33aFlg7UD/ba0JWfa2FwKCX6rXc0pZs8j2ScLjlX0aMH1ay4khcUVAaOY+gq9rhOwNqZFUD9Eh4EQUpb1dmg6z7gTMm10J1KpCI5Ndbg/Fg4c01dUiOkUJyzMCK1RZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yv5DfZIOdnFjSB8ExsDmNUXFNKUd+xcMd0XGjXkO4mA=;
 b=QC/m+XAMMeeI7LKRgTUtGhofc+s45Wnt3+FeYCFHRMUEFGtEBg9IBCd03fLsg+F9u+eFZ+q/1we+b8XuiS+ScRod7WEK/vL1wlu4cAlP2mJRW6zyZrlTiKajzu7YSuX6/7/zK3tnpBOG8kKFLH6dAQBXgenW8Tmxb/VQO1UpW/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 12:09:16 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 12:09:16 +0000
From:   NJNXP <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v1 1/2] Added initial code for handling VOCS
Date:   Tue,  6 Jun 2023 15:08:23 +0300
Message-Id: <20230606120824.4705-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606120824.4705-1-nitin.jadhav@nxp.com>
References: <20230606120824.4705-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|DU2PR04MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 8905bf19-7474-483b-65c8-08db6686d992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsGKNrdGoARs1ggMpwGzi9zeH5riqT2QyZi5Mx2f+o215r+H5z5QWidJKkkYKr7sLJl/qbhNSw/uKiJsCvxNzEMZgoXFqBvA/Pzf8d/mAKdOGMMpqMKZBttnEQczSJOWoN4Bhz2bwbuuVehmHDHQ4sp9A8CYdOMPeHWe6//0m5+2WiY5VyuSVL/jfhN8sOGGS11n7SzoOPmLyxNKzER/Fpgy6HcUvjcrgN/DH+gfx+uR7y0DLktKZakQTLKfWt6leD2+UB4uSqqif+CpKu6f2IdW2EMuPXxlvB/nCYvXiUE3Ld2OnVM8h+XFPgo7Ov8ki9A39zv3q7QMol8siZs9toDZlgIBKy48Wd1GyiL3xGn5WDAUYeq3xWXbDc00JIjw0JCG93wxZtH2JeFtUMXsCZbd4phCMciJIOD17TLlx9Ey9xoT2jf6MbWIT2PP8d45Qk3dm4/V7WIhivVQ1y9S6SbyEaVn4yPEv7YC3r5Q4zcDn4MmjGvXprvecMJzjjDvsIEqGR2jujjGiMcWwPyIComtu/Bo40KnPhgo5dKWINcNvrzwmtA3QHyQBHwASCFOGUNrMCw5Cb7bbH7DzaG1pa55fUvQArSP5zPdl9fEYfFknav3IiKZtBXcTROCfL6D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(6666004)(26005)(186003)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(4326008)(5660300002)(8676002)(8936002)(2906002)(30864003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1jQJ/BgjLxemZx6A0fqL/8oXKwYvk9dBbyvpMWdV14jc2Q5vgrul4NzjZiom?=
 =?us-ascii?Q?26x2e4RBQvTctq+IthAsQfCPIm/cyk4A2RQu1kWLNrmOvaVoHp0N+5IwWDka?=
 =?us-ascii?Q?oFI6IqHtw6am3q9ITpGK+BsbAMMCiZNodoWoYEOFGBkZqCEqPDnVPjY8poZ5?=
 =?us-ascii?Q?TVV2EI7Pbs+wJ2Y02TfLilvjMUhocHrS4xYIsw//UQ7JZld5V6dfFYha5Djj?=
 =?us-ascii?Q?oWfyDMhewz60wkrlu5ZXeOmo5+PFh2MKTnVzTqRVEzZI7VYQiuEvI1uVFLV0?=
 =?us-ascii?Q?XO/KB899YogtYZHgeeuQ09UYBZL7QUSHoTdA1Y9HPvWlo0i0iEmqsNUufN6C?=
 =?us-ascii?Q?YJnc1yxdBLRG1z5pbpNeO/0dRnuIztTD54k+zHDthwp9vWKhlSU2f5s2R/u0?=
 =?us-ascii?Q?CIyTSwTpPySEDwIRFdKjb74iwKvIxElmKX4uj9uRpZkvzxs5MdipmmpZPSd/?=
 =?us-ascii?Q?mDHNxGM0fU7QqTxm9pVJ8Oz/HEGWjT8O3BvnpsudDmdUs6WEonBvC5ifAw+t?=
 =?us-ascii?Q?mw3jLltOLLgc8ylxykDufYbEucaFkbL8mFTDvpWEgxVOLtqm+ZjTMZmjllx/?=
 =?us-ascii?Q?9HlTaOYkUvTJ8l0XVx2SQwYPG3cl0oGliZX44EIgHb7GqpP4SdEt9WWDzYae?=
 =?us-ascii?Q?C3DswCrlr1bBgGQBwFHjARSFgfM2X4kSZ0VbO0NTS8T/0TgAxOaWOkpWSNCV?=
 =?us-ascii?Q?/NXnQ9TwM0APfb1kCUcIyfcZ03L3VvHFhH1kq7GTrC/A2kuCxQlf+l2ilhJl?=
 =?us-ascii?Q?IPkW4EGdw80/bWy5/foiOWMEY0L9DNtt63axJQ000t01TqmXg1NiPNekXQ71?=
 =?us-ascii?Q?DWeLfclvTf7mTDRFiZIQz7mCZPk5+60pyML/TXh34ZYG8E2Yp7qPQcOJUxMY?=
 =?us-ascii?Q?vrU0bGW5tOj7UQxadJUhuKSx74Uqy1o2uJt4VCheN08ALBJ3GYmhLXZG+wCS?=
 =?us-ascii?Q?jtTQIKrVCqseOR/PS74khpeezGTDHrWNZL9am0PuNnFHYTzdpiOHjSudZf+T?=
 =?us-ascii?Q?VUQSligqwin13Fz4pJtQPRSo+6fH/CK00e/NfYqa4GTRU//vy9PFoo+tcQof?=
 =?us-ascii?Q?pESU6q33mCbicl88fdd2CFMt23Uc4GHyN0RCUfR9Ml3B7W+vLck79I1q1ZUW?=
 =?us-ascii?Q?GA/wChwWls4V0w8F/nfYrmcTvsKdKtinlNCfXlq7WFiCL7nWlCnsWvRWttTW?=
 =?us-ascii?Q?xjXQ3MFBqdlCXnrRIATjvjMKgnTV2emACBs3QpGUQLG47OjqR/giCUpAbRLn?=
 =?us-ascii?Q?3FLy7ytab2NBRVOlzTnsII7qQMPYQ7dsVN7h4JpCCYLC/TrJPUe5DIdIb8gb?=
 =?us-ascii?Q?LftKxjeJJT5IoB4nMc9Crj+yiOXOacsFkbOdZeGOWdXjXmAfnBNLIz1v9xQB?=
 =?us-ascii?Q?BzFw04dDeWuvj7oWJ0YksXFd5HXcV8ZSCxtNGY/C8kMLzHuhgl7qUmKrCUv3?=
 =?us-ascii?Q?ydzm9FrRWBj/Oy0KOnchF125uf/qLc0dhk/+wa8RB+WAXKPzuHUxBC9gHRjW?=
 =?us-ascii?Q?hvpaxo6YLXmedz/P3rC5VA6jCj+RV+h3depqmsoL4IUsLbSs0OBK6pY/Fa+u?=
 =?us-ascii?Q?2ek0sXtoSno0hvdb+MWCZOJ9huD41S3z9AKI6II+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8905bf19-7474-483b-65c8-08db6686d992
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:09:16.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPWo7dioxscCl3u6EzHWJvv4srRWJ1/o+HU7JHt3DmuUiuEzG8NAlvhbXg10cDljnc7kep7Sbb+/AKPESEBsgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit handles the code implementation of VOCS service and characteristics
---
 lib/uuid.h       |   5 +
 src/shared/vcp.c | 533 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 538 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 5cdfedb4b..e8c7f8e37 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -179,6 +179,11 @@ extern "C" {
 #define VOL_CP_CHRC_UUID				0x2B7E
 #define VOL_FLAG_CHRC_UUID				0x2B7F
 
+#define VOL_OFFSET_STATE_CHAR_UUID		0x2B80
+#define AUDIO_LOCATION_CHRC_UUID		0x2B81
+#define VOL_OFFSET_CP_CHRC_UUID			0x2B82
+#define AUDIO_OUTPUT_DESC_CHAR_UUID		0x2B83
+
 #define GMCS_UUID                               0x1849
 #define MEDIA_PLAYER_NAME_CHRC_UUID             0x2b93
 #define MEDIA_TRACK_CHNGD_CHRC_UUID             0x2b96
diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 5459cf892..05e341108 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -36,9 +36,40 @@
 #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER	0x80
 #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED	0x81
 
+#define GEN_AUDIO_AUDLOC_NA                   0x00000000
+#define GEN_AUDIO_AUDLOC_FL                   0x00000001
+#define GEN_AUDIO_AUDLOC_FR                   0x00000002
+#define GEN_AUDIO_AUDLOC_FC                   0x00000004
+#define GEN_AUDIO_AUDLOC_LOW_FRQ_EFF_1        0x00000008
+#define GEN_AUDIO_AUDLOC_BL                   0x00000010
+#define GEN_AUDIO_AUDLOC_BR                   0x00000020
+#define GEN_AUDIO_AUDLOC_FLC                  0x00000040
+#define GEN_AUDIO_AUDLOC_FRC                  0x00000080
+#define GEN_AUDIO_AUDLOC_BC                   0x00000100
+#define GEN_AUDIO_AUDLOC_LOW_FRQ_EFF_2        0x00000200
+#define GEN_AUDIO_AUDLOC_SL                   0x00000400
+#define GEN_AUDIO_AUDLOC_SR                   0x00000800
+#define GEN_AUDIO_AUDLOC_TFL                  0x00001000
+#define GEN_AUDIO_AUDLOC_TFR                  0x00002000
+#define GEN_AUDIO_AUDLOC_TFC                  0x00004000
+#define GEN_AUDIO_AUDLOC_TC                   0x00008000
+#define GEN_AUDIO_AUDLOC_TBL                  0x00010000
+#define GEN_AUDIO_AUDLOC_TBR                  0x00020000
+#define GEN_AUDIO_AUDLOC_TSL                  0x00040000
+#define GEN_AUDIO_AUDLOC_TSR                  0x00080000
+#define GEN_AUDIO_AUDLOC_TBC                  0x00100000
+#define GEN_AUDIO_AUDLOC_BFC                  0x00200000
+#define GEN_AUDIO_AUDLOC_BFL                  0x00400000
+#define GEN_AUDIO_AUDLOC_BFR                  0x00800000
+#define GEN_AUDIO_AUDLOC_FLW                  0x01000000
+#define GEN_AUDIO_AUDLOC_FRW                  0x02000000
+#define GEN_AUDIO_AUDLOC_LS                   0x04000000
+#define GEN_AUDIO_AUDLOC_RS                   0x08000000
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
 
+	unsigned int vostate_id;
+	unsigned int vocs_audio_loc_id;
+	unsigned int vocs_ao_dec_id;
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
+	vocs->vocs_audio_loc = GEN_AUDIO_AUDLOC_FL;
+	vocs->vocs_ao_dec = "Left Speaker";
+
+	/* Populate DB with VOCS attributes */
+	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
+	vocs->service = gatt_db_add_service(db, &uuid, true, 9);
+
+	bt_uuid16_create(&uuid, VOL_OFFSET_STATE_CHAR_UUID);
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
+	bt_uuid16_create(&uuid, AUDIO_LOCATION_CHRC_UUID);
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
+	bt_uuid16_create(&uuid, VOL_OFFSET_CP_CHRC_UUID);
+	vocs->vo_cp = gatt_db_service_add_characteristic(vocs->service,
+					&uuid,
+					BT_ATT_PERM_WRITE,
+					BT_GATT_CHRC_PROP_WRITE,
+					NULL, vocs_cp_write,
+					vocs);
+
+	bt_uuid16_create(&uuid, AUDIO_OUTPUT_DESC_CHAR_UUID);
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
+static void vcp_audio_descriptor_notify(struct bt_vcp *vcp, uint16_t value_handle,
+				const uint8_t *value, uint16_t length,
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
@@ -972,6 +1336,80 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 	DBG(vcp, "Vol Counter:%x", vs->counter);
 }
 
+static void read_vol_offset_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
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
+static void read_vocs_audio_location(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
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
+static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
+{
+	char *vocs_ao_dec_r;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x", att_ecode);
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
@@ -1128,6 +1566,85 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
 	}
 }
 
+static void foreach_vocs_char(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_vcp *vcp = user_data;
+	uint16_t value_handle;
+	bt_uuid_t uuid, uuid_vostate, uuid_audio_loc, uuid_vo_cp, uuid_audio_op_decs;
+	struct bt_vocs *vocs;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
+						NULL, NULL, &uuid))
+		return;
+
+	bt_uuid16_create(&uuid_vostate, VOL_OFFSET_STATE_CHAR_UUID);
+	bt_uuid16_create(&uuid_audio_loc, AUDIO_LOCATION_CHRC_UUID);
+	bt_uuid16_create(&uuid_vo_cp, VOL_OFFSET_CP_CHRC_UUID);
+	bt_uuid16_create(&uuid_audio_op_decs, AUDIO_OUTPUT_DESC_CHAR_UUID);
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
+		vcp->vostate_id = vcp_register_notify(vcp, value_handle,
+						     vcp_voffset_state_notify, NULL);
+
+		return;
+	}
+
+	if (!bt_uuid_cmp(&uuid, &uuid_audio_loc)) {
+		DBG(vcp, "VOCS Volume Audio Location found: handle 0x%04x", value_handle);
+
+		vocs = vcp_get_vocs(vcp);
+		if (!vocs || vocs->voal) 
+			return;
+
+		vocs->voal = attr;
+
+		vcp_read_value(vcp, value_handle, read_vocs_audio_location, vcp);
+
+		vcp->vocs_audio_loc_id = vcp_register_notify(vcp, value_handle,
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
+		DBG(vcp, "VOCS Vol Audio Descriptor found: handle 0x%04x", value_handle);
+
+		vocs = vcp_get_vocs(vcp);
+		if (!vocs || vocs->voaodec)
+			return;
+
+		vocs->voaodec = attr;
+
+		vcp_read_value(vcp, value_handle, read_vocs_audio_descriptor, vcp);
+		vcp->vocs_ao_dec_id = vcp_register_notify(vcp, value_handle,
+						    vcp_audio_descriptor_notify, NULL);
+
+	}
+
+}
+
 static void foreach_vcs_service(struct gatt_db_attribute *attr,
 						void *user_data)
 {
@@ -1141,6 +1658,19 @@ static void foreach_vcs_service(struct gatt_db_attribute *attr,
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
@@ -1163,6 +1693,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	bt_uuid16_create(&uuid, VCS_UUID);
 	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service, vcp);
 
+	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
+	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service, vcp);
+
 	return true;
 }
 
-- 
2.34.1

