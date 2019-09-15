Return-Path: <SRS0=ezyT=XK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8B6C4CECC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA1421479
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 08:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfIOIOU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Sep 2019 04:14:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:61783 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfIOIOU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Sep 2019 04:14:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2019 01:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="385906896"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.80.76])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2019 01:14:18 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 1/1] mesh: Add local/remote bools to DevKey transactions
Date:   Sun, 15 Sep 2019 01:14:08 -0700
Message-Id: <20190915081408.18116-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915081408.18116-1-brian.gix@intel.com>
References: <20190915081408.18116-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DevKey operations require authorization on the part of the applications
making the requests. Messages to state changing Servers should use keys
from the local Key Database to demonstrate authority.
---
 doc/mesh-api.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 9b9f4e3de..be2a337ba 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -245,7 +245,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound
 
-	void DevKeySend(object element_path, uint16 destination,
+	void DevKeySend(object element_path, uint16 destination, bool remote,
 					uint16 net_index, array{byte} data)
 
 		This method is used to send a message originated by a local
@@ -259,6 +259,11 @@ Methods:
 		destination must be a uint16 to a unicast address, or a well
 		known group address.
 
+		The remote parameter, if true, looks up the destination address
+		in the key database to encrypt the message.  If false the local
+		device key is used. If remote is true, but requested key does
+		not exist, a NotFound error will be returned.
+
 		The net_index parameter is the subnet index of the network on
 		which the message is to be sent.
 
@@ -782,7 +787,7 @@ Methods:
 
 		The data parameter is the incoming message.
 
-	void DevKeyMessageReceived(uint16 source, uint16 net_index,
+	void DevKeyMessageReceived(uint16 source, bool local, uint16 net_index,
 							array{byte} data)
 
 		This method is called by meshd daemon when a message arrives
@@ -792,6 +797,10 @@ Methods:
 		The source parameter is unicast address of the remote
 		node-element that sent the message.
 
+		The local parameter if true indicates that the local device key
+		was used to decrypt the message. False indicates that the remote
+		nodes device key was used.
+
 		The net_index parameter indicates what subnet the message was
 		received on, and if a response is required, the same subnet
 		must be used to send the response.
-- 
2.21.0

