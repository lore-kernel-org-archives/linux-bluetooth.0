Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F0C4742C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729592087D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzwVuPq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ2VXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VXq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:23:46 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012CDC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:45 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id eh4so2545239qvb.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WyDGRz2pbkNZwiLvOIQy45H0kIvS2ltU85WXGIWP/yQ=;
        b=uzwVuPq/le2AMhNgDudVXSjx2dWhjpxsiSSlKSTmkgtoLz5VaAucFdcnxklbC1vb8J
         3Ao3EN/TJFzVtDqq+kpSt7ksNNwExyUVu0vshKBzaVcbSbOX6VOdbfvf2nP9dpdwRdsa
         ZX9VtY+PEA5yTDFnT5NMn2nst0kzZbqr0HzB8q4CaRIdKqz21EFvTne5vonmBJkkN9Xm
         xIGUbFK038fFBE3YsVazG6LQrc5vDKcuzXU8iGZtcLEcj2tkjewypDTRJXWNVdAD7XF+
         y5pzjeWLq+1IcdFLOGY3KlF+Yp1Jn+xnxSWPD1TPAMASVCXRdH0ZP58s7djiFD5qZOrd
         GNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WyDGRz2pbkNZwiLvOIQy45H0kIvS2ltU85WXGIWP/yQ=;
        b=G3w9lNnzp7b7vTlPEue/RHG0VSviDwTk1XcDiao40g02KuHpgy6lMIyr0TcXPOhv3c
         Bye9SrGehstPHUcspcnoQyzXCboLNzixtEhG/SH+KAqQFRMwjAiIuBxv+x8a+5jlZg6l
         6omnpwcfSiY0l1P3IY8o1A+/f+Hu48lMIc3yCCnuOSqDUd1eHOYZke+pEWXgF18F0MrA
         eBsQ6u1KRri7RFu8CIt+8cYp5bDt0fYMjX12CK58+onk3x4A7gXQh/iZOVh7xmJFLanZ
         3vLzSZkpEmg52ql31prqIWDNUV0CjsnFAbI6Yv5T+Nn/SD0+U53vncVPL62I3jCHWqL+
         F24g==
X-Gm-Message-State: AOAM531ZLOsnefNyINDPJWwAmJ4TiyPL4l71U4NE+McI0q97Kf1zXsuH
        yeC0yZmmq0KiooqNEJ/XLbEdQlarmt0IIXbiVMUQ
X-Google-Smtp-Source: ABdhPJwHd8boNgQ1UN23fOMfz1AXhvPVHqAVi/SGS7GbEl6iqbA4i1d22nfLSP6UiCGt2gEgqb15If/BVjdDqN1d6Zhz
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:85e3:: with SMTP id
 o90mr5878142qva.46.1604006624988; Thu, 29 Oct 2020 14:23:44 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:25 -0700
Message-Id: <20201029212336.3283410-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 00/10] Bluetooth: Add new MGMT interface for
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

