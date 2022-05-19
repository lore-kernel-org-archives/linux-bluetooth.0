Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1890FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 May 2022 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiESVkJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 May 2022 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbiESVkI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 May 2022 17:40:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B809346F
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:40:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso9842979pjj.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yz/u2pg1usXBo/qx/LxqTE9Sh74iCFGMexsnQ4PMEn4=;
        b=dAcBh29d1TSuUmnHS4uaxI4KIa1xKln6G9i9o146rMBEuxr45KH5Dqah5DvtCKusIq
         wlY83/nae5dwrXGVbDJWkkaNLXhDidbv0qXBDMitUnHO5LNjA2lYeJzShCwt/EtXRrza
         KpTeg5QT8YXuOBVUuXFz7Z0PDEuU3SPHuOIieYLkxU4iwsl8RMNio70Y46rx8FH3gBA/
         hMhtuVhK6XeR/pzBmC6s/bj6ARZ551QYDtUfWdR3gXUuJjNOkvB11hhu6mD3Pa+EprL1
         /uGK3KpKPKJTn8PtB9Z5AtiXxpzQVdCWoHBy3C/RHxmLD0hrq5C7qKl8ChSTANduxNRg
         mX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yz/u2pg1usXBo/qx/LxqTE9Sh74iCFGMexsnQ4PMEn4=;
        b=2Jx8XLMqdUNzP/+xrJ4dlKgRhvxGtxUgeCwhYN6W4wnNetM2cV4DUT/mbx6nZHIkW6
         3wU3GymQIM5y9EquvWVnQqYVPwH0QnXjFSCSalPLlaSbeC0S067jiwft1wqfPfj1kjlx
         3K51Iupk65nGK7K+wq9TyL9Dy5WPnq8zOs5cwa0rMg31wPo7Pgb+qqLnXIwr8FzQvE6L
         PrZK/Sd0wKDAiCOGslvDX7h3OQlK+oQIW4PlWXIBNsKIqOiFGiCv4n6V1zLlioYXfuTc
         5lC5MgqdfeARI8ztSUFJjYOEC6+dTPp2vkdm0co8iJyD9EpCxBCD+I4nUjbqw3X8FdV7
         rJbg==
X-Gm-Message-State: AOAM530U5BKIxB7HjRc0Kw+1VWViUAUfUKotXwAQfhGGj34gUOlq1nWg
        m4Mfvn7j8IiVd8p1IooAowwD4PWg/6k=
X-Google-Smtp-Source: ABdhPJwHkO2KF1pe129JS4+ABjYKIgXnZ6WrdrukN+qogQyzcymJV3HHDT/cLpcIMJaGgBHi+Zi7AQ==
X-Received: by 2002:a17:902:ebca:b0:15f:4cc5:f40f with SMTP id p10-20020a170902ebca00b0015f4cc5f40fmr6484527plg.96.1652996405718;
        Thu, 19 May 2022 14:40:05 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fh6-20020a17090b034600b001cd4989ff53sm283327pjb.26.2022.05.19.14.40.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:40:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt-server: Fix crash while disconnecting
Date:   Thu, 19 May 2022 14:40:02 -0700
Message-Id: <20220519214002.2525857-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there is a pending notify multiple the code was not removing before
freeing the object causing the following crash:

Invalid read of size 8
   at 0x4A3D10: notify_multiple (gatt-server.c:1703)
   by 0x4D05F0: timeout_callback (timeout-glib.c:25)
   by 0x4956900: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49560AE: g_main_context_dispatch
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49AB307: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49557C2: g_main_loop_run
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x4D0A34: mainloop_run (mainloop-glib.c:66)
   by 0x4D0F2B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x2B0CD1: main (main.c:1276)
 Address 0x6ca35c8 is 136 bytes inside a block of size 144 free'd
   at 0x48470E4: free (vg_replace_malloc.c:872)
   by 0x415E73: gatt_server_cleanup (device.c:698)
   by 0x415E73: attio_cleanup (device.c:715)
   by 0x47745B: queue_foreach (queue.c:207)
   by 0x490C54: disconnect_cb (att.c:701)
   by 0x4CF4AF: watch_callback (io-glib.c:157)
   by 0x49560AE: g_main_context_dispatch
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49AB307: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x49557C2: g_main_loop_run
   (in /usr/lib64/libglib-2.0.so.0.7000.5)
   by 0x4D0A34: mainloop_run (mainloop-glib.c:66)
   by 0x4D0F2B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x2B0CD1: main (main.c:1276)
---
 src/shared/gatt-server.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2adb4afbf..85cff30ec 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -121,11 +121,26 @@ struct bt_gatt_server {
 	struct nfy_mult_data *nfy_mult;
 };
 
+static void notify_multiple_free(struct bt_gatt_server *server)
+{
+	if (!server->nfy_mult)
+		return;
+
+	if (server->nfy_mult->id)
+		timeout_remove(server->nfy_mult->id);
+
+	free(server->nfy_mult->pdu);
+	free(server->nfy_mult);
+	server->nfy_mult = NULL;
+}
+
 static void bt_gatt_server_free(struct bt_gatt_server *server)
 {
 	if (server->debug_destroy)
 		server->debug_destroy(server->debug_data);
 
+	notify_multiple_free(server);
+
 	bt_att_unregister(server->att, server->mtu_id);
 	bt_att_unregister(server->att, server->read_by_grp_type_id);
 	bt_att_unregister(server->att, server->read_by_type_id);
@@ -1695,17 +1710,26 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 	return true;
 }
 
+static void notify_multiple_timeout_remove(struct bt_gatt_server *server)
+{
+	if (!server->nfy_mult->id)
+		return;
+
+	timeout_remove(server->nfy_mult->id);
+	server->nfy_mult->id = 0;
+}
+
 static bool notify_multiple(void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 
+	server->nfy_mult->id = 0;
+
 	bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY_MULT,
 			server->nfy_mult->pdu, server->nfy_mult->offset, NULL,
 			NULL, NULL);
 
-	free(server->nfy_mult->pdu);
-	free(server->nfy_mult);
-	server->nfy_mult = NULL;
+	notify_multiple_free(server);
 
 	return false;
 }
@@ -1737,8 +1761,7 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 		/* flush buffered data if this request hits buffer size limit */
 		if (data && data->offset > 0 &&
 				data->len - data->offset < 4 + length) {
-			if (server->nfy_mult->id)
-				timeout_remove(server->nfy_mult->id);
+			notify_multiple_timeout_remove(server);
 			notify_multiple(server);
 			/* data has been freed by notify_multiple */
 			data = NULL;
-- 
2.35.1

