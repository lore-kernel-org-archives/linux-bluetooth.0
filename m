Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6B13F44A
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236803; cv=none; b=NNqfGu7yR7ynEMP/xhtnKiMHHviT/6MS/o8569ZPTtEhDp260gu1GJ+Ckk7sGh2Ty3y6S86NUbzKFuf7nFgSSTw774gRHEfhnu81RsUKvsLbOcv4OjI5s1oTXbk1EzIawyQqbWO/WgkkIU/Vc4J5T2kNTZmTn/LGflE4UV8MFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236803; c=relaxed/simple;
	bh=speyKXoHGNbBPQnMrA1kLptWaTzr/oXufu+SvgnPNTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ryHAYbYwL4016cz1kiboDPNrgNSUS13kvf3qcy+x5dzSsqq85EAE0PF3ToFn0Y5jGm3z9Kiqw+ieIXHGfYqBsJZxOQzdUV6Ux5pqWJsYF65PMbmcj0kyZPSosYME5pEMzbD1AYmBdxpr6Gi4H0aKJ2Uehjs9tX5mgSQV+hgfHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMej/b9g; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMej/b9g"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48f49d1e660so582875137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jun 2024 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719236800; x=1719841600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Qsy0AigKZNXAG/Yag9EzW+4o7e0akS0mmoGabRpwI=;
        b=IMej/b9gzdfiBmFGPAhLpry1eM7HZHnb5LZou9KMzEJQzayuLqbCMa0nbLr9NOuJeH
         YzT0DAKdThHbPaZqxg0OGGCM97Rr3Jn9m0GKI8iGeqdJhUbCE14JUxCVp0NIJydpa4cm
         /oHcqSu/zcWepghByIKfiHoRrf010JgB2HPVTHhflwpKu2meJ58EZBN+laCVWCpdVL88
         bAsvraM54toi2F4WJSsLS5jMu7EXyCvNNJKFNWSjMZDPp5uL5fTpXPiPS4tCYcOl0reh
         WrXA8G9dcMhnlDeCECb53lujL5VaXbebC/MdebY2LN7QTCQ1rRftPoGynj8phO/qHboN
         gw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236800; x=1719841600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Qsy0AigKZNXAG/Yag9EzW+4o7e0akS0mmoGabRpwI=;
        b=Vf34z0vperjz7sNxTvBcLsq1f+syacCBI73TsYpggvAzwYo6z036UyCp/HgGDmqCiK
         aJAe/Xh5fErMXei2L3eG20TvnfXh7vEytLpYBwJn2ZphBZxocax4yVVCHbqK8MDwG/Sh
         MmRGyAY9TrTWcL7KMV3miW/kiu8dba25SvlG1+1eM7/xbFCQSNn8bE0yfjm4i2Nv5JvZ
         WEei5VgapZRGKFE7xsx7nFX4cUnrryFQGM79KtRoil5z7YHKL/tjxw/idBsviNvQdK4C
         Dh82UU39DvF77n6jgNCHHJeWHCdwhbarSOfr4hYT7dzewKoG7qdYvm56iU/LZh+rgCph
         PTBA==
X-Gm-Message-State: AOJu0Yx9eyWX9koJalz+uxMjO8WMaxfQ5i9fqCv0q77lViJJ7plQDMME
	mLbcrazq1LoyKVm08lbH2yyABqBtKRTUY8jZVFGApW/GOfIyG8v9APbmhhNk
X-Google-Smtp-Source: AGHT+IH+T2OnzYfMSxXgcQR4ZrjLmTjgpjXqr34v7KZzrqtuE3NQYQ7rEc2wfsAzir3KYPnz1SIX+A==
X-Received: by 2002:a67:ce07:0:b0:48f:583a:72d with SMTP id ada2fe7eead31-48f583a08c9mr2761756137.5.1719236799696;
        Mon, 24 Jun 2024 06:46:39 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80f728caa7bsm1261336241.12.2024.06.24.06.46.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:46:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix deadlock
Date: Mon, 24 Jun 2024 09:46:37 -0400
Message-ID: <20240624134637.3790278-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following deadlock introduced by e3203b177717
("bluetooth/l2cap: sync sock recv cb and release"):

============================================
WARNING: possible recursive locking detected
6.10.0-rc3-g4029dba6b6f1 #6823 Not tainted
--------------------------------------------
kworker/u5:0/35 is trying to acquire lock:
ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_sock_recv_cb+0x44/0x1e0

but task is already holding lock:
ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_get_chan_by_scid+0xaf/0xd0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&chan->lock#2/1);
  lock(&chan->lock#2/1);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/u5:0/35:
 #0: ffff888002b8a940 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
process_one_work+0x750/0x930
 #1: ffff888002c67dd0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
at: process_one_work+0x44e/0x930
 #2: ffff888002ec2510 (&chan->lock#2/1){+.+.}-{3:3}, at:
l2cap_get_chan_by_scid+0xaf/0xd0

To fix the original problem this introduces l2cap_chan_lock at
l2cap_conless_channel to ensure that l2cap_sock_recv_cb is called with
chan->lock held.

Fixes: e3203b177717 ("bluetooth/l2cap: sync sock recv cb and release")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c |  3 +++
 net/bluetooth/l2cap_sock.c | 13 +------------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aed025734d04..c3c26bbb5dda 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6761,6 +6761,8 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
@@ -6777,6 +6779,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	}
 
 drop:
+	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 free_skb:
 	kfree_skb(skb);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 962aa11ce3de..ba437c6f6ee5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1489,18 +1489,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	struct l2cap_pinfo *pi;
 	int err;
 
-	/* To avoid race with sock_release, a chan lock needs to be added here
-	 * to synchronize the sock.
-	 */
-	l2cap_chan_hold(chan);
-	l2cap_chan_lock(chan);
 	sk = chan->data;
-
-	if (!sk) {
-		l2cap_chan_unlock(chan);
-		l2cap_chan_put(chan);
+	if (!sk)
 		return -ENXIO;
-	}
 
 	pi = l2cap_pi(sk);
 	lock_sock(sk);
@@ -1552,8 +1543,6 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
-	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
 
 	return err;
 }
-- 
2.45.2

