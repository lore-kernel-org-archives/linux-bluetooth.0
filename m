Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737818;
	b=GUvToeJXgbI8THVeWKvL1pYdHvRPB3PrpQlyJrar8VbKstG+rNznwxKxfTfeiM3eMThl
	 bDyGZwd62RG941XDcZK/WBozN7t3EKGFyPgmVWFBizAFbiaDkr0CZMq8WwgR3+dSr6MiR
	 PF6fQJCrlJ57bog8fk+kKpxSuesvDuLnLBvxTIz6WMn6PpCL4R47AOnASPsoVe3SYYyIQ
	 e6WtvipZhhH0lgAcXHZSv4t1O84KMcPq9hmI4uPI2hBIWGkC7yR6tznInspTtMv39t++w
	 2TPt8looOX0HskfVdT3hO/QfrPfcbaO+CQiR59bAtNcYqFBNzgacNwsi6uGaeTC5QqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tGWh8hfV7187POWWJYAabKOh5NmF6arPmT7lmmlLVHg=;
	b=HyrF0xhGKmpYQF5NRhG3JfzbEEnk182sJ9ekXH4LbrlWG9tzvu1Dhv/3I/7DeUjB4TvP
	 8kR7KHZTUgUWSNNn53TyhaHVzWwBv0KFDyqYBfehU4F9sVMP+kAygmRzivl2jhubT3Z+P
	 F9/oD3ImfQ4gIeNWrJzoRrLhw9V2N001bgQcJfDlMvlWYLGLfTZBiGO1bHXUEa6d1AxYr
	 khugEGFV/L8VzN7H8Nm4MAGcP7++n8Qu7CTCwAIDTFevW834czYusg8k6bn58G1NDNj7a
	 X4UaoBm3jiolfVQQKGy7S5ezw4TifcP299MmkCM6OQDHfY/rQ3rlWtBsnWwDkjBrtBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hQJ2eQwu;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CE606A329
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 766CE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hQJ2eQwu
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cc91ddf447so1662305137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737816; x=1794342616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tGWh8hfV7187POWWJYAabKOh5NmF6arPmT7lmmlLVHg=;
        b=hQJ2eQwuFWw6PsiYoAgcqhdPuD8daDVqrBb6XgRiFylRdsyg7edRWXw7ZlOQEiJvyU
         rkojRHnbyHuEKJF754s6emnAL/MyJIw0fPICP7QTY6OXoj50xuuBalcdNw0VeC91rSq2
         4qrKFx0stGeGaNLkZq0EjAFNWtRePLQIWP1IOK8CWHUoNdajsmGfyFLx13uDZKRK7a1c
         17i7Ts181K3x8b7xY+N24M/ro3Z2ql47F4qJkFc0pouDQBVI7bEZZAdsYmYoNHcWHhIf
         xOf35pIHJBCfcQahoSXgEKIMW1nwjoSul4/PObM/5MPxd8rVqE/kBxpiDU0u3xWn9oiT
         REKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737816; x=1794342616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tGWh8hfV7187POWWJYAabKOh5NmF6arPmT7lmmlLVHg=;
        b=i3JDIvqkduwRYtVVJBjJ1VT7l8PruE5XRKsLhxhTZEkrS0y1DdYB0opVlPlqsaU4jl
         0A24NGwlLkAbnZi+J3qSDlz2eQo7/LKmhVmwArcNhGq0AMQoMZ2XNusWRSc7Ch9FCtrt
         pfGF30KqopzHUwKPkYh/vfopf5TotjBP0WWRUcOOdd53CoSGK2O25c/DSrF90QbnvH/r
         gzrsBIU7dRublkG0KuoXdIW5iQJYGvezV9wEHUUnhToit+jdLCq4ZRAdkgeak7hTXqwd
         3dxaXaRjjvHLal7taVsom5NvPF+e83O22n+JOm1Hrx+krXzTbOBeupvxqPuMIYGa2wlv
         k30w==
X-Gm-Message-State: APuU4Z9yZU5AiK1WBsGnXAsIQQEL6fJPMmLOtRSTNYYCdv1RSiibZ3MB
	ECeZsohOVpEYrQOMNYQ+aNQ1pZlkA32A/pqLY7HfsNDaybXmUgW5UgZjAlPvOA==
