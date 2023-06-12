Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C74C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jun 2023 13:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjFLNdx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jun 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbjFLNdw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jun 2023 09:33:52 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B9FB
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jun 2023 06:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDCsqokBi/N42U8KvPARc8bvJT2EMclYzhtJi6WECTEy0zHrORmGagM1Opg16dp+86kXaatqro2V9vMcO1FSSCJem+F1dcsVgXa8im6H1btK/0XG2LWnDocUVrqVTEu6VemzHHkebHf9WdKzapekYgUaZQ98roEfakqPCpHv/dJolaUz6h+BlxRBulHxUVmIYQFhKvYpJqMih4x8tyQDzZfVpVbLEhcgz6QqyTixQGhLA8bR5QGF8f0pGW+b6oPFypTETS3KgPAkq2o2CFn+CdhPZGTdVf+TejwGFLYi7CvXIxDgE1ceieL2GmiPLQTMDNb9Juj2x5Sm0uPVKdxiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5yhFzmI5hxrAXsqUptywBBym8iemfMW4SCPR7Ir9WI=;
 b=gp1CVG2NE0hPAOXZn7KHgFlpxG/8BFyedxl9eMnb602W87HIPLOfVIqgN/QGzTXZF7dvPLejM32PKGONgW2wxBHIaL2F0ECuhGxqUPV8vQr2+46Fjp6IVTBMT4GsvqwqX52Qrpi1kI4JU8WdqlUDZyU8PbRZjI3ZNFxVg2L6yZXUiDOBG1vvQWTsuPWxHgg30lbX4Ju9i8XNZT62IzVTvygOQ4Qr3o9v8/fLofAnNxsUI1TdUwR9AvqPlB/FwL9sJm8qFOCjLB6lJxFNvz31ph3/qwt1ide1aE4jAxI+K3Zy9mkFgtIbE+qc0JKci4ZGWD4k/8ST+3Z5SV4eyKhjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5yhFzmI5hxrAXsqUptywBBym8iemfMW4SCPR7Ir9WI=;
 b=Z4i+Wgk4gQ5hnZSuHms8KegMKWPmKw3HpFNOf+Yx4UsnrAmlWb6kocjWeAObcy0wA9584stuyWe+EKlDFsFIWHOrEuPkY3UXDKCuzCHdJqEZJ5i8oBI0BHicHtNDtjiSpgD4GHPH7jj7Z3eI8yjS6Vf6VhzrCaDNljI/A4BiNJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:33:50 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 13:33:50 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v5 3/3] shared/vcp.c: Make VOCS as an included service of VCS
