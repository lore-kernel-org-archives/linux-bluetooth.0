Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72D3C4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 18:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE74721A4A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 18:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfIZSPI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:15:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:23188 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbfIZSPI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 14:15:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 11:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="196461224"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.25.152])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2019 11:15:07 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v3 1/3] mesh: Add remote boolean to DevKey transactions
Date:   Thu, 26 Sep 2019 11:14:42 -0700
Message-Id: <20190926181444.4916-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926181444.4916-1-brian.gix@intel.com>
References: <20190926181444.4916-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DevKey operations require authorization on the part of the applications
making the requests. Messages to state changing Servers should use
device keys from the remote (destination) to demonstrate authorization.
---
 doc/mesh-api.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 9b9f4e3de..a589616eb 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -245,7 +245,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound
 
-	void DevKeySend(object element_path, uint16 destination,
+	void DevKeySend(object element_path, uint16 destination, boolean remote,
 					uint16 net_index, array{byte} data)
 
 		This method is used to send a message originated by a local
@@ -259,6 +259,12 @@ Methods:
 		destination must be a uint16 to a unicast address, or a well
 		known group address.
 
+		The remote parameter, if true, looks up the device key by the
+		destination address in the key database to encrypt the message.
+		If remote is true, but requested key does not exist, a NotFound
+		error will be returned. If set to false, the local node's
+		device key is used.
+
 		The net_index parameter is the subnet index of the network on
 		which the message is to be sent.
 
@@ -782,8 +788,8 @@ Methods:
 
 		The data parameter is the incoming message.
 
-	void DevKeyMessageReceived(uint16 source, uint16 net_index,
-							array{byte} data)
+	void DevKeyMessageReceived(uint16 source, boolean remote,
+					uint16 net_index, array{byte} data)
 
 		This method is called by meshd daemon when a message arrives
 		addressed to the application, which was sent with the remote
@@ -792,6 +798,11 @@ Methods:
 		The source parameter is unicast address of the remote
 		node-element that sent the message.
 
+		The remote parameter if true indicates that the device key
+		used to decrypt the message was from the sender. False
+		indicates that the local nodes device key was used, and the
+		message has permissions to modify local states.
+
 		The net_index parameter indicates what subnet the message was
 		received on, and if a response is required, the same subnet
 		must be used to send the response.
-- 
2.21.0

