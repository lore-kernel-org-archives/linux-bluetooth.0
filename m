Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9373F4F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785848; cv=none; b=r1eZFKy2gVPX1udiuCDn/WbCMkF38/ByEnZU73fPYdr9cdVqtLeVQlN8X/a+cNEZze50t9dgILVpMTtlYWnowCcl03ompec66ozdcyqmdBX/ay4FZs0KPlqko7BQVq3fDKNod2KfaisTdC+Sdd4Vl0YMP1aWsZdqCDU5UO2IQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785848; c=relaxed/simple;
	bh=VnfihSnTVYJWHHaACISrXqsCsBRJv/FbFqT4Hsh3+94=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cAtaB5fSwvU0rZi1gm2C5jWnpIEONRgS3Sp0yU/tEUnd2XzK4BDfZwxZ/K6dvHOGePSpTjdN2tZpR870lykL2ApW0e7sfa2UQ9u39ZL1S8b5Dxr6mm8Y8HqTnoXFXyM0pb9i9d8B8hwST11qyP9poZpt5vkri7yFg8ZcVDF4HlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Lg7hXM4I; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Lg7hXM4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778785846;
	bh=dph0UzICEi7+IQdNrxSeYYGn6jta27DZfFG7worF22I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Lg7hXM4In5A4LlIoKvo+KdSuudKyDPk3dh8RrAOgQ8xpU5UzHYPYE8Mj+/VCFcSIt
	 B4Nc7TDaZrchOb8RwpOfwIJTPxsC6PBG9Z6MHm+9XAGC4VYFYIZQXLwDoc1l+q4EGA
	 LeMm+KtSkbxU2alLmOb5/pyVaChSX5akINx16Se8=
Received: from github.com (hubbernetes-node-b1ec7b6.va3-iad.github.net [10.48.177.35])
	by smtp.github.com (Postfix) with ESMTPA id 1423E28098C
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 12:10:46 -0700 (PDT)
Date: Thu, 14 May 2026 12:10:46 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c47895-48cb22@github.com>
Subject: [bluez/bluez] e19c77: emulator: btvirt: check pkt lengths, don't get
 stu...
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
  Commit: e19c771841e9017326103a8d8e8139b2374ffe19
      https://github.com/bluez/bluez/commit/e19c771841e9017326103a8d8e8139b2374ffe19
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: check pkt lengths, don't get stuck on malformed

Don't try to parse packet before whole header is received.

If received data has unknown packet type, reset buffer so that we don't
get stuck.


  Commit: 5ee43f9993ddb6f42a281b513885d9f0eb9f9a05
      https://github.com/bluez/bluez/commit/5ee43f9993ddb6f42a281b513885d9f0eb9f9a05
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M emulator/main.c

  Log Message:
  -----------
  emulator: btvirt: allow specifying where server unix sockets are made

Make --server to take optional path name where to create the various
server sockets.


  Commit: cc077e4a12dd4d7e3eeeacc1a658416d105f7f39
      https://github.com/bluez/bluez/commit/cc077e4a12dd4d7e3eeeacc1a658416d105f7f39
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M emulator/server.c

  Log Message:
  -----------
  emulator: btvirt: support SCO data packets

Support also SCO data packets in btvirt.


  Commit: f1a303e1d07a715db6d7cadcf757e02f41c0468b
      https://github.com/bluez/bluez/commit/f1a303e1d07a715db6d7cadcf757e02f41c0468b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: btdev: clear more state on Reset

On controller Reset command, initialize most fields in struct btdev to
zero, similarly to the state just after btdev_create().

This excludes some fields like command bitmasks, which hciemu may have
adjusted.

To make this easier, add struct_group() macro similar to what kernel
uses.


  Commit: ff2ecb82e4c38849112aebe0ac9b27af03a2284d
      https://github.com/bluez/bluez/commit/ff2ecb82e4c38849112aebe0ac9b27af03a2284d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: enable path argument for --unix

Allow specifying the path for the controller socket to be used.


  Commit: 82c635c879bf66b6efe36d4efb184c02d9c15dc1
      https://github.com/bluez/bluez/commit/82c635c879bf66b6efe36d4efb184c02d9c15dc1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Add -o/--option option

Allow passing arbitrary arguments to QEMU.


  Commit: 1929b3a99d2f2149fd9fb0e2cb473fcdce4da63a
      https://github.com/bluez/bluez/commit/1929b3a99d2f2149fd9fb0e2cb473fcdce4da63a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: allow source tree root for -k

Allow passing source tree root for -k option, look up kernel below it.


  Commit: 908c14fc3abb96b553821aa81c88f4604af91379
      https://github.com/bluez/bluez/commit/908c14fc3abb96b553821aa81c88f4604af91379
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: use virtio-serial for implementing -u device forwarding

Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu or
kernel seems to be sometimes dropping part of the sent data or insert
spurious \0 bytes, leading to sporadic errors like:

    kernel: Bluetooth: hci0: command 0x0c52 tx timeout
    kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
    btvirt: packet error, unknown type: 0

This appears to occur most often when host system is under load, e.g.
due to multiple test-runners running at the same time.  The problem is
not specific to btvirt, but seems to be in the qemu serial device layer
vs. kernel interaction.

Change test-runner to use virtserialport to forward the btvirt
connection inside the VM, as virtio-serial doesn't appear to have these
problems.


  Commit: 7856de4d69d66d360616ddfd071171358e831ea1
      https://github.com/bluez/bluez/commit/7856de4d69d66d360616ddfd071171358e831ea1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable CONFIG_VIRTIO_CONSOLE in tester config

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.


  Commit: 48cb22a572c7001bf4377cec761702857680f4c0
      https://github.com/bluez/bluez/commit/48cb22a572c7001bf4377cec761702857680f4c0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-14 (Thu, 14 May 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable KVM paravirtualization & clock support in tester kernel config

Enable KVM guest and PTP options in tester kernel config.

This allows synchronizing tester VM guest with host clock, needed for
testers that want to compare timestamps outside the VM guest.


Compare: https://github.com/bluez/bluez/compare/c4789506455f...48cb22a572c7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
