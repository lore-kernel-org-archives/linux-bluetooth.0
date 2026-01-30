Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D132ED2E
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811603; cv=none; b=A0E/J+fWoOyjnEjQf/jjVquL3Y/o8fblEMWsiuKwwjs+yatSMMafIe026eB2RPD1QDUHRShglXKyUm3sKQMhjwO6+ubyVgccAUoEojmLw6kUAp19XQMl2WXKhdTveSAkLtkl964ru+km/gWrFmR4ieNMo1dlHiuAgFHvXGf66z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811603; c=relaxed/simple;
	bh=ZqevtvBYc6SRrUYi3ohyosEYrgX/PcZ6MevzhmigEHQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ig3HkPJJxrH/Xt3k8tay3TXBywCJb1rZiPbR0fhTk60JUQejqr9tkfeV2mRp31cYjHts7cE/xqEmPCxtw0qwJkCdnNa4/0SIaecOO17y/qudv2a08/rUgneP3U9zpl4fVsor4IA3NOt0XNZBHt+iwGkErkb98MuNLPYD0/JDaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=i/BGJKRk; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="i/BGJKRk"
Received: from github.com (hubbernetes-node-b618d5b.ac4-iad.github.net [10.52.202.86])
	by smtp.github.com (Postfix) with ESMTPA id 81C4E400446
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769811600;
	bh=ZwKq7JvDEQ7RWKEjBC/LxzeIUEnSojJ//otO5eM+83g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=i/BGJKRkdK7ZIpfiU8S7bMnNOpp1XsnWV1dYAvyS+VMQuWQyUZIuA0HsK2vBqYsLI
	 uvcodi0/mciJ/ZfJMChbBSsuh+40uFdX4LYVXUhReuVR4tG6A+eo9xRg86Ns2Yp20c
	 GFL2H2+W6WPwSlqfCHySVL+LOT3aDNLskCAY++UE=
Date: Fri, 30 Jan 2026 14:20:00 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049160/000000-6f2217@github.com>
Subject: [bluez/bluez] 97bb8a: doc/bluetoothctl: Add :Uses: fields and
 document a...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1049160
  Home:   https://github.com/bluez/bluez
  Commit: 97bb8a6799d2f624008a36aac3c3743163fe73d8
      https://github.com/bluez/bluez/commit/97bb8a6799d2f624008a36aac3c3743163fe73d8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  doc/bluetoothctl: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: eec843bb56d2bac8b19d1caf61239b7c4647e5f3
      https://github.com/bluez/bluez/commit/eec843bb56d2bac8b19d1caf61239b7c4647e5f3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-mgmt.rst

  Log Message:
  -----------
  doc/bluetoothctl-mgmt: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: bb186c4a1df078d553a36c2692f100c15682679f
      https://github.com/bluez/bluez/commit/bb186c4a1df078d553a36c2692f100c15682679f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-admin.rst

  Log Message:
  -----------
  doc/bluetoothctl-admin: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 291670518410cb8879c375a5424985d28e198b2a
      https://github.com/bluez/bluez/commit/291670518410cb8879c375a5424985d28e198b2a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-advertise.rst

  Log Message:
  -----------
  doc/bluetoothctl-advertise: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 95839e0e9b1c9839d2af3d6f674cff516fd7556a
      https://github.com/bluez/bluez/commit/95839e0e9b1c9839d2af3d6f674cff516fd7556a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-assistant.rst

  Log Message:
  -----------
  doc/bluetoothctl-assistant: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: fff64bdf3e1e526b41c413a3e2027832bd814eac
      https://github.com/bluez/bluez/commit/fff64bdf3e1e526b41c413a3e2027832bd814eac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-bredr.rst

  Log Message:
  -----------
  doc/bluetoothctl-bredr: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: cf9f3ae75ed091d6fff3cf55a4a82e001dd006a8
      https://github.com/bluez/bluez/commit/cf9f3ae75ed091d6fff3cf55a4a82e001dd006a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-endpoint.rst

  Log Message:
  -----------
  doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 8f9db122187ede4f408a7b173479cdf2af9e9121
      https://github.com/bluez/bluez/commit/8f9db122187ede4f408a7b173479cdf2af9e9121
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-gatt.rst

  Log Message:
  -----------
  doc/bluetoothctl-gatt: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: a17aa6c2ad1cdebcfe8a0f89f3c8465026d5fa77
      https://github.com/bluez/bluez/commit/a17aa6c2ad1cdebcfe8a0f89f3c8465026d5fa77
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-hci.rst

  Log Message:
  -----------
  doc/bluetoothctl-hci: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 4865dc88c72b30042d4f402acc24c5287d1eb2fa
      https://github.com/bluez/bluez/commit/4865dc88c72b30042d4f402acc24c5287d1eb2fa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-le.rst

  Log Message:
  -----------
  doc/bluetoothctl-le: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: d8005e0846c9ee60c8848503afb895f35b205e06
      https://github.com/bluez/bluez/commit/d8005e0846c9ee60c8848503afb895f35b205e06
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-monitor.rst

  Log Message:
  -----------
  doc/bluetoothctl-monitor: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 7878c62f32e66ddd69ff8dbb74126fb4482efcfc
      https://github.com/bluez/bluez/commit/7878c62f32e66ddd69ff8dbb74126fb4482efcfc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-player.rst

  Log Message:
  -----------
  doc/bluetoothctl-player: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: d02befa5bc1c17471394850cd6f3cd8e2bf85c39
      https://github.com/bluez/bluez/commit/d02befa5bc1c17471394850cd6f3cd8e2bf85c39
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-scan.rst

  Log Message:
  -----------
  doc/bluetoothctl-scan: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 51dbc6d71a4899e61024da763883eccef8033a64
      https://github.com/bluez/bluez/commit/51dbc6d71a4899e61024da763883eccef8033a64
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-telephony.rst

  Log Message:
  -----------
  doc/bluetoothctl-telephony: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 360df72885356c0ae3ca6393fd9e56c7085b84cb
      https://github.com/bluez/bluez/commit/360df72885356c0ae3ca6393fd9e56c7085b84cb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-transport.rst

  Log Message:
  -----------
  doc/bluetoothctl-transport: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 7ecf0d3ab5185bc3c9c40a8332a69c76db2b487a
      https://github.com/bluez/bluez/commit/7ecf0d3ab5185bc3c9c40a8332a69c76db2b487a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  doc/org.bluez.Adapter: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.


  Commit: a495b14dd0f3e46fb5ca02b8f3ec34c5292f9d1a
      https://github.com/bluez/bluez/commit/a495b14dd0f3e46fb5ca02b8f3ec34c5292f9d1a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicySet.rst

  Log Message:
  -----------
  doc/org.bluez.AdminPolicySet: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-admin and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.


  Commit: 417c6a2fc78bf69042ea8af24b02e36a52f083bb
      https://github.com/bluez/bluez/commit/417c6a2fc78bf69042ea8af24b02e36a52f083bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicyStatus.rst

  Log Message:
  -----------
  doc/org.bluez.AdminPolicyStatus: Add Used by reference

