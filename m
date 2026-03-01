Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC441A9F97
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772379609; cv=none; b=KMCrspzqRyuFexkD7sNK+KOmfhYzPGigRrG5jdv7karW9iQLvT0X6hIYFGHICpktMtUeUV2uDE0iO7/JSrhePHfYOSE1ay/dxqWGXya51GeRNbKy1OQ0ut6hM7rqj4PZUpVTW3DWWwA4czBWZ3UQESQq327iEOH2hi6Tc2rWRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772379609; c=relaxed/simple;
	bh=I6ujwJw5k7Dml5AC4tQzeMMRnToquvpbJlsLdBtXhZ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NrjsthcsyZ7MeLSq8oo6D9qiheBpAaFH7LzOlJHEA5Nh19si/HflmHnHnVwxd+uEkh1P8FfJt5jARXUOs1PuN+FVWYc4cRKHI/VzO2Mf+83w1kOQNTwKq9ofl2kOa0IVpXxOPoYqnnGPPB/catc3lzzRYv6/nT00SFInkvizVkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AlpOoTbx; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AlpOoTbx"
Received: from github.com (hubbernetes-node-7fbaa19.ac4-iad.github.net [10.52.133.34])
	by smtp.github.com (Postfix) with ESMTPA id EB4634010A9
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772379606;
	bh=zMt+In5CbIs0XXNIXGg2Y6RsgYoV7WTu5a9cmU6ikuo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AlpOoTbx4La+HEfmoWSCEtDK/AN4m4NqopLK1prLU9hQcfNDVVnDmf/itGBnLozVc
	 QCLdlXZFXDuvakrSoUJ/Bxi9gqlWyccobZN/4kh6uqfaSuWKemaYi0t2z9DDuUHpbY
	 STVU09ZGLzuKvkyacbeFD3y7PvShE8qi2DI+C04Q=
Date: Sun, 01 Mar 2026 07:40:06 -0800
From: Martin <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059646/000000-b4a79d@github.com>
Subject: [bluez/bluez] b0a4e4: shared/att: Don't disconnect on ATT request
 timeout
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

  Branch: refs/heads/1059646
  Home:   https://github.com/bluez/bluez
  Commit: b0a4e4d7bfe07e9f67c107ed3a346d5afcb092c7
      https://github.com/bluez/bluez/commit/b0a4e4d7bfe07e9f67c107ed3a346=
d5afcb092c7
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-01 (Sun, 01 Mar 2026)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  shared/att: Don't disconnect on ATT request timeout

The ATT layer currently calls io_shutdown() on every request timeout,
terminating the connection.  This is too aggressive for devices that
silently ignore optional ATT requests (e.g. secondary service
discovery, UUID 0x2801) while remaining otherwise fully functional.

Remove the io_shutdown() call from timeout_cb().  The upper layer
(gatt-client.c) already handles aborted-request error codes for
optional operations and continues discovery.  Truly dead connections
are caught by the link-layer supervision timeout.


  Commit: ca6da514df7b2f9cfe12213a7e8c042de0c11bae
      https://github.com/bluez/bluez/commit/ca6da514df7b2f9cfe12213a7e8c0=
42de0c11bae
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-01 (Sun, 01 Mar 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Handle secondary discovery timeout

When a BLE device silently ignores the secondary service discovery
request, the ATT layer (after the previous att.c fix) invokes the
callback with success=3Dfalse and att_ecode 0x00 or BT_ATT_ERROR_UNLIKELY=

(0x0e).  These fell through to the default case, aborting the entire
GATT discovery even though primary services were already found.

Add cases for att_ecode 0x00 and BT_ATT_ERROR_UNLIKELY in
discover_secondary_cb(), treating them the same as
ATTRIBUTE_NOT_FOUND so discovery continues with the primary services.


  Commit: eb4f63cda1cd77721ef698c22370cae7dd9a1c32
      https://github.com/bluez/bluez/commit/eb4f63cda1cd77721ef698c22370c=
ae7dd9a1c32
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-01 (Sun, 01 Mar 2026)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_set_alias()

Add a function that lets plugins set the device alias
programmatically.  This is useful for devices whose Bluetooth name
is generic (e.g. a bare BD address) but whose identity is known to
the plugin after protocol-level interrogation.

The function updates the in-memory alias, persists it via
store_device_info(), and emits a D-Bus PropertyChanged signal.


  Commit: 857a374be1ef26020cafeda9c9c1aaa7451e0ee1
      https://github.com/bluez/bluez/commit/857a374be1ef26020cafeda9c9c1a=
aa7451e0ee1
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-01 (Sun, 01 Mar 2026)

  Changed paths:
    M src/dbus-common.c

  Log Message:
  -----------
  dbus-common: Add Gaming appearance class (0x2a)

Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
(generic gaming, handheld game console, game controller, etc.).
Map it to "input-gaming" so the correct icon is exposed over D-Bus.


  Commit: b4a79d184015c89a161071181545cd38295d3d49
      https://github.com/bluez/bluez/commit/b4a79d184015c89a161071181545c=
d38295d3d49
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-01 (Sun, 01 Mar 2026)

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


Compare: https://github.com/bluez/bluez/compare/b0a4e4d7bfe0%5E...b4a79d1=
84015

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
