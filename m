Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1180E9413E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 01:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjJGBCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjJGBCB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 21:02:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240BDC5
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 18:01:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ae2896974bso1734737b6e.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Oct 2023 18:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696640517; x=1697245317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud1q4yYXQKZT9lTKirqbZx/9B+bk1hmJri15/L6UuQ0=;
        b=Zp3nUx6n/8q3QytnPEDcF/wPMtVFA1r35Rn6xDyKbFA2L8lnqLMSI5vvlpfyc/3+Pc
         XXwLQ6A9+oYA39wuPPDi4NGbki50vlUM7oVIKZR/mi8O/xaCFlRnzcNTn6Uku1B04mbx
         zjbVTpJ5SBCsepVw0jhb65txz9WAeGiBpr73QYkhnTQll+Fe9dq+9r1IOUn5tGaOQXTE
         wH5frvd+LNpw4ov2Tv1md7kWJw623iRHD41V8inKzNvywnUcLeEFTI/jkFLAiJdybp9g
         eSTonFUHzNISDREMnQnRzuY2YNxEyevAYWOWHfPVRINeMoH0N1tRmiCz6pUbIDIcvVRf
         PiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696640517; x=1697245317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud1q4yYXQKZT9lTKirqbZx/9B+bk1hmJri15/L6UuQ0=;
        b=v4Rlmf642NAgsfZlbLdrczM5e6RR3h11fRQxfaQeFOH4YvLhQvF0r3c4D30u5DNXPE
         HmlUHNTUDI/AK0l60JqVkGf9/Bych+R/jwVMt3CU8NI4yC7ZgxcbtonbBg7euZ24x9DN
         z8a0G/rRrQIy+IS9gFG6ev3RuMS1vi51zeJHZ5k8hHolxV05Sv08HpD24uF6HoZ/Fp9k
         K0T/hxdU/BIQmNWynS+AF7nL/83v6xP2if9enINxhQ3nlrqyBGxqWkaH6FB8WI6nqriA
         iUMbtaF+gWVXF2zzZD3Nm6nXY9tABiK9oxg5DXgkxgpRsRB55KTYTp0v9r56CiaR0oga
         U+qQ==
X-Gm-Message-State: AOJu0YzK3swZh4cLhGjXSeV/ljtNHnG2UfJIUOADcvTrVzBRUL6GDciy
        E2q6FGHpGDceWAGH91IyuriaUFK1V0n7mkm2
X-Google-Smtp-Source: AGHT+IFpraprSpxJbLTcmWsVmeMwRmtJjTvryrTf8S+7s+TphHY1CbRkpW8jMUDUZO61i9W5GK4bjw==
X-Received: by 2002:a05:6358:7250:b0:134:d282:92e9 with SMTP id i16-20020a056358725000b00134d28292e9mr10712013rwa.29.1696640517390;
        Fri, 06 Oct 2023 18:01:57 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id co11-20020a17090afe8b00b00279060a0fccsm4098360pjb.9.2023.10.06.18.01.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 18:01:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] doc/profile-api: Rename to org.bluez.Profile{Manager}.rst
Date:   Fri,  6 Oct 2023 18:01:46 -0700
Message-ID: <20231007010150.4103452-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231007010150.4103452-1-luiz.dentz@gmail.com>
References: <20231007010150.4103452-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames profile-api.txt to org.bluez.Profile{Manager}.rst and
generate manpages org.bluez.Profile{Manager}.5.
---
 Makefile.am                      |  10 +-
 doc/org.bluez.Profile.rst        |  51 ++++++++++
 doc/org.bluez.ProfileManager.rst | 141 +++++++++++++++++++++++++
 doc/profile-api.txt              | 170 -------------------------------
 4 files changed, 198 insertions(+), 174 deletions(-)
 create mode 100644 doc/org.bluez.Profile.rst
 create mode 100644 doc/org.bluez.ProfileManager.rst
 delete mode 100644 doc/profile-api.txt

