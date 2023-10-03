Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B051E8FDB7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 21:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbjJCVOv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbjJCVOv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 17:14:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD958AF
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 14:14:46 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c62cb79b02so903602a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696367685; x=1696972485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybON3hguA2NBAyfA9nsZYVM31BU7eZSbOEejEhk/g4c=;
        b=k4HHPpX4olv/L7naJD9tsi7kv9fP9Xfrcy/o4wN1vCpmo2G5+Rzp1AApNUolZbTxsE
         eGY1gsJzGUYFDnSsBTvcP4GfdR1ZUDyKyiMjdmhkXSRtsov6FVJn0ArA+naZTLWI3+57
         okjTrJaY9hNwyk+FIOkoIY7o5uWquY1xeA3o/atOEYLKXRMEdDj7HW9BXaUjI3+85fnE
         muRPKMuRoayHV0lrlnIu+4K90hOuGKcEb44EeYgAp+5TXoN7GfljEhopo1gOJbOf605Y
         /z7zUJDJYwcgzgB7JRAPh0rAfq3uTYijKwdDnD0ChOq/+4a12SXpFkIsAMUxfC2rW7OE
         lndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367685; x=1696972485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybON3hguA2NBAyfA9nsZYVM31BU7eZSbOEejEhk/g4c=;
        b=a8IzPQSGA/iZtg9RzJZLFIwfRc97Fw7/PRyh9ABb4kPJBxz5qvPRrNi6uXu497FSHj
         WCAjowBh6xw58wIFNxbcImJ4r3FDw+wpGNZdJe/ieglVx7hSZm3Xf/xi07P/fgji87a3
         b63No8lPuO/SEEz4o2/uxJxtPrArqTyV985uAVvbYr+eMHqZ9Ra+7sOjUUAbxEebJeHi
         4z7PciDMV/ZEkzp2wiogL++HO64iGDvb7Hb6trkrTjihKVPukiC7fe8sRTw7n924Rzvf
         TUamS3ybJnFScwJPhDJn4d2Of+Z1fUwQ9OfMEygpaTWLmUxx6G0eOSGSxDfuGfkMguIo
         mpPQ==
X-Gm-Message-State: AOJu0YxYMfEr2yJ6dZ9ZPuarQ6t7b06zaVDnqvLgu/5cJ9vZHe2QiOoR
        GOSnq11e17MKc2DyYSNmXdqIzZK/5cILZtbs
X-Google-Smtp-Source: AGHT+IGnF+yGkZVNKX8eHmxuspwX9e8N/tsNPasTcWRK2tWcgKAIgZyYMj4P/MCiIM9IrHGbZTrd+Q==
X-Received: by 2002:a05:6830:d6:b0:6be:fc8b:40fc with SMTP id x22-20020a05683000d600b006befc8b40fcmr423058oto.36.1696367685218;
        Tue, 03 Oct 2023 14:14:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id o1-20020a63a801000000b0057412d84d25sm1848293pgf.4.2023.10.03.14.14.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 14:14:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/mgmt: Fix registering pairing callbacks
Date:   Tue,  3 Oct 2023 14:14:42 -0700
Message-ID: <20231003211442.3348427-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't register pairing callbacks until mgmt.pair is called otherwise it
may take over the role of pairing agent when bluetoothctl agent is in
use.
---
 client/mgmt.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index c056d018a9da..947d8fcd5556 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -3056,6 +3056,18 @@ static void pair_rsp(uint8_t status, uint16_t len, const void *param,
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void register_pair_callbacks(struct mgmt *mgmt, uint16_t index)
+{
+	mgmt_register(mgmt, MGMT_EV_PIN_CODE_REQUEST, index, request_pin,
+								mgmt, NULL);
+	mgmt_register(mgmt, MGMT_EV_USER_CONFIRM_REQUEST, index, user_confirm,
+								mgmt, NULL);
+	mgmt_register(mgmt, MGMT_EV_USER_PASSKEY_REQUEST, index,
+						request_passkey, mgmt, NULL);
+	mgmt_register(mgmt, MGMT_EV_PASSKEY_NOTIFY, index,
+						passkey_notify, mgmt, NULL);
+}
+
 static struct option pair_options[] = {
 	{ "help",	0, 0, 'h' },
 	{ "capability",	1, 0, 'c' },
@@ -3105,6 +3117,8 @@ static void cmd_pair(int argc, char **argv)
 	if (index == MGMT_INDEX_NONE)
 		index = 0;
 
+	register_pair_callbacks(mgmt, index);
+
 	memset(&cp, 0, sizeof(cp));
 	str2ba(argv[0], &cp.addr.bdaddr);
 	cp.addr.type = type;
@@ -5780,14 +5794,6 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 					local_name_changed, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_DEVICE_FOUND, index, device_found,
 								mgmt, NULL);
-	mgmt_register(mgmt, MGMT_EV_PIN_CODE_REQUEST, index, request_pin,
-								mgmt, NULL);
-	mgmt_register(mgmt, MGMT_EV_USER_CONFIRM_REQUEST, index, user_confirm,
-								mgmt, NULL);
-	mgmt_register(mgmt, MGMT_EV_USER_PASSKEY_REQUEST, index,
-						request_passkey, mgmt, NULL);
-	mgmt_register(mgmt, MGMT_EV_PASSKEY_NOTIFY, index,
-						passkey_notify, mgmt, NULL);
 	mgmt_register(mgmt, MGMT_EV_UNCONF_INDEX_ADDED, index,
 					unconf_index_added, NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_UNCONF_INDEX_REMOVED, index,
-- 
2.41.0

