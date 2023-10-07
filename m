Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0100E94139
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 01:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjJGBCN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjJGBCM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 21:02:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE883CA
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 18:02:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-564b6276941so1988629a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Oct 2023 18:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696640525; x=1697245325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a86wI1ZNAlgU2PnlOjRPjzbEAtoUse4LSuKIerJSG+Q=;
        b=EstbBsZDZWWGYzlnSgjA+hkQOynZs+GpB2ABQfCHVS3lG4Svtzbg8b8/exvjIJdKxi
         Xk6JwlYODZ7LnnFKhFmoSkUph0OinezK9oNJK5skEGouQJqFCzKFe88tf4VYjuTYjelX
         FPhK1AW90MtR59oWV3NJpVYfFgIEHsEymnj573HeYN7P6372C8ph/VIjomzKaWlv8uTm
         MOr/1a5fnsoNd8F9G6vVkX6K7zmZ3g+XqHhRiK3BIhsYiII4ikO9yxsAUo6tZ6ADOMaZ
         HXoRtUTZRfK9I+QICh2xHDuSQSL8KYLgI9Zmt7ZHzaE+xoh/JuEgZlGgckGoWOrmxpqh
         AmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696640525; x=1697245325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a86wI1ZNAlgU2PnlOjRPjzbEAtoUse4LSuKIerJSG+Q=;
        b=g3itXts65JUDY1CCPXhHOyjHaUkegdHLS2C2iRcIFXjiuycAKbXDu3Qfpe1ICw3Web
         TVXOuu7Ha32nQIBuwX41/9Hj+qxrgZriy+8QP/kSEc+4TxY5zgXmRKnSTeoaV0MWef6q
         Hp2hTrDTUDna2p+v0DXZCHvsuvHMBJN7Ndi5mPrTf7iUn+z8bByAbqv4QwNfUhHZlBjt
         Wtx9CdkBp/o2NmS/PyF5iaP63EWAnIkjEq9U9WdLt1uC8XbJ2KCrCPk73zV2FtUxlLRB
         /xOWctlM61YEpKe0BJqo2UINkPeuwieLaikxe0sih1HW81vcMniyscIy3lOXBfivyWLq
         kTGw==
X-Gm-Message-State: AOJu0Yy6anwTpWLBU/L437p/fg68I/0raabh6P0b/ep0jD1Ye05moHge
        owvfaQ9gOSPYpKPLHJe00qZzXu2T+zIACYbU
X-Google-Smtp-Source: AGHT+IFwlJHloscmpTbd8se7jROgw+h4NikQ3kjvSn5x/5hh5bW8gyw7iIFOZkBhP0vgO3+6uNAcEg==
X-Received: by 2002:a17:90a:8004:b0:274:6a79:17c1 with SMTP id b4-20020a17090a800400b002746a7917c1mr9721009pjn.15.1696640524687;
        Fri, 06 Oct 2023 18:02:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id co11-20020a17090afe8b00b00279060a0fccsm4098360pjb.9.2023.10.06.18.02.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 18:02:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] doc/gatt-api: Rename to org.bluez.Gatt*.rst
Date:   Fri,  6 Oct 2023 18:01:50 -0700
Message-ID: <20231007010150.4103452-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231007010150.4103452-1-luiz.dentz@gmail.com>
References: <20231007010150.4103452-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames gatt-api.txt to org.bluez.Gatt*.rst and generate manpages
org.bluez.Gatt*.5.
---
 Makefile.am                          |  18 +-
 doc/gatt-api.txt                     | 512 ---------------------------
 doc/org.bluez.GattCharacteristic.rst | 375 ++++++++++++++++++++
 doc/org.bluez.GattDescriptor.rst     | 167 +++++++++
 doc/org.bluez.GattManager.rst        | 114 ++++++
 doc/org.bluez.GattProfile.rst        |  46 +++
 doc/org.bluez.GattService.rst        |  79 +++++
 7 files changed, 796 insertions(+), 515 deletions(-)
 delete mode 100644 doc/gatt-api.txt
 create mode 100644 doc/org.bluez.GattCharacteristic.rst
 create mode 100644 doc/org.bluez.GattDescriptor.rst
 create mode 100644 doc/org.bluez.GattManager.rst
 create mode 100644 doc/org.bluez.GattProfile.rst
 create mode 100644 doc/org.bluez.GattService.rst

diff --git a/Makefile.am b/Makefile.am
index 892965261bef..d658dc27500a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -366,7 +366,11 @@ man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
 		doc/org.bluez.MediaTransport.5
-man_MANS += doc/org.bluez.LEAdvertisingManager.5 \
+man_MANS += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
+		doc/org.bluez.GattService.5 \
+		doc/org.bluez.GattCharacteristic.5 \
+		doc/org.bluez.GattDescriptor.5 \
+		doc/org.bluez.LEAdvertisingManager.5 \
 		doc/org.bluez.LEAdvertisement.5
 endif
 manual_pages += src/bluetoothd.8
@@ -379,7 +383,11 @@ manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
 		doc/org.bluez.MediaTransport.5
