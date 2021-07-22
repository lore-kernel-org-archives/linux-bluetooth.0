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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52EAC63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84EF61249
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhGVGmw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhGVGmw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:42:52 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B884C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:27 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d9-20020ac84e290000b0290256a44e9034so2882160qtw.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AblpCmnKzckPdtK44G8+vJzcvH8pwpD8NBRq+/0+0ak=;
        b=Fv7RG/nhjzg1BKDOHp46ELeyciHTQce/32Yrdua8669BegBJgp9/rb46mRGACcHSsU
         /OXm5iq2ThABLNeFfufVwHj2cChs8kU18Am+GJAGeQ4lmysujKBmGbwKmBZ7/PRnhk9z
         4a0ZP4W2Eopl9fHjIK0R4RETHkZhlWOYsQWs8xwVCb9GnNHyenXF7rZ02UQVMnFxxald
         DAfYk4Bmm+jZp2ocXTtFI57dtTMKKFfgwfov9QVsCRosT1zFtMbYzJen+5BuuLT+CqX0
         jicUOoBknyRNRzvfD4q6kWYdiD4OeZ5QnmqXUm9cUurn5juGOiomBJ+1G9eW2SVgbpiA
         zOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AblpCmnKzckPdtK44G8+vJzcvH8pwpD8NBRq+/0+0ak=;
        b=ns2Oan7zahb8VllbtHFhxFuuKodYMySIBW60t1urAS+J287AUNvW7tptL4agFnB1xo
         C9+Gm46fcqysdUCZSm4zzlVdD+LPjMgZ9zLCHKJRD630XJJZoZqwawYpQ8qwCZ6/xDWm
         kqUVYhpPqVkJF/y7z21yA1B8VD6cac09Td1+7Gw0gCtRmLUev7nal4UN+Ch+7CsKbFJ3
         Z9W7JMWGDLjGh3GAl1GoOxB1swnRwFC2CG4bRTbGkUgdWjgWtgoBPIjaFc38aSZPIRAi
         DbYtSPFQw19M4BndrsalKClPBQMDt6j8/i4b3cMeDiiEFzuRQqWDteBDsRd+iT4vMzJD
         dNdQ==
X-Gm-Message-State: AOAM532Mr3qRfkSGwbILb/p+8BmU+Z4YNv+1yXnfv5hBIpUO3Hrc04wN
        +wFq/na6Sv9iMKvLZziTWc/+LsP5BBn6R6GUHHtod8bIKgM2xdwUwJT+eIKgs/FtS59MXHdTd+V
        TZ96+dCkQrFil0q6iuDTnKh7No6AKJDPbu0C+eLioT79GtW/U8vkuYWlp8wkmIUfsxrNRkVjloY
        BEjApE3D7oYzM=
X-Google-Smtp-Source: ABdhPJw89dxFn7nV0Vv9hfyD7LfC07PhZNVI/cvwx1HT4mhgkJ9EE6qk4in51gCwD3LCekYBwuHmpYtCu+Y5CFw12g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a05:6214:20ac:: with SMTP id
 12mr40004808qvd.7.1626938606217; Thu, 22 Jul 2021 00:23:26 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:10 +0800
Message-Id: <20210722072321.1225119-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 00/11] Hi manintainers,
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>


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

Yun-Hao Chung (11):
  core: add is_allowed property in btd_service
  core: add adapter and device allowed_uuid functions
  profiles: ignore incoming connection of not allowed service
  plugins: new plugin
  plugins/admin_policy: add admin_policy adapter driver
  plugins/admin_policy: add ServiceAllowList method
  plugins/admin_policy: add ServiceAllowList property
  plugins/admin_policy: listen for device add and remove
  plugins/admin_policy: add AffectedByPolicy property
  plugins/admin_policy: persist policy settings
  doc: add description of admin policy

 Makefile.plugins         |   5 +
 Makefile.tools           |   1 +
 bootstrap-configure      |   1 +
 configure.ac             |   4 +
 doc/admin-policy-api.txt |  65 ++++
 plugins/admin_policy.c   | 653 +++++++++++++++++++++++++++++++++++++++
 profiles/audio/a2dp.c    |   6 +
 profiles/audio/avctp.c   |   7 +
 profiles/health/mcap.c   |  10 +-
 profiles/input/server.c  |  10 +
 src/adapter.c            |  90 ++++++
 src/adapter.h            |   8 +
 src/device.c             |  64 +++-
 src/device.h             |   2 +
 src/profile.c            |  12 +
 src/service.c            |  33 ++
 src/service.h            |   2 +
 17 files changed, 971 insertions(+), 2 deletions(-)
 create mode 100644 doc/admin-policy-api.txt
 create mode 100644 plugins/admin_policy.c

-- 
2.32.0.402.g57bb445576-goog

