Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B867C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8CD20830
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4/o67Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfEFMnR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 08:43:17 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35693 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFMnR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 08:43:17 -0400
Received: by mail-ed1-f43.google.com with SMTP id p26so15190526edr.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2EQOjhQ2HFe6BUiqvi74ZBwVWlvks5nOvCz0Wil3vdY=;
        b=a4/o67SjD0Odj40BERtdKtZnXOGFocv0c4h959VBpRBlI+1ChJCKKN0lRK6U1V6MZ5
         TOMqwcvlXtmETUhDmLYUn4XqngFwfdSkUPYNlmoDoDEOQ/N6i3FhEu0U3IcJPdblRmLL
         ll+9+UVVT8/iCYnKXqKv4qIdx2XwrbY5dBBQE/GHCq9DbPcVkHf5/nVMHOPLZ+ZwiAbK
         FAKkVPHQq+Eze2o0bTti37gkQFkgSYrgH8b0Rdrj9fnf6Uo8pBTs1TAY9i/50amfEQgh
         U/MV16dTuRAOYZGS8bnC+G8kjIC6bCEcPDtchSQAhZFFiEjXsfZvTeRMyf8MY3w/+tRz
         wKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EQOjhQ2HFe6BUiqvi74ZBwVWlvks5nOvCz0Wil3vdY=;
        b=G9m9bJ/fcKanrZ8uoxwN7QZBq3ZffVPZi3vmxYoNlRciPNcBBG6wNcEx/A0U19ojoL
         5b6cUomnjgpft5EO4ZOb/QVPZucPqT2O/TJRkJgHDjR6JK04WQrFAbckX9LpL67I0i4i
         tT+nKLNhqkRDapqUL83ZNWZaGv0sr/sIVUoadGxsLvETE4JBkSNKZNRwX6Vj/B0SZUhC
         PTA92PjiDjAHLh5witGzoFP1WKWfI/6N+asSp+S53CERatxn58zl/1YhZVbE3XAOrLU4
         D/jOBweRw5K3Woh0ARSvFmzO/JrBAwpibgPx3NreQ6QuUrxar6GC8g7spVbn3r1Q2Xs9
         PR4Q==
X-Gm-Message-State: APjAAAVaHk74enWTbmFd1jHR2Rj+pSsL3JwTwuZJu7PJS1uSjG1FCH3d
        mKRKM8UAwiBvPiRoGafvbene9jpU0Bk=
X-Google-Smtp-Source: APXvYqz5i5rPswHCOjlxCohA7RV+3IzpNeJAaFp7P1Zv+Kvhg+OQp/TsJfdoiP/Px6AdZgN/Qluigg==
X-Received: by 2002:a17:906:d72:: with SMTP id s18mr18926961ejh.111.1557146595263;
        Mon, 06 May 2019 05:43:15 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h27sm1025816edb.66.2019.05.06.05.43.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 05:43:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/6] a2dp: Try aborting when switching endpoints
Date:   Mon,  6 May 2019 15:43:06 +0300
Message-Id: <20190506124310.19151-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506124310.19151-1-luiz.dentz@gmail.com>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If ongoing stream cannot be closed try aborting since the setup may
still be ongoing.
---
 profiles/audio/a2dp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 74ada3bbe..d0913b1ec 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1257,6 +1257,11 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!setup)
 		return;
 
+	if (setup->reconfigure) {
+		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
+		return;
+	}
+
 	setup_unref(setup);
 }
 
@@ -1642,8 +1647,12 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 
 			err = avdtp_close(chan->session, tmp->stream, FALSE);
 			if (err < 0) {
-				error("avdtp_close: %s", strerror(-err));
-				goto fail;
+				err = avdtp_abort(chan->session, tmp->stream);
+				if (err < 0) {
+					error("avdtp_abort: %s",
+							strerror(-err));
+					goto fail;
+				}
 			}
 
 			setup->reconfigure = TRUE;
-- 
2.20.1

