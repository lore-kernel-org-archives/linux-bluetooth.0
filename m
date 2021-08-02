Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACBFC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF7160EE8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhHBGNF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhHBGNF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:05 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62DC06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:12:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w26-20020a05620a129ab02903b9eeb8b45dso8103469qki.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iZF+42747nTECmbQEpmwvPedWXQvvIZLebZREQolKd8=;
        b=RL1j9U2rF1GX9FKLq9Ffrw/6hA5vleXf4t2k/q5LQZzQZCg5xHPW/xIJFs3jp5wFJm
         yv1jNMi8STK8Kzc3CqPHc/Gpv2w+GCzYvKmQ/N6GKcc3sT8k6cuR+Q5f65l5f2EcTo0s
         qYrLoCjpJfp8ZHzeZXwswJe3li7UnHm6XcX2HLLOmfEg85+8HOeBOYURKWM2Hhg5f96E
         HqG3Cm+GtkAItYBYorm0nli5KochRe4a7WsGmJJ4iw4lADDDZuu1P2icAWta6l1OX+LR
         mr5xhwH6rD3Q+p1sv56G+yLYvGJ8c9CndfiUBgwV02b+8bU5+8hrgyP3qfh8eDvQT2kq
         YCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iZF+42747nTECmbQEpmwvPedWXQvvIZLebZREQolKd8=;
        b=dokgCugWgiRZsFgx1Q0ZsVc1nT7J5ncW/kfBlEtuLIG/w13QzunBNRKDeTccMlHKYN
         xtBWRyi+VkzFl42QzxWX3n4RdYuLbB91UBeyhRGSGY6XOZVp2200i3iG1IMnpfDuXp83
         ZV69YJqVHYbHcwuCdIvn+HPDx7LT5sKTu1KHPWDSbFqyeddEJPhdHTwOcZo7vWEI82Q/
         22ZZ573yW1xvrc6SleD7YMJvE9Y4AOg/Lb2+82Kkz2Wkf/M0oxdutQWtZmTHN4+ZH2Ln
         q+9Qs1wLsuaXIHzXgvxr0M4UrzqmmvUD9hTXnToZxzz9bAg87ioaVBvRjFBps9VXE9XP
         Vrpw==
X-Gm-Message-State: AOAM53370dg2pH3JfN2QAoKRIaG0G66RA3pK7EPPDRuRFJ7nQxtVrShc
        MBpv234Pyey8ubUEDw2/59Pt6/aCbAUrLiwQOA2nvPm34g0wqYXQmtiANqQ9zpNwIVoFrtNIdKM
        S0mXYHYO85mjKPM2T2kvuENK3xOd0KlPojufrUM+v1BlhfJGwusCVBsY+uoSsXkTDiZPISddCRu
        gCzZiTUbL+p/M=
X-Google-Smtp-Source: ABdhPJxUq/LZgY94Cvbg5tdySA2KUKKNyZGJ6Wsie0Wm9jHam7X4CSGhu0ibeqzb7hiO/etXbI84Oo6eLwNx8oZxRA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a05:6214:d1:: with SMTP id
 f17mr15008533qvs.12.1627884775474; Sun, 01 Aug 2021 23:12:55 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:37 +0800
Message-Id: <20210802061250.170975-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 00/13] Admin policy series
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
 profiles/health/mcap.c   |  38 ++-
 profiles/health/mcap.h   |   9 +
 src/adapter.c            | 154 +++++++++-
 src/adapter.h            |  12 +
 src/device.c             |  64 ++++-
 src/device.h             |   2 +
 src/profile.c            |  11 +
 src/service.c            |  39 +++
 src/service.h            |   2 +
 tools/mcaptest.c         |   2 +-
 17 files changed, 993 insertions(+), 10 deletions(-)
 create mode 100644 doc/admin-policy-api.txt
 create mode 100644 plugins/admin.c

-- 
2.32.0.554.ge1b32706d8-goog