Date:   Mon, 12 Jun 2023 19:02:51 +0530
Message-Id: <20230612133251.194-4-nitin.jadhav@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05d5265b-a5d0-4e72-a345-08db6b49a830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWhTjkHxylSj/+uF9ogsCJxePcm69grf6rq0M7QQGMi7oJE9fmFmY6jjRAwylcvUEtKw37QuUCYeu8LLpGApYczD6MyaOCkBgGCBRTn0aetRtPKzCapG2frC4/hDxJgpe+LI7qqhExuM0Kw9uVR+OTFHticc1HG3414W6Gnf9EY92K/RaBa75GBbGO+PHNv0jNIV92t64KWH5HQu3W3ngZ0ZsSJMsSG2uQIRI7+HqcBgHAQxgzzGfec6FvTehskHkd67Wz95+ifTTFFxnwAm0OVjZS2XbWK/0y+keR8WO7gZvc82VWPqJ16XEOCzBv+6+kYMefkPS193S3g/EV+UiGQ/xoN4M3PwpT/JUB0PM+PHyQsTz2Udi4MdELCJSjw/fUTLbpYndFbQ2NNxGRHuBNkMJin23jby1rxo44SJS4rpN28b+W9phRtsj9MMRbC91hpd6qQxUiqglL2Bm/TCvCH8svALpqrkAkKEtrkP3Ux2ZPSPbjZZkEEkIOoDcCmCwy7f/RvybIW6wHay8gB8mNM20TBsZl9QxifZHtiaIUatngRqio3DluEWO65lYN2Is7OdblmaGPEfFL2trsk/sl3OeyxHCHfrrvsnQ2Lc/NOjH7dIoU+ZvUceL7kMzh6P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(52116002)(6486002)(36756003)(83380400001)(2616005)(38350700002)(38100700002)(86362001)(6506007)(6512007)(1076003)(26005)(186003)(2906002)(5660300002)(44832011)(8936002)(8676002)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVJqJHrwUSDrLuXzPF3BayXii1VcgufOQx3pNfgzXimtdtv5C6UtLeYk6f8F?=
 =?us-ascii?Q?2ovG88MElv2xGEsxwE4qbC31uKrd8Ijzo2ajdv8nK91qVlOfeN6Q72JSCsZ7?=
 =?us-ascii?Q?dsUgj8/YdYjt2qUh4g3gkm78KGeXNfb0PtBo45VakiEzynF3/b6+JvsXus5V?=
 =?us-ascii?Q?JcYs6RYmvVyaDB2a0aMK5m3b2pxEqGS3VgbehTB/hvgXkw29nQwqugq6DgB1?=
 =?us-ascii?Q?fIhHlg1qpd6rJXAqIRpYyiNh1OdnpJ8b/3O2dzosI0rw9Wl2XsWNGzmyJxtu?=
 =?us-ascii?Q?JvGkGBYqo28ESD2nS6dKc6h8CM21OQVp/PaE/tiQK5z0r4Ilw1TWv0BJmrZD?=
 =?us-ascii?Q?FaVOnCXpF8XpNZt30X8sAG2nKUu8gKyczvQ9Nm5fsPQRtr1MnJzx/9r9nNhE?=
 =?us-ascii?Q?qpX3tDECu166fy6BW5NZjHwAv6tfjNeixK2qXsr/yxkA9UFuaFG3afguJuAM?=
 =?us-ascii?Q?Z6EEi+vHP4Y1FLmcmHx0p/NOf6kUr4OeRnuWIXvXj+hyWhKtXBdkxImjV9jf?=
 =?us-ascii?Q?JprklrYd0mpyddvXgT0DiO4z9OFUlFQc16AFRgGwBufoaloYg67a+wrmJPcY?=
 =?us-ascii?Q?qj7eyn3XJPv6s7+8kDTeKoaF6kVTES7u4ZVU5eKtIklj7ZwSy8Vuw1hPjvEI?=
 =?us-ascii?Q?oj739VbuGGtNsEV2FpD124vHGmMqyvQyc4heW0RiN58FKzWbqQ4jJcKk1XWw?=
 =?us-ascii?Q?9gFJz3cyJUJEEv+p71U3ka8FzTDlZNnlCYKRWc3VVNP6VVbvRCWwypMhr0Fv?=
 =?us-ascii?Q?6jNFkCyI4pMolzNmNK1vQqJ356oNjdtxP2QpjiGl8kbyb7zwBA6N03bTcUeH?=
 =?us-ascii?Q?CW6LbOdw00gODqeAU+RbZ1aGVOcTG4+I2yur3u0MyTzng3YT2Ey4yJ/wCJ36?=
 =?us-ascii?Q?jjd/ma3IS9RLuMpdsNjxVUM/ss+w2hKR1/D3TwFllCwSXLVmyh3Yg/pJ8/kc?=
 =?us-ascii?Q?gFfFlJZ6FfX6ToICcZLcDlXAdM2NVHmqdcOeABQboTP20KpALgaMPA5kpup1?=
 =?us-ascii?Q?Rf86q4s001aw+WTsb0w3AzKO8m3MkL4NAO1xGP6fqYi/uCcD2jqKBj0ygTMv?=
 =?us-ascii?Q?P0kGkuZBjrxRAmuxuldwKUx5v07pS1EfW7NH31iSebtAM3RF2S+a7ATEunq3?=
 =?us-ascii?Q?x3HkhuRg6wqP/bPjGW3E2GH8Nab4FhLcMMo689BBc3r4v1Dq0aZgZlsqhLln?=
 =?us-ascii?Q?1VO7/B52JXzvkADKWSygUNOU25K7zhr7bjUfTvCU8ZrCIH2J6zOmOiL9Lblw?=
 =?us-ascii?Q?wM2H2ocQhs5XQlblnv8polcGuIaE1TYkTuA43puuJ65RF9E56ZwezeoK9/Sg?=
 =?us-ascii?Q?LeK3+apttvCo0IxOGWwSw4Vuy9n/EK8ltT7Ca550eAwKKDBQWa79SLXO07ud?=
 =?us-ascii?Q?NuVhIlseoXkdsFzRupwm3as5kf9urtixEBngPee/fh2S3C8TIDo3K6/2yFAk?=
 =?us-ascii?Q?48GF7vXm4548L0fVcMBurHGbgHr8VmEf+bR0NdXZOhnGIa5fjNWxDyvXPahn?=
 =?us-ascii?Q?EvH78PnXoSTYY8ZN43KyONM4zGijoP0ShyFxJXeWMmChk5rsJwp3FyONXD8B?=
 =?us-ascii?Q?pbP51xTJrQaSNLFqKjef+PUsJ5cSV9ZTf+4cT037?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d5265b-a5d0-4e72-a345-08db6b49a830
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:33:50.4429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tODjJjUe5Gc/I//KrXsWRf94N+o63cMzrLdLDZh0HbKl4iOn8NgPCJaLaow1EJgRCgE+y0DogypS7LBNZF7E1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002
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
v5: Resolved GitLint warning (tedd_an/GitLint)
---

 src/shared/vcp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 92f21fd0b..74bd01729 100644
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

