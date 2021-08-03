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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8CFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9254160EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhHCLnn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbhHCLnm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:43:42 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0677C061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:43:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d10-20020a170902e14ab029012ccda38630so862617pla.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jJr8Pj0oZi3uk1UfApDjJ/uA6UIySU3eGXKkrZPI+TI=;
        b=uY3eSxva/IshEHaeLnV67BRybKCeU4uXYg5AytfXon/vo9mPal1ALKBvzz1oO6xbEx
         DdK6LlA9XSU+1uYHVI1WOLtsx1l7T8X5X9Y3Jlr2FYGPQSO5rbcDRRiuIS+rCtRotoNl
         H4YoqMrzxq3e5ggHT+aCQMnVmhrdciFXvxf5NN4oFzWioaj5HdIvyVumYvLx3Rt6Rkmx
         tndv28Lap/7hG6AlrTlNed0w4VI0XCg7t8rQ/NBaFl208eGTeRcjiWET5fg8PWNPvf5D
         Tf2ZhHvgB44xuq/3ihiznXEa5eHpaO22OGjH7RyoMSYYuMvZRwjCYlmotk39BBXoLc04
         1huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jJr8Pj0oZi3uk1UfApDjJ/uA6UIySU3eGXKkrZPI+TI=;
        b=hp73+MemdQ4EXQOj3hvY+r8TBrMHROo2JiEoILH6Wx2+B9AaYOWNXhczsB2kcS3LWN
         aZMtzqPiTL1BghJPKBkINQc/KxggJMCXwM36PACLEsf/Y9NrjPYYGTwQU/Iqpuq2h52D
         DWM6dQjEDTMkFGc9LKoEnfySwLRibcA7XRNenwuglIlZIyFGEBl5eAjwarAIPDGTYoMn
         QtlE/xnBlXrk0HjOwhFfvzXvCSGYgk9MiESKGX3RIx2CFi0iL+CburMlBtIEXtqEaaB6
         EWgrENjrKRm4/sVmeC+kv3gQnQRKKcsGGvkECapmWOUYrMS42+/4G9DTO5USCIpk6kh6
         8nMg==
X-Gm-Message-State: AOAM532VB4+R2fPPcGgBLt2lGSUSi4iioqZnGkU5lZ6UGLOVucDqxfUE
        9bZzBBUBXAvmBstQWvZ8LsvYxzICQBzvF9RWjAHzcO71pXb+R8Fm/14UUUuZitcbClan5uyFaNS
        i4HyvtoIjPK3js1Qr6Ujt3NsSgbdd8H/OHxtohgfS/zwlkDDeqeip2ByU1yBJKMioNvl9Hqz1en
        XjSl3n5PcD8HI=
X-Google-Smtp-Source: ABdhPJwD9TqM8D8ycgJQZDG7+vRcmM1AkeJdN+uhfhh1/4UR3Xixr6/gEBpjwMg+HyweZ9Xl3bUgRtElF0heW1kjaA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:aa7:93b1:0:b029:3c0:a7b7:3db0 with
 SMTP id x17-20020aa793b10000b02903c0a7b73db0mr7306717pff.40.1627991010165;
 Tue, 03 Aug 2021 04:43:30 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:05 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 01/13] core: add is_allowed property in btd_service
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

Changes in v9:
- Fix gitlint error in patch 'core: add device callbacks to adapter
  driver'

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