X-Gm-Gg: AYBFou2AhPkoYoSzT0Uk7Kgfys8jumiaKDspOn2zjq+R03vgGUeru0ZFmigopLLKQeg
	XC5eM9DIxFHf6ey2YDNXRRyZovMxDB7ZauFJeg9IaucolALJXe0VokIZ2L5QtaFPaOfaLslRN0P
	8oovXM0/FdeFdWam9rJnBKrwkJF8GDoFXbzFNMK83i3DuyGdlY5GjAMSw42yBkYz7/94P3/7vDC
	+UTbdED0hbjCueHVtRoPCoww0Q6mFN6i17pz7vt4MLcRAe/TeBe8Vj1YEjq/xCERg8gpNzxyLsI
	emb47OhX/s+SyCJOPbkYyxXs4/BirW9vzDvbTOG/OuNkj366KX0dj7DN8uCq7oTf0NAdcZad/p2
	4mqPPqJltrMxx1R9ydRJoVt9w90JlilID/HO7I7dHg9DQuh8qYeBKtcz5vfWnRuhiPOMSdVCmxt
	g9ij9ymIylb68is5CFAWv7CwMhj+iziDhQ4VFWj4Mh4eLAOYpV0H2N5pA5LsbY62T8bil6vwdAX
	fSZ166/+YRP45sAUWULEmf3tSUgHLsj1FiT60ouZHt3zvzDB/pajB7w/BdoXnKLobHRbXPcKcmV
	V62UUWqrjIxpJ6m3NwlAhIn3CNZKh7ZuQVONnq3KN7Gm5Z4C3yDcjzTBSmQBx8nfV6Jg230dZ1g
	fgTWJiA82yR0iNEv2chUeTjdkpoj/StzjXzO1gWpxZxZgMqebaU45YGCGOEgj+pYyXwgtB4yDYB
	ZNG4U=
X-Received: by 2002:a67:e70a:0:b0:7c4:a0e4:1a79 with SMTP id ada2fe7eead31-7d0726cfedfmr4773755137.19.1793737816231;
        Tue, 03 Nov 2026 12:30:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d2a3asm139916241.8.2026.11.03.12.30.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/7] shared/bap: Wait for ASE state before completing requests
Date: Tue,  3 Nov 2026 15:30:04 -0500
Message-ID: <20261103203011.3904290-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203011.3904290-1-luiz.dentz@gmail.com>
References: <20261103203011.3904290-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When acting as client the ASE Control Point notification may arrive
before the ASE state notifications, so completing the request on the CP
notification alone may cause the upper layer to act on a stale state,
e.g. replying to MediaTransport1.Release and then failing the following
Acquire with an I/O error since the ASE is still in Streaming state.

Fix this by keeping the request outstanding until each ASE whose
operation succeeded has left the state it was in when the request was
sent, with BAP_STATE_TIMEOUT as a fallback in case the server never
notifies it. Further requests are not sent in the meantime, so each
request only waits for the states it caused. Each request in a group is
now also completed with the response of its own ASE.

Since requests can now be outstanding for longer, detaching or
cancelling a stream grouped in a queued request now only removes its
own request, promoting the next one in the group if it was the leader,
instead of completing or freeing the whole group. Cancelling the
outstanding request only drops its callback, so it still waits for its
CP notification and ASE state before the next request is sent. The
requests are unlinked before their callbacks are called, the queue is
processed again if the outstanding request is removed, and a detached
request whose CP notification is still pending is replaced by a
placeholder so the notification is not taken as the response of the
next request.
---
 src/shared/bap.c | 424 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 397 insertions(+), 27 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 24a43ba07b55..8cb7fb40f16c 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -48,6 +48,7 @@
 	}
 
 #define BAP_PROCESS_TIMEOUT 10
+#define BAP_STATE_TIMEOUT 1000
 
 #define CODEC_SPECIFIC_CONFIGURATION_MASK (\
 		(1<<BT_BAP_CC_FREQ)|\
