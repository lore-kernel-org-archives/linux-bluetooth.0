Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E20E19478
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Mar 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710602674; cv=pass; b=puyIn2HpC4U3mfRVaEPG7bjkXvA1oQu5GkYqt1RBViGOzGFsVQ+7QnFbj6JNBASY9J6pc8t4PoB2ddxqmDYfI9PWxkUtuWOViOAzrQnjPAPNjW/xM+ck1axRtLJyRZk4c2rD/LC4fyPC7Nl8tr4OX332oaj6RMpjgR1Y2dWBGyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710602674; c=relaxed/simple;
	bh=1w3U2f0P5rOZuMN+SKcfsjQMowqlvjzKZxjp4a+W22w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwjsfNrlijEnJQ1JRqDjR5SrecyLkA0TCA3QeA3IhdwCGh9gGO70vI7tAMsre1Uu5EcbkvWkedTj8zbyLeGVVRCuTUUAaW5RcfxtvClrFJZPbw3kc5as/8TtpFPXN+VM/C4z6KyqBpxDOPCfDrBi2iiHdqmeiCZ4x3NSNMpR3ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=LYGmJg0E; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="LYGmJg0E"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TxlJy5MJWz49Psp;
	Sat, 16 Mar 2024 17:24:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710602659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lgboKiOsndZEvO1KGG+JF0uguG/iUIyrUW16ETcmOCs=;
	b=LYGmJg0E1wl5msrG0NzgEO3oR577j3uYx9Px3RJ6wIeFzj5ywQZQefQWQ2qC+84aSXUUNz
	IXr+TqyIvWQwkWCNlrHxVZrw42sJKNDBzsEeXj4n5qz/+L139JT29yPgL5635Uf6BGdW4E
	PisDrSFUqJye9vCEMAfi63MzrFHYvaIKFFT4BlDKx2DuHBgckuv5jwMLJE9zR8ehzVu+8L
	pAbI0NllzzcyBh+fJ9ePoukkHQ9On+ivLOWTxpg0X/9rAP7VKL/QeIXaZttiwu99wPzUlf
	j2koguIiTuERQYqEWW2fdtITGPGVz7insUAdxQEvBU8uaytGp477a9Q9PYMWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710602659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lgboKiOsndZEvO1KGG+JF0uguG/iUIyrUW16ETcmOCs=;
	b=GSo+WDgs0lnqFgboiItO2Rk46tud0FpcIBFVQHVZoIZuJXFvno5RCXMQLlJ+hw1EjLbNy+
	P5YYxfX6gc+3vubXKtXuySimYBM/p+agJGiT1kuO6we+JSEPNh/p+N/5OpwGY3O3XfWKGV
	FbkvCm06ZGAWwwsS0AeU99/b3N8g9JdzBWMgbK5Qjb62re/m91Ra0zPXYkAb9t7aemHB2W
	rApkGpDNxCCES+930e3jrsNAZr0Euq4C//QNhWvvg1x9EFj5pJFprelmzqzJhgqda9BoM/
	5P5nUj17g60S6wJepDPxwYOGXG5tHd0ecqx7FLTWfYDr/fnLt4juaeVq1q89SQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710602659; a=rsa-sha256;
	cv=none;
	b=tVwsxfLlhKow2HuSOrTtMI6n4zrJDzIYYYJWWlTfT0rdJE/+KeNTbybJXcyXBDqyQnsCKH
	WNVT1hjBfVpJqECzry0m7nuTJk1oFQ8P87VOKW42hIXjzus4kMXvTT2/cXwFZLaFrSuzyL
	dtGPyILZAZ4UTm8/vjw9ArRXWswTnn9qcsSqgghc5RZ57AjUfDggHU4seHNHEyrrDXB0jX
	k/hxtUeRMeHux/Bl1TJCp2mxbLQBFXQDnzyMDaAF4bI0S9I8RGVT9E1KiV9mV/p1cxEtJM
	kW73mHMBmIZBtwsm6GnmAOhsh/C6Jp4qCBenc15CGM0wblXrFgBucxy6rLkSxQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] bap: handle ep or session freed before select_cb returns
Date: Sat, 16 Mar 2024 17:24:12 +0200
Message-ID: <90670acf017c4fb5a4ef4dba4b666c1307e9de5c.1710602216.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
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

Track pending select_cb() callbacks, and mark them canceled when ep /
session goes away.

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
 profiles/audio/bap.c | 81 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 964ba9c21..6c74760c2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -95,6 +95,12 @@ struct bap_ep {
 	struct queue *setups;
 };
 
