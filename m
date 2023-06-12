Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A526C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jun 2023 13:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbjFLNdw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jun 2023 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjFLNdv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jun 2023 09:33:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD704E9
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jun 2023 06:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiSffE6gleAV995Q7VC+kCrNmBb6c/T7ZwyENwxM/57NHOn9yym5bn+EWeG3DdcUmwfJ9AinNkrbWnNTDcLLko80p+s/Kf432rpL8T9sjHCTS3f83ntLYdpp77JW58nV4WuGPxM6feB2EJjfAo++H3vsIOZEwGgKZxvqfj4MHJPVx9xSHQQtVkwwE8nRnoZFIHlNvSJNkakJw1/Kb+Pc0jgvgVHj6ksRTDISUFGQkvUhYC7uk7er53cX57a/XVtoGslQPpv9GGXtyBnLPKwLSoZVUkgvg0KS1rivO/GpixAjQXHA7bTdMbyk9f6bp5hBUpxkS2vaEDy02GQr0nWfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS2yyTLi1/F1hBcA9t8xKpPDVB2p85oYdfrFpEXyPek=;
 b=Wk19QZjMS0UghN59LOqa38MizLb3dHj0JMheUJ20gYMS4UsQkXZ+dbyv14waU+2A49wRGxnR2TRoFfye3F1wipjgzlMmtKhb/ZdtkjRdICYlYZ7exjtx9ctByGXn3JKZNmgSlWfojlzXMIwjsNXppi96qXW8U7hkXaYOC4dlFPNE8miRpxPf04yrDARej+TtqawgoqbT/t8AtbznBOqnyqwa/yfA9F2B9ci9FQMJzfTxK/KO3YcnsjCKo9ivK3V/ve5yBKbQDR8PtwyzoZfsRBeEpAeSrojdhlJn2+HHtBS4sVmEmyMhH4+IyA0wMVIsKERWSCJ645LUFROVdlVOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS2yyTLi1/F1hBcA9t8xKpPDVB2p85oYdfrFpEXyPek=;
 b=Vue8NXX0t1S+gWwb+VLUaeUhAyHJAZv4wqoYVZqLTb1zm6nWnvUpeQT7kIO2W4VwNMlCqzx6i1CV/gxCvW4+xQ9ycH8wSj+Q/HeqANl5+EcM0l7Kq5vjbD/WxhfV0XzWfnScqfJg0qMGI8ywPW4N8XB3P2HFeYc53Qxczm6ObVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:33:46 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 13:33:46 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v5 2/3] shared/vcp: Add initial code for handling VOCS
