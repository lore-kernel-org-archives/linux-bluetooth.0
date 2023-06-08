Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193F7C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 12:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjFHMKm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 08:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbjFHMKf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 08:10:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8022139
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 05:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE6ZzIeIMptnHQy49C1P3c2u2dV0uG+HJEHHxJVXWBrAWbBOvSZcEJL2aV6hvWCEKXHK/D10LZsvip6wZ0oySZYj+6H3xgbM3YrdDhfp6itqm+WQx6kr4lH9fw5nMflqgedD3GBqmB+EEHWO+NAldyfaliucT8NZrgxT6ZUvgi2KPpfomHw4hXVX6FD9DzrjRHJe5ZRmUcR2AMnRHjsvBDB/tRWVZo/K2heBDTOHhwvXqjJwCkOGm3Fo67iokP9ImSC3OgVNTDlnVbfbv+gr+Ur/cGf193cLsKMVm9HdSsXO8ZhlE0G/BY6O+WMzNW12XJ8eYwOMMvCPo2+A2V42Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkYWeLgJJT+Xf4Dwp+78qzzqTLMRVqu9vUt8/DGFngw=;
 b=ghSW7TqLSgnfq4qOaTw98hnhrLvynnmizMkUqYiNGq/dr/X3wXmj64eXpP5bsSTsYJA5ejMvyOdXVXhTJMnLheAkiWl89JSSKkg66IM5KNHVDD4V3OAZ78TVihX0RmtPbmUIJjJIwklB1PN7in1BkhAnNH7wyF/KpJ8fjX6ES0cW7RH4gGHCGmDVrfgPtNWhiQG7WrqL91wuELPTXaFIIMQOSg4R53f6vsIgs1Px/IAw9HCc8tbSDsEIGlpNXm6jnTXhuYCEaBSL2b3jcGOUiFwCV4EercqWGQp4T56uYes65s62edPsLOP0krfm4MDOWmAZyMGpi63qL+HL6ajiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkYWeLgJJT+Xf4Dwp+78qzzqTLMRVqu9vUt8/DGFngw=;
 b=IUarz/9RXUqrekgsSjQL6PsYo8bd3NX1w0c4uXLXD02Mj14mJu5ImA1Rd9VOYvYdVFHb+Us3YbrKVWh0cr+9/hTrMBsHsFplz+XGxTjsPdbFwcO2UppBqvdeur2y/urwai8vsVAju7vaI9Km7N8fVp1hOLw+nfRhKcDMp2v5ZRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PA4PR04MB7597.eurprd04.prod.outlook.com (2603:10a6:102:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 12:10:30 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 12:10:30 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 2/2] Make VOCS (Secondary) as an included service of VCS (Primary)
