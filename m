Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737841;
	b=WU/fDUv6jD+46yLMfbZ3Yto1oy7eIIQ6fnTTff3SIAFBfaDbUHvcsEghU1aip9qPnYLv
	 lBgEaKtoXxUdDIphLK1EkkZCHBPs/rPsoYBkiIwZxYhpFWZnMTcNwTI/UYlr63kYNgaDc
	 RWxvwvVj2GM5YpBNANcmUgGEmvfml6V6avErT/gPT+PD75JNw1gKnFvl0GjXRMFaeLJBD
	 ah26qUFJc3NwsONUTgGkIPM4F+Bs8EjBgL8+EcMJDnsMu8khgnjIb1u0aOtw7BsA7I1oC
	 bjXFyHw2Cx/D9iF7XpX00K4aA0N8pxB+EgoanICQkhG631OjxbSNRGAMDf+IOlPOlTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fZ+B3O7MhOD3TlVcYktBa/Tvb6Ay5D11vBT6PONzzj4=;
	b=sjHgDuji9MK9LzLw2p1UBivujnQ9LThjWYCZOItxZf1JKd77N+2ELZCHGfHJGjzJiFNm
	 IiQ4lIXU3sxS0YWbVtYsh/gHyQhiugDYJsy8YENneTZPFmZwZtZ9nMjiHquBF/0QxP0p5
	 tUwYgS2qBhitvCEoBDdFjSRuGSGjDViZaJm/tEZ1sInkR71xfH4aj+96xapja0RXiiO8Y
	 f7YXRQ7zyxIh7hls1w0ZkOJ1FBkUOVUs7wpE4nFL8j9g6urYX5YcFieeQ7u1vVBprZfeg
	 3tm3PWH5CQqZ7rfePShrlwIzEmw7OZEcognWOymTWYjGuOF5A+IQPcgbGQV44ZpYZug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtCYIAAo;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72981606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72981606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PtCYIAAo
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-998318396ecso5718241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737840; x=1794342640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fZ+B3O7MhOD3TlVcYktBa/Tvb6Ay5D11vBT6PONzzj4=;
        b=PtCYIAAomJPPcmPyx+GVJnsr+up5jPJl9m23CIJ7Pze1o9UCbr1gvl8njkCsALKRTE
         1pBPvu/CucORHD8bbvHqo+GuboZwsnz3gbeSMkyAqB9FxFj6mesROqY53fzREwT7S30P
         Y/8BpSsh1GuXbxv/EpZuoMC9KPqqB/7fyirJzdp6cVftKmaeGPPN7CVUXZ/dh37wO5uQ
         o8/aNPYENtHs2ekaONhx2YWVdld03JU3QyZbJ7O4Eh5rCeoxwZzU2TqO2tP3sjmhrmGv
         Mg7vzp1zW60j8xzwikHkt2+zYyn1IvBti6csVScpjbJouESaemqrF6wmizId8fxKQwqm
         WznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737840; x=1794342640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fZ+B3O7MhOD3TlVcYktBa/Tvb6Ay5D11vBT6PONzzj4=;
        b=0vGFyPruqyEHSX5XOuVua6kpsYLzn8e+xFUtTS7wM+XX9EcsTRHwzkMDWNKwdFkVlI
         v+2EzJh35GBkbqGbXK/WQ5s+NrfcSenFQ2Wpw4ejsepCu1vhpXUz6Eq8to6h4z9PXdVE
         F3J2/s5OItWxaT8Z1NqtncrIVyBSZDYsNIv4c4m/8KuaXZPK7J0JMpvmX3kmVLC2mNhk
         3UTCs2AyrqcL6ch7s6fqewWgZNnnY2dFhdAnyAlKE8+wKvQg46t8oDYuMsMVbqJXAJq+
         fLhuJ0x4EUOcYxStcb2HghCppKuQAei0l/AD5yK9BFkWz4F2rKRjegeW182j8VnLrsMj
         PLAQ==
X-Gm-Message-State: APuU4Z/WdnDynrCDHRMcvoYHvfM8XLREKjGtXpWgXm+yjcJD/aYmuyVN
	uXqMAhu092MkOgMyEg35tbNdmi5Yc+nkrKxcBLEx/cWCmpIvja6To3/ekSaRCg==
