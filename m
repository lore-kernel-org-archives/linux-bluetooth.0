Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204E1C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 20:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D394D61287
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 20:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhDLUfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:35:06 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17390 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhDLUfF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 16:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618259686; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Bw2swC3nRLw1LjxN7XnibNpYQ9zLoxFz0HJkS2O4tQ6kENpwD3aHgOEj61XYFB8xN+Guus8WgZurhVINIqhL4P7nOg9n+4pjteypTtnpCGWHLPX+87nejuSsJtrVmxtuM5KeYMv/u6R7ZBAEBU/effa69AR1QfidLF/6v4PfZ48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618259686; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=GjFl7TQkTCGqxAZckifq9fw2B/wpPtWZ1Y9gUPlpq5k=; 
        b=HTcGKGNbEtiRQdwtaisvMHKclrWX6XbEdXCvjqCDbmVRCQZ2qFBdQGtHa8Lv1XtFMtB21+zyRqbJGMJL7XV3uybXw81XsMpmTRIR4Yvy6p0nNAhxxwNywTQxCPsvBZ+O78tOQMkCfBoIcOwwkJXzmyYthKUTg94jJP2Y3qFAMtA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=maves.io;
        spf=pass  smtp.mailfrom=curtis@maves.io;
        dmarc=pass header.from=<curtis@maves.io> header.from=<curtis@maves.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618259686;
        s=dkim; d=maves.io; i=curtis@maves.io;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=GjFl7TQkTCGqxAZckifq9fw2B/wpPtWZ1Y9gUPlpq5k=;
        b=M8nrjiDaOm64Jhj8ciMtdaMnisUjDzlZV6jz52mAu0QPaxNk0EFVs4lyUAsigtaf
        RbNFy/Vzvf7ozob+emjFBLBcbklf8iVCNsom1PAMILcnBp/ga8UdUEe4oqQ4cKl9/rU
        VGUidbVTLG8h9ZXM5Wm9oD7GNo/nZJXOcGTx5RxI=
Received: from maves-arch-laptop.attlocal.net (107-216-162-79.lightspeed.iplsin.sbcglobal.net [107.216.162.79]) by mx.zohomail.com
        with SMTPS id 1618259683082683.5709696986727; Mon, 12 Apr 2021 13:34:43 -0700 (PDT)
From:   Curtis Maves <curtis@maves.io>
To:     linux-bluetooth@vger.kernel.org
Cc:     Curtis Maves <curtis@maves.io>
Subject: [PATCH Bluez v2] gatt: Either notify or indicate, do not do both
Date:   Mon, 12 Apr 2021 16:34:26 -0400
Message-Id: <20210412203426.213872-1-curtis@maves.io>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

