Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A7E3B19A
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963856; cv=none; b=UrDW5QQkJC1US/OQIdo1f+BQ3A/6Ix7uxXIsaQ7yhfVBu+Yeh1XMtnDqRY1sDwYfw5Rwoqvpy5hU8iJSIJmRx7UX3S28+0xl8Un//W0DqjtcJDVUNb/c25Egnz03SkH8l2y8O81ITO/+I7EdjFbhvbr7KXSKKRuWHacvsFu6x38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963856; c=relaxed/simple;
	bh=CHYLxcy3ZpvmUrVomCQ79OE2TuoLJBnbWKxBjiwizig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Da6A5KEwa9bkYRpogXjiCEP+D7bGjSIaDPUdtMRzTwfx9OB9fyZCs+N9/tZa7AK4GE0NZMIWyl8SoALvpUqKhDSYy5FuNrteB5XhnQdX73lsGICaSzdxXOJM8ueKEMBuKXEiZTaUy5x6cpULGkzWypFs0uSLOWwfJjaQSQEzaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from c.2.f.1.6.8.1.3.8.c.d.1.f.3.3.d.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:d33f:1dc8:3186:1f2c] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1uMTON-001uWv-2h;
	Tue, 03 Jun 2025 16:17:31 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	pav@iki.fi,
	frederic.danis@collabora.com,
	Andrew Sayers <kernel.org@pileofstuff.org>
Subject: [PATCH BlueZ 0/3] pbap: use the public DBus connection
Date: Tue,  3 Jun 2025 16:13:28 +0100
Message-ID: <20250603151651.1080923-1-kernel.org@pileofstuff.org>
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

Reported-by: Frédéric Danis <frederic.danis@collabora.com>
Closes: https://lore.kernel.org/linux-bluetooth/333ad76e-0aba-4f93-b141-8e69fb47535f@collabora.com/
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---

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

