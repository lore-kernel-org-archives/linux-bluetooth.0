Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90565C7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCTOkG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjCTOjc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:39:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF38252A6
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFGz/nk4ZXFJlpPXm/7yeyWxdXyJFmCUWWwcqVk+VKAfTOXWZeo3tlOnd1L4AeXsn2g98bDjEnj+e4isc2eJVlvPE+jvW+ldKgCMHDMMUznH7dbyhQNwP2BNi9ECbhPI1pDBLwDR8UElCgQIN+AE0zjz80CwtKIa1kSr+HLt9ZpDIzaeB2jLF7NsrBd+m59pAc+B8zKiEV1hAEQsSpHweMKFlhgyAW/pbyq74VZGBTzZiRG21/3sbvCfvUn1InKgTFTCVJzAXWDtE4qceHB9MTBjEOp7VV485U9h/wYT6re08oElZ685TFrmY9ZLMgTLN3Og/7wh5fIE5NGqeutKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwO7QxuEMM0nKL0CNUeTZsGstAyZ++3JC0cSHXNsZfc=;
 b=AFacp/PtJQocSflJxYHzGpN8Jm8N52tnLEf6ql7tZ/Sk5A1w2q359UzMoMkEn0fWeKTLD1bbaJcRMnNnMyfFW0Tq968Y6PESfdYHzQY51LFRa0EHFAVWBU/GTcN75KS07Xejpf4IHibhT11lrPSfbwFudiYXuXzlwuJmcICPjqUzKufSvPBSzQ4I1E7WhDUFIwjLzCJ0JY2aLM8ULfmiB+zQDpvHC1BEbh1g7kZHALxFsQOvyFAcdcj/UAwMwtMgCnmDlgohaYpimt39vrwny1uAraZDUSMiN/gtOz41agU5K2BKOBTmoiklrIeZgKGvmSdQ3b2tTh3ttWmv3b5knA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwO7QxuEMM0nKL0CNUeTZsGstAyZ++3JC0cSHXNsZfc=;
 b=ZOIvnkTZr0AVbvkeEYhkpe9hpT+scLtTxpf7AxzUlSHDOjoXtPd407d7kqGhkfY7167/Y7udmnVJPZMkeJNouqoTx0fd0ZrxDt3ertXh0W4Y2XSTpuuxX1h+zeVsogl4zQPKWlcV1W2Pm8pg57JUbFXTmuVGNMVEJKeGIJEeDnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:44 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:44 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 8/8] tools/iso-tester: Use dedicated ISO QoS options for unicast and broadcast
