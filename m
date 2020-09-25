Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42040C4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E67A207C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLrZW2kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgIYBN6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgIYBN6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:13:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5CC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:13:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a7so1088822ybq.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=esZ6mdnPKj7LnCrN12NDOxoAp0Ez7vV5cUu/bYcytjc=;
        b=OLrZW2kHhdh4DEoVzRiNW95yOcE/TNNQSZInB/HDKNfxyuYl/0INZ2U3Gl9O6ury1h
         FHspG5VcZjCx44SH+oBAenSjy+ulNz/9LW/SH1c4SWpVYiAxOKEvtBlaDQVkd4kqAQ1L
         KXctGsG/SA8wwyppDcGBrndDf1U0DDABvhdz7iewoXydehS+qSk6nPPFs+Kvba4uExwZ
         kEHsHBgLlDoP/UYQUtpCH/Fp1dCzyuloT3kOGJQhJqezc26dws4F21HHTg/E+kvN14Vw
         v3pvQYzY1Ra27wCzYvgYpLiHJRF8hooxShbA2v41ufaloqGyI23WWI7rvctGZKqgqpoH
         BkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=esZ6mdnPKj7LnCrN12NDOxoAp0Ez7vV5cUu/bYcytjc=;
        b=BMFjT/v4E5uwD9Mh0BHnfkMtEPdp5PJ3usMFRfMp7HRfK0f2EfAjPtGowXHNknlgAU
         XH/jogGLR/HOtPDQgDOrrcg/b+fkDk8S5u5LY3yvIiUmmBP+Ph2zbn6mJ3yKJEsmnDZ9
         0CLiwgzZndVBFg4fuENouXSRPymaAuOhOZg9NkXtX3O5p00uWS9VkKVPdhFnQZ+oJ4RI
         R95E8Mb+wJPgqqcG3QUkxqqgu+uwKG3vg5jc2R6U/kjDqg9GomU9yFMs34U8v9/rqrOa
         12EpdXPe01xj3f6F5d8qOmmKavnW2ESbGKncheNiLZV7BZqp+A3g4LGAVW6Emh967dsl
         v2IA==
X-Gm-Message-State: AOAM533GfWegE2GlYDkoJxeEN0Zinniu4QTvJ1hcjgAar9ZBCpsVs9QS
        ah+t8O6LtMIFej7GbeSQxIYNnwzFRfgNYXYEpt45
X-Google-Smtp-Source: ABdhPJz3JvfHaDrFTS4z9zpW40cM9DiZO5Vh2CJnu4pXm7PRfEnaCNUfSPdaew8iuXXbkg5uTBCTZk38lCYprp+IlL1L
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:8389:: with SMTP id
 t9mr2307639ybk.471.1600996437324; Thu, 24 Sep 2020 18:13:57 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:38 -0700
Message-Id: <20200925011347.2478464-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 0/9] Bluetooth: Add new MGMT interface for
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


Changes in v3:
- Removed Tx Power Selected MGMT event
- Changed Read Security Info cmd to  Read Controller Capabilities
- Added selected tx power to MGMT params response
- Removed Tx Power Selected MGMT event from monitor

Changes in v2:
- Removed extra space in Add Extended Advertising Parameters API
- Uses btd_has_kernel_features to detect kernel command support
- Cleaned fail path in add_adv_params_callback

Daniel Winkler (9):
  doc/advertising-api: update API with new interface
  doc/mgmt-api: Add new MGMT interfaces to mgmt-api
  advertising: Detect if extended advertising mgmt commands are
    supported
  advertising: Parse intervals and tx power from adv
  advertising: Use new mgmt interface for advertising add
  advertising: Query LE TX range at manager initialization
  advertising: Expose SupportedCapabilities for advertising
  client: Add SupportedCapabilities to bluetoothctl
  monitor: Add new MGMT adv commands and events to monitor

 client/main.c           |   1 +
 doc/advertising-api.txt |  50 +++++
 doc/mgmt-api.txt        | 229 +++++++++++++++++++++-
 lib/mgmt.h              |  47 ++++-
 monitor/packet.c        |  79 +++++++-
 src/adapter.c           |   4 +
 src/adapter.h           |   1 +
 src/advertising.c       | 423 ++++++++++++++++++++++++++++++++++++++--
 tools/btmgmt.c          |  12 +-
 9 files changed, 813 insertions(+), 33 deletions(-)

-- 
2.28.0.709.gb0816b6eb0-goog

