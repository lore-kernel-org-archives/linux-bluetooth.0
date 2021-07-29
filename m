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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C86C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69636101C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhG2DN2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DN2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:13:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC078C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n192-20020a25dac90000b029054c59edf217so5403865ybf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IjbIcQQ6ZH9GwlsUK8fE6nVk/9HfXohVJuLMoNjGGeQ=;
        b=sa8kkUO8vnNC9+GxgHo8MlKorVAg+XiQgMXOtO+9r4zMU2OMOzQpdlylJMF5so64Gv
         wIE37Gs74Uqct9UMSs1NcSbBZca8o3tUj3v+EVZY1QGop2Mz3E0QiZowjeNmtMPXfTcY
         CfJAorLA4Vsq5uaI9QL76N2IOEVqzv2lV6qoy1Xptv+4v8W/ypMkpJDhwaLOiYm2USf3
         vqKDJSMaETzAbi9Nbfv+C3Sn3NuYzbg2wi+ocXZtxDg6s9RH+LFD5jCam0eQDLyB6l7g
         YEkK2rS7/DAFSIGKIVGwNHEyxYK5LW72G8ktxbNmHQlZT4SGgTlDx8yg04VJq6pa9QT9
         reGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IjbIcQQ6ZH9GwlsUK8fE6nVk/9HfXohVJuLMoNjGGeQ=;
        b=IkmLL/1Pd4yr3YISuL1ztKAaWL6T7hI/GKJRRfCE0ntnyse4fO1m9uw2yIPAZlJRDK
         ad0aGDR14ILKd3RBca7xUVtwzLYXl3XSyWX1hL0X0b9dtLUZmj3wYpkrtr2/SZvjQmX8
         m98ZQdA8SEp2+T5WR62EkDcnB1C+32IJ5Tht4QU8K3dz+Yned4Kkxqb5wIQmZfq5shvH
         hLZgGznbvFZH6sBbavAEcAHcbBG6OE8Lo/xugdaATG7ZjuMWaviFSQ0FZv4ec21B8DsD
         Zqcvkhw2Zddo4QtqNX48MP1LsIpcpIfOWmDjsWcm1fYS6/sWIMIRRwPuUGljoCMj0wxX
         hVIg==
X-Gm-Message-State: AOAM531hwiQkDyphJXvYZNIcCS0u/KYMBdL9n/hgiDHWAMfLo9LKditI
        /cJFaAl4eSHmH2vTHfDlOHeRFMVUWIuHLknovECU0Oa7R+HiK7lEB5k4ryCD9cWfE0ihe2+Su52
        D/6cyhxUJz30tOfyK3lpGAtGftDJ22a3BzpxztSYWVEO9wHAHEEbpn5W1D61a6YPHavc+weFngR
        hz7Qa2gi6IymM=
X-Google-Smtp-Source: ABdhPJw/HimzDSmHEzBsZYqDJy/QauY4jRM5a952U6AwTNyHKvgUEyzK9wf7Uy1IjoIarAyAWhy+YpUPyyaMKpDHKw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:41ce:: with SMTP id
 o197mr4073275yba.365.1627528404078; Wed, 28 Jul 2021 20:13:24 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:46 +0800
Message-Id: <20210729031258.3391756-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 00/13] Admin policy series
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
 plugins/admin.c          | 589 +++++++++++++++++++++++++++++++++++++++
 profiles/health/hdp.c    |   1 +
 profiles/health/mcap.c   |  39 ++-
 profiles/health/mcap.h   |   7 +
 src/adapter.c            | 154 +++++++++-
 src/adapter.h            |  12 +
 src/device.c             |  64 ++++-
 src/device.h             |   2 +
 src/profile.c            |  12 +
 src/service.c            |  39 +++
 src/service.h            |   2 +
 tools/mcaptest.c         |   2 +-
 17 files changed, 990 insertions(+), 10 deletions(-)
 create mode 100644 doc/admin-policy-api.txt
 create mode 100644 plugins/admin.c

-- 
2.32.0.554.ge1b32706d8-goog

