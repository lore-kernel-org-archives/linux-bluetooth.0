Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2124FC7EE25
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjFHMK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 08:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjFHMKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 08:10:23 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED8210E
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 05:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddl/m8rsu5usOfYElEAVQYqzRRXyGuqPaP2mWDjkGlyanjrEJN1XYRjcAYtwqtc9Ac5xJOsRzVatqgmjRfynEqM2HvQnFduIYpZGFtVfunVIgFI6UuPT2b/M3H4rNVtXsHBMyhs5vXDhzHlUMXBAOoWuExkdP11lkSCxd+YMR8Wau+eolb4ofjB3QQiV22hCdva94qllA9jvAm7ziD+jQZezfEvS0FOl8SnBbRIeUg/ohvw4a9AUpjOPM0/cyeButauyGQqBPJ70mtUFKveUvmn8KHi1fa4ts2rwASYtfE116ErBgV09mUPGGxo/hltRItUUoI6v5YcdQD2EMpBKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ejXrAdPXftoxXzJ1L8CIfbIFH0Hjmvv8DK+C1r3IXE=;
 b=acLVubxWLLpBtlRIPUtspk62Rjx5fWFxTbLPZPsb4oI3wW8Dy8Rkcmckq19mR91/fzqG/2Fe8LPMKulMJpV+atjHMMRpFdUT+o2sl/cTmIDOQ3VRz9vC636cAVonkmVJQ4/Kw7IjWbp2Agj5kyRzQpzHkWSG/5fgVwJSYGC9AbqYkSW1b4lV0MQyD1uGtW3p8hXzpnEkLwZhFS5pGglMJyExtbLoovBsOLYoHcO051zv29nIKdc91SU0c1A4Kz7fQHPRy0z/kGiKbYn3EJUJBAZvAT0SdP9RU/gVhyBNic00D/7kSerQc6UU290Et3hOG9115OabYCWl+B6KYrjReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ejXrAdPXftoxXzJ1L8CIfbIFH0Hjmvv8DK+C1r3IXE=;
 b=RLe5v1vOvULD1m8/VigEC+94K+tZFoSturjG3Lr0vtdUc0dORc3d2sC9uQK5qa/9TzUR7uyZu/1nKcPmaNHj6g97BpMAufqQWpozT7Sv1obLjGOWq7iitCtPJmkgmzTysg/Lsh19uXXytrqz4tWk61nlmu9drEKi9Tgo9xBf1Dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PA4PR04MB7597.eurprd04.prod.outlook.com (2603:10a6:102:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 12:10:18 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 12:10:18 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 1/2] Title: Added initial code for handling VOCS
