Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B884160F02
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhG2M2C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbhG2M2B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:28:01 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE1CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:27:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so3718468qki.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VEMQAONCUK/ns4OQrWgAKRl16DjN80grN5a0+VGMS3E=;
        b=Gz4+pWy68tIxBOyPd2qR1kRWeREHgmHbFPNXfAz/cTJMWBlmzeB1xYt0Tctk2HdGgd
         CRrRmd1hD7loutNJuk4F54tmFDVBL3OgmLCclOBZeL/JLNXg3sX23aHLRhhpDJCxoYul
         3ZrF6ffZnWWEFiUixKq04Z9er67YmBHyyrs9TfsELTYH7mScyAiKpGsIcHQas3FbNP09
         wy/3MS0/TcYJuU4YY74y4CiaHQ9YYRQ2LECxwnxHH7u/0/dbgaV69a5UAzRXflIgxFbA
         LrACMX6a8BZ/etE48EbVWIWofyCLpGKK4z9ki32daDPGV3hBnd+cSbzhis361TF2RhHX
         wQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VEMQAONCUK/ns4OQrWgAKRl16DjN80grN5a0+VGMS3E=;
        b=aK/K2Svxcl3hZR+Zcd+M6/DvWXwJ79PnTLM66uSXs0COgEZQKL+Be1pUdlq4PMVF3k
         hIznB3A4WHYaMNM7U6OV1T+T8Tf3rFJi8/UMmyhQGDgIQNfU84pPa3peRMpZy4g13yme
         uq5ez0lKItptUJxNDM0BB8cC6UUmk11qVX9Zbg7pA4c0NBnYvoRV9Oz9ZCyFcrRxSlkS
         GuwDBT8XZ6o0NtRzuaTeE0RIF4jwOw9yqkMaob/MQjsuGZ0a32DYtBia3RCHsEkwOx4m
         yxfiaBeyg9ay89vCebWJrgj/qPKsmVcOo3gFPkaO7MV9oKSqEYb8P0LO0s9QKKpSnWw2
         zyMQ==
X-Gm-Message-State: AOAM531cXmnhJfnywhQin9v/X41BTQrTaekCcaeu3m4hJ4sHZZfmCacJ
        LAL1H5+4EmgYkSunH9CSEZupH6fWiXRpTv3wqNFJx9oOv4b4pIoxa+ckskFVJs7uE2UDFMHlr8S
        srwH18ASGBBK6TG5jH8zNzrX+URt1QIviuYkU3VoldL7llmtRKs0CvnyqLfhYdH8oxlVJYwaV3d
        W/7ht2mKPqWds=
X-Google-Smtp-Source: ABdhPJzLQVGnUAaPdy8xCizE4JlVQF7j2T1VKC2k+2SPfnEJbT+p0Mil7znPioRFlg2nXLq+T5dUL40uoOMG4Dx2lw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a0c:8304:: with SMTP id
 j4mr4973821qva.31.1627561677474; Thu, 29 Jul 2021 05:27:57 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:38 +0800
Message-Id: <20210729122751.3728885-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 00/13] Admin policy series
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>


Hi manintainers,

This series is to
1. Implement a few methods in core so that a plugin can have control of
   allowing / disallowing certain service connections.
2. Implement the AdminPolicy plugin. The plugin provides interfaces
   AdminPolicySet and AdminPolicyStatus. For each policy, users should
   set the value thorugh AdminPolicySet and query the current setting
   through AdminPolicyStatus. We separeted these two interfaces so that
   developers can assign different groups of users to these interfaces.
   Currently the only policy is ServiceAllowList, which make bluez only
   allow a list of service by specified their UUIDs, but the plugin is
   also expected to provide more controls over other bluez behaviors.
Since the second part is a plugin, it might not be necessary to land in
upstream tree.

Thanks.

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

Yun-Hao Chung (13):
  core: add is_allowed property in btd_service
  core: add adapter and device allowed_uuid functions
  mcap: add adapter authorization
  core: block not allowed UUID connect in auth
  core: add device_added and device_removed to adapter driver
  plugins: new plugin
  plugins/admin: add admin_policy adapter driver
  plugins/admin: add ServiceAllowList method
  plugins/admin: add ServiceAllowList property
  plugins/admin: add device callbacks
  plugins/admin: add AffectedByPolicy property
  plugins/admin: persist policy settings
  doc: add description of admin policy

 Makefile.plugins         |   5 +
 android/health.c         |   2 +-
 bootstrap-configure      |   1 +
 configure.ac             |   4 +
 doc/admin-policy-api.txt |  65 +++++
 plugins/admin.c          | 592 +++++++++++++++++++++++++++++++++++++++
 profiles/health/hdp.c    |   1 +
 profiles/health/mcap.c   |  39 ++-
 profiles/health/mcap.h   |   7 +
 src/adapter.c            | 154 +++++++++-
 src/adapter.h            |  12 +
 src/device.c             |  64 ++++-
 src/device.h             |   2 +
 src/profile.c            |  11 +
 src/service.c            |  39 +++
 src/service.h            |   2 +
 tools/mcaptest.c         |   2 +-
 17 files changed, 992 insertions(+), 10 deletions(-)
 create mode 100644 doc/admin-policy-api.txt
 create mode 100644 plugins/admin.c

-- 
2.32.0.554.ge1b32706d8-goog

