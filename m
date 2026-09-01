Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F93ABD80;
	Tue,  1 Sep 2026 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296699; cv=pass; b=i49Vo/9CAcZtbYGvql7ZSl1HcXkB8lbXTSZifqiOOPc2tcKgPueZFlZMNEWQ/s2epOH8lV3WSik/V5SIq3CGbh9nM7QcPxMcWxo2GfR+d5EGYnsN2YRkQI+XWrPH7iKeerewhu3K/fsWDXBswiVUxvPvNUcnOlZ1a813FujNJt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296699; c=relaxed/simple;
	bh=3s9ZPhc55/duEREoxPchCpuMYgIEAWBsjxd0ONqCIlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQqHqxOTsm+0JurdnQqr/jtZVSYhUGFMUfrqQastbV53nyTAS7oGn3G+F+K/4zQqb6NEDKsLAsp5N8dmImoHJel9LIpfiwWIqmCnLL2ZBoKfBab2FgNiyV4O/6Z0SNNs7nDBlinWReTt2u+giLmmRUohtUao2Y8h9x3DYvzQpZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=azUd0b7f; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="azUd0b7f"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::dd01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hZJJs75WvzyfV;
	Wed, 02 Sep 2026 00:04:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788296686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKCj5gbsSO9eIn0e0ZDUMGMEaXRZhNCzZmvhhpmDLHU=;
	b=azUd0b7fJNupUPolcxrpWnK9GGH2Q8leOYPrTjATnFjshnnd4uLn8fpyMuIXjn9H3km1sC
	mGV18IJ+xTQz7dcpYLRmDFSx34UNXn2+ow+UkA9u/+KHhJl9wr/iBLHRTzFXIlSUqzOD+y
	lqIcxzLLP7faXhyH28ExFT2rZQVKb28=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788296686;
	b=I6Kis1eVuRn+/wPscm+Ohsa28fW19MBQPLyygfK1MHyI/qzWfKdvMca9UYo3u1CRaem3Yy
	yvNOWMfapV9vsaukXLVYt+ibfoIia8crklM3Hiy9NseIkCFjKXF799q7ABhV3HBEK0JTzp
	Hc/9MTocGKm9+qjhJ5vXYAiWOmnE8GE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788296686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKCj5gbsSO9eIn0e0ZDUMGMEaXRZhNCzZmvhhpmDLHU=;
	b=mppzkUBCkSEUcT7Nrklsn+WGkMemwqGPDlZc8zky4KgFI7DIzslZq/qHd55ZMWAeCvs1ll
	CYsu0XAUBvwQ8rPX+2a5ztGMwGiVhq7a0rSHiO0RSEA8BZ3D0n+LILIAVlT+0fK9y2rfzz
	fH2lHGy5OmRrFlXagVot2oV4hY019RM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred_rsp_defer
Date: Wed,  2 Sep 2026 00:04:33 +0300
Message-ID: <24ff07854c80a2813fe7050d1dbb40586391b162.1788296635.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788296635.git.pav@iki.fi>
References: <cover.1788296635.git.pav@iki.fi>
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
index 2315a3993c7b..c7e642abe404 100644
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
index 9da689f0a50a..805623a48bae 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -848,6 +848,8 @@ static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
+	lockdep_assert_held(&chan->lock);
+
 	switch (chan->state) {
 	case BT_LISTEN:
 		chan->ops->teardown(chan, 0);
@@ -3950,6 +3952,7 @@ static void l2cap_ecred_list_defer(struct l2cap_chan *chan, void *data)
 }
 
 struct l2cap_ecred_rsp_data {
+	struct l2cap_chan *locked_chan;
 	struct {
 		struct l2cap_ecred_conn_rsp_hdr rsp;
 		__le16 scid[L2CAP_ECRED_MAX_CID];
@@ -3957,11 +3960,42 @@ struct l2cap_ecred_rsp_data {
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
 
 	if (chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		return;
@@ -3973,6 +4007,22 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
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
 
@@ -3985,6 +4035,12 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
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
@@ -3996,11 +4052,15 @@ void __l2cap_ecred_conn_rsp_defer(struct l2cap_chan *chan)
 
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