Date:   Thu,  8 Jun 2023 15:09:44 +0300
Message-Id: <20230608120945.4478-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608120945.4478-1-nitin.jadhav@nxp.com>
References: <20230608120945.4478-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PA4PR04MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b66fc27-a5c5-494c-3502-08db6819532d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tlRqojH9an+kImu/Qp4D0/60V+uMzVvQW8nDetMU4jGpA+VDlZUlNE9M36PmwofTGDODsx8rQ8HYvHEM7E1UfGKDd6bbGP3KkFn727t+BF13827yO69L4im2jg0p9njCw8ayJnDFBiluyjZNB7RAlSofFvqJavyRDGgClpgDvOoLcCnZclo3EqJw3/6zIpchLmN8VMHBdDM0/MevEAUAiKfaHAi0M9Gas/Sl4yegtjjaP1YOLG9jeKHocOggKmzuu7R8b7p2Lr6afLOB0KjuAv9IkGNtaLvwXNWHbzUTbqW3ttQ3h5xnjU421zYjWIpa9AvtdAYrigYgP93TqZ/EhrcVWyWGUkYtRWhA53I0y10dx8hc7ZBon5yS0CjvOhKz7Ex9g8vTo/Fc9AyNqr8v7ha71K0QpzH2ki2Fm3WiXJaT0WQXt+lOfiIHugvnK50TmHE+MEuKdftG/af0mCzapGIvTHoJeFbpxKlp1JFq2TYoMwmsWI/+Riy2bxHojJLBSzdXGnINkEiIXASg3Q+es/lJchjanY+cBSMSPNxdkvhYcutZcdnyYbCI+ktfn/QBe6c2gIAgq85NL3Qgbb0PnnBSeNUeg1PcTH/7Fwea/KLSO+HRBrvYiTsrjBPe4JP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(8676002)(186003)(8936002)(316002)(478600001)(6486002)(52116002)(41300700001)(6666004)(5660300002)(6506007)(1076003)(26005)(44832011)(6512007)(66476007)(6916009)(4326008)(66556008)(66946007)(83380400001)(2616005)(2906002)(30864003)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6NQrnDEvFYZ/UM9CQq+yQ10gB8br7VKkj7D1h4sWkRxJ4lzLcANQjVyhAqC?=
 =?us-ascii?Q?U/kWX0WQbTR0XCyniuEFN1eVUYGmfv5ErFHmnhl11Yz3VKpBq94LUREs7ar8?=
 =?us-ascii?Q?FfyD2Ypy9XJi5C7/cM9GqQhN9RY5RyRaBJaQ+n9KseGe9VGoobAPqrBzegu6?=
 =?us-ascii?Q?E1GcYiARZ275VtWSBTawPvW+bDJA+AJP7VuK2nAjN/jfZJRI043mQy4LmPkB?=
 =?us-ascii?Q?Auh/0DneQfElV99Jwia66vrgN3HV/Iuw8H6aWC5XDvXMxiC31FQbwx3n5/XD?=
 =?us-ascii?Q?WaTKalfzLm+oQSKsgO9dKJRk03jdOj6e6z6iJBrG8VeyjIFjuzDcGbSWZdO2?=
 =?us-ascii?Q?l17qkVQeb0PDaH+Z+9sddytWTASETVqfQhK8IPlwzt7+6n0h4MGm4GhEON0E?=
 =?us-ascii?Q?cG74a0oUjKaOxEzor3NgPTNadWcZUgsPI/TtzGO3XNyuTww0ZM2iueqY25i4?=
 =?us-ascii?Q?9NC+KjGmDmpPFKEyLQS6WAo1QGVWi9i4RpaEtx/oZWVMnKRyMUu0AyUTOHzP?=
 =?us-ascii?Q?kDdsnpEibjqEhs+qoLCyXWLWyceMjVFUuvTKLSym1CJh4kH8T2wl/89M6SmA?=
 =?us-ascii?Q?3rLhOv+fqrySvMWgfAEQQwU5zjF0A7DePGOhN2zCA0/Id8Q2fbLNTeecf3Qh?=
 =?us-ascii?Q?/J9fptaq9zrEpxjAC+wMEeYx7YC7sS9vSoesIeTDE74tuOfbRMLlttZ3WEq+?=
 =?us-ascii?Q?SIRjKXq/HEm/q+0aD4GowI+qADCPrrRT8/LQGswEN9SR17TqdWNLHNnVkQ/6?=
 =?us-ascii?Q?02M2zd36YeEEJBpbO8UQqtF3dVBqyvV1lYdGOcMxkfzXGzpJU6DUH8lCVHl1?=
 =?us-ascii?Q?L2o4QGNr0Pylp5xvdlQtjPnSI7bOHLKtuXrqKRyulKNmJjK3laUA12dwOxEq?=
 =?us-ascii?Q?ev9QW3bYTrcYkiIY9436/4d9oZPimGWFuSEdXdSehZHopaflVgZTn9BgGjD6?=
 =?us-ascii?Q?ZUXODjtC5e9Fwb9Y8D+uhGC8mdDN7H022CbrSzC0aLpRdhLxuAjoPq3H3J7p?=
 =?us-ascii?Q?pF6CrOnLAFn4tzya+Me4BcSQRTsEEVixgEVF+Yrnkd9tnrW07VnozL6HD+mz?=
 =?us-ascii?Q?76JDM3pPzIX1FJmAQ2N0Qp5xgTOApThavvN9GWuV/Pqdvaff+8VtDNAYbp+8?=
 =?us-ascii?Q?NpZ1wSnlQh7pI7nA+BNiKuiXpBzbv+T3YZTD2zdQpo5YLR502TAVXybDZ7w2?=
 =?us-ascii?Q?Bb0dQGZ0/idfsO3EhGWbt7qEzRBKLnMrkbbgvm0+ucvm3IEIce5y8YuFSsSf?=
 =?us-ascii?Q?jgmBTNajMZQrBAXKtgwBYvmLTu274UeFMjcmHrYE/XTURbWVsMKB9/lCSOBe?=
 =?us-ascii?Q?k8mGx/5H8sYCvhAv/MimKWIKImgHnZY17HBpkE5NYPXvu/WDErBAzSjoCXl2?=
 =?us-ascii?Q?7np43WA3biNQLwn0nRrI9HVw585unoEiB/Y9MjwB/biMKsfYRiLc/7qnQZWc?=
 =?us-ascii?Q?S4+8B0bFDa37Oon2d3dGcQ6rFeBe5BiCinuN/0Jah7BcOgi/xn9foId40xcC?=
 =?us-ascii?Q?1p4N5o1B7/jiLYtMlj0GoxBOtxC1at/WX21bvNS0uTWuVAQR9CKOi0yqoc6M?=
 =?us-ascii?Q?4OuAGguyVHN/eoMVBBMGFFVz5+jpoTEdcgL0bWaR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b66fc27-a5c5-494c-3502-08db6819532d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:10:18.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ACw8N0eoHT9Txs8DWuSfu2TELTtr73hZa8mvCuaxuwpafnIXgPSK9veA/j0oFQmv5rMvI19y7OEXo2uksCMTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7597
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Summary:
- This adds implementation for VOCS service and characteristics
- Implementation based on VOCS_v1.0.pdf specification
- Tested using PTS with reference to VOCS.TS.p1.pdf
---
v2: Corrected prefixs and cosmetic changes (Luiz Augusto von Dentz)
v3: Commit message modified and fixed long line length warning (Paul
Menzel)
---
 lib/uuid.h       |   5 +
 src/shared/vcp.c | 547 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 552 insertions(+)

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
index 5459cf892..aa75f498a 100644
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
@@ -911,6 +1240,44 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
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
+	if (value != NULL)
+		memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
+
+	DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
+}
+
+
+static void vcp_audio_descriptor_notify(struct bt_vcp *vcp,
+					uint16_t value_handle,
+					const uint8_t *value,
+					uint16_t length,
+					void *user_data)
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
@@ -972,6 +1339,86 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
 	DBG(vcp, "Vol Counter:%x", vs->counter);
 }
 