Date:   Thu,  8 Jun 2023 15:09:45 +0300
Message-Id: <20230608120945.4478-3-nitin.jadhav@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 843601cb-ab6b-43d9-487e-08db68195a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkc7bwHewTFQzapP4EsLOLv5/QR/NVbR7A8AUIBgWefWLvPiejjYgbcG0VHbfqfBpJxd0y5ikKq7frLhxWGFbIBYkIs/3TbZYgsG9C4MnEqC7XFQAL06Erbw64xr8zkIaK/ZmZFrnTYHOKbU2M94m09+wo09ux/xMWnsTx6+/WfzA56+TzXtB1C9nny3y8oT4tMpS7LA+wWZsut978DFxS5AnL15kfjewLd/NVkmXpd+I3oy6qj6PgXLYCZsADBBEnCcURRShslt++V9qXfHfcGlVEKFf80IEQBLfFR7peLmPHYlHowaDrJJnCd8D7hiU3f2FIi/K57GGBh2XVyuytyOPul0CIXwhJRMtwG8Frx+s+52rWpj0yVykLzl1pDlGBXz2jlGfxNsW/kjhYt4a+aBtz4js4N8Xb1VhJx95wGhI+bxdtW/UO951luJb2XMEAFuvy9HZHw4e3v+TalMjCEaQXfiKRUOCkJFGTInHQr9w66RNDeEd9K/glbfGdCsHohUyhrfzypkk2FxYnW6bE2DolTPjj6ZMN1kZwmhh/K7Zm0Md1YsrEbCLjdGLk+WmDghY9YmOS4AypSepgRMHN0v7eeuZj+d8otP89sUnIqmPkRyHGZUANg7NWdEGmm8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(8676002)(186003)(8936002)(316002)(478600001)(6486002)(52116002)(41300700001)(6666004)(5660300002)(6506007)(1076003)(26005)(44832011)(6512007)(66476007)(6916009)(4326008)(66556008)(66946007)(83380400001)(2616005)(2906002)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+JeArok8Q44/YfXbIYZbgPjCZFpDL6YisVpd6SRb6RPaI15EI0WH+8uE58Y?=
 =?us-ascii?Q?Qy3u4gNO5IFW4Ly3MIdVc84PluuPaoNr5QQnDkwY2PStHTqKkQ35pmnGlcjE?=
 =?us-ascii?Q?BQmI9MkhyiVTKIaB3wabVrNfvO6ZXQj4L/6Rbl1Ewrbtcn+gfQ4E4TOJii0W?=
 =?us-ascii?Q?kFBVK2jfbLXkcHFpd/TICSzdqlQVqcUUchnB/hOkT6e1H+Zz7IHZWd/iq9K6?=
 =?us-ascii?Q?dQDG7znifYqsel5rByrH6/XMfET81VqwUOL/ThVmHVJk8FP1LTK4nSvwDEiP?=
 =?us-ascii?Q?w9DxjxMjiyKUjp5jy6oxW7wlUKChawkQrrOHvqadreWJ8yRTpQuw1H87ACAm?=
 =?us-ascii?Q?1+pHJlpAhkaKA0J3WnIMEZuHzq+Y1JySdNmT0OI7vfMSp5suDU+T8hdKSx4p?=
 =?us-ascii?Q?IBRn2xOT3dMFAUM9W7AbWsF7nFmh6zuCMgo2o5iJZQd/s4G7DV3wIDlTxh8P?=
 =?us-ascii?Q?6uNHezEV28ncF4CaNqMoGuDVtYW2f4+d6vMKQno7PnzJ7fO8QUeLEAmKarEg?=
 =?us-ascii?Q?XyBTbdl8bqSBG1sYsfx+0UUCe/1XDsFn9Cgx+kgJmmPA18M2AxLczutE/8GI?=
 =?us-ascii?Q?koxYh0AKsblex0ytLWgbzlh8zmL1c0qrvRUA8vyzw8IaC9xc7zcikcPE2BHs?=
 =?us-ascii?Q?n3Z517s9VG8Wlm1sDLKqxWL0I2tGi++8QypTrOr0O+5kj+hqI06zncWgRogo?=
 =?us-ascii?Q?Ql75uFLc5QjZ7JxpKPqirI9pseNAze0xg3ZYS4IZRNuEk4zIYbA9WwmOTP9o?=
 =?us-ascii?Q?yvYhmG+kKyotOiSM+jUDgsENUfA1ZuO9d++DPMJbkYatFXbzK7eBLFhA6SLr?=
 =?us-ascii?Q?MYxGEl6E4RkSNb4yFbTyZkzWm80/XKKrFErOT6p9SK6TQh6xst2wRS/tuACY?=
 =?us-ascii?Q?/deSg4vXQTrO4p2WimFxLEnVjFvE8MUEcsYmUnkVX9EAngMGNxpz/gfKLdxy?=
 =?us-ascii?Q?0PWKNLEhKzSwQ0CvndwXFA99NToppLCFtOVUzutMmBmYLJ3+suvUlegzXXgO?=
 =?us-ascii?Q?DmqUlHMkyDtP/dBU0AUgMBZv/p4FRhBdT84OH0T/ostqWuNbgIzK7vtwZX99?=
 =?us-ascii?Q?2dyRK53BRB8vt8xOjmvQIf6KQhrQQEWtHde2czssCwWC1lP+sy/jzTvOwz2M?=
 =?us-ascii?Q?pOt84IEHVGUgevNG7ikHWdxJocJ3JMzVzz2quRsiKPv4j2IVtnTLEaz3ufyI?=
 =?us-ascii?Q?CmnAk2Hc/Qaut8g8oaqlkdZj+oMAEnJ1ztFpqgUWK0B1ze1GQAqbSJNRXuOH?=
 =?us-ascii?Q?hJcjVGoIwk5po9AwaYE83uk73LurkNIf45khVvV7Lf6b9q4zlFrfjehqgQz4?=
 =?us-ascii?Q?jdwWdYP+ZHZvROw5eSYxrbUD+ygFBslG1nZ/XOmxc9DGZGYQ/H5Le/rnkNOc?=
 =?us-ascii?Q?4kf/WGrX7glXa12XGPaT9SMCIVWs1pBnu7x+cip5iFQ7mbjMdHqwzs25BtOI?=
 =?us-ascii?Q?UjWr0MhQOImc27rkf8+Vmzx3fBq6wHRINKIlo0cqXt9IQt7fhpcsRs9Yd82a?=
 =?us-ascii?Q?R7Nt31bmqQUtI6mFlgp+BT94PRf0Uf5cv1pXmLSY0HFgSuWv5gSHlUB+RA8B?=
 =?us-ascii?Q?lJYmRR8Sw+BbZoaq4BYfcCGoAj/Sm1M6RNw7sGpX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843601cb-ab6b-43d9-487e-08db68195a94
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:10:30.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHXrImCYTiwoSFKc803Z6F34xslMD09luML+5pQIJA1jG9SqYvAF5N2gtL/Iijtua3VVJM/MCxeXeiZF1ET4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7597
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixed the following issue observed during PTS testing
- Specified Upper and Lower Limit for Volume offset
- Corrected the number of handles for VOCS
- VOCS is made as included service of VCS
  (VOCS is secondary service and VSC is primary service)
