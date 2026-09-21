Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC852386C3B
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018630; cv=none; b=d/usLbGIdBcU8O78umNvKmqGMnRIcr35xztdqzukLShKHrskotvG7xsX/I0fzvcOT9u0rkzzxFThVvTvDFzQeBzLXkqQJgZ4V/jgPoHfe7eLKqSC8GuRYZS+mLnuh6PEJhQQVhXVOeb2xUCjUJpV0kCmEDMcQj2l2W/dD5VAxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018630; c=relaxed/simple;
	bh=2SOjsxTzsjXbBEFfNkhcVW4NcOP9+FXOnSBFvG2hnlM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Rjk3Ty2UWoPE+CFcCpJE2tI5I1xfpxPC+VMrUNja782LcqO24cEyF7v9v1THmyMiHFaGbrxVes7doT9Eh+FEMcRK+g7IQRLhqrROOTU34M9AIqEEr3Llo2ucRSlVXFV8Gm/UADcs7sl1R3Tcx7mkDPbqzP5fBgz2Y8cMCVlHNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IM2jjii2; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IM2jjii2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790018628;
	bh=h3C2tZCRzXDogPM41BvN4RVIKS97H+/+mVCoLJ5Pg4s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IM2jjii2JwPbzOIZPIasnlHjPhgY6GosPwqaQRuXOWv62P9E7S1nYRs5i8DXJYH5Y
	 kXI/gHJMbuG6FfUhDiCUv/xbxPj4G+mfOTUV2kojdRW3uPiErfTpTIq589zWMekz0K
	 cbg2XxkgeofPq9lh4UtVGP+vHs1htTtmx9WFjs+w=
Received: from github.com (hubbernetes-node-6ae26dc.ac4-iad.github.net [10.55.93.32])
	by smtp.github.com (Postfix) with ESMTPA id EC5CC9417C3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 12:23:47 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:23:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ebbb4e-17e624@github.com>
Subject: [bluez/bluez] eb82d8: adapter: remove the devices from the list
 before f...
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
  Commit: eb82d81bf26bd212856f74a301f0fcc24eb6c132
      https://github.com/bluez/bluez/commit/eb82d81bf26bd212856f74a301f0fcc24eb6c132
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: remove the devices from the list before freeing them

The devices of an adapter are freed one by one when it is removed, but
the list keeps pointing at them until every one of them is gone, so it
refers to freed devices while the remaining ones are being removed.

Freeing a device looks devices up though, e.g. cleaning up its GATT
server reports the disconnection, which searches the list for the
device it belongs to, and the search reads the devices already freed:

  ERROR: AddressSanitizer: heap-use-after-free
    in bacmp lib/bluetooth/bluetooth.h:438
    in device_addr_type_cmp src/device.c:5657
    in btd_adapter_find_device src/adapter.c:1055
    in att_disconnected src/gatt-database.c:335
    in gatt_server_cleanup src/device.c:842
    in device_free src/device.c:918

Take each device out of the list before removing it, so only the ones
still to be removed are ever found.

This needs more than one device on the adapter to show up, which the
test of a coordinated set is the first to leave behind.

Assisted-by: opencode:claude-opus-5


  Commit: 0bed9886cff317d814f9b1f11c1461459f2b9a00
      https://github.com/bluez/bluez/commit/0bed9886cff317d814f9b1f11c1461459f2b9a00
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix crash on NULL stream in transport_cb

transport_cb() runs from bt_io_accept() and begins by confirming that
the a2dp_setup it was handed still exists:

	if (!g_slist_find(setups, setup)) {
		warn("bt_io_accept: setup %p no longer valid", setup);
		...
	}

That establishes the lifetime of the setup, not of the stream it
points at. Several paths in a2dp.c clear setup->stream while leaving
the setup itself on the list, so by the time the accept completes the
setup can be valid and its stream NULL. confirm_cb() already refuses
to start the accept when setup->stream is NULL; nothing re-checks it
when the accept completes, and it is then passed on unchecked:

	if (!avdtp_stream_set_transport(setup->stream,
					g_io_channel_unix_get_fd(io),
					imtu, omtu))

