Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2372EC43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E564F2075C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 09:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ohBhoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfECJpB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 05:45:01 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:45621 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECJpA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 05:45:00 -0400
Received: by mail-lj1-f173.google.com with SMTP id w12so4651296ljh.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 02:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2EQOjhQ2HFe6BUiqvi74ZBwVWlvks5nOvCz0Wil3vdY=;
        b=e4ohBhoMJm9gMStBmsEbep/Vju43xud7im2CZJ9SlbRzOxxDJTRySeb7jkuFXZ4lG8
         Tdulhq2GUQSjjZSCxODNiOiWx5ELJ1Ia3FrYdQnjzUqVDoqkRzb+etYq98jnitX/aBE3
         FBtMAA4rdq2dlV5FvOsQ54Jopy+Mk+zIc2U/Rv8uPDMRIz5fbaCb16jy0I26Gm7KFkcD
         dW1+gLKl6EXu7ULoUXrFoeDbNOqhFhiQxhzj+fpOf3yoZX/Gf9HE7nFpXw/OUqjLoSIk
         Z7hZpvZqFSYKUB+O/Vez0a/Tf/JbpB3mEJwzHWpNepDvNMQ+6hfMpomsGYPRncwxwupO
         LhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EQOjhQ2HFe6BUiqvi74ZBwVWlvks5nOvCz0Wil3vdY=;
        b=GUSkZtwdzcalELg0ih+kfFKFu48pwqLP8JI1Yn09+iPHI5hLHJ7BiCcKEpd6A1uZKJ
         PVfCup1SH3hEklme0yEBt/BdMQkl3ADVD2qQ+bsO/QuvTFzw5ziun+bw0gdakqVix2P4
         2JR8zoGz0l3yzZ23/EjowdDizcUxLzFTnQtZQZyYcLWsRBugRVqBFLdbZuhqkLOwTnmz
         HiXV1KVTOe59lOnYd8JIyG7z15j+w/DZlKVZo+lSyt2OE2+cHnHvJWW0poHlOXR54NH0
         AekjyIt8V5iZqb6xPE4Kwdo30a2HnNE4u8cKUpfnlpGNsWVFBLukLd8gvWzw4M0rhoep
         KKtw==
X-Gm-Message-State: APjAAAWBADmoinucNQXkUzeQK3wqzbnHgW8iJNwqGDpuvO8abFjJyfeM
        61uTZo8W3PBLCUVn8bXKj0gP0RzkEMk9iA==
X-Google-Smtp-Source: APXvYqxDUFmo3Y1yNLCAzJ8k/dCaXcOSOjumw2tOyBkgy5/ptF4CdEu7Nque7DoXEdcqQZ4KZZeziA==
X-Received: by 2002:a2e:85d2:: with SMTP id h18mr4442984ljj.128.1556876698090;
        Fri, 03 May 2019 02:44:58 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id e19sm376455lfd.36.2019.05.03.02.44.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 02:44:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] a2dp: Try aborting when switching endpoints
Date:   Fri,  3 May 2019 12:44:52 +0300
Message-Id: <20190503094454.23774-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503094454.23774-1-luiz.dentz@gmail.com>
References: <20190503094454.23774-1-luiz.dentz@gmail.com>
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

