Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E55377031
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073832; cv=none; b=Cm82GCBDM8WUd6+aB3NVIimooRB5L5Fmkk+iBObJn7AfUXor84GJmsOf+LgPTL+SxLqkKUMfy3S/xFYjMeWFSVC8ZLw18kSu5r6jH1gOaIaJ66zAWL0c7L132XMQqtE7QeNmDaobcVRnsajnP9s8WlLxu2sT4NpRyVjbntT3pZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073832; c=relaxed/simple;
	bh=P8MXJH4jiVdlq4ROMB77XBf0uWf6NqtO0PAQ74FlQZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAAGbjcPfuVig/CUwRnONHqs9xG4xWS7PrzASbyZLBp9oJNHfGKWGFNmuze0BNjxg9O4QY0yuK2rC6F+2Q0KICXBwyzNuOYmjhFWBWqiABGOAXc+N3AEscHIj6zSrnt+3UbXrrkXkrtnZ8XYvuQy9Q12y/fqn3OlihDHekPaHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAYjCGao; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAYjCGao"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c85825bbc4fso3875448a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781073830; x=1781678630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+1LSkSiRz8zCBnMMY+UJOT/B2iSGc2AMMXb8SeE7pw=;
        b=QAYjCGaoo2Q+TuNvwecKcbUZ6BgV3uoOOTh8ODdY4LONGL2SneJZyjFOcGHCldOudJ
         X4hWsV4/IPEcReIuEmBkNphQ6aXpc4zJ/YNz2GX1rGDdb6QWoBWwPvjFbWXSnlBVakq2
         TEM3ZwV3gvULw5Hrsx1BLN9wGv/oC2Pw4Umq+LfnjF5n+1n61w+hAznMZgfJzTBp75A3
         ypzZH8W2Kd0rOCLQVvyajRcT2mDKmy21v//qoUMfVWShPa/GFo5adKvI7JYo81FDLecu
         AWPA/02UcvHo3cAtO67Ivub12TigxkB72Xoch+AI5R1UbzVzWDE8as+K9jhwCbd1HX1O
         I36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781073830; x=1781678630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+1LSkSiRz8zCBnMMY+UJOT/B2iSGc2AMMXb8SeE7pw=;
        b=qcFQioW6YzC2fB5BMLD6PvYDDdZ6YY2HSVPnoSrQWDdSeGLsrHR2PAiQ6iSpWO2rEQ
         /dKytfL/Ult16tHFb8cUiena4uXY6aY1hNtGIZWlqx55F5/Rz53x6uskvantjwzyawn9
         Ln9wdIDOVmQb8QtWyTwxmJKoke+nprk7bK8IAnth89WnX6jhJlUHrJaZNUe3wv+Hl5Or
         ZxqznpkAh45r2FzdSBJ0CehYzrxadhwxp7Z99h25I1cJUx1qZXblqN+0bfmGClnlsBj5
         /tccfveQzMpCkZE68PkauqTrmXKsPb/tbsC6NfduzZvJGq73SpKnFJ/XJZn7F+sVLsGW
         pb+Q==
X-Forwarded-Encrypted: i=1; AFNElJ//jijD8VIGUMCMmkv93x8AE1c91co9i8+BOvv/vwaboxwA45b0nJ0I2dXHS5CEBQPNcjsFa4VCeCyknPexrsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++mydbNowvDH6ItTY654QT2EH//+N1rYURWcYPydfRm6Uphxq
	50qcNiiFm7cJ1q8zMm+pSDQkXChNQrAoajus2izvS5drpYZo7LurG7UIMzkIEhVeg11w9g==
X-Gm-Gg: Acq92OFJfrmMqfC5Lur/sBGH8LHmL/jc3sr8lIeQvsmUNRvEKDKmf7K6eIujJZU9iuL
	fFP9+v5FM5AumPZQcsu6R+YOY+SucKAyTvFPilUID8deA0l9Q/OHu4DAL4kZV1tdzJZTMmoydob
	Ho1e8HPzLPfHEGRTvbK18lAdDvYSaRAbnWcJHy32N9oDzS/uGwwEMlJ0ztchHdMHNnRa6wZkIyn
	7q8Ryds/1Z4oppZ3aqmd83B4crsJ2B+rvmItvf5fXkLGR+RUptMjJIRGqPV99aYSPFvwGeofyTN
	DwCoR6iVddUmAGl+jlf3ckldZTi3Le7o0wdAxTQj0OAMTfbLfyrRSU2sT0Mj5xMJksOtGh/GLnS
	XpYSHIY2aO+sUH+TuXOVeGJFCXbp44AeDSoqb3jqh3x8ZOKIMaUpBI/VdTYLX2uE1fTVPacD61k
	eXv3CGXm/2TwfQWQkjLYfmRU/vOris6gBi3xGGWq+vY+pzMgq67Q5UGvwNnOKNeZXogvCTk7UFN
	qN1Da1xne00E2EY10HgjlVjeQ==
X-Received: by 2002:a17:903:2342:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c1e7898d9cmr245728775ad.0.1781073830129;
        Tue, 09 Jun 2026 23:43:50 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d389sm225331355ad.16.2026.06.09.23.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:43:49 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: SCO: Fix use-after-free in sco_conn_ready() connect path
Date: Wed, 10 Jun 2026 15:43:09 +0900
Message-ID: <20260610064309.591113-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn_ready() reads conn->sk without holding the connection lock or
taking a socket reference. A concurrent close() can detach and free that
socket before sco_conn_ready() calls lock_sock(sk), resulting in a
use-after-free.

Fix this by taking the connection lock and using sco_sock_hold() to read
conn->sk with a reference held before calling lock_sock(). Drop the
reference with sock_put() after releasing the socket lock.

Race:

  CPU0 (hci_rx_work)                 CPU1 (userspace close)
  ============================       ==========================
  sco_conn_ready(conn):
    sk = conn->sk
                                     close(sco_fd)
                                       sco_sock_release()
                                         sco_sock_close()
                                           __sco_sock_close()
                                             sco_chan_del()
                                               conn->sk = NULL
                                         sock_orphan()
                                         sco_sock_kill()
                                           sock_put(sk) -> frees sk
    lock_sock(sk)
    // UAF: sk may already be freed

Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
 net/bluetooth/sco.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 6383db54657..c2c4b5a5b82 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1306,16 +1306,21 @@ static int sco_sock_release(struct socket *sock)
 static void sco_conn_ready(struct sco_conn *conn)
 {
 	struct sock *parent;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 
 	BT_DBG("conn %p", conn);
 
+	sco_conn_lock(conn);
+	sk = sco_sock_hold(conn);
+	sco_conn_unlock(conn);
+
 	if (sk) {
 		lock_sock(sk);
 		sco_sock_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
 		sk->sk_state_change(sk);
 		release_sock(sk);
+		sock_put(sk);
 	} else {
 		sco_conn_lock(conn);
 
-- 
2.48.1
