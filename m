Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A09274FEB
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801978; cv=none; b=OY2rTDJFlfscAU/iiE14+BM4UKGv5KFiP6aBbYZbbYjJeePNdJjbTdlZ1q8kWp3XGceaUua0jAjcTYubkFLvSmma56R0o+udvn53hPFWXlXqcsTDPEhr85dKpXaFvkv+TD3Vml6/CqE+mmpzLHxf14S10MPoVkZrRoS8fcbuaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801978; c=relaxed/simple;
	bh=yyvzJIQ8FyBWAOkyvnHDGOTDo536+hNS1NeoH7tftBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4lwERQxsj3X9yEkamtEfUZz/epc9Lbh3maE89+p0eIbIM6jqU3tcxABGxZMNSYAlbVpq44DIpmu0BApzNmftainknP80Puc5dutgQRuEE76sajyu7D6Eknoug6twIw0yeCCoB5OvOC7wUQs9S1WWF94meaCI1qSgd//vZBLXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5O0da87; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5O0da87"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5634feea416so1211614e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801975; x=1770406775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HULzOf0FPGgnmWpbwEFo6CBIUo0DHmOHFKRE3t2Lc4Q=;
        b=A5O0da87j47+6kOjqTng09gzSFr/3XKwr0E5tp8rfFpkD8lPb+mx6B2VbMLZ4gzynM
         3KjTln6FZLHqC70d37AtBdHc9ZBaPZ4tQmYxJtCGq9frpeQxotlXLEsrCmEn5Q2xmzp3
         ZIaQrBN6TTZ7ug/eYP96Lb4dTSfDr3A0/EWXfI5Jw6TEk5mp8hnHDVE0LxvUMshkCmfX
         i+DtX5nmwNFANBV5qC6Ohy60pV7WL/OUWrb+PK5gg1RSgOJn7Ka+clS52E50nBRazwTq
         +aJ8+aeW83Qt31kZ+/RlGIOglxkqCHXY/BFdks53JN8n7wb4vZ+FqHCTIWCPx1m9TDqc
         ktOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801975; x=1770406775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HULzOf0FPGgnmWpbwEFo6CBIUo0DHmOHFKRE3t2Lc4Q=;
        b=rk81yQQ9hDH2OXEWiLHyJAdE+5FTdTS1tSC8znxNAsGMR5AlBgjrN7eknFXCVL94tH
         6xATS9lUcNTdNHqhPHaWufUnO5zl82fWW6nBdAV2Rg42gXnxcqxfGVZ0PRkGKKuztXEa
         6vrvvH6ovWk/Rlcy3SAUO77mFWZvTi1ta3Ha1+JN+zj3NqMytcF61eRPcBGpYCK2BAkj
         UkHlKu2T4Ij6EQ+ICCP61MhKpgsFu0nxYWBsOeAXfqaL0HNaeRFLwUs25F5YPaz1k0iy
         AZu2ZBDbF4vLQGr7AufHEokzsxwrjsVsx7lO3dUjokS/+edKd62tmW0i+MEGw6kGImlU
         SgQg==
X-Gm-Message-State: AOJu0YzZhNLxTj4PbzA8tzDcOtamtpqNRp+HTzVVhlA9cs4tjD+QJBo0
	jxAa9jonvoE4JlVWuSRFcIYDcF7q/emgweprUJkA5AiAeCxbnKBAuoVTodFuc1n+
X-Gm-Gg: AZuq6aIlPHcqqn/k9Axt5JOQNcmxTYJjRFyGcoIx4cSfrhygckJtIJytyeTLNLSj6/v
	/jY5SKY6CvSg9+XIv1E84pvotvyMOIuUl0j4jFR7s66c7usNNA9Q+JEETvK9gbgqpEZrczo5I4C
	DbhrqbCyI1c/+yvA+rWfmZY8E5Df7PoCDxgimiIdLZmyz56GKRMVqXC0uyiTb11+0uBk5xcs8xY
	5PHH9Ei5CZJEy+tGyLN/cpS4s3BPtK6tVBS5QkWrJtTcH8JpRcoXOcRxuEdofDYLaPUAszDVxky
	yBW+w9bxiyi7xE7k0G+cndSiOJY66PFlSsv41p+emtvpFCVZiNP6iSOmD7UaJrKeQraOU5PHoYR
	sIBDtJd+C1tBBhsO7cKmGmHcGqUPZyGXNEEaLwyoy19RPauPpWwOKcP7Cxs2ewDCwGDBuWcdhsy
	rscDqe2cYdJRslOaueAf0pAKXmQtTBKNTX4lAm5BbfBuqsklBy0uwvHjKbhXNQ4Nr3ryeuWmByQ
	xMxAg==
