Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FC27FD79
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512640; cv=none; b=iBuGiWI1fv7mwci1CG3yLH4YwNafElu009PjO5XTAxAjZ/TFvaBPkPW99NDr+uwa9X1+oG2COpSpcdFbz62ClIegVelo2YmuIcNAPZWmLGin1xxLowKCBtQ+dbYWpgLpBAFPlUurCf0QHm99XqYu6VNSBShkTiCc1/DFYRYaxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512640; c=relaxed/simple;
	bh=hophk24uQ99G1DM5bJ6BVbZ/oO7aUWAUb/6tuR2OSas=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B0M/syIg0eBdPfgq4zsVXnFOVPwQVsmOitP2BK+TGiGAtawjZTsto52mdSawV8bCBePzpDMq2Tio/HB8mWKBbVC2xmStyRoCvn4V/VVLOwUj7hSEK3gxbGHc+w3xI0k78s6h8qJT1CuntE+SWdzif/AFZt8/q5z06TbVnoKm1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XAbAV2mm; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XAbAV2mm"
Received: from github.com (hubbernetes-node-20ef36f.ash1-iad.github.net [10.56.212.83])
	by smtp.github.com (Postfix) with ESMTPA id 2503960117E
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745512637;
	bh=TnFKLZDrv59tbcn3iELJPAqmJ5CLt63Jz8K9FWXrDGU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XAbAV2mmuWfQ41Yx825D9/ELCuRVwlfXgTFMvnnBf8PD7EMsGs3pGt96sfj2rrkaW
	 3E0t+r2jx/M6GbkV88eN0xTYduBueMDLgERuKBoZOtWgjdMBmTEIqSfrhrE4P1HMTK
	 f1ndM/zXmPx26jFB4dTByap5QvLXncMZaSnvlZBU=
Date: Thu, 24 Apr 2025 09:37:17 -0700
From: Ludovico de Nittis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/956700/000000-c03b3f@github.com>
Subject: [bluez/bluez] c62df9: src: Add new CablePairing property
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

  Branch: refs/heads/956700
  Home:   https://github.com/bluez/bluez
  Commit: c62df91830396908b4ef3ccdbf8a0e2db35bcd3f
      https://github.com/bluez/bluez/commit/c62df91830396908b4ef3ccdbf8a0e2db35bcd3f
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src: Add new CablePairing property

This adds initial support for a new CablePairing property.
The property can be used for devices that are paired using a cable and
don't support the expected bonding (with pairing/encryption), for
example like the Sixaxis gamepads.


  Commit: f384c59f7ef7c5e754f2240c91567a45fb25fc8e
      https://github.com/bluez/bluez/commit/f384c59f7ef7c5e754f2240c91567a45fb25fc8e
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print CablePairing property

When using the `info` command, include the new CablePairing value.


  Commit: 6d92db305fc027b732f91d005b437e1f1210ab18
      https://github.com/bluez/bluez/commit/6d92db305fc027b732f91d005b437e1f1210ab18
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Set CablePairing when pairing a Sixaxis with USB

Sixaxis gamepads don't support encryption. When doing the USB cable
pairing, set the CablePairing property to keep the connection to the
device unencrypted.


  Commit: 2d1745a125679e34e7acab6fbd1807625da59ec5
      https://github.com/bluez/bluez/commit/2d1745a125679e34e7acab6fbd1807625da59ec5
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Add btd_adapter_has_cable_pairing_devices()

Add a function that can be used to know if any of the known devices have
the `CablePaired` property set.


  Commit: 509cbe9f3551ef8420eb135ca5f67924f0a3ed73
      https://github.com/bluez/bluez/commit/509cbe9f3551ef8420eb135ca5f67924f0a3ed73
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/manager.c
    M profiles/input/server.c
    M profiles/input/server.h

  Log Message:
  -----------
  input: Automatically use sec level low when using a cable paired device

BT_IO_SEC_LOW is the only way to allow devices that use cable pairing to
establish a connection.

This adds the ability to start the listening input server with
BT_IO_SEC_LOW to avoid breaking support for these devices, and then,
in `hidp_add_connection()`, we check if either `classic_bonded_only` was
disabled or if this device has `CablePairing`. If neither are true, we
bump the security back to BT_IO_SEC_MEDIUM, i.e. enforcing encryption.

This allows supporting these devices without having to change the
classic bonded only option.


  Commit: c03b3fa2e7b9ccf126789628d02be8f43a811bae
      https://github.com/bluez/bluez/commit/c03b3fa2e7b9ccf126789628d02be8f43a811bae
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Set security level when adding a sixaxis device

When doing the cable pairing for a sixaxis, we may need to change the
listening input server security level.
This is because sixaxis gamepads can only work with the level
BT_IO_SEC_LOW.


Compare: https://github.com/bluez/bluez/compare/c62df9183039%5E...c03b3fa2e7b9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
