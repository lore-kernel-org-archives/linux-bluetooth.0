Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0AC40D598;
	Tue, 14 Jul 2026 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018483; cv=pass; b=jD5x8vpOzg8ceT2S2dRvpAikOqtY0G5urOxxzxjd+IQtKKQNGCrSF4xn3nlxwF84DlJ5r8gtZqcoCd2Rf74o6IjYYJqqj30Vtriy0qdqaGC5bBVWbxtTPUsGsnsatnmGmpxVcC0+7+g9tbdjusoueeLZBkRE2G49pt3+FnHcg+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018483; c=relaxed/simple;
	bh=RxU+HTMT4e7gqntzch9vJgiaNm5ZGZt+PRgQScwOTos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsOAma+hHmd+SP8n+q1deSdM0EBafCSKXdhyH+0btHBCvapUrSdd/SoZndE28ZXg3mdg/RAew7Awz3/hfKEjMP8HI8AfiRHwQHBCUnLFa6iKO5TNQVbtfSs2uIawOisEoaHaPoJmAK6S29wyVT1QbLLIjqoob7UXyVYQcH8sNYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=PS0I4NIF; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="PS0I4NIF"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gzt7P2Nbmz49Q7r;
	Tue, 14 Jul 2026 11:41:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784018465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmcNuCzruBf46D7jtK0IDQXcz3yC7dwreqOBRSsfTAs=;
	b=PS0I4NIFk+kXN1BgJaJj6kvJrPa8P55EeBLwwdgIkUQKcltE+LxgFw8b/uf06YyIZs3VJT
	DWMkRrjP5KOs5mMvy0L977o/GIk/tzcRZq3VXvDwRubuSpXdvDg/7oBzy9HWqvHT20+RPD
	Qkol+IyB1JMQxGmnUggqX23hiOA9qKXInMiMgTs/vitS7BogYdbzBn4y99BPD5Dwh1tJwv
	nT1d9govN7cvvTr63Dz+0cRH9jUwX5ngZ1cply7Eis49NoDS1NuF0wZcV2wDug4fOHzj3P
	E5It5cjfR0zAyWGH5mjEK8mkB/5qmxypWpq4R4gM3rjWNhjbNsdCiRXhp0P7RQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784018465;
	b=s2RxHCpEp/DUVv0EWIoSRQpb0gvsyUpuVl0OjUDA+71M6BJytsq1VvV8e3lcw4Z45dlhUd
	fbaGYaE1viNjNNJJpnu8hxHXgyoIK80Lt41agLTkoH+yT8/xGBx2S2gqMh6S6RKyxYMiy1
	kPSy4e3aKu6CYn+fYG8x88r2ko4apyLW2gCIUIECv62XBHuTgrS6rhxS3/ocACErCasc6Y
	Ntt2rUOoivIXdK3dNZ0NBxF/qmoVHxIjlaUr1f96wbHUhWn0Al/CR7P1ND91/Ypz6HfqBT
	rO5MNU93WU2f5vC8/7iKKb3UU1N+vTKRH+TZdODGVBbLHEG1nhH4URoQFaR3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784018465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmcNuCzruBf46D7jtK0IDQXcz3yC7dwreqOBRSsfTAs=;
	b=X0/GtUU/BaCZqgTSIa+YqOzcX38iysbEEmz08gRgGGMqViAO8qZvu2TvkXtfN0jeGbqxOd
	WKFI5vx4+HMWrBta2E9pY/bFGRkQNovO4BmyD8QwxKb9wN9Q9sl/OcvACYlrNyDknutpcd
	ibhKBNBU0Kubo3F3XpLRsYZYNANMLsyXX6Mv2WFceXj3iOkuwSTDvhko5z3eZzlZLRCZvQ
	voRdxtHIZbTbSt5mJla5jOHBeTrMnP3iUsDiLqUxP2I/JlgllfSkMVJefo3Zf3R4km5EgX
	n51jbj0XpFMT5FQVt+/sx7dyXYG1tKJpJ6HZ4utMqGnZBkQDEM9z4kDzfhn8Jw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	bvanassche@acm.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/3] Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock
Date: Tue, 14 Jul 2026 11:40:50 +0300
Message-ID: <a0e6db05b52994c3c27d854e2d35ab0256b93769.1784018377.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
References: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal context analysis annotations to l2cap_chan_lock/unlock() and
callers required for no warnings.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - split code changes and adding annotations to separate patches
    
    Possibly the l2cap_ops::alloc_skb callback should have generally
    __must_hold(&chan->lock) and not just in l2cap_sock.c
    
    This would imply l2cap_chan_send() should hold the lock, but trying to
    add the annotations reveals l2cap_chan_send is called without chan->lock
    from some places:
    
    net/bluetooth/smp.c:589:2: warning: calling function 'l2cap_chan_send' requires holding mutex 'conn->smp->lock' exclusively [-Wthread-safety-analysis]
      589 |         l2cap_chan_send(chan, &msg, 1 + len, NULL);
          |         ^
    1 warning generated.
    net/bluetooth/6lowpan.c:455:8: warning: calling function 'l2cap_chan_send' requires holding mutex 'chan->lock' exclusively [-Wthread-safety-analysis]
      455 |         err = l2cap_chan_send(chan, &msg, skb->len, NULL);
          |               ^
    
    Don't know now if the context in these places allows l2cap_chan_lock()

 include/net/bluetooth/l2cap.h | 2 ++
 net/bluetooth/l2cap_core.c    | 1 +
 net/bluetooth/l2cap_sock.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ef6ce1c20a4f..53a68fc32f10 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -825,11 +825,13 @@ struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c);
 void l2cap_chan_put(struct l2cap_chan *c);
 
 static inline void l2cap_chan_lock(struct l2cap_chan *chan)
+	__acquires(&chan->lock)
 {
 	mutex_lock_nested(&chan->lock, atomic_read(&chan->nesting));
 }
 
 static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
+	__releases(&chan->lock)
 {
 	mutex_unlock(&chan->lock);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 322a1895c1bd..5a76c348712d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4078,6 +4078,7 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
+	__context_unsafe(/* conditional locking */)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 735167f73f31..4afc5b370b97 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1740,6 +1740,7 @@ static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 					       unsigned long hdr_len,
 					       unsigned long len, int nb)
+	__must_hold(&chan->lock)
 {
 	struct sock *sk = chan->data;
 	struct sk_buff *skb;
-- 
2.55.0

