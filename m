Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9CB1494A8
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730167; cv=none; b=QBu0sMcX91/Q6AMVRx4UBcDhelwJ60ZBbLF7l/6/0lnW8nvrB4UHZJR3hh2izFOxT2yzcvIlP+oFbHU1JNmaIiyOV7q7qg8XsNy7NFvZ+42xLCo31DCx7xEwz3fWv2d1EtYPAl2h8aLM5fTbejaI1BRbO1dfgpOa6opnGPqNhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730167; c=relaxed/simple;
	bh=MG71iW1kLIEvNaPoI37SBj3+VJhf3UArgsxf0sSgC/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGEsDy4Xu8DIi+pOvcJWKtUjHPUfwZGQVQno7Zvcn2WzuCdxgIbzlKJa7K/95cpqUPsL863TduKRgYiyCgoudMOO4/AdUeXtxmnoFsBeCPC5OxneFJXB1xlewGz6uw6UfW3FFSvoDnH6O5h+7FJ6KSiQkQzny02ND36erHi22E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbya416Y; arc=none smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbya416Y"
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-9412512e9f3so409451241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 12:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767730164; x=1768334964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2/rJIknnA9yZaxmnMRxWNRmDmTc7qzUZ/7OO17EYfc=;
        b=Hbya416YIVtK/7zZb1zrddbnorADMhXkmsyO5UO3IVsTOptybuVhG2PXu2lhsy9Rh/
         QbBg8teyv54ZBtBprobDdq5o+QCbTqQPCSSb1raaOD0S0xmQ4fduo2TTOUCPpNC1rhj8
         YrkMPR+30iazmKoCwnQtBhiswUTHJxn/EHzFopTm0YOKIzKSAaFh2NkzzF2mhXrgmMt6
         WLjn6XseGgx2gZw6P7Ny5341PykC+ZpGHtbcYpjTzD0Myu0/qfgh0BwzX3zvlHlFhL68
         jsQtrLY94hq12J8HpozA8pBHGuE96g3sAwvGcNMQGXqT9/WvQgbIJdgteMJ1ziRzFaI3
         FIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767730164; x=1768334964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k2/rJIknnA9yZaxmnMRxWNRmDmTc7qzUZ/7OO17EYfc=;
        b=LYgJtHjvnPCSuWba91GhSsT41+0j92hA0kgWFrjvLTfOTbO4skYVgM6FSCveHyNO0l
         c9V0cMpgO4YvD0XMuHq140At7vbclud0Fmb0w4nYmi5NiMoUfnZfQs2GKLxtO7rLJqPo
         vNv7tDKVyySML7iTjG5NSlAxpt0/GzYWFT6SDbK6z/h1AhuNdhN6hM1GFcXDTZKuEBGQ
         9YDCmFHU6XmzawH5Dq5rXppHjbw6l4VW9IZLxOVfmiM5hPKXoMTg5F15klt0LBu5Ko+9
         jGD7oWcG/9d+7OMqOiSqMVFWP1LaJHESk7rIKcMV/5wosZ6eAc/KkNDN7bZRgRMWTteV
         gHZw==
X-Gm-Message-State: AOJu0YzrQ8yZG/FnnLR7FbqhNOVr26mDV06bkBfa+3WVrjIuNzBQHMrL
	C6M4jDzl4Bv2ewtWTA81Bx+e1NUbEAQE3In+BUuzptca37FWAeJkJgFeGdL2jFZ/aUs=
