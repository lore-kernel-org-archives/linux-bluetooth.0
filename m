Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDE0C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 20:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjEAUDh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 16:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjEAUDg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 16:03:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11641FFD
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 13:03:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a9253d4551so21562165ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682971408; x=1685563408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbBtSA3uJsZp0zrHUcdg57fcZO6mCxmi7bK41/B7hrc=;
        b=KaMJC62/q6HPkotdP6Xd0sdWyrMQvdZPkIs0e9tHvXMpy/mGwm2qv4eAZd0KntwRbC
         t25KYy27kexOYMmc2FWQUdTjVbPNbok42zHWeQ8qO07t8aEVPh5bt+mhkm5e9sw9LRF3
         orryvhDZJHjUs5w3+rneqsU5C3y+G5C8OINEEHBcWALSbQw546LCUKRaHps4W8Dpfvqp
         AH5CNiLvJaAnPE8fxMlCVXzCuUbqtIvlfeoh38nm9Pqflz8Jve7HcuW3QTeXsOuxaOOP
         D10zSNamdw9GbmssZ66bD506jueRDTsg/up9HH+vdN/xgWy9tWNJfhUoWIo/yHn7uRNA
         pJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682971408; x=1685563408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbBtSA3uJsZp0zrHUcdg57fcZO6mCxmi7bK41/B7hrc=;
        b=Dr56o6R3pntJIwnPi28TWyHPgF36iJdz4uaI2O0/eXFxqBQgmP6CmVRCtb7HXULX4t
         BITjrsG3f0WM3JFfj56g5PA9lf+wbiT3puzAsMc389OcUjXjmG14Jr0x/vs1SxB2gDTc
         wF1wXnFjSK9ths4A5gfFYh2ezEcMHGC4oQuffEHZIfmnX+fevp3BEmMfUdmwqm8e5o89
         huSXhVfzYDlIwmFJyvZo+Tju/ty7wyQ4pB05j2dcRv2PnjDRThSCejtzwH1xqBJtKe6E
         yjtJwRpsav9nR/pHBgWfoMb2Wan8vfKVcBv34gMhQdSEEDM08efPMLsNQOlOlUo/fIcj
         xaIg==
X-Gm-Message-State: AC+VfDwb9rIaAoG7UBw09cI/loa9RV61SKt//xNDVDCL9msKrYQEbcMd
        e/X/ZULiY7bg3calF9uaQLhNhlw5pDo=
X-Google-Smtp-Source: ACHHUZ5fO6/JpIe6BFV8jF2cLfNzyVEKazyoKaZ97RC6P0PtobsPHRjxyg9ObdxjUevF7ljx48ijTw==
X-Received: by 2002:a17:902:d50c:b0:1a9:8769:36bd with SMTP id b12-20020a170902d50c00b001a9876936bdmr18834090plg.36.1682971408382;
        Mon, 01 May 2023 13:03:28 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001aaecc15d66sm3037514plb.289.2023.05.01.13.03.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:03:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/3] client/player: Add support for Metadata in BAP Profile
Date:   Mon,  1 May 2023 13:03:24 -0700
Message-Id: <20230501200326.1056736-1-luiz.dentz@gmail.com>
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

