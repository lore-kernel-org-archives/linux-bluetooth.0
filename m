Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A636C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4F260F23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhG2I5I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhG2I5H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73BC061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id c63-20020a25e5420000b0290580b26e708aso6077199ybh.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4I2iMbWQ21aFNoMQLxQWDUhc1iIIJegWRipWIi9tO9k=;
        b=Lb3vWrY0yGOlJegcgogBkMQ2S7wwRxTEVa05+wFMuBM4F9d+F8Up1RVK6bjdJLtaG4
         niRpZUNucUt2key+18LFhLJyJe20Luv6Anvdrqbq1yZ6uBgMXafyUY7mHdI4VSJGm6Xb
         q3VQzt0KyZGEHwUU3ET8aMOtwInHjrjrwgJRO7/6Fv2IdMWcA469skZf5H7LKq7+h93f
         iPpwGtgvjTNNMar6yskDXA5qgYt44uoAiQzYpmnSiER9WyHHwxrGXaLphhmQ/ksolpQn
         0NuvX1zK+mAAvFERcdu6piRDK5nDrB7+NGwSZ+sX/9E41bwfuRDhhW37Shy10pXOPCtC
         08LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4I2iMbWQ21aFNoMQLxQWDUhc1iIIJegWRipWIi9tO9k=;
        b=C3LFJnfgAEqJ56vdNeEnkop69AOkbw6zy4yP31pu7nzo5zE3I1c7IgPtrPM+SFY54o
         cdse1m95LsVm3O2lifPfFPlFVYS0oEFriMRNhqYg8Zpjn4OAioNgjQnKGyR+4MckUFY1
         6KLC28Z9/BK4+d9mtlrY7G1adf/iS7FARgiDwRDeiijnz8n9zCvWsxqT8a6Re7oF0P15
         bimcjmZNl7lx+SOmmVh2rrhKK9/iJD28Q6OyzNc7QERqyGuqmzs3XWJJtG+xkH3ysWX7
         IhakMWV/yju8WzAnrUjiMED94drpQmeJyi2zwnrRqyZLol/gphJ/c2eUzvr9NtpyqE8g
         0eaw==
X-Gm-Message-State: AOAM532owWnJF8l4M7I8hSrYDz9EzCDTFGxC1wooQgA5KA0AYo/eqtAQ
        /Cl0lO2b7E7ugoJhYp+hP6TE7roRVhckNjlixP3yya20ruY6X432M2vU/SdO0TcxaHj//7TsbCg
        xe09xuAKsptekVaWkQtcoOoRqsHoZEeSClgaglc2u669UdWaCCKiSfDQmLAi+FDgMJTzFR/HM+4
        gxdxRuSwmHGcY=
X-Google-Smtp-Source: ABdhPJwwgj4PJSj0k2me3KO6nFy9k2E8EYl2e0X+D/G/GtYzCiSlmCNzd7iHMB3BBD1qrGMDOQLnnQWiTZ/p8alnHA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:d0d4:: with SMTP id
 h203mr5467424ybg.0.1627549023467; Thu, 29 Jul 2021 01:57:03 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:39 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 01/13] core: add is_allowed property in btd_service
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

Changes in v5:
- Fix compiler errors in plugins/admin.c

Changes in v4:
- Update commit message (admin_policy -> admin)
- remove old plugins/admin_policy.c

Changes in v3:
- Rename plugins/admin_policy.c -> plugins/admin.c
- Use device_added callback in btd_adapter_driver instead of listen for
  dbus
- Add authorization method in profiles/health/mcap.c and block incoming
  connections in adapter authorization function.

Changes in v2:
- Move bt_uuid_hash and bt_uuid_equal functions to adapter.c.
- Modify the criteria to say a device is `Affected` from any-of-uuid
  to any-of-auto-connect-profile.
- Remove the code to remove/reprobe disallowed/allowed profiles,
  instead, check if the service is allowed in bt_io_accept connect_cb.
- Fix a typo in emit_property_change in
  plugin/admin_policy.c:set_service_allowlist
- Instead of using device_state_cb, utilize D-BUS client to watch device
  added/removed.
- Add a document in doc/

 src/service.c | 39 +++++++++++++++++++++++++++++++++++++++
 src/service.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/src/service.c b/src/service.c
index 21a52762e637..929d6c136b6d 100644
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
@@ -186,6 +188,18 @@ int service_accept(struct btd_service *service)
 	if (!service->profile->accept)
 		return -ENOSYS;
 
+	if (!service->is_allowed) {
+		info("service %s is not allowed",
+						service->profile->remote_uuid);
+		return -ECONNABORTED;
+	}
+
+	if (!service->is_allowed) {
+		info("service %s is not allowed",
+						service->profile->remote_uuid);
+		return -ECONNABORTED;
+	}
+
 	err = service->profile->accept(service);
 	if (!err)
 		goto done;
@@ -245,6 +259,12 @@ int btd_service_connect(struct btd_service *service)
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
@@ -361,6 +381,25 @@ bool btd_service_remove_state_cb(unsigned int id)
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
2.32.0.554.ge1b32706d8-goog

