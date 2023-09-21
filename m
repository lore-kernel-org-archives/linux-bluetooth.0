Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A2FE7D0B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Sep 2023 23:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjIUXrw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXrw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 19:47:52 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328C8F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:44 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57b3d8de4a2so841332eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 16:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695340063; x=1695944863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtGiSV1E5U4cehaNWHPMnXXwXJDO7i/5cOKi8COIW5k=;
        b=ALVGNI2OYWhsMXBnvw7JfkJxZ4Ev5TAHUbfmoDgLz+33zDMsVHR1AnGkTuz0xEA+rk
         JFASnDoCaArMs4J4Scv9F2eAKCVdmIy7jQpfHr5ghYUm73jc0zH/4xESArrqBoy+18Ci
         FTY6Amihu3VMnzcAhxwkEFuysFD/AA4Imao2MvBQ0oGZjCeWkTDyOCkLyaU3EmLy+tij
         5JpFWv2fIj7cmlbZzoVJBi+Tlbi4CZgGFhGkCaHfAP7ip6I59VxJgUYkYu8XGTApBbH+
         FaCUgYaGbDnxPPKnqS7teUGVmachDThDHepg0zcYo/B2xHgWfi09gEaDTHE8N6KUTgz6
         alLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340063; x=1695944863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtGiSV1E5U4cehaNWHPMnXXwXJDO7i/5cOKi8COIW5k=;
        b=LVTDL8Ek3pv+Si9bdPlRHGeoUKr1RcBF2ITMksKOEVdfxUwMLI1kvfyUHWp8Wnkag5
         HAHIIdcGNhkCsm1koIc/xa2SkMcJLHdkPZshY5lfcPSVbbfvzNuDT83s0LF8+ExaQVCW
         Nbmr3XK6PZLOqP8b78Vbd6xVpR/7OjwIbL47+Phj03GdRx+61vGoDfUNmwMMKY2l5uGs
         JWzX5TJdRh4E66R2iJ9y9/SKt/WCgrJAsMRBzq1kOj1Ao+aIrLwJT9IlaOIqT/sKzekB
         FNYOIbyPJkDwn3J6QwYrMabWCEiO7+zYJR4k4dzHkBD/Ui5+udmLBKIGWmTZJkMPzge5
         QxWQ==
X-Gm-Message-State: AOJu0YxtyGR2pyUrLE0PJVB5BArMMPqs7u5gQb41gUG5mnwXFE/KvpOY
        6zFVybSpNGLXJyTSnLXVUXLO7A86bBM=
X-Google-Smtp-Source: AGHT+IFZKV5qp+Bl6HdigMrw3ihfBmHfX+yrtK49HjOi7627Do2erGZI0btBuMS7vlQNvncSTsRFWQ==
X-Received: by 2002:a05:6358:2607:b0:141:bfc:b11d with SMTP id l7-20020a056358260700b001410bfcb11dmr7926755rwc.16.1695340062871;
        Thu, 21 Sep 2023 16:47:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b00690fb385ea9sm1959824pfo.47.2023.09.21.16.47.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 16:47:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] transport: Implement QoS property
Date:   Thu, 21 Sep 2023 16:47:35 -0700
Message-ID: <20230921234738.929423-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921234738.929423-1-luiz.dentz@gmail.com>
References: <20230921234738.929423-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements Transport.QoS as a dict instead of listing each field as
a individual property.
---
 client/player.c            |   6 +-
 lib/bluetooth.h            |   2 +-
 profiles/audio/bap.c       |   6 +-
 profiles/audio/transport.c | 431 ++++++++-----------------------------
 src/shared/bap.h           |   2 +-
 src/shared/bass.c          |   2 +-
 tools/iso-tester.c         |   6 +-
 tools/isotest.c            |   2 +-
 8 files changed, 98 insertions(+), 359 deletions(-)

