Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86F38BF60
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780764; cv=none; b=umw3+IhX6ec1wx8PZVMXRbQLHyeXX5KdsTw8RkjjXG3gGqCglITB6dKvY4F07OxW3cJCMLToX+LIDVCwblvZLMvJCFy2QGT3kOj7hWypEQY6Q0nDE7d8kheNDPaI2rTMUJrc/XmJX69nzxMIDcGGeaj9CzNINZm96royQxdUyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780764; c=relaxed/simple;
	bh=2IcCe6EYu08osPOFrJ2LMU2Y60r1ph2oJrxvuJT1CmQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MK/oU637ToVHBiApnmMYTIvMz7ap2jj2RYdRzp4mqV22/rApH6XhRCB3WVqdPQkd5pZABmcJzG5lcJ2uS9T7og27KV4DyDfS3shxB2y1rXe1Kn/ptL++h2ITBmD4oN+ybGX9xISBSJ0vS0+A3+nNvrirJDl/g3AKvQfw6PBFiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aAo4nryE; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aAo4nryE"
Received: from github.com (hubbernetes-node-4500896.va3-iad.github.net [10.48.144.28])
	by smtp.github.com (Postfix) with ESMTPA id 629D81C121D
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773780762;
	bh=oPZJTfCefIlOnVg/+QSjdt7jvoVa1bvdgq4S9KyyNL4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aAo4nryEPSKIl7lnhNUX1Tt+iqIU4DKs47oLCHcy2hm6nzjeOlJbHN2w1WY4huKwB
	 bFmmS1bcevDo12lUxDUk0wnAtAzmWecrSOjWEINvikLOvwdsBL/4HW+VkmNWfmkMs7
	 BrO5ZbkIRlZeMbZ8eIfLyJymQOuPZxzL13LppVo0=
Date: Tue, 17 Mar 2026 13:52:42 -0700
From: Martin <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1068246/000000-e4e22d@github.com>
Subject: [bluez/bluez] e89b95: shared/gatt: Add skip_secondary option for GATT
 cl...
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

  Branch: refs/heads/1068246
  Home:   https://github.com/bluez/bluez
  Commit: e89b95a9b6cb6693a4204e38e20159993d89e104
      https://github.com/bluez/bluez/commit/e89b95a9b6cb6693a4204e38e20159993d89e104
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

  Changed paths:
    M peripheral/gatt.c
    M src/device.c
    M src/device.h
    M src/shared/gatt-client.c
    M src/shared/gatt-client.h
    M tools/btgatt-client.c
    M unit/test-bap.c
    M unit/test-gatt.c
    M unit/test-gmap.c
    M unit/test-mcp.c
    M unit/test-micp.c
    M unit/test-tmap.c

  Log Message:
  -----------
  shared/gatt: Add skip_secondary option for GATT client

Some BLE devices reject or ignore secondary service discovery requests,
causing ATT timeouts that terminate the connection. Add a skip_secondary
parameter to bt_gatt_client_new() that skips the secondary service
discovery step during GATT client initialization. Add
btd_device_set_skip_secondary() so device-specific plugins can enable
this. All existing callers pass false (no behavior change).

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>


  Commit: 8db4f9d116ccdd530e6168b33c9d077d82385d08
      https://github.com/bluez/bluez/commit/8db4f9d116ccdd530e6168b33c9d077d82385d08
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt: Add timeout for secondary service discovery

Some BLE devices do not respond to secondary service discovery
requests, causing the 30-second ATT timeout to fire and terminate the
connection. Add a 2-second timeout at the GATT client level that
cancels the pending ATT request and proceeds as if no secondary
services were found. This prevents the ATT timeout from killing the
connection while still giving well-behaved devices enough time to
respond.

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>


  Commit: a2d84371d9d6d95d6ae48bbeac74c3a2b80a4372
      https://github.com/bluez/bluez/commit/a2d84371d9d6d95d6ae48bbeac74c3a2b80a4372
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

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


  Commit: e2942638756beccaa62aceb442055b8187245036
      https://github.com/bluez/bluez/commit/e2942638756beccaa62aceb442055b8187245036
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

  Changed paths:
    M src/dbus-common.c

  Log Message:
  -----------
  dbus-common: Add Gaming appearance class (0x2a)

Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
(generic gaming, handheld game console, game controller, etc.).
Map it to "input-gaming" so the correct icon is exposed over D-Bus.


  Commit: 1c7d00b2fa5581d0b14ea18fb2bd7c5cc4076dc5
      https://github.com/bluez/bluez/commit/1c7d00b2fa5581d0b14ea18fb2bd7c5cc4076dc5
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

  Changed paths:
    A plugins/gatt-uhid.c
    A plugins/gatt-uhid.h

  Log Message:
  -----------
  plugins/gatt-uhid: Add generic GATT-to-UHID bridge

Add a reusable bridge that creates a /dev/uhid device backed by BLE
GATT characteristics. It forwards GATT notifications as HID input
reports (UHID_INPUT2) and HID output reports (UHID_OUTPUT) back as
GATT write-without-response commands.

Report format (both directions):
  byte 0:    HID report ID (0x01)
  byte 1-2:  GATT handle, little-endian
  byte 3+:   payload

The bridge has no device-specific knowledge. It subscribes to all
notify-capable GATT characteristics passed by the caller and generates
a vendor-defined HID descriptor at runtime. A kernel HID driver matched
by vendor/product ID provides all protocol handling.

Input forwarding is gated on CCCD subscription completion: the bridge
suppresses UHID_INPUT2 writes until all GATT notification registrations
are confirmed, ensuring the kernel driver's output path is fully
operational before it receives any input events.


  Commit: e4e22d9b28263bb0df81b726780573d00dafbb2b
      https://github.com/bluez/bluez/commit/e4e22d9b28263bb0df81b726780573d00dafbb2b
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

  Changed paths:
    M Makefile.plugins
    A plugins/switch2.c

  Log Message:
  -----------
  plugins/switch2: Add Nintendo Switch 2 Controller plugin

Thin device-specific wrapper around the generic GATT-UHID bridge for
Nintendo Switch 2 controllers (Pro Controller 2, Joy-Con 2 L/R,
GameCube Controller).

The plugin handles:
- Profile registration with the Switch 2 GATT service UUID
- Dynamic GATT characteristic discovery (all notify handles)
- Controller type detection from product ID
- Vendor/product IDs and payload sizes for uhid device creation
- Low-latency connection parameters and BT_SECURITY_LOW
- Skip secondary service discovery (controller rejects it)

All protocol knowledge (init handshake, calibration, stick normalization,
button mapping, rumble) is delegated to a matched kernel HID driver.
The plugin itself contains no Nintendo protocol logic.


Compare: https://github.com/bluez/bluez/compare/e89b95a9b6cb%5E...e4e22d9b2826

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
