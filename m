Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2759C47256
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F7208DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 23:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZ66rhYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgEAXLI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 19:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAXLH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 19:11:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D0C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 16:11:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id hi11so502821pjb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSnYh2MpU177hTo/8gdzpYUncp20lC76SDO8HZ5dMgE=;
        b=eZ66rhYXf8gHn7mI4bKVLO5RiXfHcVJr0vdLdVzXT/gDZZYzUjmEP7r/WkQTuVhPzw
         RS05M6VlrWm4vKJvsWFOGqTmwfMX733a6wVtz0K9ZAXy3ilZ/V6hkDbIUMP/LOn95noV
         adQzqquNBfOfxiR8JcXJm5Lrn5xtS4UsCMPeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZSnYh2MpU177hTo/8gdzpYUncp20lC76SDO8HZ5dMgE=;
        b=L3DQbb4C1++rno316IomMRbwrmZ9kCa10HxDmz32OT7y/oJatecfYI9a8RMD9vvXle
         wk6OybuMg2rAq/bTlqRt43VLzU9JVDH0ynstl9HhbTvU4bR/gOSiTR//5zNqtQyC0Fh9
         jNxOwEeZNYWL0QNiloDGMd/dJMZfEkTIrxbnj+7DJaGWEPTV0kdbnXW5ysytsxyyxLAV
         7w2RNahJo+eZ6oeYLBu5D+PQg7YbmDiyy/Bb8vXu7fGfmkG+iwc7G4mjwlBOF1BVoTVa
         S9lO5rbY4jP+T/ecVNOKaOOngkEyN7LgpI5xLCL99AVpPI1M3vwVlbVbpl6SCejiiyuO
         ft5A==
X-Gm-Message-State: AGi0Puadn33kTb/sfuYnKdD8CmBpFcu+2w8sCpoPaaUd1xD42otkilxN
        8Uju45Gkqz2ijJT1ldvduU5an3YVWFs=
X-Google-Smtp-Source: APiQypJ+dv+yuLg5z8KqPugNyM3RKm9+RlZNCk3GBg49uhkcYcuhYVEiWY9UwQ0gYnXdCUSJck5z/Q==
X-Received: by 2002:a17:902:dc86:: with SMTP id n6mr6972743pld.198.1588374665662;
        Fri, 01 May 2020 16:11:05 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id p1sm678358pjf.15.2020.05.01.16.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 16:11:04 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5] doc: Add Advertisement Monitoring API
Date:   Fri,  1 May 2020 16:10:59 -0700
Message-Id: <20200501161017.BlueZ.v5.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch proposes an Advertisement Monitoring API for an application to
register a job of monitoring ADV reports with content filter and RSSI
thresholds.
---

Changes in v5:
- Fix indentation of few lines.
- Shorten the name of functions and strings of parameters.

Changes in v4:
- Change the signature of SupportedMonitorTypes to be array of strings.
- Fix document formatting.

Changes in v3:
- Introduce SupportedFeatures to reflect the features based on
controller's capabilities.
- Modify SupportedMonitorTypes to list available types of monitors.

