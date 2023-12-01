Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3PFpnqn"
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799D7AD
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 14:39:16 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db53f8cf4afso1044799276.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Dec 2023 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701470354; x=1702075154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ksYSdxZhMuwVUzXhKZUFZKDWNfR+dei+bwpsAXb7yI=;
        b=h3PFpnqnAcQAFwtt4WeApkeM+MBUFQWPmZoqIOiRhlS8taCSVFCzx41FKRCUHH8RKA
         vD2TWyCwyHVtCbeIeaC6XTEl6Zl7lrOvro8/X6uct5PaZrUsoFF9JDcRc0Jr6IByb8FL
         tCK1gSwSc+s3oplEHAQfP6+sPMv5tn+4F0z1Bu7ZmRCGBXs9dWtUDIQbmc5T4bBnL3Sx
         /yoACxWLm3CsWHoMaYLrYYlgucDtOCU20fYkFCk87nlTCJLiLtsz9hbhz+aGexXyhOmQ
         dqJTdp9s5MJNDaOa987fegJD3LcjNmvpiJ/uZ4AMAPPFW2wsnabb1b/pcPgAIeakA8BC
         c7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470354; x=1702075154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ksYSdxZhMuwVUzXhKZUFZKDWNfR+dei+bwpsAXb7yI=;
        b=NU/J2PXM616hxWduEGv4o6c/GQs3tLHxz4+okgCnQvBrUKlzoYB6UZEYtPirpOMkEc
         CgNY4Dfx4OYu+kzBhewXhF1aGtEjzxJVeFj68Uj/ib/jetTkh/NdLoWlT+ukylcYMTjM
         HM1fSlIDG1hovDhhWOMZ8+T3qFlmSz7eBZ4ZH6cle8d7hsBzWETlWsWEHE9ESYujHS6Y
         AmLfTGi8qSX8MNSh33y64iMbYr9LvoV+546gOBtPmc32n2aH+uNMmqAmcONcvx3c1zOZ
         33ZiX3JqW7t99OLCvrlVwHn7lOjzekOM/v44kylXdl9H8R9/Cc7ayh+yuku1lw2nfJva
         Ojfw==
X-Gm-Message-State: AOJu0YzQAZaQy+DBUBABKmKZTyKQPfkwv/VyD/lKggx5m1v/obdw8Pi0
	yxlwBGBVKcCpNCZ3iIYVgAR5LzDWCmem8g==
X-Google-Smtp-Source: AGHT+IER3h1bGlFiAiFqIsvk5Qy1U/LufICKS6xv0tb4bF+fs7g2EL9fjEH5sxUpgiDqJz0+/QWptQ==
X-Received: by 2002:a25:f904:0:b0:da0:48df:cafa with SMTP id q4-20020a25f904000000b00da048dfcafamr23314918ybe.16.1701470354481;
        Fri, 01 Dec 2023 14:39:14 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id b18-20020a0c9b12000000b0065b13180892sm1915411qve.16.2023.12.01.14.39.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:39:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/7] shared/bap: Fix possible crash when freeing requests
Date: Fri,  1 Dec 2023 17:38:59 -0500
Message-ID: <20231201223900.2498565-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201223900.2498565-1-luiz.dentz@gmail.com>
References: <20231201223900.2498565-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Requests maybe queued using a stream so when detaching it needs to be
canceled otherwise they can lead crashes like bellow:

 Invalid read of size 8
    at 0x1C3247: stream_stop_complete (bap.c:1230)
    by 0x1BB2A3: bap_req_complete (bap.c:3863)
    by 0x1C7BB3: bap_req_detach (bap.c:4219)
    by 0x1C7BB3: bt_bap_detach (bap.c:4231)
    by 0x1C7BB3: bt_bap_detach (bap.c:4222)
    by 0x1C7E67: bap_free (bap.c:2937)
    by 0x1C7E67: bt_bap_unref (bap.c:3090)
    by 0x1C7E67: bt_bap_unref (bap.c:3082)
    by 0x18CCC2: test_teardown (test-bap.c:513)
    by 0x1D826A: teardown_callback (tester.c:434)
    by 0x491E4FC: g_idle_dispatch (gmain.c:6163)
    by 0x49224FB: UnknownInlinedFun (gmain.c:3460)
    by 0x49224FB: g_main_context_dispatch (gmain.c:4200)
    by 0x49806B7: g_main_context_iterate.isra.0 (gmain.c:4276)
    by 0x4921AFE: g_main_loop_run (gmain.c:4479)
    by 0x1E8EF4: mainloop_run (mainloop-glib.c:66)
    by 0x1E93F7: mainloop_run_with_signal (mainloop-notify.c:188)
  Address 0x57b9ad0 is 0 bytes inside a block of size 120 free'd
    at 0x4845B2C: free (vg_replace_malloc.c:985)
    by 0x1CBAB7: bap_stream_state_changed (bap.c:1290)
    by 0x1D3104: bap_ep_set_status (bap.c:3673)
    by 0x1DC746: queue_foreach (queue.c:207)
    by 0x1A5320: notify_cb (gatt-client.c:2271)
    by 0x19A1EF: handle_notify (att.c:1012)
    by 0x19A1EF: can_read_data (att.c:1096)
    by 0x1D68CF: watch_callback (io-glib.c:157)
    by 0x49224FB: UnknownInlinedFun (gmain.c:3460)
    by 0x49224FB: g_main_context_dispatch (gmain.c:4200)
    by 0x49806B7: g_main_context_iterate.isra.0 (gmain.c:4276)
    by 0x4921AFE: g_main_loop_run (gmain.c:4479)
    by 0x1E8EF4: mainloop_run (mainloop-glib.c:66)
    by 0x1E93F7: mainloop_run_with_signal (mainloop-notify.c:188)
