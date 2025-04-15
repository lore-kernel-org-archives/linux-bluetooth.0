Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E379255250
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753712; cv=none; b=bYRqhqo5p2cw4xFTcg3twOCVZWWwoAVdWtN0NjH24athEho1CKDJKx32PMKkMd+UUWw1+iwfUCGoSmRLBSpGkvLG4of2LXiO/JXO67K1Crybrx9JPNi9BZrBkfZ3IXjGqTsKJlqx2nBdRVihePm708gPJS08EhIdRjaqDnjF/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753712; c=relaxed/simple;
	bh=SgsqgNkKR4j4LHuhbEW86j7JDfMHKDH4y6mzvihBRj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvDW7XLoxDH7hINlHUS8d98x3fWGVWXzb4PiClOq2jN8ltiaR5fuG5fC9+xye/5bGDvRfoFdh1z7TyIzzrNgbpAESYoQ0vdikcZk6iejxqn96S6BsqfcvKtl/+xzl0EtmibNOXkKAwFyBMQZ0+mC0yPLZQQ88a3qRU6G+k1hPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsXC3ENH; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsXC3ENH"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52403e39a23so4421008e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744753708; x=1745358508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYO8tePVhqNcc/Lq2pqvHjQYNefQ+Sf1a7mfkT1hWBo=;
        b=bsXC3ENHroY0VrNeqmX7uC6u30p7dRwY8PYLYFRRFVYKVOe291pixgj1V5/vxMoS1V
         YwXzmXzNmiNEcSiem7fKluDjtyrJvJSaSYLW+MAARx/+ksspCwwSazOmjv/RRyd0hI7r
         8C9mJCKUSHmhx/pP5UrXLgjPl/J5LeXghLGsTU3nXF4IOhF04wTgbCy6WVDMNg4dOGoN
         ACIT4U4CftaTEiNAsDEnVOUnyPw7r/n/rF+D6u26tuvtFIyYDAPWkDtmdPWqVnBggdtv
         NAihnelQJDxG9M6uvrWtmxvQg50aNHzoVE0YwPNU1XkbLV0Q1+jaMjg59lk88p3/m0wW
         vmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744753708; x=1745358508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYO8tePVhqNcc/Lq2pqvHjQYNefQ+Sf1a7mfkT1hWBo=;
        b=ewQrCdaAkN73nfEzlt44RtEBmGJCDuUi0u0sm7BGjyVtMtzZWHJ358exu5YIYC6+5z
         +Ffrzs7Tasfob8ATxxaFoDFcfqmmhR/Ath3q5NkYMmNAJ3NZK+bGUIoD3MbN+NctZQLC
         HRnXUZAmJWq/qN2qsKPjcGinJFVqAJJic8W3CNPh14A+sO18n63EW+4Q+Yn+wjZy2d+y
         fQtidt0akRau6N5aSoV5dfe4puhwoVqC1LkTmi7Ju9hePHrj6LcAbpYY+tBuiMsqnqr3
         3CuvmT+WBnIzt4AwFfCEAkx+eanbZblUfd9EFxb2RXJJVfC34fj6dvpGgFitnUE/0qkO
         KnuA==
X-Gm-Message-State: AOJu0YxULbN3ZecXK0T8qhh8Kjy8cc5hBP1QzLypa1tZlT/pLUHqNcEF
	59dMR0Gsom6VhelEyBUaVM6BxSZqL5GBYT3TxiJ4wSQ9Vs2CkkwrF7C6YhoSPXA=
X-Gm-Gg: ASbGnctHeh+LrLED+7kZBlHHRiQGVmgaCWAQuJ4TyimbUzlPlLUO8DHyUQtQZwz05fu
	hzccU5JiP7rHTG/MOQrlGLQH803fw7/xLE3sME99NFbkZ7u3KwuSuJ1ez7U9965ToBtVuDdCGOV
	NCFbUxosR4MPDE4S9HUS7n0RwTfK7YsB2cITHp7yQ8mE2Qb0rS3EcRZZz4trgbuMWIuuvORmLn/
	BIymKZ7Frqi/LrWjXe+kWbZVzYcWmBWTYkSytpx5Jq5iwKMk0eYUnC7iIrDzDJi4k5j1xybrb/Y
	dStU9DzqG/hy/NG5Dg2UrhmpeiZiFZk+dl17Zd8Txpi9Z9qB28gUCB8lAYatzISwAQo8ao1GZG+
	x26BmJiJ91g==
X-Google-Smtp-Source: AGHT+IGM5Uh4h1J1TFcFtPlTlH+aXmS4pEQxEHovfD8IU5XEE90wp7RGw1mlHqSmZO2+SDlVxacVAA==
X-Received: by 2002:a05:6122:20a7:b0:526:1d98:b046 with SMTP id 71dfb90a1353d-52908f9973fmr797743e0c.0.1744753708313;
        Tue, 15 Apr 2025 14:48:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d740sm2844459e0c.33.2025.04.15.14.48.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 14:48:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/7] bap: Add support for using SID for broadcast receiver
