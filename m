Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6159C74A36
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05120838
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfGJXIg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:08:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:52368 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJXIg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 19:08:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 16:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="186250437"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 16:08:35 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ 8/8] test: This extends the mesh tool to exercise Provisioning methods
Date:   Wed, 10 Jul 2019 16:07:57 -0700
Message-Id: <20190710230757.8425-9-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190710230757.8425-1-brian.gix@intel.com>
References: <20190710230757.8425-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Note:  This script is *not* a suitable tool for expanding into
a Mesh Provisioner. It is only intended to demonstrate the arguments
and methods required.
---
 test/test-mesh | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/test/test-mesh b/test/test-mesh
index 4d515e186..b655d7b3d 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -24,10 +24,13 @@
 # The main menu:
 #       token
 #       create
+#       scan
+#       add
 #       join
 #       attach
 #       remove
 #       dest
+#       uuid
 #       app-index
 #       client-menu
 #       exit
@@ -50,6 +53,16 @@
 #            for the runtime of the test, and may be used in future
 #            attach requests.
 #
+#     scan
+#            Scan for unprovisioned devices
+#
+#     add
+#            Adds a remote node to a mesh network that we have provisioning
+#            authorization to. The test prompts for a remote devices
+#            UUID, and supplies an Agent that will handle the interaction,
+#            and provide the provisioning data which will complete to
+#            process.
+#
 #     join
 #            Request provisioning of a device to become a node
 #            on a mesh network. The test generates device UUID
@@ -145,9 +158,11 @@ MESH_SERVICE_NAME = 'org.bluez.mesh'
 DBUS_PROP_IFACE = 'org.freedesktop.DBus.Properties'
 DBUS_OM_IFACE = 'org.freedesktop.DBus.ObjectManager'
 
+MESH_MGR_IFACE = 'org.bluez.mesh.Management1'
 MESH_NETWORK_IFACE = 'org.bluez.mesh.Network1'
 MESH_NODE_IFACE = 'org.bluez.mesh.Node1'
 MESH_APPLICATION_IFACE = 'org.bluez.mesh.Application1'
+MESH_PROV_IFACE = 'org.bluez.mesh.Provisioner1'
 MESH_ELEMENT_IFACE = 'org.bluez.mesh.Element1'
 
 APP_COMPANY_ID = 0x05f1
@@ -160,6 +175,7 @@ app = None
 bus = None
 mainloop = None
 node = None
+node_mgr = None
 mesh_net = None
 
 dst_addr = 0x0000
@@ -170,6 +186,10 @@ token = None
 have_token = False
 attached = False
 
+# Remote device UUID
+have_uuid = False
+remote_uuid = None
+
 # Menu housekeeping
 MAIN_MENU = 0
 ON_OFF_CLIENT_MENU = 1
@@ -179,6 +199,7 @@ INPUT_TOKEN = 1
 INPUT_DEST_ADDRESS = 2
 INPUT_APP_KEY_INDEX = 3
 INPUT_MESSAGE_PAYLOAD = 4
+INPUT_UUID = 5
 
 menus = []
 current_menu = None
@@ -226,6 +247,17 @@ def set_token(str_value):
 	token = numpy.uint64(input_number)
 	have_token = True
 
+def set_uuid(str_value):
+	global remote_uuid
+	global have_uuid
+
+	if len(str_value) != 32:
+		raise_error('Expected 32 digits')
+		return
+
+	remote_uuid = bytearray.fromhex(str_value)
+	have_uuid = True
+
 def array_to_string(b_array):
 	str_value = ""
 	for b in b_array:
@@ -248,6 +280,18 @@ def attach(token):
 					reply_handler=attach_app_cb,
 					error_handler=attach_app_error_cb)
 
+def scan_cb():
+	print('Scan procedure started')
+
+def scan_error_cb(reason):
+	print('Scan procedure failed ', reason)
+
+def add_cb():
+	print('AddNode procedure started')
+
+def add_error_cb(reason):
+	print('AddNode procedure failed ', reason)
+
 def join_cb():
 	print('Join procedure started')
 
@@ -306,6 +350,9 @@ def attach_app_cb(node_path, dict_array):
 
 	obj = bus.get_object(MESH_SERVICE_NAME, node_path)
 
+	global node_mgr
+	node_mgr = dbus.Interface(obj, MESH_MGR_IFACE)
+
 	global node
 	node = dbus.Interface(obj, MESH_NODE_IFACE)
 
@@ -392,6 +439,8 @@ class Application(dbus.service.Object):
 				'CompanyID': dbus.UInt16(APP_COMPANY_ID),
 				'ProductID': dbus.UInt16(APP_PRODUCT_ID),
 				'VersionID': dbus.UInt16(APP_VERSION_ID)
+			},
+			MESH_PROV_IFACE: {
 			}
 		}
 
