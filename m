Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711414C14F8
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005157; cv=none; b=ccoVf3ybyTWSvsw/HMIV9A1MV678KlMRHNcSq89AoPZSoI7/g6Kfwhk55aM77QHQ1GncMyaTAPAoCkZBFjZYXUrbTruBhguWrVjNdY2uuQ+Ubq0a19+ldiCLIHE5nXHxnvEvfLRyQ7bBSLhhl2+L3DbT9kDb6G22xawAJ5rIPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005157; c=relaxed/simple;
	bh=GJDLDKF1u5CPMp4Uv16UsWMnehm7Urz6TVe/2jIm/eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tGdWP6eF+UQJZX8X4dR1vj6dKUY5x5zy4AZwPOMR8JPDCQqL1K9uySYfemX2XDAvuQQW44rC8kzPUxTRsl0Zid4NJLvXNTpBF93tSR6+fr5AyrNb+3etjsisKgV2uAw/YAYLwP/r4bJjGPRQ0S6SoBdM9K0n32TVKYii3EBRrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeaK/cHY; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeaK/cHY"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a0so3483380b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790005156; x=1790609956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1X79HRIHH4he9wBEHQfrVBFJwF+UUIpDljtJ3hHJkuQ=;
        b=HeaK/cHYu3aIk8htG6QpSieWavPUbbG3LfBmZ/sda9d0iGkVoWqO+9IPaxIMNjxBxh
         jbySz9Oa/ojvkLe68+m7a187lBdctzW+fSdDdwbwZNAYuB1IzCjMGXOx1CRuPUsvJY8H
         SXDRQFyZGKI7IuMPCEygnzcj2LGBAyDpHN/EbjSE0aEFQwGepifzNTso4An44RCmgSGY
         hbcPj8WLsDU3oBR9mp4KVsBW7hHdvWokjX+6kC5ZPiKlekABTecICf9RftwHx1dCr9Zx
         ge3VohAMbl7+0+JsoBcfgkEqdxOvSbeb6BoAaZ3jQ92NqXwVEfJYVGxnuq3sI7OIcX8u
         gqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005156; x=1790609956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1X79HRIHH4he9wBEHQfrVBFJwF+UUIpDljtJ3hHJkuQ=;
        b=c4ZRm6eTKZSkMw6KEbkAF2p+nMg6fcsCMZsLOKOInhFCEzYv+VflSEQ1bJCX+KcExo
         BzhCO1DpLYpwHyYwMS5BfJmrgt7VnvWgedDop4AiBd6JBtaMWerNmfltLhese+27KCd/
         42hUSak1jpuf9+r9keGHeEgrVSIzLqMc1zaxevV0vDaPbLwr2Ez973fTFjmYx0OGyCPk
         a7+kJ/khBiH6Km8GGJVHR8A/6sEonSV66VyxospzIeiPSoqLzG7K6PGU/IH5OAOIlZ4s
         lOjbvCiz+fUCjVQBhcN0klcnbWfyn4XEBw8IHaQwVUofOjdYnaLT3tZdOPf5O5vXj+I1
         V4IQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvrJ+EYaR+A1KkjI6lSH+RaEyhsIaZkz2QuYeG02w9Tl79by4S7yboRrhcpoSNV+77z+VNZgiWLYT3JZscXqk=@vger.kernel.org
X-Gm-Message-State: AFuF++nN3wcoFSPJjUHk04J4/9pnuiOJ4QfxT3ycXEnR/7ZuHhAXqtQh
	O3wL660S8609OhEtmvC1h1l72AOZCYh5ZArVFk46DRTe29NZZ5vPoi7Y
X-Gm-Gg: AYBFou2ximk8+qDPRphCbqEdeE00txXrEf4cxBhdarXE6wf/zUrTgzvj8OLfdzi4zUB
	fgG5vs2oBjAg/CNDg3l4L9GKbpff1ccLiDqSBqNj0HCHYa5XheZh1TBCdf9wI18jW6YAI30tv7/
	efVffYDn9qAYIoFm8MGjkgcXYODfbpE8puD0IiUyJeUVKp64dpBUJUNQMlMGSDSbZMPwz1FIjLi
	b0gtlekcyl0oda2QzhL23cAClu9ybi11gQYDe3kwHu1vr6UaQVy456p1FK4ct/1xaaR4vPq5M+t
	UalqrwsXluaxS+aOwGTWRunypTh1KVqxHQ7JV7MJU2fxEHIgdCM90I1/fSeEXpvlj8Fp71C4f2K
	FNfBgJUwQXuTc+1MIUR6akpOzGJRSYWpFLRxfIXiQ/OctvMBnG19aCMUt4+cB8Bse8N/58w0R3v
	fR7GyRbKq6YmjQVFkvD13WGEuO9vOYid5073+llDo52Yf0Jtyt4zDhs6dLwRJYY9xjnA==
X-Received: by 2002:a05:6a00:2d26:b0:857:72f8:dc98 with SMTP id d2e1a72fcca58-874dddfe1ffmr15944015b3a.25.1790005155685;
        Mon, 21 Sep 2026 08:39:15 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm3448186b3a.2.2026.09.21.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:39:15 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marco Elver <elver@google.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/5] Bluetooth: L2CAP: ignore close requests for deleted channels
Date: Mon, 21 Sep 2026 23:38:58 +0800
Message-Id: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_del() keeps chan->conn alive until channel destruction and
marks removal with FLAG_DEL, but does not necessarily change the state.
A caller retaining a temporary reference can therefore enter
l2cap_chan_close_unlocked() after deletion and follow a stale connected
state, rearming the channel timer and sending another disconnection
request for a channel no longer on the connection list.

Check FLAG_DEL after taking the channel and connection locks so that
concurrent deletion is serialized with the decision to close. Return
without further timer or signaling work when the channel is deleted.

Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 49a998804908..65e957fdc7ae 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -939,8 +939,10 @@ void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
 
 	have_conn = l2cap_chan_lock_conn(chan);
 
-	/* Context analysis: consider chan->conn->lock held also if conn NULL */
-	context_unsafe(__l2cap_chan_close(chan, reason));
+	if (!test_bit(FLAG_DEL, &chan->flags)) {
+		/* Consider chan->conn->lock held also if conn NULL */
+		context_unsafe(__l2cap_chan_close(chan, reason));
+	}
 
 	l2cap_chan_unlock_conn(chan, have_conn);
 }

base-commit: 019debf20bfd648b40ba10377ee0168db5eb241e
-- 
2.43.0

