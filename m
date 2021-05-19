Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CFC433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA4761364
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhESALz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 20:11:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:12937 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhESALz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 20:11:55 -0400
IronPort-SDR: WAd+CI4Y159IvF5OLDpZ0+imCFtYqZBIjEH2YdrvcV6qHxd3Kv1irxoLSE8qg86OO15ZZvTcDQ
 HUPRQrH8tRiA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188263489"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="188263489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 17:10:36 -0700
IronPort-SDR: eWtAkOFJROeYMkHvA0TMkJ4MnSSlKF3Y5F/qWcJwYE8KVaz2X8CfTyzKOkei3C0CjKnZFJ4s8D
 ZxV/CYb23dUw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439707715"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.0.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 17:10:34 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ 3/4] tools/mesh: Add all supported OOB methods to cfgclient
Date:   Tue, 18 May 2021 17:10:26 -0700
Message-Id: <20210519001027.1540720-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210519001027.1540720-1-brian.gix@intel.com>
References: <20210519001027.1540720-1-brian.gix@intel.com>
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
index 49069674f..fd859a606 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -104,7 +104,17 @@ static struct model_info *cfgcli;
 static struct l_queue *devices;
 
 static bool prov_in_progress;
-static const char *caps[] = {"static-oob", "out-numeric", "in-numeric"};
+static const char *caps[] = {"static-oob",
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
+                                               struct l_dbus_message *msg,
+                                               void *user_data)
+{
+       l_dbus_message_ref(msg);
+       agent_input_request(HEXADECIMAL, 64, "Enter 512 bit Public Key",
+                                                       agent_input_done, msg);
+       return NULL;
+}
+
 static struct l_dbus_message *prompt_static_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -618,6 +638,8 @@ static void setup_agent_iface(struct l_dbus_interface *iface)
 						"u", "s", "number", "type");
 	l_dbus_interface_method(iface, "PromptStatic", 0, prompt_static_call,
 						"ay", "s", "data", "type");
+       l_dbus_interface_method(iface, "PublicKey", 0, prompt_public_call,
+                                               "ay", "", "data");
 }
 
 static bool register_agent(void)
-- 
2.25.4

