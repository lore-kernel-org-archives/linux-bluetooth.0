Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5CDE9371F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379101AbjJIXaA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379105AbjJIX35 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5821EA4
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c8a1541233so12601785ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894188; x=1697498988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkPh2UbzNSyJBColBTH9IoJdkJTLS0KGu6b2bTjbbRM=;
        b=Cslg2cyr6+IsqCZTyGhxOqi5bymawJmNIkPB83AmecU8QDSfoCZia21t0oUBc4O0Xh
         b3+YRWjF/MX+0LLW9GaDXt5OSmwNhv6T49sRTenrZPzydwhYP+J6XHN+RHpHjEVYr9hI
         xghgqs8b0YZOhKRlVwV5XB05ZMynaw/5T786ST/0+dYVS5i4Li61ecTZoHO+64T3xtmt
         sNMgkI02jEKTfsVTxjMhMWk5qajNECAtNSSmcVcNMgY/0/WPCOw0l8hj6h+qeXe+/UjY
         x5YkCmu6PwgPTcqK0898EEHwKCK5viZYYLs5X2LNZtHsiDlybkiapxluw0h1c1BhIuPv
         EdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894188; x=1697498988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkPh2UbzNSyJBColBTH9IoJdkJTLS0KGu6b2bTjbbRM=;
        b=cPDRM34mM0wn32xHrcARtE1QKr+kVE3BTMOiUMe61plSFGmples02mwFfF4cTyim+i
         KPFn0effwXWotnnPZr/2pssOSEK/PHSxioB39kn0/FqAe8E7HLYfLoKvkrNZqJEk5w46
         +zEAss8pn6TnkHT6Ee1mUACOTGV44JywvgKC5b67aAfPmQii/0gqoGmqF9CnvssWTr8H
         G+qofAHRJg0GFF6p5RvEYYGcabfxSbzNMeQm2C12dGG+xFeX0FjEsVx4mjdwH7WeIhwO
         FdjhyLJc6jiTABLdjj3Uc3bKFcnemmurLtHL2LRCnZNewcatDY9WghDQaZ4XezgaGl0A
         z5Yg==
X-Gm-Message-State: AOJu0YxpLG20mZbaY4tR6KVC6/JhJ1qZjf3eHVxsyjuVJ5WqqyE2oSKP
        zUj0MRzAQOUBpm9L2ynPuNzViNV8JekQQ/14
X-Google-Smtp-Source: AGHT+IFBFR1TNzLsZ4vLwV3IhaBxE99wWK8ESq3oyenuNRkKNqCs/tWgam8ejuw8kjM4Hyo/oryb2A==
X-Received: by 2002:a17:902:e550:b0:1b9:e937:9763 with SMTP id n16-20020a170902e55000b001b9e9379763mr16646835plf.12.1696894188132;
        Mon, 09 Oct 2023 16:29:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/11] doc/advertising-api: Rename to org.bluez.LEAdvertis*.rst
Date:   Mon,  9 Oct 2023 16:29:29 -0700
Message-ID: <20231009232933.500652-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames advertising-api.txt to org.bluez.LEAdvertis*.rst and
generate manpages org.bluez.LEAdvertis*.5.
---
 Makefile.am                            |   7 +-
 doc/advertising-api.txt                | 278 -------------------------
 doc/org.bluez.LEAdvertisement.rst      | 195 +++++++++++++++++
 doc/org.bluez.LEAdvertisingManager.rst | 144 +++++++++++++
 4 files changed, 345 insertions(+), 279 deletions(-)
 delete mode 100644 doc/advertising-api.txt
 create mode 100644 doc/org.bluez.LEAdvertisement.rst
 create mode 100644 doc/org.bluez.LEAdvertisingManager.rst

diff --git a/Makefile.am b/Makefile.am
index f717d2c2336b..cf72a7905274 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -366,6 +366,8 @@ man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
 		doc/org.bluez.MediaTransport.5
+man_MANS += doc/org.bluez.LEAdvertisingManager.5 \
+		doc/org.bluez.LEAdvertisement.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
@@ -377,6 +379,8 @@ manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
 		doc/org.bluez.MediaTransport.5
+manual_pages += doc/org.bluez.LEAdvertisingManager.5 \
+		doc/org.bluez.LEAdvertisement.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -427,7 +431,8 @@ EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoint.rst \
 		doc/org.bluez.MediaTransport.rst
 
