Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D9E9413D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 01:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJGBCF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Oct 2023 21:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjJGBCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Oct 2023 21:02:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECB8C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 18:02:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-565e395e7a6so1635031a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Oct 2023 18:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696640521; x=1697245321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZEtrbzXngvXdJZfe4mzW0EEeYxGk5KHatJ0uG5DkXU=;
        b=PSwuWSDpX47x8MixbY29zES7ejS8dr1BD9y8tTluJjwTQPnCt855ia2x7DqitsR7bd
         UatvOwQPty3WCmL76/mz4iuwcDegTsXQT5xA5K08g4+63+CBo5EkzfbtBa8t4uzhNwOP
         MX+Ds3L1U1LLe6S666+GR9KFgYevV4bdy2o7lkhw4TLGbBYgr7+MHlQt2xOu2R/S2twB
         XdZ99TGRJZliBtrNp1ZUIzZt4NYu1j4FNST/zKSGuLiWh6SgkBrrd1dclO2F9tbgkKzE
         bPZd6CboqDDckiMo9ikoDw7qQ30yXz7fbwnt7OcN4zqUwbDbaVqkTukMQkm8MpycA4OY
         NMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696640521; x=1697245321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZEtrbzXngvXdJZfe4mzW0EEeYxGk5KHatJ0uG5DkXU=;
        b=htXpee/yGO/QOMXsKb2akLHU5l3Q83OP4sM8Yw8S+i6gwqXxMr6fwVKsAFVRizq+Rz
         hgJQnulJV0qVqZbj2Sitpvc09PBESSZf/K94ciVsnmIAk4kTasIR96OIvjUUfXKCgsIO
         lnIyESbpQWBFZnq2QukRirDYLRE9WR137I0IpL/Kou1ForK50shlHKYvNGxUIfonDS7q
         SAGf19s/KJJwpcteQn2h5r4SmfDxMVJXJbBksTzFSm4Bren9lqQhnJFnQcDrqdMXL1Ea
         gbMI/lHrd9oqxhVDL9CM7BWlmM97PB5dP7YK2uWBK6ah+A48ptJGQcJemIsKsOTMdqvc
         wSFg==
X-Gm-Message-State: AOJu0YyuA8/crF+QVKb7DmDyUfbC0MiXyW6oqg4PpRt03odS8jxpCW+4
        6tHnyQqwAFPHwUtwliLPJ1by0Wh0vAywU9cg
X-Google-Smtp-Source: AGHT+IFlspJlsG3DD5b+QKXO6XhcQrlk6bIIZnuv5nPcqxvH8IFQH79Jh2VbbXl3YR0IX6wco8e/vw==
X-Received: by 2002:a17:90a:6c47:b0:267:f9ab:15bb with SMTP id x65-20020a17090a6c4700b00267f9ab15bbmr8816835pjj.14.1696640520914;
        Fri, 06 Oct 2023 18:02:00 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id co11-20020a17090afe8b00b00279060a0fccsm4098360pjb.9.2023.10.06.18.01.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 18:01:59 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] doc/input-api: Rename to org.bluez.Input.rst
Date:   Fri,  6 Oct 2023 18:01:48 -0700
Message-ID: <20231007010150.4103452-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231007010150.4103452-1-luiz.dentz@gmail.com>
References: <20231007010150.4103452-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames input-api.txt to org.bluez.Input.rst and generate manpages
org.bluez.Input.5.
---
 Makefile.am             |  6 ++---
 doc/input-api.txt       | 32 --------------------------
 doc/org.bluez.Input.rst | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 35 deletions(-)
 delete mode 100644 doc/input-api.txt
 create mode 100644 doc/org.bluez.Input.rst

diff --git a/Makefile.am b/Makefile.am
index 4507b72bbae7..38074c773b4f 100644
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

