Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A747C04A95
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Sep 2022 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIYQgv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Sep 2022 12:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiIYQgu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Sep 2022 12:36:50 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Sep 2022 09:36:49 PDT
Received: from rs225.mailgun.us (rs225.mailgun.us [209.61.151.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2817325EB4
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Sep 2022 09:36:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hexchain.org; q=dns/txt;
 s=smtp; t=1664123808; x=1664210208; h=Content-Transfer-Encoding:
 MIME-Version: Message-Id: Date: Subject: Subject: Cc: To: To: From:
 From: Sender: Sender; bh=hWfzItsWPiZ1ZzGA3E480CEVlONEPGsPslhrATTWDCQ=;
 b=Smr1fI+5e2hFwre5Ck5PcA2N+hW/fC8db5sMdk6V7jmNZck/LgVV4W44X3Mz5KRB+x9XkSAW
 7C0HBmb8nU32NhMkEQchIDJn7T6WeJ7EJcfOU0I1hIVkR118waYlaQUqLxPqMMxzbRe8jFgk
 o79zKpYlJX9kU7Bd82nKgIa1nfkZG/fpjbWiVxFqZXTnuUMTW6wBXvwJd9gMf3q9pxTc6aT4
 b4i+LzwLA+AhRDJq8Q/A62Psd0SftEmDkDz4sTvPaFUtdmesXGKubGY2ZEqLtMnrhx3yWUZn
 K3/50HLRfykcpABqLAw1xrkFryv0y6XSxoBrmGar/EVXYGZfgR7w/g==
X-Mailgun-Sending-Ip: 209.61.151.225
X-Mailgun-Sid: WyJiNzllYSIsImxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmciLCIxOTI1MTgiXQ==
Received: from localhost (254.248.75.138.unknown.m1.com.sg [138.75.248.254])
 by 8bda31290a10 with SMTP id 633082724618b2fed687bc7c (version=TLS1.3,
 cipher=TLS_AES_128_GCM_SHA256); Sun, 25 Sep 2022 16:31:46 GMT
Sender: i@hexchain.org
From:   Haochen Tong <i@hexchain.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Haochen Tong <i@hexchain.org>
Subject: [PATCH BlueZ] tools/mpris-proxy: unregister object path if player registration fails
Date:   Mon, 26 Sep 2022 00:31:39 +0800
Message-Id: <20220925163139.194382-1-i@hexchain.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The `owner' string, passed as user data, is freed if the player fails
registration, but the object path still exists. Upon program exiting,
the lingering path will be enumerated and the attached user data will be
freed again.
---
 tools/mpris-proxy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 3779b6887..e5fc91fdb 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -480,6 +480,7 @@ static void add_player(DBusConnection *conn, const char *name,
 	reply = dbus_connection_send_with_reply_and_block(sys, msg, -1, &err);
 	if (!reply) {
 		fprintf(stderr, "Can't register player\n");
+		dbus_connection_unregister_object_path(sys, path);
 		free(owner);
 		if (dbus_error_is_set(&err)) {
 			fprintf(stderr, "%s\n", err.message);
-- 
2.37.3

