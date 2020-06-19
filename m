Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6905DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496CC21924
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 21:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFSV1B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:27:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:21821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgFSV07 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 17:26:59 -0400
IronPort-SDR: 8LBm0Z0gMQF2AJO3YS9qWHFiud3jZW3mIdMAXssaQjQ09dxcb8q4Y+t4DM1eEZBoxdmvFCkKo6
 dnxvndVdK9lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="143045103"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="143045103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 14:26:59 -0700
IronPort-SDR: 99eSHzOCTeeR59FlQjjGMWV8scU815X9yU1BMmEHClgtXCE5w8AnJbZSA2tH6/WKyH7qt8Im+V
 SwWxtareOpDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="292246236"
Received: from pafleisc-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.109.121])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2020 14:26:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/3] tools/mesh-cfgclient: get/set IV index
Date:   Fri, 19 Jun 2020 14:26:54 -0700
Message-Id: <20200619212655.107839-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619212655.107839-1-inga.stotland@intel.com>
References: <20200619212655.107839-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds keeping track of IV index changes.
The updates are detected by observing PropertiesChanged signal
on local node's object path and reading "IvIndex" property
---
 tools/mesh-cfgclient.c | 39 ++++++++++++++++++++++++++++++++++++++-
 tools/mesh/mesh-db.c   | 25 +++++++++++++++++++++++++
 tools/mesh/mesh-db.h   |  3 ++-
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index fe82a8bbe..da9f83c29 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -144,6 +144,7 @@ static const char *range_opt;
 static const char *net_idx_opt;
 static const char *config_opt;
 
+static uint32_t iv_index;
 static uint16_t low_addr;
 static uint16_t high_addr;
 static uint16_t prov_net_idx;
@@ -664,6 +665,7 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 {
 	struct meshcfg_node *node = user_data;
 	struct l_dbus_message_iter iter_cfg;
+	uint32_t ivi;
 
 	if (l_dbus_message_is_error(msg)) {
 		const char *name;
@@ -693,6 +695,12 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 	/* Inititalize config client model */
 	client_init();
 
+	if (l_dbus_proxy_get_property(local->proxy, "IvIndex", "u", &ivi) &&
+							ivi != iv_index) {
+		iv_index = ivi;
+		mesh_db_set_iv_index(ivi);
+	}
+
 	return;
 
 fail:
@@ -1792,6 +1800,33 @@ static struct l_dbus_message *join_complete(struct l_dbus *dbus,
 	return l_dbus_message_new_method_return(message);
 }
 
+static void property_changed(struct l_dbus_proxy *proxy, const char *name,
+				struct l_dbus_message *msg, void *user_data)
+{
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+	const char *path = l_dbus_proxy_get_path(proxy);
+
+	if (strcmp(path, local->path))
+		return;
+
+	bt_shell_printf("Property changed: %s %s %s\n", name, path, interface);
+
+	if (!strcmp(interface, "org.bluez.mesh.Node1")) {
+
+		if (!strcmp(name, "IvIndex")) {
+			uint32_t ivi;
+
+			if (!l_dbus_message_get_arguments(msg, "u", &ivi))
+				return;
+
+			bt_shell_printf("New IV Index: %u\n", ivi);
+
+			iv_index = ivi;
+			mesh_db_set_iv_index(ivi);
+		}
+	}
+}
+
 static void setup_app_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_property(iface, "CompanyID", 0, "q", cid_getter,
@@ -1974,6 +2009,8 @@ static bool read_mesh_config(void)
 		high_addr = range_h;
 	}
 
+	iv_index = mesh_db_get_iv_index();
+
 	return true;
 }
 
@@ -2040,7 +2077,7 @@ int main(int argc, char *argv[])
 	l_dbus_client_set_disconnect_handler(client, client_disconnected, NULL,
 									NULL);
 	l_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
-							NULL, NULL, NULL);
+						property_changed, NULL, NULL);
 	l_dbus_client_set_ready_handler(client, client_ready, NULL, NULL);
 
 	node_proxies = l_queue_new();
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index b789c3933..dbeed0214 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1232,6 +1232,29 @@ bool mesh_db_set_addr_range(uint16_t low, uint16_t high)
 	return save_config();
 }
 
+uint32_t mesh_db_get_iv_index(void)
+{
+	int ivi;
+
+	if (!cfg || !cfg->jcfg)
+		return 0;
+
+	if (!get_int(cfg->jcfg, "ivIndex", &ivi))
+		return 0;
+
+	return (uint32_t) ivi;
+}
+
+bool mesh_db_set_iv_index(uint32_t ivi)
+{
+	if (!cfg || !cfg->jcfg)
+		return false;
+
+	write_int(cfg->jcfg, "ivIndex", ivi);
+
+	return save_config();
+}
+
 bool mesh_db_create(const char *fname, const uint8_t token[8],
 							const char *mesh_name)
 {
@@ -1282,6 +1305,8 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 
 	json_object_object_add(jcfg, "appKeys", jarray);
 
+	write_int(jcfg, "ivIndex", 0);
+
 	if (!save_config())
 		goto fail;
 
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 89c644400..83fcfbee7 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -26,7 +26,8 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 bool mesh_db_load(const char *fname);
 
 bool mesh_db_get_token(uint8_t token[8]);
-
+bool mesh_db_set_iv_index(uint32_t ivi);
+uint32_t mesh_db_get_iv_index(void);
 bool mesh_db_net_key_add(uint16_t idx);
 bool mesh_db_net_key_del(uint16_t idx);
 bool mesh_db_net_key_phase_set(uint16_t net_idx, uint8_t phase);
-- 
2.26.2

