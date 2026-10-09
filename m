Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058939934C
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791589077; cv=none; b=Z7+dHpduyCmYLQgZtJYKhKXJlWE+WYitJp3LrmaRFtiTkYsK19YSbLyykhWfMD7L8lBznTF0OOs7sKeUqMKqkIO6qt28HdheJ7LIu5kIUnihcwG9bGqJhFLtmbTX/+Rjw+QCsbTCePWL3ksXNjtFuqGx8AFqGivgyTQOeRWb6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791589077; c=relaxed/simple;
	bh=JJ/3KBtCof523jub3N+ghgEFsS14LLkd1k7cMZBI0h4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jxtLQZeDWaCcQIWWiChyl8JOXnHldss56QRwf890QhKeDxC8e1ZfIUuboD9FaYZBYcoIR7Z783kWLp6yvGmOeP0Up+WNJZvjFOIG1fVWKD7h4RcTamP+jSXv7O77o6l6dQyHW5vJfmTQYEuCPYHf4cvcYttE+xj/6CXbJhDlBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=YkR5TBSv; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="YkR5TBSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791589075;
	bh=OukZv0ApzPRFbLVO+4VMHlK/t+AWtd2+jFz3ZNJJnas=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YkR5TBSv9Wh5zfge2UTXW8iKt1aiEedBagDKbXNUbBbfbj9cbKX5DW+2qLHRjp1zS
	 x1fWY4sxWl53+rR6NA9GloGra7AqF6mRxjL6Qlnsa3iUFh5hYPQpaHMbtuo9v7NTUP
	 AdVko19cMJJPhCXwlzl7abxQLMcoEJHyTvQrSJ8h/aLN6REAjyMFZ+HnhnZ+pfuHYw
	 jVlCN2zOgOUk9Rnqn8vQm2gBYZNntpgXZ6c0GbSFoWHIfRowc06bavG3RbAdsdaSwE
	 dHDVTAuPimdpZ6VH1I72WmCTFip++L//UEBc4hVVrd+QizIW3IPwKgZjPQhFtYprCt
	 V9ruzeRLCoyQg==
Received: from github.com (hubbernetes-node-ac264f9.va3-iad.github.net [10.48.67.62])
	by smtp.github.com (Postfix) with ESMTPA id B59EE340E13
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 16:37:55 -0700 (PDT)
Date: Fri, 09 Oct 2026 16:37:55 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b11135-7428ca@github.com>
Subject: [bluez/bluez] c31e90: org.bluez.Bearer: Add Role property
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
  Commit: c31e9091e646b61cfce3634baac03636f2760ac8
      https://github.com/bluez/bluez/commit/c31e9091e646b61cfce3634baac03636f2760ac8
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M doc/org.bluez.Bearer.LE.rst

  Log Message:
  -----------
  org.bluez.Bearer: Add Role property

This adds Role property to org.bluez.Bearer.LE1 which indicates whether
the remote device is the central or the peripheral of the current LE
connection, so applications can tell a central that connected to the
adapter from a peripheral the adapter connected to.

Assisted-by: Claude:claude-opus-5.5


  Commit: 76890c8fd3255bd1b0d64e3c35abb38ef3d87b22
      https://github.com/bluez/bluez/commit/76890c8fd3255bd1b0d64e3c35abb38ef3d87b22
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Add Role property

This implements Role property for the LE bearer using the initiator
flag of the Device Connected event, which the kernel sets when the
adapter created the connection as central, and emits PropertiesChanged
along with Connected.

Assisted-by: Claude:claude-opus-5.5


  Commit: 2515706490c2d569885cd553a553de12cb2fc867
      https://github.com/bluez/bluez/commit/2515706490c2d569885cd553a553de12cb2fc867
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print LE.Role in info

This prints the Role property of the LE bearer with the likes of info
command:

bluetoothctl> info <addr>
...
        LE.Connected: yes
        LE.Connectable: yes
        LE.Role: central

Assisted-by: Claude:claude-opus-5.5


  Commit: 926bbc5dfe29a19d579d29fd81d7c5a5952a3ecd
      https://github.com/bluez/bluez/commit/926bbc5dfe29a19d579d29fd81d7c5a5952a3ecd
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-bearer.rst
    M doc/functional-testing.rst

  Log Message:
  -----------
  doc: Add functional-bearer documentation

Document the bearer functional tests, where two hosts connect or pair
over LE or BR/EDR and each checks the org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1 properties of the device object it has for the
other:

- Connected and Role on both sides of an LE connection, and the
  Disconnected signal with its reason on both sides
- Connectable for a connectable advertiser and for a broadcaster
- Paired, Bonded and Connected after LE and BR/EDR pairing, Role being
  only reported for LE

Assisted-by: Claude:claude-opus-5.5


  Commit: ce448a8a7a3bf538c443235c9c7b38d4aea841cf
      https://github.com/bluez/bluez/commit/ce448a8a7a3bf538c443235c9c7b38d4aea841cf
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    A test/functional/test_bearer.py

  Log Message:
  -----------
  test: functional: add bearer tests

Add tests where host0 connects to or pairs with host1 over LE or
BR/EDR, and both hosts check the properties and the Disconnected
signal of the bearer interfaces of the device object they have for the
other, including the LE Role of each side of the connection.

See doc/functional-bearer.rst for details.

Assisted-by: Claude:claude-opus-5.5


  Commit: 7428ca2df9356363079db0f48412c20cbdb9471f
      https://github.com/bluez/bluez/commit/7428ca2df9356363079db0f48412c20cbdb9471f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix LE bearer Connect not replying

If the ATT socket of an outgoing LE connection connects before the MGMT
Device Connected event is processed, att_connect_cb sets the LE state as
connected, so device_add_connection bails out as already connected and
btd_bearer_connected is never called. Bearer.LE1.Connect is then left
without a reply, the initiator flag is not set and Device1.Connected is
not emitted.

Fix it by calling device_add_connection from att_connect_cb when the LE
state is not yet connected.

Fixes: 4e21ebcaa5d0 ("bearer: Implement Connect/Disconnect methods")
Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/b111351fd617...7428ca2df935

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
