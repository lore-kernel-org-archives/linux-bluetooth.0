Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A27C10F0B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 06:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7492184B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 06:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfDRGbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:31:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:57068 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfDRGbM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 02:31:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 23:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,364,1549958400"; 
   d="scan'208";a="316936018"
Received: from ingas-nuc1.sea.intel.com ([10.252.198.132])
  by orsmga005.jf.intel.com with ESMTP; 17 Apr 2019 23:31:11 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] test: Drive test-mesh with a string-based menu
Date:   Wed, 17 Apr 2019 23:31:09 -0700
Message-Id: <20190418063110.22237-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Switch to  string interactive commands to drive testing
of bluetooth-meshd. Re-work the menu to allow global setting of
destination address and AppKey index for outbound mesh messages.
---
 test/test-mesh | 539 +++++++++++++++++++++++++++++--------------------
 1 file changed, 317 insertions(+), 222 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index fd02207bc..02f52a269 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -18,23 +18,26 @@
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
+#       dest
+#       app-index
+#       client-menu
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
@@ -49,7 +52,7 @@
 #            'token' is returned to the application and is used
 #            for the runtime of the test.
 #
-#     3 - attach
+#     attach
 #            Attach the application to bluetoothd-daemon as a node.
 #            For the call to be successful, the valid node token must
 #            be already set, either from command arguments or by
@@ -57,16 +60,24 @@
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
+#     dest
+#           Set destination address to send messages: 4 hex digits
+#
+#     app-index
+#           Set AppKey index to indicate which application key to use
+#           to encode outgoing messages: up to 3 hex digits
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
@@ -128,16 +139,41 @@ mainloop = None
 node = None
 mesh_net = None
 
-menu_level = 0
 dst_addr = 0x0000
 app_idx = 0
 
 # Node token housekeeping
 token = None
 have_token = False
+attached = False
+
+# Menu housekeeping
+MAIN_MENU = 0
+ON_OFF_CLIENT_MENU = 1
+
+INPUT_NONE = 0
+INPUT_TOKEN = 1
+INPUT_DEST_ADDRESS = 2
+INPUT_APP_KEY_INDEX = 3
+
+menus = []
+current_menu = None
 
 user_input = 0
+input_error = False
 
+def raise_error(str_value):
+	global input_error
+
+	input_error = True
+	print(set_error(str_value))
+
+def clear_error():
+	global input_error
+	input_error = False
+
+def is_error():
+	return input_error
 
 def app_exit():
 	global mainloop
@@ -149,11 +185,28 @@ def app_exit():
 				model.timer.cancel()
 	mainloop.quit()
 
+def set_token(str_value):
+	global token
+	global have_token
+
+	if len(str_value) != 16:
+		raise_error('Expected 16 digits')
+		return
+
+	try:
+		input_number = int(str_value, 16)
+	except ValueError:
+		raise_error('Not a valid hexadecimal number')
+		return
+
+	token = numpy.uint64(input_number)
+	have_token = True
+
 def array_to_string(b_array):
-	str = ""
+	str_value = ""
 	for b in b_array:
-		str += "%02x" % b
-	return str
+		str_value += "%02x" % b
+	return str_value
 
 def generic_error_cb(error):
 	print(set_error('D-Bus call failed: ') + str(error))
@@ -177,6 +230,14 @@ def join_cb():
 def join_error_cb(reason):
 	print('Join procedure failed: ', reason)
 
+def remove_node_cb():
+	global attached
+	global have_token
+
+	print(set_yellow('Node removed'))
+	attached = False
+	have_token = False
+
 def unwrap(item):
 	if isinstance(item, dbus.Boolean):
 		return bool(item)
@@ -197,7 +258,11 @@ def unwrap(item):
 	return item
 
 def attach_app_cb(node_path, dict_array):
-	print('Mesh application registered ', node_path)
+	global attached
+
+	attached = True
+
+	print(set_yellow('Mesh app registered: ') + set_green(node_path))
 
 	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
 
@@ -223,17 +288,6 @@ def interfaces_removed_cb(object_path, interfaces):
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
@@ -315,13 +369,15 @@ class Application(dbus.service.Object):
 	def JoinComplete(self, value):
 		global token
 		global have_token
+		global attach
 
-		print('JoinComplete with token ' + set_green(hex(value)))
+		print(set_yellow('Joined mesh network with token ') +
+				set_green(format(value, '16x')))
 
 		token = value
 		have_token = True
-
-		attach(token)
+		if attached == False:
+			attach(token)
 
 	@dbus.service.method(MESH_APPLICATION_IFACE,
 					in_signature="s", out_signature="")
