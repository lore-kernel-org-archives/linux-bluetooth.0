Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03012FE575
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728934; cv=none; b=NOppcZa7rrswZ4t4DNev5DNjSvVRQJC5EH6XgbFC26zMKZt7+YMr6jQONQFSz1lfWtrH8kwilczwx28EbvC/3GQ0TlZpwVr8sq4MIYYz3NkfxKu6m6g4v4epq68IY5PI9pV9ffN8qPbiburyLPzDbF0y8NMFZnij1B+Nol4s8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728934; c=relaxed/simple;
	bh=WqSfBpqTnY1Eh65DeiOrLyvRucVwmk5V+vjS5ZH98aE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=crFo9tEfhxwkQAu8lxua+cN0PozaSGbBOBiQ6nWx0LwkW5cLwU8GMs6C4RIU6w2dqz6BtHHJoMAebqeDpfIy2Bez9TCm0w8799orDGINRxouGEthS7HOfK9ABuM9Ryohn7T1h67f2K2AQlW73GhloJVbdUsGCEOANYyXxuozaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0fPqu2s; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0fPqu2s"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5ee9fa419f5so323726137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728931; x=1770333731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MKeVCJ2uNDNkcE+ZruphRTvmQnU6XeFjBZPu8CDT5s=;
        b=T0fPqu2s12CuFUZvDiYsgaZtbFlvrFESvxGG5dqgn2bisJIjSW0+VUbjqaoFayZEGA
         gJAstFfnHcdc3hiUWY+yvaAjJ8tBa8Tg2CZFX7l+jI+eTGOjpmEAsaNlfOcW52qzZmwk
         9HqLDCdiipyJdozGyTBJ8++GI777lwvI6lKcaAoBknjYu8rsGrmhUzUvzP5TTE/LNrlF
         3eyNAw99L8vBfzhsJe2fbcWaOffKU9IxD1qPQjqp3MbCvLFls27MbGgnyDIHnqdwzNQ3
         f77QHcdX4U48gPa3hHI8kW/xzMMw40oH/+JfDquCauLhF1Rlqy8yJBo7+RN3XF4yXbNn
         jdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728931; x=1770333731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MKeVCJ2uNDNkcE+ZruphRTvmQnU6XeFjBZPu8CDT5s=;
        b=kPRN9Oa2r+pQKH56M2CVwa8D4m7v5ojGXQUgEyuDLtKBdaUsI4eEPFEJxRDVQ/H0X5
         U0p+m2nO7KeCFfRTd2427sPvD+SG33TXFkg2cXZAqui5WJ06zxe8bTGlY5YVVCZXdoBD
         oreiDQb/xLcv8eqTKQH3aZ8mvtdJYrXG150EKcLSXjitRhFe41PWw3pn2c0g/R+4mnO3
         qU8iN9alpIzHhgMy0dLcwiOyxnWPhRNpKUTfDDPX+QadcRIBOEAo/FUVs41QvaVcdfKx
         E5iawUmMKSL6HgY25Dgjv7QMyBFcC2lr72C6GW+PPm+bFy7WvXuxwyFEcZ4o5mtZO+j9
         9jhg==
X-Gm-Message-State: AOJu0YwmUbMM2XKfNU0dh+r+qryEzMJPZI9oH4G7ZIhUW5S/1bQMCoG2
	JQNbtePpm3sho0iNGxW03tW8Ns6WBTyiHauiHhgohoEn1GsJaAn5AF4gOXCY+FBEjUY=
X-Gm-Gg: AZuq6aLte40r+kRv6M6duidicsSG1WHMg0X0zUfsPhM/kHeBv0cXl8qHulsUkURL/G8
	cKAKZvQ/LQdTDK399Od1X7VL1FlyfZyA/GsLZD7I/2neTLEIc1rtRjicQKgO2Or96CJUGmO2WuH
	NhiveVwdsNfs4iTzKEacfs7kj975XrqeBzxOKXkuo4jUkRtg0PwYQzgDmuqhjxQDkWZa3bmvS/s
	zBgumSgIKAi9NG8zm86H98AuQ9N4YawUntDCFewSvr7GapC5ln3hisjhmtxvuCNh4FiN1B0CWD3
	wsCwsHL8yAG70M4Sq8CKISivaEowOLMrpyPBifWWCi9ynZPeNOumpRtmf6v/kpAid6JtzgB2bnn
	66N5kGmZv3eJvgguJxBiTKpdQFyKXjb7iWv/iss6ddUJLmTdX/JWVV3dP4kT1tYI4O2CskdxfCZ
	aeN4JhQkXCOn0PjQbXcI2RDQZSjVnDdgXMks5XL6Sj9HXm6Yf+awmLTjdIT8W1XEzPYcYaQgXAu
	2PuHg==
