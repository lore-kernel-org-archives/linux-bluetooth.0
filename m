Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D603D6CC5
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849037; cv=none; b=jcK4Fe9sh2iRa9E/SEnVaM5jlHE3PtHIaC+TslGo+RP24rbEmIIUAxwsgzr4F2Ya48xq+puwJpT1xvKIFPRqBdpJiGAshGanL9QjhucgTfE6SJjKT3eZft8gtAYINjpGFOLJqF1BklvnX81tKt6/0nlbezJNsmF0oT9s1jOuQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849037; c=relaxed/simple;
	bh=PR68wEl2cP1YEj2clZ+hyyClihpjWEfs8FZpXB24LEQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aTX10DoDdj0YwrmuzYtwjfTSJNqYWJWCqZ0N4PjBmQpV0Ec/DMFfcuGxmDRvb6MXRl9ePCQQu+XD9XqYfOoEAiBgheNpmIjNNr0ikJmdOtE5MYdJlEh4o/p0G4LQnpSuIhIlGZYRGyrfKmG5w36dz+E0j5l469H7yb36RMOVVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=cZ7wr0xc; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="cZ7wr0xc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791849034;
	bh=VL49R4xt12gbES/zrQVer3jH8OkJ/P6F5PW4zOcNgb4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cZ7wr0xc7SX8dNlzEWEmQXGYxc6MXvN7myusfqH6MGIFfvnE/90ENGLEQ0mtMpbAR
	 ldbJvEd6Z9Xbfp0tIvxG54v8yndaZ9cepTQ5v/vaWKwcU5tsNzLtV85jETm2PP+7oZ
	 sqtR4AB8q+zXN0riXS29c8I8ulVqjS+FCm91jEX6eDaR8/XeWkU+hdtjJqAil8Ivcu
	 QB2QzuSrVZTQs4xdg6wcL+SbAOwv4AmodpJ6dOfabwSP45kO9yB3/MM3qWL6B9SGKO
	 rkKYm9eJ+kn6JH6kKR5O0nvN0WFQNKYsFm+6JvUULARnJVcqMIjZqr7VGfZHjAWaZ4
	 IG5dU81qPBW2A==
Received: from github.com (hubbernetes-node-89d6902.ash1-iad.github.net [10.56.149.25])
	by smtp.github.com (Postfix) with ESMTPA id A5BE8840C5D
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 16:50:34 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:50:34 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7428ca-9dc7e4@github.com>
Subject: [bluez/bluez] 087ac3: test: functional: change the HoG connection
 rate f...
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
  Commit: 087ac3d6f198534702bf8cd8b89c83923bb18656
      https://github.com/bluez/bluez/commit/087ac3d6f198534702bf8cd8b89c83923bb18656
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M doc/functional-hog.rst
    M test/functional/test_hog.py

  Log Message:
  -----------
  test: functional: change the HoG connection rate from the HID device

As specified by the HIDS/HOGP SCI FIPD, the HID device initiates the
Connection Rate Update procedure once the HID host writes the mode to
the HID Control Point, so load the connection subrate on the HID device
instead of the HID host.

This requires the kernel to issue the LE Connection Rate Request as
peripheral, so the test is marked as expected to fail otherwise, the
parameters being loaded but the connection rate never changed.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 1b52ab98e6c54d4794a78b6fc7a2f52071317ead
      https://github.com/bluez/bluez/commit/1b52ab98e6c54d4794a78b6fc7a2f52071317ead
  Author: Ye He <ye.he@amlogic.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M src/bearer.c

  Log Message:
  -----------
  bearer: Cancel disconn_timer upon btd_bearer_disconnected

If a fast reconnect occurs after a rapid disconnect,
the 2-seconds bearer->disconn_timer may still fire and
tear down the newly established link.

Fix this by cancelling the disconn_timer inside
btd_bearer_disconnected().


  Commit: f088feb4f6dd725c16f3403e582fba45ed507df2
      https://github.com/bluez/bluez/commit/f088feb4f6dd725c16f3403e582fba45ed507df2
  Author: Ye He <ye.he@amlogic.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix BR/EDR bearer when merging duplicate device

A device first discovered over BR/EDR and later over LE with a private
address has two device objects until its IRK is distributed and they are
merged. device_merge_duplicate() copied dup->bredr into dev, so both
objects shared one bearer and whichever was freed second used a bearer
already destroyed by the first.

Give dev its own BR/EDR bearer instead, unless it already has one, and
inherit the paired and bonded state from dup. The connection state is not
inherited since dup still owns the link and receives its disconnection.

Fixes: d9294d644930 ("core: Add support for merging duplicate device object data")
Assisted-by: OpenCode:claude-opus-5.5


  Commit: 8da7e648a9fb7e510cc62ecce174bc7f0a3a66e8
      https://github.com/bluez/bluez/commit/8da7e648a9fb7e510cc62ecce174bc7f0a3a66e8
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Free hooks in btdev_destroy

