Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F40CC2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1212206F7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="nHaAmjpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgDHUxL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:53:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37929 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgDHUxL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 16:53:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id l11so6241126lfc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2020 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydMliBbxes0uQbQu/87VkkNAw7EAWP1FEHNcgBKJZGY=;
        b=nHaAmjpvINawhUufhq+BoQJ7UaG2ezYzzGz3Iy04jGSixP2/rnuyr0WJzG15kjPof3
         IfMOtQ9ZYoblGpz7bdHBz3y/jWuLWv2TvYAyvwch16WaHoHEcay520p1fOfiFzIEyXiC
         GUIk1OYTgmOwR2kJ2+tSc3rQUby/n1X+onzGjI4QxQ14vZSVvYaOvu4hlC9Lh0v0WQcv
         nvEis4AN9X7URN55hIKHohtj25XtjbLCDeEbUzVSBDg/TUMHkhdGHCQWTBC63T3nLsD9
         XB9DW1uNeQs1un7GakTHJRPVDz+bZZhGi1wurVWSRV5KkL5Q6DHk512QXggTDTBtKONS
         EEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydMliBbxes0uQbQu/87VkkNAw7EAWP1FEHNcgBKJZGY=;
        b=T8zuOCzmoJZf/IKB+/5kXDmnU4n2lEI16XkBZhMoN2Ca2PiMtTfGPlbvFyWlx6fzte
         VduB1LXT1AVx8Ve7ws7tkr9kq2E3wWmASDCWVyuatt6cwssAotFE88DJmDelD1bJSLoj
         BZy/2UXAvjtvDJCTkP6AsUHIA2IcF2AfJ7MwYwjYhF5Xzp074EEiFAGbMXT8kiv6W3n4
         YdOwFBafl06yLBj8TPad2dI7L3LHSyLwh7OqltOq++tiEpwB1XjMaf0HviPjFfBoBR46
         ur4n8TKNI4Xbl4u9IU3qnwCTxAIQ520F0t438S/RhzDOnXRZJ88ejnphWgRl6mcknwbk
         Ecaw==
X-Gm-Message-State: AGi0PuYkuwjpNq8Dsuxjq+ycljV93YTUj63MxzUO2bEAU8Z/JkutR8PX
        wkqDYZhpYAvdl8siIOF4N0GkGeqQm04=
X-Google-Smtp-Source: APiQypLLlfCUcdF38evb4csYqawl3/EiZh/CMYtCXOoU2jrYJ3Ykkx//nIldxePI8p79nAergL/8Mg==
X-Received: by 2002:ac2:4350:: with SMTP id o16mr5676730lfl.136.1586379187990;
        Wed, 08 Apr 2020 13:53:07 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id r24sm14168976ljn.25.2020.04.08.13.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:53:07 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ 4/4] tools/mesh-cfgclient: Add waiting for 'JoinComplete'
Date:   Wed,  8 Apr 2020 22:52:55 +0200
Message-Id: <20200408205255.45112-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
References: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Przemysław Fierek <przemyslaw.fierek@silvair.com>

---
 tools/mesh-cfgclient.c | 73 ++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 5b018eb4a..c5b6938ed 100644
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
@@ -1779,6 +1748,43 @@ static bool crpl_getter(struct l_dbus *dbus,
 	return true;
 }
 
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
+	l_dbus_proxy_method_call(net_proxy, "Attach", attach_node_setup,
+						attach_node_reply, NULL,
+						NULL);
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static void setup_app_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_property(iface, "CompanyID", 0, "q", cid_getter,
@@ -1789,6 +1795,9 @@ static void setup_app_iface(struct l_dbus_interface *iface)
 									NULL);
 	l_dbus_interface_property(iface, "CRPL", 0, "q", crpl_getter, NULL);
 
+	l_dbus_interface_method(iface, "JoinComplete", 0, join_complete,
+							"", "t", "token");
+
 	/* TODO: Methods */
 }
 
-- 
2.26.0