X-Received: by 2002:a05:6102:4426:b0:5ed:675:e355 with SMTP id ada2fe7eead31-5f8e2603978mr352291137.27.1769728931021;
        Thu, 29 Jan 2026 15:22:11 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/15] doc/bluetoothctl: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:40 -0500
Message-ID: <20260129232201.1049568-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This commit adds comprehensive parameter documentation for all commands
that accept arguments in the main bluetoothctl interface including show,
select, devices, power, advertise, scan, pair, connect, disconnect,
trust, untrust, block, unblock, remove, info, bearer and agent commands.
---
 doc/bluetoothctl.rst | 224 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 197 insertions(+), 27 deletions(-)

diff --git a/doc/bluetoothctl.rst b/doc/bluetoothctl.rst
index f8d6c3457977..988c00328c25 100644
--- a/doc/bluetoothctl.rst
+++ b/doc/bluetoothctl.rst
@@ -48,6 +48,8 @@ list
 List available controllers.
 
 :Usage: **> list**
+:Example Display all Bluetooth controllers available on the system:
+	| **> list**
 
 show
 ----
@@ -55,6 +57,11 @@ show
 Controller information.
 
 :Usage: **> show [ctrl]**
+:[ctrl]: Bluetooth controller address
+:Example Display information for currently selected controller:
+	| **> show**
+:Example Show information for controller 00:11:22:33:44:55:
+	| **> show 00:11:22:33:44:55**
 
 select
 ------
@@ -62,6 +69,9 @@ select
 Select default controller.
 
 :Usage: **> select <ctrl>**
+:<ctrl>: Bluetooth controller address
+:Example Select controller 00:11:22:33:44:55:
+	| **> select 00:11:22:33:44:55**
 
 devices
 -------
@@ -69,6 +79,17 @@ devices
 List available devices, with an optional property as the filter.
 
 :Usage: **> devices [Paired/Bonded/Trusted/Connected]**
+:[Paired/Bonded/Trusted/Connected]: Filter to show only devices with specific property (optional)
+:Example List all discovered devices:
+	| **> devices**
+:Example List only paired devices:
+	| **> devices Paired**
+:Example List only bonded devices:
+	| **> devices Bonded**
+:Example List only trusted devices:
+	| **> devices Trusted**
+:Example List only currently connected devices:
+	| **> devices Connected**
 
 system-alias
 ------------
@@ -76,6 +97,13 @@ system-alias
 Set controller alias.
 
 :Usage: **> system-alias <name>**
+:<name>: New alias name for the Bluetooth controller (required)
+:Example Set controller alias with spaces (note quotes):
+	| **> system-alias "My Desktop Bluetooth"**
+:Example Set controller alias without spaces:
+	| **> system-alias MyLaptop**
+:Example Set controller alias with hyphens:
+	| **> system-alias "Home-Office-PC"**
 
 reset-alias
 -----------
@@ -83,6 +111,8 @@ reset-alias
 Reset controller alias.
 
 :Usage: **> reset-alias**
+:Example Reset controller alias to default (usually the hostname):
+	| **> reset-alias**
 
 power
 -----
@@ -93,15 +123,19 @@ When the controller is powered off, the USB port the controller is attached to
 is put into a suspend state.
 
 :Usage: **> power <on/off>**
+:<on/off>: Power state - "on" to enable or "off" to disable the controller (required)
+:Example Turn on the Bluetooth controller:
+	| **> power on**
+:Example Turn off the Bluetooth controller:
+	| **> power off**
 
 advertise
 ---------
 
 Enable/disable advertising with given type.
 
