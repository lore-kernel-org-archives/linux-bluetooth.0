Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B7301717
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801987; cv=none; b=D/2KCIpHPwEgBDZc3OfjaXInEX6tyjRPmQL6ICDXR4Wx+tvCr2GK6y257IrYZ+y753Cj3uYW/DC4tcOGwO8KdGyqPNJOOwMzpoB/8FQgc/I1ynzIlQdhqT8TLS5DKbtsAtAB/XQaBNsNViUdI1zFTTPTMuOLwwyM9RcIQwzhVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801987; c=relaxed/simple;
	bh=rUE5HZgo1c2zzKWDGgWnOkHm5Ox6izAIHvkfveqplpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVBHeBTY1QmwbrIqHwIeZv/hUCHnLj3EUSaJjFgAXA/p+a66zDQWJwtVT1bXe7Hth5xbSjvlXgsSnkmXuuJnpwKvRKLb940RUgtbQHWDKHNYSyHhaC23qykRrWRba8kCQo3/UFXz2udaHZOyPdOoaH1nt3MPqmu5f6bkxF8pyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGP5r2kY; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGP5r2kY"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-560227999d2so892748e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801984; x=1770406784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IfTXbPMbgVtzF/gDYXEBrFe5L1j4eJB2s2bTx/9zE4=;
        b=OGP5r2kY6AoJDsQFeJyEMK/GNhn6aqHH5wQZmBXXN6TsRkxPrytkJDbGdpm0O+vI0G
         jbcsn4zcySyb6w6uWUFT/Hpr6cphhbBLV7h761o0o5FAnvUGNWaW9hj7O3Zm6N14CB86
         egJ7X0v0EodRdr8Gkjv8o1v84BVrWq4wBZIheQTHWMJleH6Csj8UX9J4kGSxpqysGdaG
         IJfQPS9Y162gixRF2sdQyzbIWFlsyrykGV3o2KOw6OT9kty7c1KhSvxmGiIgib0HeMM7
         JcTcsC6Gd9V1Eg2Ontb54LUU79rGepVgKuMaCR+sFFRkC9TTQCL0OFwpUtbgKkGyUXDM
         yKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801984; x=1770406784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IfTXbPMbgVtzF/gDYXEBrFe5L1j4eJB2s2bTx/9zE4=;
        b=YZLQRYMknI8qgR4ghskQ9qT7LkuPPPwSZvJxPlM4nh83XEo1+NmJ0U4f0E8CHda001
         20TdMzraNYivH1bN+YQv4ssOICMdAIUcSl9Fp2a6cD7+/R02PfqlxqQ1puBedwFNdb1v
         VYYUwa6AKL5n88micOCFbIyMazN5Yb9l8CAEi0Cfj1oGkBEWgcgVnxQs7zsmzQNEggKX
         D6IA/pjdP+utKGU9JNysKyKIjE0FVvT/zGb1lLQpsVRPWGu6pg9zq5bsGHT6A/gGwJkG
         2QttZtiJ1T2C7+tSvLpl44rrwmjnvN2AgMztlyriBJ3gTRWoMy53EKvgcHYTjhJuMku+
         ENnw==
X-Gm-Message-State: AOJu0YyB7IkKfA+yvelwBypboBMXMozdG0/CYC28SXUUfzcIZ9TuLtb3
	D86q/Hi0tqo1bpnTvY4X/MIifgRDRbo7qT18JxgYMTIKIwBQ1gQvQFwC3C8NLq8f
X-Gm-Gg: AZuq6aI5D04aQp3ApaWCjWiy3gMD3pLOFtvfVc7YRNpmtqM+8p/lyOV+ZewCCzpsVSH
	kR45Yawg7l2KCIKTeWrNw8fPL7HN/dYrlWQBISEEturojGJG093eliXYbllkmuYdyMqp99rog5V
	Eek6NxlPxFgyyfgnoue+ZbJ75Tld/Nn4YAqCBnVTuF0frtt0Yx/uZ6N/IDhrTpP7rqDKRqryknA
	ORT/scRMSfMkbbKiDK5dBdl0Zl5YxuIOBO7xixWP+G5AX7Pm7Foqkjhg4oSi4waTJX59o5/izDt
	vb9fudZkZhZzCBP3EQcBbnf9/gQE6z3teFzeGqjQqpualoo3b55yYfHun5Pnxolq6yF2Weaq/KK
	dcWrTT17BxeoxOCTyVir0yBLGp8GonPwkDV2vzVo1BWgvfiHIgy4B83xSrGbJWlJx/wuQOmwBP5
	uE5Gr1hdUTGceL1GfEsEKBDwAYj8aenfJlExnqg+xGj2K9LoKGwzYfLWYV3Jq8jD7QKwTffAVKR
	YmaaA==
