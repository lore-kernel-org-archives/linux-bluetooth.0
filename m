Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BBFC388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 07:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BE32225B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 07:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiHfAt9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKDH26 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDH26 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 02:28:58 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E719DC061A4D
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 23:28:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y11so20747356ybm.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 23:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VMs0RSuZYJWQYM2qY1Ay9hJIl+DoSw5tv9blGU6QQN0=;
        b=uiHfAt9BJ0NCbEzNQPhIL4OLo+7Tk8TzZ4R73OHHL/wd9avKZ8N8oJqyqdoqpHltHD
         z0d8cSfTLphmDhVDCURGsMfgvknt6y/3EhzdisZ5wnTbCguzAEOwiixj4zKdYhfXQV7v
         IY6wlMzsUtOblw2JiEnb7O1vXPE8TLzPFnId0eyegrWGKnYqqjlh7H6YASpuEOOnY8G+
         wENApKX9Fm5/AaGQ3cOqv9rGaXqb4XscE2lhVlpo9nC0VWRZX8X+i7tIq/vtKDniEEA/
         rlpPYrrnA5wJ++w//I0HyhiCGd7B4GbZER+hKwESq/DPghkcc9dZN2G33B4+jeKfPy2G
         rS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VMs0RSuZYJWQYM2qY1Ay9hJIl+DoSw5tv9blGU6QQN0=;
        b=fdHJkpxhgAwVy4crjI5GQXg0ciwra2cc+VtoFfgGSRiMmq0x2HhPYkqNSZPH5LE0Cu
         vJXkdXKoaO0P2UW7z0o87Yk/+2lV2Ye5XMnuaILbYRUwUz8FICgKDuZhNitSC3ZTm6uB
         /YvSMl6hgXGmq8qOupg8L+i4uATu3bT4lYoPgUeBAK7oJ+fEiphZTaYNdnhBXlYn3+FH
         kpVdfmEa/qywxQsO0k3i/G4bRMeXa+hjMOEV9GJqzu+R/AuexSbtLmzhi0XhUoVlJvpG
         CYcbHJgkV6YBnlynPRwTPG7CKlVUcWpu2ykKjD2BAlcfP4XHg/JbKSi1AkvB3f7Gg3fs
         ApgQ==
X-Gm-Message-State: AOAM532vRsARK526+DLBO35IlytDl56SuWArkMzJKxXTWtjMmT5Ftp13
        JF5FTOnS7TtgJNRzwuYbvO9BPyOWk/IHZYosxGrVIuLrsE0b4TA/fCSqttV1jbPgCbe4jlILyzw
        zweJZfI01e2gBaAUh9eRUis4MXRucgFwZhE6xP87BOnnZjk5297g8V8ncbc/82hW73+LKk6QvTQ
        dE
X-Google-Smtp-Source: ABdhPJxglpyt6TYpC2KO4CsIfV1AvL/yTLi6fLlIYdvGYNA/rqtZA77wk5PVihuJt/EcaBvCm4wVJaBtlV7S
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:2614:: with SMTP id
 m20mr33872111ybm.196.1604474937100; Tue, 03 Nov 2020 23:28:57 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:35:28 +0800
In-Reply-To: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Message-Id: <20201104133318.Bluez.v1.3.Ib69ea31cb69840b941b725a1d889473c5e6cac97@changeid>
Mime-Version: 1.0
References: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v1 3/3] audio/avdtp: Report failure in disconnected state
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

