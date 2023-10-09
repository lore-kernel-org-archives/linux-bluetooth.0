Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6082E9413E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbjJIX3o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjJIX3m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD3A7
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-58d26cfe863so808179a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894178; x=1697498978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqKUg053lyYsj/ooEOZyT990Wlr0Y5kgkhv8tFgOXzE=;
        b=gC0HF7PoX6bVd2TQe7JOOKxwT77el0nG12Bj34mVhV1avCTxc9DDQQCA4E7OK5SwLJ
         bXiwHxN+GH2OBIXubndirO+ENOSPiSYoH/YVjdThZac02EsvUEcurpSrI+BsuB4v2y8F
         uddU83ZcmtbcK29AE+r3LpoM4eNoPbufu6qXcfepUZAQ3vzxw21SzUQSOC7mIFncIneT
         jscu57aY8078bFr4mIgH6kHrgcaJvVXuvfN6I6oTNYogL/s7R9KvOZYPy0QposfkzILF
         qTkMLrflB/3im051DlnOuda+rJQjgQ4jdn+0Qb884w6Bjce9F5z1AaDw3J9JeolH0/JF
         jjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894178; x=1697498978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqKUg053lyYsj/ooEOZyT990Wlr0Y5kgkhv8tFgOXzE=;
        b=rVFq0ZQA7HnvfVc6tnyKt6o94hRY8jm4MGHSKWsgVCpKPGUyDHro6DYWPFCnzqpjKz
         XGWYz8hTRsYDehI5Ipridpd44bxmHeondW+YO6ThmRp2STfrJjxxyw5IXu/BP6E4uQ9p
         skEWLN6spq2aSV8m+obJ1jYuREE8a//+B36sEIdZPkNvmzefPzWaAifSSw9dFdbcjEkh
         JePH7QSL/W+ZcOh44SJD7yS2XCGfuctv0TMklxkhzPB5zVgausx+qfUxBcXdnOBnHBoa
         b4YAmTa9WtfEBE+QKCdn+E9ms0rrOnoB7t0x+1tyfce2weOEC8rr8f37FiD5uozurMe/
         vWVQ==
X-Gm-Message-State: AOJu0YxzrlhV0pzFXqH7pOODkwlzKxKl2ywradr9KPuFld72xkivwuuC
        tSPDW4PQ13e2YG+0w0NJ/IDc39o8xEZajUU0
X-Google-Smtp-Source: AGHT+IHsLM7kRIdE7CL0q19bu1EBe+THGBPEJ2/zo2Ah6io0k42fzmOkQ5ph20+AMxYXfThggboNsQ==
X-Received: by 2002:a05:6a21:3e07:b0:171:c88a:891e with SMTP id bk7-20020a056a213e0700b00171c88a891emr298951pzc.55.1696894177976;
        Mon, 09 Oct 2023 16:29:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/11] doc/device-api: Rename to org.bluez.Device.rst
Date:   Mon,  9 Oct 2023 16:29:24 -0700
Message-ID: <20231009232933.500652-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames device-api.txt to org.bluez.Device.rst and generate a
manpage org.bluez.Device.5.
---
 Makefile.am              |  10 +-
 doc/device-api.txt       | 293 ----------------------------------
 doc/org.bluez.Device.rst | 329 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+), 297 deletions(-)
 delete mode 100644 doc/device-api.txt
 create mode 100644 doc/org.bluez.Device.rst

diff --git a/Makefile.am b/Makefile.am
index 5eb94985a1b7..9e74f4f0fc76 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -357,14 +357,16 @@ CLEANFILES += $(builtin_files) src/bluetooth.service
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
-man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.DeviceSet.5
+man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
+	    doc/org.bluez.DeviceSet.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
 		doc/org.bluez.MediaTransport.5
 endif
 manual_pages += src/bluetoothd.8
-manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.DeviceSet.5
+manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
+		doc/org.bluez.DeviceSet.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -405,12 +407,12 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/mgmt-api.txt \
-		doc/device-api.txt \
 		doc/agent-api.txt doc/profile-api.txt \
 		doc/network-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/input-api.txt
 
-EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.DeviceSet.rst
+EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
+	      doc/org.bluez.DeviceSet.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/device-api.txt b/doc/device-api.txt
deleted file mode 100644
index e4a8d3c5af33..000000000000
--- a/doc/device-api.txt
+++ /dev/null
@@ -1,293 +0,0 @@
-BlueZ D-Bus Device API description
-**********************************
-
-
-Device hierarchy
-================
-
-Service		org.bluez
-Interface	org.bluez.Device1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		void Connect()
-
-			This is a generic method to connect any profiles
-			the remote device supports that can be connected
-			to and have been flagged as auto-connectable on
-			our side. If only subset of profiles is already
-			connected it will try to connect currently disconnected
-			ones.
-
-			If at least one profile was connected successfully this
-			method will indicate success.
-
-			For dual-mode devices only one bearer is connected at
-			time, the conditions are in the following order:
-
-				1. Connect the disconnected bearer if already
-				connected.
-
-				2. Connect first the bonded bearer. If no
-				bearers are bonded or both are skip and check
-				latest seen bearer.
-
-				3. Connect last seen bearer, in case the
-				timestamps are the same BR/EDR takes
-				precedence.
-
-			Possible errors: org.bluez.Error.NotReady
-					 org.bluez.Error.Failed
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.AlreadyConnected
-
-		void Disconnect()
-
-			This method gracefully disconnects all connected
-			profiles and then terminates low-level ACL connection.
-
-			ACL connection will be terminated even if some profiles
-			were not disconnected properly e.g. due to misbehaving
-			device.
-
-			This method can be also used to cancel a preceding
-			Connect call before a reply to it has been received.
-
-			For non-trusted devices connected over LE bearer calling
-			this method will disable incoming connections until
-			Connect method is called again.
-
-			Possible errors: org.bluez.Error.NotConnected
-
-		void ConnectProfile(string uuid)
-
-			This method connects a specific profile of this
-			device. The UUID provided is the remote service
-			UUID for the profile.
-
-			Possible errors: org.bluez.Error.Failed
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotAvailable
-					 org.bluez.Error.NotReady
-
-		void DisconnectProfile(string uuid)
-
-			This method disconnects a specific profile of
-			this device. The profile needs to be registered
-			client profile.
-
-			There is no connection tracking for a profile, so
-			as long as the profile is registered this will always
-			succeed.
-
-			Possible errors: org.bluez.Error.Failed
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-
-		void Pair()
-
-			This method will connect to the remote device,
-			initiate pairing and then retrieve all SDP records
-			(or GATT primary services).
-
-			If the application has registered its own agent,
-			then that specific agent will be used. Otherwise
-			it will use the default agent.
-
-			Only for applications like a pairing wizard it
-			would make sense to have its own agent. In almost
-			all other cases the default agent will handle
-			this just fine.
-
-			In case there is no application agent and also
-			no default agent present, this method will fail.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-					 org.bluez.Error.AlreadyExists
-					 org.bluez.Error.AuthenticationCanceled
-					 org.bluez.Error.AuthenticationFailed
-					 org.bluez.Error.AuthenticationRejected
-					 org.bluez.Error.AuthenticationTimeout
-					 org.bluez.Error.ConnectionAttemptFailed
-
-		void CancelPairing()
-
-			This method can be used to cancel a pairing
-			operation initiated by the Pair method.
-
-			Possible errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.Failed
-
-Properties	string Address [readonly]
-
-			The Bluetooth device address of the remote device.
-
-		string AddressType [readonly]
-
-			The Bluetooth device Address Type. For dual-mode and
-			BR/EDR only devices this defaults to "public". Single
-			mode LE devices may have either value. If remote device
-			uses privacy than before pairing this represents address
-			type used for connection and Identity Address after
-			pairing.
-
-			Possible values:
-				"public" - Public address
-				"random" - Random address
-
-		string Name [readonly, optional]
-
-			The Bluetooth remote name. This value can not be
-			changed. Use the Alias property instead.
-
-			This value is only present for completeness. It is
-			better to always use the Alias property when
-			displaying the devices name.
-
-			If the Alias property is unset, it will reflect
-			this value which makes it more convenient.
-
-		string Icon [readonly, optional]
-
-			Proposed icon name according to the freedesktop.org
-			icon naming specification.
-
-		uint32 Class [readonly, optional]
-
-			The Bluetooth class of device of the remote device.
-
-		uint16 Appearance [readonly, optional]
-
-			External appearance of device, as found on GAP service.
-
-		array{string} UUIDs [readonly, optional]
-
-			List of 128-bit UUIDs that represents the available
-			remote services.
-
-		boolean Paired [readonly]
-
-			Indicates if the remote device is paired. Paired means
-			the pairing process where devices exchange the
-			information to establish an encrypted connection has
-			been completed.
-
-		boolean Bonded [readonly]
-
-			Indicates if the remote device is bonded. Bonded means
-			the information exchanged on pairing process has been
-			stored and will be persisted.
-
-		boolean Connected [readonly]
-
-			Indicates if the remote device is currently connected.
-			A PropertiesChanged signal indicate changes to this
-			status.
-
-		boolean Trusted [readwrite]
-
-			Indicates if the remote is seen as trusted. This
-			setting can be changed by the application.
-
-		boolean Blocked [readwrite]
-
-			If set to true any incoming connections from the
-			device will be immediately rejected. Any device
-			drivers will also be removed and no new ones will
-			be probed as long as the device is blocked.
-
-		boolean WakeAllowed [readwrite]
-
-			If set to true this device will be allowed to wake the
-			host from system suspend.
-
-		string Alias [readwrite]
-
-			The name alias for the remote device. The alias can
-			be used to have a different friendly name for the
-			remote device.
-
-			In case no alias is set, it will return the remote
-			device name. Setting an empty string as alias will
-			convert it back to the remote device name.
-
-			When resetting the alias with an empty string, the
-			property will default back to the remote name.
-
-		object Adapter [readonly]
-
-			The object path of the adapter the device belongs to.
-
-		boolean LegacyPairing [readonly]
-
-			Set to true if the device only supports the pre-2.1
-			pairing mechanism. This property is useful during
-			device discovery to anticipate whether legacy or
-			simple pairing will occur if pairing is initiated.
-
-			Note that this property can exhibit false-positives
-			in the case of Bluetooth 2.1 (or newer) devices that
-			have disabled Extended Inquiry Response support.
-
-		string Modalias [readonly, optional]
-
-			Remote Device ID information in modalias format
-			used by the kernel and udev.
-
-		int16 RSSI [readonly, optional]
-
-			Received Signal Strength Indicator of the remote
-			device (inquiry or advertising).
-
-		int16 TxPower [readonly, optional]
-
-			Advertised transmitted power level (inquiry or
-			advertising).
-
-		dict ManufacturerData [readonly, optional]
-
-			Manufacturer specific advertisement data. Keys are
-			16 bits Manufacturer ID followed by its byte array
-			value.
-
-		dict ServiceData [readonly, optional]
-
-			Service advertisement data. Keys are the UUIDs in
-			string format followed by its byte array value.
-
-		bool ServicesResolved [readonly]
-
-			Indicate whether or not service discovery has been
-			resolved.
-
-		array{byte} AdvertisingFlags [readonly, experimental]
-
-			The Advertising Data Flags of the remote device.
-
-		dict AdvertisingData [readonly, experimental]
-
-			The Advertising Data of the remote device. Keys are
-			are 8 bits AD Type followed by data as byte array.
-
-			Note: Only types considered safe to be handled by
-			application are exposed.
-
-			Possible values:
-				<type> <byte array>
-				...
-
-			Example:
-				<Transport Discovery> <Organization Flags...>
-				0x26                   0x01         0x01...
-
-		array{object, dict} Sets [readonly, experimental]
-
-			The object paths of the sets the device belongs to
-			followed by a dictionary which can contain the
-			following:
-
-				byte Rank:
-
-					Rank of the device in the Set.
diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
new file mode 100644
index 000000000000..4fdb31b0acbe
--- /dev/null
+++ b/doc/org.bluez.Device.rst
@@ -0,0 +1,329 @@
+================
+org.bluez.Device
+================
+
+------------------------------------
+BlueZ D-Bus Device API documentation
+------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.Device1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods
+-------
+
+void Connect()
+``````````````
+
+	Connects all profiles the remote device supports that can be connected
+	to and have been flagged as auto-connectable. If only subset of profiles
+	is already connected it will try to connect currently disconnected ones.
+
+	If at least one profile was connected successfully this method will
+	indicate success.
+
+	For dual-mode devices only one bearer is connected at time, the
+	conditions are in the following order:
+
+	1. Connect the disconnected bearer if already connected.
+
+	2. Connect first the bonded bearer. If no bearers are bonded or both
+	are skip and check latest seen bearer.
+
+	3. Connect last seen bearer, in case the timestamps are the same BR/EDR
+	takes precedence.
+
+	Possible errors:
+
+	:org.bluez.Error.NotReady:
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.AlreadyConnected:
+
+void Disconnect()
+`````````````````
+
+	Disconnects all connected profiles and then terminates low-level ACL
+	connection.
+
+	ACL connection will be terminated even if some profiles were not
+	disconnected properly e.g. due to misbehaving device.
+
+	This method can be also used to cancel a preceding Connect call before
+	a reply to it has been received.
+
+	For non-trusted devices connected over LE bearer calling this method
+	will disable incoming connections until Connect method is called again.
+
+	Possible errors:
+
+	:org.bluez.Error.NotConnected:
+
+void ConnectProfile(string uuid)
+````````````````````````````````
+
+	Connects a specific profile of this device. The UUID provided is the
+	remote service UUID for the profile.
+
+	Possible errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotAvailable:
+	:org.bluez.Error.NotReady:
+
+void DisconnectProfile(string uuid)
+```````````````````````````````````
+
+	Disconnects a specific profile of this device. The profile needs to be
+	registered client profile.
+
+	There is no connection tracking for a profile, so as long as the
+	profile is registered this will always succeed.
+
+	Possible errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+
+void Pair()
+```````````
+
+	Connects to the remote device and initiate pairing procedure then
+	proceed with service discovery.
+
+	If the application has registered its own agent, then that specific
+	agent will be used. Otherwise it will use the default agent.
+
+	Only for applications like a pairing wizard it would make sense to have
+	its own agent. In almost all other cases the default agent will handle
+	this just fine.
+
+	In case there is no application agent and also no default agent present,
+	this method will fail.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.AlreadyExists:
+	:org.bluez.Error.AuthenticationCanceled:
+	:org.bluez.Error.AuthenticationFailed:
+	:org.bluez.Error.AuthenticationRejected:
+	:org.bluez.Error.AuthenticationTimeout:
+	:org.bluez.Error.ConnectionAttemptFailed:
+
+void CancelPairing()
+````````````````````
+
+	Cancels a pairing operation initiated by the **Pair** method.
+
+	Possible errors:
+
+	:org.bluez.Error.DoesNotExist:
+	:org.bluez.Error.Failed:
+
+Properties
+----------
+
+string Address [readonly]
+`````````````````````````
+
+	The Bluetooth device address of the remote device.
+
+string AddressType [readonly]
+`````````````````````````````
+
+	The Bluetooth device Address Type. For dual-mode and BR/EDR only devices
+	this defaults to "public". Single mode LE devices may have either value.
+	If remote device uses privacy than before pairing this represents
+	address type used for connection and Identity Address after pairing.
+
+	Possible values:
+
+	:"public":
+
+		Public address
+
+	:"random":
+
+		Random address
+
+string Name [readonly, optional]
+````````````````````````````````
+
+	The Bluetooth remote name.
+
+	This value is only present for completeness. It is better to always use
+	the **Alias** property when displaying the devices name.
+
+	If the **Alias** property is unset, it will reflect this value which
+	makes it more convenient.
+
+string Icon [readonly, optional]
+````````````````````````````````
+
+	Proposed icon name according to the freedesktop.org icon naming
+	specification.
+
+uint32 Class [readonly, optional]
+`````````````````````````````````
+
+	The Bluetooth class of device of the remote device.
+
+uint16 Appearance [readonly, optional]
+``````````````````````````````````````
+
+	External appearance of device, as found on GAP service.
+
+array{string} UUIDs [readonly, optional]
+````````````````````````````````````````
+
+	List of 128-bit UUIDs that represents the available remote services.
+
+boolean Paired [readonly]
+`````````````````````````
+
+	Indicates if the remote device is paired. Paired means the pairing
+	process where devices exchange the information to establish an
+	encrypted connection has been completed.
+
+boolean Bonded [readonly]
+`````````````````````````
+
+	Indicates if the remote device is bonded. Bonded means the information
+	exchanged on pairing process has been stored and will be persisted.
+
+boolean Connected [readonly]
+````````````````````````````
+
+	Indicates if the remote device is currently connected.
+	A PropertiesChanged signal indicate changes to this status.
+
+boolean Trusted [readwrite]
+```````````````````````````
+
+	Indicates if the remote is seen as trusted. This setting can be changed
+	by the application.
+
+boolean Blocked [readwrite]
+```````````````````````````
+
+	If set to true any incoming connections from the device will be
+	immediately rejected. Any device drivers will also be removed and
+	no new ones will be probed as long as the device is blocked.
+
+boolean WakeAllowed [readwrite]
+```````````````````````````````
+
+	If set to true this device will be allowed to wake the host from
+	system suspend.
+
+string Alias [readwrite]
+````````````````````````
+
+	The name alias for the remote device. The alias can be used to have a
+	different friendly name for the remote device.
+
+	In case no alias is set, it will return the remote device name. Setting
+	an empty string as alias will convert it back to the remote device name.
+
+	When resetting the alias with an empty string, the property will default
+	back to the remote name.
+
+object Adapter [readonly]
+`````````````````````````
+
+	The object path of the adapter the device belongs to.
+
+boolean LegacyPairing [readonly]
+````````````````````````````````
+
+	Set to true if the device only supports the pre-2.1 pairing mechanism.
+	This property is useful during device discovery to anticipate whether
+	legacy or simple pairing will occur if pairing is initiated.
+
+	Note that this property can exhibit false-positives in the case of
+	Bluetooth 2.1 (or newer) devices that have disabled Extended Inquiry
+	Response support.
+
+string Modalias [readonly, optional]
+````````````````````````````````````
+
+	Remote Device ID information in modalias format used by the kernel and
+	udev.
+
+int16 RSSI [readonly, optional]
+```````````````````````````````
+
+	Received Signal Strength Indicator of the remote device (inquiry or
+	advertising).
+
+int16 TxPower [readonly, optional]
+``````````````````````````````````
+
+	Advertised transmitted power level (inquiry or advertising).
+
+dict ManufacturerData [readonly, optional]
+``````````````````````````````````````````
+
+	Manufacturer specific advertisement data. Keys are 16 bits Manufacturer
+	ID followed by its byte array value.
+
+dict ServiceData [readonly, optional]
+`````````````````````````````````````
+
+	Service advertisement data. Keys are the UUIDs in string format followed
+	by its byte array value.
+
+bool ServicesResolved [readonly]
+````````````````````````````````
+
+	Indicate whether or not service discovery has been resolved.
+
+array{byte} AdvertisingFlags [readonly, experimental]
+`````````````````````````````````````````````````````
+
+	The Advertising Data Flags of the remote device.
+
+dict AdvertisingData [readonly, experimental]
+`````````````````````````````````````````````
+
+	The Advertising Data of the remote device. Keys are 1 byte AD Type
+	followed by data as byte array.
+
+	Note: Only types considered safe to be handled by application are
+	exposed.
+
+	Possible values:
+
+	:<type>:
+
+		<byte array>
+
+	Example:
+
+		<Transport Discovery> <Organization Flags...>
+		0x26                   0x01         0x01...
+
+array{object, dict} Sets [readonly, experimental]
+`````````````````````````````````````````````````
+
+	The object paths of the sets the device belongs to followed by a
+	dictionary which can contain the following:
+
+	:byte Rank:
+
+		Rank of the device in the Set.
-- 
2.41.0

