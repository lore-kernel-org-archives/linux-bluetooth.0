Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ED2C54FC9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 20:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2A0206B8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 20:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDUUIp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:08:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:24510 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDUUIo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 16:08:44 -0400
IronPort-SDR: uZ7RNuJVXCqjjT2cfotgXs9RlrbZM1HtM91HKa3XNv/zJJu4F7e+2lSTmBV6VqfbG3lAh1u6mY
 DdpoNRh5G2uw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 13:08:44 -0700
IronPort-SDR: cDMvg18TRwKD1m2Jfo4d/N9O9PbC7K2Zn3wuJMV364RLfJgHeghRnAWS3BVhCu1iE2QYOVIPQP
 juEeH5Xlw1Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="258827228"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.29.188])
  by orsmga006.jf.intel.com with ESMTP; 21 Apr 2020 13:08:43 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] test/mesh: Remove Provisioner interface
Date:   Tue, 21 Apr 2020 13:08:37 -0700
Message-Id: <20200421200837.4172-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change removes the Provisioner Initiator from the python test
script, along with the menu commands for create, scan and add. This
makes it a cleaner Python3 example of a simple On/Off node, and a
fuller featured Provisioner/Config Client still exists in the tools
subdirectory.
---
 test/test-mesh | 142 +------------------------------------------------
 1 file changed, 2 insertions(+), 140 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 6a607835c..66055e2de 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -23,9 +23,6 @@
 #
 # The main menu:
 #       token
-#       create
-#       scan
-#       add
 #       join
 #       attach
 #       remove
@@ -41,28 +38,6 @@
 #            The token can be set from command line arguments as
 #            well.
 #
-#     create
-#            Creates a new mesh network, with its first local
-#            node. The test generates device UUID to store for
-#            the initial node, and the daemon will create all
-#            the other parameters including Unicast address 0x0001
-#            for the new nodes primary element.
-#            In case of successful creation, the application
-#            automatically attaches as a node to the daemon. A node
-#            'token' is returned to the application and is used
-#            for the runtime of the test, and may be used in future
-#            attach requests.
-#
-#     scan
-#            Scan for unprovisioned devices
-#
-#     add
-#            Adds a remote node to a mesh network that we have provisioning
-#            authorization to. The test prompts for a remote devices
-#            UUID, and supplies an Agent that will handle the interaction,
-#            and provide the provisioning data which will complete to
-#            process.
-#
 #     join
 #            Request provisioning of a device to become a node
 #            on a mesh network. The test generates device UUID
@@ -83,8 +58,8 @@
 #            For the call to be successful, the valid node token must
 #            be already set, either from command arguments or by
 #            executing "set token" operation or automatically after
-#            successfully executing "join" or "create" operation in
-#            the same test run.
+#            successfully executing "join" operation in the same
+#            test run.
 #
 #     remove
 #           Permanently removes any node configuration from daemon
@@ -163,7 +138,6 @@ MESH_MGR_IFACE = 'org.bluez.mesh.Management1'
 MESH_NETWORK_IFACE = 'org.bluez.mesh.Network1'
 MESH_NODE_IFACE = 'org.bluez.mesh.Node1'
 MESH_APPLICATION_IFACE = 'org.bluez.mesh.Application1'
-MESH_PROV_IFACE = 'org.bluez.mesh.Provisioner1'
 MESH_ELEMENT_IFACE = 'org.bluez.mesh.Element1'
 
 APP_COMPANY_ID = 0x05f1
@@ -281,40 +255,12 @@ def attach(token):
 					reply_handler=attach_app_cb,
 					error_handler=attach_app_error_cb)
 
-def scan_cb():
-	print('Scan procedure started')
-
-def scan_error_cb(reason):
-	print('Scan procedure failed ', reason)
-
-def add_cb():
-	print('AddNode procedure started')
-
-def add_error_cb(reason):
-	print('AddNode procedure failed ', reason)
-
 def join_cb():
 	print('Join procedure started')
 
 def join_error_cb(reason):
 	print('Join procedure failed: ', reason)
 
-def create_cb(value):
-	global token
-	global have_token
-	global attach
-
-	print(set_yellow('Created mesh network with token ') +
-			set_green(format(value, '016x')))
-
-	token = value
-	have_token = True
-	if attached == False:
-		attach(token)
-
-def create_error_cb(reason):
-	print('Create procedure failed: ', reason)
-
 def remove_node_cb():
 	global attached
 	global have_token