@@ -424,6 +473,35 @@ class Application(dbus.service.Object):
 	def JoinFailed(self, value):
 		print(set_error('JoinFailed '), value)
 
+	@dbus.service.method(MESH_PROV_IFACE,
+					in_signature="nay", out_signature="")
+	def ScanResult(self, rssi, uuid):
+		uuid_str = array_to_string(uuid)
+		print(set_yellow('ScanResult RSSI ')
+					+ set_green(format(rssi, 'd'))
+					+ ' ' + uuid_str)
+
+	@dbus.service.method(MESH_PROV_IFACE,
+					in_signature="y", out_signature="qq")
+	def RequestProvData(self, count):
+		print('RequestProvData for Ele_Cnt '
+					+ set_green(format(count, 'd')))
+		return dbus.Struct((dbus.UInt16(0), dbus.UInt16(678)))
+
+	@dbus.service.method(MESH_PROV_IFACE,
+					in_signature="ayqy", out_signature="")
+	def AddNodeComplete(self, uuid, unicast, count):
+		uuid_str = array_to_string(uuid)
+		print(set_yellow('AddNodeComplete of node ')
+					+ set_green(format(unicast, '04x'))
+					+ ' uuid ' + uuid_str)
+
+	@dbus.service.method(MESH_PROV_IFACE,
+					in_signature="ays", out_signature="")
+
+	def AddNodeFailed(self, uuid, value):
+		print(set_error('AddNodeFailed '), value)
+
 
 class Element(dbus.service.Object):
 	PATH_BASE = '/example/ele'
@@ -768,6 +846,10 @@ class MainMenu(Menu):
 						self.__cmd_set_token),
 			'create': MenuItem(' - create mesh network',
 						self.__cmd_create),
+			'scan': MenuItem(' - scan for near unprovisioned devs',
+						self.__cmd_scan),
+			'add': MenuItem(' - add device to mesh network',
+						self.__cmd_add),
 			'join': MenuItem(' - join mesh network',
 						self.__cmd_join),
 			'attach': MenuItem(' - attach mesh node',
@@ -776,6 +858,8 @@ class MainMenu(Menu):
 						self.__cmd_remove),
 			'dest': MenuItem(' - set destination address',
 						self.__cmd_set_dest),
+			'uuid': MenuItem(' - set remote uuid',
+						self.__cmd_set_uuid),
 			'app-index': MenuItem(' - set AppKey index',
 						self.__cmd_set_app_idx),
 			'vendor-send': MenuItem(' - send raw vendor message',
@@ -809,6 +893,12 @@ class MainMenu(Menu):
 		user_input = INPUT_DEST_ADDRESS
 		print(set_cyan('Enter 4-digit hex destination address:'))
 
+	def __cmd_set_uuid(self):
+		global user_input
+
+		user_input = INPUT_UUID
+		print(set_cyan('Enter 32-digit hex remote UUID:'))
+
 	def __cmd_set_app_idx(self):
 		global user_input
 
@@ -842,7 +932,7 @@ class MainMenu(Menu):
 
 		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
 		random.shuffle(uuid)
-		uuid_str = array_to_string(uuid)
+		uuid_str = array_to_string(remote_uuid)
 		caps = ["out-numeric"]
 		oob = ["other"]
 
@@ -851,6 +941,26 @@ class MainMenu(Menu):
 			reply_handler=join_cb,
 			error_handler=join_error_cb)
 
+	def __cmd_scan(self):
+
+		print(set_yellow('Scanning...'))
+		node_mgr.UnprovisionedScan(0, reply_handler=add_cb,
+						error_handler=add_error_cb)
+
+	def __cmd_add(self):
+		global user_input
+		if agent == None:
+			print(set_error('Provisioning agent not found'))
+			return
+
+		uuid_str = array_to_string(remote_uuid)
+		caps = ["in-numeric"]
+		oob = ["other"]
+
+		print(set_yellow('Adding dev UUID ') + set_green(uuid_str))
+		node_mgr.AddNode(remote_uuid, reply_handler=add_cb,
+						error_handler=add_error_cb)
+
 	def __cmd_attach(self):
 		if have_token == False:
 			print(set_error('Token is not set'))
@@ -887,6 +997,8 @@ class MainMenu(Menu):
 
 		if user_input == INPUT_TOKEN:
 			set_token(str_value)
+		elif user_input == INPUT_UUID:
+			set_uuid(str_value)
 		elif user_input == INPUT_DEST_ADDRESS:
 			res = set_value(str_value, 4, 4)
 			if is_error() != True:
@@ -977,6 +1089,7 @@ def main():
 	mesh_net = dbus.Interface(bus.get_object(MESH_SERVICE_NAME,
 						"/org/bluez/mesh"),
 						MESH_NETWORK_IFACE)
+
 	mesh_net.connect_to_signal('InterfacesRemoved', interfaces_removed_cb)
 
 	app = Application(bus)
-- 
2.14.5

