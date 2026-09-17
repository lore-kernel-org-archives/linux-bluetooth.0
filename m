Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B4495AF0
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685508; cv=none; b=OeDEIhOy5ipUY/vSw2NHmlkT7LEiiWm6lq5vp2LRfARNM2ZahaSKL5GWHFnypwrH8NrlHn6odXjLIgrCCOBFBlTiGB3bM/Ot6uHQSL5NDtjbRWcFz0S7H+R4G//9uQQroDdWKgaVfcPtklxzSGFG331VeezQPnZ2tv+CyyJPJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685508; c=relaxed/simple;
	bh=y0Ud6cMP4St6hqqZO9MEO2j+CGl1qezUiW50QVTvSgI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ohYYXbudwyiHIi4AhFjxuUu3KDMGbSZ9as4YsBiQClDvQNGHhCkMPLeh8FUWHIZBYkkxwqHZPiOeKMskeiKWNnhqFXI06sxFHqUaXsQXpND5UfCmN9N3HWNReLd26JXltOaFMp/kRnCwrs2EYID+VldGwbSt8YM84oKFzV1Q3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LIeI1HHS; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LIeI1HHS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789685506;
	bh=6VZQ264gv6OnDheqFD5r5NlCbuK+R29oO3HTOv16m3A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LIeI1HHS0+9zbx19sMzDKADfT+zJWeFqLyUui1AMy39Ya2aGe5PoXPJdEEM4BhRt1
	 wSwdmgD2p7gcAYdLpdQ519pfQbnB/o48Uq3O/sU8IXHTWv9QiHfO3mRXhYjJgqtt5P
	 KnEgVHjjFl9uddwWsxP1ThZe6RXEOEyQAjmLbs90=
Received: from github.com (hubbernetes-node-3350ea2.va3-iad.github.net [10.51.96.33])
	by smtp.github.com (Postfix) with ESMTPA id 1A7827806B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 15:51:46 -0700 (PDT)
Date: Thu, 17 Sep 2026 15:51:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168010/000000-46235d@github.com>
Subject: [bluez/bluez] 1b75f4: monitor: Route the decoding output through a
 singl...
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

  Branch: refs/heads/1168010
  Home:   https://github.com/bluez/bluez
  Commit: 1b75f454a20b977624b5dc2fcc232cab07f1d6a7
      https://github.com/bluez/bluez/commit/1b75f454a20b977624b5dc2fcc232cab07f1d6a7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

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

The model performed the conversion, which the author reviewed and
verified by comparing the output of both modes over a set of traces
before and after, byte for byte.

Assisted-by: opencode:claude-opus-5


  Commit: 056426bcf3a52107e02cf67da3bdf83af3f55ced
      https://github.com/bluez/bluez/commit/056426bcf3a52107e02cf67da3bdf83af3f55ced
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

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

The model wrote this, which the author reviewed and verified by counting
the separators against the frames, by checking that a pager reading lines
still receives none, and that the output is unchanged when neither is
asked for.

Assisted-by: opencode:claude-opus-5


  Commit: ce3496b857efa4b68690d9d6f1978e718b1aae4c
      https://github.com/bluez/bluez/commit/ce3496b857efa4b68690d9d6f1978e718b1aae4c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

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

The model wrote this, which the author reviewed and verified against a
capture fed through a terminal, covering the printing before and after,
the capture continuing to be collected while the pager was up, the
frames arriving then being printed on close, and a piped capture being
left alone.

Assisted-by: opencode:claude-opus-5


  Commit: ab66bf7de73d2f2bbab0bb92a5a8ac835e5812bf
      https://github.com/bluez/bluez/commit/ab66bf7de73d2f2bbab0bb92a5a8ac835e5812bf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document searching the frames

Describe how the frames are separated for a pager reading records, how the
ones seen so far are handed to the pager while capturing, and that they
are only collected when the output is a terminal.

The model drafted the text, which the author reviewed against the actual
behaviour.

Assisted-by: opencode:claude-opus-5


  Commit: 39385b0d656ae1c1bb4d88f7a74f973bccb24da1
      https://github.com/bluez/bluez/commit/39385b0d656ae1c1bb4d88f7a74f973bccb24da1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

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
frames and for the colours to be rendered rather than shown as escape
sequences:

  fzf --ansi --read0

PAGER is still honoured when set, and setting it to cat or leaving it
empty still turns the pager off. The choice is shared with the frames
seen so far being handed over while capturing, so both arrive at the same
pager.

Frames are separated only when a pager that reads records is going to
read them, so redirected output and a pager that reads lines are both
left exactly as they were.

The model wrote this, which the author reviewed and verified by checking
which pager is started for each setting of PAGER, that the colours are
rendered rather than shown, and that redirected output is unchanged.

Assisted-by: opencode:claude-opus-5


  Commit: 46235d37e5ae5ea805735c58b453d49a2c325574
      https://github.com/bluez/bluez/commit/46235d37e5ae5ea805735c58b453d49a2c325574
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the pager choice

Describe that fzf is used when PAGER is not set, the options it is given,
and that it needs --ansi to render the colours when named explicitly.

The model drafted the text, which the author reviewed against the actual
behaviour.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/1b75f454a20b%5E...46235d37e5ae

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
