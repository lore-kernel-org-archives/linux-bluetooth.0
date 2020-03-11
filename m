Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97114C0044D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9172F2074E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgCKW7r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:59:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:17050 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbgCKW7r (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 18:59:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 15:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; 
   d="scan'208";a="236449457"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.76.166])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2020 15:59:45 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, testtgsh@gmail.com
Subject: [PATCH BlueZ v2] tools/mesh-cfgclient: Add support for Static OOB key
Date:   Wed, 11 Mar 2020 15:59:40 -0700
Message-Id: <20200311225940.6628-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a bug that didn't allow 16 octet Static OOB strings during
provisioning.
---
 tools/mesh-cfgclient.c | 29 +++++++++++++++++++----------
 tools/mesh/agent.c     | 10 ++++++----
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index b4d76de93..4b7bd2200 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -372,12 +372,11 @@ static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
 	struct l_dbus_message *reply = NULL;
 	struct l_dbus_message_builder *builder;
 	uint32_t val_u32;
-	uint8_t ascii[16];
+	uint8_t oob_data[16];
 
 	switch (type) {
 	case NONE:
 	case OUTPUT:
-	case HEXADECIMAL:
 	default:
 		break;
 
@@ -386,12 +385,18 @@ static void agent_input_done(oob_type_t type, void *buf, uint16_t len,
 			bt_shell_printf("Bad input length\n");
 			break;
 		}
+		/* Fall Through */
 
-		memset(ascii, 0, 16);
-		memcpy(ascii, buf, len);
+	case HEXADECIMAL:
+		if (len > 16) {
+			bt_shell_printf("Bad input length\n");
+			break;
+		}
+		memset(oob_data, 0, 16);
+		memcpy(oob_data, buf, len);
 		reply = l_dbus_message_new_method_return(msg);
 		builder = l_dbus_message_builder_new(reply);
-		append_byte_array(builder, ascii, 16);
+		append_byte_array(builder, oob_data, 16);
 		l_dbus_message_builder_finalize(builder);
 		l_dbus_message_builder_destroy(builder);
 		break;
@@ -539,12 +544,16 @@ static struct l_dbus_message *prompt_static_call(struct l_dbus *dbus,
 		return l_dbus_message_new_error(msg, dbus_err_fail, NULL);
 	}
 
-	if (!strcmp(str, "in-alpha") && !strcmp(str, "out-alpha"))
-		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
-
-	l_dbus_message_ref(msg);
-	agent_input_request(ASCII, 8, "Enter displayed Ascii code",
+	if (!strcmp(str, "in-alpha") || !strcmp(str, "out-alpha")) {
+		l_dbus_message_ref(msg);
+		agent_input_request(ASCII, 8, "Enter displayed Ascii code",
 							agent_input_done, msg);
+	} else if (!strcmp(str, "static-oob")) {
+		l_dbus_message_ref(msg);
+		agent_input_request(HEXADECIMAL, 16, "Enter Static Key",
+							agent_input_done, msg);
+	} else
+		return l_dbus_message_new_error(msg, dbus_err_support, NULL);
 
 	return NULL;
 }
diff --git a/tools/mesh/agent.c b/tools/mesh/agent.c
index 1f83347bf..0258a3803 100644
--- a/tools/mesh/agent.c
+++ b/tools/mesh/agent.c
@@ -81,15 +81,16 @@ static bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
 static void response_hexadecimal(const char *input, void *user_data)
 {
 	uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];
+	uint16_t len = pending_request.len;
 
 	if (!str2hex(input, strlen(input), buf, pending_request.len) ) {
 		bt_shell_printf("Incorrect input: expecting %d hex octets\n",
 			  pending_request.len);
-		return;
+		len = 0;
 	}
 
 	if (pending_request.cb)
-		pending_request.cb(HEXADECIMAL, buf, pending_request.len,
+		pending_request.cb(HEXADECIMAL, buf, len,
 					pending_request.user_data);
 
 	reset_input_request();
@@ -98,14 +99,15 @@ static void response_hexadecimal(const char *input, void *user_data)
 static void response_decimal(const char *input, void *user_data)
 {
 	uint8_t buf[DECIMAL_OOB_LEN];
+	uint16_t len = DECIMAL_OOB_LEN;
 
 	if (strlen(input) > pending_request.len)
-		return;
+		len = 0;
 
 	bt_put_be32(atoi(input), buf);
 
 	if (pending_request.cb)
-		pending_request.cb(DECIMAL, buf, DECIMAL_OOB_LEN,
+		pending_request.cb(DECIMAL, buf, len,
 					pending_request.user_data);
 
 	reset_input_request();
-- 
2.21.1

