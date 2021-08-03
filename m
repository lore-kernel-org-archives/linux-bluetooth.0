Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489BBC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F45A60F70
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhHCIXS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbhHCIXR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:23:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E35CC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v71-20020a252f4a0000b029055b51419c7dso22025506ybv.23
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QmVlcdOw8a6YgvvWT/ZlzFfrtL+D2xy3XVjOy/2Tpl4=;
        b=mFTl+IXac+Ow+APOOQu0eP+vOE1cKDRLu7Hdsc6gEmSHirGkcpjC5XeAvMVzKnDOHT
         SbrA10nG07AxpCvKndcxFW+gBmtoxdfSFpvyqB4LvUBMpygcs0ipp1o3lb9Xt+0v6+l3
         7aZvjln6r5H0MNWXjHoW3vURJ0ZsMLcE0bjrDolhjhtVJgLaWV4mOrjPHsjrFv2wXUyB
         bOUTMneRt8GEFzv3Jhcd3E4eeMVdWVW/QpWZgvLFOXGmIozzccsd2/A1nsjL7xcZdwXO
         HfD2Lj+BkiFZUZZUupgAqg3cWdMQLO2zNfO5/yAHknOQQngJII4+thqfI2aOwFGv76+w
         hStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QmVlcdOw8a6YgvvWT/ZlzFfrtL+D2xy3XVjOy/2Tpl4=;
        b=ON29ziKMPB0KFKD9G5t+A3kfiMA2Ks9Qq5IX/IfWTLGgIgtucrP5gcELYWPhqHVHwy
         bfkKKu0T7RfmC0cpNd22qINPGh2mZ4f5TbsNfQIjT5S+ZwwtvFZ7iQl7EWbpROJzI3xX
         qp3rLtppbnxNO/WmMLoR9PzeYAWW1WHbq0acFBORuaNcowCcewft9cyNFl2rqZGUqYlC
         ZH8jtuNhHTh6I9frDpTuakIfCwm8aHP4H5TouYulrtJGqL++CJ7xmcRd41U1B2g5HwqC
         JJU1g5MrL/nZPVc25LTQsT0zziifWUykij5ePfp1DAd+xHXUbr452269ZncfzW1C24FU
         xohg==
X-Gm-Message-State: AOAM531AsxqjMUs079+fomSyTKIQeWeFZAehqsqabunKzBdgn4wdyRtO
        7LCaTGTuO7aEoeR9DNC1qbwVISzdwPXqjWBjBxdJMc8uFH/8DqQ1pxxhb+eW+YUYThY9no3O4ae
        sd2Z05AKq+Gt/rc+XoI7sFqdOcDQ+VEpeGycv39RGe7QLLMBlw2p92qb+ef/IA7KmnavNHtSWiJ
        WJbu0kcPOFqqI=
X-Google-Smtp-Source: ABdhPJxoZysNgWIK5Tw0yYk/AVVwin+6agGEfXckC7IRQ4fqn8xKnG+zGN16UB+qAW6LbxLjf+b0kDDfPL8SlLYfaw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:d642:: with SMTP id
 n63mr27799516ybg.165.1627978986205; Tue, 03 Aug 2021 01:23:06 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:25 +0800
In-Reply-To: <20210803082237.723766-1-howardchung@google.com>
Message-Id: <20210803161319.Bluez.v8.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210803082237.723766-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 01/13] core: add is_allowed property in btd_service
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

Changes in v8:
- Remove changes in profiles/health/

Changes in v7:
- Fix compiler errors in profiles/hdp.c

Changes in v6:
- include <errno.h> instead of <error.h> in plugins/admin.c

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
2.32.0.554.ge1b32706d8-goog

