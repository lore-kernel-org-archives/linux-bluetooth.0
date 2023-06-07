Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F804C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 12:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbjFGMO1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjFGMOY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 08:14:24 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8CB1BE3
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 05:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeEX7UOHAcLGO4BY2C5mTJeFbv0VIo1KqDUR2/5Q2nkWbqA2Iz3J2Jl+/lIbWmc+1fsgrgy+JMBVBM0CYfSP8lvwaYh+gjQNgwTaNAFQa404MWsxZgU63LXLMDQCJSRRLawfb+y5EgIy7egGoLX1gnYX6qNT8crq5ZfoJUx1POe7xcahExsBtJe0ujkc3VCwivJHGYMkCKoU//XsvrpSLxP0xN+SSBzazyR50kAA+RNQhD5NUU8whQN1sEGGxvNA9+vxaANOnuUIh13euyi+ZAwyS2i0A59DD+2wIBXoY25r9Tvz25LZkCVeaYOHHAEMJtuyIRTj7PQuyAQFs2xozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U32rteFPZhBvqPBZOT5DB6FLUnNyhc34GkoNTvAuqqw=;
 b=ngZsFMy/pYqZS/q3644YeyUKNbb2ioc1XzM5O9po5Po5dvah/t2E7WmLFbdaw2VaeLbe44RN4EiMw46XvIXteamHjKkeC0obwPAuQ5/uljIc+ayt5InfO2LiJS5qMEKjDCONoTxfPu5EcX4fAU65HognphSphTiZEg1BQrnADlQjYicU6rKKc/DNhRZaxThb+rg9g9XqBXAymXt2gM89buPs+ZA+dzTvV9/kCLAsCeatc06rxFsoe6v224fUa+0rD5oRMdHGEYs6+37Mk43MVjRlWELyIZWWhqwIgy6kx3sLRsKKaD13H1EADTw5IoIrFqqCCwhN5inw4PDfvzTJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U32rteFPZhBvqPBZOT5DB6FLUnNyhc34GkoNTvAuqqw=;
 b=Gz8Re7pk9ACozxyFraBTSD7d/iZX2hMeKGEYUAXQUx1biJM38XBeC47kQR2XyBWM9xE3m2h0cwQCKJGuzmzMVfG67s69SN7kJuxd8yJXCDVvYqTixmNep9vDmaavuEdLnHrY2CuELnla2IcRLgQIKZlgcf0fh6nhCBXMUH3/pqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:14:21 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:14:21 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 2/2] Make VOCS (Secondary) as an included service of VCS (Primary)
