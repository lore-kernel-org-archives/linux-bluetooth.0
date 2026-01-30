Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B92EB5CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810565; cv=none; b=kpwtS5JF5y9h5UuHRWajcIcLB4l4yuM9u53IEqrUMD4HrZ/MFXnDc8GDELRnt+tng2q4hRYedr/zP32FgHarT2Z7iLI8f7qIWttqOH8BDG+zRc3hetQXfk0vkTTeE1YGDb6XpAuDj6G04sI9XTbCNPfGgXMx3HJwb0YDuAHyY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810565; c=relaxed/simple;
	bh=Gp2ZQhlDQUA5rfaglqMPIIItz8RetHZyRx+z6uguYS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reM1Fu48lTZk7F/sXqR0dYoGZV3LpUYfzsR/XD4nXb7dPmiye1B6DbVqNuqaIh9p3pLzhNhOXk8NYlNXkWyK7YunVl7qBoVFdGoXy/i+jiW/atC4UkoEAQlYhdDo3cdMp5PX0Pn7L82P63xmS0wNW4ODF/jiL5NtvHkFmPOFGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAFvbHNf; arc=none smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAFvbHNf"
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-948a374845fso47501241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810562; x=1770415362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W58PusbtFLGvbEf3XP5sq64WKSFf0iRbFwuyrzt7CCs=;
        b=nAFvbHNfpE5qtrlRRhWNkSb6lDwdLIuY+QemYGwol6JAD12g790Fhh0PR+i+/V5rok
         P9sOdx28CquvH2iOnZjl6TnPehZ4k45L0u3LMvMUpN3HNX8puxHxWEX8+pScMNjuWMQt
         QQfioOvLG36qUfyZyGVyOKvzVP1DBlBSu8ZqNWOp6wLFF55N8cbam/GlNHNrC4sqStcm
         V1JxALVWumAK97b+h88rR7wF6M0CuQBYJYtwErdOtKb2mo31VS9de10yPnkKuJ4+vid6
         2EFtGeh3TMV2N8YOXJxZyCJaWbxwaFD8W5aJkxLxI9peZCSClPNFMyia9qv29dy3AMwX
         vAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810562; x=1770415362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W58PusbtFLGvbEf3XP5sq64WKSFf0iRbFwuyrzt7CCs=;
        b=dQeOfgmA/Z8tuSW9aXLxWd8eLElLqHmBKadlPJi2XujaHnnEIWyyHLKKQbFa3tUQTS
         ofjurFdEtJSbqJGGKhL8bzfl3x6Cx6Sw5KOlxXKBRp8c9lm2zBaht2gL1zKRwWj3y06l
         qDHrmMD/A/Gk1+hGvDtfZ2h4uaNUfDew+pfefVVA9w7gqilcws4ci09G641XkkpOWy5v
         iS6pGtDVkEgBFosPob3w4Om+fxB1PkgHk49Q7jxmwDgq1WEDkwy0Fvmx23RB7Fu3P7Kb
         IzOn9+6Xhaw73tglQFD2RJXzDwsjv39TX7PwKs4lWMlrFtpqVxQcsPCZtmH1z0rmVc2Y
         JfOA==
X-Gm-Message-State: AOJu0Yz0nd2jZYIe7/99zqRUM9cPOdLL1LMpmf3Qhpo5GyUJvxIfCUue
	3oF84PmlbIJsq3ePD4x0SN1Ptm8L7VLsMmOesGbp/8nVTmSTL/YMchDhK75FGvKr
X-Gm-Gg: AZuq6aLkGFXjB3g6bUdAE7FUuRdJM4MqJ8g1D8Fi33pD4I+K9yAtlT+ruUBSufH2jFP
	k/0p5aBBRs3NI5AlDohYJaubssVsUZUXotPuiWnUQdTsAOGweVhaCYPGHhj/3U+Z4/zzNLndQpA
	mNz4qcqZJVlL1QoXcLE3SXjLGqlSsYaJc9TLSAhp3TpjdPM02A9okSJXeW4e+34DMXU9neJe24i
	rPR/FjpOe1uzYzdAs1iEC7tPQjaOHkMOXV22QuJx4dUp/NHuhMHFGZ5xkwVu/a9BgRqL6HVkzjv
	DAcS82FBvMer4mWqHT2xhDFbKV5K6Ldd+o0Pcarsi9MZDlIRGm5qXeF8fpVfSw4TRdh44jHTbGg
	Un773l/BrTpyb9iw2LlyxAUTAfwdebwKGdck6xKmHWYWn9cWPBpTVHtBkdcJT8tiNPlPb4hWcFs
	yd0NaaqrGJQbJYFFsGuejSCz5O29PGLi+jtcy+Kfv+KXZH/CYz9xWw8QubT7kuj5v8grfKAqp17
	J8SDg==
X-Received: by 2002:a05:6102:5106:b0:5f5:884d:b78d with SMTP id ada2fe7eead31-5f8e25b3840mr1385285137.25.1769810561601;
        Fri, 30 Jan 2026 14:02:41 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.02.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:02:40 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 01/37] doc/bluetoothctl: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 17:01:52 -0500
