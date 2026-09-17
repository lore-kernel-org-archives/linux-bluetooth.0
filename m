Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740A4E36F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675420; cv=none; b=FWDCws83PEoZZ7FrDkBxrYU66fQgQX3c1oavpG24zGBuruHaP9KsK4BQVKXWCGJc3KY/BnCX4u3UNswfBleSCc8WfMtVvsYWuSBhrXJ0mZQFUaNjOljwZlkm+qt+qAYjsReJeioSsV5vj1ZY9JCgPv01tVTfPsV+BAfmB9zjFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675420; c=relaxed/simple;
	bh=CBlcGknrd4hwK/+GRpf9JT5ijsapXimVfu2558wDnZA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eMd/2sPicWtVk4gFDBIfA9aC3JZTGstwGH8T7lUgIO/T1OxLu0D0W/HsFbm9g4Z0SO/HSj4Rg8OByWPOUCA7st2Rtel327m+txc4udmKCoxQ7m4qRJLl7drGMeFZgv6/KyIsKzuLvqzq8zxlO5URtR4BUW3Lw4uiNmmyti2R9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WJ/G1iUm; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WJ/G1iUm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789675416;
	bh=pHNO/K5mM44SSbMM/zC06yYGgeT4qKRiIK2DdnKv7Pc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WJ/G1iUm52eUl/Pal3jL9Pnb0OsfoPsAKsILkl6VxN561emBH2HphNL5X6EhSaOBr
	 mpq132c4vdEDyZdid9Y5gZq1uPrP70INNuvuC3+awnt0RJ3uUhsLbfGFtdZw05liN1
	 FYOoxGcknFTexoKKDRbave63cQ+sFYqoZwU87fFE=
Received: from github.com (hubbernetes-node-49be727.ash1-iad.github.net [10.56.200.97])
	by smtp.github.com (Postfix) with ESMTPA id 66E1A1812BA
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:03:36 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:03:36 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f87a79-240105@github.com>
Subject: [bluez/bluez] 985ee7: gatt-server: Check prepare write length before
 rea...
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
  Commit: 985ee7b3ab0e01ed83d6f2c70ab6ec7ac4d11d1e
      https://github.com/bluez/bluez/commit/985ee7b3ab0e01ed83d6f2c70ab6ec7ac4d11d1e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Check prepare write length before reallocating

append_prep_data() grew the buffer and copied the new fragment into it
before rejecting a total length above UINT16_MAX. On overflow the
allocation had already been enlarged and written while prep_data->length
was left at its previous value, desynchronising the buffer from its
tracked size.

Move the bound check ahead of the realloc() so an oversized prepare
write queue is rejected without touching the buffer.

Assisted-by: opencode:claude-opus-5


  Commit: 0ccdf019681c6f95c447b19977c796a026fa3490
      https://github.com/bluez/bluez/commit/0ccdf019681c6f95c447b19977c796a026fa3490
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  adapter: Unify the A2DP admin allowlist UUID mapping

The allowlist enforcement added across the adapter, device and A2DP
layers ended up using three different UUIDs for the same two profiles:
adapter.c mapped both a2dp-source and a2dp-sink to ADVANCED_AUDIO_UUID
(0x110d), while device.c and a2dp.c mapped them to the local role UUIDs
0x110a and 0x110b. An allowlist containing only 0x110a therefore blocked
the a2dp-sink adapter probe outright, so the finer grained SEP checks in
a2dp.c never ran.

Add btd_profile_get_policy_uuid() as the single place resolving a
profile to the UUID of the local service it provides. btd_profile names
and remote_uuid describe the remote role, so the A2DP profiles are
inverted there: "a2dp-source" registers the local Sink server and
"a2dp-sink" registers the local Source server. This matches what
device.c and a2dp.c already do.

Note that allowlisting 0x110d alone no longer enables A2DP; the local
role UUIDs 0x110a and/or 0x110b have to be listed.

This also drops the hardcoded profile name table in adapter.c. Every
entry but the two A2DP ones just returned profile->remote_uuid, and any
profile without a local_uuid that was missing from the table resolved to
NULL, i.e. was allowed unconditionally regardless of the allowlist.

Assisted-by: opencode:claude-opus-5


  Commit: 2ffbcf6f9d38b24b0e45b077819481064482fa35
      https://github.com/bluez/bluez/commit/2ffbcf6f9d38b24b0e45b077819481064482fa35
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M src/battery.c
    M src/battery.h

  Log Message:
  -----------
  battery: Document the unknown sentinels and fix a stale name

btd_battery_update() treats UINT8_MAX and btd_battery_update_charging()
treats -1 as "unknown", invalidating the D-Bus property rather than
setting it. Neither was documented at the prototypes.

