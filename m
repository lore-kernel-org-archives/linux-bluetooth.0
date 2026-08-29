Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB54214812;
	Sat, 29 Aug 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013266; cv=pass; b=Ob9EDeGUuiRbRTDpZv7zOpxojjO03ci6gP28Cvh8ywtKz7d46onTFUWxoPjNqK+kqKTz/MPDMBCrC3gSPmm3K8ORlkHC22eId9RVLSan+eW6Btrty/VNW4Eemmhn/2Dq3zaJYUkW6e/NhFTkXPfQTKeGqbx3XTkkc7SZ01tMP28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013266; c=relaxed/simple;
	bh=Ip8ewKHJCDXXqOktL5ZD05PV0I70Yt777as68Mwsgew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBjeEOGy3Sk/kL+i03N5whM6rZZwsygtEAuNuo3OzMj56oXFnQPfST+66GIMxL0uFAhCAhV/EesWlK7VoMNMu/I+kZfh2fCVnqzWrSyo/cRct6W/l+uUKrrsmki3+81kS7VlEPlJJGA0CEOcD/5ucuxwRQhfLSFywRXxrgsbn7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=eMUiw3Lk; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="eMUiw3Lk"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHVJ4hKdz11GQ;
	Sat, 29 Aug 2026 17:20:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PRgG5uGRLGPkDBo1Znpwxxc2dMsweTnD+4NI02S4Gs=;
	b=eMUiw3Lkw82W8YCPUdONCd47durk0Jq3MLJKiogMBq+j0YMk144fZ3aMbG985PrG/00KFv
	91vYwe71jJnvROnRgzgSiAsJ0E6t1fPRe392hf8W2OgXQ39YNslMa1gmUgzqDpATdQsPXs
	rHqP+KjG7j7AIBKUUAJv4OddLjxR37I=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013258;
	b=p8bFDu3BNNKdeJZxxkhNlOPtUrnob1T5chezo+rathQ+ai6+G/HsycV4NJwrUf+g1DQZt8
	fs5XcFBE76ZnELC1y1IEtIqQ8+6Z/aBoJCLL8lZxXyvvoEivezhD2B/wlLXA7UEz6q4/CA
	kE0i1bfnD67WSwSjCyYyPI+reXUKLJQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PRgG5uGRLGPkDBo1Znpwxxc2dMsweTnD+4NI02S4Gs=;
	b=I2t2BAtl8jYnwJHFfMg3/oeNeFZq27A9ariC3jB4rihy4rGeZtfJRLRNZnY2f88Rs9yVlf
	oYnKT1hrs33qGG4KP56olML7cifoVBR9X+QeKJ2T/1rfy33BqJH1jLryUi1fPwpHHEnDJP
	1WHRuJXlYeA/fW11bDswKGbMUBPs4ZU=
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
	linux-kernel@vger.kernel.org,
	Eulgyu Kim <eulgyukim@snu.ac.kr>,
	Jaeyoung Chung <jjy600901@snu.ac.kr>
Subject: [PATCH 03/16] Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
Date: Sat, 29 Aug 2026 17:19:58 +0300
Message-ID: <f4da8f7b70ab1226e80f44aff07a1f18a2b50d33.1788013041.git.pav@iki.fi>
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

l2cap_sock_shutdown() has the race condition

    [Task 1]                      [Task 2]
    l2cap_sock_shutdown           l2cap_sock_connect
      l2cap_chan_lock               l2cap_chan_connect
      conn = ... /* == NULL*/
      l2cap_chan_unlock ------------> l2cap_chan_lock
      if (conn) /* false */
                                      __l2cap_chan_add(conn, chan)
      l2cap_chan_lock <-------------- l2cap_chan_unlock
      l2cap_chan_close /* chan->conn->lock not held! */

conn->lock protects conn->chan_l and is not properly held here.

Use the l2cap_chan_close_unlocked() helper that ensures conn->lock is
held for l2cap_chan_close().

Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://lore.kernel.org/linux-bluetooth/20260824153908.2327306-1-jjy600901@snu.ac.kr/
Link: https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_sock.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b553b6356af8..0265b6508682 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1406,7 +1406,6 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan;
-	struct l2cap_conn *conn;
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p, how %d", sock, sk, how);
@@ -1463,23 +1462,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	sk->sk_shutdown |= SEND_SHUTDOWN;
 	release_sock(sk);
 
-	l2cap_chan_lock(chan);
-	/* prevent conn structure from being freed */
-	conn = l2cap_conn_hold_unless_zero(chan->conn);
-	l2cap_chan_unlock(chan);
-
-	if (conn)
-		/* mutex lock must be taken before l2cap_chan_lock() */
-		mutex_lock(&conn->lock);
-
-	l2cap_chan_lock(chan);
-	l2cap_chan_close(chan, 0);
-	l2cap_chan_unlock(chan);
-
-	if (conn) {
-		mutex_unlock(&conn->lock);
-		l2cap_conn_put(conn);
-	}
+	l2cap_chan_close_unlocked(chan, 0);
 
 	lock_sock(sk);
 
-- 
2.55.0

