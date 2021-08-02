Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D93BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02035610A7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhHBGNK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhHBGNJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:09 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF9C0613D5
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:00 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id lx12-20020a17090b4b0cb0290176d6de7ddbso15326826pjb.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MwKyfsGeyXVNrsYPJAEH0SWM5alYOreGZmOHvTcA5Ug=;
        b=uGn25qArrz9LcTTbcRcl+rkp7Cl1JYtooE8z1sQOQYg8KGhXWvsWTUX4LzPw0iOiw4
         KXYInAJ502hB8S75E+hYsMFELTZmfNQa/AvM7ocP4+xrI9UHxmqDNA85nANA9j3HUlm2
         IpFgmhKwcG4wVT782igN1osN+l7ga5nigLILIhcUpqMfE1XeIWntdSApHfLpGPGqSDCT
         G3We1+s9DBuI2EwCo4ui5CW75dpaJkagZzRED3cs/LqMwRAacDJbBTJUaWrGGPf6aukG
         j+N8i/TiGBYRSNeXy869pbxxgA0stMhZJ/xpknid703czTGQ9xb2Geow3yQztfqQOV82
         ZY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MwKyfsGeyXVNrsYPJAEH0SWM5alYOreGZmOHvTcA5Ug=;
        b=Xq6mmV0dbXlL12gy7qUbRoPGs+cqDHowE0s9aO6d1UTPekG7uKgUFFMUzqR/pcVWhA
         BfI6CAWUk11iDC6Yn4A4f4PFkHO8NhcA/RCOFM3IjLQ9jHCEr/mjmHbBrXes8zbbJTw5
         vvLj1ehT23A1OXy/8J6fKSmeOcc+8ev15Eb2NmtmAodIPPIDBOUuvKavVTdL1FVISpwN
         WuFoYYjfALpEkooPestlUSSIHeSbyEDnLNyq/8nB+SmHgnmNZrF0yo86qdukjy67uRj7
         ZWmWTi0Im9LV2n65dEeBCQoQOwb8vwu2VXeQZBPvuqnGjJYhEfPQVl7bK+/1KIKkpz2+
         4Fiw==
X-Gm-Message-State: AOAM532fWODcYidCII7iAAw6vdXh401FuewBWfaHL/JP9kfRGPk4jM4E
        nHvTpyx2FjXdEzK8l8nkNFBKf988eFBzDQErOHjN8bJmP3klQQs+KsvDcizwt3GpZ80bhEH+3mA
        7NcY7NPMv6I4hSf0E3rYjJ4fLobEkz+LUnYk8HgiToQFbwjX27HY1zws0plr4+urjaoRctx4lIA
        +4WRfW9SJpYLM=
X-Google-Smtp-Source: ABdhPJxaJBV1ifw6RAHMg8IygILeSGYM2WHhoTAqZyyouMkXMudYHK3w+IIsm0gImBNmTgxifpA4G6KeeYbyIJEZBg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:aa7:9e0d:0:b029:3a9:e8dc:2085 with
 SMTP id y13-20020aa79e0d0000b02903a9e8dc2085mr15438016pfq.73.1627884779301;
 Sun, 01 Aug 2021 23:12:59 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:38 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 01/13] core: add is_allowed property in btd_service
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

