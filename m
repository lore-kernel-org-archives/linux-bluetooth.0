Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919027B50F
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730166; cv=none; b=RJnrRc9ieGJaiQVK+NsjjQR/4IkLjthdaRYXWJHTsNN3j46Cl4pDniWsxqxPUjjVzbuMko28G/KY+GlV4nm0X+4NBxEzY0Jiq0WAc0z3YM/MiEcLH/wSNSAE+BHbBdaHlOrqjVNe9jyZMTcjKnP8IUG6Ym7Kb/12lLuN2zJw1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730166; c=relaxed/simple;
	bh=ppPzgR440gFNPRD6EL56Cjou9sZrmZYs1rw70EIzf40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GeaLJwXgS6a4FWQwyuTCSQeaQt04plAUYGVROuZV1AlA1k6jrrKCuc+dxtZCj0xzqWi5c19zqVuWudZB6yqjBEgSXugs38S2yebyVsQtztVR0oskM/0+gyCKH6ZnNq/M4LRtff8hAJ09FgRR5uML/Riz5b0C2Jp2LM+Wad1/ZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLRK4uIL; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLRK4uIL"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-941275fece4so357842241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 12:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767730163; x=1768334963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEiLVpD5txKuULuEdVcnUcYTiXO8v1nkEdL8aY/+LgI=;
        b=DLRK4uILXc0wCP0z9wShDJGXN8bMMliVEfoo78QEn3lAFva7wUPycKO8NfIacUIIdd
         3mXq3yVo/0s8j5X9yfICpIMYZQzLmpO5eeNcI+hmGGk90EBo0OFnN8zUtUXEnRnr2MOz
         Rh2SFvIUwfNGVMJVD1XFqogpI8XI8oqb9UgJGtmpohaGYTUkYU/O46LuFoOOqqYrE0tI
         HWkW13GKTQwLDWtKO7klFldD72+XqURzfMBKyVagZ2yX8wDnZMQjF26RTuIEoZxHxJua
         459l9eZ/AwMO799RwV13nJDMfgx0ljkSufxQmzTlGxhs/OVYcvTJnAxTGXzYwfhK7FWK
         Lbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767730163; x=1768334963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEiLVpD5txKuULuEdVcnUcYTiXO8v1nkEdL8aY/+LgI=;
        b=QzuvVim7p2hehQnOxu5B28/XofYDT727KCI/WouYHRk59VP6HG19Sl02UpeblIlgmN
         GuYsHHQ91C8Jko473x7kdAtNJ2bjEy2oJXJRk5WoKZiXK7Olz6b2g06WZfq9pV2UYP73
         BGN1K7B656Kp1d7Gabfd1MvGdtY5mBA1ETRB5CpjXwOqP/wSP8khsCZyOSWugfKtLBmO
         iGZGPL03xCKkqpGt7uxlDLBrY77KJbnomChKvhHhw00bzNLErNIp2aSyseUDRSlevPZ7
         CAFiZ6dH/G5jHYQjByTRPfzi0k+XMvjuz40cLkAn9v5JbpzbEhjGf/8sDsHA//14kjY8
         8iXw==
X-Gm-Message-State: AOJu0YytBrLEnbkq9jrep3hxjPNTppI+H1FP0loxG4f3Jx+9YyUTCSp/
	UjFgXLY1ICpZ/4m8Qwp5s4clvK4n8pLqAlSoxU7yYtY0+nUxvIhNJ17tCLzYYSGd
X-Gm-Gg: AY/fxX4KdSBXtWqCZ6N/Cg1wYfaiSTyavCJhq8EYChjVdAJBQDZi3YWuUy+Uw20t4dX
	WMHSfsd15b+yktSCmqqdxla/WCeL4BdXwopVhybsI5lEaefk1g9JhQzIYQ3uPTCKXLYuuFSfjBB
	WLaO2MCGTE0Bgz3N9ZHLujpsBvgW2o6w55mR+Jo55/k4jr1tA65Ay/9E+KmSOBY3ZdqIyEZ14pi
	gHqYYMrdHbIA8Cp9oM18jUfmzbWCC+GHYBYOqYq0SSvgC96T13t8nEbocuJNsnK/i6KT3CABW1x
	rDVGRkP21eJ+SwZgICBzOkkG3OOALuSRbBoNzY0CL+8nvCgcyz9IvtmkC1UjF9kWXpQahjh/v2S
	wYw5QqRGu1lOPgX7nsv9JSeIX1iJZlfuskYIEnvAeZ90FjochjEpmEr2wxa0ICFrPFD7zmUAYrN
	M0mYVN/tDf6yd1+DObb21k3KA2PoT6JgNYWkjPCNdLOEMqL4uimNe3//WELlmgpUEgIbSvGSWEd
	hYHow==
