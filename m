Return-Path: <SRS0=CMXm=WX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3ACC3A5A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 09:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC25B217F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Aug 2019 09:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="BmPxw7Hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfH0JIz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:08:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37942 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0JIy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Aug 2019 05:08:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id c12so3200878lfh.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2019 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7bA2urBKgOnKvfIRMv920GgddFyXANyykmJrgmAVwfw=;
        b=BmPxw7Hhaw7WxxRh0SX9N5uXrogx2X62+YrzRDFnmYY6R3CVDxODR0Gv7NSRBs3tK2
         n/0o/bW94rqlzrC+evk14EFJtlX6NIEvOcCjgNDkJH980tY8fb8pvXLxEBAoFjkti9JO
         Tf5CzLCIOSut8YZ7g4jqVZuj+4bztNAuPHwiI9tcBJmg8Ek0VJBzMEkCdT5OlPetw/mD
         7SWvLP8QQFzy7LupA9mGSt0L3+voPXfCdiq66YLs0czwSyoivx3/VZC/C1CavFyHyDWt
         uRbbSga6OSBvtoysztZoSsh4c9xY5J/zEPLPK1gOGz7ymp16ryq518lZPCzVioAFHEDb
         RERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bA2urBKgOnKvfIRMv920GgddFyXANyykmJrgmAVwfw=;
        b=ib+TxeNfMAEWMq7ADcYr4iNRXAMVeLtuqftcaMuuB6r4wjBnK2qtD4cRCVFpRRYYeT
         sYAAhTJm1gdFyGCavPRGAXEzRgQQenhoexdYb7dNjgD5x1QJ9VRVPbLVduukLwEDTfJ/
         z1qwV6d2M6R8ZpY0HimznBjFZAuGbueNYCRR1AGwlOo+CQjSI0JFx8aUpOKo6f1I7MHy
         Ve6GwNN8n7IDSRMbvSqrLFl3YDABxSwDU32nxHYkAzFDIFTgNZlvdVOawgfB8K6rQ/0L
         04QyJIMmrpDY5mrCzzMCbmwn2fqFiE7NMdyQIHNc2SYbpuCDX2rCTSEE1lVHvTpUJUs+
         NTSw==
X-Gm-Message-State: APjAAAWti+Nhv4NUvAT/s4aXJe6cyQEA+dKVnLKuISJhSGdJK7kNwYEA
        YHXx5dUpw10Fnx85uA/IDLjJvp70vok=
X-Google-Smtp-Source: APXvYqyjjjMciHpLfumHNmu3dUuKuY0VMu+0i9WCI6m0cucN95z2r8oCD1qxTsKKPchJQfWf/oclkg==
X-Received: by 2002:a19:ac41:: with SMTP id r1mr13676070lfc.100.1566896930768;
        Tue, 27 Aug 2019 02:08:50 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v2sm2525625lfb.88.2019.08.27.02.08.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:08:50 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] mesh: Implement properties on org.bluez.mesh.Node1 interface
Date:   Tue, 27 Aug 2019 11:08:43 +0200
Message-Id: <20190827090844.21394-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
References: <20190827090844.21394-1-michal.lowas-rzechonek@silvair.com>
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

