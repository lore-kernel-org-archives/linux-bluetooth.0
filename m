Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF5BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0942070E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCvz0vrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGQTPS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgGQTPS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 15:15:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5091AC0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so6979603pjb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofcSy59ESp8nBAyKdvQXxbumDxZMg6HeTOxTvE1Riuw=;
        b=GCvz0vrAe6peAes71/uhyAz4RxWuVIZ6EJVpFx1bpx0QH2ajnjswhEyEPoXFUROncO
         UWERIRfXVaF6ccdX/rGWLNkrQcgB+JpvTofCeVzF0gyIQ4BQoX+7oDV0sCeGUHYpDfeE
         6g2Bus9RC30tromji8Fb39/GiCBm2DFY17leGo6DqH70X/nHfGXb1L8SNfxeO1SkWcEs
         zdidIoZEXKmWBOEI/dxiA/lX22eMeGiytVTUhCbx3TeSZwDMB6hHVA8NMLhVZ3f3zjJn
         UyYR7KhvPSkgVM6wDGVNRRA4xdpmP7MEjUJ3d8z9IdzOlKPryvkkMXbaVmm8yfEfa6eX
         VScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofcSy59ESp8nBAyKdvQXxbumDxZMg6HeTOxTvE1Riuw=;
        b=NC8QU44RbwaMKqQ6QeVHi0z27Hc3douw+YOLFSSruinVvsfy4SHgBxtJbvDfB1/E27
         KNr7ghIv0bHYI+4NP05XLC486QoALZtZ5SsFfBYDtJXgSCf0/ZRTUOa020N/6lTDh9xr
         /qMwbpA8XebZoNLmdrQzz/s9B1WyqLvJpQRIlQWTPx9ghIJYKSUB0CwqaA0dQXt3VHRo
         5i4PKYn62jXz1bvQgq7W2xiJjyVTXFWx5BeODO8jiPjQbq//xawRLRKZ+WXV0Lsz12sj
         kXW8U+Bgn3uPv13QY07QOQWyACXkhAI7B5KiDx08c3wwMxylWwKW7ElepVfikAM7Ft4s
         zBrQ==
X-Gm-Message-State: AOAM530ooA14wO0dk35Z4H9rYtUemUTCAxLlfVKBjDGAFXaMbg2Hutk5
        KtViNnx7AP/pAM2Ue58zTnvW893A/qI=
X-Google-Smtp-Source: ABdhPJx/sGMBavpUlFB5fLaeOBrNdy3bilHEaO8dnIRw/UVQ6yaIX0A2p++GJWZjpEIRchuDrszixw==
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr10444585pju.80.1595013317189;
        Fri, 17 Jul 2020 12:15:17 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p9sm6488334pgc.77.2020.07.17.12.15.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:15:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/att: Fix possible crash on disconnect
Date:   Fri, 17 Jul 2020 12:15:11 -0700
Message-Id: <20200717191515.220621-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are pending request while disconnecting they would be notified
but clients may endup being freed in the proccess which will then be
calling bt_att_cancel to cancal its requests causing the following
trace:

Invalid read of size 4
   at 0x1D894C: enable_ccc_callback (gatt-client.c:1627)
   by 0x1D247B: disc_att_send_op (att.c:417)
   by 0x1CCC17: queue_remove_all (queue.c:354)
   by 0x1D47B7: disconnect_cb (att.c:635)
   by 0x1E0707: watch_callback (io-glib.c:170)
   by 0x48E963B: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.6400.4)
   by 0x48E9AC7: ??? (in /usr/lib/libglib-2.0.so.0.6400.4)
   by 0x48E9ECF: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.6400.4)
   by 0x1E0E97: mainloop_run (mainloop-glib.c:79)
   by 0x1E13B3: mainloop_run_with_signal (mainloop-notify.c:201)
   by 0x12BC3B: main (main.c:770)
 Address 0x7d40a28 is 24 bytes inside a block of size 32 free'd
   at 0x484A2E0: free (vg_replace_malloc.c:540)
   by 0x1CCC17: queue_remove_all (queue.c:354)
   by 0x1CCC83: queue_destroy (queue.c:73)
   by 0x1D7DD7: bt_gatt_client_free (gatt-client.c:2209)
   by 0x16497B: batt_free (battery.c:77)
   by 0x16497B: batt_remove (battery.c:286)
   by 0x1A0013: service_remove (service.c:176)
   by 0x1A9B7B: device_remove_gatt_service (device.c:3691)
   by 0x1A9B7B: gatt_service_removed (device.c:3805)
   by 0x1CC90B: queue_foreach (queue.c:220)
   by 0x1DE27B: notify_service_changed.isra.0.part.0 (gatt-db.c:369)
   by 0x1DE387: notify_service_changed (gatt-db.c:361)
   by 0x1DE387: gatt_db_service_destroy (gatt-db.c:385)
   by 0x1DE3EF: gatt_db_remove_service (gatt-db.c:519)
   by 0x1D674F: discovery_op_complete (gatt-client.c:388)
   by 0x1D6877: discover_primary_cb (gatt-client.c:1260)
   by 0x1E220B: discovery_op_complete (gatt-helpers.c:628)
   by 0x1E249B: read_by_grp_type_cb (gatt-helpers.c:730)
   by 0x1D247B: disc_att_send_op (att.c:417)
   by 0x1CCC17: queue_remove_all (queue.c:354)
   by 0x1D47B7: disconnect_cb (att.c:635)
