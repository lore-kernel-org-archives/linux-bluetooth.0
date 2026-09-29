Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE812765E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722190; cv=none; b=AIBztn0PdPajK39jPOGOkVgQKzufftso8AlhynrEVADW7ICeN4AegFfkdmnyxdTmgy3wCWqzpBncrLozvKoSKC/jcttxNxOnPmcIXYKOikkr+wPDp/pRZ+yhSSwvJdg4/2oIqAsyVe2TCPT2TL+WmqXHwrV3dguuWS3dKK3ln1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722190; c=relaxed/simple;
	bh=cmpx8LPiKHmJJhjcO/Shir5b+Vjmjoy+ydoIB8HADOY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JJZtrQEoTTkTcffjwO9kBw5iEF/UBUo6ZpeGkbF5xgrinTuNoNkckmWFpjcRQZWdi2xN8tMP8frcSHWLHTBvPekuBZ4KqMgWUj/zfp86IqWBJLzx+RtqFrMO2gthy7cXCzfzaeQH0kQC9a/vg8XK/2OnefylumRO54Q92CIOUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=cxK9Xyxd; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="cxK9Xyxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790722186;
	bh=yGvPCDOrBdhBxBzkMwuLLf8MTZMFqPOtP1OFbE3DMwc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cxK9Xyxd9ejC9cjxI0d9xogAJc6UizWy3RW5RqGbFIYnAWuPq+eFJBGlUmLHQeUzB
	 JoeoUG7zYMMrSYf/cXve5qf2YNf51hyFyXG11ZQkkYE/sPB+lQYdASUUcfFWNI3zvL
	 TUmmyluampWem3Pa5N08VFkRcR0aYvBHeiqjyD/jOy+BPaZ9SzBysXVJjii/k7LBcB
	 VoR8pGIMl8517U7jVYmqLh8gPu+hQkn0kiR0WYVgKbgGoomqKTpj5YUdgrDM53Pt7a
	 U4fl+m8tYFwnaXJWilHhB/MRcV7R3qToI3sSq4ZueJ1feDHF46BTvmQfCjt5+GDbec
	 y4VdtF1kDf4iw==
Received: from github.com (hubbernetes-node-c49b522.ash1-iad.github.net [10.56.226.76])
	by smtp.github.com (Postfix) with ESMTPA id E6AF792121D
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:49:46 -0700 (PDT)
Date: Tue, 29 Sep 2026 15:49:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/867137-dbc610@github.com>
Subject: [bluez/bluez] 65f8a8: shared/gatt-client: Fix calling destroy after
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 65f8a8b60a70143c37527280278c462aa5a11bfc
      https://github.com/bluez/bluez/commit/65f8a8b60a70143c37527280278c462aa5a11bfc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: f14171908901f786a6216a0cc1bca5849645fcca
      https://github.com/bluez/bluez/commit/f14171908901f786a6216a0cc1bca5849645fcca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: e96e1d7e6db85663d6164199d8320b5af4edf807
      https://github.com/bluez/bluez/commit/e96e1d7e6db85663d6164199d8320b5af4edf807
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 6b304a7dd2acba1e9e39eefd73b6bed80984b2ef
      https://github.com/bluez/bluez/commit/6b304a7dd2acba1e9e39eefd73b6bed80984b2ef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 2604ba5035cd7fb021ff1d7bf5ce0b0b7c74c617
      https://github.com/bluez/bluez/commit/2604ba5035cd7fb021ff1d7bf5ce0b0b7c74c617
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 7b68fecf0599a8433679e8b1c44f866be3de4ed7
      https://github.com/bluez/bluez/commit/7b68fecf0599a8433679e8b1c44f866be3de4ed7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: c7a2a63a02d66ee5ad201adb0c5a428c549ec0b3
      https://github.com/bluez/bluez/commit/c7a2a63a02d66ee5ad201adb0c5a428c549ec0b3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 044404ccbf91813077a5667f392790d519eb7609
      https://github.com/bluez/bluez/commit/044404ccbf91813077a5667f392790d519eb7609
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 67a794ff4048c293ab119dec611bff8fececd8f9
      https://github.com/bluez/bluez/commit/67a794ff4048c293ab119dec611bff8fececd8f9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: dc2eb1394f4ff5477b0ed3c72012b7f7ae02411f
      https://github.com/bluez/bluez/commit/dc2eb1394f4ff5477b0ed3c72012b7f7ae02411f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

  Changed paths:
    M src/shared/uhid.c

  Log Message:
  -----------
  shared/uhid: Fix size of Get Report reply with a Report ID

The size of the reply did not account for the Report ID prepended to
the data of numbered reports, dropping the last byte of the report,
unlike Input Reports which already account for it.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 4efaf7ed188b5f0106249bfbbba791f845ef7567
      https://github.com/bluez/bluez/commit/4efaf7ed188b5f0106249bfbbba791f845ef7567
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 7104e632672b19d5212a123d18274d058a8abaa6
      https://github.com/bluez/bluez/commit/7104e632672b19d5212a123d18274d058a8abaa6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 326a0000ac024fe32423e6d2959bd0c6a3f469df
      https://github.com/bluez/bluez/commit/326a0000ac024fe32423e6d2959bd0c6a3f469df
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 06053830b71c74a1f376ae4b55d2a4fb73ce7c6f
      https://github.com/bluez/bluez/commit/06053830b71c74a1f376ae4b55d2a4fb73ce7c6f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: c2f56f58b8b7dd686329edd2e294a000e43b7dcc
      https://github.com/bluez/bluez/commit/c2f56f58b8b7dd686329edd2e294a000e43b7dcc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 7af5798ddb42a77db19512bbd4979c567f7fece3
      https://github.com/bluez/bluez/commit/7af5798ddb42a77db19512bbd4979c567f7fece3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: c2f53b0343484424d32700f8da3c674a2666956c
      https://github.com/bluez/bluez/commit/c2f53b0343484424d32700f8da3c674a2666956c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 96f1201f5ac298860889714fcbc81307c2827dc0
      https://github.com/bluez/bluez/commit/96f1201f5ac298860889714fcbc81307c2827dc0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: bb69738a1206c895b6cb25e71add297c10d62f1b
      https://github.com/bluez/bluez/commit/bb69738a1206c895b6cb25e71add297c10d62f1b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: ed0b991aa5b2d4f8eb00d09d418c46d8ef5bfecc
      https://github.com/bluez/bluez/commit/ed0b991aa5b2d4f8eb00d09d418c46d8ef5bfecc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: 9d09a446ace8eaa0ca2a52ca70e294daee7efffd
      https://github.com/bluez/bluez/commit/9d09a446ace8eaa0ca2a52ca70e294daee7efffd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


  Commit: a7da60ed45e9b7aea429f1472588c9070ebecdf7
      https://github.com/bluez/bluez/commit/a7da60ed45e9b7aea429f1472588c9070ebecdf7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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
    M src/adapter.c
    M src/device.c
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


  Commit: dbc6102ccdeee4a09caa33ed73ab28de88cf2e92
      https://github.com/bluez/bluez/commit/dbc6102ccdeee4a09caa33ed73ab28de88cf2e92
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-29 (Tue, 29 Sep 2026)

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


Compare: https://github.com/bluez/bluez/compare/86713777f91a...dbc6102ccdee

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
