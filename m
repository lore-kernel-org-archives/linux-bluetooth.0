Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2545FC282C5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4DB20879
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIYiv7c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfAVNpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:41 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:36143 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfAVNpl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:41 -0500
Received: by mail-ed1-f44.google.com with SMTP id f23so19348919edb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 05:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=AVWaushRs7nkXjvfzNqW87RGHM12FcgrQewKIb+0Oco=;
        b=UIYiv7c3ZxBgBsjeF+JwYX3BILDxR9A27wH6Qg+TauHediDqp7F8Me61gDZgaXVVot
         dovLe1OV010IX5FD/tSUdPE+tU5kvAnwzgpEToxgxQhqh8fb2PdWQ3ESl2foLRKxk3rU
         bsCWOmj7yxeOPDGGi1jgcLtxrcH81T0/f0vAHCYFIaFXnwE6MQCFdiVV9tfY45TClpyz
         MNY5tg2YEaAFW4NXSH5NE27t8bCXj1adzaxpJHi/XeY0uTVcTQogLUaJ7VO6KxHkYjYN
         Br+aJre5DZo3HubME8YcRXyUdjGX3pO16uhhpR/AE15RjXeTDW4Y4RqAg4+OrXr7O2p2
         3wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=AVWaushRs7nkXjvfzNqW87RGHM12FcgrQewKIb+0Oco=;
        b=NEqeC3ay3j0PGYw+9h3x72I+talGkwa+hfo+ilNh+lG8UE10KDLsAgDlDwoDumivXq
         /22lws1ZmStAWlcdo+SOnDujIUbQvHRh8BYObQVSvO+bgyXFsFzfHtX+abWShgH2wqkl
         Gv3zTpQRBAQNN5vV6ie/UiYx1MuHhp3mQgE0pwPALjRLFHliMsbeK9+sLchLSCOGhA3g
         XkXufnRVhK3rbQHL3KLNgCFJxurKko2suY13/wyO7NnMLC4VJnPMxprbTOo14ZVBs5CR
         dWTyg7djZ0I/oTmTqLJtzbz3PSjkq25UjqR1LSp+wB/ERjrVZx4b1eI0q19teLXJD/JM
         x7ig==
X-Gm-Message-State: AJcUukft8pudwJNb12GmyueRYHXzXD1fblw+rB2ipFj2xP8n1s1lgSWY
        Ztn45AwMrY/p5CIrAmz0l3Af+MKN
X-Google-Smtp-Source: ALg8bN7T1qfzqLa+PN2pCd4qxx1ufw+p3Q1cJh74i+PFegz39zB7DwiKX/445gvPc266xriSzgWttg==
X-Received: by 2002:a17:906:2e4f:: with SMTP id r15-v6mr28241171eji.198.1548164738801;
        Tue, 22 Jan 2019 05:45:38 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm5319153ejb.53.2019.01.22.05.45.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:45:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 9/9] a2dp: Add reverse discovery
Date:   Tue, 22 Jan 2019 15:45:24 +0200
Message-Id: <20190122134524.20509-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122134524.20509-1-luiz.dentz@gmail.com>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Now that remote endpoints are exposed there is a chance that a
configured device will reconnect and initiate SetConfiguration skipping
the discovery phase which is now required in order to be able to switch
endpoints, so this introduces the reverse discovery logic in order to
find out about remote endpoints capabilities if they have not been
found yet.
---
 profiles/audio/a2dp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index ff384cd23..4001ea0ea 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -583,6 +583,12 @@ static gboolean endpoint_match_codec_ind(struct avdtp *session,
 	return TRUE;
 }
 
+static void reverse_discover(struct avdtp *session, GSList *seps, int err,
+							void *user_data)
+{
+	DBG("err %d", err);
+}
+
 static gboolean endpoint_setconf_ind(struct avdtp *session,
 						struct avdtp_local_sep *sep,
 						struct avdtp_stream *stream,
@@ -638,8 +644,14 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 						setup_ref(setup),
 						endpoint_setconf_cb,
 						a2dp_sep->user_data);
-		if (ret == 0)
+		if (ret == 0) {
+			/* Attempt to reverve discover if there are no remote
+			 * SEPs.
+			 */
+			if (queue_isempty(setup->chan->seps))
+				a2dp_discover(session, reverse_discover, NULL);
 			return TRUE;
+		}
 
 		setup_unref(setup);
 		setup->err = g_new(struct avdtp_error, 1);
-- 
2.17.2