X-Google-Smtp-Source: AGHT+IG23eQ8fIEvKmH0aYm5EUU3YFydhMtpuQMDV33YCIdlNJ9ZnLzdyom1svDqnFOYrG/V+PEuDA==
X-Received: by 2002:a05:6102:c0a:b0:5dd:b2ee:c6ff with SMTP id ada2fe7eead31-5ecb1e72e29mr23159137.8.1767730162825;
        Tue, 06 Jan 2026 12:09:22 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944121ef3fcsm938373241.0.2026.01.06.12.09.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 12:09:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] lib: Rename bt_iso_io_qos phy field to phys
Date: Tue,  6 Jan 2026 15:09:12 -0500
Message-ID: <20260106200913.3419162-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This renames the bt_iso_io_qos phy field to phys to emphasize it is
actually a bitfield rather than a single value.
---
 emulator/bthost.c         |  8 ++++----
 lib/bluetooth/bluetooth.h |  2 +-
 profiles/audio/bap.c      |  4 ++--
 profiles/audio/media.c    |  8 ++++----
 src/shared/bap.c          | 16 ++++++++--------
 src/shared/bap.h          |  2 +-
 tools/btiotest.c          |  2 +-
 tools/iso-tester.c        |  8 ++++----
 tools/isotest.c           | 24 ++++++++++++------------
 unit/test-bap.c           |  2 +-
 10 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index fe6ad4145673..d09ad1e76c50 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3886,10 +3886,10 @@ void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
 	cp->cis[0].cis_id = cis_id;
 	cp->cis[0].c_sdu = qos->ucast.in.sdu;
 	cp->cis[0].p_sdu = qos->ucast.out.sdu;
-	cp->cis[0].c_phys = qos->ucast.in.phy ? qos->ucast.in.phy :
-							qos->ucast.out.phy;
-	cp->cis[0].p_phys = qos->ucast.out.phy ? qos->ucast.out.phy :
-							qos->ucast.in.phy;
+	cp->cis[0].c_phys = qos->ucast.in.phys ? qos->ucast.in.phys :
+							qos->ucast.out.phys;
+	cp->cis[0].p_phys = qos->ucast.out.phys ? qos->ucast.out.phys :
+							qos->ucast.in.phys;
 	cp->cis[0].c_rtn = qos->ucast.in.rtn;
 	cp->cis[0].p_rtn = qos->ucast.out.rtn;
 
diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index 88a5d8b66134..f9f22c3f7523 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -173,7 +173,7 @@ struct bt_iso_io_qos {
 	uint32_t interval;
 	uint16_t latency;
 	uint16_t sdu;
-	uint8_t  phy;
+	uint8_t  phys;
 	uint8_t  rtn;
 };
 
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b6eb91ab3fb6..f015f73e3c6d 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -428,7 +428,7 @@ static gboolean get_qos(const GDBusPropertyTable *property,
 		return FALSE;
 
 	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE, &qos->framing);
-	dict_append_entry(&dict, "PHY", DBUS_TYPE_BYTE, &qos->phy);
+	dict_append_entry(&dict, "PHY", DBUS_TYPE_BYTE, &qos->phys);
 	dict_append_entry(&dict, "Retransmissions", DBUS_TYPE_BYTE, &qos->rtn);
 	dict_append_entry(&dict, "MaximumLatency", DBUS_TYPE_UINT16,
 					&qos->latency);
@@ -2242,7 +2242,7 @@ static void bap_iso_qos(struct bt_bap_qos *qos, struct bt_iso_io_qos *io)
 	io->interval = qos->ucast.io_qos.interval;
 	io->latency = qos->ucast.io_qos.latency;
 	io->sdu = qos->ucast.io_qos.sdu;
-	io->phy = qos->ucast.io_qos.phy;
+	io->phys = qos->ucast.io_qos.phy;
 	io->rtn = qos->ucast.io_qos.rtn;
 }
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index ad9eb7beb536..bf8be52ac960 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1049,7 +1049,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 						metadata->iov_len);
 	}
 
-	if (qos && qos->phy) {
+	if (qos && qos->phys) {
 		DBusMessageIter entry, variant, qos_dict;
 
 		key = "QoS";
@@ -1065,7 +1065,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							&qos->framing);
 
 		g_dbus_dict_append_entry(&qos_dict, "PHY", DBUS_TYPE_BYTE,
-							&qos->phy);
+							&qos->phys);
 
 		g_dbus_dict_append_entry(&qos_dict, "Retransmissions",
 					DBUS_TYPE_BYTE, &qos->rtn);