+struct bap_select {
+	int ref_count;
+	struct bap_data *data;
+	struct bap_ep *ep;
+};
+
 struct bap_data {
 	struct btd_device *device;
 	struct btd_adapter *adapter;
@@ -107,8 +113,8 @@ struct bap_data {
 	struct queue *snks;
 	struct queue *bcast;
 	struct queue *streams;
+	struct queue *selecting;
 	GIOChannel *listen_io;
-	int selecting;
 	void *user_data;
 };
 
@@ -194,6 +200,14 @@ static void ep_unregister(void *data)
 						MEDIA_ENDPOINT_INTERFACE);
 }
 
+static void bap_cancel_select(void *data)
+{
+	struct bap_select *sel = data;
+
+	sel->data = NULL;
+	sel->ep = NULL;
+}
+
 static void bap_data_free(struct bap_data *data)
 {
 	if (data->listen_io) {
@@ -210,6 +224,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->streams, NULL);
+	queue_destroy(data->selecting, bap_cancel_select);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
@@ -1148,11 +1163,21 @@ static const GDBusMethodTable ep_methods[] = {
 	{ },
 };
 
+static void ep_cancel_select(void *data, void *user_data)
+{
+	struct bap_select *sel = data;
+
+	if (sel->ep == user_data)
+		sel->ep = NULL;
+}
+
 static void ep_free(void *data)
 {
 	struct bap_ep *ep = data;
 	struct queue *setups = ep->setups;
 
+	queue_foreach(ep->data->selecting, ep_cancel_select, ep);
+
 	ep->setups = NULL;
 	queue_destroy(setups, setup_free);
 	free(ep->path);
@@ -1348,16 +1373,29 @@ static void bap_config(void *data, void *user_data)
 	queue_foreach(ep->setups, setup_config, NULL);
 }
 
+static void select_count(void *data, void *user_data)
+{
+	struct bap_select *sel = data;
+	int *count = user_data;
+
+	*count += sel->ref_count;
+}
+
 static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 				struct iovec *metadata, struct bt_bap_qos *qos,
 				void *user_data)
 {
-	struct bap_ep *ep = user_data;
+	struct bap_select *sel = user_data;
+	struct bap_data *data = sel->data;
+	struct bap_ep *ep = sel->ep;
 	struct bap_setup *setup;
+	int count = 0;
+
+	if (!data || !ep)
+		err = ECANCELED;
 
 	if (err) {
 		error("err %d", err);
-		ep->data->selecting--;
 		goto done;
 	}
 
@@ -1366,16 +1404,23 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 	setup->metadata = util_iov_dup(metadata, 1);
 	setup->qos = *qos;
 
-	DBG("selecting %d", ep->data->selecting);
-	ep->data->selecting--;
+	queue_foreach(data->selecting, select_count, &count);
+
+	DBG("selecting %d", count);
 
 done:
-	if (ep->data->selecting)
+	if (sel->ref_count-- <= 1) {
+		if (data)
+			queue_remove(data->selecting, sel);
+		free(sel);
+	}
+
+	if (!data || !queue_isempty(data->selecting))
 		return;
 
-	queue_foreach(ep->data->srcs, bap_config, NULL);
-	queue_foreach(ep->data->snks, bap_config, NULL);
-	queue_foreach(ep->data->bcast, bap_config, NULL);
+	queue_foreach(data->srcs, bap_config, NULL);
+	queue_foreach(data->snks, bap_config, NULL);
+	queue_foreach(data->bcast, bap_config, NULL);
 }
 
 static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1420,8 +1465,21 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	}
 
 	/* TODO: Cache LRU? */
-	if (btd_service_is_initiator(service))
-		bt_bap_select(lpac, rpac, &ep->data->selecting, select_cb, ep);
+	if (btd_service_is_initiator(service)) {
+		struct bap_select *sel;
+
+		sel = new0(struct bap_select, 1);
+		sel->ep = ep;
+		sel->data = ep->data;
+		sel->ref_count = 0;
+
+		bt_bap_select(lpac, rpac, &sel->ref_count, select_cb, sel);
+
+		if (sel->ref_count)
+			queue_push_tail(ep->data->selecting, sel);
+		else
+			free(sel);
+	}
 
 	return true;
 }
@@ -2495,6 +2553,7 @@ static struct bap_data *bap_data_new(struct btd_device *device)
 	data->srcs = queue_new();
 	data->snks = queue_new();
 	data->bcast = queue_new();
+	data->selecting = queue_new();
 
 	return data;
 }
-- 
2.44.0

