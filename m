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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68337C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9BB60F23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhG2DNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:13:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4AC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso2936099qke.14
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tX8Do79SScMCWREDbAJxEEnKh7sMJKvr0rNJ/ZT7ZKI=;
        b=Sk6dyu6Z1PhMgMIvHviXqigpWaUQn62zwSxxYTJ9SZcc7UUzXVi2Awwm45u4SfVkvx
         pvlkVSikspIvGRuD0URJ4sV1uNEjtyCznSFRMSj9+aHj+ruOUCGdKuv9HUF1gtgL+PPP
         dyuHbu2v1bscJqKZRQ1oyD2GvmgFb6ShCOXSI8YkbP168emi4ztYVDmkmgN1tTxS2DWH
         PefGslX0Kh3kjnWil5PfoJ4EqP5sM0qUxoJrSU1M5eqo0iqZtTGVZoK2j1KKLUK5Nb2g
         1w2aPkb29/ptc1FbXxYtGk5CUCPUDf3jOHQTWbGba6iBCoTVYO2W5awtL5Gt67g156Jb
         k+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tX8Do79SScMCWREDbAJxEEnKh7sMJKvr0rNJ/ZT7ZKI=;
        b=fWCZ7N58ruioiM9t1hvvOj/CDVlqHdSlKPUdci3dE9hUxGeLQBz32a7HT33cAvLw0T
         AVZSOVSb9FQcV6Wcyk88p9J/qYMglybrRynDKzfGfkHycFN6ajQpPaTKw9MXHH5bJ2Y9
         KV5WkJYAvIr86Sg2a2XOH/k05z4WFsrefPS0+OEd33ArBRDO6uW1U2ptRAgWJTNwLrUy
         mxQMG7+rhs7FJtCT7/Po9F8Ez+zoB78ZOJBSCv7cOBd5iBS/l6XsskJsyC1zgNmtoLwc
         YaL6JjKMeVsjQCsfz5JaBcTmihSRm9leHkxvV/PLro0wx/QNWky6XoHGM8Mdh7nVg+36
         K3WA==
X-Gm-Message-State: AOAM5315Z38mxS//UrFVOOSIYyAXzkrZSsATYydwPsIAxeaWAeeJRF+9
        oSWP+amS1YHiUNe5IWNJKokaaqTPGyl6moyZty6+OOngc8w+ukAu4JYW5zn+79VgB1QwA2+lxo0
        77YFnUrXhbKOPlWR3S+jrlZCxgquyuRY4GEoiO/z8Waj4Wx60cSv3livK/CW9NQYWkgJcED6fO3
        y10g+TxLp7lCY=
X-Google-Smtp-Source: ABdhPJzT9psZFfMio3M/afqfriGWDqBTPzBUu1mQCJvLuwsHPoKdy/yQYz2N3mCG+3Z4/qHZFfbculZOicv86YNOpQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:e83:: with SMTP id
 hf3mr3271930qvb.19.1627528408461; Wed, 28 Jul 2021 20:13:28 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:47 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 01/13] core: add is_allowed property in btd_service
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

