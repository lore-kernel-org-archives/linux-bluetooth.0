Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FDAC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 04:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1B8207EA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 04:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="k8rnRio/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgIAEAM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAEAL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 00:00:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F28DC0612FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 21:00:11 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y4so2004987pff.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 21:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=z0eYPoeOBrp5E0yT01/cy3y5DSF+S81jtW2iN+6CTSE=;
        b=k8rnRio/W/28dqBVEpQ5A/DeAtFOaJ2sLOBxo9LUuUbY68mdS76p9inJNKlgBVJn9Q
         e6FhfzmghguaoFMP15Y7hM+tbBWAWyatNwXl6Zv47uqh1EBtANvs7F0PwGnY6ZaLGbXO
         thaihSUf+LYmV4NLcZxbgIKWKBrZk3az3Zzp2RC7W1cWQFXh92M7m2rQ0FWKdC5SLrwr
         rY++b9su4h0OWImc8+8K/lLbcRGQYoMItA/GXLYN/FWbbhp2EB6F3I41CogE/AhHkpnt
         koTyv8NbXWchHRspFnMqF7MkiDDtwKgEFzIaYY6fQHyLy3PEE3LDXn5XFP738RI5IgoX
         P/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=z0eYPoeOBrp5E0yT01/cy3y5DSF+S81jtW2iN+6CTSE=;
        b=iDbyZgHcNj9aKUFd2S8XJsAlQJHuGhJpmsBz0Jqf1Pku29sUB9PZEaR5sg/3+50onw
         O324OWZ/+pGZRmtzjwTYXJpEs/A0x2NuhzVrZo7u6GrgLuO+NTNfLPByMNf+2zuZndVq
         i3kYBTYTO7bbvT3sMHlHY11hOZYQS5WceLzL9QCanQpSFCXubV47aWG7llbMO9GvHzky
         ELOS504X2PQFWp8ZqzzMwpP6L/sfV9nysQrARqgdyxtep6QGmck7MseC1E4beMqE0w6t
         Zc+er9x1Za4CbE23OyLCL6kIHp/czQlJn4KhOV+3FyDY67acNemN0vAeulIT+BgVdpxE
         7ycA==
X-Gm-Message-State: AOAM531jf4wHMQ4NHM7W0L0W1cHDuE/310NFcWYGipMSt+qE6sITR5C9
        rMkMh7GpaHjk5yjWBhmLn2lQPyymjl/lRYlTYHXsG4ODOPcUlB+SeMr0im9gj5e7GW8iHgpFkLi
        YfgoiMYqd6v6V37tCRoGqnRaHE05xzU0Sl1WHYEe+BmWKl9KsOir/+jxzM21z3F1/x71dA7oE44
        uT
X-Google-Smtp-Source: ABdhPJwt56jPjdKVqqBgwAmOYq1rYPl6j39lJHkWzI2GtYTbATd6pc0ueiwNXq5A5HnOCOw4JyzVH2yDpm4f
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:902:8488:b029:d0:4c09:c0 with SMTP id
 c8-20020a1709028488b02900d04c0900c0mr100062plo.2.1598932810915; Mon, 31 Aug
 2020 21:00:10 -0700 (PDT)
Date:   Tue,  1 Sep 2020 12:00:00 +0800
Message-Id: <20200901115913.Bluez.v2.1.Ieeae14ab680eda03474551fdb7a0a020f950e9c1@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v2] audio/transport: Don't set volume if it's invalid
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Adding a check inside media_transport_update_volume to prevent
the volume being updated with an invalid value.
---

Changes in v2:
* Move the check from media.c:set_configuration

 profiles/audio/transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a2c4f7dfb..dd1c553a2 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -941,6 +941,9 @@ void media_transport_update_volume(struct media_transport *transport,
 {
 	struct a2dp_transport *a2dp = transport->data;
 
+	if (volume < 0)
+		return;
+
 	/* Check if volume really changed */
 	if (a2dp->volume == volume)
 		return;
-- 
2.28.0.402.g5ffc5be6b7-goog

