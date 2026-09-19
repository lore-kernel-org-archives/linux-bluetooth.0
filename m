Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787E3955F3
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789852004; cv=none; b=BMLhhxhGi+8FrE1Ji92EAhoc4RznfGhf2qViHzQt6NBVKF4wi+4deJh4kDQqclXaXSu90g049NjciYyA4LDt1UAoQRtQfaOUGA8v9xHsVpipPRjuoVqAPVqK3qDA1zga+20Sy2XYRjYmdqL/pPjjTdla1yJkRqt9DmbGOb4R83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789852004; c=relaxed/simple;
	bh=Mj20bHk11Xz1k/8jClvLrdrJmX/TpErl3vWhLSoJe88=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C0KImUhGTFFuhmNETytA5okTTRjXuirv7gSZV/IwDnfHpdgGboKbs8yd2ODenC3/Hx0JLJbm3vxNdRX8LgnLN4JceGgNqTEJULW4NxaknxcCWgjsN8NyNbWyY3LLLvtXML7ukNzi2ohEjMM91Fyo4Y8FzqPDE84oEay0LbMFfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OKPuZw4b; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OKPuZw4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789851986;
	bh=rkNyMlVAZ8WtK1sHANDSeaHZZtFEIZHX/ttsXmr+cMo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OKPuZw4bspeEnk5u+AePGHQj67kZkJUgCiO4bN4uVcmIb1D13f+98HUcQwp56NVau
	 tNXhoqiMdL5YazWSc75Bi0UF8gBlWymKkqiuKkAWy/ubTR4vfeRcK/wey+g0U7khPW
	 YqrqkOB2bChDqFCymUyEiyII4t6ADIxoiNo1jrdk=
Received: from github.com (hubbernetes-node-66db4b1.ac4-iad.github.net [10.52.137.32])
	by smtp.github.com (Postfix) with ESMTPA id DEDAC740752
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 14:06:26 -0700 (PDT)
Date: Sat, 19 Sep 2026 14:06:26 -0700
From: IAROSLAV VOITOVYCH <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169363/000000-0e2503@github.com>
Subject: [bluez/bluez] 0e2503: a2dp: Fix crash on NULL stream in transport_cb
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

  Branch: refs/heads/1169363
  Home:   https://github.com/bluez/bluez
  Commit: 0e2503425c486cb6326c4d200d04ef709fe9d00f
      https://github.com/bluez/bluez/commit/0e2503425c486cb6326c4d200d04ef709fe9d00f
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-09-19 (Sat, 19 Sep 2026)

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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
