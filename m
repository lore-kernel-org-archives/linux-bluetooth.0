Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F972DDC6
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Mar 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711186848; cv=pass; b=GtXZVHBCFgwB/ywXc6xD2knMKMluGIAmnFRZ0QQ5Rad2gf1BmS5m0rW03rJo/g2Br/fOqwNp87vcCP7sZXAkvdgpTg0yeZfryAOMEr9+3FazczmEiWwdhF6PpNHv/YrJzUeJwOCLpXibkqruC8wzSq9skjb6rGSbHmyuMWPV5lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711186848; c=relaxed/simple;
	bh=IoahIzyh8mp5DwtbrANedMi7XraiF9OX+0f3XYTrwh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN0FWTR8F0L/Mpt8OJ4zqrbStlJ8xRPGWgkYf7SFxJ4YpkDi8KYKL7849dLbC0ptKXhdKh0RbC4z22sLe3AW/JgO4pmckaqjELiAdjLEKJ+S+IenS+AR83KRkSFVqggY0er/9AvCOZ5Hmzy/PYCHutro/trEIgOj3Zg+WvFuUAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=aGUzEeKq; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="aGUzEeKq"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V1vMJ1FsXz49Q4s;
	Sat, 23 Mar 2024 11:40:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1711186844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXWD/cxWqBNk5N0RGe8RUAlES24dHBrTtZjsPePdrr4=;
	b=aGUzEeKqXtnle7PIaZutm24DxpXNtu0jTKSPiTHR21yq7K2fURwfljys1ANNSlNJJzr5Mj
	NVxmcAZITELccV5VsTGe3jMG/iuQd/7RVTlajjpZKyDBoNaiNJL2jGpatfdpDK8qGBzqvj
	Xd6H866RoBPwlu601FefHQBowCWnyyF4JXQVQA/x9W5pWfWLkQsjODszq2ZENphuXC6N9O
	gMXwAYM63kPPOoWletJJluyByhbDy7MDsboD060dRrXfg4vti/xmHgEowy+J+TKVk2VZmS
	qESzQchdiJfwDG1pfGk76VZjdg4bza0h3eeS0gp+eT+AO9zeK0RZkc6kNkYJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1711186844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXWD/cxWqBNk5N0RGe8RUAlES24dHBrTtZjsPePdrr4=;
	b=cUxtbaplq1SHzxeGfwgp0aVlDw7asIAAC5u44YeoET6QqavqsNLeTfM+Ed8Ma/u35sLl0P
	0CmcOJsKj4pQk4M0UpEKhLfLrA7dfDlF7k4vHo4RELaTqUZjTxZf8OeMXN5JujMsfAV3CA
	QfoJX3W5HTc2wzpIUc3+MrMcTEoJC9r3mQbUYaIitq49ODVLwQw+kqpyV1fhBQfuCnrs/O
	j8AnEH6gmJW1WepMpG++XezwoZDxZiI35hwcRdMzqCQLyMTU3N9BzeN1v2nUKosVczl6Ei
	kEHBjAFr1RHI9ALd4qM4HeM3FZyuheir5G4ThC1KX1H/j0yHxw9kORWtW9TYEQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1711186844; a=rsa-sha256;
	cv=none;
	b=Xh4gX3jWbCBcYxiy2kGFsKctsv/Q+JzbSLETzTUJYFtdyej7LQQiXUYU7NtyZHTfs3mS3L
	GBmCWXcd4kDIziszCe9FjqES7QjnXeR8aJxiZBvcyQzhdUuXontSGbE+G5+yMpxl351Rjs
	qvkvO7SgCq1EgcTnpLiIQA0QR5jlybalIwsmkwkKpKhKKLKYvU+Vm8KwF61iVRBqVK4vkk
	n0DMcabvCJs+RndvszkHDUAYtahPDYAvldXnlP5dRZ7Q2evvr+gQSJkGUL3SHxqq4J2zEw
	AFTftQrQdVr1hG2AK1kEsdb8C8YJelxiyI44/57X91CYK2eZWVAdg8AyuDqCTw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] bap: cancel ongoing SelectProperties() before freeing the ep
Date: Sat, 23 Mar 2024 11:40:40 +0200
Message-ID: <ad76621e8c2d414989b4eb384cb9077ca55cb16d.1711186824.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711186824.git.pav@iki.fi>
References: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711186824.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

select_cb() callback is called when the sound server replies. However,
at that point the ep or session for which it was made may already be
gone if e.g. device disconnects or adapter is powered off.

