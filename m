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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F5A61019
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhG1NPm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NPm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:15:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF4C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x7-20020a0569021027b029055b9b68cd3eso2803388ybt.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6hWrRnNYi2s/+4xHmBf9CSF55NC5a1hg1KjWcJFX+ds=;
        b=lR6bIXF8UQllB3ebg0N6vfQ1+MLgEuS6baPh/Je6kwv+4mgzEVMJXQuQdkz1TQqVLw
         QkgdunjaxI9ZL8uOXKmlFdRf6VWJ/aROy5WPGBiuYSXh8fUPFqcGZ5Xomps3YlZTdP14
         SJVnobQ5cwiJhMYcvg9gv6fUDkxdLJ8fVGHMvSlZzfqcOjH7SlbsEnwiCIFVzJsJfm1f
         V4mq1Y6myiVU0J+UvpUTelgSqh5XOPVi4fsKmyHKLaKolILTASATvhQL1YtyAspuuksc
         xkDOCca7VSzqW3pniH3rCrXSeZWglWJxsLv69Y7pIzMnzGOQW7YFKtYPJT0p7yfn3tHY
         b/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6hWrRnNYi2s/+4xHmBf9CSF55NC5a1hg1KjWcJFX+ds=;
        b=i3r9Zws7EKcBelt1L1WcKk7qly4Ejr2OEp/zC1ftuo6vCEbHNyhH9n5b+ndH3ZeKAY
         uhDHmfb1BCR7rarGGzRx6V1WmV8JYVekBLdXBI1VhksItRU3NmY6RnfNISQHVkMSNaO+
         hBrZTiJtw/qrsdMxcdDXz8Ab5r3sZ2dnDXHsobwgLJ3CFgwK7L1iM6P4pNVbzBCMuKtD
         R28p5oIip9kg6WuaSsVPTl5xmkmpD+WJF02GPcWhUUta4Touhg9UHUSrmtc+xv5UV5wl
         0ASESWEgbtizcFf5ZmRNWyznYfXpYMdA0sY+5uYTtR1SKvJ4tHqRb112fovO2g5PsIr9
         dpaw==
X-Gm-Message-State: AOAM530YxdTNBDlOuiTxWgtfMQCa/8cUCqnRI9SW7150HrwZd+ldSWzZ
        1RFJtgaiGMGjhZd1ANx9jtkFCG1LKDaVag0ViHM/mQNA9DIC93WSphH4w0c3iSO8wRGFnYWk4od
        O/goq0DPRiqEP6T5HKqVVxMs+LeX+WmKZmbqOj+1d3Hw+zaQfqdhzcGnb4bSp7oDEAavJGfBbOc
        rxtpBY2FSfDdg=
X-Google-Smtp-Source: ABdhPJy0HomVArC1jyEtst9iObkgSL5I5MHU/wZm3fBFyeg9K3ShEzljxEHhgfA7zx0VLihjdJcFv0sStOgjctsxMA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a25:c5d2:: with SMTP id
 v201mr24955611ybe.409.1627478138899; Wed, 28 Jul 2021 06:15:38 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:16 +0800
Message-Id: <20210728131529.3310558-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 00/13] Admin policy series
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
  plugins/admin_policy: add admin_policy adapter driver
  plugins/admin_policy: add ServiceAllowList method
  plugins/admin_policy: add ServiceAllowList property
  plugins/admin_policy: add device callbacks
  plugins/admin_policy: add AffectedByPolicy property
  plugins/admin_policy: persist policy settings
  doc: add description of admin policy

 Makefile.plugins         |   5 +
 bootstrap-configure      |   1 +
 configure.ac             |   4 +
 doc/admin-policy-api.txt |  65 ++++
 plugins/admin.c          | 589 +++++++++++++++++++++++++++++++++++
 plugins/admin_policy.c   | 653 +++++++++++++++++++++++++++++++++++++++
 profiles/health/hdp.c    |   1 +
 profiles/health/mcap.c   |  39 ++-
 profiles/health/mcap.h   |   7 +
 src/adapter.c            | 154 ++++++++-
 src/adapter.h            |  12 +
 src/device.c             |  64 +++-
 src/device.h             |   2 +
 src/profile.c            |  12 +
 src/service.c            |  39 +++
 src/service.h            |   2 +
 tools/mcaptest.c         |   2 +-
 17 files changed, 1642 insertions(+), 9 deletions(-)
 create mode 100644 doc/admin-policy-api.txt
 create mode 100644 plugins/admin.c
 create mode 100644 plugins/admin_policy.c

-- 
2.32.0.432.gabb21c7263-goog

