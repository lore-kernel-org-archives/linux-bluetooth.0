Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276872E85F
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613602; cv=none; b=Zr9LoMFOCk4JYXRwh5q1RvHGU5ClmqumKodknldAyG3CJ9JPP6sIZCLchgBLNAjAYkc14teO+VSWArdAmJnyCEO2WgtoncW5zsEv3B/VgmafgehlTvfCXA04UNlk9oJ3tFWjSQhnwbvlMittRXevS+YSGFE22YwiAKqje9WdfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613602; c=relaxed/simple;
	bh=MIt2/AT7AzXthRI1r75h/UsmD+7Qmo2+bGcP1c4Q7qY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbkc8v8fqRqKqkk+UCvrOCU6ZsEohmsqgCYbC+1ydlJaH3+bateCMFPTViBcuI/9gqnOraiNZn8mDnC7m24PGNNo3SFb35bsSAdZ6dGi16KdxKYxDgTsJ6ZGqCtVtGR/2rEKkea0HQNgovTTw14k6MgH3WSsL5lu52tDUv7cX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpGyukYQ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpGyukYQ"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dafe04717baso149765276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705613599; x=1706218399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6j45BN6efBluIRNXZybeRar2DgujNdmx1ktfsogHd0=;
        b=ZpGyukYQLMtlLV6WBHUcAnwUVZCqORA9qWt+3msp9V83+588N/HKgd3y5yqw65+I+P
         62NHZv1lc/D6lui0edGU7aB3AofXLVpHEwCnbOiEK6M7q1wdHpkpJPuG2z13y/qOER/7
         Nec0lX5qzTd9M34vT4PrZcnNS8A/68dXhQ8/RzZLp5Q3d0E84WaeD7/baH+IxkOalCz1
         +fTOfD0l0JLkDi1eMQIeW8QJn1EVlG60Ttj1FhHHbUtZj9Q2H+67l3LY2eq4q8OmK8LP
         ZGxG0II9GWMVOD4FPlhd6ysl+ZCMFzZzA09aiBh4QNXUpntGfE50Xt06aGSdalqOwjcs
         9S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705613599; x=1706218399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6j45BN6efBluIRNXZybeRar2DgujNdmx1ktfsogHd0=;
        b=iqtB/snsd+fNwC+HfbVrTlGcxIk/WtVEp/SuvrAtsYYKhHW13ye4ZrS+s51j+44g9q
         KRQp8vTtCDk1tu9isa+t5DKqNRY32WIPTd4Mf7Ur3WorPonMK5XWqEmf/EwPTv8FBapt
         7cH2lq+JEqNKJ1xTZ3tYGis5K1tEaOgA/Tro1Q6URDUSBdjAkPZ7n0h3nivnc8/O+8vq
         Md/HVB6WIKI/lA6tfEVqdaZOh9WPcskba9tUwpeV+xo0uGiP49wdaL35UJat3I5UpyvF
         w3TFYhjWdI1ijD46cXmxMpxQPAivWydryqXh6PjDGn+/0QxZF1g4fRl+Ly/FIer3T8su
         YsCA==
X-Gm-Message-State: AOJu0Yw6ieaMy7Lrg3vwm2oVleX088sgnZ2uhhrs50oCLTrGjIEYbjt0
	rKEjAUnADgLl1p8h9jg3f3iERad0AnBLASto6A733t/17ZrxDBGRlc2QHcma
X-Google-Smtp-Source: AGHT+IGXeJ+5IDjKSOsqo7TkaI5xzP9VyfKaOW8DpnHewVxOY7f2iG3wm/ASfxwhPwRpeYQgQjw4lg==
X-Received: by 2002:a25:2f17:0:b0:db5:37c7:a0cb with SMTP id v23-20020a252f17000000b00db537c7a0cbmr1277674ybv.11.1705613599242;
        Thu, 18 Jan 2024 13:33:19 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id d7-20020a254f07000000b00dbd9a0ec1d5sm6301383ybb.47.2024.01.18.13.33.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:33:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] bap: Fix crash when attempting to setup a broadcast source
Date: Thu, 18 Jan 2024 16:33:14 -0500
Message-ID: <20240118213314.2066415-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118213314.2066415-1-luiz.dentz@gmail.com>
References: <20240118213314.2066415-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes a crash which could be observed with the following commands:

