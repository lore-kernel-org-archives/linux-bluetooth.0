Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A38C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25DE6108F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhIPUlo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhIPUln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 16:41:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03D8C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:40:22 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t4so4736627plo.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaTlYmrTZ4vigxHL9Yiu6ffVmbBgOdNv+JmqZQCZico=;
        b=RSq0v51vHmKxJSiC8RZdacoNnEXRvvqdCUJ5rd2h4rehn1SDK9RBcc3o9qbrCTvW+i
         Vq2ZnRfUPlqSaVKECXUmxsDXw7A4HSK6RSr0du5V4qVtL/JqadBkFMPI3bapOcBoxlLn
         jmD9dTVdqOtkXzd6DmM7b0umPxc+0ueoyHg/tijV7RIBFR3PLiL5wBLaZUUxNLR9M43m
         1HEUiP8MLOW8G9sQV4ZZgrpljzwxnbrVg8LsgoAYnPwb3CAfkcUStExLbfDH9ZMK/Iyt
         9pITobD3EOw+VGIGlbcJlrzudXDDHYOws4q+MvJ00cZWHt4IKzRmnJUVRa51Rqiv8fqU
         fXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaTlYmrTZ4vigxHL9Yiu6ffVmbBgOdNv+JmqZQCZico=;
        b=SCsaK9UHYm6N7APOtb0Umd7yWYvT5YYGJoiFnuYCrw0T0+RCFlODQSTHjH/SLiJ+c6
         z9iWk/uQyrhjPA0BFERYRChL15frKMJnSXQerAz+QHTO3eIY/+INY9VjQ/hAa1ipqAC3
         cW1TQAQ7eMVMu+rIUYUZCvozC5KIRNJh4ta+U5gIvjzWyQPxNW63/puIW1JuWeJil/Dv
         lJtMbDu+o+ENj9nszF/6bHn9G49vEmV730W+EK3xQ8RIoQXFtZx8bPCKdihttFov6BYl
         Axc4grgp1gfoWFYvMVE/Lb2gix7METRbyuyDroQD4Q9Qpcyjaj13KYmtxwUoJ3Ky+vN2
         iM+Q==
X-Gm-Message-State: AOAM532jf39omV0NiLQ4pH4YNhrt7nk6rn5slYvzgJSw47ybVP/+r/MN
        IMdac0qXDCFrUn2mRMDScYj1A3Q9jxk=
X-Google-Smtp-Source: ABdhPJxnDQksIf1k66Wj83wlxxixoyIJ7KFxOqxAKI5+pNsTc/0VyT9nuCR3OvI1nCwJMBYVxRsn1g==
X-Received: by 2002:a17:902:bcc6:b0:138:d3ca:c356 with SMTP id o6-20020a170902bcc600b00138d3cac356mr6301192pls.6.1631824821806;
        Thu, 16 Sep 2021 13:40:21 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u21sm4283355pgk.57.2021.09.16.13.40.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:40:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] service: Add btd_service_is_initiator
Date:   Thu, 16 Sep 2021 13:40:19 -0700
Message-Id: <20210916204020.118310-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since BTD_SERVICE_STATE_CONNECTING is being used for both initiator and
responder case it is no longer possible to use the state distint when
the service connection was initiated locally or not, so to fix this a
new flag is introduce to track when btd_service_connect has been
called.
---
 src/service.c | 10 ++++++++++
 src/service.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/src/service.c b/src/service.c
index 84fbb208a..14a4c292b 100644
--- a/src/service.c
+++ b/src/service.c
@@ -42,6 +42,7 @@ struct btd_service {
 	btd_service_state_t	state;
 	int			err;
 	bool			is_allowed;
+	bool			initiator;
 };
 
 struct service_state_callback {
@@ -96,6 +97,9 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 
 		cb->cb(service, old, state, cb->user_data);
 	}
+
+	if (state == BTD_SERVICE_STATE_DISCONNECTED)
+		service->initiator = false;
 }
 
 struct btd_service *btd_service_ref(struct btd_service *service)
@@ -261,6 +265,7 @@ int btd_service_connect(struct btd_service *service)
 
 	err = profile->connect(service);
 	if (err == 0) {
+		service->initiator = true;
 		change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
 		return 0;
 	}
@@ -343,6 +348,11 @@ int btd_service_get_error(const struct btd_service *service)
 	return service->err;
 }
 
+bool btd_service_is_initiator(const struct btd_service *service)
+{
+	return service->initiator;
+}
+
 unsigned int btd_service_add_state_cb(btd_service_state_cb cb, void *user_data)
 {
 	struct service_state_callback *state_cb;
diff --git a/src/service.h b/src/service.h
index 5a2a02447..fa930f985 100644
--- a/src/service.h
+++ b/src/service.h
@@ -47,6 +47,7 @@ struct btd_device *btd_service_get_device(const struct btd_service *service);
 struct btd_profile *btd_service_get_profile(const struct btd_service *service);
 btd_service_state_t btd_service_get_state(const struct btd_service *service);
 int btd_service_get_error(const struct btd_service *service);
+bool btd_service_is_initiator(const struct btd_service *service);
 
 unsigned int btd_service_add_state_cb(btd_service_state_cb cb,
 							void *user_data);
-- 
2.31.1

