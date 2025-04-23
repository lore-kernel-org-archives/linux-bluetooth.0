Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAED288CA4
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426074; cv=none; b=IlLfspW7D2psK34WIUV+SGlldxSfZ7V98wqMFmHnLffSqCEZkyVzDew/y28qbg/ok5FL3/allOtbXFzcPL008+bX22phjW+dzWpovbW/TbHffnshPK4qZX9NBtmyYWBdtaySqPMHToUUpqT6bACvot7UYEudFmd3yy0gihzPFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426074; c=relaxed/simple;
	bh=FVIXcLF1VvJzBXnTY5lcWWJHoS/TYBDE0MmDy88qFc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3N1LlhRpn8gidESkEZ1Ht08dvgSUjHyuTiyy6PXjVi5wJqK75k8uZ6lClvth0roG1F2X8VbkyiUiH7vu7iCtkQxdvMEoR6SCWJfccpqJPCwJsZWCjYqepVvWHVZUgC6XpS/lq+iSHtclWqXOPy74zwzA6Slp1SbhM9BW2JLl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 2.d.9.3.3.f.4.8.6.f.f.b.b.0.3.7.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:730b:bff6:84f3:39d2] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u7d3M-00El0N-08;
	Wed, 23 Apr 2025 17:34:28 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH 0/4] obex: unregster profiles when the user is inactive
Date: Wed, 23 Apr 2025 17:33:22 +0100
Message-ID: <20250423163343.4160595-1-kernel.org@pileofstuff.org>
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

Andrew Sayers (4):
      pbap: Support calling pbap_init() after pbap_exit()
      obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
      obex: unregster profiles when the user is inactive
      Revert "obexd: only run one instance at once"

 Makefile.obexd            |  10 ++
 obexd/client/pbap.c       |  34 ++++++-
 obexd/plugins/bluetooth.c |  44 ++++++++-
 obexd/src/logind.c        | 238 ++++++++++++++++++++++++++++++++++++++++++++++
 obexd/src/logind.h        |  26 +++++
 obexd/src/main.c          |   4 +
 obexd/src/obex.service.in |   9 --
 7 files changed, 350 insertions(+), 15 deletions(-)

