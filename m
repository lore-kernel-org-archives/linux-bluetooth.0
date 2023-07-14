Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B619C001DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 18:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbjGNSoo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjGNSom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 14:44:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B579E2D6B
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 11:44:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036d80caaeso14669941cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689360281; x=1691952281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tqu2bxetn8WYs+UeNRGyJM2QO6Bg4lTE289m7SYadAY=;
        b=o5W48DEUgVtjriLbOT9wzDaMHKWcdUcHfPNpVQdL4tTCltrqMuFigy+rO3QWmRd1Yw
         Cm4nOweV254JIkJhCaaYyW7pHgTtCyMfRPu2ZaJojHb6XyImYu3YyUZeAhNXdbLU1C45
         MpAUQ3b8ujuyb/x3Dh5anC1Hqj1XTJU1kM2IqONOKDGBNP8CBHhoW9Hq9fvjIhIuW6v5
         sNLEILZBo9pwtXgtI6ULBN7Ly9McSM+lYMAkcBGCpAnayiY08xWSnxlU9qeDU5fjOBV4
         Py6DcNScGMrZshsoOVUSxYqYM5j0i+aBQszRvsQRJGTDEtPrqx97GuwdtCZ6JlERkCbs
         HoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360281; x=1691952281;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqu2bxetn8WYs+UeNRGyJM2QO6Bg4lTE289m7SYadAY=;
        b=HNXPIvBMCqHVKFI3Fd30LJ8k5Df/w8JPKtiuzgRu5rlmsY8k7pbP2douUPtg29RsDy
         H0+3+SI9YsNFZTKztt4PkE4IagkEr2uLt3EsWBY1L4cZugjok3ZrfkDzzKgXcFcS7V9i
         HNXlhDmc8sNR0yjaKnyE/VF5WP5cqHMacBQ4ssHMSXFd02QFGOTcbaAdq/ZS0ienZhQJ
         a8X84T+BFDfYmVBGN93Jh9yahNqpQxdqe1L0paZWf6qYcn//8PzpINjxHSxkQ7bWlRpa
         hn6ucVLQD/22Yga8Uf2AHyE9QLbesB2C0j8Hx4ZU72d+MEtCFayZoyxJBiBZ1TMJN8OQ
         iclg==
X-Gm-Message-State: ABy/qLbZgoilK/ZhWfjKpmy8njTCPXOcWg8wQu2zKHHTvIwMo5ugvJ1y
        zgaXeNNTNwWN4sBWLbECAAbqbzE2O7k=
X-Google-Smtp-Source: APBJJlE9RqswRB9wGZP2/NcwI8MWIU2e/QgMvxbd+5Y7FRL7TfSkUW5utZoXWLlGBqHs1/e3as4wtg==
X-Received: by 2002:ac8:5c06:0:b0:403:b8b6:49f8 with SMTP id i6-20020ac85c06000000b00403b8b649f8mr4936409qti.47.1689360280711;
        Fri, 14 Jul 2023 11:44:40 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.74.34])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8774d000000b0040353ea0827sm4150959qtu.56.2023.07.14.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:44:40 -0700 (PDT)
Message-ID: <64b19798.c80a0220.baa04.108a@mx.google.com>
Date:   Fri, 14 Jul 2023 11:44:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0529582255077459016=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, robh@kernel.org
Subject: RE: bluetooth: Explicitly include correct DT includes
In-Reply-To: <20230714174057.4041063-1-robh@kernel.org>
References: <20230714174057.4041063-1-robh@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0529582255077459016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765817

---Test result---

Test Summary:
CheckPatch                    PASS      1.15 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      42.45 seconds
CheckAllWarning               PASS      45.71 seconds
CheckSparse                   PASS      51.96 seconds
CheckSmatch                   PASS      138.88 seconds
BuildKernel32                 PASS      40.47 seconds
TestRunnerSetup               PASS      618.07 seconds
TestRunner_l2cap-tester       PASS      29.54 seconds
TestRunner_iso-tester         PASS      61.30 seconds
TestRunner_bnep-tester        PASS      13.65 seconds
TestRunner_mgmt-tester        FAIL      264.78 seconds
TestRunner_rfcomm-tester      PASS      21.98 seconds
TestRunner_sco-tester         PASS      22.34 seconds
TestRunner_ioctl-tester       PASS      24.60 seconds
TestRunner_mesh-tester        PASS      17.53 seconds
TestRunner_smp-tester         PASS      20.10 seconds
TestRunner_userchan-tester    PASS      15.69 seconds
IncrementalBuild              PASS      40.44 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.995 seconds
LL Privacy - Unpair 2 (Remove from AL)               Timed out    4.985 seconds


---
Regards,
Linux Bluetooth


--===============0529582255077459016==--
