Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAA37F01B
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399242; cv=none; b=RdO0AAFnm3x+ZvoDUUlQZh7qBQevMDtxNSqZ6kpC937MnElfPXMogpxf/6i097OjFe9v2c3Oj2utH5zWcwfWkkxpHwqq6qiKm2ALsNfhSFOQRV0soR9B4mZ4qNjicpWCXfQVz3FlEl8n//XSrYCUvg575OsxXr+j+iIFWNmhgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399242; c=relaxed/simple;
	bh=288vNyjFI/o7LdvjUh7z8jeCilP+HcKmqNrYjzNjx50=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OnsuloNa8TTGpgHf+JQeQoz8Xb84e1O+hPTDPN+mEM2yyJBbQ4fVq5+5ghrVSzHnHvKOn6wtB1L7P3DaVlPYO+L2uTK/mocakTz/oys+3f7iAoqfWUtcQciVE8IU9T9MUbHkifZUgquVchZHRehet9M+yyHjsL7LKBErDDCElp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=gy6pJCN8; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="gy6pJCN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791399239;
	bh=bm/K3OgpoZGDcbD8RVAhJZ4piTHQGoRaA7mD5SCTP/c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gy6pJCN8Lgp3Im5H5CBVQNpPvGZMTtH7NegGnlH5AjZutFpXO40J/zKW0pshw0Jb4
	 ZFvkAZoc+8tla+2DsqXsyW9N21So1D059ufm+dVKT4y/tQM4Hp3tin3xsfp8hkQ4rb
	 IL9RI05pj3GNO/uQ/k0L0yi/zuxelx77NSxscJemyfdqWop9P0hpT7eNRTGVhdA32r
	 IuryZDb1iGP4/38YB40/U9HJ8E3L8RG/x7LNb7+/4o2EwjNPLB09oBVGL9ChFNAOqc
	 n2Jz1TvSXYo0Evx3x8iXRTIonfRBXU+JiUmuOqoJcBpJekWWzFLvlld4vKVCN4/AGa
	 UOweoLY+mXLGg==
Received: from github.com (hubbernetes-node-35e9fb4.ac4-iad.github.net [10.52.175.32])
	by smtp.github.com (Postfix) with ESMTPA id E7FFE741392
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 11:53:59 -0700 (PDT)
Date: Wed, 07 Oct 2026 11:53:59 -0700
From: IAROSLAV VOITOVYCH <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f8f352-d84171@github.com>
Subject: [bluez/bluez] d852fa: transport: Preserve Release on late BAP ready
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
  Commit: d852faf0b1d1a9a5b2c0e2bb0b8310a21f1cff58
      https://github.com/bluez/bluez/commit/d852faf0b1d1a9a5b2c0e2bb0b8310a21f1cff58
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Preserve Release on late BAP ready

A late stream-ready event can reach bap_resume_complete() after Release
has queued Disable. It then replies to Release with an Acquire payload
and drops the Disable request ID. Client disconnection can subsequently
free the owner while the Disable callback still refers to it.

Only complete pending Acquire/TryAcquire requests from this path. Leave
Release and its request ID for the Disable callback or cancellation.

Fixes: 466fce0209a3 ("transport: handle BAP Enabling state correctly when resuming")
Assisted-by: Codex:GPT-6


  Commit: 47f783ff5ba40135feb2fb1a68dcd1a8f457df04
      https://github.com/bluez/bluez/commit/47f783ff5ba40135feb2fb1a68dcd1a8f457df04
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Recreate stream IO after an early Enable

When reacquiring a transport, the stream can reach Enabling before its
previous CIS finishes disconnecting. Once teardown completes, IO
recreation accepts only QoS, while CIS enabling requires existing IO.
The pending Acquire consequently stalls.

Allow deferred IO recreation in Enabling too. Keep the existing CIG-busy
checks and recreate all IO before enabling CISes.

Fixes: 7feff47a9fbe ("bap: delay QoS & IO creation if CIG is busy or setups configuring")
Assisted-by: Codex:GPT-6


  Commit: 4b44e0726c6fb81bc972087edecc136c4038d3a4
      https://github.com/bluez/bluez/commit/4b44e0726c6fb81bc972087edecc136c4038d3a4
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: Cover BAP transport release and reacquire

Acquire both unicast transports, close their sockets and release them
through the same D-Bus owner. Require an empty Release reply so a late
ready callback cannot pass unnoticed by returning an Acquire payload.

Wait for both Acquire replies before Release, and for both Release
replies before the next Acquire. Only requests on different transport
paths are concurrent; no path has successive operations queued without
waiting for its preceding reply.

Repeat three times with immediate, 100 ms and one-second reacquisition.
Check Acquire reply types and active transport states. Close returned
FDs even when a reply is malformed.

Assisted-by: Codex:GPT-6


  Commit: 28cfa93135d4e77114f4e3c93954eeb37e1d130c
      https://github.com/bluez/bluez/commit/28cfa93135d4e77114f4e3c93954eeb37e1d130c
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Remove unused le_ext_adv_type

Nothing has read le_ext_adv_type since advertising sets got their own
struct le_ext_adv in commit 5145b1ea2e95 ("emulator/btdev: Add support
multiple instance of extended advertising"). Remove it along with
ext_legacy_adv_type, rather than fix that function's mapping of low
duty cycle directed advertising (0x04) to ADV_SCAN_IND.

Assisted-by: Claude:claude-opus-5.5


  Commit: 11f99edc26c78b2bedfbb44f91008cbcea5a1a53
      https://github.com/bluez/bluez/commit/11f99edc26c78b2bedfbb44f91008cbcea5a1a53
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix extended scan response Event_Type

The scan response to non-legacy scannable advertising was reported with
Event_Type 0x0000, since the scan response bit was masked instead of
set, so hosts saw it as a separate non-connectable advertisement.

Fixes: 32339501a125 ("emulator: Add 5.0 feature support")
Assisted-by: Claude:claude-opus-5.5


  Commit: 73d7f86a117a7ec5b32f82e50bf4decdc2cef5a5
      https://github.com/bluez/bluez/commit/73d7f86a117a7ec5b32f82e50bf4decdc2cef5a5
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Fix report type after a scan response

ext_adv_broadcast stored the scan response type in report_type, which
is also used for the advertising report to the next scanner, so every
active scanner after the first got the advertisement reported as a scan
response.

Fixes: 32339501a125 ("emulator: Add 5.0 feature support")
Assisted-by: Claude:claude-opus-5.5


  Commit: d84171e6cd68a5ab95d0f3a384279c36bd108a13
      https://github.com/bluez/bluez/commit/d84171e6cd68a5ab95d0f3a384279c36bd108a13
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

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

  bluetoothd[398112]: segfault at 10 ip 0000635d944b47e5 \
      sp 00007ffefcba28d0 error 4 in bluetoothd[367e5,635d944a3000+f3000]

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


Compare: https://github.com/bluez/bluez/compare/f8f352d133fa...d84171e6cd68

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
