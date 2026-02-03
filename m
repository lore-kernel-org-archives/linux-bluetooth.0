Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596AA1DE8B5
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143598; cv=none; b=nY9EXqXrSxQ8jpE1Vb+WU30a3JkSyfENLSJ9bI38i3uKVWQwkOnscksZJctJx+X34tUCM7B1bQhKrwPxF9ckidDoSlaNvSqH4gZAGwPClTmtXC+jSbvuZzdvy7hxmtV7nXROwOFzyxhDL0UBTJhbOU+kPZ+2KpT1cpbLJxX0HRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143598; c=relaxed/simple;
	bh=TD4fQiPVaDbciDOopfxpXuyUKE6lEOA9L+VVu3Q3bdU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Zus5suiLPlYgv30lqF1pDD0k7pVCIVarbzM3Gi4a8QFvDrGj7XNTAfzsAdE1W5S7vzbm5OKaGPAecrlAGn5xtuycAqCeSeGb3wPlKe+o5Y+dg1PmwoD6iIUxHqB794yVoIPrEHJWaGqNM6Pmoxfhe5DqzCogwmkTKFpHjOs8aas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZqzrkOjm; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZqzrkOjm"
Received: from github.com (hubbernetes-node-b1f14c9.va3-iad.github.net [10.48.168.30])
	by smtp.github.com (Postfix) with ESMTPA id E959E4E1482
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770143593;
	bh=gnZ1hOd4U9OuQjwwB0dqCJNWPiwO3jesTUWsG8FbfsM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZqzrkOjmZWuJY6j3oungLgPKkgec7QFPPhQ93AWooRTCxWB/q9dqgWwepXdlUgqwz
	 Ehi8esPHzs1Tjg8ebwCapdt6Rs771Zf8QJ3XqVWieCN3yBMYnFdUgh5sN/9TgA7rcl
	 x0zKrawDax/55kU3pG6Lebktfh+6ndJOto5ASDvs=
Date: Tue, 03 Feb 2026 10:33:12 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4c963f-9b54cf@github.com>
Subject: [bluez/bluez] b42840: doc/bluetoothctl: Add :Uses: fields and
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: b4284016a35bacc80c0a0c9775de2fd1050a5d28
      https://github.com/bluez/bluez/commit/b4284016a35bacc80c0a0c9775de2fd1050a5d28
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  doc/bluetoothctl: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 8153258ebe6c1d7f7a5c3eca93d7c3fb1c6ee5f1
      https://github.com/bluez/bluez/commit/8153258ebe6c1d7f7a5c3eca93d7c3fb1c6ee5f1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-mgmt.rst

  Log Message:
  -----------
  doc/bluetoothctl-mgmt: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 7213d8dfd04157ad4fec918c22dd5c0ea31fc6d2
      https://github.com/bluez/bluez/commit/7213d8dfd04157ad4fec918c22dd5c0ea31fc6d2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-admin.rst

  Log Message:
  -----------
  doc/bluetoothctl-admin: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: c5715df9adb1e2f07998ead0920f6acf4953ff6f
      https://github.com/bluez/bluez/commit/c5715df9adb1e2f07998ead0920f6acf4953ff6f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-advertise.rst

  Log Message:
  -----------
  doc/bluetoothctl-advertise: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: fefe8c7413638d9eb9b996eb19cfd1ff2a8360d9
      https://github.com/bluez/bluez/commit/fefe8c7413638d9eb9b996eb19cfd1ff2a8360d9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-assistant.rst

  Log Message:
  -----------
  doc/bluetoothctl-assistant: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 061759b8736c7aee375bdb2c916e947211a334d4
      https://github.com/bluez/bluez/commit/061759b8736c7aee375bdb2c916e947211a334d4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-bredr.rst

  Log Message:
  -----------
  doc/bluetoothctl-bredr: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: e3c20c3183ed88f954a129743da5a18c0622749c
      https://github.com/bluez/bluez/commit/e3c20c3183ed88f954a129743da5a18c0622749c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-endpoint.rst

  Log Message:
  -----------
  doc/bluetoothctl-endpoint: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 459e46abd054fc640c2f03d332afe7028a677424
      https://github.com/bluez/bluez/commit/459e46abd054fc640c2f03d332afe7028a677424
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-gatt.rst

  Log Message:
  -----------
  doc/bluetoothctl-gatt: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 8e926e4d8f16dc36013fa498b4c7847b693a91bb
      https://github.com/bluez/bluez/commit/8e926e4d8f16dc36013fa498b4c7847b693a91bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-hci.rst

  Log Message:
  -----------
  doc/bluetoothctl-hci: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 6238b7c3cabdcd808656baf48d548dccc83ec648
      https://github.com/bluez/bluez/commit/6238b7c3cabdcd808656baf48d548dccc83ec648
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-le.rst

  Log Message:
  -----------
  doc/bluetoothctl-le: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 192dd3f72f3669277bac025fe5800575afe1c9f1
      https://github.com/bluez/bluez/commit/192dd3f72f3669277bac025fe5800575afe1c9f1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-monitor.rst

  Log Message:
  -----------
  doc/bluetoothctl-monitor: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 0dfb1cad38634a14a2feef075a9d81b930908eb3
      https://github.com/bluez/bluez/commit/0dfb1cad38634a14a2feef075a9d81b930908eb3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-player.rst

  Log Message:
  -----------
  doc/bluetoothctl-player: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 16057f2ea3eec0096d974475404f6074a9aa50b3
      https://github.com/bluez/bluez/commit/16057f2ea3eec0096d974475404f6074a9aa50b3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-scan.rst

  Log Message:
  -----------
  doc/bluetoothctl-scan: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: d7119120d26c5aabe3f6c856018c8e1f543824b5
      https://github.com/bluez/bluez/commit/d7119120d26c5aabe3f6c856018c8e1f543824b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-telephony.rst

  Log Message:
  -----------
  doc/bluetoothctl-telephony: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 4d69f11acf8a0a317c793e98bddd31fd9295d133
      https://github.com/bluez/bluez/commit/4d69f11acf8a0a317c793e98bddd31fd9295d133
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-transport.rst

  Log Message:
  -----------
  doc/bluetoothctl-transport: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 34a0969a8aac2edc09b0eef5bc18ca76df23a310
      https://github.com/bluez/bluez/commit/34a0969a8aac2edc09b0eef5bc18ca76df23a310
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  doc/org.bluez.Adapter: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.


  Commit: d0841ac272dd23b72cad2fd9c662cc57193acfd9
      https://github.com/bluez/bluez/commit/d0841ac272dd23b72cad2fd9c662cc57193acfd9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicySet.rst

  Log Message:
  -----------
  doc/org.bluez.AdminPolicySet: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-admin and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.


  Commit: 5490e7e4ccafe8535dfad4e29d3b5b75ca613fcb
      https://github.com/bluez/bluez/commit/5490e7e4ccafe8535dfad4e29d3b5b75ca613fcb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.AdminPolicyStatus.rst

  Log Message:
  -----------
  doc/org.bluez.AdminPolicyStatus: Add Used by reference

