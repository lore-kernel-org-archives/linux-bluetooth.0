Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5BFC2D0F0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEBF20716
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0SnB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:43:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:39636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgC0SnB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:43:01 -0400
IronPort-SDR: m2GmDPr7Z9yifqMzS8V+8KqdHbXXkfPY499jlbjpe9/T0Lwxr23oHP5nHtsXT5TscbMNfVjayJ
 r/vH/VfS8dCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 11:43:01 -0700
IronPort-SDR: Y/sNGXA3qX4gP7EAdkWB32b3rAnxm6cPznpI2Aj+viidfPrS7PUClWzrj/cZAqbtJQVd3eLLlT
 wfYTfuVu+tpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="421193655"
Received: from ingas-nuc1.sea.intel.com ([10.251.8.23])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 11:43:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 4/4] tools/mesh-cfgclient: Update to match modified APIs
Date:   Fri, 27 Mar 2020 11:42:57 -0700
Message-Id: <20200327184257.15042-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327184257.15042-1-inga.stotland@intel.com>
References: <20200327184257.15042-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This handles updated parameter list in UnprovisionedScan(),
AddNode() and ScanResult() D-Bus methods
---
 tools/mesh-cfgclient.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index ae13c4409..d1c673182 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -232,6 +232,21 @@ struct key_data {
 	bool update;
 };
 
+static void append_dict_entry_basic(struct l_dbus_message_builder *builder,
+					const char *key, const char *signature,
+					const void *data)
+{
+	if (!builder)
+		return;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', key);
+	l_dbus_message_builder_enter_variant(builder, signature);
+	l_dbus_message_builder_append_basic(builder, signature[0], data);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
 static void append_byte_array(struct l_dbus_message_builder *builder,
 					unsigned char *data, unsigned int len)
 {
@@ -769,9 +784,15 @@ static void scan_reply(struct l_dbus_proxy *proxy, struct l_dbus_message *msg,
 
 static void scan_setup(struct l_dbus_message *msg, void *user_data)
 {
-	int32_t secs = L_PTR_TO_UINT(user_data);
+	uint16_t secs = (uint16_t) L_PTR_TO_UINT(user_data);
+	struct l_dbus_message_builder *builder;
 
-	l_dbus_message_set_arguments(msg, "q", (uint16_t) secs);
+	builder = l_dbus_message_builder_new(msg);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	append_dict_entry_basic(builder, "Seconds", "q", &secs);
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
 }
 
 static void cmd_scan_unprov(int argc, char *argv[])
@@ -1284,6 +1305,9 @@ static void add_node_setup(struct l_dbus_message *msg, void *user_data)
 
 	builder = l_dbus_message_builder_new(msg);
 	append_byte_array(builder, uuid, 16);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	/* TODO: populate with options when defined */
+	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 
@@ -1508,17 +1532,17 @@ static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	struct l_dbus_message_iter iter;
+	struct l_dbus_message_iter iter, opts;
 	int16_t rssi;
 	uint32_t n;
 	uint8_t *prov_data;
 	char *str;
 	struct unprov_device *dev;
+	const char *sig = "naya{sv}";
 
-	if (!l_dbus_message_get_arguments(msg, "nay", &rssi, &iter)) {
+	if (!l_dbus_message_get_arguments(msg, sig, &rssi, &iter, &opts)) {
 		l_error("Cannot parse scan results");
 		return l_dbus_message_new_error(msg, dbus_err_args, NULL);
-
 	}
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter, &prov_data, &n) ||
@@ -1669,7 +1693,7 @@ static struct l_dbus_message *add_node_fail_call(struct l_dbus *dbus,
 static void setup_prov_iface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "ScanResult", 0, scan_result_call, "",
-							"nay", "rssi", "data");
+						"naya{sv}", "rssi", "data");
 
 	l_dbus_interface_method(iface, "RequestProvData", 0, req_prov_call,
 				"qq", "y", "net_index", "unicast", "count");
-- 
2.21.1

