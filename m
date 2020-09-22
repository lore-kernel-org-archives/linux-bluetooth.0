Return-Path: <SRS0=LYTB=C7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A6C2D0E2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96348221F0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Sep 2020 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZT5JI/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgIVXGl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXGl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Sep 2020 19:06:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F7FC061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2020 16:06:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x22so9024241pfo.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2020 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Laiihs0AaECfje2oIsybon2jtD4LrGoqde0EkeWBcm8=;
        b=vZT5JI/XNcducT0pHahqZmRltPIWSubHo1F+RzHGtpelrZfKwZbsyaPvNbwB5FAqfC
         OI1l2/g99Klre1ejYlkxV3THKDBSCmBO/ZGYT7h74Hv8sKsL8Vngh6G6K0gf8+984ZC+
         0Cn/zvU4LOc21Sn6Z7IqqQGXdCpzAANpFzohwG27bjF6hPDgeloOhmd2n+Q/g1ZbizN4
         /qEeSZSOxyxrSE5P+zVy7dlyxRSWlFN+btxOHo4wgAgKM6q5xlohQzUkD7WlPBmrSaJq
         EUtt/7Px3EedEszkZoA8ZkrGdxvljDF/fE9BLxaUtO0ZvAziBsQC6sizSySuxZSptjyO
         xaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Laiihs0AaECfje2oIsybon2jtD4LrGoqde0EkeWBcm8=;
        b=UIVc9Xllz0rq8IFw2wKpOS1cV3Atn7TiiDICUXttgLkXW8f809HfoxZkRpL+wwROD9
         F/kE4MBot9EFx4qUv2642rd1czcN9miYoTI3HyqckplDvcCoqxaSq+JK4Hu4xVXVedzS
         iDWcWFSFYbeEsVCFjqFI0Eh57qoXShucEgJ2GDmrDKXNy3pACKC2tPbyYFOZtueAhQVj
         A5fE2sLdp2kr/SiStzwTSxM2B/ZCPoRJjS8BaeqwYYQwv7EMAGD9RgTpKHzVwU3LvXCu
         YVRgEyaFvzGZEmjFxAuTIKDGDG8NHT5JRN7OocMrKr+isj2gtrV3PFQqKCqyLFXen45U
         snCQ==
X-Gm-Message-State: AOAM5325mQPZjbqDA7Rg1ejKrV7dSi6T/S+N2BPhVVp6DFPgcfTJKS2D
        jNfwz4dS4hIHjIBl5p0bTPumOcMUtPM=
X-Google-Smtp-Source: ABdhPJwP8BYHpc39GuUOt2oiBU65TGr1smWsde7aUNFRpA/DWOSwqjwAYJF0qAvKOBHtfYF36pRWxA==
X-Received: by 2002:a63:4416:: with SMTP id r22mr5444989pga.248.1600816000113;
        Tue, 22 Sep 2020 16:06:40 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y29sm17464823pfq.207.2020.09.22.16.06.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:06:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] avdtp: Handle case where remote send L2CAP connect ahead of Open
Date:   Tue, 22 Sep 2020 16:06:37 -0700
Message-Id: <20200922230637.3524806-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stores the channel if it had been connected ahead of Open
procedure so it can later be processed.
---
 profiles/audio/avdtp.c | 75 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b44a23c48..ae93fb26f 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -388,6 +388,7 @@ struct avdtp {
 	GSList *prio_queue; /* Same as req_queue but is processed before it */
 
 	struct avdtp_stream *pending_open;
+	GIOChannel *pending_open_io;
 
 	uint32_t phy;
 	uint16_t imtu;
@@ -609,11 +610,33 @@ static gboolean stream_open_timeout(gpointer user_data)
 
 	stream->session->pending_open = NULL;
 
+	if (stream->session->pending_open_io) {
+		g_io_channel_unref(stream->session->pending_open_io);
+		stream->session->pending_open_io = NULL;
+	}
+
 	avdtp_abort(stream->session, stream);
 
 	return FALSE;
 }
 
+static void stream_set_timer(struct avdtp_stream *stream, guint timeout,
+							GSourceFunc func)
+{
+	if (stream->timer)
+		g_source_remove(stream->timer);
+
+	stream->timer = g_timeout_add_seconds(timeout, func, stream);
+}
+
+static void stream_set_pending_open(struct avdtp_stream *stream, GIOChannel *io)
+{
+	stream->open_acp = TRUE;
+	stream->session->pending_open = stream;
+	stream->session->pending_open_io = io;
+	stream_set_timer(stream, REQ_TIMEOUT, stream_open_timeout);
+}
+
 void avdtp_error_init(struct avdtp_error *err, uint8_t category, int id)
 {
 	err->category = category;
@@ -836,6 +859,12 @@ proceed:
 
 	stream->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 					(GIOFunc) transport_cb, stream);
+
+	/* Release pending IO */
+	if (session->pending_open_io) {
+		g_io_channel_unref(session->pending_open_io);
+		session->pending_open_io = NULL;
+	}
 }
 
 static int pending_req_cmp(gconstpointer a, gconstpointer b)
@@ -1674,6 +1703,14 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 
 	stream = sep->stream;
 
+	/* Check if the stream is pending and there is an IO set already */
+	if (stream == session->pending_open && session->pending_open_io) {
+		handle_transport_connect(session, session->pending_open_io,
+						stream->imtu, stream->omtu);
+		return avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
+							AVDTP_OPEN, NULL, 0);
+	}
+
 	if (sep->ind && sep->ind->open && !session->pending_open) {
 		if (!sep->ind->open(session, sep, stream, &err,
 					sep->user_data))
@@ -1686,13 +1723,8 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 						AVDTP_OPEN, NULL, 0))
 		return FALSE;
 
-	if (!session->pending_open) {
-		stream->open_acp = TRUE;
-		session->pending_open = stream;
-		stream->timer = g_timeout_add_seconds(REQ_TIMEOUT,
-						stream_open_timeout,
-						stream);
-	}
+	if (!session->pending_open)
+		stream_set_pending_open(stream, NULL);
 
 	return TRUE;
 
@@ -3139,18 +3171,39 @@ struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
 						size_t imtu, size_t omtu)
 {
-	GIOChannel *io;
+	GIOChannel *io = g_io_channel_unix_new(fd);
 
-	if (stream != stream->session->pending_open)
-		return FALSE;
+	if (stream != stream->session->pending_open) {
+		uint8_t err;
+
+		if (stream->session->pending_open)
+			goto failed;
+
+		/* Attempt to Open there is no pending stream set yet */
+		if (stream->lsep->ind && stream->lsep->ind->open) {
+			if (!stream->lsep->ind->open(stream->session,
+						stream->lsep,
+						stream, &err,
+						stream->lsep->user_data))
+				goto failed;
+		}
 
-	io = g_io_channel_unix_new(fd);
+		stream_set_pending_open(stream, io);
+		stream->imtu = imtu;
+		stream->omtu = omtu;
+
+		return TRUE;
+	}
 
 	handle_transport_connect(stream->session, io, imtu, omtu);
 
 	g_io_channel_unref(io);
 
 	return TRUE;
+
+failed:
+	g_io_channel_unref(io);
+	return FALSE;
 }
 
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
-- 
2.26.2

