Return-Path: <SRS0=kgXe=64=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA2C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 02:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3674B205CB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 May 2020 02:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENCUf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 May 2020 22:20:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:48991 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgENCUf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 May 2020 22:20:35 -0400
IronPort-SDR: HwTOWrn7cgsOqqfucQWZs7iUIrUCh0YDFQDyMUQrRxvzwtBbxykJEGyCIAZ26G5oere2GS7z7s
 jtSq6CiyiWxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 19:20:34 -0700
IronPort-SDR: bIu1ZdGSMBGmS6KzZWxRHxzYkfGFw1uZGKzGNsbduzoWATTqQ6xs4PGApN4l0kU0HHtS6QuLA8
 Krs4l35RFbEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="253359788"
Received: from swu2-mobl2.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.65.142])
  by fmsmga008.fm.intel.com with ESMTP; 13 May 2020 19:20:34 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] test: Fix payload and model opcode packing in test-mesh
Date:   Wed, 13 May 2020 19:20:33 -0700
Message-Id: <20200514022033.52864-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use correct packing of multi-byte values in message payload bytearray.
For example, a 2-byte opcode 0x8204 is packed as 0x82 0x04, i.e. in
natural order.

Add transaction ID parameter to "set" commands of generic On/Off
model. Server will ignore the identical commands with the same
transaction ID, source and destination during a timeout period
of 6 seconds.
---
 test/test-mesh | 94 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 66055e2de..38f0c0a74 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -146,6 +146,8 @@ APP_VERSION_ID = 0x0001
 
 VENDOR_ID_NONE = 0xffff
 
+TRANSACTION_TIMEOUT = 6
+
 app = None
 bus = None
 mainloop = None
@@ -330,7 +332,7 @@ def print_state(state):
 		print('ON')
 	else:
 		print('UNKNOWN')
-class PubTimer():
+class ModTimer():
 	def __init__(self):
 		self.seconds = None
 		self.func = None
@@ -473,18 +475,18 @@ class Element(dbus.service.Object):
 
 	@dbus.service.method(MESH_ELEMENT_IFACE,
 					in_signature="qqvay", out_signature="")
-	def MessageReceived(self, source, key, destination, data):
+	def MessageReceived(self, source, key, dest, data):
 		print(('Message Received on Element %02x') % self.index, end='')
 		print(', src=', format(source, '04x'), end='')
 
-		if isinstance(destination, int):
-			print(', dst=%04x' % destination)
-		elif isinstance(destination, dbus.Array):
-			dst_str = array_to_string(destination)
+		if isinstance(dest, int):
+			print(', dst=%04x' % dest)
+		elif isinstance(dest, dbus.Array):
+			dst_str = array_to_string(dest)
 			print(', dst=' + dst_str)
 
 		for model in self.models:
-			model.process_message(source, key, data)
+			model.process_message(source, dest, key, data)
 
 	@dbus.service.method(MESH_ELEMENT_IFACE,
 					in_signature="qa{sv}", out_signature="")
@@ -528,7 +530,7 @@ class Model():
 	def get_vendor(self):
 		return self.vendor
 
-	def process_message(self, source, key, data):
+	def process_message(self, source, dest, key, data):
 		return
 
 	def set_publication(self, period):
@@ -576,6 +578,9 @@ class Model():
 class OnOffServer(Model):
 	def __init__(self, model_id):
 		Model.__init__(self, model_id)
