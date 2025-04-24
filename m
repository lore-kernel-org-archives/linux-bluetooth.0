Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284F280A37
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511108; cv=none; b=fk08/vNMljEL/78zH88MXziPlySSAvovoo1SYkglfnkAHZoeE4tT64mrKn9Su6LnZRnFAZtZj/rKT0eAsj4ujgGjZijsum6PJzDYuHkQfQp/pCrryQFLF8g0kMBHAqjcF4SKFfTXGrp6LNzQidKuTUFeCuln862ueP4NWus6AZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511108; c=relaxed/simple;
	bh=yWOm69DALGe8GaBP+kRBo+BC2ffCYAm+4uQ5ycqgSBY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YMo8fNUmwAr0mLSgmOAQXbIYAZ72SaiIWHOgpI9b/LbLs51aBa/2Gxp0oNngIhrdGqpQVBXIpCxmBF91EiAWDQeJYSzpXPFWGSC9mWnWLzTiCAgOXqUWJPKLoswQ6gwvrQqJywY/PVgjpUXa6E6iAI+b1Q9p7C8VBbhJbvg+ZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YZdfhhCt; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YZdfhhCt"
Received: from github.com (hubbernetes-node-1ae8a12.ac4-iad.github.net [10.52.175.32])
	by smtp.github.com (Postfix) with ESMTPA id 9CB6221310
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745511105;
	bh=D+OFN+qH6f/jdgWf1CbZABBkfLoe2XcLfY64ipMSqwo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YZdfhhCtt8fXVZOb3fznhr5pNV/Za1RpXQ9yH6BhvRDTVJ3pcxOk00jKEftVimmo2
	 jGGHPh68teNK0j+fizuogExbeWp6uKyFhwMdxd3wDrtFpJr3nKi63+LYZh/4rm7PQs
	 wo6jPfx5kO0umqeNgxVoRye+pjE+BYjbSWPA6pAQ=
Date: Thu, 24 Apr 2025 09:11:45 -0700
From: Ludovico de Nittis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/956666/000000-72d064@github.com>
Subject: [bluez/bluez] 352237: src: Add new CablePairing property
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

  Branch: refs/heads/956666
  Home:   https://github.com/bluez/bluez
  Commit: 352237cb35cb4d0f606733ed36b7a3da4fedcf08
      https://github.com/bluez/bluez/commit/352237cb35cb4d0f606733ed36b7a3da4fedcf08
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


  Commit: 1ead3988ad6718d386a70a113269e02815028f41
      https://github.com/bluez/bluez/commit/1ead3988ad6718d386a70a113269e02815028f41
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print CablePairing property

When using the `info` command, include the new CablePairing value.


  Commit: 9787d5520347693a2de5e7a1ffa923c963cf1af3
      https://github.com/bluez/bluez/commit/9787d5520347693a2de5e7a1ffa923c963cf1af3
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


  Commit: 61b9c83d82d1cadf58f12596b08f8b5062f8600c
      https://github.com/bluez/bluez/commit/61b9c83d82d1cadf58f12596b08f8b5062f8600c
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


  Commit: 16a2c7919e8da98a08ef72f76156d0b4e5a570a9
      https://github.com/bluez/bluez/commit/16a2c7919e8da98a08ef72f76156d0b4e5a570a9
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

This doesn't cover the case where a device with `CablePairing` gets
loaded from storage. That case will be handled with a followup commit.


  Commit: abbcb3352cc6621c9858733dbb29362f29cc2cc0
      https://github.com/bluez/bluez/commit/abbcb3352cc6621c9858733dbb29362f29cc2cc0
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Set server security level in load_devices()

After loading known devices from storage, change the security level if
we have a device with `CablePairing`.
This will allow it to successfully establish a connection.


  Commit: 72d064cccbfb7f37aef6e32dc8ee97ea1ae93498
      https://github.com/bluez/bluez/commit/72d064cccbfb7f37aef6e32dc8ee97ea1ae93498
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


Compare: https://github.com/bluez/bluez/compare/352237cb35cb%5E...72d064cccbfb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