Date:   Wed,  7 Jun 2023 15:13:42 +0300
Message-Id: <20230607121342.6136-3-nitin.jadhav@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 551fbafc-0deb-4ac4-6a32-08db6750b961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hcT0ZaETit8AF1LGbltX4NdfHCyiWYRwC770Pd/+00TjW79yj1j3Jg3Cwa4KuszXpAffxPC7HP9XbaLusFcYzdjxSKLGTOiB8qZvxb0VdL8ON2eqqSyj6+PvFPwq8f9n+rwtPRY/0fY+VGqaY6Aapp73yboZizQwHFOLDMosIBbwox+lTfpf8XniWi5VudwtMycMyGZZcvRTr17gzmD4WnQutoEyP4griQ515GQMiIUhSyRwNh8k9VSk3gRl3g3HLvOxX25gm++/JFeOSclSoWuRpoZmDpy3nyFAr8FAXvRFJe3cI0zCrKVrHraD2UNvansJQ5A3zaq19X2trDOQ+ZF6Z8uu/llJK3JEcaNLTnoypvsdBOIn6x8l84wwOVl/5HnoDKpyzUPkeCA5AJMVFPpa44hew8rS2RTZZpN4tf8k7HHu6oT3eSL5RksyDV4iw26CmOWviVWTntZcwoeQJMJ8gieb2qfrxPJf0+GmGxSL49nlBu/HKxfLmY++9jaeQGo227M9HzQFZSDF2scceRsOk1v2K3eCXBXFo3Oc3kT48DSXkRh19KS+ESbf13GIlsNQuE0HFzyM7+5YPDxhZOULBFLT9FJP6YKHnBeIOA+/GX3jZBCNgO0aXrSZXdu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(478600001)(5660300002)(8936002)(44832011)(8676002)(36756003)(86362001)(2906002)(66556008)(66476007)(6916009)(66946007)(316002)(4326008)(6506007)(41300700001)(38350700002)(2616005)(38100700002)(6512007)(1076003)(26005)(83380400001)(6486002)(52116002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZ5FzMek5SnpwCV641dWWh43Xa4qcIWPJx0CtcMKfEIdDRQQvg+HWoQrf+XN?=
 =?us-ascii?Q?urgVBajAinggeoJvYLQ5Id2b48Ax0Iezjl76HGlywfEytykkM/xtch3ynwIw?=
 =?us-ascii?Q?xr8XIHMRSrWVNw0jfJDynMZQjJycBH7NWT2U7Q9tSMhTKKbqiNyQ57CKbmlu?=
 =?us-ascii?Q?KkzAyMUT6NlpF8mYsgjeYswz7F6YqepcxX3Ys8Bx902p2vj70p0suTyo3ip9?=
 =?us-ascii?Q?iiGRPTmNB4RVIoz0RSuZD0sZcDNqZFVu0Ula4yIliMMHWrW35ajIwXAEvbeD?=
 =?us-ascii?Q?lBA18UmDFrCFMhr96X/a8CLy+pfY9BjfmgFsS0+SuFNiwsOfaODIFiMDphPK?=
 =?us-ascii?Q?qgiOjC+eJSObQZEhhNUzf6leeaNsL7Smnxb+kASkC5rZq4I6DN8/yUc+r8IP?=
 =?us-ascii?Q?m5vdmrBPnnXAf8lPwxrbcru7+Q45OB+FDpnigH2pqIksmtA7MkDAZcN+kB1I?=
 =?us-ascii?Q?J6lme3lFe2b4Asotk3TCKWvM5C+v7JwHVY3XEIIKmo98e562E8p0RsieMZ/m?=
 =?us-ascii?Q?RKvAOf2Kkl4jI4NefiJLwjpTjsO1cEB/1xiPwwxMTf4nElh+r/tkbBMWO7d6?=
 =?us-ascii?Q?IXJyIYE1s7iH8vIKrmTPxs3C/CbmzqObWUoa7FBLYGsWV0h8gCyeJbsLREUF?=
 =?us-ascii?Q?0lNxte7KuUN2YAKb+hlk0HPLSNp22b3kVfo/O10wexEjzC2XMTfJMv8gzxHf?=
 =?us-ascii?Q?L9hLxxHR1tNNWBLnrY2wDoKt/WCBTq0bN4x+qNXHgpb+gE/G1Kn+IfLtR5fQ?=
 =?us-ascii?Q?WFjhE8q34eqjFNqY2C7FBZtAtNpoV973N1VJjp/ULDZ7mI82XPROXEpPxJzH?=
 =?us-ascii?Q?7jp54Hz9op+Nfcu8bGgNX57IzXv+uCAhzkvar4VQ3mT0m9Id+JqEXQkukcqm?=
 =?us-ascii?Q?VVf7+CQcuiPAe7hfx1o4qT/YDKb/fn3YQdmYbzXXP33cQOi5kjIfLEiv47yN?=
 =?us-ascii?Q?V5nbj/D5u8pb7pmtCypb7nVtEBUiHlvlS8JN3qvmLO2ZvSnoAIzdN9UpoYax?=
 =?us-ascii?Q?zEFmcrUa6VWuXcvpOmHXiA7CpIwpJmRNFzlDFf2Ex0egdVRE4EEJfEmJkQU5?=
 =?us-ascii?Q?kOXAmYcBO2Da+cuXsxgq0oBmJmiYh5xx9++DAcp+/Sg29HtYgHVp+zAlTSmx?=
 =?us-ascii?Q?3PgUoB4uxEHvmrRTi1IRzOxdXqVXl3oWT9sp+RLn6G3pzLfORtg9jrKAlBSi?=
 =?us-ascii?Q?Iay/PDEzCFmkYQeQHRzeNmsS2q4004+9GIPmmL61VLcAjPJyKCOp0K7BdTKU?=
 =?us-ascii?Q?kpSG56Xj/pz++FX03eGqtg7xm7EgvErvPzK3erbLddR0tx1xhCFj9fCoTvO9?=
 =?us-ascii?Q?tylmtM6sezBuyFqnKn4UkeciOTPW07ensAanahDDOw87fAtKhoweDdHo6ovv?=
 =?us-ascii?Q?s0AKtMHCiILQA/s/5IfOduMNzNPGVCLgJjdyJffzM/VxvIkttWMRZw1nMKIf?=
 =?us-ascii?Q?bz563VS/RKv2GWj9rkT/seoQyW28/1AzP1PFyeSLAYt0gIIOjLPzrRT9iHN/?=
 =?us-ascii?Q?e25WLLU7PJfRwYIsW53MHrT5qi4MgzfWCue39k/TxfrylykidswDZA8UPxFo?=
 =?us-ascii?Q?JbKpkU9OYnOkvhnJwek7VFJUbrxmqR4R2lWy74v5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551fbafc-0deb-4ac4-6a32-08db6750b961
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:14:21.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lclQkQI+P5JWHl90SPy2dEwv88Aeyq/SbwlOv/XVVQEc5R3VHjOieuIeZ177UrileYbIHmWfuB9nYaoFu5muQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434
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
---
 src/shared/vcp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index e9bd6e88b..7a9a6c9ed 100644
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

