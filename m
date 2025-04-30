Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AF25A632
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019031; cv=none; b=GGpSodBVubqHBDTojNI2aQhjeUJCXJMeboO8JxN7dsvInsYvmlqdF7ZTXbHYwZxn/CD/2ZO8gL1/l8WJAhOsJ29gL0WrLSscMdOleJgaG/KMfu5QD3lOWoj//I6AA+0yt0+zwPOq7Lbp6oGjEZcHidYCLmxbN9ChGvAwLDwaMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019031; c=relaxed/simple;
	bh=N+gPtcMcezkkQvwUK/k2qdAv6aYIdWIFaaIWeRsuqqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnCQqd/eWspJKKbLX5rMQCwsgJ7Nr2tImwvuF18WH4OUZwtR3x0RtpZlmTrhyfs2p0zyQiCKDjkKE2YTXHMoQgjiREEQ5AZxMIyFdh7k7khcl/ew4fgecvPn1mWec+Zd3HgDvrP9x6xGN2UIbGCGKJ7kkFgvfPAvIIVtMGZ0PAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from a.d.e.2.8.8.9.5.f.7.2.3.4.3.2.4.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:4234:327f:5988:2eda] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uA7JB-00B6cr-0q;
	Wed, 30 Apr 2025 14:17:06 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v6 0/3] obexd: unregister profiles when the user is inactive
Date: Wed, 30 Apr 2025 14:13:59 +0100
Message-ID: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
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

v1 -> v2 open/close private DBus connections instead of
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
V4 -> V5 Add #include <stdlib.h> based on CI tests - thanks Luiz
         Update the timeout on event_handler calls (and handle a couple of
           edge cases that could have misbehaved before) - thanks Pauli
         Discuss how the API assumes poll() in the penultimate
           commit message - thanks Pauli
V5 -> V6 Remove commits that were upstreamed in v5 (thanks Luiz)
         Replace dummy macros with inline functions in logind.h
           (silences some checkpatch.pl warnings, function solution
           recommended by Luiz)

Andrew Sayers (3):
      obexd: Unregister profiles when the user is inactive
      obexd: Support sd_login_monitor_get_timeout()
      Revert "obexd: only run one instance at once"

 Makefile.obexd            |  10 ++
 obexd/client/pbap.c       |  17 ++-
 obexd/plugins/bluetooth.c |  14 ++-
 obexd/src/logind.c        | 282 ++++++++++++++++++++++++++++++++++++++++++++++
 obexd/src/logind.h        |  37 ++++++
 obexd/src/main.c          |   4 +
 obexd/src/obex.service.in |   9 --
 7 files changed, 359 insertions(+), 14 deletions(-)

