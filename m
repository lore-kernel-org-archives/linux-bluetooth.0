Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C1245012
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775404068; cv=none; b=X1/ntA085mF78+a77xktkZ9M0UBRM1ZZxfGNLBVxQQWhTmidV69sYPdYtV3yiXBWKTWPaIL5bIHly4xRaZZqEO9BMQtu0IchvjYaCNsnqjmaBRM518FKQPtk1GScmmocIw+KVvym9QKdfDqM/AwfBuLfG9bFDoCAbIWV4qse2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775404068; c=relaxed/simple;
	bh=8hu8ss0uPyZ5rDuH4pMHAXMOHiqmCBMNUALRQExYxAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RPfPkSUWtHW1MkCozgbhqvKqinDCu1mDUHVcfAr5jDDz7VlM16AM5Zm6ITQB6hyWqa/s1pqgxQ32FPD6vCyo6GeBNdR9VXzYiRGJx4CB8YNjjF2J7nPHEi1IHfEE/j2MVUf1oXtGF/8eyclXsbVcM3o74LnyPcQefrziYUwKQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuZIH/mj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuZIH/mj"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so1894786a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Apr 2026 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775404067; x=1776008867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+d5AGm0FNHzJ1D8G3mWc9eFaKMA2FUYEackMAdrldg=;
        b=FuZIH/mjIfTt9BJ/1/bhG/kVndYlbhhM6jeo7bw5nm6e6HcToWREfc9VdzPCHTcis8
         ivAwAA52o6J0fFboGoygz33TK9dxI7d9puV1Z5IaBhRb528qtZVI6W28gjFpYYQAHMd+
         ju31ElxQw0OJhjuTnQAHKnhm3+cUQ/XcT8Z4SWRsxDDBKbl0di57lvk3egSk+uqsQwwM
         NUwcrUGqdPQrb4npCDtJZsENbWnjT29YM4fnN2vNYuXAKn1NP0zDJCr6X7vXL4vhHnff
         zWZh2UUU5Nql1/C5yPun/WcAseJZRh6evx0Hv/pa9ZKgt0KMRZ6j1qnL4XXArQoFzxvo
         ylLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775404067; x=1776008867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+d5AGm0FNHzJ1D8G3mWc9eFaKMA2FUYEackMAdrldg=;
        b=De2vVTpnYoM9t1FtABAvTNA75zzEKjLJGqZUlggPbKwCPtYyOswzp2myr9vTsvoRGU
         WFn2/pP4EsXQicrTQObDTKbt9jRwF6YeUdi5bpeuUesPA5mJ0mKqNQgr2E4Fsz5Tq4Sx
         y11Ock2ctGgCIyTlkcM75981Jw2FDcg9OHpGiNo1reeY9Yz6hGxEy8MC8IWrPUf61HSQ
         wl088rLw8dGSxqAJpx9+fpxKU+PrveKCvR5APeHA+wLb0j8J45z3MUqUhb7t3eTPy0F0
         gYT3WdsfPm5FaZ1TNCExcIK3aFWT5iqgZnmaenOb1psTSPKdD4nNtRY7Rdnq7AwBNaYb
         op2Q==
X-Gm-Message-State: AOJu0YyO+HDDYnzIMLvIGwT8PwRR2f1Tt3e4tlqLrYzhrxvgumNsVXej
	o0/kdn+YqUDf7TMCb2aEYtySjSFRcEvyMN/L12dB4ubiv9EtD7UBrXYsWQF0c/oZpEU=
X-Gm-Gg: AeBDieuTbEwJgrUBEchNF3lamsYgmej/mHK0VT3H7GSQlirWSa0MFH86PEyjdSQTZ5w
	cHggvVs4FxaHaDDxAc+nUVIv6sDXZwC+zZKBdZk0iFf6TXoG7577SMnC1ecV+CZ7vQJUiTO2f4r
	HBzUN4QDmkunW09SEfQEor6uBHAsb63ZqwA5OCaxAo93vcnZ0S8pk5oYuWt2z/9FYLu0RiNKCKZ
	xifkpUe4YGnyydqWjvWg1phJrOo25CBXWbRZJJQIEM6qTTd5syxgJWt6OfYfR+gvuqejLfmnrWU
	jby/Szccmr1eiarI14rF6nB/1JQkRjcTrgzejyEzw+yNQev0UG729o+s+/skQCklAbhXcQW1wcd
	yYjxcrfWqTwo63mJF3s8YCkfgYoXpdEfYKR//+V3NyODyP4v1mfBA8cFvwI5OOttVOuiv8tUkx3
	6xZH3sjs3SheFnBFBrCI/TReTzGsi3
X-Received: by 2002:a17:903:37ce:b0:2b0:60db:7927 with SMTP id d9443c01a7336-2b28178a2e2mr100213865ad.28.1775404066945;
        Sun, 05 Apr 2026 08:47:46 -0700 (PDT)
Received: from gmail.com ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm144042795ad.27.2026.04.05.08.47.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Apr 2026 08:47:46 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
Date: Sun,  5 Apr 2026 23:47:41 +0800
Message-Id: <20260405154741.7051-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_ecred_reconf_rsp() calls l2cap_chan_del() without holding
l2cap_chan_lock(). Every other l2cap_chan_del() caller in the file
acquires the lock first. A remote BLE device can send a crafted
L2CAP ECRED reconfiguration response to corrupt the channel list
while another thread is iterating it.

Add l2cap_chan_hold() and l2cap_chan_lock() before l2cap_chan_del(),
and l2cap_chan_unlock() and l2cap_chan_put() after, matching the
pattern used in l2cap_ecred_conn_rsp() and l2cap_conn_del().

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add L2CAP_ECRED_RECONF support")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..82989c1319c4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5473,7 +5473,13 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 		if (chan->ident != cmd->ident)
 			continue;
 
+		l2cap_chan_hold(chan);
+		l2cap_chan_lock(chan);
+
 		l2cap_chan_del(chan, ECONNRESET);
+
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
 	}
 
 	return 0;
-- 
2.53.0

