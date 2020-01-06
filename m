Return-Path: <SRS0=R8GA=23=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C01C32767
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 05:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB9520707
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 05:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFFuw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:50:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:59308 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgAFFuw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 00:50:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 21:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,401,1571727600"; 
   d="scan'208";a="222161781"
Received: from ingas-nuc1.sea.intel.com ([10.251.144.187])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2020 21:50:51 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Style fix
Date:   Sun,  5 Jan 2020 21:50:49 -0800
Message-Id: <20200106055049.31997-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes style issues: spaces -> tabs, alignment.
---
 mesh/manager.c | 59 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 1ad6c126d..e4a7deaeb 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -750,35 +750,36 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 
 static void setup_management_interface(struct l_dbus_interface *iface)
 {
-    l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "",
-                            "ay", "uuid");
-    l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call, "",
-                            "qyay", "primary", "count", "dev_key");
-    l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call, "",
-                            "qy", "primary", "count");
-    l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call, "",
-                            "q", "seconds");
-    l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0, cancel_scan_call, "",
-                            "");
-    l_dbus_interface_method(iface, "CreateSubnet", 0, create_subnet_call, "",
-                            "q", "net_index");
-    l_dbus_interface_method(iface, "UpdateSubnet", 0, update_subnet_call, "",
-                            "q", "net_index");
-    l_dbus_interface_method(iface, "DeleteSubnet", 0, delete_subnet_call, "",
-                            "q", "net_index");
-    l_dbus_interface_method(iface, "ImportSubnet", 0, import_subnet_call, "",
-                            "qay", "net_index", "net_key");
-    l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call, "",
-                            "qq", "net_index", "app_index");
-    l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call, "",
-                            "q", "app_index");
-    l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call, "",
-                            "q", "app_index");
-    l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call, "",
-                            "qqay", "net_index", "app_index", "app_key");
-    l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call, "",
-                            "qy", "net_index", "phase");
- }
+	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "",
+								"ay", "uuid");
+	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
+				"", "qyay", "primary", "count", "dev_key");
+	l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call,
+						"", "qy", "primary", "count");
+	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
+							"", "q", "seconds");
+	l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0,
+						cancel_scan_call, "", "");
+	l_dbus_interface_method(iface, "CreateSubnet", 0, create_subnet_call,
+							"", "q", "net_index");
+	l_dbus_interface_method(iface, "UpdateSubnet", 0, update_subnet_call,
+							"", "q", "net_index");
+	l_dbus_interface_method(iface, "DeleteSubnet", 0, delete_subnet_call,
+							"", "q", "net_index");
+	l_dbus_interface_method(iface, "ImportSubnet", 0, import_subnet_call,
+					"", "qay", "net_index", "net_key");
+	l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call,
+					"", "qq", "net_index", "app_index");
+	l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call,
+							"", "q", "app_index");
+	l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call,
+							"", "q", "app_index");
+	l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call,
+							"", "qqay", "net_index",
+							"app_index", "app_key");
+	l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call, "",
+						"qy", "net_index", "phase");
+}
 
 bool manager_dbus_init(struct l_dbus *bus)
 {
-- 
2.21.0