-If you exit the program advertising will be disabled.
-
-When advertising the controller should advertise with random address but may
+When the controller advertises an LE device (peripheral) it will generate a
+random address for its own privacy if the controller is capable of it, it will
 use its public address if it does not support the feature (address of the
 device).
 
@@ -109,6 +143,15 @@ A device can advertise if it initiated the connection to another advertising
 device.
 
 :Usage: **> advertise <on/off/type>**
+:<on/off/type>: Advertising mode - "on", "off", "peripheral", or "broadcast" (required)
+:Example Enable basic LE advertising:
+	| **> advertise on**
+:Example Disable LE advertising:
+	| **> advertise off**
+:Example Advertise as peripheral device:
+	| **> advertise peripheral**
+:Example Advertise as broadcast source:
+	| **> advertise broadcast**
 
 set-alias
 ---------
@@ -116,6 +159,13 @@ set-alias
 Set device alias.
 
 :Usage: **> set-alias <alias>**
+:<alias>: New alias name for the device (required)
+:Example Set device alias with spaces (note quotes):
+	| **> set-alias "My Headphones"**
+:Example Set device alias without spaces:
+	| **> set-alias MyMouse**
+:Example Set device alias with hyphens:
+	| **> set-alias "Kitchen-Speaker"**
 
 scan
 ----
@@ -128,19 +178,16 @@ The purpose of scanning is to find devices that are advertising with their
 discoverable flag set (either limited or general). Once you have found the
 address then you can connect or pair.
 
-Note the following when scanning:
-
-  - When scanning the controller will use a random address that is not
-    resolvable so the public address is not leaked. A new random address is
-    created every time scan on is used.
-  - When turning on scanning the device will start receiving advertising reports
-    of what devices are advertising.
-  - The filtering of duplicate advertising reports may be enabled depending on
-    the filtering settings.
-  - Device objects found during a scan session will only be persisted if they
-    are connected/paired otherwise they are removed after some time.
-
 :Usage: **> scan <on/off/bredr/le>**
+:<on/off/bredr/le>: Scan mode - "on", "off", "bredr" for Classic, or "le" for Low Energy (required)
+:Example Start scanning for all device types (LE + Classic):
+	| **> scan on**
+:Example Stop scanning:
+	| **> scan off**
+:Example Scan for Low Energy devices only:
+	| **> scan le**
+:Example Scan for BR/EDR (Classic) devices only:
+	| **> scan bredr**
 
 pair
 ----
@@ -161,7 +208,14 @@ connection before pairing.
 Before pairing the agent must be selected to choose the authentication
 mechanism.
 
-:Usage: **> pair <dev>**
+:Usage: **> pair [dev]**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) (optional, uses current device if omitted)
+:Example Pair with device using MAC address:
+	| **> pair 00:11:22:33:44:55**
+:Example Pair with another device:
+	| **> pair AA:BB:CC:DD:EE:FF**
+:Example Pair using device object path:
+	| **> pair /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 pairable
 --------
@@ -172,6 +226,11 @@ This enables/disables pairing. If pairing is disabled then the controller will
 not accept any pairing requests.
 
 :Usage: **> pairable <on/off>**
+:<on/off>: Pairable mode - "on" to accept or "off" to reject pairing requests (required)
+:Example Enable pairing (accept pairing requests):
+	| **> pairable on**
+:Example Disable pairing (reject pairing requests):
+	| **> pairable off**
 
 discoverable
 ------------
@@ -189,6 +248,11 @@ It will use a random address if supported by the controller. The length of time
 "discoverable on" is valid is determined by discoverable-timeout command.
 
 :Usage: **> discoverable <on/off>**
+:<on/off>: Discoverable mode - "on" to be discoverable or "off" to be non-discoverable (required)
+:Example Make controller discoverable to other devices:
+	| **> discoverable on**
+:Example Make controller non-discoverable:
+	| **> discoverable off**
 
 discoverable-timeout
 --------------------
@@ -198,6 +262,17 @@ Set discoverable timeout.
 The time in seconds that "discoverable on" is valid.
 
 :Usage: **> discoverable-timeout [value]**
