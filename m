Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD02737EB
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183720; cv=none; b=iskDuLviPSvdiNnsgZ9R/OP3j6pMtEE4IRhLn0dBEoFGFZ+x7pkiF+Bn9jfbG7vLu8qiH/LO6h86uMVLIzhYZE2rYAaz0g4+0HbdYm//zrvkkV+7EifZ1ZlDB7tgxOvOOn1pkR4vyXZvrqCsjVTWXmGm7rB0j2Bbxs3quHuLcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183720; c=relaxed/simple;
	bh=5BlhcsTDh6rMgSyWd7vPvs1GR0ITmrEksX9yVPM7pD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1uiI33xU2cL5B9+Oa6h6ik9dp0fjTTrE3QtIsfMQLeEefbOTzDY27VcxFqvJegjtWqZ/1uOpZVslj2kEZ+jo6r95GarX2y/JRh861c0McwUPTb6Mk+U8I3TAHjuE8uHWbQhhp5X53sFFAJElJDlsuIaQNOcuRhshFx58tx8AeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch/eEjl0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch/eEjl0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82cf636dac8so690317b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 19:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775183718; x=1775788518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BL6izkFKiyu7pzRUtEH6dOuIFCaKg16fDgnoCHQq+J8=;
        b=Ch/eEjl0Hm/wV2b3ZNF0ZDU8zSKmazY3+8jV8jFnWC2KuyrA+Cy8KQhYcY5vTLbiRs
         i7ff92Gn3CnMuObfmAszmB1S2ag7aHYDfO7gcBvVMpIYR9ecwStXylTygsgZhFUJ8Qvw
         mhOpjE73D/zpcpQVoF5gRUPv+2Oh0SvPgXcn8L+jUkMUNxwSAxFmmY7Uh1yheqjKmLGP
         ekIEIX/+L8dATbMry+uxGyDZor6X+Dj9ekYZNDrUCBGk6phuDa98FL3HQwBU3i6hu9Kd
         qwPBAq84lDhPleg5m3n/07FZ9BOCPP94t9UhYLVqrvBf0urGwOW3E+dZEfeo/OPlFIvQ
         P/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183718; x=1775788518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL6izkFKiyu7pzRUtEH6dOuIFCaKg16fDgnoCHQq+J8=;
        b=R/Sb52GWVTsiCgrU5kRYwDEyB+JsudhsqZCahXv5ZOGLtb0ynJXFSWEcwW/HzGR4F9
         G1aCx1DMRfjFFDUMnwLTl6Jiqjn1VJieko7uJxstM9guUk61KBD7TQv6wVZLfrYtyxFJ
         mK2L1ouPQC3knWpzmGFG9ERlQ1wkkN0UXRyzEeRo7BCeZ7ZpYJOVwrqD+wDJPdn4kMMj
         QIkhpmvH12XxQ1pFAk/GRf1X8wIUsZcDDGwGDxfLlLqXnU0ixAEk5cj9ioefWBzyUgDP
         DlP46ZA8TiDRegxI8MKVUl2MqY3UruHhhzVc+jkAuE02v4Po//F8RN/+M7UTelR4L48J
         BpIA==
X-Gm-Message-State: AOJu0YwzZuADGyuEkCm4RTYFyEmbW25Erobf/IRs4+EAsIQLbR0jADDQ
	TdBDslASFc00YQgDiKaq8iMPbGwpsTKLT9aZIZNM0iyUXhWXMlWlsUiw0PS5DBdu8Ow=
X-Gm-Gg: ATEYQzwicC/PisQWYXVR2xcU3VmTo0/6p1f3JNH7PcHCPiT84otfq1Kd1StYaeiH8EA
	MnbIcqbO9vg4MfGWwS6F3WzL6DEuz0hgN+Fc1XJy+Bet24p1L5oEeQ9WpdQeCLkuhZRop1UarXp
	d6GdVihf3MltiwDjRQ+65Eajffr/nRcVz+etFgFEuXimLNXgd1YuWamIGQKCaEl4tzWyjjZHk4y
	nihln64ucWvDy03Pdln0mCuaUMaDLdwQbLgJy+WyST9BKhX+fI47g+IV4ftvuBgFKo8IwCyU0cA
	rh4cR3cFWh+3wIqvFZEUGr8sMadzlSoNUo+mrPOEp2PVtJBOGeXw6eXAKLfjU7lAHFlfwQvc/Ac
	CJpz2PvrdhfLNkMKQiMkDS70MreuC324wB/G4g8VmsjUMhjH7g/BqMmUOoIQjGCgMOtxYgLhNK3
	lzuSkdHgaTLlPAa7i2/5zCSXxUmnDcUd5ptZjVzQr200e169Ho/WcuKoUz36I=
X-Received: by 2002:a05:6a00:92a5:b0:82c:e1a0:3445 with SMTP id d2e1a72fcca58-82d0db72612mr1376030b3a.27.1775183718390;
        Thu, 02 Apr 2026 19:35:18 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261b6sm5269657b3a.3.2026.04.02.19.35.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:35:17 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp
Date: Fri,  3 Apr 2026 10:35:13 +0800
Message-Id: <20260403023513.25151-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_ecred_reconf_rsp() calls l2cap_chan_del() without first acquiring
the channel lock or holding a reference on the channel. All other call
sites of l2cap_chan_del() in l2cap_core.c (e.g., l2cap_disconnect_req,
l2cap_ecred_conn_rsp) properly hold the channel lock and a reference.

Without the lock, concurrent operations on the same channel can lead to
list corruption or use-after-free. Fix by adding l2cap_chan_hold +
l2cap_chan_lock before the deletion and the corresponding unlock + put
after, matching the established pattern.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add L2CAP_ECRED_RECONF support")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/bluetooth/l2cap_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index XXXXXXX..XXXXXXX 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5472,7 +5472,15 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 		if (chan->ident != cmd->ident)
 			continue;

-		l2cap_chan_del(chan, ECONNRESET);
+		l2cap_chan_hold(chan);
+		l2cap_chan_lock(chan);
+
+		l2cap_chan_del(chan, ECONNRESET);
+
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
 	}

 	return 0;