Date: Tue, 15 Apr 2025 17:48:10 -0400
Message-ID: <20250415214811.1677842-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415214811.1677842-1-luiz.dentz@gmail.com>
References: <20250415214811.1677842-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Broadcast receiver needs to set the SID of the advertisement, for now
that is done by using 0xff which indicates to the kernel to perform to
discover what is the actual SID in use over the air.
---
 profiles/audio/bap.c  | 30 +++++++++++++++++-------------
 profiles/audio/bass.c | 19 ++++++++++++-------
 src/shared/bap.c      | 11 ++++++-----
 src/shared/bap.h      | 13 +++++++------
 4 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 24763666ce96..88d17058592b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -74,6 +74,7 @@ struct bap_setup {
 	unsigned int io_id;
 	bool recreate;
 	bool cig_active;
+	uint8_t sid;
 	struct iovec *caps;
 	struct iovec *metadata;
 	unsigned int id;
@@ -1053,8 +1054,9 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 }
 
 static void create_stream_for_bis(struct bap_data *bap_data,
-		struct bt_bap_pac *lpac, struct bt_bap_qos *qos,
-		struct iovec *caps, struct iovec *meta, char *path)
+				struct bt_bap_pac *lpac, uint8_t sid,
+				struct bt_bap_qos *qos, struct iovec *caps,
+				struct iovec *meta, char *path)
 {
 	struct bap_setup *setup;
 
@@ -1072,6 +1074,7 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	setup->stream = bt_bap_stream_new(bap_data->bap,
 			lpac, NULL, &setup->qos, caps);
 
+	setup->sid = sid;
 	bt_bap_stream_set_user_data(setup->stream, path);
 	bt_bap_stream_config(setup->stream, &setup->qos,
 			caps, NULL, NULL);
@@ -1079,29 +1082,27 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 			NULL, NULL);
 }
 
-static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
-	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
+static void bis_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
+			struct iovec *caps, struct iovec *meta,
+			struct bt_bap_qos *qos, void *user_data)
 {
 	struct bap_data *data = user_data;
 	struct bt_bap_pac *lpac;
 	char *path;
 
-	bt_bap_bis_probe(data->bap, bis, sgrp, caps, meta, qos);
+	bt_bap_bis_probe(data->bap, sid, bis, sgrp, caps, meta, qos);
 
 	/* Check if this BIS matches any local PAC */
-	bt_bap_verify_bis(data->bap, bis,
-			caps, &lpac);
+	bt_bap_verify_bis(data->bap, bis, caps, &lpac);
 
 	if (!lpac)
 		return;
 
-	if (asprintf(&path, "%s/bis%d",
-			device_get_path(data->device),
-			bis) < 0)
+	if (asprintf(&path, "%s/sid%d/bis%d", device_get_path(data->device),
+			sid, bis) < 0)
 		return;
 
-	create_stream_for_bis(data, lpac, qos,
-			caps, meta, path);
+	create_stream_for_bis(data, lpac, sid, qos, caps, meta, path);
 }
 
 static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
@@ -1113,12 +1114,14 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	struct bt_iso_qos qos;
 	struct iovec iov;
 	struct bt_bap_qos bap_qos = {0};
+	uint8_t sid;
 
 	DBG("BIG Info received");
 
 	bt_io_get(io, &err,
 			BT_IO_OPT_BASE, &base,
 			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_ISO_BC_SID, &sid,
 			BT_IO_OPT_INVALID);
 	if (err) {
 		error("%s", err->message);
@@ -1147,7 +1150,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	/* Create BAP QoS structure */
 	bt_bap_iso_qos_to_bap_qos(&qos, &bap_qos);
 
-	bt_bap_parse_base(&iov, &bap_qos, bap_debug, bis_handler, data);
+	bt_bap_parse_base(sid, &iov, &bap_qos, bap_debug, bis_handler, data);
 
 	util_iov_free(bap_qos.bcast.bcode, 1);
 
@@ -2941,6 +2944,7 @@ static void pa_and_big_sync(struct bap_setup *setup)
 			btd_device_get_bdaddr_type(bap_data->device),
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, &bap_sink_pa_qos,
+			BT_IO_OPT_ISO_BC_SID, setup->sid,
 			BT_IO_OPT_INVALID);
 	if (!bap_data->listen_io) {
 		error("%s", err->message);
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index c36f432776b5..46ac0f4894e2 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -141,8 +141,9 @@ static struct bass_data *bass_data_new(struct btd_device *device);
 static void bass_data_add(struct bass_data *data);
 static void bass_data_remove(struct bass_data *data);
 
-static void bis_probe(uint8_t bis, uint8_t sgrp, struct iovec *caps,
-	struct iovec *meta, struct bt_bap_qos *qos, void *user_data);
+static void bis_probe(uint8_t sid, uint8_t bis, uint8_t sgrp,
+			struct iovec *caps, struct iovec *meta,
+			struct bt_bap_qos *qos, void *user_data);
 static void bis_remove(struct bt_bap *bap, void *user_data);
 
 
@@ -482,8 +483,9 @@ static void bass_add_bis(struct bass_setup *setup)
 	setup_configure_stream(setup);
 }
 
