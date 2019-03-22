Return-Path: <SRS0=CqyX=RZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC3C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 03:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8A0218FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Mar 2019 03:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCVDta (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:49:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:54940 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfCVDta (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 23:49:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 20:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,255,1549958400"; 
   d="scan'208";a="136384845"
Received: from ingas-nuc1.sea.intel.com ([10.254.17.2])
  by fmsmga007.fm.intel.com with ESMTP; 21 Mar 2019 20:49:28 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] test: Enable test-mesh to send raw vendor commands
Date:   Thu, 21 Mar 2019 20:49:27 -0700
Message-Id: <20190322034927.6247-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a sample vendor model to the first element of the
mesh node. A new menu entry allows to generate and send a raw
vendor command.
---
 test/test-mesh | 314 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 222 insertions(+), 92 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index fd02207bc..79b3a6fa4 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -18,6 +18,7 @@
 #
 #      The test imitates a device with 2 elements:
 #            element 0: OnOff Server model
+#                       Sample Vendor model
 #            element 1: OnOff Client model
 #
 # The main menu:
@@ -25,8 +26,9 @@
 #       2 - join mesh network
 #       3 - attach mesh node
 #       4 - remove node
-#       5 - client menu
-#       6 - exit
+#       5 - on/off model client menu
+#       6 - send raw message
+#       7 - exit
 #
 # The main menu options explained:
 #     1 - set token
@@ -63,10 +65,20 @@
 #           is permanently forgotten by the daemon and the associated
 #           node token is no longer valid.
 #
-#     5 - client menu
+#     5 - On/Off client menu
 #           Enter On/Off client submenu.
 #
-#     6 - exit
+#     6 - Send raw message
+#           Allows to send arbitrary message to a specified destination.
+#           User is propted to enter 4-digit hex destination address,
+#           app key index, bytearray payload.
+#           The message is originated from the vendor model registered
+#           on element 0. For the command to succeed, the app key index
+#           must correspond to an application key to which the Sample
+#           Vendor model is bound.
+#
+#
+#     7 - exit
 #
 ###################################################################
 import sys
@@ -131,13 +143,29 @@ mesh_net = None
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
@@ -177,6 +205,11 @@ def join_cb():
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
@@ -197,7 +230,11 @@ def unwrap(item):
 	return item
 
 def attach_app_cb(node_path, dict_array):
-	print('Mesh application registered ', node_path)
+	global attached
+
+	attached = True
+
+	print(set_yellow('Mesh app registered: ') + set_green(node_path))
 
 	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
 
@@ -223,17 +260,6 @@ def interfaces_removed_cb(object_path, interfaces):
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
@@ -316,7 +342,8 @@ class Application(dbus.service.Object):
 		global token
 		global have_token
 
-		print('JoinComplete with token ' + set_green(hex(value)))
+		print(set_yellow('Joined mesh network with token ') +
+				set_green(format(value, '16x')))
 
 		token = value
 		have_token = True
@@ -348,14 +375,28 @@ class Element(dbus.service.Object):
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
+		print(props)
+		return { MESH_ELEMENT_IFACE: props }
 
 	def add_model(self, model):
 		model.set_path(self.path)
@@ -381,8 +422,8 @@ class Element(dbus.service.Object):
 					in_signature="qa{sv}", out_signature="")
 
 	def UpdateModelConfiguration(self, model_id, config):
-		print('UpdateModelConfig ', end='')
-		print(hex(model_id))
+		print(('Update Model Config '), end='')
+		print(format(model_id, '04x'))
 		for model in self.models:
 			if model_id == model.get_id():
 				model.set_config(config)
@@ -420,6 +461,18 @@ class Model():
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
@@ -433,12 +486,14 @@ class Model():
 
 	def print_bindings(self):
 		print(set_cyan('Model'), set_cyan('%04x' % self.model_id),
-			set_cyan('is bound to application key(s): '), end = '')
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
@@ -479,7 +534,7 @@ class OnOffServer(Model):
 			print_state(self.state)
 
 		rsp_data = struct.pack('<HB', 0x8204, self.state)
-		send_response(self.path, source, key, rsp_data)
+		self.send_message(source, key, rsp_data)
 
 	def set_publication(self, period):
 
