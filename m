Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97E37647A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728939; cv=none; b=CBvbEdrPk2iCakn1X2eokdyQkwLAbvCJd161mV5WDVQBK93wxeS9pMDxdChhluEjqVAp3goGEWi0mwQz2RdaRBDQ+3Uv9E/uKYFJ8heqPmNs7jxtLcBGeeuKZQlZjXoq9yTUAWRfma+IKUdzzZNCMpwFPFXxcQTHuWePxuyHAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728939; c=relaxed/simple;
	bh=LicWe0DiHe9B3sssTC9xUvRnRqQitrnLx4g1HqY4TGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovnQyDYG4lG1dEo0x8VReguTCfbY7Ct+sCm79zEMrdBEWnkTAu3jKMD8zreSXSI6/2D2aY/7iPNkfNDcLs1KO7I9RQGoL8mRgymrPbO0yrYle23sSnAKF+Q6g1dFcEHpFqJBt0LRjUp52I34g/Qm6UhLW1AdSc554+mIqaYmMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZLT5C1V; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZLT5C1V"
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-5637886c92aso500322e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728936; x=1770333736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSS4GeSvORTVdeGc0b2nfu6U3YjrdrLzdKIbV537qaM=;
        b=CZLT5C1VYPtau/UzngYIerDXVhEF7jF7+ZhpZU1/2U4yWizIOlgNIuB/5XTfOpPsQ5
         0JrFuxk+9+yJRFzBXlePDTsGzqroeywEK2ZBnqpMa2SuD877Fejs9muMUN9eFS9zJSxE
         xLlrd4ELkby2jeU5IJr3P7A0X3IcdvFVyvH+Ihe8ZrZHX0rGiAVVfb+gx8uW5l0rWTxa
         9WazgTC0nVJG9J/lVU4DeDfnGZBXxB0eldTskPyBzK1E3Azt93ox/QjVLFLc8PU8eISu
         SSg5ZcScJFIQ1LqcFijKIKWBVU679tQNMHMlR/2QpSKK9qzdTn8hNxBSvlq/Bv4ietlx
         Twuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728936; x=1770333736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSS4GeSvORTVdeGc0b2nfu6U3YjrdrLzdKIbV537qaM=;
        b=KXoJVEdh5UwbSjC8BUIhgl7gqT2b8PmPW+gNo3iQI1Zhd9hXndbWgtUp50xC3FRMu0
         znSZMmNW/3ybhHXsU6gCqobsf8LBZNc8FekbDXNZKS413fcJoYPCCOcikCXFGvuKoP6W
         lb50wBpPAJ0V9qMzz7Oy/NcXmhWLauuprJy0EvYbPid1GZ4+9i6gb8hK57lUJdJeldQQ
         3v5PWj0i4o6RRymtebCVFDbziWB+eX7h5QGQayJqYP0KySfazegNqDLTEeUVQSzDAkwQ
         Ym5aLuifwfiifkmvTOz2uQVLFOtDu1H1dSOi5Z0c46KtV0Os67doAt3x1N16d3/x9FSv
         mSNA==
X-Gm-Message-State: AOJu0YzdfiSRwjhltLJiZ3HZZ74xXZWDcVoYOwqGpu0fEriYq7OB1vSX
	ttxWAbWwebuGOanYBTMPKomdDn+d9iuyvNhEKSuVhHOHAsL8HXp/XUWHmKHHi6t0WJM=
X-Gm-Gg: AZuq6aKu6AJ+kCjgvNypVuPPYSD2VOGsg25tUhabdFq1OycQGi+8xHT1rk9TzgltbaV
	K5o0QCLe+HNqsWCb3wExcsKHPqqnI2Ym9w9iF60HlRV3J9lTTJrb5/V3iQbSRJmEVCNI+ulHUsS
	/SkaHNSJ4C1tPvUF3InLVQ4deCxBf7PMGMoXTyzY06B5UDoomQAQLSS0qtHComr9AUInFeulYRw
	2hkcMQKHI3oBCHwt+0dPdoc+4pWSYv12WfO4gquv14HpHhyhCFlN+zn5B8LcOFaq3effjWe59Ju
	JPu0DVJ6j8QYQbuM3tl/YGD4o7Hv0ZSAybCtPD8E/AENDtO4s/xPIO7DwWjx279Dg15pDA9SKK6
	KM6OwUhI7n62ukiQ6g9c/YJ/mNPLhci7VQpgMYKX/qh/vxQUxfaoRZ9fl5jSSzpw3zfXhRcJr/h
	zOmoUujgQ4hYdvpQVGK+eyb+sGeXNnGwM35mBnzVZhu1Ksyl+kotpIj1RfWSuGmtq8xGVYTJr96
	EpHNQ==
