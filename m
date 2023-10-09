Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D619EE9413E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 23:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379133AbjJIXaC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379118AbjJIX36 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 19:29:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00268D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 16:29:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c63164a2b6so44790825ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696894193; x=1697498993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbKjzGfYFvrYz69Oh9xHak9Tm1bwzVG1Okvcmnq9mbQ=;
        b=C55mzXCywGd+3OSClnkH3A6lUYFvmeLO4zn8NACyrfl3K4vEb/AxvBvSQZhjb/2Tcc
         WrO+SvmXsnsYKOpIbrSqJi3F++BXH4pA0a8fGKMrUkYbHsbAC6WvtZ7O56vaGMlBQJu5
         lZF+evLc6zoXcYVF6tXvgMxtxOAkugRAK+bZ2jxHcHKbO25m8Y5vdXXJYFfNxVmpgxy2
         sm9Q4DoqMTZBXkKsLvkPQgxL7Zc5Mhu75qncX366wVSIfZHvnNKItBIklhpSKaHzS3Gi
         m2cu3TJg+ZxNE8IV9izbfvSvts+PbXCdCQ/IYmTsnDnsPtqXP+v1SZKo2GLvqHq2cyUT
         PBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894193; x=1697498993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbKjzGfYFvrYz69Oh9xHak9Tm1bwzVG1Okvcmnq9mbQ=;
        b=nKp10qDC3dg1QCCc6PoQofccQ1fEHIQ5VuaK47eARZI7SjM6ciZVQYL2e1GyLUOwxl
         J8Rbwzn5ELBy2RGhs90wJCKC1yAHiRa0WMlwCUHb8Zb8jJ78ONc23enIq/EPpHJ9kL/U
         jZfLEbql9WWVJYyyOlDnWlYI4/mrHtFPKVGehpS9d8LBiIin7BeXMgFBV5TiFi+HJE/s
         u0AagnQUi64oKXAk5A+5Xy49piiWAQm9CLvkBaV19T8pgBlJF4krylbo3qYjNzY6kHyF
         /Chsm6pikw+/toPtu1jVte8F6/AKgpgmnFIhAIW6yUIX22sDN60R5RWC10uhOVlXw23I
         7/mg==
X-Gm-Message-State: AOJu0Yy6+qg6+VPjnPUWYqqaXBO/5vB0Vq/ebDGXkJ4SphAUdm6NR8kW
        yqwbr6xcJIyzFA2kbbY6OI0tzX4emD+g1YsS
X-Google-Smtp-Source: AGHT+IGFdZgVfENn8XCUK4IvKjVqEiiYcmmlWqCnKO6pp6tmA/FEiw1qrynQb3HdHIXidDfGha5RrQ==
X-Received: by 2002:a17:902:c404:b0:1c9:9fa6:ce5b with SMTP id k4-20020a170902c40400b001c99fa6ce5bmr4945303plk.16.1696894193172;
        Mon, 09 Oct 2023 16:29:53 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902989400b001c5b8087fe5sm10182711plp.94.2023.10.09.16.29.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:29:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/11] doc/advertisement-monitor-api: Rename to org.bluez.AdvertisementMonitor*.rst
Date:   Mon,  9 Oct 2023 16:29:32 -0700
Message-ID: <20231009232933.500652-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009232933.500652-1-luiz.dentz@gmail.com>
References: <20231009232933.500652-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames advertisement-monitor-api.txt to
org.bluez.AdvertisementMonitor*.rst and generate manpages
org.bluez.AdvertisementMonitor*.5.
---
 Makefile.am                                   |  12 +-
 doc/advertisement-monitor-api.txt             | 187 ------------------
 doc/org.bluez.AdvertisementMonitor.rst        | 153 ++++++++++++++
 doc/org.bluez.AdvertisementMonitorManager.rst |  90 +++++++++
 4 files changed, 252 insertions(+), 190 deletions(-)
 delete mode 100644 doc/advertisement-monitor-api.txt
 create mode 100644 doc/org.bluez.AdvertisementMonitor.rst
 create mode 100644 doc/org.bluez.AdvertisementMonitorManager.rst

