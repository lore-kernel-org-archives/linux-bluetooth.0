Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A3C432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1394720714
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKVQXi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:23:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:9463 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfKVQXi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 11:23:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="197670498"
Received: from ingas-nuc1.sea.intel.com ([10.251.140.44])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2019 08:23:35 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, sbrown@ewol.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Fix signatures in agent methods
Date:   Fri, 22 Nov 2019 08:23:31 -0800
Message-Id: <20191122162331.10096-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes an extra return parameter from PromptNumeric and PromptStatic
method signatures. Also, style fixes.
---
 tools/mesh-cfgclient.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 1c617a37b..200eb5b84 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -478,6 +478,7 @@ static struct l_dbus_message *disp_string_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
+	const char *prompt = "Enter AlphaNumeric code on remote device:";
 	char *str;
 
 	if (!l_dbus_message_get_arguments(msg, "s", &str)) {
@@ -485,7 +486,7 @@ static struct l_dbus_message *disp_string_call(struct l_dbus *dbus,
 		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
 	}
 
-	bt_shell_printf(COLOR_YELLOW "Enter AlphaNumeric code on remote device: %s\n" COLOR_OFF, str);
+	bt_shell_printf(COLOR_YELLOW "%s %s\n" COLOR_OFF, prompt, str);
 
 	return l_dbus_message_new_method_return(msg);
 }
@@ -542,13 +543,13 @@ static void setup_agent_iface(struct l_dbus_interface *iface)
 								NULL);
 	/* TODO: Other properties */
 	l_dbus_interface_method(iface, "DisplayString", 0, disp_string_call,
-						"", "s", "value");
+							"", "s", "value");
 	l_dbus_interface_method(iface, "DisplayNumeric", 0, disp_numeric_call,
 						"", "su", "type", "number");
 	l_dbus_interface_method(iface, "PromptNumeric", 0, prompt_numeric_call,
-						"u", "s", "type");
+						"u", "s", "number", "type");
 	l_dbus_interface_method(iface, "PromptStatic", 0, prompt_static_call,
-						"ay", "s", "type");
+						"ay", "s", "data", "type");
 }
 
 static bool register_agent(void)
-- 
2.21.0