Add :Used by: field linking to bluetoothctl-admin for this interface
which exposes properties read by admin policy commands.


  Commit: 21732e9c6b9cc07c2673745db0b4a7b09c9bcbec
      https://github.com/bluez/bluez/commit/21732e9c6b9cc07c2673745db0b4a7b09c9bcbec
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.AdvertisementMonitor.rst

  Log Message:
  -----------
  doc/org.bluez.AdvertisementMonitor: Add Used by reference

Add :Used by: field linking to bluetoothctl-monitor for this callback
interface implemented by advertisement monitor clients.


  Commit: 48524504310b5c41dae6ac4a54c617000541ea38
      https://github.com/bluez/bluez/commit/48524504310b5c41dae6ac4a54c617000541ea38
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.AdvertisementMonitorManager.rst

  Log Message:
  -----------
  doc/org.bluez.AdvertisementMonitorManager: Add Used by reference

Add :Used by: field linking to bluetoothctl-monitor for this interface
used to register advertisement monitors.


  Commit: aeff7ee796fff5371dce30d7d7623f27457b3f12
      https://github.com/bluez/bluez/commit/aeff7ee796fff5371dce30d7d7623f27457b3f12
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.AgentManager.rst

  Log Message:
  -----------
  doc/org.bluez.AgentManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for agent methods.


  Commit: 58029c4cf24546ae6a66cd6d2a8f978fc67015c8
      https://github.com/bluez/bluez/commit/58029c4cf24546ae6a66cd6d2a8f978fc67015c8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.Call.rst

  Log Message:
  -----------
  doc/org.bluez.Call: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl commands for call methods.


  Commit: 4d4fb9c93cb2db61824111ab92c23d25d7d324ba
      https://github.com/bluez/bluez/commit/4d4fb9c93cb2db61824111ab92c23d25d7d324ba
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/org.bluez.Device: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for device methods.


  Commit: 2123ab772fbe97d1369fc9e179ea87c3469cf98f
      https://github.com/bluez/bluez/commit/2123ab772fbe97d1369fc9e179ea87c3469cf98f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst

  Log Message:
  -----------
  doc/org.bluez.GattCharacteristic: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT operations.


  Commit: d0488f7ea3e98c34e43d11b9cd3fc8728615fa97
      https://github.com/bluez/bluez/commit/d0488f7ea3e98c34e43d11b9cd3fc8728615fa97
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.GattDescriptor.rst

  Log Message:
  -----------
  doc/org.bluez.GattDescriptor: Add Used by reference

