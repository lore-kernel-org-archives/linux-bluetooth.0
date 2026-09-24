Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB53B42C6
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259892; cv=none; b=HyPIo3qZa1s8iy8qntG9ENV1XqYzbpzNyYySexIrI0LheXsS+c0OXsQS9w0d1EnsDSvOh+CdEeBzLZzYleNhi/Aqhe/DGacaprWqaAOvBwedmadhDD4qR2FY75Apu9GAsFc3khdOGPGzK5cA5n1hLZQZMoHvOneq67u9QKEURZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259892; c=relaxed/simple;
	bh=O4hCqFnIbisN4gEG4y4RpZMgPp5jj/Cm4C1ya9GHW/4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uBkBUz9TgK/cRhQKZexHQVeJpiresdp/D0/oM9IOnue99SsiJXtIBOhrs5IyTe0Ye9IMwyCD6id8Ns9KSvFsWNImaUzuxz+OcpLK9hBS8+ITS5Yq5vG3ugoZBHcB4f/KunpPWiAAKe+/Y98TxvXVFUP1Hz7sNPkpp8fXrZD/sXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f/oCOIs8; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f/oCOIs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790259889;
	bh=PhWbzGBx0u2+t8e0UC3nmBKV7iihn8gS5J75Doj+/3U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f/oCOIs8S6272fvtPy9hGttKce3YpcY9+VlI1ukAGDXgBxSsDekKF8xwrOIInRyKf
	 xVmoHQA7QmuSCNdABlPfDzI47uHXHglxD+fRo2qjt7xwiqrMkUKDIIaHY6jj4vMSwJ
	 ahpoVsqv9wfxpueNTa9DiPp4uSNVBDIN08BWrUkU=
Received: from github.com (hubbernetes-node-9aac62c.ash1-iad.github.net [10.56.84.30])
	by smtp.github.com (Postfix) with ESMTPA id 4B460840995
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 07:24:49 -0700 (PDT)
Date: Thu, 24 Sep 2026 07:24:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173166/000000-f191e7@github.com>
Subject: [bluez/bluez] 895f77: attrib: Fix unregistering notifications
 registered...
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

  Branch: refs/heads/1173166
  Home:   https://github.com/bluez/bluez
  Commit: 895f77da97dc7c9cb0247089a25b89442e834943
      https://github.com/bluez/bluez/commit/895f77da97dc7c9cb0247089a25b89442e834943
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

  Changed paths:
    M attrib/gattrib.c

  Log Message:
  -----------
  attrib: Fix unregistering notifications registered with bt_gatt_client

g_attrib_register registers ATT_OP_HANDLE_NOTIFY with bt_gatt_client,
when there is one, returning its id, but g_attrib_unregister always
unregisters with bt_att, so the notification was never unregistered
and its destroy callback was called once bt_gatt_client was freed,
after the user data was freed, e.g. the reports of HoG:

 ERROR: AddressSanitizer: heap-use-after-free
 #11 report_notify_destroy profiles/input/hog-lib.c:359
 #12 attrib_callbacks_destroy attrib/gattrib.c:126
 #13 notify_data_unref src/shared/gatt-client.c:256
 ...
 #17 bt_gatt_client_free src/shared/gatt-client.c:2293
 #18 bt_gatt_client_unref src/shared/gatt-client.c:2605
 #19 g_attrib_unref attrib/gattrib.c:154
 #20 attio_cleanup src/device.c:874

Give out ids of our own, keeping track of how each one was registered
so it is unregistered accordingly.


  Commit: 41645ad2a317bb1e5d92fd2427a2391ccb96618d
      https://github.com/bluez/bluez/commit/41645ad2a317bb1e5d92fd2427a2391ccb96618d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

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


  Commit: 8bbcecc9b28bc9260fe0f0537701daf4310c9ac5
      https://github.com/bluez/bluez/commit/8bbcecc9b28bc9260fe0f0537701daf4310c9ac5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Print Connection Subrate event

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.


  Commit: f498acfcd2179b61be5e3d377718a76640a03768
      https://github.com/bluez/bluez/commit/f498acfcd2179b61be5e3d377718a76640a03768
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

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


  Commit: a046897e840d29f7a6e478b3fa09888dc88491e3
      https://github.com/bluez/bluez/commit/a046897e840d29f7a6e478b3fa09888dc88491e3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

  Changed paths:
    A client/scripts/hog-device-sci.bt
    A client/scripts/hog-device.bt

  Log Message:
  -----------
  client/scripts: Add HoG device scripts

Add scripts registering a HID Service (HIDS) acting as a HID over GATT
keyboard, with and without Shorter Connection Interval (SCI) support.

HID SCI Mode can be notified so the device can confirm a mode change.


  Commit: 6db64b52fdd547687ac49d9a6e219529ba7e176c
      https://github.com/bluez/bluez/commit/6db64b52fdd547687ac49d9a6e219529ba7e176c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

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


  Commit: f3c32979b1b1b5aad1508487403aa5229e95ed44
      https://github.com/bluez/bluez/commit/f3c32979b1b1b5aad1508487403aa5229e95ed44
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

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


  Commit: f191e73d06e8e8533491139d727e53f7c9cb1928
      https://github.com/bluez/bluez/commit/f191e73d06e8e8533491139d727e53f7c9cb1928
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

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


Compare: https://github.com/bluez/bluez/compare/895f77da97dc%5E...f191e73d06e8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