@@ -348,14 +404,28 @@ class Element(dbus.service.Object):
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
@@ -381,8 +451,8 @@ class Element(dbus.service.Object):
 					in_signature="qa{sv}", out_signature="")
 
 	def UpdateModelConfiguration(self, model_id, config):
-		print('UpdateModelConfig ', end='')
-		print(hex(model_id))
+		print(('Update Model Config '), end='')
+		print(format(model_id, '04x'))
 		for model in self.models:
 			if model_id == model.get_id():
 				model.set_config(config)
@@ -420,6 +490,18 @@ class Model():
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
@@ -432,13 +514,15 @@ class Model():
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
@@ -479,7 +563,7 @@ class OnOffServer(Model):
 			print_state(self.state)
 
 		rsp_data = struct.pack('<HB', 0x8204, self.state)
-		send_response(self.path, source, key, rsp_data)
+		self.send_message(source, key, rsp_data)
 
 	def set_publication(self, period):
 
@@ -494,11 +578,10 @@ class OnOffServer(Model):
 
 		self.timer.start(period/1000, self.publish)
 
-
 	def publish(self):
 		print('Publish')
 		data = struct.pack('<HB', 0x8204, self.state)
-		send_publication(self.path, self.model_id, data)
+		self.send_publication(data)
 
 ########################
 # On Off Client Model
@@ -512,25 +595,20 @@ class OnOffClient(Model):
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
@@ -541,7 +619,7 @@ class OnOffClient(Model):
 			# The opcode is not recognized by this model
 			return
 
-		opcode, state=struct.unpack('<HB',bytes(data))
+		opcode, state = struct.unpack('<HB',bytes(data))
 
 		if opcode != 0x8204 :
 			# The opcode is not recognized by this model
@@ -556,9 +634,54 @@ class OnOffClient(Model):
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
+class MenuItem():
+	def __init__(self, desc, func):
+		self.desc = desc
+		self.func = func
+
+class Menu():
+	def __init__(self, title, menu):
+		self.title = title
+		self.menu = menu
+
+	def show(self):
+		print(set_cyan('*** ' + self.title.upper() + ' ***'))
+		for k, v in self.menu.items():
+			print(set_green(k), set_cyan(v.desc))
+
+	def process_cmd(self, str_value):
+		if is_error():
+			self.show()
+			clear_error()
+			return
+
+		cmds = []
+		for key in self.menu.keys():
+			if key.startswith(str_value):
+				cmds.append(key)
+
+		if len(cmds) == 0:
+			print(set_error('Unknown menu option: '), str_value)
+			self.show()
+			return
+		if len(cmds) > 1:
+			for cmd in cmds:
+			     print(set_cyan(cmd + '?'))
+			return
+
+		self.menu.get(cmds[0]).func()
+
 class MenuHandler(object):
 	def __init__(self, callback):
 		self.cb = callback
@@ -579,221 +702,184 @@ class MenuHandler(object):
 		return True
 
 def process_input(input_str):
-	if menu_level == 0:
-		process_main_menu(input_str)
-	elif menu_level == 1:
-		process_client_menu(input_str)
-	else:
-		print(set_error('BUG: bad menu level'))
+	str_value = input_str.strip()
+
+	# Allow entering empty lines for better output visibility
+	if len(str_value) == 0:
+		return
+
+	current_menu.process_cmd(str_value)
 
 def switch_menu(level):
-	global menu_level
+	global current_menu
 
-	if level > 1:
+	if level >= len(menus):
 		return
 
-	if level == 0:
-		main_menu()
-	elif level == 1:
-		client_menu()
-
-	menu_level = level
+	current_menu = menus[level]
+	current_menu.show()
 
 ########################
-# Main menu functions
+# Main menu class
 ########################
-def process_main_menu(input_str):
-	global token
-	global user_input
-	global have_token
+class MainMenu(Menu):
+	def __init__(self):
+		menu_items = {
+			'token': MenuItem(' - set node ID (token)',
+						self.__cmd_set_token),
+			'join': MenuItem(' - join mesh network',
+						self.__cmd_join),
+			'attach': MenuItem(' - attach mesh node',
+						self.__cmd_attach),
+			'remove': MenuItem(' - delete node',
+						self.__cmd_remove),
+			'dest': MenuItem(' - set destination address',
+						self.__cmd_set_dest),
+			'app-index': MenuItem(' - set AppKey index',
+						self.__cmd_set_app_idx),
+			'client-menu': MenuItem(' - On/Off client menu',
+						self.__cmd_client_menu),
+			'quit': MenuItem(' - exit the test', app_exit)
+		}
 
