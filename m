Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1ACC10F14
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 06:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157C1214DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 06:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfDRGbN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:31:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:57068 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388011AbfDRGbN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 02:31:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 23:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,364,1549958400"; 
   d="scan'208";a="316936024"
Received: from ingas-nuc1.sea.intel.com ([10.252.198.132])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2019 23:31:12 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] test: Enable test-mesh to send raw vendor commands
Date:   Wed, 17 Apr 2019 23:31:10 -0700
Message-Id: <20190418063110.22237-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190418063110.22237-1-inga.stotland@intel.com>
References: <20190418063110.22237-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a sample vendor model to the first element of the
mesh node. A new menu entry allows to generate and send a raw
vendor command.
---
 test/test-mesh | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/test/test-mesh b/test/test-mesh
index 02f52a269..7201669a8 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -73,6 +73,16 @@
 #           Set AppKey index to indicate which application key to use
 #           to encode outgoing messages: up to 3 hex digits
 #
+#     vendor-send
+#           Allows to send an arbitrary endor message.
+#           The destination is set based on previously executed "dest"
+#           command (if not set, the outbound message will fail).
+#           User is prompted to enter hex bytearray payload.
+#           The message is originated from the vendor model registered
+#           on element 0. For the command to succeed, the AppKey index
+#           that is set by executing "app-key" must correspond to the
+#           application key to which the Sample Vendor model is bound.
+#
 #     client-menu
 #           Enter On/Off client submenu.
 #
@@ -155,6 +165,7 @@ INPUT_NONE = 0
 INPUT_TOKEN = 1
 INPUT_DEST_ADDRESS = 2
 INPUT_APP_KEY_INDEX = 3
+INPUT_MESSAGE_PAYLOAD = 4
 
 menus = []
 current_menu = None
@@ -542,7 +553,6 @@ class OnOffServer(Model):
 
 	def process_message(self, source, key, data):
 		datalen = len(data)
-		print('OnOff Server process message len: ', datalen)
 
 		if datalen != 2 and datalen != 3:
 			# The opcode is not recognized by this model
@@ -737,6 +747,8 @@ class MainMenu(Menu):
 						self.__cmd_set_dest),
 			'app-index': MenuItem(' - set AppKey index',
 						self.__cmd_set_app_idx),
+			'vendor-send': MenuItem(' - send raw vendor message',
+						self.__cmd_vendor_msg),
 			'client-menu': MenuItem(' - On/Off client menu',
 						self.__cmd_client_menu),
 			'quit': MenuItem(' - exit the test', app_exit)
@@ -772,6 +784,12 @@ class MainMenu(Menu):
 		user_input = INPUT_APP_KEY_INDEX;
 		print(set_cyan('Enter app key index (up to 3 digit hex):'))
 
+	def __cmd_vendor_msg(self):
+		global user_input
+
+		user_input = INPUT_MESSAGE_PAYLOAD;
+		print(set_cyan('Enter message payload (hex):'))
+
 	def __cmd_join(self):
 		if agent == None:
 			print(set_error('Provisioning agent not found'))
@@ -806,6 +824,17 @@ class MainMenu(Menu):
 		mesh_net.Leave(token, reply_handler=remove_node_cb,
 					error_handler=generic_error_cb)
 
+	def __send_vendor_msg(self, str_value):
+		try:
+			msg_data = bytearray.fromhex(str_value)
+		except ValueError:
+			raise_error('Not a valid hexadecimal input')
+			return
+
+		print(set_yellow('Send data: ' + set_green(str_value)))
+		app.elements[0].models[1].send_message(dst_addr, app_idx,
+							msg_data)
+
 	def process_cmd(self, str_value):
 		global user_input
 		global dst_addr
@@ -825,6 +854,8 @@ class MainMenu(Menu):
 				app_idx = res
 				print(set_yellow("Application index: ") +
 					set_green(format(app_idx, '03x')))
+		elif  user_input == INPUT_MESSAGE_PAYLOAD:
+			self.__send_vendor_msg(str_value)
 
 		if user_input != INPUT_NONE:
 			user_input = INPUT_NONE
-- 
2.17.2