Date:   Mon, 12 Jun 2023 19:02:50 +0530
Message-Id: <20230612133251.194-3-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.33.1.windows.1
In-Reply-To: <20230612133251.194-1-nitin.jadhav@nxp.com>
References: <20230612133251.194-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 997ad669-5e83-43de-42e1-08db6b49a5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7X78DgKiTZ5ETWgxqTLZwGftSesoAArp+PZnP3mfAKRju1a6Gr/tRbx6LTBaJXuvSm5cwAZ7LdO7bTWZ0oYLUQ52HTXm1XY3MOGQWz+I8/tYyF3JoSfXLKrckny1Gw4Jbmis7p0FslZK0xK0tJ9K6k4syEOd8cFOwQVzlrpFnMxEAnPPK0xlH2ui72H714QN+N8oCggLeyv9Y351Izs0ZEGqkaLtFS1T9bg6bvh7+mASgbQ00fAOPpYtGAgL4lZDzmv4SRoU8LoZ1wUKTwmiqEk94//NZ38k5c5gtMspOr9+D4/v4VxrHUqZyufIgm8XPxiBV1J9Dc+24Y62Mtzk2eXsMRl4bcRoAESzBpDQyth6axcx8s+QDGidKlpLU88j1er7Oq0n8iRL+44XIPMfpCr+6taaR3fV9Rt5ehDLPH9qOYDg8XeomMWycZHZ75X6EoFvb64lZ5JY13H6zfzOIJz/44pPpk439SMWvibwZnhSihNMs/IaE9AQLywNgnUStU1vDgR4uBo5Dm/EBVqUeFDS6ohCS96HPzcRtD7YibOQIhjr6hQ0I3uIVu1lssu0XqrfH6TP6RUT/9VlV/hOVBx2KMxRT9JRRYsD0MS8TFVmHCQvgzQ+pXDlt0vy9TS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(52116002)(6486002)(6666004)(36756003)(83380400001)(2616005)(38350700002)(38100700002)(86362001)(6506007)(6512007)(1076003)(26005)(186003)(30864003)(2906002)(5660300002)(44832011)(8936002)(8676002)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bor/DFbZfTiQClL81KvLRibDeWty3OQMdd5i9j1u6um1wLYYLtN3bWt7fyKX?=
 =?us-ascii?Q?bEflmVtOHUNhAeEkbu6JLySs4wzum4nSlYspyKePgo5fikrUg2RB8SBW6qXP?=
 =?us-ascii?Q?dydUwb69P7hnsPeVDvQ9t9BuY2tOdMWRmYfCc9VUmzVuXlkbIaiuYyNIGP2x?=
 =?us-ascii?Q?yawzOob57/ppXXs6+WoukUYnRhYEP6xsof6P9Tc3/rsr7bzEnQvyjyYPeLsU?=
 =?us-ascii?Q?Ht8SbRlckaEpTOsCoP+IsSbAvPSDM6iPCKO5yW6fH7k27/t7D63bDrXiybRd?=
 =?us-ascii?Q?kkUGpean96O3UkoiA5BEJaL2AcfTohfUH1M3iARulJ3DouXKcQOxlwLDtWsn?=
 =?us-ascii?Q?L40dcSYbLJmCSAG8B6mXGjS0Jk2UX63mh5Du3pd+e75UPT6m0qbvYC9LV/nQ?=
 =?us-ascii?Q?TRAD6KRQwO4COvvxWF3xEf9HzHe/f3FSpFL1PnLLrn/5iFx/LH3O2bbUAkKK?=
 =?us-ascii?Q?vUiIubbxajifaoUkQLFYJpQRepWbtpH0ZzmQkSxPILacRIfmlkdZBHFBsfji?=
 =?us-ascii?Q?uTFrxMK1LpK6eq8fVGg9gJJND/7K7k+vYt5yI08R7/Wsulp0rX+4p0kYqUx8?=
 =?us-ascii?Q?E0oVyDyBV51z+TbOFgVkHLZov3yURgTnDO1wDD35M96Nr91tLopk2yttKNs6?=
 =?us-ascii?Q?aGpCB7wvPm4K/5d2mKlCXUgY4EzIXdFCcJB/mCI4P1Uzu2drOEJ1hF/+3RGK?=
 =?us-ascii?Q?jN3tDhvcapNM4c3l04AT3ssei4B78NW8F7+hZm4wbSRPN0B39grCjFIDfh88?=
 =?us-ascii?Q?S5KVAuvwdP81LQblT/5LRUEUDasVUBXHJGrtzE0FM2iGcRlfaOc3MEWlFyGO?=
 =?us-ascii?Q?73biaV/CcTX6yV6I33ZVN5LXJT/c2xagVJmf5rK39nA3KTIitIh4Kdfpc7nn?=
 =?us-ascii?Q?xVlE6Qc9xVkgFawjOwTGGb/gmnDA3UqIUI5y67XkSG2LYrcP1ex0ahUAtZ5D?=
 =?us-ascii?Q?4XTR6HYD2ui2JbNcLCUnWwYherAPuRi6BBuP1VJKM5zZbRQUbK0qGzlnV5gd?=
 =?us-ascii?Q?UpqvwgQ4IBaioC8a5SfbLwgSjhG++z1csKlV7SbL9+V7IHtQLP/df9CHFi/P?=
 =?us-ascii?Q?6FChlWYAvjfuHUc2HiRHBOIemHUJuve+JBwt+qJuEliTnYvzvjDUrpJaM2fE?=
 =?us-ascii?Q?f/9uY+e7qt++ldumTr0xrjit+zDwWq7u8Izwz36i+9Bq05Dsf/4o9glSs0L/?=
 =?us-ascii?Q?9R0UPl4j6yOc3JerXH5VgEOSjv+4ldFgOJSyMFSeF7UwSvt8Y8VO71Tn3oRD?=
 =?us-ascii?Q?8dJqqgvCPjLDAfF/yFxoeBvhFjRiqntfo8dS7jaNfj1duPyL7HSxB2bKiKJl?=
 =?us-ascii?Q?0LHHTCu9CcHljaxOJoTEtdsquTZ+sa47A7iXHFSUVoVF6GF2AfC66GupG4ga?=
 =?us-ascii?Q?rNJJPFeA+xP5AHQs5OgZuVBaH256lR5JqBxv7GPGFRoQwnmfttJIItYSzweV?=
 =?us-ascii?Q?gBulyOHk5C+TN3h/MiKUE0NLpg8J+YiWVfJUT7IKYzZXIz7O9+cQzKUFeMFq?=
 =?us-ascii?Q?ZPW7kKFtYTHZXXqEx07k9sUs9Jj/3Sc7l05QLrNj43sVlDC3HFordeg452t3?=
 =?us-ascii?Q?5q9RsLeD3JrqYzVJl8dDDnzJJ+i8fQE5aGwjIPku?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ad669-5e83-43de-42e1-08db6b49a5a8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:33:46.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Z/qnFI+iHpE8QgLI66ae5SS8IBC3omV3nlK3UQPcQ7xogrDgvdbLgCh5wrGkpkIzQQnG7i+U4aftOSD5CetVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002
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
v4: Used BIT macro to set bit of audio location macros (Luiz Augusto von Dentz)
v5: Resolved Scan Build warning (tedd_an/ScanBuild)
---
 src/shared/vcp.c | 550 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 550 insertions(+)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 5459cf892..92f21fd0b 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -36,9 +36,40 @@
 #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER	0x80
 #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED	0x81
 
