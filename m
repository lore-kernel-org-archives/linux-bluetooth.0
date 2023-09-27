Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C39E7F14F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjI0VyI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjI0VyH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:54:07 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DEFB
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-351365e47f6so26040465ab.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851644; x=1696456444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LYirlf9dOaUzJulMGXdd1bw4TsoU8BSK/GBa/WWho8=;
        b=LlKPycqyf3zV2gOrDsiOivhFrRu2Vs75JnIZEA+nJjRM90tdoew+61pYl/yCp7c4na
         aDD38I++knlSQnAR7lbZbTq44OKi2J6jMezHT2MCX1L47KCog5fL8zCy/PpUBHdCxUmA
         Vk8KUlZPqh3YnLGp2H9MdHQlYu9zohzvvloqOWRA2c3D70W94WVxhTheyKkoTs/zxm+0
         1UDsbiSFQ8ImdDJ5LuLWG3+JVr1YJAgsgV6Mk0DTokVKvxpPZN5/+mxeoPl4a/h+WyJO
         fR23qyyhvLhOFuqFJAUMDQ0qn71kNukbBuik1QW3cbCijqNHcjmBo4cExSBBsCfexGEa
         /Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851644; x=1696456444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LYirlf9dOaUzJulMGXdd1bw4TsoU8BSK/GBa/WWho8=;
        b=Xb4B+klSz3zESDk95aKf/j43DUoNfFIzCTxASoutjFZFUZcTwbyneTkcmDWqH0hBUy
         O+f5G0Lk+WhXczVjvXMgFhzo/oAL/TA1KvQok3foq6z9X25+1v7kRBoSXa/xoX+4NFId
         JaCeeDj6KtP9GG0qwgvAyXKMTgQpTYWRukcyBEM8NKVfoscb5kTKvfxuA86zXR2KwBEg
         HxbjsvIklMysoChHPnJ8yyfd09N+m5Hsf3+VbkbmUQovZFhEcWG/4CWwVCihRgpszkvh
         LjC6WnPBzwy4bUSubYMHbB9NDXvCulmuXZM00V8WvkBHpD0OReExojP0mwodDXAnlkiT
         CcGA==
X-Gm-Message-State: AOJu0Yx9IocQ0nQZqc+7hVe6d6q2CKKZO2Bep81oOjEZQLjncm3nxlBk
        yjNf64k8gcEv2uyAtMos9Eev+Jm3qJJOEZcs
X-Google-Smtp-Source: AGHT+IESa7nKrF1Kl5wZegFhe/Lz0rCPyGOiMgZXyKG8SsUNmJA5F1Lkxw42NkZu50ifgiPR1nH1ig==
X-Received: by 2002:a92:cc82:0:b0:34f:fdbd:244a with SMTP id x2-20020a92cc82000000b0034ffdbd244amr2762212ilo.32.1695851643857;
        Wed, 27 Sep 2023 14:54:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id g15-20020a02cd0f000000b0042bbfe3dc42sm4225331jaq.173.2023.09.27.14.54.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:54:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 05/12] client: Make Endpoint.SelectProperties reply properly
Date:   Wed, 27 Sep 2023 14:53:47 -0700
Message-ID: <20230927215354.1874835-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes Endpoint.SelectProperties reply with QoS property since it
is now a single property.
---
 client/player.c | 316 +++++++++++++++++++++++++++---------------------
 client/print.c  |  16 ++-
 2 files changed, 188 insertions(+), 144 deletions(-)