-manual_pages += doc/org.bluez.LEAdvertisingManager.5 \
+manual_pages += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
+		doc/org.bluez.GattService.5 \
+		doc/org.bluez.GattCharacteristic.5 \
+		doc/org.bluez.GattDescriptor.5 \
+		doc/org.bluez.LEAdvertisingManager.5 \
 		doc/org.bluez.LEAdvertisement.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
@@ -431,7 +439,11 @@ EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoint.rst \
 		doc/org.bluez.MediaTransport.rst
 
-EXTRA_DIST += doc/gatt-api.txt doc/org.bluez.LEAdvertisingManager.rst \
+EXTRA_DIST += doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.rst\
+		doc/org.bluez.GattService.rst \
+		doc/org.bluez.GattCharacteristic.rst \
+		doc/org.bluez.GattDescriptor.rst \
+		doc/org.bluez.LEAdvertisingManager.rst \
 		doc/org.bluez.LEAdvertisement.rst
 
 EXTRA_DIST += doc/obex-api.txt doc/obex-agent-api.txt
diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
deleted file mode 100644
index f29308aec843..000000000000
--- a/doc/gatt-api.txt
+++ /dev/null
@@ -1,512 +0,0 @@
-BlueZ D-Bus GATT API description
-********************************
-
-GATT local and remote services share the same high-level D-Bus API. Local
-refers to GATT based service exported by a BlueZ plugin or an external
-application. Remote refers to GATT services exported by the peer.
-
-BlueZ acts as a proxy, translating ATT operations to D-Bus method calls and
-Properties (or the opposite). Support for D-Bus Object Manager is mandatory for
-external services to allow seamless GATT declarations (Service, Characteristic
-and Descriptors) discovery. Each GATT service tree is required to export a D-Bus
-Object Manager at its root that is solely responsible for the objects that
-belong to that service.
-
-Releasing a registered GATT service is not defined yet. Any API extension
-should avoid breaking the defined API, and if possible keep an unified GATT
-remote and local services representation.
-
-Service hierarchy
-=================
-
-GATT remote and local service representation. Object path for local services
-is freely definable.
-
-External applications implementing local services must register the services
-using GattManager1 registration method and must implement the methods and
-properties defined in GattService1 interface.
-
-Service		org.bluez
-Interface	org.bluez.GattService1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX
-
-Properties	string UUID [read-only]
-
-			128-bit service UUID.
-
-		boolean Primary [read-only]
-
-			Indicates whether or not this GATT service is a
-			primary service. If false, the service is secondary.
-
-		object Device [read-only, optional]
-
-			Object path of the Bluetooth device the service
-			belongs to. Only present on services from remote
-			devices.
-
-		array{object} Includes [read-only, optional]
-
-			Array of object paths representing the included
-			services of this service.
-
-		uint16 Handle [read-write, optional] (Server Only)
-		              [read-only] (Client Only)
-
-			Service handle. When available in the server it
-			would attempt to use to allocate into the database
-			which may fail, to auto allocate the value 0x0000
-			shall be used which will cause the allocated handle to
-			be set once registered.
-
-
-Characteristic hierarchy
-========================
-
-For local GATT defined services, the object paths need to follow the service
-path hierarchy and are freely definable.
-
-Service		org.bluez
-Interface	org.bluez.GattCharacteristic1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
-
-Methods		array{byte} ReadValue(dict options)
-
-			Issues a request to read the value of the
-			characteristic and returns the value if the
-			operation was successful.
-
-			Possible options: "offset": uint16 offset
-					  "mtu": Exchanged MTU (Server only)
-					  "device": Object Device (Server only)
-
-			Possible Errors: org.bluez.Error.Failed(string ecode)
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.NotPermitted
-					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.InvalidOffset
-					 org.bluez.Error.NotSupported
-
-			Possible Error Code: string 0x80 - 0x9f
-
-		void WriteValue(array{byte} value, dict options)
-
-			Issues a request to write the value of the
-			characteristic.
-
-			Possible options: "offset": Start offset
-					  "type": string
-						Possible values:
-						"command": Write without
-						response
-						"request": Write with response
-						"reliable": Reliable Write
-					  "mtu": Exchanged MTU (Server only)
-					  "device": Device path (Server only)
-					  "link": Link type (Server only)
-					  "prepare-authorize": True if prepare
-							       authorization
-							       request
-
-			Possible Errors: org.bluez.Error.Failed(string ecode)
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.NotPermitted
-					 org.bluez.Error.InvalidValueLength
-					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.NotSupported
-
-			Possible Error Code: string 0x80 - 0x9f
-
-		fd, uint16 AcquireWrite(dict options) [optional]
-
-			Acquire file descriptor and MTU for writing. Only
-			sockets are supported. Usage of WriteValue will be
-			locked causing it to return NotPermitted error.
-
-			For server the MTU returned shall be equal or smaller
-			than the negotiated MTU.
-
-			For client it only works with characteristic that has
-			WriteAcquired property which relies on
-			write-without-response Flag.
-
-			To release the lock the client shall close the file
-			descriptor, a HUP is generated in case the device
-			is disconnected.
-
-			Note: the MTU can only be negotiated once and is
-			symmetric therefore this method may be delayed in
-			order to have the exchange MTU completed, because of
-			that the file descriptor is closed during
-			reconnections as the MTU has to be renegotiated.
-
-			Possible options: "device": Object Device (Server only)
-					  "mtu": Exchanged MTU (Server only)
-					  "link": Link type (Server only)
-
-			Possible Errors: org.bluez.Error.Failed
-					 org.bluez.Error.NotSupported
-
-		fd, uint16 AcquireNotify(dict options) [optional]
-
-			Acquire file descriptor and MTU for notify. Only
-			sockets are support. Usage of StartNotify will be locked
-			causing it to return NotPermitted error.
-
-			For server the MTU returned shall be equal or smaller
-			than the negotiated MTU.
-
-			Only works with characteristic that has NotifyAcquired
-			which relies on notify Flag and no other client have
-			called StartNotify.
-
-			Notification are enabled during this procedure so
-			StartNotify shall not be called, any notification
-			will be dispatched via file descriptor therefore the
-			Value property is not affected during the time where
-			notify has been acquired.
-
-			To release the lock the client shall close the file
-			descriptor, a HUP is generated in case the device
-			is disconnected.
-
-			Note: the MTU can only be negotiated once and is
-			symmetric therefore this method may be delayed in
-			order to have the exchange MTU completed, because of
-			that the file descriptor is closed during
-			reconnections as the MTU has to be renegotiated.
-
-			Possible options: "device": Object Device (Server only)
-					  "mtu": Exchanged MTU (Server only)
-					  "link": Link type (Server only)
-
-			Possible Errors: org.bluez.Error.Failed
-					 org.bluez.Error.NotSupported
-
-		void StartNotify()
-
-			Starts a notification session from this characteristic
-			if it supports value notifications or indications.
-
-			Possible Errors: org.bluez.Error.Failed
-					 org.bluez.Error.NotPermitted
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.NotConnected
-					 org.bluez.Error.NotSupported
-
-		void StopNotify()
-
-			This method will cancel any previous StartNotify
-			transaction. Note that notifications from a
-			characteristic are shared between sessions thus
-			calling StopNotify will release a single session.
-
-			Possible Errors: org.bluez.Error.Failed
-
-		void Confirm() [optional] (Server only)
-
-			This method doesn't expect a reply so it is just a
-			confirmation that value was received.
-
-			Possible Errors: org.bluez.Error.Failed
-
-Properties	string UUID [read-only]
-
-			128-bit characteristic UUID.
-
-		object Service [read-only]
-
-			Object path of the GATT service the characteristic
-			belongs to.
-
-		array{byte} Value [read-only, optional]
-
-			The cached value of the characteristic. This property
-			gets updated only after a successful read request and
-			when a notification or indication is received, upon
-			which a PropertiesChanged signal will be emitted.
-
-		boolean WriteAcquired [read-only, optional]
-
-			True, if this characteristic has been acquired by any
-			client using AcquireWrite.
-
-			For client properties is ommited in case
-			'write-without-response' flag is not set.
-
-			For server the presence of this property indicates
-			that AcquireWrite is supported.
-
-		boolean NotifyAcquired [read-only, optional]
-
-			True, if this characteristic has been acquired by any
-			client using AcquireNotify.
-
-			For client this properties is ommited in case 'notify'
-			flag is not set.
-
-			For server the presence of this property indicates
-			that AcquireNotify is supported.
-
-		boolean Notifying [read-only, optional]
-
-			True, if notifications or indications on this
-			characteristic are currently enabled.
-
-		array{string} Flags [read-only]
-
-			Defines how the characteristic value can be used. See
-			Core spec "Table 3.5: Characteristic Properties bit
-			field", and "Table 3.8: Characteristic Extended
-			Properties bit field".
-
-			The "x-notify" and "x-indicate" flags restrict access
-			to notifications and indications by imposing write
-			restrictions on a characteristic's client
-			characteristic configuration descriptor.
-
-			Allowed values:
-
-				"broadcast"
-				"read"
-				"write-without-response"
-				"write"
-				"notify"
-				"indicate"
-				"authenticated-signed-writes"
-				"extended-properties"
-				"reliable-write"
-				"writable-auxiliaries"
-				"encrypt-read"
-				"encrypt-write"
-				"encrypt-notify" (Server only)
-				"encrypt-indicate" (Server only)
-				"encrypt-authenticated-read"
-				"encrypt-authenticated-write"
-				"encrypt-authenticated-notify" (Server only)
-				"encrypt-authenticated-indicate" (Server only)
-				"secure-read" (Server only)
-				"secure-write" (Server only)
-				"secure-notify" (Server only)
-				"secure-indicate" (Server only)
-				"authorize"
-
-		uint16 Handle [read-write, optional] (Server Only)
-		              [read-only] (Client Only)
-
-			Characteristic handle. When available in the server it
-			would attempt to use to allocate into the database
-			which may fail, to auto allocate the value 0x0000
-			shall be used which will cause the allocated handle to
-			be set once registered.
-
-		uint16 MTU [read-only]
-
-			Characteristic MTU, this is valid both for ReadValue
-			and WriteValue but either method can use long
-			procedures when supported.
-
-Characteristic Descriptors hierarchy
-====================================
-
-Local or remote GATT characteristic descriptors hierarchy.
-
-Service		org.bluez
-Interface	org.bluez.GattDescriptor1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ
-
-Methods		array{byte} ReadValue(dict flags)
-
-			Issues a request to read the value of the
-			characteristic and returns the value if the
-			operation was successful.
-
-			Possible options: "offset": Start offset
-					  "device": Device path (Server only)
-					  "link": Link type (Server only)
-
-			Possible Errors: org.bluez.Error.Failed
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.NotPermitted
-					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.NotSupported
-
-		void WriteValue(array{byte} value, dict flags)
-
-			Issues a request to write the value of the
-			characteristic.
-
-			Possible options: "offset": Start offset
-					  "device": Device path (Server only)
-					  "link": Link type (Server only)
-					  "prepare-authorize": boolean Is prepare
-							       authorization
-							       request
-
-			Possible Errors: org.bluez.Error.Failed
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.NotPermitted
-					 org.bluez.Error.InvalidValueLength
-					 org.bluez.Error.NotAuthorized
-					 org.bluez.Error.NotSupported
-
-Properties	string UUID [read-only]
-
-			128-bit descriptor UUID.
-
-		object Characteristic [read-only]
-
-			Object path of the GATT characteristic the descriptor
-			belongs to.
-
-		array{byte} Value [read-only, optional]
-
-			The cached value of the descriptor. This property
-			gets updated only after a successful read request, upon
-			which a PropertiesChanged signal will be emitted.
-
-		array{string} Flags [read-only]
-
-			Defines how the descriptor value can be used.
-
-			Possible values:
-
-				"read"
-				"write"
-				"encrypt-read"
-				"encrypt-write"
-				"encrypt-authenticated-read"
-				"encrypt-authenticated-write"
-				"secure-read" (Server Only)
-				"secure-write" (Server Only)
-				"authorize"
-
-		uint16 Handle [read-write, optional] (Server Only)
-		              [read-only] (Client Only)
-
-			Characteristic handle. When available in the server it
-			would attempt to use to allocate into the database
-			which may fail, to auto allocate the value 0x0000
-			shall be used which will cause the allocated handle to
-			be set once registered.
-
-GATT Profile hierarchy
-=====================
-
-Local profile (GATT client) instance. By registering this type of object
-an application effectively indicates support for a specific GATT profile
-and requests automatic connections to be established to devices
-supporting it.
-
-Service		<application dependent>
-Interface	org.bluez.GattProfile1
-Object path	<application dependent>
-
-Methods		void Release()
-
-			This method gets called when the service daemon
-			unregisters the profile. The profile can use it to
-			do cleanup tasks. There is no need to unregister the
-			profile, because when this method gets called it has
-			already been unregistered.
-
-Properties	array{string} UUIDs [read-only]
-
-			128-bit GATT service UUIDs to auto connect.
-
-
-GATT Manager hierarchy
-======================
-
-GATT Manager allows external applications to register GATT services and
-profiles.
-
-Registering a profile allows applications to subscribe to *remote* services.
-These must implement the GattProfile1 interface defined above.
-
-Registering a service allows applications to publish a *local* GATT service,
-which then becomes available to remote devices. A GATT service is represented by
-a D-Bus object hierarchy where the root node corresponds to a service and the
-child nodes represent characteristics and descriptors that belong to that
-service. Each node must implement one of GattService1, GattCharacteristic1,
-or GattDescriptor1 interfaces described above, based on the attribute it
-represents. Each node must also implement the standard D-Bus Properties
-interface to expose their properties. These objects collectively represent a
-GATT service definition.
-
-To make service registration simple, BlueZ requires that all objects that belong
-to a GATT service be grouped under a D-Bus Object Manager that solely manages
-the objects of that service. Hence, the standard DBus.ObjectManager interface
-must be available on the root service path. An example application hierarchy
-containing two separate GATT services may look like this:
-
--> /com/example
-  |   - org.freedesktop.DBus.ObjectManager
-  |
-  -> /com/example/service0
-  | |   - org.freedesktop.DBus.Properties
-  | |   - org.bluez.GattService1
-  | |
-  | -> /com/example/service0/char0
-  | |     - org.freedesktop.DBus.Properties
-  | |     - org.bluez.GattCharacteristic1
-  | |
-  | -> /com/example/service0/char1
-  |   |   - org.freedesktop.DBus.Properties
-  |   |   - org.bluez.GattCharacteristic1
-  |   |
-  |   -> /com/example/service0/char1/desc0
-  |       - org.freedesktop.DBus.Properties
-  |       - org.bluez.GattDescriptor1
-  |
-  -> /com/example/service1
-    |   - org.freedesktop.DBus.Properties
-    |   - org.bluez.GattService1
-    |
-    -> /com/example/service1/char0
-        - org.freedesktop.DBus.Properties
-        - org.bluez.GattCharacteristic1
-
-When a service is registered, BlueZ will automatically obtain information about
-all objects using the service's Object Manager. Once a service has been
-registered, the objects of a service should not be removed. If BlueZ receives an
-InterfacesRemoved signal from a service's Object Manager, it will immediately
-unregister the service. Similarly, if the application disconnects from the bus,
-all of its registered services will be automatically unregistered.
-InterfacesAdded signals will be ignored.
-
-Examples:
-	- Client
-		test/example-gatt-client
-		client/bluetoothctl
-	- Server
-		test/example-gatt-server
-		tools/gatt-service
-
-
-Service		org.bluez
-Interface	org.bluez.GattManager1
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Methods		void RegisterApplication(object application, dict options)
-
-			Registers a local GATT services hierarchy as described
-			above (GATT Server) and/or GATT profiles (GATT Client).
-
-			The application object path together with the D-Bus
-			system bus connection ID define the identification of
-			the application registering a GATT based
-			service or profile.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-
-		void UnregisterApplication(object application)
-
-			This unregisters the services that has been
-			previously registered. The object path parameter
-			must match the same value that has been used
-			on registration.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
new file mode 100644
index 000000000000..cd5a0d0c788f
--- /dev/null
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -0,0 +1,375 @@
+============================
+org.bluez.GattCharacteristic
+============================
+
+------------------------------------------------
+BlueZ D-Bus GattCharacteristic API documentation
+------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+GATT local/server and remote/client characteristic attribute representation
+share the same high-level D-Bus API.
+
+Local/Server refers to GATT based characteristics exported by a plugin or an
+external application.
+
+Remote/Client refers to GATT characteristics exported by the peer.
+
+Interface
+=========
+
+Client
+------
+
+:Service:	org.bluez
+:Interface:	org.bluez.GattCharacteristic1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
+
+Server
+------
+
+:Service:	unique name
+:Interface:	org.bluez.GattCharacteristic1
+:Object path:	freely definable
+
+Methods
+-------
+
+array{byte} ReadValue(dict options)
+```````````````````````````````````
+
+	Issues a request to read the value of the characteristic and returns the
+	value if the operation was successful.
+
+	Possible options:
+
+	:uint16_t offset:
+
+		Read start offset in bytes.
+
+	:uint16_t mtu (server only):
+
+		Exchange MTU in bytes.
+
+	:object device (server only):
+
+		Device object.
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+
+		Possible values: string 0x80 - 0x9f
+
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.NotPermitted:
+	:org.bluez.Error.NotAuthorized:
+	:org.bluez.Error.InvalidOffset:
+	:org.bluez.Error.NotSupported:
+
+void WriteValue(array{byte} value, dict options)
+````````````````````````````````````````````````
+
+	Issues a request to write the value of the characteristic.
+
+	Possible options:
+
+	:uint16 offset:
+
+		Write start offset in bytes.
+
+	:string type:
+
+		Possible values:
+
+		:"command":
+
+			Use Write without response procedure.
+
+		:"request":
+
+			Use Write with response procedure.
+
+		:"reliable":
+
+			Use Reliable Write procedure.
+
+	:uint16 mtu:
+
+		Exchanged MTU (Server only).
+
+	:object device:
+
+		Device path (Server only).
+
+	:string link:
+
+		Link type (Server only).
+
+		Possible values:
+
+		:"BR/EDR":
+		:"LE":
+
+	:boolean prepare-authorize:
+
+		True if prepare authorization request.
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+
+		Possible values: string 0x80 - 0x9f
+
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.NotPermitted:
+	:org.bluez.Error.InvalidValueLength:
+	:org.bluez.Error.NotAuthorized:
+	:org.bluez.Error.NotSupported:
+
+fd, uint16 AcquireWrite(dict options) [optional]
+````````````````````````````````````````````````
+
+	Acquire file descriptor and MTU for writing. Only sockets are supported.
+	Usage of WriteValue will be locked causing it to return NotPermitted
+	error.
+
+	For server the MTU returned shall be equal or smaller than the
+	negotiated MTU.
+
+	For client it only works with characteristic that has **WriteAcquired**
+	property which relies on write-without-response **Flag**.
+
+	To release the lock the client shall close the file descriptor, a HUP
+	is generated in case the device is disconnected.
+
+	Note: the MTU can only be negotiated once and is symmetric therefore
+	this method may be delayed in order to have the exchange MTU completed,
+	because of that the file descriptor is closed during reconnections as
+	the MTU has to be renegotiated.
+
+	Possible options:
+
+	:object device:
+
+		Object Device (Server only).
+
+	:uint16 mtu:
+
+		Exchanged MTU (Server only).
+
+	:string link:
+
+		Link type (Server only).
+
+		Possible values:
+
+		:"BR/EDR":
+		:"LE":
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotSupported:
+
+fd, uint16 AcquireNotify(dict options) [optional]
+`````````````````````````````````````````````````
+
+	Acquire file descriptor and MTU for notify. Only sockets are support.
+
+	Usage of StartNotify will be locked causing it to return
+	**org.bluez.Error.NotPermitted**.
+
+	For server the MTU returned shall be equal or smaller than the
+	negotiated MTU.
+
+	Only works with characteristic that has **NotifyAcquired** property
+	which relies on **"notify"** **Flag** and no other client have called
+	**StartNotify()**.
+
+	Notification are enabled during this procedure so **StartNotify()**
+	shall not be called, any notification will be dispatched via file
+	descriptor therefore the Value property is not affected during the time
+	where notify has been acquired.
+
+	To release the lock the client shall close the file descriptor, a HUP is
+	generated in case the device is disconnected.
+
+	Note: the MTU can only be negotiated once and is symmetric therefore
+	this method may be delayed in order to have the exchange MTU completed,
+	because of that the file descriptor is closed during reconnections as
+	the MTU has to be renegotiated.
+
+	Possible options:
+
+	:object device:
+
+		Object Device (Server only).
+
+	:uint16 mtu:
+
+		Exchanged MTU (Server only).
+
+	:string link:
+
+		Link type (Server only).
+
+		Possible values:
+
+		:"BR/EDR":
+		:"LE":
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.NotPermitted:
+
+void StartNotify()
+``````````````````
+
+	Starts a notification session from this characteristic if it supports
+	value notifications or indications.
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotPermitted:
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.NotConnected:
+	:org.bluez.Error.NotSupported:
+
+void StopNotify()
+`````````````````
+
+	Stops or cancel session previously created by **StartNotify()**.
+
+	Note that notifications from a characteristic are shared between
+	sessions thus calling StopNotify will release a single session.
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+
+void Confirm() [noreply, optional] (Server only)
+````````````````````````````````````````````````
+
+
+	Confirms value was received.
+
+	Possible Errors:
+
+	org.bluez.Error.Failed
+
+Properties
+----------
+
+string UUID [read-only]
+```````````````````````
+
+	128-bit characteristic UUID.
+
+object Service [read-only]
+``````````````````````````
+
+	Object path of the GATT service the characteristic belongs to.
+
+array{byte} Value [read-only, optional]
+```````````````````````````````````````
+
+	The cached value of the characteristic. This property gets updated only
+	after a successful read request and when a notification or indication
+	is received, upon which a PropertiesChanged signal will be emitted.
+
+boolean WriteAcquired [read-only, optional]
+```````````````````````````````````````````
+
+	True, if this characteristic has been acquired by any client using
+	AcquireWrite.
+
+	For client properties is ommited in case 'write-without-response' flag
+	is not set.
+
+	For server the presence of this property indicates that AcquireWrite is
+	supported.
+
+boolean NotifyAcquired [read-only, optional]
+````````````````````````````````````````````
+
+	True, if this characteristic has been acquired by any client using
+	AcquireNotify.
+
+	For client this properties is ommited in case 'notify' flag is not set.
+
+	For server the presence of this property indicates that AcquireNotify
+	is supported.
+
+boolean Notifying [read-only, optional]
+```````````````````````````````````````
+
+	True, if notifications or indications on this characteristic are
+	currently enabled.
+
+array{string} Flags [read-only]
+```````````````````````````````
+
+	Defines how the characteristic value can be used. See Core spec
+	"Table 3.5: Characteristic Properties bit field", and
+	"Table 3.8: Characteristic Extended Properties bit field".
+
+	The "x-notify" and "x-indicate" flags restrict access to notifications
+	and indications by imposing write restrictions on a characteristic's
+	client characteristic configuration descriptor.
+
+	Possible values:
+
+	:"broadcast":
+	:"read":
+	:"write-without-response":
+	:"write":
+	:"notify":
+	:"indicate":
+	:"authenticated-signed-writes":
+	:"extended-properties":
+	:"reliable-write":
+	:"writable-auxiliaries":
+	:"encrypt-read":
+	:"encrypt-write":
+	:"encrypt-notify" (Server only):
+	:"encrypt-indicate" (Server only):
+	:"encrypt-authenticated-read":
+	:"encrypt-authenticated-write":
+	:"encrypt-authenticated-notify" (Server only):
+	:"encrypt-authenticated-indicate" (Server only):
+	:"secure-read" (Server only):
+	:"secure-write" (Server only):
+	:"secure-notify" (Server only):
+	:"secure-indicate" (Server only):
+	:"authorize":
+
+uint16 Handle [read-only] (Client Only)
+```````````````````````````````````````
+
+	Characteristic handle.
+
+uint16 Handle [read-write, optional] (Server Only)
+``````````````````````````````````````````````````
+
+	Characteristic handle. When available in the server it would attempt to
+	use to allocate into the database which may fail, to auto allocate the
+	value 0x0000 shall be used which will cause the allocated handle to be
+	set once registered.
+
+uint16 MTU [read-only]
+``````````````````````
+
+	Characteristic MTU, this is valid both for **ReadValue()** and
+	**WriteValue()** but either method can use long procedures when
+	supported.
diff --git a/doc/org.bluez.GattDescriptor.rst b/doc/org.bluez.GattDescriptor.rst
new file mode 100644
index 000000000000..94cc8b26af29
--- /dev/null
+++ b/doc/org.bluez.GattDescriptor.rst
@@ -0,0 +1,167 @@
+========================
+org.bluez.GattDescriptor
+========================
+
+--------------------------------------------
+BlueZ D-Bus GattDescriptor API documentation
+--------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+GATT local/server and remote/client descriptor attribute representation
+share the same high-level D-Bus API.
+
+Local/Server refers to GATT based descriptors exported by a plugin or an
+external application.
+
+Remote/Client refers to GATT descriptors exported by the peer.
+
+Interface
+=========
+
+Client
+------
+
+:Service:	org.bluez
+:Interface:	org.bluez.GattDescriptor1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ
+
+Server
+------
+
+:Service:	unique name
+:Interface:	org.bluez.GattDescriptor1
+:Object path:	freely definable
+
+Methods
+-------
+
+array{byte} ReadValue(dict flags)
+`````````````````````````````````
+
+	Issues a request to read the value of the descriptor and returns the
+	value if the operation was successful.
+
+	Possible options:
+
+	:uint16_t offset:
+
+		Read start offset in bytes.
+
+	:object device (server only):
+
+		Device object.
+
+	:string link:
+
+		Link type (Server only).
+
+		Possible values:
+
+		:"BR/EDR":
+		:"LE":
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.NotPermitted:
+	:org.bluez.Error.NotAuthorized:
+	:org.bluez.Error.NotSupported:
+
+void WriteValue(array{byte} value, dict flags)
+``````````````````````````````````````````````
+
+	Issues a request to write the value of the descriptor.
+
+	Possible flags:
+
+	:uint16 offset:
+
+		Write start offset in bytes.
+
+	:uint16 mtu:
+
+		Exchanged MTU (Server only).
+
+	:object device:
+
+		Device path (Server only).
+
+	:string link:
+
+		Link type (Server only).
+
+		Possible values:
+
+		:"BR/EDR":
+		:"LE":
+
+	:boolean prepare-authorize:
+
+		True if prepare authorization request.
+
+	Possible Errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.NotPermitted:
+	:org.bluez.Error.InvalidValueLength:
+	:org.bluez.Error.NotAuthorized:
+	:org.bluez.Error.NotSupported:
+
+Properties
+----------
+
+string UUID [read-only]
+```````````````````````
+
+	128-bit descriptor UUID.
+
+object Characteristic [read-only]
+`````````````````````````````````
+
+	Object path of the GATT characteristic the descriptor belongs to.
+
+array{byte} Value [read-only, optional]
+```````````````````````````````````````
+
+	The cached value of the descriptor. This property gets updated only
+	after a successful read request, upon which a PropertiesChanged signal
+	will be emitted.
+
+array{string} Flags [read-only]
+```````````````````````````````
+
+	Defines how the descriptor value can be used.
+
+	Possible values:
+
+	:"read":
+	:"write":
+	:"encrypt-read":
+	:"encrypt-write":
+	:"encrypt-authenticated-read":
+	:"encrypt-authenticated-write":
+	:"secure-read" (Server Only):
+	:"secure-write" (Server Only):
+	:"authorize":
+
+uint16 Handle [read-only] (Client Only)
+```````````````````````````````````````
+
+	Descriptor handle.
+
+uint16 Handle [read-write, optional] (Server Only)
+``````````````````````````````````````````````````
+
+	Descriptor handle. When available in the server it would attempt to
+	use to allocate into the database which may fail, to auto allocate the
+	value 0x0000 shall be used which will cause the allocated handle to be
+	set once registered.
diff --git a/doc/org.bluez.GattManager.rst b/doc/org.bluez.GattManager.rst
new file mode 100644
index 000000000000..f98296b89a01
--- /dev/null
+++ b/doc/org.bluez.GattManager.rst
@@ -0,0 +1,114 @@
+=====================
+org.bluez.GattManager
+=====================
+
+-----------------------------------------
+BlueZ D-Bus GattManager API documentation
+-----------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+GATT Manager allows external applications to register GATT services and
+profiles.
+
+Registering a profile allows applications to subscribe to *remote/client*
+services.
+
+Registering a service allows applications to publish a *local/server* GATT
+service, which then becomes available to remote devices. A GATT service is
+represented by a D-Bus object hierarchy where the root node corresponds to a
+service and the child nodes represent characteristics and descriptors that
+belong to that service. Each node must implement one of
+**org.bluez.GattService(5)**, **org.bluez.GattCharacteristic(5)** or
+**org.bluez.GattDescriptor(5)** interfaces, based on the attribute it
+represents. Each node must also implement the standard D-Bus Properties
+interface to expose their properties. These objects collectively represent a
+GATT service definition.
+
+To make service registration simple, **bluetoothd(8)** requires that all objects
+that belong to a GATT service be grouped under a D-Bus Object Manager that
+solely manages the objects of that service. Hence, the standard
+DBus.ObjectManager interface must be available on the root service path. An
+example application hierarchy containing two separate GATT services may look
+like this:
+
+.. code-block::
+
+    -> /com/example
+      |   - org.freedesktop.DBus.ObjectManager
+      |
+      -> /com/example/service0
+      | |   - org.freedesktop.DBus.Properties
+      | |   - org.bluez.GattService1
+      | |
+      | -> /com/example/service0/char0
+      | |     - org.freedesktop.DBus.Properties
+      | |     - org.bluez.GattCharacteristic1
+      | |
+      | -> /com/example/service0/char1
+      |   |   - org.freedesktop.DBus.Properties
+      |   |   - org.bluez.GattCharacteristic1
+      |   |
+      |   -> /com/example/service0/char1/desc0
+      |       - org.freedesktop.DBus.Properties
+      |       - org.bluez.GattDescriptor1
+      |
+      -> /com/example/service1
+        |   - org.freedesktop.DBus.Properties
+        |   - org.bluez.GattService1
+        |
+       -> /com/example/service1/char0
+            - org.freedesktop.DBus.Properties
+            - org.bluez.GattCharacteristic1
+
+When a service is registered, **bluetoothd(8)** will automatically obtain
+information about all objects using the service's Object Manager. Once a service
+has been registered, the objects of a service should not be removed. If
+**bluetoothd(8)** receives an InterfacesRemoved signal from a service's Object
+Manager, it will immediately unregister the service. Similarly, if the
+application disconnects from the bus, all of its registered services will be
+automatically unregistered. InterfacesAdded signals will be ignored.
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.GattManager1
+:Object path:	[variable prefix]/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterApplication(object application, dict options)
+``````````````````````````````````````````````````````````
+
+	Registers a local GATT services hierarchy as described above
+	(GATT Server) and/or GATT profiles (GATT Client).
+
+	The application object path together with the D-Bus system bus
+	connection ID define the identification of the application registering
+	a GATT based service (**org.bluez.GattService(5)**) and/or profile
+	(**org.bluez.GattProfile(5)**).
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.AlreadyExists:
+
+void UnregisterApplication(object application)
+``````````````````````````````````````````````
+
+	This unregisters the services and/or profiles that has been previously
+	registered using **RegisterApplication()**. The object path parameter
+	must match the same value that has been used on registration.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.DoesNotExist:
diff --git a/doc/org.bluez.GattProfile.rst b/doc/org.bluez.GattProfile.rst
new file mode 100644
index 000000000000..904301a9773b
--- /dev/null
+++ b/doc/org.bluez.GattProfile.rst
@@ -0,0 +1,46 @@
+=====================
+org.bluez.GattProfile
+=====================
+
+-----------------------------------------
+BlueZ D-Bus GattProfile API documentation
+-----------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+Local profile (GATT client) instance. By registering this type of object
+an application effectively indicates support for a specific GATT profile
+and requests automatic connections to be established to devices
+supporting it.
+
+Interface
+=========
+
+:Service:	<application dependent>
+:Interface:	org.bluez.GattProfile1
+:Object path:	<application dependent>
+
+Methods
+-------
+
+void Release()
+``````````````
+
+	This method gets called when the service daemon
+	unregisters the profile. The profile can use it to do cleanup tasks.
+	There is no need to unregister the profile, because when this method
+	gets called it has already been unregistered.
+
+Properties
+----------
+
+array{string} UUIDs [read-only]
+```````````````````````````````
+
+	128-bit GATT service UUIDs to auto connect.
diff --git a/doc/org.bluez.GattService.rst b/doc/org.bluez.GattService.rst
new file mode 100644
index 000000000000..4a1e81fc9e03
--- /dev/null
+++ b/doc/org.bluez.GattService.rst
@@ -0,0 +1,79 @@
+=====================
+org.bluez.GattService
+=====================
+
+-------------------------------------------------
+BlueZ D-Bus GattService API documentation
+-------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+GATT local/server and remote/client services share the same high-level D-Bus
+API.
+
+Local/Server refers to GATT based service exported by a plugin or an external
+application.
+
+Remote/Client refers to GATT services exported by the peer.
+
+Interface
+=========
+
+Client
+------
+
+:Service:	org.bluez
+:Interface:	org.bluez.GattService1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX
+
+Server
+------
+
+:Service:	unique name
+:Interface:	org.bluez.GattService1
+:Object path:	freely definable
+
+Properties
+----------
+
+string UUID [read-only]
+```````````````````````
+
+	128-bit service UUID.
+
+boolean Primary [read-only]
+```````````````````````````
+
+	Indicates whether or not this GATT service is a primary service. If
+	false, the service is secondary.
+
+object Device [read-only, optional]
+```````````````````````````````````
+
+	Object path of the Bluetooth device the service belongs to. Only
+	present on services from remote devices.
+
+array{object} Includes [read-only, optional]
+````````````````````````````````````````````
+
+	Array of object paths representing the included services of this
+	service.
+
+uint16 Handle [read-only] (client only)
+```````````````````````````````````````
+
+	Service handle.
+
+uint16 Handle [read-write, optional] (Server Only)
+``````````````````````````````````````````````````
+
+	Service handle. When available in the server it would attempt to use to
+	allocate into the database which may fail, to auto allocate the value
+	0x0000 shall be used which will cause the allocated handle to be set
+	once registered.
-- 
2.41.0