X-Received: by 2002:a05:6122:490e:b0:55b:10d7:51a5 with SMTP id 71dfb90a1353d-566a00c08b4mr1145162e0c.10.1769801984082;
        Fri, 30 Jan 2026 11:39:44 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 13/35] doc/bluetoothctl-scan: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:55 -0500
Message-ID: <20260130193921.1273263-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-scan.rst | 126 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 4 deletions(-)

diff --git a/doc/bluetoothctl-scan.rst b/doc/bluetoothctl-scan.rst
index cee255131622..16b4d08daddf 100644
--- a/doc/bluetoothctl-scan.rst
+++ b/doc/bluetoothctl-scan.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [scan.commands]
 
+This submenu configures discovery filters using **org.bluez.Adapter(5)**
+method **SetDiscoveryFilter**.
+
 Scan Commands
 =============
 
@@ -27,6 +30,24 @@ uuids
 Set/Get UUIDs filter.
 
 :Usage: **> uuids [all/uuid1 uuid2 ...]**
+:Uses: **org.bluez.Adapter(5)** method **SetDiscoveryFilter** property **UUIDs**
+:[all/uuid1 uuid2 ...]: List of UUIDs to filter for during scanning (default: none, use "all" to scan for any UUID)
+:Example Show current UUID filter settings:
+	| **> uuids**
+:Example Filter for Generic Access service only:
+	| **> uuids 0x1800**
+:Example Filter for Battery service only:
+	| **> uuids 0x180F**
+:Example Filter for Generic Access and Battery services:
+	| **> uuids 0x1800 0x180F**
+:Example Filter for Device Info, Battery, and Environmental Sensing:
+	| **> uuids 0x180A 0x180F 0x181A**
+:Example Filter for Generic Access using full UUID:
+	| **> uuids 00001800-0000-1000-8000-00805f9b34fb**
+:Example Filter using mixed short and long forms:
+	| **> uuids 00001800-0000-1000-8000-00805f9b34fb 0000180f-0000-1000-8000-00805f9b34fb**
+:Example Remove UUID filtering (scan for all devices):
+	| **> uuids all**
 
 rssi
 ----
@@ -41,7 +62,20 @@ If one or more discovery filters have been set, the RSSI delta-threshold imposed
 by starting discovery by default will not be applied.
 
 :Usage: **> rssi [rssi]**
-:Example: **> rssi -60**
+:Uses: **org.bluez.Adapter(5)** method **SetDiscoveryFilter** property **RSSI**
+:[rssi]: Minimum RSSI threshold value in dBm (optional, shows current if omitted)
+:Example Show current RSSI filter setting:
+	| **> rssi**
+:Example Only report devices with RSSI ≥ -60 dBm (close range):
+	| **> rssi -60**
+:Example Report devices with RSSI ≥ -80 dBm (medium range):
+	| **> rssi -80**
+:Example Report devices with RSSI ≥ -90 dBm (extended range):
+	| **> rssi -90**
+:Example Report only very close devices (RSSI ≥ -40 dBm):
+	| **> rssi -40**
+:Example Report devices with very weak signals (maximum sensitivity):
+	| **> rssi -100**
 
 pathloss
 --------
@@ -55,7 +89,20 @@ If one or more discovery filters have been set, the RSSI delta-threshold
 imposed by starting discovery by default will not be applied.
 
 :Usage: **> pathloss [pathloss]**
-:Example: **> pathloss 4**
+:Uses: **org.bluez.Adapter(5)** method **SetDiscoveryFilter** property **Pathloss**
+:[pathloss]: Maximum pathloss threshold value in dB (optional, shows current if omitted)
+:Example Show current pathloss filter setting:
+	| **> pathloss**
+:Example Report devices with maximum 4 dB pathloss (very close):
+	| **> pathloss 4**
+:Example Report devices with maximum 10 dB pathloss (close range):
+	| **> pathloss 10**
+:Example Report devices with maximum 20 dB pathloss (medium range):
+	| **> pathloss 20**
+:Example Report devices with maximum 30 dB pathloss (extended range):
+	| **> pathloss 30**
+:Example Report devices with maximum 50 dB pathloss (maximum range):
+	| **> pathloss 50**
 
 transport
 ---------
