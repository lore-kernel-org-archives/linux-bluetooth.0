Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC2E9371F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbjJIX3u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379101AbjJIX3t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2366A4
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c63164a2b6so44790065ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894186; x=1697498986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38cuLNQBXrWB5OzgDJk9XBNGuRqGtwf007h1s4UEi60=;
        b=c8hDCF+VU48F+zAibNpqzp6Zxs+Nz9cNn4uEJcWyPCPqb7WSljjHIMAyanHmjuz0gj
         Mk4hKo7lMB+SqCBVr13rMr2gbqhPUV5EYxHJg7U4iCEy5RVmLj74WjDPKCVMv9Wp/hu0
         U/9VbeayouGnmRYWOAxqmlXGdh8JZf0c2P6tX4PCjpMKKcgNmnLTtsDrkohmJ82wmncK
         JopRdqDhcijbIZdfkcfmLeH0EZBmV6+d1PF80eN40ZPOkBHVbTDO5vLOnEPB8xGJOgCT
         POyTS1tpygSP2iOSFE7sCBDUj0C/WQBps56EnyNc5/YtWJ6kjVvnNN8owMrMd0COf4Rx
         CTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894186; x=1697498986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38cuLNQBXrWB5OzgDJk9XBNGuRqGtwf007h1s4UEi60=;
        b=qYnQq9iffylnaHzSTOE0PUQeX1zEgE1bOs1LyWXnNHsYnf7g/XCOHsekVVVgmfxtbW
         SMtr2ka1NMQghLhW3Tko9doxcwlksJvFUi+b3uenCaVpr1H98eCNQJxztuQwMU272htW
         Uw2uSCNKBjNBtqmLAgMC1d+1s7QaKkAapO8uk7K+0r+IuA5rE+OrDK784RA++kQDjI2x
         0YlZaBOZL2J12QB120WEWtlsQ/kZJuTdSpXsZuTA024OXvz+tcF2wngTrsBmF8O12snc
         dPindPHgXslergMmsao2DRKcoaFe2lUjoS7/uhLg8I9lXFSZPjJYOE6HxCNmiYUDA4pa
         S4mQ==
X-Gm-Message-State: AOJu0YyCyfwDQK5ZfWOPT1S8vuOJGXw8gLMTEALnIW43Kn+rAsrWA5ns
        5e+/r95S1w44jXoB9nUUhMz4DgKi0D+ND/nt
X-Google-Smtp-Source: AGHT+IFHVJjUJrbPBnaD2z5tiOYCZeoKlS/Iypwi7G588yNdIvTtaOd1+YjnASdxCvfgY1Viu3JTjA==
X-Received: by 2002:a17:902:e5c1:b0:1c6:23fd:fb18 with SMTP id u1-20020a170902e5c100b001c623fdfb18mr18776276plf.0.1696894186294;
        Mon, 09 Oct 2023 16:29:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/11] doc/input-api: Rename to org.bluez.Input.rst
Date:   Mon,  9 Oct 2023 16:29:28 -0700
Message-ID: <20231009232933.500652-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames input-api.txt to org.bluez.Input.rst and generate manpages
org.bluez.Input.5.
---
 Makefile.am             |  8 +++----
 doc/input-api.txt       | 32 --------------------------
 doc/org.bluez.Input.rst | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 36 deletions(-)
 delete mode 100644 doc/input-api.txt
 create mode 100644 doc/org.bluez.Input.rst

diff --git a/Makefile.am b/Makefile.am
index 797dc6b78fa5..f717d2c2336b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -361,7 +361,7 @@ man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
-		doc/org.bluez.Network.5
+		doc/org.bluez.Network.5 doc/org.bluez.Input.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -372,7 +372,7 @@ manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
-		doc/org.bluez.Network.5
+		doc/org.bluez.Network.5 doc/org.bluez.Input.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -414,13 +414,13 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 
 EXTRA_DIST += doc/mgmt-api.txt \
 		doc/health-api.txt \
-		doc/sap-api.txt doc/input-api.txt
+		doc/sap-api.txt
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 	      doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
 	      doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
 	      doc/org.bluez.Profile.rst doc/org.bluez.NetworkServer.rst \
-	      doc/org.bluez.Network.rst
+	      doc/org.bluez.Network.rst doc/org.bluez.Input.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/input-api.txt b/doc/input-api.txt
deleted file mode 100644
index 67da08b102c9..000000000000
--- a/doc/input-api.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-BlueZ D-Bus Input API description
-*********************************
-
-Input hierarchy
-===============
-
-Service		org.bluez
-Interface	org.bluez.Input1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Properties	string ReconnectMode [readonly]
-
-			Determines the Connectability mode of the HID device as
-			defined by the HID Profile specification, Section 5.4.2.
-
-			This mode is based in the two properties
-			HIDReconnectInitiate (see Section 5.3.4.6) and
-			HIDNormallyConnectable (see Section 5.3.4.14) which
-			define the following four possible values:
-
-			"none"		Device and host are not required to
-					automatically restore the connection.
-
-			"host"		Bluetooth HID host restores connection.
-
-			"device"	Bluetooth HID device restores
-					connection.
-
-			"any"		Bluetooth HID device shall attempt to
-					restore the lost connection, but
-					Bluetooth HID Host may also restore the
-					connection.
diff --git a/doc/org.bluez.Input.rst b/doc/org.bluez.Input.rst
new file mode 100644
index 000000000000..c3c223c913d8
--- /dev/null
+++ b/doc/org.bluez.Input.rst
@@ -0,0 +1,51 @@
+===============
+org.bluez.Input
+===============
+
+-----------------------------------
+BlueZ D-Bus Input API documentation
+-----------------------------------
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
+:Interface:	org.bluez.Input1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties
+----------
+
+string ReconnectMode [readonly]
+```````````````````````````````
+
+	Indicates the Connectability mode of the HID device as defined by the
+	HID Profile specification, Section 5.4.2.
+
+	This mode is based in the two properties HIDReconnectInitiate (see
+	Section 5.3.4.6) and HIDNormallyConnectable (see Section 5.3.4.14) which
+	define the following four possible values:
+
+	:"none":
+
+		Device and host are not required to automatically restore the
+		connection.
+
+	:"host":
+
+		Bluetooth HID host restores connection.
+
+	:"device":
+
+		Bluetooth HID device restores connection.
+
+	:"any":
+
+		Bluetooth HID device shall attempt to restore the lost
+		connection, but Bluetooth HID Host may also restore the
+		connection.
-- 
2.41.0