-	str = input_str.strip()
+		Menu.__init__(self, 'Main Menu', menu_items)
 
-	if user_input == 1:
-		res = set_token(str)
-		user_input = 0
+	def __cmd_client_menu(self):
+		if attached != True:
+			print(set_error('Disallowed: node is not attached'))
+			return
+		switch_menu(ON_OFF_CLIENT_MENU)
 
-		if res == False:
-			main_menu()
+	def __cmd_set_token(self):
+		global user_input
 
-		return
+		if have_token == True:
+			print('Token already set')
+			return
 
-	# Allow entering empty lines for better output visibility
-	if len(str) == 0:
-		return
+		user_input = INPUT_TOKEN
+		print(set_cyan('Enter 16-digit hex node ID:'))
 
-	if str.isdigit() == False:
-		main_menu()
-		return
+	def __cmd_set_dest(self):
+		global user_input
 
-	opt = int(str)
+		user_input = INPUT_DEST_ADDRESS
+		print(set_cyan('Enter 4-digit hex destination address:'))
 
-	if opt > 6:
-		print(set_error('Unknown menu option: '), opt)
-		main_menu()
-	elif opt == 1:
-		if have_token:
-			print('Token already set')
-			return
+	def __cmd_set_app_idx(self):
+		global user_input
 
-		user_input = 1;
-		print(set_cyan('Enter 16-digit hex node ID:'))
-	elif opt == 2:
+		user_input = INPUT_APP_KEY_INDEX;
+		print(set_cyan('Enter app key index (up to 3 digit hex):'))
+
+	def __cmd_join(self):
 		if agent == None:
 			print(set_error('Provisioning agent not found'))
 			return
 
-		join_mesh()
-	elif opt == 3:
+		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
+		random.shuffle(uuid)
+		uuid_str = array_to_string(uuid)
+		caps = ["out-numeric"]
+		oob = ["other"]
+
+		print(set_yellow('Joining with UUID ') + set_green(uuid_str))
+		mesh_net.Join(app.get_path(), uuid,
+			reply_handler=join_cb,
+			error_handler=join_error_cb)
+
+	def __cmd_attach(self):
 		if have_token == False:
 			print(set_error('Token is not set'))
-			main_menu()
+			self.show()
 			return
 
 		attach(token)
-	elif opt == 4:
+
+	def __cmd_remove(self):
 		if have_token == False:
 			print(set_error('Token is not set'))
-			main_menu()
+			self.show()
 			return
 
