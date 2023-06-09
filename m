Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C99C7EE2E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 09:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbjFIJwa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbjFIJvj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 05:51:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B191E5597
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 02:44:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCGZ8rOj1/rdZ/814hEq8WFBUcjRblRWgXNW1VYl3GIztsrfY68PSgdayoSlUhZeuQyXnsta970D12tMlr3KWZPuqfEmIhDWM5PSRlhSHxlHaedp/Sn7FHPfbbec7xGRdtG2kPAG18OfrOsWX+h5/hgPCYGx4uEb65ScLGz770Remr5x+7XBfOgtecZFO91ASITBucUunjcwdY+fmNJRWM/gVPO2tsp1HBbhBHC+OOiovdM8FzqtNElBfawknNVK6HmKtTGxB+pfyD8hpYfKZLxY9pdyesF031mRxAWlfJDJBLC+gAyApVxuN69qjewQeDiDVjOSjbDM94lqMjO9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtmtePmdXN/XdtqE2lOonnIg7eVdZcnLvkbijL0OgE0=;
 b=oe7rWjpQUY1X4m8hmLMd7Fj4GeeMJPJiQ0yJLjkwsOLq2GU30sX7YrdKzFIB1Ja8Xx7vCH0lgKHBJmk/xZwyLCmk7gmMf+dXkyIPxQrf0QXbgpLZN5hKxZ1JZ5jl/qAMD1qagsTF9SP26/2NnmgUps8uGuNTDab86OudXAzQReMO6gkOjD4+qm4xpC7sWblvOwPBJqSRhduL8SVsxQx7MMkQC/lcgNX5BkTUGa69STUzM320KatyDtrkngWTivFqkjU7kuqvzRnVSGH47LMju6dDLrurSPjmsrWaHTXNzHxgh0DVD8YC9Jgv5VZb1nXBESApBnKeXF0EVdUK9EmWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtmtePmdXN/XdtqE2lOonnIg7eVdZcnLvkbijL0OgE0=;
 b=o0vW4nlo3TtgfFiUaYea6kcd4t9KxsguCJiG/XbcsuvypttmvWsFNquoIJMkpVHyfIegb0sE81kiHeMVPMzZy7QoQKF5hnIeEBOxkZnNtCfZC/3LupS26rHU7sItJdsniBhFNciOrIfSLbfW4m3sZGyfjnSUzCS9/2tN9u/pw1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PAXPR04MB8191.eurprd04.prod.outlook.com (2603:10a6:102:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Fri, 9 Jun
 2023 09:43:17 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 09:43:17 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v4 3/3] shared/vcp.c: Make VOCS (Secondary) as an included service of VCS (Primary)
