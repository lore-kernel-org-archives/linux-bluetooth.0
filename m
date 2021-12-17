Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E546C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 21:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhLQVZv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 16:25:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:11976 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhLQVZu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 16:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639776350; x=1671312350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NfoM1ATLlJZccZJieE3y8Q4MjiYoeg5NyXe9R5qP0QI=;
  b=jWARuU+ZxiNsJ+Ig5KzRPuvjTSfTiuBjwiDZHvgDUPI8t5mspMg5W62y
   biRWj3mRXaT/ej3G29m5Kr/dNv0HpKh+V+gv8LAEmqJcgRkIGSOmXAwqJ
   60ENYD+JvwDBr+8h6FWdQQvYrP3kBVO/icwS4jacCkmA2RwznJrGx6A8q
   aYQQI/QPpfvLZc7O1jn8gcnxzUlI+X0UWzzmYtXg2y4jQa47KJUF34tcu
   3HJ+Lho1Z/mCQjnlY16ELD+kgqUmDsFG8Q3d0cGOZH5asoBFHHn6zUN2B
   Pg1Oi2BymvMi8fNnXEbKJ631Yh7rDSBc2SE6znU7ovmiGSIT+cvrwg4c2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219850411"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="219850411"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 13:25:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="546524864"
Received: from emace-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.103.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 13:25:50 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org
Subject: [RFC BlueZ] Bluetooth: Add support for Mesh Scanning and Sending
Date:   Fri, 17 Dec 2021 13:25:42 -0800
Message-Id: <20211217212542.372210-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adds two new MGMT Commands:
	- MESH_MODE - Enable Mesh Mode with either Active or Passive
	scanning for a list of AD Types (Mesh and/or Extended Mesh).

	- MESH_SEND - Send a requested Mesh Packet on a non-resolvable
	random address, perhaps with a specific fine-timed delay.

Adds one new MGMT Event:
	- MESH_DEVICE_FOUND - Returned when Mesh is enabled, and one of
	  the requested AD Types is detected in an incoming
	  Advertisement.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 doc/mgmt-api.txt | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4..3c34d6fb9 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -332,6 +332,7 @@ Read Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
+		18	Mesh Mode
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -3858,6 +3859,90 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				Invalid Parameters
 
 
+Set controller to Mesh mode Command
+==============================================================
+
+	Command Code:		0x0057
+	Controller Index:	<controller id>
+	Command Parameters:	Enable (1 Octet)
+				Active (1 Octet)
+				AD Types { }
+	Return Parameters:	Available Slots (1 Octet)
+
+	This command Enables or Disables Mesh Mode. Mesh mode, when enabled
+	keeps the controller passivly or actively scanning for LE Advertising
+	messgaes. To enable Mesh, LE must be enabled.
+
+	The Active parameter when set to 0x01, will cause the controller to
+	perform active scanning, as opposed to passive scanning, when the
+	parameter is set to 0x00.
+
+	The AD Types parameter, if present, will filter Advertising and Scan
+	responses by AD type. reponses that do not contain at least one of the
+	requested AD types will be discarded. response results will be delivered
+	with the Mesh Device Found event.
+
+	This command may be called redundantly to switch between Active and
+	Passive scanning, without disabling Mesh mode. If Mesh mode is disabled,
+	all active outbound Mesh Packet Send requests will return fail codes.
+
+	The returned parameter Available Slots returns the number of
+	simultaneous outbound packets that may to queued for delivery.
+
+	Possible errors:	Failed
+				Busy
+				No Resources
+				Invalid Parameters
+
+
+Mesh Packet Send Command
+==============================================================
+
+	Command Code:		0x0058
+	Controller Index:	<controller id>
+	Command Parameters:	Reference (1 Octets)
+				Instant (4 Octets)
+				Delay (2 Octets)
+				Count (1 Octets)
+				Data { }
+	Return Parameters:	Status, Reference Value
+
+	This command sends a Mesh Packet as a NONCONN LE Advertisement. Mesh
+	mode must be enabled.
+
+	The Reference value is Host defined, and will be returned with the
+	status, so that the Host may have multiple requests outstanding at
+	the same time. The Reference value will not be interpretted by the
+	kernel.
+
+	The Instant parameter is used in combination with the Delay
+	parameter, to finely time the sending of the Advertising packet. It
+	should be set to the Instant value tag of a received incoming
+	Mesh Device Found Event. It is only useful in POLL-RESPONSE situations
+	where a response must be sent within a negotiated time window. The value
+	of the Instant parameter should not be interpreted by the host, and
+	only has meaning to the controller.
+
+	The Delay parameter, if 0x0000, will cause the packet to be sent
+	immediately, or at the earliest opportunity. If non-Zero, it will
+	attempt to send the packet the requested number of milliseconds after
+	the instant in time represented by the Instant parameter.
+
+	The Count parameter must be sent to a non-Zero value indicating the
+	number of times this packet will be sent before transmission completes.
+	If the Delay parameter is non-Zero, then Count must be 1 only.
+
+	The Data parameter is an octet array of the AD Type and Mesh Packet.
+
+	This command will return only after the outbound packet has been sent,
+	or it fails.
+
+	Possible errors:	Failed
+				Busy
+				No Resources
+				Invalid Parameters
+
+
 Command Complete Event
 ======================
 
@@ -4978,3 +5063,37 @@ Advertisement Monitor Device Lost Event
 		2	LE Random
 
 	This event will be sent to all management sockets.
+
+Mesh Device Found Event
+========================================
+
+	Event code:		0x0031
+	Controller Index:	<controller_id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				RSSI (1 Octet)
+				Flags (4 Octets)
+				Instant (4 Octets)
+				AD_Data_Length (2 Octets)
+				AD_Data (0-65535 Octets)
+
+	This event indicates that the controller has received an Advertisement
+	or Scan Result containing an AD Type matching the Mesh scan set.
+
+	The address of the sending device is returned, and must be a valid LE
+	Address_Type.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	The RSSI field is a signed octet, and is the RSSI reported by the
+	receiving controller.
+
+	The Instant field is 32 bit value that represents the instant in time
+	the packet was received. It's value is not intended to be interpretted
+	by the host, and is only useful if the host wants to make a timed
+	response to the received packet. (i.e. a Poll/Response)
+
+	This event will be sent to all management sockets.
-- 
2.31.1

