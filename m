Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A67AFA3739
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 11:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5703920861
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 11:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkNaUBfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfAUL5v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:57:51 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:36130 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfAUL5u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 06:57:50 -0500
Received: by mail-ed1-f43.google.com with SMTP id f23so16382005edb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 03:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=qs9BElVskgPvqLhS9fNHeAPSVG3RaDZcf5L8DM9D6SE=;
        b=RkNaUBfBi1ltmriMJLCaWVPiyDMkzcMGLjXdpDR+8woowSqp9zni2dp6PmLGWT9tvV
         BmoJ9AJyWPOkjowehOYjgogiPvtnNM1oWrrxwpRwMBJB8zhxbAsfOuZJD7oVg3DLxYwm
         Ujgdz3DB4qZfnfQe4sPIIWX0vxjT4ckfx8KoTU8ijk/RykAsXhcTseePjlZtk9EzIalO
         7+DjhJ/5+b2pEj6da1BpHBcJiRy5zNlVhPi1SFb3fRk4Pay+Ub2w+3OVz+DGETEiS1xd
         YBzXFKVFfI/TzfaTyOJSzaa44t4aQviQps0IiqbB40Uh+nlwjhBIzqW4fXxCgvk2O4v7
         PhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=qs9BElVskgPvqLhS9fNHeAPSVG3RaDZcf5L8DM9D6SE=;
        b=rXqx3EZeOMU+TNKhIKngyfAS9mOnIPNWqVLe273K8p3qhPSFF/h+iQlaOgripcxewK
         mHJ3zQ5VbGO2PoaOaq7D3+vkxpqCi52D1/URdXSngwkq+6XS4vdVKsjHy+sJmTYTViqd
         zHhuwZ3lx+alALhxuvVxH5TeDOfrJMB2/R0xAKNZPxiYtbtsH51R6lksfe0Vl7/mMJeM
         yH+4A2SOJCTyetfq/c900dR3z9GBgATUSmLPNyRPpFjRFyTpWAeIHwEMmGeSAZnrPDOj
         DFvpafR40bw8mdT69ZDfVGlSiBWW2WVjmYU5swFA0JI3ZwntbWzE6f6NnSguvVAdXUAb
         HcwQ==
X-Gm-Message-State: AJcUukcn4RkNct1mXbSVl1gJArtjPfNwLhfRqtMqedvmBU6Dq1E2c/T5
        XyeJNQBzGUI40KBDcsOss7RrTG6g
X-Google-Smtp-Source: ALg8bN7yi2UD9+6yfp4h+2AyJHtsaPJaFlI/tTK6mosW5zX/fcj0WZvEUnjidc8ypLyoUIrQo77xsA==
X-Received: by 2002:a50:9472:: with SMTP id q47mr26894666eda.251.1548071867998;
        Mon, 21 Jan 2019 03:57:47 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id n11-v6sm4880568ejh.74.2019.01.21.03.57.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 03:57:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avdtp: Fix always destroying session immediatelly
Date:   Mon, 21 Jan 2019 13:57:45 +0200
Message-Id: <20190121115745.5353-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the remote device sent a close/abort the session shall not be
free immediatelly as the remote may want to reconfigure the stream.
---
 profiles/audio/avdtp.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 4f964feb5..f4c9a2ed8 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -412,6 +412,7 @@ struct avdtp {
 	struct pending_req *req;
 
 	guint dc_timer;
+	int dc_timeout;
 
 	/* Attempt stream setup instead of disconnecting */
 	gboolean stream_setup;
@@ -1152,10 +1153,12 @@ static void set_disconnect_timer(struct avdtp *session)
 	if (session->dc_timer)
 		remove_disconnect_timer(session);
 
-	if (!session->stream_setup && !session->streams)
+	DBG("timeout %d", session->dc_timeout);
+
+	if (!session->dc_timeout)
 		session->dc_timer = g_idle_add(disconnect_timeout, session);
 	else
-		session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
+		session->dc_timer = g_timeout_add_seconds(session->dc_timeout,
 							disconnect_timeout,
 							session);
 }
@@ -1797,6 +1800,8 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CLOSING);
 
+	session->dc_timeout = DISCONNECT_TIMEOUT;
+
 	if (!avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 						AVDTP_CLOSE, NULL, 0))
 		return FALSE;
@@ -1893,8 +1898,10 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 
 	ret = avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
 						AVDTP_ABORT, NULL, 0);
-	if (ret)
+	if (ret) {
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
+		session->dc_timeout = DISCONNECT_TIMEOUT;
+	}
 
 	return ret;
 }
@@ -2377,6 +2384,8 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 	 * with respect to the disconnect timer */
 	session->stream_setup = TRUE;
 
+	session->dc_timeout = DISCONNECT_TIMEOUT;
+
 	avdtp_connect_cb(chan, NULL, session);
 
 	return session;
@@ -3512,8 +3521,10 @@ int avdtp_close(struct avdtp *session, struct avdtp_stream *stream,
 
 	ret = send_request(session, FALSE, stream, AVDTP_CLOSE,
 							&req, sizeof(req));
-	if (ret == 0)
+	if (ret == 0) {
 		stream->close_int = TRUE;
+		session->dc_timeout = 0;
+	}
 
 	return ret;
 }
@@ -3561,8 +3572,10 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 
 	ret = send_request(session, TRUE, stream, AVDTP_ABORT,
 							&req, sizeof(req));
-	if (ret == 0)
+	if (ret == 0) {
 		stream->abort_int = TRUE;
+		session->dc_timeout = 0;
+	}
 
 	return ret;
 }
-- 
2.17.2

