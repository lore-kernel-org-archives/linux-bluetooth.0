Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D44F61207
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbhIPTFS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344284AbhIPTFQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 15:05:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DAEC0611A2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:40:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s11so7017516pgr.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaTlYmrTZ4vigxHL9Yiu6ffVmbBgOdNv+JmqZQCZico=;
        b=LphB+qkoHDaKeXGQSrVw2I3J5BlRjg4rGRSSVoVV5XrswHGAxFJTIIvJViVEtLUn7q
         u5FElLryVTvpvOmyPe+oD2CMIWeoaiFyaDYe3oNRNrT3QJ+0REHvEwjkh6zhecjoShLA
         u80dfH6BGmA1KHxmnhJZ/ospJU776lAUXoyt+qQoaN2TwAJwkOlBLisYkiJQuzvu0XZL
         mz6lQTG49yOm8hBQ7c92tX7p2VgOzut0zY7PPXR2nk9lJUnJAlYQ2smLEeO1BFzBN4Mu
         hSiGJS5WrYxmW0RTFxQKBrMLVc/2y6dtHE86kGynvYZk4T0cpTeyc24nAqM/b9MiHRjc
         rXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaTlYmrTZ4vigxHL9Yiu6ffVmbBgOdNv+JmqZQCZico=;
        b=EcOH6XlGqJH5ziZR/0QmNIrgijJSxNsu3SxKSm2BNejNv21TqvyVq/vIs6efo5oN3A
         tPltNBnmXj4BongKDb00qqUkcl+qzfLVi9laNUYypHe+TgFsyv5SxpFakDojXDIV4bpA
         bwf8y39Iw4BTMM3yBrYKOK988UDuxe31/dnA3JDc18nTDgdyKLZWovJFxG7MvaSq0ehE
         T1jqegClG/893wCS/34OouZrYw0f0loA/UMM+mHJj8kVno6p4x7FzZCZZbHInE0jddAk
         c+GSR/pvY1ZwxDUeCxt1sWkMdYsW5rEL7TWoDerthYcxVYRLr/VszflmjFiqDMdUisc9
         FjFg==
X-Gm-Message-State: AOAM530VTDzVI/JMFBUeXgCI20ZoYCRgydXKDQyHhXMay/lWa/QPQz87
        1r6MQSUxsMkAqB9gAwDkl2InvKOqm5E=
X-Google-Smtp-Source: ABdhPJwySHjOTunnT3lN2O702Vo10lLibaYoNlgKOzYS9TfTXyTCpDHBSVx0ybhSpIojzFZibIJ7Pg==
X-Received: by 2002:a63:6544:: with SMTP id z65mr6225927pgb.325.1631817622386;
        Thu, 16 Sep 2021 11:40:22 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f205sm2766717pfa.92.2021.09.16.11.40.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:40:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] service: Add btd_service_is_initiator
Date:   Thu, 16 Sep 2021 11:40:20 -0700
Message-Id: <20210916184021.83775-1-luiz.dentz@gmail.com>
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

