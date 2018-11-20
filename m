Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52813C04EBC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4F206BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJee3yum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B4F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeKTVId (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:08:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34029 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbeKTVId (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 16:08:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so1494192ede.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 02:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=fUcxVbOXcMCMb1MQkWyXDeYqrFomI7zbs1g5MTJgbeU=;
        b=lJee3yumzlCWck4wAdOYXxJLLi0v/V/c4hx+mQmTbyQCIBoi2YHXbP7tHHaNJ8Ibp8
         icLHkx0ESC0arPeouR3s5ROcvjWkR5DmpL8qOHjfwxlT22cQPsUajTwi3WPQzZuxkw0h
         r0AdKxQiy9MF3guHXVk8u/uaNl3DpW8MWZ6HHQFricHvcIptJSWTeRM2nPYXQdUgU3p6
         0oAhli/emVkbE4z23TmgGzDlAmBkByo1oi89Nxzxj7t8F3vk+Wz0YU+SZZ+xR5/SGAfP
         UbOjmLKdLCtAF0Y8nobMgYc5iZARUDgOqEnjSn0LU/SoA5D4h9c6zWmtMrzoT7PdgoE8
         0Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fUcxVbOXcMCMb1MQkWyXDeYqrFomI7zbs1g5MTJgbeU=;
        b=MgRlR1/Ksm/31C6EHybMhjpymr2xgaSN852Pnn9Q0jEAdhy4l46dg4V9nQ/yA2KFRp
         Ca10aEjcOAtTeB34y/bjTuJ+viYtQ6zwbvAr6+rRrs+b9zn6TREZngvprUFAcQB6Df/A
         HHycZbey/TzsR9ilK+YD8vzzh+Lr2mQSFmGd22ERVJjLP7LqJMfCNdvJCbPF0foq4OEt
         +rY8wUAP8PGRXOLhqoWeccelSx39sbEpUYJ2J8kR90bBfbGaHymfUsItSwr6rzeFG2p/
         /Y+P+xz3pgOiFbFN4+JWs2P2fypAw/12gis37WKuGgxy17TGky0ZjOfEFPdA8qk4shJA
         Okgw==
X-Gm-Message-State: AGRZ1gISpBQOnqDjY/NUJPhhP1U3lXY1eYbdYHn5StSnfZOBYe+KLm+d
        4hCxL2O7tZ8gVLTwpRXsTDs6p8SQ
X-Google-Smtp-Source: AJdET5f/WAaJnDh9Pgv/OvvgMK2HeKJtmtSl6Zo8NQxbkBlN2gxtGWH11T5M0jxWHizQ3LDwYB8niA==
X-Received: by 2002:a17:906:a35a:: with SMTP id bz26-v6mr1572372ejb.98.1542710402726;
        Tue, 20 Nov 2018 02:40:02 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id b42-v6sm14020900edd.81.2018.11.20.02.40.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 02:40:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] gatt: Fix invalid read when disconnecting
Date:   Tue, 20 Nov 2018 12:39:55 +0200
Message-Id: <20181120103959.23502-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case there is a client of AcquireNotify and a disconnect happens the
code not only have to free the client object but also destroy the io
associated with it, for this reason the client object cannot be freed
until the io is destroyed otherwise it may lead to the following error:

Invalid read of size 4
   at 0x63920: notify_io_destroy (gatt-client.c:1461)
   by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
   by 0x6405B: characteristic_free (gatt-client.c:1663)
   by 0x81F33: remove_interface (object.c:667)
   by 0x826CB: g_dbus_unregister_interface (object.c:1391)
   by 0x85D2B: queue_remove_all (queue.c:354)
   by 0x635F7: unregister_service (gatt-client.c:1893)
   by 0x85CF7: queue_remove_all (queue.c:339)
   by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
   by 0x695CB: gatt_service_removed (device.c:3747)
   by 0x85B17: queue_foreach (queue.c:220)
   by 0x91283: notify_service_changed (gatt-db.c:280)
   by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
 Address 0x515ed48 is 0 bytes inside a block of size 20 free'd
   at 0x483EAD0: free (vg_replace_malloc.c:530)
   by 0x85D2B: queue_remove_all (queue.c:354)
   by 0x636D3: unregister_characteristic (gatt-client.c:1741)
   by 0x85D2B: queue_remove_all (queue.c:354)
   by 0x635F7: unregister_service (gatt-client.c:1893)
   by 0x85CF7: queue_remove_all (queue.c:339)
   by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
   by 0x695CB: gatt_service_removed (device.c:3747)
   by 0x85B17: queue_foreach (queue.c:220)
   by 0x91283: notify_service_changed (gatt-db.c:280)
   by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
   by 0x85D2B: queue_remove_all (queue.c:354)
   by 0x91387: gatt_db_clear_range (gatt-db.c:475)
---
 src/gatt-client.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 234f46ed7..55aa5e423 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1645,13 +1645,22 @@ static const GDBusMethodTable characteristic_methods[] = {
 	{ }
 };
 
+static void remove_client(void *data)
+{
+	struct notify_client *ntfy_client = data;
+	struct btd_gatt_client *client = ntfy_client->chrc->service->client;
+
+	queue_remove(client->all_notify_clients, ntfy_client);
+
+	notify_client_unref(ntfy_client);
+}
+
 static void characteristic_free(void *data)
 {
 	struct characteristic *chrc = data;
 
 	/* List should be empty here */
 	queue_destroy(chrc->descs, NULL);
-	queue_destroy(chrc->notify_clients, NULL);
 
 	if (chrc->write_io) {
 		queue_remove(chrc->service->client->ios, chrc->write_io->io);
@@ -1663,6 +1672,8 @@ static void characteristic_free(void *data)
 		pipe_io_destroy(chrc->notify_io);
 	}
 
+	queue_destroy(chrc->notify_clients, remove_client);
+
 	g_free(chrc->path);
 	free(chrc);
 }
@@ -1715,16 +1726,6 @@ static struct characteristic *characteristic_create(
 	return chrc;
 }
 
-static void remove_client(void *data)
-{
-	struct notify_client *ntfy_client = data;
-	struct btd_gatt_client *client = ntfy_client->chrc->service->client;
-
-	queue_remove(client->all_notify_clients, ntfy_client);
-
-	notify_client_unref(ntfy_client);
-}
-
 static void unregister_characteristic(void *data)
 {
 	struct characteristic *chrc = data;
@@ -1738,7 +1739,6 @@ static void unregister_characteristic(void *data)
 	if (chrc->write_op)
 		bt_gatt_client_cancel(gatt, chrc->write_op->id);
 
-	queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
 	queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
-- 
2.17.2

