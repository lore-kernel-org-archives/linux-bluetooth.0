Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F98370AD2
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188131; cv=none; b=LsSAqXaCbBh90xEwv52Lk2IOETSIlcUm3MGMeUBElkruc8mr3RiKUGBuHLPeCPGkhVrR2Iw8EbNFMTlj1s3Z6fq/QljJjBrbqulo/0uTJZrclhmYI6wbGiJ9QOx3QLp+S8fhYE4GH6t/T+MMYZa3WI8m5m1afVWHBIgwiSKULJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188131; c=relaxed/simple;
	bh=OiFFw0ckwty5Mk4ln/9vDIqH2ZSguHXu6Peue7icyUE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=nFC6q+M+Wt6+ZlQZo746oOQYlB/EQlht+KBknDGF8/jaPORuzGWng+yiDkyNTJb+4rTPeq4zvjT3fZG481IcT0vPhuSt4LzEUR1dJMI28jK+V2obFFNph4pnQMRwLq8rL1gaAukBvBlkNx1HwkLiFkRUu7zDC4aKwK/NPkIYhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oZjcI42B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oZjcI42B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779188124;
	bh=OiFFw0ckwty5Mk4ln/9vDIqH2ZSguHXu6Peue7icyUE=;
	h=From:To:Subject:Date:From;
	b=oZjcI42B2QJVBiH2Q/B86dXgWWgA1xwA1E5593RLg2XMfEwayZvFJrShCx1UW4jZn
	 jRtay72U+GttfGwB1q32I4XJKgvU7hcsYIWNVBnTAKFvTu0xwXg+zOFL3qLs+bvm0n
	 2yc65mKdlTL5j5rGgG8kKw09mbyfXSXpqJxBlF5kH0MorEtZJcBWpTL0YkJIBCS7xa
	 TS0bbquxrX3Q33K9evdPJrH2hPYvffY3kq3AltE3TXQy8o/mwHkwJSmB2SzA4pWIkP
	 J3TF7HM565ny5u4QNxFZizVgEIx8ngG7DrQwsp4THxoIHjzFKJECD/ixfW8//JZ+r/
	 j84FVOOzB8XVA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A2C617E0B87
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:55:24 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] client/btpclient: Add GAP extended advertising support
Date: Tue, 19 May 2026 12:55:16 +0200
Message-ID: <20260519105519.226648-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The BTP_OP_GAP_SET_EXTENDED_ADVERTISING command is used by at least the
BAP/USR/DISC/BV-01-C test.

Since this opcode is defined as 0x21 (33), it does not fit into the
current fixed-size command bitmap. This series refactors the way
btpclient reports supported auto-PTS commands so it can grow the bitmap
dynamically as needed.

The series also switches GAP advertising data handling to the
advertising type definitions already provided by src/shared/ad.h.

Frédéric Danis (3):
  client/btpclient: refactor read-commands bitmap building
  client/btpclient: Replace advertising defines by shared ones
  client/btpclient: Add BTP_OP_GAP_SET_EXTENDED_ADVERTISING support

 client/btpclient/bap.c       |  27 ++++--
 client/btpclient/btpclient.c |  25 +++++
 client/btpclient/btpclient.h |   5 +
 client/btpclient/core.c      |  29 ++++--
 client/btpclient/gap.c       | 171 +++++++++++++++++++++++++----------
 client/btpclient/gatt.c      |  39 +++++---
 src/shared/btp.h             |   7 ++
 7 files changed, 229 insertions(+), 74 deletions(-)

-- 
2.43.0

