Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECAFC76190
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 02:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE392238C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 02:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGZCDR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jul 2019 22:03:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:27392 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfGZCDR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jul 2019 22:03:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 19:03:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="170486831"
Received: from ingas-nuc1.sea.intel.com ([10.254.183.90])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2019 19:03:16 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] doc/mesh-api: Restore properties in mesh node hierarchy
Date:   Thu, 25 Jul 2019 19:03:10 -0700
Message-Id: <20190726020310.27266-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This restores Features, Beacon, BeaconFlags, IvIndex and
SecondsSinceLAst heard properties under the
org.bluez.mesh.Node1 interface.
---
 doc/mesh-api.txt | 98 ++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index ff6b33346..7b62c0af4 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -343,6 +343,55 @@ Methods:
 			org.bluez.mesh.Error.DoesNotExist
 			org.bluez.mesh.Error.InvalidArguments
 
+Properties:
+	dict Features [read-only]
+
+		The dictionary that contains information about feature support.
+		The following keys are defined:
+
+		boolean Friend
+
+			Indicates the ability to establish a friendship with a
+			Low Power node
+
+		boolean LowPower
+
+			Indicates support for operating in Low Power node mode
+
+		boolean Proxy
+
+			Indicates support for GATT proxy
+
+		boolean Relay
+			Indicates support for relaying messages
+
+	If a key is absent from the dictionary, the feature is not supported.
+	Otherwise, true means that the feature is enabled and false means that
+	the feature is disabled.
+
+	boolean Beacon [read-only]
+
+		This property indicates whether the periodic beaconing is
+		enabled (true) or disabled (false).
+
+	uint8 BeaconFlags [read-only]
+
+		This property may be read at any time to determine the flag
+		field setting on sent and received beacons of the primary
+		network key.
+
+	uint32 IvIndex [read-only]
+
+		This property may be read at any time to determine the IV_Index
+		that the current network is on. This information is only useful
+		for provisioning.
+
+	uint32 SecondsSinceLastHeard [read-only]
+
+		This property may be read at any time to determine the number of
+		seconds since mesh network layer traffic was last detected on
+		this node's network.
+
 Mesh Provisioning Hierarchy
 ============================
 Service		org.bluez.mesh
@@ -618,55 +667,6 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 
-Properties:
-	dict Features [read-only]
-
-		The dictionary that contains information about feature support.
-		The following keys are defined:
-
-		boolean Friend
-
-			Indicates the ability to establish a friendship with a
-			Low Power node
-
-		boolean LowPower
-
-			Indicates support for operating in Low Power node mode
-
-		boolean Proxy
-
-			Indicates support for GATT proxy
-
-		boolean Relay
-			Indicates support for relaying messages
-
-	If a key is absent from the dictionary, the feature is not supported.
-	Otherwise, true means that the feature is enabled and false means that
-	the feature is disabled.
-
-	boolean Beacon [read-only]
-
-		This property indicates whether the periodic beaconing is
-		enabled (true) or disabled (false).
-
-	uint8 BeaconFlags [read-only]
-
-		This property may be read at any time to determine the flag
-		field setting on sent and received beacons of the primary
-		network key.
-
-	uint32 IvIndex [read-only]
-
-		This property may be read at any time to determine the IV_Index
-		that the current network is on. This information is only useful
-		for provisioning.
-
-	uint32 SecondsSinceLastHeard [read-only]
-
-		This property may be read at any time to determine the number of
-		seconds since mesh network layer traffic was last detected on
-		this node's network.
-
 Mesh Application Hierarchy
 ==========================
 Service		unique name
-- 
2.21.0