X-Received: by 2002:a05:6122:8c05:b0:566:2211:d090 with SMTP id 71dfb90a1353d-5669fffe77amr1501192e0c.7.1769801975040;
        Fri, 30 Jan 2026 11:39:35 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/35] doc/bluetoothctl-advertise: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:46 -0500
Message-ID: <20260130193921.1273263-5-luiz.dentz@gmail.com>
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
 doc/bluetoothctl-advertise.rst | 356 +++++++++++++++++++++++++++++++--
 1 file changed, 342 insertions(+), 14 deletions(-)

diff --git a/doc/bluetoothctl-advertise.rst b/doc/bluetoothctl-advertise.rst
index b1a950409ba4..0780cd9d8fde 100644
--- a/doc/bluetoothctl-advertise.rst
+++ b/doc/bluetoothctl-advertise.rst
@@ -18,6 +18,10 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [advertise.commands]
 
+This submenu configures LE advertising data and parameters using the
+**org.bluez.LEAdvertisement(5)** and **org.bluez.LEAdvertisingManager(5)**
+interfaces.
+
 Advertise Options Commands
 ==========================
 
@@ -26,16 +30,50 @@ uuids
 
 Set/Get advertise uuids.
 
-:Usage: **> uuids [all/uuid1 uuid2 ...]**
-:Example: **> uuids 0x1234**
-:Example: **> uuids 0x12345678**
-:Example: **> uuids 90f95193-35de-4306-a6e9-699328f15059**
+:Usage: **> uuids [uuid1 uuid2 ...]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **ServiceUUIDs**
+:[uuid1 uuid2 ...]: List of UUIDs to advertise (default: none)
+:Example Show current advertised UUIDs:
+	| **> uuids**
+:Example Advertise custom 16-bit service UUID:
+	| **> uuids 0x1234**
+:Example Advertise custom 32-bit service UUID:
+	| **> uuids 0x12345678**
+:Example Advertise custom 128-bit service UUID:
+	| **> uuids 90f95193-35de-4306-a6e9-699328f15059**
+:Example Advertise Battery and Generic Attribute services:
+	| **> uuids 0x180F 0x1801**
+:Example Advertise Device Information, Battery, and HID services:
+	| **> uuids 0x180A 0x180F 0x1812**
+:Example Advertise Generic Access service:
+	| **> uuids 0x1800**
+:Example Advertise Environmental Sensing service:
+	| **> uuids 0x181A**
+:Example Advertise Pulse Oximeter service:
+	| **> uuids 0x183B**
+:Example Mix short and full UUID formats:
+	| **> uuids 0x180F 12345678-1234-5678-9abc-123456789abc**
 
 solicit
 -------
 
 Set/Get advertise solicit uuids.
-:Usage: **# solicit [all/uuid1 uuid2 ...]**
+
+:Usage: **> solicit [uuid1 uuid2 ...]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **SolicitUUIDs**
+:[uuid1 uuid2 ...]: List of UUIDs to advertise (default: none)
+:Example Show current solicited service UUIDs:
+	| **> solicit**
+:Example Solicit Generic Access service:
+	| **> solicit 0x1800**
+:Example Solicit Device Information service:
+	| **> solicit 0x180A**
+:Example Solicit User Data service:
+	| **> solicit 0x181C**
+:Example Solicit Battery and Generic Attribute services:
+	| **> solicit 0x180F 0x1801**
+:Example Solicit Device Info, Environmental Sensing, and Pulse Oximeter:
+	| **> solicit 0x180A 0x181A 0x183B**
 
 service
 -------
@@ -43,6 +81,23 @@ service
 Set/Get advertise service data.
 
 :Usage: **> service [uuid] [data=xx xx ...]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **ServiceData**
