Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B893612D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810577; cv=none; b=VGO+J/J1OwNtr8PN4DC4HsaFqWY5H8/QICTK8PHxqO51JHd/x12ZE0PCReXtXvDpn75R4Uckbrp3uZHp2/6DguE6fnveGZ3HBPd2HDsKaGLMid1fG/2GtiysE/2n+bdL+vUbVGi2DJCKe/o8alspDGQ26TkGt/YbO4c1Y9m2uNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810577; c=relaxed/simple;
	bh=y2Wbb3ipm8rzLLvYUDOZAeAirlzBSOGEqufrArfgrsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db4wUSFmy4Nd44Mr70ru/c8lej6UMFlNeRgrDWEwwCabT1qur+uworU4AFM2E+tarvUM/5Krk94Ms+wVsIpDkZpW9HhkQArZTmjQimhOJwK1/oUbe1Tklk1H/n6mSrPAjp0EoPu+u/hbou0AYoXfLzBjPvIUJPCwu3J82mfuqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkgBWy+A; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkgBWy+A"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5f5418ec110so1993824137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810574; x=1770415374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjBwDrHpKTOump2kq3+wHvUqnOQBU2aYcctNfbdN1wA=;
        b=gkgBWy+AJAbZFX8809Tg/rRmcmrW9yLMFFLS+gwZQo2X3kqPAQGQEF+Xpblg2mzG+Q
         K9wo+GLvy7Qn2r0gni36qlHeCo8oA6gJC82e846hfP+RLqfmQ/BC2bpOQZfExQWzhxPC
         b+vIkFQiRSvv1sEupXT+bT6m2JDVHikFudaVmGPoJTytXSvE/Icw93M4hqlZr7tAcy+q
         xs32FUFM2OVKlmG9oTgiYvNu4VjvDp78zjoB7vQDJkaZUWM3PAMyb30EE4CgJUU1ODDW
         ks6EYjdOtVjEaSqhfAOC87oI74iqO2RDrjH0WIIR+qPEjuj4Dtxp0wkAsCaVxcdb5x/e
         MHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810574; x=1770415374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YjBwDrHpKTOump2kq3+wHvUqnOQBU2aYcctNfbdN1wA=;
        b=rVPaKUos/T95PXhA/UcLAnbAQxSwv07eiDsL9KPLKlZNK8oSuqkSqE+q34xbeezWMc
         YQ+j4U/oUyG2RgO1DTsSl4KuI/uZuGYznhZv2i63pDClDqaO0jbch4JdN7HYihLjQb8T
         RkJU04YqNNlQwZOIafLZSWXWs5yASrQ3vSjWPQVPQGKjy051wrWMXo89qubdoXyxg71A
         VEaBTIfIR92c9Eu9zzL5znFwApgzW7Nz+fJ0bIm00TPi92+uHOwSJ0hFN2B2lz1txUdq
         T0OabQBebSHhF/QuQ3DC3PSDXPKqfhKAFAk5te+JMqMlraBsM3qqd/fuPVWCMbGlDWFv
         iqyg==
X-Gm-Message-State: AOJu0YyRHpVMDXlvwq/CTZIBf6WR6iyVejah5SIK40LZ7KqI5eNMk8ea
	RQsADDLRlBwF3vuVK9AdYRXBz+dIxXj9+xpWINjvnSV9DqN3nHSWLtZsgf7RLssK
X-Gm-Gg: AZuq6aJiT/aMwuYLBT/Qyi7mdfanu+/s2JsGAwGVYwrUPauD9HFfXQYfUngyj3G32es
	nGqs0nWDmotk5Yem2nNjxDhsiHQlf03f1jDXYJSzFZezMUnSnKz9KY9bQxpi9PeW2MgnnYkyHWY
	0tiAAADZxfTc6fqGqgipi6fjgzjMBu5mb1Ty5qkC0JLFXY2h0+ZgS8h0a1de4i7QcdUpZ+FksST
	tahb4CGWbH2G6H6jqpvDB3kWY7puKcOj83lYzBEw+y4iAwGn2+qIruAuwtpPVRrsjBYyBzERZOj
	CwzP2mJkc9co31oIMEkXaXwLPZRJoGUkWxojXdVQdo0xi3wTGpu6rT02JMGo+cMDjyoaMI6bbsa
	q5HygB/34fsJkG2a2iu857A83SxTAUmvyY1houU/bEHOQMjfpfrurIV8OX3HOVJJEPOa/0lAHC/
	PbJdqMLXsYDUGUG+AWo+1kGHBtLcof9TvqU3sh6t+5rzN5BHVvzkYK70BHGI5hC3uUHWU9aUGZP
	vy+Sg==
X-Received: by 2002:a05:6102:f06:b0:5f1:c561:8dc7 with SMTP id ada2fe7eead31-5f8e268d3b5mr1550577137.38.1769810574365;
        Fri, 30 Jan 2026 14:02:54 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 11/37] doc/bluetoothctl-monitor: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:02:02 -0500
Message-ID: <20260130220229.1346261-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-monitor.rst | 79 +++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/doc/bluetoothctl-monitor.rst b/doc/bluetoothctl-monitor.rst
index 1e2bfeecc931..25c73655e2e2 100644
--- a/doc/bluetoothctl-monitor.rst
+++ b/doc/bluetoothctl-monitor.rst
@@ -18,6 +18,10 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [monitor.commands]
 
+This submenu configures advertisement monitors using the
+**org.bluez.AdvertisementMonitor(5)** and
+**org.bluez.AdvertisementMonitorManager(5)** interfaces.
+
 Monitor Commands
 ================
 
@@ -27,6 +31,16 @@ set-rssi-threshold
 Set RSSI threshold parameter
 
 :Usage: **> set-rssi-threshold <low_threshold> <high_threshold>**