---
 src/shared/att.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index ed3af2920..58f23dfcb 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -84,6 +84,7 @@ struct bt_att {
 	struct queue *req_queue;	/* Queued ATT protocol requests */
 	struct queue *ind_queue;	/* Queued ATT protocol indications */
 	struct queue *write_queue;	/* Queue of PDUs ready to send */
+	bool in_disc;			/* Cleanup queues on disconnect_cb */
 
 	bt_att_timeout_func_t timeout_callback;
 	bt_att_destroy_func_t timeout_destroy;
@@ -222,8 +223,10 @@ static void destroy_att_send_op(void *data)
 	free(op);
 }
 
-static void cancel_att_send_op(struct att_send_op *op)
+static void cancel_att_send_op(void *data)
 {
+	struct att_send_op *op = data;
+
 	if (op->destroy)
 		op->destroy(op->user_data);
 
@@ -631,11 +634,6 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	/* Dettach channel */
 	queue_remove(att->chans, chan);
 
-	/* Notify request callbacks */
-	queue_remove_all(att->req_queue, NULL, NULL, disc_att_send_op);
-	queue_remove_all(att->ind_queue, NULL, NULL, disc_att_send_op);
-	queue_remove_all(att->write_queue, NULL, NULL, disc_att_send_op);
-
 	if (chan->pending_req) {
 		disc_att_send_op(chan->pending_req);
 		chan->pending_req = NULL;
@@ -654,6 +652,15 @@ static bool disconnect_cb(struct io *io, void *user_data)
 
 	bt_att_ref(att);
 
+	att->in_disc = true;
+
+	/* Notify request callbacks */
+	queue_remove_all(att->req_queue, NULL, NULL, disc_att_send_op);
+	queue_remove_all(att->ind_queue, NULL, NULL, disc_att_send_op);
+	queue_remove_all(att->write_queue, NULL, NULL, disc_att_send_op);
+
+	att->in_disc = false;
+
 	queue_foreach(att->disconn_list, disconn_handler, INT_TO_PTR(err));
 
 	bt_att_unregister_all(att);
@@ -1574,6 +1581,30 @@ bool bt_att_chan_cancel(struct bt_att_chan *chan, unsigned int id)
 	return true;
 }
 
+static bool bt_att_disc_cancel(struct bt_att *att, unsigned int id)
+{
+	struct att_send_op *op;
+
+	op = queue_find(att->req_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_find(att->ind_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_find(att->write_queue, match_op_id, UINT_TO_PTR(id));
+
+done:
+	if (!op)
+		return false;
+
+	/* Just cancel since disconnect_cb will be cleaning up */
+	cancel_att_send_op(op);
+
+	return true;
+}
+
 bool bt_att_cancel(struct bt_att *att, unsigned int id)
 {
 	const struct queue_entry *entry;
@@ -1591,6 +1622,9 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 			return true;
 	}
 
+	if (att->in_disc)
+		return bt_att_disc_cancel(att, id);
+
 	op = queue_remove_if(att->req_queue, match_op_id, UINT_TO_PTR(id));
 	if (op)
 		goto done;
-- 
2.26.2

