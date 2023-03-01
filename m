Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCAC7EE30
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 01:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCABit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 20:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCABir (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 20:38:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22EA6EA5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u20so6984375pfm.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 17:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GAZV8ATK33ceYZSpnWzTqubtZsqMxwwDBkcdr8J4Ew=;
        b=JNOdNbjsDITAvaaCazMn03Z/Drv7FZuM30dvu7QeS6EnuTaH/KNUunIjrujmrkPWIJ
         m/G1NxxfBZtW9fWBcuVnn6isGXNYtbjYYcGlAnOXJZijWcZ2PsSRMdeTU+LF/qVDekeO
         MkRYNsoLCWesnMq4qTiB3t9UCqmM1jRyHy/YwlDOC2rkMwHq2S//v3qdwwNyWxZoiyb/
         m5HaZLgg7W3LUmDAc7fxlN5QHDwVqxMo7v2BaID/izgK8eR0UUrLhStb5igkX9247IWC
         oJWh/IbqgZSTsnM9m+eBi44VDe0yWcgr1oGeyaym0so4zYCrW6zJNVlLSLSD20XDGwEd
         GNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GAZV8ATK33ceYZSpnWzTqubtZsqMxwwDBkcdr8J4Ew=;
        b=Ullac8o3kjfECIbnpYsm3UXIiwgoIqlHXqUVe4ssVVznrqwouN/OZdJcbswBKZoHbL
         3dlubWKP2KyMWRyb6X9VFFyQvccd9g77YIJKs61ghb2MlRJCIE2dUW3MzPKFUnhFFlWE
         dX1TlV5OTqU32+TRMnnI8zormMtsWOMd8vn30xNPOxZUd6Mf9bUVedqrJMzMZ8aP7h6i
         o9kXpEribBt6RXLA2lXAN+jKtYBM5WL1cR8Nz6ee0vV1NrdXIJC/sg2mY61bW7wyh4up
         gaBZy/u+6Ke9K8aU49BeTtPdvakfuo8bmezVBjWHC+75JYAr2lhg/juDLIM15RQOzjx2
         s2Sg==
X-Gm-Message-State: AO0yUKX0QCBvY5F06xoa3BsZPXqGWkwapQ5aIfyZDcjqBpTtw6k3SkLo
        EubyMC5szwtbNWy7YCHDuF+MzYxwkm8=
X-Google-Smtp-Source: AK7set8di9jOGG756nvla8AApMS0vHMHC9xOdetUemok9fpydn0xAS8JuznymggU5VHhF2YQI09Ytw==
X-Received: by 2002:aa7:8bc7:0:b0:5a8:4861:af7d with SMTP id s7-20020aa78bc7000000b005a84861af7dmr4614275pfd.20.1677634725967;
        Tue, 28 Feb 2023 17:38:45 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78801000000b005d866d184b5sm6627797pfo.46.2023.02.28.17.38.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:38:45 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] client: Allow transport.send command to work with multiple transports
Date:   Tue, 28 Feb 2023 17:38:39 -0800
Message-Id: <20230301013842.718438-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301013842.718438-1-luiz.dentz@gmail.com>
References: <20230301013842.718438-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables transport.send to work with multiple transports instead of
sending one by one which can create synchronization problems.
---
 client/player.c | 71 +++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/client/player.c b/client/player.c
index 65cac3b50376..767304b567b6 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3566,48 +3566,54 @@ static void cmd_send_transport(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 	struct transport *transport;
-	int fd, err;
+	int fd = -1, err;
 	struct bt_iso_qos qos;
 	socklen_t len;
+	int i;
 
-	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+	for (i = 1; i < argc; i++) {
+		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
-	if (!proxy) {
-		bt_shell_printf("Transport %s not found\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+		if (!proxy) {
+			bt_shell_printf("Transport %s not found\n", argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 
-	transport = find_transport(proxy);
-	if (!transport) {
-		bt_shell_printf("Transport %s not acquired\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+		transport = find_transport(proxy);
+		if (!transport) {
+			bt_shell_printf("Transport %s not acquired\n", argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 
-	if (transport->sk < 0) {
-		bt_shell_printf("No Transport Socked found\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
+		if (transport->sk < 0) {
+			bt_shell_printf("No Transport Socked found\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 
-	fd = open_file(argv[2], O_RDONLY);
-	if (fd < 0)
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		if (i + 1 < argc) {
+			fd = open_file(argv[++i], O_RDONLY);
+			if (fd < 0)
+				return bt_shell_noninteractive_quit(
+								EXIT_FAILURE);
+		}
 
-	bt_shell_printf("Sending ...\n");
+		bt_shell_printf("Sending ...\n");
 
-	/* Read QoS if available */
-	memset(&qos, 0, sizeof(qos));
-	len = sizeof(qos);
-	if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
+		/* Read QoS if available */
+		memset(&qos, 0, sizeof(qos));
+		len = sizeof(qos);
+		if (getsockopt(transport->sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
 							&len) < 0)
-		err = transport_send(transport, fd, NULL);
-	else
-		err = transport_send(transport, fd, &qos);
+			err = transport_send(transport, fd, NULL);
+		else
+			err = transport_send(transport, fd, &qos);
 
-	if (err < 0) {
-		bt_shell_printf("Unable to send: %s (%d)", strerror(-err),
-								-err);
-		close(fd);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		if (err < 0) {
+			bt_shell_printf("Unable to send: %s (%d)",
+						strerror(-err), -err);
+			close(fd);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -3710,7 +3716,8 @@ static const struct bt_shell_menu transport_menu = {
 	{ "release",     "<transport> [transport1...]", cmd_release_transport,
 						"Release Transport",
 						transport_generator },
-	{ "send",        "<transport> <filename>", cmd_send_transport,
+	{ "send",        "<transport> <filename> [transport1...]",
+						cmd_send_transport,
 						"Send contents of a file",
 						transport_generator },
 	{ "receive",     "<transport> [filename]", cmd_receive_transport,
-- 
2.39.2