---
v2: Cosmetic Changes (Bluez Test Bot)
v3: No change
---
 src/shared/vcp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index aa75f498a..e656615cc 100644
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
 
 #define BT_VCP_NA                   0x00000000
 #define BT_VCP_FRONT_LEFT           0x00000001
@@ -100,7 +104,7 @@ struct bt_vcs_ab_vol {
 
 struct bt_vocs_set_vol_off {
 	uint8_t	change_counter;
-	uint8_t	set_vol_offset;
+	int16_t set_vol_offset;
 } __packed;
 
 struct bt_vcp_cb {
@@ -167,7 +171,7 @@ struct bt_vcs {
 
 /* Contains local bt_vcp_db */
 struct vol_offset_state {
-	uint16_t vol_offset;
+	int16_t vol_offset;
 	uint8_t counter;
 } __packed;
 
@@ -705,6 +709,11 @@ static uint8_t vocs_set_vol_offset(struct bt_vocs *vocs, struct bt_vcp *vcp,
 		return BT_ATT_ERROR_INVALID_CHANGE_COUNTER;
 	}
 
+	if (req->set_vol_offset > VOCS_VOL_OFFSET_UPPER_LIMIT ||
+		req->set_vol_offset < VOCS_VOL_OFFSET_LOWER_LIMIT) {
+		DBG(vcp, "error: Value Out of Range");
+		return BT_ATT_ERROR_VALUE_OUT_OF_RANGE;
+	}
 	vstate->vol_offset = req->set_vol_offset;
 	vstate->counter = -~vstate->counter; /*Increment Change Counter*/
 
@@ -971,7 +980,7 @@ static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
 							iov.iov_len);
 }
 
-static struct bt_vcs *vcs_new(struct gatt_db *db)
+static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 {
 	struct bt_vcs *vcs;
 	struct vol_state *vstate;
@@ -990,6 +999,8 @@ static struct bt_vcs *vcs_new(struct gatt_db *db)
 	/* Populate DB with VCS attributes */
 	bt_uuid16_create(&uuid, VCS_UUID);
 	vcs->service = gatt_db_add_service(db, &uuid, true, 9);
+	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
+	gatt_db_service_set_active(vdb->vocs->service, true);
 
 	bt_uuid16_create(&uuid, VOL_STATE_CHRC_UUID);
 	vcs->vs = gatt_db_service_add_characteristic(vcs->service,
@@ -1048,7 +1059,8 @@ static struct bt_vocs *vocs_new(struct gatt_db *db)
 
 	/* Populate DB with VOCS attributes */
 	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
-	vocs->service = gatt_db_add_service(db, &uuid, true, 9);
+
+	vocs->service = gatt_db_add_service(db, &uuid, false, 12);
 
 	bt_uuid16_create(&uuid, VOCS_STATE_CHAR_UUID);
 	vocs->vos = gatt_db_service_add_characteristic(vocs->service,
@@ -1110,11 +1122,10 @@ static struct bt_vcp_db *vcp_db_new(struct gatt_db *db)
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

