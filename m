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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5537C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E89420728
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 06:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSVb6eKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgKEGaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 01:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgKEGaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 01:30:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7253C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 22:30:16 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id b17so558636pgd.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 22:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3uB46e4wAC56usX3WUKxk/x85EKQRpS+HGXlr+AFs78=;
        b=KSVb6eKXDB9ua+A9M8/mPeequa1NilN1qmbKfuMZ7w/KUqTqttF3zl86Veq4B1FcEu
         BD8/Z/rrZ9UIFjQUj8aF8JUyJvKtBBkxq592ZfqMSjTMgHkc3ZqmiGQ14vVWkJ0LnJYK
         CYAh1Sy74vV/Nb6MzPNi2m5Vd/ivi8MFDIw6oKBFtzse25Yq0pz/R27VF5wS98bGp0zd
         9KzciXY1qGcksDqCsASVCElVVs16eUvXEsH73+XnfGxnOm9b0JznvRqHPIC91CMZpO1l
         P01v3H0831QjohgXHtP+uEXwc4/dcwH1emqNBti3mq4x7sLgxcyzbG7IJdquq4VmSBXs
         sDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3uB46e4wAC56usX3WUKxk/x85EKQRpS+HGXlr+AFs78=;
        b=qejgsjH/rkEwwTTc4NNgvptBK6utQ/fODRg7rx5lN+EfbWwHTkgdy0bk3sy3oaDtAS
         V0agLUdu2LTHHeqxsbAcbhkZJvdQq/1gmydQv60uhFrihhtBzAiI2O4MX08FD4OEXQZW
         j7kFr5LZMmRixnaN1NRLQ7bRJ/NMT+R7c9che1XVoYJqr0TlkDnEgGRGs7rlY+qJHSpm
         9URB1RCpuVlwFNMCMBT+dQ/pMyZP+7hG4dzChfSf7o1EMFhn9QUEMSl/4AyHutBTUpqJ
         0uUWU9LkheYDlYElWPFs464kXMe+oSCUbAeFtFg6rZrY+G+ZbQovPwbhVbWewSFyb+8v
         35cw==
X-Gm-Message-State: AOAM532UHDgeJgricSenqejkcXBb6xeAL614muAUTs+4jUYLj3oVJx8W
        NlD1dK/XTYt2rzUfsj3PoTX4w58NFUNz6hDvJIYO2xMkt2uE6lltfM++wUF96sInAI80ssmDba9
        JxPeMXx/C8WFD4algEjfMR1rFsZ5azuaM9RvUQYP2iZWpHoMJYSefQGxEl47cSnCo7fooZEV+e/
        mC
X-Google-Smtp-Source: ABdhPJzHswnnv6Og5ge0abEVutamk93XcF10LZF73Ukrz9i/Jfo2LKa1zIeqbfuqJOXo0OBdsGSV1g7RIQX6
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a62:fb10:0:b029:18b:823a:535f with SMTP id
 x16-20020a62fb100000b029018b823a535fmr1040764pfm.42.1604557816227; Wed, 04
 Nov 2020 22:30:16 -0800 (PST)
Date:   Thu,  5 Nov 2020 14:29:53 +0800
In-Reply-To: <20201105142838.Bluez.v2.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Message-Id: <20201105142838.Bluez.v2.3.Ib69ea31cb69840b941b725a1d889473c5e6cac97@changeid>
Mime-Version: 1.0
References: <20201105142838.Bluez.v2.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v2 3/3] audio/avdtp: Report failure in disconnected state
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

