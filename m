Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839BFC07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6445A619A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhGHG0S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhGHG0R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:17 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E5EC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:35 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f12-20020a0562141d2cb02902ba007211abso3379884qvd.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zfKJA5L1xFQjALWiYpGAANN9lAZTGIYlAjpH2h7Vxbc=;
        b=aKiT3o1iuWMqxvE6XmvC16ssn1NAWPpkASCy2k1GxMsPyZou/bLZsSpzYB1eAopwux
         X+IxGCh+cRVnfu5a1Gbw1on9zBzyqeGGp7yQZLzk+LlpaFjZ6Oi4h1fr+2rbub9thZqY
         6kfsAj5WJbsY8CzoplJyPpUTOd1azWxAkKsx/F7AgIx7Lz9niAfpAoz2ycXQibuVGsBz
         SioLcc8yz0CeJfxqVe4dRZMFaf4CVejziEZZ478XhPWMN31kcTYzxsPbfqViNwjLsHfO
         4Mn2w4YHchFcOuft3BhAHWI1w56ocYVXPVJp5RyqwgTWNhhXpLIuGC8dhGf3n1k51hBT
         iNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zfKJA5L1xFQjALWiYpGAANN9lAZTGIYlAjpH2h7Vxbc=;
        b=dBgxu28BoO8jpCtTFuNIrLj97yMh3rFlp4XncI8l/EeYapjfCrKwrc3SDAUpjTr/5N
         jYon65QcCBDX9oqc7gYexctU7uJs9E83FxVnSWTbotLnphA4jY4wAWulFXNO+ThFSz+z
         nUWSwx/kCxeVQt9188aTl3WU1TwEh+GL+YyHMySp8pj8NrTTrZtarxRs7KzPfV3LoOGJ
         t6k08sXxdShyFZECie5DLGoUE51zC5f2c2zCvMsb+04i1LIuTSm4D0ySUrlRTzJFYs1f
         RxKmQniQbCGpLWAfJAEyu2ArTW5ALI9omKfUPZHOGrlo0O9cXO3wmGgKv2M0qtkduy35
         lcEg==
X-Gm-Message-State: AOAM5300Ft0U4sWuIvt1rFpSXXLF9lJ84W+ISo3/4mzj6mQgB3z0n5lK
        wMHKfl/AFKxJ6kR8HmmndWisBhl9E1lOkrL5yZgGc/QmR5WqSuz72fQE/HR8oMJQdhIhXvvr/Yb
        CXTJjoZ1JOCj+p2qpge/XlmE/o2tLh/+n6yn6asAb1B4ZQEymUSpfDVpT+JpdkBqf3/s9gmQ4DC
        +68Uej2iyjzy8=
X-Google-Smtp-Source: ABdhPJzryXixkxENEmchADhzoJFqdKvcUnQ/vsIebLN/e2QuKGsVwGGwxIr9gegCrQ5q7DndA6w6KLJqHxjL9mqfjA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1028:: with SMTP id
 k8mr28426239qvr.13.1625725414671; Wed, 07 Jul 2021 23:23:34 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:03 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.3.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 03/14] core: add is_allowed property in btd_service
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds is_allowed property in btd_service. When is_allowed is set to
false, calling btd_service_connect and service_accept will fail and the
existing service connection gets disconnected.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 src/service.c | 33 +++++++++++++++++++++++++++++++++
 src/service.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/service.c b/src/service.c
index 21a52762e637..84fbb208a7e9 100644
--- a/src/service.c
+++ b/src/service.c
@@ -41,6 +41,7 @@ struct btd_service {
 	void			*user_data;
 	btd_service_state_t	state;
 	int			err;
+	bool			is_allowed;
 };
 
 struct service_state_callback {
@@ -133,6 +134,7 @@ struct btd_service *service_create(struct btd_device *device,
 	service->device = device; /* Weak ref */
 	service->profile = profile;
 	service->state = BTD_SERVICE_STATE_UNAVAILABLE;
+	service->is_allowed = true;
 
 	return service;
 }
@@ -186,6 +188,12 @@ int service_accept(struct btd_service *service)
 	if (!service->profile->accept)
 		return -ENOSYS;
 
+	if (!service->is_allowed) {
+		info("service %s is not allowed",
+						service->profile->remote_uuid);
+		return -ECONNABORTED;
+	}
+
 	err = service->profile->accept(service);
 	if (!err)
 		goto done;
@@ -245,6 +253,12 @@ int btd_service_connect(struct btd_service *service)
 		return -EBUSY;
 	}
 
+	if (!service->is_allowed) {
+		info("service %s is not allowed",
+						service->profile->remote_uuid);
+		return -ECONNABORTED;
+	}
+
 	err = profile->connect(service);
 	if (err == 0) {
 		change_state(service, BTD_SERVICE_STATE_CONNECTING, 0);
@@ -361,6 +375,25 @@ bool btd_service_remove_state_cb(unsigned int id)
 	return false;
 }
 
+void btd_service_set_allowed(struct btd_service *service, bool allowed)
+{
+	if (allowed == service->is_allowed)
+		return;
+
+	service->is_allowed = allowed;
+
+	if (!allowed && (service->state == BTD_SERVICE_STATE_CONNECTING ||
+			service->state == BTD_SERVICE_STATE_CONNECTED)) {
+		btd_service_disconnect(service);
+		return;
+	}
+}
+
+bool btd_service_is_allowed(struct btd_service *service)
+{
+	return service->is_allowed;
+}
+
 void btd_service_connecting_complete(struct btd_service *service, int err)
 {
 	if (service->state != BTD_SERVICE_STATE_DISCONNECTED &&
diff --git a/src/service.h b/src/service.h
index 88530cc17d53..5a2a02447b24 100644
--- a/src/service.h
+++ b/src/service.h
@@ -51,6 +51,8 @@ int btd_service_get_error(const struct btd_service *service);
 unsigned int btd_service_add_state_cb(btd_service_state_cb cb,
 							void *user_data);
 bool btd_service_remove_state_cb(unsigned int id);
+void btd_service_set_allowed(struct btd_service *service, bool allowed);
+bool btd_service_is_allowed(struct btd_service *service);
 
 /* Functions used by profile implementation */
 void btd_service_connecting_complete(struct btd_service *service, int err);
-- 
2.32.0.93.g670b81a890-goog

