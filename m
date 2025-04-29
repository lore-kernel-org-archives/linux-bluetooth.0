Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2D2D29D6
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936162; cv=none; b=FwTiTtr2er0oTtgJhQRGtTkKoxuCmk9f0a8I7k0XjSBrYgn7ie0IKa8fr/cu+mBufxp6IroN6tpq9qe5rRbMhRjlOBv00kAZDS5E/+DuzpC5+GlmZrrlOFzZmjMyPo9BBzqk+uTTJH69swiBCTGfq6lpk9EllA8UH7Lp4PziUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936162; c=relaxed/simple;
	bh=s5QDdVkbROSlmPA+dk9Gq4CqN4KKMGAvoGE8u4U3NqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+nQlofUeBYR7p6SzvVNTOaKM46d4YhEg87tqYE+pDtn8APzreDVguv+J78upwPNuYQJj+41CDPRZ9J3NNdwduclv9On9msg8wajR4m6CW1Z/iu3IJKvr2LhHl7Qu0mc31AANtqaUIpRr8ub4tAtBbE0xWJ3g0Bu3tEmVhtfwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from e.d.9.2.d.8.4.d.d.a.6.6.5.f.8.1.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:18f5:66ad:d48d:29de] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u9lkb-008Jal-34;
	Tue, 29 Apr 2025 15:15:57 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v5 0/6] obexd: unregister profiles when the user is inactive
Date: Tue, 29 Apr 2025 15:14:10 +0100
Message-ID: <20250429141533.803295-1-kernel.org@pileofstuff.org>
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

Luiz, I've looked through the CI errors and added `#include <stdlib.h>` -
the other errors don't seem related to anything I've done,
but happy to fix anything I've missed.

Pauli mentioned that, since the API assumes we're calling poll() directly,
the timeout could theoretically be updated by events that don't trigger
an event_handler() call.  I agree it would be bikeshedding to fix that
now, but it would be a nightmare to debug if it ever happened,
so I've mentioned it in the relevant commit message.

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

Andrew Sayers (6):
      pbap: Support calling pbap_init() after pbap_exit()
      obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
      obexd: Support creating private system/session bus connections
      obexd: Unregister profiles when the user is inactive
      obexd: Support sd_login_monitor_get_timeout()
      Revert "obexd: only run one instance at once"

 Makefile.obexd            |  10 ++
 obexd/client/pbap.c       |  33 +++++-
 obexd/plugins/bluetooth.c |  30 ++++-
 obexd/src/logind.c        | 282 ++++++++++++++++++++++++++++++++++++++++++++++
 obexd/src/logind.h        |  26 +++++
 obexd/src/main.c          |  12 ++
 obexd/src/obex.service.in |   9 --
 obexd/src/obexd.h         |   2 +
 8 files changed, 386 insertions(+), 18 deletions(-)