@@ -1810,7 +1810,7 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 		} else if (strcasecmp(key, "PHY") == 0) {
 			if (var != DBUS_TYPE_BYTE)
 				return -EINVAL;
-			dbus_message_iter_get_basic(&value, &qos->phy);
+			dbus_message_iter_get_basic(&value, &qos->phys);
 		} else if (strcasecmp(key, "Retransmissions") == 0) {
 			if (var != DBUS_TYPE_BYTE)
 				return -EINVAL;
@@ -3073,7 +3073,7 @@ static void app_register_endpoint(void *data, void *user_data)
 		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
 			goto fail;
 
-		dbus_message_iter_get_basic(&iter, &qos.phy);
+		dbus_message_iter_get_basic(&iter, &qos.phys);
 	}
 
 	if (g_dbus_proxy_get_property(proxy, "MaximumLatency", &iter)) {
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6a35e4e1d948..cb6db8765e9f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -374,14 +374,14 @@ struct bt_iso_qos bap_sink_pa_qos = {
 			.interval	= 10000,
 			.latency	= 10,
 			.sdu		= 40,
-			.phy		= 0x02,
+			.phys		= BIT(1),
 			.rtn		= 2,
 		},
 		.out = {
 			.interval	= 10000,
 			.latency	= 10,
 			.sdu		= 40,
-			.phy		= 0x02,
+			.phys		= BIT(1),
 			.rtn		= 2,
 		}
 	}
@@ -1029,8 +1029,8 @@ static void stream_notify_config(struct bt_bap_stream *stream)
 	status->state = ep->state;
 
 	/* Initialize preferred settings if not set */
-	if (!lpac->qos.phy)
-		lpac->qos.phy = 0x02;
+	if (!lpac->qos.phys)
+		lpac->qos.phys = BIT(1);
 
 	if (!lpac->qos.rtn)
 		lpac->qos.rtn = 0x05;
@@ -1053,7 +1053,7 @@ static void stream_notify_config(struct bt_bap_stream *stream)
 	/* TODO:Add support for setting preferred settings on bt_bap_pac */
 	config = (void *)status->params;
 	config->framing = lpac->qos.framing;
-	config->phy = lpac->qos.phy;
+	config->phy = lpac->qos.phys;
 	config->rtn = lpac->qos.rtn;
 	config->latency = cpu_to_le16(lpac->qos.latency);
 	put_le24(lpac->qos.pd_min, config->pd_min);
@@ -4237,7 +4237,7 @@ uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac)
 
 struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_bap_pac *pac)
 {
-	if (!pac || !pac->qos.phy)
+	if (!pac || !pac->qos.phys)
 		return NULL;
 
 	return &pac->qos;
@@ -5109,7 +5109,7 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	/* Set preferred settings */
 	if (ep->stream->rpac) {
 		ep->stream->rpac->qos.framing = cfg->framing;
-		ep->stream->rpac->qos.phy = cfg->phy;
+		ep->stream->rpac->qos.phys = cfg->phy;
 		ep->stream->rpac->qos.rtn = cfg->rtn;
 		ep->stream->rpac->qos.latency = le16_to_cpu(cfg->latency);
 		ep->stream->rpac->qos.pd_min = pd_min;
@@ -7861,7 +7861,7 @@ void bt_bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
 	bap_qos->bcast.io_qos.interval =
 			iso_qos->bcast.in.interval;
 	bap_qos->bcast.io_qos.latency = iso_qos->bcast.in.latency;
-	bap_qos->bcast.io_qos.phy = iso_qos->bcast.in.phy;
+	bap_qos->bcast.io_qos.phy = iso_qos->bcast.in.phys;
 	bap_qos->bcast.io_qos.rtn = iso_qos->bcast.in.rtn;
 	bap_qos->bcast.io_qos.sdu = iso_qos->bcast.in.sdu;
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 80e91f10a203..c1b75949f86b 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -55,7 +55,7 @@ extern struct bt_iso_qos bap_sink_pa_qos;
 /* Local PAC related functions */
 struct bt_bap_pac_qos {
 	uint8_t  framing;
-	uint8_t  phy;
+	uint8_t  phys;
 	uint8_t  rtn;
 	uint16_t latency;
 	uint32_t pd_min;
diff --git a/tools/btiotest.c b/tools/btiotest.c
index f62248e32a8c..da50ad175c3f 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -35,7 +35,7 @@ static int opt_update_sec = 0;
 	.interval = 10000, \
 	.latency = 10, \
 	.sdu = 40, \
-	.phy = 0x02, \
+	.phys = 0x02, \
 	.rtn = 2, \
 }
 
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index ff5c85ae410c..b851d2cd84bc 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -43,12 +43,12 @@
 
 #define EIR_SERVICE_DATA_16	0x16
 
-#define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
+#define QOS_IO(_interval, _latency, _sdu, _phys, _rtn) \
 { \
 	.interval = _interval, \
 	.latency = _latency, \
 	.sdu = _sdu, \
-	.phy = _phy, \
+	.phys = _phys, \
 	.rtn = _rtn, \
 }
 
@@ -2171,9 +2171,9 @@ static bool check_io_qos(const struct bt_iso_io_qos *io1,
 		return false;
 	}
 
-	if (io1->phy && io2->phy && io1->phy != io2->phy) {
+	if (io1->phys && io2->phys && io1->phys != io2->phys) {
 		tester_warn("Unexpected IO PHY: 0x%02x != 0x%02x",
-				io1->phy, io2->phy);
+				io1->phys, io2->phys);
 		return false;
 	}
 
diff --git a/tools/isotest.c b/tools/isotest.c
index e3d2d63ce1ff..ca59ea5b3ea6 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -270,13 +270,13 @@ static void print_ucast_qos(int sk)
 		qos.ucast.packing, qos.ucast.framing);
 
 	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
-		"ms SDU %u PHY 0x%02x RTN %u]", qos.ucast.in.interval,
-		qos.ucast.in.latency, qos.ucast.in.sdu, qos.ucast.in.phy,
+		"ms SDU %u PHYs 0x%02x RTN %u]", qos.ucast.in.interval,
+		qos.ucast.in.latency, qos.ucast.in.sdu, qos.ucast.in.phys,
 		qos.ucast.in.rtn);
 
 	syslog(LOG_INFO, "Output QoS [Interval %u us Latency %u "
-		"ms SDU %u PHY 0x%02x RTN %u]", qos.ucast.out.interval,
-		qos.ucast.out.latency, qos.ucast.out.sdu, qos.ucast.out.phy,
+		"ms SDU %u PHYs 0x%02x RTN %u]", qos.ucast.out.interval,
+		qos.ucast.out.latency, qos.ucast.out.sdu, qos.ucast.out.phys,
 		qos.ucast.out.rtn);
 }
 
