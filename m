Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950AC77B73
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 13:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjDSNol (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjDSNoj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 09:44:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E542E1258D
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 06:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3vCG3rrq+5Pe+geapcNxT+8HMwHgZWfKBYXl8hkLdNuEqcHEUBgT1sX9EDthWE7Ka05A9Kdv4/ZHgwFPbHX7PHpHK8sYseCf2G+ilU3WwrX6dUwGqsshsxc2OdYpIQ9MrD2fy0b55alpS4FwmI+Lsz1xy9IFCf3XztYsDJpgKhN/IoKUSCnhonGVDoNgQ+sL26OwijfZ3aH0jpeoy6zDihq7SlK7cSzWksONRNDbOGu8nJTUxvMfewCtuyU5hYxK8MRx7DzOa3+eaW3OrqU4ky05pxVOqgDLfSXxxxUgGF1N/qIRcOrEimmaLuTue82hr1iOuG/97yA/EJNw2Yzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCG1r5cxjgcuzlV8CXiWUtyAxJVZFS813vQbOx1Ou68=;
 b=bxr0kaur1Sf59IGVB7e4WN5wV6SDE7DmsjRe/WBSDPRfhBOcSqJYZdoK0UP4rFeazyWNy3d3w6P2Fh7F3H1bpX672lWqd+MCwHEBjr7nl8sW6fRRAwsaoySEpDjZJwr58X/qkvVVPXFuEFHHMMdcJqLBl8jW2XjvOE0U8Jh2ecGLfRwbmKpdItnyH6ZVOqri4vn4dmYXeiW7wn8oLFBAoz0KItPv7l+SbQZd8RZCBGYWq9uhOVpJoDNVapj1B078h+2bzVmiTxQ5+d2lWWq9TN9aCs38Xd/w0hpNfFsSJquaJT/KoqkSm42TQ24xraUhzWP5YK0CiA9scfxlkrxWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCG1r5cxjgcuzlV8CXiWUtyAxJVZFS813vQbOx1Ou68=;
 b=JcKlk3/QRM7smTN45x6Wb+zTKWa8V+kVh/20YLVGNlCypxzbsRxSOUVgRMHU+VTzt/i1RpDC/AgvE3R/1ZWOGbgSuNsJUZE5jkNhI6rvW/BygQ4o6maTGICbQfvZsfBbDUMADVAMUOFK3wkshpc1Mz/LPfHiGvDUrxs9il7l+No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:44:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 13:44:32 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] tools/iso-tester: Add Broadcast tests for encrypted BIG
