Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888FC4A23
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517048; cv=none; b=nM1nLYQxWBTjTSYrBITLDw4a2JI1pTn5a1OkIm90dyihWI/ve5H/oBerFK3gOzzH1Hbni+bmWpQfeAc7+c22mdjOHjP7mRNMwdP+dDK5Mt5k2Tg0eIHYonG1gadOAcs7Q3X1NkvsIGDlWUUEDx+8IlfklbgKzVlOj41LdU4j3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517048; c=relaxed/simple;
	bh=AonkfEf3cXa5jKiAljw03eEisPJJwCkx1Dt9NG0o+7Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E2nvhf3VPEUb4f0qdXTtXRrJwqTdDNjJe6oJ4nUsby0PN2x02i8A4JcIypxBnhYyOJ4BtUUwJ5oJwMqcrUO92F31TYgZlfFK0zT4Y3v9v8fpMAs65AI8P7xLCe137/T3qE/QafyEmAfhW1WsK4nfN2o/VMR0shjA9N5UW26yUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O1JIMmJU; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O1JIMmJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789517045;
	bh=mTnie00JP5wrds4Q8kkuA+/xDhC34vpPDFqHXjRCkxw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O1JIMmJUJf8lwGIt0c7F9jz+OScf6mYgnP9TMhFim94RfBUOdnPls20dOkiG2xPgv
	 dl6ngH9vZtUpXMozKjxT3rH80OD58Z6IywavbRQRNvyU6d9fP8VIpsrkVntBVXosBb
	 aickA/XRbZD8TRzcSZtt7CYLdp8cHpRwUM7a5XuE=
Received: from github.com (hubbernetes-node-8e6e882.ac4-iad.github.net [10.55.93.34])
	by smtp.github.com (Postfix) with ESMTPA id 95DE9780728
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:04:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:04:05 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1165926/000000-f8ccd9@github.com>
Subject: [bluez/bluez] c05a81: shared/bass: add a ready callback
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

  Branch: refs/heads/1165926
  Home:   https://github.com/bluez/bluez
  Commit: c05a81937cddad3984222fd15c829dd8fb8fc72d
      https://github.com/bluez/bluez/commit/c05a81937cddad3984222fd15c829dd8fb8fc72d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: add a ready callback

A BASS client has no way to tell when the session is usable, i.e. when
the service discovery, the reads and the subscriptions triggered by
bt_bass_attach() are complete.

Without it an upper layer may write to the Broadcast Audio Scan Control
Point before the Broadcast Receive State notifications are enabled, and
miss the state changes the write causes, as the notifications are only
sent to clients that have enabled them.

Register for the GATT client idle event and notify the registered
callbacks once it is reached, as done for BAP.

Assisted-by: opencode:claude-opus-5


  Commit: 70ee89a0a6461f250fa4c663f2580e809135e342
      https://github.com/bluez/bluez/commit/70ee89a0a6461f250fa4c663f2580e809135e342
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: wait for the session to be ready before pushing a source

A Broadcast Assistant could write to the Broadcast Audio Scan Control
Point of a Scan Delegator before its own session had enabled the
Broadcast Receive State notifications, as the connection was completed
as soon as the session was attached.

When that happens the delegator handles the Add Source, sets the state
to request the sync info to be transferred, and notifies it, but the
notification is dropped since the assistant has not subscribed yet. The
assistant never learns it has to transfer the sync info, so PAST never
happens, and the delegator is left waiting for it until the kernel
gives up, which takes 20 seconds, and falls back to creating the sync
itself.

Complete the connection only once the session is ready, and queue any
push received in the meantime, replaying it afterwards, so it is not
rejected just because the user was quick.

With this the sync info is transferred right after the Add Source, and
test_bass_past_transport_acquire consistently takes around 11 seconds
instead of intermittently taking over 40 seconds when the transfer was
missed.

Assisted-by: opencode:claude-opus-5


  Commit: 9f59237d9f2f16a1420ef28feb8ef1a6fa41a6ab
      https://github.com/bluez/bluez/commit/9f59237d9f2f16a1420ef28feb8ef1a6fa41a6ab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M test/functional/conftest.py

  Log Message:
  -----------
  test: functional: report what a test is waiting for

A test that is stuck gives no clue about what it is waiting for until it
times out, which makes it hard to tell a slow test from a hung one.

Report the calls that take too long, along with how much of their
timeout is left. When the terminal can be updated in place the report is
refreshed as it goes and erased once the call completes, so only the
waits that are actually slow are visible. The workers of pytest-xdist
share the terminal, and none of them can update a line of its own, so
they report whole lines instead, prefixed with the worker they come
from.

The report goes to the terminal directly, as pytest captures the output
at file descriptor level, and is disabled when there is none, e.g. under
CI, or with --progress=no.

Assisted-by: opencode:claude-opus-5


  Commit: 34f6fee82a7bf3e38d5f586236037393e6fdc8fb
      https://github.com/bluez/bluez/commit/34f6fee82a7bf3e38d5f586236037393e6fdc8fb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M test/functional/test_avrcp.py

  Log Message:
  -----------
  test: functional: answer the notification registered by the victim

The AVRCP target of the NN-2026-0145 test tells the victim it supports
the track changed event, so the victim registers a notification for it,
but the target never answers it.

