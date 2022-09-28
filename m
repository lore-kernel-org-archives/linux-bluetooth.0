Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35FAC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 21:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiI1V0z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiI1V0x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 17:26:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747267453
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 14:26:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so13312471pgi.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=K/koYjTIKng4CMvyXLwMuTWvexuMIhrGUzFRql4YZ4I=;
        b=iGYh4wbtGz0ZGH3HCDhIvQKX+TFmz0TwOJaRYem2WSxhqg9KbVtWJhJFV7+CdljOSJ
         AUpBEAFs681p7QQFixCX39LwsVsKLNXTxcou2+hG3yN3m1mecWHTa1WLJiGrJn5CO8x4
         c/xAAMNND9DwJt3yzEMf9lGYlO73oC8vg/aMts/IW0YSk6EmX1OvbXYM1ilLxMRZAqUz
         dQsaTBcGGIv8W+KzWyaffkb/IQPA44r/drtF9VF1zxIBCF/KLkmDcR6+AQM3VnpDR7r4
         niw39FHHgiOo0+IvgwbChS1f7twGfsS3rQt/+l9DvrHbz37/HUSRjqyIAWid9HEOaF4I
         SHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=K/koYjTIKng4CMvyXLwMuTWvexuMIhrGUzFRql4YZ4I=;
        b=NyDs/+o6Y8zgMZoSqgbz3fUVp7j8Mf53GmvxMxdnHNUCfSr6ONb5G0zafYyWfgMq/4
         Vu5tCmMjPH+7+EVssFbSd89ki8CGveIzlJmTI2YvvQwG+u1pUvZAiC5JX7B6vxLwihEI
         /1QdDlSQFvQSGdt7xMY5o/27U6pLahG08KaDyFi5OZ3CI5Ju1ih7vqZYagugH6H9T0oT
         CVL1Wop1PRr798Tz8aTQZu5BM0ARGGnrcHxThqeft2prj/xyE/PgxV05yq6sRY8AIzUW
         5eIAsfMU2DUvPniTkwbnP4oqCtsb6HrxXFF1FXmPjS9ehs979oxfHf4hoUm3e9VUo9/V
         h95w==
X-Gm-Message-State: ACrzQf30dvnIzw5GJynHRdtM6f5ooV6gC8+GrPv5j/7cHKK7zneCh5aK
        ysVyVS0fpgL2P3JAIPFaAHlOvzyZZrfOTw==
X-Google-Smtp-Source: AMsMyM58HMgf0IODDfYMpt5N+dUyVr4IheblGf7SHKXK7JTxa7AczdvfTsNSLbST3qmhtsUZ1QUBkA==
X-Received: by 2002:aa7:8896:0:b0:556:cc53:3f43 with SMTP id z22-20020aa78896000000b00556cc533f43mr30162210pfe.19.1664400411364;
        Wed, 28 Sep 2022 14:26:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s23-20020a170902b19700b00177f8f234cesm4176371plr.258.2022.09.28.14.26.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:26:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Fix attempting to acquire already acquired transport
Date:   Wed, 28 Sep 2022 14:26:49 -0700
Message-Id: <20220928212649.3824261-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the transport has links check if the link is acquiring before
attempting to call Acquire otherwise it may cause an error to be
printed.
---
 client/player.c | 70 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index 30ae263c8e41..4324089345c1 100644
--- a/client/player.c
+++ b/client/player.c
@@ -65,6 +65,7 @@ struct endpoint {
 	uint8_t codec;
 	struct iovec *caps;
 	bool auto_accept;
+	bool acquiring;
 	uint8_t cig;
 	uint8_t cis;
 	char *transport;
@@ -2688,6 +2689,30 @@ static struct endpoint *find_ep_by_transport(const char *path)
 	return NULL;
 }
 
+static struct endpoint *find_link_by_proxy(GDBusProxy *proxy)
+{
+	DBusMessageIter iter, array;
+
+	if (!g_dbus_proxy_get_property(proxy, "Links", &iter))
+		return NULL;
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) ==
+				DBUS_TYPE_OBJECT_PATH) {
+		const char *transport;
+		struct endpoint *link;
+
+		dbus_message_iter_get_basic(&array, &transport);
+
+		link = find_ep_by_transport(transport);
+		if (link)
+			return link;
+	}
+
+	return NULL;
+}
+
 static void transport_close(struct transport *transport)
 {
 	if (transport->fd < 0)
@@ -2769,10 +2794,19 @@ static void transport_new(GDBusProxy *proxy, int sk, uint16_t mtu[2])
 static void acquire_reply(DBusMessage *message, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
+	struct endpoint *ep, *link;
 	DBusError error;
 	int sk;
 	uint16_t mtu[2];
 
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+	if (ep) {
+		ep->acquiring = false;
+		link = find_link_by_proxy(proxy);
+		if (link)
+			link->acquiring = false;
+	}
+
 	dbus_error_init(&error);
 
 	if (dbus_set_error_from_message(&error, message) == TRUE) {
@@ -2803,11 +2837,22 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 static void transport_acquire(const char *input, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
+	struct endpoint *ep, *link;
 
 	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
-		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
+		if (g_dbus_proxy_method_call(proxy, "Acquire", NULL,
 						acquire_reply, proxy, NULL))
-			bt_shell_printf("Failed acquire transport\n");
+			return;
+		bt_shell_printf("Failed acquire transport\n");
+	}
+
+	/* Reset acquiring */
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+	if (ep) {
+		ep->acquiring = false;
+		link = find_link_by_proxy(proxy);
+		if (link)
+			link->acquiring = false;
 	}
 }
 
@@ -2815,7 +2860,7 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 						DBusMessageIter *iter)
 {
 	char *str;
-	struct endpoint *ep;
+	struct endpoint *ep, *link;
 
 	str = proxy_description(proxy, "Transport", COLORED_CHG);
 	print_iter(str, name, iter);
@@ -2833,14 +2878,29 @@ static void transport_property_changed(GDBusProxy *proxy, const char *name,
 	 * endpoint.
 	 */
 	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-	if (!ep)
+	if (!ep || ep->acquiring)
 		return;
 
+	ep->acquiring = true;
+
+	link = find_link_by_proxy(proxy);
+	if (link) {
+		bt_shell_printf("Link %s found\n", link->transport);
+		/* If link already acquiring wait it to be complete */
+		if (link->acquiring)
+			return;
+		link->acquiring = true;
+	}
+
 	if (ep->auto_accept) {
 		bt_shell_printf("Auto Acquiring...\n");
 		if (!g_dbus_proxy_method_call(proxy, "Acquire", NULL,
-						acquire_reply, proxy, NULL))
+						acquire_reply, proxy, NULL)) {
 			bt_shell_printf("Failed acquire transport\n");
+			ep->acquiring = false;
+			if (link)
+				link->acquiring = false;
+		}
 		return;
 	}
 
-- 
2.37.3

