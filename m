Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073042A96;
	Sat, 29 Aug 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013271; cv=pass; b=IPrgsZX43flNqOwDmDPswdB8CvOEIp4gvkyi5p86h+81B8Xj2WgR2rzJa8M99EYayQ8AY6vRGj4xsk1ws0nmJxfSPYhq+0sWQrwAil/ccJAtr62SLK2PV1+6SuGPq/MYr7HGaLTQ+i6vCagbl95ORnpEOqWvQGUYh6v71onfADM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013271; c=relaxed/simple;
	bh=h6XrQILfwOax1K7ARvNpappOhb59PN4VV5J9P0/3+GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DewD1+sBphpwLanx7jndRn6WTUr5OsJ2SmJCXowwh+xpZuf7tF1Va67jrcGjqcShACbPpMZVjZ6W/zxbrzM/Sqaa/hYFqIBXdAebJCludywQ+DLfN8Pp0D0jg6+2N6Ms3dE0sCJxmtZvIMcYJCVUTzUyS5ndEgkCfQ8To3hy2Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=eTQWbKJS; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="eTQWbKJS"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVQ72QHzyhS;
	Sat, 29 Aug 2026 17:21:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBhlXhEpcZVXBOByrLQzkXc88TtYCblpBHZ6pmcoSVA=;
	b=eTQWbKJS9JyX18t/2xz/OpYDNfc+2V1/xAJ8NB7spKUhj9cFJhTe2KEQKxTCFUjn07HbRt
	N6VWYygs/NfmX8OJSTpI2xqdG101Zr4zF3fZ5BgVxfSsyLA4iRR3TurbLpIINAUJ0KFDe/
	//ENK+dhwmjoVmb5cxNGbutuLZs6lJk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013264;
	b=zPxTnlg69ZBgVn0ohpZaAUDmxPaW6mYamU54klxDIHFstAH+F89Vxmm/63NIxJ2KrXuIa4
	VCKud1TxO9aCrgeuVMcjFdTv2LNFlh8VLXW6nMNyk7Ivi3qqabZk82g6GYkdkaCDXJb6AJ
	37e7NHm/P4pdSmxmxti+Oo8y+p/SDl4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBhlXhEpcZVXBOByrLQzkXc88TtYCblpBHZ6pmcoSVA=;
	b=uGFFM4fMZY9OzuKSJNWKwH1ARlNEDhAnIkwebsQF1lL0hSuplrba/ZHBN+baNKzUTiOYdQ
	5uVjmUVX7TOZY3d9RyayljwtlpvO++LGDf5uDWI5vbA6mVo2Fr03OpCR6r9Xp2lrr1yimZ
	pNXjLEt0BBk0aBodN1i/EbPXgQ8GH14=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	error27@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
Date: Sat, 29 Aug 2026 17:19:59 +0300
Message-ID: <c805ce9dafad6ebc50e41c81639c2a268e2a2675.1788013041.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788013041.git.pav@iki.fi>
References: <cover.1788013041.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6lowpan.c is using l2cap_chan_close() without taking chan->conn->lock,
so it may modify conn->chan_l without holding the guarding lock.

Fix the locking by using the l2cap_chan_close_unlocked() helper that
acquires the necessary locks.

Fixes: 15f32cabf426 ("Bluetooth: 6lowpan: add missing l2cap_chan_lock()")
Link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/6lowpan.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 30f4afa18bc8..4ea55950e599 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -921,9 +921,7 @@ static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 
 	BT_DBG("peer %p chan %p", peer, peer->chan);
 
-	l2cap_chan_lock(peer->chan);
-	l2cap_chan_close(peer->chan, ENOENT);
-	l2cap_chan_unlock(peer->chan);
+	l2cap_chan_close_unlocked(peer->chan, ENOENT);
 
 	return 0;
 }
@@ -1025,9 +1023,9 @@ static void disconnect_all_peers(void)
 	struct lowpan_peer *peer;
 	int nchans;
 
-	/* l2cap_chan_close() cannot be called from RCU, and lock ordering
-	 * chan->lock > devices_lock prevents taking write side lock, so copy
-	 * then close.
+	/* l2cap_chan_close_unlocked() cannot be called from RCU, and lock
+	 * ordering chan->lock > devices_lock prevents taking write side lock,
+	 * so copy then close.
 	 */
 
 	rcu_read_lock();
@@ -1062,9 +1060,7 @@ static void disconnect_all_peers(void)
 		spin_unlock(&devices_lock);
 
 		for (i = 0; i < nchans; ++i) {
-			l2cap_chan_lock(chans[i]);
-			l2cap_chan_close(chans[i], ENOENT);
-			l2cap_chan_unlock(chans[i]);
+			l2cap_chan_close_unlocked(chans[i], ENOENT);
 			l2cap_chan_put(chans[i]);
 		}
 	} while (nchans);
@@ -1082,9 +1078,7 @@ static void do_enable_set(bool flag)
 
 	mutex_lock(&set_lock);
 	if (listen_chan) {
-		l2cap_chan_lock(listen_chan);
-		l2cap_chan_close(listen_chan, 0);
-		l2cap_chan_unlock(listen_chan);
+		l2cap_chan_close_unlocked(listen_chan, 0);
 		l2cap_chan_put(listen_chan);
 	}
 
@@ -1132,9 +1126,7 @@ static ssize_t lowpan_control_write(struct file *fp,
 
 		mutex_lock(&set_lock);
 		if (listen_chan) {
-			l2cap_chan_lock(listen_chan);
-			l2cap_chan_close(listen_chan, 0);
-			l2cap_chan_unlock(listen_chan);
+			l2cap_chan_close_unlocked(listen_chan, 0);
 			l2cap_chan_put(listen_chan);
 			listen_chan = NULL;
 		}
@@ -1303,10 +1295,9 @@ static void __exit bt_6lowpan_exit(void)
 	debugfs_remove(lowpan_control_debugfs);
 
 	if (listen_chan) {
-		l2cap_chan_lock(listen_chan);
-		l2cap_chan_close(listen_chan, 0);
-		l2cap_chan_unlock(listen_chan);
+		l2cap_chan_close_unlocked(listen_chan, 0);
 		l2cap_chan_put(listen_chan);
+		listen_chan = NULL;
 	}
 
 	disconnect_devices();
-- 
2.55.0