Also rename unregister_if_path_has_prefix() to
unregister_if_provider_matches(); it no longer compares path prefixes,
it compares the owning provider.

Assisted-by: opencode:claude-opus-5


  Commit: e5dc89d28253cc3f92fe3caaf73ca11be3965a1c
      https://github.com/bluez/bluez/commit/e5dc89d28253cc3f92fe3caaf73ca11be3965a1c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M Makefile.tools
    M client/admin.c
    M client/admin.h
    M client/main.c
    A client/main.h

  Log Message:
  -----------
  client/bluetoothctl: Declare the controller helper in its own header

bluetoothctl_get_default_controller() is implemented in main.c but was
declared in admin.h, the header of one of the submenus that consumes it.
Move the declaration to a new client/main.h so main.c also sees it.

While at it, drop the bluetooth/bluetooth.h include added to admin.c,
which is unused.

Assisted-by: opencode:claude-opus-5


  Commit: e9b6ee3808ab403bfbb45e4aecacac14f96be28a
      https://github.com/bluez/bluez/commit/e9b6ee3808ab403bfbb45e4aecacac14f96be28a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: test closing sockets with ECRED defer

Add test that does defer accept with ECRED with 2 SCIDs, and
accepts + closes the first before accepting the second. This triggers
deadlock on some kernel versions.

L2CAP Ext-Flowctl Server - Accept 2 Close 1


  Commit: 776026c41f67243b07d2731dac65baa383d5b57c
      https://github.com/bluez/bluez/commit/776026c41f67243b07d2731dac65baa383d5b57c
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M monitor/control.c

  Log Message:
  -----------
  monitor: Fix btmon heap-buffer-overflow triggered by HCI devcoredump

Kernel HCI devcoredump can accumulate a large amount of dump data from MANY
packets, then send it as a SINGLE DIAG packet to the monitor channel, so
cause payload length @len in the header exceed BTSNOOP_MAX_PACKET_SIZE, but
btmon uses @len to access the payload in @buf without validating that
@len fits within @buf, causing a heap-buffer-overflow.

Kernel:
include/net/bluetooth/hci_mon.h
struct hci_mon_hdr {
	__le16  opcode;
	__le16  index;
	__le16  len;
} __packed;

BlueZ:
src/shared/btsnoop.h
#define BTSNOOP_MAX_PACKET_SIZE            (1486 + 4)
monitor/control.c
struct control_data {
	uint16_t channel;
	int fd;
	unsigned char buf[BTSNOOP_MAX_PACKET_SIZE];
	uint16_t offset;
};

The heap-buffer-overflow Issue:
ERROR: AddressSanitizer: heap-buffer-overflow on address 0x51b00000065c at pc 0x7f50b987a029 bp 0x7ffde88dc8d0 sp 0x7ffde88dc088
READ of size 17916 at 0x51b00000065c thread T0
    #0 0x7f50b987a028 in write ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:1096
    #1 0x5b4f3443ae3a in btsnoop_write ../src/shared/btsnoop.c:289
    #2 0x5b4f3429cbf0 in data_callback ../monitor/control.c:969
    #3 0x5b4f3444fa9d in mainloop_run ../src/shared/mainloop.c:104
    #4 0x5b4f34451da6 in mainloop_run_with_signal ../src/shared/mainloop-notify.c:196
    #5 0x5b4f342953fc in main ../monitor/main.c:303
    #6 0x7f50b8c2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #7 0x7f50b8c2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x5b4f34295ed4 in _start (/usr/bin/btmon+0x29fed4) (BuildId: b41caafb24db693946c283eaea48112186863d2d)

Fix by clamping @len to the amount of data received before accessing
@buf.


  Commit: 2faee1f504ce85807bacf4267838d728493345d8
      https://github.com/bluez/bluez/commit/2faee1f504ce85807bacf4267838d728493345d8
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M tools/btmon-logger.c

  Log Message:
  -----------
  tools: Fix btmon-logger heap-buffer-overflow triggered by HCI devcoredump

Kernel HCI devcoredump can accumulate a large amount of dump data from MANY
packets, then send it as a SINGLE DIAG packet to the monitor channel, so
cause payload length @len in the header exceed BTSNOOP_MAX_PACKET_SIZE, but
btmon-logger uses @len to access the payload in @buf without validating that
@len fits within @buf, causing a heap-buffer-overflow.

Kernel:
include/net/bluetooth/hci_mon.h
struct hci_mon_hdr {
	__le16  opcode;
	__le16  index;
	__le16  len;
} __packed;

