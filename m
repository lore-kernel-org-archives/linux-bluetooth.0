Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32E3016E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801981; cv=none; b=BPIhyXTJxdJ70z64+t2ZQqG3wGlZ7O54/0GdDzwJBWsVNFrtzSw9PeCuen4rXKzl8ICR/GLwQbct5r0r1Wg88rqCqofKc3VLHgKxC6AvAtD7qT6MSqxDVi+MjHqCV0lDUSuVyVVExgruzj4xTU/O92XqAk41XrL7musEqulduVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801981; c=relaxed/simple;
	bh=bEel7GG3FINQpPszrDgwa96RKYIsXmrogbWVjbDnTH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlnQrJK2wdygP4OeIrd54fWKnH79Gd90DCd6HfQi2HDp33f+aeirArL4NdeWvLGGgxS4QV2omOucWcpwU/X2oStmxDPtCAy9Zii49zygjurZ1J/66CN38rY/lxWWNrPdFcEOKMv7YBq+3BuuQm3ogTh76JPRZ8v1S+ZZmWMX0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEMo4biD; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEMo4biD"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-56367a388e5so726372e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801978; x=1770406778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYiCAkSmDkUDT3RT8wBl29YPj2K1XoHlz/YFLXH/IfM=;
        b=nEMo4biDOy7ByVWRspYTOlEuQnuXWFkAdKK7eSM/fv20v7Hq+7rd3SbCFESa4oQKPy
         UztED1fK+osfUzQqKU32RAfQ6v1yiA1PKhgE923WktqGRvHBr3XOlYuTb0t4MXtbfXMp
         fygEfuLpsEHQMCQPKnjM2G/77jckZ+8K3JCf+vrQAlyIrKDo1T9AYUJ77aQ1aku6Dxj6
         qvITnPxaZ4vGrmckE3Hy8Grly/NcduNF3qRdrOOUwwIBbWFGMdT8fravVwjT7YPdCKbz
         4doHqtgCcFxv/SlDdyQczusiT8fNt4aB+lHaXTMK7SF63a9gwxY6APmkiZowTpdJG+lg
         SwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801978; x=1770406778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYiCAkSmDkUDT3RT8wBl29YPj2K1XoHlz/YFLXH/IfM=;
        b=N5JDpI9gmTJYk/5GwXBW96iU8ggjLdU8PMBz6xknfSs1phUGwJ4wwR6Hfh+tGnzDr0
         NE4QpEtNJVZAr89+EbFretcxNlvkrXLUcOVj4t2l4/911T7+TQ9vJwzMfhqQi9oweZZj
         ail1GxxyeSNuWPiT4S3BMFbu68RKqX74yC4bOYmh0X7PxvLL27r7J5zVXRdJqKnYMOou
         Xpgbuz2PftsQqf1HbJDklOHeO1zCr99pW+bCQW/6bISIcQNj4HcDna57/UmCeEDnHSc4
         NRDnufK/wxN4yCLEXAKpEOtZM6im+/8XpEFHcJlFnYGJ5F9nonvkUt+tEQ+wISejZfI7
         KTqg==
X-Gm-Message-State: AOJu0YzpVF0wSqa4YBB+pBXz+Qa38SY/miF/1QSdeUONxBHGRdenssZN
	/qCun/O0dQC2KUWQaY4b/fNYk7ZbNaF83Yf+8YwEdiRMR3KN1z/DDuipAzxPRUHc
X-Gm-Gg: AZuq6aIq8KZPCT55VtMjvYOldBYSnP4aGga2EqsvCacceX56Y9gm45fSDolE6nzfhqe
	G8wbzcXen+IR7lxduwPV0elHr01eHu1K2OgKdpL9YstHcoa6XGkboTeT7XqgqC1elD+rgcoUlvJ
	q98TV/ZnL9txs5LbRyYH2QyplIFrM8m/2Xcuyivpfsk6yoLh2cEPwbDf7suwLyIvEvDCKem1KCm
	BgWqKoVPxRzEqW6NSkmGwHE2jT4FJLkPh/wTGZn+fdaS+v67OfXvKIJP8XzfOkwKp9BiZ1ZQHDL
	dTvf3EKtd2gHRBrpMM5b3Rqb7cjVjO10ZTizSbPbgOZszO/I6ZmOYGJPqqWGPRwAO3EJOOG4fnE
	q5ukN8ZEEr38x6jhJKKWUQt7ekftiyg7+5bljhihw459XVq1lzIv0iEibbPcJxKq7kOOfIdZv1j
	euYqnRlo+FRU4Z9DaNE0x/tp8HEp/hgK9h4lkmiQ9j8yN1ahoOowbpHrqh91wnepQWejJY29Su7
	JO5EQ==