AcquireNotify and StartNotify starts notifications and/or indications
by whether the characteristic supports them. Before this patch, if both
were supported, Bluez would try to start both simultaneously. This
patch changes this behavior so if both are supported, only
notifications are started. Test cases have also be updated accordingly.
---
 src/shared/gatt-client.c | 10 +++++-----
 unit/test-gatt.c         | 43 +++++++++++++++++++++++++++-------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 4e10f244d..9511ea8ca 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1585,20 +1585,20 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 {
 	uint8_t pdu[4];
 	unsigned int att_id;
+	uint16_t properties = notify_data->chrc->properties;
 
 	assert(notify_data->chrc->ccc_handle);
 	memset(pdu, 0, sizeof(pdu));
 	put_le16(notify_data->chrc->ccc_handle, pdu);
 
 	if (enable) {
-		/* Try to enable notifications and/or indications based on
+		/* Try to enable notifications or indications based on
 		 * whatever the characteristic supports.
 		 */
-		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
+		if (properties & BT_GATT_CHRC_PROP_NOTIFY)
 			pdu[2] = 0x01;
-
-		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
-			pdu[2] |= 0x02;
+		else if (properties & BT_GATT_CHRC_PROP_INDICATE)
+			pdu[2] = 0x02;
 
 		if (!pdu[2])
 			return false;
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 4aa87d09c..6a47268e6 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -241,8 +241,8 @@ struct context {
 #define CHARACTERISTIC_DISC_SMALL_DB					\
 		raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x03, 0x28),	\
 		raw_pdu(0x09, 0x07, 0x02, 0x00, 0xb2, 0x03, 0x00, 0x29,	\
-			0x2a),						\
-		raw_pdu(0x08, 0x03, 0x00, 0xff, 0xff, 0x03, 0x28),	\
+			0x2a, 0x07, 0x00, 0x22, 0x08, 0x00, 0x28, 0x2a),\
+		raw_pdu(0x08, 0x08, 0x00, 0xff, 0xff, 0x03, 0x28),	\
 		raw_pdu(0x09, 0x07, 0x12, 0xf0, 0x02, 0x13, 0xf0, 0x00,	\
 			0x2a),						\
 		raw_pdu(0x08, 0x13, 0xf0, 0xff, 0xff, 0x03, 0x28),	\
@@ -256,11 +256,17 @@ struct context {
 		raw_pdu(0x01, 0x08, 0x18, 0xf0, 0x0a)
 
 #define DESCRIPTOR_DISC_SMALL_DB					\
-		raw_pdu(0x04, 0x04, 0x00, 0x10, 0x00),			\
+		raw_pdu(0x04, 0x04, 0x00, 0x06, 0x00),			\
 		raw_pdu(0x05, 0x01, 0x04, 0x00, 0x02, 0x29, 0x05, 0x00,	\
 			0x01, 0x29),					\
-		raw_pdu(0x04, 0x06, 0x00, 0x10, 0x00),			\
-		raw_pdu(0x01, 0x04, 0x06, 0x00, 0x0a),			\
+		raw_pdu(0x04, 0x06, 0x00, 0x06, 0x00),			\
+		raw_pdu(0x05, 0x01, 0x06, 0x00, 0x00, 0x29),		\
+		raw_pdu(0x0a, 0x06, 0x00),				\
+		raw_pdu(0x0b, 0x01, 0x00),				\
+		raw_pdu(0x04, 0x09, 0x00, 0x10, 0x00),			\
+		raw_pdu(0x05, 0x01, 0x09, 0x00, 0x02, 0x29),		\
+		raw_pdu(0x04, 0x0a, 0x00, 0x10, 0x00),			\
+		raw_pdu(0x01, 0x04, 0x0a, 0x00, 0x0a),			\
 		raw_pdu(0x04, 0x16, 0xf0, 0x16, 0xf0),			\
 		raw_pdu(0x05, 0x01, 0x16, 0xf0, 0x00, 0x29),		\
 		raw_pdu(0x0a, 0x16, 0xf0),				\
@@ -1565,6 +1571,13 @@ static struct gatt_db *make_test_spec_small_db(void)
 							"Manufacturer Name"),
 		DESCRIPTOR(GATT_CHARAC_EXT_PROPER_UUID, BT_ATT_PERM_READ, 0x01,
 									0x00),
+		CHARACTERISTIC_STR(GATT_CHARAC_SOFTWARE_REVISION_STRING,
+						BT_ATT_PERM_READ,
+						BT_GATT_CHRC_PROP_READ |
+						BT_GATT_CHRC_PROP_INDICATE,
+						"5.59"),
+		DESCRIPTOR(GATT_CLIENT_CHARAC_CFG_UUID, BT_ATT_PERM_READ
+			| BT_ATT_PERM_WRITE, 0x00, 0x00),
 
 		PRIMARY_SERVICE(0xF010, GAP_UUID, 9),
 		INCLUDE(0x0001),
@@ -2308,7 +2321,7 @@ static void test_indication(struct context *context)
 }
 
 static const struct test_step test_indication_1 = {
-	.handle = 0x0003,
+	.handle = 0x0008,
 	.func = test_indication,
 	.value = read_data_1,
 	.length = 0x03,
@@ -2573,9 +2586,10 @@ int main(int argc, char *argv[])
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x01, 0x00, 0x0f, 0x00, 0x03, 0x28),
 			raw_pdu(0x09, 0x07, 0x02, 0x00, 0xb2, 0x03, 0x00, 0x29,
-					0x2a),
-			raw_pdu(0x08, 0x03, 0x00, 0x0f, 0x00, 0x03, 0x28),
-			raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a));
+					0x2a, 0x07, 0x00, 0x22, 0x08, 0x00,
+					0x28, 0x2a),
+			raw_pdu(0x08, 0x08, 0x00, 0x0f, 0x00, 0x03, 0x28),
+			raw_pdu(0x01, 0x08, 0x08, 0x00, 0x0a));
 
 	define_test_server("/TP/GAD/SR/BV-04-C/large-1", test_server,
 			ts_large_db_1, NULL,
@@ -2626,9 +2640,10 @@ int main(int argc, char *argv[])
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x01, 0x00, 0x0f, 0x00, 0x03, 0x28),
 			raw_pdu(0x09, 0x07, 0x02, 0x00, 0xb2, 0x03, 0x00, 0x29,
-					0x2a),
-			raw_pdu(0x08, 0x03, 0x00, 0x0f, 0x00, 0x03, 0x28),
-			raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a));
+					0x2a, 0x07, 0x00, 0x22, 0x08, 0x00,
+					0x28, 0x2a),
+			raw_pdu(0x08, 0x08, 0x00, 0x0f, 0x00, 0x03, 0x28),
+			raw_pdu(0x01, 0x08, 0x08, 0x00, 0x0a));
 
 	define_test_server("/TP/GAD/SR/BV-05-C/large-1", test_server,
 			ts_large_db_1, NULL,
@@ -3241,7 +3256,7 @@ int main(int argc, char *argv[])
 			&test_notification_1,
 			CLIENT_INIT_PDUS,
 			SMALL_DB_DISCOVERY_PDUS,
-			raw_pdu(0x12, 0x04, 0x00, 0x03, 0x00),
+			raw_pdu(0x12, 0x04, 0x00, 0x01, 0x00),
 			raw_pdu(0x13),
 			raw_pdu(),
 			raw_pdu(0x1B, 0x03, 0x00, 0x01, 0x02, 0x03));
@@ -3267,7 +3282,7 @@ int main(int argc, char *argv[])
 			&test_indication_1,
 			CLIENT_INIT_PDUS,
 			SMALL_DB_DISCOVERY_PDUS,
-			raw_pdu(0x12, 0x04, 0x00, 0x03, 0x00),
+			raw_pdu(0x12, 0x09, 0x00, 0x02, 0x00),
 			raw_pdu(0x13),
 			raw_pdu(),
 			raw_pdu(0x1D, 0x03, 0x00, 0x01, 0x02, 0x03),
-- 
2.31.1

