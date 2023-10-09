Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EAE9413E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379100AbjJIX3s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379086AbjJIX3r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E9A4
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5c91bece9so36662345ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894184; x=1697498984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRxH1waw56FtswklNdEvqOLXLAlzGTnUWqOZjyGi8FQ=;
        b=FF4UAv/iIEGvjRglvLIxj41v2FGTT6kjAHNZGzu2dpk32YKjWYoep5sxfw9uxzgszB
         HCtnR/CYBCcbSdgouZ9qzSqT4d7KP86SlOlR2KrEice4/hh6oDwSoq9gaCp39gJC8z+U
         tGmkchge6EN0dw6VmCh73fY+UwdUGuZWjnPJdk3PSiKfVwBmZkdIaUjqP8gNS1XfSuEB
         WSxkv9rlk+OP5Fb3r47ZXJHW1wP07coOW4UkH5VgjNhkfnXn6sNeV0bnvbAbl86m1ISp
         usajzbdDeYxaWvw1svR216bkFfoI54vIG0SVnu7BbfRa6slzP1gyXYDQQnamCDxqWp3j
         5ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894184; x=1697498984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRxH1waw56FtswklNdEvqOLXLAlzGTnUWqOZjyGi8FQ=;
        b=A5FCshoeKG5zS4XbXV47VGf8+0E7T7zB11dPZ6Mnrjc420NpL2OjdvJbS/EPVChBpm
         gzcBVTEc4hl+eAPvZ85cuKFGh5Z8q0CljVpZfo10+g7CnFeUIjoYFPU+4EqBUZ4iX5fm
         rQjd/hdzLMTXVjuDs1wbaMMzGosbNoK5NVbHOaEq/LrbH/X8choVV6nxz2lh3s8SRmwq
         i+05rDfltY/RSkaJE+zBljInghWnleOTZ0LdIubAWFziDVC1SR90l8UYrkrHOIvXUBG4
         mzyztEAxlnk9QQ5rrCwwZRo+a89hTGBlG7zVUY4qETbCh5hhUQCO4WiKloWKtrcCRXud
         glkQ==
X-Gm-Message-State: AOJu0YzhSEsDd8uS+Yyt1rWiznzK2cGyvdROznJsf57JNbT4od6st2OL
        HS6m/VF9IsepWaW5wf9sZVqBO13mASjEiMO6
X-Google-Smtp-Source: AGHT+IHh6AdiCDfaUAIxjmwB0NSf2WT9WurmsMJL5sszKqlDXgx+aUDttP9oZ1nWeNw/npS/crZybA==
X-Received: by 2002:a17:902:cecb:b0:1c3:411c:9b7d with SMTP id d11-20020a170902cecb00b001c3411c9b7dmr16904986plg.57.1696894184175;
        Mon, 09 Oct 2023 16:29:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/11] doc/network-api: Rename to org.bluez.Network{Server}.rst
Date:   Mon,  9 Oct 2023 16:29:27 -0700
Message-ID: <20231009232933.500652-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
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
index 64004004fb2a..797dc6b78fa5 100644
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
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
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