+:[uuid]: Service UUID
+:[data=xx xx ...]: Service data
+:Example Show current service data:
+	| **> service**
+:Example Set battery level to 100 (0x64):
+	| **> service 0x180F 64**
+:Example Set battery level to 50 (0x32):
+	| **> service 0x180F 32**
+:Example Set battery level to 0 (0x00):
+	| **> service 0x180F 00**
+:Example Set environmental data (temperature, humidity, pressure):
+	| **> service 0x181A 20 15 C8 07**
+:Example Set device information data:
+	| **> service 0x180A 01 02 03 04**
+:Example Set custom service data with 128-bit UUID:
+	| **> service 12345678-1234-5678-9abc-123456789abc FF EE DD CC**
 
 manufacturer
 ------------
@@ -57,6 +112,23 @@ maximum has been exceeded so you  may receive an error from bluetoothd that it
 manufacturer data length.
 
 :Usage: **> manufacturer [id] [data=xx xx ...]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **ManufacturerData**
+:[id]: Manufacturer ID (default: 0x004C for Apple Inc.)
+:[data=xx xx ...]: Manufacturer data
+:Example Show current manufacturer data:
+	| **> manufacturer**
+:Example Set Apple Inc. manufacturer data:
+	| **> manufacturer 0x004C 01 02 03 04**
+:Example Set Apple manufacturer data with 8 bytes:
+	| **> manufacturer 0x004C FF FE FD FC FB FA F9 F8**
+:Example Set Microsoft Corp. manufacturer data:
+	| **> manufacturer 0x0006 10 11 12 13**
+:Example Set Samsung Electronics manufacturer data:
+	| **> manufacturer 0x0075 AA BB CC DD EE**
+:Example Set Google LLC manufacturer data:
+	| **> manufacturer 0x00E0 01 23 45 67 89 AB CD EF**
+:Example Set custom manufacturer ID with test data:
+	| **> manufacturer 0xFFFF DE AD BE EF**
 
 data
 ----
@@ -75,40 +147,111 @@ You can modify the advertising data while it is advertising.
 To get the currently set data use the command data without any arguments.
 
 :Usage: **> data [type] [data=xx xx ...]**
-:Example: **> data 0x0C 01 0x0F 13**
+:Uses: **org.bluez.LEAdvertisement(5)** property **Data**
+:[type]: Advertising data type
+:[data=xx xx ...]: Advertising data (default: none)
+:Example Show current advertising data:
+	| **> data**
+:Example Set slave connection interval range data:
+	| **> data 0x0C 01 0x0F 13**
+:Example Set complete local name to "Hello":
+	| **> data 0x09 48 65 6C 6C 6F**
+:Example Set shortened local name to "Test":
+	| **> data 0x08 54 65 73 74**
+:Example Set flags (LE General Discoverable + BR/EDR not supported):
+	| **> data 0x01 06**
+:Example Set appearance (keyboard, 0x0341):
+	| **> data 0x19 41 03**
+:Example Set TX power level to +4 dBm:
+	| **> data 0x0A 04**
+:Example Set TX power level to -4 dBm:
+	| **> data 0x0A FC**
+:Example Set URI "//google.com":
+	| **> data 0x24 17 2F 2F 67 6F 6F 67 6C 65 2E 63 6F 6D**
+:Example Set service data for Battery Service (UUID 0x180F, level 100):
+	| **> data 0x16 0F 18 64**
 
 sr-uuids
 --------
 
 Set/Get scan response uuids.
 
-:Usage: **# sr-uuids [all/uuid1 uuid2 ...]**
+:Usage: **> sr-uuids [uuid1 uuid2 ...]**
+:[uuid1 uuid2 ...]: List of UUIDs to advertise in scan response
+:Example Show current scan response UUIDs:
+	| **> sr-uuids**
+:Example Set Generic Access in scan response:
+	| **> sr-uuids 0x1800**
+:Example Set Device Info and Battery services in scan response:
+	| **> sr-uuids 0x180A 0x180F**
+:Example Set custom UUID in scan response:
+	| **> sr-uuids 12345678-1234-5678-9abc-123456789abc**
 
 sr-solicit
 ----------
 
 Set/Get scan response solicit uuids.