+		self.tid = None
+		self.last_src = 0x0000
+		self.last_dst = 0x0000
 		self.cmd_ops = { 0x8201,  # get
 				 0x8202,  # set
 				 0x8203,  # set unacknowledged
@@ -584,48 +589,74 @@ class OnOffServer(Model):
 		print("OnOff Server ")
 		self.state = 0
 		print_state(self.state)
-		self.timer = PubTimer()
+		self.pub_timer = ModTimer()
+		self.t_timer = ModTimer()
 
-	def process_message(self, source, key, data):
+	def process_message(self, source, dest, key, data):
 		datalen = len(data)
 
-		if datalen != 2 and datalen != 3:
+		if datalen != 2 and datalen != 4:
 			# The opcode is not recognized by this model
 			return
 
 		if datalen == 2:
-			op_tuple=struct.unpack('<H',bytes(data))
+			op_tuple=struct.unpack('>H',bytes(data))
 			opcode = op_tuple[0]
+
 			if opcode != 0x8201:
 				# The opcode is not recognized by this model
 				return
 			print('Get state')
-		elif datalen == 3:
-			opcode,self.state=struct.unpack('<HB',bytes(data))
+		elif datalen == 4:
+			opcode,self.state, tid = struct.unpack('>HBB',
+							       bytes(data))
+
 			if opcode != 0x8202 and opcode != 0x8203:
 				# The opcode is not recognized by this model
 				return
 			print_state(self.state)
 
-		rsp_data = struct.pack('<HB', 0x8204, self.state)
+			if (self.tid != None and self.tid == tid and
+						self.last_src == source and
+						self.last_dst == dest):
+				# Ignore duplicate transaction
+				return
+
+			self.t_timer.cancel()
+			self.tid = tid
+			self.last_src = source
+			self.last_dst = dest
+			self.t_timer.start(TRANSACTION_TIMEOUT, self.t_track)
+
+			# Unacknowledged "set"
+			if opcode == 0x8203:
+				return
+
+		rsp_data = struct.pack('>HB', 0x8204, self.state)
 		self.send_message(source, key, rsp_data)
 
+	def t_track(self):
+			self.t_timer.cancel()
+			self.tid = None
+			self.last_src = 0x0000
+			self.last_dst = 0x0000
+
 	def set_publication(self, period):
 
 		self.pub_period = period
 		if period == 0:
-			self.timer.cancel()
+			self.pub_timer.cancel()
 			return
 
 		# We do not handle ms in this example
 		if period < 1000:
 			return
 
-		self.timer.start(period/1000, self.publish)
+		self.pub_timer.start(period/1000, self.publish)
 
 	def publish(self):
 		print('Publish')
-		data = struct.pack('<HB', 0x8204, self.state)
+		data = struct.pack('>HB', 0x8204, self.state)
 		self.send_publication(data)
 
 ########################
@@ -634,6 +665,8 @@ class OnOffServer(Model):
 class OnOffClient(Model):
 	def __init__(self, model_id):
 		Model.__init__(self, model_id)
+		self.tid = 0
+		self.data = None
 		self.cmd_ops = { 0x8201,  # get
 				 0x8202,  # set
 				 0x8203,  # set unacknowledged
@@ -646,16 +679,23 @@ class OnOffClient(Model):
 
 	def get_state(self, dest, key):
 		opcode = 0x8201
-		data = struct.pack('<H', opcode)
-		self._send_message(dest, key, data)
+		self.data = struct.pack('>H', opcode)
+		self._send_message(dest, key, self.data)
 
 	def set_state(self, dest, key, state):
 		opcode = 0x8202
 		print('Set state:', state)
-		data = struct.pack('<HB', opcode, state)
-		self._send_message(dest, key, data)
+		self.data = struct.pack('>HBB', opcode, state, self.tid)
+		self.tid = (self.tid + 1) % 255
+		self._send_message(dest, key, self.data)
+
+	def repeat(self, dest, key):
+		if self.data != None:
+			self._send_message(dest, key, self.data)
+		else:
+			print('No previous command stored')
 
-	def process_message(self, source, key, data):
+	def process_message(self, source, dest, key, data):
 		print('OnOffClient process message len = ', end = '')
 		datalen = len(data)
 		print(datalen)
@@ -664,7 +704,7 @@ class OnOffClient(Model):
 			# The opcode is not recognized by this model
 			return
 
-		opcode, state = struct.unpack('<HB',bytes(data))
+		opcode, state = struct.unpack('>HB',bytes(data))
 
 		if opcode != 0x8204 :
 			# The opcode is not recognized by this model
@@ -919,12 +959,14 @@ class ClientMenu(Menu):
 						self.__cmd_set_state_off),
 			'on': MenuItem(' - set state ON',
 						self.__cmd_set_state_on),
+			'repeat': MenuItem(' - repeat last command',
+						self.__cmd_repeat_transaction),
 			'back': MenuItem(' - back to main menu',
 						self.__cmd_main_menu),
 			'quit': MenuItem(' - exit the test', app_exit)
 		}
 
-		Menu.__init__(self, 'On/Off Clien Menu', menu_items)
+		Menu.__init__(self, 'On/Off Client Menu', menu_items)
 
 	def __cmd_main_menu(self):
 		switch_menu(MAIN_MENU)
@@ -938,6 +980,8 @@ class ClientMenu(Menu):
 	def __cmd_set_state_on(self):
 		app.elements[1].models[0].set_state(dst_addr, app_idx, 1)
 
+	def __cmd_repeat_transaction(self):
+		app.elements[1].models[0].repeat(dst_addr, app_idx)
 
 def set_value(str_value, min, max):
 
-- 
2.26.2

