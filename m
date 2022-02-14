Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454DAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 23:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiBNXQb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 18:16:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBNXQa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 18:16:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46968D57
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:16:21 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso810691pjd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXPxT0fm29iAUvQhD195S8ivHKoRSUoMvS+zm+n6X4Q=;
        b=LEhQLNfMZATSBf8W/UDKtRhos55QRPzp1Ixj53BoSEf62sslAuhbzmHV2QraLxJteO
         oVF9IbaJA9u5jWVdlORV56JkfUIN/YAP5qu3fnwgOo3ycFmkoEyxscslDQ5T/kCEX4hF
         IwxOKsZQnChQNNkAwGdYbacxxJO054EqqxXXDPpIGlzpYkmjs6L5dN0hBnxn6rOO9Sit
         YWfZ/sW2HhoGh8990+LkCPpyGxW0DHuFwPSQTJKTV7lOX3S29Dk2Su2LtwYwEiSVP+B6
         jBrJWCY4VznoAvCQt74pHOZdnzqIWlU/WEIbX+G1FF5TZiMHBmMqb1XzD/7Ckv697zf0
         PiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXPxT0fm29iAUvQhD195S8ivHKoRSUoMvS+zm+n6X4Q=;
        b=ePwFITDqAEuwMlROfMrSc6K2inDH+//sEIDc68kZoUtyvn5+QfBUFGvIl8s+lxAAhB
         R6s+jgG811StFEcyIXBd03A4ioNcowwEl1FJwZIFvQj2Itm+KwtIVrjK8Y2Q6POHGyGE
         QknQFuxlINKfRcUaSZPWOC03xm/S3qX1JqbTbij+PnJsDMkpLlYwXtoOUgGhrxcOQvB5
         +OjIEs8GrFJCp/ads4NZQd6GBzPq1hEnz1vcVTwh/Yhs1yRDAE0C0DsiUHmH2aBCC2xs
         vac0Je46Q/rhGp+nzn47NZ6rD4sreDU9CJkUx0f9UxgvG/++jTCr42QGl9O8GLaAkPm5
         5k7Q==
X-Gm-Message-State: AOAM533aTVblUCHfFnWW/dlFwaF95Y8W98eqVAapd1AbZO4LCcX4wxuU
        beb1/y994tIxYcFEj42+KhcU9NaorLUIWw==
X-Google-Smtp-Source: ABdhPJzhRQCvYRu0r1C26qZjnvaOeoCRdWuXnCGjyOuuj8YWxVkR3W/EEpW1Ga2yofNXv6kB83EFpw==
X-Received: by 2002:a17:902:74c4:: with SMTP id f4mr1243358plt.48.1644880580487;
        Mon, 14 Feb 2022 15:16:20 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t2sm37163569pfj.211.2022.02.14.15.16.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:16:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] obexctl: Add optional argument channel to connect command
Date:   Mon, 14 Feb 2022 15:16:19 -0800
Message-Id: <20220214231619.1873499-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a third argument to connect command so a channel can be passed
to CreateSession which is useful since it possible to force a specific
RFCOMM channel.
---
v2: Fix passing Channel argument as DBUS_TYPE_UINT16 rather than
DBUS_TYPE_BYTE.

 tools/obexctl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index e671d253b..56a76915c 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -114,6 +114,7 @@ static void connect_reply(DBusMessage *message, void *user_data)
 struct connect_args {
 	char *dev;
 	char *target;
+	uint8_t channel;
 };
 
 static void connect_args_free(void *data)
@@ -139,13 +140,14 @@ static void connect_setup(DBusMessageIter *iter, void *user_data)
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
 
-	if (args->target == NULL)
-		goto done;
-
-	g_dbus_dict_append_entry(&dict, "Target",
+	if (args->target)
+		g_dbus_dict_append_entry(&dict, "Target",
 					DBUS_TYPE_STRING, &args->target);
 
-done:
+	if (args->channel)
+		g_dbus_dict_append_entry(&dict, "Channel",
+					DBUS_TYPE_BYTE, &args->channel);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -153,6 +155,7 @@ static void cmd_connect(int argc, char *argv[])
 {
 	struct connect_args *args;
 	const char *target = "opp";
+	int channel = 0;
 
 	if (!client) {
 		bt_shell_printf("Client proxy not available\n");
@@ -162,9 +165,20 @@ static void cmd_connect(int argc, char *argv[])
 	if (argc > 2)
 		target = argv[2];
 
+	if (argc > 3) {
+		char *endptr = NULL;
+
+		channel = strtol(argv[3], &endptr, 0);
+		if (!endptr || *endptr != '\0' || channel > UINT8_MAX) {
+			bt_shell_printf("Invalid channel\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
 	args = g_new0(struct connect_args, 1);
 	args->dev = g_strdup(argv[1]);
 	args->target = g_strdup(target);
+	args->channel = channel;
 
 	if (g_dbus_proxy_method_call(client, "CreateSession", connect_setup,
 			connect_reply, args, connect_args_free) == FALSE) {
@@ -1832,7 +1846,8 @@ static void cmd_mkdir(int argc, char *argv[])
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
-	{ "connect",      "<dev> [uuid]", cmd_connect, "Connect session" },
+	{ "connect",      "<dev> [uuid] [channel]", cmd_connect,
+						"Connect session" },
 	{ "disconnect",   "[session]", cmd_disconnect, "Disconnect session",
 						session_generator },
 	{ "list",         NULL,       cmd_list, "List available sessions" },
-- 
2.34.1

