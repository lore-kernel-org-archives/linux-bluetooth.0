Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Dec 2021 00:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbhLaAcQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Dec 2021 19:32:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:6309 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233018AbhLaAcQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Dec 2021 19:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640910736; x=1672446736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E7Fpm7gwSYom9uZy1YsDAoCyyZ20uSG59yuIMjej1IY=;
  b=SOf6Vj8fTYyDfItPFnmCgN2YI7mISx+Hmv2ukxeFk5PKgVcz5oA/VUes
   mfMgkIWwsWEiluDs2JAsw62Ek11iy3FnZJBACOrCPU1cLvyUIKgWLiQIG
   uyQZAKR8hv/C3uLwJZDLfOKbBF+ziHVnmET44iwucIAJCYiaZo+W31/aO
   rLeq+8qu6GngGuYRSUXRTL/ggemams5LfV++M5BYj6lImmESY9ei8AsYS
   qOqCgWv8oY4z1Cr2Qhj8xp9qYCyGlGKKLDeXuZ+FYLitg9DpEiPT1fKG0
   1y5TyixvIvvHxzAo9xTBI8QiG0AbyjUl8QF4thxomllrPFGD1YtFSUGSc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="302501900"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="302501900"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 16:32:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="619504537"
Received: from tpkhuc-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.101.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 16:32:15 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com,
        luiz.von.dentz@intel.com
Subject: [RFC BlueZ v2] Bluetooth: Add support for Mesh Scanning and Sending
Date:   Thu, 30 Dec 2021 16:32:08 -0800
Message-Id: <20211231003208.2530079-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adds four new MGMT Commands:
	- MESH_RECEIVER - Enable Mesh Receiver with Passive scanning
	  with a list of AD Types (Mesh and/or Extended Mesh).

	- MESH_FEATURES - Requests information on how many simultaneous
	  outbound  mesh packets can be pending at one time.

	- MESH_TX_PACKET - Send a requested Mesh Packet, perhaps with a
	  specific fine-timed delay.

	- MESH_TX_CANCEL - Cancel a prior Mesh TX request that has not
	  yet completed.

Adds two new MGMT Events:
	- MESH_DEVICE_FOUND - Returned when Mesh is enabled, and one of
	  the requested AD Types is detected in an incoming
	  Advertisement.

	- MESH_TX_COMPLETE - Reports that a prior requested transmission
	  has completed and no longer consumes one of the available
	  outbound slots.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 doc/mgmt-api.txt | 161 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4..1833f178b 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -332,6 +332,7 @@ Read Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
+		18	Mesh Mode
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -3858,6 +3859,120 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				Invalid Parameters
 
 
+Set Mesh Receiver Command
+==============================================================
+
+	Command Code:		0x0057
+	Controller Index:	<controller id>
+	Command Parameters:	Enable (1 Octet)
+				Window (2 Octets)
+				Period (2 Octets)
+				AD Types { variable }
+	Return Parameters:	Status
+
+	This command Enables or Disables Mesh Mode. Mesh mode, when enabled
+	keeps the controller passivly scanning for LE Advertising packets.
+	To enable Mesh, LE must first be enabled.
+
+	The Window/Period values are used to set the Scan Parameters when no
+	other scanning is being done.
+
+	The AD Types parameter, if present, will filter Advertising and Scan
+	responses by AD type. reponses that do not contain at least one of the
+	requested AD types will be discarded. Response results will be delivered
+	with the Mesh Device Found event.
+
+	This command may be used redundantly to set new filtering AD Types.
+
+	Possible errors:	Failed
+				No Resources
+				Invalid Parameters
+
+Read Mesh Features Command
+==============================================================
+
+	Command Code:		0x0058
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Status, Used slots, Total slots
+
+	This command is used to request the count of outbound packet slots
+	which may be simultaneously requested.
+
+	Used slots (1 octet) contains the count of packets currently awaiting
+	transmission.
+
+	Total slots contains (1 octet) contains the total number of packets
+	that can be pending at one time.
+
+	Possible errors:	Failed
+				No Resources
+				Invalid Parameters
+
+Transmit Mesh Packet Command
+==============================================================
+
+	Command Code:		0x0059
+	Controller Index:	<controller id>
+	Command Parameters:	Addr (6 octets)
+				Addr Type (1 Octets)
+				Instant (4 Octets)
+				Delay (2 Octets)
+				Count (1 Octets)
+				Data { }
+	Return Parameters:	Status, Handle
+
+	This command sends a Mesh Packet as a NONCONN LE Advertisement.
+
+	The Addr + Addr Type parameters specifify the address to use in the
+	outbound advertising packet. If BD_ADDR_ANY and LE_RANDOM is set, the
+	kernel will create a single use non-resolvable address.
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
+	This command will return immediately, and if it succeeds, will generate
+	a Mesh Packet Transmission Complete event when after the packet has been
+	sent.
+
+	Possible errors:	Failed
+				Busy
+				No Resources
+				Invalid Parameters
+
+Cancel Transmit Mesh Packet Command
+==============================================================
+
+	Command Code:		0x005A
+	Controller Index:	<controller id>
+	Command Parameters:	Handle (2 octets)
+	Return Parameters:	Status
+
+	This command may be used to cancel an outbound transmission request.
+
+	The Handle parameter is the returned handle from a successful Transmit
+	Mesh Packet request.
+
+	Possible errors:	Failed
+				Invalid Parameters
+
+
 Command Complete Event
 ======================
 
@@ -4978,3 +5093,49 @@ Advertisement Monitor Device Lost Event
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
+
+Mesh Packet Transmit Complete Event
+========================================
+
+	Event code:		0x0032
+	Controller Index:	<controller_id>
+	Event Parameters:	Handle (2 Octets)
+
+	This event indicates that a requested outbound Mesh packet has
+	completed and no longer occupies a transmit slot.
+
+	This event will be sent to all management sockets.
-- 
2.31.1

