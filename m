Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E846C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 23:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjAWX5S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjAWX5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 18:57:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB343251D
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a18so550203plm.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZvXSJ4zmXkv5lVqObYR6fX8TtPkDBm6+BtCHY7i/Fk=;
        b=T87o6hCYXF2AGp9ZEFZKLwwhuv9HzvvTElaWvtV58EG6qwph3LkFeIyZmFYF/XS8UK
         Z76QRS/POmIjXKz/h1mrF+rd/yWGVRhIIQlXhtdrYBoRuOYbUP1H6v/0Uy/sNW6JjE7/
         94ouPzO/dpvdmZJ7Ok3jQSbZQfaShcsrtlR+LcQDxvj+tDkAzpyG9qphHI5sNjfiLF/d
         TUPTEf2H6oGjmPOzb/Q2PkdkVB4NLWAsaDSneMDwNHGamK/yZFDvvmHI58neHEvlU5hs
         sAURTCSw39BVTLrRqcVk5wy9VBX4GklSZG/oNEDLOMwXMEBxSOAw+qDWBlhfFGhj9hJp
         koHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZvXSJ4zmXkv5lVqObYR6fX8TtPkDBm6+BtCHY7i/Fk=;
        b=eioRpz6AfKoA7UYJXb4T+sqCTa+d8r+FtOcZSGODsq2PKRY+EH4DNogpPRSLyUUHNY
         RtpXOkkBFYy7x9chyv4Ia4aHphar8PL66u4+3uqCknu1EBncTvsCKMMxN1FLy75hSSsc
         0V29elE58JEdAh7u2ZlGfgDk0iD4eEh8tTTBfjtoSPfEOb97c6htXSsRXXySV4epI/EF
         u2P7uIPoDNZVr+BH2uzc7OLxyqEY5fYnFyXWNUQ/3y6r6OSyiwRC9csIXkkdk/MgV6dV
         /I+OYVYCWzByaWiQZPsyh3498PiFyyj21A+s5GuwVPGKv7CGx4vH2xDzwLaCORFdDkH7
         QBcQ==
X-Gm-Message-State: AFqh2kpBsSMdb5J+I49wCTCUv0RU6BoN32AJdvAOqgDU3DplQ3/BRX1x
        TQG165Kj5nKpBDEFFk8LRRrhcyjLFEs=
X-Google-Smtp-Source: AMrXdXsq5kQYINAMZgzxVJXf01WSpHoRtUUG0LsjmzSBApK5Pzj6nNJXE4kQhNSxFB1Taa2lq+WAbg==
X-Received: by 2002:a17:902:eb86:b0:194:7696:c024 with SMTP id q6-20020a170902eb8600b001947696c024mr27362556plg.5.1674518216772;
        Mon, 23 Jan 2023 15:56:56 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902d70e00b001960706141fsm268130ply.149.2023.01.23.15.56.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:56:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] media: Rework support of Vendor to use uint32_t as type
Date:   Mon, 23 Jan 2023 15:56:49 -0800
Message-Id: <20230123235649.3231488-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230123235649.3231488-1-luiz.dentz@gmail.com>
References: <20230123235649.3231488-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reworks the handlings of Vendor property to use a single uint32_t.
---
 client/player.c        | 24 +++++++++++++++++-------
 profiles/audio/media.c | 37 +++++++++++++++++--------------------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/client/player.c b/client/player.c
index bab563eec592..65cac3b50376 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1868,13 +1868,18 @@ static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+struct vendor {
+	uint16_t cid;
+	uint16_t vid;
+} __packed;
+
 static gboolean endpoint_get_vendor(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct endpoint *ep = data;
+	struct vendor vendor = { ep->cid, ep->vid };
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->cid);
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->vid);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &vendor);
 
 	return TRUE;
 }
@@ -1891,7 +1896,7 @@ static const GDBusPropertyTable endpoint_properties[] = {
 	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
 	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
 	{ "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
-	{ "Vendor", "qq", endpoint_get_vendor, NULL, endpoint_vendor_exists },
+	{ "Vendor", "u", endpoint_get_vendor, NULL, endpoint_vendor_exists },
 	{ }
 };
 
@@ -1909,7 +1914,14 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 
 	g_dbus_dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &ep->codec);
 