-:Usage: **# sr-solicit [all/uuid1 uuid2 ...]**
+
+:Usage: **> sr-solicit [uuid1 uuid2 ...]**
+:[uuid1 uuid2 ...]: List of UUIDs to advertise in scan response
+:Example Show current scan response solicited UUIDs:
+	| **> sr-solicit**
+:Example Solicit Generic Attribute service in scan response:
+	| **> sr-solicit 0x1801**
+
+:Example Solicit Device Info and Environmental Sensing in scan response:
+	| **> sr-solicit 0x180A 0x181A**
 
 sr-service
 ----------
 
 Set/Get scan response service data.
 
-:Usage: **# sr-service [uuid] [data=xx xx ...]**
+:Usage: **> sr-service [uuid] [data=xx xx ...]**
+:[uuid]: Service UUID
+:[data=xx xx ...]: Service data
+:Example Show current scan response service data:
+	| **> sr-service**
+:Example Set battery level to 128 in scan response:
+	| **> sr-service 0x180F 80**
+:Example Set environmental data in scan response:
+	| **> sr-service 0x181A 22 18 C0 05**
+:Example Set device info "Hello" in scan response:
+	| **> sr-service 0x180A 48 65 6C 6C 6F**
 
 sr-manufacturer
 ---------------
 
 Set/Get scan response manufacturer data.
 
-:Usage: **# sr-manufacturer [id] [data=xx xx ...]**
+:Usage: **> sr-manufacturer [id] [data=xx xx ...]**
+:[id]: Manufacturer ID (default: 0x004C for Apple Inc.)
+:[data=xx xx ...]: Manufacturer data
+:Example Show current scan response manufacturer data:
+	| **> sr-manufacturer**
+:Example Set Apple manufacturer data in scan response:
+	| **> sr-manufacturer 0x004C 05 06 07 08**
+:Example Set Microsoft manufacturer data in scan response:
+	| **> sr-manufacturer 0x0006 20 21 22 23**
+:Example Set custom manufacturer data in scan response:
+	| **> sr-manufacturer 0xFFFF CA FE BA BE**
 
 sr-data
 -------
 
 Set/Get scan response data.
-:Usage: **# sr-data [type] [data=xx xx ...]**
+
+:Usage: **> sr-data [type] [data=xx xx ...]**
+:[type]: Scan Response data type
+:[data=xx xx ...]: Scan Response data
+:Example Show current scan response data:
+	| **> sr-data**
+:Example Set complete local name "ScanResp" in scan response:
+	| **> sr-data 0x09 53 63 61 6E 52 65 73 70**
+:Example Set TX power level +8 dBm in scan response:
+	| **> sr-data 0x0A 08**
+:Example Set Battery service data (level 50) in scan response:
+	| **> sr-data 0x16 0F 18 32**
 
 discoverable
 ------------
@@ -125,6 +268,14 @@ will be ignored.
 Entering the command by itself will show the status of the setting
 
 :Usage: **> discoverable [on/off]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **Discoverable**
+:[on/off]: Enable/Disable LE General Discoverable Mode
+:Example Show current discoverable setting:
+	| **> discoverable**
+:Example Enable LE General Discoverable Mode:
+	| **> discoverable on**
+:Example Disable discoverable mode:
+	| **> discoverable off**
 
 discoverable-timeout
 --------------------
@@ -141,6 +292,18 @@ discoverable [on] must be set to use this feature.
 Entering the command by itself will show the current value set.
 
 :Usage: **> discoverable-timeout [seconds]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **DiscoverableTimeout**
+:[seconds]: Timeout duration in seconds for LE Limited Discoverable Mode
+:Example Show current discoverable timeout:
+	| **> discoverable-timeout**
+:Example Set LE Limited Discoverable for 30 seconds:
+	| **> discoverable-timeout 30**
+:Example Set LE Limited Discoverable for 2 minutes:
+	| **> discoverable-timeout 120**
+:Example Set LE Limited Discoverable for 5 minutes:
+	| **> discoverable-timeout 300**
+:Example Disable discoverable timeout (unlimited):
+	| **> discoverable-timeout 0**
 
 tx-power
 --------