diff --git a/client/player.c b/client/player.c
index b92f529c693a..ac8493d3cb0b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1873,7 +1873,7 @@ static struct bt_iso_qos bcast_qos = {
 	.bcast = {
 		.big = BT_ISO_QOS_BIG_UNSET,
 		.bis = BT_ISO_QOS_BIS_UNSET,
-		.sync_interval = 24,
+		.sync_factor = 24,
 		.packing = 0x00,
 		.framing = 0x00,
 		.encryption = 0x00,
@@ -1991,10 +1991,10 @@ static void append_properties(DBusMessageIter *iter,
 	if (!cfg->ep->broadcast)
 		goto done;
 
-	bt_shell_printf("SyncInterval %u\n", bcast_qos.bcast.sync_interval);
+	bt_shell_printf("SyncInterval %u\n", bcast_qos.bcast.sync_factor);
 
 	g_dbus_dict_append_entry(&dict, "SyncInterval", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.sync_interval);
+						&bcast_qos.bcast.sync_factor);
 
 	bt_shell_printf("Encryption %u\n", bcast_qos.bcast.encryption);
 
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 1286aa763208..ba08c70e61b8 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -174,7 +174,7 @@ struct bt_iso_ucast_qos {
 struct bt_iso_bcast_qos {
 	uint8_t  big;
 	uint8_t  bis;
-	uint8_t  sync_interval;
+	uint8_t  sync_factor;
 	uint8_t  packing;
 	uint8_t  framing;
 	struct bt_iso_io_qos in;
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index d61b6f677660..c1fba6b1bff5 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -533,7 +533,7 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 				goto fail;
 
 			dbus_message_iter_get_basic(&value,
-						&qos->bcast.sync_interval);
+						&qos->bcast.sync_factor);
 		} else if (!strcasecmp(key, "MSE")) {
 			if (var != DBUS_TYPE_BYTE)
 				goto fail;
@@ -756,7 +756,7 @@ static void update_bcast_qos(struct bt_iso_qos *qos,
 {
 	bap_qos->bcast.big = qos->bcast.big;
 	bap_qos->bcast.bis = qos->bcast.bis;
-	bap_qos->bcast.sync_interval = qos->bcast.sync_interval;
+	bap_qos->bcast.sync_factor = qos->bcast.sync_factor;
 	bap_qos->bcast.packing = qos->bcast.packing;
 	bap_qos->bcast.framing = qos->bcast.framing;
 	bap_qos->bcast.encryption = qos->bcast.encryption;
@@ -1671,7 +1671,7 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 
 	iso_qos.bcast.big = ep->qos.bcast.big;
 	iso_qos.bcast.bis = ep->qos.bcast.bis;
-	iso_qos.bcast.sync_interval = ep->qos.bcast.sync_interval;
+	iso_qos.bcast.sync_factor = ep->qos.bcast.sync_factor;
 	iso_qos.bcast.packing = ep->qos.bcast.packing;
 	iso_qos.bcast.framing = ep->qos.bcast.framing;
 	iso_qos.bcast.encryption = ep->qos.bcast.encryption;
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 2998d6bab00d..6c2cb598fe96 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -850,160 +850,41 @@ static const GDBusPropertyTable a2dp_properties[] = {
 	{ }
 };
 
-static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
+static void append_io_qos(DBusMessageIter *dict, struct bt_bap_io_qos *qos)
 {
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	if (media_endpoint_is_broadcast(transport->endpoint))
-		return bap->qos.bcast.io_qos.sdu != 0x00;
-
-	return bap->qos.ucast.io_qos.phy != 0x00;
+	dict_append_entry(dict, "Interval", DBUS_TYPE_UINT32, &qos->interval);
+	dict_append_entry(dict, "Latency", DBUS_TYPE_UINT16, &qos->latency);
+	dict_append_entry(dict, "SDU", DBUS_TYPE_UINT16, &qos->sdu);
+	dict_append_entry(dict, "PHY", DBUS_TYPE_BYTE, &qos->phy);
+	dict_append_entry(dict, "Retransmissions", DBUS_TYPE_BYTE, &qos->rtn);
 }
 
-static gboolean get_cig(const GDBusPropertyTable *property,
+static gboolean get_ucast_qos(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
+	DBusMessageIter dict;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.ucast.cig_id);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
 
-	return TRUE;
-}
+	dict_append_entry(&dict, "CIG", DBUS_TYPE_BYTE,
+					&bap->qos.ucast.cig_id);
+	dict_append_entry(&dict, "CIS", DBUS_TYPE_BYTE,
+					&bap->qos.ucast.cis_id);
+	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
+					&bap->qos.ucast.framing);
+	dict_append_entry(&dict, "PresentationDelay", DBUS_TYPE_UINT32,
+					&bap->qos.ucast.delay);
 
-static gboolean get_big(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
+	append_io_qos(&dict, &bap->qos.ucast.io_qos);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.bcast.big);
-
-	return TRUE;
-}
-
-static gboolean get_cis(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.ucast.cis_id);
-
-	return TRUE;
-}
-
-static gboolean get_bis(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-							&bap->qos.bcast.bis);
-
-	return TRUE;
-}
-
-static gboolean get_interval(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
-					&bap->qos.ucast.io_qos.interval);
-
-	return TRUE;
-}
-
-static gboolean get_framing(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-	dbus_bool_t val = bap->qos.ucast.framing;
-
-	if (media_endpoint_is_broadcast(transport->endpoint))
-		val = bap->qos.bcast.framing;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
-
-	return TRUE;
-}
-
-static gboolean get_phy(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	if (media_endpoint_is_broadcast(transport->endpoint)) {
-		dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-					&bap->qos.bcast.io_qos.phy);
-		return TRUE;
-	}
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-					&bap->qos.ucast.io_qos.phy);
-
-	return TRUE;
-}
-
-static gboolean get_sdu(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	if (media_endpoint_is_broadcast(transport->endpoint)) {
-		dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-					&bap->qos.bcast.io_qos.sdu);
-		return TRUE;
-	}
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-					&bap->qos.ucast.io_qos.sdu);
-
-	return TRUE;
-}
-
-static gboolean get_retransmissions(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-					&bap->qos.ucast.io_qos.rtn);
-
-	return TRUE;
-}
-
-static gboolean get_latency(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-					&bap->qos.ucast.io_qos.latency);
-
-	return TRUE;
-}
-
-static gboolean get_delay(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
-						&bap->qos.ucast.delay);
+	dbus_message_iter_close_container(iter, &dict);
 
 	return TRUE;
 }
