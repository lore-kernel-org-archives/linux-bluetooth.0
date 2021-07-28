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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D63C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A40E6100A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhG1NPr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhG1NPq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:15:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC0C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:44 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id hf7-20020a0562140e87b02902dc988b8675so1935502qvb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DL2MaMzk+eOHtADn15C9fhPVEM1UNggN3rQz3EprNuo=;
        b=UvVwgLLGuSf8WTxOLfrzFlirzPZFI7kajuwabmBftKk2/oIIKT7PMRId1QkEB+TncW
         0I190KLwUNdIlTYJkW+eSv3nujzIsWs4JxwGzMQdtSdiDGN8yIJCcYQ4MlKYmT4LLu9Z
         vRYiQRmF4s6hJCAftfpG0dGhGd4YfiL8qOqXEv4Pk0NP1KgUwYhRTdWiStVub2yGWDPi
         bKKxpVZVdtl8XY4YZzWEcenXz37LHr03lWz+IVvqSxEzUEY8OKCmS9Z/N7aeE6TkNsFh
         JKQLZsosMnQLXvCaLb83HgM4wiGeeG6pbXtFf05+DpqisxH7yvgabtYSJLM4DW/sKqlH
         glLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DL2MaMzk+eOHtADn15C9fhPVEM1UNggN3rQz3EprNuo=;
        b=jn/MzYoOyYvkiu3Hiy82b0yaEm7Qlc1UFgqlf3nIRDQXXnPZO4XYeIfw0hmFjZXqPL
         zLnTW7JZ0y5XXNYj/nFbSnbBMW2HCuDYZvrgtFzrkHCbJLPa3PhhZLQAQMkfNFJHA9pC
         RMgOTWrwraiI5LRsIIg55/PkN+s9MDV2X3cO5gE424pMk7zH8KFFNGVl5d7atwSTrP2Z
         O/2O5OBJjEBFUq8OT3+VJbVRB1tzjHcQmEjlW4zKW4Un9iSzEhIP4bQYmWFlDPTw3ada
         b5ISTjcsY7Knuqa+6086smxv9er1DxfUwEInKJrVby41SHcaJ3Sr6rSz+lk0inC4PC7y
         G3FQ==
X-Gm-Message-State: AOAM530ScCVX0A135UVCo4fwl3o1Sv1LDjxSkdpMHVPqIFF69dVVtdBj
        H7ElBfKOq79AMq0MGf5SixkHGHkg1eDiDW99RejQ53OwrHpH+Iyl1NaK9lCjRx+XPTY9LwqdpXa
        hg7jFatg/L1PmpiaRvSTWqKq52b5/1Y07vzabsr8a645magbiiPNfqgwwjXJOybju0ksh1pXcHO
        Rv5JgWyFb5rPY=
X-Google-Smtp-Source: ABdhPJwJxhFcm9VNAmMa/7nVT/tHuLi3nUoMBr2sNCO1jQl/Cj82/ke8OPoyu6LCFt3jpvjmzcY1lfAAyVq/Ulg2Lg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a05:6214:dab:: with SMTP id
 h11mr2771808qvh.21.1627478143430; Wed, 28 Jul 2021 06:15:43 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:17 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 01/13] core: add is_allowed property in btd_service
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
index 21a52762e..929d6c136 100644
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
index 88530cc17..5a2a02447 100644
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
2.32.0.432.gabb21c7263-goog

