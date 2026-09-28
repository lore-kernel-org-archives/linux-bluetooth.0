Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14B4FD28A
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631105; cv=none; b=SVWavPuOI331xo5QG25qpLTxTi0FnzrQFV2yYkYX7gJq6NDTNBOmnUM0Dh+zHWFtvc/SQOdDXrQEWjgZPsF2KlCZTDlModXWVc2wXZkKl9NUQKoP2oAwZ+/yhJAPLvx7pM7/ElNSQNJo22ciwICPPIxSt3NXeWSHabe6Aksh5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631105; c=relaxed/simple;
	bh=5vDh1PsKoTGJhSKAxR7I8wCAND+AF7+VXkvUc99IOZU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pY20zysnsJfS7m9bS6wnXcgxRzC1tCtqBgOeu5C5bvyxiyuYJTq3DHY+XD6W2LakaLReNSo7jnzttmUs37NvoHH2CRqKv5oxnFr/nP6VyJwzHoRZIhSc5BLgG3AzTcRn0RdN2j7O5+Ah4luXIpUxv53BOs6JQWhI4Jd8uN/Ztag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ws2kyxTd; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ws2kyxTd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790631098;
	bh=hEu1S3HRloJzbinM3oeXC/Cm1pMPjnlUlhwWQGOTE/E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ws2kyxTdKKpG8jxQJFr3Kg/XuAqyLP6SCvakXfrpc8syure4UvWqT5II+1UKSrKzZ
	 ySf9YjHjJR9OZeE7m0lKtv7c+3v7uCh/9/yQ6ZEobxia6dipsDc2rV8boxUOrDmqcs
	 gEwh6YxHISBfGP4yR2ygymiTrlfI4NpHvfBhaEEk=
Received: from github.com (hubbernetes-node-2c59046.va3-iad.github.net [10.48.68.85])
	by smtp.github.com (Postfix) with ESMTPA id 59526800796
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:31:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:31:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175561/000000-317f15@github.com>
Subject: [bluez/bluez] 3d93d2: shared/gatt-client: Fix calling destroy after
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

  Branch: refs/heads/1175561
  Home:   https://github.com/bluez/bluez
  Commit: 3d93d2bb599aa7f8185641403db83cbec266c813
      https://github.com/bluez/bluez/commit/3d93d2bb599aa7f8185641403db83cbec266c813
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M src/gatt-client.c
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

Call destroy when unregistering instead, once done with notify_data and
holding a reference to the client in case destroy drops the last one.

As destroy is now called when unregistering, reply to StartNotify before
freeing the notify client when enabling the notifications fails, since
it frees the operation the reply is for.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 574fd32c0c0e5805c3a20d17bab170f9cd48a34a
      https://github.com/bluez/bluez/commit/574fd32c0c0e5805c3a20d17bab170f9cd48a34a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

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

As invalid values can now come from scripts, fix handling them: the
attribute is no longer used once unregistered, which frees it, nor kept
in the list of its parent, and the command fails. Also stop counting
the empty entries between the values, which left bytes uninitialized,
and reject negative values.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 36ff882b465ba54dad15175729ed885d7384dbcd
      https://github.com/bluez/bluez/commit/36ff882b465ba54dad15175729ed885d7384dbcd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Print Connection Subrate event

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: ee36cdefec85149844041a8fca62bacc3dfac90c
      https://github.com/bluez/bluez/commit/ee36cdefec85149844041a8fca62bacc3dfac90c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M doc/test-functional.rst
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

Assisted-by: OpenCode:claude-opus-5.5


  Commit: cd8016de9707ee54c353fdcff3cacf0c983e27ee
      https://github.com/bluez/bluez/commit/cd8016de9707ee54c353fdcff3cacf0c983e27ee
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    A client/scripts/hog-device-sci.bt
    A client/scripts/hog-device.bt

  Log Message:
  -----------
  client/scripts: Add HoG device scripts

Add scripts registering a HID Service (HIDS) acting as a HID over GATT
keyboard, with and without Shorter Connection Interval (SCI) support.

HID SCI Mode can be notified so the device can confirm a mode change.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 18591af6f67912e52cb5baabbe5c3b3be63973c7
      https://github.com/bluez/bluez/commit/18591af6f67912e52cb5baabbe5c3b3be63973c7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

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

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 7e6df5b9a9e27e5a43331072c3c8073536ccff39
      https://github.com/bluez/bluez/commit/7e6df5b9a9e27e5a43331072c3c8073536ccff39
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

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

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 6148d00996125874d0cd9baae317c6f688f7c1dd
      https://github.com/bluez/bluez/commit/6148d00996125874d0cd9baae317c6f688f7c1dd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

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

