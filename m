Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8753859EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810572; cv=none; b=CN0XWwt3mcMvdXR9FVcYSmNo31VGfd8v2sarn6WuZLZLCB0wFRt2fYaN/qHjYLA3HuNM57IAvmourDfK2/RyQXdI5yLVF6+XURrytV0cSe2S/O4ZmiOshCP9EH2GvogDnVQyMwpuhY9k3e83lF+hppR1zOLq2nOuLs09qXB9XEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810572; c=relaxed/simple;
	bh=bEel7GG3FINQpPszrDgwa96RKYIsXmrogbWVjbDnTH8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJF0BYyH1taXv+VqbC61MRd+7aS9iQdXBUC6HeNcMgUQk/SqBkLvOVRtnFsQJzAxcn8fdBE2TsmRTc3U+qGTfHhEwp7MfxK03vB9f3bekMQtpyWIufu0CG34uodsq31I8DoW3oIdFOGDdU3TfT2Pkbf2wiB+TgfbrCjiQnNsJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWpSIkpZ; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWpSIkpZ"
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-56635de8acfso826187e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810569; x=1770415369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYiCAkSmDkUDT3RT8wBl29YPj2K1XoHlz/YFLXH/IfM=;
        b=hWpSIkpZTtc96FCjZokEaG/riMQxfjlnfnR//nTKKCqqy/BNh/GLPzDZ9gsf8Bm8vV
         wnT9bLdlh//jhGRmb6Rbf3jJEqLVtKiOk/6MoLM81tSMm8MkdTUhs717dOF4v4HUvCcx
         sj0Ubget3b0jNF20KZ4yrUor6LIYCj1FIHhhacZjWbb7OFW61j3KXMXTcdJkEIgLfSg7
         DJ7dRm0lxT9d5FHuIXVXfcuGMwEDuFSsQFwRUZiBE/6nrEh2OmammYBxcbRuCjKZ2eOp
         ueIXKfu8XhGqxkIEK1z604LQx4qfxRNwe8UBRGJt/Tg2HTAMWndpPjt/t9ZrFZTOGPcT
         b1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810569; x=1770415369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eYiCAkSmDkUDT3RT8wBl29YPj2K1XoHlz/YFLXH/IfM=;
        b=KSgq9J3qLpqXnKxZJJDvtHe67vVaU72llM2JMBgPmaU/orqMfp2L7j96GQbNbHdfxU
         eaojlU39B3Hb7ctyNIiEk8ii8HjlagFkN9gJZybwyioP+Hg0iS0HGgea+jSkQO08rByA
         Ad3G+Z5qXBIFtEJ+bCB7M8qoNHlkArL6AmB4sHGWVPUiA9eYaBf+TRWl/6HKVI8uSLGJ
         QDSThSTjTSdRrOpOpYzu4/PlbsZI9sjdiKG/lp3OOQimpHH7O5go8cyScebyUAdu+o8D
         QYntA9it8KVJ+vDUHyr5DukfTaqhKyEJuIXKgrEMQ9BobvaNUOsxtfuiRxuCgpaShntX
         bUIA==
X-Gm-Message-State: AOJu0Yz2rzJ3E6cKb01TFWDziSV6WbYO7pWzDET0zxneoXL49+vWuCcd
	fa+rueYR/Vg2jgM3y8hsciTwEmHLuY4Xoay+NfPjGEzOD5bELBvnstp16NDw3m1F
X-Gm-Gg: AZuq6aI6eTjx5SyL/yp2wvf99FPN1uwUIhyV66pMQulvBDzbEddUmJjVIgkaqrcbQDT
	nVgpxVmqnF635PnRaKp46k2ePbzwZNshoBRw90DjlGYwLCYk0BPJlYRkHojKUzYHZFUXncSYr+o
	puNa5/jCNlfJUt/KWNdxnr3znfFt0du2VuWzfsekYW0zRgt2o6BhHZpMH1Zs+5dn65AqdmPjJeU
	5OZw1B7KOEQPUYmqUCFdCfLd2dPOoWOmHOpeNGKFJClSPsPPVN3MxJDYct2FFeQL7mbG7fOqatY
	SDL3AUjJnFFg0g914ZA25R8h3Bx8xei5UDSK5YIUFToKCLxmt4f5OLl6kLeYZALlY89jwAbIXkT
	79bNVI+VAK88C/xF2qNQrG2n5PPN8QUapieRaH45lCjw+WHKZnprLWWWlmxi+TqLh3Ot+oGGVpU
	BMFoyyZDEa5ZKf+fKPOC8gT4KF8IOJPOCdgqWmX75lqy+1+ZzO6E4BWgcGgyKemtHXNBl6bto+d
	Fk8KN0ErA/yXMzh
X-Received: by 2002:a05:6102:3f09:b0:5db:e909:aa0d with SMTP id ada2fe7eead31-5f8e2680347mr1395213137.37.1769810569202;
        Fri, 30 Jan 2026 14:02:49 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 07/37] doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:01:58 -0500
Message-ID: <20260130220229.1346261-8-luiz.dentz@gmail.com>
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

