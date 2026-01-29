Received: from mail-ua1-f65.google.com (mail-ua1-f65.google.com [209.85.222.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5463451C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728943; cv=none; b=ZfiLwc51dg27Bmv9y9VTVx5YrPEJU/wbFH2CtEIeal6aTqKt6DCDK8VrXLrWeMO0OFFNDwcn6U4gNUs42Ss8uQKLlQjXYjP5WgMmli9jt5KygE1/ICYBw7LvE9vLvZ/QH8RvyMNqniPX3XUlSV/9U1Hp8Uyk/EippLP7/8wO79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728943; c=relaxed/simple;
	bh=eL2tTRoKpKASo3RYgYV2n+NWcTC/UfcS1oYjZpHqX2E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzIz1QQYZhR8VLsgk7sK8N6nXB8PTDs8uJYdlIP/BbeEx34fGFovC96WHbK/Gff3diWaKAG61xR7CD1SSU1/UA4NHDZIRJGz6S0eurWdfAKTyklReQV5TFrpQmfz4uANsxN+QmE5Kz5TiRWadRwvKnm8SvLkjlMv876bvs/1jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcWDn5hC; arc=none smtp.client-ip=209.85.222.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcWDn5hC"
Received: by mail-ua1-f65.google.com with SMTP id a1e0cc1a2514c-944199736ebso453817241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728941; x=1770333741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGMWmD77/hvAqR20pxlvXhzMTdX6RuJZ/qJyhUWTVgo=;
        b=OcWDn5hCeUVlNlycW69+hd6wETtpKxLbgpSkz52H+uys0ARljXaTRvoZhQATJ6gdma
         l+vxUmXeztdwfhNf/c1pA+lUyZqwYZ0BqKSkJfBPIdSaR1Qb6kHyBNzgFe0pECabjUwU
         ih5SxJEeKpJzORZc7TjWJQjrXGAU4XAtIofSgvqyo13buRxbWH96SNoA2UhHjylfZj4u
         wSvdKx+LfPVDDzjCP9yWnSBkZtl2xatemVgHVHmAToUuJpCADBO1ksKsz+fsQu+K6a5W
         Fz8jU3PtIfDh3X7eXYrlWHx7Gf5yX5nlL2hyjoAzIWaifW4DB/Chb9yNsQqcDzvinH+N
         g9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728941; x=1770333741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGMWmD77/hvAqR20pxlvXhzMTdX6RuJZ/qJyhUWTVgo=;
        b=AJRCYAkpFN7ccDQ5oVqNpIOu21rq3qIus7v7N1M52Vn5vgH6FI3raYDbu1i4lEtzsT
         1J44kIyIScVjJnrXwZHmcAXqoendn7OmCgxkMZ5o6qyE2n+MZJWNig1mdhQVQTf//vzC
         Jr4kHT5xsJaoIpLVaL99fTVjqugVWOvpWWNrYf3LxPjmnu7m3jIT55wIBtL3ba8XnE23
         TIg/iQ8T7qpxq8+grwqHT9ZLWSbfZfmkYkGQ/Fz2fXF1cLDSfMmNwG5GqzWoHKFcd3WW
         Wud2+RD8k77KffloSPd1kM1XTmvBLHah1grQYfZ/7/MYSLS75yCI05Kx6QvdNjtevkVQ
         EHpg==
X-Gm-Message-State: AOJu0YwqXu9vY4T3TT8J0XzfRWISO4AxlY6i0xA5rmufPm224C91zRDx
	SkuM/Zy4YXo9pgTe5DQG3YCOH58KNXMfk+eAsni2sQI2jizWvgulbJVeHo/KoKPk05A=
X-Gm-Gg: AZuq6aL+XaOFkWPht++kHmhJkrdeNx+jLpUtVILL9p9/RHYEfDYqjUyjN2br2ZyvqNJ
	WJB3OVQ15cDw6aE965UHP18W4Y7QBQQVQ2sJGu2/zUUErY4E5+S+iI9d9JjeMWuoTkHoz0uuC/3
	onBMJRHkbjznMlwDA7GE5e0OxFFoU8AsGWBpQ975q3EFpdIQyORg+uOX+VhO70zePi0MmUqWxYX
	vkKT+GNA0CalP9sIC4I8uY2fns23aQ8TPWkmCu4BqnsS7MrVeOuVxwRtjVvO1uIUCKmwZ1nQDFF
	97Rt99/07Y24LunxLu23yonwlh5nulj8QcqNTBgXtnkHGdx17xeuTejmhJrqqKSCvMLUVB0UAg+
	9/bxYPvaP7UuwsBQnrDaQzISEKf1rPiMFg7/jfAE+N7WWCsy1TLPnNRF4j0FXIfVfonj7zbilNP
	yPDkdiRvEknm6RlNrMPMM6ewPK61Y/px70O/fxBq9Qn8E0AKxZn59F0+pJZJ7mFeHVgqDiQCAxY
	J8Beg==
X-Received: by 2002:a05:6102:3f09:b0:5f5:37f6:2b33 with SMTP id ada2fe7eead31-5f8e24a529dmr314727137.13.1769728940580;
        Thu, 29 Jan 2026 15:22:20 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/15] doc/bluetoothctl-endpoint: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:46 -0500
Message-ID: <20260129232201.1049568-7-luiz.dentz@gmail.com>
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

Add comprehensive parameter documentation for all endpoint commands
including list, show, register, unregister, config and presets.
Documents UUID, codec, capabilities and preset parameters for
Bluetooth audio endpoint management.
---
 doc/bluetoothctl-endpoint.rst | 210 ++++++++++++++++++++++------------
 1 file changed, 138 insertions(+), 72 deletions(-)

diff --git a/doc/bluetoothctl-endpoint.rst b/doc/bluetoothctl-endpoint.rst
index b7ecd96244b7..6b0a5fb6d6db 100644
--- a/doc/bluetoothctl-endpoint.rst
+++ b/doc/bluetoothctl-endpoint.rst
@@ -27,6 +27,11 @@ list
 List available endpoints.
 
 :Usage: **> list [local]**
+:[local]: Only show locally registered endpoints (optional, shows all if omitted)
+:Example List all available endpoints (local and remote):
+	| **> list**
+:Example List only locally registered endpoints:
+	| **> list local**
 
 show
 ----
@@ -34,6 +39,15 @@ show
 Endpoint information.
 
 :Usage: **> show [endpoint]**
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
@@ -41,37 +55,40 @@ register
 Register Endpoint.
 
 :Usage: **> register <UUID> <codec[:company]> [capabilities...]**
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
 
@@ -86,6 +103,23 @@ unregister
 Unregister Endpoint.
 
 :Usage: **> unregister <UUID/object>**
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
 
@@ -98,6 +132,15 @@ config
 Configure Endpoint.
 
 :Usage: **> config <endpoint> <local endpoint> [preset]**
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
 
@@ -110,55 +153,78 @@ presets
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

