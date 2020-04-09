Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A084C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0DF2084D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZHWxYUK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgDITrt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:47:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42438 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgDITrt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 15:47:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so971836ljp.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f//NAxK7NVQLTDEd9r9V523X8NWIwjJbsxXRfwRbPxg=;
        b=ZHWxYUK39uU/dyfu/Z2V04FsoVQOI3NCWzyslqo3K9N5JFvbUPxqHD5ipq8yxXo/8M
         uwyCucbThnOaVYbV8Kv+7pSs7PG4r4PjMDtPcbIJYLOyZ3bi7aj56Vqs8N5dTCN9UKvB
         /HtCqODLBGmU9KKRG5Sq0CkBWWiR6tEARpjvvRoAvDdiMk1vd4HUUyQKQrPNw1LYfI7s
         x+PjyKSlxlGwPF6KesFHQkkNgdaPHHX4jdHQ9/3YPzuspwFL7N+SS3fVgFcnm+4BwIvl
         2WqRWuRRF3lFmzNeWBScPg+51q7ci6i/ikC1GWXp5FrVVvAUyQEDmpq6czjMxje0NQ27
         qCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f//NAxK7NVQLTDEd9r9V523X8NWIwjJbsxXRfwRbPxg=;
        b=Mxv8jLUpTn1f1n9CoYyKo7BQ4WdF0Pyr7+YGy7HbL5AgCiGcb6fx+sCGQR/f5KukaV
         3oHgjMcnYimr9HK5eXwUpPP3EP4RsfyvO4DJQm6kXwQLy5/l73OTKpjrAVjvzGxM3cwR
         QR8xEqcVgz0meLbSl8gnefJsqrhlGOtLX9xSZM0d2f6Ys+vUAvtD/dvACoBtrpXJxeSF
         l3d7rKPe4KOTMY+NYyYzTM8AgmGE9aESgxVty3P7okSaSxwxB+eaEApF4GJXzDhXr5yX
         eJ3lEHKGikJ9T1ciR9UFmfaKPKuDw5GWZXYYIOWj1LO97DMqix6KVAnTrAxCOXKdGmaa
         3iEg==
X-Gm-Message-State: AGi0PuaqEsJ/6dh0c/CnWYYWKaS5hEYPSJl8py2lXlwxB5u/8Tp+/r7f
        cKVUpCPg45OEFRFMQd6ctRJY8t+G0ko=
X-Google-Smtp-Source: APiQypLvAYoKLJuxMYo6fQ4Qv4DuR/+5szCQyB5bMOsjbYcWMYc/pklpzHMq8HqYCPosH4aIj2xbgg==
X-Received: by 2002:a2e:8195:: with SMTP id e21mr858581ljg.49.1586461665772;
        Thu, 09 Apr 2020 12:47:45 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id l13sm15915895ljc.84.2020.04.09.12.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:47:45 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ v2 4/4] tools/mesh-cfgclient: Add waiting for 'JoinComplete'
Date:   Thu,  9 Apr 2020 21:47:33 +0200
Message-Id: <20200409194733.18039-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
References: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
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
2.26.0