+:<low_threshold>: Lower RSSI threshold value in dBm for monitoring
+:<high_threshold>: Higher RSSI threshold value in dBm for monitoring
+:Example Set low threshold to -80 dBm and high threshold to -40 dBm:
+	| **> set-rssi-threshold -80 -40**
+:Example Set low threshold to -70 dBm and high threshold to -30 dBm:
+	| **> set-rssi-threshold -70 -30**
+:Example Set very sensitive low threshold and moderate high threshold:
+	| **> set-rssi-threshold -90 -50**
+:Example Set less sensitive thresholds for close range monitoring:
+	| **> set-rssi-threshold -60 -20**
 
 set-rssi-timeout
 ----------------
@@ -34,20 +48,56 @@ set-rssi-timeout
 Set RSSI timeout parameter
 
 :Usage: **> set-rssi-timeout <low_timeout> <high_timeout>**
+:<low_timeout>: Timeout value in seconds for low RSSI threshold
+:<high_timeout>: Timeout value in seconds for high RSSI threshold
+:Example Set low timeout to 5 seconds, high timeout to 10 seconds:
+	| **> set-rssi-timeout 5 10**
+:Example Set quick timeout response for both thresholds:
+	| **> set-rssi-timeout 1 5**
+:Example Set longer timeout periods for stable monitoring:
+	| **> set-rssi-timeout 10 30**
+:Example Set asymmetric timeout values:
+	| **> set-rssi-timeout 3 15**
 
 set-rssi-sampling-period
 -------------------------
 
 Set RSSI sampling period parameter
 
-:Usage: **> set-rssi-timeout <low_timeout> <high_timeout>**
+:Usage: **> set-rssi-sampling-period <sampling_period>**
+:<sampling_period>: Sampling period in 100ms units (0-255, where 0 means report all, 255 means report only first)
+:Example Set sampling period to 100ms (1 unit):
+	| **> set-rssi-sampling-period 1**
+:Example Set sampling period to 500ms (5 units):
+	| **> set-rssi-sampling-period 5**
+:Example Set sampling period to 1 second (10 units):
+	| **> set-rssi-sampling-period 10**
+:Example Report all advertisements (no sampling):
+	| **> set-rssi-sampling-period 0**
+:Example Report only first advertisement:
+	| **> set-rssi-sampling-period 255**
 
 add-or-pattern
 --------------
 
 Register 'or pattern' type monitor with the specified RSSI parameters
 
-:Usage: **> add-or-pattern [patterns=pattern1 pattern2 ...]**
+Each pattern requires 3 arguments: <start_position> <ad_data_type> <content_of_pattern>
+Multiple patterns can be specified to create an OR condition.
+
+:Usage: **> add-or-pattern <start_pos> <ad_type> <content> [start_pos ad_type content ...]**
+:Uses: **org.bluez.AdvertisementMonitorManager(5)** method **RegisterMonitor**
+:<start_pos>: Byte position in advertisement data where pattern matching starts (0-based)
+:<ad_type>: Advertisement data type (e.g., 9 for Complete Local Name, 1 for Flags)
+:<content>: Hexadecimal pattern content to match
+:Example Monitor for "Samsung" in Complete Local Name (type 9):
+	| **> add-or-pattern 0 9 53616d73756e67**
+:Example Monitor for devices with Flags type (type 1) containing 0x06:
+	| **> add-or-pattern 0 1 06**
+:Example Monitor for two different patterns (OR condition):
+	| **> add-or-pattern 0 9 53616d73756e67 0 9 4170706c65**
+:Example Monitor for specific manufacturer data (type 255):
+	| **> add-or-pattern 0 255 4c000215**
 
 get-pattern
 -----------
@@ -55,6 +105,15 @@ get-pattern
 Get advertisement monitor
 
 :Usage: **> get-pattern <monitor-id/all>**
+:<monitor-id/all>: Monitor ID number to retrieve details for, or "all" for all active monitors
+:Example Get details of monitor ID 0:
+	| **> get-pattern 0**
+:Example Get details of monitor ID 1:
+	| **> get-pattern 1**
+:Example Get details of monitor ID 5:
+	| **> get-pattern 5**
+:Example Get details of all active monitors:
+	| **> get-pattern all**
 
 remove-pattern
 --------------
@@ -62,6 +121,16 @@ remove-pattern
 Remove advertisement monitor
 
 :Usage: **> remove-pattern <monitor-id/all>**
+:Uses: **org.bluez.AdvertisementMonitorManager(5)** method **UnregisterMonitor**
+:<monitor-id/all>: Monitor ID number to remove, or "all" to remove all active monitors
+:Example Remove monitor with ID 0:
+	| **> remove-pattern 0**
+:Example Remove monitor with ID 1:
+	| **> remove-pattern 1**
+:Example Remove monitor with ID 3:
+	| **> remove-pattern 3**
+:Example Remove all active advertisement monitors:
+	| **> remove-pattern all**
 
 get-supported-info
 ------------------
@@ -69,6 +138,9 @@ get-supported-info
 Get advertisement manager supported features and supported monitor types
 
 :Usage: **> get-supported-info**
+:Uses: **org.bluez.AdvertisementMonitorManager(5)** properties
+:Example Display supported monitor features and types:
+	| **> get-supported-info**
 
 print-usage
 -----------
@@ -76,6 +148,9 @@ print-usage
 Print the command usage
 
 :Usage: **> print-usage <add-or-pattern>**
+:<add-or-pattern>: Command name to display detailed usage information for
+:Example Show detailed usage for add-or-pattern command:
+	| **> print-usage add-or-pattern**
 
 RESOURCES
 =========
-- 
2.52.0