-	if (ep->caps->iov_len) {
+	if (ep->cid && ep->vid) {
+		struct vendor vendor = { ep->cid, ep->vid };
+
+		g_dbus_dict_append_entry(&dict, "Vendor", DBUS_TYPE_UINT32,
+						 &vendor);
+	}
+
+	if (ep->caps) {
 		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
 					DBUS_TYPE_BYTE, &ep->caps->iov_base,
 					ep->caps->iov_len);
@@ -2113,9 +2125,7 @@ static void cmd_register_endpoint(int argc, char *argv[])
 					g_list_length(local_endpoints));
 	local_endpoints = g_list_append(local_endpoints, ep);
 
-	if (g_strstr_len(argv[2], -1, ":")) {
-		bt_shell_printf("Found split\r\n");
-
+	if (strrchr(argv[2], ':')) {
 		list = g_strsplit(argv[2], ":", 2);
 
 		ep->codec = 0xff;
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 76a378e69401..889cd59b00f9 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1379,6 +1379,11 @@ media_endpoint_create(struct media_adapter *adapter,
 	return endpoint;
 }
 
+struct vendor {
+	uint16_t cid;
+	uint16_t vid;
+} __packed;
+
 static int parse_properties(DBusMessageIter *props, const char **uuid,
 				gboolean *delay_reporting, uint8_t *codec,
 				uint16_t *cid, uint16_t *vid,
@@ -1388,6 +1393,7 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 {
 	gboolean has_uuid = FALSE;
 	gboolean has_codec = FALSE;
+	struct vendor vendor;
 
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		const char *key;
@@ -1412,14 +1418,11 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 			dbus_message_iter_get_basic(&value, codec);
 			has_codec = TRUE;
 		} else if (strcasecmp(key, "Vendor") == 0) {
-			if (var != DBUS_TYPE_UINT16)
+			if (var != DBUS_TYPE_UINT32)
 				return -EINVAL;
-			dbus_message_iter_get_basic(&value, cid);
-			dbus_message_iter_next(&value);
-			var = dbus_message_iter_get_arg_type(&value);
-			if (var != DBUS_TYPE_UINT16)
-				return -EINVAL;
-			dbus_message_iter_get_basic(&value, vid);
+			dbus_message_iter_get_basic(&value, &vendor);
+			*cid = vendor.cid;
+			*vid = vendor.vid;
 		} else if (strcasecmp(key, "DelayReporting") == 0) {
 			if (var != DBUS_TYPE_BOOLEAN)
 				return -EINVAL;
@@ -2543,8 +2546,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	const char *uuid;
 	gboolean delay_reporting = FALSE;
 	uint8_t codec;
-	uint16_t cid = 0;
-	uint16_t vid = 0;
+	struct vendor vendor;
 	struct bt_bap_pac_qos qos;
 	uint8_t *capabilities = NULL;
 	int size = 0;
@@ -2577,16 +2579,10 @@ static void app_register_endpoint(void *data, void *user_data)
 	dbus_message_iter_get_basic(&iter, &codec);
 
 	if (g_dbus_proxy_get_property(proxy, "Vendor", &iter)) {
-		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
 			goto fail;
 
-		dbus_message_iter_get_basic(&iter, &cid);
-
-		dbus_message_iter_next(&iter);
-		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT16)
-			goto fail;
-
-		dbus_message_iter_get_basic(&iter, &vid);
+		dbus_message_iter_get_basic(&iter, &vendor);
 	}
 
 	/* DelayReporting and Capabilities are considered optional */
@@ -2666,9 +2662,10 @@ static void app_register_endpoint(void *data, void *user_data)
 	}
 
 	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
-						delay_reporting, codec, cid,
-						vid, &qos, capabilities,
-						size, metadata, metadata_size,
+						delay_reporting, codec,
+						vendor.cid, vendor.vid, &qos,
+						capabilities, size,
+						metadata, metadata_size,
 						&app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
-- 
2.37.3

