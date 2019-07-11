Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F86AC742A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041A6208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfGKXAL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:62608 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfGKXAL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166516104"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:09 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 1/9] doc: Cleanup API Provisioner1 interface
Date:   Thu, 11 Jul 2019 15:59:44 -0700
Message-Id: <20190711225952.1599-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Modified the RequestProvData In and Out param list to eliminate
parameters which can be provided by the Node which owns the
procedure, and clean-up the actual error list.
---
 doc/mesh-api.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 893a1a6c0..0ac2fdfd1 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -365,7 +365,9 @@ Methods:
 		ScanResult() method on the app will be called with the result.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotAuthorized
+			org.bluez.mesh.Error.Busy
 
 	void UnprovisionedScanCancel(void)
 
@@ -374,6 +376,7 @@ Methods:
 		(scanning) for unprovisioned devices in the area.
 
 		PossibleErrors:
+			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotAuthorized
 
 	void AddNode(array{byte}[16] uuid)
@@ -860,7 +863,7 @@ Service		unique name
 Interface	org.bluez.mesh.Provisioner1
 Object path	freely definable
 
-	ScanResult(int8 rssi, array{byte} data)
+	void ScanResult(int16 rssi, array{byte} data)
 
 		The method is called from the bluetooth-meshd daemon when a
 		unique UUID has been seen during UnprovisionedScan() for
@@ -881,17 +884,17 @@ Object path	freely definable
 		was recieved at a higher rssi power level.
 
 
-	uint16 net_index, uint8 flags, uint32 iv_index, uint16 unicast
-							RequestProvData()
+	uint16 net_index, uint16 unicast RequestProvData(uint8 count)
 
 		This method is implemented by a Provisioner capable application
 		and is called when the remote device has been fully
 		authenticated and confirmed.
 
+		The count parameter is the number of consecutive unicast
+		addresses the remote device is requesting.
+
 		Return Parameters are from the Mesh Profile Spec:
 		net_index - Subnet index of the net_key
-		flags - Flags for IV_Update and Key Refresh
-		iv_index - Current IvIndex being used on the network
 		unicast - Primary Unicast address of the new node
 
 		PossibleErrors:
-- 
2.14.5