X-Gm-Gg: AYBFou0uYndY6YX7nYBtzuw/DXLbfIkFPlEvn9O9K/WrAurgdMdfm8HfrzfbQQQ4Txk
	RMTMXfOCEATsBkWVSFDp2JzXSSHVgROT/btpgbCw1Zb7XkHzsQXmd+TI//Yv1yVpPXw3CWeNzJY
	mBsLRVa7EUoHXCNHvseFRXJTbsTq09BGSI57eHFAl06DucQWfyBbWvGIQyVXKYGmJZiQdWnvyh+
	98FXpGVOf7nUt7qoPRKmBX/d+2KGyGrJm+vTxjaFmQ4DHc2JMLeL5Q0nKrohzq2jwwmv5TpQ7Dr
	RhNPOZd1Bha9QdI0ByYkCfh+7gJ8CKGpAMWRbwWNLQ8WFfp9IC0hrJaFWaBJF7RvgJRvrZifG3U
	a9prXjaWXtcH9edMIlA3yAwE2xQ4PejiQ435Ce5yxYG8lc98/amwH6hw/mY+ntIPkfrEAqTH/SV
	hBMGPqneDMsZjc3DU0sej2i1Nj99/XIse90ar+DiFKXJsNer2m7JRKTr+LJJZH4cst6Tyo9GqpI
	FL3vgqzTiDECYkxpx/cj34gEf0am4Lw3GmfDKzsUEC8rpnLuayC3j1orc16btgvEh0T0z6CqdLZ
	PJ6jd1zhZtnOHycWncuQu4CEoQMceuhDV+tbP0mo3F3ZfYGE/VjntNAm4DoY1r/JT1iXHLuNley
	IsLpCT2VL/K4/AZxo5RFizI5Sv5Zo0h6MGnJmhhFfv0d/hgPWx15JahXtmWZd4znKgKdshWPbj+
	sMyQ1M
X-Received: by 2002:a05:6102:6449:b0:7a2:7ccd:280d with SMTP id ada2fe7eead31-7d072bb31cbmr4921466137.8.1793737840224;
        Tue, 03 Nov 2026 12:30:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af021sm167865241.1.2026.11.03.12.30.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/5] shared/gatt-server: Add bt_gatt_server_set_mnotify_timeout
Date: Tue,  3 Nov 2026 15:30:32 -0500
Message-ID: <20261103203034.3904499-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203034.3904499-1-luiz.dentz@gmail.com>
References: <20261103203034.3904499-1-luiz.dentz@gmail.com>
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

This adds bt_gatt_server_set_mnotify_timeout which can be used to
control the timeout used to aggregate notifications into a Notify
Multiple PDU, a negative value disables Notify Multiple so regular
notifications are always used.

The default timeout is changed from 10 ms to 0 so only notifications
queued in the same mainloop cycle are aggregated, since the former adds
latency which may be undesirable for e.g. HID.

While at it, rename the nfy_mult/notify_multiple identifiers to mnotify.
---
 src/shared/gatt-server.c | 87 +++++++++++++++++++++++++---------------
 src/shared/gatt-server.h |  3 ++
 2 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index fde791aae867..15944bd1478f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -32,7 +32,7 @@
  */
 #define DEFAULT_MAX_PREP_QUEUE_LEN 30
 
-#define NFY_MULT_TIMEOUT 10
+#define MNOTIFY_TIMEOUT 0
 
 #define DBG(_server, _format, arg...) \
 	gatt_log(_server, "%s:%s() " _format, __FILE__, __func__, ## arg)
@@ -73,7 +73,7 @@ static void prep_write_data_destroy(void *user_data)
 	free(data);
 }
 
