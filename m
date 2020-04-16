Return-Path: <SRS0=gb+p=6A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FDC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 03:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14022076A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Apr 2020 03:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VB7SZkLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389182AbgDPDJS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388679AbgDPDJM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Apr 2020 23:09:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036C8C061A0C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 20:09:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z9so760534pjd.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2020 20:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50RFmMa+/GrFabHF4KzsBwDEi29B3iMJp3H6sPfstOI=;
        b=VB7SZkLzn6qVXO3smneTPPWIV5DaJiWc11+BVEP+4Ue7ArmGv81Kl3kH8ao+tDErT7
         Yc7grYhtQgpm/t5LK1cwyCmy+e8ttglrlUJvazOeCFFDYw9AlS/JVrepJpgTEGBAb3yw
         QfxHTMdttbshCfjcgc3rqBaOYN2kgPfyPQK3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50RFmMa+/GrFabHF4KzsBwDEi29B3iMJp3H6sPfstOI=;
        b=CJyFkbvc6xfzDO2a2En0kyRgR9RAOsdXEUOD3cxEDLMRrut/JVaDdWV/oRm+VKqmcP
         GmM1zz6j0bTeKuzC0MJrEMIzbpdfUQtqIXzaKfULoR/oUVRe0oDwZHuE1V33igxb0ZCa
         pXvyNOC31cvmGTk9Iq3N00/1wtFROGtp1gVIAX33PmRwS/0tWEXzT1sfD9WBC/Ux+veE
         rEDjOBb1iKYCANsucBN8y7lLQKYtDI6dEn5UNvktE5YE7fTJT2e0eVewwnBFNyN30b0o
         G7+Z58KTZHHvKiA7AQLjhu0RIdGxXUIl1KsK5Oa4oLUvGNwwhziH2h+gcOyKZnDAAw0H
         G3/g==
X-Gm-Message-State: AGi0PuZLYtSt+G2Nl3APDhuV2otYgggjJk7OWFGHaJw1YIACZl6eNYuo
        yr+qKqNOP6Hmp0ziMWkMBr5fVMm7SUs=
X-Google-Smtp-Source: APiQypIFhmlCf+vxNp/OzEHBXh151qwP27aM1rqahljnMokOCzJ4UWlq+LkLYXxUO1Ra7EaFy+eS/Q==
X-Received: by 2002:a17:90a:6043:: with SMTP id h3mr2484765pjm.69.1587006549771;
        Wed, 15 Apr 2020 20:09:09 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id x18sm8163424pfi.22.2020.04.15.20.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 20:09:08 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2] doc: Add Advertisement Monitoring API
Date:   Wed, 15 Apr 2020 20:09:03 -0700
Message-Id: <20200415200831.BlueZ.v2.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
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

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2:
- Rename the interfaces and functions.
- Adopt the object manager mechanism so that a client can expose
multiple monitor objects and expect to get notified on whether the
monitor has been activated or not.
- Change the contract of DeviceFound so that it is called to indicate
the starting point of monitoring on a device instead of reporting every
ADV. In other words, the client is expected to monitor corresponding
device events.

 doc/advertisement-monitor-api.txt | 127 ++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 doc/advertisement-monitor-api.txt

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
new file mode 100644
index 000000000..6491dab29
--- /dev/null
+++ b/doc/advertisement-monitor-api.txt
@@ -0,0 +1,127 @@
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
+			The type of a monitor can be the following values. More
+			will be added.
+			0x01 - Patterns with logic OR applied
+				Supported only if "patterns-with-logic-or-
+				applied" is supported.
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
+Properties	array{string} SupportedFeatures [read-only]
+
+			This reflects the supported features of advertisement
+			monitoring. An application should check this before
+			instantiate and expose an object of
+			org.bluez.AdvertisementMonitor1.
+
+			Here are the potential features. More will be added.
+			software-based-filtering
+				The filtering process is mainly done in BlueZ.
+			patterns-with-logic-or-applied
+				Logic OR would be applied among the patterns
+				provided by a monitor object.
+			rssi-monitoring
+				Values of RSSIThreshholdsAndTimers would be
+				applied during the filtering process.
-- 
2.24.1