The request then times out after 10 seconds, is retried once, and times
out again, so the victim only sends the ListPlayerAttributes the test
needs 20 seconds later, which is most of the time the test takes.

Answer it with an interim response, as a target would.

Assisted-by: opencode:claude-opus-5


  Commit: 64f65fb6201c35286d386e4b0dcafcc481856434
      https://github.com/bluez/bluez/commit/64f65fb6201c35286d386e4b0dcafcc481856434
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst

  Log Message:
  -----------
  doc: describe the BAP coordinated set test cases

Assisted-by: opencode:claude-opus-5


  Commit: 20de146d203d98ee949228273174898279f190dd
      https://github.com/bluez/bluez/commit/20de146d203d98ee949228273174898279f190dd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: use the handle of the receiving side

Every device assigns its own connection handles, so the two sides of a
link do not necessarily know it by the same handle: conn_link() picks
the lowest one free on each device, which differ as soon as a device
has more than one connection.

The events and the data delivered to the peer carried the handle of the
sender though, so the receiving side got a handle it knows nothing
about and dropped what it received: with three devices the second link
of the initiator is handle 2 on it and handle 1 on the peer, so neither
the ACL data nor the CIS requests reached their destination.

Give the receiving side its own handle, as the disconnection already
does, for the data as well as for the events reporting a connection, a
key request, a connection update and the CIS of a CIG.

This changes nothing for two devices, as both sides then assign the
same handles.

Assisted-by: opencode:claude-opus-5


  Commit: 7cb6ac00e86565e6af7dca07cdb8bdf779bcc7c0
      https://github.com/bluez/bluez/commit/7cb6ac00e86565e6af7dca07cdb8bdf779bcc7c0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: allow the maximum number of CIS of a CIG

The Num_CIS of LE Set CIG Parameters ranges from 0x00 to 0x1f, but only
three CIS were accepted, so setting up a CIG with more of them failed
with Memory Capacity Exceeded.

A CIG has one CIS per direction of every member of a coordinated set,
so four of them are needed for a stereo stream to a set of two.

Take the maximum the command allows, which the handles of a CIG have
room for: they start at CIS_HANDLE and the ones of a BIG only start at
BIS_HANDLE, 256 handles later.

Assisted-by: opencode:claude-opus-5


  Commit: 678800acd11ac747218ea338d1b027978ea627b4
      https://github.com/bluez/bluez/commit/678800acd11ac747218ea338d1b027978ea627b4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: keep the long term key of both roles

LE legacy pairing distributes one long term key per role: each side
generates its own and gives it to the peer, which uses it to encrypt
the link when that side is the peripheral. Secure Connections derives a
single key instead, so there is only one to keep.

Only one key was kept though, whichever arrived last, so the key ending
up on each side of a legacy bond was not necessarily the same one.

Encrypting the SIRK of a coordinated set then gave a value the other
side was unable to decrypt, as sef() is only symmetric when both sides
use the same key, and the set was resolved under a SIRK that is not the
one the members were configured with.

Keep the key of each role and select the one matching the role of the
link, so both sides use the key the peripheral distributed.

Assisted-by: opencode:claude-opus-5


  Commit: e84aaa3ac847fe39d9445b756392d303babfdf80
      https://github.com/bluez/bluez/commit/e84aaa3ac847fe39d9445b756392d303babfdf80
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M client/agent.c
    M client/main.c
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  client: allow a capability with the auto agent

The auto agent registers with no capability, which is KeyboardDisplay,
so a peer pairing with it may well choose the entry of a passkey. That
is a method the auto agent cannot answer: it only replies by itself to
the confirmation and the authorization requests, and the passkey entry
is left to the user, who is not there to answer it in a test.

The pairing then only completes once the request times out, 30 seconds
later, and it completes as a failure.

Accept a capability after the name, e.g. auto:NoInputNoOutput, to let
the capability be the one pairing Just Works, which requires no answer
at all. Plain auto keeps registering as before.

Assisted-by: opencode:claude-opus-5


  Commit: c43477d608d85584c23a8fa2dac5c8e9cec5506b
      https://github.com/bluez/bluez/commit/c43477d608d85584c23a8fa2dac5c8e9cec5506b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: fail as soon as an operation fails

A test waiting for what an operation reports on success only learns
that it failed when the wait times out, 20 seconds later, and what it
reports then is the pattern it was waiting for, not the error.

Watch for the failures alongside it, so a test fails right away and
tells what went wrong, e.g. "Failed to pair:
org.bluez.Error.AlreadyExists".

Assisted-by: opencode:claude-opus-5


  Commit: f8ccd96939281bc663ff112bd5a74abf4acc7dec
      https://github.com/bluez/bluez/commit/f8ccd96939281bc663ff112bd5a74abf4acc7dec
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    A client/scripts/bap-sink-lc3-left.bt
    A client/scripts/bap-sink-lc3-right.bt
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: add the BAP coordinated set tests

Cover a stereo unicast stream to a coordinated set of two acceptors,
one taking the left channel and one the right, which is what a pair of
earbuds does.

The acceptors advertise the RSI of the set and are configured with the
same SIRK, so the initiator resolves them into a single DeviceSet and
connects the second one on its own once the first is paired.

The endpoints are not configured by the test, as the daemon configures
a stream for them by itself, and the transports of both members are
acquired, as the CIS of a CIG are only created once every one of them
is active.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/c05a81937cdd%5E...f8ccd9693928

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
