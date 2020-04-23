Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0485DC54FD0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC2E20728
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 21:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqRhn6Dd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDWVOt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWVOt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 17:14:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D96C09B042
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:14:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h12so1990014pjz.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/M4QmIoZmeIiS/RBi2NOcEP+1qthQRucyV9U39J9MA=;
        b=SqRhn6DdxHk7qn8L/aET+K8ZrwV63U06MNdKTJCGIXcmBd9GPQF6kWNltWE3qKRCLv
         jqY/o3Ziyle4LJsrWoPWkKVp4XPkT7jZvvvmIuUPV4goZqMc9cAjV6zAlgq2Ol0xqA6L
         0Njg+zBQuAsz2/g+2rmKunccC1ho2z/madr14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c/M4QmIoZmeIiS/RBi2NOcEP+1qthQRucyV9U39J9MA=;
        b=MacaVHHHjaUcjrttLu7ZGOtz2wVetIsLME7OQmNFv715X5uxX/t68mUx0HQwq83YtL
         h/qc7IfENOuFh2N7qYbn7zIDbbZoWwpEUoL1cCIV0SEEDPCFMaP64OL2+YFdAwkbWQ4x
         NoBm6ixK7j9Fko0Y7FxcIEr9TSdTb1pe/j5B9Pa1jrcW53K+zeRQK0NgvV6Adyr8tq7c
         SH1tDho+sQ+ObOMu+JV8chGBHocn8CziIAnqXwUzVc9xbXzmd8PkXMRzoJa3JYhecpY5
         A0/WAmlOOQXAfP8e9Zs03Lc5TyjajroA+WW0qZUvNWk6dkkXdeUk9cXuQCGohVBMXs3E
         FEQg==
X-Gm-Message-State: AGi0PuYV9YDy4YP4QnqX+Gf8yZEaEhIdTCRFtMUcllmHzgDJ9uGp8kj+
        a8A/CYU5arvOOKVl73q+VAJUZqNMl1U=
X-Google-Smtp-Source: APiQypKtCzdKSDo1CHVrIUS4sEGhK8gD8r1bAd22t5j2eH8pREEAQtOBBPZkRTFV+Vtg1nHFP6rtBg==
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr2654927pjb.143.1587676487955;
        Thu, 23 Apr 2020 14:14:47 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id y29sm3641356pfq.162.2020.04.23.14.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 14:14:47 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v3] doc: Add Advertisement Monitoring API
Date:   Thu, 23 Apr 2020 14:14:41 -0700
Message-Id: <20200423141423.BlueZ.v3.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
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

 doc/advertisement-monitor-api.txt | 134 ++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 doc/advertisement-monitor-api.txt

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
new file mode 100644
index 000000000..b8b01536a
--- /dev/null
+++ b/doc/advertisement-monitor-api.txt
@@ -0,0 +1,134 @@
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
+Service		org.bluez
+Interface	org.bluez.AdvertisementMonitor1
+Object path	freely definable
+
+Methods		void Release() [noreply]
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
+=======================================
+Service		org.bluez
+Interface	org.bluez.AdvertisementMonitorManager1
+Object path	/org/bluez/{hci0,hci1,...}
+Methods		void RegisterApplication(object application)
+
+			This registers a hierarchy of advertisement monitors.
+			The application object path together with the D-Bus
+			system bus connection ID define the identification of
+			the application registering advertisement monitors.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void UnregisterApplication(object application)
+
+			This unregisters advertisement monitors that have been
+			previously registered. The object path parameter must
+			match the same value that has been used on
+			registration.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
+
+Properties	array{uint8} SupportedMonitorTypes [read-only]
+
+			This lists the supported types of advertisement
+			monitors. An application should check this before
+			instantiate and expose an object of
+			org.bluez.AdvertisementMonitor1.
+
+			Possible values for monitor types:
+
+			0x01	Patterns with logic OR applied. With this type,
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
+			"controller-based-monitor-by-patterns"
+				If the controller is capable of performing
+				advertisement monitoring by patterns, BlueZ
+				would offload the patterns to the controller to
+				reduce power consumption.
-- 
2.24.1

