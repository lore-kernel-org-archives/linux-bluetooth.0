Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659FFC2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D74E2073B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0Sm7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:42:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:39636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgC0Sm7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:42:59 -0400
IronPort-SDR: BovRQ3iQ+6WbsUD1AGNQKoCihej8GGMZsMuPjrrBNoc5dNqzW6ZkOIMfKX32rNg2jIczvyJPXq
 /kfveuhF4imw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 11:42:59 -0700
IronPort-SDR: TPTAC3odcwLMzjbnr4FAaj1MnAsgkti2Yi0xg9xMfSmXJaBanefaSr1ng4k6ZFgf+iYDmMHGCj
 wBAgYMlsqdcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,313,1580803200"; 
   d="scan'208";a="421193642"
Received: from ingas-nuc1.sea.intel.com ([10.251.8.23])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2020 11:42:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/4] doc/mesh-api: Forward compatibility modifications
Date:   Fri, 27 Mar 2020 11:42:54 -0700
Message-Id: <20200327184257.15042-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200327184257.15042-1-inga.stotland@intel.com>
References: <20200327184257.15042-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following methods are modified to allow for future development:

Interface org.bluez.mesh.Management1:

Old: void UnprovisionedScan(uint16 seconds)
New: void UnprovisionedScan(dict options)

    The options parameter is a dictionary with the following keys defined:
    uint16 Seconds
                Specifies number of seconds for scanning to be active.
                If set to 0 or if this key is not present, then the
                scanning will continue until UnprovisionedScanCancel()
                or AddNode() methods are called.
    other keys TBD

Old: void AddNode(array{byte}[16] uuid)
New: void AddNode(array{byte}[16] uuid, dict options)

    The options parameter is currently an empty dictionary

Interface org.bluez.mesh.Provisioner1

Old: void ScanResult(int16 rssi, array{byte} data)
New: void ScanResult(int16 rssi, array{byte} data, dict options)

    The options parameter is currently an empty dictionary
---
 doc/mesh-api.txt | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 131de6bfd..cc351b635 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -455,14 +455,20 @@ Object path	/org/bluez/mesh/node<uuid>
 		CreateNetwork() or Import()
 
 Methods:
-	void UnprovisionedScan(uint16 seconds)
+	void UnprovisionedScan(dict options)
 
 		This method is used by the application that supports
 		org.bluez.mesh.Provisioner1 interface to start listening
-		(scanning) for unprovisioned devices in the area. Scanning
-		will continue for the specified number of seconds, or, if 0 is
-		specified, then continuously until UnprovisionedScanCancel() is
-		called or if AddNode() method is called.
+		(scanning) for unprovisioned devices in the area.
+
+		The options parameter is a dictionary with the following keys
+		defined:
+
+		uint16 Seconds
+			Specifies number of seconds for scanning to be active.
+			If set to 0 or if this key is not present, then the
+			scanning will continue until UnprovisionedScanCancel()
+			or AddNode() methods are called.
 
 		Each time a unique unprovisioned beacon is heard, the
 		ScanResult() method on the app will be called with the result.
@@ -482,7 +488,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotAuthorized
 
-	void AddNode(array{byte}[16] uuid)
+	void AddNode(array{byte}[16] uuid, dict options)
 
 		This method is used by the application that supports
 		org.bluez.mesh.Provisioner1 interface to add the
@@ -491,6 +497,10 @@ Methods:
 		The uuid parameter is a 16-byte array that contains Device UUID
 		of the unprovisioned device to be added to the network.
 
+		The options parameter is a dictionary that may contain
+		additional configuration info (currently an empty placeholder
+		for forward compatibility).
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotAuthorized
@@ -927,7 +937,7 @@ Service		unique name
 Interface	org.bluez.mesh.Provisioner1
 Object path	freely definable
 
-	void ScanResult(int16 rssi, array{byte} data)
+	void ScanResult(int16 rssi, array{byte} data, dict options)
 
 		The method is called from the bluetooth-meshd daemon when a
 		unique UUID has been seen during UnprovisionedScan() for
@@ -943,6 +953,10 @@ Object path	freely definable
 		bit set in OOB mask). Whether these fields exist or not is a
 		decision of the remote device.
 
+		The options parameter is a dictionary that may contain
+		additional scan result info (currently an empty placeholder for
+		forward compatibility).
+
 		If a beacon with a UUID that has already been reported is
 		recieved by the daemon, it will be silently discarded unless it
 		was recieved at a higher rssi power level.
-- 
2.21.1