Hooks added with btdev_add_hook() are only freed by btdev_del_hook(),
so a hook still installed when the device is destroyed is leaked. Five
mgmt-tester cases leave one installed: "Add + Remove Device Nowait -
Success" and the four "Adv. (non-)connectable & connected" cases on the
LE emulator; one l2cap-tester case does too. They pass, but with ASan
the tester exits with status 1 because LeakSanitizer reports, for
mgmt-tester:

  Direct leak of 120 byte(s) in 5 object(s) allocated from:
    #0 in malloc
    #1 in btdev_add_hook emulator/btdev.c:8891

Free the remaining hooks in btdev_destroy().

Fixes: 37199df506f4 ("emulator: Add support for pre/post command/event hooks")


  Commit: bf98544491b2a09e1d88d5087725e58d61235ec5
      https://github.com/bluez/bluez/commit/bf98544491b2a09e1d88d5087725e58d61235ec5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M unit/test-rap.c

  Log Message:
  -----------
  unit: test-rap: disable optimization to speed up compilation

Compilation of this file with optimization takes 4 minutes with ASAN.
Disable optimization to reduce to 2 sec.

autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
unit_test_bap_CFLAGS. Use pragma instead.


  Commit: da2406695f708edade0fa95849ad590f4b05ba5b
      https://github.com/bluez/bluez/commit/da2406695f708edade0fa95849ad590f4b05ba5b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Track RAS CCC state per connection

The Real-time, On-demand, Ranging Data Ready and Ranging Data Overwritten
CCC values were stored on the RAS service shared by all connections, while
ranging data is sent on the ATT channel of the connection that produced
it. One central's subscription could therefore decide whether, and with
which transport, another central was sent ranging data, and the Real-time
vs On-demand exclusivity check rejected a central because of another
central's configuration.

Store the values on the bt_rap session of the writing connection instead
and use them for the mode, transport and subscription checks.

Fixes: a9b39d71597d ("src/shared: Add RAS packet format and notification support")
Fixes: 2ac9fc0901c4 ("shared/rap: Honor CCCD transport for RAS on-demand ranging data")
Assisted-by: OpenCode:claude-opus-5.5


  Commit: f3344d20d9047a15c4c6becd94bef76b27ebdf5f
      https://github.com/bluez/bluez/commit/f3344d20d9047a15c4c6becd94bef76b27ebdf5f
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M emulator/btdev.c
    M emulator/btdev.h

  Log Message:
  -----------
  emulator: Add btdev_send_event

Allow a tester to send an arbitrary event from the emulated controller,
for instance from a command hook, so that the order of events around a
command can be chosen by the test.


  Commit: 2942883d2738a70a96229e3088dd81ec8b5d02b0
      https://github.com/bluez/bluez/commit/2942883d2738a70a96229e3088dd81ec8b5d02b0
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M emulator/vhci.c
    M emulator/vhci.h

  Log Message:
  -----------
  emulator/vhci: Add vhci_set_quirk_simultaneous_discovery

Set or clear HCI_QUIRK_SIMULTANEOUS_DISCOVERY through the kernel's
quirk_simultaneous_discovery debugfs entry, which only accepts writes
while the controller is down.

This entry name is the longest so far: its path does not fit in the
64 byte buffer of vhci_debugfs_write() from hci1000 on, so size the
buffer with PATH_MAX and use snprintf().


  Commit: 49a70562f0bf4c1d19e26337a7c44c17c9283e8e
      https://github.com/bluez/bluez/commit/49a70562f0bf4c1d19e26337a7c44c17c9283e8e
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add simultaneous discovery stop tests

With HCI_QUIRK_SIMULTANEOUS_DISCOVERY, kernels without commit
96d006ae6445 ("Bluetooth: hci_event: fix simultaneous discovery stuck
in FINDING") stay in DISCOVERY_FINDING when the Inquiry Complete event
arrives after LE Set Scan Enable (disable) was sent but before its
Command Complete: no Discovering (disabled) event is sent and every
later Start Discovery fails with Busy.

Both tests set the quirk through debugfs and send the Inquiry Complete
themselves: one second into the discovery (Simultaneous Inquiry First,
the normal order) or from the LE Set Scan Enable (disable) command
hook, before its Command Complete (Simultaneous Inquiry Late). The LE
scan timeout itself is not shortened. One second after that command a
new Start Discovery probes the state; a test fails if no Discovering
(disabled) event came before the probe or if the probe does not
succeed. Without the kernel fix the Late test fails. If the debugfs
entry cannot be opened, the tests are reported as Not Run.


  Commit: 9dc7e40962f11d1d9a5568f8a7633a695288329c
      https://github.com/bluez/bluez/commit/9dc7e40962f11d1d9a5568f8a7633a695288329c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-12 (Mon, 12 Oct 2026)

  Changed paths:
    M src/bearer.c

  Log Message:
  -----------
  bearer: Remove disconn_timer when freeing the bearer

The timer armed by Disconnect is only removed when it fires or when the
bearer disconnects, so a device removed within DISCONNECT_TIMER seconds of
a Disconnect call leaves it to run bearer_disconnect_link() on the freed
bearer.

Remove it in bearer_free().

Fixes: 4e21ebcaa5d0 ("bearer: Implement Connect/Disconnect methods")
Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/7428ca2df935...9dc7e40962f1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
