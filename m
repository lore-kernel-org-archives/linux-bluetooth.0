Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BD836F8E5;
	Sat, 29 Aug 2026 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013368; cv=pass; b=QRnRH8VJyuMLPs1BhNVxJAUkEJxeT/6MLMFz9D0nQlwZXzNNFcDZCFif3PQJ6gi8br5GW2LG+qF15BsK8DwZX4FqvPwNxZSJBTYlmnsehdfSlmxigWk639LZWSJp6+wrn6AF+BAYtd04EfkztfTPMoWYL4jFsIKHMoN95atrUFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013368; c=relaxed/simple;
	bh=6f2/T2YdPWk825/l6BZ6NR8rusH1doGXtU/ILb4FGy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTvPWzL3JMfmvFayAXn4FKAZBkHQxkCz22C+SgbG60sp02x6VvMmVdJN7gtnPQYfM5KrPnGiEewMNZRE5St16gtOm64sJuUVo4wGtPoRK4C+Z0inq02J+qCPCD3AIoRiLJtg71hfL/eo8+MPExwZqC5MXUaEnYXrctL3ez+c1II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Z3l1zB+F; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Z3l1zB+F"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHXJ0LmXzyWl;
	Sat, 29 Aug 2026 17:22:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/v1dQ0w80RABszAytoWbBxYusHWM3N5fTPq2MCPDXvg=;
	b=Z3l1zB+FcdEC0prICJY3qKs5iheo5A6wGzQYGrazN/3AciG62AwUsE7lLTrWmK4Db1elbg
	UTTgbWBVSrlROz9ELl/NNOb5GhdZmFmp8HssOdozNf4tW3KfE9RzVjmeTbIOJqimbAX2kx
	pEkv6GuONhjxWZ6HShz0uPn+YmggqlY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013361;
	b=wAzLmHEezlRFnJIZiEKhvbkl28H9knCxlTUYFaXxHhPCwADUXkToDcvAjcGX0rjbhRTjUR
	41iBcmt9yGF6Rit2eUi3mpe/xDT+wg64QNKutf/w++Y8WYrzcAkKMfnGAsskQE14Jm6rOb
	fIcfh/tY6C1b4TyDRZKRhMhTDgfgE2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/v1dQ0w80RABszAytoWbBxYusHWM3N5fTPq2MCPDXvg=;
	b=ozTEao5ZALs/IhLhUUt61sM3HC+rIgWzUpl62q08yt2Gzp9CeTrDzeRXLggsya/16KnDmE
	2dj8q8NT2t40E2ZzOAWjFtmYP2nGtJ/8JM5KaSx4Bln4CGUVX4BuVCACTnNmNG4icFEN6r
	HwT9LijVotUQ0tE8W98EcXRKC8cuAT8=
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
Subject: [PATCH 10/16] Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred_rsp_defer
Date: Sat, 29 Aug 2026 17:20:05 +0300
Message-ID: <faaac11f2ee17bdec7a4cd18727d5d8af5702d54.1788013041.git.pav@iki.fi>
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

l2cap_ecred_rsp_defer() calls l2cap_chan_del without holding chan->lock,
which ends up calling ops->teardown() with wrong lock context.

Fix by taking chan->lock in l2cap_ecred_rsp_defer().  AB-BA deadlocks
between sibling l2cap_chan are avoided here via requiring l2cap_conn::lock
to serialize all nested l2cap_chan locking on same nesting level.

In current code, there is no nested l2cap_chan locking on same nesting
level, so we can add this new requirement.

Also return early from  __l2cap_ecred_conn_rsp_defer() if chan did not
have FLAG_DEFER_SETUP, as then no RSP shall be sent for it, to make sure
SMP channels are excluded.

