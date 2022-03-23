Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18999C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 00:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240869AbiCWAI3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiCWAI3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 20:08:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581215DE5A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:07:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mz9-20020a17090b378900b001c657559290so4820613pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YgL1QjGsntEM/sKI8J2WatVdiyjYA18RaC7riKp34Dw=;
        b=inHQgya4SkmzVTHegivMz4jpirNwlj3kIlYeIvbWj21sADkCbT0PZfkVJMVohzn2Cr
         0oVI1tpUaxqaEzDNZcFEn+TXacvR6wkfVMRhxQrPi8jjLGWgkY5g2blI6IMPpqBbMpQT
         +ZMFsLQAU8tgfNdsSFKnIiXekhiB8WbVTUROK0yMmhvNMk+WXv6KrG3Lg3pIJYc9ShhC
         zluLRcBR1npFLFVjgJV2ou1s5FgwLSt3eqfqMaZbTW0oo9c9P4fq9xovfLmWTftMXLVO
         cB7vDa79GOjkPuMc8caw9OjE+Y2gikEjOqeGuBvZGQyctM+jpcxh/F4lLL5A+BTTmGEw
         zEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YgL1QjGsntEM/sKI8J2WatVdiyjYA18RaC7riKp34Dw=;
        b=S5H7bJ2+F4JwkfSNPDIftOF9znDlf7ANxADlNkFeuLAsOOjb0ftjDbJHB1K0dbTlYR
         p9INoOVP51+q6j8MNsfcXGYQOg/PX+op62JQ+jgLQX23lX1c+WJHvA481I3kD3Dy4gU7
         hYZiL23yjG5VVhenfekWxKEDjiWwg+yitjZndC2VHgtzQQ7bukxHB3XUad1XIgKVOXqs
         8v5rqdUVzGhSb+VeUz6SEyiGxqzfZJaxpQZ/LnKic2GNZTyhs3jLtttgsVHOaFsXaoeB
         hDt8j17nfJgJaHoOsZwadZ2shQ9faOqjAPt4BuoCT3NceNcjmukKBPOSFYXONvdMbNnZ
         AudQ==
X-Gm-Message-State: AOAM532aWcKORU7EWhAt84/sxNDUvwwBTop9eiMh72YAz3WajYcV0Ngt
        h3ipJ4xh/KE+97CdXWHutmBIz2aiEdE=
X-Google-Smtp-Source: ABdhPJwqj34vm1quNwnBAqGk6rnSK5ZwICuKeMlKUJmEQqe9mzjj3GqU3ppBTBJoC+mY+t/jJevogA==
X-Received: by 2002:a17:903:1206:b0:151:7d67:2924 with SMTP id l6-20020a170903120600b001517d672924mr20592820plh.45.1647994019253;
        Tue, 22 Mar 2022 17:06:59 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm10098423pfb.196.2022.03.22.17.06.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 17:06:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/9] gatt-client: Add DBG macro
Date:   Tue, 22 Mar 2022 17:06:51 -0700
Message-Id: <20220323000654.3157833-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323000654.3157833-1-luiz.dentz@gmail.com>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds gatt_log wrapper for util_debug and DBG macro so file and
function names are printed which is more consistent with other parts of
the daemon code.
---
 src/shared/gatt-client.c | 160 +++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 90 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e24c9603c..ba9228ddf 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -37,6 +37,8 @@
 
 #define GATT_SVC_UUID	0x1801
 #define SVC_CHNGD_UUID	0x2a05
