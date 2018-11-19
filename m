Return-Path: <SRS0=AiOn=N6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB80C43441
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3720851
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Nov 2018 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6KSmnBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA3720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbeKTCHP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:07:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46675 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbeKTCHO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Nov 2018 21:07:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so3148767edt.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Nov 2018 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=fUcxVbOXcMCMb1MQkWyXDeYqrFomI7zbs1g5MTJgbeU=;
        b=A6KSmnBOXcOVarVw9kMKX/dOX3+jvAMassBnZoDmcsfnLBeTirkWBV1UVx+DBwOcNK
         Cx4BGHWCtsXN3IsIbkxEO/zsPEdYlULmfhjkkxa/UwEwO0fBrsP/ezSe1/aUwPqwd6XQ
         OK9whlLqnzi2cqUbCSRVSKXFEq0xfeRksMtAmOyu5CkiEto+vVAMg7O3zylMJKxtvfH1
         gwagefoO8JfRw7li870tCsSqnw/l9f4kTMIsH2Su4ShAu9zoq9tyEEB4NYw+5bRaSaNJ
         XCwJyueXOWrdGRrEqqr24pGbTLQZ9UFThHRwjkENlC0KCeP5u/CGJf8sjUiooDVQx/yF
         TU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fUcxVbOXcMCMb1MQkWyXDeYqrFomI7zbs1g5MTJgbeU=;
        b=p80LPYwy7TCjtSV0mO8y0fE583aMDOyIr/Um/hpGfjySTX5+3SiVvSFBzzUiXJiADo
         BCOHYUvetUVFZWORKRepjzJMVcig0kH6F+e8R9SazjPeJblPJHKUicahLEP3/O1G+L1R
         T0C+YqOuXLiZ4rnkmaq21j5xl4WvCKSUNEmuFmOKoydFpG+JCFM40EsXEDfXxH7Ul7Nn
         coDseBPdFojooXU6pJ5pnAMRWNmMslRufXDNqLaHSSUV1wTGRD5L1vtL/aBw33vfSNlw
         BZrRAigiiJ2SwTOlWs+UCYC58klJP6uPvdc9laZrtp/m7WTCw43+ELwKhzhDYFxrGWyU
         3jzw==
X-Gm-Message-State: AGRZ1gLzDh7FIiM2hgVfu28Idxlo7oZa/ffPvssw1L49aeN83tOyRLmZ
        tl51nlTvCPytam04APA1bYXowKrG
X-Google-Smtp-Source: AJdET5fT2PaFzdRcAdYGovHtxCvr7P2GddryUZzFcWQGMFs6/6FCRcoTof5uzZGEJZ97u8mBymYaVQ==
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr20080275eds.91.1542642195224;
        Mon, 19 Nov 2018 07:43:15 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s3sm684448eda.69.2018.11.19.07.43.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:43:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] gatt: Fix invalid read when disconnecting
Date:   Mon, 19 Nov 2018 17:43:07 +0200
Message-Id: <20181119154311.27826-1-luiz.dentz@gmail.com>
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

