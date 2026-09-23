Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFB4766B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200258; cv=none; b=jSoOYeywHHWlCKMlJHjg91lifLtI7y8scneR5iDj3xiY34XNPvnC6s6TgrDyUbS1x54wHJvhRcmcyt2YkQPjSPCn0/TpPfPD1zEOmcSk/S7pfn0I5QKpCJKrt7yl9NbAaYMBM1B8Ksc0XXhrpXzq8niCqZ404qzBlH0vv9F6GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200258; c=relaxed/simple;
	bh=TYiyI+Rcnx1avZAaCKZhY5KvqMmcOQKU79U2gtL9XMs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ciOlN5bby/IOFP40HVqOn353cZ8RlMPFMT9ZcnpJ5nPHkyWtDbS85I4CCC9Pq35coNMLxHL3MahW8H0UyITdlH2vFD1XJd5iS7zMUbtTXlO1nKPpVWd/ns4vQ3I/Tb8gWEexwojqza6UJyhi1QpiUrE5Pibh7I6Voh1/727zYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JZ99O26i; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JZ99O26i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790200255;
	bh=EQjo66AXelr85LDmJO6GrSOg2/gWNMNZRehc+k/rhOw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JZ99O26i0xgqd6oT6RO+u1UjGFzKILGA27ondeegh7Ci4ifOl9asvvIPmJCeULrAO
	 ERlY5DtXMWJvhq3j1Fov1QIZ77DyY1bTHzGC6E5yjwcligYLq6KiBsq1n86IhHPPoJ
	 SnP7M3HrVvnYwSGet6ohobGQCOhHnSL7RJfybrpM=
Received: from github.com (hubbernetes-node-f8d24aa.ac4-iad.github.net [10.52.175.68])
	by smtp.github.com (Postfix) with ESMTPA id A254FA131B
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 14:50:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 14:50:55 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1172525/000000-b0c89b@github.com>
Subject: [bluez/bluez] 8da060: client/gatt: Fix setting descriptor value from
 scr...
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

  Branch: refs/heads/1172525
  Home:   https://github.com/bluez/bluez
  Commit: 8da060ab2b74f949f372092761306a6b4383ca2a
      https://github.com/bluez/bluez/commit/8da060ab2b74f949f372092761306a6b4383ca2a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Fix setting descriptor value from scripts

gatt.register-descriptor completed the command right after prompting
for the value, so when run from a script the line with the value was
executed as a command instead of being passed to the prompt, causing
the descriptor to be unregistered.

Complete the command once the value is set, as done for
characteristics, and parse a copy of the value so the input line is
not truncated by strsep while still in use by the shell.


  Commit: 2d57d372e98ce22fdaadbe8cfd9f9f2c15a3e31b
      https://github.com/bluez/bluez/commit/2d57d372e98ce22fdaadbe8cfd9f9f2c15a3e31b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Print Connection Subrate event

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.


  Commit: c8991dc61d9c7cb682d9192b5d2c5b4616915cb7
      https://github.com/bluez/bluez/commit/c8991dc61d9c7cb682d9192b5d2c5b4616915cb7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M emulator/main.c
    M emulator/server.c
    M emulator/server.h

  Log Message:
  -----------
  emulator: Default to the latest BR/EDR+LE version

Emulate BR/EDR+LE 6.2 controllers by default, for both local (-l) and
server (--server, --tcp) controllers, so the latest features such as
Shorter Connection Intervals (LE Connection Rate Request) are
supported, e.g. by test-functional which uses --server.

Add the -C/--core=<version> option to emulate older versions instead:
5.0, 5.2, 6.0 or 6.2.


  Commit: c902d6924c73814d989e6aa979a5fa5b904e6055
      https://github.com/bluez/bluez/commit/c902d6924c73814d989e6aa979a5fa5b904e6055
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    A client/scripts/hog-device-sci.bt
    A client/scripts/hog-device.bt

  Log Message:
  -----------
  client/scripts: Add HoG device scripts

Add scripts registering a HID Service (HIDS) acting as a HID over GATT
keyboard, with and without Shorter Connection Interval (SCI) support.

HID SCI Mode can be notified so the device can confirm a mode change.


  Commit: c75369b48952ac51ddcadbaeab2307158c4720f7
      https://github.com/bluez/bluez/commit/c75369b48952ac51ddcadbaeab2307158c4720f7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-hog.rst
    M doc/functional-testing.rst

  Log Message:
  -----------
  doc: Add functional-hog documentation

Document the HoG functional tests, where bluetoothctl registers a HID
Service with and without Shorter Connection Interval (SCI) support
using client/scripts/hog-device*.bt, and the HID host:

- checks HID Information, HID SCI Mode and HID SCI Information with
  gatt.select-attribute/gatt.read
- receives a few Input Reports notified by the HID device
- changes the SCI mode, followed by the connection rate with
  mgmt.conn-subrate, and receives the notification from the HID device
  confirming the mode has been changed


  Commit: bfd8fda2b353d7aa18b058fc308043407497a6e6
      https://github.com/bluez/bluez/commit/bfd8fda2b353d7aa18b058fc308043407497a6e6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    A test/functional/test_hog.py

  Log Message:
  -----------
  test: functional: add HoG tests

Add tests where bluetoothctl registers a HID Service, with and without
SCI support, using client/scripts/hog-device*.bt, and the HID host
checks the service, receives Input Reports and, with SCI support,
changes the SCI mode and the connection rate.

See doc/functional-hog.rst for details.


  Commit: b0c89b68917d4123bb7926dfa344f7fdc9900ed3
      https://github.com/bluez/bluez/commit/b0c89b68917d4123bb7926dfa344f7fdc9900ed3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-23 (Wed, 23 Sep 2026)

  Changed paths:
    M Makefile.am
    M doc/test-functional.rst
    M test/functional/conftest.py

  Log Message:
  -----------
  test: functional: limit the workers by the memory available

Each worker of pytest-xdist runs VM instances, so using one worker per
CPU could run out of memory, with the OOM killer terminating some of
them and tests failing at random.

With -n auto, limit the number of workers by the memory available,
estimating each worker needs memory for 3 VM instances of 256M of guest
memory plus the overhead of qemu, and use -n auto for check-functional
by default, which can be overridden with CHECK_FUNCTIONAL_JOBS.


Compare: https://github.com/bluez/bluez/compare/8da060ab2b74%5E...b0c89b68917d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
