Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816CCC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7BE60EFF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhHCIXP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhHCIXO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:23:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B4AC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q3-20020a25bfc30000b02905592911c932so21542782ybm.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OOVbT5YcgiLknP6URilQ09xDcSi4CELWilzHcYFHxMs=;
        b=BCpH1oMI/O11tsENx+6zDrbqd8Edaiq0G2ejSJ2MVZfKzv68W9LioNvchAmPuq47O8
         Fpi+Ewni8jwtxFG2kJ4SzB8C/0Qh3LfLjIPEYal8e7ylCvimh/td8DcNiPP6twBxz5cc
         3zmudJWzc+0rG1cL9vqVj/mslWDERgbb2xl6668cW+bN2ZmaHZagF6bw5u2QehXtC0vg
         kNUtKrZ2vx3xXp66iGhcPloDzZk6sFVrMgpq8x/o7WgS1tAXn0oRgWVIYQgrTkIP2mdb
         56SQHxjLNPZYQgL/crL8g5Wayaecf/5ArqpqFyqMxgVFLkA+U+p6wuGcNHkIAAsT5eBO
         Ardw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OOVbT5YcgiLknP6URilQ09xDcSi4CELWilzHcYFHxMs=;
        b=H/y10vIv4/+8t2QPWdyiY+NFhjNzjINwBddAHQoLDSia4ZvYewvQNvl1FBnaEol9Ie
         CLrFApO9fO80JJpJO2VrRcZUKO1Z6IL7UPDo/a6U325utxcMxa0R9+VUsVo/F2s+/PEm
         uspaHsSvXED64WgiQ8h9ZKnRX0EDDwaJ1a2pBm81qlkNxPqRtakP6h4thE8wwQ25dfEh
         XlopefFQOkueWjZYSXPtFfepMaED0DsoghhcNZBP6cm0LgUe3VB9U2SGSQhpTl36B+83
         HW0iLUwlyIX3PxucNM9joy+nZcHGdXmc439uKZeUkLekJBXd7NQ1Ycq3YOCbSGEPLn6x
         VLTg==
X-Gm-Message-State: AOAM531k3phS7ByI4ZiANO7wI9DL3k64uAn7RelSQBs1RoGcUKUnxc3R
        IPWBeUT14CjYK05PT8xMIECFuLb+FE+t9GREHYkGaIUWm09tApR01jkA0mNlROeKumQXVyJmqte
        VndekhUFaQZLyk0UJl1KAp3mUKjQ3IGDJROdFBLbK4pyGrOb26z6EQvRQnHCPh+3dsOX9SioT0U
        iLVlD7jUDDR/w=
X-Google-Smtp-Source: ABdhPJxtMnhg1tphWUtbRrWRtcdG4HjkfJEkhkhwMo6H5lg1D0QMb+r4aefcVk9bFluKaOt/No/afnK25oHFPtawDg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:e910:: with SMTP id
 n16mr26123442ybd.226.1627978982215; Tue, 03 Aug 2021 01:23:02 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:24 +0800
Message-Id: <20210803082237.723766-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 00/13] Admin policy series
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

