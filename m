Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E174C4727E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA9020796
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emU3R8U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgJAXB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgJAXB7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:01:59 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F71C0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:01:59 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y17so23603qkf.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=kB8umKmk3w9z63FbO86NCrv668wCYgvIIupSKSt1V5o=;
        b=emU3R8U1fQD+Cp+0yR5/UlMJk/IfQqLdSTSFntJLEU6y4o+ESTA1b2c2nSFAShhFo5
         +23wpDZhNZULnFOsmE1T4Zty1RPAWt6SXR5nSrS4o0/7NisZnvkvJUMsLaqHbRDEWEjz
         K4bddRWYcDLAgbM7d2Q9bgL7cN0ZgUM372lMY4/ntVg5jrg90MASEAC1cnEa5t84MpDS
         3v4cTFLBf+uv9BhqFbT5nICY3odAvZlEXDcCnkSSQuGYWYnRdDWHAK8+D2shtbEh2y5L
         wga9EOETmMw0JsK8xqmmRfHkT/HA05k8i6O9HQYQ3ScZ9mR6Ek1fBCKXyq7Q8yUQ9wUu
         iFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=kB8umKmk3w9z63FbO86NCrv668wCYgvIIupSKSt1V5o=;
        b=Yvc4VhocbITNzl7SkXMq30xkCk3fBQBi7JSfyyYkEG/dn8MUqJcZHgPSfZenYLLEGp
         FiGB8GYEjK/TFuSwZKuo44AUykSTbW1qvnVVO1lo75427mgYXD/EJLOrTVWaviK5nQz8
         gcTes/EsWZA4unoDs0IfrfJUk4/BDUdEyyw68crdjY2nJ68FgXSXda/n6vL5pFZCxyfh
         eGjLDWO5Xdc0pwvgcJPEsL89bPDdEMOv07J++ME0TFi0SGUhdUWfSHdB5jDAsq8sNdRx
         OVoRPkhpPFNFQQDK2unnJZy4tkprP/Er1G9Pm+a0iwYUQ/6J5lT7XWW6xbSntzrTxNK2
         AN4Q==
X-Gm-Message-State: AOAM532ugkLeSGOmilLeLuQ7r3pzbaZIrk0PCoRAWob/t7VhfQdZEqXd
        C1lmReJtE+R4YgjyXN8egCy9T9e+eZK7fI+qqjn2
X-Google-Smtp-Source: ABdhPJzmTLVFpws08SMt4gGt5wW4IYTmfAJi109zTl56DQxO+H7FE61jvtiAqqfe3pws9N1TxSa719h0J/nsG6LJtzS+
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5653:: with SMTP id
 bl19mr9531037qvb.7.1601593317999; Thu, 01 Oct 2020 16:01:57 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:42 -0700
Message-Id: <20201001230152.2422908-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 00/10] Bluetooth: Add new MGMT interface for
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
 doc/advertising-api.txt |  50 +++++
 doc/mgmt-api.txt        | 238 +++++++++++++++++++++++-
 lib/mgmt.h              |  46 ++++-
 monitor/packet.c        |  69 ++++++-
 src/adapter.c           |   4 +
 src/adapter.h           |   1 +
 src/advertising.c       | 403 ++++++++++++++++++++++++++++++++++++++--
 tools/btmgmt.c          |  12 +-
 9 files changed, 791 insertions(+), 33 deletions(-)

-- 
2.28.0.709.gb0816b6eb0-goog

