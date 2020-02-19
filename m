Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE2C3404C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011A32173E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 00:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpqfeI8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgBSAgW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:36:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33439 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgBSAgW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 19:36:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so11565974pfn.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 16:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KfHgx4KA2lQ2RntLtxbWBLc3vqu7hBUeejmhR/t+iIA=;
        b=dpqfeI8sLIn7iMd6t0Co9NopSBbBfao7NNJjgi9DWyYDxxf9ihRdQtIfjA+beKc+FD
         zn5BPqaAdRMllOKXpv+ToKvlFzifzbxHd/HdyOKspLx1lFb07Glva2rtERNXLwgxBg8J
         4Xj9TMsrtGVXTeFempitpgJOqIIdt5CBi577IA6p+NpIBMy5UemOmt6ATqTHjEIEi9yf
         9vvK4vizaNIX3xhwxWuRYXCQ2X0bHhPgfsG8nGC7txgZoyNQ9ra4obB/p08DI7GiOetR
         Kn6jpqLTx4CGe2yjVQ028TzbOFIMVPXea/Mj+hPtpkyI0Ji5CS8N2fSMoBE1cMnRtlpA
         F15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfHgx4KA2lQ2RntLtxbWBLc3vqu7hBUeejmhR/t+iIA=;
        b=Qxkor7EzB6oFz/xcxxLMa0+b6UJ7Qo4XCcjGesJ0ExA9DqMuKlsQYsEePVQ8fo1W7J
         dUSC5D+SYNyaeUG6S8vRf6aUgsXZ/Eg/CzAfkS922AOLj+iYNcMDImIykZtXs4nQvA5D
         Q0DlXJfuYlbbyHJvTskNOAeJsFqME/cjlnBSwiDH2iZ1tRKsO8jiSBSE9V+rWXJUcRno
         wvIK3z9GvTPnwajofUAHz+sP2VOGfE37QDrf81MSwCnIEMFjE1rmJKpnzrxJy9+QWiPW
         j92svjPj/ZkoG+cFkS+bAUbXkO1PQiMjnYd3gH8VvAKpbxeoAgHfyQLt/LAVKNQwSctS
         u76Q==
X-Gm-Message-State: APjAAAVWyf8CWTXD2BC6R+bn3IrTxxmwJp+3DYczL3MBwl9KUFt7Xr6O
        XQnmYxMboGf6XBAuW65tPemD6I3+LjI=
X-Google-Smtp-Source: APXvYqz4tAUyKqIwN2P9p3ls+ecQLfNvXyfzTbfTQbpkOS/PNIgR/4k5AK+tymvtUBaFRgmUxyRTMA==
X-Received: by 2002:a05:6a00:5b:: with SMTP id i27mr24511910pfk.112.1582072580936;
        Tue, 18 Feb 2020 16:36:20 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.42])
        by smtp.gmail.com with ESMTPSA id v184sm180569pfc.67.2020.02.18.16.36.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 16:36:20 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] avdtp: Enable MTU auto tunning
Date:   Tue, 18 Feb 2020 16:36:12 -0800
Message-Id: <20200219003612.14599-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219003612.14599-1-luiz.dentz@gmail.com>
References: <20200219003612.14599-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses BT_PHY to check if kernel is able to do MTU auto tunning
which is enabled by forcing the input MTU to 0.
---
 profiles/audio/avdtp.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f42f21bbb..0e075f9ff 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -401,6 +401,7 @@ struct avdtp {
 
 	struct avdtp_stream *pending_open;
 
+	uint32_t phy;
 	uint16_t imtu;
 	uint16_t omtu;
 
@@ -2291,6 +2292,9 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	if (!session->io)
 		session->io = g_io_channel_ref(chan);
 
+	/* Check if kernel supports reading packet types */
+	bt_io_get(chan, NULL, BT_IO_OPT_PHY, &session->phy, BT_IO_OPT_INVALID);
+
 	bt_io_get(chan, &err,
 			BT_IO_OPT_OMTU, &session->omtu,
 			BT_IO_OPT_IMTU, &session->imtu,
@@ -2399,14 +2403,26 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 
 	src = btd_adapter_get_address(device_get_adapter(session->device));
 
-	io = bt_io_connect(avdtp_connect_cb, session,
-				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_DEST_BDADDR,
-				device_get_address(session->device),
-				BT_IO_OPT_PSM, AVDTP_PSM,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
+	if (session->phy)
+		io = bt_io_connect(avdtp_connect_cb, session,
+					NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, src,
+					BT_IO_OPT_DEST_BDADDR,
+					device_get_address(session->device),
+					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					/* Set Input MTU to 0 to auto-tune */
+					BT_IO_OPT_IMTU, 0,
+					BT_IO_OPT_INVALID);
+	else
+		io = bt_io_connect(avdtp_connect_cb, session,
+					NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, src,
+					BT_IO_OPT_DEST_BDADDR,
+					device_get_address(session->device),
+					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
 	if (!io) {
 		error("%s", err->message);
 		g_error_free(err);
-- 
2.21.1