@@ -311,14 +311,14 @@ static void print_bcast_qos(int sk)
 		qos.bcast.bcode[13], qos.bcast.bcode[14], qos.bcast.bcode[15]);
 
 	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
-		"ms SDU %u PHY 0x%02x RTN %u]", qos.bcast.in.interval,
+		"ms SDU %u PHYs 0x%02x RTN %u]", qos.bcast.in.interval,
 		qos.bcast.in.latency, qos.bcast.in.sdu,
-		qos.bcast.in.phy, qos.bcast.in.rtn);
+		qos.bcast.in.phys, qos.bcast.in.rtn);
 
 	syslog(LOG_INFO, "Output QoS [Interval %u us Latency %u "
-		"ms SDU %u PHY 0x%02x RTN %u]", qos.bcast.out.interval,
+		"ms SDU %u PHYs 0x%02x RTN %u]", qos.bcast.out.interval,
 		qos.bcast.out.latency, qos.bcast.out.sdu,
-		qos.bcast.out.phy, qos.bcast.out.rtn);
+		qos.bcast.out.phys, qos.bcast.out.rtn);
 }
 
 static int do_connect(char *peer)
@@ -350,7 +350,7 @@ static int do_connect(char *peer)
 	/* Set QoS if available */
 	if (iso_qos) {
 		if (!inout || !strcmp(peer, "00:00:00:00:00:00")) {
-			iso_qos->ucast.in.phy = 0x00;
+			iso_qos->ucast.in.phys = 0x00;
 			iso_qos->ucast.in.sdu = 0;
 		}
 
@@ -1020,12 +1020,12 @@ static void multy_connect_mode(char *peer)
 	}
 }
 
-#define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
+#define QOS_IO(_interval, _latency, _sdu, _phys, _rtn) \
 { \
 	.interval = _interval, \
 	.latency = _latency, \
 	.sdu = _sdu, \
-	.phy = _phy, \
+	.phys = _phys, \
 	.rtn = _rtn, \
 }
 
@@ -1339,7 +1339,7 @@ int main(int argc, char *argv[])
 
 		case 'Y':
 			if (optarg)
-				iso_qos->ucast.out.phy = atoi(optarg);
+				iso_qos->ucast.out.phys = atoi(optarg);
 			break;
 
 		case 'R':
diff --git a/unit/test-bap.c b/unit/test-bap.c
index be838cb99f24..cdd1bed7e1ff 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -101,7 +101,7 @@ static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
 								3u, 26, 240);
 
 static struct bt_bap_pac_qos lc3_qos = {
-	.phy = 0x02,
+	.phys = BIT(1),
 	.rtn = 0x01,
 	.location = 0x00000003,
 	.supported_context = 0x0fff,
-- 
2.52.0