BlueZ:
src/shared/btsnoop.h
#define BTSNOOP_MAX_PACKET_SIZE            (1486 + 4)
tools/btmon-logger.c
uint8_t buf[BTSNOOP_MAX_PACKET_SIZE];

Fix by clamping the payload length to the amount of data received before
accessing @buf.


  Commit: 5a8df006aee230eae0b7d2c4fed0589b6045159a
      https://github.com/bluez/bluez/commit/5a8df006aee230eae0b7d2c4fed0589b6045159a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Reference the request frame on command responses

Correlating a Command Complete or a Command Status with the command it
responds to means scrolling back through the trace to find the matching
opcode, and the time the controller took to respond is not visible at all
without comparing timestamps by hand.

Keep the frame number and the timestamp of each command that has not been
answered yet, and append both to the opcode line of the response, so that
a slow command is obvious at the point where it completes:

  < HCI Command: LE Set Random Address (0x08|0x0005) plen 6 #76 [hci0] 3.175055
          Address: 00:11:22:33:44:55 (Non-Resolvable)
  > HCI Event: Command Complete (0x0e) plen 4               #77 [hci0] 3.175394
        LE Set Random Address (0x08|0x0005) ncmd 1 #76 (0.339 msec)
          Status: Success (0x00)

Several commands may be outstanding at once and they need not complete in
order, so entries are matched on the opcode and the oldest one is taken.
Nothing is printed when the request was not captured, which is the normal
case when attaching to a system that is already running. The queue is
bounded so commands that never get a response cannot pile up, and it is
released when the index goes away.

The model wrote the tracking and the matching, which the author reviewed
and verified against traces covering out of order completion, a response
without a request and sub-millisecond deltas.

Assisted-by: opencode:claude-opus-5


  Commit: f3b1d4d698346b4244f342321e53848deee85f99
      https://github.com/bluez/bluez/commit/f3b1d4d698346b4244f342321e53848deee85f99
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the request reference on command responses

Extend the Command Complete example to show the request frame number and
the response time, and describe how the reference is resolved and when it
is omitted.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5


  Commit: 05199c8b99ea1a5351f34daffe254015b8911410
      https://github.com/bluez/bluez/commit/05199c8b99ea1a5351f34daffe254015b8911410
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Resolve commands completed by a later event

Some commands are only acknowledged by a Command Status and complete much
later through a separate event. Create Connection, Remote Name Request and
LE Create Connection are the common ones, and the delay is often seconds,
so this is exactly where the request reference is worth having. Until now
the completing event carried no hint of which command caused it:

  > HCI Event: Connect Complete (0x03) plen 11              #27 [hci0] 6.178055
          Request: #12 (3003.000 msec)
          Status: Success (0x00)
          Handle: 12
          Address: 00:11:22:33:44:55 (CIMSYS Inc)

Keep such commands queued past their Command Status and resolve them when
the completing event arrives, using a table that maps the opcode to the
event and to the value the two are matched on. Several may be outstanding
towards different devices at once and need not complete in order, so the
match is on the connection handle or the remote address, not on the opcode
alone. Inquiry and the LE connection commands are matched on the opcode
only, since the specification allows a single one to be outstanding and
the address in the command is ignored when the accept list is in use.

A Command Status reporting an error means the completing event will never
arrive, so the command is dropped instead of being left to match a later
unrelated event.

Setup Synchronous Connection and LE Create CIS are deliberately left out.
The former reports the ACL handle in the command but the new synchronous
handle in the event, and the latter produces one event per CIS, so neither
can be matched this way without being wrong.

The model wrote the table and the matching, which the author reviewed and
verified against traces covering out of order completion of two commands
with the same opcode, handle and address keyed matching, a failing Command
Status and truncated events.

Assisted-by: opencode:claude-opus-5


  Commit: 0c926ea1a4320552ba73fd3cd0b2a83f5a45f221
      https://github.com/bluez/bluez/commit/0c926ea1a4320552ba73fd3cd0b2a83f5a45f221
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the deferred command references

Describe the Request field shown on events that complete a command which
was only acknowledged by a Command Status, and how those are matched.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5


  Commit: 0f726ab43454aa4d092d938b1d9880891a5980a2
      https://github.com/bluez/bluez/commit/0f726ab43454aa4d092d938b1d9880891a5980a2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Report command latency in analyze mode

A trace shows every command and every response, but not how quickly the
controller answered, and a command that was never answered at all leaves
no trace beyond its absence.

Measure the interval between a command and the Command Complete or
Command Status that acknowledges it, and report it per controller along
with the number of commands still unanswered at the end of the trace:

  Command latency: 0-215 msec (~55 msec +/- 70 msec)
  Commands without response: 3

