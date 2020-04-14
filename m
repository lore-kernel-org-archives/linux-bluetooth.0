Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF7C352BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021392072D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 08:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="g5CdbYab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437246AbgDNIzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437241AbgDNIzq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 04:55:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120F6C008749
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so12119169wmj.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2020 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYw83xQZWPThAtROU1oga8r97ZB97JOahIrkX+lwcrw=;
        b=g5CdbYabWHDPDzbLX/KIqGC+4iWYugLaR0E+5no8fMdeCHL9UfOHPqBv8ZFVPP6UD2
         POo5AdlmmaTqNioQ5KFQhiK+S246EVrPLQb1IPuRRVzkbvYOJe1F2A8V6uXK6XI6IYe4
         v3Tl5HKWtOaGRuxDilTFRM4xYedOvFHBRfVbYcuMNzvIJ5NFtcd7p3J6FsnghrYVX5CG
         c8cyFK+oARpU1RzCAI0TIajc63PVhJtn/FPvcki9OWm7/uKatnRxvDBaEZ2RoSOewu9f
         j7XN6GGNRy/CE76o8dvLIr7fUtGWnocYbg6rtD0GSxApi8/UN8Ahjbqv/T08YWdCUV5O
         Tumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYw83xQZWPThAtROU1oga8r97ZB97JOahIrkX+lwcrw=;
        b=WLWh/qA+txalY5f2xIBVg0nxaMgSeAKyLa5RnJAZH4b9XQ1ZnBvXUbvawIIwvYcyNr
         8aDMzRg5UbJI19cl5CnPKh0h/OAPTHCa21nngKNfudCn4UTvXlHBaGYhT/2ue504Bv9l
         yhaKpD84I1UPYqEILGGdjqx5PnGHjMbxS8o352FuhYEJ8Gwfu2AUiTbLZQ1kfdxDhFSC
         NZrjDGWPbG4WzALF8E6KnbT8speKoCQXd/PXVpFr5HTzP2Pa6TUVjzfvCOYEdtlFvaLs
         eMhYs9obMzGWVUzeGVxH/U1WK/reaOStba6bNzL8DHs54FElonGJ5sQlvbrxX/hA6Gez
         +QZQ==
X-Gm-Message-State: AGi0Pua/NB1KuLeKgwN56IVwTVKb8NLo25EpU6wzhF8pDv3s+K0T8jfj
        o8kLAytfl07Zez2yJAbqa31baiiQJO8=
X-Google-Smtp-Source: APiQypIQ3mpGTqvECB3o5fJni4zf8cMrn2iwHMNdYPVXbpdrqPpK9qfQgwmIE/wRNra9m6mEscDWsQ==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr21383196wmj.125.1586854544349;
        Tue, 14 Apr 2020 01:55:44 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w83sm18361553wmb.37.2020.04.14.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 01:55:43 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ v5 3/4] tools/mesh-cfgclient: Add waiting for 'JoinComplete'
Date:   Tue, 14 Apr 2020 10:55:56 +0200
Message-Id: <20200414085557.23464-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
References: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Przemysław Fierek <przemyslaw.fierek@silvair.com>

---
 tools/mesh-cfgclient.c | 78 +++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 5b018eb4a..6db65cd49 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -707,44 +707,13 @@ static void attach_node_setup(struct l_dbus_message *msg, void *user_data)
 static void create_net_reply(struct l_dbus_proxy *proxy,
 				struct l_dbus_message *msg, void *user_data)
 {
-	char *str;
-	uint64_t tmp;
-
 	if (l_dbus_message_is_error(msg)) {
 		const char *name;
 
 		l_dbus_message_get_error(msg, &name, NULL);
 		l_error("Failed to create network: %s", name);
 		return;
-
-	}
-
-	if (!l_dbus_message_get_arguments(msg, "t", &tmp))
-		return;
-
-	local = l_new(struct meshcfg_node, 1);
-	local->token.u64 = l_get_be64(&tmp);
-	str = l_util_hexstring(&local->token.u8[0], 8);
-	bt_shell_printf("Created new node with token %s\n", str);
-	l_free(str);
-
-	if (!mesh_db_create(cfg_fname, local->token.u8,
-						"Mesh Config Client Network")) {
-		l_free(local);
-		local = NULL;
-		return;
 	}
-
-	mesh_db_set_addr_range(low_addr, high_addr);
-	keys_add_net_key(PRIMARY_NET_IDX);
-	mesh_db_net_key_add(PRIMARY_NET_IDX);
-
-	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
-	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
-
-	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
-						attach_node_reply, NULL,
-						NULL);
 }
 
 static void create_net_setup(struct l_dbus_message *msg, void *user_data)
@@ -1727,7 +1696,7 @@ static struct l_dbus_message *add_node_fail_call(struct l_dbus *dbus,
 static void setup_prov_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "ScanResult", 0, scan_result_call, "",
-						"naya{sv}", "rssi", "data", "options");
+					"naya{sv}", "rssi", "data", "options");
 
 	l_dbus_interface_method(iface, "RequestProvData", 0, req_prov_call,
 				"qq", "y", "net_index", "unicast", "count");
@@ -1779,6 +1748,48 @@ static bool crpl_getter(struct l_dbus *dbus,
 	return true;
 }
 
+static void attach_node(void *user_data)
+{
+	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
+						attach_node_reply, NULL,
+						NULL);
+}
+
+static struct l_dbus_message *join_complete(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	char *str;
+	uint64_t tmp;
+
+	if (!l_dbus_message_get_arguments(message, "t", &tmp))
+		return l_dbus_message_new_error(message, dbus_err_args, NULL);
+
+	local = l_new(struct meshcfg_node, 1);
+	local->token.u64 = l_get_be64(&tmp);
+	str = l_util_hexstring(&local->token.u8[0], 8);
+	bt_shell_printf("Created new node with token %s\n", str);
+	l_free(str);
+
+	if (!mesh_db_create(cfg_fname, local->token.u8,
+					"Mesh Config Client Network")) {
+		l_free(local);
+		local = NULL;
+		return l_dbus_message_new_error(message, dbus_err_fail, NULL);
+	}
+
+	mesh_db_set_addr_range(low_addr, high_addr);
+	keys_add_net_key(PRIMARY_NET_IDX);
+	mesh_db_net_key_add(PRIMARY_NET_IDX);
+
+	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
+	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
+
+	l_idle_oneshot(attach_node, NULL, NULL);
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void setup_app_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_property(iface, "CompanyID", 0, "q", cid_getter,
@@ -1789,6 +1800,9 @@ static void setup_app_iface(struct l_dbus_interface *iface)
 									NULL);
 	l_dbus_interface_property(iface, "CRPL", 0, "q", crpl_getter, NULL);
 
+	l_dbus_interface_method(iface, "JoinComplete", 0, join_complete,
+							"", "t", "token");
+
 	/* TODO: Methods */
 }
 
-- 
2.20.1

