Return-Path: <SRS0=KRcZ=RD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC27C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 23:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E745218AE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Feb 2019 23:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbfB1XZB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:25:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:36901 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732436AbfB1XY7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Feb 2019 18:24:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 15:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="324330737"
Received: from ingas-nuc1.sea.intel.com ([10.254.180.113])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2019 15:24:59 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] doc/mesh-api: Fix Attach() method signature
Date:   Thu, 28 Feb 2019 15:24:56 -0800
Message-Id: <20190228232456.9707-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Correct return arguments for Attach() method.
Also, fix some grammar and formatting.
---
 doc/mesh-api.txt | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index e1bc3ee02..0b341a0f9 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -1,4 +1,3 @@
-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 BlueZ D-Bus Mesh API description
 ********************************
 
@@ -12,16 +11,16 @@ Methods:
 	void Join(object app_defined_root, array{byte}[16] uuid)
 
 		This is the first method that an application has to call to
-		become a provisioned node on a mesh network.  The call will
+		become a provisioned node on a mesh network. The call will
 		initiate broadcasting of Unprovisioned Device Beacon.
 
 		The app_defined_root parameter is a D-Bus object root path of
 		the application that implements org.bluez.mesh.Application1
 		interface. The application represents a node where child mesh
 		elements have their own objects that implement
-		org.bluez.mesh.Element1 interface.  The application hierarchy
+		org.bluez.mesh.Element1 interface. The application hierarchy
 		also contains a provision agent object that implements
-		org.bluez.mesh.ProvisionAgent1 interface.  The standard
+		org.bluez.mesh.ProvisionAgent1 interface. The standard
 		DBus.ObjectManager interface must be available on the
 		app_defined_root path.
 
@@ -34,8 +33,8 @@ Methods:
 		Cancels an outstanding provisioning request initiated by Join()
 		method.
 
-	(object node, array{byte, array{(uint16, dict}} configuration)
-				Attach(object app_defined_root, uint64 token)
+	object node, array{byte, array{(uint16, dict)}} configuration
+			Attach(object app_defined_root, uint64 token)
 
 		This is the first method that an application must call to get
 		access to mesh node functionalities.
@@ -58,13 +57,13 @@ Methods:
 		(see Mesh Node Hierarchy section) and current configuration
 		settings. The return value of configuration parameter is an
 		array, where each entry is a structure that contains element
-		configuration.  The element configuration structure is organized
+		configuration. The element configuration structure is organized
 		as follows:
 
 		byte
 
 			Element index, identifies the element to which this
-			configuration entry pertians.
+			configuration entry pertains.
 
 		array{struct}
 
@@ -140,7 +139,7 @@ Methods:
 		be returned.
 
 		The data parameter is an outgoing message to be encypted by the
-		meshd daemon and sent on.
+		bluetooth-meshd daemon and sent on.
 
 		Possible errors:
 			org.bluez.mesh.Error.NotAuthorized
@@ -308,8 +307,8 @@ Methods:
 	void MessageReceived(uint16 source, uint16 key_index,
 					boolean subscription, array{byte} data)
 
-		This method is called by meshd daemon when a message arrives
-		addressed to the application.
+		This method is called by bluetooth-meshd daemon when a message
+		arrives addressed to the application.
 
 		The source parameter is unicast address of the remote
 		node-element that sent the message.
@@ -328,7 +327,7 @@ Methods:
 
 	void UpdateModelConfiguration(uint16 model_id, dict config)
 
-		This method is called by meshd daemon when a model's
+		This method is called by bluetooth-meshd daemon when a model's
 		configuration is updated.
 
 		The model_id parameter contains BT SIG Model Identifier or, if
-- 
2.17.2