Changes in v2:
- Rename the interfaces and functions.
- Adopt the object manager mechanism so that a client can expose
multiple monitor objects and expect to get notified on whether the
monitor has been activated or not.
- Change the contract of DeviceFound so that it is called to indicate
the starting point of monitoring on a device instead of reporting every
ADV. In other words, the client is expected to monitor corresponding
device events.

 doc/advertisement-monitor-api.txt | 137 ++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 doc/advertisement-monitor-api.txt

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
new file mode 100644
index 000000000..eb5c83768
--- /dev/null
+++ b/doc/advertisement-monitor-api.txt
@@ -0,0 +1,137 @@
+BlueZ D-Bus Advertisement Monitor API Description
+*************************************************
+
+This API allows an client to specify a job of monitoring advertisements by
+registering the root of hierarchy and then exposing advertisement monitors
+under the root with filtering conditions, thresholds of RSSI and timers
+of RSSI thresholds.
+
+Once a monitoring job is activated by BlueZ, the client can expect to get
+notified on the targeted advertisements no matter if there is an ongoing
+discovery session (a discovery session is started/stopped with methods in
+org.bluez.Adapter1 interface).
+
+Advertisement Monitor hierarchy
+===============================
+Service	org.bluez
+Interface	org.bluez.AdvertisementMonitor1 [experimental]
+Object path	freely definable
+
+Methods	void Release() [noreply]
+
+			This gets called as a signal for a client to perform
+			clean-up when (1)a monitor cannot be activated after it
+			was exposed or (2)a monitor has been deactivated.
+
+		void Activate() [noreply]
+
+			After a monitor was exposed, this gets called as a
+			signal for client to get acknowledged when a monitor
+			has been activated, so the client can expect to receive
+			calls on DeviceFound() or DeviceLost().
+
+		void DeviceFound(object device) [noreply]
+
+			This gets called to notify the client of finding the
+			targeted device. Once receiving the call, the client
+			should start to monitor the corresponding device to
+			retrieve the changes on RSSI and advertisement content.
+
+		void DeviceLost(object device) [noreply]
+
+			This gets called to notify the client of losing the
+			targeted device. Once receiving this call, the client
+			should stop monitoring the corresponding device.
+
+Properties	uint8 Type [read-only]
+
+			The type of the monitor. See SupportedMonitorTypes in
+			org.bluez.AdvertisementMonitorManager1 for the available
+			options.
+
+		(Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
+
+			This contains HighRSSIThreshold, HighRSSIThresholdTimer,
+			LowRSSIThreshold, LowRSSIThresholdTimer in order. The
+			unit of HighRSSIThreshold and LowRSSIThreshold is dBm.
+			The unit of HighRSSIThresholdTimer and
+			LowRSSIThresholdTimer is second.
+
+			If these are provided, RSSI would be used as a factor to
+			notify the client of whether a device stays in range or
+			move out of range. A device is considered in-range when
+			the RSSIs of the received advertisement(s) during
+			HighRSSIThresholdTimer seconds exceed HighRSSIThreshold.
+			Likewise, a device is considered out-of-range when the
+			RSSIs of the received advertisement(s) during
+			LowRSSIThresholdTimer do not reach LowRSSIThreshold.
+
+		array{(uint8, uint8, string)} Patterns [read-only, optional]
+
+			If Type is set to 0x01, this must exist and has at least
+			one entry in the array.
+
+			The structure of a pattern contains the following.
+			uint8 start_position
+				The index in an AD data field where the search
+				should start. The beginning of an AD data field
+				is index 0.
+			uint8 AD_data_type
+				See https://www.bluetooth.com/specifications/
+				assigned-numbers/generic-access-profile/ for
+				the possible allowed value.
+			string content_of_pattern
+				This is the value of the pattern.
+
+Advertisement Monitor Manager hierarchy
+=======================================
+Service	org.bluez
+Interface	org.bluez.AdvertisementMonitorManager1 [experimental]
+Object path	/org/bluez/{hci0,hci1,...}
+
+Methods	void RegisterMonitor(object application)
+
+			This registers a hierarchy of advertisement monitors.
+			The application object path together with the D-Bus
+			system bus connection ID define the identification of
+			the application registering advertisement monitors.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void UnregisterMonitor(object application)
+
+			This unregisters advertisement monitors that have been
+			previously registered. The object path parameter must
+			match the same value that has been used on
+			registration.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
+
+Properties	array{string} SupportedMonitorTypes [read-only]
+
+			This lists the supported types of advertisement
+			monitors. An application should check this before
+			instantiate and expose an object of
+			org.bluez.AdvertisementMonitor1.
+
+			Possible values for monitor types:
+
+			"or_patterns"
+				Patterns with logic OR applied. With this type,
+				property "Patterns" must exist and has at least
+				one pattern.
+
+		array{string} SupportedFeatures [read-only]
+
+			This lists the features of advertisement monitoring
+			supported by BlueZ.
+
+			Possible values for features:
+
+			"controller-patterns"
+				If the controller is capable of performing
+				advertisement monitoring by patterns, BlueZ
+				would offload the patterns to the controller to
+				reduce power consumption.
-- 
2.24.1