diff --git a/client/player.c b/client/player.c
index d72ad6a5da01..6953eff28543 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1199,7 +1199,7 @@ static const struct capabilities {
 struct codec_qos {
 	uint32_t interval;
 	uint8_t  framing;
-	char *phy;
+	uint8_t  phy;
 	uint16_t sdu;
 	uint8_t  rtn;
 	uint16_t latency;
@@ -1274,22 +1274,22 @@ static struct codec_preset sbc_presets[] = {
 	QOS_CONFIG(_interval, 0x01, _phy, _sdu, _rtn, _latency, _delay)
 
 #define QOS_UNFRAMED_1M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_UNFRAMED(_interval, "1M", _sdu, _rtn, _latency, _delay) \
+	QOS_UNFRAMED(_interval, 0x01, _sdu, _rtn, _latency, _delay) \
 
 #define QOS_FRAMED_1M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_FRAMED(_interval, "1M", _sdu, _rtn, _latency, _delay) \
+	QOS_FRAMED(_interval, 0x01, _sdu, _rtn, _latency, _delay) \
 
 #define QOS_UNFRAMED_2M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_UNFRAMED(_interval, "2M", _sdu, _rtn, _latency, _delay) \
+	QOS_UNFRAMED(_interval, 0x02, _sdu, _rtn, _latency, _delay) \
 
 #define QOS_FRAMED_2M(_interval, _sdu, _rtn, _latency, _delay) \
-	QOS_FRAMED(_interval, "2M", _sdu, _rtn, _latency, _delay) \
+	QOS_FRAMED(_interval, 0x02, _sdu, _rtn, _latency, _delay) \
 
 #define LC3_7_5_UNFRAMED(_sdu, _rtn, _latency, _delay) \
-	QOS_UNFRAMED(7500u, "2M", _sdu, _rtn, _latency, _delay)
+	QOS_UNFRAMED(7500u, 0x02, _sdu, _rtn, _latency, _delay)
 
 #define LC3_7_5_FRAMED(_sdu, _rtn, _latency, _delay) \
-	QOS_FRAMED(7500u, "2M", _sdu, _rtn, _latency, _delay)
+	QOS_FRAMED(7500u, 0x02, _sdu, _rtn, _latency, _delay)
 
 #define LC3_10_UNFRAMED(_sdu, _rtn, _latency, _delay) \
 	QOS_UNFRAMED_2M(10000u, _sdu, _rtn, _latency, _delay)
@@ -1770,14 +1770,174 @@ static struct bt_iso_qos bcast_qos = {
 	}
 };
 
+static void append_io_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
+{
+	struct codec_qos *qos = (void *)cfg->qos;
+
+	bt_shell_printf("Interval %u\n", qos->interval);
+
+	g_dbus_dict_append_entry(iter, "Interval", DBUS_TYPE_UINT32,
+						&qos->interval);
+
+	bt_shell_printf("PHY 0x%02x\n", qos->phy);
+
+	g_dbus_dict_append_entry(iter, "PHY", DBUS_TYPE_BYTE, &qos->phy);
+
+	bt_shell_printf("SDU %u\n", cfg->qos->sdu);
+
+	g_dbus_dict_append_entry(iter, "SDU", DBUS_TYPE_UINT16, &qos->sdu);
+
+	bt_shell_printf("Retransmissions %u\n", qos->rtn);
+
+	g_dbus_dict_append_entry(iter, "Retransmissions",
+					DBUS_TYPE_BYTE, &qos->rtn);
+
+	bt_shell_printf("Latency %u\n", qos->latency);
+
+	g_dbus_dict_append_entry(iter, "Latency",
+					DBUS_TYPE_UINT16, &qos->latency);
+}
+
+static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
+{
+	struct codec_qos *qos = (void *)cfg->qos;
+
+	if (cfg->ep->iso_group != BT_ISO_QOS_GROUP_UNSET) {
+		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->iso_group);
+		g_dbus_dict_append_entry(iter, "CIG", DBUS_TYPE_BYTE,
+							&cfg->ep->iso_group);
+	}
+
+	if (cfg->ep->iso_stream != BT_ISO_QOS_STREAM_UNSET) {
+		bt_shell_printf("CIS 0x%2.2x\n", cfg->ep->iso_stream);
+		g_dbus_dict_append_entry(iter, "CIS", DBUS_TYPE_BYTE,
+							&cfg->ep->iso_stream);
+	}
+
+	bt_shell_printf("Framing 0x%02x\n", qos->framing);
+
+	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
+							&qos->framing);
+
+	bt_shell_printf("PresentationDelay %u\n", qos->delay);
+
+	g_dbus_dict_append_entry(iter, "PresentationDelay",
+					DBUS_TYPE_UINT32, &qos->delay);
+
+	if (cfg->target_latency) {
+		bt_shell_printf("TargetLatency 0x%02x\n", cfg->target_latency);
+		g_dbus_dict_append_entry(iter, "TargetLatency",
+					DBUS_TYPE_BYTE, &cfg->target_latency);
+	}
+
+	append_io_qos(iter, cfg);
+}
+
+static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
+{
+	if (bcast_qos.bcast.big != BT_ISO_QOS_BIG_UNSET) {
+		bt_shell_printf("BIG 0x%2.2x\n", bcast_qos.bcast.big);
+		g_dbus_dict_append_entry(iter, "BIG", DBUS_TYPE_BYTE,
+							&bcast_qos.bcast.big);
+	}
+
+	if (bcast_qos.bcast.bis != BT_ISO_QOS_BIS_UNSET) {
+		bt_shell_printf("BIS 0x%2.2x\n", bcast_qos.bcast.bis);
+		g_dbus_dict_append_entry(iter, "BIS", DBUS_TYPE_BYTE,
+							&bcast_qos.bcast.bis);
+	}
+
+	bt_shell_printf("Framing 0x%02x\n", bcast_qos.bcast.framing);
+
+	g_dbus_dict_append_entry(iter, "Framing", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.framing);
+
+	bt_shell_printf("SyncFactor %u\n", bcast_qos.bcast.sync_factor);
+
+	g_dbus_dict_append_entry(iter, "SyncFactor", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.sync_factor);
+
+	bt_shell_printf("Options %u\n", bcast_qos.bcast.options);
+
+	g_dbus_dict_append_entry(iter, "Options", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.options);
+
+	bt_shell_printf("Skip %u\n", bcast_qos.bcast.skip);
+
+	g_dbus_dict_append_entry(iter, "Skip", DBUS_TYPE_UINT16,
+						&bcast_qos.bcast.skip);
+
+	bt_shell_printf("SyncTimeout %u\n", bcast_qos.bcast.sync_timeout);
+
+	g_dbus_dict_append_entry(iter, "SyncTimeout", DBUS_TYPE_UINT16,
+						&bcast_qos.bcast.sync_timeout);
+
+	bt_shell_printf("SyncCteType %u\n", bcast_qos.bcast.sync_cte_type);
+
+	g_dbus_dict_append_entry(iter, "SyncType", DBUS_TYPE_BYTE,
+					&bcast_qos.bcast.sync_cte_type);
+
+	bt_shell_printf("MSE %u\n", bcast_qos.bcast.mse);
+
+	g_dbus_dict_append_entry(iter, "MSE", DBUS_TYPE_BYTE,
+						&bcast_qos.bcast.mse);
+
+	bt_shell_printf("Timeout %u\n", bcast_qos.bcast.timeout);
+
+	g_dbus_dict_append_entry(iter, "Timeout", DBUS_TYPE_UINT16,
+						&bcast_qos.bcast.timeout);
+
+	if (cfg->ep->bcode) {
+		const char *key = "BCode";
+
+		bt_shell_printf("BCode:\n");
+		bt_shell_hexdump(cfg->ep->bcode->iov_base,
+				cfg->ep->bcode->iov_len);
+
+		g_dbus_dict_append_basic_array(iter, DBUS_TYPE_STRING,
+						&key, DBUS_TYPE_BYTE,
+						&cfg->ep->bcode->iov_base,
+						cfg->ep->bcode->iov_len);
+	}
+
+	append_io_qos(iter, cfg);
+}
+
+static void append_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
+{
+	DBusMessageIter entry, var, dict;
+	struct codec_qos *qos = (void *)cfg->qos;
+	const char *key = "QoS";
+
+	if (!qos)
+		return;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+						"a{sv}", &var);
+
+	dbus_message_iter_open_container(&var, DBUS_TYPE_ARRAY, "{sv}",
+					&dict);
+
+	if (cfg->ep->broadcast)
+		append_bcast_qos(&dict, cfg);
+	else
+		append_ucast_qos(&dict, cfg);
+
+	dbus_message_iter_close_container(&var, &dict);
+	dbus_message_iter_close_container(&entry, &var);
+	dbus_message_iter_close_container(iter, &entry);
+}
+
 static void append_properties(DBusMessageIter *iter,
 						struct endpoint_config *cfg)
 {
 	DBusMessageIter dict;
-	struct codec_qos *qos = (void *)cfg->qos;
 	const char *key = "Capabilities";
-	const char *meta = "Metadata";
-	const char *keyBCode = "BroadcastCode";
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
@@ -1789,6 +1949,8 @@ static void append_properties(DBusMessageIter *iter,
 					cfg->caps->iov_len);
 
 	if (cfg->meta && cfg->meta->iov_len) {
+		const char *meta = "Metadata";
+
 		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
 				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
 				cfg->meta->iov_len);
@@ -1797,132 +1959,8 @@ static void append_properties(DBusMessageIter *iter,
 		bt_shell_hexdump(cfg->meta->iov_base, cfg->meta->iov_len);
 	}
 
-	if (!qos)
-		goto done;
+	append_qos(&dict, cfg);
 
-	if (cfg->target_latency) {
-		bt_shell_printf("TargetLatency 0x%02x\n", qos->interval);
-		g_dbus_dict_append_entry(&dict, "TargetLatency",
-					DBUS_TYPE_BYTE, &cfg->target_latency);
-	}
-
-	if ((!cfg->ep->broadcast) &&
-			(cfg->ep->iso_group != BT_ISO_QOS_GROUP_UNSET)) {
-		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->iso_group);
-		g_dbus_dict_append_entry(&dict, "CIG", DBUS_TYPE_BYTE,
-							&cfg->ep->iso_group);
-	} else {
-		bt_shell_printf("BIG 0x%2.2x\n", bcast_qos.bcast.big);
-		g_dbus_dict_append_entry(&dict, "BIG", DBUS_TYPE_BYTE,
-							&bcast_qos.bcast.big);
-	}
-
-	if ((!cfg->ep->broadcast) &&
-			(cfg->ep->iso_stream != BT_ISO_QOS_STREAM_UNSET)) {
-		bt_shell_printf("CIS 0x%2.2x\n", cfg->ep->iso_stream);
-		g_dbus_dict_append_entry(&dict, "CIS", DBUS_TYPE_BYTE,
-							&cfg->ep->iso_stream);
-
-	} else {
-		bt_shell_printf("BIS 0x%2.2x\n", bcast_qos.bcast.bis);
-		g_dbus_dict_append_entry(&dict, "BIS", DBUS_TYPE_BYTE,
-							&bcast_qos.bcast.bis);
-	}
-
-	bt_shell_printf("Interval %u\n", qos->interval);
-
-	g_dbus_dict_append_entry(&dict, "Interval", DBUS_TYPE_UINT32,
-						&qos->interval);
-
-	if (!cfg->ep->broadcast) {
-		bt_shell_printf("Framing %s\n",
-					qos->framing ? "true" : "false");
-
-		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
-							&qos->framing);
-	} else {
-		bt_shell_printf("Framing %s\n",
-				bcast_qos.bcast.framing ? "true" : "false");
-
-		g_dbus_dict_append_entry(&dict, "Framing", DBUS_TYPE_BOOLEAN,
-						&bcast_qos.bcast.framing);
-	}
-
-	bt_shell_printf("PHY %s\n", qos->phy);
-
-	g_dbus_dict_append_entry(&dict, "PHY", DBUS_TYPE_STRING, &qos->phy);
-
-	bt_shell_printf("SDU %u\n", cfg->qos->sdu);
-
-	g_dbus_dict_append_entry(&dict, "SDU", DBUS_TYPE_UINT16, &qos->sdu);
-
-	bt_shell_printf("Retransmissions %u\n", qos->rtn);
-
-	g_dbus_dict_append_entry(&dict, "Retransmissions", DBUS_TYPE_BYTE,
-						&qos->rtn);
-
-	bt_shell_printf("Latency %u\n", qos->latency);
-
-	g_dbus_dict_append_entry(&dict, "Latency", DBUS_TYPE_UINT16,
-						&qos->latency);
-
-	bt_shell_printf("Delay %u\n", qos->delay);
-
-	g_dbus_dict_append_entry(&dict, "Delay", DBUS_TYPE_UINT32,
-						&qos->delay);
-
-	if (!cfg->ep->broadcast)
-		goto done;
-
-	bt_shell_printf("SyncInterval %u\n", bcast_qos.bcast.sync_factor);
-
-	g_dbus_dict_append_entry(&dict, "SyncInterval", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.sync_factor);
-
-	bt_shell_printf("Encryption %u\n", bcast_qos.bcast.encryption);
-
-	g_dbus_dict_append_entry(&dict, "Encryption", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.encryption);
-
-	bt_shell_printf("Options %u\n", bcast_qos.bcast.options);
-
-	g_dbus_dict_append_entry(&dict, "Options", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.options);
-
-	bt_shell_printf("Skip %u\n", bcast_qos.bcast.skip);
-
-	g_dbus_dict_append_entry(&dict, "Skip", DBUS_TYPE_UINT16,
-						&bcast_qos.bcast.skip);
-
-	bt_shell_printf("SyncTimeout %u\n", bcast_qos.bcast.sync_timeout);
-
-	g_dbus_dict_append_entry(&dict, "SyncTimeout", DBUS_TYPE_UINT16,
-						&bcast_qos.bcast.sync_timeout);
-
-	bt_shell_printf("SyncCteType %u\n", bcast_qos.bcast.sync_cte_type);
-
-	g_dbus_dict_append_entry(&dict, "SyncCteType", DBUS_TYPE_BYTE,
-					&bcast_qos.bcast.sync_cte_type);
-
-	bt_shell_printf("MSE %u\n", bcast_qos.bcast.mse);
-
-	g_dbus_dict_append_entry(&dict, "MSE", DBUS_TYPE_BYTE,
-						&bcast_qos.bcast.mse);
-
-	bt_shell_printf("Timeout %u\n", bcast_qos.bcast.timeout);
-
-	g_dbus_dict_append_entry(&dict, "Timeout", DBUS_TYPE_UINT16,
-						&bcast_qos.bcast.timeout);
-
-	bt_shell_printf("BroadcastCode:\n");
-	bt_shell_hexdump(cfg->ep->bcode->iov_base, cfg->ep->bcode->iov_len);
-
-	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &keyBCode,
-						DBUS_TYPE_BYTE,
-						&cfg->ep->bcode->iov_base,
-						cfg->ep->bcode->iov_len);
-
-done:
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -2892,9 +2930,9 @@ static void custom_phy(const char *input, void *user_data)
 	struct codec_qos *qos = (void *)&p->qos;
 
 	if (!strcmp(input, "1M"))