Date:   Mon, 20 Mar 2023 16:37:13 +0200
Message-Id: <20230320143713.25449-9-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
References: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc8f048-71bb-4087-c136-08db2950aa95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ55kL9QuuxP+uVicrUQ4mozEj+uuoJvgKm0QKbdJO9oyu2y1Nso7cDbvOH0ZEKZxAAt+7f8ZEqLs97hfyFXlNES12j7q5CWiyrFcriSkK3olbiZ72lesaQ19BPlMCkZe+al3+CRmp3ma+ytRQfP16oBDnOiRLkUv+rWHP8rJcQ3lIFJ7VMTF5VUX6n9wxKvd3KzvOwa7CepwoFuAEU3W3kFEHxJcrHGOhOSafTwIF8Na5tu9wRQjbNy0MIub6lh0f1TrccZq06gezOuxVo7+J6ZEOEj3JBMM/9a64vprSFoto/4l7GLin+BZ8iNmIEq9scuQ+LaHzT3TP6XABH9H+SpsGz0Rc1DIA93BKYUUHpdHwNYEfZBxGZJu0HQOVQKpIroAJmDy3zUwz1PRTfTSNr9xsIz2dV0CiueaiRzrPm6Lu8jVIbyBpglt7cmKSSFNPzq8OrDNMRej5j+Qt/YN6sr+akA5ua8KDxrxger+YVTkeYRbtbL3VIVcCHSr8lDL/PsNktJ5lVJVBPYZJKQfoZp1eI+K37iDxQkJSbT07OTNQ+asJWRazzyWdgKJhGCcM8KLzz0TIX/VBa3yHa2aQazeydMKW8fyPBcAQSSC/MKes9GJnrrWDtYjpVe/0ErcT0vlOjpx7nmJEUzScF4D3TyVpRrlMliR+SAFj/xAbJ823vO1A8X32uR0HB01YT7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(30864003)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JnrWBu8Eq5yXl6Tk1lFERv/oTTO5htaWdxUwQYSuRRuwqrkZMO10iM3Kdt1h?=
 =?us-ascii?Q?vKY6yguMzSD7nz/CmCKfaPAczK+4QE8yCbR372/GPZrxkDXf9/o54mz7i5pY?=
 =?us-ascii?Q?8vtq/HV/F7OxnQ0r42UJQKSvW6UPrV1sAKhuWAXmUHqgWjxjXkxH4HjUVdCC?=
 =?us-ascii?Q?EVC6A4DPDFzzXGs7CVPkS/ZCDf6i8FHTdikYzzYJ0+hv+/aBqlhGkEpck3tX?=
 =?us-ascii?Q?9bgZPyGFTLxsrY+8OmyEdUtwx39dhMc5a54PWilL+XHe8ACNPGO2YneVZZJI?=
 =?us-ascii?Q?6YHa/lU7N7IiWqyjdTzBoOHPx1oeWyqrHhxhPkmGfLAfwDhIX8eyEh6U/csT?=
 =?us-ascii?Q?pPu2XsTDJMtzJ9iSZELoJbSUCbV8sk4tenRvvkMQDXoo0vZ0lyA04frBS4LP?=
 =?us-ascii?Q?ADalI0HJWqqbTOqd4cbZG/Kxw3lbHJ6aiIH6ZUrrxEztesO6Fl834zRTYPyi?=
 =?us-ascii?Q?Faj1J8VWXG3ph2Bn78yBdKqW7+ipc61aAL/+R3gC3LY8eWvf423s0Fxd4uhV?=
 =?us-ascii?Q?uCWq0W8GpJXpdItee85Enq5awS40VsOpNAkcwXNs9P3ym8Wek1C4qf699j1D?=
 =?us-ascii?Q?toTOTqF1zxzahEZdd8rqZFmbthPutCZGw2tJqpeV9W/DXFMfRt2e3NqXKs3N?=
 =?us-ascii?Q?O4cRgNKJ9SkVt1D2Hn0OptQyovxIv0rLQPwr6+DtjNUkqh2OOTMD5856z8zW?=
 =?us-ascii?Q?pXahQMOLHRkSK9FKMDQI/DSRUS5PY16FOhhZ8Modek+RryLnn1PLUuFJ7xRB?=
 =?us-ascii?Q?/dJw07M0pHzFAVnuk8wv6ZHGaq4tS7UE1stzbEamnlhWLySgHCiDmml+J1FG?=
 =?us-ascii?Q?7ugO7ssP0r/lrePW3rNE8CPHInTlHXM3qx9Ia1Vwo5W5XMoxu9i1uLKTc9pe?=
 =?us-ascii?Q?menbqnZ8eRNA1R9MfABBIZdQ/LwZQs9Fz4ghyBF1GqXk2zGWeFUdFsBV6Sy4?=
 =?us-ascii?Q?F+f/iKmDAovm+AjpOLNtJlzY1dsH7ckxPy1pXI0ankN6jzBuUuqvrBbPy+Cp?=
 =?us-ascii?Q?atbhmZPke4ExYMdWigd/bRKclGjVtG3dl03cVtvTNLJzz0eOphJ2kU5jlwb/?=
 =?us-ascii?Q?vEkozRaCadKgD1nlm4E0I2kPrkc1ffPCy7CGVdT9DWEv5HoDtT47ji3AP3MQ?=
 =?us-ascii?Q?scEXszL0GluA8v2AKjau9ahhKYUSc63V3P2zrHOdgiagzl4KivLGPSojaKWB?=
 =?us-ascii?Q?CXX4LFAuR62aurskMYgJjJzLGwvaWoBqLpFgkvQs3ZS4liQUnme1sJLgTIC9?=
 =?us-ascii?Q?p6+uvjXN5Cwaaiz9mNRH1/hysYnRpinAk8ERNKHpjPuFnnZxCMu3RsOPIg1U?=
 =?us-ascii?Q?jx5esz4Y8JapSHa3TGzEEVWW7ShFwdM1j6y1JcDOrtroAu+QiVERrBYz2l69?=
 =?us-ascii?Q?p0tJ3Rig1IDefnkZ4KjoI7W4i2FMUF+9MUVV6ZDVJQw9IEY5Kp+6N6ETYMQX?=
 =?us-ascii?Q?RftykF/x5GnB0LgSGe0yWIHCO9KLcDqNIUciK5mT2ePB40g1PD8YPGF+jzWB?=
 =?us-ascii?Q?arCIMqs9R81yBkijJWq9KwTP7ltICegn6x66Z1BVcr7OeIrzl/43ZdFjeAIu?=
 =?us-ascii?Q?2Oi/UqyUhdzkWsKNoHu8Xa0bYw7+IkR8mtaZxZjFSBEETB3iNpMNtxsID2NT?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc8f048-71bb-4087-c136-08db2950aa95
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:44.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CwSVdHgTDMUu1mXReqHzu+G8CRCusN2rIBweTHU1olZwe9L0G3MJ4zuMF5+g5k6zUPRdfat4pMTHmJoqjKr4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Convert the generic bt_iso_qos structure into dedicated ISO QoS structures
for unicast or broadcast.

