Return-Path: <SRS0=7u80=N4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB272C43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8155820817
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="EZz9kI6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8155820817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeKRG1E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:27:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41818 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRG1E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 01:27:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id v18-v6so28125086wrt.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Nov 2018 12:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxiPu5n0yPHH8JJQduWQ5v04NqnmhSy/ov+rShnock8=;
        b=EZz9kI6+Goa8TqkjNKybE7eTcuEFGZxCVhKZN1I/PRigm82oXgtp3Pyfn8ABaUra8X
         bG2gVJvN+6j9yegoXstUgtp1N8+5NFZMqQKygj8FOnWsk9gErBQ/gWQiDItv5XBd9PYK
         youCIHokh2AqBh6/OCFJf1ZHuKOfzkDHG/3YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxiPu5n0yPHH8JJQduWQ5v04NqnmhSy/ov+rShnock8=;
        b=dQB8USGOieXJQMR+Ms7cJ6eCBaedObn8K69/DQnjcNfA/CS4iHFZdFaT/OsR8thOp9
         VOuNwJVXM3kM99J4Qw92pvWTbkhcb29c1KBtlheRVezz9h32kQSkJ3QHv5kIdEEclZkg
         YqY7XbBDaG+46Q4EklXVPQrIB2CM/m3EKFU+IK5QIYSTVTgSMpBIYRIg+jFm5rn44w2B
         6yC+iCNl+UxKpmhej/q5EaFFhAYyerzyTDMbQKBIsf49IEQynZzcPrqTEPeKFRPLPIeW
         T5r5MGtl9WR4t07KaNlFlGNL0fN7DKMONbnQYXQAkyfUkSHFC8lcdjl3wzrYMTe4Z7jh
         weyg==
X-Gm-Message-State: AGRZ1gJmDyK/7utgh9rYcEtx2ZtaoSxF7CGCIGg/wkjEdZYO5rFlRwNO
        zc1cXqxD2sRkpyP6NeyFLkAdYvPP5tWgjsGUw43F4vEZC48+xE0ikg3rvdaCoN9tPySLDP8t/0M
        SKaN7jNLanY6qnoZiZaNeUrV82ylA9Dleifldks7l+Auny0ZEN+EZbsAgkUIV3Jtm43eLT/7Ep0
        GDXLQ=
X-Google-Smtp-Source: AJdET5feDYK3YVz1rXbbIBO4zYd+wyi4thnCPZKOeqPig3F+VwlLWuunmqfBdqcWG1ZfNa+Y6Q1cDQ==
X-Received: by 2002:adf:812a:: with SMTP id 39-v6mr12953064wrm.84.1542485354456;
        Sat, 17 Nov 2018 12:09:14 -0800 (PST)
Received: from localhost.localdomain (bzq-79-182-246-1.red.bezeqint.net. [79.182.246.1])
        by smtp.gmail.com with ESMTPSA id l79-v6sm50729535wma.26.2018.11.17.12.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 12:09:13 -0800 (PST)
From:   Gal Ben-Haim <gbenhaim@augury.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gal Ben-Haim <gbenhaim@augury.com>
Subject: [PATCH BlueZ] gatt-client: Fix a segfault that is caused by accessing a destroyed notify_client
Date:   Sat, 17 Nov 2018 22:09:03 +0200
Message-Id: <20181117200903.17513-1-gbenhaim@augury.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Sometimes, when using a pipe that is acquired with AcquireNotify, bluetoothd
exits with segmentation fault when the device disconnects. it happens more
often if "Cache = no" is set in main.conf.

The notify_client is created in characteristic_acquire_notify() and destroyed
in unregister_characteristic(). struct pipe_io contains a pointer to a destroy
function which access the notify_client and also destroy it. this happens
after the notify_client is already destroyed and cause a segmentation fault.

