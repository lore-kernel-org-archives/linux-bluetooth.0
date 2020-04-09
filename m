Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9441C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 22:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0D2074F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 22:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgEyeYIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDIWMB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:12:01 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:36112 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDIWMB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 18:12:01 -0400
Received: by mail-pg1-f171.google.com with SMTP id c23so138377pgj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qGqrQbS2sVBSEwGojs6+mtKIg+SzYKbgurnpn5aUrg=;
        b=VgEyeYIBaCmW0Ea2mUDAKqAzAOyJLs7xu9p0QdjfL1sHvvHc/BIfyB6j4i5mKHeKPj
         p35GFpBpQpXW2DSUFeOOH5Yo/TPgad5vajC9EZtGQW6bjM1NPpMaz/C8j8dm9QKMhB/S
         ZwmS44ZcS/ARSqo/ntACpoZ01MR61/ib9TxaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qGqrQbS2sVBSEwGojs6+mtKIg+SzYKbgurnpn5aUrg=;
        b=BC+Yv5SH+lbaxsI98thWIV1o1j7+vUC8CAjyq5noI3+DFB9vXncBYyntBjFnUeK2g9
         B+Cle2bu4TG3/AUtkjLNL9uC7e/kG/Hi30Hntl5/LJDr66m6qdLQYnJn2UNguq6KVp+2
         XkXuKaXrv4FBD0Dt9IEkwCENdGilyD5LDyj56Neq0E995bsWwcXy9FkkhYrRyqvx1KXC
         qHI2jQqjz547ZEPFOnmlMdukLji23Hta/ogxdxxIR/8iDfxTe2HBK66PuttBELOH5gtv
         PYqDSmm1m0opDUS6VLJCv9JvfkbkUuklLE3xYlrip9RNljWutcReHrtPZCng5TFBsJ5P
         jiKQ==
X-Gm-Message-State: AGi0PubRsdEqMTSOKIhyDHFW8yLuHpKw9zTin3tar4SLXVCvlOPA5Tw0
        7L/x3B/tbAbVXWej2nuXBx3j8mjLbdE=
X-Google-Smtp-Source: APiQypJmJ9vatMTkLI8jQY6HuM+O1GXxYFchOpEQsB4pHTSuOKEnkb7UgbkHZp/Vcs5ODe3LYroICA==
X-Received: by 2002:aa7:940f:: with SMTP id x15mr1807173pfo.312.1586470319314;
        Thu, 09 Apr 2020 15:11:59 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id x11sm76806pfp.204.2020.04.09.15.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 15:11:58 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1] doc: Add Advertisement Monitoring API
Date:   Thu,  9 Apr 2020 15:11:37 -0700
Message-Id: <20200409151004.BlueZ.v1.1.I137a529ab03c9d0d2327f1659bd1af4954a28e78@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 doc/advertisement-monitoring-api.txt | 163 +++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 doc/advertisement-monitoring-api.txt

