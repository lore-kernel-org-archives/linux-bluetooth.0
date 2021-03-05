Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B35C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7427650B1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhCEXwk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCEXwX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:52:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E350C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:52:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n10so4225339ybb.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=O8D9yjp5NrnAmw7mHxxnVW7HVXLeeetf18uRfkud3OI=;
        b=ZyZrOh/J9NsRzKFUIsP2sZPIh3dFppXkeZViXNrU86cwVNGIGUk7EMVayoe11DMhfI
         /oy0tr7AGSc+5ta76e4fbKDPWAgTEgzsP4p25+6kEGP/J0M8VsJqCrE4aH4gJv70eB3E
         T7QmiKSTct183Ptl9Mey4aJTHt8LsfxhFicbb/NhnwGU6wxX3woK4gyN+JLrRqEgfPAz
         EYcb80nFaoprxh40+zC5gPnGxEGRswhfg/agjwnQ465W7Tj6GGZuhiWQb7zMZKAjTWvw
         CgnvFMnhmbrrNLhEX7dw6udDUyHm7S0Ss5oMHOPoJ6Dv9ZYW27A5clA7GhNeyb9+b2gH
         WM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=O8D9yjp5NrnAmw7mHxxnVW7HVXLeeetf18uRfkud3OI=;
        b=S9zHkR3kO/GIQXwfzvf267RhhyjVq2/sJgUVa6QWUzk/hnmS52cv5UlIB/QBSxFhcP
         75iro2msi1COCxK5AXt1ztdcZt91i3o/tNCQyWJ+NfLXMuPjtLg0kJeajpIruCoQstbF
         Tn8i6L7PmzMGKVoJMA+EqynHoa7dhGAJmcPHC5W2G5JCmF/QyA/YWWmNKaavBxUjJdfe
         7QDIxMCpIBrjhQWh1nX+8+5EmNc/tgfE/2IPv7cr5hK3Lu0kR2hKYU6MOWhjtNeeh+Lp
         w8oOn9JRyVitibsSpTVm50D0H/OIpXQWp8i4mOHSbXL5I3gX4YQSNO1OodZkz0quHZSw
         xrow==
X-Gm-Message-State: AOAM533hCI9fhlaQjoge7rhzkQmu9MoPtB/VfJ42l5WoCkZ0xk50VluF
        BTCTs69nwqIE2HUZ8FwP2SJ5fuJ3QVn99dxJrjsJi+ixq8RzFdDipPUUbp87ULsg8lMwOfiNSS8
        iIFsLqNUM7ub8p/+JtacGceQ2yMFjmV/nwRN4NSutZG7Iqf1R1+tSWelE9HhHIgbtp/WRG6ZzXP
        DY5z/AZ8XibplDsjyo
X-Google-Smtp-Source: ABdhPJxpiiGAPCQnseluXOA+2V7pNEMf4TwNsTN92H+a3g2p1sbLm2TW0K1LupxKvVl2TnwdL/EFJal7dXRi2I2sDOoO
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:94dd:309a:2fcb:13a])
 (user=danielwinkler job=sendgmr) by 2002:a25:dfcc:: with SMTP id
 w195mr17606349ybg.210.1614988342293; Fri, 05 Mar 2021 15:52:22 -0800 (PST)
Date:   Fri,  5 Mar 2021 15:52:14 -0800
Message-Id: <20210305235217.2382976-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v3 0/3] Expose extended adv feature support via bluez API
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

I believe this series fell through the cracks. It is listed on
patchworks as "Accepted", but I have not been able to find it in the
tree. I am re-posting it here, please advise if I am mistaken.

This change adds a SupportedFeatures member to the LEAdvertisingManager
interface, which allows us to expose support for hardware offloading and
setting TX power on advertisements.

Best,
Daniel

Changes in v3:
- Rebased onto master

Changes in v2:
- Expose empty SupportedFeatures if no support available
- Doc: Expect empty SupportedFeatures if no support available

Daniel Winkler (3):
  advertising: Add SupportedFeatures to LEAdvertisingManager1
  client: Add adv SupportedFeatures to bluetoothctl
  doc/advertising-api: Add adv SupportedFeatures to doc

 client/main.c           |  1 +
 doc/advertising-api.txt | 20 +++++++++++++++++++
 lib/mgmt.h              |  2 ++
 src/advertising.c       | 43 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

