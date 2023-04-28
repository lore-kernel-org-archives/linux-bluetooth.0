Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C0C77B61
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 23:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjD1XId (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjD1XIc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 19:08:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4349D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 16:08:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a92513abebso5161705ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682723309; x=1685315309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbBtSA3uJsZp0zrHUcdg57fcZO6mCxmi7bK41/B7hrc=;
        b=erDp1d80MFQI0D6zvP7oPxbL18pPiV/b3pxsLiBRjhmb2Xc/ebFaEq4QpGi6+Ckz67
         Im8IkgOJ/Q8Z0GJq52HvZukofib6+TkJoArBoRqhCDjpk7vXVuvcpQHF4jYgJzNwjXUY
         JAbT7+1Q4JD5XHf4uP1gvOW5lMQE+euCNOpJkGz2eKkvjviepn0So0i4RN40EPxLVYDC
         F/kzeYRT045FlvfX0Xpbln/qEhQwMjYKl8OA9Jm0glEY5a9quNcGKZslncGu54vSm+t5
         2T/XeYD6vsurEZSVbtS6iXCL+jqwhrzBPiyZ4F/bQLkuTXfNqmO2zCHDqN8CFoMlL6D6
         7YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682723309; x=1685315309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbBtSA3uJsZp0zrHUcdg57fcZO6mCxmi7bK41/B7hrc=;
        b=VtNhyyodFYkbTdpRkPupV6W32PWV6Xht7280gHGnp0yAUsEQVluYjALvgeeRtLfrmo
         znlSF2HBziTkGEmcrsclt6WwIWB7N07v9I9AHfu+2h1B7VJ+Q6brLxToet1AqoBPRLv+
         E+vVlPlTkIl0EzA8nythpklvjRRf40rNapqplNgPYn3B90DXyzFLfvfWBTqFgFMQYXB2
         khC0BxWNDZutoCOHU/hAVNvXQc4+ww+lO0obMVALp12GrH3SJIXLLef1xb/itR8xpOGa
         cEsORJUOZK/RPJvngsvgCWiJ4P67WTXLcxf5NBUO/0qwpj4RuZCpMCO1O5GxURfc3Uju
         zcVA==
X-Gm-Message-State: AC+VfDxJp+krzT33lSVZ3DB2AlQFzlodfPhDW4I3dSfcuIJqQZKYwR0K
        UaRb5Gy6itZBpxl1IgQrw7Tf+qzJ7N0=
X-Google-Smtp-Source: ACHHUZ7IsrLO3lV0AtGs7XN2DJeIsvjo0BNqHMZxIlbwgaVo4riyNueaPTzo7jDYphTGRR4hcJ/b6w==
X-Received: by 2002:a17:902:e804:b0:1a4:f7b1:12f1 with SMTP id u4-20020a170902e80400b001a4f7b112f1mr8074067plg.4.1682723309439;
        Fri, 28 Apr 2023 16:08:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id io6-20020a17090312c600b001a64ed4621csm1809920plb.182.2023.04.28.16.08.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 16:08:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Add support for Metadata in BAP Profile
Date:   Fri, 28 Apr 2023 16:08:27 -0700
Message-Id: <20230428230827.908680-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>

This adds support for Metadata in BAP profile.
In order to register zero Metadata, 0 shall be
entered when prompted.

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Enter Metadata (value/no): n
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] CIG (auto/value): a
[/local/endpoint/ep0] CIS (auto/value): a
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
Endpoint /local/endpoint/ep0 registered
---
 client/player.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 5572cc566e79..cc35721d85b7 100644
