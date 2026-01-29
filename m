Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com [209.85.217.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33813446C0
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728950; cv=none; b=FubCeq+ndQZ/oGHKtxfRXgKEOM8nbfXXHv7/cRBoIJZyDgdluz7JeP3dg22YzQUvprMUXCkoVwuGHU+7TOpylgUOzH/W+I46+Y83hBLN7eRoujA/OcZXw0zFj1+jIUlzkW00q0A0NXGM2Kfa6xHgiOgGLBn1vMrzC4vVViWbE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728950; c=relaxed/simple;
	bh=0MGkyIs7NvJt3RpL2e4qVN8DaJMm3s0B8GIgUjaQgyM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psazKGIMOz7ppZYfII7dHnQ2y2fbcInm9p/tNpuWhuUQhE57NkXRzxRaMUsh2XGtwXhoJ5dOH84eOs21/J4YX/D3NiNEr/3FZIp7Ut2U19xWfKjY4TWYUSDEx2ac1hxsasajR0hN1tFYr87ez6VhCzaVSnt1cdzg5SxD9bRSuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYJqZLrW; arc=none smtp.client-ip=209.85.217.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYJqZLrW"
Received: by mail-vs1-f67.google.com with SMTP id ada2fe7eead31-5f54d6b4047so995783137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728947; x=1770333747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iDksbITcu3MV8MiNOiu6dcMz2o3OsxIEJLww01wtOQ=;
        b=IYJqZLrW/lJuMgHuSOPp1WW3nGi1cKoEwxqIE+hQD2aU7N9shjGOCRVMLU4UBbdfsX
         sOnyWgSN0GUsqzXPR3Hn42jcnG4YPWh5p6CzVoYEnkOfDEG7veR1rcU5s5amvn3wGSZ5
         YW9wWT1It9GnvzVdKceM97yX3r+gF/WlLoU5AlYahIF8zU2fhOBitJLP6ntMTBETf30G
         TViUB5h9dGQRVte+M2lWuCeRYYwJMR8avyVKH9f/FHqWXxGlkWEA9W9zL3079Qj+PPwS
         ZOsusN6OKUjvsJsbAZHBkoCb25VMEk0lWZzpmDg/KFa9urB3+3XILzLmbLkCAi2+0ibI
         TdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728947; x=1770333747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5iDksbITcu3MV8MiNOiu6dcMz2o3OsxIEJLww01wtOQ=;
        b=Kg3d1wwWuYpZpKe1XJufZjD3L94v+qyfv5LMgrfGixNrPpxRAR+ngjliMjz7ArbrBZ
         YJHy7DqLLFeHEtn+tTXFCi/BfJFMI+MdHI2RS14e6WyBMpyAqa26PfWHOY3G83tzPlDO
         XniMbNmjyyaYjeBy/nne/LRYQkFc4MCho5I+ma1XxFsljwWrvyQmdjcL5b2ZDeVE0nBL
         C6D2r83YVN2rUMoU0Zdkhkb0UlSDsRBLKFb4gHtO1tBz089AXa09Aq2iSob+c9X+Dlla
         pwvJUja9iIS9hn2hxMjXSiLpnns/J0g8sSV/oMoOlDSAK1JE/iD9UKhMVpKI0aIgAcry
         WnLw==
X-Gm-Message-State: AOJu0YxsxGehQXQM1tW8ksoOMx4t/L+zk8ulYUnajrzDySgwtr2YsOLD
	IxmA/jvYXvjHumwhAYXg4ZXQ/3EUORwmlAX8tFZPTrfKahqAapGNYXaUJP7zspGealI=
X-Gm-Gg: AZuq6aIpVSqOrk9NDSFuTQ9984CXjHyhzkNy1QmW1OaoPrMZ/tRDHZ7H4nsQ9mJNkiD
	haP3Rys6NFy9NMCgU4SpIsvXQXJlhuBnIEHefNEijohbOj+epfzZblffPlG+PoXzeIuziPtB20M
	aLbpvxW63wlZYF4ECE0LdejG+nSD64cVCf6rlP03vUF6PrefiZxzerGhqVXSjkf1FheZOiFRgd5
	NUc8BuOMDkLqcKBloP2ery+DGOiyl4Iv7A0w63UhcqNFyPXX7DmN0ZT3ABybyF+4R32ileRseO2
	+v444yWx2Ohmu9eW2rgaqpz7pLVO3bB/pq+EifUSkiqqQgywWIwVoDjoUO5OtR1B8ZpnYkwpFkP
	X5B+O3ktIbytyjOL9oPJ+riys8eUnIIUte/uLJMeyXCoqHd+KsDUQtijwuICZ1CSzIxwHSelV6a
	O+nL2B/JOAuM5oGsTO4/nI2VZTSFGh8IF/bOhN9nglS7HyL+71J2/7cAeuNFBbPfRlB3k4Jt3e2
	dZRGQ==
X-Received: by 2002:a05:6102:c48:b0:5df:b57a:ad28 with SMTP id ada2fe7eead31-5f8e23e7d45mr387065137.6.1769728947382;
        Thu, 29 Jan 2026 15:22:27 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 11/15] doc/bluetoothctl-monitor: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:50 -0500
Message-ID: <20260129232201.1049568-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add parameter documentation for all monitor commands including RSSI
threshold, timeout and sampling period settings. Documents pattern
management, monitor ID parameters and threshold values for
advertisement monitoring.
---
 doc/bluetoothctl-monitor.rst | 72 +++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/doc/bluetoothctl-monitor.rst b/doc/bluetoothctl-monitor.rst
index 1e2bfeecc931..51552f1b2011 100644
--- a/doc/bluetoothctl-monitor.rst
+++ b/doc/bluetoothctl-monitor.rst
@@ -27,6 +27,16 @@ set-rssi-threshold
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
@@ -34,20 +44,55 @@ set-rssi-timeout
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
@@ -55,6 +100,15 @@ get-pattern
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
@@ -62,6 +116,15 @@ remove-pattern
 Remove advertisement monitor
 
 :Usage: **> remove-pattern <monitor-id/all>**
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
@@ -69,6 +132,8 @@ get-supported-info
 Get advertisement manager supported features and supported monitor types
 
 :Usage: **> get-supported-info**
+:Example Display supported monitor features and types:
+	| **> get-supported-info**
 
 print-usage
 -----------
@@ -76,6 +141,9 @@ print-usage
 Print the command usage
 
 :Usage: **> print-usage <add-or-pattern>**
+:<add-or-pattern>: Command name to display detailed usage information for
+:Example Show detailed usage for add-or-pattern command:
+	| **> print-usage add-or-pattern**
 
 RESOURCES
 =========
-- 
2.52.0

