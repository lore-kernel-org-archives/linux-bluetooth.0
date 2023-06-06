Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA4C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Jun 2023 12:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjFFMJ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Jun 2023 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjFFMJZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Jun 2023 08:09:25 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82E0E7D
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jun 2023 05:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjoPs+Yl1Xjl9XpqfT1DSZyz8hg/dzceP+JyUvcpWS/sFExZDs7w0nuFthhN19iQm8XqCCfO2DIxaUTyX9IphJ2Ikb4IOPtVzo1/ypHpesYlvRoo3FsEw5Rnq/c+F0B1EJTick0PlJBjYmbaICFNX2U+4fDt0GG6p2XPflSkHHIkfERmnpkqmpTpu5xDoYOhJ1jdeQDOhFR+OWWuz+z4bFn0KpZAmyIrPLQC8EtAM6s1cvFOlrGlbKVy4HxzK5uWgtIbUPeGd0EwFAwK2bETR42RDD8mqtHuVsr3AQOYgDKTi4YgR6B7ybWKrFMkFzXI9uGfHKfZQOdOi0i4Pu6XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dGc9vZ/ZZPmnYgEFB5539HJ6BMR+HJ4srjHka8Yv/Q=;
 b=NIKml+GPmtQqRB5S4jUVckNPcQBhR+SWSB8r7O6xx5P2nGLUDc1ZOioI3MOWPuZOmUqQMcueA/DRwHnB/S78FQZyxwuDBuAVvqap/b9Q16KRvi9j4yCN0TbYjxX65jm84gEO+yluRASAg3tChytFiO0GNgwL7e7It2RdO4NnWTkDEGDZeiVofBgWKPee0dduClU9CXOmkk+RvjRMeUeunz4UMxKxx6z0wmh/dVt56cE4UMWaHfMHyfCBL0Km1ywVxpuwI/5cxJGMV7rOwbmTxiNpLwrZvdjiFsYXCOGniMDBNpt+H1gmZZ0B/L5/rEew2YVy+TX6/695X3VYGnh3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dGc9vZ/ZZPmnYgEFB5539HJ6BMR+HJ4srjHka8Yv/Q=;
 b=IiYu1PxHRD0tg60MoSa64zF66NVwZzd3n2SrWGdcS2SIPLLBskIzVWCfSqkyjEH7Z8pMCX6eBGsDGmVxnzFsfq0DE+DPhnUT69fw3Hys+0eJK/Rr1xuj0xTqOHyy3SXMTdEEPxKTuSMQGdm2k8yY6LiKRIP5xzziXWStwwlrVD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 12:09:20 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 12:09:20 +0000