@@ -498,7 +553,7 @@ class OnOffServer(Model):
 	def publish(self):
 		print('Publish')
 		data = struct.pack('<HB', 0x8204, self.state)
-		send_publication(self.path, self.model_id, data)
+		self.send_publication(data)
 
 ########################
 # On Off Client Model
@@ -512,25 +567,20 @@ class OnOffClient(Model):
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
@@ -541,7 +591,7 @@ class OnOffClient(Model):
 			# The opcode is not recognized by this model
 			return
 
-		opcode, state=struct.unpack('<HB',bytes(data))
+		opcode, state = struct.unpack('<HB',bytes(data))
 
 		if opcode != 0x8204 :
 			# The opcode is not recognized by this model
@@ -556,6 +606,14 @@ class OnOffClient(Model):
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
@@ -579,48 +637,54 @@ class MenuHandler(object):
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
+	if level > 2:
 		return
 
 	if level == 0:
 		main_menu()
 	elif level == 1:
 		client_menu()
+	elif level == 2:
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
 
 	if str.isdigit() == False:
 		main_menu()
@@ -628,10 +692,22 @@ def process_main_menu(input_str):
 
 	opt = int(str)
 
-	if opt > 6:
+	if opt > 7:
 		print(set_error('Unknown menu option: '), opt)
 		main_menu()
-	elif opt == 1:
+		return
+
+	if opt == 7:
+		app_exit()
+		return
+
+	if opt > 3:
+		if attached == False:
+			print(set_error('Node not attached'))
+			main_menu()
+			return
+
+	if opt == 1:
 		if have_token:
 			print('Token already set')
 			return
@@ -652,20 +728,13 @@ def process_main_menu(input_str):
 
 		attach(token)
 	elif opt == 4:
-		if have_token == False:
-			print(set_error('Token is not set'))
-			main_menu()
-			return
-
 		print('Remove mesh node')
-		mesh_net.Leave(token, reply_handler=generic_reply_cb,
+		mesh_net.Leave(token, reply_handler=remove_node_cb,
 					error_handler=generic_error_cb)
-		have_token = False
 	elif opt == 5:
 		switch_menu(1)
 	elif opt == 6:
-		app_exit()
-
+		switch_menu(2)
 
 def main_menu():
 	print(set_cyan('*** MAIN MENU ***'))
@@ -674,27 +743,26 @@ def main_menu():
 	print(set_cyan('3 - attach mesh node'))
 	print(set_cyan('4 - remove node'))
 	print(set_cyan('5 - client menu'))
-	print(set_cyan('6 - exit'))
+	print(set_cyan('6 - send raw vendor command'))
+	print(set_cyan('7 - exit'))
 
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
 
@@ -703,7 +771,7 @@ def join_mesh():
 
 	random.shuffle(uuid)
 	uuid_str = array_to_string(uuid)
-	print('Joining with UUID ' + set_green(uuid_str))
+	print(set_yellow('Joining with UUID ') + set_green(uuid_str))
 
 	mesh_net.Join(app.get_path(), uuid,
 			reply_handler=join_cb,
@@ -712,33 +780,30 @@ def join_mesh():
 ##############################
 # On/Off Client menu functions
 ##############################
-def process_client_menu(input_str):
+def process_client_menu(str):
 	global user_input
 	global dst_addr
 	global app_idx
 
-	res = -1
-	str = input_str.strip()
-
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
-
 	if str.isdigit() == False:
 		client_menu()
 		return
@@ -760,7 +825,7 @@ def process_client_menu(input_str):
 	elif opt == 2:
 		user_input = 2;
 		app.elements[1].models[0].print_bindings()
-		print(set_cyan('Choose application key index:'))
+		print(set_cyan('Enter application key index:'))
 	elif opt == 3:
 		app.elements[1].models[0].get_state(dst_addr, app_idx)
 	elif opt == 4 or opt == 5:
@@ -780,20 +845,81 @@ def client_menu():
 	print(set_cyan('6 - back to main menu'))
 	print(set_cyan('7 - exit'))
 
-def set_value(str):
+def set_value(str, min, max):
 
-	if len(str) != 4:
-		print(set_error('Expected 4 digits'))
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
+		switch_menu(0)
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
@@ -827,8 +953,12 @@ def main():
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