Message-ID: <20260130220229.1346261-2-luiz.dentz@gmail.com>
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
 doc/bluetoothctl.rst | 250 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 223 insertions(+), 27 deletions(-)

diff --git a/doc/bluetoothctl.rst b/doc/bluetoothctl.rst
index f8d6c3457977..0c55092b880f 100644
--- a/doc/bluetoothctl.rst
+++ b/doc/bluetoothctl.rst
@@ -28,6 +28,10 @@ Bluetooth Classic (BR/EDR) and Bluetooth Low Energy (LE) controllers.
 The tool is menu driven but can be automated from the command line.
 Examples are given in the automation section.
 
+This tool communicates with the BlueZ daemon via D-Bus, primarily using the
+**org.bluez.Adapter(5)** and **org.bluez.Device(5)** interfaces. Each command
+documents which D-Bus interface and method/property it uses.
+
 OPTIONS
 =======
 
@@ -48,6 +52,8 @@ list
 List available controllers.
 
 :Usage: **> list**
+:Example Display all Bluetooth controllers available on the system:
+	| **> list**
 
 show
 ----
@@ -55,6 +61,12 @@ show
 Controller information.
 
 :Usage: **> show [ctrl]**
+:Uses: **org.bluez.Adapter(5)** properties
+:[ctrl]: Bluetooth controller address
+:Example Display information for currently selected controller:
+	| **> show**
+:Example Show information for controller 00:11:22:33:44:55:
+	| **> show 00:11:22:33:44:55**
 
 select
 ------
@@ -62,6 +74,9 @@ select
 Select default controller.
 
 :Usage: **> select <ctrl>**
+:<ctrl>: Bluetooth controller address
+:Example Select controller 00:11:22:33:44:55:
+	| **> select 00:11:22:33:44:55**
 
 devices
 -------
@@ -69,6 +84,17 @@ devices
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
@@ -76,6 +102,14 @@ system-alias
 Set controller alias.
 
 :Usage: **> system-alias <name>**
+:Uses: **org.bluez.Adapter(5)** property **Alias**
+:<name>: New alias name for the Bluetooth controller (required)
+:Example Set controller alias with spaces (note quotes):
+	| **> system-alias "My Desktop Bluetooth"**
+:Example Set controller alias without spaces:
+	| **> system-alias MyLaptop**
+:Example Set controller alias with hyphens:
+	| **> system-alias "Home-Office-PC"**
 
 reset-alias
 -----------
@@ -83,6 +117,9 @@ reset-alias
 Reset controller alias.
 
 :Usage: **> reset-alias**
+:Uses: **org.bluez.Adapter(5)** property **Alias**
+:Example Reset controller alias to default (usually the hostname):
+	| **> reset-alias**
 
 power
 -----
@@ -93,15 +130,20 @@ When the controller is powered off, the USB port the controller is attached to
 is put into a suspend state.
 
 :Usage: **> power <on/off>**
+:Uses: **org.bluez.Adapter(5)** property **Powered**
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
 
@@ -109,6 +151,16 @@ A device can advertise if it initiated the connection to another advertising
 device.
 
 :Usage: **> advertise <on/off/type>**
+:Uses: **org.bluez.LEAdvertisingManager(5)** method **RegisterAdvertisement**
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
@@ -116,6 +168,14 @@ set-alias
 Set device alias.
 
 :Usage: **> set-alias <alias>**
+:Uses: **org.bluez.Device(5)** property **Alias**
+:<alias>: New alias name for the device (required)
+:Example Set device alias with spaces (note quotes):
+	| **> set-alias "My Headphones"**
+:Example Set device alias without spaces:
+	| **> set-alias MyMouse**
+:Example Set device alias with hyphens:
+	| **> set-alias "Kitchen-Speaker"**
 
 scan
 ----
@@ -128,19 +188,17 @@ The purpose of scanning is to find devices that are advertising with their
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
+:Uses: **org.bluez.Adapter(5)** methods **StartDiscovery**, **StopDiscovery**
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
@@ -161,7 +219,15 @@ connection before pairing.
 Before pairing the agent must be selected to choose the authentication
 mechanism.
 
-:Usage: **> pair <dev>**
+:Usage: **> pair [dev]**
+:Uses: **org.bluez.Device(5)** method **Pair**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) (optional, uses current device if omitted)
+:Example Pair with device using MAC address:
+	| **> pair 00:11:22:33:44:55**
+:Example Pair with another device:
+	| **> pair AA:BB:CC:DD:EE:FF**
+:Example Pair using device object path:
+	| **> pair /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 pairable
 --------
@@ -172,6 +238,12 @@ This enables/disables pairing. If pairing is disabled then the controller will
 not accept any pairing requests.
 
 :Usage: **> pairable <on/off>**
+:Uses: **org.bluez.Adapter(5)** property **Pairable**
+:<on/off>: Pairable mode - "on" to accept or "off" to reject pairing requests (required)
+:Example Enable pairing (accept pairing requests):
+	| **> pairable on**
+:Example Disable pairing (reject pairing requests):
+	| **> pairable off**
 
 discoverable
 ------------
