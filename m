Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2092FE58C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801975; cv=none; b=qQvWEVY/wdVdua5XPUHzpc1VbKfBooYc+6TSkD1dDxBF5gkDqpsUtEoX1E3pUQDmPGz0XdWdY0X8PnKbAv8Ldc21DRWEjf+tL2A61f6tW3kuOUxT8pjIp3l3Uj//Wxj6h0mMSYBqHueY0VUZEDgoLo6BLoLHXCK2M9R44Ny4qwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801975; c=relaxed/simple;
	bh=Gp2ZQhlDQUA5rfaglqMPIIItz8RetHZyRx+z6uguYS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dj6y2f4vEdR+Y6wQ8V+xafrN0W1Sj9o1Dk9N+UvlAhybrjT6jbYAqtz/UuZW6gojkcZUvuBbuNuAtU/Bb/TVBMttX8YLlTAb7+dUgg9u/lB1AFGnZ1feoDN4/bnn7zq+FrMxbT3QngQlvbZqxDbnPFqKDxim1LGNTUXSqzhgbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOxaoZb2; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOxaoZb2"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-56638fca064so805358e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801972; x=1770406772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W58PusbtFLGvbEf3XP5sq64WKSFf0iRbFwuyrzt7CCs=;
        b=EOxaoZb27FvG7zXzrjZW4vXq0BMrILtcwvYaOOz5JRrobpn+x4cdEEEB1cKO+0aWp7
         xipOyes/i7xNiA/0oAwUY2OwH8+XHURFFwiDmQC6Li9LbfbEboYsNscGyTj763xYjxWI
         iRH6oh5Wz3cPI9xUW0QbLUbWwMw4FWxkFdMyuYYFNx6mmEctAZvBzmITZlH48cJJ4pRh
         H20GJAF/wPS7JgvHzxePatqNIlO/jkLk5y79BYH0f+MxFtZYYTF/+rW6u1WT3oiGKAiO
         4cPZVIfsmMZu8ewpNJVgX4fcGWUej3elCtZiu6CbIhbk+V7xW4p+UhlkJsOCBdwiVVk4
         PlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801972; x=1770406772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W58PusbtFLGvbEf3XP5sq64WKSFf0iRbFwuyrzt7CCs=;
        b=jTF6krlt0dQTVkMpkg9Vyb5ixOF0aOlIBxB49gYL2qNdLKAtATTlM+mg1ymcCDh+aO
         S4NY19ctRYgX4Kodq1XOnmkTKESM1hwGtqBWGFgLTX0NpX9pCxq1/CMBHp6A6bVHZCL1
         c5DcY4KBk6TDhY63rzoxFAjX0dsU3UW6zZeV3L/HCkoP092Xm8Ksdc/8OE73W4tVxk8B
         +qApLii0duzA/e155kutD3BxwbCWvWvD6PjyVKCP19K5M1NKpDbDb/F0Wj+TKWy0ly+M
         tiKZ9XZCF3besKFNyP+sEAR+VHMWn60D+s6LbXN6drIqLcFFPomFkaXGIrfzFqLCbLT/
         mPHQ==
X-Gm-Message-State: AOJu0Yy6P7ageVzX7GoLG1npO5ZlAMU+t5Qwv3F23IwiV2/i4s/BlJmP
	nERCQX190gFm2XxmelTzU9C3tg/wSkDXTzVy0WnZGagLrZc0E9DgQZxuedDQlDx4
X-Gm-Gg: AZuq6aIe+Iir0POw2E3jNCLHE5F6IppXFaDOEUzpw+76FxaYnN5N/nDYdT8LTgGCFaB
	I3r++cJTwiymKFwBCgDgr6qDCVt/nAAIBpP92MZqE5+8EfUn+Vb/mm5py6lQi/Th5Z0ntfRg4Gp
	VjuReOnJNSu+NzSz+zmnR+xRUa9HqPzejglxUKS/PGSVDxIk1PCly8C+6GwxzbjRCr1Mrf7c39L
	vtPgRAKEJ8hEYhUpQKM4CmCT2b/wGhEOpzzR43rKy8tY1e9cM4trkmjv0vBWekQQFv2JFt4kBQ9
	5pavNgIMkQFftfvT2Rovw+oTaXbOh9uSSZqYPYboew3ZEGsBlmxdGrBWu0wLqyZOET8eWXyO/cM
	vzwek8kAuzgZD/UKq/xFUtshQOuTTE6FrbH6f/l/UaT3GHT5/Lp+q15nDVUXwUZHzCP+0x0bI0Y
	oMn7DQ9i+SmyA2ojWLfIT72+CKGURIHNvZzGSf/Y03NLbX1dUxCdcff1nGqu1/Ka9SDrAvbIjGf
	95A5w==
X-Received: by 2002:a05:6122:1ac1:b0:559:5dbe:fe29 with SMTP id 71dfb90a1353d-566a0053467mr1049544e0c.2.1769801971934;
        Fri, 30 Jan 2026 11:39:31 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/35] doc/bluetoothctl: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:43 -0500
Message-ID: <20260130193921.1273263-2-luiz.dentz@gmail.com>
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

