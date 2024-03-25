Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC66FE2B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389147; cv=pass; b=PJmhoHBMLfqx1upMbclwIP5AjYYKAOrZyl84H9GBKBUFHxKlbT/k6aj9xvPHVf64X31kAZU2zfobMIwYNu4k0tVdB+lFuZA6HNT+T1gNSLQ5ZAanDsbSTnVsMjumTJ8LurFjzjTspp3yPmpzuYsADfMlAox0JK7tk6vnOK2ckNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389147; c=relaxed/simple;
	bh=WPvZDL5IZZefChWkGcPOjOrZHccDGBFdbXhG06JHjAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwNT6j9ay8tPLZv26SsPveapBQZfMAKxHD9pHW4hUDuICKWL9/svDbGbvPHRV4cAfSbXdlJpHY9eGTwOVcTYvh8MvWKRulnJSwTjOxIxvmMiBIaAG4cRgUbJfU9dETP7J4L8ETi/s02KB1vwTM3dnBSf7Q2D98t3a8m7gj6R4ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qZg8DXGq; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qZg8DXGq"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V3L9X1klRzyxb;
	Mon, 25 Mar 2024 19:52:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1711389136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/J3VaaaWhoxnZTTP23p9sDmoCMzw+7FmFPAVQjyIttA=;
	b=qZg8DXGqqNHOzj0oq8ceVPz+6h1df55caZjrEsp3XFDfR+C1A5yggA2nR2Z6Udq3qrzyEe
	6R3RJvuVrgGicv5HK+CVtqTKSOPMY0/k8iyolzwOLt0LJgpE3lapGWps0J+yFFcm3FiDqC
	qqKN8knds2CjuDsYKgO27C5/Qhxz74c=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1711389136; a=rsa-sha256; cv=none;
	b=vVZAU6Zu5I7CtX+cVCBxk4WFLIQ+MPliZtsmOwyP6C0OFhqxRkORLYbwVFOx7mRPhJXOiH
	+77u1bS5s5Sjf1CJjP5djEwFA0TCVq/3Xm5Nm6sBwluuTn1Gyr3GttXLAyGVXh2c8qD64J
	pgqXJspFYiG8L4fscE+ZJ8YqOx4JQho=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1711389136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/J3VaaaWhoxnZTTP23p9sDmoCMzw+7FmFPAVQjyIttA=;
	b=tIkUkN0AqwRfFx+00V/9803xsTf99svIxVYL7sjsE4JupgzN0YOZQcr2Yo7fGjxNGeEJzs
	/aDyQjtTTPbTJE4ruB24xp4pHvwY/6j7k3qqaw8mURRsUvfideMKksRG/LN9mKsneiFPSq
	5iG5/6rNzNbEee9F3Xv88IuMZ2GAbkE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/2] bap: cancel ongoing SelectProperties() before freeing the ep
Date: Mon, 25 Mar 2024 19:52:10 +0200
Message-ID: <46fbeabf3001a1f8111ca9661acb6b6805db685a.1711389066.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711389066.git.pav@iki.fi>
References: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711389066.git.pav@iki.fi>
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
 profiles/audio/media.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index edaff7867..144f6bfc4 100644
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
 
@@ -1028,6 +1033,34 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 								data, free);
 }
 
+static void pac_cancel_select(struct bt_bap_pac *lpac, bt_bap_pac_select_t cb,
+						void *cb_data, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	GSList *l = endpoint->requests;
+
+	while (l) {
+		struct endpoint_request *req = l->data;
+		struct pac_select_data *data;
+
+		if (req->cb != pac_select_cb) {
+			l = g_slist_next(l);
+			continue;
+		}
+
+		data = req->user_data;
+		if (data->pac != lpac || data->cb != cb ||
+						data->user_data != cb_data) {
+			l = g_slist_next(l);
+			continue;
+		}
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
@@ -1195,6 +1228,7 @@ static void pac_clear(struct bt_bap_stream *stream, void *user_data)
 
 static struct bt_bap_pac_ops pac_ops = {
 	.select = pac_select,
+	.cancel_select = pac_cancel_select,
 	.config = pac_config,
 	.clear = pac_clear,
 };
-- 
2.44.0