-		print('Remove mesh node')
-		mesh_net.Leave(token, reply_handler=generic_reply_cb,
+		print('Removing mesh node')
+		mesh_net.Leave(token, reply_handler=remove_node_cb,
 					error_handler=generic_error_cb)
-		have_token = False
-	elif opt == 5:
-		switch_menu(1)
-	elif opt == 6:
-		app_exit()
-
-
-def main_menu():
-	print(set_cyan('*** MAIN MENU ***'))
-	print(set_cyan('1 - set node ID (token)'))
-	print(set_cyan('2 - join mesh network'))
-	print(set_cyan('3 - attach mesh node'))
-	print(set_cyan('4 - remove node'))
-	print(set_cyan('5 - client menu'))
-	print(set_cyan('6 - exit'))
 
-def set_token(str):
-	global token
-	global have_token
-
-	if len(str) != 16:
-		print(set_error('Expected 16 digits'))
-		return False
-
-	try:
-		input_number = int(str, 16)
-	except ValueError:
-		print(set_error('Not a valid hexadecimal number'))
-		return False
-
-	token = numpy.uint64(input_number)
-	have_token = True
-
-	return True
-
-def join_mesh():
-	uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
-
-	caps = ["out-numeric"]
-	oob = ["other"]
-
-	random.shuffle(uuid)
-	uuid_str = array_to_string(uuid)
-	print('Joining with UUID ' + set_green(uuid_str))
+	def process_cmd(self, str_value):
+		global user_input
+		global dst_addr
+		global app_idx
+
+		if user_input == INPUT_TOKEN:
+			set_token(str_value)
+		elif user_input == INPUT_DEST_ADDRESS:
+			res = set_value(str_value, 4, 4)
+			if is_error() != True:
+				dst_addr = res
+				print(set_yellow("Destination address: ") +
+					set_green(format(dst_addr, '04x')))
+		elif user_input == INPUT_APP_KEY_INDEX:
+			res = set_value(str_value, 1, 3)
+			if is_error() != True:
+				app_idx = res
+				print(set_yellow("Application index: ") +
+					set_green(format(app_idx, '03x')))
+
+		if user_input != INPUT_NONE:
+			user_input = INPUT_NONE
+			if is_error() != True:
+				return
 
-	mesh_net.Join(app.get_path(), uuid,
-			reply_handler=join_cb,
-			error_handler=join_error_cb)
+		Menu.process_cmd(self, str_value)
 
 ##############################
-# On/Off Client menu functions
+# On/Off Client menu class
 ##############################
-def process_client_menu(input_str):
-	global user_input
-	global dst_addr
-	global app_idx
-
-	res = -1
-	str = input_str.strip()
-
-	if user_input == 1:
-		res = set_value(str)
-		if res != -1:
-			dst_addr = res
-	elif user_input == 2:
-		res = set_value(str)
-		if res != -1:
-			app_idx = res
-
-	if user_input != 0:
-		user_input = 0
-		if res == -1:
-			client_menu()
-		return
-
-	# Allow entering empty lines for better output visibility
-	if len(str) == 0:
-		return
+class ClientMenu(Menu):
+	def __init__(self):
+		menu_items = {
+			'get-state': MenuItem(' - get server state',
+						self.__cmd_get_state),
+			'off': MenuItem(' - set state OFF',
+						self.__cmd_set_state_off),
+			'on': MenuItem(' - set state ON',
+						self.__cmd_set_state_on),
+			'back': MenuItem(' - back to main menu',
+						self.__cmd_main_menu),
+			'quit': MenuItem(' - exit the test', app_exit)
+		}
 
-	if str.isdigit() == False:
-		client_menu()
-		return
+		Menu.__init__(self, 'On/Off Clien Menu', menu_items)
 
-	opt = int(str)
+	def __cmd_main_menu(self):
+		switch_menu(MAIN_MENU)
 
-	if opt > 7:
-		print(set_error('Unknown menu option: '), opt)
-		client_menu()
-		return
+	def __cmd_get_state(self):
+		app.elements[1].models[0].get_state(dst_addr, app_idx)
 
-	if opt >= 3 and opt <= 5 and dst_addr == 0x0000:
-		print(set_error('Destination address not set!'))
-		return
+	def __cmd_set_state_off(self):
+		app.elements[1].models[0].set_state(dst_addr, app_idx, 0)
 
-	if opt == 1:
-		user_input = 1;
-		print(set_cyan('Enter 4-digit hex destination address:'))
-	elif opt == 2:
-		user_input = 2;
-		app.elements[1].models[0].print_bindings()
-		print(set_cyan('Choose application key index:'))
-	elif opt == 3:
-		app.elements[1].models[0].get_state(dst_addr, app_idx)
-	elif opt == 4 or opt == 5:
-		app.elements[1].models[0].set_state(dst_addr, app_idx, opt - 4)
-	elif opt == 6:
-		switch_menu(0)
-	elif opt == 7:
-		app_exit()
+	def __cmd_set_state_on(self):
+		app.elements[1].models[0].set_state(dst_addr, app_idx, 1)
 
-def client_menu():
-	print(set_cyan('*** ON/OFF CLIENT MENU ***'))
-	print(set_cyan('1 - set destination address'))
-	print(set_cyan('2 - set application key index'))
-	print(set_cyan('3 - get state'))
-	print(set_cyan('4 - set state OFF'))
-	print(set_cyan('5 - set state ON'))
-	print(set_cyan('6 - back to main menu'))
-	print(set_cyan('7 - exit'))
 
-def set_value(str):
+def set_value(str_value, min, max):
 
-	if len(str) != 4:
-		print(set_error('Expected 4 digits'))
+	if len(str_value) > max or len(str_value) < min:
+		raise_error('Bad input length %d' % len(str_value))
 		return -1
 
 	try:
-		value = int(str, 16)
+		value = int(str_value, 16)
 	except ValueError:
-		print(set_error('Not a valid hexadecimal number'))
+		raise_error('Not a valid hexadecimal number')
 		return -1
 
 	return value
 
+
 ########################
 # Main entry
 ########################
@@ -806,6 +892,8 @@ def main():
 	global mainloop
 	global app
 	global mesh_net
+	global menu
+	global current_menu
 
 	if len(sys.argv) > 1 :
 		set_token(sys.argv[1])
@@ -827,14 +915,21 @@ def main():
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
 
 	mainloop = GLib.MainLoop()
 
-	main_menu()
+	menus.append(MainMenu())
+	menus.append(ClientMenu())
+	switch_menu(MAIN_MENU)
+
 	event_catcher = MenuHandler(process_input);
 	mainloop.run()
 
-- 
2.17.2

