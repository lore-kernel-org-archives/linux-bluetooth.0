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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9167C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 05:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7495A223C6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 05:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6o3wD3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgKDFfo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 00:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgKDFfo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 00:35:44 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B817C061A4D
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 21:35:44 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n10so12294022plk.14
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ej2iTrt9Z1IFwb0BU/LPIeKtR6sJNiV3QsPClggI+HA=;
        b=V6o3wD3awKWyIw0FPmznha1mkX9kLWG+V85HkaoZeC+ucTjgSWvxaPlNRNjAY3GYfs
         4vY6miGjVSevYhgZenMMOb175WkS1tpNg9lVkPGb+/QnKL5l1QLOInpeY+4KGqvyD/5q
         1hvxCbCPQtXhZLheHuVHlWphv4jJe1euBoO0Q3qr+JZH/hstsg1kT3aZoZFcmHBgUuu6
         UJhM0nAUTDj/QUKOxD7jZtRqj5F29wksU1EVV1ZW0XRmfMR6CZJtwWXL/0U+SBvt0lNT
         72XxO7mvmVsGmBW9LkIyKqSLiIteM6NdfPr+i5R02ncGeDmEkiF4UAhiIuiy78oSmKrG
         Qb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ej2iTrt9Z1IFwb0BU/LPIeKtR6sJNiV3QsPClggI+HA=;
        b=Gj/TlcMTVfmM+H8tr9THwzbGym6PExM7ffgs0y3sEUEMKw0D3F4foamxk3I8K3O1M5
         ZJLV0u7rM2MOjeezZdDBwqkfcaC3Ohn7DatgrmZ6z6EIajWGf3g8I/t3U/hq6TpROkcs
         kUTP8Gs2QlDg0fRq7VLmIyz15fJiZrBSYKQxHRGRizJdWz6nt+ND1NvtJUzzHsMoVByU
         Xx0UOYYLO7YW3yNb3xHbA23VKoz+zGgRrfnvn4pK0YZu6TLzoq0QZrK4s3ocCqPvUCis
         unISGekYqszrxqlXX7TdhabzQicY6p3zR+uCOCbLpjFaSVMNZPjG6xxfAQG8grWLLJJh
         rmVw==
X-Gm-Message-State: AOAM5306tF7Bd04RXYC/e4386M8a2wUB5cYs+uYQcv7a5ecfxSJN0YjC
        K95ySoCeEuZOS/kbXEEhhO+KZyceK89tVxmYJ5UhXrob6Hu3g4AjCHpTMjzCesTaXkgG2ob8/qn
        fx9yvMpon1anYrnxdTHAww58fxbeor8EXEwl71EPyypR6jlJC0F5e8DGguB4gIitEeEjAtQFZtg
        9Y
X-Google-Smtp-Source: ABdhPJzG5TYQdYHlC5/8RkcrIHQ+kLFviBRkE7pOo//ZyQcmzmqIF+40AtGA2L/K6GlD+9MyrnIdQt+dmla0
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a62:1a48:0:b029:18a:b64f:44eb with SMTP id
 a69-20020a621a480000b029018ab64f44ebmr16569409pfa.79.1604468143265; Tue, 03
 Nov 2020 21:35:43 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:35:26 +0800
Message-Id: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v1 1/3] policy: add checks before connecting
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

When policy_connect() is called, there might be a case where the
device is not ready, or even the adapter is down. Add some checks
by calling btd_device_connect_services() instead of directly calling
btd_service_connect().

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 plugins/policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index ba9e1be020..42b15cb65f 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -106,6 +106,7 @@ static void policy_connect(struct policy_data *data,
 {
 	struct btd_profile *profile = btd_service_get_profile(service);
 	struct reconnect_data *reconnect;
+	GSList *l = NULL;
 
 	reconnect = reconnect_find(btd_service_get_device(service));
 	if (reconnect && reconnect->active)
@@ -113,7 +114,9 @@ static void policy_connect(struct policy_data *data,
 
 	DBG("%s profile %s", device_get_path(data->dev), profile->name);
 
-	btd_service_connect(service);
+	l = g_slist_prepend(l, service);
+	btd_device_connect_services(data->dev, l);
+	g_slist_free(l);
 }
 
 static void policy_disconnect(struct policy_data *data,
-- 
2.29.1.341.ge80a0c044ae-goog

