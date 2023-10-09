Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DCE95A9C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379093AbjJIX3r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379050AbjJIX3q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52089D
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c871a095ceso36652585ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894183; x=1697498983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVrLTp9UxQLsQ/wLqHYuTdmwNj7vaeKNZO1RAmb2cic=;
        b=HSevLFft6Yij3Gqod4o7sY5MjZiITLiLdgmk2zA/zdvhsoBoIbf0xr6QRU2QwWQlQk
         LZM3efPM3c05Zr8bAPDjNfRuA209XXz55yUso+OompFQzQ8Q05WxhFopBFmrhUJxcYlN
         bKOlBNL7Q9ZiADCMo7h8w++l5LYfH4kcQXEMAuvgXlKzjaUd5sN4sK8z9vq5tTNxyFjt
         DzmOJX1liagGwdBlRrY+722R+UL4TqENplsO0VO3Amqhp0ULNaTtuI/zlV6weXWHYj9X
         PeEC0mKaoQ9GKNZnLamBsjzVU97+/ZUEKiK0Kmer+s6cMeiAUkWZgF3VyOPIDVqOv2CY
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894183; x=1697498983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVrLTp9UxQLsQ/wLqHYuTdmwNj7vaeKNZO1RAmb2cic=;
        b=wbO42rCnWu3LMturqYsXJ83ZQjmGxBZN1yD33EtkLqBD1h0RPvToap3zVgvkoikk+V
         DnHtWps2NlJU7D5V26xVDuNcD26+IX044Rh4w2Zj5vqVwRVdkjOV5cmHkGTlZj+eObpl
         t+nAr3vjRdHz3OI74Lm8Fl71SsJYWugoDq+OUV6W+NPuMmEp1b/9UrTU/SEszno2i1g9
         YAMJL8WB160vKEymhrXpvAA4Ob5Hyjo1LZnia7bUGUd7rwNjHiwqG/WfHmyAeBOgSyxI
         4vfj/V3fnujqiWl80ks2wSytScXc7Yq+vsYAUVeqAEMc8m3QPdiUtws0QNT0msbU40yk
         h/sQ==
X-Gm-Message-State: AOJu0YxW37w5bYdFgC2KMFg7wFNLYY2H+Nh6p3lvFNg61uz2CuqOm3G1
        3e4sQE8AY+jqOPKmAEIXNydamU8fzB9m+fj4
X-Google-Smtp-Source: AGHT+IEI/QCFA47MXBiltsrkAzBNPhqP33r1HRSp84Dw0yjPVgvU5wy9WmPj0lSbofow4TflRGavUg==
X-Received: by 2002:a17:902:c947:b0:1c7:4a8a:32d1 with SMTP id i7-20020a170902c94700b001c74a8a32d1mr17033654pla.28.1696894182843;
        Mon, 09 Oct 2023 16:29:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/11] doc/profile-api: Rename to org.bluez.Profile{Manager}.rst
Date:   Mon,  9 Oct 2023 16:29:26 -0700
Message-ID: <20231009232933.500652-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
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
index b25bc521cab3..64004004fb2a 100644
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
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
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

