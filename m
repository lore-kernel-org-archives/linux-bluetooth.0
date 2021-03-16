Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C294C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1885D64F41
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhCPWuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhCPWuE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 18:50:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD04C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:50:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v6so43235484ybk.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9MwTJhSoenOhuY+ESbwbge9BPXSCfgHsCeuVoqfyQwg=;
        b=rn+u5dOZzmNmYH+t1WZQSnrwVR0NtPuibNLvVcm/Ae60VSKAy/DYGgFYNoFZgOaaR4
         c7xElnh5h9LncJYjzbt7AkwjCcMjrTczMUcxq0M0Q1g1QMpOAjmR41orXZk18uJYtCyd
         DX356K65QEMI2MzineiauUL4UUxmJbulmcaG4TlSolgmHiSa+9WXey0Jw8eT/nXjoder
         rAkjxKyQB+vtdvHsgI5pmD4Rnv8H4jWJc9GDFlEKtHxclSKnYY6JeyzINf17J87t7KDq
         BnzX/GkxfnGrfB+bxdtUH89/5XX2a6vAzw5V8+glJKMjwR/vrCh6z/PIkSn9R2oF0GVe
         q5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9MwTJhSoenOhuY+ESbwbge9BPXSCfgHsCeuVoqfyQwg=;
        b=Shx3hoYzwzZoKgPrGfldSQYqgcVTcdUKzDYMXcPZsk9QjBtKj4ZEGSKEoEhfYg4GlH
         gS4XPhG61AnRH5sxkpgUN9U+t6nbw55K+qxakbNlxMMYQx1RkvTHE6vo6+NOPHX+kLxG
         2aM2N5UxPE1k1JQCvsV0jXrvYsm3GcHTk/6wrETFJ2wucY3qeal/VC5WTFtdRhbwQyY0
         aXXURzd4+u3hVS/KwE3ocACz50dNAk8uTYgk1K8jz2o8oOsNfzuWaBHu2yEiyQKSfuQN
         rdWxzmi5JrQjG4Gyvg5Q9o3nRtryOp6MXKO2fXh4YJBRXlq58xxe2Gc2Lo+hhl3rLWnk
         tU2A==
X-Gm-Message-State: AOAM530mgDctYw9KNoNScZDgS3mO0a+71JA7rhx0fxBAmwDpfuohH0w/
        /MPKKo3FTETj/RYZSdejOtfD/YupdRbYJNmhWvVMbw0tCSN79Lf6hQcJNlfhv6Fu/G4ME+aUTnv
        enSHPfUVvw0zN0kOajgNYPesfvkjHnvJleOM0S+r1MNPQQVU2KTlmd9TUcYMDXEhlXuYDowX4uV
        15F71Gy9NgTC1hoxXr
X-Google-Smtp-Source: ABdhPJzBi3kZXl6G8ts9JhqfxOMjGZdSyq9K9shFsd+Eb2n74IebhEN4J9X2GDo/BQHbBeswVGzXx0YJFa2LHfo985Ny
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:8543:90a8:2e5c:1402])
 (user=danielwinkler job=sendgmr) by 2002:a25:7315:: with SMTP id
 o21mr1571104ybc.453.1615935003891; Tue, 16 Mar 2021 15:50:03 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:49:55 -0700
Message-Id: <20210316224957.3294962-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v3 0/2] Bluetooth: Fix scannable broadcast advertising
 on extended APIs
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

We have discovered that when userspace registers a broadcast
(non-connectable) advertisement with scan response data, it exposes a
limitation in the new extended MGMT APIs. At the time that the
parameters are registered with the controller, kernel does not yet have
the advertising data and scan response (coming in a separate MGMT call),
and will default to a non-scannable PDU. When the MGMT call for
data/scan response is received, the controller will either fail when we
request to set the scan response, or return success and not use it.

This series along with another in kernel will allow userspace to pass a
flag with the params request indicating if the advertisement contains a
scan response. This allows kernel to register the parameters correctly
with the controller.

The patch is tested with a scannable broadcast advertisement on Hatch
and Kukui chromebooks (ext and non-ext capabilities) and ensuring a
peripheral device can detect the scan response.

Best,
Daniel

Changes in v3:
    - Use helpers to determine scannable rather than generating earlier

Changes in v2:
    - Check kernel supports flag before setting it

Daniel Winkler (2):
  advertising: Create and use scannable adv param flag
  doc/mgmt-api: Update documentation for scan_rsp param flag

 doc/mgmt-api.txt  |  5 +++++
 lib/mgmt.h        |  1 +
 src/advertising.c | 24 +++++++++++++++++++++++-
 src/shared/ad.c   | 17 +++++++++++++++++
 src/shared/ad.h   |  2 ++
 5 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