Date:   Wed, 19 Apr 2023 16:43:54 +0300
Message-Id: <20230419134354.61950-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
References: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0119.eurprd05.prod.outlook.com
 (2603:10a6:207:2::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 8724b120-eda7-47c7-c406-08db40dc3469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1C10rpplEkZdzGybVHrpni9HoYtZDub1hLv1U8jCNj9OvHQG0pOiDprljdELLJJWULBw3oTeK7HdbbuyAfQvgJ7UJoKdhg1a1xPbBgaQXU6K9N4t0Gj0iWgqFV/oRA/x2WeZo/LD5r9nEI//nVZz2TBFtQyn1FCxiBZbC9c2S011OUTTB5aadS/kxVqbRSfTuroR2LM3SsqerU6EQN7UxGM5pnt+e0IPMX7niQZtDXrlbYRNDU+zbsFIczFUSQ6574ug0/9wZTKMiGMCFp1Hk2W256I43wGMaXPbD85BFwqqlM4m7UuNFDSD55UtYtDDvFqN5v18oC7cvojdY9wRIXyqry8iUMf9PUXpyZndQZyIUQgj/tIV0N9W35P0GERezEzS3qw5rTB5gG2968c5B4fU94ONCE5fTVOh/4ElsLdy45c3T2CA5blqJzjJqtQsEcDcf87ysntW/20hg/nv85n7JKfjBeiNv0DMA2yJziOv5A/PRj08PPoCJJ0eJ485q5FdcqFfq9gnrDai+8e7UhcUYdacmw9ubYExoBA6zLbifiZ0uA3O3+S5WOFUq4K5JeacNMk82EPjw+Adkgkzv83Gl+eEdDOGE4e32fhtvOU483POD5oAS7hAjUj5jsR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(5660300002)(44832011)(86362001)(2616005)(83380400001)(55236004)(6512007)(186003)(6506007)(1076003)(26005)(38350700002)(38100700002)(8676002)(8936002)(478600001)(6486002)(316002)(6666004)(52116002)(41300700001)(36756003)(4326008)(6916009)(66946007)(66556008)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WY2MoD6F/prRC4LDMN9JssZk1zZd8y6C3eML3KMCyROJjPAHP3Y+Yx/vMY87?=
 =?us-ascii?Q?Qk2T3hqVyzrFXS5rK9OA7Q+laaR/uTSHsEs6xHnBiwGr1+pzwXh3xRk5Bp1b?=
 =?us-ascii?Q?I7bM5ThH8/yn07zTdGy0E7mI5HThQskNq/gKN0filsTp8zqlZQ6UNvn6A0sL?=
 =?us-ascii?Q?isCxRw9GtEAOK90GR//MUgeeNleXkZTBl6AZzlWReEMz0HUGaDNXX6f/D1Yj?=
 =?us-ascii?Q?RFKBbdEKRQTLebzg4qDAK/cV3j5WI9zuYxvdaUnrruNsXo/KtTK2MKHdqw3z?=
 =?us-ascii?Q?joohyxiomxeLrl3vDf9kZt4lP7M7nwkC2gKPMPcRIng5j2BWny+UCXPjMiIs?=
 =?us-ascii?Q?HpN8cVNNG5MD6aOYK9sSVOqTz6aY/gwnGyPohFF6sNDBIaVDoqk9Ou8F4QRO?=
 =?us-ascii?Q?8Hp8ze2T/JL4fiPCZjhxaNvKo4+5ezZYllrGq4uAp4SGbL410zEg1C42n92W?=
 =?us-ascii?Q?Jw4p4kbB02bDlXmlwSwAVJSPu4ZYIuSKSkfCYsY8jrPrJqoz7Vxr2T1/IRYC?=
 =?us-ascii?Q?tnoRFzPTpfeHl6SuhxFNJDf96zIwxBnB+uBBTUoKwkdp9LlF6GHaE8vPdOd4?=
 =?us-ascii?Q?izpAGIw4fibfBv7hc5pWFFZdKUgooqHYurVsKHv2cg5dfye1WyUKewGy7gL/?=
 =?us-ascii?Q?aXCM38cW7a/YlJLRG1m9SZbjrcBkNBJ+Rj0Ywuj/kdKla9W3HZjw6lTdSpec?=
 =?us-ascii?Q?17RN3InC+nxkWJrYB5z4ONs0gpSNZucm8BLVXF3jwXS0yti27feIq4DKEAZB?=
 =?us-ascii?Q?D+wsJtf9YEYnU8jthwT9PSSJmZcIl0XGouJ7RWQQOaN9Ld+SQDGmYp7y3i/E?=
 =?us-ascii?Q?vi7NcKLazOzlvwhmShUpLUJQSHPDdGYGxfauuefWABUkEitggD7G8YU/B6ty?=
 =?us-ascii?Q?Gy8FzqZ6oebfNHvLaj3U4vOWxhRdzkI3WIrH13xgEPgNjd6WHBNU3ZnnZBbw?=
 =?us-ascii?Q?da7br95ND3ciBU0JPLXQOBngSrddQwqfel6MdxFVOjDBEpsy2h2VZZvE4458?=
 =?us-ascii?Q?kVuR3ViCxSxJGtc+TYCJswUpbGLabSQkIRc6Y1CZFGgJdfRvL9coxAQX6w/S?=
 =?us-ascii?Q?+imnFSFazrxKxlIJiwh3Gh84rxzU+3QWLAJ1vtdVPvc71YxeIaL9QOa+mxsa?=
 =?us-ascii?Q?75f7hpZHf/K9lmgzZuWLKrPGVgmDxeJy2hPjpin/Z6YrK2pE44eeDpqhXuS7?=
 =?us-ascii?Q?Xf3rcjEhi/zbnLnGrTBTCQP4LRnyAFs4j/Ctf/K7xQUnNTZEuQc97BExXUy4?=
 =?us-ascii?Q?z7I2xzXGQM4i6uxLMtC7Z4JDkqzy4CBYMOqbz8LZesLyRRUmF18a6Y5sJsCr?=
 =?us-ascii?Q?s7pI9KhHjYcGNkwIV/8WKA7DvLKMAR4Sr68iu6itbP07AqQcqIaAohcaNBGC?=
 =?us-ascii?Q?Xdt+m12HA2CIkfTeko2DlnVkjIB1Ev6uOCzUnSlRSiSn/4WGl5OEMldZSbBH?=
 =?us-ascii?Q?ZwoVav7+GNa2zCqC3b1n/DiSaWxUjImu/4nXXabnpmm1nw0SpCg5p0oZy6lD?=
 =?us-ascii?Q?gDtgE1p/fLUpyHZ+Emh2Tb+mSeFs/EpkLhMnxBp34cebaR2M7X65aip27eOS?=
 =?us-ascii?Q?ZKM9cMcWGq7BEtXTFYPyefJceFhb8dff3JAmgS2Au4Qu8x2AlDIj7+r1ek3f?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8724b120-eda7-47c7-c406-08db40dc3469
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:44:32.1202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkXCRWGiANGeondsBnuEbjU/kYFLgzv3g9uqlHGs+b7jc+Yd6uEBJOqFNHIMXEB2f5mVQHTpRee1oBHVTJe74Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following tests for encrypted broadcast:

ISO Broadcaster Encrypted - Success
ISO Broadcaster Receiver Encrypted - Success

---
 emulator/btdev.c   |  8 ++++++
 emulator/bthost.c  |  5 +++-
 emulator/bthost.h  |  4 ++-
 monitor/bt.h       |  2 ++
 tools/iso-tester.c | 64 +++++++++++++++++++++++++++++++++++++++++-----
 5 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a04f34d4b..7980a5280 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -6162,6 +6163,13 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 	dev->big_handle = cmd->handle;
 	bis = conn->data;
 
+	if (bis->encryption != cmd->encryption) {
+		pdu.ev.status = BT_HCI_ERR_ENC_MODE_NOT_ACCEPTABLE;
+		le_meta_event(dev, BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED, &pdu,
+					sizeof(pdu.ev));
+		return 0;
+	}
+
 	pdu.ev.handle = cmd->handle;
 	memcpy(pdu.ev.latency, bis->sdu_interval, sizeof(pdu.ev.interval));
 	pdu.ev.nse = 0x01;
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 8cdfa0c06..3179bb3d2 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3137,7 +3137,8 @@ void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_PA_ENABLE, &cp, sizeof(cp));
 }
 
