Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798F3AB5C3;
	Sat, 29 Aug 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013260; cv=pass; b=eTiMwEq+IrWBTJAK2wEHmHgVOKnkC0zqKaNJBk5j5E6wFIZI+iGtp/z1DjDikVXAgFFvROgZZ4qGjNq9QNSCoon7lbHxQOaeFYOSNcI2AwGDQVzMaIgq4o4iRbgT+27XwCFJpbx18r4cVjPidixsr/ZyaTAjBh/In6MG2XC87og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013260; c=relaxed/simple;
	bh=TOcMXFWykundmx7U0oKPgaPN+mEeO3jj/UL7vY7+MnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fti2R9gSzcTAA3K0qh/r13SKLmUEvGYgs0H8hIzRTlfqHCd2xfsKvdUUnKkHwhrEDvUks6wwqHswqvseJkizJxfTME9SJLffrv7Ys0FRV/gYeZyB7zKwJ2OeUDcVJC7sEUcsTKjPDw5mCy29LcxH5HiJ0akfdciygaweCCInykY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=flZrJKuj; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="flZrJKuj"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHV510YWzyvj;
	Sat, 29 Aug 2026 17:20:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPdRZk6OTj7U1aLWdMJRRce2Ve5/w20Ues9PzuebYnQ=;
	b=flZrJKujqxKokr0Fys2eLi3eAZkrgah38wr5P1PPKUBcgJIt4UP9BCAe/gOJ8aA5qQ+1Sj
	X+tc3/7WnaTdcc3SFETvSqHwzGBSnNhFHbsN0tGpzPaIyq84qwdVkogjEeDALkAOzQdrIi
	yQ/t9PW81Veurt0P9g1tclUzivBFlfc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013246;
	b=Py9UX8y+9n9+CkaCRXbPRzYN6aKSwDZ6h2nwsak3AWF+F4oazrUaZEuhXvbrXDoaV3IKHs
	tvtCKBSGAtYBq10HbXoE5/1EG92Rwy7BHSa48qurnz4oAVe+x8q6zYnUGCfXcRpCuoPsp4
	5IBJKiLj4TslHuet4kEP2O2K5NPySNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPdRZk6OTj7U1aLWdMJRRce2Ve5/w20Ues9PzuebYnQ=;
	b=QEZ9/meAgOmC1gaH1crUBgprnkoTUwXdqAEBsMYQbd096AS0N0S36uCHx6x6E+YKXnvuJB
	MtFcYDSEBn1tobamJYRGRpASeS/gvrSqQWfgBAZo5iOqSSoDbsazyq0RfiZ52gIFnVjsK7
	2RvvZaM1Njbje5Z4xHYUy0MjgZOdUek=
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
Subject: [PATCH 01/16] Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
Date: Sat, 29 Aug 2026 17:19:56 +0300
Message-ID: <dbcbac89076e5aa3aa4f3ab22a82f85e051bb022.1788013041.git.pav@iki.fi>
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

chan->lock must be held for __l2cap_chan_add as eg. calls to
l2cap_chan_close assume chan->conn writes are guarded by it.

It must be held for l2cap_chan_del() due to
l2cap_sock.c:l2cap_chan_conn, l2cap_monitor_timeout, etc.

Similarly it should be held for l2cap_ops::ready (assumed in 6lowpan.c).
Also teardown usually has chan->lock held, it should always have it held
to have the same locking context.

The lock is not correctly held by l2cap_core in several places.

Add the missing locks for l2cap_chan_del/add/ready(), except in
l2cap_ecred_rsp_defer() which needs separate fix as it needs lock
nesting.

Fixes: 6fef032af009 ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h |  3 ++-
 net/bluetooth/l2cap_core.c    | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 69d193fee351..43a67562b238 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -973,7 +973,8 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
-void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
+void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
+	__must_hold(&chan->lock);
 typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
 void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 		     void *data);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 358b11eabd4f..adcf714ec1ed 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -665,7 +665,9 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	mutex_lock(&conn->lock);
+	l2cap_chan_lock(chan);
 	__l2cap_chan_add(conn, chan);
+	l2cap_chan_unlock(chan);
 	mutex_unlock(&conn->lock);
 }
 
@@ -4065,6 +4067,8 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 	if (!chan)
 		return NULL;
 
+	l2cap_chan_lock(chan);
+
 	l2cap_chan_set_defaults(chan, pchan);
 	chan->ops = pchan->ops;
 
@@ -4073,10 +4077,13 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 	if (pchan->ops->new_connection &&
 	    pchan->ops->new_connection(pchan, chan) < 0) {
 		l2cap_chan_del(chan, 0);
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return NULL;
 	}
 
+	l2cap_chan_unlock(chan);
+
 	return chan;
 }
 
@@ -5047,6 +5054,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	l2cap_chan_lock(chan);
+
 	bacpy(&chan->src, &conn->hcon->src);
 	bacpy(&chan->dst, &conn->hcon->dst);
 	chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5079,6 +5088,8 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		result = L2CAP_CR_LE_SUCCESS;
 	}
 
+	l2cap_chan_unlock(chan);
+
 response_unlock:
 	l2cap_chan_unlock(pchan);
 	l2cap_chan_put(pchan);
@@ -5271,6 +5282,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 			continue;
 		}
 
+		l2cap_chan_lock(chan);
+
 		bacpy(&chan->src, &conn->hcon->src);
 		bacpy(&chan->dst, &conn->hcon->dst);
 		chan->src_type = bdaddr_src_type(conn->hcon);
@@ -5303,6 +5316,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		} else {
 			l2cap_chan_ready(chan);
 		}
+
+		l2cap_chan_unlock(chan);
 	}
 
 unlock:
-- 
2.55.0