Fix by implementing cancelling select() callbacks, and doing it before
freeing ep.

Fixes crash:

==889897==ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x60400006b098 thread T0
    #0 0x55aeba in setup_new profiles/audio/bap.c:840
    #1 0x562158 in select_cb profiles/audio/bap.c:1361
    #2 0x47ad66 in pac_select_cb profiles/audio/media.c:920
    #3 0x47661b in endpoint_reply profiles/audio/media.c:375
    ...
freed by thread T0 here:
    #0 0x7fd20bcd7fb8 in __interceptor_free.part.0
    #1 0x55f913 in ep_free profiles/audio/bap.c:1156
    #2 0x7d696e in remove_interface gdbus/object.c:660
    #3 0x7de622 in g_dbus_unregister_interface gdbus/object.c:1394
    #4 0x554536 in ep_unregister profiles/audio/bap.c:193
    #5 0x574455 in ep_remove profiles/audio/bap.c:2963
    #6 0x7f5341 in queue_remove_if src/shared/queue.c:279
    #7 0x7f5aba in queue_remove_all src/shared/queue.c:321
    #8 0x57452b in bap_disconnect profiles/audio/bap.c:2972
    #9 0x6cd107 in btd_service_disconnect src/service.c:305
    ...
previously allocated by thread T0 here:
    #0 0x7fd20bcd92ef in malloc
    #1 0x7f6e98 in util_malloc src/shared/util.c:46
    #2 0x560d28 in ep_register profiles/audio/bap.c:1282
    #3 0x562bdf in pac_register profiles/audio/bap.c:1386
    #4 0x8cc834 in bap_foreach_pac src/shared/bap.c:4950
    #5 0x8cccfc in bt_bap_foreach_pac src/shared/bap.c:4964
    #6 0x56330b in bap_ready profiles/audio/bap.c:1457
    ...
---
 profiles/audio/bap.c   | 22 ++++++++++++++++++++++
 profiles/audio/media.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 315eff729..fdce275c9 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1148,11 +1148,15 @@ static const GDBusMethodTable ep_methods[] = {
 	{ },
 };
 
+static void ep_cancel_select(struct bap_ep *ep);
+
 static void ep_free(void *data)
 {
 	struct bap_ep *ep = data;
 	struct queue *setups = ep->setups;
 
+	ep_cancel_select(ep);
+
 	ep->setups = NULL;
 	queue_destroy(setups, setup_free);
 	free(ep->path);
@@ -1426,6 +1430,24 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
+static bool pac_cancel_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+							void *user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	bt_bap_cancel_select(lpac, select_cb, ep);
+
+	return true;
+}
+
+static void ep_cancel_select(struct bap_ep *ep)
+{
+	struct bt_bap *bap = ep->data->bap;
+
+	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_cancel_select, ep);
+	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_cancel_select, ep);
+}
+
 static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							void *user_data)
 {
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index edaff7867..3c5daf782 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -149,6 +149,11 @@ static void media_endpoint_cancel(struct endpoint_request *request)
 {
 	struct media_endpoint *endpoint = request->endpoint;
 
+	DBG("Canceling %s: name = %s path = %s",
+			dbus_message_get_member(request->msg),
+			dbus_message_get_destination(request->msg),
+			dbus_message_get_path(request->msg));
+
 	if (request->call)
 		dbus_pending_call_cancel(request->call);
 
@@ -1028,6 +1033,30 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 								data, free);
 }
 
+static void pac_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t cb,
+						void *cb_data, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	GSList *l;
+
+	for (l = endpoint->requests; l; l = g_slist_next(l)) {
+		struct endpoint_request *req = l->data;
+		struct pac_select_data *data;
+
+		if (req->cb != pac_select_cb)
+			continue;
+
+		data = req->user_data;
+		if (data->pac != lpac || data->cb != cb ||
+						data->user_data != cb_data)
+			continue;
+
+		req->cb = NULL;
+		media_endpoint_cancel(req);
+		l = endpoint->requests;
+	}
+}
+
 struct pac_config_data {
 	struct bt_bap_stream *stream;
 	bt_bap_pac_config_t cb;
@@ -1195,6 +1224,7 @@ static void pac_clear(struct bt_bap_stream *stream, void *user_data)
 
 static struct bt_bap_pac_ops pac_ops = {
 	.select = pac_select,
+	.cancel_select = pac_cancel_select,
 	.config = pac_config,
 	.clear = pac_clear,
 };
-- 
2.44.0

