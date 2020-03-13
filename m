Return-Path: <SRS0=ynic=46=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A816FC2BB1D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Mar 2020 08:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAED20724
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Mar 2020 08:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRLhThYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgCMIlW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:41:22 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:50051 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCMIlW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Mar 2020 04:41:22 -0400
Received: by mail-qk1-f201.google.com with SMTP id c1so7211505qkm.16
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2020 01:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k3gSKNf82gpanOuiZQzkhHbwuYg72gdAtRjJ9P/+VYQ=;
        b=dRLhThYSBkBAHGayLJhvJhOg0ZsXZsmsEmaLdnV80a6vKr2FACnA4rTn2Lt0uBywqE
         e1dMja13zf9ye06Fx+aRjiM9mu+lJjukHb/KJLhVO6736YD7iMDaxOshxwtJvF9QQ6Ep
         d5su/+7IXPz6RqrsKdej8IqtmJ87qjWn6xBrIeZIHuLHy1cLn50qhf6H5tFVK97BgJvY
         Mtfzg209JePpW87ShUDlbe+W8sh+bopCmoVRzqcmk2xBQ8ZoCk9O23Tjucp6FiZGIxWg
         kE9CudoxgMJ4Y10H1GpmwOxiZT+enVSYH2YLPQ9OEDFp3NBZC39nd/0+GOFsrElDEVU/
         Q0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k3gSKNf82gpanOuiZQzkhHbwuYg72gdAtRjJ9P/+VYQ=;
        b=FEGmqwK/vYLo+lFmTCX7ACDwcVAu/X+Vm6nabGXPxawx1jKvxWSKFNlrDoMZ7sQMCw
         pJ6RJ9whnswKCaork1UQG1F4meln6Kl98AvenpRHWnuUsSLKoH/QWcpiVpioLUKBkyK3
         jXKcWDxStTdtofSFdXrSpqvgMZ3ORNBW4YVtFDRTZOqOWb5jsvmOW96o3piLqUlVZgl+
         JVuiyH4lEoomtfOPy14mIMAQ3dNUX0Seg497Q0bh02W2IGVP86nXM6SS1M1LqapFYW7+
         w0DTxR8Fp9O/9i7snhvjdYn0rqK7Kie8mAdGnR/PnCdp/FFQWSryTCwmf6XMg7tU9OVu
         XmeA==
X-Gm-Message-State: ANhLgQ37d21WlJ4/LIXlxCRcB1UjhOToRKOp2zITaWD5zMvTj6QNH9iw
        YxzzPn36BqomhGc3oen08zdLHkxMWaWgDmmy8/7Xvv8ppEoV8DHtqAfgx8CDHCePgTJbidsGuYv
        nWBwZHxr/33Aq+Ndr0yh4yLWBxQnb0yxbHsI/Pwgm61iC+zF6ROfkfl2eUovX6NfY9pMU8sz3HY
        JF
X-Google-Smtp-Source: ADFU+vvJMyUw561oeSavnMq4fv5rmbqSAO06qRyrnZzBLkOeEGhnoxt7elHRSMh6dj1e9dHPvuFVRqGX3Ooo
X-Received: by 2002:a25:9a47:: with SMTP id r7mr15204459ybo.221.1584088881151;
 Fri, 13 Mar 2020 01:41:21 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:41:03 +0800
Message-Id: <20200313164001.Bluez.v1.1.I320c1cb9a71bf0793ae3a644548c76b13427a97d@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [Bluez PATCH v1] avdtp: Add check for service capabilities length correctness
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

There is a check for capability length of AVDTP_MEDIA_TRANSPORT,
but there are none for the other capability categories.

Therefore, this patch add such check for these categories:
AVDTP_REPORTING
AVDTP_RECOVERY
AVDTP_CONTENT_PROTECTION
AVDTP_HEADER_COMPRESSION
AVDTP_MULTIPLEXING

Set Configuration Command messages which contains bad length shall
be responded with Set Configuration Reject.

Furthermore, this patch also assign the service category field for
Set Configuration Reject, as what is described in section 8.9.3 of
Bluetooth AVDTP spec.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

 profiles/audio/avdtp.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0e075f9ff..5faf0279e 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1421,6 +1421,39 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_CONFIGURED);
 }
 
+static uint8_t verify_service_capability_length(
+					struct avdtp_service_capability *cap)
+{
+	switch (cap->category) {
+	case AVDTP_MEDIA_TRANSPORT:
+		if (cap->length != 0)
+			return AVDTP_BAD_MEDIA_TRANSPORT_FORMAT;
+		break;
+	case AVDTP_REPORTING:
+		if (cap->length != 0)
+			return AVDTP_BAD_PAYLOAD_FORMAT;
+		break;
+	case AVDTP_RECOVERY:
+		if (cap->length != 3)
+			return AVDTP_BAD_RECOVERY_FORMAT;
+		break;
+	case AVDTP_CONTENT_PROTECTION:
+		if (cap->length < 2)
+			return AVDTP_BAD_CP_FORMAT;
+		break;
+	case AVDTP_HEADER_COMPRESSION:
+		if (cap->length != 1)
+			return AVDTP_BAD_ROHC_FORMAT;
+		break;
+	case AVDTP_MULTIPLEXING:
+		if (cap->length < 2 || cap->length > 7)
+			return AVDTP_BAD_MULTIPLEXING_FORMAT;
+		break;
+	}
+
+	return 0;
+}
+
 static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 				struct setconf_req *req, unsigned int size)
 {
@@ -1487,12 +1520,12 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 					&stream->codec,
 					&stream->delay_reporting);
 
-	/* Verify that the Media Transport capability's length = 0. Reject otherwise */
 	for (l = stream->caps; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_service_capability *cap = l->data;
 
-		if (cap->category == AVDTP_MEDIA_TRANSPORT && cap->length != 0) {
-			err = AVDTP_BAD_MEDIA_TRANSPORT_FORMAT;
+		err = verify_service_capability_length(cap);
+		if (err) {
+			category = cap->category;
 			goto failed_stream;
 		}
 	}
-- 
2.25.1.481.gfbce0eb801-goog