X-Received: by 2002:a05:6122:f89:b0:55b:1aa5:bf88 with SMTP id 71dfb90a1353d-566a0034a6dmr1036129e0c.7.1769801977686;
        Fri, 30 Jan 2026 11:39:37 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/35] doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:49 -0500
Message-ID: <20260130193921.1273263-8-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-endpoint.rst | 217 +++++++++++++++++++++++-----------
 1 file changed, 145 insertions(+), 72 deletions(-)

diff --git a/doc/bluetoothctl-endpoint.rst b/doc/bluetoothctl-endpoint.rst
index b7ecd96244b7..019e64e38452 100644
--- a/doc/bluetoothctl-endpoint.rst
+++ b/doc/bluetoothctl-endpoint.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [endpoint.commands]
 
+This submenu manages media endpoints for audio streaming using the
+**org.bluez.MediaEndpoint(5)** and **org.bluez.Media(5)** interfaces.
+
 Endpoint Commands
 =================
 
@@ -27,6 +30,11 @@ list
 List available endpoints.
 
 :Usage: **> list [local]**
+:[local]: Only show locally registered endpoints (optional, shows all if omitted)
+:Example List all available endpoints (local and remote):
+	| **> list**
+:Example List only locally registered endpoints:
+	| **> list local**
 
 show
 ----
@@ -34,6 +42,16 @@ show
 Endpoint information.
 
 :Usage: **> show [endpoint]**
+:Uses: **org.bluez.MediaEndpoint(5)** properties
+:[endpoint]: Path to specific endpoint to display (optional, shows current selection if omitted)
+:Example Show information for currently selected endpoint:
+	| **> show**
+:Example Show local endpoint information:
+	| **> show /local/endpoint/ep0**
+:Example Show remote endpoint information:
+	| **> show /org/bluez/hci0/dev_00_11_22_33_44_55/ep1**
+:Example Show another local endpoint:
+	| **> show /local/endpoint/ep1**
 
 register
 --------
@@ -41,37 +59,41 @@ register
 Register Endpoint.
 
 :Usage: **> register <UUID> <codec[:company]> [capabilities...]**
+:Uses: **org.bluez.Media(5)** method **RegisterEndpoint**
+:<UUID>: Bluetooth service UUID for the endpoint type (required)
+:<codec[:company]>: Codec ID in hex format, optionally with company ID (required)
+:[capabilities...]: Optional codec-specific capability data in hex format
 :Example LC3 BAP source:
-	 | **>endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06**
-	 | **>Auto Accept (yes/no):** y
-	 | **>Max Transports (auto/value):** a
-	 | **>Locations:** a
-	 | **>Supported Context (value):** 3
-	 | **>Context (value):** 3
-	 | **>CIG (auto/value):** a
-	 | **>CIS (auto/value):** a
+	| **>endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06**
+	| **>Auto Accept (yes/no):** y
+	| **>Max Transports (auto/value):** a
+	| **>Locations:** a
+	| **>Supported Context (value):** 3
+	| **>Context (value):** 3
+	| **>CIG (auto/value):** a
+	| **>CIS (auto/value):** a
 :Example LC3 BAP sink with extra capabilities:
-	 | **>endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06 "0x03 0xe5 0x03 0x00 0x02 0xe6 0x07"**
-	 | **>Enter Metadata (value/no):** n
-	 | **>Auto Accept (yes/no):** y
-	 | **>Max Transports (auto/value):** a
-	 | **>Locations:** a
-	 | **>Supported Context (value):** 3
-	 | **>Context (value):** 3
-	 | **>CIG (auto/value):** a
-	 | **>CIS (auto/value):** a
+	| **>endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06 "0x03 0xe5 0x03 0x00 0x02 0xe6 0x07"**
+	| **>Enter Metadata (value/no):** n
+	| **>Auto Accept (yes/no):** y
+	| **>Max Transports (auto/value):** a
+	| **>Locations:** a
+	| **>Supported Context (value):** 3
+	| **>Context (value):** 3
+	| **>CIG (auto/value):** a
+	| **>CIS (auto/value):** a
 :Example LC3 BAP Broadcast source:
-	 | **>endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06**
-	 | **>Auto Accept (yes/no):** y
-	 | **>Max Transports (auto/value):** a
-	 | **>Locations:** 3
-	 | **>Supported Context (value):** 1
+	| **>endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06**
+	| **>Auto Accept (yes/no):** y
+	| **>Max Transports (auto/value):** a
+	| **>Locations:** 3
+	| **>Supported Context (value):** 1
 :Example LC3 BAP Broadcast sink:
