Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FEEC433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300AA2078B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 16:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgHZQya (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:54:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:2013 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHZQy2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 12:54:28 -0400
IronPort-SDR: WOqB0djzFbAMI4L+6+RW7vQuJ3oczcIfiO1RwsHqDGjDPNvriA199pWDloFbqfiH3h5X77Sqf1
 +ZUvSK2h3nOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135883620"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="135883620"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:54:26 -0700
IronPort-SDR: 1NrtchoYKWVy1BodSFizdexLSq/KkxeGhSBjF00u1l4+t4OmEDJ+UZLqsB4e+c69Nk7rJ8OYhW
 6HKZ3XT+SpRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="331851961"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.63.130])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 09:54:26 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 1/4] doc/mesh-api: Add "options" dictionary to Send/Publish
Date:   Wed, 26 Aug 2020 09:54:17 -0700
Message-Id: <20200826165420.563822-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200826165420.563822-1-brian.gix@intel.com>
References: <20200826165420.563822-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

This modifies Send, DevKeySend and Publish methods
on mesh.Node interface to include additional argument "options".
This new argument is a dictionary that currently has only one
new key word defined for Send() and DevKeySend():
    "ForceSegmented" - to force small payloads to be sent as
    		      one-segment messages

In case of Publish(), and additional keyword is defined
     "Vendor" -  16-bit Company ID as defined by the Bluetooth SIG

Other key words may be defined in future to accommodate evolving
requirements of Mesh Profile specification.

Also, the addition of "options" dictionary to Publish allows to
eliminate VendorPublish() method (taken care by "Vendor" keyword).
---
 doc/mesh-api.txt | 60 ++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 495f95b0b..254ccbd7f 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -229,7 +229,7 @@ Object path	/org/bluez/mesh/node<uuid>
 
 Methods:
 	void Send(object element_path, uint16 destination, uint16 key_index,
-							array{byte} data)
+						dict options, array{byte} data)
 
 		This method is used to send a message originated by a local
 		model.
@@ -248,6 +248,14 @@ Methods:
 		this element. Otherwise, org.bluez.mesh.Error.NotAuthorized will
 		be returned.
 
+		The options parameter is a dictionary with the following keys
+		defined:
+
+			bool ForceSegmented
+				Specifies whether to force sending of a short
+				message as one-segment payload. If not present,
+				the default setting is "false".
+
 		The data parameter is an outgoing message to be encypted by the
 		bluetooth-meshd daemon and sent on.
 
@@ -257,7 +265,7 @@ Methods:
 			org.bluez.mesh.Error.NotFound
 
 	void DevKeySend(object element_path, uint16 destination, boolean remote,
-					uint16 net_index, array{byte} data)
+			uint16 net_index, dict options, array{byte} data)
 
 		This method is used to send a message originated by a local
 		model encoded with the device key of the remote node.
@@ -279,6 +287,14 @@ Methods:
 		The net_index parameter is the subnet index of the network on
 		which the message is to be sent.
 
+		The options parameter is a dictionary with the following keys
+		defined:
+
+			bool ForceSegmented
+				Specifies whether to force sending of a short
+				message as one-segment payload. If not present,
+				the default setting is "false".
+
 		The data parameter is an outgoing message to be encypted by the
 		meshd daemon and sent on.
 
@@ -344,7 +360,8 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound
 
-	void Publish(object element_path, uint16 model, array{byte} data)
+	void Publish(object element_path, uint16 model, dict options,
+							array{byte} data)
 
 		This method is used to send a publication originated by a local
 		model. If the model does not exist, or it has no publication
@@ -356,32 +373,24 @@ Methods:
 		Hierarchy section).
 
 		The model parameter contains a model ID, as defined by the
-		Bluetooth SIG.
-
-		Since only one Publish record may exist per element-model, the
-		destination and key_index are obtained from the Publication
-		record cached by the daemon.
+		Bluetooth SIG. If the options dictionary contains a "Vendor"
+		key, then this ID is defined by the specified vendor.
 
-		Possible errors:
-			org.bluez.mesh.Error.DoesNotExist
-			org.bluez.mesh.Error.InvalidArguments
-
-	void VendorPublish(object element_path, uint16 vendor, uint16 model_id,
-							array{byte} data)
-
-		This method is used to send a publication originated by a local
-		vendor model. If the model does not exist, or it has no
-		publication record, the method returns
-		org.bluez.mesh.Error.DoesNotExist error.
+		The options parameter is a dictionary with the following keys
+		defined:
 
-		The element_path parameter is the object path of an element from
-		a collection of the application elements (see Mesh Application
-		Hierarchy section).
+			bool ForceSegmented
+				Specifies whether to force sending of a short
+				message as one-segment payload. If not present,
+				the default setting is "false".
 
-		The vendor parameter is a 16-bit Bluetooth-assigned Company ID.
+			uint16 Vendor
+				A 16-bit Company ID as defined by the
+				Bluetooth SIG. This key should only exist when
+				publishing on a Vendor defined model.
 
-		The model_id parameter is a 16-bit vendor-assigned Model
-		Identifier.
+		The data parameter is an outgoing message to be encypted by the
+		meshd daemon and sent on.
 
 		Since only one Publish record may exist per element-model, the
 		destination and key_index are obtained from the Publication
@@ -391,6 +400,7 @@ Methods:
 			org.bluez.mesh.Error.DoesNotExist
 			org.bluez.mesh.Error.InvalidArguments
 
+
 Properties:
 	dict Features [read-only]
 
-- 
2.25.4

