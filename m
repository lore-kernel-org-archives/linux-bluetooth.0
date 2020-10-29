Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47224C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C855120791
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3EY6Mxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgJ2XGa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2XGa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDDC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b17so3149026pgd.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4DQMQXNpASgAcgv5EiRtGpHEpK47gKJLGB48bS5XLC0=;
        b=s3EY6Mxv4nsHX2DJ5oZpIueGlYNlKBTam5lzwuUclCjlAi8djX0bqcU6Dxsw3Ihcmw
         jiO5ayMVmjr0O2Ew1AuD5SDaHjHqP3B8qtnH6Mqv+hjVewFJBVtecytkw/dMq373AIA/
         arvAEgG5WbmaApG0ZZNUDoBQlGRjqh9WLCIw/5wlrRZrentQaGpFf1coPV5XdIWEIgye
         oItdCknYaK4oae+g9k3KscWrbKRcuX/znf3SBuCWNhEGrTz/cx4r83wwxNTXf/px16nM
         2uG6QBG4mB0qAkp79SAM+mdYAAGpwa29L6Kib52XnEWmw7bo7uEp4TopfyDkogN7yaxI
         81OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4DQMQXNpASgAcgv5EiRtGpHEpK47gKJLGB48bS5XLC0=;
        b=XCk3Z4U42F1Qlz+fMBrP6bReWxPW4a3J5PVGvQi045tzPZS1+TbmZyz9uI/RLsMEOy
         amhbHSfoWCqBct9se1dzncj6nNrW8v8RyyKRkBRE0i6xCFmQzQcYV+8Fr2/VTHTdFquj
         ZIXFztDOGtY8ymTEsd42haJUux8ut2NnoZXWnTZ5/AbGFwdaJ4LgAi9OT0emTDM7cSaP
         8QXeVPZChsTPb9PMFq2FGola1LpcahW1CtKfUa+qouNKFrhzI5KmJmJP+SvEG/7H2xdv
         DUxvvSJvqZdcgP8Gar+GCeNUa/7si33il0WuLxwn4xXcK7LTVcSsvMNqy3vNJ9qCY0sG
         0NQA==
X-Gm-Message-State: AOAM531agWX7vJ5dW3EvxfxvBFTuEvYdh5Xcb6PidsZ/aL83CPhR57ie
        tTloWy7RxDNVJ39ctx1uaX1ZAO4Y9hoEWYXUuPQM
X-Google-Smtp-Source: ABdhPJzRE+PlJ1Mf/jgSLOxzj7TfZb/TDnHhG+QF8nQyK8yM55c1YgozJOAmyM0lnHdXa1dZJuQFwY71hza8iBK5rgYA
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:aa7:9afc:0:b029:152:9d45:6723 with
 SMTP id y28-20020aa79afc0000b02901529d456723mr6261532pfp.35.1604012789321;
 Thu, 29 Oct 2020 16:06:29 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:12 -0700
Message-Id: <20201029230623.3630069-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 00/10] Bluetooth: Add new MGMT interface for
 advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

This patch series defines the new two-call MGMT interface in userspace
for adding advertising instances. Bluez will detect if kernel supports
the new MGMT commands, and use them if so. Each new advertising instance
will be configured by a MGMT call to set advertising parameters,
followed by a MGMT call to set advertising data. The new data pipeline
is meant to be unnoticeable from the clients' perspective, with the
exception of new intervals and tx power support, and new exposed
advertising manager properties.

All changes have been tested on hatch (extended advertising) and kukui
(no extended advertising) chromebooks with manual testing verifying
correctness of parameters/data in btmon traces, and our automated test
suite of 25 single- and multi-advertising usage scenarios.

V2 of the series puts documentation at the front as requested.

Thank you in advance for your review!
Daniel Winkler


Changes in v6:
- Reserve new MGMT codes earlier in series to detect support

Changes in v5:
- Changed interval API from jiffies to milliseconds for clarity
- Changed new dbus endpoints to be experimental
- Only parse new properties if experimental flag is set
- Verify capabilities MGMT command is supported before calling it
- Make SupportedCapabilities experimental

Changes in v4:
- mgmt-api: moved optional params into 'flags' field
- mgmt-api: added info for new return parameters for max data size
- mgmt-api: Move Controller Capabilities MGMT doc into new patch
- mgmt-api: Tx Power range put into single capabilities entry
- Moved optional params into flags field
- Use returned max data length in adv data length check
- Move tx power range into single capability field

Changes in v3:
- Removed Tx Power Selected MGMT event
- Changed Read Security Info cmd to  Read Controller Capabilities
- Added selected tx power to MGMT params response
- Removed Tx Power Selected MGMT event from monitor

Changes in v2:
- Removed extra space in Add Extended Advertising Parameters API
- Uses btd_has_kernel_features to detect kernel command support
- Cleaned fail path in add_adv_params_callback

Daniel Winkler (10):
  doc/advertising-api: update API with new interface
  doc/mgmt-api: Add new Advertising MGMT interfaces to mgmt-api
  doc/mgmt-api: Update controller capabilities MGMT command in mgmt-api
  advertising: Detect if extended advertising mgmt commands are
    supported
  advertising: Parse intervals and tx power from adv
  advertising: Use new mgmt interface for advertising add
  advertising: Query LE TX range at manager initialization
  advertising: Expose SupportedCapabilities for advertising
  client: Add SupportedCapabilities to bluetoothctl
  monitor: Add new MGMT adv commands and events to monitor

 client/main.c           |   1 +
 doc/advertising-api.txt |  48 +++++
 doc/mgmt-api.txt        | 238 +++++++++++++++++++++-
 lib/mgmt.h              |  46 ++++-
 monitor/packet.c        |  69 ++++++-
 src/adapter.c           |   8 +
 src/adapter.h           |   2 +
 src/advertising.c       | 428 ++++++++++++++++++++++++++++++++++++++--
 tools/btmgmt.c          |  12 +-
 9 files changed, 819 insertions(+), 33 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