Assisted-by: OpenCode:claude-opus-5.5


  Commit: b8ee97172b09e0e22fd4f11ac7b8d0d4cf02565f
      https://github.com/bluez/bluez/commit/b8ee97172b09e0e22fd4f11ac7b8d0d4cf02565f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M client/agent.c

  Log Message:
  -----------
  client/agent: Fix crash on Cancel with no pending request

The auto agent replies to the requests right away, so there is no
pending request when bluetoothd cancels one, e.g. when pairing fails,
and dbus_message_unref is then called with NULL, which libdbus aborts
on:

 #5  ?? () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
 #6  _dbus_warn_check_failed () from /usr/lib/x86_64-linux-gnu/libdbus-1.so.3
 #7  cancel_request (...) at client/agent.c:258
 #8  process_message (...) at gdbus/object.c:293

Only release the pending request if there is one, as done when the
agent is released.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 8bf9a2fa25037b345c608d17a4bfa8d043974188
      https://github.com/bluez/bluez/commit/8bf9a2fa25037b345c608d17a4bfa8d043974188
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M src/shared/uhid.c

  Log Message:
  -----------
  shared/uhid: Fix size of Get Report reply with a Report ID

The size of the reply did not account for the Report ID prepended to
the data of numbered reports, dropping the last byte of the report,
unlike Input Reports which already account for it.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: ae56c75c06b46ceb2f82a74c59e14a9cffbf637c
      https://github.com/bluez/bluez/commit/ae56c75c06b46ceb2f82a74c59e14a9cffbf637c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M src/shared/uhid.c

  Log Message:
  -----------
  shared/uhid: Keep reading when an event is not available

When the fd is non-blocking an event may have been consumed by another
reader of the same fd, e.g. multiple instances of HID over GATT sharing
the fd of the uHID device in unit tests, so keep reading on EAGAIN
instead of stopping.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 1f8e932a8d77c9723420ff665a58add1aecad15d
      https://github.com/bluez/bluez/commit/1f8e932a8d77c9723420ff665a58add1aecad15d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: Allow expecting a PDU with no response

IOV_NULL following an expected PDU used to send an empty PDU, unless
followed by another IOV_NULL chaining the PDUs to send, so it was not
possible to expect a PDU with no response, e.g. a Write Command,
followed by another expected PDU.

Wait for the next PDU instead of sending an empty one in that case.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 12bded16b68f1a34c5d641b9c3b62131fd357e20
      https://github.com/bluez/bluez/commit/12bded16b68f1a34c5d641b9c3b62131fd357e20
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Fix calling idle callbacks again while notifying

The idle callbacks are called while being removed from the queue, so if
one of them makes the client idle again, e.g. if a request it sends
fails right away, they are called again while the queue is being
iterated, corrupting it:

 Invalid read of size 8
    at queue_remove_if (queue.c:285)
    by queue_remove_all (queue.c:321)
    by notify_client_idle (gatt-client.c:187)
    ...
  Address is 8 bytes inside a block of size 16 free'd
    at free
    by queue_remove_if (queue.c:292)
    by queue_remove_all (queue.c:321)
    by notify_client_idle (gatt-client.c:187)
    by request_unref (gatt-client.c:206)
    by bt_gatt_client_read_long_value (gatt-client.c:3140)

Detach the callbacks from the client before calling them.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: b23cb73cd9b5ff3e276acda50d3d0368610831d8
      https://github.com/bluez/bluez/commit/b23cb73cd9b5ff3e276acda50d3d0368610831d8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M src/shared/gatt-client.c
    M src/shared/gatt-client.h

  Log Message:
  -----------
  shared/gatt-client: Add bt_gatt_client_is_idle

Add bt_gatt_client_is_idle to tell if there are no pending requests, so
it is known whether the callbacks registered with
bt_gatt_client_idle_register will be called.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: f5acf7b1c286490c54b8bf85f564586c911295ca
      https://github.com/bluez/bluez/commit/f5acf7b1c286490c54b8bf85f564586c911295ca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M Makefile.am
    A src/shared/hog.c
    A src/shared/hog.h

  Log Message:
  -----------
  shared/hog: Add initial implementation

Add a HID over GATT implementation based on bt_gatt_client and
gatt_db, meant as a drop-in replacement of profiles/input/hog-lib
which is based on GAttrib:

- bt_hog_attach takes a bt_gatt_client, which is cloned so the requests
  of HoG are tracked and cancelled on their own