X-Received: by 2002:a05:6122:2499:b0:559:6723:628c with SMTP id 71dfb90a1353d-566a0103f39mr337713e0c.16.1769728935938;
        Thu, 29 Jan 2026 15:22:15 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/15] doc/bluetoothctl-advertise: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:43 -0500
Message-ID: <20260129232201.1049568-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix critical syntax errors in tx-power and interval commands and add
comprehensive parameter documentation. Corrects tx-power to use only
on/off parameters and updates interval to use min/max format. Adds
parameter documentation for all advertising commands.
---
 doc/bluetoothctl-advertise.rst | 339 +++++++++++++++++++++++++++++++--
 1 file changed, 325 insertions(+), 14 deletions(-)

diff --git a/doc/bluetoothctl-advertise.rst b/doc/bluetoothctl-advertise.rst
index b1a950409ba4..4f8bd5909b12 100644
--- a/doc/bluetoothctl-advertise.rst
+++ b/doc/bluetoothctl-advertise.rst
@@ -26,16 +26,48 @@ uuids
 
 Set/Get advertise uuids.
 
-:Usage: **> uuids [all/uuid1 uuid2 ...]**
-:Example: **> uuids 0x1234**
-:Example: **> uuids 0x12345678**
-:Example: **> uuids 90f95193-35de-4306-a6e9-699328f15059**
+:Usage: **> uuids [uuid1 uuid2 ...]**
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
@@ -43,6 +75,22 @@ service
 Set/Get advertise service data.
 
 :Usage: **> service [uuid] [data=xx xx ...]**
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
@@ -57,6 +105,22 @@ maximum has been exceeded so you  may receive an error from bluetoothd that it
 manufacturer data length.
 
 :Usage: **> manufacturer [id] [data=xx xx ...]**
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
@@ -75,40 +139,110 @@ You can modify the advertising data while it is advertising.
 To get the currently set data use the command data without any arguments.
 
 :Usage: **> data [type] [data=xx xx ...]**
-:Example: **> data 0x0C 01 0x0F 13**
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
@@ -125,6 +259,13 @@ will be ignored.
 Entering the command by itself will show the status of the setting
 
 :Usage: **> discoverable [on/off]**
+:[on/off]: Enable/Disable LE General Discoverable Mode
+:Example Show current discoverable setting:
+	| **> discoverable**
+:Example Enable LE General Discoverable Mode:
+	| **> discoverable on**
+:Example Disable discoverable mode:
+	| **> discoverable off**
 
 discoverable-timeout
 --------------------
@@ -141,6 +282,17 @@ discoverable [on] must be set to use this feature.
 Entering the command by itself will show the current value set.
 
 :Usage: **> discoverable-timeout [seconds]**
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
@@ -158,7 +310,14 @@ This feature can be modified while advertising.
 
 Entering the command by itself will show the current value set.
 
-:Usage: **> tx-power [on/off] [power]**
+:Usage: **> tx-power [on/off]**
+:[on/off]: Enable or disable TX power advertisement (optional, shows current if omitted)
+:Example Show current TX power advertisement setting:
+	| **> tx-power**
+:Example Enable TX power advertisement with default power:
+	| **> tx-power on**
+:Example Disable TX power advertisement:
+	| **> tx-power off**
 
 name
 ----
@@ -173,7 +332,27 @@ It will either advertise as a complete local name or if it has to be truncated
 then a shortened local name.
 
 :Usage: **> name [on/off/name]**
-:Example: **> name "0123456789abcdef0123456789abcdef"**
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
@@ -181,6 +360,43 @@ appearance
 Configure custom appearance to be advertised.
 
 :Usage: **> appearance [on/off/value]**
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
@@ -212,6 +428,23 @@ set for each Instance. The advertising interval is the maximum of the
 advertising intervals set for each Instance.
 
 :Usage: **> duration [seconds]**
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
@@ -219,6 +452,17 @@ timeout
 Set/Get advertise timeout.
 
 :Usage: **> timeout [seconds]**
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
@@ -226,6 +470,32 @@ secondary
 Set/Get advertise secondary channel.
 
 :Usage: **> secondary [1M/2M/Coded]**
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
@@ -252,7 +522,25 @@ set for each Instance.
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
@@ -266,6 +554,29 @@ first clear the advertise configuration and then set the new advertise
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