-		qos->phy = "1M";
+		qos->phy = 0x01;
 	else if (!strcmp(input, "2M"))
-		qos->phy = "2M";
+		qos->phy = 0x02;
 	else {
 		char *endptr = NULL;
 		uint8_t phy = strtol(input, &endptr, 0);
@@ -2906,10 +2944,8 @@ static void custom_phy(const char *input, void *user_data)
 
 		switch (phy) {
 		case 0x01:
-			qos->phy = "1M";
-			break;
 		case 0x02:
-			qos->phy = "2M";
+			qos->phy = phy;
 			break;
 		default:
 			bt_shell_printf("Invalid argument: %s\n", input);
diff --git a/client/print.c b/client/print.c
index 66439e541307..8d721e21df4b 100644
--- a/client/print.c
+++ b/client/print.c
@@ -165,11 +165,19 @@ void print_iter(const char *label, const char *name, DBusMessageIter *iter)
 		break;
 	case DBUS_TYPE_DICT_ENTRY:
 		dbus_message_iter_recurse(iter, &subiter);
-		entry = g_strconcat(name, " Key", NULL);
-		print_iter(label, entry, &subiter);
-		g_free(entry);
 
-		entry = g_strconcat(name, " Value", NULL);
+		if (dbus_message_iter_get_arg_type(&subiter) ==
+						DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&subiter, &valstr);
+			entry = g_strconcat(name, ".", valstr, NULL);
+		} else {
+			entry = g_strconcat(name, ".Key", NULL);
+			print_iter(label, entry, &subiter);
+			g_free(entry);
+
+			entry = g_strconcat(name, ".Value", NULL);
+		}
+
 		dbus_message_iter_next(&subiter);
 		print_iter(label, entry, &subiter);
 		g_free(entry);
-- 
2.41.0

