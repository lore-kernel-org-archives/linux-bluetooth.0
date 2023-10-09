Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E9E9413E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379127AbjJIX37 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379101AbjJIX35 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC47B8
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c760b34d25so34356755ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894191; x=1697498991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPKPTrAFTaG/VuvdOhexMV8R8338ygb3Fefuv4griHI=;
        b=Pa+3zhcAgob3WgMa3SVOn9Ewbqzx/oazzXZnUmZyspYy30xLbza42/RNJp57+biwP/
         9NwPqvFdzAEICraY2+7Xje5b5LfFFfkLT0Uh+v9a9sO2lC3vkiNXDIcMTTppUwyvAEk7
         65nlTpm41gJmmMRWZMx5FwurU0p+hIHOqi+4Wh1EJNq1bBf6ivYbtovqPjil3y4aBSMe
         BnOHodfWuti7IEjV5Kd8Oz/aqMvJfqIpWZS8/6kD9UwBtJR/9oZQ31Ol1xO0+Bfl+nMQ
         TY8HyQtZQ6Joqm0fRP3vPkx0/cEYXjkXNZD0ugc0rbGZ88FK46ma1tKhInUnKq2+RkpC
         oSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894191; x=1697498991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPKPTrAFTaG/VuvdOhexMV8R8338ygb3Fefuv4griHI=;
        b=DUsZHX99UZl7ELbE5Und4gI9KDehrE+v3jNnLwcW0Td/+xYCgihl93GffvEAWkJlNs
         1GcM6+at6fepZavTp1L7zNvPTb8bBZ4HsxhMxbS2eihNwXGmRoUcImUYlaPAo0CRQy03
         sdUlTnJfBI3BGJo78IiV6zmkQ2dnGewWdBbB51MHVkYarYSSLMbA/xU92U5fdy8MiGrV
         0OAJL+o4TBmHZ2bLt23Av33sDlUaTZs7tdfqxJe/bEK6v5b9F72RWJyfRoKZ9sqpGnjR
         Dm/3p03HIUETBFjGvYU953LT6oAlZNhRcTC47hNqGd+J8kFJIMehHkeuGMHhF0SIs1Cm
         eHjQ==
X-Gm-Message-State: AOJu0YzVVO7piX/T50dbhtgUV6DeflthSQ+rnUEeaBwP1ONR2oKncD3M
        wNYFf1SAbp+N2awjYYPa8vvBPrtzZfdW3VPI
X-Google-Smtp-Source: AGHT+IHe0EUo0/U8f2HltUYdGHC7Hg/DxBsV4+OTKMJBrnJnoTA6nIcY18/5f1V0iwROj68mHqnMIQ==
X-Received: by 2002:a17:902:da8d:b0:1c0:d17a:bfe9 with SMTP id j13-20020a170902da8d00b001c0d17abfe9mr17394592plx.46.1696894191170;
        Mon, 09 Oct 2023 16:29:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/11] doc/battery-api: Rename to org.bluez.Battery*.rst
Date:   Mon,  9 Oct 2023 16:29:31 -0700
Message-ID: <20231009232933.500652-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames battery-api.txt to org.bluez.Battery*.rst and generate
manpages org.bluez.Battery*.5.
---
 Makefile.am                              | 18 ++++---
 doc/battery-api.txt                      | 69 ------------------------
 doc/org.bluez.Battery.rst                | 39 ++++++++++++++
 doc/org.bluez.BatteryProvider.rst        | 32 +++++++++++
 doc/org.bluez.BatteryProviderManager.rst | 50 +++++++++++++++++
 5 files changed, 133 insertions(+), 75 deletions(-)
 delete mode 100644 doc/battery-api.txt
 create mode 100644 doc/org.bluez.Battery.rst
 create mode 100644 doc/org.bluez.BatteryProvider.rst
 create mode 100644 doc/org.bluez.BatteryProviderManager.rst

