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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67425C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF5461059
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhG2I5D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhG2I5C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:02 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F8DC061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:56:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w26-20020a05620a129ab02903b9eeb8b45dso3420981qki.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L7MblLuSrbsDGknoKMFU48tI/k3+p9nDFuXCQMLTjTI=;
        b=rYXSiq2EkZOOw6ARZzpT/N8pRWzodPMsraVi/YHroI3O9xwGloBY6HMmS+EvhcnLDq
         xdEHnZRnXTtfWkTRQgZak7kP306zIput7Ti1mhSN9f3VJP0H3MX1pVV12DOL3hxN8hmB
         LoDcl7K1vkdywTZmbRJpRfqlSL1qjkrti7FLfSd70DW+sUNqx4H7IN4XGRuR9ybL5tzU
         07SrCAgyVQzFI1nQyfw/GwPQSBSCjv7SfqWpwtcPFYWvK7pCT/OBSQ/6OqG4Odbo2WXO
         Ti7/zgt2tzeCdesMQRi7G9n6lBcuyLtoa6jqB9m0Wkd2HHqUPfgZ+aoEKWaxEnXdSBoe
         hf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L7MblLuSrbsDGknoKMFU48tI/k3+p9nDFuXCQMLTjTI=;
        b=RX4IA/vt6ybbAxX0zTKIG5mkrSnDs8IJxXVQvIvTauE0RxZAhJzehf+mTr/30gsdgo
         tFj1ry7duBR6Ubd6Kxpdw25qNdx8Fw6qU0mPHuLpyZfvpATBDNZ2w3EsRviMJiJq7swg
         m6M2YRuHeG8o634sqfypDUnxnxxwzQIK8o5kXZ9FusIdx+w4+vxoTBs127RUPcDITa7I
         /jby/+vgYDJxe2IGQwsaeF7pmDo3fOoioiYlKkAINTrsDk0PjIaz+ZThgJyLGIiTcJX4
         8o9WJjvDOitpBG0KlWmoVIMD+FpO8qEZbM8Kdosa1GDp/9DbH3HaXe3xwz4rrJU6IGWe
         Fy+g==
X-Gm-Message-State: AOAM533Pk2oa+8BTjF9r5Emg7vZYP6rDbXOxyx+zfHlbGft/jXqnkJPx
        p0+7ybp1vjEdiRFZfXRbVItcA8aNM2Psu06KFDW3zPmLqOSN+0uxdCvThP3uE6xGNqCyMJE0ozb
        9HMhz6xVTR04Q551AjbsRv+agjnImrHYkssrxkdfWJo4krlb01047C7tefYeICd4DsgLV5MYzMa
        xF2xNmBNg2mB8=
X-Google-Smtp-Source: ABdhPJyyo7KwNT+n/13JdLVFpxNHJtZ4XiQD9tB6/6UvtZOcmpF29cBpB1Sso8MyoX49WoQwIjpXBd1Qq4dcEvqKNQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:ad4:538c:: with SMTP id
 i12mr3926250qvv.51.1627549018014; Thu, 29 Jul 2021 01:56:58 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:38 +0800
Message-Id: <20210729085651.3600926-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 00/13] Admin policy series
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

