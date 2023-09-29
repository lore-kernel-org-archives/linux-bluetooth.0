Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D123CE728C5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 16:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjI2QjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2QjG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 12:39:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E41A5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 09:39:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68c576d35feso12665723b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 09:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696005544; x=1696610344; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nRPexQc9M51kvPJFcE9uM1lprCCsGeZyt7k4xcgxwUk=;
        b=Ef2cqGajx+4me2R2QzXlkGgd21qIQzC2uLS/sf8VinDAJSqM+j5xjG24CbRZDsRaXk
         h2YE9kr4PmJMLMX/quMQF+5feDViivGVRyso69VM1bOPmQvZ3DJWg44doi2SToCS5+MW
         KOvB3fa1uI8EY2LspAUDnmkVZG+PB8RcWzvJoYZkxWl4qWM2Ddkx/zaS8YCr3aZGMG85
         K5hx/D5AqYqv1Slv8yfFT5eYAXztfKTKdJ28yw+uPoQ0EUg+zGaD9e31liY9efAd7X1A
         lYdJDNXQpAYUhZ81uEa6J69cB6drhsRZamZMA+ulbmTVp0KetcWrAAZYDOr7nXd+FEcq
         mDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696005544; x=1696610344;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRPexQc9M51kvPJFcE9uM1lprCCsGeZyt7k4xcgxwUk=;
        b=Qu0ZyU6ZcDEeXo6/FFitcTcY+IfsvjAuXs7n+xgOachV7gIN1IEyW+81MdVY3R3K+z
         dAiZPiTpNsjDQc6E0XaPkZXZAUZe7l29p4te6YQcCzhZIeK/Y7Nlbp+rd01fEcEnpc38
         iXVTtl1nfjcuzKhkrnqRAQ9uQt2b7ZxnBHXrDKpP8ihDnfdjsjxxIbXjglQyWafdXt+Z
         UwurKEc3tTXxxYPefoX0m+rzg5hVtJ5c2WZ5hwU6fPAa1ZGemrxihAPAQBzMH+K9DdkI
         g95Pl/bi/GQhypqj0eDG13lLbZ01T8D3dnuBwGArUnaAO5q9CxhdkOlqL9BqVF/D003m
         fvfA==
X-Gm-Message-State: AOJu0YwnnwIAAM/2DLy+qNbKqvkw9yqTWFAbQBwLYRmXJqdsRCROy+0D
        VTur0/YV9dFLIHlHA+QdmdAARj11DZ4=
X-Google-Smtp-Source: AGHT+IEIHmL+GeuOkZarb9yVlkYXBElvamWLYr9OCOzmEV9z49a8RIi1+a464FQQwq8dS7mthst3pQ==
X-Received: by 2002:a05:6a00:1487:b0:68a:5877:bfb1 with SMTP id v7-20020a056a00148700b0068a5877bfb1mr5118053pfu.20.1696005543632;
        Fri, 29 Sep 2023 09:39:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.7.27])
        by smtp.gmail.com with ESMTPSA id n13-20020a63b44d000000b0056c24c2e23dsm12039474pgu.25.2023.09.29.09.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:39:03 -0700 (PDT)
Message-ID: <6516fda7.630a0220.57241.ca6c@mx.google.com>
Date:   Fri, 29 Sep 2023 09:39:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5412265905293721729=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Match QoS adv handle with BIG handle
In-Reply-To: <20230929153727.3728-2-iulia.tanasescu@nxp.com>
References: <20230929153727.3728-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5412265905293721729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788854

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      33.90 seconds
CheckAllWarning               PASS      36.67 seconds
CheckSparse                   PASS      42.09 seconds
CheckSmatch                   PASS      117.46 seconds
BuildKernel32                 PASS      32.87 seconds
TestRunnerSetup               PASS      496.38 seconds
TestRunner_l2cap-tester       PASS      30.09 seconds
TestRunner_iso-tester         PASS      49.60 seconds
TestRunner_bnep-tester        PASS      10.53 seconds
TestRunner_mgmt-tester        PASS      218.45 seconds
TestRunner_rfcomm-tester      PASS      15.14 seconds
TestRunner_sco-tester         PASS      18.75 seconds
TestRunner_ioctl-tester       PASS      17.13 seconds
TestRunner_mesh-tester        PASS      12.56 seconds
TestRunner_smp-tester         PASS      13.61 seconds
TestRunner_userchan-tester    PASS      10.40 seconds
IncrementalBuild              PASS      30.93 seconds



---
Regards,
Linux Bluetooth


--===============5412265905293721729==--
