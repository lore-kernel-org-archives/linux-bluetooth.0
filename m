Return-Path: <SRS0=4NR/=SL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B5CC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 19:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325CC206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Apr 2019 19:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDITi2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:38:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:57059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfDITi2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Apr 2019 15:38:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 12:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="138898005"
Received: from ingas-nuc1.sea.intel.com ([10.252.136.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2019 12:37:25 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] test: Enable test-mesh to send raw vendor commands
Date:   Tue,  9 Apr 2019 12:37:23 -0700
Message-Id: <20190409193723.1536-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a sample vendor model to the first element of the
mesh node. A new menu entry allows to generate and send a raw
vendor command.
Also, switch from numeric to a string-based menu.
---
 test/test-mesh | 421 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 279 insertions(+), 142 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index fd02207bc..5627a874b 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -18,23 +18,25 @@
 #
 #      The test imitates a device with 2 elements:
 #            element 0: OnOff Server model
+#                       Sample Vendor model
 #            element 1: OnOff Client model
 #
 # The main menu:
-#       1 - set node ID (token)
-#       2 - join mesh network
-#       3 - attach mesh node
-#       4 - remove node
-#       5 - client menu
-#       6 - exit
+#       token
+#       join
+#       attach
+#       remove
+#       client-menu
+#       send-raw
+#       exit
 #
 # The main menu options explained:
-#     1 - set token
+#     token
 #            Set the unique node token.
 #            The token can be set from command line arguments as
 #            well.
 #
-#     2 - join
+#     join
 #            Request provisioning of a device to become a node
 #            on a mesh network. The test generates device UUID
 #            which is displayed and will need to be provided to
@@ -49,7 +51,7 @@
 #            'token' is returned to the application and is used
 #            for the runtime of the test.
 #
-#     3 - attach
+#     attach
 #            Attach the application to bluetoothd-daemon as a node.
 #            For the call to be successful, the valid node token must
 #            be already set, either from command arguments or by
@@ -57,16 +59,26 @@
 #            successfully executing "join" operation in the same test
 #            run.
 #
-#     4 - remove
+#     remove
 #           Permanently removes any node configuration from daemon
 #           and persistent storage. After this operation, the node
 #           is permanently forgotten by the daemon and the associated
 #           node token is no longer valid.
 #
-#     5 - client menu
+#     send-raw
+#           Allows to send arbitrary message to a specified destination.
+#           User is propted to enter 4-digit hex destination address,
+#           app key index, bytearray payload.
+#           The message is originated from the vendor model registered
+#           on element 0. For the command to succeed, the app key index
+#           must correspond to an application key to which the Sample
+#           Vendor model is bound.
+#
+#     client-menu
 #           Enter On/Off client submenu.
 #
-#     6 - exit
+#     quit
+#           Exits the test.
 #
 ###################################################################
 import sys
@@ -74,6 +86,7 @@ import struct
 import fcntl
 import os
 import numpy
+import re
 import random
 import dbus
 import dbus.service
@@ -122,6 +135,10 @@ APP_VERSION_ID = 0x0001
 
 VENDOR_ID_NONE = 0xffff
 
+MAIN_MENU = 0
+ON_OFF_CLIENT_MENU = 1
+VENDOR_COMMAND_MENU = 2
+
 app = None
 bus = None
 mainloop = None
@@ -131,13 +148,29 @@ mesh_net = None
 menu_level = 0
 dst_addr = 0x0000
 app_idx = 0
+vendor_dst_addr = 0x0000
+vendor_app_idx = 0
 
 # Node token housekeeping
 token = None
 have_token = False
+attached = False
 
 user_input = 0
+input_error = False
+
+def raise_error(str):
+	global input_error
+
+	input_error = True
+	print(set_error(str))
 
+def clear_error():
+	global input_error
+	input_error = False
+
+def is_error():
+	return input_error
 
 def app_exit():
 	global mainloop
@@ -177,6 +210,11 @@ def join_cb():
 def join_error_cb(reason):
 	print('Join procedure failed: ', reason)
 
+def remove_node_cb():
+	global attached
+	print(set_yellow('Node removed'))
+	attached = False
+
 def unwrap(item):
 	if isinstance(item, dbus.Boolean):
 		return bool(item)
@@ -197,7 +235,11 @@ def unwrap(item):
 	return item
 
 def attach_app_cb(node_path, dict_array):
-	print('Mesh application registered ', node_path)
+	global attached
+
+	attached = True
+
+	print(set_yellow('Mesh app registered: ') + set_green(node_path))
 
 	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
 
@@ -223,17 +265,6 @@ def interfaces_removed_cb(object_path, interfaces):
 		print('Service was removed')
 		app_exit()
 
-def send_response(path, dest, key, data):
-		node.Send(path, dest, key, data, reply_handler=generic_reply_cb,
-						error_handler=generic_error_cb)
-
-def send_publication(path, model_id, data):
-		print('Send publication ', end='')
-		print(data)
-		node.Publish(path, model_id, data,
-						reply_handler=generic_reply_cb,
-						error_handler=generic_error_cb)
-
 def print_state(state):
 	print('State is ', end='')
 	if state == 0:
@@ -316,7 +347,8 @@ class Application(dbus.service.Object):
 		global token
 		global have_token
 
-		print('JoinComplete with token ' + set_green(hex(value)))
+		print(set_yellow('Joined mesh network with token ') +
+				set_green(format(value, '16x')))
 
 		token = value
 		have_token = True
@@ -348,14 +380,28 @@ class Element(dbus.service.Object):
 				ids.append(id)
 		return ids
 
+	def _get_v_models(self):
+		ids = []
+		for model in self.models:
+			id = model.get_id()
+			v = model.get_vendor()
+			if v != VENDOR_ID_NONE:
+				vendor_id = (v, id)
+				ids.append(vendor_id)
+		return ids
+
 	def get_properties(self):
-		return {
-			MESH_ELEMENT_IFACE: {
-				'Index': dbus.Byte(self.index),
-				'Models': dbus.Array(
-					self._get_sig_models(), signature='q')
-			}
-		}
+		vendor_models = self._get_v_models()
+		sig_models = self._get_sig_models()
+
+		props = {'Index' : dbus.Byte(self.index)}
+		if len(sig_models) != 0:
+			props['Models'] = dbus.Array(sig_models, signature='q')
+		if len(vendor_models) != 0:
+			props['VendorModels'] = dbus.Array(vendor_models,
+							signature='(qq)')
+		#print(props)
+		return { MESH_ELEMENT_IFACE: props }
 
 	def add_model(self, model):
 		model.set_path(self.path)
@@ -381,8 +427,8 @@ class Element(dbus.service.Object):
 					in_signature="qa{sv}", out_signature="")
 
 	def UpdateModelConfiguration(self, model_id, config):