-void bthost_create_big(struct bthost *bthost, uint8_t num_bis)
+void bthost_create_big(struct bthost *bthost, uint8_t num_bis,
+				uint8_t enc, const uint8_t *bcode)
 {
 	struct bt_hci_cmd_le_create_big cp;
 
@@ -3150,6 +3151,8 @@ void bthost_create_big(struct bthost *bthost, uint8_t num_bis)
 	cp.bis.latency = cpu_to_le16(10);
 	cp.bis.rtn = 0x02;
 	cp.bis.phy = 0x02;
+	cp.bis.encryption = enc;
+	memcpy(cp.bis.bcode, bcode, sizeof(cp.bis.bcode));
 	send_command(bthost, BT_HCI_CMD_LE_CREATE_BIG, &cp, sizeof(cp));
 }
 
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 92182687f..cdc12dc1c 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -102,7 +103,8 @@ void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
 void bthost_set_pa_params(struct bthost *bthost);
 void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
-void bthost_create_big(struct bthost *bthost, uint8_t num_bis);
+void bthost_create_big(struct bthost *bthost, uint8_t num_bis, uint8_t enc,
+				const uint8_t *bcode);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
diff --git a/monitor/bt.h b/monitor/bt.h
index 97501c7dc..2548f0dcd 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2014  Intel Corporation
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -3720,6 +3721,7 @@ struct bt_hci_evt_le_big_info_adv_report {
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
 #define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
 #define BT_HCI_ERR_CANCELLED			0x44
+#define BT_HCI_ERR_ENC_MODE_NOT_ACCEPTABLE	0x25
 
 struct bt_l2cap_hdr {
 	uint16_t len;
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index aad4b6574..c5c6f0aec 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -214,7 +214,10 @@
 #define AC_11ii_1 QOS_1(10000, 10, 40, 0x02, 2)
 #define AC_11ii_2 QOS_1(10000, 10, 40, 0x02, 2)
 
-#define QOS_BCAST_FULL(_big, _bis, _in, _out) \
+#define BCODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
+				0xa2, 0x65, 0xbb, 0xaf, 0xc6, 0xea, 0x03, 0xb8}
+
+#define QOS_BCAST_FULL(_big, _bis, _encryption, _bcode, _in, _out) \
 { \
 	.bcast = { \
 		.big = _big, \
@@ -224,8 +227,8 @@
 		.framing = 0x00, \
 		.in = _in, \
 		.out = _out, \
-		.encryption = 0x00, \
-		.bcode = {0}, \
+		.encryption = _encryption, \
+		.bcode = _bcode, \
 		.options = 0x00, \
 		.skip = 0x0000, \
 		.sync_timeout = 0x4000, \
@@ -237,24 +240,40 @@
 
 #define BCAST_QOS_OUT(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
-		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+		0x00, {0x00}, {}, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+
+#define BCAST_QOS_OUT_ENC(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		0x01, BCODE, {}, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
 
 #define BCAST_QOS_OUT_1(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_BCAST_FULL(0x01, BT_ISO_QOS_BIS_UNSET, \
-		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+		0x00, {0x00}, {}, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
 
 #define BCAST_QOS_OUT_1_1(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_BCAST_FULL(0x01, 0x01, \
-		{}, QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
+		0x00, {0x00}, {}, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
 
 #define BCAST_QOS_IN(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		0x00, {0x00}, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
+
+#define BCAST_QOS_IN_ENC(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		0x01, BCODE, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
 
 #define QOS_OUT_16_2_1 BCAST_QOS_OUT(10000, 10, 40, 0x02, 2)
+#define QOS_OUT_ENC_16_2_1 BCAST_QOS_OUT_ENC(10000, 10, 40, 0x02, 2)
 #define QOS_OUT_1_16_2_1 BCAST_QOS_OUT_1(10000, 10, 40, 0x02, 2)
 #define QOS_OUT_1_1_16_2_1 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
 #define QOS_IN_16_2_1 BCAST_QOS_IN(10000, 10, 40, 0x02, 2)
+#define QOS_IN_ENC_16_2_1 BCAST_QOS_IN_ENC(10000, 10, 40, 0x02, 2)
 
 struct test_data {
 	const void *test_data;
@@ -870,6 +889,13 @@ static const struct iso_client_data bcast_16_2_1_send = {
 	.bcast = true,
 };
 
+static const struct iso_client_data bcast_enc_16_2_1_send = {
+	.qos = QOS_OUT_ENC_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+};
+
 static const struct iso_client_data bcast_1_16_2_1_send = {
 	.qos = QOS_OUT_1_16_2_1,
 	.expect_err = 0,
@@ -892,6 +918,14 @@ static const struct iso_client_data bcast_16_2_1_recv = {
 	.server = true,
 };
 
+static const struct iso_client_data bcast_enc_16_2_1_recv = {
+	.qos = QOS_IN_ENC_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+};
+
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -1008,7 +1042,9 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 		if (isodata->bcast) {
 			bthost_set_pa_params(host);
 			bthost_set_pa_enable(host, 0x01);
-			bthost_create_big(host, 1);
+			bthost_create_big(host, 1,
+					isodata->qos.bcast.encryption,
+					isodata->qos.bcast.bcode);
 		} else if (!isodata->send && isodata->recv) {
 			const uint8_t *bdaddr;
 
@@ -1883,6 +1919,13 @@ static int listen_iso_sock(struct test_data *data)
 		}
 	}
 
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &isodata->qos,
+						sizeof(isodata->qos)) < 0) {
+		tester_print("Can't set socket BT_ISO_QOS option: %s (%d)",
+					strerror(errno), errno);
+		goto fail;
+	}
+
 	if (listen(sk, 10)) {
 		err = -errno;
 		tester_warn("Can't listen socket: %s (%d)", strerror(errno),
@@ -2257,6 +2300,9 @@ int main(int argc, char *argv[])
 
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
+	test_iso("ISO Broadcaster Encrypted - Success", &bcast_enc_16_2_1_send,
+							setup_powered,
+							test_bcast);
 	test_iso("ISO Broadcaster BIG 0x01 - Success", &bcast_1_16_2_1_send,
 							setup_powered,
 							test_bcast);
@@ -2268,6 +2314,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver Encrypted - Success",
+							&bcast_enc_16_2_1_recv,
+							setup_powered,
+							test_bcast_recv);
 
 	return tester_run();
 }
-- 
2.34.1

