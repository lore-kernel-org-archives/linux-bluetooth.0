Received: from out-4.smtp.github.com (out-4.smtp.github.com [192.30.252.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C52E7185
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775208714; cv=none; b=I8wfU1aZZxej2t2V96xUxf9Xymo2GNeq8k6GcLC0tkvoSbUpti0VQCrxT5AC8fIRak+XOxm286pSeFkNeUZ/mbGc6QqHDUvS/ymNbfkz+d4+O6zUB1Y37dWSZ5GCXb4C8SuYC4d3LZoywIQS4/IkNj62voqoMhLYDlAjD7z7ZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775208714; c=relaxed/simple;
	bh=MLc8S49iNAVqXWPYj0OMAWgGWt+4HCWqYRow3vJgN98=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hUmY10WqOD+pRJeZl4Wkdb+7GEZyFXJ7lJpLuhMsubLWmOoq406xKNpEbnPEGpnNPzVOqYM68TLkxryV2v0uKt7mjKjTWhSzHPbLsRJdaDkjZgjdE9PRQ7eCdqnmbjCVHMAEO/sNjWlK2NmAclcXMmqCQx9jd4XgEJ7jgjSi4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mDNWpPZ1; arc=none smtp.client-ip=192.30.252.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mDNWpPZ1"
Received: from github.com (hubbernetes-node-5a626af.va3-iad.github.net [10.51.95.35])
	by smtp.github.com (Postfix) with ESMTPA id 0D6222C082F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775208709;
	bh=8+W9a1gl4QG1ioySgLrb/O4KGl1OTJkM5wOmudgR8FQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mDNWpPZ1U8WuryyvCoMfXyqfZJ+xNm5/oFG0Uugg4fug6ClUIkIcZcpAX7eJOWorb
	 6+D3QRM0AXsYLHnS/hc1SInhbs1Yw1djrtCNVEi5bsYlNelMPfdcrjDJY+C/f5Fycf
	 hMyqvQudWweJazP3Dm85XRkCpOKdKyr4eC+PhHSo=
Date: Fri, 03 Apr 2026 02:31:49 -0700
From: Martin <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076884/000000-275d48@github.com>
Subject: [bluez/bluez] 672b3b: shared/gatt: Add skip_secondary option for GATT
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

  Branch: refs/heads/1076884
  Home:   https://github.com/bluez/bluez
  Commit: 672b3bb43bec919cdb4bf2d27bd9c983aa37ebb7
      https://github.com/bluez/bluez/commit/672b3bb43bec919cdb4bf2d27bd9c983aa37ebb7
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

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


  Commit: 870484f24c73a98e8c3bd4c9f8d49b499eced638
      https://github.com/bluez/bluez/commit/870484f24c73a98e8c3bd4c9f8d49b499eced638
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

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


  Commit: 9ac05f452d964d733e17247d6a45f632b921a252
      https://github.com/bluez/bluez/commit/9ac05f452d964d733e17247d6a45f632b921a252
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

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


  Commit: 65454bc5c4ef42b179a0433e4a5f02f62b92f513
      https://github.com/bluez/bluez/commit/65454bc5c4ef42b179a0433e4a5f02f62b92f513
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M src/dbus-common.c

  Log Message:
  -----------
  dbus-common: Add Gaming appearance class (0x2a)

Bluetooth 5.0+ defines appearance category 0x2a for gaming devices
(generic gaming, handheld game console, game controller, etc.).
Map it to "input-gaming" so the correct icon is exposed over D-Bus.


  Commit: 7f8dc9a767b694ac50ab16ba304ef05e5693a7f6
      https://github.com/bluez/bluez/commit/7f8dc9a767b694ac50ab16ba304ef05e5693a7f6
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    A plugins/gatt-uhid.c
    A plugins/gatt-uhid.h
    M src/shared/gatt-client.h

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


  Commit: 275d48e314f59257b9b461e2f2ba9c18fb62c224
      https://github.com/bluez/bluez/commit/275d48e314f59257b9b461e2f2ba9c18fb62c224
  Author: Martin BTS <martinbts@gmx.net>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

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


Compare: https://github.com/bluez/bluez/compare/672b3bb43bec%5E...275d48e314f5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
