Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB22C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA407206DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 22:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCHW5w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:57:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:41083 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfCHW5w (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 17:57:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 14:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132507497"
Received: from ingas-nuc1.sea.intel.com ([10.251.144.43])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 14:57:50 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] test: Add unified test for mesh node example app
Date:   Fri,  8 Mar 2019 14:57:49 -0800
Message-Id: <20190308225749.20469-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds one script, test-mesh, to replace three test-join,
example-onoff-server and example-onoff-client.
This is menu driven test that allows provisioning (join) and/or
connecting existing (attach) nodes.
---
 test/agent.py             |  10 +-
 test/example-onoff-client | 288 ----------------
 test/example-onoff-server | 365 --------------------
 test/test-mesh            | 703 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 711 insertions(+), 655 deletions(-)
 delete mode 100644 test/example-onoff-client
 delete mode 100644 test/example-onoff-server
 create mode 100755 test/test-mesh

diff --git a/test/agent.py b/test/agent.py
index 22c92f952..bd78b6000 100755
--- a/test/agent.py
+++ b/test/agent.py
@@ -3,7 +3,12 @@
 import sys
 import dbus
 import dbus.service
-import dbus.mainloop.glib
+
+try:
+  from termcolor import colored, cprint
+  set_green = lambda x: colored(x, 'green', attrs=['bold'])
+except ImportError:
+  set_green = lambda x: x
 
 AGENT_IFACE = 'org.bluez.mesh.ProvisionAgent1'
 AGENT_PATH = "/mesh/test/agent"
@@ -37,4 +42,5 @@ class Agent(dbus.service.Object):
 
 	@dbus.service.method(AGENT_IFACE, in_signature="su", out_signature="")
 	def DisplayNumeric(self, type, value):