diff --git a/Makefile.am b/Makefile.am
index f355ac0c379c..ab723a59f1ac 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -359,7 +359,8 @@ if MANPAGES
 man_MANS += src/bluetoothd.8
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
-		doc/org.bluez.Agent.5
+		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
+		doc/org.bluez.Profile.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -368,7 +369,8 @@ endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AagentManager.5 \
-		doc/org.bluez.Agent.5
+		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
+		doc/org.bluez.Profile.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -409,13 +411,13 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/mgmt-api.txt \
-		doc/profile-api.txt \
 		doc/network-api.txt doc/health-api.txt \
 		doc/sap-api.txt doc/input-api.txt
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 	      doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
-	      doc/org.bluez.Agent.rst
+	      doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
+	      doc/org.bluez.Profile.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/org.bluez.Profile.rst b/doc/org.bluez.Profile.rst
new file mode 100644
index 000000000000..d8ae669c7323
--- /dev/null
+++ b/doc/org.bluez.Profile.rst
@@ -0,0 +1,51 @@
+=================
+org.bluez.Profile
+=================
+
+-------------------------------------
+BlueZ D-Bus Profile API documentation
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
+:Service:	unique name
+:Interface:	org.bluez.Profile1
+:Object path:	freely definable
+
+Methods
+-------
+
+void Release() [noreply]
+````````````````````````
+
+	This method gets called when the service daemon unregisters the profile.
+	A profile can use it to do cleanup tasks. There is no need to unregister
+	the profile, because when this method gets called it has already been
+	unregistered.
+
+void NewConnection(object device, fd, dict fd_properties)
+`````````````````````````````````````````````````````````
+
+	This method gets called when a new service level connection has been
+	made and authorized.
+
+	Possible fd_properties values:
+
+	:uint16 Version [optional]:
+
+		Profile version.
+
+	:uint16 Features [optional]:
+
+		Profile features.
+
+	Possible errors:
+
+	:org.bluez.Error.Rejected:
+	:org.bluez.Error.Canceled:
diff --git a/doc/org.bluez.ProfileManager.rst b/doc/org.bluez.ProfileManager.rst
new file mode 100644
index 000000000000..ccd7a2673d77
--- /dev/null
+++ b/doc/org.bluez.ProfileManager.rst
@@ -0,0 +1,141 @@
+========================
+org.bluez.ProfileManager
+========================
+
+--------------------------------------------
+BlueZ D-Bus ProfileManager API documentation
+--------------------------------------------
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
+:Interface:	org.bluez.ProfileManager1
+:Object path:	/org/bluez
+
+Methods
+-------
+
+void RegisterProfile(object profile, string uuid, dict options)
+```````````````````````````````````````````````````````````````
+
+	Registers profile agent.
+
+	The object path defines the path of the profile that will be called
+	when there is a connection and must implement **org.bluez.Profile(5)**
+	interface.
+
+	If an application disconnects from the bus all its registered profiles
+	will be removed.
+
+	Possible uuid values:
+
+	:"0000111f-0000-1000-8000-00805f9b34fb":
+
+		HFP AG, default profile Version is 1.7, profile Features is
+		0b001001 and RFCOMM channel is 13. Authentication is required.
+
+	:"0000111e-0000-1000-8000-00805f9b34fb":
+
+		HFP HS, default profile Version is 1.7, profile Features is
+		0b000000 and RFCOMM channel is 7. Authentication is required.
+
+	:"00001112-0000-1000-8000-00805f9b34fb":
+
+		HSP AG, default profile Version is 1.2, RFCOMM channel is 12 and
+		Authentication is required. Does not support any Features,
+		option is ignored.
+
+	:"00001108-0000-1000-8000-00805f9b34fb":
+
+		HSP HS, default profile Version is 1.2, profile Features is 0b0
+		and RFCOMM channel is 6. Authentication is required.
+		Features is one bit value, specify capability of Remote Audio
+		Volume Control (by default turned off).
+
+	:"<vendor UUID>":
+
+		Vendor defined UUID, no defaults, must set options.
+
+	Possible options values:
+
+	:string Name:
+
+		Human readable name for the profile
+
+	:string Service:
+
+		The primary service class UUID (if different from the actual
+		profile UUID).
+
+	:string Role:
+
+		For asymmetric profiles that do not have UUIDs available to
+		uniquely identify each side this parameter allows specifying the
+		precise local role.
+
+		Possible values:
+
+		:"client":
+		:"server":
+
+	:uint16 Channel:
+
+		RFCOMM channel number that is used for client and server UUIDs.
+
+		If applicable it will be used in the SDP record as well.
+
+	:uint16 PSM:
+
+		PSM number that is used for client and server UUIDs.
+
+		If applicable it will be used in the SDP record as well.
+
+	:boolean RequireAuthentication:
+
+		Pairing is required before connections will be established.
+		No devices will be connected if not paired.
+
+	:boolean RequireAuthorization:
+
+		Request authorization before any connection will be established.
+
+	:boolean AutoConnect:
+
+		In case of a client UUID this will force connection of the
+		RFCOMM or L2CAP channels when a remote device is connected.
+
+	:string ServiceRecord:
+
+		Provide a manual SDP record.
+
+	:uint16 Version:
+
+		Profile version (for SDP record)
+
+	:uint16 Features:
+
+		Profile features (for SDP record)
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.AlreadyExists:
+
+void UnregisterProfile(object profile)
+``````````````````````````````````````
+
+	Unregisters profile object that has been previously registered using
+	**RegisterProfile**.
+
+	The object path parameter must match the same value that has been used
+	on registration.
+
+	Possible errors:
+
+	:org.bluez.Error.DoesNotExist:
diff --git a/doc/profile-api.txt b/doc/profile-api.txt
deleted file mode 100644
index 183c6c11a7ba..000000000000
--- a/doc/profile-api.txt
+++ /dev/null
@@ -1,170 +0,0 @@
-BlueZ D-Bus Profile API description
-***********************************
-
-
-Profile Manager hierarchy
-=========================
-
-Service		org.bluez
-Interface	org.bluez.ProfileManager1
-Object path	/org/bluez
-
-		void RegisterProfile(object profile, string uuid, dict options)
-
-			This registers a profile implementation.
-
-			If an application disconnects from the bus all
-			its registered profiles will be removed.
-
-			Some predefined services:
-
-			HFP AG UUID: 0000111f-0000-1000-8000-00805f9b34fb
-
-				Default profile Version is 1.7, profile Features
-				is 0b001001 and RFCOMM channel is 13.
-				Authentication is required.
-
-			HFP HS UUID: 0000111e-0000-1000-8000-00805f9b34fb
-
-				Default profile Version is 1.7, profile Features
-				is 0b000000 and RFCOMM channel is 7.
-				Authentication is required.
-
-			HSP AG UUID: 00001112-0000-1000-8000-00805f9b34fb
-
-				Default profile Version is 1.2, RFCOMM channel
-				is 12 and Authentication is required. Does not
-				support any Features, option is ignored.
-
-			HSP HS UUID: 00001108-0000-1000-8000-00805f9b34fb
-
-				Default profile Version is 1.2, profile Features
-				is 0b0 and RFCOMM channel is 6. Authentication
-				is required. Features is one bit value, specify
-				capability of Remote Audio Volume Control
-				(by default turned off).
-
-			Available options:
-
-				string Name
-
-					Human readable name for the profile
-
-				string Service
-
-					The primary service class UUID
-					(if different from the actual
-					 profile UUID)
-
-				string Role
-
-					For asymmetric profiles that do not
-					have UUIDs available to uniquely
-					identify each side this
-					parameter allows specifying the
-					precise local role.
-
-					Possible values: "client", "server"
-
-				uint16 Channel
-
-					RFCOMM channel number that is used
-					for client and server UUIDs.
-
-					If applicable it will be used in the
-					SDP record as well.
-
-				uint16 PSM
-
-					PSM number that is used for client
-					and server UUIDs.
-
-					If applicable it will be used in the
-					SDP record as well.
-
-				boolean RequireAuthentication
-
-					Pairing is required before connections
-					will be established. No devices will
-					be connected if not paired.
-
-				boolean RequireAuthorization
-
-					Request authorization before any
-					connection will be established.
-
-				boolean AutoConnect
-
-					In case of a client UUID this will
-					force connection of the RFCOMM or
-					L2CAP channels when a remote device
-					is connected.
-
-				string ServiceRecord
-
-					Provide a manual SDP record.
-
-				uint16 Version
-
-					Profile version (for SDP record)
-
-				uint16 Features
-
-					Profile features (for SDP record)
-
-			Possible errors: org.bluez.Error.InvalidArguments
-			                 org.bluez.Error.AlreadyExists
-
-		void UnregisterProfile(object profile)
-
-			This unregisters the profile that has been previously
-			registered. The object path parameter must match the
-			same value that has been used on registration.
-
-			Possible errors: org.bluez.Error.DoesNotExist
-
-
-Profile hierarchy
-=================
-
-Service		unique name
-Interface	org.bluez.Profile1
-Object path	freely definable
-
-Methods		void Release() [noreply]
-
-			This method gets called when the service daemon
-			unregisters the profile. A profile can use it to do
-			cleanup tasks. There is no need to unregister the
-			profile, because when this method gets called it has
-			already been unregistered.
-
-		void NewConnection(object device, fd, dict fd_properties)
-
-			This method gets called when a new service level
-			connection has been made and authorized.
-
-			Common fd_properties:
-
-			uint16 Version		Profile version (optional)
-			uint16 Features		Profile features (optional)
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-
-		void RequestDisconnection(object device)
-
-			This method gets called when a profile gets
-			disconnected.
-
-			The file descriptor is no longer owned by the service
-			daemon and the profile implementation needs to take
-			care of cleaning up all connections.
-
-			If multiple file descriptors are indicated via
-			NewConnection, it is expected that all of them
-			are disconnected before returning from this
-			method call.
-
-			Possible errors: org.bluez.Error.Rejected
-			                 org.bluez.Error.Canceled
-- 
2.41.0