---
 tools/iso-tester.c | 270 +++++++++++++++++++++++++++++++++------------
 1 file changed, 200 insertions(+), 70 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index e4582573a..a763c6a09 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation.
+ *  Copyright 2023 NXP
  *
  */
 
@@ -119,10 +120,52 @@
 #define QOS_48_5_2 QOS_OUT(7500, 75, 117, 0x02, 13)
 #define QOS_48_6_2 QOS_OUT(10000, 100, 155, 0x02, 13)
 
-#define QOS_OUT_16_2_1 QOS_OUT(10000, 10, 40, 0x02, 2)
-#define QOS_OUT_1_16_2_1 QOS_OUT_1(10000, 10, 40, 0x02, 2)
-#define QOS_OUT_1_1_16_2_1 QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
-#define QOS_IN_16_2_1 QOS_IN(10000, 10, 40, 0x02, 2)
+#define QOS_SINK_FULL(_big, _in) \
+{ \
+	.options = 0x00, \
+	.skip = 0x0000, \
+	.sync_timeout = 0x4000, \
+	.sync_cte_type = 0x00, \
+	.big = _big, \
+	.encryption = 0x00, \
+	.bcode = {0}, \
+	.mse = 0x00, \
+	.timeout = 0x4000, \
+	.in = _in, \
+}
+
+#define QOS_SOURCE_FULL(_big, _bis, _out) \
+{ \
+	.sync_interval = 0x07, \
+	.big = _big, \
+	.bis = _bis, \
+	.packing = 0x00, \
+	.framing = 0x00, \
+	.encryption = 0x00, \
+	.bcode = {0}, \
+	.out = _out, \
+}
+
+#define BCAST_QOS_OUT(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_SOURCE_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define BCAST_QOS_OUT_1(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_SOURCE_FULL(0x01, BT_ISO_QOS_BIS_UNSET, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define BCAST_QOS_OUT_1_1(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_SOURCE_FULL(0x01, 0x01, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define BCAST_QOS_IN(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_SINK_FULL(BT_ISO_QOS_BIG_UNSET, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define QOS_OUT_16_2_1 BCAST_QOS_OUT(10000, 10, 40, 0x02, 2)
+#define QOS_OUT_1_16_2_1 BCAST_QOS_OUT_1(10000, 10, 40, 0x02, 2)
+#define QOS_OUT_1_1_16_2_1 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define QOS_IN_16_2_1 BCAST_QOS_IN(10000, 10, 40, 0x02, 2)
 
 struct test_data {
 	const void *test_data;
@@ -141,7 +184,9 @@ struct test_data {
 };
 
 struct iso_client_data {
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos unicast_qos;
+	struct bt_iso_bcast_sink_qos sink_qos;
+	struct bt_iso_bcast_source_qos source_qos;
 	int expect_err;
 	const struct iovec *send;
 	const struct iovec *recv;
@@ -369,182 +414,182 @@ static void test_data_free(void *test_data)
 	test_iso_full(name, data, setup, func, 1, reason)
 
 static const struct iso_client_data connect_8_1_1 = {
-	.qos = QOS_8_1_1,
+	.unicast_qos = QOS_8_1_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_8_2_1 = {
-	.qos = QOS_8_2_1,
+	.unicast_qos = QOS_8_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_16_1_1 = {
-	.qos = QOS_16_1_1,
+	.unicast_qos = QOS_16_1_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_16_2_1 = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_1_16_2_1 = {
-	.qos = QOS_1_16_2_1,
+	.unicast_qos = QOS_1_16_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_1_1_16_2_1 = {
-	.qos = QOS_1_1_16_2_1,
+	.unicast_qos = QOS_1_1_16_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_24_1_1 = {
-	.qos = QOS_24_1_1,
+	.unicast_qos = QOS_24_1_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_24_2_1 = {
-	.qos = QOS_24_2_1,
+	.unicast_qos = QOS_24_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_32_1_1 = {
-	.qos = QOS_32_1_1,
+	.unicast_qos = QOS_32_1_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_32_2_1 = {
-	.qos = QOS_32_2_1,
+	.unicast_qos = QOS_32_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_44_1_1 = {
-	.qos = QOS_44_1_1,
+	.unicast_qos = QOS_44_1_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_44_2_1 = {
-	.qos = QOS_44_2_1,
+	.unicast_qos = QOS_44_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_1_1 = {
-	.qos = QOS_48_1_1,
+	.unicast_qos = QOS_48_1_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_2_1 = {
-	.qos = QOS_48_2_1,
+	.unicast_qos = QOS_48_2_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_3_1 = {
-	.qos = QOS_48_3_1,
+	.unicast_qos = QOS_48_3_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_4_1 = {
-	.qos = QOS_48_4_1,
+	.unicast_qos = QOS_48_4_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_5_1 = {
-	.qos = QOS_48_5_1,
+	.unicast_qos = QOS_48_5_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_6_1 = {
-	.qos = QOS_48_6_1,
+	.unicast_qos = QOS_48_6_1,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_8_1_2 = {
-	.qos = QOS_8_1_2,
+	.unicast_qos = QOS_8_1_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_8_2_2 = {
-	.qos = QOS_8_2_2,
+	.unicast_qos = QOS_8_2_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_16_1_2 = {
-	.qos = QOS_16_1_2,
+	.unicast_qos = QOS_16_1_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_16_2_2 = {
-	.qos = QOS_16_2_2,
+	.unicast_qos = QOS_16_2_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_24_1_2 = {
-	.qos = QOS_24_1_2,
+	.unicast_qos = QOS_24_1_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_24_2_2 = {
-	.qos = QOS_24_2_2,
+	.unicast_qos = QOS_24_2_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_32_1_2 = {
-	.qos = QOS_32_1_2,
+	.unicast_qos = QOS_32_1_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_32_2_2 = {
-	.qos = QOS_32_2_2,
+	.unicast_qos = QOS_32_2_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_44_1_2 = {
-	.qos = QOS_44_1_2,
+	.unicast_qos = QOS_44_1_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_44_2_2 = {
-	.qos = QOS_44_2_2,
+	.unicast_qos = QOS_44_2_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_1_2 = {
-	.qos = QOS_48_1_2,
+	.unicast_qos = QOS_48_1_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_2_2 = {
-	.qos = QOS_48_2_2,
+	.unicast_qos = QOS_48_2_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_3_2 = {
-	.qos = QOS_48_3_2,
+	.unicast_qos = QOS_48_3_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_4_2 = {
-	.qos = QOS_48_4_2,
+	.unicast_qos = QOS_48_4_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_5_2 = {
-	.qos = QOS_48_5_2,
+	.unicast_qos = QOS_48_5_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_48_6_2 = {
-	.qos = QOS_48_6_2,
+	.unicast_qos = QOS_48_6_2,
 	.expect_err = 0
 };
 
 static const struct iso_client_data connect_invalid = {
-	.qos = QOS(0, 0, 0, 0, 0),
+	.unicast_qos = QOS(0, 0, 0, 0, 0),
 	.expect_err = -EINVAL
 };
 
 static const struct iso_client_data connect_reject = {
-	.qos = QOS_16_1_2,
+	.unicast_qos = QOS_16_1_2,
 	.expect_err = -ENOSYS
 };
 
@@ -561,20 +606,20 @@ static const struct iovec send_48_2_1 = {
 };
 
 static const struct iso_client_data connect_16_2_1_send = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.send = &send_16_2_1,
 };
 
 static const struct iso_client_data listen_16_2_1_recv = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.recv = &send_16_2_1,
 	.server = true,
 };
 
 static const struct iso_client_data listen_16_2_1_recv_ts = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.recv = &send_16_2_1,
 	.server = true,
@@ -582,27 +627,27 @@ static const struct iso_client_data listen_16_2_1_recv_ts = {
 };
 
 static const struct iso_client_data defer_16_2_1 = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.defer = true,
 };
 
 static const struct iso_client_data connect_16_2_1_defer_send = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.defer = true,
 };
 
 static const struct iso_client_data connect_48_2_1_defer_send = {
-	.qos = QOS_48_2_1,
+	.unicast_qos = QOS_48_2_1,
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.defer = true,
 };
 
 static const struct iso_client_data listen_16_2_1_defer_recv = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.recv = &send_16_2_1,
 	.server = true,
@@ -610,7 +655,7 @@ static const struct iso_client_data listen_16_2_1_defer_recv = {
 };
 
 static const struct iso_client_data listen_48_2_1_defer_recv = {
-	.qos = QOS_48_2_1,
+	.unicast_qos = QOS_48_2_1,
 	.expect_err = 0,
 	.recv = &send_48_2_1,
 	.server = true,
@@ -618,7 +663,7 @@ static const struct iso_client_data listen_48_2_1_defer_recv = {
 };
 
 static const struct iso_client_data listen_16_2_1_defer_reject = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = -1,
 	.recv = &send_16_2_1,
 	.server = true,
@@ -626,50 +671,51 @@ static const struct iso_client_data listen_16_2_1_defer_reject = {
 };
 
 static const struct iso_client_data connect_16_2_1_send_recv = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.recv = &send_16_2_1,
 };
 
 static const struct iso_client_data disconnect_16_2_1 = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.disconnect = true,
 };
 
 static const struct iso_client_data reconnect_16_2_1 = {
-	.qos = QOS_16_2_1,
+	.unicast_qos = QOS_16_2_1,
 	.expect_err = 0,
 	.disconnect = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_send = {
-	.qos = QOS_OUT_16_2_1,
+	.source_qos = QOS_OUT_16_2_1,
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.bcast = true,
 };
 
 static const struct iso_client_data bcast_1_16_2_1_send = {
-	.qos = QOS_OUT_1_16_2_1,
+	.source_qos = QOS_OUT_1_16_2_1,
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.bcast = true,
 };
 
 static const struct iso_client_data bcast_1_1_16_2_1_send = {
-	.qos = QOS_OUT_1_1_16_2_1,
+	.source_qos = QOS_OUT_1_1_16_2_1,
 	.expect_err = 0,
 	.send = &send_16_2_1,
 	.bcast = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_recv = {
-	.qos = QOS_IN_16_2_1,
+	.sink_qos = QOS_IN_16_2_1,
 	.expect_err = 0,
 	.recv = &send_16_2_1,
 	.bcast = true,
+	.server = true,
 };
 
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
@@ -854,7 +900,7 @@ static void test_getsockopt(const void *test_data)
 {
 	int sk, err;
 	socklen_t len;
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
 	if (sk < 0) {
@@ -867,7 +913,7 @@ static void test_getsockopt(const void *test_data)
 	len = sizeof(qos);
 	memset(&qos, 0, len);
 
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS, &qos, &len);
 	if (err < 0) {
 		tester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
@@ -885,7 +931,7 @@ static void test_setsockopt(const void *test_data)
 {
 	int sk, err;
 	socklen_t len;
-	struct bt_iso_qos qos = QOS_16_1_2;
+	struct bt_iso_unicast_qos qos = QOS_16_1_2;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
 	if (sk < 0) {
@@ -895,7 +941,8 @@ static void test_setsockopt(const void *test_data)
 		goto end;
 	}
 
-	err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, sizeof(qos));
+	err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS,
+						&qos, sizeof(qos));
 	if (err < 0) {
 		tester_warn("Can't set socket option : %s (%d)",
 							strerror(errno), errno);
@@ -906,7 +953,7 @@ static void test_setsockopt(const void *test_data)
 	len = sizeof(qos);
 	memset(&qos, 0, len);
 
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS, &qos, &len);
 	if (err < 0) {
 		tester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
@@ -1004,8 +1051,14 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 		}
 	}
 
-	err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &isodata->qos,
-						sizeof(isodata->qos));
+	if (!isodata->bcast)
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_UNICAST_QOS,
+			&isodata->unicast_qos, sizeof(isodata->unicast_qos));
+	else {
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_BCAST_SOURCE_QOS,
+			&isodata->source_qos, sizeof(isodata->source_qos));
+	}
+
 	if (err < 0) {
 		tester_warn("Can't set socket BT_ISO_QOS option : %s (%d)",
 							strerror(errno), errno);
@@ -1080,8 +1133,8 @@ static bool check_io_qos(const struct bt_iso_io_qos *io1,
 	return true;
 }
 
-static bool check_qos(const struct bt_iso_qos *qos1,
-				const struct bt_iso_qos *qos2)
+static bool check_unicast_qos(const struct bt_iso_unicast_qos *qos1,
+				const struct bt_iso_unicast_qos *qos2)
 {
 	if (qos1->cig != BT_ISO_QOS_CIG_UNSET &&
 			qos2->cig != BT_ISO_QOS_CIG_UNSET &&
@@ -1124,6 +1177,62 @@ static bool check_qos(const struct bt_iso_qos *qos1,
 	return true;
 }
 
+static bool check_bcast_source_qos(const struct bt_iso_bcast_source_qos *qos1,
+				const struct bt_iso_bcast_source_qos *qos2)
+{
+	if (qos1->sync_interval != qos2->sync_interval) {
+		tester_warn("Unexpected QoS sync interval: 0x%02x != 0x%02x",
+				qos1->sync_interval, qos2->sync_interval);
+		return false;
+	}
+
+	if (qos1->big != BT_ISO_QOS_BIG_UNSET &&
+			qos2->big != BT_ISO_QOS_BIG_UNSET &&
+			qos1->big != qos2->big) {
+		tester_warn("Unexpected BIG ID: 0x%02x != 0x%02x",
+				qos1->big, qos2->big);
+		return false;
+	}
+
+	if (qos1->bis != BT_ISO_QOS_BIS_UNSET &&
+			qos2->bis != BT_ISO_QOS_BIS_UNSET &&
+			qos1->bis != qos2->bis) {
+		tester_warn("Unexpected BIS ID: 0x%02x != 0x%02x",
+				qos1->bis, qos2->bis);
+		return false;
+	}
+
+	if (qos1->packing != qos2->packing) {
+		tester_warn("Unexpected QoS packing: 0x%02x != 0x%02x",
+				qos1->packing, qos2->packing);
+		return false;
+	}
+
+	if (qos1->framing != qos2->framing) {
+		tester_warn("Unexpected QoS framing: 0x%02x != 0x%02x",
+				qos1->framing, qos2->framing);
+		return false;
+	}
+
+	if (qos1->encryption != qos2->encryption) {
+		tester_warn("Unexpected QoS encryption: 0x%02x != 0x%02x",
+				qos1->encryption, qos2->encryption);
+		return false;
+	}
+
+	if (memcmp(qos1->bcode, qos2->bcode, sizeof(qos1->bcode))) {
+		tester_warn("Unexpected QoS Broadcast Code");
+		return false;
+	}
+
+	if (!check_io_qos(&qos1->out, &qos2->out)) {
+		tester_warn("Unexpected Output QoS");
+		return false;
+	}
+
+	return true;
+}
+
 static gboolean iso_recv_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1249,14 +1358,28 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 	const struct iso_client_data *isodata = data->test_data;
 	int err, sk_err, sk;
 	socklen_t len;
-	struct bt_iso_qos qos;
+	int optname;
+	bool ret = true;
+
+	union {
+		struct bt_iso_unicast_qos unicast_qos;
+		struct bt_iso_bcast_sink_qos sink_qos;
+		struct bt_iso_bcast_source_qos source_qos;
+	} qos;
 
 	sk = g_io_channel_unix_get_fd(io);
 
+	if (!isodata->bcast)
+		optname = BT_ISO_UNICAST_QOS;
+	else if (isodata->server)
+		optname = BT_ISO_BCAST_SINK_QOS;
+	else
+		optname = BT_ISO_BCAST_SOURCE_QOS;
+
 	len = sizeof(qos);
 	memset(&qos, 0, len);
 
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+	err = getsockopt(sk, SOL_BLUETOOTH, optname, &qos, &len);
 	if (err < 0) {
 		tester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
@@ -1264,7 +1387,14 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	if (!check_qos(&qos, &isodata->qos)) {
+	if (!isodata->bcast)
+		ret = check_unicast_qos(&qos.unicast_qos,
+					&isodata->unicast_qos);
+	else if (!isodata->server)
+		ret = check_bcast_source_qos(&qos.source_qos,
+					&isodata->source_qos);
+
+	if (!ret) {
 		tester_warn("Unexpected QoS parameter");
 		tester_test_failed();
 		return FALSE;
@@ -1579,7 +1709,7 @@ static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
 		client = hciemu_get_client(data->hciemu, 0);
 		host = hciemu_client_host(client);
 
-		bthost_set_cig_params(host, 0x01, 0x01, &isodata->qos);
+		bthost_set_cig_params(host, 0x01, 0x01, &isodata->unicast_qos);
 		bthost_create_cis(host, 257, data->acl_handle);
 	}
 }
-- 
2.34.1