-		print("DisplayNumeric type=", type, " number=", value)
+		print(set_cyan("DisplayNumeric type="), type,
+					set_cyan(" number="), set_green(value))
diff --git a/test/example-onoff-client b/test/example-onoff-client
deleted file mode 100644
index e4a87eb12..000000000
--- a/test/example-onoff-client
+++ /dev/null
@@ -1,288 +0,0 @@
-#!/usr/bin/env python3
-
-import sys
-import struct
-import numpy
-import dbus
-import dbus.service
-import dbus.exceptions
-
-try:
-  from gi.repository import GObject
-except ImportError:
-  import gobject as GObject
-from dbus.mainloop.glib import DBusGMainLoop
-
-MESH_SERVICE_NAME = 'org.bluez.mesh'
-DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'
-DBUS_OM_IFACE = 'org.freedesktop.DBus.ObjectManager'
-
-MESH_NETWORK_IFACE = 'org.bluez.mesh.Network1'
-MESH_NODE_IFACE = 'org.bluez.mesh.Node1'
-MESH_ELEMENT_IFACE = 'org.bluez.mesh.Element1'
-
-VENDOR_ID_NONE = 0xffff
-
-app = None
-bus = None
-mainloop = None
-node = None
-token = numpy.uint64(0x76bd4f2372477600)
-
-def unwrap(item):
-	if isinstance(item, dbus.Boolean):
-		return bool(item)
-	if isinstance(item, (dbus.UInt16, dbus.Int16, dbus.UInt32, dbus.Int32,
-						dbus.UInt64, dbus.Int64)):
-		return int(item)
-	if isinstance(item, dbus.Byte):
-		return bytes([int(item)])
-	if isinstance(item, dbus.String):
-			return item
-	if isinstance(item, (dbus.Array, list, tuple)):
-		return [unwrap(x) for x in item]
-	if isinstance(item, (dbus.Dictionary, dict)):
-		return dict([(unwrap(x), unwrap(y)) for x, y in item.items()])
-
-	print('Dictionary item not handled')
-	print(type(item))
-	return item
-
-def attach_app_cb(node_path, dict_array):
-	print('Mesh application registered ', node_path)
-	print(type(node_path))
-	print(type(dict_array))
-	print(dict_array)
-
-	els = unwrap(dict_array)
-	print("Get Elements")
-	for el in els:
-		print(el)
-		idx = struct.unpack('b', el[0])[0]
-		print('Configuration for Element ', end='')
-		print(idx)
-		models = el[1]
-
-		element = app.get_element(idx)
-		element.set_model_config(models)
-
-	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
-	global node
-	node = dbus.Interface(obj, MESH_NODE_IFACE)
-
-def error_cb(error):
-	print('D-Bus call failed: ' + str(error))
-
-def generic_reply_cb():
-	print('D-Bus call done')
-
-def interfaces_removed_cb(object_path, interfaces):
-	if not mesh_net:
-		return
-
-	if object_path == mesh_net[2]:
-		print('Service was removed')
-		mainloop.quit()
-
-class Application(dbus.service.Object):
-
-	def __init__(self, bus):
-		self.path = '/example'
-		self.elements = []
-		dbus.service.Object.__init__(self, bus, self.path)
-
-	def get_path(self):
-		return dbus.ObjectPath(self.path)
-
-	def add_element(self, element):
-		self.elements.append(element)
-
-	def get_element(self, idx):
-		for ele in self.elements:
-			if ele.get_index() == idx:
-				return ele
-
-	@dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
-	def GetManagedObjects(self):
-		response = {}
-		print('GetManagedObjects')
-		for element in self.elements:
-			response[element.get_path()] = element.get_properties()
-		return response
-
-class Element(dbus.service.Object):
-	PATH_BASE = '/example/ele'
-
-	def __init__(self, bus, index):
-		self.path = self.PATH_BASE + format(index, '02x')
-		print(self.path)
-		self.models = []
-		self.bus = bus
-		self.index = index
-		dbus.service.Object.__init__(self, bus, self.path)
-
-	def _get_sig_models(self):
-		ids = []
-		for model in self.models:
-			id = model.get_id()
-			vendor = model.get_vendor()
-			if vendor == VENDOR_ID_NONE:
-				ids.append(id)
-		return ids
-
-	def get_properties(self):
-		return {
-				MESH_ELEMENT_IFACE: {
-				'Index': dbus.Byte(self.index),
-				'Models': dbus.Array(
-					self._get_sig_models(), signature='q')
-				}
-		}
-
-	def add_model(self, model):
-		model.set_path(self.path)
-		self.models.append(model)
-
-	def get_index(self):
-		return self.index
-
-	def set_model_config(self, config):
-		print('Set element models config')
-
-	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="qqbay", out_signature="")
-	def MessageReceived(self, source, key, is_sub, data):
-		print('Message Received on Element ', end='')
-		print(self.index)
-		for model in self.models:
-			model.process_message(source, key, data)
-
-	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="qa{sv}", out_signature="")
-
-	def UpdateModelConfiguration(self, model_id, config):
-		print('UpdateModelConfig ', end='')
-		print(hex(model_id))
-		for model in self.models:
-			if model_id == model.get_id():
-				model.set_config(config)
-				return
-
-	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="", out_signature="")
-	def get_path(self):
-		return dbus.ObjectPath(self.path)
-
-class Model():
-	def __init__(self, model_id):
-		self.cmd_ops = []
-		self.model_id = model_id
-		self.vendor = VENDOR_ID_NONE
-		self.path = None
-
-	def set_path(self, path):
-		self.path = path
-
-	def get_id(self):
-		return self.model_id
-
-	def get_vendor(self):
-		return self.vendor
-
-	def process_message(self, source, key, data):
-		print('Model process message')
-
-	def set_publication(self, period):
-		self.period = period
-
-	def set_bindings(self, bindings):
-		self.bindings = bindings
-
-	def set_config(self, config):
-		if 'Bindings' in config:
-			self.bindings = config.get('Bindings')
-			print('Bindings: ', end='')
-			print(self.bindings)
-		if 'PublicationPeriod' in config:
-			self.set_publication(config.get('PublicationPeriod'))
-			print('Model publication period ', end='')
-			print(self.pub_period, end='')
-			print(' ms')
-
-class OnOffClient(Model):
-	def __init__(self, model_id):
-		Model.__init__(self, model_id)
-		self.cmd_ops = { 0x8201, # get
-						 0x8202, # set
-						 0x8203 } # set unacknowledged
-		print('OnOff Client')
-
-	def _reply_cb(state):
-		print('State ', end='');
-		print(state)
-
-	def _send_message(self, dest, key, data, reply_cb):
-		print('OnOffClient send data')
-		node.Send(self.path, dest, key, data, reply_handler=reply_cb,
-				  error_handler=error_cb)
-
-	def get_state(self, dest, key):
-		opcode = 0x8201
-		data = struct.pack('<H', opcode)
-		self._send_message(dest, key, data, self._reply_cb)
-
-	def set_state(self, dest, key, state):
-		opcode = 0x8202
-		data = struct.pack('<HB', opcode, state)
-		self._send_message(dest, key, data, self._reply_cb)
-
-	def process_message(self, source, key, data):
-		print('OnOffClient process message len ', end = '')
-		datalen = len(data)
-		print(datalen)
-
-		if datalen!=3:
-			return
-
-		opcode, state=struct.unpack('<HB',bytes(data))
-		if opcode != 0x8202 :
-			print('Bad opcode ', end='')
-			print(hex(opcode))
-			return
-
-		print('Got state ', end = '')
-		print(hex(state))
-
-def attach_app_error_cb(error):
-	print('Failed to register application: ' + str(error))
-	mainloop.quit()
-
-def main():
-
-	DBusGMainLoop(set_as_default=True)
-
-	global bus
-	bus = dbus.SystemBus()
-	global mainloop
-	global app
-
-	mesh_net = dbus.Interface(bus.get_object(MESH_SERVICE_NAME,
-							"/org/bluez/mesh"),
-							MESH_NETWORK_IFACE)
-	mesh_net.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
-
-	app = Application(bus)
-	first_ele = Element(bus, 0x00)
-	first_ele.add_model(OnOffClient(0x1001))
-	app.add_element(first_ele)
-
-	mainloop = GObject.MainLoop()
-
-	print('Attach')
-	mesh_net.Attach(app.get_path(), token,
-					reply_handler=attach_app_cb,
-					error_handler=attach_app_error_cb)
-	mainloop.run()
-
-if __name__ == '__main__':
-	main()
diff --git a/test/example-onoff-server b/test/example-onoff-server
deleted file mode 100644
index 131b6415c..000000000
--- a/test/example-onoff-server
+++ /dev/null
@@ -1,365 +0,0 @@
-#!/usr/bin/env python3
-
-import sys
-import struct
-import numpy
-import dbus
-import dbus.service
-import dbus.exceptions
-
-from threading import Timer
-import time
-
-
-try:
-  from gi.repository import GObject
-except ImportError:
-  import gobject as GObject
-from dbus.mainloop.glib import DBusGMainLoop
-
-MESH_SERVICE_NAME = 'org.bluez.mesh'
-DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'
-DBUS_OM_IFACE = 'org.freedesktop.DBus.ObjectManager'
-
-MESH_NETWORK_IFACE = 'org.bluez.mesh.Network1'
-MESH_NODE_IFACE = 'org.bluez.mesh.Node1'
-MESH_APPLICATION_IFACE = 'org.bluez.mesh.Application1'
-MESH_ELEMENT_IFACE = 'org.bluez.mesh.Element1'
-
-APP_COMPANY_ID = 0x05f1
-APP_PRODUCT_ID = 0x0001
-APP_VERSION_ID = 0x0001
-
-VENDOR_ID_NONE = 0xffff
-
-app = None
-bus = None
-mainloop = None
-node = None
-
-token = numpy.uint64(0x76bd4f2372476578)
-
-def generic_error_cb(error):
-	print('D-Bus call failed: ' + str(error))
-
-def generic_reply_cb():
-	print('D-Bus call done')
-
-def unwrap(item):
-	if isinstance(item, dbus.Boolean):
-		return bool(item)
-	if isinstance(item, (dbus.UInt16, dbus.Int16, dbus.UInt32, dbus.Int32,
-						dbus.UInt64, dbus.Int64)):
-		return int(item)
-	if isinstance(item, dbus.Byte):
-		return bytes([int(item)])
-	if isinstance(item, dbus.String):
-			return item
-	if isinstance(item, (dbus.Array, list, tuple)):
-		return [unwrap(x) for x in item]
-	if isinstance(item, (dbus.Dictionary, dict)):
-		return dict([(unwrap(x), unwrap(y)) for x, y in item.items()])
-
-	print('Dictionary item not handled')
-	print(type(item))
-	return item
-
-def attach_app_cb(node_path, dict_array):
-	print('Mesh application registered ', node_path)
-
-	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
-
-	global node
-	node = dbus.Interface(obj, MESH_NODE_IFACE)
-
-	els = unwrap(dict_array)
-	print("Get Elements")
-
-	for el in els:
-		idx = struct.unpack('b', el[0])[0]
-		print('Configuration for Element ', end='')
-		print(idx)
-
-		models = el[1]
-		element = app.get_element(idx)
-		element.set_model_config(models)
-
-def interfaces_removed_cb(object_path, interfaces):
-	if not mesh_net:
-		return
-
-	if object_path == mesh_net[2]:
-		print('Service was removed')
-		mainloop.quit()
-
-def send_response(path, dest, key, data):
-		print('send response ', end='')
-		print(data)
-		node.Send(path, dest, key, data, reply_handler=generic_reply_cb,
-						error_handler=generic_error_cb)
-
-def send_publication(path, model_id, data):
-		print('send publication ', end='')
-		print(data)
-		node.Publish(path, model_id, data,
-						reply_handler=generic_reply_cb,
-						error_handler=generic_error_cb)
-
-class PubTimer():
-	def __init__(self):
-		self.seconds = None
-		self.func = None
-		self.thread = None
-		self.busy = False
-
-	def _timeout_cb(self):
-		self.func()
-		self.busy = True
-		self._schedule_timer()
-		self.busy =False
-
-	def _schedule_timer(self):
-		self.thread = Timer(self.seconds, self._timeout_cb)
-		self.thread.start()
-
-	def start(self, seconds, func):
-		self.func = func
-		self.seconds = seconds
-		if not self.busy:
-			self._schedule_timer()
-
-	def cancel(self):
-		print('Cancel timer')
-		if self.thread is not None:
-			print('Cancel thread')
-			self.thread.cancel()
-			self.thread = None
-
-class Application(dbus.service.Object):
-
-	def __init__(self, bus):
-		self.path = '/example'
-		self.elements = []
-		dbus.service.Object.__init__(self, bus, self.path)
-
-	def get_path(self):
-		return dbus.ObjectPath(self.path)
-
-	def add_element(self, element):
-		self.elements.append(element)
-
-	def get_element(self, idx):
-		for ele in self.elements:
-			if ele.get_index() == idx:
-				return ele
-
-	def get_properties(self):
-		return {
-			MESH_APPLICATION_IFACE: {
-				'CompanyID': dbus.UInt16(APP_COMPANY_ID),
-				'ProductID': dbus.UInt16(APP_PRODUCT_ID),
-				'VersionID': dbus.UInt16(APP_VERSION_ID)
-			}
-		}
-
-	@dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
-	def GetManagedObjects(self):
-		response = {}
-		print('GetManagedObjects')
-		response[self.path] = self.get_properties()
-		for element in self.elements:
-			response[element.get_path()] = element.get_properties()
-		return response
-
-class Element(dbus.service.Object):
-	PATH_BASE = '/example/ele'
-
-	def __init__(self, bus, index):
-		self.path = self.PATH_BASE + format(index, '02x')
-		print(self.path)
-		self.models = []
-		self.bus = bus
-		self.index = index
-		dbus.service.Object.__init__(self, bus, self.path)
-
-	def _get_sig_models(self):
-		ids = []
-		for model in self.models:
-			id = model.get_id()
-			vendor = model.get_vendor()
-			if vendor == VENDOR_ID_NONE:
-				ids.append(id)
-		return ids
-
-	def get_properties(self):
-		return {
-			MESH_ELEMENT_IFACE: {
-				'Index': dbus.Byte(self.index),
-				'Models': dbus.Array(
-					self._get_sig_models(), signature='q')
-			}
-		}
-
-	def add_model(self, model):
-		model.set_path(self.path)
-		self.models.append(model)
-
-	def get_index(self):
-		return self.index
-
-	def set_model_config(self, configs):
-		print('Set element models config')
-		for config in configs:
-			mod_id = config[0]
-			self.UpdateModelConfiguration(mod_id, config[1])
-
-	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="qqbay", out_signature="")
-	def MessageReceived(self, source, key, is_sub, data):
-		print('Message Received on Element ', end='')
-		print(self.index)
-		for model in self.models:
-			model.process_message(source, key, data)
-
-	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="qa{sv}", out_signature="")
-
-	def UpdateModelConfiguration(self, model_id, config):
-		print('UpdateModelConfig ', end='')
-		print(hex(model_id))
-		for model in self.models:
-			if model_id == model.get_id():
-				model.set_config(config)
-				return
-
-	@dbus.service.method(MESH_ELEMENT_IFACE,
-					in_signature="", out_signature="")
-
-	def get_path(self):
-		return dbus.ObjectPath(self.path)
-
-class Model():
-	def __init__(self, model_id):
-		self.cmd_ops = []
-		self.model_id = model_id
-		self.vendor = VENDOR_ID_NONE
-		self.bindings = []
-		self.pub_period = 0
-		self.pub_id = 0
-		self.path = None
-
-	def set_path(self, path):
-		self.path = path
-
-	def get_id(self):
-		return self.model_id
-
-	def get_vendor(self):
-		return self.vendor
-
-	def process_message(self, source, key, data):
-		print('Model process message')
-
-	def set_publication(self, period):
-		self.pub_period = period
-
-	def set_config(self, config):
-		if 'Bindings' in config:
-			self.bindings = config.get('Bindings')
-			print('Bindings: ', end='')
-			print(self.bindings)
-		if 'PublicationPeriod' in config:
-			self.set_publication(config.get('PublicationPeriod'))
-			print('Model publication period ', end='')
-			print(self.pub_period, end='')
-			print(' ms')
-
-class OnOffServer(Model):
-	def __init__(self, model_id):
-		Model.__init__(self, model_id)
-		self.cmd_ops = { 0x8201, # get
-						 0x8202, # set
-						 0x8203 } # set unacknowledged
-
-		print("OnOff Server ", end="")
-		self.state = 0
-		print('State ', end='')
-		self.timer = PubTimer()
-
-	def process_message(self, source, key, data):
-		datalen = len(data)
-		print('OnOff Server process message len ', datalen)
-
-		if datalen!=2 and datalen!=3:
-			return
-
-		if datalen==2:
-			op_tuple=struct.unpack('<H',bytes(data))
-			opcode = op_tuple[0]
-			if opcode != 0x8201:
-				print(hex(opcode))
-				return
-			print('Get state')
-		elif datalen==3:
-			opcode,self.state=struct.unpack('<HB',bytes(data))
-			if opcode != 0x8202 and opcode != 0x8203:
-				print(hex(opcode))
-				return
-			print('Set state: ', end='')
-			print(self.state)
-
-		rsp_data = struct.pack('<HB', 0x8204, self.state)
-		send_response(self.path, source, key, rsp_data)
-
-	def publish(self):
-		print('Publish')
-		data = struct.pack('B', self.state)
-		send_publication(self.path, self.model_id, data)
-
-	def set_publication(self, period):
-		if period == 0:
-			self.pub_period = 0
-			self.timer.cancel()
-			return
-
-		# We do not handle ms in this example
-		if period < 1000:
-			return
-
-		self.pub_period = period
-		self.timer.start(period/1000, self.publish)
-
-def attach_app_error_cb(error):
-	print('Failed to register application: ' + str(error))
-	mainloop.quit()
-
-def main():
-
-	DBusGMainLoop(set_as_default=True)
-
-	global bus
-	bus = dbus.SystemBus()
-	global mainloop
-	global app
-
-	mesh_net = dbus.Interface(bus.get_object(MESH_SERVICE_NAME,
-						"/org/bluez/mesh"),
-						MESH_NETWORK_IFACE)
-	mesh_net.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
-
-	app = Application(bus)
-	first_ele = Element(bus, 0x00)
-	first_ele.add_model(OnOffServer(0x1000))
-	app.add_element(first_ele)
-
-	mainloop = GObject.MainLoop()
-
-	print('Attach')
-	mesh_net.Attach(app.get_path(), token,
-					reply_handler=attach_app_cb,
-					error_handler=attach_app_error_cb)
-
-	mainloop.run()
-
-if __name__ == '__main__':
-	main()
diff --git a/test/test-mesh b/test/test-mesh
new file mode 100755
index 000000000..cc10adff0
--- /dev/null
+++ b/test/test-mesh
@@ -0,0 +1,703 @@
+#!/usr/bin/env python3
+
+###################################################################
+#
+# This is a unified test for BT Mesh
+#
+# To run the test:
+#     test-mesh [token]
+#
+#            'token' is an optional argument. It must be a 16-digit
+#            hexadecimal number. The token must be associated with
+#            an existing node. The token is generated and assigned
+#            to a node as a result of successful provisioning (see
+#            explanation of "join" option).
+#            When the token is set, the menu operations "attach"
+#            and "remove" will be performed on a node specified
+#            by this token.
+#
+#      The test imitates a 2-element device:
+#            element 0: OnOff Server model
+#            element 1: OnOff Client model
+#
+# The main menu:
+#       1 - set node ID (token)
+#       2 - join mesh network
+#       3 - attach mesh node
+#       4 - remove node
+#       5 - exit
+#
+# The main menu options explained:
+#     1 - set token
+#            Set a unique node token.
+#            The token can be set from command line arguments as
+#            well.
+#
+#     2 - join
+#            Request provisioning of a device to become a node
+#            on a mesh network. The test generates device UUID
+#            which is displayed and will need to be provided to
+#            an outside entity that acts as a Provisioner. Also,
+#            during the provisioning process, an agent that is
+#            part of the test, will request (or will be requested)
+#            to perform a specified operation, e.g., a number will
+#            be displayed and this number will need to be  entered
+#            on the Provisioner's side.
+#            In case of successful provisioning, an node 'token'
+#            will be returned to the application and will be used
+#            for the runtime of the test or until option "set token"
+#            option is chosen to set another token and, subsequently,
+#            switch to another node.
+#
+#     3 - attach
+#            Attach the application to bluetoothd-daemon as a node.
+#            For the call to be successful, the valid node token must
+#            be already set, either from command arguments or by
+#            executing "set token" operation or automatically after
+#            successfully executing "join" operation in the same test
+#            run.
+#
+#     4 - remove
+#           Permanently removes any node configuration from daemon
+#           and persistent storage. After this operation, the node
+#           is permanently forgotten by the daemon and the associated
+#           node token is no longer valid.
+#
+#     5 - exit
+#
+###################################################################
+import sys
+import struct
+import fcntl
+import os
+import numpy
+import random
+import dbus
+import dbus.service
+import dbus.exceptions
+
+from threading import Timer
+import time
+
+try:
+  from gi.repository import GLib
+except ImportError:
+  import glib as GLib
+from dbus.mainloop.glib import DBusGMainLoop
+
+try:
+  from termcolor import colored, cprint
+  set_error = lambda x: colored('!' + x, 'red', attrs=['bold'])
+  set_cyan = lambda x: colored(x, 'cyan', attrs=['bold'])
+  set_green = lambda x: colored(x, 'green', attrs=['bold'])
+  set_yellow = lambda x: colored(x, 'yellow', attrs=['bold'])
+except ImportError:
+  set_error = lambda x: x
+  set_cyan = lambda x: x
+  set_green = lambda x: x
+  set_yellow = lambda x: x
+
+# Provisioning agent
+try:
+  import agent
+except ImportError:
+  agent = None
+
+MESH_SERVICE_NAME = 'org.bluez.mesh'
+DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'
+DBUS_OM_IFACE = 'org.freedesktop.DBus.ObjectManager'
+
+MESH_NETWORK_IFACE = 'org.bluez.mesh.Network1'
+MESH_NODE_IFACE = 'org.bluez.mesh.Node1'
+MESH_APPLICATION_IFACE = 'org.bluez.mesh.Application1'
+MESH_ELEMENT_IFACE = 'org.bluez.mesh.Element1'
+
+APP_COMPANY_ID = 0x05f1
+APP_PRODUCT_ID = 0x0001
+APP_VERSION_ID = 0x0001
+
+VENDOR_ID_NONE = 0xffff
+
+app = None
+bus = None
+mainloop = None
+node = None
+mesh_net = None
+
+# Node token housekeeping
+token = None
+token_input = False
+have_token = False
+
+def array_to_string(b_array):
+	str = ""
+	for b in b_array:
+		str += "%02x" % b
+	return str
+
+def generic_error_cb(error):
+	print(set_error('D-Bus call failed: ') + str(error))
+
+def generic_reply_cb():
+	return
+
+def attach_app_error_cb(error):
+	print(set_error('Failed to register application: ') + str(error))
+
+def attach(token):
+	print('Attach mesh node to bluetooth-meshd daemon')
+
+	mesh_net.Attach(app.get_path(), token,
+					reply_handler=attach_app_cb,
+					error_handler=attach_app_error_cb)
+
+def join_cb():
+	print('Join procedure started')
+
+def join_error_cb(reason):
+	print('Join procedure failed: ', reason)
+
+def unwrap(item):
+	if isinstance(item, dbus.Boolean):
+		return bool(item)
+	if isinstance(item, (dbus.UInt16, dbus.Int16, dbus.UInt32, dbus.Int32,
+						dbus.UInt64, dbus.Int64)):
+		return int(item)
+	if isinstance(item, dbus.Byte):
+		return bytes([int(item)])
+	if isinstance(item, dbus.String):
+			return item
+	if isinstance(item, (dbus.Array, list, tuple)):
+		return [unwrap(x) for x in item]
+	if isinstance(item, (dbus.Dictionary, dict)):
+		return dict([(unwrap(x), unwrap(y)) for x, y in item.items()])
+
+	print(set_error('Dictionary item not handled: ') + type(item))
+
+	return item
+
+def attach_app_cb(node_path, dict_array):
+	print('Mesh application registered ', node_path)
+
+	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
+
+	global node
+	node = dbus.Interface(obj, MESH_NODE_IFACE)
+
+	els = unwrap(dict_array)
+
+	for el in els:
+		idx = struct.unpack('b', el[0])[0]
+
+		models = el[1]
+		element = app.get_element(idx)
+		element.set_model_config(models)
+
+def interfaces_removed_cb(object_path, interfaces):
+	print('Removed')
+	if not mesh_net:
+		return
+
+	print(object_path)
+	if object_path == mesh_net[2]:
+		print('Service was removed')
+		app_exit()
+
+def send_response(path, dest, key, data):
+		node.Send(path, dest, key, data, reply_handler=generic_reply_cb,
+						error_handler=generic_error_cb)
+
+def send_publication(path, model_id, data):
+		print('Send publication ', end='')
+		print(data)
+		node.Publish(path, model_id, data,
+						reply_handler=generic_reply_cb,
+						error_handler=generic_error_cb)
+
+def print_state(state):
+	print('State is ', end='')
+	if state == 0:
+		print('OFF')
+	elif state == 1:
+		print('ON')
+	else:
+		print('UNKNOWN')
+class PubTimer():
+	def __init__(self):
+		self.seconds = None
+		self.func = None
+		self.thread = None
+		self.busy = False
+
+	def _timeout_cb(self):
+		self.func()
+		self.busy = True
+		self._schedule_timer()
+		self.busy =False
+
+	def _schedule_timer(self):
+		self.thread = Timer(self.seconds, self._timeout_cb)
+		self.thread.start()
+
+	def start(self, seconds, func):
+		self.func = func
+		self.seconds = seconds
+		if not self.busy:
+			self._schedule_timer()
+
+	def cancel(self):
+		if self.thread is not None:
+			self.thread.cancel()
+			self.thread = None
+
+class Application(dbus.service.Object):
+
+	def __init__(self, bus):
+		self.path = '/example'
+		self.agent = None
+		self.elements = []
+		dbus.service.Object.__init__(self, bus, self.path)
+
+	def set_agent(self, agent):
+		self.agent = agent
+
+	def get_path(self):
+		return dbus.ObjectPath(self.path)
+
+	def add_element(self, element):
+		self.elements.append(element)
+
+	def get_element(self, idx):
+		for ele in self.elements:
+			if ele.get_index() == idx:
+				return ele
+
+	def get_properties(self):
+		return {
+			MESH_APPLICATION_IFACE: {
+				'CompanyID': dbus.UInt16(APP_COMPANY_ID),
+				'ProductID': dbus.UInt16(APP_PRODUCT_ID),
+				'VersionID': dbus.UInt16(APP_VERSION_ID)
+			}
+		}
+
+	@dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+	def GetManagedObjects(self):
+		response = {}
+		response[self.path] = self.get_properties()
+		response[self.agent.get_path()] = self.agent.get_properties()
+		for element in self.elements:
+			response[element.get_path()] = element.get_properties()
+		return response
+
+	@dbus.service.method(MESH_APPLICATION_IFACE,
+					in_signature="t", out_signature="")
+	def JoinComplete(self, value):
+		global token
+		global have_token
+
+		print('JoinComplete with token ' + set_green(hex(value)))
+
+		token = value
+		have_token = True
+
+		attach(token)
+
+	@dbus.service.method(MESH_APPLICATION_IFACE,
+					in_signature="s", out_signature="")
+	def JoinFailed(self, value):
+		print(set_error('JoinFailed '), value)
+
+
+class Element(dbus.service.Object):
+	PATH_BASE = '/example/ele'
+
+	def __init__(self, bus, index):
+		self.path = self.PATH_BASE + format(index, '02x')
+		print(self.path)
+		self.models = []
+		self.bus = bus
+		self.index = index
+		dbus.service.Object.__init__(self, bus, self.path)
+
+	def _get_sig_models(self):
+		ids = []
+		for model in self.models:
+			id = model.get_id()
+			vendor = model.get_vendor()
+			if vendor == VENDOR_ID_NONE:
+				ids.append(id)
+		return ids
+
+	def get_properties(self):
+		return {
+			MESH_ELEMENT_IFACE: {
+				'Index': dbus.Byte(self.index),
+				'Models': dbus.Array(
+					self._get_sig_models(), signature='q')
+			}
+		}
+
+	def add_model(self, model):
+		model.set_path(self.path)
+		self.models.append(model)
+
+	def get_index(self):
+		return self.index
+
+	def set_model_config(self, configs):
+		for config in configs:
+			mod_id = config[0]
+			self.UpdateModelConfiguration(mod_id, config[1])
+
+	@dbus.service.method(MESH_ELEMENT_IFACE,
+					in_signature="qqbay", out_signature="")
+	def MessageReceived(self, source, key, is_sub, data):
+		print('Message Received on Element ', end='')
+		print(self.index)
+		for model in self.models:
+			model.process_message(source, key, data)
+
+	@dbus.service.method(MESH_ELEMENT_IFACE,
+					in_signature="qa{sv}", out_signature="")
+
+	def UpdateModelConfiguration(self, model_id, config):
+		print('UpdateModelConfig ', end='')
+		print(hex(model_id))
+		for model in self.models:
+			if model_id == model.get_id():
+				model.set_config(config)
+				return
+
+	@dbus.service.method(MESH_ELEMENT_IFACE,
+					in_signature="", out_signature="")
+
+	def get_path(self):
+		return dbus.ObjectPath(self.path)
+
+class Model():
+	def __init__(self, model_id):
+		self.cmd_ops = []
+		self.model_id = model_id
+		self.vendor = VENDOR_ID_NONE
+		self.bindings = []
+		self.pub_period = 0
+		self.pub_id = 0
+		self.path = None
+		self.timer = None
+
+	def set_path(self, path):
+		self.path = path
+
+	def get_id(self):
+		return self.model_id
+
+	def get_vendor(self):
+		return self.vendor
+
+	def process_message(self, source, key, data):
+		return
+
+	def set_publication(self, period):
+		self.pub_period = period
+
+	def set_config(self, config):
+		if 'Bindings' in config:
+			self.bindings = config.get('Bindings')
+			print('Bindings: ', end='')
+			print(self.bindings)
+		if 'PublicationPeriod' in config:
+			self.set_publication(config.get('PublicationPeriod'))
+			print('Model publication period ', end='')
+			print(self.pub_period, end='')
+			print(' ms')
+
+########################
+# On Off Server Model
+########################
+class OnOffServer(Model):
+	def __init__(self, model_id):
+		Model.__init__(self, model_id)
+		self.cmd_ops = { 0x8201,  # get
+				 0x8202,  # set
+				 0x8203,  # set unacknowledged
+				 0x8204 } # status
+
+		print("OnOff Server ")
+		self.state = 0
+		print_state(self.state)
+		self.timer = PubTimer()
+
+	def process_message(self, source, key, data):
+		datalen = len(data)
+		print('OnOff Server process message len: ', datalen)
+
+		if datalen != 2 and datalen != 3:
+			# The opcode is not recognized by this model
+			return
+
+		if datalen == 2:
+			op_tuple=struct.unpack('<H',bytes(data))
+			opcode = op_tuple[0]
+			if opcode != 0x8201:
+				# The opcode is not recognized by this model
+				return
+			print('Get state')
+		elif datalen == 3:
+			opcode,self.state=struct.unpack('<HB',bytes(data))
+			if opcode != 0x8202 and opcode != 0x8203:
+				# The opcode is not recognized by this model
+				return
+			print_state(self.state)
+
+		rsp_data = struct.pack('<HB', 0x8204, self.state)
+		send_response(self.path, source, key, rsp_data)
+
+	def publish(self):
+		print('Publish')
+		data = struct.pack('<HB', 0x8204, self.state)
+		send_publication(self.path, self.model_id, data)
+
+	def set_publication(self, period):
+		if period == 0:
+			self.pub_period = 0
+			self.timer.cancel()
+			return
+
+		# We do not handle ms in this example
+		if period < 1000:
+			return
+
+		self.pub_period = period
+		self.timer.start(period/1000, self.publish)
+
+########################
+# On Off Client Model
+########################
+class OnOffClient(Model):
+	def __init__(self, model_id):
+		Model.__init__(self, model_id)
+		self.cmd_ops = { 0x8201,  # get
+				 0x8202,  # set
+				 0x8203,  # set unacknowledged
+				 0x8204 } # status
+		print('OnOff Client')
+
+	def _reply_cb(state):
+		print('State ', end='');
+		print(state)
+
+	def _send_message(self, dest, key, data, reply_cb):
+		print('OnOffClient send data')
+		node.Send(self.path, dest, key, data, reply_handler=reply_cb,
+				  error_handler=generic_error_cb)
+
+	def get_state(self, dest, key):
+		opcode = 0x8201
+		data = struct.pack('<H', opcode)
+		self._send_message(dest, key, data, self._reply_cb)
+
+	def set_state(self, dest, key, state):
+		opcode = 0x8202
+		data = struct.pack('<HB', opcode, state)
+		self._send_message(dest, key, data, self._reply_cb)
+
+	def process_message(self, source, key, data):
+		print('OnOffClient process message len = ', end = '')
+		datalen = len(data)
+		print(datalen)
+
+		if datalen != 3:
+			# The opcode is not recognized by this model
+			return
+
+		opcode, state=struct.unpack('<HB',bytes(data))
+		print(opcode)
+		if opcode != 0x8204 :
+			# The opcode is not recognized by this model
+			return
+
+		print(set_yellow('Got state '), end = '')
+
+		state_str = "ON"
+		if hex(state) == 0:
+			state_str = "OFF"
+
+		print(set_yellow(state_str))
+
+########################
+# Menu functions
+########################
+class MenuDriver(object):
+	def __init__(self, callback):
+		self.cb = callback
+		flags = fcntl.fcntl(sys.stdin.fileno(), fcntl.F_GETFL)
+		flags |= os.O_NONBLOCK
+		fcntl.fcntl(sys.stdin.fileno(), fcntl.F_SETFL, flags)
+		sys.stdin.flush()
+		GLib.io_add_watch(sys.stdin, GLib.IO_IN, self.input_callback)
+
+	def input_callback(self, fd, condition):
+		chunk = fd.read()
+		buffer = ''
+		for char in chunk:
+			buffer += char
+			if char == '\n':
+				self.cb(buffer)
+
+		return True
+
+def process_input(input_str):
+	global token
+	global token_input
+	global have_token
+
+	str = input_str.strip()
+
+	if token_input == True:
+		res = set_token(str)
+		token_input = False
+
+		if res == False:
+			main_menu()
+
+		return
+
+	# Allow entering empty lines for better output visibility
+	if len(str) == 0:
+		return
+
+	if str.isdigit() == False:
+		main_menu()
+		return
+
+	opt = int(str)
+
+	if opt > 5:
+		print(set_error('Unknown menu option: '), opt)
+		main_menu()
+	elif opt == 1:
+		token_input = True;
+		print('Enter 16-digit hex node ID')
+	elif opt == 2:
+		if agent == None:
+			print(set_error('Provisioning agent not found'))
+			return
+
+		join_mesh()
+	elif opt == 3:
+		if have_token == False:
+			print(set_error('Token is not set'))
+			main_menu()
+			return
+
+		attach(token)
+	elif opt == 4:
+		if have_token == False:
+			print(set_error('Token is not set'))
+			main_menu()
+			return
+
+		print('Remove mesh node')
+		mesh_net.Leave(token, reply_handler=generic_reply_cb,
+					error_handler=generic_error_cb)
+		have_token = False
+	elif opt == 5:
+		app_exit()
+
+def main_menu():
+	print(set_cyan('1 - set node ID (token)'))
+	print(set_cyan('2 - join mesh network'))
+	print(set_cyan('3 - attach mesh node'))
+	print(set_cyan('4 - remove node'))
+	print(set_cyan('5 - exit'))
+
+def set_token(str):
+	global token
+	global have_token
+
+	if len(str) != 16:
+		print(set_error('Expected 16 digits'))
+		return False
+
+	try:
+		input_number = int(str, 16)
+	except ValueError:
+		print(set_error('Not a valid hexadecimal number'))
+		return False
+
+	token = numpy.uint64(input_number)
+	have_token = True
+
+	return True
+
+def join_mesh():
+	uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
+
+	caps = ["out-numeric"]
+	oob = ["other"]
+
+	random.shuffle(uuid)
+	uuid_str = array_to_string(uuid)
+	print('Joining with UUID ' + set_green(uuid_str))
+
+	mesh_net.Join(app.get_path(), uuid,
+			reply_handler=join_cb,
+			error_handler=join_error_cb)
+
+def app_exit():
+	global mainloop
+	global app
+
+	for el in app.elements:
+		for model in el.models:
+			if model.timer != None:
+				model.timer.cancel()
+	mainloop.quit()
+
+########################
+# Main entry
+########################
+def main():
+
+	DBusGMainLoop(set_as_default=True)
+
+	global bus
+	bus = dbus.SystemBus()
+	global mainloop
+	global app
+	global mesh_net
+
+	if len(sys.argv) > 1 :
+		set_token(sys.argv[1])
+
+	mesh_net = dbus.Interface(bus.get_object(MESH_SERVICE_NAME,
+						"/org/bluez/mesh"),
+						MESH_NETWORK_IFACE)
+	mesh_net.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
+
+	app = Application(bus)
+
+	# Provisioning agent
+	if agent != None:
+		app.set_agent(agent.Agent(bus))
+
+	first_ele = Element(bus, 0x00)
+	second_ele = Element(bus, 0x01)
+
+	print(set_yellow('Register OnOff Server model on element 0'))
+	first_ele.add_model(OnOffServer(0x1000))
+
+	print(set_yellow('Register OnOff Client model on element 1'))
+	second_ele.add_model(OnOffClient(0x1001))
+	app.add_element(first_ele)
+	app.add_element(second_ele)
+
+	mainloop = GLib.MainLoop()
+
+	main_menu()
+	event_catcher = MenuDriver(process_input);
+	mainloop.run()
+
+if __name__ == '__main__':
+	main()
-- 
2.17.2