-EXTRA_DIST += doc/gatt-api.txt doc/advertising-api.txt
+EXTRA_DIST += doc/gatt-api.txt doc/org.bluez.LEAdvertisingManager.rst \
+		doc/org.bluez.LEAdvertisement.rst
 
 EXTRA_DIST += doc/obex-api.txt doc/obex-agent-api.txt
 
diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
deleted file mode 100644
index a0077843defd..000000000000
--- a/doc/advertising-api.txt
+++ /dev/null
@@ -1,278 +0,0 @@
-BlueZ D-Bus LE Advertising API Description
-******************************************
-
-Advertising packets are structured data which is broadcast on the LE Advertising
-channels and available for all devices in range.  Because of the limited space
-available in LE Advertising packets (31 bytes), each packet's contents must be
-carefully controlled.
-
-BlueZ acts as a store for the Advertisement Data which is meant to be sent.
-It constructs the correct Advertisement Data from the structured
-data and configured the kernel to send the correct advertisement.
-
-Advertisement Data objects are registered freely and then referenced by BlueZ
-when constructing the data sent to the kernel.
-
-LE Advertisement Data hierarchy
-===============================
-
-Specifies the Advertisement Data to be broadcast and some advertising
-parameters.  Properties which are not present will not be included in the
-data.  Required advertisement data types will always be included.
-All UUIDs are 128-bit versions in the API, and 16 or 32-bit
-versions of the same UUID will be used in the advertising data as appropriate.
-
-Service		org.bluez
-Interface	org.bluez.LEAdvertisement1
-Object path	freely definable
-
-Methods		void Release() [noreply]
-
-			This method gets called when the service daemon
-			removes the Advertisement. A client can use it to do
-			cleanup tasks. There is no need to call
-			UnregisterAdvertisement because when this method gets
-			called it has already been unregistered.
-
-Properties	string Type
-
-			Determines the type of advertising packet requested.
-
-			Possible values: "broadcast" or "peripheral"
-
-		array{string} ServiceUUIDs
-
-			List of UUIDs to include in the "Service UUID" field of
-			the Advertising Data.
-
-		dict ManufacturerData
-
-			Manufactuer Data fields to include in
-			the Advertising Data.  Keys are the Manufacturer ID
-			to associate with the data.
-
-		array{string} SolicitUUIDs
-
-			Array of UUIDs to include in "Service Solicitation"
-			Advertisement Data.
-
-		dict ServiceData
-
-			Service Data elements to include. The keys are the
-			UUID to associate with the data.
-
-		dict Data [Experimental]
-
-			Advertising Type to include in the Advertising
-			Data. Key is the advertising type and value is the
-			data as byte array.
-
-			Note: Types already handled by other properties shall
-			not be used.
-
-			Possible values:
-				<type> <byte array>
-				...
-
-			Example:
-				<Transport Discovery> <Organization Flags...>
-				0x26                   0x01         0x01...
-
-		bool Discoverable [Experimental]
-
-			Advertise as general discoverable. When present this
-			will override adapter Discoverable property.
-
-			Note: This property shall not be set when Type is set
-			to broadcast.
-
-		uint16 DiscoverableTimeout [Experimental]
-
-			The discoverable timeout in seconds. A value of zero
-			means that the timeout is disabled and it will stay in
-			discoverable/limited mode forever.
-
-			Note: This property shall not be set when Type is set
-			to broadcast.
-
-		array{string} Includes
-
-			List of features to be included in the advertising
-			packet.
-
-			Possible values: as found on
-					LEAdvertisingManager.SupportedIncludes
-
-		string LocalName
-
-			Local name to be used in the advertising report. If the
-			string is too big to fit into the packet it will be
-			truncated.
-
-			If this property is available 'local-name' cannot be
-			present in the Includes.
-
-		uint16 Appearance
-
-			Appearance to be used in the advertising report.
-
-			Possible values: as found on GAP Service.
-
-		uint16_t Duration
-
-			Rotation duration of the advertisement in seconds. If
-			there are other applications advertising no duration is
-			set the default is 2 seconds.
-
-		uint16_t Timeout
-
-			Timeout of the advertisement in seconds. This defines
-			the lifetime of the advertisement.
-
-		string SecondaryChannel [Experimental]
-
-			Secondary channel to be used. Primary channel is
-			always set to "1M" except when "Coded" is set.
-
-			Possible value: "1M" (default)
-					"2M"
-					"Coded"
-
-		uint32 MinInterval [Experimental]
-
-			Minimum advertising interval to be used by the
-			advertising set, in milliseconds. Acceptable values
-			are in the range [20ms, 10,485s]. If the provided
-			MinInterval is larger than the provided MaxInterval,
-			the registration will return failure.
-
-		uint32 MaxInterval [Experimental]
-
-			Maximum advertising interval to be used by the
-			advertising set, in milliseconds. Acceptable values
-			are in the range [20ms, 10,485s]. If the provided
-			MinInterval is larger than the provided MaxInterval,
-			the registration will return failure.
-
-		int16 TxPower [Experimental]
-
-			Requested transmission power of this advertising set.
-			The provided value is used only if the "CanSetTxPower"
-			feature is enabled on the Advertising Manager. The
-			provided value must be in range [-127 to +20], where
-			units are in dBm.
-
-
-LE Advertising Manager hierarchy
-================================
-
-The Advertising Manager allows external applications to register Advertisement
-Data which should be broadcast to devices.  Advertisement Data elements must
-follow the API for LE Advertisement Data described above.
-
-Service		org.bluez
-Interface	org.bluez.LEAdvertisingManager1
-Object path	/org/bluez/{hci0,hci1,...}
-
-Methods		RegisterAdvertisement(object advertisement, dict options)
-
-			Registers an advertisement object to be sent over the LE
-			Advertising channel.  The service must be exported
-			under interface LEAdvertisement1.
-
-			InvalidArguments error indicates that the object has
-			invalid or conflicting properties.
-
-			InvalidLength error indicates that the data
-			provided generates a data packet which is too long.
-
-			The properties of this object are parsed when it is
-			registered, and any changes are ignored.
-
-			If the same object is registered twice it will result in
-			an AlreadyExists error.
-
-			If the maximum number of advertisement instances is
-			reached it will result in NotPermitted error.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-					 org.bluez.Error.InvalidLength
-					 org.bluez.Error.NotPermitted
-
-		UnregisterAdvertisement(object advertisement)
-
-			This unregisters an advertisement that has been
-			previously registered.  The object path parameter must
-			match the same value that has been used on registration.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
-
-Properties	byte ActiveInstances
-
-			Number of active advertising instances.
-
-		byte SupportedInstances
-
-			Number of available advertising instances.
-
-		array{string} SupportedIncludes
-
-			List of supported system includes.
-
-			Possible values: "tx-power"
-					 "appearance"
-					 "local-name"
-					 "rsi"
-
-		array{string} SupportedSecondaryChannels [Experimental]
-
-			List of supported Secondary channels. Secondary
-			channels can be used to advertise with the
-			corresponding PHY.
-
-			Possible values: "1M"
-					 "2M"
-					 "Coded"
-
-		dict SupportedCapabilities [Experimental]
-
-			Enumerates Advertising-related controller capabilities
-			useful to the client.
-
-			Possible Values:
-
-				byte MaxAdvLen
-
-					Max advertising data length
-
-				byte MaxScnRspLen
-
-					Max advertising scan response length
-
-				int16 MinTxPower
-
-					Min advertising tx power (dBm)
-
-				int16 MaxTxPower
-
-					Max advertising tx power (dBm)
-
-		array{string} SupportedFeatures [readonly,optional,Experimental]
-
-			List of supported platform features. If no features
-			are available on the platform, the SupportedFeatures
-			array will be empty.
-
-			Possible values: "CanSetTxPower"
-
-						Indicates whether platform can
-						specify tx power on each
-						advertising instance.
-
-					 "HardwareOffload"
-
-						Indicates whether multiple
-						advertising will be offloaded
-						to the controller.
diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
new file mode 100644
index 000000000000..4609bde74a5e
--- /dev/null
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -0,0 +1,195 @@
+=========================
+org.bluez.LEAdvertisement
+=========================
+
+---------------------------------------------
+BlueZ D-Bus LEAdvertisement API documentation
+---------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+Advertising packets are structured data which is broadcast on the LE Advertising
+channels and available for all devices in range.  Because of the limited space
+available in LE Advertising packets, each packet's contents must be carefully
+controlled.
+
+The service daemon acts as a store for the Advertisement Data which is meant to
+be sent. It constructs the correct Advertisement Data from the structured
+data and configured the kernel to send the correct advertisement.
+
+Interface
+=========
+
+Specifies the Advertisement Data to be broadcast and some advertising
+parameters.  Properties which are not present will not be included in the
+data.  Required advertisement data types will always be included.
+All UUIDs are 128-bit versions in the API, and 16 or 32-bit
+versions of the same UUID will be used in the advertising data as appropriate.
+
+:Service:	org.bluez
+:Interface:	org.bluez.LEAdvertisement1
+:Object path:	freely definable
+
+Methods
+-------
+
+void Release() [noreply]
+````````````````````````
+
+	This method gets called when the service daemon removes the
+	Advertisement. A client can use it to do cleanup tasks. There is no
+	need to call **UnregisterAdvertisement()** because when this method
+	gets called it has already been unregistered.
+
+Properties
+----------
+
+string Type [readonly]
+``````````````````````
+
+	Determines the type of advertising packet requested.
+
+	Possible values:
+
+	:"broadcast":
+	:"peripheral":
+
+array{string} ServiceUUIDs
+``````````````````````````
+
+	List of UUIDs to include in the "Service UUID" field of the Advertising
+	Data.
+
+dict ManufacturerData
+`````````````````````
+
+	Manufacturer Data fields to include in the Advertising Data.  Keys are
+	the Manufacturer ID to associate with the data.
+
+array{string} SolicitUUIDs
+``````````````````````````
+
+	Array of UUIDs to include in "Service Solicitation" Advertisement Data.
+
+dict ServiceData
+````````````````
+
+	Service Data elements to include. The keys are the UUID to associate
+	with the data.
+
+dict Data [Experimental]
+````````````````````````
+
+	Advertising Data to include. Key is the advertising type and value is
+	the data as byte array.
+
+	Note: Types already handled by other properties shall not be used.
+
+	Possible values:
+
+	:<type>:
+
+		<byte array>
+
+	Example:
+		<Transport Discovery> <Organization Flags...>
+		0x26                   0x01         0x01...
+
+bool Discoverable [Experimental]
+````````````````````````````````
+
+	Advertise as general discoverable. When present this will override
+	adapter Discoverable property.
+
+	Note: This property shall not be set when **Type** is set to
+	"broadcast".
+
+uint16 DiscoverableTimeout [Experimental]
+`````````````````````````````````````````
+
+	The discoverable timeout in seconds. A value of zero means that the
+	timeout is disabled and it will stay in discoverable/limited mode
+	forever.
+
+	Note: This property shall not be set when **Type** is set to
+	"broadcast".
+
+array{string} Includes
+``````````````````````
+
+	List of features to be included in the advertising packet.
+
+	Possible values:
+
+	See **org.bluez.LEAdvertisingManager(5)** **SupportedIncludes**
+	property.
+
+string LocalName
+````````````````
+
+	Local name to be used in the advertising report. If the string is too
+	big to fit into the packet it will be truncated.
+
+	If this property is available 'local-name' cannot be present in the
+	**Includes**.
+
+uint16 Appearance
+`````````````````
+
+	Appearance to be used in the advertising report.
+
+	Possible values: as found on GAP Service.
+
+uint16_t Duration
+`````````````````
+
+	Rotation duration of the advertisement in seconds. If there are other
+	applications advertising no duration is set the default is 2 seconds.
+
+uint16_t Timeout
+````````````````
+
+	Timeout of the advertisement in seconds. This defines the lifetime of
+	the advertisement.
+
+string SecondaryChannel [Experimental]
+``````````````````````````````````````
+
+	Secondary channel to be used. Primary channel is always set to "1M"
+	except when "Coded" is set.
+
+	Possible value:
+
+	:"1M" (default):
+	:"2M":
+	:"Coded":
+
+uint32 MinInterval [Experimental]
+`````````````````````````````````
+
+	Minimum advertising interval to be used by the advertising set, in
+	milliseconds. Acceptable values are in the range [20ms, 10,485s].
+	If the provided MinInterval is larger than the provided MaxInterval,
+	the registration will return failure.
+
+uint32 MaxInterval [Experimental]
+`````````````````````````````````
+
+	Maximum advertising interval to be used by the advertising set, in
+	milliseconds. Acceptable values are in the range [20ms, 10,485s]. If the
+	provided MinInterval is larger than the provided MaxInterval, the
+	registration will return failure.
+
+int16 TxPower [Experimental]
+````````````````````````````
+
+	Requested transmission power of this advertising set. The provided value
+	is used only if the "CanSetTxPower" feature is enabled on the
+	**org.bluez.LEAdvertisingManager(5)**. The provided value must be in
+	range [-127 to +20], where units are in dBm.
diff --git a/doc/org.bluez.LEAdvertisingManager.rst b/doc/org.bluez.LEAdvertisingManager.rst
new file mode 100644
index 000000000000..b9d5cafc6ff3
--- /dev/null
+++ b/doc/org.bluez.LEAdvertisingManager.rst
@@ -0,0 +1,144 @@
+==============================
+org.bluez.LEAdvertisingManager
+==============================
+
+-------------------------------------------------
+BlueZ D-Bus LEAvertisingManager API documentation
+-------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+The Advertising Manager allows external applications to register Advertisement
+Data which should be broadcast to devices.  Advertisement Data elements must
+follow the API for LE Advertisement Data described above.
+
+:Service:	org.bluez
+:Interface:	org.bluez.LEAdvertisingManager1
+:Object path:	/org/bluez/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterAdvertisement(object advertisement, dict options)
+``````````````````````````````````````````````````````````````
+
+	Registers an advertisement object to be sent over the LE Advertising
+	channel.  The service must implement **org.bluez.LEAdvertisement(5)**
+	interface.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+
+		Indicates that the object has invalid or conflicting properties.
+
+	:org.bluez.Error.AlreadyExists:
+
+		Indicates the object is already registered.
+
+	:org.bluez.Error.InvalidLength:
+
+		Indicates that the data provided generates a data packet which
+		is too long
+
+	:org.bluez.Error.NotPermitted:
+
+		Indicates the maximum number of advertisement instances has
+		been reached.
+
+void UnregisterAdvertisement(object advertisement)
+``````````````````````````````````````````````````
+
+	Unregisters an advertisement that has been previously registered using
+	**RegisterAdvertisement()**.  The object path parameter must match the
+	same value that has been used on registration.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.DoesNotExist:
+
+Properties
+----------
+
+byte ActiveInstances [readonly]
+```````````````````````````````
+
+	Number of active advertising instances.
+
+byte SupportedInstances [readonly]
+``````````````````````````````````
+
+	Number of available advertising instances.
+
+array{string} SupportedIncludes [readonly]
+``````````````````````````````````````````
+
+	List of supported system includes.
+
+	Possible values:
+
+	:"tx-power":
+	:"appearance":
+	:"local-name":
+	:"rsi":
+
+array{string} SupportedSecondaryChannels [readonly, Experimental]
+`````````````````````````````````````````````````````````````````
+
+	List of supported Secondary channels. Secondary channels can be used to
+	advertise with the corresponding PHY.
+
+	Possible values:
+
+	:"1M":
+	:"2M":
+	:"Coded":
+
+dict SupportedCapabilities [readonly, Experimental]
+```````````````````````````````````````````````````
+
+	Enumerates Advertising-related controller capabilities useful to the
+	client.
+
+	Possible Values:
+
+	:byte MaxAdvLen:
+
+		Max advertising data length
+
+	:byte MaxScnRspLen:
+
+		Max advertising scan response length
+
+	;int16 MinTxPower:
+
+		Min advertising tx power (dBm)
+
+	:int16 MaxTxPower:
+
+		Max advertising tx power (dBm)
+
+array{string} SupportedFeatures [readonly,optional,Experimental]
+````````````````````````````````````````````````````````````````
+
+	List of supported platform features. If no features are available on
+	the platform, the SupportedFeatures array will be empty.
+
+	Possible values:
+
+	:"CanSetTxPower":
+
+		Indicates whether platform can specify tx power on each
+		advertising instance.
+
+	:"HardwareOffload":
+
+		Indicates whether multiple advertising will be offloaded to the
+		controller.
-- 
2.41.0