From:   NJNXP <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v1 2/2] Fixed the following issue observed during PTS testing for mandatory test cases - Specified Upper and Lower Limit for Volume offset - Corrected the number of handles for VOCS - VOCS is made as included service of VCS because VOCS is secondary service and VSC is primary service
Date:   Tue,  6 Jun 2023 15:08:24 +0300
Message-Id: <20230606120824.4705-3-nitin.jadhav@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64d87665-d391-4b7c-2bbb-08db6686dbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TlTFtOHskiC7vaJAnsu26ixK+280mYUMtZPAuOQGJrlrmzWIfqEvFEMCPFiCNSKuhPQM/l4DqvNRMp/6v0DHnQ/UfL9nbmDVmwgIV1agAGOFaQ9EGh1fa7wpzr4SiHlLe5P8RSfFaL3mhKg+vwd1egu5s3vbtroFFKERiNTGcoiWW/BklkUt2D4tOIHDdiXbyPJ/Zn3NVtjq7wSJnouMdiUpyuAED0TZAMQzcGiPgnHMlTzSIqBytqlgZu8tJ7X8tOc4/VnvnivMZ1+oJveN4303DmmsffGcnCVTJ0qmkSBNWFV1k8fyXCpFt5NymAhzShqAg3OclS6l0FFGWeRE1CPLOkSvAsm7SoBV65ItaDe9Q/0YAljais9RoN+lxfMUlwEmlP/r7iexpEcbtbHuHfw6A46O9AKemONMwOyjhkNLt/6MzrkdvqNFOI2Aj1OvePYDdwi/WA9hZUddYmon5EkgkACvN7YtYhGzGCT/M4Iazta/fa/vGvZDRgDG8jmUi8Ty64GK+K5RQhmUkB5l1DnR5d8SYo+Qcc+VlfhrE/2CpXsrFKf+ob41C12snE+OUhSrazznoH6MwvBGcAG1UI2vq3m3j8cY9LAMaGnEYUCmnYZ2EkCLtsJVaCZrkez+llTXe1kxP0zw2h0aIvtKQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(26005)(186003)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(4326008)(5660300002)(8676002)(8936002)(2906002)(86362001)(36756003)(219693005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zJBbH674bXxFfKHc4EY/ZiXhIH6XMVBIhX2WVKPLK9+jHioTbZaK48gwFmeO?=
 =?us-ascii?Q?uisogBvUt3VN06yqCwfttdTd7ls/ErrTwpNjG/d+rwrouVp2rpxmTPZdXfGF?=
 =?us-ascii?Q?GRJ0yi9UYYRmSwgXnk2KqN/sFqefW7LlRq1TuXjjq9jbCtFANDDJNStXN1bu?=
 =?us-ascii?Q?9U1Zld+R19CeQacW26xTf7z5UJh+6p/IpM9M98lGmy53F3J+TttT192J2lCY?=
 =?us-ascii?Q?z2tt19z19mvDWFTECyoC2Y6ISticwuAIfpcLo5ZWDwXldBPeBeeiGhaq+Rdo?=
 =?us-ascii?Q?8BCfWaR9FRptwsjvAY0oGLjxgJVqRSYgSL7yn4XujzCpptoXe3h8xnPVIwwZ?=
 =?us-ascii?Q?cpBjGFzf62+FLCfLm8oNj9wmkmmKQSFBObRNXd6NG2G4ExB13W07xT2TJTYT?=
 =?us-ascii?Q?ie6+KDsEawFVzrQt3WYt/joaL7PmohkAohpK4wZyIUOIt8QU93ZBnlIltPOk?=
 =?us-ascii?Q?KsrGg4j26uIOKT/p42Zf5TTCY9ZKzsMX1QNJwyWNR8mjOgWyNvC4qjqf0fa3?=
 =?us-ascii?Q?Sc+H4u9gr6oWHvNswTw8zJTtIeTKu0HrJezldoKK89oXIzXWCVuc5pdszCAv?=
 =?us-ascii?Q?Tm7aCaRqJiGjXZBL6R5sLqWVHUiydj1XgE7rZr69+abD5q6hYvIo3set7I0a?=
 =?us-ascii?Q?7DW9/XKThktW+ows5uoNF6Sax5uXM0U9yT4aRrj4SszgMeOf0tY+ajnLDwAt?=
 =?us-ascii?Q?G5dhOvhiHh0kHesEfWvKOXSfCyMSKyDB+WAg4kcBNPXyzJEt2iueOPDdUTM1?=
 =?us-ascii?Q?zJMmXFGHwnl9pebS9BPwgldZ7qqb3L+8bCT27LWj37z+4ki8b+xJcJgAQPFZ?=
 =?us-ascii?Q?xgZbid1NAX1uFwJh1ulzkCSZQfU4nYqwNS2zk33S/BILUFtNM6/yF8dwMOef?=
 =?us-ascii?Q?GCusMw2AZ/p9XWR30Ue1WfbvJEIfhiOuLUwHE37t4LhDPESZKsVAzUWU7XTj?=
 =?us-ascii?Q?Zz8v2rbvVQpEd7JUznu/xJtkGb7wKfvAvIxWtPRKikIzayFviiia2qei+jlU?=
 =?us-ascii?Q?nxBJ2/IUiKVp/VRSkFGj5GGfNerpDioaBFcPg7BDaju4HRUe/c+Rvwe5LnYr?=
 =?us-ascii?Q?Z3FXvtADCT+urUKKKIbWYvGXD/QVxMpZpSlxDwlnRTtXUe2tCfYPgd3lLb8w?=
 =?us-ascii?Q?wDr/nqmsqWralRazcG+NBfH57p3aQgW2n0Oj90mmzDa0QJhP5U+dBMwgPlek?=
 =?us-ascii?Q?HeePw1hnW38wEk233D5adPtRQP2fzPq/ds+S4BzpCdvITBGGzs8q3R8E4R1k?=
 =?us-ascii?Q?jm5ZB4/JewjDNgeberJw7VkeMTZtPmMQvRhZEJdpFU2kcNlH2nP8FRC4VHcc?=
 =?us-ascii?Q?4AdOKFA4pxUF2z1N/6u8eI5+RB+FizuV7mvmhOgHGBvUZAHIU0f9i+wY1PKe?=
 =?us-ascii?Q?eACwwlaE94g+DSBrNE5cnGYDD7Vv9daMWlK343hJcT81er5BCQO0kTtVsuU2?=
 =?us-ascii?Q?7aNrdOnkQwT5LZ+kACBbT1SfgwG/suLn2jhpGV+1y12H7q5M8ANYu4MPBBCD?=
 =?us-ascii?Q?zUhrEBrLL27vZzT9D9j7CbmN+T60+hpyhKl36TCN6pUvoPYHJ7FzrDFyrOLI?=
 =?us-ascii?Q?uleCc5hseWZxgLJXAhLFhUxi5kBMay4UhddyyI3o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d87665-d391-4b7c-2bbb-08db6686dbfe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:09:20.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PGYCyHrnNkEaHZY/SzGfpL8SmJ7CqUxd/Mg1GzEjipldzXfKORYlJ1ERWgx1rWyRWdGQz305OE+7Blw5ulc4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/shared/vcp.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 05e341108..b6e8ffdaf 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -32,9 +32,13 @@
 
 #define VCP_STEP_SIZE 1
 
+#define VOCS_VOL_OFFSET_UPPER_LIMIT	 255
+#define VOCS_VOL_OFFSET_LOWER_LIMIT	-255
+
 /* Apllication Error Code */
 #define BT_ATT_ERROR_INVALID_CHANGE_COUNTER	0x80
 #define BT_ATT_ERROR_OPCODE_NOT_SUPPORTED	0x81
+#define BT_ATT_ERROR_VALUE_OUT_OF_RANGE		0x82
 
 #define GEN_AUDIO_AUDLOC_NA                   0x00000000
 #define GEN_AUDIO_AUDLOC_FL                   0x00000001
@@ -100,7 +104,7 @@ struct bt_vcs_ab_vol {
 
 struct bt_vocs_set_vol_off {
 	uint8_t	change_counter;
-	uint8_t	set_vol_offset;
+	int16_t set_vol_offset;
 } __packed;
 
 struct bt_vcp_cb {
@@ -167,8 +171,8 @@ struct bt_vcs {
 
 /* Contains local bt_vcp_db */
 struct vol_offset_state {
-	uint16_t vol_offset;
-	uint8_t counter;
+    int16_t vol_offset;
+    uint8_t counter;
 } __packed;
 
 struct bt_vocs {
@@ -705,6 +709,10 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
+	if(req->set_vol_offset > VOCS_VOL_OFFSET_UPPER_LIMIT || req->set_vol_offset < VOCS_VOL_OFFSET_LOWER_LIMIT) {
+		DBG(vcp, "error: Value Out of Range");
+		return BT_ATT_ERROR_VALUE_OUT_OF_RANGE;
+	}
 	vstate->vol_offset = req->set_vol_offset;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
@@ -971,7 +979,7 @@ static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
 							iov.iov_len);
 }
 
-static struct bt_vcs *vcs_new(struct gatt_db *db)
+static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 {
 	struct bt_vcs *vcs;
 	struct vol_state *vstate;
@@ -990,6 +998,8 @@ static struct bt_vcs *vcs_new(struct gatt_db *db)
 	/* Populate DB with VCS attributes */
 	bt_uuid16_create(&uuid, VCS_UUID);
 	vcs->service = gatt_db_add_service(db, &uuid, true, 9);
+	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
+	gatt_db_service_set_active(vdb->vocs->service, true);
 
 	bt_uuid16_create(&uuid, VOL_STATE_CHRC_UUID);
 	vcs->vs = gatt_db_service_add_characteristic(vcs->service,
@@ -1048,7 +1058,8 @@ static struct bt_vocs *vocs_new(struct gatt_db *db)
 
 	/* Populate DB with VOCS attributes */
 	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
-	vocs->service = gatt_db_add_service(db, &uuid, true, 9);
+
+	vocs->service = gatt_db_add_service(db, &uuid, false, 12);
 
 	bt_uuid16_create(&uuid, VOL_OFFSET_STATE_CHAR_UUID);
 	vocs->vos = gatt_db_service_add_characteristic(vocs->service,
@@ -1110,11 +1121,10 @@ static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
 	if (!vcp_db)
 		vcp_db = queue_new();
 
-	vdb->vcs = vcs_new(db);
-	vdb->vcs->vdb = vdb;
-
 	vdb->vocs = vocs_new(db);
 	vdb->vocs->vdb = vdb;
+	vdb->vcs = vcs_new(db, vdb);
+	vdb->vcs->vdb = vdb;
 
 	queue_push_tail(vcp_db, vdb);
 
-- 
2.34.1

