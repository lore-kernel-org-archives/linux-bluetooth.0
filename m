Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5028AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 16:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3598A2073E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 16:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGGQot (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:44:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:62900 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGGQot (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 12:44:49 -0400
IronPort-SDR: LfPdDm9L2YEyqXQFYfEaCz73AXcz8XGvybsbrwAVSvlU14JRNKlRMe0tQNrEd3QFKhfqRZL77I
 +NfLn6oAL7RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147657526"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="147657526"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 09:44:41 -0700
IronPort-SDR: sjwYZw1bSqGtv389avo8bjKvuUYNTxpyaoI292FaUiM/VRv2C1RCDzXrZSXsB4SyaTvNIHS61f
 1HK+P5oItxpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="323592435"
Received: from jdlachim-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.255.230.123])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2020 09:44:40 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] tools/mesh: Get rid of "unreliable opcodes" in models
Date:   Tue,  7 Jul 2020 09:44:39 -0700
Message-Id: <20200707164439.24146-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707164439.24146-1-inga.stotland@intel.com>
References: <20200707164439.24146-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes an old notion of unreliable opcodes in models , i.e.,
a correctly formatted acknowledged message always gets a response.
---
 tools/mesh-gatt/config-client.c | 2 +-
 tools/mesh-gatt/config-server.c | 2 +-
 tools/mesh-gatt/onoff-model.c   | 2 +-
 tools/mesh-gatt/util.h          | 2 --
 tools/mesh/cfgcli.c             | 4 ++--
 tools/mesh/model.h              | 1 -
 6 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/mesh-gatt/config-client.c b/tools/mesh-gatt/config-client.c
index ed31c67d9..bfc788258 100644
--- a/tools/mesh-gatt/config-client.c
+++ b/tools/mesh-gatt/config-client.c
@@ -100,7 +100,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 	if (primary != src)
 		return false;
 
-	switch (opcode & ~OP_UNRELIABLE) {
+	switch (opcode) {
 	default:
 		return false;
 
diff --git a/tools/mesh-gatt/config-server.c b/tools/mesh-gatt/config-server.c
index 8fc6edcc0..9e9b93959 100644
--- a/tools/mesh-gatt/config-server.c
+++ b/tools/mesh-gatt/config-server.c
@@ -73,7 +73,7 @@ static bool server_msg_recvd(uint16_t src, uint8_t *data,
 
 	n = 0;
 
-	switch (opcode & ~OP_UNRELIABLE) {
+	switch (opcode) {
 	default:
 		return false;
 
diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index 92c9a3105..be519c969 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -123,7 +123,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
 								len, opcode);
 	print_byte_array("\t",data, len);
 
-	switch (opcode & ~OP_UNRELIABLE) {
+	switch (opcode) {
 	default:
 		return false;
 
diff --git a/tools/mesh-gatt/util.h b/tools/mesh-gatt/util.h
index c3facfa73..dba2c480b 100644
--- a/tools/mesh-gatt/util.h
+++ b/tools/mesh-gatt/util.h
@@ -25,8 +25,6 @@
 
 struct mesh_publication;
 
-#define OP_UNRELIABLE			0x0100
-
 void set_menu_prompt(const char *name, const char *id);
 void print_byte_array(const char *prefix, const void *ptr, int len);
 bool str2hex(const char *str, uint16_t in_len, uint8_t *out_buf,
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 218e82c50..e36c8dca5 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -416,7 +416,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 
 	bt_shell_printf("Received %s (len %u)\n", opcode_str(opcode), len);
 
-	req = get_req_by_rsp(src, (opcode & ~OP_UNRELIABLE));
+	req = get_req_by_rsp(src, opcode);
 	if (req) {
 		cmd = req->cmd;
 		free_request(req);
@@ -424,7 +424,7 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	} else
 		cmd = NULL;
 
-	switch (opcode & ~OP_UNRELIABLE) {
+	switch (opcode) {
 	default:
 		return false;
 
diff --git a/tools/mesh/model.h b/tools/mesh/model.h
index 449fe19b2..35bb80efc 100644
--- a/tools/mesh/model.h
+++ b/tools/mesh/model.h
@@ -18,7 +18,6 @@
  *
  */
 
-#define OP_UNRELIABLE	0x0100
 #define VENDOR_ID_INVALID	0xFFFF
 
 typedef bool (*model_send_msg_func_t) (void *user_data, uint16_t dst,
-- 
2.26.2

