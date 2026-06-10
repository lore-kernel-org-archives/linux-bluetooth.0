Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50222E92B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071795; cv=none; b=WYsps5HH2/mvSy/5CPdCfsyVlWEMBJj94JjjKIBumGsO/il3mbhfOVOdv/5lg3g77JJnswNcdQaH7N60pngGrd6uvKlsA1pOd/iVvQi5H4S7z10mK+Tf2PmVl97qo+rPQeBOa0FMG68gSqsXiyE/2M+uVwnNLjyus8TOeoR/Qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071795; c=relaxed/simple;
	bh=hm17FVhrNkd50jtx4zxZ0zdVZm6S96HMCooYJmqcb6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpgB+zbajDJMTH1zRjFeGftwYQ5F9qqgOuH6SMEleMXKp4S0es8y5Ywtnr/hpPmOCFI1KQNp3+wLSUNWoEjGNrt3axCa1PzEsXoe+EUHY9TOVxgQG393m/N5QMSylqaziKiRxS0iKvCJBFUBp6T/InHziFm9jmNbj3snjwqbbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCgnsWbi; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCgnsWbi"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so4178664a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071794; x=1781676594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpPRyVzsUeUftUh1G+WRy0d3kh62QxoKi7h/TqK3Xzk=;
        b=HCgnsWbiUTFcFPsnLiOqPhN5AMv9DHe1wWQQDin7YU2QmXpyWMgj30aric9ixrd/82
         loQIiL0d98uINuyLJeaIcWi+kacONmx2TVGQOq05F+WQ3jEW+E1xnWkQD6Wa3trJpWny
         9O2zldPiB9+9QEL4/G5Whw5zMBvos3GsBrgp74bo9WxoNIHgadcQFT17w2uwaM0+SdeM
         CL2b5zUJUFIpH/5AUFXHhUcL6ssJev9/UmciTqMbw2BK/qMiW8cZikiMjKHl2lmcTxAD
         GxxW8Gj0dFkMvIJPOvB6gqAmAT2+i2XLQ6iK8DeynsJXzqWYDWHRZq4CKCM/Ev7ORlFt
         N8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071794; x=1781676594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpPRyVzsUeUftUh1G+WRy0d3kh62QxoKi7h/TqK3Xzk=;
        b=XzJh6ogGOsyJPfZF/kZAepdaHdsQXYW4CqBG0XaKffJAo7B8aSUCxBvCXwpuV0I4ic
         Kf9Jol+rbDvM01PwDkCtdxoYok4Yn05ydJZGSsY2wbaWs3pnR3zTA+ecO18lt35+vqDj
         i7kEszjjijacnrIvl+yrZAswgRvhLoBf9lbx6llkjJCwl02w4MMKEPAHlN3vwz4d79EN
         VtgM5TkAEtN0/KQszp6b+WQc+hRatOh1X8GgsTACuoJ54rXMP6HU0mSUmz2RWgb4JIgn
         sbAdfTopZl9qBZ8aAh1S3rZmAIlx1fIoOoT3DNqK3KS9RM8rhO6mqJ+C8XhwpoWYJ3gy
         klEA==
X-Forwarded-Encrypted: i=1; AFNElJ9LPxDq2m0Zs4Oawj5E8kTBk8psVe3V+HAkyw4C5q8VAONytPZt/rk6zHiHL+YcbLUAaZIoUuife9SmYBBSxj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPnAHTrn4o5SJuNzpqAU87UNdTKbOAcUZF1Q1uvAWuMiPpviyW
	7JB5FcBjCFdB4OuPXM7ARIdhDCwb7oK4DIQipSFs5RQkwsVV29EV4J2L
X-Gm-Gg: Acq92OHRKdRuarn3V53IB6rLTPRaRQ31AlOkH/gkFmJUu+4qNujS5HeRRQdpxDekfgO
	xG1gbUoHioLCTqoBtieCDl2PS1mCYtHiG64zRuGBtLv8l+crrdxFqpmiIyZPKr5Pee13CPeei5C
	QCmdSlLzgRnVD4O5GTZeO5iIvs3JqdLwuSqiL7yURdsWZPdddf6CdvVcdPSB80K4+BT7HlxJmpL
	YCpUWHaAPrUu/V4NZqfIkvb52Zb7TbpieV0TGTktP/BBX5c5SsGhPi8AeZAqD2Hof6Yn/SElEtI
	lNDdx89KFcuwI2TgptCixICx2hWk/2ziTL6QXiV1M43Eo8M6ajdoKhStxpjHXQNxF7nNb6AQ50T
	eCcmMmegICLmau+iAau3UMKgnoSSkEMyFA6TjONcbqFePErmCSIKYxggNct6hUNuqy6F7wS/0fo
	xIr6rBPg8vmIxd6XBilQ55xvDGv2Gt+m0BAg09+nB0OEwE+bwmfyibsQmHdN58xL0z9uEgM2dWr
	1nBqYx/Pzoe3u3FYzuktXpQow==
X-Received: by 2002:a17:90b:3d8f:b0:36d:70c8:3a3 with SMTP id 98e67ed59e1d1-370f0772dc6mr24687384a91.15.1781071793905;
        Tue, 09 Jun 2026 23:09:53 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37625ecfed4sm787508a91.0.2026.06.09.23.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:09:52 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: SCO: Fix use-after-free on listening socket in sco_conn_ready()
Date: Wed, 10 Jun 2026 15:08:24 +0900
Message-ID: <20260610060824.552957-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn_ready() calls sco_get_sock_listen() which returns a raw
pointer to a listening socket without taking a reference. After
releasing sco_sk_list.lock, a concurrent close() of the listening socket
can free it between the list lookup return and lock_sock(parent),
resulting in a use-after-free.

Fix by taking a reference with sock_hold() inside sco_get_sock_listen()
while the list lock is still held, and dropping it with sock_put() in
sco_conn_ready() after release_sock().

Race:

  CPU0 (HCI event workqueue)         CPU1 (userspace)
  ============================       ==========================
  sco_conn_ready():
    parent = sco_get_sock_listen()
      // returns parent without a reference
                                     close(listen_fd):
                                       sco_sock_release()
                                         sco_sock_kill()
                                           sock_put(parent) -> frees parent
    lock_sock(parent)
    // UAF: parent may already be freed

Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
Changes in v2:
 - Move sock_hold() from sco_conn_ready() into sco_get_sock_listen() so
   the reference is taken while sco_sk_list.lock is still held.
 - Drop the verbose reproduction/KASAN text, personal note, and unverified
   Fixes tag from the commit message.
 - Fix whitespace damage.

 net/bluetooth/sco.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 6383db54657..20518bbc93a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -410,6 +410,11 @@ static struct sock *sco_get_sock_listen(bdaddr_t *src)
 			sk1 = sk;
 	}
 
+	if (sk)
+		sock_hold(sk);
+	else if (sk1)
+		sock_hold(sk1);
+
 	read_unlock(&sco_sk_list.lock);
 
 	return sk ? sk : sk1;
@@ -1336,6 +1341,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 				    BTPROTO_SCO, GFP_ATOMIC, 0);
 		if (!sk) {
 			release_sock(parent);
+			sock_put(parent);
 			sco_conn_unlock(conn);
 			return;
 		}
@@ -1357,6 +1363,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		parent->sk_data_ready(parent);
 
 		release_sock(parent);
+		sock_put(parent);
 
 		sco_conn_unlock(conn);
 	}