@@ -158,7 +321,15 @@ This feature can be modified while advertising.
 
 Entering the command by itself will show the current value set.
 
-:Usage: **> tx-power [on/off] [power]**
+:Usage: **> tx-power [on/off]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **Includes**
+:[on/off]: Enable or disable TX power advertisement (optional, shows current if omitted)
+:Example Show current TX power advertisement setting:
+	| **> tx-power**
+:Example Enable TX power advertisement with default power:
+	| **> tx-power on**
+:Example Disable TX power advertisement:
+	| **> tx-power off**
 
 name
 ----
@@ -173,7 +344,28 @@ It will either advertise as a complete local name or if it has to be truncated
 then a shortened local name.
 
 :Usage: **> name [on/off/name]**
-:Example: **> name "0123456789abcdef0123456789abcdef"**
+:Uses: **org.bluez.LEAdvertisement(5)** property **LocalName**
+:[name]: Local name (optional, shows current if omitted)
+:Example Show current advertised name setting:
+	| **> name**
+:Example Enable advertising the system hostname:
+	| **> name on**
+:Example Disable name advertisement:
+	| **> name off**
+:Example Advertise "My Device" as local name:
+	| **> name "My Device"**
+:Example Advertise "Smart Sensor" as local name:
+	| **> name "Smart Sensor"**
+:Example Advertise device with ID suffix:
+	| **> name "BLE-Peripheral-001"**
+:Example Advertise long name (will be truncated to fit):
+	| **> name "0123456789abcdef0123456789abcdef"**
+:Example Long descriptive name (automatically truncated):
+	| **> name "This is a very long device name that will be truncated"**
+:Example Name with special characters:
+	| **> name "Device™"**
+:Example Name with accented characters:
+	| **> name "Tëst-Dëvicë"**
 
 appearance
 ----------
@@ -181,6 +373,44 @@ appearance
 Configure custom appearance to be advertised.
 
 :Usage: **> appearance [on/off/value]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **Appearance**
+:[value]: Appearance value (optional, shows current if omitted)
+:Example Show current appearance setting:
+	| **> appearance**
+:Example Enable appearance advertisement with default value:
+	| **> appearance on**
+:Example Disable appearance advertisement:
+	| **> appearance off**
+:Example Set appearance to keyboard (0x03C1):
+	| **> appearance 961**
+:Example Set appearance to mouse (0x03C2):
+	| **> appearance 962**
+:Example Set appearance to joystick (0x03C3):
+	| **> appearance 963**
+:Example Set appearance to gamepad (0x03C4):
+	| **> appearance 964**
+:Example Set appearance to generic audio sink (0x0340):
+	| **> appearance 832**
+:Example Set appearance to speaker (0x0341):
+	| **> appearance 833**
+:Example Set appearance to microphone (0x0342):
+	| **> appearance 834**
+:Example Set appearance to headset (0x0343):
+	| **> appearance 835**
+:Example Set appearance to headphones (0x0344):
+	| **> appearance 836**
+:Example Set appearance to heart rate sensor (0x0540):
+	| **> appearance 1344**
+:Example Set appearance to thermometer (0x05C0):
+	| **> appearance 1472**
+:Example Set appearance to glucose meter (0x0640):
+	| **> appearance 1600**
+:Example Set appearance to generic phone (0x0040):
+	| **> appearance 64**
+:Example Set appearance to generic computer (0x0080):
+	| **> appearance 128**
+:Example Set appearance to generic watch (0x00C0):
+	| **> appearance 192**
 
 duration
 --------
@@ -212,6 +442,24 @@ set for each Instance. The advertising interval is the maximum of the
 advertising intervals set for each Instance.
 
 :Usage: **> duration [seconds]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **Duration**
+:[seconds]: Duration in seconds (optional, shows current if omitted)
+:Example Show current advertising duration setting:
+	| **> duration**
+:Example Use default duration (2 seconds):
+	| **> duration 0**
+:Example Set duration to 1 second:
+	| **> duration 1**
+:Example Set duration to 5 seconds:
+	| **> duration 5**
+:Example Set duration to 10 seconds:
+	| **> duration 10**
+:Example Set duration to 30 seconds:
+	| **> duration 30**
+:Example Set duration to 1 minute:
+	| **> duration 60**
+:Example Set duration to 5 minutes:
+	| **> duration 300**
 
 timeout
 -------