---
 src/shared/bap.c | 91 ++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d8a3adde60ca..a1495ca84bcc 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1232,6 +1232,47 @@ static void stream_stop_complete(struct bt_bap_stream *stream, uint8_t code,
 		bap_stream_io_detach(stream);
 }
 
+static void bap_req_free(void *data)
+{
+	struct bt_bap_req *req = data;
+	size_t i;
+
+	queue_destroy(req->group, bap_req_free);
+
+	for (i = 0; i < req->len; i++)
+		free(req->iov[i].iov_base);
+
+	free(req->iov);
+	free(req);
+}
+
+static void bap_req_complete(struct bt_bap_req *req,
+				const struct bt_ascs_ase_rsp *rsp)
+{
+	struct queue *group;
+
+	if (!req->func)
+		goto done;
+
+	if (rsp)
+		req->func(req->stream, rsp->code, rsp->reason, req->user_data);
+	else
+		req->func(req->stream, BT_ASCS_RSP_UNSPECIFIED, 0x00,
+						req->user_data);
+
+done:
+	/* Detach from request so it can be freed separately */
+	group = req->group;
+	req->group = NULL;
+
+	queue_foreach(group, (queue_foreach_func_t)bap_req_complete,
+							(void *)rsp);
+
+	queue_destroy(group, NULL);
+
+	bap_req_free(req);
+}
+
 static void bap_stream_state_changed(struct bt_bap_stream *stream)
 {
 	struct bt_bap *bap = stream->bap;
@@ -1286,6 +1327,10 @@ static void bap_stream_state_changed(struct bt_bap_stream *stream)
 	/* Post notification updates */
 	switch (stream->ep->state) {
 	case BT_ASCS_ASE_STATE_IDLE:
+		if (bap->req && bap->req->stream == stream) {
+			bap_req_complete(bap->req, NULL);
+			bap->req = NULL;
+		}
 		bap_stream_detach(stream);
 		break;
 	case BT_ASCS_ASE_STATE_QOS:
@@ -2905,20 +2950,6 @@ static void bap_state_free(void *data)
 	free(state);
 }
 
-static void bap_req_free(void *data)
-{
-	struct bt_bap_req *req = data;
-	size_t i;
-
-	queue_destroy(req->group, bap_req_free);
-
-	for (i = 0; i < req->len; i++)
-		free(req->iov[i].iov_base);
-
-	free(req->iov);
-	free(req);
-}
-
 static void bap_detached(void *data, void *user_data)
 {
 	struct bt_bap_cb *cb = data;
@@ -3809,6 +3840,11 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 
 	DBG(bap, "req %p len %u", req, iov.iov_len);
 
+	if (req->stream && !queue_find(bap->streams, NULL, req->stream)) {
+		DBG(bap, "stream %p detached, aborting op 0x%02x", req->op);
+		return false;
+	}
+
 	if (!gatt_db_attribute_get_char_data(ascs->ase_cp, NULL, &handle,
 						NULL, NULL, NULL)) {
 		DBG(bap, "Unable to find Control Point");
@@ -3843,33 +3879,6 @@ static bool bap_send(struct bt_bap *bap, struct bt_bap_req *req)
 	return true;
 }
 
-static void bap_req_complete(struct bt_bap_req *req,
-				const struct bt_ascs_ase_rsp *rsp)
-{
-	struct queue *group;
-
-	if (!req->func)
-		goto done;
-
-	if (rsp)
-		req->func(req->stream, rsp->code, rsp->reason, req->user_data);
-	else
-		req->func(req->stream, BT_ASCS_RSP_UNSPECIFIED, 0x00,
-						req->user_data);
-
-done:
-	/* Detach from request so it can be freed separately */
-	group = req->group;
-	req->group = NULL;
-
-	queue_foreach(group, (queue_foreach_func_t)bap_req_complete,
-							(void *)rsp);
-
-	queue_destroy(group, NULL);
-
-	bap_req_free(req);
-}
-
 static bool bap_process_queue(void *data)
 {
 	struct bt_bap *bap = data;
-- 
2.43.0

