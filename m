Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D20C05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 18:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCNSEe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 14:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCNSEd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 14:04:33 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804F39EF45
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 11:04:31 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 065A6240685
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 19:04:29 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PbhHd2SDHz6tns;
        Tue, 14 Mar 2023 19:04:29 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: fix Locations, Context to be PACS not PAC properties
Date:   Tue, 14 Mar 2023 18:04:27 +0000
Message-Id: <3eff7be0f5f2cd5df7585ed2a2dc82bc84ff7f38.1678816865.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Audio Locations and Contexts are properties of the PACS service, not of
individual PAC, as these are device-wide bitmaps and a single
characteristic may exist on PACS server (PACS v1.0 Sec 3).

Move the attributes out from bt_bap_pac to bt_bap_pacs, and actually
keep track of the values.
---
 src/shared/bap.c | 74 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 952b7be26..13189aab4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -91,6 +91,12 @@ struct bt_pacs {
 	struct gatt_db_attribute *context_ccc;
 	struct gatt_db_attribute *supported_context;
 	struct gatt_db_attribute *supported_context_ccc;
+	uint32_t source_loc_value;
+	uint32_t sink_loc_value;
+	uint16_t source_context_value;
+	uint16_t sink_context_value;
+	uint16_t supported_source_context_value;
+	uint16_t supported_sink_context_value;
 };
 
 struct bt_ase {
@@ -171,8 +177,6 @@ struct bt_bap_pac {
 	struct bt_bap_db *bdb;
 	char *name;
 	uint8_t type;
-	uint32_t locations;
-	uint16_t contexts;
 	struct bt_bap_codec codec;
 	struct bt_bap_pac_qos qos;
 	struct iovec *data;
@@ -203,7 +207,6 @@ struct bt_bap_stream_io {
 struct bt_bap_stream {
 	struct bt_bap *bap;
 	struct bt_bap_endpoint *ep;
-	struct queue *pacs;
 	struct bt_bap_pac *lpac;
 	struct bt_bap_pac *rpac;
 	struct iovec *cc;
@@ -380,7 +383,8 @@ static void pacs_sink_loc_read(struct gatt_db_attribute *attrib,
 				uint8_t opcode, struct bt_att *att,
 				void *user_data)
 {
-	uint32_t value = 0x00000003;
+	struct bt_pacs *pacs = user_data;
+	uint32_t value = cpu_to_le32(pacs->sink_loc_value);
 
 	gatt_db_attribute_read_result(attrib, id, 0, (void *) &value,
 							sizeof(value));
@@ -412,7 +416,8 @@ static void pacs_source_loc_read(struct gatt_db_attribute *attrib,
 				uint8_t opcode, struct bt_att *att,
 				void *user_data)
 {
-	uint32_t value = 0x00000001;
+	struct bt_pacs *pacs = user_data;
+	uint32_t value = cpu_to_le32(pacs->source_loc_value);
 
 	gatt_db_attribute_read_result(attrib, id, 0, (void *) &value,
 							sizeof(value));
@@ -423,9 +428,10 @@ static void pacs_context_read(struct gatt_db_attribute *attrib,
 				uint8_t opcode, struct bt_att *att,
 				void *user_data)
 {
+	struct bt_pacs *pacs = user_data;
 	struct bt_pacs_context ctx = {
-		.snk = 0x0fff,
-		.src = 0x000e
+		.snk = cpu_to_le16(pacs->sink_context_value),
+		.src = cpu_to_le16(pacs->source_context_value)
 	};
 
 	gatt_db_attribute_read_result(attrib, id, 0, (void *) &ctx,
@@ -437,9 +443,10 @@ static void pacs_supported_context_read(struct gatt_db_attribute *attrib,
 					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
+	struct bt_pacs *pacs = user_data;
 	struct bt_pacs_context ctx = {
-		.snk = 0x0fff,
-		.src = 0x000e
+		.snk = cpu_to_le16(pacs->supported_sink_context_value),
+		.src = cpu_to_le16(pacs->supported_source_context_value)
 	};
 
 	gatt_db_attribute_read_result(attrib, id, 0, (void *) &ctx,
@@ -456,6 +463,14 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 
 	pacs = new0(struct bt_pacs, 1);
 
+	/* Set default values */
+	pacs->sink_loc_value = 0x00000003;
+	pacs->source_loc_value = 0x00000001;
+	pacs->sink_context_value = 0x0fff;
+	pacs->source_context_value = 0x000e;
+	pacs->supported_sink_context_value = 0x0fff;
+	pacs->supported_source_context_value = 0x000e;
+
 	/* Populate DB with PACS attributes */
 	bt_uuid16_create(&uuid, PACS_UUID);
 	pacs->service = gatt_db_add_service(db, &uuid, true, 19);
@@ -2862,6 +2877,13 @@ static void read_source_pac_loc(bool success, uint8_t att_ecode,
 		return;
 	}
 
+	if (length != sizeof(uint32_t)) {
+		DBG(bap, "Invalid Source PAC Location size: %d", length);
+		return;
+	}
+
+	pacs->source_loc_value = get_le32(value);
+
 	gatt_db_attribute_write(pacs->source_loc, 0, value, length, 0, NULL,
 							NULL, NULL);
 
@@ -2891,6 +2913,13 @@ static void read_sink_pac_loc(bool success, uint8_t att_ecode,
 		return;
 	}
 
+	if (length != sizeof(uint32_t)) {
+		DBG(bap, "Invalid Sink PAC Location size: %d", length);
+		return;
+	}
+
+	pacs->sink_loc_value = get_le32(value);
+
 	gatt_db_attribute_write(pacs->sink_loc, 0, value, length, 0, NULL,
 							NULL, NULL);
 
@@ -2913,12 +2942,21 @@ static void read_pac_context(bool success, uint8_t att_ecode,
 {
 	struct bt_bap *bap = user_data;
 	struct bt_pacs *pacs = bap_get_pacs(bap);
+	const struct bt_pacs_context *ctx = (void *)value;
 
 	if (!success) {
 		DBG(bap, "Unable to read PAC Context: error 0x%02x", att_ecode);
 		return;
 	}
 
+	if (length != sizeof(*ctx)) {
+		DBG(bap, "Invalid PAC Context size: %d", length);
+		return;
+	}
+
+	pacs->sink_context_value = le16_to_cpu(ctx->snk);
+	pacs->source_context_value = le16_to_cpu(ctx->src);
+
 	gatt_db_attribute_write(pacs->context, 0, value, length, 0, NULL,
 							NULL, NULL);
 }
@@ -2929,6 +2967,7 @@ static void read_pac_supported_context(bool success, uint8_t att_ecode,
 {
 	struct bt_bap *bap = user_data;
 	struct bt_pacs *pacs = bap_get_pacs(bap);
+	const struct bt_pacs_context *ctx = (void *)value;
 
 	if (!success) {
 		DBG(bap, "Unable to read PAC Supproted Context: error 0x%02x",
@@ -2936,6 +2975,14 @@ static void read_pac_supported_context(bool success, uint8_t att_ecode,
 		return;
 	}
 
+	if (length != sizeof(*ctx)) {
+		DBG(bap, "Invalid PAC Supported Context size: %d", length);
+		return;
+	}
+
+	pacs->supported_sink_context_value = le16_to_cpu(ctx->snk);
+	pacs->supported_source_context_value = le16_to_cpu(ctx->src);
+
 	gatt_db_attribute_write(pacs->supported_context, 0, value, length, 0,
 							NULL, NULL, NULL);
 }
@@ -4594,14 +4641,17 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
 
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 {
-	struct bt_bap_pac *pac;
+	struct bt_pacs *pacs;
 
 	if (!stream)
 		return 0x00000000;
 
-	pac = stream->rpac ? stream->rpac : stream->lpac;
+	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
 
-	return pac->locations;
+	if (stream->ep->dir == BT_BAP_SOURCE)
+		return pacs->source_loc_value;
+	else
+		return pacs->sink_loc_value;
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
-- 
2.39.2