X-Gm-Gg: AY/fxX4G08Wqze1k1qnWLLIpE5oNLDizFfQVC6eYUuPmZjgi3TzjQRB5PTczxjF+5dK
	LGQ0byU9GfAzTgxCwDBEK3GCn75v3dCx3VcfsguHDa9u+SFJ8P4Q4HtLSf2co7e43AgnshaiHzo
	EmU7WT5j006aZ6OByMqkdcsiqVPHIF3e2EaTznKBtlCPTMuWWT8dhnZ8+2cvrhdSJqv7LApeIQH
	xmFaErxdsas20N4U1nbNoZBDUjCPAC+mZ7maHLqeplln3aDyqHwkOwI257Pr+UZTlwH8pvenf/U
	E/HD+biykFSsDqCW+miDuPSYiPMWNLQUtPbgIq9Y8pcPBE7NfyqMpYLq3pydMPkrDpN+HEnMZwq
	+q0W6TQWBtZbOEawcJ+n5XKY+Jr60WZ8kg2kCcFjx28nhIxJwSxmExTUK5/nwjeK39dlnPlKkQ7
	BbBBx6IJ1JfRh1ztfWSq5s/sjuNrm+cATMH2aFmaRxwCWJ/19RRegk1OV0W+/GYrsAi+JodNFp0
	RV5eA==
X-Google-Smtp-Source: AGHT+IEg1eapZhrwlOKuvYlBYp9imgqo+v3LJ3Wp0f/8ik35LxB65J0ICss8AkTYQ+8+EEd82DbCUw==
X-Received: by 2002:a05:6102:6c7:b0:5db:d411:20cd with SMTP id ada2fe7eead31-5ecb6946bcfmr14592137.28.1767730164222;
        Tue, 06 Jan 2026 12:09:24 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944121ef3fcsm938373241.0.2026.01.06.12.09.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 12:09:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/bap: Fix PHY fields being treated as single value
Date: Tue,  6 Jan 2026 15:09:13 -0500
Message-ID: <20260106200913.3419162-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106200913.3419162-1-luiz.dentz@gmail.com>
References: <20260106200913.3419162-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BP PHY fields always refer to bitfields with the exception of target
PHY field in bt_ascs_config.
---
 client/player.c            | 12 +++++-----
 profiles/audio/bap.c       |  6 ++---
 profiles/audio/media.c     |  2 +-
 profiles/audio/transport.c |  6 ++---
 src/shared/ascs.h          |  6 ++---
 src/shared/bap-defs.h      |  8 +++----
 src/shared/bap.c           | 49 +++++++++++++++++++++++++-------------
 src/shared/lc3.h           |  4 ++--
 unit/test-bap.c            |  4 ++--
 9 files changed, 57 insertions(+), 40 deletions(-)

diff --git a/client/player.c b/client/player.c
index d7402d19d57b..1444e939d30b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1890,9 +1890,9 @@ static void append_io_qos(DBusMessageIter *iter, struct bt_bap_io_qos *qos)
 	g_dbus_dict_append_entry(iter, "Interval", DBUS_TYPE_UINT32,
 						&qos->interval);
 
-	bt_shell_printf("PHY 0x%02x\n", qos->phy);
+	bt_shell_printf("PHYs 0x%02x\n", qos->phys);
 
-	g_dbus_dict_append_entry(iter, "PHY", DBUS_TYPE_BYTE, &qos->phy);
+	g_dbus_dict_append_entry(iter, "PHY", DBUS_TYPE_BYTE, &qos->phys);
 
 	bt_shell_printf("SDU %u\n", qos->sdu);
 
@@ -2229,7 +2229,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	else
 		qos = &preset->qos.ucast.io_qos;
 
