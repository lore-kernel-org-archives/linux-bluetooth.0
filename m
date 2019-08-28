Return-Path: <SRS0=N1M0=WY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A863C3A5A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2B322CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 07:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="IjMgoGU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfH1Hwk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:52:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39080 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1Hwk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Aug 2019 03:52:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so1431196wra.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2019 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7bA2urBKgOnKvfIRMv920GgddFyXANyykmJrgmAVwfw=;
        b=IjMgoGU9Vjo89ltyFE98ooE5OvsEMRGIAG/KQw8afzjYgqMS8ZoKWZ1MQwwAKeJyUT
         PlvCxMkk7cfWcv0ijuVrNgKG39efpL9YvHyLq8n+oyX0uvvsl4DmrOpoOXDxkszkRmH/
         oLAW/1UHG6IoOJNoTtuT9RmN4q6/8OuGcoccVLe6dM/uu6u1eNmvk94oIxkSo9In/5+r
         hPDKpwcX4Z79S79bpaNiOrh6fhIOhkEWhc+gADF6Ywxmk14aOtb92C6uDoEqRLtRmcBO
         7/ipZWK3GLh/Lev7OrM5GSP59G9UiWZE/Ey1rNijRSu48JXkpd9tcD1/WcIXD4EkcQsw
         dbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bA2urBKgOnKvfIRMv920GgddFyXANyykmJrgmAVwfw=;
        b=dg02ttvRLCzZMtkPwDCZIUyyKOgi7e8w/CQjDmTYFXb3IDC5sk0glZFEI0wOcukLIn
         u3AJYy2ehuIKX0HTLKEKCO2AAOFvPC8fgzdZiwstL9JkNDfp6uT2rkv2Zwr0IgamGrAD
         hMQ99/6RSKZwz57zsjMiQd4pD1Llz/x9ts9GKnSJ/q4rSk293b68MANAN5m1lPWQo1yQ
         NBfccFdMNh3pEq6o3t2pYxq9P7U47h0Mpz2jUnfbOD+YsOWz2HROv3xEJUXF8epZXfvP
         w3iSVkcR6xHjKFQW2PPrtfr5P4VjRqLFBSRW5Pjs4luJmmiybM20QcyZFBVUZR+5y5GS
         n1Ww==
X-Gm-Message-State: APjAAAWyb9va5a1rGDmJzMY80hlA9fjW0+gqQcLqF5Hv6cuI+ZIkH5y2
        zW5T1U+WoTKa/OgGVqp5PL8xObyudPo=
X-Google-Smtp-Source: APXvYqxML80zZ1QPT2z/tcqIfj2bkEjKbPEicUYFuCusNmJ66JM2A1GVHEziRI4YJSd2KFGL3kbHtg==
X-Received: by 2002:a5d:6606:: with SMTP id n6mr3020795wru.346.1566978756691;
        Wed, 28 Aug 2019 00:52:36 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t7sm206958wrr.37.2019.08.28.00.52.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:52:36 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] mesh: Implement properties on org.bluez.mesh.Node1 interface
Date:   Wed, 28 Aug 2019 09:52:29 +0200
Message-Id: <20190828075230.21594-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190828075230.21594-1-michal.lowas-rzechonek@silvair.com>
References: <20190828075230.21594-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/net.c  |   4 ++
 mesh/net.h  |   1 +
 mesh/node.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 7c4049e0e..2785039db 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3945,3 +3945,7 @@ void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov)
 	net->prov = prov;
 }
 
+uint32_t mesh_net_get_instant(struct mesh_net *net)
+{
+	return net->instant;
+}
diff --git a/mesh/net.h b/mesh/net.h
index 55e89ca72..150240ff8 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -359,3 +359,4 @@ void mesh_net_transmit_params_get(struct mesh_net *net, uint8_t *count,
 							uint16_t *interval);
 struct mesh_prov *mesh_net_get_prov(struct mesh_net *net);
 void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov);
+uint32_t mesh_net_get_instant(struct mesh_net *net);
diff --git a/mesh/node.c b/mesh/node.c
index 0d7e45c90..3d9ded3b1 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -24,6 +24,7 @@
 #define _GNU_SOURCE
 #include <dirent.h>
 #include <stdio.h>
+#include <sys/time.h>
 
 #include <ell/ell.h>
 
@@ -2103,6 +2104,100 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	return  l_dbus_message_new_method_return(msg);
 }
 
+static bool features_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct mesh_node *node = user_data;
+	uint8_t friend = node_friend_mode_get(node);
+	uint8_t lpn = node_lpn_mode_get(node);
+	uint8_t proxy = node_proxy_mode_get(node);
+	uint8_t count;
+	uint16_t interval;
+	uint8_t relay = node_relay_mode_get(node, &count, &interval);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	if (friend != MESH_MODE_UNSUPPORTED)
+		dbus_append_dict_entry_basic(builder, "Friend", "b", &friend);
+
+	if (lpn != MESH_MODE_UNSUPPORTED)
+		dbus_append_dict_entry_basic(builder, "LowPower", "b", &lpn);
+
+	if (proxy != MESH_MODE_UNSUPPORTED)
+		dbus_append_dict_entry_basic(builder, "Proxy", "b", &proxy);
+
+	if (relay != MESH_MODE_UNSUPPORTED)
+		dbus_append_dict_entry_basic(builder, "Relay", "b", &relay);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static bool beacon_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct mesh_node *node = user_data;
+	bool beacon_mode = node_beacon_mode_get(node) == MESH_MODE_ENABLED;
+
+	l_dbus_message_builder_append_basic(builder, 'b', &beacon_mode);
+
+	return true;
+}
+
+static bool beaconflags_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
+	uint8_t flags;
+	uint32_t iv_index;
+
+	mesh_net_get_snb_state(net, &flags, &iv_index);
+
+	l_dbus_message_builder_append_basic(builder, 'y', &flags);
+
+	return true;
+}
+
+static bool ivindex_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
+	uint8_t flags;
+	uint32_t iv_index;
+
+	mesh_net_get_snb_state(net, &flags, &iv_index);
+
+	l_dbus_message_builder_append_basic(builder, 'u', &iv_index);
+
+	return true;
+}
+
+static bool lastheard_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct mesh_node *node = user_data;
+	struct mesh_net *net = node_get_net(node);
+	struct timeval now;
+	uint32_t last_heard;
+
+	gettimeofday(&now, NULL);
+
+	last_heard = now.tv_sec - mesh_net_get_instant(net);
+
+	l_dbus_message_builder_append_basic(builder, 'u', &last_heard);
+
+	return true;
+
+}
+
 static void setup_node_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Send", 0, send_call, "", "oqqay",
@@ -2118,7 +2213,15 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 						"", "oqqay", "element_path",
 						"vendor", "model_id", "data");
 
-	/* TODO: Properties */
+	l_dbus_interface_property(iface, "Features", 0, "a{sv}", features_getter,
+									NULL);
+	l_dbus_interface_property(iface, "Beacon", 0, "b", beacon_getter, NULL);
+	l_dbus_interface_property(iface, "BeaconFlags", 0, "b",
+						beaconflags_getter, NULL);
+	l_dbus_interface_property(iface, "IvIndex", 0, "u", ivindex_getter,
+									NULL);
+	l_dbus_interface_property(iface, "SecondsSinceLastHeard", 0, "u",
+					lastheard_getter, NULL);
 }
 
 bool node_dbus_init(struct l_dbus *bus)
-- 
2.19.1

