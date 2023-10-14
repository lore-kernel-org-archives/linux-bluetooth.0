Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6C5CDB465
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Oct 2023 19:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjJNTlf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Oct 2023 15:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjJNTle (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Oct 2023 15:41:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817EB7
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 12:41:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c515527310so6462051fa.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Oct 2023 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697312491; x=1697917291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=quRXq43BRUvNxzNxX1eh163n0hacy/wdLQuWvUi9i/s=;
        b=ekRz0dEdsIVFk+7NOQ2Nj6O1o7CvsHx44SpMjtTlTaJIZqQXkuDn6F/+et24ze9/6/
         JnXk+9sgsPHf6LLo5S/euB52TPAqghKc2dsKGCbQX64hmH/21zHBkyxHWwDia83KmRb+
         tKvd6BsvwctjfoHY12GwYBCNJPFX1EtcnDfvgYsgTQyXAuX91lpdVvavOpzRqKT2bITk
         GUT65TlFuu5mE2bF1aInEQURKMxo5zWZzcwCAefN/S4oYUKqJzm7g06a2xHdoPOEk5Hr
         Uw5TFFz+tMgoa19S88lJ/XCCNQ6M1fgkMzKmWbKIvffAPBDlt1YRN3CuPnExgAS6+xDI
         MaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697312491; x=1697917291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quRXq43BRUvNxzNxX1eh163n0hacy/wdLQuWvUi9i/s=;
        b=uOcLozdGXqt7xJX3UHg1pgjBrkDbyU8HZRg6gHD6/zy1SVrUHqLTwPsZb2UBXMu6Zc
         S8e1UyMRSXICypm0fKvhQXP2gt+JpPXLNBCF4IV73pe6CXUb7u7SEIaCwCfgmvMxcPcK
         fRXWYfI+EjgAd15oPya9mGInB9yAgoF5JWmqV1I9mu2I5ycr/+qksPTbP3THms6InEut
         GxwmRgO39kKUUTJge7aWzXgFo2bpisdfrb8+ntMAIzFOcs2YYQpTJzcg+rhqoZY4X4Hs
         gR0MeEFdWLn5BYAr8t5gGBKvssuyQs656alaZVswuriK3jUKj66UGyEMN7gJqnuyWcgq
         0/Vw==
X-Gm-Message-State: AOJu0Ywt3XtkknJLxVe7hlSD0/yoDwr6ivED0i8kw3E6++P9LOEjgibJ
        /RUcGVgFEUcSeFB7Xe5sLNdwBRQpOpk=
X-Google-Smtp-Source: AGHT+IE7rcHYlJ49BxKXhJ/SBylmM2vbirYZ0Jez9jLGm4WqfafRk21jLplQiMtod8N3ndza4pvdgQ==
X-Received: by 2002:a2e:9589:0:b0:2bf:af49:daf7 with SMTP id w9-20020a2e9589000000b002bfaf49daf7mr26640903ljh.42.1697312490904;
        Sat, 14 Oct 2023 12:41:30 -0700 (PDT)
Received: from localhost.localdomain (46.205.208.24.nat.ftth.dynamic.t-mobile.pl. [46.205.208.24])
        by smtp.gmail.com with ESMTPSA id v8-20020a2e5048000000b002c4fdb0ef12sm509029ljd.19.2023.10.14.12.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 12:41:30 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] btdev: Do not call auth_complete with NULL conn
Date:   Sat, 14 Oct 2023 21:41:20 +0200
Message-Id: <20231014194120.1884126-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make sure that the auto_complete() function will not be called with the
NULL connection, because it is required by that function.

** NOTE FOR REVIEWERS **
The change in the cmd_link_key_reply_complete() function was done based
on the code from other *_complete() functions. In most of them, in case
of NULL connection the conn_complete() was used instead. But I'm not
100% sure that it's the right approach (not even 90% sure...).
---
 emulator/btdev.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c76b89db9..2564d96f2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1453,7 +1453,7 @@ static void auth_complete(struct btdev_conn *conn, uint8_t status)
 
 	memset(&ev, 0, sizeof(ev));
 
-	ev.handle = conn ? cpu_to_le16(conn->handle) : 0x0000;
+	ev.handle = cpu_to_le16(conn->handle);
 	ev.status = status;
 
 	send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
@@ -1491,10 +1491,10 @@ static int cmd_link_key_reply_complete(struct btdev *dev, const void *data,
 		status = BT_HCI_ERR_AUTH_FAILURE;
 
 done:
-	auth_complete(conn, status);
-
 	if (conn)
 		auth_complete(conn->link, status);
+	else
+		conn_complete(dev, cmd->bdaddr, status);
 
 	return 0;
 }
@@ -1681,28 +1681,25 @@ static int cmd_pin_code_neg_reply_complete(struct btdev *dev, const void *data,
 							uint8_t len)
 {
 	const struct bt_hci_cmd_pin_code_request_neg_reply *cmd = data;
+	const uint8_t status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
 	struct btdev *remote;
 	struct btdev_conn *conn;
-	uint8_t status;
 
 	remote = find_btdev_by_bdaddr(cmd->bdaddr);
 	if (!remote)
 		return 0;
 
-	status = BT_HCI_ERR_PIN_OR_KEY_MISSING;
-
 	conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
 	if (conn)
 		auth_complete(conn, status);
 	else
-		conn_complete(dev, cmd->bdaddr, BT_HCI_ERR_PIN_OR_KEY_MISSING);
+		conn_complete(dev, cmd->bdaddr, status);
 
 	if (conn) {
 		if (remote->pin_len)
 			auth_complete(conn->link, status);
 	} else {
-		conn_complete(remote, dev->bdaddr,
-					BT_HCI_ERR_PIN_OR_KEY_MISSING);
+		conn_complete(remote, dev->bdaddr, status);
 	}
 
 	return 0;
-- 
2.39.2

