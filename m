Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF2C4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 05:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8774C20722
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 05:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgHqsJtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgCTFOg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:14:36 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:39545 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTFOg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 01:14:36 -0400
Received: by mail-yb1-f201.google.com with SMTP id h66so3354712yba.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2020 22:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PVj+7SjNlIU45zNg0OacwKeLCyTTe1IlcmItJ3ZLdsI=;
        b=rgHqsJtRCh7da2whEJ++sdjjuCw+liyyEiwPCV+Rw0Eoc+wm+RAVxIViw7zxMfZI2I
         ITIlhJn0iV3U5huV7OWuJpRvXMQxWfp1ouxYuxsgqUjwhr27y0l9CoToQrjhZJ2NgTxP
         gELcNcpau8Jo3xXUj4I2v3p/3hbw/qJZe9tMdfsqBkwd7qLBbfGEc5PVOmOwYOEsN9hn
         wRRRIThK7lWuS4NrZ0Sq+pk5gjC1FNQ2shI4yPBvZ7tANtsUdCqev/nxSstM0qW8gT+r
         Xm1clmyYnwQZNWYoJMumOzBw4nLJYeA2rTzUFeaxxmctoUwpRR8SNfXZ+UVWy4YNF413
         PiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PVj+7SjNlIU45zNg0OacwKeLCyTTe1IlcmItJ3ZLdsI=;
        b=G/ZM3+jS5n8slOtvXh+sCfvjGKTEGTVHKEXZc9b7VtsPe/fyEjjuKCt0bLOBzfvZWe
         9JLdPlRN2KJl6PaXY3Tp8pxBucq8SuSEKZc7RtEWn1hyLzW69xA8d23ol1wMJpKI8Znr
         VLoNgWOIXRqFpccdsV4DqSFfxq7mPdizKnlFNrrD0QPrxlBparcT0WU6hn01kvJeUQ4x
         OWbEol0gxZfhGRe4aw+XAGkqARKSSF567Lf4u4nqQDWTvLB+HafBFza+sSCEqpqmqr4d
         ZvJ+nY+xeWeBpfvtU5ckU+pXSxt7nBtavuitEMuISMIRWpELVfKeelAvnBXLZIyeuHXM
         v0wg==
X-Gm-Message-State: ANhLgQ1Ody+WWEQq/F890aX9NJYrsLYqYEZYRm9lf735T49sNph7PRt2
        ZaeVWOpTFkrwJEKTVyyylN4LHqytqK0Puvl7wEgB41c0MA6f3CLjo5Wk1a5DSy11NajA10qSldM
        5eDPycAtEIxNc7wYI+Y/fhMAoPyVl6JQfqCD68jTVuTKFmNUAOk4fGnTh1h1a+FXCsiBlQv3fIP
        FQ
X-Google-Smtp-Source: ADFU+vtFtuSTUtoIvDQMqYGyBCsInycFOftfioMRMyo9J2X1AVdPe5ITproPFtHtBOyZHOYzBwm13rr0a8xL
X-Received: by 2002:a25:ba8b:: with SMTP id s11mr9610113ybg.343.1584681274855;
 Thu, 19 Mar 2020 22:14:34 -0700 (PDT)
Date:   Fri, 20 Mar 2020 13:14:25 +0800
Message-Id: <20200320131356.Bluez.v1.1.Ia3d21e293d18f903fa6e54918856e1dd5ffc904f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [Bluez PATCH v1] avdtp: fix delay report valid states
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to AVDTP specification section 6.19,
avdtp_delayreport_cmd could also be received when the state of SEP
is open.

Therefore, updating to accommodate such condition.
---

 profiles/audio/avdtp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0e075f9ff..4b0e63384 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1936,6 +1936,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 	stream = sep->stream;
 
 	if (sep->state != AVDTP_STATE_CONFIGURED &&
+					sep->state != AVDTP_STATE_OPEN &&
 					sep->state != AVDTP_STATE_STREAMING) {
 		err = AVDTP_BAD_STATE;
 		goto failed;
-- 
2.25.1.696.g5e7596f4ac-goog