--- a/client/player.c
+++ b/client/player.c
@@ -70,6 +70,7 @@ struct endpoint {
 	uint16_t cid;
 	uint16_t vid;
 	struct iovec *caps;
+	struct iovec *meta;
 	bool auto_accept;
 	bool acquiring;
 	uint8_t cig;
@@ -1582,6 +1583,7 @@ struct endpoint_config {
 	GDBusProxy *proxy;
 	struct endpoint *ep;
 	struct iovec *caps;
+	struct iovec *meta;
 	uint8_t target_latency;
 	const struct codec_qos *qos;
 };
@@ -1592,6 +1594,7 @@ static void append_properties(DBusMessageIter *iter,
 	DBusMessageIter dict;
 	struct codec_qos *qos = (void *)cfg->qos;
 	const char *key = "Capabilities";
+	const char *meta = "Metadata";
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
@@ -1602,6 +1605,15 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
 					cfg->caps->iov_len);
 
+	if (cfg->meta->iov_len) {
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
+				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
+				cfg->meta->iov_len);
+
+		bt_shell_printf("Metadata:\n");
+		bt_shell_hexdump(cfg->meta->iov_base, cfg->meta->iov_len);
+	}
+
 	if (!qos)
 		goto done;
 
@@ -1699,6 +1711,9 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
 	cfg->target_latency = preset->target_latency;
 
+	/* Copy metadata */
+	iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
+
 	if (preset->qos.phy)
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
@@ -1847,6 +1862,12 @@ static void endpoint_free(void *data)
 		g_free(ep->caps);
 	}
 
+	if (ep->meta) {
+		if (ep->meta->iov_base)
+			g_free(ep->meta->iov_base);
+		g_free(ep->meta);
+	}
+
 	if (ep->msg)
 		dbus_message_unref(ep->msg);
 
@@ -1917,10 +1938,38 @@ static gboolean endpoint_vendor_exists(const GDBusPropertyTable *property,
 	return ep->cid && ep->vid;
 }
 
+static gboolean endpoint_get_metadata(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+				&ep->meta->iov_base,
+				ep->meta->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean endpoint_metadata_exists(const GDBusPropertyTable *property,
+							void *data)
+{
+	struct endpoint *ep = data;
+
+	return ep->meta ? TRUE : FALSE;
+}
+
 static const GDBusPropertyTable endpoint_properties[] = {
 	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
 	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
 	{ "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
+	{ "Metadata", "ay", endpoint_get_metadata, NULL,
+				endpoint_metadata_exists },
 	{ "Vendor", "u", endpoint_get_vendor, NULL, endpoint_vendor_exists },
 	{ }
 };
@@ -1930,6 +1979,7 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 	struct endpoint *ep = user_data;
 	DBusMessageIter dict;
 	const char *key = "Capabilities";
+	const char *meta = "Metadata";
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &ep->path);
 
@@ -1955,6 +2005,15 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 		bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
 	}
 
+	if (ep->meta) {
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
+				DBUS_TYPE_BYTE, &ep->meta->iov_base,
+				ep->meta->iov_len);
+
+		bt_shell_printf("Metadata:\n");
+		bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
+	}
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -2072,6 +2131,30 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
 }
 
+static void endpoint_set_metadata(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
+		free(ep->meta->iov_base);
+		ep->meta = NULL;
+		goto done;
+	}
+
+	if (!ep->meta)
+		ep->meta = g_new0(struct iovec, 1);
+
+	ep->meta->iov_base = str2bytearray((char *) input, &ep->meta->iov_len);
+	if (!ep->meta->iov_base) {
+		free(ep->meta);
+		ep->meta = NULL;
+	}
+
+done:
+	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
+					endpoint_auto_accept, ep);
+}
+
 static void endpoint_set_capabilities(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -2091,8 +2174,8 @@ static void endpoint_set_capabilities(const char *input, void *user_data)
 		ep->caps->iov_len = 0x00;
 	}
 
-	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
-						endpoint_auto_accept, ep);
+	bt_shell_prompt_input(ep->path, "Enter Metadata (value/no):",
+					endpoint_set_metadata, ep);
 }
 
 static char *uuid_generator(const char *text, int state)
-- 
2.40.0