stacktrace:
bluetoothd[1566]: src/gatt-client.c:unregister_characteristic() Removing GATT characteristic: /org/bluez/hci0/dev_EC_25_29_0F_09_AD/service0009/char000c
bluetoothd[1566]: src/gatt-client.c:notify_client_unref() owner :1.8332
bluetoothd[1566]: src/gatt-client.c:notify_client_free() owner :1.8332
bluetoothd[1566]: src/gatt-client.c:unregister_descriptor() Removing GATT descriptor: /org/bluez/hci0/dev_EC_25_29_0F_09_AD/service0009/char000c/desc000e
==1566== Invalid read of size 4
==1566==    at 0x63920: notify_io_destroy (gatt-client.c:1461)
==1566==    by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
==1566==    by 0x6405B: characteristic_free (gatt-client.c:1663)
==1566==    by 0x81F33: remove_interface (object.c:667)
==1566==    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
==1566==    by 0x85D2B: queue_remove_all (queue.c:354)
==1566==    by 0x635F7: unregister_service (gatt-client.c:1893)
==1566==    by 0x85CF7: queue_remove_all (queue.c:339)
==1566==    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
==1566==    by 0x695CB: gatt_service_removed (device.c:3747)
==1566==    by 0x85B17: queue_foreach (queue.c:220)
==1566==    by 0x91283: notify_service_changed (gatt-db.c:280)
==1566==    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
==1566==  Address 0x515ed48 is 0 bytes inside a block of size 20 free'd
==1566==    at 0x483EAD0: free (vg_replace_malloc.c:530)
==1566==    by 0x85D2B: queue_remove_all (queue.c:354)
==1566==    by 0x636D3: unregister_characteristic (gatt-client.c:1741)
==1566==    by 0x85D2B: queue_remove_all (queue.c:354)
==1566==    by 0x635F7: unregister_service (gatt-client.c:1893)
==1566==    by 0x85CF7: queue_remove_all (queue.c:339)
==1566==    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
==1566==    by 0x695CB: gatt_service_removed (device.c:3747)
==1566==    by 0x85B17: queue_foreach (queue.c:220)
==1566==    by 0x91283: notify_service_changed (gatt-db.c:280)
==1566==    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
==1566==    by 0x85D2B: queue_remove_all (queue.c:354)
==1566==    by 0x91387: gatt_db_clear_range (gatt-db.c:475)
==1566==  Block was alloc'd at
==1566==    at 0x483D588: malloc (vg_replace_malloc.c:299)
==1566==    by 0x85DBB: btd_malloc (util.c:46)
==1566==    by 0x645C3: notify_client_create (gatt-client.c:1330)
==1566==    by 0x6493B: characteristic_acquire_notify (gatt-client.c:1486)
==1566==    by 0x82E33: process_message (object.c:259)
==1566==    by 0x496A59F: ??? (in /usr/lib/libdbus-1.so.3.19.8)
==1566==
==1566== Invalid read of size 4
==1566==    at 0x85B94: queue_remove (queue.c:256)
==1566==    by 0x63937: notify_io_destroy (gatt-client.c:1461)
==1566==    by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
==1566==    by 0x6405B: characteristic_free (gatt-client.c:1663)
==1566==    by 0x81F33: remove_interface (object.c:667)
==1566==    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
==1566==    by 0x85D2B: queue_remove_all (queue.c:354)
==1566==    by 0x635F7: unregister_service (gatt-client.c:1893)
==1566==    by 0x85CF7: queue_remove_all (queue.c:339)
==1566==    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
==1566==    by 0x695CB: gatt_service_removed (device.c:3747)
==1566==    by 0x85B17: queue_foreach (queue.c:220)
==1566==  Address 0x512391c is 4 bytes inside a block of size 16 free'd
==1566==    at 0x483EAD0: free (vg_replace_malloc.c:530)
==1566==    by 0x6400B: characteristic_free (gatt-client.c:1654)
==1566==    by 0x81F33: remove_interface (object.c:667)
==1566==    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
==1566==    by 0x85D2B: queue_remove_all (queue.c:354)
==1566==    by 0x635F7: unregister_service (gatt-client.c:1893)
==1566==    by 0x85CF7: queue_remove_all (queue.c:339)
==1566==    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
==1566==    by 0x695CB: gatt_service_removed (device.c:3747)
==1566==    by 0x85B17: queue_foreach (queue.c:220)
==1566==    by 0x91283: notify_service_changed (gatt-db.c:280)
==1566==    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
==1566==    by 0x85D2B: queue_remove_all (queue.c:354)
==1566==  Block was alloc'd at
==1566==    at 0x483D588: malloc (vg_replace_malloc.c:299)
==1566==    by 0x85DBB: btd_malloc (util.c:46)
==1566==    by 0x858F3: queue_new (queue.c:60)
==1566==    by 0x65577: characteristic_create (gatt-client.c:1679)
==1566==    by 0x65577: export_char (gatt-client.c:1947)
==1566==    by 0x91A07: gatt_db_service_foreach (gatt-db.c:1338)
==1566==    by 0x65A6F: create_characteristics (gatt-client.c:1972)
==1566==    by 0x65A6F: export_service (gatt-client.c:1989)
==1566==    by 0x920BF: foreach_service_in_range (gatt-db.c:1292)
==1566==    by 0x85B17: queue_foreach (queue.c:220)
==1566==    by 0x9197F: gatt_db_foreach_service_in_range (gatt-db.c:1313)
==1566==    by 0x9199F: gatt_db_foreach_service (gatt-db.c:1262)
==1566==    by 0x6604F: create_services (gatt-client.c:2060)
==1566==    by 0x6604F: btd_gatt_client_ready (gatt-client.c:2150)
==1566==    by 0x6C63B: gatt_client_ready_cb (device.c:4843)
==1566==
---
 src/gatt-client.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 234f46ed7..04fa5cf26 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -93,7 +93,6 @@ struct async_dbus_op {
 struct pipe_io {
 	DBusMessage *msg;
 	struct io *io;
-	void (*destroy)(void *data);
 	void *data;
 };
 
@@ -1078,9 +1077,6 @@ static bool chrc_pipe_read(struct io *io, void *user_data)
 
 static void pipe_io_destroy(struct pipe_io *io)
 {
-	if (io->destroy)
-		io->destroy(io->data);
-
 	if (io->msg)
 		dbus_message_unref(io->msg);
 
@@ -1454,14 +1450,6 @@ static void register_notify_io_cb(uint16_t att_ecode, void *user_data)
 	characteristic_ready(true, 0, chrc);
 }
 
-static void notify_io_destroy(void *data)
-{
-	struct notify_client *client = data;
-
-	if (queue_remove(client->chrc->notify_clients, client))
-		notify_client_unref(client);
-}
-
 static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -1502,7 +1490,6 @@ static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
 	chrc->notify_io = new0(struct pipe_io, 1);
 	chrc->notify_io->data = client;
 	chrc->notify_io->msg = dbus_message_ref(msg);
-	chrc->notify_io->destroy = notify_io_destroy;
 
 	return NULL;
 }
-- 
2.19.1

