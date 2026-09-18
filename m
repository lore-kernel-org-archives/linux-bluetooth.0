Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE965187DB
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753240; cv=none; b=W73dSuEwoYDy24sAwQXEIKdHZQSmWqxOsiw93b/YOMgN7wpBzduILWX0Z4dZz1K9JC+qtFDiTTBFxRPLVGYlBfWtKbeklH529nh7PwtebBZPu3XYlYkHTxj7FHG7IEkisG353s/ESvJNtv4bm7NI2Xmn116ONQwmnHCZ3/9clE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753240; c=relaxed/simple;
	bh=ab9ANZWJpf9IVJH8IEvvSlkiSNjaKMQl0gVvGQTdIqM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=c40SSQZr7zyXSrX7Tm/f+utre4QepBQyOQBlUuhdkWZh4FL39ybZry13F2KkTEgNNV1It8LnHY5mO4KANeZpzybqbN47Rkxy7RiWEzNtZFW0E7/edDisILJHxDOfg5cDPPeA4lGuPSHraDPWJ+FKNe0ny6LBPDNj3bpK/6d+pYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ifYYj4nQ; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ifYYj4nQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789753237;
	bh=5IbePxfgSYqhLrWQQ7HJeB0/zkLYDvMISFs4RdyAU9U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ifYYj4nQK1cjlqz30JiFPUHMZLpnsw/DYwPr8b4nzmA2+EFbSvhhhTHGxhRKuiIDZ
	 xmeXC9kh2Y+oRhU3RqA8GQjTy2vuGt9NA1SdZb16Ma+xKrGetJdbN6cSoRoT5g00TS
	 wwD9vrUBqGF3jUiwFH2k8Zh+1vuj3ZAbogvrSEHo=
Received: from github.com (hubbernetes-node-da445e1.va3-iad.github.net [10.48.64.65])
	by smtp.github.com (Postfix) with ESMTPA id 7C42650085C
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:40:37 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:40:37 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1168850/000000-6eb44f@github.com>
Subject: [bluez/bluez] eb58dc: monitor/analyze: Free the channel latency plots
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

  Branch: refs/heads/1168850
  Home:   https://github.com/bluez/bluez
  Commit: eb58dc5a596c20fc25e231ea4e1f9c6864d87894
      https://github.com/bluez/bluez/commit/eb58dc5a596c20fc25e231ea4e1f9c6864d87894
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: aa11d08cb772d525a9910d68609e6ddf10efd8c0
      https://github.com/bluez/bluez/commit/aa11d08cb772d525a9910d68609e6ddf10efd8c0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: 773b112f38de3725722f46b28f44c06072457b66
      https://github.com/bluez/bluez/commit/773b112f38de3725722f46b28f44c06072457b66
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor/analyze: Drop a trailing space before a newline

The count of control messages is printed with a space between the text
and the newline, which puts a stray character at the end of the line.

Assisted-by: opencode:claude-opus-5


  Commit: 310db2a397ba99861a940407662bf6e8331eefe2
      https://github.com/bluez/bluez/commit/310db2a397ba99861a940407662bf6e8331eefe2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: ea58ac3a07c51605abcd358a133ff3c87dc1b014
      https://github.com/bluez/bluez/commit/ea58ac3a07c51605abcd358a133ff3c87dc1b014
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: 204c5e05a7d1aaea517208d5112c9444eaa991c6
      https://github.com/bluez/bluez/commit/204c5e05a7d1aaea517208d5112c9444eaa991c6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: 026ca0f098664488812f2400fa320c5e44a87392
      https://github.com/bluez/bluez/commit/026ca0f098664488812f2400fa320c5e44a87392
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document searching the frames

Describe how the frames are separated for a pager reading records, how the
ones seen so far are handed to the pager while capturing, and that they
are only collected when the output is a terminal.

Assisted-by: opencode:claude-opus-5


  Commit: 0351467e112d4c7915dfe007299d05e27b2621e5
      https://github.com/bluez/bluez/commit/0351467e112d4c7915dfe007299d05e27b2621e5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

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


  Commit: 6eb44fd8c89b30a08b61bd437b2d6572a436353e
      https://github.com/bluez/bluez/commit/6eb44fd8c89b30a08b61bd437b2d6572a436353e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Document the pager choice

Describe that fzf is used when PAGER is not set, the options it is given,
and that it needs --ansi to render the colours when named explicitly.

Assisted-by: opencode:claude-opus-5


Compare: https://github.com/bluez/bluez/compare/eb58dc5a596c%5E...6eb44fd8c89b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