diff --git a/Makefile.am b/Makefile.am
index 239d2da7bb05..ae44937a50e1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -373,7 +373,9 @@ man_MANS += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.GattCharacteristic.5 \
 		doc/org.bluez.GattDescriptor.5 \
 		doc/org.bluez.LEAdvertisingManager.5 \
-		doc/org.bluez.LEAdvertisement.5
+		doc/org.bluez.LEAdvertisement.5 \
+		doc/org.bluez.AdvertisementMonitorManager.5 \
+		doc/org.bluez.AdvertisementMonitor.5
 endif
 manual_pages += src/bluetoothd.8
 manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
@@ -392,7 +394,9 @@ manual_pages += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.GattCharacteristic.5 \
 		doc/org.bluez.GattDescriptor.5 \
 		doc/org.bluez.LEAdvertisingManager.5 \
-		doc/org.bluez.LEAdvertisement.5
+		doc/org.bluez.LEAdvertisement.5 \
+		doc/org.bluez.AdvertisementMonitorManager.5 \
+		doc/org.bluez.AdvertisementMonitor.5
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf profiles/network/network.conf \
@@ -450,7 +454,9 @@ EXTRA_DIST += doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.rst\
 		doc/org.bluez.GattCharacteristic.rst \
 		doc/org.bluez.GattDescriptor.rst \
 		doc/org.bluez.LEAdvertisingManager.rst \
-		doc/org.bluez.LEAdvertisement.rst
+		doc/org.bluez.LEAdvertisement.rst \
+		doc/org.bluez.AdvertisementMonitorManager.rst \
+		doc/org.bluez.AdvertisementMonitor.rst
 
 EXTRA_DIST += doc/obex-api.txt doc/obex-agent-api.txt
 
diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
deleted file mode 100644
index 9189f2cceb96..000000000000
--- a/doc/advertisement-monitor-api.txt
+++ /dev/null
@@ -1,187 +0,0 @@
-BlueZ D-Bus Advertisement Monitor API Description
-*************************************************
-
-This API allows an client to specify a job of monitoring advertisements by
-registering the root of hierarchy and then exposing advertisement monitors
-under the root with filtering conditions, thresholds of RSSI and timers
-of RSSI thresholds.
-
-Once a monitoring job is activated by BlueZ, the client can expect to get
-notified on the targeted advertisements no matter if there is an ongoing
-discovery session (a discovery session is started/stopped with methods in
-org.bluez.Adapter1 interface).
-
-Advertisement Monitor hierarchy
-===============================
-Service		org.bluez
-Interface	org.bluez.AdvertisementMonitor1 [experimental]
-Object path	freely definable
-
-Methods		void Release() [noreply]
-
-			This gets called as a signal for a client to perform
-			clean-up when (1)a monitor cannot be activated after it
-			was exposed or (2)a monitor has been deactivated.
-
-		void Activate() [noreply]
-
-			After a monitor was exposed, this gets called as a
-			signal for client to get acknowledged when a monitor
-			has been activated, so the client can expect to receive
-			calls on DeviceFound() or DeviceLost().
-
-		void DeviceFound(object device) [noreply]
-
-			This gets called to notify the client of finding the
-			targeted device. Once receiving the call, the client
-			should start to monitor the corresponding device to
-			retrieve the changes on RSSI and advertisement content.
-
-		void DeviceLost(object device) [noreply]
-
-			This gets called to notify the client of losing the
-			targeted device. Once receiving this call, the client
-			should stop monitoring the corresponding device.
-
-Properties	string Type [read-only]
-
-			The type of the monitor. See SupportedMonitorTypes in
-			org.bluez.AdvertisementMonitorManager1 for the available
-			options.
-
-		Int16 RSSILowThreshold [read-only, optional]
-
-			Used in conjunction with RSSILowTimeout to determine
-			whether a device becomes out-of-range. Valid range is
-			-127 to 20 (dBm), while 127 indicates unset.
-
-		Int16 RSSIHighThreshold [read-only, optional]
-
-			Used in conjunction with RSSIHighTimeout to determine
-			whether a device becomes in-range. Valid range is
-			-127 to 20 (dBm), while 127 indicates unset.
-
-		Uint16 RSSILowTimeout [read-only, optional]
-
-			The time it takes to consider a device as out-of-range.
-			If this many seconds elapses without receiving any
-			signal at least as strong as RSSILowThreshold, a
-			currently in-range device will be considered as
-			out-of-range (lost). Valid range is 1 to 300 (seconds),
-			while 0 indicates unset.
-
-		Uint16 RSSIHighTimeout [read-only, optional]
-
-			The time it takes to consider a device as in-range.
-			If this many seconds elapses while we continuously
-			receive signals at least as strong as RSSIHighThreshold,
-			a currently out-of-range device will be considered as
-			in-range (found). Valid range is 1 to 300 (seconds),
-			while 0 indicates unset.
-
-		Uint16 RSSISamplingPeriod [read-only, optional]
-
-			Grouping rules on how to propagate the received
-			advertisement packets to the client. Valid range is 0 to
-			255 while 256 indicates unset.
-
-			The meaning of this property is as follows:
-			0:
-				All advertisement packets from in-range devices
-				would be propagated.
-			255:
-				Only the first advertisement packet of in-range
-				devices would be propagated. If the device
-				becomes lost, then the first packet when it is
-				found again will also be propagated.
-			1 to 254:
-				Advertisement packets would be grouped into
-				100ms * N time period. Packets in the same group
-				will only be reported once, with the RSSI value
-				being averaged out.
-
-			Currently this is unimplemented in user space, so the
-			value is only used to be forwarded to the kernel.
-
-		array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
-
-			If the Type property is set to "or_patterns", then this
-			property must exist and have at least one entry in the
-			array.
-
-			The structure of a pattern contains the following:
-			uint8 start_position
-				The index in an AD data field where the search
-				should start. The beginning of an AD data field
-				is index 0.
-			uint8 AD_data_type
-				See https://www.bluetooth.com/specifications/
-				assigned-numbers/generic-access-profile/ for
-				the possible allowed value.
-			array{byte} content_of_pattern
-				This is the value of the pattern. The maximum
-				length of the bytes is 31.
-
-Advertisement Monitor Manager hierarchy
-=======================================
-Service		org.bluez
-Interface	org.bluez.AdvertisementMonitorManager1 [experimental]
-Object path	/org/bluez/{hci0,hci1,...}
-
-Methods		void RegisterMonitor(object application)
-
-			This registers the root path of a hierarchy of
-			advertisement monitors.
-			The application object path together with the D-Bus
-			system bus connection ID define the identification of
-			the application registering advertisement monitors.
-			Once a root path is registered by a client via this
-			method, the client can freely expose/unexpose
-			advertisement monitors without re-registering the root
-			path again. After use, the client should call
-			UnregisterMonitor() method to invalidate the
-			advertisement monitors.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-					 org.bluez.Error.Failed
-
-		void UnregisterMonitor(object application)
-
-			This unregisters a hierarchy of advertisement monitors
-			that has been previously registered. The object path
-			parameter must match the same value that has been used
-			on registration. Upon unregistration, the advertisement
-			monitor(s) should expect to receive Release() method as
-			the signal that the advertisement monitor(s) has been
-			deactivated.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
-
-Properties	array{string} SupportedMonitorTypes [read-only]
-
-			This lists the supported types of advertisement
-			monitors. An application should check this before
-			instantiate and expose an object of
-			org.bluez.AdvertisementMonitor1.
-
-			Possible values for monitor types:
-
-			"or_patterns"
-				Patterns with logic OR applied. With this type,
-				property "Patterns" must exist and has at least
-				one pattern.
-
-		array{string} SupportedFeatures [read-only]
-
-			This lists the features of advertisement monitoring
-			supported by BlueZ.
-
-			Possible values for features:
-
-			"controller-patterns"
-				If the controller is capable of performing
-				advertisement monitoring by patterns, BlueZ
-				would offload the patterns to the controller to
-				reduce power consumption.
diff --git a/doc/org.bluez.AdvertisementMonitor.rst b/doc/org.bluez.AdvertisementMonitor.rst
new file mode 100644
index 000000000000..98852ac68b59
--- /dev/null
+++ b/doc/org.bluez.AdvertisementMonitor.rst
@@ -0,0 +1,153 @@
+==============================
+org.bluez.AdvertisementMonitor
+==============================
+
+--------------------------------------------------
+BlueZ D-Bus AdvertisementMonitor API documentation
+--------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Description
+===========
+
+This API allows an client to specify a job of monitoring advertisements by
+registering the root of hierarchy and then exposing advertisement monitors
+under the root with filtering conditions, thresholds of RSSI and timers
+of RSSI thresholds.
+
+Once a monitoring job is activated by **bluetoothd(8)**, the client can expect
+to get notified on the targeted advertisements no matter if there is an ongoing
+discovery session (see **StartDiscovery()** in **org.bluez.Adapter(5)**).
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.AdvertisementMonitor1 [experimental]
+:Object path:	freely definable
+
+Methods
+-------
+
+void Release() [noreply]
+````````````````````````
+
+	This gets called as a signal for a client to perform clean-up when:
+
+	- Monitor cannot be activated after it was exposed
+	- Monitor has been deactivated.
+
+void Activate() [noreply]
+`````````````````````````
+
+	After a monitor was exposed, this gets called as a signal for client to
+	get acknowledged when a monitor has been activated, so the client can
+	expect to receive calls on **DeviceFound()** or **DeviceLost()**.
+
+void DeviceFound(object device) [noreply]
+`````````````````````````````````````````
+
+	This gets called to notify the client of finding the targeted device.
+	Once receiving the call, the client should start to monitor the
+	corresponding device to retrieve the changes on RSSI and advertisement
+	content.
+
+void DeviceLost(object device) [noreply]
+````````````````````````````````````````
+
+	This gets called to notify the client of losing the targeted device.
+	Once receiving this call, the client should stop monitoring the
+	corresponding device.
+
+Properties
+----------
+
+string Type [read-only]
+```````````````````````
+
+	The type of the monitor. See **SupportedMonitorTypes** in
+	**org.bluez.AdvertisementMonitorManager(5)** for the available options.
+
+int16 RSSILowThreshold [read-only, optional]
+````````````````````````````````````````````
+
+	Used in conjunction with **RSSILowTimeout** to determine whether a
+	device becomes out-of-range. Valid range is -127 to 20 (dBm), while 127
+	indicates unset.
+
+int16 RSSIHighThreshold [read-only, optional]
+`````````````````````````````````````````````
+
+	Used in conjunction with RSSIHighTimeout to determine whether a device
+	becomes in-range. Valid range is -127 to 20 (dBm), while 127 indicates
+	unset.
+
+uint16 RSSILowTimeout [read-only, optional]
+```````````````````````````````````````````
+
+	The time it takes to consider a device as out-of-range. If this many
+	seconds elapses without receiving any signal at least as strong as
+	**RSSILowThreshold**, a currently in-range device will be considered as
+	out-of-range (lost). Valid range is 1 to 300 (seconds), while 0
+	indicates unset.
+
+uint16 RSSIHighTimeout [read-only, optional]
+````````````````````````````````````````````
+
+	The time it takes to consider a device as in-range. If this many
+	seconds elapses while we continuouslyreceive signals at least as strong
+	as **RSSIHighThreshold**, a currently out-of-range device will be
+	considered as in-range (found). Valid range is 1 to 300 (seconds),
+	while 0 indicates unset.
+
+uint16 RSSISamplingPeriod [read-only, optional]
+```````````````````````````````````````````````
+
+	Grouping rules on how to propagate the received advertisement packets
+	to the client.
+
+	Possible values:
+
+	:0:
+		All advertisement packets from in-range devices would be
+		propagated.
+
+	:255:
+		Only the first advertisement packet of in-range devices would
+		be propagated. If the device becomes lost, then the first
+		packet when it is found again will also be propagated.
+
+	:1 to 254:
+		Advertisement packets would be grouped into 100ms * N time
+		period. Packets in the same group will only be reported once,
+		with the RSSI value being averaged out.
+
+	Currently this is unimplemented in user space, so the value is only
+	used to be forwarded to the kernel.
+
+array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
+`````````````````````````````````````````````````````````````````
+
+	If the **Type** property is set to **"or_patterns"**, then this
+	property must exist and have at least one entry in the array.
+
+	The structure of a pattern contains the following:
+
+	:uint8 start_position:
+
+		The index in an AD data field where the search hould start. The
+		beginning of an AD data field is index 0.
+
+	:uint8 AD_data_type:
+
+		See https://www.bluetooth.com/specifications/assigned-numbers/
+		generic-access-profile/ for the possible allowed value.
+
+	:array{byte} content_of_pattern:
+
+		This is the value of the pattern. The maximum length of the
+		bytes is 31.
diff --git a/doc/org.bluez.AdvertisementMonitorManager.rst b/doc/org.bluez.AdvertisementMonitorManager.rst
new file mode 100644
index 000000000000..3775a483543c
--- /dev/null
+++ b/doc/org.bluez.AdvertisementMonitorManager.rst
@@ -0,0 +1,90 @@
+=====================================
+org.bluez.AdvertisementMonitorManager
+=====================================
+
+---------------------------------------------------------
+BlueZ D-Bus AdvertisementMonitorManager API documentation
+---------------------------------------------------------
+
+:Version: BlueZ
+:Date: October 2023
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+Service		org.bluez
+Interface	org.bluez.AdvertisementMonitorManager1 [experimental]
+Object path	/org/bluez/{hci0,hci1,...}
+
+Methods
+-------
+
+void RegisterMonitor(object application)
+````````````````````````````````````````
+
+	Registers the root path of a hierarchy of advertisement monitors
+	implementing **org.bluez.AdvertisementMonitor(5)**.
+
+	The application object path together with the D-Bus ystem bus
+	connection ID define the identification of the application registering
+	advertisement monitors.
+
+	Once a root path is registered by a client via this method, the client
+	can freely expose/unexpose advertisement monitors without re-registering
+	the root path again. After use, the client should call
+	**UnregisterMonitor()** method to invalidate the advertisement monitors.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.AlreadyExists:
+	:org.bluez.Error.Failed:
+
+void UnregisterMonitor(object application)
+``````````````````````````````````````````
+
+	Unregisters a hierarchy of advertisement monitors that has been
+	previously registered with **RegisterMonitor()**. The object path
+	parameter must match the same value that has been used on registration.
+
+	Upon unregistration, the advertisement monitor(s) should expect to
+	receive **Release()** method as the signal that the advertisement
+	monitor(s) has been deactivated.
+
+	Possible errors:
+
+	:org.bluez.Error.InvalidArguments:
+	:org.bluez.Error.DoesNotExist:
+
+Properties
+----------
+
+array{string} SupportedMonitorTypes [read-only]
+```````````````````````````````````````````````
+
+	This lists the supported types of advertisement monitors. An application
+	should check this before instantiate and expose an object of
+	**org.bluez.AdvertisementMonitor(5)**.
+
+	Possible values:
+
+	:"or_patterns":
+
+		Patterns with logic OR applied. With this type, property
+		**Patterns** must exist and has at least one pattern.
+
+array{string} SupportedFeatures [read-only]
+```````````````````````````````````````````
+
+	This lists the features of advertisement monitoring supported by
+	**bluetoothd(8)**.
+
+	Possible values:
+
+	:"controller-patterns":
+
+		If the controller is capable of performing advertisement
+		monitoring by patterns, **bluetoothd(8)** would offload the
+		patterns to the controller to reduce power consumption.
-- 
2.41.0