@@ -189,6 +261,12 @@ It will use a random address if supported by the controller. The length of time
 "discoverable on" is valid is determined by discoverable-timeout command.
 
 :Usage: **> discoverable <on/off>**
+:Uses: **org.bluez.Adapter(5)** property **Discoverable**
+:<on/off>: Discoverable mode - "on" to be discoverable or "off" to be non-discoverable (required)
+:Example Make controller discoverable to other devices:
+	| **> discoverable on**
+:Example Make controller non-discoverable:
+	| **> discoverable off**
 
 discoverable-timeout
 --------------------
@@ -198,6 +276,18 @@ Set discoverable timeout.
 The time in seconds that "discoverable on" is valid.
 
 :Usage: **> discoverable-timeout [value]**
+:Uses: **org.bluez.Adapter(5)** property **DiscoverableTimeout**
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
@@ -210,7 +300,23 @@ for pairing and allows you to choose the IO capabilities of the controller.
 The valid agent capabilities are: DisplayOnly, DisplayYesNo, KeyboardDisplay,
 KeyboardOnly, NoInputNoOutput.
 
-:Usage: **> agent <on/off/capability>**
+:Usage: **> agent <on/off/auto/capability>**
+:Uses: **org.bluez.AgentManager(5)** method **RegisterAgent**
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
@@ -220,33 +326,68 @@ Set current agent as the default one.
 After selecting the agent this will make it the default agent.
 
 :Usage: **> default-agent**
+:Uses: **org.bluez.AgentManager(5)** method **RequestDefaultAgent**
+:Example Set the current agent as default:
+	| **> default-agent**
 
 trust
 -----
 
 Trust device.
 
-:Usage: **> trust <dev>**
+:Usage: **> trust [dev]**
+:Uses: **org.bluez.Device(5)** property **Trusted**
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
+:Uses: **org.bluez.Device(5)** property **Trusted**
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
+:Uses: **org.bluez.Device(5)** property **Blocked**
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
+:Uses: **org.bluez.Device(5)** property **Blocked**
+:[dev]: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (optional, uses current device if omitted)
+:Example Unblock device using MAC address:
+	| **> unblock 00:11:22:33:44:55**
+:Example Unblock another device:
+	| **> unblock AA:BB:CC:DD:EE:FF**
+:Example Unblock device using object path:
+	| **> unblock /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 remove
 ------
@@ -254,6 +395,14 @@ remove
 Remove device.
 
 :Usage: **> remove <dev>**
+:Uses: **org.bluez.Adapter(5)** method **RemoveDevice**
+:<dev>: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (required)
+:Example Remove device using MAC address:
+	| **> remove 00:11:22:33:44:55**
+:Example Remove another device:
+	| **> remove AA:BB:CC:DD:EE:FF**
+:Example Remove device using object path:
+	| **> remove /org/bluez/hci0/dev_00_11_22_33_44_55**
 
 connect
 -------
@@ -277,10 +426,31 @@ le-connection-abort-by-local error will be issued. In that case either try
 again to connect assuming the device is advertising.
 
 :Usage: **> connect <dev> [uuid]**
-:Example: **> connect 1C:48:F9:9D:81:5C**
-:Example: **> connect 1C:48:F9:9D:81:5C hsp-hs**
-:Example: **> connect 1C:48:F9:9D:81:5C 00001108-0000-1000-8000-00805f9b34fb**
-:Example: **> connect 1C:48:F9:9D:81:5C 0x1108**
+:Uses: **org.bluez.Device(5)** methods **Connect**, **ConnectProfile**
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
@@ -294,14 +464,37 @@ service will be disconnected.
 For LE when disconnecting from an active connection the device address is not
 needed.
 
-:Usage: **> disconnect <dev> [uuid]**
+:Usage: **> disconnect [dev] [uuid]**
+:Uses: **org.bluez.Device(5)** methods **Disconnect**, **DisconnectProfile**
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
+:Uses: **org.bluez.Device(5)** properties
+:[dev/set]: Device MAC address (XX:XX:XX:XX:XX:XX), object path, or DeviceSet (optional, uses current device if omitted)
+:Example Show detailed information for device:
+	| **> info 1C:48:F9:9D:81:5C**
+:Example Show information for another device:
+	| **> info 00:11:22:33:44:55**
+:Example Show device info using object path:
+	| **> info /org/bluez/hci0/dev_1C_48_F9_9D_81_5C**
 
 bearer
 ------
@@ -309,6 +502,9 @@ bearer
 Get/Set preferred bearer.
 
 :Usage: **> bearer <dev> [last-seen/bredr/le]**
+:Uses: **org.bluez.Device(5)** property **PreferredBearer**
+:<dev>: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (required)
+:[last-seen/bredr/le]: Preferred bearer type - "last-seen", "bredr" for Classic, or "le" for Low Energy (optional)
 :Example get preferred bearer:
 	| > bearer <addr>
         |    PreferredBearer: last-seen
-- 
2.52.0

