Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC4352036
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347810; cv=none; b=CLhf/ZQT6d9UJaYIxAw+IgmwxV2GEVp1ID8wUF0wSYVdH/NZrr3erZQPmzsypxtqEAnkyMYrC+SmI8RhCJnoeH0CByqeOe2+lJBwdZlPZvymdaa7mJwSITnEZaWAAuWXnFtSl2pd8tv5EAk7TiJj/oQFG+kJmf6PGa5tWhbn4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347810; c=relaxed/simple;
	bh=R90ZCM7AtiT/vn2b4fp3mG+6u6TG4DLuGWU7r9DRn7g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hJGJwXcVa+Y8rpY5OKEBOth9Cp6PnT4BEpp5BV5ahfqbD/tZDyG6GTGu24zko2xRsF1p2wpyibAze5BWlgyoJYsGj8FAO/ark3WaHSbkTyDVq4xsrp2BfI4GQOLigzT/bCLYsjgDIcTUqJkFxZEXaGE3+zOlXnQSFu+ecij3LhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=UXNW4xoP; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="UXNW4xoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790347806;
	bh=Gcy/C4GPNf3khbF+U/udNYviyOi9dPM218qRDnZ7ncM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UXNW4xoPixQXp2/VxqN2TsGmuX1REmg6dDILEI35cmCBd0/Vfypv4jMClZes9HiMm
	 MFm9Fa+4Cb2WiE7MSUf3Q/Ve1xZtHZxeisXccOlWNnhMPtFzCp8z1FLi4wTLbrZ7UI
	 5lhAJLQfQLmImxD9nU4o74rJgfF5aRDLpziZL6VkdTym8Pfj3YePVusxweTaFYkkt+
	 8DmkISASkc576gZsinjYBA5GmoiDQo6T0qK9V6pK4ji9aeFDeTpBDx7pRbRNxD3rcH
	 tWvzTzxzwTUkI6X6qj8XFdwxeljXFNoaIpLy7YuyecSHJIBsPHKM47yrluISNiFxgs
	 ktTbHUq0FP5aA==
Received: from github.com (hubbernetes-node-890ae1e.ash1-iad.github.net [10.56.147.36])
	by smtp.github.com (Postfix) with ESMTPA id DCBB436098F
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 07:50:06 -0700 (PDT)
Date: Fri, 25 Sep 2026 07:50:06 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173703/000000-8edb2c@github.com>
Subject: [bluez/bluez] 000431: mgmt: Add Security Level Changed event
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

  Branch: refs/heads/1173703
  Home:   https://github.com/bluez/bluez
  Commit: 000431b77b760745d49b5cce73c92f00aeb7da28
      https://github.com/bluez/bluez/commit/000431b77b760745d49b5cce73c92=
f00aeb7da28
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M doc/mgmt-protocol.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add Security Level Changed event

This provides a TLV list of values related to the security level of
the connection to a remote device.

Currently Security Level and Encryption type are implemented.


  Commit: d4be6bb3e2d167d9e48461f986a13e2d7bf872b9
      https://github.com/bluez/bluez/commit/d4be6bb3e2d167d9e48461f986a13=
e2d7bf872b9
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add Security Level Changed event tests

Test that MGMT_EV_SECURITY_LEVEL_CHANGED is correctly received during
BREDR and LE secured connection.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 2650b3cefe65735d0107efcf8fc941480362cde3
      https://github.com/bluez/bluez/commit/2650b3cefe65735d0107efcf8fc94=
1480362cde3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for Mgmt Security Level changed event

@ MGMT Event: Security Level Changed (0x0034) plen 16
        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
        Count: 2
        Security Level: No security (0x00000000)
        Encryption Type: No encryption (0x00000000)


  Commit: da763adc7bdb4fc3c3ea14f7c30afa13ace9b968
      https://github.com/bluez/bluez/commit/da763adc7bdb4fc3c3ea14f7c30af=
a13ace9b968
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add SecurityLevel properties to org.bluez.Device1

This uses the new MGMT_EV_SECURITY_LEVEL_CHANGED event.

It will be used by btpclient to reduce test time.


  Commit: d84ff3ce7d20ef2e8eb691db3f65259c8fe30366
      https://github.com/bluez/bluez/commit/d84ff3ce7d20ef2e8eb691db3f652=
59c8fe30366
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Security Level related properties

This adds the SecurityLevel and EncryptionType properties which can be
used by clients to get the security level and encryption type in use
for a connection.


  Commit: 8edb2cbb3cd687ac39e7b17e826108fcda6cf376
      https://github.com/bluez/bluez/commit/8edb2cbb3cd687ac39e7b17e82610=
8fcda6cf376
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display SecurityLevel in device info


Compare: https://github.com/bluez/bluez/compare/000431b77b76%5E...8edb2cb=
b3cd6

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
