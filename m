Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F723A985
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806240; cv=none; b=prOXVC/o1+FA9KCOBh7dv7K/OjTcfsRscu2MmVr/t+jGiYPQgHFOBOMHJfesbtzy/1BlbzgEMinV5XnYL0bmctMbG1lr4Bi8UzNAiM0iEHK4hFMLmtOB7W83q0riEiqaTt6H1pZ/x+WPndGFOm4E4u7rw3jzFBDoo0p5GsGuxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806240; c=relaxed/simple;
	bh=3mVFxY8YtPAHbm/21bl6KuwozP+8bKi9gMHzUMF2vwc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=at1veYXItwiYueyVWcYuUxzY8xeStpNDhmYAhq3C7pz1LRFeVCDawS1Yrsh6poG2VVT2Z2R5J4MX6SlNh/FFzAPtr+W0iyWhIVptbNTmhuT7ZPAwNTV+qiGD2h0UzV9YWGoWotguBfXIpunP0vTfiIfoLAgbcNSmHkII0bHxaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bansqUZ0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bansqUZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744806236;
	bh=3mVFxY8YtPAHbm/21bl6KuwozP+8bKi9gMHzUMF2vwc=;
	h=From:To:Subject:Date:From;
	b=bansqUZ0O0c6icakvmvL95xHZ0SIqdP1uNyv/l6+t6IIjdHhYBl0ocJiHs0PmOzHe
	 9YvuprgQVzZqtrWVevWftGrPbDegQVOGua3yfSkQmzejkfs7GLy72dJmDKQCkfFvmR
	 P6HKFklunzf112LjiWl7+BqCeZixSprqi+bVneoFc7E8QS9XpiIG+6u/Jzbt1qVOkM
	 1jlkZKWAznOAV9/cVL4DlnfmeqrlKOD4pT85tCXj7zDHXuCXyN/2UqfRV+Pe0qdXg8
	 WuZ1/2/8tMTnub0+c7IAdKBKkblj3GEASmcz64G5+7xmrVzNj57zm0K80Hcq0GPDWk
	 3bjXPt5oEu88A==
Received: from fdanis-XPS-13-9370.. (2a02-8428-Af44-1001-b876-6480-8eaf-Acd0.rev.sfr.net [IPv6:2a02:8428:af44:1001:b876:6480:8eaf:acd0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3853117E05EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 14:23:56 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: l2cap: Fix double free of 'skb'
Date: Wed, 16 Apr 2025 14:23:51 +0200
Message-ID: <20250416122351.213894-1-frederic.danis@collabora.com>
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

Commit ad5747d4eed1 ("Bluetooth: l2cap: Process valid commands in too
long frame") from Apr 14, 2025 (linux-next), leads to the following
Smatch static checker warning:

	net/bluetooth/l2cap_core.c:7613 l2cap_recv_acldata()
	error: double free of 'skb' (line 7557)

l2cap_recv_frame() consumes the skb.

Fixes: ad5747d4eed1 ("Bluetooth: l2cap: Process valid commands in too long frame")
Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1bba7152fd70..5ca7ac43c58d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7556,7 +7556,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			skb->len = len;
 			l2cap_recv_frame(conn, skb);
 			l2cap_conn_unreliable(conn, ECOMM);
-			goto drop;
+			goto unlock;
 		}
 
 		/* Append fragment into frame (with header) */
-- 
2.43.0