Run bluetoothctl -e:
> endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep2 16_2_1
> transport.acquire /org/bluez/hci0/pac_bcast0/fd0
---
 profiles/audio/bap.c       | 127 ++++++++++++++++++++-----------------
 profiles/audio/transport.c |   3 +-
 2 files changed, 70 insertions(+), 60 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b888764855ef..69e982832f89 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -66,6 +66,8 @@ struct bap_setup {
 	struct bap_ep *ep;
 	struct bt_bap_stream *stream;
 	struct bt_bap_qos qos;
+	int (*qos_parser)(struct bap_setup *setup, const char *key, int var,
+							DBusMessageIter *iter);
 	GIOChannel *io;
 	unsigned int io_id;
 	bool recreate;
@@ -75,6 +77,7 @@ struct bap_setup {
 	unsigned int id;
 	struct iovec *base;
 	DBusMessage *msg;
+	void (*destroy)(struct bap_setup *setup);
 };
 
 struct bap_ep {
@@ -514,9 +517,11 @@ static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
 	return 0;
 }
 
-static int parse_ucast_qos(const char *key, int var, DBusMessageIter *iter,
-				struct bt_bap_qos *qos)
+static int setup_parse_ucast_qos(struct bap_setup *setup, const char *key,
+					int var, DBusMessageIter *iter)
 {
+	struct bt_bap_qos *qos = &setup->qos;
+
 	if (!strcasecmp(key, "CIG")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -553,9 +558,18 @@ static int parse_ucast_qos(const char *key, int var, DBusMessageIter *iter,
 	return 0;
 }
 
-static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
-				struct bt_bap_qos *qos)
+static void setup_bcast_destroy(struct bap_setup *setup)
 {
+	struct bt_bap_qos *qos = &setup->qos;
+
+	util_iov_free(qos->bcast.bcode, 1);
+}
+
+static int setup_parse_bcast_qos(struct bap_setup *setup, const char *key,
+					int var, DBusMessageIter *iter)
+{
+	struct bt_bap_qos *qos = &setup->qos;
+
 	if (!strcasecmp(key, "Encryption")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -602,8 +616,15 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 		if (var != DBUS_TYPE_ARRAY)
 			return -EINVAL;
 
+		memset(&iov, 0, sizeof(iov));
+
 		parse_array(iter, &iov);
 
+		if (iov.iov_len != 16) {
+			error("Invalid size for BCode: %zu != 16", iov.iov_len);
+			return -EINVAL;
+		}
+
 		util_iov_free(qos->bcast.bcode, 1);
 		qos->bcast.bcode = util_iov_dup(&iov, 1);
 	} else {
@@ -617,18 +638,10 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 	return 0;
 }
 
-static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
-			struct iovec **base)
+static int setup_parse_qos(struct bap_setup *setup, DBusMessageIter *iter)
 {
 	DBusMessageIter array;
 	const char *key;
-	int (*parser)(const char *key, int var, DBusMessageIter *iter,
-			struct bt_bap_qos *qos);
-
-	if (*base)
-		parser = parse_bcast_qos;
-	else
-		parser = parse_ucast_qos;
 
 	dbus_message_iter_recurse(iter, &array);
 
@@ -644,7 +657,7 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
 
 		var = dbus_message_iter_get_arg_type(&value);
 
-		err = parser(key, var, &value, qos);
+		err = setup->qos_parser(setup, key, var, &value);
 		if (err) {
 			DBG("Failed parsing %s", key);
 			return err;
@@ -653,12 +666,23 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
 		dbus_message_iter_next(&array);
 	}
 
+	if (queue_find(setup->ep->data->bcast, NULL, setup->ep)) {
+		uint32_t presDelay;
+		uint8_t numSubgroups, numBis;
+		struct bt_bap_codec codec;
+
+		util_iov_free(setup->base, 1);
+		setup->base = util_iov_dup(setup->caps, 1);
+		parse_base(setup->base->iov_base, setup->base->iov_len,
+				bap_debug, &presDelay, &numSubgroups, &numBis,
+				&codec, &setup->caps, &setup->metadata);
+	}
+
 	return 0;
 }
 
-static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
-				struct iovec **metadata, struct iovec **base,
-				struct bt_bap_qos *qos)
+static int setup_parse_configuration(struct bap_setup *setup,
+					DBusMessageIter *props)
 {
 	const char *key;
 	struct iovec iov;
@@ -684,8 +708,8 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 			if (parse_array(&value, &iov))
 				goto fail;
 
-			util_iov_free(*caps, 1);
-			*caps = util_iov_dup(&iov, 1);
+			util_iov_free(setup->caps, 1);
+			setup->caps = util_iov_dup(&iov, 1);
 		} else if (!strcasecmp(key, "Metadata")) {
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
@@ -693,40 +717,24 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 			if (parse_array(&value, &iov))
 				goto fail;
 
-			util_iov_free(*metadata, 1);
-			*metadata = util_iov_dup(&iov, 1);
+			util_iov_free(setup->metadata, 1);
+			setup->metadata = util_iov_dup(&iov, 1);
 		} else if (!strcasecmp(key, "QoS")) {
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 
-			if (parse_qos(&value, qos, base))
+			if (setup_parse_qos(setup, &value))
 				goto fail;
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	if (*base) {
-		uint32_t presDelay;
-		uint8_t numSubgroups, numBis;
-		struct bt_bap_codec codec;
-
-		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
-		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis, &codec,
-			caps, NULL);
-	}
-
 	return 0;
 
 fail:
 	DBG("Failed parsing %s", key);
 
-	if (*caps) {
-		free(*caps);
-		*caps = NULL;
-	}
-
 	return -EINVAL;
 }
 