diff --git a/Makefile.am b/Makefile.am
index 0b62852a7a20..239d2da7bb05 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -361,7 +361,9 @@ man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
-		doc/org.bluez.Network.5 doc/org.bluez.Input.5
+		doc/org.bluez.Network.5 doc/org.bluez.Input.5 \
+		doc/org.bluez.BatteryProviderManager.5 \
+		doc/org.bluez.BatteryProvider.5 doc/org.bluez.Battery.5
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -378,7 +380,9 @@ manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 		doc/org.bluez.DeviceSet.5 doc/org.bluez.AgentManager.5 \
 		doc/org.bluez.Agent.5 doc/org.bluez.ProfileManager.5 \
 		doc/org.bluez.Profile.5 doc/org.bluez.NetworkServer.5 \
-		doc/org.bluez.Network.5 doc/org.bluez.Input.5
+		doc/org.bluez.Network.5 doc/org.bluez.Input.5\
+		doc/org.bluez.BatteryProviderManager.5 \
+		doc/org.bluez.BatteryProvider.5 doc/org.bluez.Battery.5
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
@@ -429,10 +433,12 @@ EXTRA_DIST += doc/mgmt-api.txt \
 		doc/sap-api.txt
 
 EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
-	      doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
-	      doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
-	      doc/org.bluez.Profile.rst doc/org.bluez.NetworkServer.rst \
-	      doc/org.bluez.Network.rst doc/org.bluez.Input.rst
+		doc/org.bluez.DeviceSet.rst doc/org.bluez.AgentManager.rst \
+		doc/org.bluez.Agent.rst doc/org.bluez.ProfileManager.rst \
+		doc/org.bluez.Profile.rst doc/org.bluez.NetworkServer.rst \
+		doc/org.bluez.Network.rst doc/org.bluez.Input.rst \
+		doc/org.bluez.BatteryProviderManager.rst \
+		doc/org.bluez.BatteryProvider.rst doc/org.bluez.Battery.rst
 
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
diff --git a/doc/battery-api.txt b/doc/battery-api.txt
deleted file mode 100644
index c03d64fc64b6..000000000000
--- a/doc/battery-api.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-BlueZ D-Bus Battery API description
-***********************************
-
-
-Battery hierarchy
-=================
-
-Service		org.bluez
-Interface	org.bluez.Battery1
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Properties	byte Percentage [readonly]
-
-			The percentage of battery left as an unsigned 8-bit integer.
-
-		string Source [readonly, optional]
-
-			Describes where the battery information comes from
-			This property is informational only and may be useful
-			for debugging purposes.
-			Providers from BatteryProvider1 may make use of this
-			property to indicate where the battery report comes from
-			(e.g. "HFP 1.7", "HID", or the profile UUID).
-
-
-Battery Provider Manager hierarchy
-==================================
-A battery provider starts by registering itself as a battery provider with the
-RegisterBatteryProvider method passing an object path as the provider ID. Then,
-it can start exposing org.bluez.BatteryProvider1 objects having the path
-starting with the given provider ID. It can also remove objects at any time.
-The objects and their properties exposed by battery providers will be reflected
-on org.bluez.Battery1 interface.
-
-BlueZ will stop monitoring these exposed and removed objects after
-UnregisterBatteryProvider is called for that provider ID.
-
-Service		org.bluez
-Interface	org.bluez.BatteryProviderManager1
-Object path	/org/bluez/{hci0,hci1,...}
-
-Methods		void RegisterBatteryProvider(object provider)
-
-			This registers a battery provider. A registered
-			battery provider can then expose objects with
-			org.bluez.BatteryProvider1 interface described below.
-
-		void UnregisterBatteryProvider(object provider)
-
-			This unregisters a battery provider. After
-			unregistration, the BatteryProvider1 objects provided
-			by this client are ignored by BlueZ.
-
-
-Battery Provider hierarchy
-==========================
-
-Service		<client D-Bus address>
-Interface	org.bluez.BatteryProvider1
-Object path	{provider_root}/{unique battery object path}
-
-Properties	Objects provided on this interface contain the same properties
-		as org.bluez.Battery1 interface. Additionally, this interface
-		needs to have the Device property indicating the object path
-		of the device this battery provides.
-
-		object Device [readonly]
-
-			The object path of the device that has this battery.
diff --git a/doc/org.bluez.Battery.rst b/doc/org.bluez.Battery.rst
new file mode 100644
index 000000000000..d7e903c496ec
--- /dev/null
+++ b/doc/org.bluez.Battery.rst
@@ -0,0 +1,39 @@
+=================
+org.bluez.Battery
+=================
+
+-------------------------------------
+BlueZ D-Bus Battery API documentation
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
+:Interface:	org.bluez.Battery1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties
+----------
+
+byte Percentage [readonly]
+``````````````````````````
+
+	The percentage of battery left as an unsigned 8-bit integer.
+
+string Source [readonly, optional]
+``````````````````````````````````
+
+	Describes where the battery information comes from.
+
+	This property is informational only and may be useful for debugging
+	purposes.
+
+	Providers from **org.bluez.BatteryProvider(5)** may make use
+	of this property to indicate where the battery report comes from
+	(e.g. "HFP 1.7", "HID", or the profile UUID).
diff --git a/doc/org.bluez.BatteryProvider.rst b/doc/org.bluez.BatteryProvider.rst
new file mode 100644
index 000000000000..b8d8b1c2ddd0
--- /dev/null
+++ b/doc/org.bluez.BatteryProvider.rst
@@ -0,0 +1,32 @@
+=========================
+org.bluez.BatteryProvider
+=========================
+
+---------------------------------------------
+BlueZ D-Bus BatteryProvider API documentation
+---------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	<client D-Bus address>
+:Interface:	org.bluez.BatteryProvider1
+:Object path:	{provider_root}/{unique battery object path}
+
+Properties
+----------
+
+Objects provided on this interface contain the same properties as
+**org.bluez.Battery(5)** interface. Additionally, this interface needs to have
+the Device property indicating the object path of the device this battery
+provides.
+
+object Device [readonly]
+````````````````````````
+
+	The object path of the device that has this battery.
diff --git a/doc/org.bluez.BatteryProviderManager.rst b/doc/org.bluez.BatteryProviderManager.rst
new file mode 100644
index 000000000000..ab5cf2d4cadc
--- /dev/null
+++ b/doc/org.bluez.BatteryProviderManager.rst
@@ -0,0 +1,50 @@
+================================
+org.bluez.BatteryProviderManager
+================================
+
+----------------------------------------------------
+BlueZ D-Bus BatteryProviderManager API documentation
+----------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+============
+
+A battery provider starts by registering itself as a battery provider with the
+**RegisterBatteryProvider()** method passing an object path as the provider ID.
+Then, it can start exposing **org.bluez.BatteryProvider(5)** objects having the
+path starting with the given provider ID. It can also remove objects at any
+time.
+The objects and their properties exposed by battery providers will be reflected
+on **org.bluez.Battery(5)** interface.
+
+**bluetoothd(8)** will stop monitoring these exposed and removed objects after
+UnregisterBatteryProvider is called for that provider ID.
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.BatteryProviderManager1
+:Object path:	/org/bluez/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterBatteryProvider(object provider)
+`````````````````````````````````````````````
+
+	Registers a battery provider. A registered battery provider can then
+	expose objects with **org.bluez.BatteryProvider(5)** interface.
+
+void UnregisterBatteryProvider(object provider)
+```````````````````````````````````````````````
+
+	Unregisters a battery provider previously registered with
+	**RegisterBatteryProvider()**. After unregistration, the
+	**org.bluez.BatteryProvider(5)** objects provided by this client are
+	ignored by **bluetoothd(8)**.
-- 
2.41.0

