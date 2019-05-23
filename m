Return-Path: <SRS0=5U9h=TX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD9C282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D57C2177E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 May 2019 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfEWQNt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 May 2019 12:13:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:52915 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfEWQNt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 May 2019 12:13:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 09:13:48 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.78.4])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2019 09:13:48 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 1/6] mesh: Add new method for Key Refresh procedure
Date:   Thu, 23 May 2019 09:13:24 -0700
Message-Id: <20190523161329.13017-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190523161329.13017-1-brian.gix@intel.com>
References: <20190523161329.13017-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new method CompleteAppKeyUpdate() on
org.bluez.mesh.Management1 interface to be used by the application
at the completion of a Key Refresh procedure. This method should
be called for each app key that is being updated during the
procedure, and must be performed prior to changing the phase of
the bound net key to phase 3.
---
 doc/mesh-api.txt | 66 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 112990a5d..2a800468b 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -24,10 +24,10 @@ Methods:
 		DBus.ObjectManager interface must be available on the
 		app_defined_root path.
 
-		The uuid parameter is a 16-byte array that contains Device UUID. This
-		UUID must be unique (at least from the daemon perspective), therefore
-		attempting to call this function using already registered UUID results
-		in an error.
+		The uuid parameter is a 16-byte array that contains Device UUID.
+		This UUID must be unique (at least from the daemon perspective),
+		therefore attempting to call this function using already
+		registered UUID results in an error.
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
@@ -131,10 +131,10 @@ Methods:
 		interface. The standard DBus.ObjectManager interface must be
 		available on the app_root path.
 
-		The uuid parameter is a 16-byte array that contains Device UUID. This
-		UUID must be unique (at least from the daemon perspective), therefore
-		attempting to call this function using already registered UUID results
-		in an error.
+		The uuid parameter is a 16-byte array that contains Device UUID.
+		This UUID must be unique (at least from the daemon perspective),
+		therefore attempting to call this function using already
+		registered UUID results in an error.
 
 		The returned token must be preserved by the application in
 		order to authenticate itself to the mesh daemon and attach to
@@ -168,8 +168,8 @@ Methods:
 		permanently remove the identity of the mesh node by calling
 		Leave() method.
 
-		It is an error to attempt importing a node with already registered
-		Device UUID.
+		It is an error to attempt importing a node with already
+		registered Device UUID.
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments,
@@ -182,8 +182,8 @@ Mesh Node Hierarchy
 Service		org.bluez.mesh
 Interface	org.bluez.mesh.Node1
 Object path	/org/bluez/mesh/node<uuid>
-		where <uuid> is the Device UUID passed to Join(), CreateNetwork() or
-		ImportLocalNode()
+		where <uuid> is the Device UUID passed to Join(),
+		CreateNetwork() or ImportLocalNode()
 
 Methods:
 	void Send(object element_path, uint16 destination, uint16 key_index,
@@ -348,8 +348,8 @@ Mesh Provisioning Hierarchy
 Service		org.bluez.mesh
 Interface	org.bluez.mesh.Management1
 Object path	/org/bluez/mesh/node<uuid>
-		where <uuid> is the Device UUID passed to Join(), CreateNetwork() or
-		ImportLocalNode()
+		where <uuid> is the Device UUID passed to Join(),
+		CreateNetwork() or ImportLocalNode()
 
 Methods:
 	void UnprovisionedScan(uint16 seconds)
@@ -400,6 +400,7 @@ Methods:
 		This call affects the local bluetooth-meshd key database only.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists
 
@@ -417,6 +418,7 @@ Methods:
 		This call affects the local bluetooth-meshd key database only.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists
 
@@ -432,8 +434,10 @@ Methods:
 		This call affects the local bluetooth-meshd key database only.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.DoesNotExist
+			org.bluez.mesh.Error.Busy
 
 	void DeleteSubnet(uint16 net_index)
 
@@ -447,11 +451,12 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
-			org.bluez.mesh.Error.DoesNotExist
 
 	void SetKeyPhase(uint16 net_index, uint8 phase)
 		This method is used to set the master key update phase of the
-		given subnet.
+		given subnet. When finalizing the procedure, it is important
+		to CompleteAppKeyUpdate() on all app keys that have been
+		updated during the procedure prior to setting phase 3.
 
 		The net_index parameter is a 12-bit value (0x000-0xFFF)
 		specifying which subnet phase to set.
@@ -472,6 +477,7 @@ Methods:
 		refresh phases per the Mesh Profile Specification.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.DoesNotExist
 
@@ -489,8 +495,10 @@ Methods:
 		This call affects the local bluetooth-meshd key database only.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists
+			org.bluez.mesh.Error.DoesNotExist
 
 	void ImportAppKey(uint16 net_index, uint16 app_index,
 						array{byte}[16] app_key)
@@ -510,8 +518,10 @@ Methods:
 		This call affects the local bluetooth-meshd key database only.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.AlreadyExists
+			org.bluez.mesh.Error.DoesNotExist
 
 	void UpdateAppKey(uint16 app_index)
 
@@ -525,6 +535,27 @@ Methods:
 		This call affects the local bluetooth-meshd key database only.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
+			org.bluez.mesh.Error.InvalidArguments
+			org.bluez.mesh.Error.DoesNotExist
+			org.bluez.mesh.Error.Busy
+
+	void CompleteAppKeyUpdate(uint16 app_index)
+
+		This method is used by the application at the completion of
+		a Key Refresh Procedure.  This method should be called for each
+		app key being updated during the procedure, and must be
+		performed prior to changing the phase of the bound net key
+		to phase 3. (See SetKeyPhase() method).
+
+		The app_index parameter is a 12-bit value (0x000-0xFFF)
+		specifying which app key was updated. Note that the subnet that
+		the key is bound to must exist and be in Phase 2.
+
+		This call affects the local bluetooth-meshd key database only.
+
+		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.DoesNotExist
 
@@ -540,7 +571,6 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
-			org.bluez.mesh.Error.DoesNotExist
 
 	void ImportRemoteNode(uint16 primary, uint8 count,
 					array{byte}[16] device_key)
@@ -560,6 +590,7 @@ Methods:
 		This call affects the local bluetooth-meshd key database only.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 
 	void DeleteRemoteNode(uint16 primary, uint8 count)
@@ -577,7 +608,6 @@ Methods:
 
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
-			org.bluez.mesh.Error.DoesNotExist
 
 Properties:
 	dict Features [read-only]
-- 
2.14.5

