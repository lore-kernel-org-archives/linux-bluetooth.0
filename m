Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF57C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Mar 2023 20:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCBU6V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCBU6E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 15:58:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC1C3AB5
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 12:58:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i10so578393plr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 12:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoE82ediI01A5EdAcBIkRb3PkC7PP+5jkbrsFputEpo=;
        b=IcKUSA+EnuGnw3tV8llJ/OuQ/URwcOxUt4vMHMdmI0cl80uo99NckQFSSGd+X1bt7y
         EZ8iN54pqeullwGTBsl8yZFZGoeQOI3UEiWq97jfC6zKYR8O4XS9z3vs0mp2wjlRDksF
         e9OVtXzE/Xv6/lKkjuO0rxKk0CO83aR3xufmCJ8fJP4hqmPc6IaaDh1D9lN7DdKQt5TO
         bL4zBtHPAndSEJe/5+bKYccRw9e4qZi5QVUFCqLMtIvNEUPV3+EiT3BEmjinkgI9ldus
         bqV1GDkhi/xrXMogOYn3fhbFEQEUU87LTnnOAzpKuBeBN4IRdtkNxmNScO/qRU7tsLA2
         OTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoE82ediI01A5EdAcBIkRb3PkC7PP+5jkbrsFputEpo=;
        b=FtyLoF28HWQ36ddB2bQBsAoAfXRNWY6ABu2/gvuoLya5I3Md/Yhg/Fic5s2j1blqy8
         k5AwJM1CF+p7QUnXT+Jhvj1Fb9HQuLHE9hhynvqyUW/rX8c/6s+ZzG5VxTOwPtrQwC7W
         73edLCTSz2j7GAeBERNpPq/0mO4kN6rMYK/BYfSVEk/DgSKw4ul7PPy/a4tQ8sxhyGii
         nI4L5RY8k+hkb2wd481yKXhSrw2kAwJ3qle9EVL0UbKNG49KefS7MZTiBul/1B5HnC8y
         Not94lDrlI0CViEZJmc6KnlYY33sAgjll22BSELh1djNj4J4ZPmYAY8gzojLbEcrYJZG
         VwcQ==
X-Gm-Message-State: AO0yUKUW+ZRVrtrgyNQq3gbENs5QLB9jH4CJRLXv1kibcvYabFp29Wpr
        7abdTm5VqvDk4E+/SbthqqMHbAvvJ6k=
X-Google-Smtp-Source: AK7set82cQloygOGztrBfhS1k+PdTs9fdBMgtdIMFHDi8cx1ZU0SQAG3wp6PM/k9Vm3xHQCCs6RgyQ==
X-Received: by 2002:a05:6a20:7343:b0:b5:a231:107f with SMTP id v3-20020a056a20734300b000b5a231107fmr12285045pzc.12.1677790681232;
        Thu, 02 Mar 2023 12:58:01 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id i5-20020aa78d85000000b005dfc8a35793sm143463pfr.38.2023.03.02.12.57.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:58:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/bap: Make use of bt_gatt_client_idle_register
Date:   Thu,  2 Mar 2023 12:57:57 -0800
Message-Id: <20230302205758.1252736-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_gatt_client_idle_register to track when instance is ready
instead of using a dedicated queue to track requests.

Fixes: https://github.com/bluez/bluez/issues/485
---
 src/shared/bap.c | 168 +++++++++++++++++++++--------------------------
 1 file changed, 74 insertions(+), 94 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index c0f35e1c9aa4..3ebcd81f16c1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -127,17 +127,6 @@ struct bt_bap_req {
 	void *user_data;
 };
 
-typedef void (*bap_func_t)(struct bt_bap *bap, bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
-					void *user_data);
-
-struct bt_bap_pending {
-	unsigned int id;
-	struct bt_bap *bap;
-	bap_func_t func;
-	void *user_data;
-};
-
 typedef void (*bap_notify_t)(struct bt_bap *bap, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data);
