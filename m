Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5728DA0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbXUi9/D"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e7c1012a42so7799177b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 09:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704390932; x=1704995732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kVcIBmBp9fKGH9/SteJ33s3BaeBj1aenXaldVnphgQ=;
        b=MbXUi9/D9Ayzo7vmb6cDXQSrXYy5USaJAKdjMT4RhbyeYnPEEDB0ssWZUMFJqRCZT8
         +nVcD9gFNENgeKk40yPEiQfO85kuQh2vQG8cqqWtiuz8jPLr1eLwmGsobZxYrWF63leh
         mjAisK+HOuK2NrTqPb0islx6FmBL8C+N/1lZgToqr2vWObwWeCQJJzyrXOa6+bO4EH1J
         7Hgh1tnK1eShhUOjjeNlJVMRhLKjkQQhtQyDZkV/uKn23XikB0cZGEFUzDeRKRmbNrUM
         b0YQ0RYBv0kNf5vAMrKy9sfckSjc9FMhQDjEDIwbXtDS8SobAgaXv0/q8CCVZGeCEFJn
         po+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704390932; x=1704995732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kVcIBmBp9fKGH9/SteJ33s3BaeBj1aenXaldVnphgQ=;
        b=T1jDkLgdBFVEluk0YNfX62N6srtSAgzbpmgWAv6IYjuUpLq9hM/m4laFE8BNTr3K98
         ax62XAF/b2deArwLJ+P3tLhN6f2W97L7oiBcuko069MlpcS52qamAYfb3WsAqoYt9jzy
         42fanWWyVk8SYPGNs1ZhCcwQlysFiflM5fr3KrDz9/1mExntJWjnS5ca05LWyzFoyOFq
         uOrhblMP1yUitc1Wgx5ZSdDnBxFE5qfPYbqoGQ1H914GcbGfkuYlFj510c6UbCm79Ict
         v9kfr6r7SMHe0yE8Evtmzx6HDMPw3DN/QcOTBmT3QrHZUmvZKO/0R8yq0xoEj+GiYhJR
         EJfg==
X-Gm-Message-State: AOJu0Yza59px/nKUhsVOq1WQblgjV1mp2M4lkgRNer/5GxeKmjTYIk1C
	ixXrWnqC2JCPDefu1NUrW3MqTT50/WY=
X-Google-Smtp-Source: AGHT+IEjOgCg15C0qfIVrm5aVkBN6QmR2oW3y7EErOI2Cg0Lj4n4QF6aVxjkhE4mUpT4uMNZKVbZvg==
X-Received: by 2002:a81:6d54:0:b0:5f3:dd8d:4646 with SMTP id i81-20020a816d54000000b005f3dd8d4646mr948765ywc.81.1704390932277;
        Thu, 04 Jan 2024 09:55:32 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bz9-20020a05690c084900b005ecd8995666sm9631765ywb.59.2024.01.04.09.55.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:55:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Adjust the SDU size based on the number of locations
Date: Thu,  4 Jan 2024 12:55:30 -0500
Message-ID: <20240104175530.4011031-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are multiple locations, aka. multiplexing, being selected then
that should be accounted properly on the SDU size since the presets only
account for just 1 channel.

Fixes: https://github.com/bluez/bluez/issues/662
---
 client/player.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/client/player.c b/client/player.c
index 92fc91f920f3..dad243786a39 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1860,7 +1860,7 @@ struct endpoint_config {
 	struct iovec *caps;
 	struct iovec *meta;
 	uint8_t target_latency;
-	const struct codec_qos *qos;
+	struct codec_qos qos;
 };
 
 #define BCODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
@@ -1886,7 +1886,7 @@ static struct bt_iso_qos bcast_qos = {
 
 static void append_io_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
-	struct codec_qos *qos = (void *)cfg->qos;
+	struct codec_qos *qos = &cfg->qos;
 
 	bt_shell_printf("Interval %u\n", qos->interval);
 
@@ -1897,7 +1897,7 @@ static void append_io_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
 	g_dbus_dict_append_entry(iter, "PHY", DBUS_TYPE_BYTE, &qos->phy);
 
-	bt_shell_printf("SDU %u\n", cfg->qos->sdu);
+	bt_shell_printf("SDU %u\n", qos->sdu);
 
 	g_dbus_dict_append_entry(iter, "SDU", DBUS_TYPE_UINT16, &qos->sdu);
 
@@ -1914,7 +1914,7 @@ static void append_io_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
 static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
-	struct codec_qos *qos = (void *)cfg->qos;
+	struct codec_qos *qos = &cfg->qos;
 
 	if (cfg->ep->iso_group != BT_ISO_QOS_GROUP_UNSET) {
 		bt_shell_printf("CIG 0x%2.2x\n", cfg->ep->iso_group);
@@ -2020,7 +2020,7 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 static void append_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 {
 	DBusMessageIter entry, var, dict;
-	struct codec_qos *qos = (void *)cfg->qos;
+	struct codec_qos *qos = &cfg->qos;
 	const char *key = "QoS";
 
 	if (!qos)
@@ -2104,7 +2104,8 @@ static struct iovec *iov_append(struct iovec **iov, const void *data,
 	return *iov;
 }
 
-static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location)
+static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location,
+						uint8_t *channels)
 {
 	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
 		const char *key;
@@ -2123,6 +2124,8 @@ static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location)
 			if (var != DBUS_TYPE_UINT32)
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value, location);
+			if (*channels)
+				*channels = __builtin_popcount(*location);
 			return 0;
 		}
 
@@ -2140,6 +2143,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	DBusMessageIter iter, props;
 	struct endpoint_config *cfg;
 	uint32_t location = 0;
+	uint8_t channels = 1;
 
 	if (!preset)
 		return NULL;
@@ -2158,7 +2162,7 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	dbus_message_iter_init(msg, &iter);
 	dbus_message_iter_recurse(&iter, &props);
 
-	if (!parse_chan_alloc(&props, &location)) {
+	if (!parse_chan_alloc(&props, &location, &channels)) {
 		uint8_t chan_alloc_ltv[] = {
 			0x05, LC3_CONFIG_CHAN_ALLOC, location & 0xff,
 			location >> 8, location >> 16, location >> 24
@@ -2171,9 +2175,15 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	if (ep->meta)
 		iov_append(&cfg->meta, ep->meta->iov_base, ep->meta->iov_len);
 
-	if (preset->qos.phy)
+	if (preset->qos.phy) {
 		/* Set QoS parameters */
-		cfg->qos = &preset->qos;
+		cfg->qos = preset->qos;
+		/* Adjust the SDU size based on the number of
+		 * locations/channels that is being requested.
+		 */
+		if (channels > 1)
+			cfg->qos.sdu *= channels;
+	}
 
 	dbus_message_iter_init_append(reply, &iter);
 
@@ -3177,7 +3187,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		}
 
 		/* Set QoS parameters */
-		cfg->qos = &preset->qos;
+		cfg->qos = preset->qos;
 
 		endpoint_set_config(cfg);
 		return;
-- 
2.43.0