@@ -1084,119 +965,12 @@ static gboolean get_links(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean get_sync_interval(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
+static gboolean qos_ucast_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-						&bap->qos.bcast.sync_interval);
-
-	return TRUE;
-}
-
-static gboolean get_packing(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-						&bap->qos.bcast.packing);
-
-	return TRUE;
-}
-
-static gboolean get_bcode(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-	DBusMessageIter array;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-					DBUS_TYPE_BYTE_AS_STRING, &array);
-
-	if (bap->qos.bcast.bcode && bap->qos.bcast.bcode->iov_len)
-		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
-						&bap->qos.bcast.bcode->iov_base,
-						bap->qos.bcast.bcode->iov_len);
-
-	dbus_message_iter_close_container(iter, &array);
-	return TRUE;
-}
-
-static gboolean get_options(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-					&bap->qos.bcast.options);
-
-	return TRUE;
-}
-
-static gboolean get_skip(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-					&bap->qos.bcast.skip);
-
-	return TRUE;
-}
-
-static gboolean get_sync_timeout(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-					&bap->qos.bcast.sync_timeout);
-
-	return TRUE;
-}
-
-static gboolean get_sync_cte_type(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-					&bap->qos.bcast.sync_cte_type);
-
-	return TRUE;
-}
-
-static gboolean get_mse(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
-					&bap->qos.bcast.mse);
-
-	return TRUE;
-}
-
-static gboolean get_timeout(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *data)
-{
-	struct media_transport *transport = data;
-	struct bap_transport *bap = transport->data;
-
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
-					&bap->qos.bcast.timeout);
-
-	return TRUE;
+	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
 static const GDBusPropertyTable bap_ucast_properties[] = {
@@ -1205,15 +979,7 @@ static const GDBusPropertyTable bap_ucast_properties[] = {
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "CIG", "y", get_cig, NULL, qos_exists },
-	{ "CIS", "y", get_cis, NULL, qos_exists },
-	{ "Interval", "u", get_interval, NULL, qos_exists },
-	{ "Framing", "b", get_framing, NULL, qos_exists },
-	{ "PHY", "y", get_phy, NULL, qos_exists },
-	{ "SDU", "q", get_sdu, NULL, qos_exists },
-	{ "Retransmissions", "y", get_retransmissions, NULL, qos_exists },
-	{ "Latency", "q", get_latency, NULL, qos_exists },
-	{ "Delay", "u", get_delay, NULL, qos_exists },
+	{ "QoS", "a{sv}", get_ucast_qos, NULL, qos_ucast_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
@@ -1221,6 +987,61 @@ static const GDBusPropertyTable bap_ucast_properties[] = {
 	{ }
 };
 
+static gboolean get_bcast_qos(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	dict_append_entry(&dict, "BIG", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.big);
+	dict_append_entry(&dict, "BIS", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.bis);
+	dict_append_entry(&dict, "SyncFactor", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.sync_factor);
+	dict_append_entry(&dict, "Packing", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.packing);
+	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.framing);
+	if (bap->qos.bcast.bcode)
+		dict_append_array(&dict, "BCode", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.bcode->iov_base,
+					bap->qos.bcast.bcode->iov_len);
+	dict_append_entry(&dict, "Options", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.options);
+	dict_append_entry(&dict, "Skip", DBUS_TYPE_UINT16,
+					&bap->qos.bcast.skip);
+	dict_append_entry(&dict, "SyncTimeout", DBUS_TYPE_UINT16,
+					&bap->qos.bcast.sync_timeout);
+	dict_append_entry(&dict, "SyncType", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.sync_cte_type);
+	dict_append_entry(&dict, "MSE", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.mse);
+	dict_append_entry(&dict, "Timeout", DBUS_TYPE_UINT16,
+					&bap->qos.bcast.timeout);
+
+	append_io_qos(&dict, &bap->qos.bcast.io_qos);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
+static gboolean qos_bcast_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	return bap->qos.bcast.io_qos.phy != 0x00;
+}
 
 static const GDBusPropertyTable bap_bcast_properties[] = {
 	{ "Device", "o", get_device },
@@ -1228,17 +1049,7 @@ static const GDBusPropertyTable bap_bcast_properties[] = {
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "BIG", "y", get_big, NULL, qos_exists },
-	{ "BIS", "y", get_bis, NULL, qos_exists },
-	{ "SyncInterval", "y", get_sync_interval, NULL, qos_exists },
-	{ "Packing", "y", get_packing, NULL, qos_exists },
-	{ "BCode", "ay", get_bcode, NULL, qos_exists },
-	{ "Options", "y", get_options, NULL, qos_exists },
-	{ "Skip", "q", get_skip, NULL, qos_exists },
-	{ "SyncTimeout", "q", get_sync_timeout, NULL, qos_exists },
-	{ "SyncCteType", "y", get_sync_cte_type, NULL, qos_exists },
-	{ "MSE", "y", get_mse, NULL, qos_exists },
-	{ "Timeout", "q", get_timeout, NULL, qos_exists },
+	{ "QoS", "a{sv}", get_bcast_qos, NULL, qos_bcast_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
@@ -1466,31 +1277,7 @@ static void bap_update_qos(const struct media_transport *transport)
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"CIG");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"CIS");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Interval");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Framing");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"PHY");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"SDU");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Retransmissions");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Latency");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Delay");
+			"QoS");
 }
 
 static gboolean bap_resume_complete_cb(void *data)
