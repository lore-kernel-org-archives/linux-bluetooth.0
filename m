Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66CEC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D536207D3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iI/ccMdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgIAWAd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIAWAc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 18:00:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8C8C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 15:00:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207so2709228ybd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LHOLGhB2FfF4MgoNi7IdLwOC7IIoWZleX+LVSUv6+Y8=;
        b=iI/ccMdXJsSK2VkuQdZnwb/BVs4pAVn283Xvm21yzRKLsHI07+hIUAee98iq+/1jZR
         9q9iYNE2ts6ok3ETlSOlEoOqxsPqYo0+GD2+959vTu477eaSH2gy0e0RFu7BG/823ujy
         Q2V4W7KlWw4GJE/ZMgZfDqRTExayKgP2skDRI3d/x0ocvSeirS1+cIXJXbhzVRK2n3Bd
         PgUDOsd8ng0Yrm1E1KOvnNKM17AhdPW7zkXqae9dgbQVaIeyEPsBsi9sfRBApjTH+izT
         Y3pp9nWZjZaSElTCBho3LQD1v8YCl1qUbUXL/aRvnGndyXvL81UlZ2eLgBP4HTNfVVeU
         Baxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LHOLGhB2FfF4MgoNi7IdLwOC7IIoWZleX+LVSUv6+Y8=;
        b=mQWWaT17HRXgnqr3c+FBDUap7ATtwmVSyA/OJIcwcZ4phsquZsN/sxywY7no7EWgdN
         1Q49LkC3Or1dh0JY6w244NKXujCdLsGUWgi101uzri/E/LQorXv1r2MF+JyJPLE/m3E6
         2x8QSGzzbInBEi6pGHreSclcNJ/SOMSfLJ3tHr7HZODfodU7dMI3gcxRdKdz/NY46j6V
         yjaRjn2QxcaR9HGVnS/m9tM8ZmkLVmDzWYtXnhX+8hq39edhiXofn9RtPRiGTvvEiF7W
         wPt0LmTWaS0UXqt7rAtyWZg9AFEXtWfR1oxkD8ouGotjZdBYeuby1EBmtpqgmaQb9cf4
         2+Mw==
X-Gm-Message-State: AOAM530k7eB8HJvFScznI0eoQZiFYiW+F/jtIc/9+L3e7yhzuWrWTru1
        Q6o3Xi2HPdghcwQu2Dd9wHRDtBW/wJQr3MZif+MW1zpsLBXFi1GJ3DQ1tMHI4fgjWneLXk9J84c
        v/2tkvvt59RSdo5smAIKUAFBaMs2sr7Xu4GsQkZoYrppc0yYqE57TRsTy9C3gHRn4SbLR04GHrK
        dyShT4bEQR2vHEV74n
X-Google-Smtp-Source: ABdhPJzte4zdzMJBRl06xMGRn0QmNrQZRmFnlcyK/3fj7vcYklSNqldDM5a9et/cc90wVWBEFLARBRQ+Z66iwfVjRIG3
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:e791:: with SMTP id
 e139mr5977283ybh.67.1598997631872; Tue, 01 Sep 2020 15:00:31 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:00:21 -0700
Message-Id: <20200901220024.662941-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v2 0/3] Expose extended adv feature support via bluez API
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

This change adds a SupportedFeatures member to the LEAdvertisingManager
interface, which allows us to expose support for hardware offloading and
setting TX power on advertisements.

Best,
Daniel

Changes in v2:
- Expose empty SupportedFeatures if no support available
- Doc: Expect empty SupportedFeatures if no support available

Daniel Winkler (3):
  advertising: Add SupportedFeatures to LEAdvertisingManager1
  advertising: Add adv SupportedFeatures to bluetoothctl
  advertising: Add adv SupportedFeatures to doc

 client/main.c           |  1 +
 doc/advertising-api.txt | 18 +++++++++++++++++
 lib/mgmt.h              |  2 ++
 src/advertising.c       | 43 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

