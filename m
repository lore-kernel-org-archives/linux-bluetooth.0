Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CEB1F3B96
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601340; cv=none; b=IqRs3rBl2qvsBNjklSDUFN70clb4IpLM1U4vuzXbKZOEMt4NLKQlU3OqTozMUOT8Vy7uwWtk7BGVN1WKEzIyPzizN4d5xVfxfCK2cTe3ACMENX5oSWA4/G7h/5gr+y0CnErxpj62KugnoCB6w6guLAKeiPPKULWEZzC4ejrLdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601340; c=relaxed/simple;
	bh=N5q9akcaPJunL6jppTI5rJin8suTSGtM9bhsBFQdmc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hv67434QpmpVReqy/AGzsAT/dUVhZsZ9uMcA58XByykiNT0zLBGQbxWQh8+T2+sOhofcTtguswPXeNOmw0PDJqBgCD2gStymtCUsaM9iZRg2EAz4OBuNKY9LLXP974grzPUHAbO4AY+Nen6Nn2zuZhBPbmfqUvMMypXmHLaECoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from f.e.3.8.2.2.5.b.8.9.9.0.4.5.1.6.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:6154:998:b522:83ef] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u8MeE-0005GV-2E;
	Fri, 25 Apr 2025 18:15:34 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v2 0/4] obexd: unregister profiles when the user is inactive
Date: Fri, 25 Apr 2025 18:12:59 +0100
Message-ID: <20250425171505.573271-1-kernel.org@pileofstuff.org>
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

V1 -> V2 Open/close private DBus connections instead of
          calling UnregisterProfile (thanks Pauli Virtanen)
         Add obex_setup_dbus_connection_private() (to enable the above)
         Fix CI errors
         Minor issues I missed last time:
           * s/regster/register/ in e-mail subject lines
           * s/login_.*_cb/logind_$1_cb/g in logind.[ch]
           * remove watches on exit in pbap.c and bluetooth.c

Andrew Sayers (5):
      pbap: Support calling pbap_init() after pbap_exit()
      obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
      obexd: Support creating private system/session bus connections
      obexd: Unregister profiles when the user is inactive
      Revert "obexd: only run one instance at once"

 Makefile.obexd            |  10 ++
 obexd/client/pbap.c       |  33 ++++++-
 obexd/plugins/bluetooth.c |  30 +++++-
 obexd/src/logind.c        | 245 ++++++++++++++++++++++++++++++++++++++++++++++
 obexd/src/logind.h        |  26 +++++
 obexd/src/main.c          |  12 +++
 obexd/src/obex.service.in |   9 --
 obexd/src/obexd.h         |   2 +
 8 files changed, 349 insertions(+), 18 deletions(-)

