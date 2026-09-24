Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BF1E9919
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274760; cv=none; b=WxG2sA2JWJ9EnZtS0DjHPHjEgZC7msBOgb4ugkzKWc4BzaRt/GC+no4j4JH5PBZYdoEswkOq3WDH8RUtT4Zw72GRQ/hNFqfCm/fs+lIpq4RpwmJGfWFoZGP8FdUkcKHPae3hrrSNlg+ySaPkU+nFcYD0PKYQciTth1r98pKb+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274760; c=relaxed/simple;
	bh=2ThfDd7OoZBp+litq2bRtJoZrlISWUsVCNcdScDO8zU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W1+UT12WS4+zI7M2EzR1yOQdjLBfm6+iP+Vz9xhZuiH1KswIDOKSAcLAh+Eu4MqdDf/BlSWK+0Nf2c8eLTxE+ajDDLTxkkPWz017UyNAh14Re8DuDFgz6ewewrwMO9zImLwi1E8LQEKlCUN9ngw7kjA+kn5zbIMyG9NKwvRitVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NuSdFRcZ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NuSdFRcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790274757;
	bh=u45K9qr5HcLfwgamEStdJhxefdizffpNHlkOOa87U6Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NuSdFRcZrRo5HSJAOAumvee+cnb4YfrdO1bZHpXI2vVvkr51B5yY6SFvi4ERr1GXu
	 E9gW4y8xODy20045Oo+RBefh8Ihhp9M091Oug5+WsbGYK2W2vWf+7xJ7JEgohGcxOJ
	 iFEZICpSSs6GgYMycE/qF9UvY4q7kK28swawYuVY=
Received: from github.com (hubbernetes-node-e3670d5.ash1-iad.github.net [10.56.196.61])
	by smtp.github.com (Postfix) with ESMTPA id DC8B06004BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 11:32:37 -0700 (PDT)
Date: Thu, 24 Sep 2026 11:32:37 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173252/000000-1fc655@github.com>
Subject: [bluez/bluez] a3a07d: shared/gatt-client: Fix calling destroy after
 unre...
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

  Branch: refs/heads/1173252
  Home:   https://github.com/bluez/bluez
  Commit: a3a07d213b3de35353eda21c6429bf869643f678
      https://github.com/bluez/bluez/commit/a3a07d213b3de35353eda21c6429bf869643f678
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-24 (Thu, 24 Sep 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Fix calling destroy after unregistering notify

bt_gatt_client_unregister_notify resets the callbacks of the
notification but not its destroy callback, which is called once the
notify_data is freed. If a procedure is still pending at that point,
e.g. the write of the CCC to disable the notifications, it holds a
reference to notify_data so destroy is called later, once the user data
may have been freed, e.g. the reports of HoG:

 ERROR: AddressSanitizer: heap-use-after-free
 #11 report_notify_destroy profiles/input/hog-lib.c:359
 #12 attrib_callbacks_destroy attrib/gattrib.c:130
 #13 notify_data_unref src/shared/gatt-client.c:256
 #15 destroy_write_op src/shared/gatt-client.c:3189
 #16 request_unref src/shared/gatt-client.c:201
 #17 destroy_att_send_op src/shared/att.c:215
 #18 bt_att_cancel src/shared/att.c:1925
 #19 cancel_request src/shared/gatt-client.c:2783
 ...
 #21 bt_gatt_client_cancel_all src/shared/gatt-client.c:2811
 #22 bt_gatt_client_free src/shared/gatt-client.c:2290

Call destroy when unregistering instead.


  Commit: 7ddf389ddd8949a87e45966f1205335ca70d3bea
      https://github.com/bluez/bluez/commit/7ddf389ddd8949a87e45966f1205335ca70d3bea
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


  Commit: 99923f9fc656df2e085b00f2b54df7983d27a2de
      https://github.com/bluez/bluez/commit/99923f9fc656df2e085b00f2b54df7983d27a2de
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


  Commit: 5cea4125aef798acfc24b611571d6d5191e7d9f1
      https://github.com/bluez/bluez/commit/5cea4125aef798acfc24b611571d6d5191e7d9f1
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


  Commit: 6b4b0c1cd63b4b30186e4f8b32787aba2ff18c33
      https://github.com/bluez/bluez/commit/6b4b0c1cd63b4b30186e4f8b32787aba2ff18c33
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


  Commit: fabfcd1e6578c35599ffc70823ff5136c83fc6f0
      https://github.com/bluez/bluez/commit/fabfcd1e6578c35599ffc70823ff5136c83fc6f0
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


  Commit: 4c6b73eaad78c221d855266fa337412d8ea889ff
      https://github.com/bluez/bluez/commit/4c6b73eaad78c221d855266fa337412d8ea889ff
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


  Commit: 73ecd52e3f6548f6e75c84dce36039fb53077e65
      https://github.com/bluez/bluez/commit/73ecd52e3f6548f6e75c84dce36039fb53077e65
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


  Commit: 1fc655af80a172d93a3fedd508e1e3c2a2ceed32
      https://github.com/bluez/bluez/commit/1fc655af80a172d93a3fedd508e1e3c2a2ceed32
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


Compare: https://github.com/bluez/bluez/compare/a3a07d213b3d%5E...1fc655af80a1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