-	 | **>endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06**
-	 | **>Auto Accept (yes/no):** y
-	 | **>Max Transports (auto/value):** a
-	 | **>Locations:** 3
-	 | **>Supported Context (value):** 1
+	| **>endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06**
+	| **>Auto Accept (yes/no):** y
+	| **>Max Transports (auto/value):** a
+	| **>Locations:** 3
+	| **>Supported Context (value):** 1
 
 Note:
 
@@ -86,6 +108,24 @@ unregister
 Unregister Endpoint.
 
 :Usage: **> unregister <UUID/object>**
+:Uses: **org.bluez.Media(5)** method **UnregisterEndpoint**
+:<UUID/object>: Either the service UUID or the object path of the endpoint to unregister
+:Example Unregister LC3 source endpoint by UUID:
+	| **> unregister 00002bcb-0000-1000-8000-00805f9b34fb**
+:Example Unregister LC3 sink endpoint by UUID:
+	| **> unregister 00002bc9-0000-1000-8000-00805f9b34fb**
+:Example Unregister broadcast source endpoint by UUID:
+	| **> unregister 00001852-0000-1000-8000-00805f9b34fb**
+:Example Unregister broadcast sink endpoint by UUID:
+	| **> unregister 00001851-0000-1000-8000-00805f9b34fb**
+:Example Unregister endpoint by object path:
+	| **> unregister /local/endpoint/ep0**
+:Example Unregister another endpoint by object path:
+	| **> unregister /local/endpoint/ep1**
+:Example Unregister source endpoint by path:
+	| **> unregister /local/endpoint/source0**
+:Example Unregister sink endpoint by path:
+	| **> unregister /local/endpoint/sink0**
 
 Note:
 
@@ -98,6 +138,16 @@ config
 Configure Endpoint.
 
 :Usage: **> config <endpoint> <local endpoint> [preset]**
+:Uses: **org.bluez.MediaEndpoint(5)** method **SetConfiguration**
+:<endpoint>: Path to the remote endpoint to configure
+:<local endpoint>: Path to the local endpoint to use for the configuration
+:[preset]: Audio quality preset name (optional, auto-detected if omitted)
+:Example Configure remote endpoint with local endpoint (auto preset):
+	| **> config /org/bluez/hci0/dev_00_11_22_33_44_55/ep0 /local/endpoint/ep0**
+:Example Configure LE Audio Unicast with BAP setting 32_1_1:
+	| **> config /org/bluez/hci0/dev_00_11_22_33_44_55/ep0 /local/endpoint/ep0 32_1_1**
+:Example Configure LE Audio Broadcast Source:
+	| **> config /org/bluez/hci0/dev_00_11_22_33_44_55/bis0 /local/endpoint/broadcast0**
 
 Note:
 
@@ -110,55 +160,78 @@ presets
 List available presets.
 
 :Usage: **> presets <endpoint>/<UUID> [codec[:company]] [preset] [codec config] [metadata]**
+:<endpoint>/<UUID>: Either endpoint path or service UUID to work with presets
+:[codec[:company]]: Codec ID with optional company identifier
+:[preset]: Preset name to display details or create custom preset
+:[codec config]: Custom codec configuration data in hex format
+:[metadata]: Additional metadata for the preset
 :Example using endpoint:
-	  | **>presets /local/endpoint/ep0 32_1_1**
-	  | **>presets /local/endpoint/ep0**
-	  | Preset 32_1_1
-	  | Configuration.**>0: len 0x02 type 0x01
-          | Configuration.Sampling Frequency: 32 Khz (0x06)
-          | Configuration.**>1: len 0x02 type 0x02
-          | Configuration.Frame Duration: 7.5 ms (0x00)
-          | Configuration.**>2: len 0x03 type 0x04
-          | Configuration.Frame Length: 60 (0x003c)
+	| **>presets /local/endpoint/ep0 32_1_1**
+	| **>presets /local/endpoint/ep0**
+	| Preset 32_1_1
+	| Configuration.**>0: len 0x02 type 0x01
+	| Configuration.Sampling Frequency: 32 Khz (0x06)
+	| Configuration.**>1: len 0x02 type 0x02
+	| Configuration.Frame Duration: 7.5 ms (0x00)
+	| Configuration.**>2: len 0x03 type 0x04
+	| Configuration.Frame Length: 60 (0x003c)
+:Example List all available presets for local endpoint:
+	| **>presets /local/endpoint/ep0**
+:Example List all presets for another endpoint:
+	| **>presets /local/endpoint/ep1**
 :Example using UUID:
