Return-Path: <SRS0=jb0q=TO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56179C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 20:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F12020881
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfENUPm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 May 2019 16:15:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:13417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfENUPm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 May 2019 16:15:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 13:15:42 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.251.7.218])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 13:15:42 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 1/3] mesh: Add "create" command to test app
Date:   Tue, 14 May 2019 13:15:23 -0700
Message-Id: <20190514201525.16067-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190514201525.16067-1-brian.gix@intel.com>
References: <20190514201525.16067-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Like "join" this command generates a UUID and calls CreateNetwork()
and displays the UUID and token.
---
 test/test-mesh | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 7201669a8..f1d2b4e39 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -23,6 +23,7 @@
 #
 # The main menu:
 #       token
+#       create
 #       join
 #       attach
 #       remove
@@ -37,6 +38,15 @@
 #            The token can be set from command line arguments as
 #            well.
 #
+#     create
+#            Creates a new mesh network, with it's first local
+#            node. The test generates device UUID to store the node
+#            as.
+#            In case of successful creation, the application
+#            automatically attaches as a node to the daemon. A node
+#            'token' is returned to the application and is used
+#            for the runtime of the test.
+#
 #     join
 #            Request provisioning of a device to become a node
 #            on a mesh network. The test generates device UUID
@@ -57,8 +67,8 @@
 #            For the call to be successful, the valid node token must
 #            be already set, either from command arguments or by
 #            executing "set token" operation or automatically after
-#            successfully executing "join" operation in the same test
-#            run.
+#            successfully executing "join" or "create" operation in
+#            the same test run.
 #
 #     remove
 #           Permanently removes any node configuration from daemon
@@ -241,6 +251,22 @@ def join_cb():
 def join_error_cb(reason):
 	print('Join procedure failed: ', reason)
 
+def create_cb(value):
+	global token
+	global have_token
+	global attach
+
+	print(set_yellow('Created mesh network with token ') +
+			set_green(format(value, '16x')))
+
+	token = value
+	have_token = True
+	if attached == False:
+		attach(token)
+
+def create_error_cb(reason):
+	print('Create procedure failed: ', reason)
+
 def remove_node_cb():
 	global attached
 	global have_token
@@ -737,6 +763,8 @@ class MainMenu(Menu):
 		menu_items = {
 			'token': MenuItem(' - set node ID (token)',
 						self.__cmd_set_token),
+			'create': MenuItem(' - create mesh network',
+						self.__cmd_create),
 			'join': MenuItem(' - join mesh network',
 						self.__cmd_join),
 			'attach': MenuItem(' - attach mesh node',
@@ -790,6 +818,20 @@ class MainMenu(Menu):
 		user_input = INPUT_MESSAGE_PAYLOAD;
 		print(set_cyan('Enter message payload (hex):'))
 
+	def __cmd_create(self):
+		if agent == None:
+			print(set_error('Provisioning agent not found'))
+			return
+
+		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
+		random.shuffle(uuid)
+		uuid_str = array_to_string(uuid)
+
+		print(set_yellow('Creating with UUID ') + set_green(uuid_str))
+		mesh_net.CreateNetwork(app.get_path(), uuid,
+			reply_handler=create_cb,
+			error_handler=create_error_cb)
+
 	def __cmd_join(self):
 		if agent == None:
 			print(set_error('Provisioning agent not found'))
-- 
2.14.5