-		print('UpdateModelConfig ', end='')
-		print(hex(model_id))
+		print(('Update Model Config '), end='')
+		print(format(model_id, '04x'))
 		for model in self.models:
 			if model_id == model.get_id():
 				model.set_config(config)
@@ -420,6 +466,18 @@ class Model():
 	def set_publication(self, period):
 		self.pub_period = period
 
+	def send_publication(self, data):
+		print('Send publication ', end='')
+		print(data)
+		node.Publish(self.path, self.model_id, data,
+						reply_handler=generic_reply_cb,
+						error_handler=generic_error_cb)
+
+	def send_message(self, dest, key, data):
+		node.Send(self.path, dest, key, data,
+						reply_handler=generic_reply_cb,
+						error_handler=generic_error_cb)
+
 	def set_config(self, config):
 		if 'Bindings' in config:
 			self.bindings = config.get('Bindings')
@@ -432,13 +490,15 @@ class Model():
 			print(' ms')
 
 	def print_bindings(self):
-		print(set_cyan('Model'), set_cyan('%04x' % self.model_id),
-			set_cyan('is bound to application key(s): '), end = '')
+		print(set_cyan('Model'), set_cyan('%03x' % self.model_id),
+						set_cyan('is bound to: '))
 
 		if len(self.bindings) == 0:
 			print(set_cyan('** None **'))
+			return
+
 		for b in self.bindings:
-			print(set_cyan('%04x' % b), set_cyan(', '))
+			print(set_green('%03x' % b) + ' ')
 
 ########################
 # On Off Server Model
@@ -479,7 +539,7 @@ class OnOffServer(Model):
 			print_state(self.state)
 
 		rsp_data = struct.pack('<HB', 0x8204, self.state)
-		send_response(self.path, source, key, rsp_data)
+		self.send_message(source, key, rsp_data)
 
 	def set_publication(self, period):
 
@@ -498,7 +558,7 @@ class OnOffServer(Model):
 	def publish(self):
 		print('Publish')
 		data = struct.pack('<HB', 0x8204, self.state)
-		send_publication(self.path, self.model_id, data)
+		self.send_publication(data)
 
 ########################
 # On Off Client Model
@@ -512,25 +572,20 @@ class OnOffClient(Model):
 				 0x8204 } # status
 		print('OnOff Client')
 
