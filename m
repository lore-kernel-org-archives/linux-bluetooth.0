Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F007E9371F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjJIX3n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjJIX3m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A16A4
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c87a85332bso41980515ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894176; x=1697498976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7RBPLmDzGivlZggMbmZBgWVPFOALRZSlggaK2gzrmQ=;
        b=D9g5rRSAwFBfFlWeDKXjCSpEjWazuImDaqBlUv0+9Y06FErCi5USVza12YBy660ABg
         ZHr8eb987JmHyaZrVH9VrM1i3MTJwjnj00dHhiswH8Gc6rPa4xwjUTRWohycSTZy2CE6
         EdIRvesGyDJ+JaHX3efZVNJEFDeL5bF3Z/gPB2GgFfN7Xk7W8ayLh9Rz5l5mIWMZ6zKW
         vdajzKUMejJzvqUvyqE3SD8RVKtzc2rHgV1l56dWCU02wHiURM8ygIsejm4A/Q1XZ6A4
         52NRfggGPp6ThvKeFyQuNYPEu5xA6+//4Q9qFNo9hAFcL2qAMx+vxB5sloIzwWXpBKXo
         wPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894176; x=1697498976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7RBPLmDzGivlZggMbmZBgWVPFOALRZSlggaK2gzrmQ=;
        b=PFTrPCuC2LZ8B2yiFisGolgapQSLPFjHpRkiquTwt8ainKeF8t20bv9DXrdheRi6Fh
         Wi6+OuLa08R7jSf5f15LdqY9+wzPkhL86jQIihrYEV9wZN10GTqgIXD43Z3BUK+3clyv
         jH1gvYyp/8V3FfYLxIN+C0Qz3U9frENs53VACeiXI5//pEqe0RbSLKCVFu4PXdEwvQnf
         1RFslLBzC3DaZGt9jJqJPrY6GFIUKa8+NgKd369Wa4YtTyDYYnEURERt7tgDj9W2N6Nu
         Fc5bBcJDM1cZvHsiPBwq0YocMuVwZqiSYXJgRvDVsiX3VWID3aDNzVVTzCxnyIUJFdh2
         z81w==
X-Gm-Message-State: AOJu0YweuZ+XlODz8s2oURd22r84UWisDCjvvGfeHuFams0ggGZiEiQ8
        RjMHo7Kj+JhGKAErwunpkSj8/uQKZJd2QSCJ
X-Google-Smtp-Source: AGHT+IGYCTVniZ2yV3Gk/ed+zFaRzbdpcP7yhAOavKyQ4SswZ7SqyQCbq2jxf/Hu30hRZY0FRDFaFw==
X-Received: by 2002:a17:902:ecd1:b0:1c0:cbaf:6930 with SMTP id a17-20020a170902ecd100b001c0cbaf6930mr18569451plh.54.1696894175581;
        Mon, 09 Oct 2023 16:29:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/11] doc/adapter-api: Rename to org.bluez.Adapter.rst
Date:   Mon,  9 Oct 2023 16:29:23 -0700
Message-ID: <20231009232933.500652-1-luiz.dentz@gmail.com>
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

