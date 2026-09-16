Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268D46EC9E
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593824; cv=none; b=OtGUi1Nje5HFiLiVyfEeXsA+JtFgxVx2N1SiKdGfstM+kXMK3wzc9BueCZB75/stQtpyVtQ/Pz3GHjXFKIG0d8rw6GvGeeRhTmv79XL9CNTNQ9cogz9im6mYxihuBKqOlcnlKRE/0s25zUS+zETdek9csGfc+i0/5dm8X7tJtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593824; c=relaxed/simple;
	bh=Y819lwQ94riPUY4CCgAw/B+UvrEKWfTImOf9rMZ3vrA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i2Rm34DtI3Nno8s0F/s6fE12lYTTo3ahqa+UnhpNof3SfRRH6uOU0zKiTmTf7vtSlXFsTiNMRhMzx6rK27W3eKhIdss2dG3wQY+XapiBD8JcnH0h8Xi6SrLnDJm1aRfLjBUPQhwBuNeL7NyCxDZGvavh4+dgTxMdPp49GaaDqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LeDmXoHW; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LeDmXoHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789593814;
	bh=/DYrgnkjtFDgpaMaX80H5Qex5wulU/K2ZDEdCiUC8OA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LeDmXoHW/4ui877vWyCwMESvoXZcQIzCMV5sLhNYzaDy8Dd1ijNawDn8d0R/43lku
	 FM4Z4Dg42X6/3NafTOWORH3NvjJzxF6quRvE5DCRjnaz1/dlTso3OXZ0DiSHpV9IBA
	 8YygvV3NefT+DEsveUeJedfwBVy1vLm0nJkF7UgY=
Received: from github.com (hubbernetes-node-5ec67cf.ash1-iad.github.net [10.56.155.24])
	by smtp.github.com (Postfix) with ESMTPA id 54C40600A00
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 14:23:34 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:23:34 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e2ec68-f87a79@github.com>
Subject: [bluez/bluez] 825c98: shared/bass: add a ready callback
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
  Commit: 825c98da2a691a5ea202c9d69a003d5f48e444e0
      https://github.com/bluez/bluez/commit/825c98da2a691a5ea202c9d69a003d5f48e444e0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: 6eb23703b473f2612be4eb306c48127461ad0138
      https://github.com/bluez/bluez/commit/6eb23703b473f2612be4eb306c48127461ad0138
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: 915926f516bc0a50fc1725384abf9ef9b99605c3
      https://github.com/bluez/bluez/commit/915926f516bc0a50fc1725384abf9ef9b99605c3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: d1130406008a09d90d3994bac0a15efa14258a05
      https://github.com/bluez/bluez/commit/d1130406008a09d90d3994bac0a15efa14258a05
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: 8da79557195aaad9b9b26161cc93741bf4341bd1
      https://github.com/bluez/bluez/commit/8da79557195aaad9b9b26161cc93741bf4341bd1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst

  Log Message:
  -----------
  doc: describe the BAP coordinated set test cases

Assisted-by: opencode:claude-opus-5


  Commit: 4ff7deaf8c908626f71b72880289e51bd4fe081d
      https://github.com/bluez/bluez/commit/4ff7deaf8c908626f71b72880289e51bd4fe081d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: 526befeb949c059044edb149f731fc2efd71a31c
      https://github.com/bluez/bluez/commit/526befeb949c059044edb149f731fc2efd71a31c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: 9251e630efddca28fd6526e7525c77daf43c9eb7
      https://github.com/bluez/bluez/commit/9251e630efddca28fd6526e7525c77daf43c9eb7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: 2f9cb900d4719d745cc711d594995544bf7ffc7c
      https://github.com/bluez/bluez/commit/2f9cb900d4719d745cc711d594995544bf7ffc7c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: 12b85dddb26e074536a5c7005243e7c79548245f
      https://github.com/bluez/bluez/commit/12b85dddb26e074536a5c7005243e7c79548245f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: e1566fd5568b219b451082c6f8cf5c5bee2b7eac
      https://github.com/bluez/bluez/commit/e1566fd5568b219b451082c6f8cf5c5bee2b7eac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

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


  Commit: a410e06a4b61950174bfc4dcc62cd043f15024c8
      https://github.com/bluez/bluez/commit/a410e06a4b61950174bfc4dcc62cd043f15024c8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M doc/test-runner.rst
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: Enable interrupt remapping for PCIe passthrough

A device passed through with -P fails to allocate its MSI-X vectors
(-ENOSPC) as the guest has no way to remap interrupts, so give it a
virtual IOMMU with interrupt remapping enabled, which in turn requires
the irqchip to be split.

Without this the guest is not presented with a DMAR table at all, so
enabling CONFIG_INTEL_IOMMU and CONFIG_IRQ_REMAP on the test kernel has
no effect, and both are now documented as required.

The machine type is moved out of the static argument list as it now
depends on whether -P is used, the resulting command line is otherwise
unchanged.

The model wrote the change and confirmed the guest is only presented
with a DMAR table once the virtual IOMMU is added; it was reviewed and
tested by the author.

Assisted-by: Claude:claude-opus-5


  Commit: 1effba22606ac62c8a4ca56313eb6b44318ca3d2
      https://github.com/bluez/bluez/commit/1effba22606ac62c8a4ca56313eb6b44318ca3d2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M doc/test-functional.rst

  Log Message:
  -----------
  doc/test-functional: Document PCIe controller passthrough

The tests needing a real controller can now use a PCIe one with --pcie
and --force-pcie, in the same way --usb and --force-usb use an USB one.

Unlike an USB controller, which only needs its device node to be
readable, a PCIe controller is bound to vfio-pci while a VM host uses
it, so the tests have to be run as root and the controller has to be
alone in its IOMMU group.

The model wrote the option handling in pytest-bluezenv and this section;
it was reviewed and tested by the author.

Assisted-by: Claude:claude-opus-5


  Commit: 77b5cba5d27b99633ac77ed3ae691853c6e270a8
      https://github.com/bluez/bluez/commit/77b5cba5d27b99633ac77ed3ae691853c6e270a8
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for Bluetooth 6.1, 6.2 and 6.3 versions


  Commit: f87a79667dac5dd2178bc224dea89b77d08f0a59
      https://github.com/bluez/bluez/commit/f87a79667dac5dd2178bc224dea89b77d08f0a59
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-09-16 (Wed, 16 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add event mask entry for Encryption Change [v2] event


Compare: https://github.com/bluez/bluez/compare/e2ec6827f7be...f87a79667dac

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