+#define BT_VCP_NA                   BIT(0)
+#define BT_VCP_FRONT_LEFT           BIT(1)
+#define BT_VCP_FRONT_RIGHT          BIT(2)
+#define BT_VCP_FRONT_CENTER         BIT(3)
+#define BT_VCP_LOW_FRQ_EFF_1        BIT(4)
+#define BT_VCP_BACK_LEFT            BIT(5)
+#define BT_VCP_BACK_RIGHT           BIT(6)
+#define BT_VCP_FRONT_LEFT_CENTER    BIT(7)
+#define BT_VCP_FRONT_RIGHT_CENTER   BIT(8)
+#define BT_VCP_BACK_CENTER          BIT(9)
+#define BT_VCP_LOW_FRQ_EFF_2        BIT(10)
+#define BT_VCP_SIDE_LEFT            BIT(11)
+#define BT_VCP_SIDE_RIGHT           BIT(12)
+#define BT_VCP_TOP_FRONT_LEFT       BIT(13)
+#define BT_VCP_TOP_FRONT_RIGHT      BIT(14)
+#define BT_VCP_TOP_FRONT_CENTER     BIT(15)
+#define BT_VCP_TOP_CENTER           BIT(16)
+#define BT_VCP_TOP_BACK_LEFT        BIT(17)
+#define BT_VCP_TOP_BACK_RIGHT       BIT(18)
+#define BT_VCP_TOP_SIDE_LEFT        BIT(19)
+#define BT_VCP_TOP_SIDE_RIGHT       BIT(20)
+#define BT_VCP_TOP_BACK_CENTER      BIT(21)
+#define BT_VCP_BOTTOM_FRONT_CENTER  BIT(22)
+#define BT_VCP_BOTTOM_FRONT_LEFT    BIT(23)
+#define BT_VCP_BOTTOM_FRONT_RIGHT   BIT(24)
+#define BT_VCP_FRONT_LEFT_WIDE      BIT(25)
+#define BT_VCP_FRONT_RIGHT_WIDE     BIT(26)
+#define BT_VCP_LEFT_SURROUND        BIT(27)
+#define BT_VCP_RIGHT_SURROUND       BIT(28)
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
@@ -911,6 +1240,47 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
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
+	uint32_t *vocs_audio_loc_n = malloc(sizeof(uint32_t));
+	*vocs_audio_loc_n = 0;
+
+	if (value != NULL)
+		memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
+
+	DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
+
+	free(vocs_audio_loc_n);
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
@@ -972,6 +1342,86 @@ static void read_vol_state(struct bt_vcp *vcp, bool success, uint8_t att_ecode,
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
@@ -1128,6 +1578,90 @@ static void foreach_vcs_char(struct gatt_db_attribute *attr, void *user_data)
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
@@ -1141,6 +1675,19 @@ static void foreach_vcs_service(struct gatt_db_attribute *attr,
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
@@ -1163,6 +1710,9 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	bt_uuid16_create(&uuid, VCS_UUID);
 	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service, vcp);
 
+	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
+	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service, vcp);
+
 	return true;
 }
 
-- 
2.34.1