+:[value]: Timeout duration in seconds for discoverable mode (0 for unlimited, optional)
+:Example Show current discoverable timeout value:
+	| **> discoverable-timeout**
+:Example Set discoverable timeout to 30 seconds:
+	| **> discoverable-timeout 30**
+:Example Set discoverable timeout to 2 minutes:
+	| **> discoverable-timeout 120**
+:Example Set discoverable timeout to 5 minutes:
+	| **> discoverable-timeout 300**
+:Example Set unlimited discoverable timeout:
+	| **> discoverable-timeout 0**
 
 agent
 -----
@@ -210,7 +285,22 @@ for pairing and allows you to choose the IO capabilities of the controller.
 The valid agent capabilities are: DisplayOnly, DisplayYesNo, KeyboardDisplay,
 KeyboardOnly, NoInputNoOutput.
 
-:Usage: **> agent <on/off/capability>**
+:Usage: **> agent <on/off/auto/capability>**
+:<on/off/auto/capability>: Agent mode - "on", "off", "auto", or capability type (DisplayOnly, DisplayYesNo, KeyboardDisplay, KeyboardOnly, NoInputNoOutput) (required)
+:Example Enable agent with default capability:
+	| **> agent on**
+:Example Disable agent:
+	| **> agent off**
+:Example Enable agent that can only display pairing codes:
+	| **> agent DisplayOnly**
+:Example Enable agent that can display codes and accept/reject:
+	| **> agent DisplayYesNo**
+:Example Enable agent that can display and input pairing codes:
+	| **> agent KeyboardDisplay**
+:Example Enable agent that can only input pairing codes:
+	| **> agent KeyboardOnly**
+:Example Enable agent with no input/output (JustWorks):
+	| **> agent NoInputNoOutput**
 
 default-agent
 -------------
@@ -220,33 +310,63 @@ Set current agent as the default one.
 After selecting the agent this will make it the default agent.
 
 :Usage: **> default-agent**
+:Example Set the current agent as default:
+	| **> default-agent**
 
 trust
 -----
 
 Trust device.
 
-:Usage: **> trust <dev>**
+:Usage: **> trust [dev]**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (optional, uses current device if omitted)
+:Example Trust device using MAC address:
+	| **> trust 00:11:22:33:44:55**
+:Example Trust another device:
+	| **> trust AA:BB:CC:DD:EE:FF**
+:Example Trust device using object path:
+	| **> trust /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 untrust
 -------
 
 Untrust device.
 
-:Usage: **> untrust <dev>**
+:Usage: **> untrust [dev]**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (optional, uses current device if omitted)
+:Example Remove trust from device using MAC address:
+	| **> untrust 00:11:22:33:44:55**
+:Example Remove trust from another device:
+	| **> untrust AA:BB:CC:DD:EE:FF**
+:Example Remove trust using object path:
+	| **> untrust /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 block
 -----
 
 Block device.
 
-:Usage: **> block <dev>**
+:Usage: **> block [dev]**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (optional, uses current device if omitted)
+:Example Block device using MAC address:
+	| **> block 00:11:22:33:44:55**
+:Example Block another device:
+	| **> block AA:BB:CC:DD:EE:FF**
+:Example Block device using object path:
+	| **> block /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 unblock
 -------
 Unblock device
 
-:Usage: **> unblock <dev>**
+:Usage: **> unblock [dev]**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (optional, uses current device if omitted)
+:Example Unblock device using MAC address:
+	| **> unblock 00:11:22:33:44:55**
+:Example Unblock another device:
+	| **> unblock AA:BB:CC:DD:EE:FF**
+:Example Unblock device using object path:
+	| **> unblock /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 remove
 ------
@@ -254,6 +374,13 @@ remove
 Remove device.
 
 :Usage: **> remove <dev>**
+:<dev>: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (required)
+:Example Remove device using MAC address:
+	| **> remove 00:11:22:33:44:55**
+:Example Remove another device:
+	| **> remove AA:BB:CC:DD:EE:FF**
+:Example Remove device using object path:
+	| **> remove /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 connect
 -------
@@ -277,10 +404,30 @@ le-connection-abort-by-local error will be issued. In that case either try
 again to connect assuming the device is advertising.
 
 :Usage: **> connect <dev> [uuid]**