and avdtp_stream_set_transport() dereferences it immediately:

	gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, ...)
	{
		GIOChannel *io = g_io_channel_unix_new(fd);

		if (stream != stream->session->pending_open) {

Observed as a crash on a QCA9377 (13d3:3503) whose controller stops
answering HCI during audio use. From the retained core, %r13 held NULL
and the faulting instruction was the first field load off it:

  bluetoothd[398112]: segfault at 10 ip 0000635d944b47e5 sp 00007ffefcba28d0 \
      error 4 in bluetoothd[367e5,635d944a3000+f3000]

  r13  0x0
  => 0x635d944b47e5:  mov 0x10(%r13),%rdi

With the check in place and the daemon logging before it bails, the
guard fired four times in 19 days of ordinary use on the same machine
(once on 2026-08-26, three times on 2026-09-02, across two daemon
lifetimes and three distinct setup pointers). Each of those is an
accept that completed after the stream had been cleared; unpatched,
each is the dereference above.

Check the stream immediately before it is used, so every existing path
keeps its current behaviour up to the point that was previously
unsafe. In particular a bt_io_accept() error or a bt_io_get() failure
still reports the real I/O error rather than this secondary lifecycle
condition.

commit 125a2e237e7c ("a2dp: Fix possible crash when accepting stream
transport") previously hardened this same asynchronous accept window
against the whole setup disappearing while the accept was pending.
This covers the remaining case where the setup survives and its stream
does not.

commit 90a600895d80 ("avdtp: Handle case where remote send L2CAP
connect ahead of Open") also changed avdtp_stream_set_transport()
itself, to handle a transport arriving before Open. The function still
dereferences stream before reaching that handling, so it does not
cover a NULL argument from transport_cb().


  Commit: a734b06059cbe0d0f00442c901506ef17e960960
      https://github.com/bluez/bluez/commit/a734b06059cbe0d0f00442c901506ef17e960960
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix crash on short start discovery reply

start_discovery_complete() validates the reply length before using the
returned parameters:

	if (length < sizeof(*rp)) {
		btd_error(adapter->dev_id,
			"Wrong size of start discovery return parameters");
		discovery_complete(adapter, MGMT_STATUS_FAILED);
		return;
	}

but that check sits below the branch taken when the discovery client
list has emptied while the command was pending, and that branch has
already dereferenced the reply:

	if (!adapter->discovery_list) {
		struct mgmt_cp_stop_discovery cp;

		if (status != MGMT_STATUS_SUCCESS)
			return;

		/* Stop discovering as there are no clients left */
		cp.type = rp->type;      <-- rp may be NULL here

mgmt_cp_start_discovery is a single uint8_t, so rp->type is a one-byte
read at offset 0 and a NULL rp faults immediately.

The mgmt layer can invoke a command callback with no reply parameters:
src/shared/mgmt.c passes length 0 and a NULL param on the Command
Status path:

	case MGMT_EV_CMD_STATUS:
		...
		DBG(mgmt, "[0x%04x] command 0x%02x status: 0x%02x", ...);
		request_complete(mgmt, cs->status, opcode, index, 0, NULL);

Observed as a crash on a QCA9377 (13d3:3503) whose controller stops
answering HCI during audio use. The archived session logs show exactly
that sequence: the daemon's debug log (bluez 5.72) ends with the
Command Status delivery and the callback entry, for the Start Discovery
it had sent 2.05 s earlier, ten seconds after its last discovery client
had gone; the contemporaneous kernel log records the resulting fault:

  bluetoothd:
  21:03:16.750  discovery_remove() owner :1.125
  21:03:24.943  send_request() [0x0000] command 0x0023
  21:03:26.994  can_read_data() [0x0000] command 0x23 status: 0x00
  21:03:26.994  start_discovery_complete() status 0x00
  kernel:
  21:03:26.995  bluetoothd[2821]: segfault at 0 ...

"command ... status:" is the Command Status branch (Command Complete
logs "complete:"), so the callback ran with status 0, length 0 and a
NULL param, found discovery_list empty, and faulted on rp->type. The
crash site was resolved from the shipped binary:

  bluetoothd[2821]: segfault at 0 ip 00005d6eb1ad1986 sp 00007ffef8e784b0 \
      error 4 in bluetoothd[a6986,5d6eb1a50000+f3000]

  a6986:  41 0f b6 45 00    movzbl 0x0(%r13),%eax     <-- cp.type = rp->type
  a698b:  0f b7 53 04       movzwl 0x4(%rbx),%edx     <-- adapter->dev_id
  a6992:  4c 8d 45 d7       lea    -0x29(%rbp),%r8    <-- &cp

The same delivery, a Command Status with status 0x00 answering a Start
Discovery just sent, was logged five more times on that machine: four
in the crashing daemon's own lifetime and once on a later day. On each
of those the client list was non-empty, so the existing check below
the branch handled it ("Wrong size of start discovery return
parameters"); when the list is empty the branch above is reached
first.

Why the kernel answers Start Discovery with a successful Command
Status rather than the usual one-byte Command Complete is not
established here. The crashing instance arrived while the controller
was timing out HCI commands; the fix does not depend on the cause.

Perform the same length validation before using the reply in the
no-clients branch. The check is added inside that branch rather than
hoisted above it, so that no other path changes behaviour.

Fixes: 3597d1377723 ("adapter: Fix not waiting for start discovery result")


  Commit: 8a1c5351739946ed7f082a4503a85c794b46ce95
      https://github.com/bluez/bluez/commit/8a1c5351739946ed7f082a4503a85c794b46ce95
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix use-after-free of device referenced by session

bap_attached() creates bap_data that are not bound to btd_service, and
can outlive the device (eg if ATT POLLHUP -> bap_detached is late).
This then crashes when accessing bap_data::device later.

Fix by having bap_data hold btd_device_ref(). This is similar to what
avdtp.c etc. do.

Remove no-op assign to ep->data->device in ep_register_bcast() +
bap_bcast_probe() -- these just assign the same device pointer.

Log:

ERROR: AddressSanitizer: heap-use-after-free on address 0x7d6513de0208
READ of size 8 at 0x7d6513de0208 thread T0
    #0 0x5594209b7e9b in device_get_adapter src/device.c:6917
    #1 0x55942086020e in find_cig_session profiles/audio/bap.c:2500
    #2 0x559420a3f070 in queue_find src/shared/queue.c:230
    #3 0x559420866cd3 in find_cig_enumerate profiles/audio/bap.c:2539
    #4 0x559420866cd3 in bap_update_cigs_cb profiles/audio/bap.c:2688
    #5 0x7ff515a46b9a
    #6 0x7ff515a481d6
    #7 0x7ff515a48576 in g_main_loop_run
    #8 0x559420b9af48 in mainloop_run src/shared/mainloop-glib.c:65
    #9 0x559420b9b87a in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #10 0x5594207192ba in main src/main.c:1713

0x7d6513de0208 is located 392 bytes inside of 752-byte region [0x7d6513de0080,0x7d6513de0370)
freed by thread T0 here:
    #0 0x7ff515d2d3ff in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x559420a29a39 in remove_interface gdbus/object.c:742

previously allocated by thread T0 here:
    #0 0x7ff515d2e40f in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:74
    #1 0x5594209cd302 in device_new src/device.c:5008

Assisted-by: opencode:qwen3.8-flash-next


  Commit: fa74ecbc0c84be5ea60c84b1b8ce0cc4d481d2f9
      https://github.com/bluez/bluez/commit/fa74ecbc0c84be5ea60c84b1b8ce0cc4d481d2f9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M test/functional/test_kernel_testers.py
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: ignore Debug feature in Read Exp Feature tests

CONFIG_BT_FEATURE_DEBUG controls whether Debug experimental feature is
present. mgmt-tester hardcodes one configuration.

CONFIG_BT_FEATURE_DEBUG is incompatible with DYNAMIC_DEBUG, so requiring
test configurations to have it enabled is inconvenient.

Instead, adjust test to accept either debug present or not.

Fixes failures in "Read Exp Feature - Success"


  Commit: 216f85e77b9253659a3e9caff6f895f91955dcc3
      https://github.com/bluez/bluez/commit/216f85e77b9253659a3e9caff6f895f91955dcc3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix expected status for invalid key entries

Kernel commit 1e9683c9b6ca ("Bluetooth: MGMT: Ignore keys being loaded
with invalid type") made Load Link Keys and Load Long Term Keys skip
entries with an invalid address type or initiator value instead of
rejecting the whole command with Invalid Parameters.

Update "Load Link Keys - Invalid Parameters 3" and "Load Long Term Keys
- Invalid Parameters 2 and 3" to expect success.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 3450e588533dccdd4317539d51fa9561a68a064d
      https://github.com/bluez/bluez/commit/3450e588533dccdd4317539d51fa9561a68a064d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: mark Pair Device - Power off 1 as fail_tolerant

The pending Pair Device command is completed by whichever path wins
the race against HCIDEVDOWN: if it is still queued when the controller
is closed, __mgmt_power_off() responds with Not Powered; if the
connection failure callbacks run first, pairing_complete_cb() responds
with Disconnected.

Both are valid outcomes, so mark the test fail_tolerant, as done for
Get Conn Info - Power off

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 9015ae3228469f38c19a01a61be43b2262ef4700
      https://github.com/bluez/bluez/commit/9015ae3228469f38c19a01a61be43b2262ef4700
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Report unexpected status as test failure

command_generic_callback() used tester_test_abort() when the command
status differed from the expected one, making the test result in
"Not Run" and hiding real failures from the summary. Treat such status
mismatches as a test failure, warning with both statuses. Mismatches
tolerated through fail_tolerant are unaffected.

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 86dfa8e3b7b35ecc4659b85134f7107a575dc132
      https://github.com/bluez/bluez/commit/86dfa8e3b7b35ecc4659b85134f7107a575dc132
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: Count setup failures as test failures

A test whose setup stage fails ends up as "Not Run", without counting as
a failure.

Make them count as TEST_RESULT_FAILED. Setup failures are real failures,
and should not be considered same as skipped tests.

Intentional skips through tester_pre_setup_abort() still report "Not
Run".

Assisted-by: opencode:qwen3.8-flash-next


  Commit: 482d95704cec0d1a93f6fce78d5700b7a369d2b3
      https://github.com/bluez/bluez/commit/482d95704cec0d1a93f6fce78d5700b7a369d2b3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M monitor/analyze.c
    M monitor/l2cap.c

  Log Message:
  -----------
  monitor/analyze: Free the channel latency plots

A channel keeps a plot of its latencies for as long as it exists, but
destroying one frees only the channel itself, leaking both plots and
everything queued on them. A connection already frees its own.

Assisted-by: opencode:claude-opus-5


  Commit: 381c58534a2f85dd1b1d975207d65e296ef68e23
      https://github.com/bluez/bluez/commit/381c58534a2f85dd1b1d975207d65e296ef68e23
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/l2cap: Report the channel latency deviation

The channel latency is reported as a range and a moving average, while
the two latency lines either side of it also report the standard
deviation, which is what tells a channel that is consistently slow apart
from one that is unstable.

Report it here as well, so that all three read the same way:

  Channel Latency: 108 msec (48-108 msec ~79 msec +/- 27 msec)

Assisted-by: opencode:claude-opus-5


  Commit: dd86570d23381b11f66d9169bd324fe00cf6252d
      https://github.com/bluez/bluez/commit/dd86570d23381b11f66d9169bd324fe00cf6252d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Drop a trailing space before a newline

The count of control messages is printed with a space between the text
and the newline, which puts a stray character at the end of the line.

Assisted-by: opencode:claude-opus-5


  Commit: 64bf1cefb3c39812fa75fb2bca39a6c6eead41af
      https://github.com/bluez/bluez/commit/64bf1cefb3c39812fa75fb2bca39a6c6eead41af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M monitor/analyze.c
    M monitor/avctp.c
    M monitor/control.c
    M monitor/display.c
    M monitor/display.h
    M monitor/l2cap.c
    M monitor/lmp.c
    M monitor/main.c
    M monitor/packet.c
    M monitor/rfcomm.c
    M tools/l2test.c

  Log Message:
  -----------
  monitor: Route the decoding output through a single function

The decoding output is written straight to stdout, partly through the
print_indent() macro and partly through some 167 direct printf() calls,
several of which build a single line across multiple calls. There is no
point at which the output of a frame can be observed as a whole.

Send all of it through display_printf(), which writes to a redirectable
stream, so that a caller can capture a frame and decide what to do with
it rather than having it go straight to the terminal. Capturing at the
stream level keeps the partially built lines working without having to
find and restructure them.

This is a pure redirection and the output is unchanged. The messages
jlink emits while connecting are left alone, as they are not part of the
decoding.

l2test uses the printing helpers from the header without linking the
monitor, so it gains its own display_printf() next to the use_color() it
already defines for the same reason.

Assisted-by: opencode:claude-opus-5


  Commit: 87051913982ccd0d2b94fa86d6b97d46b3da8d57
      https://github.com/bluez/bluez/commit/87051913982ccd0d2b94fa86d6b97d46b3da8d57
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M Makefile.tools
    M monitor/control.c
    A monitor/find.c
    A monitor/find.h
    M monitor/main.c

  Log Message:
  -----------
  monitor: Separate the frames for a pager reading records

A frame spans several lines, so a pager that works on records rather than
lines has no way of telling where one ends. Feeding a trace to fzf with
--read0 makes the whole of it a single entry, and without --read0 each
line becomes an entry of its own, so searching finds the line reporting
an error without the header saying which controller, handle and time it
belongs to.

Separate the frames with a NUL when the pager is going to read records,
which is asked for either by --print0 or by --read0 already being in
PAGER:

  $ PAGER='fzf --read0' btmon -r hcidump.log
  $ btmon -r hcidump.log --print0 | fzf --read0

Nothing is separated unless it was asked for, so the output is unchanged
for a pager reading lines, which would otherwise show the separator as a
stray character between the frames.

Assisted-by: opencode:claude-opus-5


  Commit: 2f7263b64c569a549bb8a3e81b69f9f4b6a083f9
      https://github.com/bluez/bluez/commit/2f7263b64c569a549bb8a3e81b69f9f4b6a083f9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M monitor/find.c
    M monitor/find.h
    M monitor/main.c

  Log Message:
  -----------
  monitor: Hand the captured frames to the pager on Ctrl-R

Looking for something in a running capture means stopping it and reading
back the log, losing whatever would have arrived meanwhile, or scrolling
the terminal by hand while the trace keeps moving.

Collect the frames as they are printed and hand them to the pager on
Ctrl-R, in the manner of the shell. The capture keeps running underneath,
and closing the pager returns to it, printing whatever arrived while it
was up so that the trace on the terminal has no gap.

The capture is never paused for this. Anything not read in time is
dropped by the kernel, so the pager runs on its own and is only checked
for having closed, rather than being waited for.

The frames are handed over as a file rather than through a pipe, so that
filling it cannot block the monitor and cost the capture any packets,
separated as they are elsewhere when the pager is going to read records.

Frames are only collected when the output is a terminal, so a capture
that is piped or redirected behaves exactly as it always has. The
terminal is switched to reading keys as they are typed, but signals are
left enabled so that Ctrl-C still interrupts the capture as before.

A capture runs for as long as it is left running, so the frames are held
in a ring and the oldest are dropped once it is full.

Assisted-by: opencode:claude-opus-5


  Commit: 97c101c2ef56511f1a39067d3fd3e3a586c4b287
      https://github.com/bluez/bluez/commit/97c101c2ef56511f1a39067d3fd3e3a586c4b287
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document searching the frames

Describe how the frames are separated for a pager reading records, how the
ones seen so far are handed to the pager while capturing, and that they
are only collected when the output is a terminal.

Assisted-by: opencode:claude-opus-5


  Commit: ad10ff49729f174861243e937764ecae5ea0348d
      https://github.com/bluez/bluez/commit/ad10ff49729f174861243e937764ecae5ea0348d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M monitor/display.c
    M monitor/display.h
    M monitor/find.c
    M monitor/find.h
    M monitor/main.c

  Log Message:
  -----------
  monitor: Prefer fzf as the pager when one is not set

A trace is a poor fit for a plain pager. Every frame spans several lines
and what identifies one is spread between its header and its contents, so
finding something means paging through by hand.

Use fzf when PAGER is not set and it is installed, asking it for whole
frames, for the colours to be rendered rather than shown as escape
sequences, and for the most recent frame first:

  fzf --ansi --read0 --tac

PAGER is still honoured when set, and setting it to cat or leaving it
empty still turns the pager off. The choice is shared with the frames
seen so far being handed over while capturing, so both arrive at the same
pager.

Frames are separated only when a pager that reads records is going to
read them, so redirected output and a pager that reads lines are both
left exactly as they were.

Assisted-by: opencode:claude-opus-5


  Commit: 17e624d1cd9a4d94f90e0ca008548456c3455492
      https://github.com/bluez/bluez/commit/17e624d1cd9a4d94f90e0ca008548456c3455492
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-21 (Mon, 21 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the pager choice

Describe that fzf is used when PAGER is not set, the options it is given,
and that it needs --ansi to render the colours when named explicitly.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/ebbb4ee31ad7...17e624d1cd9a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
