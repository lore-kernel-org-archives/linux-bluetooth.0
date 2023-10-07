Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720D0E784AF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 01:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjJGBCE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjJGBCC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 21:02:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA643D8
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 18:02:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27734d76e1bso2014878a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Oct 2023 18:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696640519; x=1697245319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDgX8yDsywNAW28NWgcAVa6rB+XdkOH4ZNhvrScoT/Y=;
        b=Sa19HqzujWVdIYLTIDCIYvzN5kD0xcT8K/dX/hygW9QlhYMTUZMM7jHb1B/pp+YQUH
         U/hRUZmtunuurQySoUwjKHTOVGuddAzM3LCmRL8loc9VNakImDXBtM11VfpRTm+rMwcq
         Qj0qHKb+EV0URmTUizOENC7YYn4TKD1Z8jXxJQnGiipTip5SKDbbv16rEXBwKxH9Hf4B
         rCiUyFpp1ZnOfQ9VFlW8Q/k6Kc9ca7Ro7IiFHB6sth7DmehAMvPTKSjZw9VSGn13sHsL
         cA3T8JdAmKAhgAa9nWBSFXfORELaszUpcZ7L0r0+ZfnlQIiB6i07VM/rJAxc8eqYs/uw
         7pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696640519; x=1697245319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDgX8yDsywNAW28NWgcAVa6rB+XdkOH4ZNhvrScoT/Y=;
        b=KSo2k9ydLkw6fVJV2/5Tt0jShRKxfuQRTGyg2xYJ/3bMAjoY/RUSLuFlvfy2MoPqWU
         c8oOaX8qvPLDDL1nKH706qSzHD7wEZJ25LRSoyWjLawBk93Y3yXgpylAvntu+SJNd/MA
         2xaw05ffWAaKabDSBBg/xbLokdq6Cg9HNvjxQtjEtsYa5l5qc/e9uVeFqm2Sx9BsekCz
         UjBG/obKY+DxoF+XWOMgI1W2cdJzJJfd0Fss+NGEfvW0sfc9plj+291JMAl531Fpa8q9
         mxFt9ujtojgV6nlK06CuPYr3zvEJhQKSPlc3RxrNa/FSJtQjfVA7LnQT73c+WqawrG0K
         5GCw==
X-Gm-Message-State: AOJu0Ywwk5r9JcfIQSNMC2J63sEBx0hXMVfNyq/z32X4x79d/PU8amU0
        HtozfYKclGmWHTWszeedeu4S+shXEMS2M2v6
X-Google-Smtp-Source: AGHT+IF5c/K5ZhVi8+TCivZ0jHwso/uO5w3mN7Ffjfce9DQgZ/t3pdzVomAK+rNTFd5yNLvmVTGpFA==
X-Received: by 2002:a17:90a:ab87:b0:27b:258f:2843 with SMTP id n7-20020a17090aab8700b0027b258f2843mr5308131pjq.7.1696640519204;
        Fri, 06 Oct 2023 18:01:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id co11-20020a17090afe8b00b00279060a0fccsm4098360pjb.9.2023.10.06.18.01.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 18:01:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] doc/network-api: Rename to org.bluez.Network{Server}.rst
Date:   Fri,  6 Oct 2023 18:01:47 -0700
Message-ID: <20231007010150.4103452-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231007010150.4103452-1-luiz.dentz@gmail.com>
References: <20231007010150.4103452-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames network-api.txt to org.bluez.Network{Server}.rst and
generate manpages org.bluez.Network{Server}.5.
---
 Makefile.am                     | 11 +++--
 doc/network-api.txt             | 76 ------------------------------
 doc/org.bluez.Network.rst       | 83 +++++++++++++++++++++++++++++++++
 doc/org.bluez.NetworkServer.rst | 68 +++++++++++++++++++++++++++
 4 files changed, 158 insertions(+), 80 deletions(-)
 delete mode 100644 doc/network-api.txt
 create mode 100644 doc/org.bluez.Network.rst
 create mode 100644 doc/org.bluez.NetworkServer.rst

diff --git a/Makefile.am b/Makefile.am
index ab723a59f1ac..4507b72bbae7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -360,7 +360,8 @@ man_MANS += src/bluetoothd.8
 man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
-		doc/org.bluez.Profile.5
+		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
+		doc/org.bluez.Network.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -370,7 +371,8 @@ manual_pages += src/bluetoothd.8
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AagentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
-		doc/org.bluez.Profile.5
+		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
+		doc/org.bluez.Network.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -411,13 +413,14 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/mgmt-api.txt \
-		doc/network-api.txt doc/health-api.txt \
+		doc/health-api.txt \
 		doc/sap-api.txt doc/input-api.txt
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 	      doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
 	      doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