- the services and characteristics are only looked up in the gatt_db,
  the one given to bt_hog_new or otherwise the one of the client
- notifications of the Input Reports are enabled with
  bt_gatt_client_register_notify, once their CCC has been read
- the Report Map is read along with the other characteristics, with a
  long read, and the uHID device is created once the client is idle,
  i.e. every request is complete, so the report IDs are known by then
- the addresses of the uHID device are taken from the ATT socket
- the clone is freed when detaching, which cancels its pending requests
  and unregisters its notifications
- static values, i.e. HID Information, Report Reference, External Report
  Reference and HID SCI Information, are cached in the gatt_db, along
  with the Report Map, so they are not read again when reconnecting

Unlike hog-lib, the Scan Parameters, Device Information and Battery
services are not handled, as they are by the scanparam, deviceinfo and
battery plugins, so bt_hog_set_ids is added to set the vendor, product
and version once known, e.g. from the PnP ID. A debug callback can be
set with bt_hog_set_debug.

HID SCI is supported as specified by the HIDS/HOGP SCI FIPD:
bt_hog_set_sci_mode requests the HID Device to enable a HID SCI mode by
writing it to the HID Control Point, and the notifications of HID SCI
Mode, with which the HID Device confirms the mode once the connection
rate has been changed, are enabled and reported with the callback set
with bt_hog_set_sci_mode_callback.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 599ed10d16c946a888fbc8e77716bb4f8205e5d3
      https://github.com/bluez/bluez/commit/599ed10d16c946a888fbc8e77716bb4f8205e5d3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M Makefile.am
    M unit/test-hog.c

  Log Message:
  -----------
  unit/test-hog: Use shared/hog

Port the tests to src/shared/hog, with the discovery done by
bt_gatt_client, and the uHID device emulated with a socket pair so the
events are checked.

The test cases are renamed after HOGP.TS p13, and the missing ones for
the Report Host are added, except for HID ISO which is not supported:

- Discovery: HGDC/BV-03-C (two instances of the HID Service),
  HGDC/BV-04-C and HGDC/BV-05-C
- Read: HGRF/BV-02-C to BV-08-C, BV-18-C and BV-19-C, with the Report
  values also read with UHID_GET_REPORT
- Write: HGWF/BV-01-C, BV-02-C and BV-04-C with UHID_SET_REPORT and
  UHID_OUTPUT, BV-05-C and BV-06-C (Suspend and Exit Suspend), BV-07-C
  (Set Report Protocol Mode)
- HID SCI: HGWF/BV-08-C to BV-11-C, writing each mode to the HID
  Control Point with two instances of the HID Service, then changing
  to another mode once notified with HID SCI Mode
- Configuration: HGCF/BV-01-C
- Notifications: HGNF/BV-01-C, forwarded as UHID_INPUT2, and BI-01-C
  and BI-02-C, ignoring the Boot Keyboard and Boot Mouse Input Reports,
  and HGNF/BV-01-C once reconnected, with the reports already known and
  the Report Map cached
- Characteristic GGIT: CHA/BV-01-C to BV-04-C, BV-09-C, BV-10-C and
  DES/BV-01-C

The Battery Level and PnP ID GGIT test cases are left to the battery
and deviceinfo plugins which handle these services.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 00d9386b4fe9c17f905415c5d9f716e6340abbd6
      https://github.com/bluez/bluez/commit/00d9386b4fe9c17f905415c5d9f716e6340abbd6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M client/scripts/hog-device-sci.bt
    M doc/functional-hog.rst
    M test/functional/test_hog.py

  Log Message:
  -----------
  test: functional: change the HoG SCI mode with the HID Control Point

As specified by HOGP.TS 4.6.1 and the HIDS/HOGP SCI FIPD, the HID host
requests a HID SCI mode by writing it to the HID Control Point, the HID
device then confirming it with a notification of HID SCI Mode, which is
Read and Notify only.

Write the mode to the HID Control Point instead of HID SCI Mode, which
is no longer writable, and don't expect HID SCI Mode notifications to
be subscribed by bluetoothctl as the input plugin of the HID host may
already have done it.

The connection rate is still changed by the HID host, as the kernel
only issues the LE Connection Rate Request as central.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: f91f94871f4672bafa4bb1bb4bbb026c55337ca8
      https://github.com/bluez/bluez/commit/f91f94871f4672bafa4bb1bb4bbb026c55337ca8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M Makefile.plugins
    R profiles/battery/bas.c
    R profiles/battery/bas.h
    R profiles/deviceinfo/dis.c
    R profiles/deviceinfo/dis.h
    R profiles/input/hog-lib.c
    R profiles/input/hog-lib.h
    M profiles/input/hog.c
    R profiles/scanparam/scpp.c
    R profiles/scanparam/scpp.h

  Log Message:
  -----------
  input/hog: Use shared/hog

