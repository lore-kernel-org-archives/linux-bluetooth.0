Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE9C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiBXCHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiBXCHF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD6641D
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668395; x=1677204395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cvd+xLakMB/8GSTNTyEuvAKnMwdMeGT9MJgKOHxAYGg=;
  b=IRKppubHz6mawX+4bLwv0SAxpbLWri+0EAROLi+6fVeLdjPFOqirldgf
   p/wCt0ZXODb7uInbWDKleL9Jl9VnDENB3oyhYQiPkT7/Vjw/UUZ/J1YcE
   Zh4wR/sfEoBsju8FfJ0CNY5aTTE8c0bm/DY7Dm8IonCtkTjavRL9DAZXy
   jIzuJy5zgRCd8Sw7RXkrnMwQ4Wv0LL1AWd5WZQJ24F1S5QUUKRrUXXnuI
   xCZKS2hnPNcQfE/MTNAR8+ZCj6ce+GZdea8/gBaldPUADeBoljqwqeZ19
   B9bPIAgjqe5XKb/nIH4LH+BOzjoea8dySKhNUBJ7ouHBc0mwMyHeHDS4a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239524996"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239524996"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268562"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 1/7] mgmt: Add support for Mesh in the kernel
Date:   Wed, 23 Feb 2022 18:06:18 -0800
Message-Id: <20220224020624.159247-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224020624.159247-1-brian.gix@intel.com>
References: <20220224020624.159247-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These commands and events allow User space apps to test for Mesh
support, and request incoming mesh packets be delivered and request
outbound mesh packets to be sent. This is the basis for sharing
one controller between the legacy bluetoothd daemon and the mesh
bluetooth-meshd daemon.
---
 doc/mgmt-api.txt | 180 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ebe56afa4..41c196250 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3858,6 +3858,132 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
 				Invalid Parameters
 
 
+Set Mesh Receiver Command
+=========================
+
+	Command Code:		0x0057
+	Controller Index:	<controller id>
+	Command Parameters:	Enable (1 Octets)
+				Window (2 Octets)
+				Period (2 Octets)
+				Num AD Types (1 Octets)
+				AD Types { }
+
+	This command Enables or Disables Mesh Receiving. When enabled passive
+	scanning remains enabled for this controller.
+
+	The Window/Period values are used to set the Scan Parameters when no
+	other scanning is being done.
+
+	Num AD Types and AD Types parameter, filter Advertising and Scan
+	responses by AD type. Reponses that do not contain at least one of the
+	requested AD types will be ignored. Otherwise they will be delivered
+	with the Mesh Device Found event.
+
+	Possible errors:	Failed
+				No Resources
+				Invalid Parameters
+
+
+Read Mesh Features Command
+==========================
+
+	Command Code:		0x0058
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Index (2 Octets)
+				Max Handles (1 Octets)
+				Used Handles (1 Octets)
+				Handle { }
+
+	This command is used to both verify that Outbound Mesh packet
+	support is enabled, and to indicate the number of packets that
+	can and are simultaneously queued.
+
+	Index identifies the HCI Controller that this information is valid for.
+
+	Max Handles indicates the maximum number of packets that may be queued.
+
+	Used Handles indicates the number of packets awaiting transmission.
+
+	Handle is an array of the currently outstanding packets.
+
+	Possible errors:	Failed
+				No Resources
+				Invalid Parameters
+
+
+Transmit Mesh Packet Command
+============================
+
+	Command Code:		0x0059
+	Controller Index:	<controller id>
+	Command Parameters:	Addr (6 octets)
+				Addr Type (1 Octets)
+				Instant (8 Octets)
+				Delay (2 Octets)
+				Count (1 Octets)
+				Data (variable)
+
+	Return Parameters:	Handle (1 Octets)
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
+	at the earliest opportunity. If non-Zero, and the controller supports
+	delayed delivery, the Instant and Delay parameters will be used
+	to delay the outbound packet. While the Instant is not defined, the
+	Delay is specified in milliseconds.
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
+
+Cancel Transmit Mesh Packet Command
+===================================
+
+	Command Code:		0x005A
+	Controller Index:	<controller id>
+	Command Parameters:	Handle (1 Octets)
+
+	This command may be used to cancel an outbound transmission request.
+
+	The Handle parameter is the returned handle from a successful Transmit
+	Mesh Packet request. If Zero is specified as the handle, all outstanding
+	send requests are canceled.
+
+	For each mesh packet canceled, the Mesh Packet Transmission Complete
+	event will be generated, regardless of whether the packet was sent
+	successfully.
+
+	Possible errors:	Failed
+				Invalid Parameters
+
+
 Command Complete Event
 ======================
 
@@ -4978,3 +5104,57 @@ Advertisement Monitor Device Lost Event
 		2	LE Random
 
 	This event will be sent to all management sockets.
+
+
+Mesh Device Found Event
+=======================
+
+	Event code:		0x0031
+	Controller Index:	<controller_id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				RSSI (1 Octet)
+				Flags (4 Octets)
+				Instant (8 Octets)
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
+	The Instant field is 64 bit value that represents the instant in time
+	the packet was received. It's value is not intended to be interpretted
+	by the host, and is only useful if the host wants to make a timed
+	response to the received packet. (i.e. a Poll/Response)
+
+	AD_Length and AD_Data contains the Info structure of Advertising and
+	Scan rsults. To receive this event, AD filters must be requested with
+	the Set Mesh Receiver command command, specifying which AD Types to
+	return. All AD structures will be received in this event if any of the
+	filtered AD Types are present.
+
+	This event will be sent to all management sockets.
+
+
+Mesh Packet Transmit Complete Event
+===================================
+
+	Event code:		0x0032
+	Controller Index:	<controller_id>
+	Event Parameters:	Handle (1 Octets)
+
+	This event indicates that a requested outbound Mesh packet has
+	completed and no longer occupies a transmit slot.
+
+	This event will be sent to all management sockets.
-- 
2.35.1