+static void read_vol_offset_state(struct bt_vcp *vcp, bool success,
+				  uint8_t att_ecode,
+				  const uint8_t *value, uint16_t length,
+				  void *user_data)
+{
+	struct vol_offset_state *vos;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(vcp, "Unable to read Vol Offset State: error 0x%02x",
+		    att_ecode);
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
+				     uint8_t att_ecode,
+				     const uint8_t *value, uint16_t length,
+				     void *user_data)
+{
+	uint32_t *vocs_audio_loc;
+	struct iovec iov = {
+		.iov_base = (void *) value,
+		.iov_len = length,
+	};
+
+	if (!success) {
+		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x",
+		    att_ecode);
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
+				       uint8_t att_ecode,
+				       const uint8_t *value, uint16_t length,
+				       void *user_data)
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
@@ -1128,6 +1575,90 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
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
+					vcp_voffset_state_notify, NULL);
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
+		vcp_read_value(vcp, value_handle, read_vocs_audio_location,
+				       vcp);
+
+		vcp->audio_loc_id = vcp_register_notify(vcp, value_handle,
+						vcp_audio_loc_notify, NULL);
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
+		vcp_read_value(vcp, value_handle, read_vocs_audio_descriptor,
+			       vcp);
+		vcp->ao_dec_id = vcp_register_notify(vcp, value_handle,
+					vcp_audio_descriptor_notify, NULL);
+
+	}
+
+}
+
 static void foreach_vcs_service(struct gatt_db_attribute *attr,
 						void *user_data)
 {
@@ -1141,6 +1672,19 @@ static void foreach_vcs_service(struct gatt_db_attribute *attr,
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
@@ -1163,6 +1707,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	bt_uuid16_create(&uuid, VCS_UUID);
 	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service, vcp);
 
+	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
+	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service, vcp);
+
 	return true;
 }
 
-- 
2.34.1

