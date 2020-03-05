Return-Path: <SRS0=x0qO=4W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405AAC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FD22073B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Mar 2020 11:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gz/16O9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCELDx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:03:53 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51198 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCELDx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Mar 2020 06:03:53 -0500
Received: by mail-pf1-f201.google.com with SMTP id r13so3458929pfr.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2020 03:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=40RegrjQ0uhIkykj0kL7AG4CRI+gslX64W+LbXlWAC4=;
        b=Gz/16O9LMGROHAYLhiswzkjw3HaQRoPNcGravZIPSkNsv+laaxK4dHhCmyLHDkEa6c
         A5vaIjif7fe8hc9hcFv68hoIL3DIT/bWUql3Bb1AovsPcw68Q6SbnrfUjZPEidnbHh4G
         U3f3ktyCGhojtiNxxyR3KwdL0CFNqP0vewWknAEZ6IVIlL3EAWgCbFnWlPuT4YtUGPrT
         eoak1Jx23jy+LQHyX82XswphVD7682W9FrH+j7mPb9dcDJ7OQmck/aXPx7WKHQQK4uL2
         0DHTdKqIa87ubEwEv7Mp/h1y1KPeZWA0Nm1UBrIWcLbDiOVS4WP6qY85wgM/c24aJa6Q
         diQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=40RegrjQ0uhIkykj0kL7AG4CRI+gslX64W+LbXlWAC4=;
        b=MfkbFG6pYz2odHZevjE/lsnbTGv8IITsYWYRhp/s4x2ZeHJqk4Be2nqZI9GHV6gbGg
         qxwDdPofo87c6qRB/tvgKWkzy50dOH7r2QZQlpY/UUieuGJZ+hoNqP04LUMjyf/uq7uN
         cv4Ht9+oeKRVOsokPEwCsdAKZLLMMfObH1IF08SDR7JZ3PqVMxY6vok0+VIBzsBGBjzg
         Xsyg4cc8KTqtsafofuUmCao5k0QCXvwdpiGlcRKhlQzCWgGGhMC0tf0NWSr0gwKdgrF1
         EDFSY385jnWNrsv87eaGLJBJDGJHrHoIOC8sIgk5GTTl7Dn4Jfxd0bm/wFU+5HuDe7NW
         T0Bg==
X-Gm-Message-State: ANhLgQ3AQ+a7Ny7C9lIW7vOY9cuvUXgLHSEK2JRoRQKI6stpedQlesgz
        bHWssPRBt2/jUgqG0KFLUj9A9PU40B/Z4QJ1ffCPVZkYNOZ880sZjiIWQWv0+RpVE2brCY1W77G
        xh43L7TBMewMk8mn3kbEWaiecVT+bs5U3n6K05zFVpAsl9T8S1PNCePwWgEfievvfHitLMxb9Zj
        /3NKO3i/O7+Kw=
X-Google-Smtp-Source: ADFU+vu+LnKX88jndq92ncTWsKuc7AZVrmBP0UalyNXA+qyczk7DCKO85NrKR/RHuh+neHjepA/+0w5XkJnX5ChF1Q==
X-Received: by 2002:a63:4707:: with SMTP id u7mr7265196pga.221.1583406230475;
 Thu, 05 Mar 2020 03:03:50 -0800 (PST)
Date:   Thu,  5 Mar 2020 19:03:40 +0800
Message-Id: <20200305185904.Bluez.v1.1.I6c78c0eb9826eb17c944c4903132ee75c1324136@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v1] avdtp: Fix crashes in avdtp_abort
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Initialized avdtp_local_sep later since stream could be NULL.
---

 profiles/audio/avdtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0e075f9ff..12d984866 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3566,7 +3566,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct seid_req req;
 	int ret;
-	struct avdtp_local_sep *sep = stream->lsep;
+	struct avdtp_local_sep *sep;
 
 	if (!stream && session->discover) {
 		/* Don't call cb since it being aborted */
@@ -3581,6 +3581,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (stream->lsep->state == AVDTP_STATE_ABORTING)
 		return -EINVAL;
 
+	sep = stream->lsep;
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
 
 	if (session->req && stream == session->req->stream)
-- 
2.25.0.265.gbab2e86ba0-goog