@@ -156,6 +157,10 @@ struct bt_bap_req {
 	size_t len;
 	bt_bap_stream_func_t func;
 	void *user_data;
+	uint8_t state;
+	bool wait;
+	bool has_rsp;
+	struct bt_ascs_ase_rsp rsp;
 };
 
 typedef void (*bap_notify_t)(struct bt_bap *bap, uint16_t value_handle,
@@ -176,6 +181,8 @@ struct bt_bap {
 	struct bt_gatt_client *client;
 	struct bt_att *att;
 	struct bt_bap_req *req;
+	unsigned int wait_id;
+	struct bt_ascs_ase_rsp wait_rsp;
 
 	unsigned int cp_id;
 	unsigned int process_id;
@@ -1271,6 +1278,10 @@ static void bap_req_complete(struct bt_bap_req *req,
 {
 	struct queue *group;
 
+	/* Use the response of the request own ASE if there is one */
+	if (req->has_rsp)
+		rsp = &req->rsp;
+
 	if (!req->func)
 		goto done;
 
@@ -1300,26 +1311,175 @@ static bool match_req_stream(const void *data, const void *match_data)
 	return req->stream == match_data;
 }
 
-static void bap_req_abort(void *data)
+static bool req_is_waiting(const void *data, const void *user_data)
+{
+	const struct bt_bap_req *req = data;
+
+	return req->wait;
+}
+
+static bool bap_req_waiting(struct bt_bap_req *req)
+{
+	return req->wait || queue_find(req->group, req_is_waiting, NULL);
+}
+
+static void bap_wait_complete(struct bt_bap *bap)
+{
+	struct bt_bap_req *req = bap->req;
+	struct bt_ascs_ase_rsp rsp = bap->wait_rsp;
+
+	if (bap->wait_id) {
+		timeout_remove(bap->wait_id);
+		bap->wait_id = 0;
+	}
+
+	bap->req = NULL;
+	bap_req_complete(req, &rsp);
+}
+
+static bool bap_process_queue(void *data);
+
+/* Complete the request once no stream is waiting for its ASE state */
+static void bap_wait_check(struct bt_bap *bap)
+{
+	if (!bap->req || !bap->wait_id || bap_req_waiting(bap->req))
+		return;
+
+	bap_wait_complete(bap);
+	bap_process_queue(bap);
+}
+
+static void req_clear_wait(void *data, void *user_data)
 {
 	struct bt_bap_req *req = data;
-	struct bt_bap *bap = req->stream->bap;
 
-	DBG(bap, "req %p", req);
-	bap_req_complete(req, NULL);
+	/* Ignore notifications that don't change the state, e.g. metadata */
+	if (req->stream == user_data && req->stream->ep->state != req->state)
+		req->wait = false;
+}
+
+static void bap_wait_state_changed(struct bt_bap *bap,
+					struct bt_bap_stream *stream)
+{
+	if (!bap->req || !bap->wait_id)
+		return;
+
+	req_clear_wait(bap->req, stream);
+	queue_foreach(bap->req->group, req_clear_wait, stream);
+
+	bap_wait_check(bap);
+}
+
+/* Keep a request without callback in place of a cancelled request whose
+ * CP notification is still pending, so it is not taken as the response of
+ * the next request.
+ */
+static struct bt_bap_req *bap_req_placeholder(struct bt_bap *bap,
+						uint8_t op)
+{
+	struct bt_bap_req *req;
+
+	req = new0(struct bt_bap_req, 1);
+	req->op = op;
+
+	DBG(bap, "req %p placeholder for op 0x%02x", req, op);
+
+	return req;
+}
+
+static void bap_schedule_queue(struct bt_bap *bap)
+{
+	if (bap->req || bap->process_id || queue_isempty(bap->reqs))
+		return;
+
+	bap->process_id = timeout_add(BAP_PROCESS_TIMEOUT, bap_process_queue,
+								bap, NULL);
+}
+
+/* Unlink the requests of a stream from a request and its group into
+ * removed, if the stream is the leader the next member of the group is
+ * promoted.
+ */
+static struct bt_bap_req *bap_req_unlink_stream(struct bt_bap_req *req,
+						struct bt_bap_stream *stream,
+						struct queue *removed)
+{
+	struct bt_bap_req *member;
+
+	while ((member = queue_remove_if(req->group, match_req_stream,
+								stream)))
+		queue_push_tail(removed, member);
+
+	if (req->stream != stream)
+		return req;
+
+	member = queue_pop_head(req->group);
+	if (member) {
+		member->group = req->group;
+		req->group = NULL;
+	}
+
+	queue_push_tail(removed, req);
+
+	return member;
+}
+
+static void bap_req_complete_all(struct queue *reqs,
+					const struct bt_ascs_ase_rsp *rsp)
+{
+	struct bt_bap_req *req;
+
+	while ((req = queue_pop_head(reqs)))
+		bap_req_complete(req, rsp);
+
+	queue_destroy(reqs, NULL);
 }
 
 static void bap_abort_stream_req(struct bt_bap *bap,
 						struct bt_bap_stream *stream)
 {
-	queue_remove_all(bap->reqs, match_req_stream, stream, bap_req_abort);
+	struct queue *reqs = bap->reqs;
+	struct queue *aborted = queue_new();
+	struct queue *completed = queue_new();
+	struct bt_ascs_ase_rsp rsp = bap->wait_rsp;
+	struct bt_bap_req *req;
 
-	if (bap->req && bap->req->stream == stream) {
-		struct bt_bap_req *req = bap->req;
+	/* Unlink all requests of the stream before completing them, so the
+	 * callbacks see the remaining requests.
+	 */
+	bap->reqs = queue_new();
 
-		bap->req = NULL;
-		bap_req_complete(req, NULL);
+	while ((req = queue_pop_head(reqs))) {
+		req = bap_req_unlink_stream(req, stream, aborted);
+		if (req)
+			queue_push_tail(bap->reqs, req);
 	}
+
+	queue_destroy(reqs, NULL);
+
+	if (bap->req) {
+		uint8_t op = bap->req->op;
+
+		/* If the request is waiting for the ASE state the CP operation
+		 * has already succeeded, so complete it with its response.
+		 */
+		bap->req = bap_req_unlink_stream(bap->req, stream,
+					bap->wait_id ? completed : aborted);
+		if (!bap->req) {
+			if (bap->wait_id) {
+				timeout_remove(bap->wait_id);
+				bap->wait_id = 0;
+			} else {
+				bap->req = bap_req_placeholder(bap, op);
+			}
+		}
+	}
+
+	bap_req_complete_all(aborted, NULL);
+	bap_req_complete_all(completed, &rsp);
+
+	bap_wait_check(bap);
+	bap_schedule_queue(bap);
 }
 
 static void bt_bap_stream_unref(void *data)
@@ -1488,10 +1648,7 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	/* Post notification updates */
 	switch (stream->ep->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
-		if (bap->req && bap->req->stream == stream) {
-			bap_req_complete(bap->req, NULL);
-			bap->req = NULL;
-		}
+		bap_abort_stream_req(bap, stream);
 
 		if (stream->ops && stream->ops->detach)
 			stream->ops->detach(stream);
@@ -1651,6 +1808,9 @@ static void append_group(void *data, void *user_data)
 	struct iovec *iov = user_data;
 	size_t i;
 
+	if (req->stream)
+		req->state = req->stream->ep->state;
+
 	for (i = 0; i < req->len; i++)
 		util_iov_push_mem(iov, req->iov[i].iov_len,
 					req->iov[i].iov_base);
@@ -1684,6 +1844,9 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 	iov.iov_base = alloca(iov.iov_len);
 	iov.iov_len = 0;
 
+	if (req->stream)
+		req->state = req->stream->ep->state;
+
 	hdr.op = req->op;
 	hdr.num = 1 + queue_length(req->group);
 
@@ -1721,6 +1884,10 @@ static bool bap_process_queue(void *data)
 		bap->process_id = 0;
 	}
 
+	/* Wait for the outstanding request to complete */
+	if (bap->req)
+		return false;
+
 	while ((req = queue_pop_head(bap->reqs))) {
 		if (bap_send(bap, req))
 			break;
@@ -4792,6 +4959,7 @@ static void bap_free(void *data)
 	struct bt_bap *bap = data;
 
 	timeout_remove(bap->process_id);
+	timeout_remove(bap->wait_id);
 
 	bt_bap_detach(bap);
 
@@ -5533,6 +5701,7 @@ static void bap_ep_set_status(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 					const uint8_t *value, uint16_t length)
 {
 	struct bt_ascs_ase_status *rsp;
+	struct bt_bap_stream *stream;
 	struct iovec iov = {
 		.iov_base = (void *) value,
 		.iov_len = length,
@@ -5573,7 +5742,13 @@ static void bap_ep_set_status(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	if (!ep->stream)
 		return;
 
-	bap_stream_state_changed(ep->stream);
+	stream = ep->stream;
+
+	bap_stream_state_changed(stream);
+
+	/* Complete the request if it was waiting for the ASE state */
+	if (ep->stream == stream)
+		bap_wait_state_changed(bap, stream);
 }
 
 static void read_ase_status(bool success, uint8_t att_ecode,
@@ -5673,6 +5848,139 @@ static void bap_endpoint_attach(struct bt_bap *bap, struct bt_bap_endpoint *ep)
 						bap_endpoint_notify, ep);
 }
 
+struct req_rsp_data {
+	struct bt_bap *bap;
+	const struct bt_ascs_ase_rsp *rsp;
+};
+
+static void req_set_rsp(void *data, void *user_data)
+{
+	struct bt_bap_req *req = data;
+	struct req_rsp_data *rsp = user_data;
+
+	if (!req->stream || !queue_find(rsp->bap->streams, NULL, req->stream))
+		return;
+
+	if (req->stream->ep->id != rsp->rsp->ase)
+		return;
+
+	req->rsp = *rsp->rsp;
+	req->has_rsp = true;
+}
+
+static void req_default_rsp(void *data, void *user_data)
+{
+	struct bt_bap_req *req = data;
+	struct req_rsp_data *rsp = user_data;
+
+	if (req->has_rsp)
+		return;
+
+	req->rsp = *rsp->rsp;
+	req->has_rsp = true;
+}
+
+static bool bap_req_needs_wait(struct bt_bap *bap, struct bt_bap_req *req)
+{
+	struct bt_bap_endpoint *ep;
+
+	if (!req->stream || !queue_find(bap->streams, NULL, req->stream))
+		return false;
+
+	/* Only wait if the operation succeeded for the ASE */
+	if (!req->has_rsp || req->rsp.code != BT_ASCS_RSP_SUCCESS)
+		return false;
+
+	ep = req->stream->ep;
+
+	/* ASE state has already been notified */
+	if (ep->state != req->state)
+		return false;
+
+	switch (req->op) {
+	case BT_ASCS_CONFIG:
+		return req->state != BT_ASCS_ASE_STATE_CONFIG;
+	case BT_ASCS_QOS:
+		return req->state != BT_ASCS_ASE_STATE_QOS;
+	case BT_ASCS_ENABLE:
+	case BT_ASCS_START:
+	case BT_ASCS_DISABLE:
+	case BT_ASCS_STOP:
+	case BT_ASCS_RELEASE:
+		return true;
+	}
+
+	return false;
+}
+
+static void req_set_wait(void *data, void *user_data)
+{
+	struct bt_bap_req *req = data;
+	struct bt_bap *bap = user_data;
+
+	req->wait = bap_req_needs_wait(bap, req);
+}
+
+static bool bap_wait_timeout(void *data)
+{
+	struct bt_bap *bap = data;
+
+	DBG(bap, "req %p timeout waiting for ASE state", bap->req);
+
+	bap->wait_id = 0;
+	bap_wait_complete(bap);
+	bap_process_queue(bap);
+
+	return false;
+}
+
+/* Wait for the ASE state notifications before completing the request, as
+ * the CP notification may arrive first. Further requests are not sent
+ * until then, so each request waits for the states it caused.
+ */
+static bool bap_req_wait(struct bt_bap *bap, struct bt_bap_req *req,
+				const struct bt_ascs_ase_rsp *rsp)
+{
+	struct req_rsp_data data = {
+		.bap = bap,
+		.rsp = rsp,
+	};
+
+	if (!rsp)
+		return false;
+
+	/* ASEs without a response of their own use the last one */
+	req_default_rsp(req, &data);
+	queue_foreach(req->group, req_default_rsp, &data);
+
+	req_set_wait(req, bap);
+	queue_foreach(req->group, req_set_wait, bap);
+
+	if (!bap_req_waiting(req))
+		return false;
+
+	DBG(bap, "req %p wait for ASE state", req);
+
+	bap->wait_rsp = *rsp;
+	bap->wait_id = timeout_add(BAP_STATE_TIMEOUT, bap_wait_timeout, bap,
+									NULL);
+
+	return bap->wait_id != 0;
+}
+
+/* Store the response of each ASE in its request */
+static void bap_req_set_rsp(struct bt_bap *bap, struct bt_bap_req *req,
+				const struct bt_ascs_ase_rsp *ase_rsp)
+{
+	struct req_rsp_data rsp = {
+		.bap = bap,
+		.rsp = ase_rsp,
+	};
+
+	req_set_rsp(req, &rsp);
+	queue_foreach(req->group, req_set_rsp, &rsp);
+}
+
 static void bap_cp_notify(struct bt_bap *bap, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -5682,11 +5990,11 @@ static void bap_cp_notify(struct bt_bap *bap, uint16_t value_handle,
 	struct bt_bap_req *req;
 	int i;
 
-	if (!bap->req)
+	/* Ignore if there is no request or it is waiting for ASE state */
+	if (!bap->req || bap->wait_id)
 		return;
 
 	req = bap->req;
-	bap->req = NULL;
 
 	if (length < sizeof(*rsp)) {
 		DBG(bap, "Invalid ASE CP notification: length %u < %zu",
@@ -5715,9 +6023,16 @@ static void bap_cp_notify(struct bt_bap *bap, uint16_t value_handle,
 		}
 
 		ase_rsp = &rsp->rsp[i];
+		length -= sizeof(*ase_rsp);
+
+		bap_req_set_rsp(bap, req, ase_rsp);
 	}
 
 done:
+	if (bap_req_wait(bap, req, ase_rsp))
+		return;
+
+	bap->req = NULL;
 	bap_req_complete(req, ase_rsp);
 	bap_process_queue(bap);
 }
@@ -6010,6 +6325,11 @@ void bt_bap_detach(struct bt_bap *bap)
 		return;
 
 	/* Cancel ongoing request */
+	if (bap->wait_id) {
+		timeout_remove(bap->wait_id);
+		bap->wait_id = 0;
+	}
+
 	if (bap->req) {
 		struct bt_bap_req *req = bap->req;
 
@@ -7028,26 +7348,76 @@ static bool match_name(const void *data, const void *match_data)
 	return (!strcmp(pac->name, name));
 }
 
+/* Remove the request matching id from a request and its group, if it is the
+ * leader the next member of the group is promoted.
+ */
+static struct bt_bap_req *bap_req_cancel(struct bt_bap_req *req,
+						unsigned int id)
+{
+	struct bt_bap_req *member;
+
+	member = queue_remove_if(req->group, match_req_id, UINT_TO_PTR(id));
+	if (member) {
+		bap_req_free(member);
+		return req;
+	}
+
+	if (req->id != id)
+		return req;
+
+	member = queue_pop_head(req->group);
+	if (member) {
+		member->group = req->group;
+		req->group = NULL;
+	}
+
+	bap_req_free(req);
+
+	return member;
+}
+
 int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
 {
-	struct bt_bap_req *req;
+	struct bt_bap *bap;
+	const struct queue_entry *entry;
 
 	if (!stream)
 		return -EINVAL;
 
-	if (stream->bap->req && stream->bap->req->id == id) {
-		req = stream->bap->req;
-		stream->bap->req = NULL;
-		bap_req_free(req);
-		return 0;
+	bap = stream->bap;
+
+	/* The outstanding request has already been sent, so only drop its
+	 * callback and keep waiting for its CP notification and ASE state
+	 * before sending the next request.
+	 */
+	if (bap->req) {
+		struct bt_bap_req *req = bap->req;
+
+		if (req->id != id)
+			req = queue_find(req->group, match_req_id,
+							UINT_TO_PTR(id));
+		if (req) {
+			req->func = NULL;
+			req->user_data = NULL;
+			return 0;
+		}
 	}
 
-	req = queue_remove_if(stream->bap->reqs, match_req_id,
-						UINT_TO_PTR(id));
-	if (!req)
-		return 0;
+	for (entry = queue_get_entries(bap->reqs); entry;
+						entry = entry->next) {
+		struct bt_bap_req *req = entry->data;
+		struct bt_bap_req *leader = bap_req_cancel(req, id);
 
-	bap_req_free(req);
+		if (leader == req)
+			continue;
+
+		if (leader)
+			queue_push_after(bap->reqs, req, leader);
+
+		queue_remove(bap->reqs, req);
+
+		break;
+	}
 
 	return 0;
 }
-- 
2.56.0