@@ -219,6 +467,18 @@ timeout
 Set/Get advertise timeout.
 
 :Usage: **> timeout [seconds]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **Timeout**
+:[seconds]: Timeout in seconds (optional, shows current if omitted)
+:Example Show current advertising timeout setting:
+	| **> timeout**
+:Example Unlimited advertising (no timeout):
+	| **> timeout 0**
+:Example Stop advertising after 30 seconds:
+	| **> timeout 30**
+:Example Stop advertising after 2 minutes:
+	| **> timeout 120**
+:Example Stop advertising after 1 hour:
+	| **> timeout 3600**
 
 secondary
 ---------
@@ -226,6 +486,33 @@ secondary
 Set/Get advertise secondary channel.
 
 :Usage: **> secondary [1M/2M/Coded]**
+:Uses: **org.bluez.LEAdvertisement(5)** property **SecondaryChannel**
+:[1M/2M/Coded]: Secondary channel (optional, shows current if omitted)
+:Example Show current secondary channel setting:
+	| **> secondary**
+:Example Use LE 1M PHY for secondary advertising channel:
+	| **> secondary 1M**
+:Example Use LE 2M PHY for secondary advertising channel:
+	| **> secondary 2M**
+:Example Use LE Coded PHY for secondary advertising channel:
+	| **> secondary Coded**
+
+rsi
+---
+
+Show/Enable/Disable RSI to be advertised.
+
+RSI (Resolvable Set Identifier) is used to advertise a resolvable identifier
+for Coordinated Set Identification.
+
+:Usage: **> rsi [on/off]**
+:[on/off]: Enable or disable RSI advertisement (optional, shows current if omitted)
+:Example Show current RSI setting:
+	| **> rsi**
+:Example Enable RSI advertisement:
+	| **> rsi on**
+:Example Disable RSI advertisement:
+	| **> rsi off**
 
 interval
 --------
@@ -252,7 +539,25 @@ set for each Instance.
 The advertising interval is the maximum of the advertising intervals set for
 each Instance.
 
-:Usage: **> interval [milliseconds]**
+:Usage: **> interval [min] [max]**
+:[min]: Minimum advertising interval in milliseconds (optional, shows current if omitted)
+:[max]: Maximum advertising interval in milliseconds (optional, defaults to min value)
+:Example Show current advertising interval setting:
+	| **> interval**
+:Example Set minimum advertising interval (20ms):
+	| **> interval 20**
+:Example Set advertising interval range (50-100ms):
+	| **> interval 50 100**
+:Example Set normal advertising interval (100ms):
+	| **> interval 100**
+:Example Set moderate advertising interval (200ms):
+	| **> interval 200**
+:Example Set slow advertising interval (500ms):
+	| **> interval 500**
+:Example Set very slow advertising interval (1 second):
+	| **> interval 1000**
+:Example Set maximum advertising interval (10.24 seconds):
+	| **> interval 10240**
 
 clear
 -----
@@ -266,6 +571,29 @@ first clear the advertise configuration and then set the new advertise
 configuration.
 
 :Usage: **> clear [uuids/service/manufacturer/config-name...]**
+:[uuids/service/manufacturer/config-name...]: List of configuration to clear
+:Example Clear all advertising configuration:
+	| **> clear**
+:Example Clear only advertised UUIDs:
+	| **> clear uuids**
+:Example Clear only service data:
+	| **> clear service**
+:Example Clear only manufacturer data:
+	| **> clear manufacturer**
+:Example Clear only advertised name:
+	| **> clear name**
+:Example Clear only appearance data:
+	| **> clear appearance**
+:Example Clear only TX power advertisement:
+	| **> clear tx-power**
+:Example Clear UUIDs and service data:
+	| **> clear uuids service**
+:Example Clear manufacturer data and name:
+	| **> clear manufacturer name**
+:Example Clear UUIDs, service data, and manufacturer data:
+	| **> clear uuids service manufacturer**
+:Example Clear discoverable mode and TX power:
+	| **> clear discoverable tx-power**
 
 RESOURCES
 =========
-- 
2.52.0