Add :Used by: field linking to bluetoothctl-admin for this interface
which exposes properties read by admin policy commands.


  Commit: 060c46853dbc62b3c674e616438c0a9a2ebdf9e1
      https://github.com/bluez/bluez/commit/060c46853dbc62b3c674e616438c0a9a2ebdf9e1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdvertisementMonitor.rst

  Log Message:
  -----------
  doc/org.bluez.AdvertisementMonitor: Add Used by reference

Add :Used by: field linking to bluetoothctl-monitor for this callback
interface implemented by advertisement monitor clients.


  Commit: aa5a84f765c05701d36ab31527326495c816134e
      https://github.com/bluez/bluez/commit/aa5a84f765c05701d36ab31527326495c816134e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AdvertisementMonitorManager.rst

  Log Message:
  -----------
  doc/org.bluez.AdvertisementMonitorManager: Add Used by reference

Add :Used by: field linking to bluetoothctl-monitor for this interface
used to register advertisement monitors.


  Commit: fa2e3bde3808131907f584879e37acd960f3dc4f
      https://github.com/bluez/bluez/commit/fa2e3bde3808131907f584879e37acd960f3dc4f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.AgentManager.rst

  Log Message:
  -----------
  doc/org.bluez.AgentManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for agent methods.


  Commit: 15ee283a5cefd3fd632ac4e49d2a70209a53b787
      https://github.com/bluez/bluez/commit/15ee283a5cefd3fd632ac4e49d2a70209a53b787
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Call.rst

  Log Message:
  -----------
  doc/org.bluez.Call: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl commands for call methods.


  Commit: 9fb5c88b1fa29c36a4b4767aa3ee221de6d0e459
      https://github.com/bluez/bluez/commit/9fb5c88b1fa29c36a4b4767aa3ee221de6d0e459
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/org.bluez.Device: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for device methods.


  Commit: 73d64747c328b62285b66366065b7ab31ae72879
      https://github.com/bluez/bluez/commit/73d64747c328b62285b66366065b7ab31ae72879
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst

  Log Message:
  -----------
  doc/org.bluez.GattCharacteristic: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT operations.


  Commit: 843863481d20309587aeefa3a6e283e73b4d2606
      https://github.com/bluez/bluez/commit/843863481d20309587aeefa3a6e283e73b4d2606
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattDescriptor.rst

  Log Message:
  -----------
  doc/org.bluez.GattDescriptor: Add Used by reference