Use src/shared/hog, based on bt_gatt_client, instead of hog-lib which
is based on GAttrib, and remove it along with the GAttrib based Battery,
Device Information and Scan Parameters implementations only used by it.

These services are handled by the battery, deviceinfo and scanparam
plugins, so the vendor, product and version of the uHID device are
set from the device, which gets them from the PnP ID, when accepting
the connection.

With shared/hog the notifications of HID SCI Mode are enabled when the
HID device supports SCI, so the mode is known once changed with the HID
Control Point.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 2b7c092a05715fd7a5cb1ce1691e900c1c30393f
      https://github.com/bluez/bluez/commit/2b7c092a05715fd7a5cb1ce1691e900c1c30393f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: Add CONFIG_HIDRAW to the tester kernel config

Enable hidraw so unit/test-uhid, when run as root e.g. with test-runner,
can request reports through a hidraw device, as HIDIOCGFEATURE does, and
check the replies to the requests the kernel sends to the uHID device.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 13fb671d715252ca23e0cde1f0bcd3a69716730c
      https://github.com/bluez/bluez/commit/13fb671d715252ca23e0cde1f0bcd3a69716730c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M unit/test-uhid.c

  Log Message:
  -----------
  unit/test-uhid: Add Get Report tests

Add tests replying to UHID_GET_REPORT for a numbered Feature Report:

- /uhid/command/get_report_reply checks the reply contains the Report
  ID followed by the report data, with its size accounting for both
- /uhid/device/get_report creates a uHID device, requests the report
  through hidraw with HIDIOCGFEATURE and checks it returns the Report ID
  followed by the report data, as documented in
  Documentation/hid/hidraw.rst, since uhid copies the reply to the buffer
  of hid_hw_raw_request. It requires root and CONFIG_HIDRAW, otherwise
  it is not run.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: f8bfdafad120474b77a406c1a5650a3f701f8d7a
      https://github.com/bluez/bluez/commit/f8bfdafad120474b77a406c1a5650a3f701f8d7a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M profiles/deviceinfo/deviceinfo.c
    M profiles/ranging/rap.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Use bt_att instead of GAttrib

GAttrib is no longer used other than to create the bt_att of the
connection, so create it directly, and remove btd_device_get_attrib as
there are no users left.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 72007bcc4effa028c656b423149958cdd09e2899
      https://github.com/bluez/bluez/commit/72007bcc4effa028c656b423149958cdd09e2899
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M Makefile.tools
    M attrib/gatt.c
    M attrib/gatt.h
    R attrib/gattrib.c
    R attrib/gattrib.h
    R attrib/gatttool.c
    R attrib/gatttool.h
    R attrib/interactive.c
    R attrib/utils.c
    R unit/test-gattrib.c

  Log Message:
  -----------
  attrib: Remove GAttrib and gatttool

GAttrib has no users left besides the deprecated gatttool, which is
replaced by the gatt submenu of bluetoothctl and btgatt-client, so
remove both along with unit/test-gattrib and what is left unused of
attrib/gatt.c, only keeping struct gatt_primary and gatt_parse_record
which are still used by bluetoothd.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 317f15a746b99f11baaf591728943068a299e05e
      https://github.com/bluez/bluez/commit/317f15a746b99f11baaf591728943068a299e05e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-28 (Mon, 28 Sep 2026)

  Changed paths:
    M Makefile.am
    R attrib/att-database.h
    R attrib/att.c
    R attrib/att.h
    R attrib/gatt.c
    R attrib/gatt.h
    M profiles/battery/battery.c
    M profiles/deviceinfo/deviceinfo.c
    M profiles/midi/midi.c
    M profiles/ranging/rap.c
    M profiles/scanparam/scan.c
    M src/adapter.c
    M src/device.c
    M src/device.h
    M src/shared/att.c
    M src/shared/att.h

  Log Message:
  -----------
  attrib: Remove directory

What is left of attrib is only used by bluetoothd: att_ecode2str, which
is moved to src/shared/att as bt_att_ecode2str, and struct gatt_primary
along with gatt_parse_record, which are moved to src/device, so remove
the attrib directory.

Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/3d93d2bb599a%5E...317f15a746b9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
