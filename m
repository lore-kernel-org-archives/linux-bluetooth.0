Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5A25E81D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846371; cv=none; b=fwiRC+At/BCOPZZql7mHTWTa0tWf55tlqgFuajlji3DP+MBUi7Afvzkur0Dky1Tauu+9hbqk8tCezJWBvlyh1d1wuaH1Asf50sgfP1L4p22knoUiNo2PWjg7xk2xhaqQM2YMqVuAXeDuwz8fM0XIMphX3alz0KziuBbpw9eeJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846371; c=relaxed/simple;
	bh=Q+xh5x1bADGM+Kb6hhwnzoCofdJmoCoBkobCElMeAoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgF7CBQRF4YTrqvpuDs1EXgNXGrlIUYKQEgdCifIGxDHpH+UJ0+8GOCj8MF2iWJ+MqghnuHWWnTNce06iTqpN+I3aGfSTzYgwffTw6UUaRNsTNErrH2LkmPcAeNC3Onm0b1i/oGDBfJtykmfEHFulGDp1A8rXD6RpD8ONG4YvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 4.0.e.4.2.0.f.6.8.d.6.d.1.1.3.4.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:4311:d6d8:6f02:4e04] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u9OOL-0079pP-2Y;
	Mon, 28 Apr 2025 14:19:25 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v4 0/6] obexd: unregister profiles when the user is inactive
Date: Mon, 28 Apr 2025 14:15:29 +0100
Message-ID: <20250428131842.488921-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to "obexd: only run one instance at once".
Instead of refusing to run parallel services, it unregisters
profiles when the user is inactive.  This avoids the need
for tmpfiles, and avoids issues where the user with the
obex service logs out, leaving obex disabled altogether.

Luiz previously suggested moving this to systemd, but I haven't had much
luck getting the systemd devs to accept changes, and Pauli's mention of
elogind (i.e. logind without systemd) suggests it's probably better
to avoid the dependency anyway.

I considered writing a separate D-Bus service that would notify you
when the session became (in)active, but D-Bus doesn't have particularly
strong guarantees about how long messages take to deliver, which could
lead to race conditions between instances on overloaded systems.

I also considered writing some kind of library, but there's not much
code to deduplicate, and most of it would need to be reworked for every
service that uses it.  So I wrote a gist for people to copy/paste:

https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---

Pauli pointed out timeout_handler() isn't required by the implementation,
even though the documentation implies otherwise.  Having thought about it
over the weekend, it seems hard to avoid concluding both that
timeout_handler() cannot be fully tested in the real world right now;
and that any change to the API would likely happen in many years' time,
when we've all forgotten how to fix the problem.  So I've moved that bit
to a separate patch, which can be bisected and reverted if necessary.

Pauli - I appreciate the feedback and wanted to note it in the patch,
without implying you wanted that function kept in.  I've settled on
a Cc: line, but happy to change it if you'd prefer.

V1 -> V2 Open/close private DBus connections instead of
           calling UnregisterProfile (thanks Pauli Virtanen)
         Add obex_setup_dbus_connection_private() (to enable the above)
         Fix CI errors
         Minor issues I missed last time...
           s/regster/register/ in e-mail subject lines
           s/login_.*_cb/logind_$1_cb/g in logind.[ch]
           remove watches on exit in pbap.c and bluetooth.c
V2 -> V3 Fix checkpatch.pl errors - thanks Luiz
           Note: false positive warning about commit #4 is still present -
           this URL can't be split or shortened without causing issues.
V3 -> V4 Fix various bugs - thanks Pauli
         Split timeout_handler() into a separate patch - see above

Andrew Sayers (6):
      pbap: Support calling pbap_init() after pbap_exit()
      obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
      obexd: Support creating private system/session bus connections
      obexd: Unregister profiles when the user is inactive
      obexd: Support sd_login_monitor_get_timeout()
      Revert "obexd: only run one instance at once"

 Makefile.obexd            |  10 ++
 obexd/client/pbap.c       |  33 +++++-
 obexd/plugins/bluetooth.c |  30 +++++-
 obexd/src/logind.c        | 260 ++++++++++++++++++++++++++++++++++++++++++++++
 obexd/src/logind.h        |  26 +++++
 obexd/src/main.c          |  12 +++
 obexd/src/obex.service.in |   9 --
 obexd/src/obexd.h         |   2 +
 8 files changed, 364 insertions(+), 18 deletions(-)