-	def _reply_cb(state):
-		print('State ', end='');
-		print(state)
-
-	def _send_message(self, dest, key, data, reply_cb):
-		print('OnOffClient send data')
-		node.Send(self.path, dest, key, data, reply_handler=reply_cb,
-				  error_handler=generic_error_cb)
+	def _send_message(self, dest, key, data):
+		print('OnOffClient send command')
+		self.send_message(dest, key, data)
 
 	def get_state(self, dest, key):
 		opcode = 0x8201
 		data = struct.pack('<H', opcode)
-		self._send_message(dest, key, data, self._reply_cb)
+		self._send_message(dest, key, data)
 
 	def set_state(self, dest, key, state):
 		opcode = 0x8202
-		print('State:', state)
+		print('Set state:', state)
 		data = struct.pack('<HB', opcode, state)
-		self._send_message(dest, key, data, self._reply_cb)
+		self._send_message(dest, key, data)
 
 	def process_message(self, source, key, data):
 		print('OnOffClient process message len = ', end = '')
@@ -541,7 +596,7 @@ class OnOffClient(Model):
 			# The opcode is not recognized by this model
 			return
 
-		opcode, state=struct.unpack('<HB',bytes(data))
+		opcode, state = struct.unpack('<HB',bytes(data))
 
 		if opcode != 0x8204 :
 			# The opcode is not recognized by this model
@@ -556,6 +611,14 @@ class OnOffClient(Model):
 		print(set_green(state_str), set_yellow('from'),
 						set_green('%04x' % source))
 
+########################
+# Sample Vendor Model
+########################
+class SampleVendor(Model):
+	def __init__(self, model_id):
+		Model.__init__(self, model_id)
+		self.vendor = 0x05F1 # Linux Foundation Company ID
+
 ########################
 # Menu functions
 ########################
@@ -579,122 +642,131 @@ class MenuHandler(object):
 		return True
 
 def process_input(input_str):
+	str = input_str.strip()
+
+	# Allow entering empty lines for better output visibility
+	if len(str) == 0:
+		return
+
 	if menu_level == 0:
-		process_main_menu(input_str)
+		process_main_menu(str)
 	elif menu_level == 1:
-		process_client_menu(input_str)
+		process_client_menu(str)
+	elif menu_level == 2:
+		create_vendor_command(str)
 	else:
 		print(set_error('BUG: bad menu level'))
 
 def switch_menu(level):
 	global menu_level
 
-	if level > 1:
-		return
-
-	if level == 0:
+	if level == MAIN_MENU:
 		main_menu()
-	elif level == 1:
+	elif level == ON_OFF_CLIENT_MENU:
 		client_menu()
+	elif level == VENDOR_COMMAND_MENU:
+		start_vendor_command()
 
 	menu_level = level
 
 ########################
 # Main menu functions
 ########################
-def process_main_menu(input_str):
+def process_main_menu(str):
 	global token
 	global user_input
 	global have_token
-
-	str = input_str.strip()
+	global attached
+	menu_items = ["token", "join", "attach", "remove",
+			"send-raw",  "client-menu", "quit"]
 
 	if user_input == 1:
-		res = set_token(str)
+		set_token(str)
 		user_input = 0
 
-		if res == False:
+		if is_error():
 			main_menu()
-
+			clear_error()
 		return
 
-	# Allow entering empty lines for better output visibility
-	if len(str) == 0:
-		return
+	opt = -1;
 
-	if str.isdigit() == False:
+	for m in menu_items:
+		if (bool(re.match(str, m, re.I))):
+			opt = menu_items.index(m)
+			break
+
+	if opt == -1:
+		print(set_error('Unknown menu option: '), str)
 		main_menu()
 		return
 
-	opt = int(str)
+	if opt == 6:
+		app_exit()
+		return
 
-	if opt > 6:
-		print(set_error('Unknown menu option: '), opt)
-		main_menu()
-	elif opt == 1:
+	if opt > 2:
+		if attached == False:
+			print(set_error('Node not attached'))
+			main_menu()
+			return
+
+	if opt == 0:
 		if have_token:
 			print('Token already set')
 			return
 
 		user_input = 1;
 		print(set_cyan('Enter 16-digit hex node ID:'))
-	elif opt == 2:
+	elif opt == 1:
 		if agent == None:
 			print(set_error('Provisioning agent not found'))
 			return
 
 		join_mesh()
-	elif opt == 3:
+	elif opt == 2:
 		if have_token == False:
 			print(set_error('Token is not set'))
 			main_menu()
 			return
 
 		attach(token)