@@ -1533,55 +1320,7 @@ static void bap_update_bcast_qos(const struct media_transport *transport)
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"BIG");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"BIS");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"SyncInterval");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Packing");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Framing");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"BCode");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Options");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Skip");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"SyncTimeout");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"SyncCteType");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"MSE");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Timeout");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Interval");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"Latency");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"PHY");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"SDU");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-			transport->path, MEDIA_TRANSPORT_INTERFACE,
-			"RTN");
+			"QoS");
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 			transport->path, MEDIA_TRANSPORT_INTERFACE,
 			"Codec");
diff --git a/src/shared/bap.h b/src/shared/bap.h
index edb5c1bed27e..e4eae86502f3 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -75,7 +75,7 @@ struct bt_bap_ucast_qos {
 struct bt_bap_bcast_qos {
 	uint8_t  big;
 	uint8_t  bis;
-	uint8_t  sync_interval;
+	uint8_t  sync_factor;
 	uint8_t  packing;
 	uint8_t  framing;
 	uint8_t  encryption;
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 86dab03e3993..37255aff64f3 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -102,7 +102,7 @@ static struct bt_iso_qos default_qos = {
 	.bcast = {
 		.big			= BT_ISO_QOS_BIG_UNSET,
 		.bis			= BT_ISO_QOS_BIS_UNSET,
-		.sync_interval		= 0x07,
+		.sync_factor		= 0x07,
 		.packing		= 0x00,
 		.framing		= 0x00,
 		.in			= DEFAULT_IO_QOS,
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 80f72221e7f0..36879d9fc112 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -247,7 +247,7 @@
 	.bcast = { \
 		.big = _big, \
 		.bis = _bis, \
-		.sync_interval = 0x07, \
+		.sync_factor = 0x07, \
 		.packing = 0x00, \
 		.framing = 0x00, \
 		.in = _in, \
@@ -1712,9 +1712,9 @@ static bool check_bcast_qos(const struct bt_iso_qos *qos1,
 		return false;
 	}
 
-	if (qos1->bcast.sync_interval != qos2->bcast.sync_interval) {
+	if (qos1->bcast.sync_factor != qos2->bcast.sync_factor) {
 		tester_warn("Unexpected QoS sync interval: 0x%02x != 0x%02x",
-			qos1->bcast.sync_interval, qos2->bcast.sync_interval);
+			qos1->bcast.sync_factor, qos2->bcast.sync_factor);
 		return false;
 	}
 
diff --git a/tools/isotest.c b/tools/isotest.c
index 9bbd861a92ca..4b64ea5bfa8c 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -1028,7 +1028,7 @@ static void multy_connect_mode(char *peer)
 	.bcast = { \
 		.big = BT_ISO_QOS_BIG_UNSET, \
 		.bis = BT_ISO_QOS_BIS_UNSET, \
-		.sync_interval = 0x07, \
+		.sync_factor = 0x07, \
 		.packing = 0x00, \
 		.framing = 0x00, \
 		.out = QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
-- 
2.41.0