@@ -819,6 +827,19 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 	setup = new0(struct bap_setup, 1);
 	setup->ep = ep;
 
+	if (queue_find(ep->data->bcast, NULL, ep)) {
+		/* Mark BIG and BIS to be auto assigned */
+		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
+		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+		setup->qos_parser = setup_parse_bcast_qos;
+		setup->destroy = setup_bcast_destroy;
+	} else {
+		/* Mark CIG and CIS to be auto assigned */
+		setup->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
+		setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
+		setup->qos_parser = setup_parse_ucast_qos;
+	}
+
 	if (!ep->setups)
 		ep->setups = queue_new();
 
@@ -844,8 +865,8 @@ static void setup_free(void *data)
 	util_iov_free(setup->metadata, 1);
 	util_iov_free(setup->base, 1);
 
-	if (bt_bap_stream_get_type(setup->stream) == BT_BAP_STREAM_TYPE_BCAST)
-		util_iov_free(setup->qos.bcast.bcode, 1);
+	if (setup->destroy)
+		setup->destroy(setup);
 
 	free(setup);
 }
@@ -872,18 +893,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 
 	setup = setup_new(ep);
 
-	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
-		/* Mark BIG and BIS to be auto assigned */
-		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
-		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
-	} else {
-		/* Mark CIG and CIS to be auto assigned */
-		setup->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
-		setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
-	}
-
-	if (parse_configuration(&props, &setup->caps, &setup->metadata,
-				&setup->base, &setup->qos) < 0) {
+	if (setup_parse_configuration(setup, &props) < 0) {
 		DBG("Unable to parse configuration");
 		setup_free(setup);
 		return btd_error_invalid_args(msg);
@@ -943,10 +953,10 @@ static void update_bcast_qos(struct bt_iso_qos *qos,
 	bap_qos->bcast.io_qos.phy = qos->bcast.in.phy;
 	bap_qos->bcast.io_qos.sdu = qos->bcast.in.sdu;
 	bap_qos->bcast.io_qos.rtn = qos->bcast.in.rtn;
-
-	bap_qos->bcast.bcode = new0(struct iovec, 1);
+	if (!bap_qos->bcast.bcode)
+		bap_qos->bcast.bcode = new0(struct iovec, 1);
 	util_iov_memcpy(bap_qos->bcast.bcode, qos->bcast.bcode,
-		sizeof(qos->bcast.bcode));
+						sizeof(qos->bcast.bcode));
 }
 
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
@@ -1901,6 +1911,8 @@ static void setup_create_bcast_io(struct bap_data *data,
 					struct bap_setup *setup,
 					struct bt_bap_stream *stream, int defer)
 {
+	struct bt_bap_qos *qos = &setup->qos;
+	struct iovec *bcode = qos->bcast.bcode;
 	struct bt_iso_qos iso_qos;
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
@@ -1914,9 +1926,8 @@ static void setup_create_bcast_io(struct bap_data *data,
 	iso_qos.bcast.packing = setup->qos.bcast.packing;
 	iso_qos.bcast.framing = setup->qos.bcast.framing;
 	iso_qos.bcast.encryption = setup->qos.bcast.encryption;
-	if (setup->qos.bcast.bcode)
-		memcpy(iso_qos.bcast.bcode, setup->qos.bcast.bcode->iov_base,
-									16);
+	if (bcode && bcode->iov_base)
+		memcpy(iso_qos.bcast.bcode, bcode->iov_base, bcode->iov_len);
 	iso_qos.bcast.options = setup->qos.bcast.options;
 	iso_qos.bcast.skip = setup->qos.bcast.skip;
 	iso_qos.bcast.sync_timeout = setup->qos.bcast.sync_timeout;
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5395985b990f..d89e75915787 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1798,8 +1798,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 		transport->adapter = media_endpoint_get_btd_adapter(endpoint);
 
 	transport->endpoint = endpoint;
-	transport->configuration = g_new(uint8_t, size);
-	memcpy(transport->configuration, configuration, size);
+	transport->configuration = util_memdup(configuration, size);
 	transport->size = size;
 	transport->remote_endpoint = remote_endpoint;
 
-- 
2.43.0

