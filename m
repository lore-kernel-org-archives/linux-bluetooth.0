Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B63E94139
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjJGBB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJGBB6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 21:01:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91393BD
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 18:01:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-58916df84c8so1878693a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Oct 2023 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696640513; x=1697245313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7RBPLmDzGivlZggMbmZBgWVPFOALRZSlggaK2gzrmQ=;
        b=ayU/mZNuiW0kr4uq+GwzTfBrpdOjhSRcd2AX5iiyG5cvs1ccd6qO5NfuLxzC0PWOo+
         /iWcFeQVhvz3eSB7vCCWcFAtEQe/oczuw8S11sWhzaw4Vru+BnUnC33W1HF81N+dmX5A
         AA/BKMw63MZjPvEA6moiomwgwEljf1ImCyWsYukASKbfD58Bd9JUEqhHK9AHOQNLZD9c
         jahGYsT97JEzvOV3P8Qxoeo/odlrjkOM3HAOJnLA2Jj4DhhSycI3dPzfrWsP9sLycJ+e
         ydsDKFIM5Tjpb/MmXrcpbhQqOQXAF2fOy+s1pdqU/8sk5Xbgb4QaCGOm7MCTjjyRjtTx
         4B2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696640513; x=1697245313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7RBPLmDzGivlZggMbmZBgWVPFOALRZSlggaK2gzrmQ=;
        b=Cy5HKAOkgszpeJKWaNPKPUbgnH+TeZFhjojMC6URonsn8mJ/+jx+mFORurRiwImFbO
         VA79HMEn9gI2fOD0uEcJX9X9zV2yY7YeBqP+nyO7rxuLnTAQfbeLhSdZJo8PLqCpOosY
         v3vK/pmkUNe22qpzL0nmXr3Lyzpbaho09zAFb+rBDU6Sql8ks2xIplEXUGI83hgsCA0L
         GezxY3pnyDFgZM3T8PrMqRZl73BKEX9O/lkzKkMnIXCqEokaR6/OZGxQfj/rhs6xhtE6
         fHbut57plrySBxaNmjbYJ7jpTYtvWuiZ6IEvpCZJuoeNEX3Jnn3tT4L0eurSQsb4FduF
         hwBw==
X-Gm-Message-State: AOJu0YyxSqB6MbFi2U9CW6x4Q2K9mys2n0JzsgHxjYZC2y+oHvh4Gn+O
        kK6ZhuMx1QQ2LDUDxPobO03rdl4KYAhoN8hg
X-Google-Smtp-Source: AGHT+IG3j2U8nrrxTO6KiS7vQzE7s39x1HfWjV3RUWTplVCyWxvx2s4VqAcrY/hyzOVQjFFXSLCxIw==
X-Received: by 2002:a17:90b:38d2:b0:26d:fcd:89b3 with SMTP id nn18-20020a17090b38d200b0026d0fcd89b3mr9856952pjb.8.1696640512332;
        Fri, 06 Oct 2023 18:01:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id co11-20020a17090afe8b00b00279060a0fccsm4098360pjb.9.2023.10.06.18.01.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 18:01:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] doc/adapter-api: Rename to org.bluez.Adapter.rst
Date:   Fri,  6 Oct 2023 18:01:43 -0700
Message-ID: <20231007010150.4103452-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames adapter-api.txt to org.bluez.Adapter.rst and generate a
manpage org.bluez.Adapter.5.
---
 Makefile.am               |   8 +-
 doc/adapter-api.txt       | 373 ----------------------------------
 doc/org.bluez.Adapter.rst | 412 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+), 377 deletions(-)
 delete mode 100644 doc/adapter-api.txt
 create mode 100644 doc/org.bluez.Adapter.rst

diff --git a/Makefile.am b/Makefile.am
index 8d35dbb55e69..5eb94985a1b7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -357,14 +357,14 @@ CLEANFILES += $(builtin_files) src/bluetooth.service
 
 if MANPAGES
 man_MANS += src/bluetoothd.8
-man_MANS += doc/org.bluez.DeviceSet.5
+man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.DeviceSet.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
 		doc/org.bluez.MediaTransport.5
 endif
 manual_pages += src/bluetoothd.8
