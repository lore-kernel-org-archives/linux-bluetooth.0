Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DFC4CECC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF48A20728
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 20:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SZtkGBr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgD0UM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725919AbgD0UM3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 16:12:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A6EC0610D5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 13:12:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a32so100003pje.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDo8lVsO4GmBpQKRCqJTmRE6+3RnZE/MdVldWl0wABg=;
        b=SZtkGBr1agY7qYPWxuWZd4IsHBzSV7Yr978TSnsaLTH5gCNjQmLfHnJ1hM7lhcepFJ
         O0hAandOfWd17vyOUL9TVGs5C5ijH0pVR1jcikiImzxvNhRLYzIMwbXfvaoA0M1QKal4
         /B6Iid9EwViLoN/P/wN1FNBA4Yeo83BE7ADjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wDo8lVsO4GmBpQKRCqJTmRE6+3RnZE/MdVldWl0wABg=;
        b=HSHHmhA8H2FnIL0QOdp6uhY1LzcIaVImfeo/qYqZkdRipFoza7HM2d0ZMGlBJl9R2u
         N+5VesNNtUxV/ve8fIH889G9vqDWKn3PML/kE98/nwxDWlrlrpV8lBR4ciW4Hg85Fs7x
         T7aiWud/ifpwRkUGneeku7vAjG3iN5ha0iGiefMZJFdfWQ3lZnjdZcRbOiZWTHX+38ik
         ft2Oz4js0gaUhyJrB6Q9KMrliVdW/7Qgj6u6VvVbcVmoeozX/NpGsJJ1L8uY4DFyaYWJ
         uO85hP1uDSlNXLbejkANWug/6oxEnhg1FVL1AcaiwKUu7AVHcYxIX5PRfuTm6+bs0uOM
         yXFg==
X-Gm-Message-State: AGi0PuYxV2WU0hGYQACKsiWHTVJs8xEMKKFZFHbQvXqT9XB53WjT9ENf
        5WjQlpYVrPJ4FrsxtZf9CI/xo/kB+ug=
X-Google-Smtp-Source: APiQypISYiEeOP5K+Pm9q7miYgo4h838rBsvugJ1eSJ0IemGJKT2/QeidkLKAh7d8MLU5+4FiRMs1w==
X-Received: by 2002:a17:90a:8404:: with SMTP id j4mr494787pjn.12.1588018346178;
        Mon, 27 Apr 2020 13:12:26 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id f6sm13028648pfn.189.2020.04.27.13.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:12:25 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v4] doc: Add Advertisement Monitoring API
Date:   Mon, 27 Apr 2020 13:12:19 -0700
Message-Id: <20200427131208.BlueZ.v4.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
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
index 000000000..012fce420
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
+Service		org.bluez
+Interface	org.bluez.AdvertisementMonitor1 [experimental]
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
+Advertisement Monitor Manager hierarchy
+=======================================
+Service		org.bluez
+Interface	org.bluez.AdvertisementMonitorManager1 [experimental]
+Object path	/org/bluez/{hci0,hci1,...}
+
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
+Properties	array{string} SupportedMonitorTypes [read-only]
+
+			This lists the supported types of advertisement
+			monitors. An application should check this before
+			instantiate and expose an object of
+			org.bluez.AdvertisementMonitor1.
+
+			Possible values for monitor types:
+
+			"patterns_with_logic_or"
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
+			"controller-based-monitor-by-patterns"
+				If the controller is capable of performing
+				advertisement monitoring by patterns, BlueZ
+				would offload the patterns to the controller to
+				reduce power consumption.
-- 
2.24.1

