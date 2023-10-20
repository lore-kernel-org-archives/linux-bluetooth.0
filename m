Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B01C004C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjJTXHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 19:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJTXHy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 19:07:54 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997AFD41
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 16:07:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a689bd4928so51092239f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697843271; x=1698448071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsOrKqa3IQ5XWO4puxqBUGOkCixUeKoEoDRJxiGt1+E=;
        b=lIjap/mU7i0WsOridBmXQ+UbiNWnzQeUpKjXhjB6Cw0f8RiCzxJyEUfEq8zv+q+oPg
         tQATwj7xe4+NjniQbFRtUIoSVkVpsBtvawzFpF4WK7C2xVxSRejP/K8sjwKCPDLjyTef
         FUaKb+jc6OdmK1Py+AYtY0e9T0UM/tsvMZu6RJnMRIhLuOYp/sy0EEpt7z23htpMBxQk
         S4I52y+JdRqOdK5QHWJXpSLLc+o+9L0WF4zTliMaXOw77sUJMptVXlVw+PbiqaLpb8Uo
         rpLsA/qSu291JTLln4777h3lK9v/Al/IquhokpYRNcG0e7vC3oFy998q2+iQO+PYdgcI
         AC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697843271; x=1698448071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsOrKqa3IQ5XWO4puxqBUGOkCixUeKoEoDRJxiGt1+E=;
        b=Fmk8iijV/DGBnZJImUX3WSo2D1YKj3MVbKkMoKnfXE+md+UF3SXISXuFD20v5gt+SA
         +9XpqBtcqGUbRzSaOHejdKNMZzj44PMT7tfx2fvsJXABOMF9hKj7NxPO3Rll9k8wIFpc
         taUg7VneGkyZazUDFKYwvIbuA7s5Capah5XI26Tuk5PsxGCX28jCG2xhqjvb1bStp9d4
         JMYoNqOTsOZF5eXfccQ70E+s5MnXuSWhF+9XAbBoYrJ4cWu6qATMEXgdtzlh9nck5Y5E
         v0ArGDV7oJmf9wKukyn7b0Uxd1XBpiFLzgvu6Gwk7hunqoR8SNKOLiMIQELpGG0B06DJ
         MJbw==
X-Gm-Message-State: AOJu0YyjzszI+EGocb3Z9pJpglLPa5lYsNOXoKkeHge8vYU0X3BVTJwB
        M1ghRl3JaJV1b4VNBtDLSsJkXcpILuLJ8r2D1zY=
X-Google-Smtp-Source: AGHT+IEfqh6Ea++ikaFzIyfo06aKXdBTEq0RK5jWJ6aiT5n0u8dvSS/C6TWS2MSAn0mGJLVL/vFpkA==
X-Received: by 2002:a05:6602:1481:b0:794:eb37:b0da with SMTP id a1-20020a056602148100b00794eb37b0damr3184543iow.2.1697843271108;
        Fri, 20 Oct 2023 16:07:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id a2-20020a5e8e02000000b0079216d6f219sm855785ion.14.2023.10.20.16.07.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:07:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] client: Add support for setting Locations, SupportedContext and Context
Date:   Fri, 20 Oct 2023 16:07:46 -0700
Message-ID: <20231020230746.3084772-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020230746.3084772-1-luiz.dentz@gmail.com>
References: <20231020230746.3084772-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper defaults for Locations, SupportedContext and Context
properties since bluetoothd no longer automatically set proper
defaults.
---
 client/player.c | 179 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 165 insertions(+), 14 deletions(-)

diff --git a/client/player.c b/client/player.c
index 603447a9df46..24513977cc7a 100644
--- a/client/player.c
+++ b/client/player.c
@@ -64,6 +64,14 @@
 #define SEC_USEC(_t)  (_t  * 1000000L)
 #define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
 