diff --git a/doc/advertisement-monitoring-api.txt b/doc/advertisement-monitoring-api.txt
new file mode 100644
index 000000000..070487481
--- /dev/null
+++ b/doc/advertisement-monitoring-api.txt
@@ -0,0 +1,163 @@
+BlueZ D-Bus Advertisement Monitoring API Description
+****************************************************
+
+This API allows an application to specify a job of monitoring advertisements
+by providing a filter with filtering conditions, thresholds of RSSI and timers
+of RSSI thresholds.
+
+Once an application registers a monitoring job, it can expect to get notified
+on its targeted advertisements no matter if there is an ongoing discovery
+session (a discovery session is started/stopped with methods in
+org.bluez.Adapter1 interface).
+
+Advertisement Filter hierarchy
+==============================
+Service		org.bluez
+Interface	org.bluez.AdvertisementFilter1
+Object path	freely definable
+
+Methods		void Release() [noreply]
+
+			This gets called as a signal for a client to perform
+			clean-up when BlueZ has invalidated the filter.
+
+		void DeviceInRange(object device, int16 RSSI, int16 TX_power,
+				   array{dict} ADV_data,
+				   array{uint8} ADV_raw_data)
+
+			If RSSIThreshholdsAndTimers exists, this gets called to
+			notify the client on finding the targeted device when
+			RSSI(s) of the matched advertisement(s) exceed the
+			HighRSSIThreshold at least HighRSSIThresholdTimer.
+			If RSSIThreshholdsAndTimers does not exist, this does
+			not get called.
+
+			Parameters:
+			device		The device object path associated with
+					the advertisement.
+			RSSI		The RSSI comes along with the
+					advertisement.
+			TX_power	The TX power AD data provided in the
+					advertisement. 127 indicates the absence
+					of TX power AD data.
+			ADV_data	The signature of adv_data is a{yv} where
+					“y” is the AD data type value and “v” is
+					the value of the AD data where the type
+					may vary depending on the AD data. For
+					instance, if "y" is 0x16, "v" would be
+					an array of bytes.
+			ADV_raw_data	The raw bytes of AD data from the
+					advertisement packet.
+
+		void AdvertisementReceived(object device, int16 RSSI,
+					   int16 TX_power, array{dict} ADV_data,
+					   array{uint8} ADV_raw_data)
+
+			If RSSIThreshholdsAndTimers exists, this gets called
+			every time except for the first time when receiving the
+			matched advertisement(s) exceeding the
+			HighRSSIThreshold. Once DeviceOutOfRange() gets called,
+			this no longer gets called until DeviceInRange() gets
+			called again.
+			If RSSIThreshholdsAndTimers does not exist, this gets
+			called whenever receiving the matched advertisements.
+
+			Parameters:
+			device		The device object path associated with
+					the advertisement.
+			RSSI		The RSSI comes along with the
+					advertisement.
+			TX_power	The TX power AD data provided in the
+					advertisement. 127 indicates the absence
+					of TX power AD data.
+			ADV_data	The signature of adv_data is a{yv} where
+					“y” is the AD data type value and “v” is
+					the value of the AD data where the type
+					may vary depending on the AD data. For
+					instance, if "y" is 0x16, "v" would be
+					an array of bytes.
+			ADV_raw_data	The raw bytes of AD data from the
+					advertisement packet.
+
+		void DeviceOutOfRange(device object)
+
+			If RSSIThreshholdsAndTimers exists, this gets called
+			when RSSIs of the matched advertisements are lower than
+			LowRSSIThreshold for at least LowRSSIThresholdTimer to
+			notify the client on losing the targeted device.
+			If RSSIThreshholdsAndTimers does not exist, this won’t
+			get called.
+
+Properties	uint8 FilterType [read-only]
+
+			This can be the following values. More will be added.
+			0x01 - Patterns with OR logic relation
+
+		(Int16, Uint16, Int16, Uint16) RSSIThreshholdsAndTimers [read-only, optional]
+
+			The contains HighRSSIThreshold, HighRSSIThresholdTimer,
+			LowRSSIThreshold, LowRSSIThresholdTimer in order. The
+			unit of HighRSSIThreshold and LowRSSIThreshold is dBm.
+			The unit of HighRSSIThresholdTimer and
+			LowRSSIThresholdTimer is second.
+
+			A device is considered in-range when the RSSIs of the
+			received advertisement(s) during HighRSSIThresholdTimer
+			seconds exceed HighRSSIThreshold. Likewise, a device is
+			considered out-of-range when the RSSIs of the received
+			advertisement(s) during LowRSSIThresholdTimer do not
+			reach LowRSSIThreshold.
+
+		array{(uint8, uint8, string)} Patterns [read-only, optional]
+
+			If “PatternsWithORLogicRelation” is supported, this must
+			exist and has at least one entry in the array.
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
+Advertisement Monitor hierarchy
+===============================
+Service		org.bluez
+Interface	org.bluez.AdvertisementMonitor1
+Object path	/org/bluez/{hci0,hci1,...}
+
+Methods		void RegisterApplication(object filter)
+
+			This registers a job of monitoring advertisement in a
+			power efficient way. Based on the content of the filter
+			upon registration, the filter object can expect to
+			receive the matched advertisements via DeviceInRange()
+			and AdvertisementReceived().
+
+		void UnregisterApplication(filter object)
+
+			This unregisters the job of monitoring advertisement.
+			The filter object can expect to be called on Release()
+			once the removal is done.
+
+		void UnregisterAllApplications()
+
+			This unregisters all jobs of monitoring advertisement.
+			All filter objects can expect to be called on Release()
+			once the removals are done.
+
+Properties	array{string} SupportedFilteringFeatures [read-only]
+
+			This reflects the supported features of advertisement
+			monitoring. An application should check this before
+			instantiate an object of org.bluez.AdvertisementFilter1.
+
+			Here are the potential features. More will be added.
+			"SoftwareBasedFiltering"
+			"PatternsWithORLogicRelation"
+			"RSSIMonitoring"
-- 
2.24.1

