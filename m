Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10068C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70EF60C3F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhHCLnk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhHCLnj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:43:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A24C061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:43:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a6-20020a25ae060000b0290551bbd99700so22643816ybj.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dnzKJiMv0Udzq9gGlj67AB4Clpgus0ypSbnBf8N7YG8=;
        b=bcWj2THFpBmlv3V0g1yjkFeJUyH5MQPtzJYrcrCmDmY5Sw6xtZmCLMkG9bZDjRQjXb
         0GK/ybt4DMGVq4ZPxoqcRy3DbIQVWJ/wgNBuAD1CU8mpLdM4VfzxMGWqjqpAmcOXJb59
         id4hToPwq71muyFhOIYeOoQJAhH8a6YgyH9jL3hcWze1XkzBvIiSp+o21T3qqabCl5XN
         2IjVABmlLVKnfzLW1+jM7wIyTuquzshPv3infr1KY4hzB5c23R0Gmvx7W+rTpVaAy8V+
         MUjUw6uQgXOp3pgcvnzO00DYP1Z0rda2jFZ10wtRXTCsRNTiA81kCZsf3jKWitOWBUbE
         gOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dnzKJiMv0Udzq9gGlj67AB4Clpgus0ypSbnBf8N7YG8=;
        b=q8/a6ao2r9pkf9SDkRKVv/841+1sQ89Pra9rn7h3TXpbJd6CK3HdeFwQbomxCPvST0
         OjsN1jQ6axQWegc7KRMr2UTRLQHhm9UQjsLYUIToKpbE5Y7VN8DwYaapVXlj4JM73/yJ
         A0OIlKiXyed0rfFjxZ+HGVhsrVGpA+G/AAwSMgvTOoB2LLl7oE/ZaxTEKRY4zsID5w0x
         lZN39+AWq3hAG1lqa4jzNTE72GS4Keib+btbOXs4qpTLIo/ulVLKWS9G/AeXCXEe3PG1
         /MyLSTnsrsL9X1G1W2gHCgsc5hsXdKsDYOoJgs79dE7uxCK+6lp/AUc1/30XCm09klwq
         xHlg==
X-Gm-Message-State: AOAM530hIiyA2iykjo3DLVx1DqzjJ/X5muIKWiqwdQNMmFmxBdAak3uN
        +/JoAsOhs85nm8JQIWUZCI2kw0ObCv5JYEet2IQSWOyrwlqXjYT/UHdg7SoYoA9zKiARBLhiMVR
        U6O3VUgRR81bheJsWTd0i0DpjsLb7GcvQGblLRTnTz9MU82qi9KxOZYiUrzxiCMhf/O2MdBeW9M
        Nc4whcIZzM+sE=
X-Google-Smtp-Source: ABdhPJzZ3DFu/517puK2AYHhqyjDduqDL8XON9NQSvMJMs1/JhP+U4JHU8xnlUCJIWqZV1lwM1m+NoUAzVnS1ezD4g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:186:: with SMTP id
 128mr27432012ybb.434.1627991006327; Tue, 03 Aug 2021 04:43:26 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:04 +0800
Message-Id: <20210803114317.801840-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 00/13] Admin policy series
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

Yun-Hao Chung (13):
  core: add is_allowed property in btd_service
  core: add device callbacks to adapter driver
  core: add adapter and device allowed_uuid functions
  core: block not allowed UUID connect in auth
  plugins: new plugin
  plugins/admin: add admin_policy adapter driver
  plugins/admin: add ServiceAllowList method
  plugins/admin: add ServiceAllowList property
  plugins/admin: add device callbacks
  plugins/admin: add AffectedByPolicy property
  plugins/admin: persist policy settings
  doc: add description of admin policy
  doc: add admin policy file storage description

 Makefile.plugins         |   5 +
 bootstrap-configure      |   1 +
 configure.ac             |   4 +
 doc/admin-policy-api.txt |  65 +++++
 doc/settings-storage.txt |  20 ++
 plugins/admin.c          | 590 +++++++++++++++++++++++++++++++++++++++
 src/adapter.c            | 169 ++++++++++-
 src/adapter.h            |  22 +-
 src/device.c             |  65 ++++-
 src/device.h             |   2 +
 src/profile.c            |  11 +
 src/service.c            |  33 +++
 src/service.h            |   2 +
 13 files changed, 980 insertions(+), 9 deletions(-)
 create mode 100644 doc/admin-policy-api.txt
 create mode 100644 plugins/admin.c

-- 
2.32.0.554.ge1b32706d8-goog