Commands that are only acknowledged by a Command Status and complete much
later through a separate event are measured up to the acknowledgement
only. A Create Connection waiting three seconds for its Connect Complete
is waiting on the remote device, not on the controller, and folding that
in would swamp both the average and the deviation and leave the figure
describing how many connections the trace happened to contain.

Commands are matched on the opcode, oldest first, since several may be
outstanding at once and they need not complete in order. The queue is
bounded so commands that never get a response cannot pile up.

The model wrote the tracking, which the author reviewed and verified
against a trace with a known latency spread and known unanswered
commands.

Assisted-by: opencode:claude-opus-5


  Commit: d7037412876408f9dade2388459d1c219b55c996
      https://github.com/bluez/bluez/commit/d7037412876408f9dade2388459d1c219b55c996
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the command latency statistics

Describe what the command latency measures, why deferred commands are
only measured up to their acknowledgement, and how to read the count of
commands without a response.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5


  Commit: 7b0f38544cd144097d4e99cb1eec02ca0cb24847
      https://github.com/bluez/bluez/commit/7b0f38544cd144097d4e99cb1eec02ca0cb24847
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M monitor/l2cap.c
    M monitor/l2cap.h
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add request tracking for the protocols above HCI

The protocols carried over ACL pair their requests and responses through
an identifier of their own, but a response gives no hint of where its
request was, and the time between the two is only visible by comparing
timestamps by hand.

Track outstanding requests per connection so that a response can name the
frame that carried the request, and use it for L2CAP signalling, where
responses are the request code plus one and a Command Reject may answer
any request:

  L2CAP: Connection Request (0x02) ident 1 len 4
  L2CAP: Connection Response (0x03) ident 1 len 8 #2 (1.000 msec)

None of these layers had access to a timestamp or a frame number, since
neither is passed down from the HCI decoding. Rather than thread both
through every protocol handler, record the packet being decoded and pick
it up in l2cap_frame_init(), which every frame passes through.

Requests are keyed on the channel rather than on the CID, because a CID
names the receiving end and therefore differs between the two directions
of the same channel. Fixed channels keep using the CID, which is already
the same either way.

The model wrote the tracking, which the author reviewed and verified
against traces covering matched and unmatched responses on both fixed and
dynamically allocated channels.

Assisted-by: opencode:claude-opus-5


  Commit: a565e23cce6844415368ff7cc32dcb30a8bd2c8c
      https://github.com/bluez/bluez/commit/a565e23cce6844415368ff7cc32dcb30a8bd2c8c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Reference the request frame on responses

ATT responses use the request opcode plus one, and only one request may be
outstanding on a bearer, so the opcode itself identifies the transaction:

  ATT: Read By Group Type Request (0x10) len 6
  ATT: Error Response (0x01) len 4 #6 (45.500 msec)

An Error Response names the request it rejects rather than following the
plus one rule, so it is matched on the opcode it carries. A Handle Value
Indication is paired with the confirmation that answers it.

The model wrote the matching, which the author reviewed and verified
against a trace covering ordinary responses, an Error Response, an
indication and a response with no request.

Assisted-by: opencode:claude-opus-5


  Commit: c2840bd827aff5f46334b93453af8976fc223a69
      https://github.com/bluez/bluez/commit/c2840bd827aff5f46334b93453af8976fc223a69
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M monitor/avctp.c
    M monitor/avdtp.c
    M monitor/sdp.c

  Log Message:
  -----------
  monitor: Reference the request frame on SDP, AVDTP and AVCTP responses

SDP pairs a request with its response through the transaction identifier,
and responses use the request PDU plus one with an Error Response able to
answer any request. AVDTP and AVCTP both pair a command with its response
through the transaction label:

  SDP: Service Search Request (0x02) tid 5 len 8
  SDP: Service Search Response (0x03) tid 5 len 5 #8 (12.400 msec)
  AVCTP Control: Command: type 0x00 label 7 PID 0x110e
  AVCTP Control: Response: type 0x00 label 7 PID 0x110e #12 (23.100 msec)

These all run on dynamically allocated channels, which is what the channel
keyed matching was needed for.

The model wrote the matching, which the author reviewed and verified
against a trace carrying all three over separate channels.

Assisted-by: opencode:claude-opus-5


  Commit: 2401054ca67a1f79e44e71d6a1cea096a13f5e5d
      https://github.com/bluez/bluez/commit/2401054ca67a1f79e44e71d6a1cea096a13f5e5d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the protocol request references

Describe the request references shown on L2CAP, ATT, SDP, AVDTP and AVCTP
responses, and what pairs the two halves of a transaction in each of them.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/f87a79667dac...2401054ca67a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
