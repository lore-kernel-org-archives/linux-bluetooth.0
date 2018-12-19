Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E845C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322E121871
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeLSEWR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:22:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:4230 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbeLSEWR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:22:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:22:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820346"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:22:16 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 28/30] mesh: Sample On/Off Client and Server
Date:   Tue, 18 Dec 2018 20:20:14 -0800
Message-Id: <20181219042016.25538-29-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/example-onoff-client | 288 ++++++++++++++++++++++++++++++++++++
 mesh/example-onoff-server | 365 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 653 insertions(+)
 create mode 100644 mesh/example-onoff-client
 create mode 100644 mesh/example-onoff-server

diff --git a/mesh/example-onoff-client b/mesh/example-onoff-client
new file mode 100644
index 000000000..e4a87eb12
--- /dev/null
+++ b/mesh/example-onoff-client
@@ -0,0 +1,288 @@
+#!/usr/bin/env python3
+
+import sys
+import struct
+import numpy
+import dbus
+import dbus.service
+import dbus.exceptions
+
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+from dbus.mainloop.glib import DBusGMainLoop
+
+MESH_SERVICE_NAME = 'org.bluez.mesh'
+DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'
+DBUS_OM_IFACE = 'org.freedesktop.DBus.ObjectManager'
+
+MESH_NETWORK_IFACE = 'org.bluez.mesh.Network1'
+MESH_NODE_IFACE = 'org.bluez.mesh.Node1'
+MESH_ELEMENT_IFACE = 'org.bluez.mesh.Element1'
+
+VENDOR_ID_NONE = 0xffff
+
+app = None
+bus = None
+mainloop = None
+node = None
+token = numpy.uint64(0x76bd4f2372477600)
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
+	print('Dictionary item not handled')
+	print(type(item))
+	return item
+
+def attach_app_cb(node_path, dict_array):
+	print('Mesh application registered ', node_path)
+	print(type(node_path))
+	print(type(dict_array))
+	print(dict_array)
+
+	els = unwrap(dict_array)
+	print("Get Elements")
+	for el in els:
+		print(el)
+		idx = struct.unpack('b', el[0])[0]
+		print('Configuration for Element ', end='')
+		print(idx)
+		models = el[1]
+
+		element = app.get_element(idx)
+		element.set_model_config(models)
+
+	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
+	global node
+	node = dbus.Interface(obj, MESH_NODE_IFACE)
+
+def error_cb(error):
+	print('D-Bus call failed: ' + str(error))
+
+def generic_reply_cb():
+	print('D-Bus call done')
+
+def interfaces_removed_cb(object_path, interfaces):
+	if not mesh_net:
+		return
+
+	if object_path == mesh_net[2]:
+		print('Service was removed')
+		mainloop.quit()
+
+class Application(dbus.service.Object):
+
+	def __init__(self, bus):
+		self.path = '/example'
+		self.elements = []
+		dbus.service.Object.__init__(self, bus, self.path)
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
+	@dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+	def GetManagedObjects(self):
+		response = {}
+		print('GetManagedObjects')
+		for element in self.elements:
+			response[element.get_path()] = element.get_properties()
+		return response
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
+				MESH_ELEMENT_IFACE: {
+				'Index': dbus.Byte(self.index),
+				'Models': dbus.Array(
+					self._get_sig_models(), signature='q')
+				}
+		}
+
+	def add_model(self, model):
+		model.set_path(self.path)
+		self.models.append(model)
+
+	def get_index(self):
+		return self.index
+
+	def set_model_config(self, config):
+		print('Set element models config')
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
+	def get_path(self):
+		return dbus.ObjectPath(self.path)
+
+class Model():
+	def __init__(self, model_id):
+		self.cmd_ops = []
+		self.model_id = model_id
+		self.vendor = VENDOR_ID_NONE
+		self.path = None
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
+		print('Model process message')
+
+	def set_publication(self, period):
+		self.period = period
+
+	def set_bindings(self, bindings):
+		self.bindings = bindings
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
+class OnOffClient(Model):
+	def __init__(self, model_id):
+		Model.__init__(self, model_id)
+		self.cmd_ops = { 0x8201, # get
+						 0x8202, # set
+						 0x8203 } # set unacknowledged
+		print('OnOff Client')
+
+	def _reply_cb(state):
+		print('State ', end='');
+		print(state)
+
+	def _send_message(self, dest, key, data, reply_cb):
+		print('OnOffClient send data')
+		node.Send(self.path, dest, key, data, reply_handler=reply_cb,
+				  error_handler=error_cb)
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
+		print('OnOffClient process message len ', end = '')
+		datalen = len(data)
+		print(datalen)
+
+		if datalen!=3:
+			return
+
+		opcode, state=struct.unpack('<HB',bytes(data))
+		if opcode != 0x8202 :
+			print('Bad opcode ', end='')
+			print(hex(opcode))
+			return
+
+		print('Got state ', end = '')
+		print(hex(state))
+
+def attach_app_error_cb(error):
+	print('Failed to register application: ' + str(error))
+	mainloop.quit()
+
+def main():
+
+	DBusGMainLoop(set_as_default=True)
+
+	global bus
+	bus = dbus.SystemBus()
+	global mainloop
+	global app
+
+	mesh_net = dbus.Interface(bus.get_object(MESH_SERVICE_NAME,
+							"/org/bluez/mesh"),
+							MESH_NETWORK_IFACE)
+	mesh_net.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
+
+	app = Application(bus)
+	first_ele = Element(bus, 0x00)
+	first_ele.add_model(OnOffClient(0x1001))
+	app.add_element(first_ele)
+
+	mainloop = GObject.MainLoop()
+
+	print('Attach')
+	mesh_net.Attach(app.get_path(), token,
+					reply_handler=attach_app_cb,
+					error_handler=attach_app_error_cb)
+	mainloop.run()
+
+if __name__ == '__main__':
+	main()
diff --git a/mesh/example-onoff-server b/mesh/example-onoff-server
new file mode 100644
index 000000000..131b6415c
--- /dev/null
+++ b/mesh/example-onoff-server
@@ -0,0 +1,365 @@
+#!/usr/bin/env python3
+
+import sys
+import struct
+import numpy
+import dbus
+import dbus.service
+import dbus.exceptions
+
+from threading import Timer
+import time
+
+
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+from dbus.mainloop.glib import DBusGMainLoop
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
+
+token = numpy.uint64(0x76bd4f2372476578)
+
+def generic_error_cb(error):
+	print('D-Bus call failed: ' + str(error))
+
+def generic_reply_cb():
+	print('D-Bus call done')
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
+	print('Dictionary item not handled')
+	print(type(item))
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
+	print("Get Elements")
+
+	for el in els:
+		idx = struct.unpack('b', el[0])[0]
+		print('Configuration for Element ', end='')
+		print(idx)
+
+		models = el[1]
+		element = app.get_element(idx)
+		element.set_model_config(models)
+
+def interfaces_removed_cb(object_path, interfaces):
+	if not mesh_net:
+		return
+
+	if object_path == mesh_net[2]:
+		print('Service was removed')
+		mainloop.quit()
+
+def send_response(path, dest, key, data):
+		print('send response ', end='')
+		print(data)
+		node.Send(path, dest, key, data, reply_handler=generic_reply_cb,
+						error_handler=generic_error_cb)
+
+def send_publication(path, model_id, data):
+		print('send publication ', end='')
+		print(data)
+		node.Publish(path, model_id, data,
+						reply_handler=generic_reply_cb,
+						error_handler=generic_error_cb)
+
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
+		print('Cancel timer')
+		if self.thread is not None:
+			print('Cancel thread')
+			self.thread.cancel()
+			self.thread = None
+
+class Application(dbus.service.Object):
+
+	def __init__(self, bus):
+		self.path = '/example'
+		self.elements = []
+		dbus.service.Object.__init__(self, bus, self.path)
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
+		print('GetManagedObjects')
+		response[self.path] = self.get_properties()
+		for element in self.elements:
+			response[element.get_path()] = element.get_properties()
+		return response
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
+		print('Set element models config')
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
+		print('Model process message')
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
+class OnOffServer(Model):
+	def __init__(self, model_id):
+		Model.__init__(self, model_id)
+		self.cmd_ops = { 0x8201, # get
+						 0x8202, # set
+						 0x8203 } # set unacknowledged
+
+		print("OnOff Server ", end="")
+		self.state = 0
+		print('State ', end='')
+		self.timer = PubTimer()
+
+	def process_message(self, source, key, data):
+		datalen = len(data)
+		print('OnOff Server process message len ', datalen)
+
+		if datalen!=2 and datalen!=3:
+			return
+
+		if datalen==2:
+			op_tuple=struct.unpack('<H',bytes(data))
+			opcode = op_tuple[0]
+			if opcode != 0x8201:
+				print(hex(opcode))
+				return
+			print('Get state')
+		elif datalen==3:
+			opcode,self.state=struct.unpack('<HB',bytes(data))
+			if opcode != 0x8202 and opcode != 0x8203:
+				print(hex(opcode))
+				return
+			print('Set state: ', end='')
+			print(self.state)
+
+		rsp_data = struct.pack('<HB', 0x8204, self.state)
+		send_response(self.path, source, key, rsp_data)
+
+	def publish(self):
+		print('Publish')
+		data = struct.pack('B', self.state)
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
+def attach_app_error_cb(error):
+	print('Failed to register application: ' + str(error))
+	mainloop.quit()
+
+def main():
+
+	DBusGMainLoop(set_as_default=True)
+
+	global bus
+	bus = dbus.SystemBus()
+	global mainloop
+	global app
+
+	mesh_net = dbus.Interface(bus.get_object(MESH_SERVICE_NAME,
+						"/org/bluez/mesh"),
+						MESH_NETWORK_IFACE)
+	mesh_net.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
+
+	app = Application(bus)
+	first_ele = Element(bus, 0x00)
+	first_ele.add_model(OnOffServer(0x1000))
+	app.add_element(first_ele)
+
+	mainloop = GObject.MainLoop()
+
+	print('Attach')
+	mesh_net.Attach(app.get_path(), token,
+					reply_handler=attach_app_cb,
+					error_handler=attach_app_error_cb)
+
+	mainloop.run()
+
+if __name__ == '__main__':
+	main()
-- 
2.14.5