-manual_pages += doc/org.bluez.DeviceSet.5
+manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.DeviceSet.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -405,12 +405,12 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/mgmt-api.txt \
-		doc/adapter-api.txt doc/device-api.txt \
+		doc/device-api.txt \
 		doc/agent-api.txt doc/profile-api.txt \
 		doc/network-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/input-api.txt
 
-EXTRA_DIST += doc/org.bluez.DeviceSet.rst
+EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.DeviceSet.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
deleted file mode 100644
index 10c290c62fe2..000000000000
--- a/doc/adapter-api.txt
+++ /dev/null
@@ -1,373 +0,0 @@
-BlueZ D-Bus Adapter API description
-***********************************
-
-
-Adapter hierarchy
-=================
-
-Service		org.bluez
-Interface	org.bluez.Adapter1
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Methods		void StartDiscovery()
-
-			This method starts the device discovery session. This
-			includes an inquiry procedure and remote device name
-			resolving. Use StopDiscovery to release the sessions
-			acquired.
-
-			This process will start creating Device objects as
-			new devices are discovered.
-
-			During discovery RSSI delta-threshold is imposed.
-
-			Each client can request a single device discovery session
-			per adapter.
-
-			Possible errors: org.bluez.Error.NotReady
-					 org.bluez.Error.Failed
-					 org.bluez.Error.InProgress
-
-		void StopDiscovery()
-
-			This method will cancel any previous StartDiscovery
-			transaction.
-
-			Note that a discovery procedure is shared between all
-			discovery sessions thus calling StopDiscovery will only
-			release a single session and discovery will stop when
-			all sessions from all clients have finished.
-
-			Possible errors: org.bluez.Error.NotReady
-					 org.bluez.Error.Failed
-					 org.bluez.Error.NotAuthorized
-
-		void RemoveDevice(object device)
-
-			This removes the remote device object at the given
-			path. It will remove also the pairing information.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-
-		void SetDiscoveryFilter(dict filter)
-
-			This method sets the device discovery filter for the
-			caller. When this method is called with no filter
-			parameter, filter is removed.
-
-			Parameters that may be set in the filter dictionary
-			include the following:
-
-			array{string} UUIDs
-
-				Filter by service UUIDs, empty means match
-				_any_ UUID.
-
-				When a remote device is found that advertises
-				any UUID from UUIDs, it will be reported if:
-				- Pathloss and RSSI are both empty.
-				- only Pathloss param is set, device advertise
-				  TX pwer, and computed pathloss is less than
-				  Pathloss param.
-				- only RSSI param is set, and received RSSI is
-				  higher than RSSI param.
-
-			int16 RSSI
-
-				RSSI threshold value.
-
-				PropertiesChanged signals will be emitted
-				for already existing Device objects, with
-				updated RSSI value. If one or more discovery
-				filters have been set, the RSSI delta-threshold,
-				that is imposed by StartDiscovery by default,
-				will not be applied.
-
-			uint16 Pathloss
-
-				Pathloss threshold value.
-
-				PropertiesChanged signals will be emitted
-				for already existing Device objects, with
-				updated Pathloss value.
-
-			string Transport (Default "auto")
-
-				Transport parameter determines the type of
-				scan.
-
-				Possible values:
-					"auto"	- interleaved scan
-					"bredr"	- BR/EDR inquiry
-					"le"	- LE scan only
-
-				If "le" or "bredr" Transport is requested,
-				and the controller doesn't support it,
-				org.bluez.Error.Failed error will be returned.
-				If "auto" transport is requested, scan will use
-				LE, BREDR, or both, depending on what's
-				currently enabled on the controller.
-
-			bool DuplicateData (Default: true)
-
-				Disables duplicate detection of advertisement
-				data.
-
-				When enabled PropertiesChanged signals will be
-				generated for either ManufacturerData and
-				ServiceData everytime they are discovered.
-
-			bool Discoverable (Default: false)
-
-				Make adapter discoverable while discovering,
-				if the adapter is already discoverable setting
-				this filter won't do anything.
-
-			string Pattern (Default: none)
-
-				Discover devices where the pattern matches
-				either the prefix of the address or
-				device name which is convenient way to limited
-				the number of device objects created during a
-				discovery.
-
-				When set disregards device discoverable flags.
-
-				Note: The pattern matching is ignored if there
-				are other client that don't set any pattern as
-				it work as a logical OR, also setting empty
-				string "" pattern will match any device found.
-
-			When discovery filter is set, Device objects will be
-			created as new devices with matching criteria are
-			discovered regardless of they are connectable or
-			discoverable which enables listening to
-			non-connectable and non-discoverable devices.
-
-			When multiple clients call SetDiscoveryFilter, their
-			filters are internally merged, and notifications about
-			new devices are sent to all clients. Therefore, each
-			client must check that device updates actually match
-			its filter.
-
-			When SetDiscoveryFilter is called multiple times by the
-			same client, last filter passed will be active for
-			given client.
-
-			SetDiscoveryFilter can be called before StartDiscovery.
-			It is useful when client will create first discovery
-			session, to ensure that proper scan will be started
-			right after call to StartDiscovery.
-
-			Possible errors: org.bluez.Error.NotReady
-					 org.bluez.Error.NotSupported
-					 org.bluez.Error.Failed
-
-		array{string} GetDiscoveryFilters()
-
-			Return available filters that can be given to
-			SetDiscoveryFilter.
-
-			Possible errors: None
-
-		object ConnectDevice(dict properties) [experimental]
-
-			This method connects to device without need of
-			performing General Discovery. Connection mechanism is
-			similar to Connect method from Device1 interface with
-			exception that this method returns success when physical
-			connection is established and you can specify bearer to
-			connect with parameter. After this method returns,
-			services discovery will continue and any supported
-			profile will be connected. There is no need for calling
-			Connect on Device1 after this call. If connection was
-			successful this method returns object path to created
-			device object or device that already exist.
-
-			Parameters that may be set in the filter dictionary
-			include the following:
-
-			string Address
-
-				The Bluetooth device address of the remote
-				device. This parameter is mandatory.
-
-			string AddressType
-
-				The Bluetooth device Address Type. This is
-				address type that should be used for initial
-				connection. If this parameter is not present
-				BR/EDR device is created.
-
-				Possible values:
-					"public" - Public address
-					"random" - Random address
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-					 org.bluez.Error.NotSupported
-					 org.bluez.Error.NotReady
-					 org.bluez.Error.Failed
-
-Properties	string Address [readonly]
-
-			The Bluetooth device address.
-
-		string AddressType [readonly]
-
-			The Bluetooth  Address Type. For dual-mode and BR/EDR
-			only adapter this defaults to "public". Single mode LE
-			adapters may have either value. With privacy enabled
-			this contains type of Identity Address and not type of
-			address used for connection.
-
-			Possible values:
-				"public" - Public address
-				"random" - Random address
-
-		string Name [readonly]
-
-			The Bluetooth system name (pretty hostname).
-
-			This property is either a static system default
-			or controlled by an external daemon providing
-			access to the pretty hostname configuration.
-
-		string Alias [readwrite]
-
-			The Bluetooth friendly name. This value can be
-			changed.
-
-			In case no alias is set, it will return the system
-			provided name. Setting an empty string as alias will
-			convert it back to the system provided name.
-
-			When resetting the alias with an empty string, the
-			property will default back to system name.
-
-			On a well configured system, this property never
-			needs to be changed since it defaults to the system
-			name and provides the pretty hostname. Only if the
-			local name needs to be different from the pretty
-			hostname, this property should be used as last
-			resort.
-
-		uint32 Class [readonly]
-
-			The Bluetooth class of device.
-
-			This property represents the value that is either
-			automatically configured by DMI/ACPI information
-			or provided as static configuration.
-
-		boolean Powered [readwrite]
-
-			Switch an adapter on or off. This will also set the
-			appropriate connectable state of the controller.
-
-			The value of this property is not persistent. After
-			restart or unplugging of the adapter it will reset
-			back to false.
-
-		string PowerState [readonly, experimental]
-
-			The power state of an adapter.
-
-			The power state will show whether the adapter is
-			turning off, or turning on, as well as being on
-			or off.
-
-			Possible values:
-				"on" - powered on
-				"off" - powered off
-				"off-enabling" - transitioning from "off" to "on"
-				"on-disabling" - transitioning from "on" to "off"
-				"off-blocked" - blocked by rfkill
-
-		boolean Discoverable [readwrite]
-
-			Switch an adapter to discoverable or non-discoverable
-			to either make it visible or hide it. This is a global
-			setting and should only be used by the settings
-			application.
-
-			If the DiscoverableTimeout is set to a non-zero
-			value then the system will set this value back to
-			false after the timer expired.
-
-			In case the adapter is switched off, setting this
-			value will fail.
-
-			When changing the Powered property the new state of
-			this property will be updated via a PropertiesChanged
-			signal.
-
-			For any new adapter this settings defaults to false.
-
-		boolean Pairable [readwrite]
-
-			Switch an adapter to pairable or non-pairable. This is
-			a global setting and should only be used by the
-			settings application.
-
-			Note that this property only affects incoming pairing
-			requests.
-
-			For any new adapter this settings defaults to true.
-
-		uint32 PairableTimeout [readwrite]
-
-			The pairable timeout in seconds. A value of zero
-			means that the timeout is disabled and it will stay in
-			pairable mode forever.
-
-			The default value for pairable timeout should be
-			disabled (value 0).
-
-		uint32 DiscoverableTimeout [readwrite]
-
-			The discoverable timeout in seconds. A value of zero
-			means that the timeout is disabled and it will stay in
-			discoverable/limited mode forever.
-
-			The default value for the discoverable timeout should
-			be 180 seconds (3 minutes).
-
-		boolean Discovering [readonly]
-
-			Indicates that a device discovery procedure is active.
-
-		array{string} UUIDs [readonly]
-
-			List of 128-bit UUIDs that represents the available
-			local services.
-
-		string Modalias [readonly, optional]
-
-			Local Device ID information in modalias format
-			used by the kernel and udev.
-
-		array{string} Roles [readonly]
-
-			List of supported roles. Possible values:
-				"central": Supports the central role.
-				"peripheral": Supports the peripheral role.
-				"central-peripheral": Supports both roles
-						      concurrently.
-
-		array{string} ExperimentalFeatures [readonly, optional]
-
-			List of 128-bit UUIDs that represents the experimental
-			features currently enabled.
-
-		uint16 Manufacturer [readonly]
-
-			The manufacturer of the device, as a uint16 company
-			identifier defined by the Core Bluetooth Specification.
-
-		byte Version [readonly]
-
-			The Bluetooth version supported by the device, as a
-			core version code defined by the Core Bluetooth
-			Specification.
diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
new file mode 100644
index 000000000000..f537281238e4
--- /dev/null
+++ b/doc/org.bluez.Adapter.rst
@@ -0,0 +1,412 @@
+=================
+org.bluez.Adapter
+=================
+
+-------------------------------------
+BlueZ D-Bus Adapter API documentation
+-------------------------------------
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
+:Interface:	org.bluez.Adapter1
+:Object path:	[variable prefix]/{hci0,hci1,...}
+
+Methods
+-------
+
+void StartDiscovery()
+`````````````````````
+
+	Starts device discovery session which may include starting an inquiry
+	and/or scanning procedures and remote device name resolving.
+
+	Use **StopDiscovery** to release the sessions acquired.
+
+	This process will start creating Device objects as new devices are
+	discovered.
+
+	During discovery RSSI delta-threshold is imposed.
+
+	Each client can request a single device discovery session per adapter.
+
+	Possible errors:
+
+	:org.bluez.Error.NotReady:
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.InProgress:
+
+void StopDiscovery()
+````````````````````
+
+	Stops device discovery session started by **StartDiscovery**.
+
+	Note that a discovery procedure is shared between all discovery sessions
+	thus calling StopDiscovery will only release a single session and
+	discovery will stop when all sessions from all clients have finished.
+
+	Possible errors:
+
+	:org.bluez.Error.NotReady:
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotAuthorized:
+
+void RemoveDevice(object device)
+````````````````````````````````
+
+	Removes the remote device object at the given path including cahed
+	information such as bonding information.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.Failed:
+
+void SetDiscoveryFilter(dict filter)
+````````````````````````````````````
+
+	Sets the device discovery filter for the caller. When this method is
+	called with no filter parameter, filter is removed.
+
+	Possible filter values:
+
+	:array{string} UUIDs:
+
+		Filter by service UUIDs, empty means match *any* UUID.
+
+		When a remote device is found that advertises any UUID from
+		UUIDs, it will be reported if:
+
+		- **Pathloss** and **RSSI** are both empty.
+		- only **Pathloss** param is set, device advertise TX power, and
+		  computed pathloss is less than Pathloss param.
+		- only **RSSI** param is set, and received RSSI is higher
+		  than RSSI param.
+
+	:int16 RSSI:
+
+		RSSI threshold value.
+
+		PropertiesChanged signals will be emitted for already existing
+		Device objects, with updated RSSI value. If one or more
+		discovery filters have been set, the RSSI delta-threshold, that
+		is imposed by StartDiscovery by default, will not be applied.
+
+	:uint16 Pathloss:
+
+		Pathloss threshold value.
+
+		PropertiesChanged signals will be emitted for already existing
+		Device objects, with updated Pathloss value.
+
+	:string Transport (Default "auto"):
+
+		Transport parameter determines the type of scan.
+
+		Possible values:
+
+		:"auto":
+
+			Interleaved scan, use LE, BREDR, or both, depending on
+			what's currently enabled.
+
+		:"bredr":
+
+			BR/EDR inquiry only.
+
+		:"le":
+
+			LE scan only.
+
+
+	:bool DuplicateData (Default true):
+
+		Disables duplicate detection of advertisement data.
+
+		When enabled PropertiesChanged signals will be generated for
+		either ManufacturerData and ServiceData everytime they are
+		discovered.
+
+	:bool Discoverable (Default false):
+
+		Make adapter discoverable while discovering, if the adapter is
+		already discoverable setting this filter won't do anything.
+
+	:string Pattern (Default none):
+
+		Discover devices where the pattern matches either the prefix of
+		the address or device name which is convenient way to limited
+		the number of device objects created during a discovery.
+
+		When set disregards device discoverable flags.
+
+		Note: The pattern matching is ignored if there are other client
+		that don't set any pattern as it work as a logical OR, also
+		setting empty string "" pattern will match any device found.
+
+		When discovery filter is set, Device objects will be created as
+		new devices with matching criteria are discovered regardless of
+		they are connectable or discoverable which enables listening to
+		non-connectable and non-discoverable devices.
+
+		When multiple clients call SetDiscoveryFilter, their filters are
+		internally merged, and notifications about new devices are sent
+		to all clients. Therefore, each client must check that device
+		updates actually match its filter.
+
+		When SetDiscoveryFilter is called multiple times by the same
+		client, last filter passed will be active for given client.
+
+		SetDiscoveryFilter can be called before StartDiscovery.
+		It is useful when client will create first discovery session,
+		to ensure that proper scan will be started right after call to
+		StartDiscovery.
+
+		Possible errors:
+
+		:org.bluez.Error.NotReady:
+		:org.bluez.Error.NotSupported:
+		:org.bluez.Error.Failed:
+
+array{string} GetDiscoveryFilters()
+```````````````````````````````````
+
+	Returns available filters that can be given to **SetDiscoveryFilter**.
+
+	Possible errors: None
+
+object ConnectDevice(dict properties) [experimental]
+````````````````````````````````````````````````````
+
+	connects to device without need of performing General Discovery.
+	Connection mechanism is similar to Connect method on
+	**org.bluez.Device1(5)** interface with exception that this method
+	returns success when physical connection is established and you can
+	specify bearer to connect with parameter. After this method returns,
+	services discovery will continue and any supported profile will be
+	connected. There is no need for calling Connect on Device1 after this
+	call. If connection was successful this method returns object path to
+	created device object or device that already exist.
+
+	Possible properties values:
+
+	:string Address (Mandatory):
+
+		The Bluetooth device address of the remote device.
+
+	:string AddressType (Default "BR/EDR"):
+
+		The Bluetooth device Address Type. This is address type that
+		should be used for initial connection.
+
+		Possible values:
+
+		:"public":
+
+			Public address
+
+		:"random":
+
+			Random address
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.AlreadyExists:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.NotReady:
+	:org.bluez.Error.Failed:
+
+Properties
+----------
+
+string Address [readonly]
+`````````````````````````
+
+	The Bluetooth device address.
+
+string AddressType [readonly]
+`````````````````````````````
+
+	The Bluetooth Address Type. For dual-mode and BR/EDR only adapter this
+	defaults to "public". Single mode LE adapters may have either value.
+	With privacy enabled this contains type of Identity Address and not
+	type of address used for connection.
+
+	Possible values:
+
+	:"public":
+
+		Public address.
+
+
+	:"random:
+
+		Random address.
+
+string Name [readonly]
+``````````````````````
+
+	The Bluetooth system name (pretty hostname).
+
+	This property is either a static system default or controlled by an
+	external daemon providing access to the pretty hostname configuration.
+
+string Alias [readwrite]
+````````````````````````
+
+	The Bluetooth friendly name. This value can be changed.
+
+	In case no alias is set, it will return the system provided name.
+	Setting an empty string as alias will convert it back to the system
+	provided name.
+
+	When resetting the alias with an empty string, the property will default
+	back to system name.
+
+	On a well configured system, this property never needs to be changed
+	since it defaults to the system name and provides the pretty hostname.
+	Only if the local name needs to be different from the pretty hostname,
+	this property should be used as last resort.
+
+uint32 Class [readonly]
+```````````````````````
+
+	The Bluetooth class of device.
+
+	This property represents the value that is either automatically
+	configured by DMI/ACPI information or provided as static configuration.
+
+boolean Powered [readwrite]
+```````````````````````````
+
+	Switch an adapter on or off. This will also set the appropriate
+	connectable state of the controller.
+
+	The value of this property is not persistent. After restart or
+	unplugging of the adapter it will reset back to false.
+
+string PowerState [readonly, experimental]
+``````````````````````````````````````````
+
+	The power state of an adapter.
+
+	The power state will show whether the adapter is turning off, or turning
+	on, as well as being on or off.
+
+	Possible values:
+
+	:"on":
+
+		Powered on.
+
+	:"off":
+
+		Powered off
+
+	:"off-enabling":
+
+		Transitioning from "off" to "on".
+
+	:"on-disabling":
+
+		Transitioning from "on" to "off".
+
+	:"off-blocked":
+
+		Blocked by rfkill.
+
+boolean Discoverable [readwrite] (Default: false)
+`````````````````````````````````````````````````
+
+	Switch an adapter to discoverable or non-discoverable to either make it
+	visible or hide it. This is a global setting and should only be used by
+	the settings application.
+
+	If the DiscoverableTimeout is set to a non-zero value then the system
+	will set this value back to false after the timer expired.
+
+	In case the adapter is switched off, setting this value will fail.
+
+	When changing the Powered property the new state of this property will
+	be updated via a PropertiesChanged signal.
+
+boolean Pairable [readwrite] (Default: true)
+````````````````````````````````````````````
+
+	Switch an adapter to pairable or non-pairable. This is a global setting
+	and should only be used by the settings application.
+
+	Note that this property only affects incoming pairing requests.
+
+uint32 PairableTimeout [readwrite] (Default: 0)
+```````````````````````````````````````````````
+
+	The pairable timeout in seconds. A value of zero means that the timeout
+	is disabled and it will stay in pairable mode forever.
+
+uint32 DiscoverableTimeout [readwrite] (Default: 180)
+`````````````````````````````````````````````````````
+
+	The discoverable timeout in seconds. A value of zero means that the
+	timeout is disabled and it will stay in discoverable/limited mode
+	forever.
+
+boolean Discovering [readonly]
+``````````````````````````````
+
+	Indicates that a device discovery procedure is active.
+
+array{string} UUIDs [readonly]
+``````````````````````````````
+
+	List of 128-bit UUIDs that represents the available local services.
+
+string Modalias [readonly, optional]
+````````````````````````````````````
+
+	Local Device ID information in modalias format used by the kernel and
+	udev.
+
+array{string} Roles [readonly]
+``````````````````````````````
+
+	List of supported roles.
+
+	Possible values:
+
+	:"central":
+
+		Supports the central role.
+
+	:"peripheral":
+
+		Supports the peripheral role.
+
+	:"central-peripheral":
+
+		Supports both roles concurrently.
+
+array{string} ExperimentalFeatures [readonly, optional]
+```````````````````````````````````````````````````````
+
+	List of 128-bit UUIDs that represents the experimental features
+	currently enabled.
+
+uint16 Manufacturer [readonly]
+``````````````````````````````
+
+	The manufacturer of the device, as a uint16 company identifier defined
+	by the Core Bluetooth Specification.
+
+byte Version [readonly]
+```````````````````````
+
+	The Bluetooth version supported by the device, as a core version code
+	defined by the Core Bluetooth Specification.
-- 
2.41.0