Add :Used by: field linking to bluetoothctl-gatt for this interface
used by GATT descriptor operations.


  Commit: 49dc2518d82102cda1879d12cb94d98a874f8784
      https://github.com/bluez/bluez/commit/49dc2518d82102cda1879d12cb94d98a874f8784
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattManager.rst

  Log Message:
  -----------
  doc/org.bluez.GattManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT application methods.


  Commit: 35f0dfd3bbee672784ac01c8b22e091263b13734
      https://github.com/bluez/bluez/commit/35f0dfd3bbee672784ac01c8b22e091263b13734
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.GattService.rst

  Log Message:
  -----------
  doc/org.bluez.GattService: Add Used by reference

Add :Used by: field linking to bluetoothctl-gatt for this interface
exposing GATT service properties.


  Commit: 7235f9fad979bd513229ab97a2cf6634ddd0ec0e
      https://github.com/bluez/bluez/commit/7235f9fad979bd513229ab97a2cf6634ddd0ec0e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst

  Log Message:
  -----------
  doc/org.bluez.LEAdvertisement: Add Used by reference

Add :Used by: field linking to bluetoothctl-advertise for this callback
interface implemented by LE advertisement clients.


  Commit: a3c437bc5f775b561c74f90b2f6afab1a1cc6d89
      https://github.com/bluez/bluez/commit/a3c437bc5f775b561c74f90b2f6afab1a1cc6d89
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisingManager.rst

  Log Message:
  -----------
  doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-advertise and Examples
sections showing corresponding bluetoothctl advertising commands.


  Commit: 27886e520c4fd1c9ee212a2b401a3a59e013346f
      https://github.com/bluez/bluez/commit/27886e520c4fd1c9ee212a2b401a3a59e013346f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Media.rst

  Log Message:
  -----------
  doc/org.bluez.Media: Add Used by reference

Add :Used by: field linking to bluetoothctl-endpoint for this interface
used for media endpoint registration.


  Commit: 73a5643296e0dd1d45741aeaf1fe246de47005c1
      https://github.com/bluez/bluez/commit/73a5643296e0dd1d45741aeaf1fe246de47005c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  doc/org.bluez.MediaAssistant: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-assistant and Examples
sections showing corresponding bluetoothctl assistant commands.


  Commit: f9b9a36e5c125fcac4daa59de4356a1b7e896e14
      https://github.com/bluez/bluez/commit/f9b9a36e5c125fcac4daa59de4356a1b7e896e14
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc/org.bluez.MediaEndpoint: Add Used by reference

Add :Used by: field linking to bluetoothctl-endpoint for this callback
interface implemented by media endpoint clients.


  Commit: e9768db011384f5c1dd44bed123bd3f7ecd5a80f
      https://github.com/bluez/bluez/commit/e9768db011384f5c1dd44bed123bd3f7ecd5a80f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaPlayer.rst

  Log Message:
  -----------
  doc/org.bluez.MediaPlayer: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-player and Examples sections
showing corresponding bluetoothctl player commands.


  Commit: 6c6f6829eebb48d239ae6cdcad47c0998ef54e02
      https://github.com/bluez/bluez/commit/6c6f6829eebb48d239ae6cdcad47c0998ef54e02
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/org.bluez.MediaTransport: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-transport and Examples
sections showing corresponding bluetoothctl transport commands.


  Commit: 39c78bddb044c791dd4a3c7008d212274c938337
      https://github.com/bluez/bluez/commit/39c78bddb044c791dd4a3c7008d212274c938337
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.Telephony.rst

  Log Message:
  -----------
  doc/org.bluez.Telephony: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl telephony commands.


  Commit: b09755abf0356eff2c37521fc1fce0a93f9b5bb3
      https://github.com/bluez/bluez/commit/b09755abf0356eff2c37521fc1fce0a93f9b5bb3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaFolder.rst

  Log Message:
  -----------
  doc/org.bluez.MediaFolder: Add Used by reference and Examples


  Commit: 6f2217d5be56735d49d03e2d1654d405f06ed337
      https://github.com/bluez/bluez/commit/6f2217d5be56735d49d03e2d1654d405f06ed337
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-30 (Fri, 30 Jan 2026)

  Changed paths:
    M doc/org.bluez.MediaItem.rst

  Log Message:
  -----------
  doc/org.bluez.MediaItem: Add Used by reference and Examples


Compare: https://github.com/bluez/bluez/compare/97bb8a6799d2%5E...6f2217d5be56

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
