Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buXqQ5Yw"
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB518C
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:15:41 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7c57aa2cce8so743804241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701728139; x=1702332939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ksYSdxZhMuwVUzXhKZUFZKDWNfR+dei+bwpsAXb7yI=;
        b=buXqQ5Yw1LiITCujUGOtYJWfY6c5jPqcd5vyRNrWb13Gyg7Z+2DqZCSG9kF3bZkLcZ
         SKwETgtDMhJ7ObymE2mhM0bcbCRhUNNFKc4KTn5ai2iRwTvtD2ws+G++q82M2hC0LHsD
         XaDVgvo6lwe2Tqjc/8QlbTGh9/rtTl+2ce8PhEAQa2AkC9UIVnOh2EhcKAW3/K0oRWcy
         QfQFWprKSgF2eapEmhuDGMl7Pzw3hUdK8l700UtVReRyduKZ7BFxkHgpIBwFm5U3PBK5
         jrweK/nw4GGUJGEVv1In9eDCTcIFrcCfTF9uFNm4SpeTGLToG3/ewfzEKNenMDyC/SMw
         tBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728139; x=1702332939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ksYSdxZhMuwVUzXhKZUFZKDWNfR+dei+bwpsAXb7yI=;
        b=d3wX4DHrNLKWokscfJTVeZkjPVXgoMg4+kQoas9dSB7TO9/uAFy+AgjpXK0CY8xU3S
         58aKnfiGo5hOLSzZpxSAjTBKoZyR/zX4J1YD/s1Obvjpi7h8SLBPYdXeJy6XGzQxxF0L
         EsCQ1BMG/+bXpna+vCVpnXlI/wEBixu5Ruj9XIOtC/neKjwUlv0+ueinpN1w5NA57XRS
         GYZ+KUbEFV/Zdupf7NXZoPBU2GN0BVZVLBQ+fseJ3PYRasrTImR7XMTBzJI+DeU7+PqP
         7Ltwp7pbPqlQ5A9ZxlJKx4o1OLgptTCqP6hHn1D6LVrn9PGtkf6Et8XpIvvTw4+ZEF16
         r20A==
X-Gm-Message-State: AOJu0Ywy4KWSAk3oBRc9LMgbUHsRS+55ETBB3QVLu8WSWAZPrFsbHRQH
	HgxzQ/9mGGRYlMGekO+w8ZA3+BmPBRM=
X-Google-Smtp-Source: AGHT+IEXBODAY9Gah9g+01wXQlVhE7TM6cQps4YupraO479w3sP4aDbNC7ftFpq1j/u/ozo39SG4Ug==
X-Received: by 2002:a05:6102:292b:b0:464:4c9d:6f1d with SMTP id cz43-20020a056102292b00b004644c9d6f1dmr2017833vsb.23.1701728139616;
        Mon, 04 Dec 2023 14:15:39 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bl13-20020a056102508d00b0044d4e63aa03sm1136612vsb.25.2023.12.04.14.15.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:15:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/8] shared/bap: Fix possible crash when freeing requests
Date: Mon,  4 Dec 2023 17:15:25 -0500
Message-ID: <20231204221527.2990674-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204221527.2990674-1-luiz.dentz@gmail.com>
References: <20231204221527.2990674-1-luiz.dentz@gmail.com>
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

