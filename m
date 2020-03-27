Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB50EC2D0ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914BE20716
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgC0SnB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:43:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:39636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgC0SnA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:43:00 -0400
IronPort-SDR: 1f00v4qcTVXBQtrts7dFNfrrZHW6Hc/ApR6kcMCUlA3Yl01upcZp0a3mrwUMPBAbHEmN6EvXqX
 9l256ifMvyDA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 11:43:00 -0700
IronPort-SDR: tNvglQU9+VsBd02VFUQouPzmOaMmyE8vIXGSh5E5q52lMIiKr8ulvAJ8/xFXhkWI19C2cGURcI
 WuNV3S7T90yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="421193651"
Received: from ingas-nuc1.sea.intel.com ([10.251.8.23])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 11:43:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/4] test/test-mesh: Update to match modified APIs
Date:   Fri, 27 Mar 2020 11:42:56 -0700
Message-Id: <20200327184257.15042-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327184257.15042-1-inga.stotland@intel.com>
References: <20200327184257.15042-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This handles updated parameter list in UnprovisionedScan(),
AddNode() and ScanResult() D-Bus methods
---
 test/test-mesh | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 6a5ddbd17..5db1d6d1a 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -474,13 +474,22 @@ class Application(dbus.service.Object):
 	def JoinFailed(self, value):
 		print(set_error('JoinFailed '), value)
 
-	@dbus.service.method(MESH_PROV_IFACE,
-					in_signature="nay", out_signature="")
-	def ScanResult(self, rssi, uuid):
-		uuid_str = array_to_string(uuid)
-		print(set_yellow('ScanResult RSSI ')
-					+ set_green(format(rssi, 'd'))
-					+ ' ' + uuid_str)
+	@dbus.service.method(MESH_PROV_IFACE, in_signature="naya{sv}",
+							out_signature="")
+	def ScanResult(self, rssi, data, options):
+		global remote_uuid
+		remote_uuid = data[:16]
+		uuid_str = array_to_string(remote_uuid)
+		data_str = array_to_string(data[16:])
+		if len(data_str) == 0:
+			data_str = 'Not Present'
+
+		print(set_yellow('ScanResult >> RSSI: ') +
+					set_green(format(rssi, 'd')) +
+					set_yellow(format(' UUID: ')) +
+					set_green(format(uuid_str, 's')) +
+					set_yellow(format(' OOB Data: ')) +
+					set_green(format(data_str, 's')))
 
 	@dbus.service.method(MESH_PROV_IFACE,
 					in_signature="y", out_signature="qq")
@@ -946,8 +955,6 @@ class MainMenu(Menu):
 		uuid = bytearray.fromhex("0a0102030405060708090A0B0C0D0E0F")
 		random.shuffle(uuid)
 		uuid_str = array_to_string(uuid)
-		caps = ["out-numeric"]
-		oob = ["other"]
 
 		print(set_yellow('Joining with UUID ') + set_green(uuid_str))
 		mesh_net.Join(app.get_path(), uuid,
@@ -955,23 +962,27 @@ class MainMenu(Menu):
 			error_handler=join_error_cb)
 
 	def __cmd_scan(self):
+		options = {}
+		options['Seconds'] = dbus.UInt16(0)
 
 		print(set_yellow('Scanning...'))
-		node_mgr.UnprovisionedScan(0, reply_handler=add_cb,
-						error_handler=add_error_cb)
+		node_mgr.UnprovisionedScan(options,
+						reply_handler=scan_cb,
+						error_handler=scan_error_cb)
 
 	def __cmd_add(self):
 		global user_input
+		global remote_uuid
+
 		if agent == None:
 			print(set_error('Provisioning agent not found'))
 			return
 
 		uuid_str = array_to_string(remote_uuid)
-		caps = ["in-numeric"]
-		oob = ["other"]
+		options = {}
 
 		print(set_yellow('Adding dev UUID ') + set_green(uuid_str))
-		node_mgr.AddNode(remote_uuid, reply_handler=add_cb,
+		node_mgr.AddNode(remote_uuid, options, reply_handler=add_cb,
 						error_handler=add_error_cb)
 
 	def __cmd_attach(self):
-- 
2.21.1