@@ -440,8 +386,6 @@ class Application(dbus.service.Object):
 				'CompanyID': dbus.UInt16(APP_COMPANY_ID),
 				'ProductID': dbus.UInt16(APP_PRODUCT_ID),
 				'VersionID': dbus.UInt16(APP_VERSION_ID)
-			},
-			MESH_PROV_IFACE: {
 			}
 		}
 
@@ -474,44 +418,6 @@ class Application(dbus.service.Object):
 	def JoinFailed(self, value):
 		print(set_error('JoinFailed '), value)
 
-	@dbus.service.method(MESH_PROV_IFACE, in_signature="naya{sv}",
-							out_signature="")
-	def ScanResult(self, rssi, data, options):
-		global remote_uuid
-		remote_uuid = data[:16]
-		uuid_str = array_to_string(remote_uuid)
-		data_str = array_to_string(data[16:])
-		if len(data_str) == 0:
-			data_str = 'Not Present'
-
-		print(set_yellow('ScanResult >> RSSI: ') +
-					set_green(format(rssi, 'd')) +
-					set_yellow(format(' UUID: ')) +
-					set_green(format(uuid_str, 's')) +
-					set_yellow(format(' OOB Data: ')) +
-					set_green(format(data_str, 's')))
-
-	@dbus.service.method(MESH_PROV_IFACE,
-					in_signature="y", out_signature="qq")
-	def RequestProvData(self, count):
-		print('RequestProvData for Ele_Cnt '
-					+ set_green(format(count, 'd')))
-		return dbus.Struct((dbus.UInt16(0), dbus.UInt16(678)))
-
-	@dbus.service.method(MESH_PROV_IFACE,
-					in_signature="ayqy", out_signature="")
-	def AddNodeComplete(self, uuid, unicast, count):
-		uuid_str = array_to_string(uuid)
-		print(set_yellow('AddNodeComplete of node ')
-					+ set_green(format(unicast, '04x'))
-					+ ' uuid ' + uuid_str)
-
-	@dbus.service.method(MESH_PROV_IFACE,
-					in_signature="ays", out_signature="")
-
-	def AddNodeFailed(self, uuid, value):
-		print(set_error('AddNodeFailed '), value)
-
 
 class Element(dbus.service.Object):
 	PATH_BASE = '/example/ele'
@@ -866,12 +772,6 @@ class MainMenu(Menu):
 		menu_items = {
 			'token': MenuItem(' - set node ID (token)',
 						self.__cmd_set_token),
-			'create': MenuItem(' - create mesh network',
-						self.__cmd_create),
-			'scan': MenuItem(' - scan for near unprovisioned devs',
-						self.__cmd_scan),
-			'add': MenuItem(' - add device to mesh network',
-						self.__cmd_add),
 			'join': MenuItem(' - join mesh network',
 						self.__cmd_join),
 			'attach': MenuItem(' - attach mesh node',
@@ -933,20 +833,6 @@ class MainMenu(Menu):
 		user_input = INPUT_MESSAGE_PAYLOAD;
 		print(set_cyan('Enter message payload (hex):'))
 
-	def __cmd_create(self):
-		if agent == None:
-			print(set_error('Provisioning agent not found'))
-			return
-
-		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
-		random.shuffle(uuid)
-		uuid_str = array_to_string(uuid)
-
-		print(set_yellow('Creating with UUID ') + set_green(uuid_str))
-		mesh_net.CreateNetwork(app.get_path(), uuid,
-			reply_handler=create_cb,
-			error_handler=create_error_cb)
-
 	def __cmd_join(self):
 		if agent == None:
 			print(set_error('Provisioning agent not found'))
@@ -961,30 +847,6 @@ class MainMenu(Menu):
 			reply_handler=join_cb,
 			error_handler=join_error_cb)
 
-	def __cmd_scan(self):
-		options = {}
-		options['Seconds'] = dbus.UInt16(0)
-
-		print(set_yellow('Scanning...'))
-		node_mgr.UnprovisionedScan(options,
-						reply_handler=scan_cb,
-						error_handler=scan_error_cb)
-
-	def __cmd_add(self):
-		global user_input
-		global remote_uuid
-
-		if agent == None:
-			print(set_error('Provisioning agent not found'))
-			return
-
-		uuid_str = array_to_string(remote_uuid)
-		options = {}
-
-		print(set_yellow('Adding dev UUID ') + set_green(uuid_str))
-		node_mgr.AddNode(remote_uuid, options, reply_handler=add_cb,
-						error_handler=add_error_cb)
-
 	def __cmd_attach(self):
 		if have_token == False:
 			print(set_error('Token is not set'))
-- 
2.21.1

