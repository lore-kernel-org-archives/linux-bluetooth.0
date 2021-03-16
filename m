Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE737C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8C964F8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCPXWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 19:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCPXWW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 19:22:22 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D9BC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:22 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id iy2so26346981qvb.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e1QZzMyzCSpJPelighfrG9StO7im/CHf6J2iklN2iYo=;
        b=Sm3tSexy6/Im80XcK1+0z2fof3ZER6aHVcgQ161PdGfl+1Uoaq/RD7+DBVgu3bQg37
         PEXVle/mXWOBjs+WH8+mi23YNcGMDFVxuxiqd6yI+QtJ/Qa20kHUrkR8wjWrnyv1p8x0
         TObHDWpzexbVm8mqtrHp7ZZskzRtjTYBsecEEMWvivDKl+JuJ/BaNKokbtJuzMNteDbM
         cTQ+hXAGSXa78WAiOPJ4DRRflq/kdjdULqI3duJbyJosWoezR2/FmI/s24kBPGNw0eVH
         gbWPMbj/ldWIm60XUANljMg28eXEdMo635+ZxHYnQ1aue9Q+KH+zuV903BIJT/2/2S9y
         /i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e1QZzMyzCSpJPelighfrG9StO7im/CHf6J2iklN2iYo=;
        b=acEhFF+tHcQmhFmFVcuC2F2EW4Q+0LfO7aD5tYfw5heyCZySprN+aSs4Jgd2Ewo5+a
         s4ohjZnuW6wCL10NsXj9OJ0e39oRfsV/ZCIwyUAz/FmonWaYDHmytEStenw3rZDzKxJX
         YAEgp7iH1QZ7CRvO6/m0o9+pn6B3Md/T2AF7To4zSv+xhiFOvBjTQmVPc97bVlBhoR6x
         4lgEsHaL3AF6DyLYInOGQTau4hmlyHE4aI5gJsPdBQvqyBznykFxB2zPaPrKMdAK4oVR
         7i41biJxsaC2QLFm7LyZwkEn2/9QrdOmkmcmcQ7IgD2xixkGX1ZLOCZXlqlNgONrdoRc
         VhaQ==
X-Gm-Message-State: AOAM533kFHSPz8xF3s5w79Zxdd7eZmJApHWVJI1n8fYCu0hWJB9H/lX2
        zrY50Y9ScdEQdIsrL5TUTl9UR3V7HyCSlNDLWq5H4fP7yncAl56UuAtYHgcn+C2Z3yIM8mQEFlP
        7wr/QXYTB/eEqUfz+02R74jZc8hBvByBK0Vpin3G9GlBnxzTlB/ffzdaDFEtvsLZJj3CtPBPPI3
        gZNpx2femp1xCL3oUu
X-Google-Smtp-Source: ABdhPJzsnKj1r/PinKrRCPyrJjdJmoXS46dD6EOwKl7JqXGACPc+IHU/sQr2iE9ws/IYI9yipP3k/OvVaK5fcbLPzT7r
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:8543:90a8:2e5c:1402])
 (user=danielwinkler job=sendgmr) by 2002:a0c:f505:: with SMTP id
 j5mr2028956qvm.61.1615936941401; Tue, 16 Mar 2021 16:22:21 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:22:14 -0700
Message-Id: <20210316232217.3344489-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v4 0/3] Expose extended adv feature support via bluez API
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

Changes in v4:
- Mark SupportedFeatures as experimental

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
 doc/advertising-api.txt | 18 +++++++++++++++++
 lib/mgmt.h              |  2 ++
 src/advertising.c       | 44 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 63 insertions(+), 2 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