Add :Used by: field linking to bluetoothctl-gatt for this interface
used by GATT descriptor operations.


  Commit: fe274b385fda775de4f6f1b1643a261084848547
      https://github.com/bluez/bluez/commit/fe274b385fda775de4f6f1b1643a261084848547
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.GattManager.rst

  Log Message:
  -----------
  doc/org.bluez.GattManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT application methods.


  Commit: 313ea6ba61219065267d36b046be4c29d4362a0f
      https://github.com/bluez/bluez/commit/313ea6ba61219065267d36b046be4c29d4362a0f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.GattService.rst

  Log Message:
  -----------
  doc/org.bluez.GattService: Add Used by reference

Add :Used by: field linking to bluetoothctl-gatt for this interface
exposing GATT service properties.


  Commit: 056589a179474b7821a3a7eb6279ef7a0d5bb174
      https://github.com/bluez/bluez/commit/056589a179474b7821a3a7eb6279ef7a0d5bb174
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst

  Log Message:
  -----------
  doc/org.bluez.LEAdvertisement: Add Used by reference

Add :Used by: field linking to bluetoothctl-advertise for this callback
interface implemented by LE advertisement clients.


  Commit: 4bb5abd2048488e4d959f1397f32ecf99d5e969e
      https://github.com/bluez/bluez/commit/4bb5abd2048488e4d959f1397f32ecf99d5e969e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisingManager.rst

  Log Message:
  -----------
  doc/org.bluez.LEAdvertisingManager: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-advertise and Examples
sections showing corresponding bluetoothctl advertising commands.


  Commit: ee1551a533f02464f501ab1c928eb0768d417157
      https://github.com/bluez/bluez/commit/ee1551a533f02464f501ab1c928eb0768d417157
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.Media.rst

  Log Message:
  -----------
  doc/org.bluez.Media: Add Used by reference

Add :Used by: field linking to bluetoothctl-endpoint for this interface
used for media endpoint registration.


  Commit: bd7396ef8a6231d0f8cfc8ef74505863a18c98dd
      https://github.com/bluez/bluez/commit/bd7396ef8a6231d0f8cfc8ef74505863a18c98dd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.MediaAssistant.rst

  Log Message:
  -----------
  doc/org.bluez.MediaAssistant: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-assistant and Examples
sections showing corresponding bluetoothctl assistant commands.


  Commit: 51d1582aa803415b2df9aafc0cd8c173ab779869
      https://github.com/bluez/bluez/commit/51d1582aa803415b2df9aafc0cd8c173ab779869
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc/org.bluez.MediaEndpoint: Add Used by reference

Add :Used by: field linking to bluetoothctl-endpoint for this callback
interface implemented by media endpoint clients.


  Commit: 55caa7ab126f78f29b832bb22b7f3136f780b5f3
      https://github.com/bluez/bluez/commit/55caa7ab126f78f29b832bb22b7f3136f780b5f3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.MediaPlayer.rst

  Log Message:
  -----------
  doc/org.bluez.MediaPlayer: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-player and Examples sections
showing corresponding bluetoothctl player commands.


  Commit: 54447c93e517b88c39c051f6adb9dcf807d57fbc
      https://github.com/bluez/bluez/commit/54447c93e517b88c39c051f6adb9dcf807d57fbc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc/org.bluez.MediaTransport: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-transport and Examples
sections showing corresponding bluetoothctl transport commands.


  Commit: d390dbb58d453fcfe626bcf090baef9bb58b2445
      https://github.com/bluez/bluez/commit/d390dbb58d453fcfe626bcf090baef9bb58b2445
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.Telephony.rst

  Log Message:
  -----------
  doc/org.bluez.Telephony: Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl telephony commands.


  Commit: 5ce86fc6ace390d42208f81c92426c86d161572f
      https://github.com/bluez/bluez/commit/5ce86fc6ace390d42208f81c92426c86d161572f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.MediaFolder.rst

  Log Message:
  -----------
  doc/org.bluez.MediaFolder: Add Used by reference and Examples


  Commit: 9b54cf6dd87ffa8925431ebc977f4893bf5952fb
      https://github.com/bluez/bluez/commit/9b54cf6dd87ffa8925431ebc977f4893bf5952fb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-03 (Tue, 03 Feb 2026)

  Changed paths:
    M doc/org.bluez.MediaItem.rst

  Log Message:
  -----------
  doc/org.bluez.MediaItem: Add Used by reference and Examples


Compare: https://github.com/bluez/bluez/compare/4c963f21e56a...9b54cf6dd87f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