-:Example: **> connect 1C:48:F9:9D:81:5C**
-:Example: **> connect 1C:48:F9:9D:81:5C hsp-hs**
-:Example: **> connect 1C:48:F9:9D:81:5C 00001108-0000-1000-8000-00805f9b34fb**
-:Example: **> connect 1C:48:F9:9D:81:5C 0x1108**
+:<dev>: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (required)
+:[uuid]: Specific service UUID to connect to (16-bit, 128-bit UUID, or profile name like "a2dp-sink", "hfp-hf", etc.) (optional)
+:Example Connect to device (all supported profiles):
+	| **> connect 1C:48:F9:9D:81:5C**
+:Example Connect to HSP Headset profile:
+	| **> connect 1C:48:F9:9D:81:5C hsp-hs**
+:Example Connect to A2DP Sink profile:
+	| **> connect 1C:48:F9:9D:81:5C a2dp-sink**
+:Example Connect to A2DP Source profile:
+	| **> connect 1C:48:F9:9D:81:5C a2dp-source**
+:Example Connect to HFP Hands-Free profile:
+	| **> connect 1C:48:F9:9D:81:5C hfp-hf**
+:Example Connect to HFP Audio Gateway profile:
+	| **> connect 1C:48:F9:9D:81:5C hfp-ag**
+:Example Connect to File Transfer Profile:
+	| **> connect 1C:48:F9:9D:81:5C ftp**
+:Example Connect to Serial Port Profile:
+	| **> connect 1C:48:F9:9D:81:5C spp**
+:Example Connect using full 128-bit UUID (HSP):
+	| **> connect 1C:48:F9:9D:81:5C 00001108-0000-1000-8000-00805f9b34fb**
+:Example Connect using short 16-bit UUID (HSP):
+	| **> connect 1C:48:F9:9D:81:5C 0x1108**
+:Example Connect to A2DP profile using short UUID:
+	| **> connect 1C:48:F9:9D:81:5C 0x110E**
 
 disconnect
 ----------
@@ -294,14 +441,35 @@ service will be disconnected.
 For LE when disconnecting from an active connection the device address is not
 needed.
 
-:Usage: **> disconnect <dev> [uuid]**
+:Usage: **> disconnect [dev] [uuid]**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (optional, uses current device if omitted)
+:[uuid]: Specific service UUID to disconnect from (16-bit, 128-bit UUID, or profile name) (optional)
+:Example Disconnect all profiles and terminate connection:
+	| **> disconnect 1C:48:F9:9D:81:5C**
+:Example Disconnect only A2DP Sink profile:
+	| **> disconnect 1C:48:F9:9D:81:5C a2dp-sink**
+:Example Disconnect only HFP Hands-Free profile:
+	| **> disconnect 1C:48:F9:9D:81:5C hfp-hf**
+:Example Disconnect only Serial Port Profile:
+	| **> disconnect 1C:48:F9:9D:81:5C spp**
+:Example Disconnect A2DP profile using short UUID:
+	| **> disconnect 1C:48:F9:9D:81:5C 0x110E**
+:Example Disconnect HSP profile using full UUID:
+	| **> disconnect 1C:48:F9:9D:81:5C 00001108-0000-1000-8000-00805f9b34fb**
 
 info
 ----
 
 Device information.
 
-:Usage: **> info <dev>**
+:Usage: **> info [dev/set]**
+:[dev/set]: Device MAC address (XX:XX:XX:XX:XX:XX), object path, or DeviceSet (optional, uses current device if omitted)
+:Example Show detailed information for device:
+	| **> info 1C:48:F9:9D:81:5C**
+:Example Show information for another device:
+	| **> info 00:11:22:33:44:55**
+:Example Show device info using object path:
+	| **> info /org/bluez/hci0/dev_1C_48_F9_9D_81_5C**
 
 bearer
 ------
@@ -309,6 +477,8 @@ bearer
 Get/Set preferred bearer.
 
 :Usage: **> bearer <dev> [last-seen/bredr/le]**
+:<dev>: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (required)
+:[last-seen/bredr/le]: Preferred bearer type - "last-seen", "bredr" for Classic, or "le" for Low Energy (optional)
 :Example get preferred bearer:
 	| > bearer <addr>
         |    PreferredBearer: last-seen
-- 
2.52.0