@@ -79,6 +126,15 @@ If "auto" transport is requested, the scan will use LE, BREDR, or both,
 depending on what's currently enabled on the controller.
 
 :Usage: **> transport [auto/bredr/le]**
+:[auto/bredr/le]: Transport type for scanning (optional, shows current if omitted)
+:Example Show current transport filter setting:
+	| **> transport**
+:Example Use automatic transport selection (LE + BR/EDR):
+	| **> transport auto**
+:Example Scan only Low Energy devices:
+	| **> transport le**
+:Example Scan only BR/EDR (Classic Bluetooth) devices:
+	| **> transport bredr**
 
 duplicate-data
 --------------
@@ -91,6 +147,13 @@ When enabled, PropertiesChanged signals will be generated for ManufacturerData
 and ServiceData every time they are discovered.
 
 :Usage: **> duplicate-data [on/off]**
+:[on/off]: Enable or disable duplicate advertisement data reporting (optional, shows current if omitted)
+:Example Show current duplicate data filter setting:
+	| **> duplicate-data**
+:Example Enable reporting of duplicate advertisement data:
+	| **> duplicate-data on**
+:Example Disable duplicate data reporting (filter duplicates):
+	| **> duplicate-data off**
 
 discoverable
 ------------
@@ -103,6 +166,13 @@ If the adapter is already discoverable, setting this filter won't have any
 effect.
 
 :Usage: **> discoverable [on/off]**
+:[on/off]: Make adapter discoverable during scanning (optional, shows current if omitted)
+:Example Show current discoverable filter setting:
+	| **> discoverable**
+:Example Make adapter discoverable during scanning:
+	| **> discoverable on**
+:Example Keep adapter non-discoverable during scanning:
+	| **> discoverable off**
 
 pattern
 -------
@@ -120,7 +190,21 @@ When set, it disregards device discoverable flags.
        string "" pattern will match any device found.
 
 :Usage: **> pattern [value]**
-
+:[value]: Pattern to match device address prefix or name (optional, shows current if omitted)
+:Example Show current pattern filter setting:
+	| **> pattern**
+:Example Discover devices with "Samsung" in the name:
+	| **> pattern Samsung**
+:Example Discover devices with "iPhone" in the name:
+	| **> pattern iPhone**
+:Example Discover devices with "Headphones" in the name:
+	| **> pattern Headphones**
+:Example Discover devices with addresses starting with 00:11:22:
+	| **> pattern 00:11:22**
+:Example Discover devices with addresses starting with AA:BB:CC:
+	| **> pattern AA:BB:CC**
+:Example Clear pattern filter (match any device):
+	| **> pattern ""**
 
 auto-connect
 ------------
@@ -131,13 +215,47 @@ Connect to discovered devices automatically if pattern filter has been set and
 it matches the device address or name and the device is connectable.
 
 :Usage: **> auto-connect [on/off]**
+:[on/off]: Automatically connect to discovered devices matching pattern filter (optional, shows current if omitted)
+:Example Show current auto-connect filter setting:
+	| **> auto-connect**
+:Example Enable automatic connection to matching devices:
+	| **> auto-connect on**
+:Example Disable automatic connection (manual connection required):
+	| **> auto-connect off**
 
 clear
 -----
 
 Clears discovery filter.
 
-:Usage: **> clear [uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern]**
+:Usage: **> clear [uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern/auto-connect]**
+:[uuids/rssi/pathloss/transport/duplicate-data/discoverable/pattern/auto-connect]: Specific filter(s) to clear (optional, clears all if omitted)
+:Example Clear all discovery filters:
+	| **> clear**
+:Example Clear only UUID filter:
+	| **> clear uuids**
+:Example Clear only RSSI filter:
+	| **> clear rssi**
+:Example Clear only pathloss filter:
+	| **> clear pathloss**
+:Example Clear only transport filter:
+	| **> clear transport**
+:Example Clear only duplicate data filter:
+	| **> clear duplicate-data**
+:Example Clear only discoverable filter:
+	| **> clear discoverable**
+:Example Clear only pattern filter:
+	| **> clear pattern**
+:Example Clear only auto-connect filter:
+	| **> clear auto-connect**
+:Example Clear UUID and RSSI filters:
+	| **> clear uuids rssi**
+:Example Clear transport and pattern filters:
+	| **> clear transport pattern**
+:Example Clear pattern and auto-connect filters:
+	| **> clear pattern auto-connect**
+:Example Clear RSSI, pathloss, and discoverable filters:
+	| **> clear rssi pathloss discoverable**
 
 RESOURCES
 =========
-- 
2.52.0