-static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
-	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
+static void bis_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
+			struct iovec *caps, struct iovec *meta,
+			struct bt_bap_qos *qos, void *user_data)
 {
 	struct bass_delegator *dg = user_data;
 	struct bt_bap_pac *lpac;
@@ -526,12 +528,14 @@ static gboolean big_info_cb(GIOChannel *io, GIOCondition cond,
 	struct bt_iso_qos qos;
 	struct iovec iov;
 	struct bt_bap_qos bap_qos = {0};
+	uint8_t sid;
 
 	dg->io_id = 0;
 
 	bt_io_get(io, &err,
 			BT_IO_OPT_BASE, &base,
 			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_ISO_BC_SID, &sid,
 			BT_IO_OPT_INVALID);
 	if (err) {
 		error("%s", err->message);
@@ -545,7 +549,7 @@ static gboolean big_info_cb(GIOChannel *io, GIOCondition cond,
 	/* Create BAP QoS structure */
 	bt_bap_iso_qos_to_bap_qos(&qos, &bap_qos);
 
-	bt_bap_parse_base(&iov, &bap_qos, bass_debug, bis_handler, dg);
+	bt_bap_parse_base(sid, &iov, &bap_qos, bass_debug, bis_handler, dg);
 
 	util_iov_free(bap_qos.bcast.bcode, 1);
 
@@ -1107,8 +1111,9 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	return assistant;
 }
 
-static void bis_probe(uint8_t bis, uint8_t sgrp, struct iovec *caps,
-	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
+static void bis_probe(uint8_t sid, uint8_t bis, uint8_t sgrp,
+			struct iovec *caps, struct iovec *meta,
+			struct bt_bap_qos *qos, void *user_data)
 {
 	struct btd_device *device = user_data;
 	const struct queue_entry *entry;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 3758aa0000b0..3a11cb0820ec 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5721,8 +5721,9 @@ bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id)
 	return false;
 }
 
-void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
-	struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos)
+void bt_bap_bis_probe(struct bt_bap *bap, uint8_t sid, uint8_t bis,
+		      uint8_t sgrp, struct iovec *caps, struct iovec *meta,
+		      struct bt_bap_qos *qos)
 {
 	const struct queue_entry *entry;
 
@@ -5737,7 +5738,7 @@ void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
 		entry = entry->next;
 
 		if (cb->probe)
-			cb->probe(bis, sgrp, caps, meta, qos, cb->data);
+			cb->probe(sid, bis, sgrp, caps, meta, qos, cb->data);
 	}
 
 	bt_bap_unref(bap);
@@ -7341,7 +7342,7 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 
 }
 
-bool bt_bap_parse_base(struct iovec *iov,
+bool bt_bap_parse_base(uint8_t sid, struct iovec *iov,
 			struct bt_bap_qos *qos,
 			util_debug_func_t func,
 			bt_bap_bis_func_t handler,
@@ -7452,7 +7453,7 @@ bool bt_bap_parse_base(struct iovec *iov,
 			if (!bis_cc)
 				continue;
 
-			handler(bis_index, idx, bis_cc, &meta,
+			handler(sid, bis_index, idx, bis_cc, &meta,
 				qos, user_data);
 
 			util_iov_free(bis_cc, 1);
diff --git a/src/shared/bap.h b/src/shared/bap.h
index dfd16998071b..d10581428e79 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -40,9 +40,9 @@ typedef void (*bt_bap_stream_func_t)(struct bt_bap_stream *stream,
 					void *user_data);
 typedef void (*bt_bap_func_t)(struct bt_bap *bap, void *user_data);
 
-typedef void (*bt_bap_bis_func_t)(uint8_t bis, uint8_t sgrp,
-		struct iovec *caps, struct iovec *meta,
-		struct bt_bap_qos *qos, void *user_data);
+typedef void (*bt_bap_bis_func_t)(uint8_t sid, uint8_t bis, uint8_t sgrp,
+				struct iovec *caps, struct iovec *meta,
+				struct bt_bap_qos *qos, void *user_data);
 
 typedef void (*bt_bap_bcode_reply_t)(void *user_data, int err);
 
@@ -271,7 +271,7 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct iovec *caps,
 		struct bt_bap_pac **lpac);
 
-bool bt_bap_parse_base(struct iovec *base,
+bool bt_bap_parse_base(uint8_t sid, struct iovec *base,
 			struct bt_bap_qos *qos,
 			util_debug_func_t func,
 			bt_bap_bis_func_t handler,
@@ -284,8 +284,9 @@ unsigned int bt_bap_bis_cb_register(struct bt_bap *bap,
 				bt_bap_destroy_func_t destroy);
 bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id);
 
-void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
-	struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos);
+void bt_bap_bis_probe(struct bt_bap *bap, uint8_t sid, uint8_t bis,
+			uint8_t sgrp, struct iovec *caps, struct iovec *meta,
+			struct bt_bap_qos *qos);
 void bt_bap_bis_remove(struct bt_bap *bap);
 
 void bt_bap_req_bcode(struct bt_bap_stream *stream,
-- 
2.49.0