+#define DBG(_client, _format, arg...) \
+	gatt_log(_client, "%s:%s() " _format, __FILE__, __func__, ## arg)
 
 struct ready_cb {
 	bt_gatt_client_callback_t callback;
@@ -376,6 +378,18 @@ static void discovery_op_free(struct discovery_op *op)
 
 static bool read_db_hash(struct discovery_op *op);
 
+static void gatt_log(struct bt_gatt_client *client, const char *format, ...)
+{
+	va_list ap;
+
+	if (!client || !format || !client->debug_callback)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(client->debug_callback, client->debug_data, format, ap);
+	va_end(ap);
+}
+
 static void discovery_op_complete(struct discovery_op *op, bool success,
 								uint8_t err)
 {
@@ -406,9 +420,8 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
 		gatt_db_attribute_get_service_data(attr, &start, &end,
 							NULL, NULL);
 
-		util_debug(op->client->debug_callback, op->client->debug_data,
-				"service disappeared: start 0x%04x end 0x%04x",
-				start, end);
+		DBG(op->client, "service disappeared: start 0x%04x end 0x%04x",
+			start, end);
 
 		gatt_db_remove_service(op->client->db, attr);
 	}
@@ -542,9 +555,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 	if (includes_count == 0)
 		goto failed;
 
-	util_debug(client->debug_callback, client->debug_data,
-						"Included services found: %u",
-						includes_count);
+	DBG(client, "Included services found: %u", includes_count);
 
 	for (i = 0; i < includes_count; i++) {
 		if (!bt_gatt_iter_next_included_service(&iter, &handle, &start,
@@ -555,13 +566,12 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 
 		/* Log debug message */
 		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-		util_debug(client->debug_callback, client->debug_data,
-				"handle: 0x%04x, start: 0x%04x, end: 0x%04x,"
+		DBG(client, "handle: 0x%04x, start: 0x%04x, end: 0x%04x,"
 				"uuid: %s", handle, start, end, uuid_str);
 
 		attr = gatt_db_get_attribute(client->db, start);
 		if (!attr) {
-			util_debug(client->debug_callback, client->debug_data,
+			DBG(client,
 				"Unable to find attribute at 0x%04x: skipping",
 				start);
 			continue;
@@ -569,7 +579,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 
 		attr = gatt_db_insert_included(client->db, handle, attr);
 		if (!attr) {
-			util_debug(client->debug_callback, client->debug_data,
+			DBG(client,
 				"Unable to add include attribute at 0x%04x",
 				handle);
 			goto failed;
@@ -582,7 +592,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 		 * attribute.
 		 */
 		if (gatt_db_attribute_get_handle(attr) != handle) {
-			util_debug(client->debug_callback, client->debug_data,
+			DBG(client,
 				"Invalid attribute 0x%04x expect it at 0x%04x",
 				gatt_db_attribute_get_handle(attr), handle);
 			goto failed;
@@ -604,8 +614,8 @@ next:
 	if (client->discovery_req)
 		return;
 
-	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start characteristic discovery");
+	DBG(client, "Failed to start characteristic discovery");
+
 	discovery_op_unref(op);
 failed:
 	discovery_op_complete(op, false, att_ecode);
@@ -656,7 +666,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 							NULL, NULL, NULL);
 
 		if (!attr) {
-			util_debug(client->debug_callback, client->debug_data,
+			DBG(client,
 				"Failed to insert characteristic at 0x%04x",
 				chrc_data->value_handle);
 
@@ -729,8 +739,8 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 			goto done;
 		}
 
-		util_debug(client->debug_callback, client->debug_data,
-					"Failed to start descriptor discovery");
+		DBG(client, "Failed to start descriptor discovery");
+
 		discovery_op_unref(op);
 
 		goto failed;
@@ -750,8 +760,7 @@ static void ext_prop_write_cb(struct gatt_db_attribute *attrib,
 {
 	struct bt_gatt_client *client = user_data;
 
-	util_debug(client->debug_callback, client->debug_data,
-						"Value set status: %d", err);
+	DBG(client, "Value set status: %d", err);
 }
 
 static void ext_prop_read_cb(bool success, uint8_t att_ecode,
@@ -790,8 +799,7 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	if (!success)
 		goto done;
 
-	util_debug(client->debug_callback, client->debug_data,
-				"Ext. prop value: 0x%04x", (uint16_t)value[0]);
+	DBG(client, "Ext. prop value: 0x%04x", (uint16_t)value[0]);
 
 	desc_attr = queue_pop_head(op->ext_prop_desc);
 	if (!desc_attr)
@@ -857,8 +865,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	if (desc_count == 0)
 		goto failed;
 
-	util_debug(client->debug_callback, client->debug_data,
-					"Descriptors found: %u", desc_count);
+	DBG(client, "Descriptors found: %u", desc_count);
 
 	bt_uuid16_create(&ext_prop_uuid, GATT_CHARAC_EXT_PROPER_UUID);
 
@@ -867,9 +874,8 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 
 		/* Log debug message */
 		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-		util_debug(client->debug_callback, client->debug_data,
-						"handle: 0x%04x, uuid: %s",
-						handle, uuid_str);
+
+		DBG(client, "handle: 0x%04x, uuid: %s", handle, uuid_str);
 
 		attr = gatt_db_insert_descriptor(client->db, handle,
 							&uuid, 0, NULL, NULL,
@@ -880,8 +886,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 					gatt_db_attribute_get_type(attr)))
 				continue;
 
-			util_debug(client->debug_callback, client->debug_data,
-				"Failed to insert descriptor at 0x%04x",
+			DBG(client, "Failed to insert descriptor at 0x%04x",
 				handle);
 			goto failed;
 		}
@@ -947,8 +952,8 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 		goto failed;
 
 	chrc_count = bt_gatt_result_characteristic_count(result);
-	util_debug(client->debug_callback, client->debug_data,
-				"Characteristics found: %u", chrc_count);
+
+	DBG(client, "Characteristics found: %u", chrc_count);
 
 	if (chrc_count == 0)
 		goto failed;
@@ -959,8 +964,7 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 
 		/* Log debug message */
 		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-		util_debug(client->debug_callback, client->debug_data,
-				"start: 0x%04x, end: 0x%04x, value: 0x%04x, "
+		DBG(client, "start: 0x%04x, end: 0x%04x, value: 0x%04x, "
 				"props: 0x%02x, uuid: %s",
 				start, end, value, properties, uuid_str);
 
@@ -997,8 +1001,7 @@ next:
 		if (client->discovery_req)
 			return;
 
-		util_debug(client->debug_callback, client->debug_data,
-				"Failed to start included services discovery");
+		DBG(client, "Failed to start included services discovery");
 
 		discovery_op_unref(op);
 
@@ -1110,8 +1113,7 @@ static bool discovery_parse_services(struct discovery_op *op, bool primary,
 
 		/* Log debug message */
 		bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
-		util_debug(client->debug_callback, client->debug_data,
-				"start: 0x%04x, end: 0x%04x, uuid: %s",
+		DBG(client, "start: 0x%04x, end: 0x%04x, uuid: %s",
 				start, end, uuid_str);
 
 		/* Store the service */
@@ -1122,9 +1124,7 @@ static bool discovery_parse_services(struct discovery_op *op, bool primary,
 			attr = gatt_db_insert_service(client->db, start, &uuid,
 							false, end - start + 1);
 			if (!attr) {
-				util_debug(client->debug_callback,
-						client->debug_data,
-						"Failed to store service");
+				DBG(client, "Failed to store service");
 				return false;
 			}
 			/* Database has changed adjust last handle */
@@ -1157,8 +1157,7 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 			att_ecode = 0;
 			goto next;
 		default:
-			util_debug(client->debug_callback, client->debug_data,
-					"Secondary service discovery failed."
+			DBG(client, "Secondary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
 			goto done;
 		}
@@ -1169,8 +1168,7 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 		goto done;
 	}
 
-	util_debug(client->debug_callback, client->debug_data,
-					"Secondary services found: %u",
+	DBG(client, "Secondary services found: %u",
 					bt_gatt_result_service_count(result));
 
 	if (!discovery_parse_services(op, false, &iter)) {
@@ -1199,8 +1197,8 @@ next:
 	if (client->discovery_req)
 		return;
 
-	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start included services discovery");
+	DBG(client, "Failed to start included services discovery");
+
 	discovery_op_unref(op);
 	success = false;
 
@@ -1226,8 +1224,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 			att_ecode = 0;
 			goto secondary;
 		default:
-			util_debug(client->debug_callback, client->debug_data,
-					"Primary service discovery failed."
+			DBG(client, "Primary service discovery failed."
 					" ATT ECODE: 0x%02x", att_ecode);
 			goto done;
 		}
@@ -1238,8 +1235,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		goto done;
 	}
 
-	util_debug(client->debug_callback, client->debug_data,
-					"Primary services found: %u",
+	DBG(client, "Primary services found: %u",
 					bt_gatt_result_service_count(result));
 
 	if (!discovery_parse_services(op, true, &iter)) {
@@ -1266,8 +1262,8 @@ secondary:
 	if (client->discovery_req)
 		return;
 
-	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start secondary service discovery");
+	DBG(client, "Failed to start secondary service discovery");
+
 	discovery_op_unref(op);
 	success = false;
 
@@ -1331,8 +1327,7 @@ static void discover_all(struct discovery_op *op)
 	if (client->discovery_req)
 		return;
 
-	util_debug(client->debug_callback, client->debug_data,
-			"Failed to initiate primary service discovery");
+	DBG(client, "Failed to initiate primary service discovery");
 
 	client->in_init = false;
 	notify_client_ready(client, false, BT_ATT_ERROR_UNLIKELY);
@@ -1345,8 +1340,7 @@ static void db_hash_write_value_cb(struct gatt_db_attribute *attrib,
 {
 	struct bt_gatt_client *client = user_data;
 
-	util_debug(client->debug_callback, client->debug_data,
-						"Value set status: %d", err);
+	DBG(client, "Value set status: %d", err);
 }
 
 static void db_hash_read_value_cb(struct gatt_db_attribute *attrib,
@@ -1377,9 +1371,8 @@ static void db_hash_read_cb(bool success, uint8_t att_ecode,
 	bt_gatt_iter_init(&iter, result);
 	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
 
-	util_debug(client->debug_callback, client->debug_data,
-				"DB Hash found: handle 0x%04x length 0x%04x",
-				handle, len);
+	DBG(client, "DB Hash found: handle 0x%04x length 0x%04x",
+							handle, len);
 
 	if (len != 16)
 		goto discover;
@@ -1390,15 +1383,14 @@ static void db_hash_read_cb(bool success, uint8_t att_ecode,
 
 	/* Check if the has has changed since last time */
 	if (hash && !memcmp(hash, value, len)) {
-		util_debug(client->debug_callback, client->debug_data,
-				"DB Hash match: skipping discovery");
+		DBG(client, "DB Hash match: skipping discovery");
 		queue_remove_all(op->pending_svcs, NULL, NULL, NULL);
 		discovery_op_complete(op, true, 0);
 		return;
 	}
 
-	util_debug(client->debug_callback, client->debug_data,
-						"DB Hash value:");
+	DBG(client, "DB Hash value:");
+
 	util_hexdump(' ', value, len, client->debug_callback,
 						client->debug_data);
 
@@ -1469,8 +1461,7 @@ static void db_server_feat_read(bool success, uint8_t att_ecode,
 	bt_gatt_iter_init(&iter, result);
 	bt_gatt_iter_next_read_by_type(&iter, &handle, &len, &value);
 
-	util_debug(client->debug_callback, client->debug_data,
-				"Server Features found: handle 0x%04x "
+	DBG(client, "Server Features found: handle 0x%04x "
 				"length 0x%04x value 0x%02x", handle, len,
 				value[0]);
 
@@ -1524,8 +1515,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	client->mtu_req_id = 0;
 
 	if (!success) {
-		util_debug(client->debug_callback, client->debug_data,
-				"MTU Exchange failed. ATT ECODE: 0x%02x",
+		DBG(client, "MTU Exchange failed. ATT ECODE: 0x%02x",
 				att_ecode);
 
 		/*
@@ -1543,8 +1533,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 		return;
 	}
 
-	util_debug(client->debug_callback, client->debug_data,
-					"MTU exchange complete, with MTU: %u",
+	DBG(client, "MTU exchange complete, with MTU: %u",
 					bt_att_get_mtu(client->att));
 
 discover:
@@ -1749,7 +1738,7 @@ static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
 	struct bt_gatt_client *client = user_data;
 
 	if (att_ecode) {
-		util_debug(client->debug_callback, client->debug_data,
+		DBG(client,
 			"Failed to register handler for \"Service Changed\"");
 		success = false;
 		client->svc_chngd_ind_id = 0;
@@ -1758,8 +1747,7 @@ static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
 
 	client->svc_chngd_registered = true;
 	success = true;
-	util_debug(client->debug_callback, client->debug_data,
-			"Registered handler for \"Service Changed\": %u",
+	DBG(client, "Registered handler for \"Service Changed\": %u",
 			client->svc_chngd_ind_id);
 
 done:
@@ -1807,7 +1795,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	client->in_svc_chngd = false;
 
 	if (!success && att_ecode != BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
-		util_debug(client->debug_callback, client->debug_data,
+		DBG(client,
 			"Failed to discover services within changed range - "
 			"error: 0x%02x", att_ecode);
 
@@ -1841,7 +1829,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	if (register_service_changed(client))
 		return;
 
-	util_debug(client->debug_callback, client->debug_data,
+	DBG(client,
 		"Failed to re-register handler for \"Service Changed\"");
 }
 
@@ -1877,9 +1865,8 @@ static void process_service_changed(struct bt_gatt_client *client,
 	discovery_op_free(op);
 
 fail:
-	util_debug(client->debug_callback, client->debug_data,
-					"Failed to initiate service discovery"
-					" after Service Changed");
+	DBG(client,
+		"Failed to initiate service discovery after Service Changed");
 }
 
 static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
@@ -1896,13 +1883,12 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	end = get_le16(value + 2);
 
 	if (start > end) {
-		util_debug(client->debug_callback, client->debug_data,
+		DBG(client,
 			"Service Changed received with invalid handles");
 		return;
 	}
 
-	util_debug(client->debug_callback, client->debug_data,
-			"Service Changed received - start: 0x%04x end: 0x%04x",
+	DBG(client, "Service Changed received - start: 0x%04x end: 0x%04x",
 			start, end);
 
 	if (!client->in_svc_chngd) {
@@ -1923,8 +1909,7 @@ static void server_feat_write_value(struct gatt_db_attribute *attrib,
 {
 	struct bt_gatt_client *client = user_data;
 
-	util_debug(client->debug_callback, client->debug_data,
-			"Server Features Value set status: %d", err);
+	DBG(client, "Server Features Value set status: %d", err);
 }
 
 static void write_server_features(struct bt_gatt_client *client, uint8_t feat)
@@ -1943,8 +1928,7 @@ static void write_server_features(struct bt_gatt_client *client, uint8_t feat)
 	if (!gatt_db_attribute_write(attr, 0, &feat, sizeof(feat),
 					0, NULL, server_feat_write_value,
 					client))
-		util_debug(client->debug_callback, client->debug_data,
-					"Unable to store Server Features");
+		DBG(client, "Unable to store Server Features");
 }
 
 static void write_client_features(struct bt_gatt_client *client)
@@ -1981,8 +1965,7 @@ static void write_client_features(struct bt_gatt_client *client)
 
 	client->features |= BT_GATT_CHRC_CLI_FEAT_NFY_MULTI;
 
-	util_debug(client->debug_callback, client->debug_data,
-			"Writing Client Features 0x%02x", client->features);
+	DBG(client, "Writing Client Features 0x%02x", client->features);
 
 	bt_gatt_client_write_value(client, handle, &client->features,
 				sizeof(client->features), NULL, NULL, NULL);
@@ -2006,13 +1989,11 @@ static void init_complete(struct discovery_op *op, bool success,
 	if (register_service_changed(client))
 		goto done;
 
-	util_debug(client->debug_callback, client->debug_data,
-			"Failed to register handler for \"Service Changed\"");
+	DBG(client, "Failed to register handler for \"Service Changed\"");
 	success = false;
 
 fail:
-	util_debug(client->debug_callback, client->debug_data,
-			"Failed to initialize gatt-client");
+	DBG(client, "Failed to initialize gatt-client");
 
 	op->success = false;
 
@@ -3501,8 +3482,7 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 	 * prepare writes or this is brand new reliable session (id == 0)
 	 */
 	if (id != client->reliable_write_session_id) {
-		util_debug(client->debug_callback, client->debug_data,
-			"There is other reliable write session ongoing %u",
+		DBG(client, "There is other reliable write session ongoing %u",
 			client->reliable_write_session_id);
 
 		return 0;
-- 
2.35.1

