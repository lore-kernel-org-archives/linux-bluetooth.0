Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B112C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2BB21481
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ixzu33te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRWOH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRWOH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:07 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD32C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:07 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y17so5848717qkf.15
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JfKZ2fPSMMAR4yhaJbPJAgMbWeKJCTjpmBm0wD4pcOk=;
        b=Ixzu33te/Ix5TRQyhqx2UR3AmGEup276iG7YUI/MxHF5x+BSKcqpyMH7rWSADh/vBs
         YL3Hc4DWDZmLrmZ4Sf9vmWUDmbLmDADYC9UhXo4cGBnuqWZMsFeRhNtHcMC8Igj0UqBF
         fc2SXL6j6NixMF/6XigUmdaIm9h8tnJyiQhsy5+J6Hj4WX4/WhJlLLh5sYFf6lvowVhq
         6I7FVitxSxb7Ba3HO5Mnljhg3dN0M4VzkoNZMpHH/1ztPFv21U1MUFxD2FYBhL4teuWS
         S+ws5C9LNaABJo46YSjhNndRCMnYeGmcpb9LodhTJHhH+lvfr6QHgSd+XP7mz/RlQ3kl
         nqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JfKZ2fPSMMAR4yhaJbPJAgMbWeKJCTjpmBm0wD4pcOk=;
        b=Q+sQWnkIj7/27n75XQsTP8kC0c4U91C2MYIaV2g+R7gAk4BOfkxrIy4ITep6T31yyp
         mVS0x7BRij3KL1bt117UKBEWsFE1JinBZ1FugDqFUk9gQx7q0kkZA6+UlYzRwEqdqB6T
         unN6aRF33zX27eUxE56gEq0KaQeDCN3jbpC0dxRrgwOo+hzS9OQsi0eZHxzuGo6eSfMF
         gyr8y/yfVom/mb3eVTY9CT9DPh+gipxvN5fFOSmYHPoVz+Sv6vOQUSDC/nsY8Wi282EW
         OEiuX8kIovb11wBvAtj01hA+jX58nVoEeFPAnroIecLJ7olx/xhlMNUz9NMv1i4Ik8NW
         ELzw==
X-Gm-Message-State: AOAM5326ETmKja5WPMK99XfPeCj0EGAOpjOsfcMSZamlr2ftI45uATKf
        69uTOAxnZQotK7kLxam4ZVMrPk3vwKoGUWqXPX5/
X-Google-Smtp-Source: ABdhPJwe2GzdOsCxs5Iy1AD6oDmvKncWnMsj2t/16x7n2CVTP724jNrN+Sl45xfK31MazxZU94+9GMk8FHiCX365o232
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:58e7:: with SMTP id
 di7mr19039339qvb.36.1600467246622; Fri, 18 Sep 2020 15:14:06 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:47 -0700
Message-Id: <20200918221357.3436905-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 00/10] Bluetooth: Add new MGMT interface for
 advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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


Changes in v2:
- Removed extra space in Add Extended Advertising Parameters API
- Uses btd_has_kernel_features to detect kernel command support
- Cleaned fail path in add_adv_params_callback

Daniel Winkler (10):
  doc/advertising-api: update API with new interface
  doc/mgmt-api: Add new MGMT interfaces to mgmt-api
  advertising: Detect if extended advertising mgmt commands are
    supported
  advertising: Parse intervals and tx power from adv
  advertising: Use new mgmt interface for advertising add
  advertising: Catch tx power selected event and handle it
  advertising: Query LE TX range at manager initialization
  advertising: Expose SupportedCapabilities for advertising
  client: Add SupportedCapabilities to bluetoothctl
  monitor: Add new MGMT adv commands and events to monitor

 client/main.c           |   1 +
 doc/advertising-api.txt |  50 +++++
 doc/mgmt-api.txt        | 242 ++++++++++++++++++++++
 lib/mgmt.h              |  45 +++++
 monitor/packet.c        |  84 ++++++++
 src/adapter.c           |   4 +
 src/adapter.h           |   1 +
 src/advertising.c       | 433 ++++++++++++++++++++++++++++++++++++++--
 8 files changed, 845 insertions(+), 15 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