-	elif opt == 4:
-		if have_token == False:
-			print(set_error('Token is not set'))
-			main_menu()
-			return
-
+	elif opt == 3:
 		print('Remove mesh node')
-		mesh_net.Leave(token, reply_handler=generic_reply_cb,
+		mesh_net.Leave(token, reply_handler=remove_node_cb,
 					error_handler=generic_error_cb)
-		have_token = False
+	elif opt == 4:
+		switch_menu(VENDOR_COMMAND_MENU)
 	elif opt == 5:
-		switch_menu(1)
-	elif opt == 6:
-		app_exit()
-
+		switch_menu(ON_OFF_CLIENT_MENU)
 
 def main_menu():
 	print(set_cyan('*** MAIN MENU ***'))
-	print(set_cyan('1 - set node ID (token)'))
-	print(set_cyan('2 - join mesh network'))
-	print(set_cyan('3 - attach mesh node'))
-	print(set_cyan('4 - remove node'))
-	print(set_cyan('5 - client menu'))
-	print(set_cyan('6 - exit'))
+	print(set_green('token'), '\t\t', set_cyan('- set node ID (token)'))
+	print(set_green('join'), '\t\t', set_cyan('- join mesh network'))
+	print(set_green('attach'), '\t\t', set_cyan('- attach mesh node'))
+	print(set_green('remove'), '\t\t', set_cyan('- delete node'))
+	print(set_green('send-raw'), '\t', set_cyan('- send raw (vendor) data'))
+	print(set_green('client-menu'), '\t', set_cyan('- On/Off client menu'))
+	print(set_green('quit'), '\t\t', set_cyan('- exit the test'))
 
 def set_token(str):
 	global token
 	global have_token
 
 	if len(str) != 16:
-		print(set_error('Expected 16 digits'))
-		return False
+		raise_error('Expected 16 digits')
+		return
 
 	try:
 		input_number = int(str, 16)
 	except ValueError:
-		print(set_error('Not a valid hexadecimal number'))
-		return False
+		raise_error('Not a valid hexadecimal number')
+		return
 
 	token = numpy.uint64(input_number)
 	have_token = True
 
-	return True
-
 def join_mesh():
 	uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
 
@@ -703,7 +775,7 @@ def join_mesh():
 
 	random.shuffle(uuid)
 	uuid_str = array_to_string(uuid)
-	print('Joining with UUID ' + set_green(uuid_str))
+	print(set_yellow('Joining with UUID ') + set_green(uuid_str))
 
 	mesh_net.Join(app.get_path(), uuid,
 			reply_handler=join_cb,
@@ -712,88 +784,149 @@ def join_mesh():
 ##############################
 # On/Off Client menu functions
 ##############################
-def process_client_menu(input_str):
+def process_client_menu(str):
 	global user_input
 	global dst_addr
 	global app_idx
-
-	res = -1
-	str = input_str.strip()
+	menu_items = ["dest", "app-key", "get-state", "off",
+			"on",  "back", "quit"]
 
 	if user_input == 1:
-		res = set_value(str)
-		if res != -1:
+		res = set_value(str, 4, 4)
+		if is_error() != True:
 			dst_addr = res
+			print(set_yellow("Destination address: ") +
+					set_green(format(dst_addr, '04x')))
 	elif user_input == 2:
-		res = set_value(str)
-		if res != -1:
+		res = set_value(str, 1, 3)
+		if is_error() != True:
 			app_idx = res
-
+			print(set_yellow("Application index: ") +
+					set_green(format(app_idx, '03x')))
 	if user_input != 0:
 		user_input = 0
-		if res == -1:
+		if is_error() == True:
+			clear_error()
 			client_menu()
 		return
 
-	# Allow entering empty lines for better output visibility
-	if len(str) == 0:
-		return
+	opt = -1;
 
-	if str.isdigit() == False:
-		client_menu()
-		return
+	for m in menu_items:
+		if (bool(re.match(str, m, re.I))):
+			opt = menu_items.index(m)
+			break
 
-	opt = int(str)
-
-	if opt > 7:
-		print(set_error('Unknown menu option: '), opt)
+	if opt == -1:
+		print(set_error('Unknown menu option: '), str)
 		client_menu()
 		return
 
-	if opt >= 3 and opt <= 5 and dst_addr == 0x0000:
+	if opt >= 2 and opt <= 4 and dst_addr == 0x0000:
 		print(set_error('Destination address not set!'))
 		return
 
-	if opt == 1:
+	if opt == 0:
 		user_input = 1;
 		print(set_cyan('Enter 4-digit hex destination address:'))
-	elif opt == 2:
+	elif opt == 1:
 		user_input = 2;
 		app.elements[1].models[0].print_bindings()
-		print(set_cyan('Choose application key index:'))
-	elif opt == 3:
+		print(set_cyan('Enter app key index (up to 3 digit hex):'))
+	elif opt == 2:
 		app.elements[1].models[0].get_state(dst_addr, app_idx)
-	elif opt == 4 or opt == 5:
-		app.elements[1].models[0].set_state(dst_addr, app_idx, opt - 4)
+	elif opt == 3 or opt == 4:
+		app.elements[1].models[0].set_state(dst_addr, app_idx, opt - 3)
+	elif opt == 5:
+		switch_menu(MAIN_MENU)
 	elif opt == 6:
-		switch_menu(0)
-	elif opt == 7:
 		app_exit()
 
 def client_menu():
 	print(set_cyan('*** ON/OFF CLIENT MENU ***'))
-	print(set_cyan('1 - set destination address'))
-	print(set_cyan('2 - set application key index'))
-	print(set_cyan('3 - get state'))
-	print(set_cyan('4 - set state OFF'))
-	print(set_cyan('5 - set state ON'))
-	print(set_cyan('6 - back to main menu'))
-	print(set_cyan('7 - exit'))
-
-def set_value(str):
-
-	if len(str) != 4:
-		print(set_error('Expected 4 digits'))
+	print(set_green('dest'), '\t\t', set_cyan('- set destination address'))
+	print(set_green('app-key'), '\t', set_cyan('- set app key index'))
+	print(set_green('get-state'), '\t', set_cyan('- get state'))
+	print(set_green('off'), '\t\t', set_cyan('- set state OFF'))
+	print(set_green('on'), '\t\t', set_cyan('- set state ON'))
+	print(set_green('back'), '\t\t', set_cyan('- back to main menu'))
+	print(set_green('quit'))
+
+def set_value(str, min, max):
+
+	if len(str) > max or len(str) < min:
+		raise_error('Bad input length %d' % len(str))
 		return -1
 
 	try:
 		value = int(str, 16)
 	except ValueError:
-		print(set_error('Not a valid hexadecimal number'))
+		raise_error('Not a valid hexadecimal number')
 		return -1
 
 	return value
 
+########################
+# Vendor command
+########################
+def start_vendor_command():
+	global user_input
+
+	user_input = 1
+	prompt_vendor_command(user_input)
+
+def prompt_vendor_command(input):
+	if input == 1:
+		print(set_cyan('Enter destination address (4 hex digits):'))
+	elif input == 2:
+		print(set_cyan('Enter app key index (1-3 hex digits):'))
+	elif input == 3:
+		print(set_cyan('Enter data payload (hex):'))
+
+def create_vendor_command(str):
+	global user_input
+	global vendor_dst_addr
+	global vendor_app_idx
+
+	if user_input == 1:
+		res = set_value(str, 4, 4)
+		if is_error() != True:
+			vendor_dst_addr = res
+			user_input = 2
+			print(set_yellow("Vendor Destination Address: ") +
+						set_green(format(res, '04x')))
+	elif user_input == 2:
+		res = set_value(str, 1, 3)
+		if is_error() != True:
+			vendor_app_idx = res
+			user_input = 3
+			print(set_yellow("Vendor AppKey index: ") +
+						set_green(format(res, '03x')))
+	elif user_input == 3:
+			finish_vendor_command(vendor_dst_addr, vendor_app_idx,
+									str)
+			user_input = 0
+
+	if is_error() == True:
+		clear_error()
+		user_input = 0
+
+	if user_input == 0:
+		switch_menu(MAIN_MENU)
+		return
+
+	prompt_vendor_command(user_input)
+
+def finish_vendor_command(dst, aidx, str):
+	try:
+		user_data = bytearray.fromhex(str)
+	except ValueError:
+		raise_error('Not a valid hexadecimal input')
+		return
+
+	print(set_yellow('Send payload: ' + set_green(str)))
+	app.elements[0].models[1].send_message(dst, aidx, user_data)
+
 ########################
 # Main entry
 ########################
@@ -827,8 +960,12 @@ def main():
 	print(set_yellow('Register OnOff Server model on element 0'))
 	first_ele.add_model(OnOffServer(0x1000))
 
+	print(set_yellow('Register Vendor model on element 0'))
+	first_ele.add_model(SampleVendor(0x0001))
+
 	print(set_yellow('Register OnOff Client model on element 1'))
 	second_ele.add_model(OnOffClient(0x1001))
+
 	app.add_element(first_ele)
 	app.add_element(second_ele)
 
-- 
2.17.2

