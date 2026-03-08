Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F511E32CF
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772976692; cv=none; b=qIeRBTyMcsV5df8DVWEEMiZQIxuuP2fDXJMeLOZJVlYWC+j4cxLOfJ3NPwoo3KqU5ZwBN+FBpZ64cbeOjgteLG1HU+r65N6f0jsk643Ds7TXdDkJfFEx6KLWCObUEaYuRirNtFbgl70rZ3yuo8FT3oo3IIQr/s2MEw0zfm40lKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772976692; c=relaxed/simple;
	bh=BPDmFNixrXcHkG2aR5OWFT1h84kbWPtV/ZLs4BeYKQA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rCKGOJRap6qnC1qHv1obQA5GcmFoJ8GlMlR/D+fRRLjWAcmieOhghoyQIXQ1dDeKcb957jf79lhBeWTN4HCh6my7dIeAzy0flEi8fXE0F9A5axsqmGhH1ujdTNUMgZnaybT+4IVITLeA7grXMV39GColYVLDqE7BI/BUZ8Yhg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j/s4kREJ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j/s4kREJ"
Received: from github.com (hubbernetes-node-9bb3874.ac4-iad.github.net [10.52.162.37])
	by smtp.github.com (Postfix) with ESMTPA id 8195A400009
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772976690;
	bh=dfVhA0CUQI1m2x0KpQn7I3TL7zPPuZYYlyJkYH1IZzI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j/s4kREJG/hp+e/q0jou61oFzq4QJr34d1Hnwnv+pMnpeVzV9YvDaAq9ePLbK5Yn4
	 gYB/DNerMIhttY4E6InkY2MBmcBkbKavjsz9Y+nwpRkB7gqgmePcap7VLeJOqa+fW5
	 pStlJ2mVVrSlYid4p+cxfJA73khEeM4/Bb8W9g9c=
Date: Sun, 08 Mar 2026 06:31:30 -0700
From: Martin <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1063221/000000-a3b3f1@github.com>
Subject: [bluez/bluez] ed9e97: shared/gatt: make secondary discovery optional
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1063221
  Home:   https://github.com/bluez/bluez
  Commit: ed9e97a7135c45d7ae2ff9ca6acff35a3c15b08e
      https://github.com/bluez/bluez/commit/ed9e97a7135c45d7ae2ff9ca6acff=
35a3c15b08e
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-08 (Sun, 08 Mar 2026)

  Changed paths:
    M src/shared/gatt-client.c
    M src/shared/gatt-client.h

  Log Message:
  -----------
  shared/gatt: make secondary discovery optional

BREAKING CHANGE!

* Remove gatt_client_init from bt_gatt_client_new. Consumers must now
  call gatt_client_init themselves!
* Remove mtu paramter from bt_gatt_client_new
* Rename gatt_client_init to bt_gatt_client_init and make it public
* Introduce a new bt_gatt_client field "skip_secondary", default false
* Introduce public skip_secondary setter
* If true, skip_secondary makes discover_primary_cb goto done
  (instead of discoverying secondary services)


  Commit: dee5a13a6f8c5583120287138fe6af9fbdfcb9df
      https://github.com/bluez/bluez/commit/dee5a13a6f8c5583120287138fe6a=
f9fbdfcb9df
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-08 (Sun, 08 Mar 2026)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: allow skip secondary discovery

* Introduce new btd_device field skip_secondary
* Introduce public skip_secondary setter
* Use new gatt client interface to push device->skip_secondary into
  device->client->skip_secondary after new() but before init()
* Doing secondary service discovery is now a device property that can be
  set by device specific plugins.


  Commit: 973d13fd67acdc923b8553f3023b523a736be937
      https://github.com/bluez/bluez/commit/973d13fd67acdc923b8553f3023b5=
23a736be937
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-08 (Sun, 08 Mar 2026)

  Changed paths:
    M peripheral/gatt.c
    M tools/btgatt-client.c
    M unit/test-bap.c
    M unit/test-gatt.c
    M unit/test-gmap.c
    M unit/test-mcp.c
    M unit/test-micp.c
    M unit/test-tmap.c

  Log Message:
  -----------
  fixup: propagate new gatt interface through codebase

In theory we are supposed to create one patch for each affected directory=
,
but this patch is the immediate result of splitting gatt_client_init
from bt_gatt_client_new.


  Commit: 02b54f08aa0e1cbd835ca02ab8df416bc695b9e9
      https://github.com/bluez/bluez/commit/02b54f08aa0e1cbd835ca02ab8df4=
16bc695b9e9
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-08 (Sun, 08 Mar 2026)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Rename set_alias to btd_device_set_alias()

Renamed set_alias is exposed, so that plugins and others may set
the device alias progammatically. This is usefule for devices whose
Bluetooth name is generic (e.g. a bare BD addess, or literally
"DeviceName") but whose identity is known to the plugin after
protocol-level interrogation.

The signature was changed. The first parameter,
GDBusPendingPropertySet id was dropped and
g_dbus_pending_property_success moved to dev_property_set_alias().


  Commit: 16218ec33d4f0b397733bb4851354f94dbb92384
      https://github.com/bluez/bluez/commit/16218ec33d4f0b397733bb4851354=
f94dbb92384
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-08 (Sun, 08 Mar 2026)

  Changed paths:
    M src/dbus-common.c

  Log Message:
  -----------
  dbus-common: Add Gaming appearance class (0x2a)

Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
(generic gaming, handheld game console, game controller, etc.).
Map it to "input-gaming" so the correct icon is exposed over D-Bus.


  Commit: a3b3f12fa6eabdb7b7e3e8438d24d608bfd55043
      https://github.com/bluez/bluez/commit/a3b3f12fa6eabdb7b7e3e8438d24d=
608bfd55043
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-08 (Sun, 08 Mar 2026)

  Changed paths:
    M Makefile.plugins
    A plugins/switch2.c

  Log Message:
  -----------
  plugins/switch2: Add Nintendo Switch 2 Controller plugin

Add a BLE plugin for the Nintendo Switch 2 controllers.

Currently this is only developed, tried and tested with the Nintendo
Switch 2 Pro Controller (ProCon2).

The controller uses a vendor-specific GATT service for all HID
communication.  The plugin discovers the service, binds its
characteristics, and runs an ACK-driven initialization state machine
that sends 13 configuration commands one at a time (each waiting for
the controller's ACK notification before proceeding).

The controller requires BT_SECURITY_LOW =E2=80=94 any SMP pairing attempt=

causes it to respond with "Pairing Not Supported" and drop the link.

After initialization completes, input notifications are forwarded to
userspace via a uhid device that presents a standard gamepad HID
report descriptor.  A back channel allows the host to send commands
back to the controller (e.g. rumble, LED control).


Compare: https://github.com/bluez/bluez/compare/ed9e97a7135c%5E...a3b3f12=
fa6ea

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
