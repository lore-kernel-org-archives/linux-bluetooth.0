Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A2C2D0EE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F10020716
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0SnA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:43:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:39636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgC0SnA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:43:00 -0400
IronPort-SDR: c6LK0uN4eb1ncGGOGht32uJJRHQejZdUPfQPqtfQg+icRfcIMzOQblzGjAqcRi0ccMKcq+J/Yz
 I9qc6Le9IWaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 11:43:00 -0700
IronPort-SDR: 9zHzxufKMdsTziwWA/mauqwy+9n5NJVVaiqZy8wVvrQlJwF18c8k3N5KHU1BA5eIZAQkGvEp2x
 83ej66l30Uhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="421193648"
Received: from ingas-nuc1.sea.intel.com ([10.251.8.23])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 11:42:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4] mesh: Update UnprovisionedScan, AddNode & ScanResult
Date:   Fri, 27 Mar 2020 11:42:55 -0700
Message-Id: <20200327184257.15042-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327184257.15042-1-inga.stotland@intel.com>
References: <20200327184257.15042-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following methods are modified to allow for future development:

Interface org.bluez.mesh.Management1:

Old: void UnprovisionedScan(uint16 seconds)
New: void UnprovisionedScan(dict options)

    The options parameter is a dictionary with the following keys defined:
    uint16 Seconds
                Specifies number of seconds for scanning to be active.
                If set to 0 or if this key is not present, then the
                scanning will continue until UnprovisionedScanCancel()
                or AddNode() methods are called.
    other keys TBD

Old: void AddNode(array{byte}[16] uuid)
New: void AddNode(array{byte}[16] uuid, dict options)

    The options parameter is currently an empty dictionary

Interface org.bluez.mesh.Provisioner1

Old: void ScanResult(int16 rssi, array{byte} data)
New: void ScanResult(int16 rssi, array{byte} data, dict options)

    The options parameter is currently an empty dictionary
---
 mesh/manager.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 0909c7e16..8e948e47d 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -217,21 +217,22 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
-	struct l_dbus_message_iter iter_uuid;
+	struct l_dbus_message_iter iter_uuid, options;
 	struct l_dbus_message *reply;
 	uint8_t *uuid;
-	uint32_t n;
+	uint32_t n = 22;
 
 	l_debug("AddNode request");
 
-	if (!l_dbus_message_get_arguments(msg, "ay", &iter_uuid))
+	if (!l_dbus_message_get_arguments(msg, "aya{sv}", &iter_uuid, &options))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
-								|| n != 16)
+	    || n != 16) {
+		l_debug("n = %u", n);
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device UUID");
-
+	}
 	/* Allow AddNode to cancel Scanning if from the same node */
 	if (scan_node) {
 		if (scan_node != node)
@@ -361,6 +362,9 @@ static void prov_beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 	builder = l_dbus_message_builder_new(msg);
 	l_dbus_message_builder_append_basic(builder, 'n', &rssi);
 	dbus_append_byte_array(builder, data + 2, len -2);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	/* TODO: populate with options when defined */
+	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 
@@ -372,17 +376,34 @@ static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct mesh_node *node = user_data;
-	uint16_t duration;
+	uint16_t duration = 0;
 	struct mesh_io *io;
 	struct mesh_net *net;
+	const char *key;
+	struct l_dbus_message_iter options, var;
 	const char *sender = l_dbus_message_get_sender(msg);
 
 	if (strcmp(sender, node_get_owner(node)))
 		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
 
-	if (!l_dbus_message_get_arguments(msg, "q", &duration))
+	if (!l_dbus_message_get_arguments(msg, "a{sv}", &options))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
+	while (l_dbus_message_iter_next_entry(&options, &key, &var)) {
+		bool failed = true;
+
+		if (!strcmp(key, "Seconds")) {
+			if (l_dbus_message_iter_get_variant(&var, "q",
+							    &duration)) {
+				failed = false;
+			}
+		}
+
+		if (failed)
+			return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Invalid options");
+	}
+
 	if (scan_node && scan_node != node)
 		return dbus_error(msg, MESH_ERROR_BUSY, NULL);
 
@@ -752,13 +773,13 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 static void setup_management_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "",
-								"ay", "uuid");
+						"aya{sv}", "uuid", "options");
 	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
 				"", "qyay", "primary", "count", "dev_key");
 	l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call,
 						"", "qy", "primary", "count");
 	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
-							"", "q", "seconds");
+							"", "a{sv}", "options");
 	l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0,
 						cancel_scan_call, "", "");
 	l_dbus_interface_method(iface, "CreateSubnet", 0, create_subnet_call,
-- 
2.21.1