+#define EP_SRC_LOCATIONS 0x00000001
+#define EP_SNK_LOCATIONS 0x00000003
+
+#define EP_SRC_CTXT 0x000f
+#define EP_SUPPORTED_SRC_CTXT EP_SRC_CTXT
+#define EP_SNK_CTXT 0x0fff
+#define EP_SUPPORTED_SNK_CTXT EP_SNK_CTXT
+
 struct endpoint {
 	char *path;
 	char *uuid;
@@ -72,6 +80,9 @@ struct endpoint {
 	uint16_t vid;
 	struct iovec *caps;
 	struct iovec *meta;
+	uint32_t locations;
+	uint16_t supported_context;
+	uint16_t context;
 	bool auto_accept;
 	uint8_t max_transports;
 	uint8_t iso_group;
@@ -2363,6 +2374,63 @@ static gboolean endpoint_metadata_exists(const GDBusPropertyTable *property,
 	return ep->meta ? TRUE : FALSE;
 }
 
+static gboolean endpoint_get_locations(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &ep->locations);
+
+	return TRUE;
+}
+
+static gboolean endpoint_locations_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct endpoint *ep = data;
+
+	return ep->supported_context ? TRUE : FALSE;
+}
+
+static gboolean
+endpoint_get_supported_context(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&ep->supported_context);
+
+	return TRUE;
+}
+
+static gboolean
+endpoint_supported_context_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct endpoint *ep = data;
+
+	return ep->supported_context ? TRUE : FALSE;
+}
+
+static gboolean endpoint_get_context(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->context);
+
+	return TRUE;
+}
+
+static gboolean endpoint_context_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct endpoint *ep = data;
+
+	return ep->context ? TRUE : FALSE;
+}
+
 static const GDBusPropertyTable endpoint_properties[] = {
 	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
 	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
@@ -2370,6 +2438,11 @@ static const GDBusPropertyTable endpoint_properties[] = {
 	{ "Metadata", "ay", endpoint_get_metadata, NULL,
 				endpoint_metadata_exists },
 	{ "Vendor", "u", endpoint_get_vendor, NULL, endpoint_vendor_exists },
+	{ "Locations", "u", endpoint_get_locations, NULL,
+				endpoint_locations_exists },
+	{ "SupportedContext", "q", endpoint_get_supported_context, NULL,
+				endpoint_supported_context_exists },
+	{ "Context", "q", endpoint_get_context, NULL, endpoint_context_exists },
 	{ }
 };
 
@@ -2552,6 +2625,67 @@ static void endpoint_iso_group(const char *input, void *user_data)
 			endpoint_iso_stream, ep);
 }
 
+static void endpoint_context(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ep->context = value;
+
+	if (ep->broadcast)
+		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
+			endpoint_iso_group, ep);
+	else
+		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
+			endpoint_iso_group, ep);
+}
+
+static void endpoint_supported_context(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ep->supported_context = value;
+
+	bt_shell_prompt_input(ep->path, "Context (value):", endpoint_context,
+									ep);
+}
+
+static void endpoint_locations(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0') {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ep->locations = value;
+
+	bt_shell_prompt_input(ep->path, "Supported Context (value):",
+				endpoint_supported_context, ep);
+}
+
 static void endpoint_max_transports(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -2571,12 +2705,7 @@ static void endpoint_max_transports(const char *input, void *user_data)
 		ep->max_transports = value;
 	}
 
-	if (ep->broadcast)
-		bt_shell_prompt_input(ep->path, "BIG (auto/value):",
-			endpoint_iso_group, ep);
-	else
-		bt_shell_prompt_input(ep->path, "CIG (auto/value):",
-			endpoint_iso_group, ep);
+	bt_shell_prompt_input(ep->path, "Locations:", endpoint_locations, ep);
 }
 
 static void endpoint_auto_accept(const char *input, void *user_data)
@@ -3338,14 +3467,41 @@ static const struct bt_shell_menu endpoint_menu = {
 	{} },
 };
 
+static void endpoint_init_defaults(struct endpoint *ep)
+{
+	ep->preset = find_presets(ep->uuid, ep->codec, ep->vid, ep->cid);
+	ep->max_transports = UINT8_MAX;
+	ep->auto_accept = true;
+
+	if (!strcmp(ep->uuid, A2DP_SOURCE_UUID) ||
+			!strcmp(ep->uuid, A2DP_SOURCE_UUID))
+		return;
+
+	ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
+	ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
+
+	ep->broadcast = (strcmp(ep->uuid, BCAA_SERVICE_UUID) &&
+			strcmp(ep->uuid, BAA_SERVICE_UUID)) ? false : true;
+	if (ep->broadcast)
+		return;
+
+	if (!strcmp(ep->uuid, PAC_SINK_UUID)) {
+		ep->locations = EP_SNK_LOCATIONS;
+		ep->supported_context = EP_SUPPORTED_SNK_CTXT;
+		ep->context = EP_SNK_CTXT;
+	} else if (!strcmp(ep->uuid, PAC_SOURCE_UUID)) {
+		ep->locations = EP_SRC_LOCATIONS;
+		ep->supported_context = EP_SUPPORTED_SRC_CTXT;
+		ep->context = EP_SRC_CTXT;
+	}
+}
+
 static struct endpoint *endpoint_new(const struct capabilities *cap)
 {
 	struct endpoint *ep;
 
 	ep = new0(struct endpoint, 1);
 	ep->uuid = g_strdup(cap->uuid);
-	ep->broadcast = (strcmp(cap->uuid, BCAA_SERVICE_UUID) &&
-			strcmp(cap->uuid, BAA_SERVICE_UUID)) ? false : true;
 	ep->codec = cap->codec_id;
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
@@ -3368,12 +3524,7 @@ static void register_endpoints(GDBusProxy *proxy)
 			continue;
 
 		ep = endpoint_new(cap);
-		ep->preset = find_presets(ep->uuid, ep->codec, ep->vid,
-								ep->cid);
-		ep->max_transports = UINT8_MAX;
-		ep->auto_accept = true;
-		ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
-		ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
+		endpoint_init_defaults(ep);
 		endpoint_register(ep);
 	}
 }
-- 
2.41.0