Date:   Fri,  9 Jun 2023 15:12:22 +0530
Message-Id: <20230609094222.1877-4-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.33.1.windows.1
In-Reply-To: <20230609094222.1877-1-nitin.jadhav@nxp.com>
References: <20230609094222.1877-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PAXPR04MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: fd71efb9-6dc4-4afa-eb21-08db68cdf3d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAoaIQg9Z3gerhJe8FpqU2MSGBgxT5RyeVce5JtB1IqdzO4A8/JOWuTGcP5MZDe89/34m7kEWBGGbsw/hlpBR4XZOscCt7ht6fRaSuLzdpREIRf0A9zadbMphS/RnMcisoD4np4NpDwY036Dl8fz0xjxtDlq9FpV4QFf2xeLnX7OxMbcwmtMgQkfqgKtFy4xlERdo6m2NeqSunY9+oBKeVotXefY2QpAOoicknZmWov2X3bdT3Lr/fn/zOGyxFYW8mlJNRoc+UdMaS5OgGso7zejpJO8CBZihyGMSd/rMZf2oPLUXas0cYE0v6iwTNm5popUP8kXIDtuHHtfiJagIxOH/8fXFm7YcTxCX9yn0KiTcZft9UVXAFr/Z3GIEhr3mDH2dmxtX4jQydttehzUK3H74cIeK/uKQpmg/VhceKhfDAE5NdJxhi24572E2uXTbB9X5ncXqgifUx2s+OeOn/xOf11q6ppOZg0c+XvKTa7QdPO6cp+ADrePNQjIkcR6zObO8FSapX8vV4hjZ5xlbN3ddZt8CYpbdvOQKgz1gOEgOY4Iss1xn9SrjjAhobPJz5yMvBTGDVnvIcC19iJ/Is2jd1MO0nw1OgCOV/5a5+7mwXkFlqShqdJHuGXVGq8a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199021)(36756003)(2906002)(86362001)(44832011)(5660300002)(2616005)(52116002)(6486002)(186003)(83380400001)(6666004)(6506007)(26005)(6512007)(1076003)(478600001)(66946007)(66556008)(66476007)(4326008)(38350700002)(38100700002)(316002)(41300700001)(6916009)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3pRSy762gMA5UYsUjjx4D7Vde7rsq2tgjYWzhy0+kjT5BDZU5IDmH4tTWILw?=
 =?us-ascii?Q?qNkwQVal67Blk+Jxkq/UWISYBKbECFeL0vrQnH3/l9kfYlwIkrMxWIGcmka1?=
 =?us-ascii?Q?ZZt9CJayi+/OVv3eqn79Y45uOhyRS2EBcONsuSId6iuuRXCPAV2QmSKl1sqh?=
 =?us-ascii?Q?dWjWtHLHvxY69cTrzy2jMIHI5Jgj2m8sJZ+ips9aI9bvFtLM2PINK4cyxXrK?=
 =?us-ascii?Q?lNAaJ23QIsHly0nnQsDCtEL8AOWVI6EUgd1+NmH51NdT7FC7Z7a6sSSIpZt1?=
 =?us-ascii?Q?ds5xcCgR6u78dXqaqZJuNG/AyvHly7auG8uxq0TJlhFj9wITpYp7Mup+Rubq?=
 =?us-ascii?Q?nafuyguw59LnzRlhh/PZFXatu9jalaFwWZ8eX0dhDG2/Alcpz0TRnr25OZVS?=
 =?us-ascii?Q?dWgVJaAG/IihhCdohHJFWQAgcIsi2KZzrhS3gvInsZCDkl6yMR85DUu4qlE9?=
 =?us-ascii?Q?BMISyZK5DrYpb3D5tdRxOkqQHG8n9cJ2trVvoT9L8rfn5M9fTDXtBZ0xUQGv?=
 =?us-ascii?Q?eVPKmKZV76pd5CuquTfK6hJJEb3rwXmqHWYUNnB/72ojIBlrKQKMR1b89aVz?=
 =?us-ascii?Q?+NHwyPMgtwcVBfodfoIe8T8dzkZTl3LRlVf2m5yUYSeEzcuso8NhjWJqHJ4E?=
 =?us-ascii?Q?ivRsmYGcjPx2MhhVmR4fu2PBL4DJHsSfxV5drF/GlBVKL1QT39wwks5so1PK?=
 =?us-ascii?Q?4MsAVaTj5klO8x3Fp9c8vYGrQMGjcFIu+pga2EYoISujQNkOPpseTWjRuAQp?=
 =?us-ascii?Q?++wHylfU7B0ePzVYuEN1XHURIEQsgi8x2Rdbv6ERMKCWNH+rxVkCX/MCEG6b?=
 =?us-ascii?Q?ci+C5zCBWaJfiylpo1SpMGPjUeWhmtab7X1AHUCe/iJMsPhDuzrw93GNavRH?=
 =?us-ascii?Q?M+e9W+Jd1kCPV4Hc0vtrVwAAyGwijMNlgsZr157A2oKTqF0OlwQY7lHidkqw?=
 =?us-ascii?Q?SPLGbBRbyL4rfel+zY3qA88UcdkBO5ny64Z/S0jJISKp+aTZm2v51TioeEjA?=
 =?us-ascii?Q?kisce8hVO2H+YRfrGd2N80fh8lxaEH3wMN22kdDWcwwVYYk9A8Fx+3CAZrZt?=
 =?us-ascii?Q?OSIEObb1R9M2eMWzSDiUH5rq0jJk9pj0oOsfyjL+nkt+b3U53up/RvGYs5mW?=
 =?us-ascii?Q?njuI7PgpBYbRwyBmxhzOsj5Vx8ZiOXcPdXTgowlVwcfvZca6rthJEDN4MQOj?=
 =?us-ascii?Q?ipcA08hAq4qW6mgr7mawCJCXSbLzSe+tKv/G8csMTu8XzQz7FnyW9L0svMeW?=
 =?us-ascii?Q?0ovOqGNW5QqoY/X7UU9e/fgvVFysKh3GgZs3sDy7MjW8flIqeMNCjhtYrezs?=
 =?us-ascii?Q?b25nSu1Dz46lnxLrMrbwE4MAcscK6+imAPhNSZ2yYuANxBbkvx+cxI1gslvQ?=
 =?us-ascii?Q?RVdCQ439FyTQ23ugjJR0gNh5AFTf+cEYtjSWwoYJ8P74wqAIR8rRJh2zsmq6?=
 =?us-ascii?Q?gSBoYKhprjgzu5+HXVskxtwXDkkRethQbnIgxjUIBVHFpoXGE6eqi6xym4k0?=
 =?us-ascii?Q?0y8Ff2GevptG8mLW72lpWc2tucAwXawM32bnvRDWfzk4nrD78H7DgfLzHY/2?=
 =?us-ascii?Q?FNgcaMtM/JzLInXzGHKHijQzex/kp7ltmg9VFLnGgTK5pD9hLyCS7sRbkRfN?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd71efb9-6dc4-4afa-eb21-08db68cdf3d6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:43:17.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAoJGvWtNuyNdg+hSQSGALc4cxsiS6TxNUa2iDBWQHIxAyosWGM80hsxcReYQxZyVpk0FCC7G4j8MO1R7TmhoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8191
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
index 6fc788e13..93f72a678 100644
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
 
 #define BT_VCP_NA                   BIT(0)
 #define BT_VCP_FRONT_LEFT           BIT(1)
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

