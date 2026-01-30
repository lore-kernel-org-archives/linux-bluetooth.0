Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC72FE566
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801985; cv=none; b=JNdmrtRIaozSTFu3HDZ64yVI6c5x7ooq9ajrd9VGFza+374RKH/Ps22ehO4qRhHVvIQv6U4Le7b7Icy3lWmYGSrAIMKBm4Xx5apCrVPpJi3cKBcBly6L0oi/4nUvkn2HNlJ4soYUyDibbmImZ4y5R9QkS1tkQHVWUb160CiulCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801985; c=relaxed/simple;
	bh=y2Wbb3ipm8rzLLvYUDOZAeAirlzBSOGEqufrArfgrsI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGR3PzjzRcHNizBnzwEs2qI9xdVjk0oIQ2NKBznJ+oyJ0Vx5d0SiX00r52gS/GKZmdUm0Oq0RW+H+7xcJ7x8CSHMbQ3u0Imyf6LVkXL3p3hR9G0NJRkxx85hf8xqAtO0ddLToxLCr1pmvjqm2SipG62rWgwdCUv3nExqA6rJad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuSbkGKQ; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuSbkGKQ"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-566390e7db3so1920953e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801982; x=1770406782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjBwDrHpKTOump2kq3+wHvUqnOQBU2aYcctNfbdN1wA=;
        b=IuSbkGKQV8C0BP4JP1/YWniKST8ANDyDtV5tqZXFi5+8VqFo+Ib3f6+RckMyqz4uys
         EXm7kzYjJfhetgs8dQnC8Rri+2J/AyDCsNda3ul053kAF9stCNwNBgKLG+m2yTnRh9Ic
         hjKfIIwrQsGgqPExkiw8268RBD+Slfqk6B3qILTdqv+0ZckxtrPLIuKzUPTXdek8hK1Q
         aJ4DhIysFW8hKitXS65EZ09+9DOV67M4K3Gf3tMYU7vr8VKdjTB3Zxdd8REN0DBssfOj
         JnQ8BWUcRfTT/AbafzcvGIrvPw9JfwJZirWoIrizPhkdKeZ3Lo3EkhtD5gQhnu9gv1MO
         At+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801982; x=1770406782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YjBwDrHpKTOump2kq3+wHvUqnOQBU2aYcctNfbdN1wA=;
        b=C6T5NuardB7+Io9p5+aS/9Eh0FekSPBS0ZgXH3VqNifEwhRRvz8zZd+l2HvJA3SEBn
         yDCX9ZFGLOphqNYX2B8838d3hUm/i8gYkkZqjWhIjGRMRhFOW0JoVK+LeXEqWXol9rNj
         EOtfaMfvO21yyxoHW7JeIQ3xJaEWXBa5PZjYvLORMjusBdnzop2O6NAwLyCTDLAGBNPn
         8Zi/Kow6vUVwe7VGekJHy+TZ4FHeO9wQFMX9jmrT9s2XPhtdp/4C4m0VxZX4fNydcvoW
         6PypS5JLNMpG4LI13lrQIIT/RuDubrvjT4jotBfQ2yWE02ZtgZCcGkZ77FjmQEGbbESM
         Relg==
X-Gm-Message-State: AOJu0YzdQK26yKT8HZRU+0v8ZPNhS7pa996qXdkK2F9UqqW7dpfoUOz5
	iBkgx8rtGitMvOVfOmRTBoPc7ZsyCYeZPJWL3a+MlKDj6vXNognqQHYTXnFj/AAy
X-Gm-Gg: AZuq6aJa7qww1cQpAfuZMnSZf7BODcdxqYLt7T6pqyA/YRjgdllOWtXYaCdQsh5lB+Y
	rGk7uPm9ejAORuPFzzhlWhnljcYwSilpoB9nMOV+nphUE2AiUmIMEHhqS3S+wbCwCgo988RU/2T
	HNC+/bU1ifMIHEciMk+6FJyNmLxqn0dDuaxr96mSXxRMfWmSueFKn9gGgGv50xHcdRHLzsnr0iz
	SkwxhiWZdPOhvzyeTpswWY5fOOuyVMEEmCCRHQTJbsyA/EAqRW5huPRzGkteiFq2ISDGlZuxNJL
	9d0SYo7ybAvq8S0fO8e6+WfaU44DUm9M3U8esM9jBKnvbeGmRwcvusd8kMhHd0JBHGEHEMX0lBj
	atvRz6A3YFkv+Zs/74Da7l5hXxqYUYfwo+71hzY3A5fqQN6NkNX7D3QbVAUpdLif32ieJVtAf5b
	80EHll0zEArbcMd64x3Hl7UVO4cmViVmDHJ1O4vTtMLreSQyiWYrvv2yNbZGQkknpHkiQHh9lrp
	2j54w==
X-Received: by 2002:a05:6122:8c21:b0:566:3c22:c13c with SMTP id 71dfb90a1353d-5669ffe8281mr1451391e0c.3.1769801981760;
        Fri, 30 Jan 2026 11:39:41 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 11/35] doc/bluetoothctl-monitor: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:53 -0500
Message-ID: <20260130193921.1273263-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
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

