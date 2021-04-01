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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD15C43470
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4D9606A5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhDAK2I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhDAK1u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D538C06178A
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y13so5242429ybk.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SGRhxAAUWsUnK57Aa5xc6CZnfRHteowX4OjsvjNaSZw=;
        b=jSRaxJED5wydHwLBE3dp4YyA+hBjmovkiex1Ldg0igKaCQR3sna0e8FagyV4gUZnNE
         L3OxaClhO6r3XaTs+lR29NzgwE2+tPKMBe0kMA1KAUzKuU4XpdYezh6yf6jwyjSg29kb
         FWKySt4hPsRK8tsTouIU8hfx0p2D65Bobx5FE3/DKz5MVxnOnJR/hDkkFPb0U5SOrxJ4
         0tNCMN/9QIsMwIZbld6xNmeNwCQe1/l1r76zG7akNRm4wn4sse8LL0Gu/YyrtdfZvmnt
         Z9R2OcFYyWCDsuaMeaFYeucjKE2C9hsK6ot2PnKGAsnTx3a56DXNgtg2vdLXaxIbcxJO
         aqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SGRhxAAUWsUnK57Aa5xc6CZnfRHteowX4OjsvjNaSZw=;
        b=l7dxe2PQ4akbxwLYP0VhbzuOCYKF2Izgl0SWK3sF1OY5a9tW0+SDnpJd3X/H+JdAAa
         +Od4oObp4jgy/VxYWVOO6ZV5AjiNjz3KLv0/maCFkee8cNJML3KgxUcEkHAAcsz7Jbut
         bvev5SHqeE1Z+kPjElQ2QlMcDF3Sb2qVCmy6j4gI+hfah1+c2eU4cR3f0x9e6lAHL50O
         cfwB0I8r87KqWLSi9tNGqhv42lOUBP7pHQFoa/GGQj7YF7jtgdbT19f76sETxJhdi/Sq
         hg3cm4dlvHVj9/9brqRBX2fmWIIMOBuoNldWBLK61kUuczerUbggo/3bRh1J7n29kZWJ
         PYeQ==
X-Gm-Message-State: AOAM532g6LmVCtyCG06cAF225isrvry2g2HoSpxJmR0BF1RCukIfWY6O
        ldDLopNoy/esC0tsO0qMblPpTA6IOTuOwtBvPF9Nx1Mybw7oH5OXEPooSr136g5V4u9N76oGZ6j
        S+gK2MPJtDBrMSorixwKn8Mj2/xLJxzVpXpOo+S2XZrtXqg7XP3L36rNSAg38J0YPSGyYJTG8CJ
        S776WrpD7jn8w=
X-Google-Smtp-Source: ABdhPJx2Q8t0T4i91r+fMB5yYWN9KUOMe7mGYDxxz/m44bSLgKjtJvCjB5Nr2Qd4mPRK0VCZ+UA7Hye/uTwSpvSZOQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a25:d451:: with SMTP id
 m78mr11430504ybf.105.1617272715501; Thu, 01 Apr 2021 03:25:15 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:39 +0800
Message-Id: <20210401102447.3958224-1-howardchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 0/8] Hi Linux-bluetooth,
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>


This series is to add a new method |SetServiceAllowList| in D-Bus API to
control what services can be connected by specifying UUID allow list.
Users can query a device property |IsBlockedByPolicy| to tell if some
of the services are currently restricted. Since we plan to add more
methods to limit different bluetooth functionalities, we also introduce
a new interface for this purpose. This series has been tested via sending
commands with dbus-send manually on chromebook octopus and eve.

Thanks,
Howard


Howard Chung (7):
  doc: add description of SetServiceAllowList
  lib: add hash functions for bt_uuid_t
  core: add AdminPolicy Interface
  input/hog: block connection by policy
  audio: Remove Media1 interface when a2dp source disallowed
  core: add properties IsBlockedByPolicy and ServiceAllowList
  core: store ServiceAllowList into settings

Sonny Sasaka (1):
  core: Initialize uuid_str_arr to NULL

 Makefile.am              |   3 +-
 doc/admin_policy-api.txt |  34 +++++
 doc/device-api.txt       |   7 +
 lib/uuid.c               |  21 +++
 lib/uuid.h               |   3 +
 profiles/audio/a2dp.c    |   2 +
 profiles/audio/avrcp.c   |   3 +
 profiles/input/hog.c     |  22 +++
 src/adapter.c            | 148 +++++++++++++++++++-
 src/adapter.h            |   5 +
 src/admin_policy.c       | 292 +++++++++++++++++++++++++++++++++++++++
 src/admin_policy.h       |  23 +++
 src/device.c             |  79 ++++++++++-
 src/device.h             |   2 +
 src/profile.c            |  39 ++++++
 src/profile.h            |   5 +
 src/service.c            |  21 +++
 src/service.h            |   1 +
 18 files changed, 705 insertions(+), 5 deletions(-)
 create mode 100644 doc/admin_policy-api.txt
 create mode 100644 src/admin_policy.c
 create mode 100644 src/admin_policy.h

-- 
2.31.0.291.g576ba9dcdaf-goog

