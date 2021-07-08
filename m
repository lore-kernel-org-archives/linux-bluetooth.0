Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69A0C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF8D619A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhGHG0G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHG0F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ABBC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:24 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z13-20020a170903408db0290129a6155d3cso1532823plc.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YFixJM2ZWMumL8lKOp5J/gSVJQ/tiWfJvENUmr+ZSKo=;
        b=ahvNaCq+N51VxJ/V9NfA4CAMopNamdg/iz/NhH3G+OFx4eFHpaY+xtUOfnmwOK2tKi
         NYbxbNeHyx4aL8KwyjnsDb/WN7hiNkJ2dDd+jMSNuMkYkfvMC5b2KCW/MUx87+VnqsTR
         5uuBsZ81eozuNSDcRy75Ofgw7r6yLXK5rjtephMKkxo3uk9RlaJpX1VLUbnTzABWvW4v
         CY0UdJ+XeZIjO0rKQO3y7QuYCW0Cwth4pC9xwXX7zvlJdJt8/nXkchPME5CqBnC1s95x
         w2UiBOsT3/aevG9JYI1TJVMIzUFi6QMkDnHokrDueAm+BuDan6jy6ymKVmy9ACA4Rqos
         i73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YFixJM2ZWMumL8lKOp5J/gSVJQ/tiWfJvENUmr+ZSKo=;
        b=a01Rn7252Qj3v+sWgSvsCDu5eDsdTWYUOa3MtGjk69AVC/dzNkfNTOVK1kv71ToXcY
         y1K3TPVjMrVW8aQN58HtloWLRdAW/bM6tGKyoTFp28VJnXU/karz1jGeP/Z3Q8kPiZvQ
         YMwNKwSxhiWITZSl0CcSPTVIP949rG9KKJsVCyqhpQMtvAcKwqKq4HOAtZRsXJE3sFi/
         OVQxmUZUT2IwXDFB3qmfy7xU+xmUaynQiSoIALjYVFo5Wk3Uv6BzkyUauCgxKaWRCIRG
         qqXA22UgrYFJtVheA+vZpdk5KHDz69DHt3mU+giSj/hRiVV3YYqP5EVrMt2rG7yFWVfz
         8oOw==
X-Gm-Message-State: AOAM530pZcLDYTEMyaTZm9lyEAdl+yR2oSwAfw0XopQmu6WZmmkxdKkt
        FTKYdoOHnN+4OvYZ7bktrFmDxEpYSN1KGzjXXNpCB1Y0rxZ2r4pqTdC9TYoveAQuuKr5+a8kcyk
        EjyP+Ese11u2wCvrIo4Khqb2zpJv7cKD2LWlCffso7ezTaFwBL2Czc68z03J0/5YxNY+iyaKuOi
        2537SVfGLX3Ow=
X-Google-Smtp-Source: ABdhPJy0jWP2m/+Ca9nTn0BMORwLNr+fTQAXWAnFh3ccUPSJ/6NAhTehV/sxolubfSqlzGZjHU57j9fk1E6WOjYhBg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a05:6a00:2a8:b029:31c:6382:983a with
 SMTP id q8-20020a056a0002a8b029031c6382983amr23605735pfs.74.1625725403847;
 Wed, 07 Jul 2021 23:23:23 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:00 +0800
Message-Id: <20210708062314.245754-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 00/14]
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


Howard Chung (2):
  lib: add hash functions for bt_uuid_t
  audio: Remove Media1 interface when a2dp source disallowed

Yun-Hao Chung (12):
  unit: add uuid unit tests
  core: add is_allowed property in btd_service
  core: add adapter and device allowed_uuid functions
  core: add device state and state callbacks
  plugins: add a new plugin for admin_policy
  plugins/admin_policy: add admin_policy adapter driver
  plugins/admin_policy: add ServiceAllowList method
  plugins/admin_policy: add ServiceAllowList property
  plugins/admin_policy: add device state callback
  plugins/admin_policy: add AffectedByPolicy property
  plugins/admin_policy: persist policy settings
  core: fix a possible crash when removing devices

 Makefile.plugins       |   5 +
 bootstrap-configure    |   1 +
 configure.ac           |   4 +
 lib/uuid.c             |  27 ++
 lib/uuid.h             |   3 +
 plugins/admin_policy.c | 599 +++++++++++++++++++++++++++++++++++++++++
 profiles/audio/a2dp.c  |   2 +
 profiles/audio/avrcp.c |   3 +
 src/adapter.c          |  90 +++++++
 src/adapter.h          |   8 +
 src/device.c           | 128 ++++++++-
 src/device.h           |  15 ++
 src/service.c          |  33 +++
 src/service.h          |   2 +
 unit/test-uuid.c       |  48 ++++
 15 files changed, 966 insertions(+), 2 deletions(-)
 create mode 100644 plugins/admin_policy.c

-- 
2.32.0.93.g670b81a890-goog

