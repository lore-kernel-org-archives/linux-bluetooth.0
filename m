Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A9CE7A88
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Sep 2023 12:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjIXMAz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIXMAz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Sep 2023 08:00:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCEE106
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Sep 2023 05:00:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c0ecb9a075so31085725ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Sep 2023 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695556846; x=1696161646; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MOakHujF+mx2vPNwAQ7/ndZD+eMwJyVQdWWOEu11klY=;
        b=FPUGZ4jINnbPonvFmI3WvBHJXineWk1OpmJA0cl92zMtvaCAXMWiShoCqJU/m9zaUU
         /wjblltAGQmZNvuIO9kM290j1VyRuCFrYxqfG4gjMZlu5sbjKFAqRjCvjiodUSTtVcF7
         mmjyCynv5c73kegkeSHhu60MsAoLxV0Y1LNtxeI2JozPf4F183ljbsAfBkzF+Tch+77N
         we7l2YYZPLMcQseRk2y6ZzUbxS01TFWdByQD88XteMgVvv1LDX/VMOi3YV1nnNvhYJ/S
         90L6N0GkOgb4fEvjNiR1Iqa2usCfEHuGaubnYYoB0NvYnUSUetPwlkZIS3JNnvpa7h8Y
         Rz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695556846; x=1696161646;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOakHujF+mx2vPNwAQ7/ndZD+eMwJyVQdWWOEu11klY=;
        b=BQ9pVa/gXOvKD/wMz+SWatbo9XAmI6+b/f0WJu65V+5kxa0PRRtW5PFGsJ6qCOB8Ea
         Sv/b8d4cA40rLI2pU2puzZnTU2klnZ1CJN6hALzZuFa2UHbBW9M4Zw0NTqYUJjRXMmRv
         /A3PWlgdRJ/G5jiSXuL8K3IcMgAYEsBcEjX4XxfIjjx2+zd7gcRXFL6cQ78dAp9O2AMz
         XVIOOa/DOjtiyZWYw9uzyLSYfUXagRqIXUbQVmKJ7KYyJDHTlXjoeMeVLEkyP9DVVNHP
         p4R3Yjma2GC9AVGhl+1sXFH+c+ol8uHKySKgEZBet4T56WjJF0aXvF3lJVvKpoBcRBaq
         H7NA==
X-Gm-Message-State: AOJu0YyXZG7cpFk8wTQngjw1yftkNXsSi0XsSj9Lr1iNNqaZGa7KLuOh
        7svQ1tWGsCl1SvYT9b/r0q8a1n/UjSE=
X-Google-Smtp-Source: AGHT+IFUGhucNwATcOQqRtKs9jimWvzo3jFa5taOzaJM5qnH5558m86dmgYBQt+UNMWTtW+1YT/xWQ==
X-Received: by 2002:a17:902:b40a:b0:1c3:308b:ecb9 with SMTP id x10-20020a170902b40a00b001c3308becb9mr2168069plr.11.1695556846134;
        Sun, 24 Sep 2023 05:00:46 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.9.20])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090341ce00b001bb9f104328sm6732895ple.146.2023.09.24.05.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 05:00:45 -0700 (PDT)
Message-ID: <651024ed.170a0220.74e9f.f8be@mx.google.com>
Date:   Sun, 24 Sep 2023 05:00:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8654259260892268792=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, masumrezarock100@gmail.com
Subject: RE: Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables
In-Reply-To: <20230924111655.36749-1-masumrezarock100@gmail.com>
References: <20230924111655.36749-1-masumrezarock100@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8654259260892268792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=787024

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      33.01 seconds
CheckAllWarning               PASS      36.32 seconds
CheckSparse                   PASS      41.20 seconds
CheckSmatch                   PASS      115.08 seconds
BuildKernel32                 PASS      32.16 seconds
TestRunnerSetup               PASS      488.23 seconds
TestRunner_l2cap-tester       PASS      29.69 seconds
TestRunner_iso-tester         PASS      50.42 seconds
TestRunner_bnep-tester        PASS      9.77 seconds
TestRunner_mgmt-tester        PASS      213.01 seconds
TestRunner_rfcomm-tester      PASS      14.92 seconds
TestRunner_sco-tester         PASS      18.55 seconds
TestRunner_ioctl-tester       PASS      16.89 seconds
TestRunner_mesh-tester        PASS      12.43 seconds
TestRunner_smp-tester         PASS      13.43 seconds
TestRunner_userchan-tester    PASS      10.34 seconds
IncrementalBuild              PASS      30.38 seconds



---
Regards,
Linux Bluetooth


--===============8654259260892268792==--
