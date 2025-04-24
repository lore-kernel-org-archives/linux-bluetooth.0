Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF05285412
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511112; cv=none; b=lwobWRjf/JZrkxACL1Uq5wwrnQlAAZG60wZh9GWeZk14VJMTAYPqly2B9q7zmibAvNvWlhvVByDkwIdwfnH5IuRlp8hcje/IgS+b1Kij5tniaCnjo1yE8JtGs5fVBfwZgrPVhWMC43v6r3ajPttW2mNc9BnCAN/CLd1WfTg2wzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511112; c=relaxed/simple;
	bh=jvf+FLkO6LmhqJ5sx6i1lYS6CRoIuVZdNeaKBnGoGIY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IpZAEtH6BdnuTnlqwILKr+hGFP64z3HKi8V+qoV9sC7NXq9oOVaTUIcnPddnnrCCboNM602JGtI9+eUk3SH9kKzOwODfGvPouSRH/gJqRVDhzxj7XE2Kbnyvpy4yyoxIWvkado3I4oq1LJ9hZYkGILH167bWsKXHTf794ugOnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QxRpzAiE; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QxRpzAiE"
Received: from github.com (hubbernetes-node-5895fa3.ac4-iad.github.net [10.52.137.32])
	by smtp.github.com (Postfix) with ESMTPA id 4F6D7701287
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745511110;
	bh=O7ZlavqZkXLZosJiJNRf0LOs95rt9mvt0/MXTSSp/Zk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QxRpzAiE0L8vodMOXHFQt1mEydwPVxTql/qAVlbvJ9r0KJEMVsJxahj+U/cVXXNkG
	 r/8CtncCExKoyVGZZmoTPLMKVrx36QocoFPRGRhXfbrbBwT+pf9Rkm8vGGJ7bvYF1d
	 8wnL3wBKBsjevsE78tjBSaGNEcvuz/2SpktTUB8o=
Date: Thu, 24 Apr 2025 09:11:50 -0700
From: Ludovico de Nittis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/956690/000000-4b6ffb@github.com>
Subject: [bluez/bluez] 941ab2: src: Add new CablePairing property
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

  Branch: refs/heads/956690
  Home:   https://github.com/bluez/bluez
  Commit: 941ab24411923feadac7181e9be9afa41018c1b8
      https://github.com/bluez/bluez/commit/941ab24411923feadac7181e9be9afa41018c1b8
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


  Commit: 5d34b00c46dc7bdf42545645e83f98cf878f40a7
      https://github.com/bluez/bluez/commit/5d34b00c46dc7bdf42545645e83f98cf878f40a7
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print CablePairing property

When using the `info` command, include the new CablePairing value.


  Commit: e89ad7dbb06f11947e014d8eea2c96ef5605798b
      https://github.com/bluez/bluez/commit/e89ad7dbb06f11947e014d8eea2c96ef5605798b
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


  Commit: 630731ccf41b6bb7b95d3378483c8db7e8cc4a06
      https://github.com/bluez/bluez/commit/630731ccf41b6bb7b95d3378483c8db7e8cc4a06
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


  Commit: cf0716c0fc8c7794d417a3f74f3d274587a29670
      https://github.com/bluez/bluez/commit/cf0716c0fc8c7794d417a3f74f3d274587a29670
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


  Commit: 4b6ffb046c5605e216797914c810eafecbaa0d10
      https://github.com/bluez/bluez/commit/4b6ffb046c5605e216797914c810eafecbaa0d10
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


Compare: https://github.com/bluez/bluez/compare/941ab2441192%5E...4b6ffb046c56

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