Also hold chan reference over l2cap_chan_del(), in case chan_l reference
was the last.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/l2cap.h |  4 +++
 net/bluetooth/l2cap_core.c    | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a991fc07515c..efd59b6f8afd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -758,6 +758,10 @@ enum {
  * otherwise considers all channels equal and will e.g. complain about a
  * connection oriented channel triggering SMP procedures or a listening
  * channel creating and locking a child channel.
+ *
+ * Lock nesting of channels at the same nesting level is allowed if the channels
+ * have the same l2cap_chan::conn and l2cap_chan::conn.lock is taken before the
+ * nested locks. l2cap_chan_try_sibling_lock() must be used.
  */
 enum {
 	L2CAP_NESTING_SMP,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ce51b0b0b37d..750b13f76203 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -848,6 +848,8 @@ static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
+	lockdep_assert_held(&chan->lock);
+
 	switch (chan->state) {
 	case BT_LISTEN:
 		chan->ops->teardown(chan, 0);
@@ -3943,6 +3945,7 @@ static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
 }
 
 struct l2cap_ecred_rsp_data {
+	struct l2cap_chan *locked_chan;
 	struct {
 		struct l2cap_ecred_conn_rsp_hdr rsp;
 		__le16 scid[L2CAP_ECRED_MAX_CID];
@@ -3950,11 +3953,42 @@ struct l2cap_ecred_rsp_data {
 	int count;
 };
 
+/* Lock @chan if it is not @locked_chan, and has same or lower nesting level.
+ *
+ * They must have the same chan->conn, and conn->lock must be held.
+ *
+ * Caller must ensure @chan has lock nesting level <= that of @locked_chan, as
+ * nested locking of l2cap_chan of different levels is allowed also without
+ * holding conn->lock.
+ *
+ * See l2cap.h for the global l2cap_chan locking rules.
+ */
+static bool l2cap_chan_try_sibling_lock(struct l2cap_chan *chan,
+					struct l2cap_chan *locked_chan)
+	__must_hold(&locked_chan->lock)
+	__must_hold(&locked_chan->conn->lock)
+	__cond_acquires(true, &chan->lock)
+{
+	if (chan == locked_chan)
+		return false;
+
+	if (WARN_ON_ONCE(locked_chan->conn != chan->conn))
+		return false;
+
+	if (WARN_ON_ONCE(atomic_read(&locked_chan->nesting)
+			 < atomic_read(&chan->nesting)))
+		return false;
+
+	mutex_lock_nest_lock(&chan->lock, &locked_chan->conn->lock);
+	return true;
+}
+
 static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_ecred_rsp_data *rsp = data;
 	struct l2cap_ecred_conn_rsp *rsp_flex =
 		container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, hdr);
+	bool locked;
 
 	/* Check if channel for outgoing connection or if it wasn't deferred
 	 * since in those cases it must be skipped.
@@ -3963,6 +3997,22 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	    !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
+	lockdep_assert_held(&rsp->locked_chan->lock);
+	lockdep_assert_held(&rsp->locked_chan->conn->lock);
+
+	l2cap_chan_hold(chan);
+
+	locked = l2cap_chan_try_sibling_lock(chan, rsp->locked_chan);
+
+	/* Cannot occur: PARENT channels do not appear in chan_l, and SMP
+	 * channels never have FLAG_DEFER_SETUP.
+	 */
+	if (context_unsafe(!locked && chan != rsp->locked_chan))
+		goto done;
+
+	lockdep_assert_held(&chan->lock);
+	lockdep_assert_held(&chan->conn->lock);
+
 	/* Reset ident so only one response is sent */
 	chan->ident = 0;
 
@@ -3971,6 +4021,12 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 		rsp_flex->dcid[rsp->count++] = cpu_to_le16(chan->scid);
 	else
 		l2cap_chan_del(chan, ECONNRESET);
+
+done:
+	if (locked)
+		l2cap_chan_unlock(chan);
+
+	l2cap_chan_put(chan);
 }
 
 void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
@@ -3982,11 +4038,15 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
 
 	if (!id)
 		return;
+	if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
 
 	BT_DBG("chan %p id %d", chan, id);
 
 	memset(&data, 0, sizeof(data));
 
+	data.locked_chan = chan;
+
 	data.pdu.rsp.mtu     = cpu_to_le16(chan->imtu);
 	data.pdu.rsp.mps     = cpu_to_le16(chan->mps);
 	data.pdu.rsp.credits = cpu_to_le16(chan->rx_credits);
-- 
2.55.0

