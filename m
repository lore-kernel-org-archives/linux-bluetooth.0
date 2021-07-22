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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AAFC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F4461279
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhGVGmz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhGVGmz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:42:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA2EC061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h7-20020a5b0a870000b029054c59edf217so6468017ybq.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=unuOLAlYGAjYes9X3seLt6Z+Aoy0/fCg70BicS4XsJ8=;
        b=jMgKusOKPfWO+/HZKZUX8MO/KQvSVI9AxNobNfJ+plBNHPjyBHINYSdcDVPSjSrXDJ
         KCBKNRPn6TCLq9e/l7DYOj7QE/V8fWJJNw3ZkO232wqTTs7H7uNncMtv1zlej+ONKY/n
         x8B2YHcQEnePU9nMqc09F0UwCmvzYMnKxw/y4s/VOxnVhJEzjSbliXq1S3FfbN7R2RZB
         JpZSeVyjcir4g8FCDjljKB33A/ommlCqQ1pHmZA24wpJCoWz8XQ33lnKmpJgpA9TmiDb
         4TYbdaZ5OoX1nupeN+lfMrLfRpEMuKdLX1rGDHbOqj1G2Zv2neOo0joAJ4xpm/7u/ls2
         sYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=unuOLAlYGAjYes9X3seLt6Z+Aoy0/fCg70BicS4XsJ8=;
        b=UqplosjLn6p5XRQOvpyHbF4zBqnDogSIiE/gwQCoaNbm6TqaLdgvHQh4kZHk121hnT
         t5ipw0MRsmSboIEW1tDmNdhFZ67Ia4lw46lrPAVUTMi2mva7wW/g0YiHV2jJQmQk14ak
         IrShs2SnDkDW4tNJWNmxe8AnSm54eSjJJs9du4PkLGRk/JPDz0p2QkpsDQMPD5Jn+yke
         G0bMQulyxzNSdICrVy1rcjAHTMydsikIHt+tJOmZdjAiHsv9R0TY6/RrcRLtjEewJfYR
         UZ2O60F9PR5ubVsW0mF9Edu63SXhJPO4LJijET/eMI+DBTqaDiiw8BBo8xN9A8H9VKh1
         HMlQ==
X-Gm-Message-State: AOAM530nKic5Ea/8RaO2+j2QkTVVxpQBTxp/s631zZpynBAV6IfEK7nw
        IACwGgCTE35FChDgXyWLGi+kopE6YixU4riy5MBInxSkc9ox0yPGPwT2mC9lcHN1VWgkIJVmtMC
        Tpevckfcz+ZaX8IWB/hJfRm4rnTX8epJGnZ4ZP+LMjL83omSMTYpBQ/8H9QYx6/kYBxL36h35Pe
        C24fG0cXrku+A=
X-Google-Smtp-Source: ABdhPJwTMH0u5Sk4WYO9qYtz7W198nGrhZUCRhmGK0OcKNJBjoRoEjzMHdNE26tvguInNMeYqNxinisDXFu+uuEtGA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a25:ac90:: with SMTP id
 x16mr49112067ybi.316.1626938610032; Thu, 22 Jul 2021 00:23:30 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:11 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 01/11] core: add is_allowed property in btd_service
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
2.32.0.402.g57bb445576-goog

