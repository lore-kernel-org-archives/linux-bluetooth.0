Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69871C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0057420936
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzK40psF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKEGlB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgKEGlB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:41:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB317C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:41:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y11so510094ybm.22
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3uB46e4wAC56usX3WUKxk/x85EKQRpS+HGXlr+AFs78=;
        b=VzK40psFTw4avCkuhImx9RcW9zF5NGk/KKytrYCbLQrjrzOWa4Sj7UdKPsp+0Pyk3H
         H+QQ1pO57GHs5ZTc9KY7wT7NJhEBXEGI1oFfwZkOPN3p8nyGGdi4Onz2CvXaEhjXvG2o
         i1iVdfG4zLuwYBtBDtwcxLBUtH8jtXKtW8j6PUnHaTAPDBQv7nB9KT/CYBUSybCytWdS
         5R1rMSNVZKV1IDWfag4D7nY8gt99IdiLcu7cuqfl4YbmQxoTdOq0BqsHDUAxw8GlI/p8
         AKHxXgoKEnAS0lRAGDQl1Ks8aC/Hk5zHOQGXHf/qiBQRHHjIv3VUtPWjeCUB2j6H2OIa
         dThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3uB46e4wAC56usX3WUKxk/x85EKQRpS+HGXlr+AFs78=;
        b=sultUFF06lIJKiNagboGG4M54Bj2+qXT3piSSEoSUQee9j0TykBUJbJL8L/Lm1sKXc
         9pbktB9XbJeP+eP+Oq1KxB7erU0tyd/rlOBgKUN6qmGw3nu2mETrBIK9POtN2uBeO+8O
         W8oyoaE7/jyLa3YKQ66HwLSUTJpxxG1sP2Z3RBKZr/AehZCBP6woFvi5ctsogkk5Mooq
         vSGFa8gmnOh1V83sKwX0EtwvK2yxfSYGdrIlgugkY7OT1djy7vtKxGY71KPyh6DoQoUI
         FENIJy7H8C2e6bsJTx0LuJJ7INglyp9QkLdPFSxCofW+d+o0u8Ho/eMB4ULpzeX65hI6
         m7MQ==
X-Gm-Message-State: AOAM5308SC8E3ze+u2WeRgou2P+9MrpvqH2Z+8sT6HcFenCnOGT73NcG
        J2s18Ynx26ScxXHIjwL0cbQ3y9jRUfvi9Lzyncv+zwlMnV/JX1qpsTlP0wIMkg1v6I5gVdGzdup
        YGlw2zUKd5a3yL4Os7kE5UmegRXxS8/AcfDmKL1qD1fycTTwVojwczTyNl+yPsRXNeR0RAhVfbV
        nS
X-Google-Smtp-Source: ABdhPJxZufL0FLCa1nP94j0R0ReBVMs1StU4nvuPshLa7IpMwPPeAjel2pxxN/1ipfCuCSQdF9VTXUUWYCXh
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:7444:: with SMTP id
 p65mr1547915ybc.57.1604558460074; Wed, 04 Nov 2020 22:41:00 -0800 (PST)
Date:   Thu,  5 Nov 2020 14:40:34 +0800
In-Reply-To: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Message-Id: <20201105144005.Bluez.v3.3.Ib69ea31cb69840b941b725a1d889473c5e6cac97@changeid>
Mime-Version: 1.0
References: <20201105144005.Bluez.v3.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v3 3/3] audio/avdtp: Report failure in disconnected state
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

A2DP are relying on the disconnected state callback to do cleanup.
If failure occurs when AVDTP are already in the disconnected state,
we didn't make any transition state, therefore A2DP would miss this
event.

This patch allows the transition to disconnected state, even though
we are previously already in the disconnected state.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

(no changes since v1)

 profiles/audio/avdtp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 4c39088b8f..16fa20bba7 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2612,6 +2612,11 @@ static int send_req(struct avdtp *session, gboolean priority,
 	if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
 		session->io = l2cap_connect(session);
 		if (!session->io) {
+			/* Report disconnection anyways, as the other layers
+			 * are using this state for cleanup.
+			 */
+			avdtp_set_state(session,
+					AVDTP_SESSION_STATE_DISCONNECTED);
 			err = -EIO;
 			goto failed;
 		}
-- 
2.29.1.341.ge80a0c044ae-goog