-struct nfy_mult_data {
+struct mnotify_data {
 	unsigned int id;
 	uint8_t *pdu;
 	uint16_t offset;
@@ -114,20 +114,21 @@ struct bt_gatt_server {
 	bt_gatt_server_authorize_cb_t authorize;
 	void *authorize_data;
 
-	struct nfy_mult_data *nfy_mult;
+	struct mnotify_data *mnotify;
+	int mnotify_timeout;
 };
 
-static void notify_multiple_free(struct bt_gatt_server *server)
+static void mnotify_free(struct bt_gatt_server *server)
 {
-	if (!server->nfy_mult)
+	if (!server->mnotify)
 		return;
 
-	if (server->nfy_mult->id)
-		timeout_remove(server->nfy_mult->id);
+	if (server->mnotify->id)
+		timeout_remove(server->mnotify->id);
 
-	free(server->nfy_mult->pdu);
-	free(server->nfy_mult);
-	server->nfy_mult = NULL;
+	free(server->mnotify->pdu);
+	free(server->mnotify);
+	server->mnotify = NULL;
 }
 
 static void bt_gatt_server_free(struct bt_gatt_server *server)
@@ -135,7 +136,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	if (server->debug_destroy)
 		server->debug_destroy(server->debug_data);
 
-	notify_multiple_free(server);
+	mnotify_free(server);
 
 	bt_att_unregister(server->att, server->mtu_id);
 	bt_att_unregister(server->att, server->read_by_grp_type_id);
@@ -1681,6 +1682,7 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
 	server->prep_queue = queue_new();
 	server->min_enc_size = min_enc_size;
+	server->mnotify_timeout = MNOTIFY_TIMEOUT;
 
 	if (!gatt_server_register_att_handlers(server)) {
 		bt_gatt_server_free(server);
@@ -1753,31 +1755,48 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 	return true;
 }
 
-static void notify_multiple_timeout_remove(struct bt_gatt_server *server)
+static void mnotify_timeout_remove(struct bt_gatt_server *server)
 {
-	if (!server->nfy_mult->id)
+	if (!server->mnotify->id)
 		return;
 
-	timeout_remove(server->nfy_mult->id);
-	server->nfy_mult->id = 0;
+	timeout_remove(server->mnotify->id);
+	server->mnotify->id = 0;
 }
 
-static bool notify_multiple(void *user_data)
+static bool mnotify_send(void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 
-	server->nfy_mult->id = 0;
+	server->mnotify->id = 0;
 
 	bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY_MULT,
-			server->nfy_mult->pdu, server->nfy_mult->offset, NULL,
+			server->mnotify->pdu, server->mnotify->offset, NULL,
 			NULL, NULL);
 
-	notify_multiple_free(server);
+	mnotify_free(server);
 
 	return false;
 }
 
-static bool notify_append_le16(struct nfy_mult_data *data, uint16_t value)
+bool bt_gatt_server_set_mnotify_timeout(struct bt_gatt_server *server,
+							int timeout)
+{
+	if (!server)
+		return false;
+
+	server->mnotify_timeout = timeout;
+
+	/* Flush any pending data if Notify Multiple is being disabled */
+	if (timeout < 0 && server->mnotify) {
+		mnotify_timeout_remove(server);
+		mnotify_send(server);
+	}
+
+	return true;
+}
+
+static bool notify_append_le16(struct mnotify_data *data, uint16_t value)
 {
 	if (data->offset + sizeof(value) > data->len)
 		return false;
@@ -1792,27 +1811,31 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
 					uint16_t length, bool multiple)
 {
-	struct nfy_mult_data *data = NULL;
+	struct mnotify_data *data = NULL;
 	bool result;
 
 	if (!server || (length && !value))
 		return false;
 
+	/* Notify Multiple disabled, send as regular notification */
+	if (server->mnotify_timeout < 0)
+		multiple = false;
+
 	if (multiple) {
-		data = server->nfy_mult;
+		data = server->mnotify;
 
 		/* flush buffered data if this request hits buffer size limit */
 		if (data && data->offset > 0 &&
 				data->len - data->offset < 4 + length) {
-			notify_multiple_timeout_remove(server);
-			notify_multiple(server);
-			/* data has been freed by notify_multiple */
+			mnotify_timeout_remove(server);
+			mnotify_send(server);
+			/* data has been freed by mnotify_send */
 			data = NULL;
 		}
 	}
 
 	if (!data) {
-		data = new0(struct nfy_mult_data, 1);
+		data = new0(struct mnotify_data, 1);
 		data->len = bt_att_get_mtu(server->att) - 1;
 		data->pdu = malloc(data->len);
 	}
@@ -1834,13 +1857,13 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	data->offset += length;
 
 	if (multiple) {
-		if (!server->nfy_mult)
-			server->nfy_mult = data;
+		if (!server->mnotify)
+			server->mnotify = data;
 
-		if (!server->nfy_mult->id)
-			server->nfy_mult->id = timeout_add(NFY_MULT_TIMEOUT,
-						   notify_multiple, server,
-						   NULL);
+		if (!server->mnotify->id)
+			server->mnotify->id = timeout_add(
+						server->mnotify_timeout,
+						mnotify_send, server, NULL);
 
 		return true;
 	}
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index ea49f2960d71..b024258cd186 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -43,6 +43,9 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
 					uint16_t length, bool multiple);
 
+bool bt_gatt_server_set_mnotify_timeout(struct bt_gatt_server *server,
+							int timeout);
+
 bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
 					uint16_t length,
-- 
2.56.0

