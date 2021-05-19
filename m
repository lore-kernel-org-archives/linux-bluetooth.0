Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160EDC43462
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C946124C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhESSXb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 14:23:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:32191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhESSXa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 14:23:30 -0400
IronPort-SDR: Y3hcyNRbQGgt/cxnJF9LcnOtJpgx0wDBnNobJ1HYnOYOJiYTITCQZCbYAC6kVLp9j4k52g9IvM
 sDzncdi6eQdg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="188175125"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188175125"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:10 -0700
IronPort-SDR: Pki1Cdi8WiKsWcsNjt0f7JynskDlkQ0IlCe91K7pwyQyQtcye7moIZ+uUCrifIjoc+WHRyOigo
 /+o0OSJ0WT5A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="439838654"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.229.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:22:09 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 3/5] tools/mesh: Add all supported OOB methods to cfgclient
Date:   Wed, 19 May 2021 11:21:48 -0700
Message-Id: <20210519182150.1680987-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519182150.1680987-1-brian.gix@intel.com>
References: <20210519182150.1680987-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To support the widest range of mesh devices, we need to support any
possible capability combinations that a remote device may request.
---
 tools/mesh-cfgclient.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 49069674f..a4a6f21ab 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -104,7 +104,17 @@ static struct model_info *cfgcli;
 static struct l_queue *devices;
 
 static bool prov_in_progress;
-static const char *caps[] = {"static-oob", "out-numeric", "in-numeric"};
+static const char * const caps[] = {"static-oob",
+				"push",
+				"twist",
+				"blink",
+				"beep",
+				"vibrate",
+				"public-oob",
+				"out-alpha",
+				"in-alpha",
+				"out-numeric",
+				"in-numeric"};
 
 static bool have_config;
 
@@ -419,7 +429,7 @@ static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
 	struct l_dbus_message *reply = NULL;
 	struct l_dbus_message_builder *builder;
 	uint32_t val_u32;
-	uint8_t oob_data[16];
+	uint8_t oob_data[64];
 
 	switch (type) {
 	case NONE:
@@ -435,15 +445,15 @@ static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
 		/* Fall Through */
 
 	case HEXADECIMAL:
-		if (len > 16) {
+		if (len > sizeof(oob_data)) {
 			bt_shell_printf("Bad input length\n");
 			break;
 		}
-		memset(oob_data, 0, 16);
+		memset(oob_data, 0, sizeof(oob_data));
 		memcpy(oob_data, buf, len);
 		reply = l_dbus_message_new_method_return(msg);
 		builder = l_dbus_message_builder_new(reply);
-		append_byte_array(builder, oob_data, 16);
+		append_byte_array(builder, oob_data, len);
 		l_dbus_message_builder_finalize(builder);
 		l_dbus_message_builder_destroy(builder);
 		break;
@@ -580,6 +590,16 @@ static struct l_dbus_message *prompt_numeric_call(struct l_dbus *dbus,
 	return NULL;
 }
 
+static struct l_dbus_message *prompt_public_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	l_dbus_message_ref(msg);
+	agent_input_request(HEXADECIMAL, 64, "Enter 512 bit Public Key",
+			agent_input_done, msg);
+	return NULL;
+}
+
 static struct l_dbus_message *prompt_static_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -618,6 +638,8 @@ static void setup_agent_iface(struct l_dbus_interface *iface)
 						"u", "s", "number", "type");
 	l_dbus_interface_method(iface, "PromptStatic", 0, prompt_static_call,
 						"ay", "s", "data", "type");
+	l_dbus_interface_method(iface, "PublicKey", 0, prompt_public_call,
+							"ay", "", "data");
 }
 
 static bool register_agent(void)
-- 
2.25.4