-	      doc/org.bluez.Profile.rst
+	      doc/org.bluez.Profile.rst doc/org.bluez.NetworkServer.rst \
+	      doc/org.bluez.Network.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/network-api.txt b/doc/network-api.txt
deleted file mode 100644
index 109da28bf10d..000000000000
--- a/doc/network-api.txt
+++ /dev/null
@@ -1,76 +0,0 @@
-BlueZ D-Bus Network API description
-***********************************
-
-
-Network hierarchy
-=================
-
-Service		org.bluez
-Interface	org.bluez.Network1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		string Connect(string uuid)
-
-			Connect to the network device and return the network
-			interface name. Examples of the interface name are
-			bnep0, bnep1 etc.
-
-			uuid can be either one of "gn", "panu" or "nap" (case
-			insensitive) or a traditional string representation of
-			UUID or a hexadecimal number.
-
-			The connection will be closed and network device
-			released either upon calling Disconnect() or when
-			the client disappears from the message bus.
-
-			Possible errors: org.bluez.Error.AlreadyConnected
-					 org.bluez.Error.ConnectionAttemptFailed
-
-		void Disconnect()
-
-			Disconnect from the network device.
-
-			To abort a connection attempt in case of errors or
-			timeouts in the client it is fine to call this method.
-
-			Possible errors: org.bluez.Error.Failed
-
-Properties	boolean Connected [readonly]
-
-			Indicates if the device is connected.
-
-		string Interface [readonly]
-
-			Indicates the network interface name when available.
-
-		string UUID [readonly]
-
-			Indicates the connection role when available.
-
-
-Network server hierarchy
-========================
-
-Service		org.bluez
-Interface	org.bluez.NetworkServer1
-Object path	/org/bluez/{hci0,hci1,...}
-
-Methods		void Register(string uuid, string bridge)
-
-			Register server for the provided UUID. Every new
-			connection to this server will be added the bridge
-			interface.
-
-			Valid UUIDs are "gn", "panu" or "nap".
-
-			Initially no network server SDP is provided. Only
-			after this method a SDP record will be available
-			and the BNEP server will be ready for incoming
-			connections.
-
-		void Unregister(string uuid)
-
-			Unregister the server for provided UUID.
-
-			All servers will be automatically unregistered when
-			the calling application terminates.
diff --git a/doc/org.bluez.Network.rst b/doc/org.bluez.Network.rst
new file mode 100644
index 000000000000..d81a69d3c8af
--- /dev/null
+++ b/doc/org.bluez.Network.rst
@@ -0,0 +1,83 @@
+=================
+org.bluez.Network
+=================
+
+-------------------------------------
+BlueZ D-Bus Network API documentation
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
+:Interface:	org.bluez.Network1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods
+-------
+
+string Connect(string uuid)
+```````````````````````````
+
+	Connects to the network device and return the network interface name.
+
+	Possible uuid values:
+
+	:"panu", "00001115-0000-1000-8000-00805f9b34fb":
+
+		Personal Network User role.
+
+	:"nap", "00001116-0000-1000-8000-00805f9b34fb":
+
+		Network Access Point role.
+
+	:"gn", "00001117-0000-1000-8000-00805f9b34fb":
+
+		Group Network role.
+
+	The connection will be closed and network device released either upon
+	calling **Disconnect()** or when the client disappears from the
+	message bus.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.NotSupported:
+	:org.bluez.Error.InProgress:
+	:org.bluez.Error.Failed:
+
+void Disconnect()
+`````````````````
+
+	Disconnects from the network device.
+
+	To abort a connection attempt in case of errors or timeouts in the
+	client it is fine to call this method.
+
+	Possible errors:
+
+	:org.bluez.Error.Failed:
+	:org.bluez.Error.NotConnected:
+
+Properties
+----------
+
+boolean Connected [readonly]
+````````````````````````````
+
+	Indicates if the device is connected.
+
+string Interface [readonly, optional]
+`````````````````````````````````````
+
+	Indicates the network interface name when available.
+
+string UUID [readonly, optional]
+````````````````````````````````
+
+	Indicates the connection role when available.
diff --git a/doc/org.bluez.NetworkServer.rst b/doc/org.bluez.NetworkServer.rst
new file mode 100644
index 000000000000..d15d223c5eca
--- /dev/null
+++ b/doc/org.bluez.NetworkServer.rst
@@ -0,0 +1,68 @@
+=======================
+org.bluez.NetworkServer
+=======================
+
+-------------------------------------------
+BlueZ D-Bus NetworkServer API documentation
+-------------------------------------------
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
+:Interface:	org.bluez.NetworkServer1
+:Object path:	/org/bluez/{hci0,hci1,...}
+
+
+Methods
+-------
+
+void Register(string uuid, string bridge)
+`````````````````````````````````````````
+
+	Registers server for the provided UUID.
+
+	Every new connection to this server will be added the bridge interface.
+
+	Possible uuid values:
+
+	:"panu", "00001115-0000-1000-8000-00805f9b34fb":
+
+		Personal Network User role.
+
+	:"nap", "00001116-0000-1000-8000-00805f9b34fb":
+
+		Network Access Point role.
+
+	:"gn", "00001117-0000-1000-8000-00805f9b34fb":
+
+		Group Network role.
+
+	Initially no network server SDP is provided. Only after this method a
+	SDP record will be available and the BNEP server will be ready for
+	incoming connections.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.AlreadyExists:
+	:org.bluez.Error.Failed:
+
+void Unregister(string uuid)
+````````````````````````````
+
+	Unregisters the server for provided UUID which was previously
+	registered with **Register()** method.
+
+	All servers will be automatically unregistered when the calling
+	application terminates.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.Failed:
-- 
2.41.0

