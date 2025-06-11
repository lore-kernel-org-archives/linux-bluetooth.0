Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44D28467F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647525; cv=none; b=iVJDZohP3aW7AOWY9LWBEifLqe/+YGmBOVMgS6sHnJjJM4yJL06XuCkv3Pcvnlj5whV4r76x2AV8C3AfttW86XzPnik0OIh7M6ryF4HTD/W+yEyzem3fyA/ZcCanzDG7py9VMu+XkE10PHmPvEPtMzWYE1nrlMpauG//Th85kSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647525; c=relaxed/simple;
	bh=ohcoHb6b/Rm7vLPxm+1Rvp0gB8XsT55x45lFFBN64Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mbr85BBL1wqQqsxp1HeRwA6U2wXFNid8mPrgl1y+DBPAMDpeSE1xIJkSlyoccUHOln8sZhaHnjTkMlNpbMkruFREBtEDDQLlkoIn2ozUpKDOfCfjb8ztGAOagCXhJgrm6SzawduiuLX3nDgI6mXHvF/uDmsfQAPjIOmH+omua8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 1.a.2.1.e.1.9.2.1.e.2.8.f.7.6.5.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:567f:82e1:291e:12a1] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uPLFG-00CPsc-2i;
	Wed, 11 Jun 2025 14:11:58 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	frederic.danis@collabora.com,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ v2 0/3] pbap: use the public DBus connection
Date: Wed, 11 Jun 2025 14:06:12 +0100
Message-ID: <20250611131125.450039-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DBus requests are received by the public DBus connection, because it
registers the relevant bus name.  My previous patches told PBAP to
listen on a private connection, but DBus doesn't let connections share
bus names, so it needs to listen on the public connection instead.

This adds a little more complexity to the logind callbacks, to avoid
unregistering profiles during shutdown.  It also removes an API I
previously added, which is no longer used and would only encourage the
next person to make the same mistake.

While reviewing this change, it became obvious seat-detection should
be merged into the normal driver interface instead.  That change is
likely to add time and could create its own bugs, so this series fixes
the simple bug while we discuss the deeper issue.

Reported-by: Frédéric Danis <frederic.danis@collabora.com>
Closes: https://lore.kernel.org/linux-bluetooth/333ad76e-0aba-4f93-b141-8e69fb47535f@collabora.com/
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
--

Frédéric and Pauli - please let me know if you'd like to be CCed on
the architecture discussion.  Otherwise, I'll assume you're not
interested in that part of the problem.

V1 -> V2 Move instances of "(void)foo" below "int bar"
      (fixes a "mixed declarations and code" error)

Andrew Sayers (3):
      obexd: Pass at_(un)register value to logind callbacks
      pbap: use the public DBus connection
      Revert "obexd: Support creating private system/session bus connections"

 obexd/client/pbap.c       | 28 ++++++++++++++++++++++++----
 obexd/plugins/bluetooth.c |  6 ++++--
 obexd/src/logind.c        | 14 +++++++-------
 obexd/src/logind.h        |  8 ++++----
 obexd/src/main.c          |  8 --------
 obexd/src/obexd.h         |  2 --
 6 files changed, 39 insertions(+), 27 deletions(-)