@@ -156,12 +145,13 @@ struct bt_bap {
 	struct bt_gatt_client *client;
 	struct bt_att *att;
 	struct bt_bap_req *req;
-	unsigned int cp_id;
 
+	unsigned int cp_id;
 	unsigned int process_id;
 	unsigned int disconn_id;
+	unsigned int idle_id;
+
 	struct queue *reqs;
-	struct queue *pending;
 	struct queue *notify;
 	struct queue *streams;
 	struct queue *local_eps;
@@ -192,6 +182,7 @@ struct bt_bap_pac {
 };
 
 struct bt_bap_endpoint {
+	struct bt_bap *bap;
 	struct bt_bap_db *bdb;
 	struct bt_bap_stream *stream;
 	struct gatt_db_attribute *attr;
@@ -2576,7 +2567,6 @@ static void bap_free(void *data)
 	queue_destroy(bap->remote_eps, free);
 
 	queue_destroy(bap->reqs, bap_req_free);
-	queue_destroy(bap->pending, NULL);
 	queue_destroy(bap->notify, NULL);
 	queue_destroy(bap->streams, bap_stream_free);
 
@@ -2650,7 +2640,6 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bap = new0(struct bt_bap, 1);
 	bap->ldb = bdb;
 	bap->reqs = queue_new();
-	bap->pending = queue_new();
 	bap->notify = queue_new();
 	bap->pac_cbs = queue_new();
 	bap->ready_cbs = queue_new();
@@ -2735,9 +2724,6 @@ static void bap_notify_ready(struct bt_bap *bap)
 {
 	const struct queue_entry *entry;
 
-	if (!queue_isempty(bap->pending))
-		return;
-
 	if (!bt_bap_ref_safe(bap))
 		return;
 
@@ -2835,10 +2821,12 @@ static void bap_parse_pacs(struct bt_bap *bap, uint8_t type,
 	}
 }
 
-static void read_source_pac(struct bt_bap *bap, bool success, uint8_t att_ecode,
+static void read_source_pac(bool success, uint8_t att_ecode,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
+	struct bt_bap *bap = user_data;
+
 	if (!success) {
 		DBG(bap, "Unable to read Source PAC: error 0x%02x", att_ecode);
 		return;
@@ -2847,10 +2835,12 @@ static void read_source_pac(struct bt_bap *bap, bool success, uint8_t att_ecode,
 	bap_parse_pacs(bap, BT_BAP_SOURCE, bap->rdb->sources, value, length);
 }
 
-static void read_sink_pac(struct bt_bap *bap, bool success, uint8_t att_ecode,
+static void read_sink_pac(bool success, uint8_t att_ecode,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
+	struct bt_bap *bap = user_data;
+
 	if (!success) {
 		DBG(bap, "Unable to read Sink PAC: error 0x%02x", att_ecode);
 		return;
@@ -2859,54 +2849,11 @@ static void read_sink_pac(struct bt_bap *bap, bool success, uint8_t att_ecode,
 	bap_parse_pacs(bap, BT_BAP_SINK, bap->rdb->sinks, value, length);
 }
 
-static void bap_pending_destroy(void *data)
-{
-	struct bt_bap_pending *pending = data;
-	struct bt_bap *bap = pending->bap;
-
-	if (queue_remove_if(bap->pending, NULL, pending))
-		free(pending);
-
-	bap_notify_ready(bap);
-}
-
-static void bap_pending_complete(bool success, uint8_t att_ecode,
-				const uint8_t *value, uint16_t length,
-				void *user_data)
-{
-	struct bt_bap_pending *pending = user_data;
-
-	if (pending->func)
-		pending->func(pending->bap, success, att_ecode, value, length,
-						pending->user_data);
-}
-
-static void bap_read_value(struct bt_bap *bap, uint16_t value_handle,
-				bap_func_t func, void *user_data)
-{
-	struct bt_bap_pending *pending;
-
-	pending = new0(struct bt_bap_pending, 1);
-	pending->bap = bap;
-	pending->func = func;
-	pending->user_data = user_data;
-
-	pending->id = bt_gatt_client_read_value(bap->client, value_handle,
-						bap_pending_complete, pending,
-						bap_pending_destroy);
-	if (!pending->id) {
-		DBG(bap, "Unable to send Read request");
-		free(pending);
-		return;
-	}
-
-	queue_push_tail(bap->pending, pending);
-}
-
-static void read_source_pac_loc(struct bt_bap *bap, bool success,
-				uint8_t att_ecode, const uint8_t *value,
-				uint16_t length, void *user_data)
+static void read_source_pac_loc(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
 {
+	struct bt_bap *bap = user_data;
 	struct bt_pacs *pacs = bap_get_pacs(bap);
 
 	if (!success) {
@@ -2925,14 +2872,17 @@ static void read_source_pac_loc(struct bt_bap *bap, bool success,
 		if (gatt_db_attribute_get_char_data(pacs->source,
 						NULL, &value_handle,
 						NULL, NULL, NULL))
-			bap_read_value(bap, value_handle, read_source_pac, bap);
+			bt_gatt_client_read_value(bap->client, value_handle,
+							read_source_pac, bap,
+							NULL);
 	}
 }
 
-static void read_sink_pac_loc(struct bt_bap *bap, bool success,
-				uint8_t att_ecode, const uint8_t *value,
-				uint16_t length, void *user_data)
+static void read_sink_pac_loc(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
 {
+	struct bt_bap *bap = user_data;
 	struct bt_pacs *pacs = bap_get_pacs(bap);
 
 	if (!success) {
@@ -2951,14 +2901,17 @@ static void read_sink_pac_loc(struct bt_bap *bap, bool success,
 		if (gatt_db_attribute_get_char_data(pacs->sink,
 						NULL, &value_handle,
 						NULL, NULL, NULL))
-			bap_read_value(bap, value_handle, read_sink_pac, bap);
+			bt_gatt_client_read_value(bap->client, value_handle,
+							read_sink_pac, bap,
+							NULL);
 	}
 }
 
-static void read_pac_context(struct bt_bap *bap, bool success,
-				uint8_t att_ecode, const uint8_t *value,
-				uint16_t length, void *user_data)
+static void read_pac_context(bool success, uint8_t att_ecode,
+				const uint8_t *value, uint16_t length,
+				void *user_data)
 {
+	struct bt_bap *bap = user_data;
 	struct bt_pacs *pacs = bap_get_pacs(bap);
 
 	if (!success) {
@@ -2970,10 +2923,11 @@ static void read_pac_context(struct bt_bap *bap, bool success,
 							NULL, NULL);
 }
 
-static void read_pac_supported_context(struct bt_bap *bap, bool success,
-					uint8_t att_ecode, const uint8_t *value,
-					uint16_t length, void *user_data)
+static void read_pac_supported_context(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
 {
+	struct bt_bap *bap = user_data;
 	struct bt_pacs *pacs = bap_get_pacs(bap);
 
 	if (!success) {
@@ -3015,7 +2969,8 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		if (!pacs->sink)
 			pacs->sink = attr;
 
-		bap_read_value(bap, value_handle, read_sink_pac, bap);
+		bt_gatt_client_read_value(bap->client, value_handle,
+						read_sink_pac, bap, NULL);
 	}
 
 	if (!bt_uuid_cmp(&uuid, &uuid_source)) {
@@ -3028,7 +2983,8 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 		if (!pacs->source)
 			pacs->source = attr;
 
-		bap_read_value(bap, value_handle, read_source_pac, NULL);
+		bt_gatt_client_read_value(bap->client, value_handle,
+						read_source_pac, bap, NULL);
 	}
 
 	if (!bt_uuid_cmp(&uuid, &uuid_sink_loc)) {
@@ -3040,7 +2996,8 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 			return;
 
 		pacs->sink_loc = attr;
-		bap_read_value(bap, value_handle, read_sink_pac_loc, NULL);
+		bt_gatt_client_read_value(bap->client, value_handle,
+						read_sink_pac_loc, bap, NULL);
 	}
 
 	if (!bt_uuid_cmp(&uuid, &uuid_source_loc)) {
@@ -3052,7 +3009,8 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 			return;
 
 		pacs->source_loc = attr;
-		bap_read_value(bap, value_handle, read_source_pac_loc, NULL);
+		bt_gatt_client_read_value(bap->client, value_handle,
+						read_source_pac_loc, bap, NULL);
 	}
 
 	if (!bt_uuid_cmp(&uuid, &uuid_context)) {
@@ -3063,7 +3021,8 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 			return;
 
 		pacs->context = attr;
-		bap_read_value(bap, value_handle, read_pac_context, NULL);
+		bt_gatt_client_read_value(bap->client, value_handle,
+						read_pac_context, bap, NULL);
 	}
 
 	if (!bt_uuid_cmp(&uuid, &uuid_supported_context)) {
@@ -3075,8 +3034,9 @@ static void foreach_pacs_char(struct gatt_db_attribute *attr, void *user_data)
 			return;
 
 		pacs->supported_context = attr;
-		bap_read_value(bap, value_handle, read_pac_supported_context,
-									NULL);
+		bt_gatt_client_read_value(bap->client, value_handle,
+						read_pac_supported_context,
+						bap, NULL);
 	}
 }
 
@@ -3324,14 +3284,17 @@ static void bap_ep_set_status(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	bap_stream_state_changed(ep->stream);
 }
 
-static void read_ase_status(struct bt_bap *bap, bool success, uint8_t att_ecode,
+static void read_ase_status(bool success, uint8_t att_ecode,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
 {
 	struct bt_bap_endpoint *ep = user_data;
+	struct bt_bap *bap = ep->bap;
 
-	if (!success)
+	if (!success) {
+		DBG(bap, "ASE read status failed: 0x%04x", att_ecode);
 		return;
+	}
 
 	bap_ep_set_status(bap, ep, value, length);
 }
@@ -3409,7 +3372,10 @@ static void bap_endpoint_attach(struct bt_bap *bap, struct bt_bap_endpoint *ep)
 
 	DBG(bap, "ASE handle 0x%04x", value_handle);
 
-	bap_read_value(bap, value_handle, read_ase_status, ep);
+	ep->bap = bap;
+
+	bt_gatt_client_read_value(bap->client, value_handle, read_ase_status,
+					ep, NULL);
 
 	ep->state_id = bap_register_notify(bap, value_handle,
 						bap_endpoint_notify, ep);
@@ -3734,6 +3700,15 @@ static void bap_attach_att(struct bt_bap *bap, struct bt_att *att)
 							bap, NULL);
 }
 
+static void bap_idle(void *data)
+{
+	struct bt_bap *bap = data;
+
+	bap->idle_id = 0;
+
+	bap_notify_ready(bap);
+}
+
 bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
@@ -3769,6 +3744,9 @@ clone:
 
 	bap_attach_att(bap, bt_gatt_client_get_att(client));
 
+	bap->idle_id = bt_gatt_client_idle_register(bap->client, bap_idle,
+								bap, NULL);
+
 	if (bap->rdb->pacs) {
 		uint16_t value_handle;
 		struct bt_pacs *pacs = bap->rdb->pacs;
@@ -3778,8 +3756,10 @@ clone:
 			if (gatt_db_attribute_get_char_data(pacs->sink,
 							NULL, &value_handle,
 							NULL, NULL, NULL)) {
-				bap_read_value(bap, value_handle,
-							read_sink_pac, bap);
+				bt_gatt_client_read_value(bap->client,
+							value_handle,
+							read_sink_pac,
+							bap, NULL);
 			}
 		}
 
@@ -3788,8 +3768,10 @@ clone:
 			if (gatt_db_attribute_get_char_data(pacs->source,
 							NULL, &value_handle,
 							NULL, NULL, NULL)) {
-				bap_read_value(bap, value_handle,
-							read_source_pac, bap);
+				bt_gatt_client_read_value(bap->client,
+							value_handle,
+							read_source_pac,
+							bap, NULL);
 			}
 		}
 
@@ -3797,8 +3779,6 @@ clone:
 
 		bap_cp_attach(bap);
 
-		bap_notify_ready(bap);
-
 		return true;
 	}
 
-- 
2.39.2