-	if (qos->phy) {
+	if (qos->phys) {
 		/* Set QoS parameters */
 		cfg->qos = preset->qos;
 		/* Adjust the SDU size based on the number of
@@ -4162,9 +4162,9 @@ static void custom_phy(const char *input, void *user_data)
 		qos = &p->qos.ucast.io_qos;
 
 	if (!strcmp(input, "1M"))
-		qos->phy = 0x01;
+		qos->phys = BIT(0);
 	else if (!strcmp(input, "2M"))
-		qos->phy = 0x02;
+		qos->phys = BIT(1);
 	else {
 		char *endptr = NULL;
 		uint8_t phy = strtol(input, &endptr, 0);
@@ -4177,7 +4177,7 @@ static void custom_phy(const char *input, void *user_data)
 		switch (phy) {
 		case 0x01:
 		case 0x02:
-			qos->phy = phy;
+			qos->phys = phy;
 			break;
 		default:
 			bt_shell_printf("Invalid argument: %s\n", input);
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f015f73e3c6d..90a9786674ab 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -594,7 +594,7 @@ static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
 
-		dbus_message_iter_get_basic(iter, &qos->phy);
+		dbus_message_iter_get_basic(iter, &qos->phys);
 	} else if (!strcasecmp(key, "SDU")) {
 		if (var != DBUS_TYPE_UINT16)
 			return -EINVAL;
@@ -1145,7 +1145,7 @@ static bool match_io_qos(const struct bt_bap_io_qos *io_qos,
 	if (io_qos->sdu != match->sdu)
 		return false;
 
-	if (io_qos->phy != match->phy)
+	if (io_qos->phys != match->phys)
 		return false;
 
 	if (io_qos->rtn != match->rtn)
@@ -2242,7 +2242,7 @@ static void bap_iso_qos(struct bt_bap_qos *qos, struct bt_iso_io_qos *io)
 	io->interval = qos->ucast.io_qos.interval;
 	io->latency = qos->ucast.io_qos.latency;
 	io->sdu = qos->ucast.io_qos.sdu;
-	io->phys = qos->ucast.io_qos.phy;
+	io->phys = qos->ucast.io_qos.phys;
 	io->rtn = qos->ucast.io_qos.rtn;
 }
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index bf8be52ac960..f153e757c06d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -858,7 +858,7 @@ static int parse_ucast_qos(DBusMessageIter *iter, struct bt_bap_qos *qos)
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
 
-			dbus_message_iter_get_basic(&value, &io_qos.phy);
+			dbus_message_iter_get_basic(&value, &io_qos.phys);
 		} else if (!strcasecmp(key, "SDU")) {
 			if (var != DBUS_TYPE_UINT16)
 				goto fail;
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index fc23cf33d2b6..baf8432dece2 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1241,7 +1241,7 @@ static void append_io_qos(DBusMessageIter *dict, struct bt_bap_io_qos *qos)
 	dict_append_entry(dict, "Interval", DBUS_TYPE_UINT32, &qos->interval);
 	dict_append_entry(dict, "Latency", DBUS_TYPE_UINT16, &qos->latency);
 	dict_append_entry(dict, "SDU", DBUS_TYPE_UINT16, &qos->sdu);
-	dict_append_entry(dict, "PHY", DBUS_TYPE_BYTE, &qos->phy);
+	dict_append_entry(dict, "PHY", DBUS_TYPE_BYTE, &qos->phys);
 	dict_append_entry(dict, "Retransmissions", DBUS_TYPE_BYTE, &qos->rtn);
 }
 
@@ -1460,7 +1460,7 @@ static gboolean qos_ucast_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	return bap->qos.ucast.io_qos.phy != 0x00;
+	return bap->qos.ucast.io_qos.phys != 0x00;
 }
 
 static const GDBusPropertyTable transport_bap_uc_properties[] = {
@@ -1533,7 +1533,7 @@ static gboolean qos_bcast_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	return bap->qos.bcast.io_qos.phy != 0x00;
+	return bap->qos.bcast.io_qos.phys != 0x00;
 }
 
 static void bcast_qos_set(void *user_data, int err)
diff --git a/src/shared/ascs.h b/src/shared/ascs.h
index a409bad61681..494a153fec20 100644
--- a/src/shared/ascs.h
+++ b/src/shared/ascs.h
@@ -75,7 +75,7 @@ struct bt_ascs_ase_status {
 /* ASE_State = 0x01 (Codec Configured), defined in Table 4.7. */
 struct bt_ascs_ase_status_config {
 	uint8_t  framing;
-	uint8_t  phy;
+	uint8_t  phys;
 	uint8_t  rtn;
 	uint16_t latency;
 	uint8_t  pd_min[3];
@@ -94,7 +94,7 @@ struct bt_ascs_ase_status_qos {
 	uint8_t  cis_id;
 	uint8_t  interval[3];
 	uint8_t  framing;
-	uint8_t  phy;
+	uint8_t  phys;
 	uint16_t sdu;
 	uint8_t  rtn;
 	uint16_t latency;
@@ -150,7 +150,7 @@ struct bt_ascs_qos {
 	uint8_t  cis;			/* CIG ID*/
 	uint8_t  interval[3];		/* Frame interval */
 	uint8_t  framing;		/* Frame framing */
-	uint8_t  phy;			/* PHY */
+	uint8_t  phys;			/* PHY */
 	uint16_t sdu;			/* Maximum SDU Size */
 	uint8_t  rtn;			/* Retransmission Effort */
 	uint16_t latency;		/* Transport Latency */
diff --git a/src/shared/bap-defs.h b/src/shared/bap-defs.h
index 27fefa34f1ec..e5c2accb99f7 100644
--- a/src/shared/bap-defs.h
+++ b/src/shared/bap-defs.h
@@ -35,9 +35,9 @@
 #define BT_BAP_CONFIG_LATENCY_BALANCED	0x02
 #define BT_BAP_CONFIG_LATENCY_HIGH	0x03
 
-#define BT_BAP_CONFIG_PHY_1M		0x01
-#define BT_BAP_CONFIG_PHY_2M		0x02
-#define BT_BAP_CONFIG_PHY_CODEC		0x03
+#define BT_BAP_CONFIG_PHY_1M		BIT(0)
+#define BT_BAP_CONFIG_PHY_2M		BIT(1)
+#define BT_BAP_CONFIG_PHY_CODEC		BIT(2)
 
 struct bt_bap_codec {
 	uint8_t  id;
@@ -55,7 +55,7 @@ struct bt_bap_io_qos {
 	uint32_t interval;	/* Frame interval */
 	uint16_t latency;	/* Transport Latency */
 	uint16_t sdu;		/* Maximum SDU Size */
-	uint8_t  phy;		/* PHY */
+	uint8_t  phys;		/* PHY */
 	uint8_t  rtn;		/* Retransmission Effort */
 };
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index cb6db8765e9f..37b04c5c1ea8 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1053,7 +1053,7 @@ static void stream_notify_config(struct bt_bap_stream *stream)
 	/* TODO:Add support for setting preferred settings on bt_bap_pac */
 	config = (void *)status->params;
 	config->framing = lpac->qos.framing;
-	config->phy = lpac->qos.phys;
+	config->phys = lpac->qos.phys;
 	config->rtn = lpac->qos.rtn;
 	config->latency = cpu_to_le16(lpac->qos.latency);
 	put_le24(lpac->qos.pd_min, config->pd_min);
@@ -1097,7 +1097,7 @@ static void stream_notify_qos(struct bt_bap_stream *stream)
 	qos->cig_id = stream->qos.ucast.cig_id;
 	put_le24(stream->qos.ucast.io_qos.interval, qos->interval);
 	qos->framing = stream->qos.ucast.framing;
-	qos->phy = stream->qos.ucast.io_qos.phy;
+	qos->phys = stream->qos.ucast.io_qos.phys;
 	qos->sdu = cpu_to_le16(stream->qos.ucast.io_qos.sdu);
 	qos->rtn = stream->qos.ucast.io_qos.rtn;
 	qos->latency = cpu_to_le16(stream->qos.ucast.io_qos.latency);
@@ -1857,6 +1857,23 @@ static unsigned int bap_ucast_get_state(struct bt_bap_stream *stream)
 	return stream->ep->state;
 }
 
+static uint8_t bits_to_phy(uint8_t bits)
+{
+	uint8_t phy = 0x00;
+
+	/* Convert PHY bits to PHY values on a ascending order. */
+	if (bits & BIT(0))
+		phy = 0x01; /* LE 1M */
+
+	if (bits & BIT(1))
+		phy = 0x02; /* LE 2M */
+
+	if (bits & BIT(2))
+		phy = 0x03; /* LE Coded */
+
+	return phy;
+}
+
 static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					struct iovec *data,
@@ -1877,7 +1894,7 @@ static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
 
 	config.ase = stream->ep->id;
 	config.latency = qos->ucast.target_latency;
-	config.phy = qos->ucast.io_qos.phy;
+	config.phy = bits_to_phy(qos->ucast.io_qos.phys);
 	config.codec = stream->rpac->codec;
 
 	if (config.codec.id == 0xff) {
@@ -1936,7 +1953,7 @@ static unsigned int bap_ucast_qos(struct bt_bap_stream *stream,
 	qos.cis = data->ucast.cis_id;
 	put_le24(data->ucast.io_qos.interval, qos.interval);
 	qos.framing = data->ucast.framing;
-	qos.phy = data->ucast.io_qos.phy;
+	qos.phys = data->ucast.io_qos.phys;
 	qos.sdu = cpu_to_le16(data->ucast.io_qos.sdu);
 	qos.rtn = data->ucast.io_qos.rtn;
 	qos.latency = cpu_to_le16(data->ucast.io_qos.latency);
@@ -3162,8 +3179,8 @@ static uint8_t ascs_config(struct bt_ascs *ascs, struct bt_bap *bap,
 
 	req = util_iov_pull_mem(iov, sizeof(*req));
 
-	DBG(bap, "codec 0x%02x phy 0x%02x latency %u", req->codec.id, req->phy,
-							req->latency);
+	DBG(bap, "codec 0x%02x phy 0x%02x latency %u", req->codec.id,
+						req->phy, req->latency);
 
 	ep = bap_get_local_endpoint_id(bap, req->ase);
 	if (!ep) {
@@ -3236,16 +3253,16 @@ static uint8_t ascs_qos(struct bt_ascs *ascs, struct bt_bap *bap,
 	qos.ucast.cis_id = req->cis;
 	qos.ucast.io_qos.interval = get_le24(req->interval);
 	qos.ucast.framing = req->framing;
-	qos.ucast.io_qos.phy = req->phy;
+	qos.ucast.io_qos.phys = req->phys;
 	qos.ucast.io_qos.sdu = le16_to_cpu(req->sdu);
 	qos.ucast.io_qos.rtn = req->rtn;
 	qos.ucast.io_qos.latency = le16_to_cpu(req->latency);
 	qos.ucast.delay = get_le24(req->pd);
 
 	DBG(bap, "CIG 0x%02x CIS 0x%02x interval %u framing 0x%02x "
-			"phy 0x%02x SDU %u rtn %u latency %u pd %u",
+			"phys 0x%02x SDU %u rtn %u latency %u pd %u",
 			req->cig, req->cis, qos.ucast.io_qos.interval,
-			qos.ucast.framing, qos.ucast.io_qos.phy,
+			qos.ucast.framing, qos.ucast.io_qos.phys,
 			qos.ucast.io_qos.sdu, qos.ucast.io_qos.rtn,
 			qos.ucast.io_qos.latency, qos.ucast.delay);
 
@@ -5061,9 +5078,9 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	ppd_min = get_le24(cfg->ppd_min);
 	ppd_max = get_le24(cfg->ppd_max);
 
-	DBG(bap, "codec 0x%02x framing 0x%02x phy 0x%02x rtn %u "
+	DBG(bap, "codec 0x%02x framing 0x%02x.phys 0x%02x rtn %u "
 			"latency %u pd %u - %u ppd %u - %u", cfg->codec.id,
-			cfg->framing, cfg->phy, cfg->rtn,
+			cfg->framing, cfg->phys, cfg->rtn,
 			le16_to_cpu(cfg->latency),
 			pd_min, pd_max, ppd_min, ppd_max);
 
@@ -5109,7 +5126,7 @@ static void ep_status_config(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	/* Set preferred settings */
 	if (ep->stream->rpac) {
 		ep->stream->rpac->qos.framing = cfg->framing;
-		ep->stream->rpac->qos.phys = cfg->phy;
+		ep->stream->rpac->qos.phys = cfg->phys;
 		ep->stream->rpac->qos.rtn = cfg->rtn;
 		ep->stream->rpac->qos.latency = le16_to_cpu(cfg->latency);
 		ep->stream->rpac->qos.pd_min = pd_min;
@@ -5175,8 +5192,8 @@ static void ep_status_qos(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 	latency = le16_to_cpu(qos->latency);
 
 	DBG(bap, "CIG 0x%02x CIS 0x%02x interval %u framing 0x%02x "
-			"phy 0x%02x rtn %u latency %u pd %u", qos->cig_id,
-			qos->cis_id, interval, qos->framing, qos->phy,
+			"phys 0x%02x rtn %u latency %u pd %u", qos->cig_id,
+			qos->cis_id, interval, qos->framing, qos->phys,
 			qos->rtn, latency, pd);
 
 	if (!ep->stream)
@@ -5184,7 +5201,7 @@ static void ep_status_qos(struct bt_bap *bap, struct bt_bap_endpoint *ep,
 
 	ep->stream->qos.ucast.io_qos.interval = interval;
 	ep->stream->qos.ucast.framing = qos->framing;
-	ep->stream->qos.ucast.io_qos.phy = qos->phy;
+	ep->stream->qos.ucast.io_qos.phys = qos->phys;
 	ep->stream->qos.ucast.io_qos.sdu = sdu;
 	ep->stream->qos.ucast.io_qos.rtn = qos->rtn;
 	ep->stream->qos.ucast.io_qos.latency = latency;
@@ -7861,7 +7878,7 @@ void bt_bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
 	bap_qos->bcast.io_qos.interval =
 			iso_qos->bcast.in.interval;
 	bap_qos->bcast.io_qos.latency = iso_qos->bcast.in.latency;
-	bap_qos->bcast.io_qos.phy = iso_qos->bcast.in.phys;
+	bap_qos->bcast.io_qos.phys = iso_qos->bcast.in.phys;
 	bap_qos->bcast.io_qos.rtn = iso_qos->bcast.in.rtn;
 	bap_qos->bcast.io_qos.sdu = iso_qos->bcast.in.sdu;
 }
diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index cb78b668dbe5..e5999f88f9ee 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -491,7 +491,7 @@
 	.ucast.io_qos.interval = _interval, \
 	.ucast.io_qos.latency = _lat, \
 	.ucast.io_qos.sdu = _sdu, \
-	.ucast.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
+	.ucast.io_qos.phys = BT_BAP_CONFIG_PHY_2M, \
 	.ucast.io_qos.rtn = _rtn, \
 }
 
@@ -947,7 +947,7 @@
 	.bcast.io_qos.interval = _interval, \
 	.bcast.io_qos.latency = _lat, \
 	.bcast.io_qos.sdu = _sdu, \
-	.bcast.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
+	.bcast.io_qos.phys = BT_BAP_CONFIG_PHY_2M, \
 	.bcast.io_qos.rtn = _rtn, \
 }
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index cdd1bed7e1ff..3a67e7016e4e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -1576,7 +1576,7 @@ static void test_disc(void)
 #define QOS_BALANCED_2M \
 	{ \
 		.target_latency = BT_BAP_CONFIG_LATENCY_BALANCED, \
-		.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
+		.io_qos.phys = BT_BAP_CONFIG_PHY_2M, \
 	}
 #define QOS_UCAST \
 {\
@@ -7533,7 +7533,7 @@ static struct test_config cfg_bsrc_48_6_2 = {
 	.bcast.io_qos.interval = 7500, \
 	.bcast.io_qos.latency = 10, \
 	.bcast.io_qos.sdu = 40, \
-	.bcast.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
+	.bcast.io_qos.phys = BT_BAP_CONFIG_PHY_2M, \
 	.bcast.io_qos.rtn = 2, \
 }
 
-- 
2.52.0