-	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 32_1_1**
-	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
-	  | ...
-	  | ***32_1_1**
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 32_1_1**
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	| ...
+	| ***32_1_1**
+:Example List all LC3 sink presets:
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+:Example List all LC3 source presets:
+	| **>presets 00002bcb-0000-1000-8000-00805f9b34fb 0x06**
+:Example List all broadcast source presets:
+	| **>presets 00001852-0000-1000-8000-00805f9b34fb 0x06**
+:Example List all broadcast sink presets:
+	| **>presets 00001851-0000-1000-8000-00805f9b34fb 0x06**
+:Example Show details for 48kHz stereo preset:
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 48_2_1**
+:Example Show details for 24kHz mono high-quality preset:
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 24_1_2**
+:Example Show details for 16kHz mono preset:
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 16_1_1**
 :Example setting up LC3 custom preset:
-	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom**
-	  | **>[Codec] Enter frequency (Khz):** 48
-	  | **>[Codec] Enter frame duration (ms):** 10
-	  | **>[Codec] Enter channel allocation:** 3
-	  | **>[Codec] Enter frame length:** 100
-	  | **>[QoS] Enter Target Latency (Low, Balance, High):** Low
-	  | **>[QoS] Enter SDU Interval (us):** 1000
-	  | **>[QoS] Enter Framing (Unframed, Framed):** Unframed
-	  | **>[QoS] Enter PHY (1M, 2M):** 2M
-	  | **>[QoS] Enter Max SDU:** 200
-	  | **>[QoS] Enter RTN:** 3
-	  | **>[QoS] Enter Max Transport Latency (ms):** 10
-	  | **>[QoS] Enter Presentation Delay (us):** 20000
-	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
-	  | ...
-	  | ***custom**
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom**
+	| **>[Codec] Enter frequency (Khz):** 48
+	| **>[Codec] Enter frame duration (ms):** 10
+	| **>[Codec] Enter channel allocation:** 3
+	| **>[Codec] Enter frame length:** 100
+	| **>[QoS] Enter Target Latency (Low, Balance, High):** Low
+	| **>[QoS] Enter SDU Interval (us):** 1000
+	| **>[QoS] Enter Framing (Unframed, Framed):** Unframed
+	| **>[QoS] Enter PHY (1M, 2M):** 2M
+	| **>[QoS] Enter Max SDU:** 200
+	| **>[QoS] Enter RTN:** 3
+	| **>[QoS] Enter Max Transport Latency (ms):** 10
+	| **>[QoS] Enter Presentation Delay (us):** 20000
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	| ...
+	| ***custom**
 :Example setting up LC3 custom preset with extra configuration:
-	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom "0x03 0xe8 0x00 0x00 0x02 0xe9 0x00"**
-	  | **>[Codec] Enter frequency (Khz):** 48
-	  | **>[Codec] Enter frame duration (ms):** 10
-	  | **>[Codec] Enter channel allocation:** 3
-	  | **>[Codec] Enter frame length:** 100
-	  | **>[QoS] Enter Target Latency (Low, Balance, High):** Low
-	  | **>[QoS] Enter SDU Interval (us):** 1000
-	  | **>[QoS] Enter Framing (Unframed, Framed):** Unframed
-	  | **>[QoS] Enter PHY (1M, 2M):** 2M
-	  | **>[QoS] Enter Max SDU:** 200
-	  | **>[QoS] Enter RTN:** 3
-	  | **>[QoS] Enter Max Transport Latency (ms):** 10
-	  | **>[QoS] Enter Presentation Delay (us):** 20000
-	  | **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
-	  | ...
-	  | ***custom**
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom "0x03 0xe8 0x00 0x00 0x02 0xe9 0x00"**
+	| **>[Codec] Enter frequency (Khz):** 48
+	| **>[Codec] Enter frame duration (ms):** 10
+	| **>[Codec] Enter channel allocation:** 3
+	| **>[Codec] Enter frame length:** 100
+	| **>[QoS] Enter Target Latency (Low, Balance, High):** Low
+	| **>[QoS] Enter SDU Interval (us):** 1000
+	| **>[QoS] Enter Framing (Unframed, Framed):** Unframed
+	| **>[QoS] Enter PHY (1M, 2M):** 2M
+	| **>[QoS] Enter Max SDU:** 200
+	| **>[QoS] Enter RTN:** 3
+	| **>[QoS] Enter Max Transport Latency (ms):** 10
+	| **>[QoS] Enter Presentation Delay (us):** 20000
+	| **>presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	| ...
+	| ***custom**
 
 RESOURCES
 =========
-- 
2.52.0

