Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE929C388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 23:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A177B24198
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 23:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIxiwo4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgKPXjN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbgKPXjM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 18:39:12 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E94C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 15:39:12 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id c66so15688428pfa.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 15:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2IpVZOBFKwG6fkZR6kKHP8HoxMJ30d0Brw+5dul0Yhw=;
        b=BIxiwo4URxhrjr0s1QE1mvB+PUUGt9L3BFGdhlECBX64/QrhhSoNXSa9lVm28bRbB3
         pjeQdEzYgwtGxDjgOfrcIkj6jzw3Hr0N3ZunLNd5rA7d8Bxbk7E+BRsO6nL9tmN2rF0M
         JDv8w76g7w7L+sMuB5PCMLCgXRZk/9BiQ0u3biTNMvqbRP+niqYKlok+9QVIkUK76qXF
         m2w1zVj+T2noiH7o4qo3WdHjpaJkQj1wfLoHe5BbOCT744RUzICF2Z6dBUDSScXEYVH9
         Gz7u8HDF4GwZuhvVvLe1OSP107QkPfMnHRWvfcQx8hu4sr2D7hZplCpr+en8dTTUk9U2
         HRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2IpVZOBFKwG6fkZR6kKHP8HoxMJ30d0Brw+5dul0Yhw=;
        b=ltxoCj8QOcrHQAmmcqtmmvGBewewujnOK/a9pnKzZ9NmNQgNRrB/KshGJkeJjxVFmy
         3e5T4RzrKxo7Yt2u44vBxhtdEGJNcg9X/CdDBoLnPuC1gmHFmKTw7oU/sQriyz2/Bmit
         E4LBPh6M367GNsdgqRy4kjR85ZU5G/b8Snl/mxQenBMM6xdEbQxTQ8jfQYUI7AlluO2H
         dHPhKrjKMbHqKe0qAmjkvaYyel5UGtXOTmnvqPeT+fHD+SdVLNoz6rTJ6cWxeEa+Rwb1
         ZolWKuPVYe3TcXe6sW21obGiDERBPzfsycAGDHcoT7DSy9PA7CYDpVmF/3suuK1PCxdv
         XDtg==
X-Gm-Message-State: AOAM533FHv4e9BdpxhHKCvlGeK7FZJiOg9iJsbTcpa/fK5Lgvoe+ZaCH
        0gbpSSUCvA5TvgrB/m0eFzYg9IA/lkw=
X-Google-Smtp-Source: ABdhPJwrutMwnAvBpFtpA6uXdfkqUTLOWm338gF+7V29gnG/gxUGMgU0qJLZ9HfFZqe2ceHGwgKFjw==
X-Received: by 2002:a17:90a:1705:: with SMTP id z5mr1424828pjd.129.1605569952006;
        Mon, 16 Nov 2020 15:39:12 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s4sm96006pjn.0.2020.11.16.15.39.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:39:11 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/2] avdtp: Fix connecting using streaming mode with signalling channel
Date:   Mon, 16 Nov 2020 15:39:09 -0800
Message-Id: <20201116233910.4128702-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Signalling channel shall only use Basic or ERTM modes.
---
 profiles/audio/avdtp.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 16fa20bba..619b94e29 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2429,20 +2429,13 @@ uint16_t avdtp_get_version(struct avdtp *session)
 	return session->version;
 }
 
-static GIOChannel *l2cap_connect(struct avdtp *session)
+static GIOChannel *l2cap_connect(struct avdtp *session, BtIOMode mode)
 {
 	GError *err = NULL;
 	GIOChannel *io;
 	const bdaddr_t *src;
-	BtIOMode mode;
-
 	src = btd_adapter_get_address(device_get_adapter(session->device));
 
-	if (btd_opts.mps == MPS_OFF)
-		mode = BT_IO_MODE_BASIC;
-	else
-		mode = BT_IO_MODE_STREAMING;
-
 	if (session->phy)
 		io = bt_io_connect(avdtp_connect_cb, session,
 					NULL, &err,
@@ -2610,7 +2603,14 @@ static int send_req(struct avdtp *session, gboolean priority,
 	int err, timeout;
 
 	if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
-		session->io = l2cap_connect(session);
+		BtIOMode mode;
+
+		if (btd_opts.mps == MPS_OFF)
+			mode = BT_IO_MODE_BASIC;
+		else
+			mode = BT_IO_MODE_ERTM;
+
+		session->io = l2cap_connect(session, mode);
 		if (!session->io) {
 			/* Report disconnection anyways, as the other layers
 			 * are using this state for cleanup.
@@ -2807,8 +2807,14 @@ static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stre
 				struct seid_rej *resp, int size)
 {
 	struct avdtp_local_sep *sep = stream->lsep;
+	BtIOMode mode;
+
+	if (btd_opts.mps == MPS_OFF)
+		mode = BT_IO_MODE_BASIC;
+	else
+		mode = BT_IO_MODE_STREAMING;
 
-	stream->io = l2cap_connect(session);
+	stream->io = l2cap_connect(session, mode);
 	if (!stream->io) {
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
 		return FALSE;
-- 
2.26.2

