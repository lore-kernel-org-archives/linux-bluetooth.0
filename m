Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51917211276
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819492; cv=none; b=A9WdT+NqsbhkZOVVJI5ElJRts/XxUhGyoO7zH1CVc9XfgNlwMoW1XFUT07mv622vecP1DbUMeCNjDp6GKvBzxZ5/cixuCWksgoVpMpEq3oMpLSy11RM21hTmpaKJL1ffXg7MflBgEhHjUOv3B1HhrCmj05iIXgaodolT5Ubthwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819492; c=relaxed/simple;
	bh=SgsqgNkKR4j4LHuhbEW86j7JDfMHKDH4y6mzvihBRj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8LXX56R3dVefqdBFujG6q/qRY4re8yoJQ8j9aolNwXtIsQ3ZiJ2Q1f8G3HHBv3mA8yaV1ecT+DyAZH2KEVY4PkjlVMHIBpsGcQ6Lu1u5ot/KTHdC2e3OVNlFBDflft+X8Xx+/MAsKv87JhPoYn+CdLcEr07Lmy7Z0H7euatSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCV7fpBR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCV7fpBR"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so9246736d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819488; x=1745424288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYO8tePVhqNcc/Lq2pqvHjQYNefQ+Sf1a7mfkT1hWBo=;
        b=TCV7fpBRcB3RfFkhOYDChxnsL7Z4jVSiLTpCfMgwiaWNh1r6YN6U9Javfd0QOJ4HF7
         rxbamAr0RyNg1D2sn235FNf/pwwkqtgRdhpJecnL8Y/ISSin2VRlGzZhd+vg9380EbG3
         uehyfSuVzFZ1QHOpnT8QqC4d/Eorefhvd761U95ZSW+GRJ3DNll/3fdOQSoVPfD12Vfs
         uWRD8dUtqRLi+CE50o1ubo/m/nvvsdlW/5KODcTd9OvKoKNlzzv0Sk0uybToMnAkkqM+
         Gyk0h2NAD0Op8q4coUHbzqjPFcBjIFNSpyXtUbJXQH0EV8vpio91zPsQGjmIKKkpU50B
         cUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819488; x=1745424288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYO8tePVhqNcc/Lq2pqvHjQYNefQ+Sf1a7mfkT1hWBo=;
        b=aGa/ABsiqBfvNM78AjRJxlV0A1gH29ZDS3kuLwpSJO0fl4s08Ss/XJXLVylQyq7S5y
         L44j1UC5x+cgdSNNa8+RglaTL59hcUyhW9TV8led6vG9RKJ0IjZlMsOiSlkrVEcXUvGk
         JyfrpZ34uJaVrzY2P2LvgbA1efO41FoftsXXSjPAR9KIMTga+J5u3aaliDHvoxz6glRp
         g8IWqjbsl1GxjlJoEd3xujkRMhHJcHplgrv5ltQEpt6axXwwMbwdmd+WUJj+4DtQLuTM
         EC7WecjLOCpQijaUjZyPYZyS9VTbu70KPSawe0q2sh4TB18jAnsvv6R+rVs9kOh0xvs0
         tcLQ==
X-Gm-Message-State: AOJu0YxrPf8EEd+jpJ1M4ooRIimhlBJwJLSitAeRpkCYneydDPpccRdM
	6xJK8CfDOdAyc6++VVQX8H6DtdtBynXgLry36iqqVutMa5lPoMfmFO1wOk6K
X-Gm-Gg: ASbGnctYnXeu0/hwfQ7UeMwT+LvPvdTjL8JeUgTHasGN98mdS/LAlOorA1Hlw9LodWH
	HwUkUQAT8DEjgcZk6IxXPg8DieuBMSdhyyjLdigYBFeLheAnANj3dPP34ZngUgyB0RUCgLxQ3Wr
	jal6dskycWhJOPDAHNMNvlS7xKmkBuJciYUsWS2ohBlbj6mDWaRwlsH4DjJbhIG3GtEICGL9/+b
	/f+NsRPQ4SDVZ3x2gGJY6R79FFz2qtkm11gYY2E70WtDdztSlY2N6A3SvMSdnhMf4tkRUH59s6y
	vJ0JfHCsu4I939FJiQuqcrpn+3JflByszI4QBethQCsXVFrd8oxu8ftZN6ogizIgy6YwaKDbL1N
	H8nqg8rmoFA==
X-Google-Smtp-Source: AGHT+IHmAwDH6AaKBTpTw7zfjHzYbyN1fjYNzrXYUZn4cYLhtaTyWU4tHIpjlkNr962B0yd93vAhXw==
X-Received: by 2002:a05:6214:f25:b0:6e4:5a38:dd0f with SMTP id 6a1803df08f44-6f2b9955358mr1246476d6.4.1744819488314;
        Wed, 16 Apr 2025 09:04:48 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd43sm3094029137.20.2025.04.16.09.04.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:04:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/7] bap: Add support for using SID for broadcast receiver
Date: Wed, 16 Apr 2025 12:04:33 -0400
Message-ID: <20250416160433.1822263-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
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

