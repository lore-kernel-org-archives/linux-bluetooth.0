Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BC2C83F18
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Aug 2023 09:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjHZJCw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Aug 2023 05:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjHZJC3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Aug 2023 05:02:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21838268F
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 02:02:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4121b5334f3so1499761cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693040546; x=1693645346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ2ibpzQ+8fiDoSS/oUdE80stplFGVJx5b4GJ35X7Lk=;
        b=EHJXsOQZAdDMbkausRb/MlACy6hlFbcP5+Fh3fqPqY+kFblc513dQnjCodKbwhHClR
         w4f41x3qrQ7GdIEm0CuOImchJSF0LK9R6f4TRh9HW3r8q3+0U2VcqnLz4oYwjdffA/oJ
         9SxFMKoUVNRLDqm1JqlRzOUbQT8dYTUQOmU+TCMnyCnEEZQwbAWVZk4ioTc0ur0zQTG1
         D2Pb4TcAzB8CBDvHr7SRHGohAtctNRRvdpOhpGmu/NYqL0cWrAh4hVYpzfUAqbhmk9jK
         RrZkv5SpJ/BVwrptoPfeT8A9Oa2MpBANNLuzaQ5yJM1yCKk8UkHmulYRag+K0f+kLrgZ
         Gzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693040546; x=1693645346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ2ibpzQ+8fiDoSS/oUdE80stplFGVJx5b4GJ35X7Lk=;
        b=ZvNxtZGbwnhj46xcYWnmADEKQdTHcJX7oK+ac6t28Rqjom1qOIdF4EBODcXA3m1EB6
         vaDyiLy/nDImRvuYQAMxUUnMitoZagQmT+IR7BHOegxF9QAwoKWh7svvtBRRi/WzsVq9
         AC2kgrf1yHqYh1KIXZOdIc6/gu/JtDht/vZJCvf/CLJ8gQbcnZbxzDBrerm+1it1Fd/F
         2bBg+IF1vUpwyYLg6I+x7QGYW2r8BGp8F4aI3ORyF17V11N8DlRh98CUjuSLqid0NXGu
         YD8uRclTj6qLjS8jOAJGo0UvH1aTcJ3zw5mIe4VMXXRmTmU1uuX7YJ8hTpyjfTvGS6Wu
         P/gQ==
X-Gm-Message-State: AOJu0YzMujCtCzHztuwYJQV+Nxlogi6+hSrmK6lJl9cfbB7P/NYIZnVm
        oBijDJ72ECeoEOXKZ3wzXfJWZuWwoC0=
X-Google-Smtp-Source: AGHT+IGrtPf2wvH7aPTlwZeKv5g7XZN2csSp0qnij9IsknkDpi/MZl520lNiJ/cIDOdKjfPRkWon6g==
X-Received: by 2002:ac8:7f47:0:b0:410:9c04:84eb with SMTP id g7-20020ac87f47000000b004109c0484ebmr17072298qtk.17.1693040546082;
        Sat, 26 Aug 2023 02:02:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.126.61])
        by smtp.gmail.com with ESMTPSA id z25-20020ac86b99000000b004108c610d08sm1009824qts.32.2023.08.26.02.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 02:02:25 -0700 (PDT)
Message-ID: <64e9bfa1.c80a0220.df015.44d2@mx.google.com>
Date:   Sat, 26 Aug 2023 02:02:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5130158513878729622=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [1/1] Bluetooth: Delete unused hci_req_prepare_suspend() declaration
In-Reply-To: <20230826081313.3431523-1-xiaokeqinhealth@126.com>
References: <20230826081313.3431523-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5130158513878729622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=779560

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      34.55 seconds
CheckAllWarning               PASS      37.56 seconds
CheckSparse                   PASS      42.81 seconds
CheckSmatch                   PASS      115.88 seconds
BuildKernel32                 PASS      33.27 seconds
TestRunnerSetup               PASS      503.60 seconds
TestRunner_l2cap-tester       PASS      28.71 seconds
TestRunner_iso-tester         PASS      55.72 seconds
TestRunner_bnep-tester        PASS      11.30 seconds
TestRunner_mgmt-tester        PASS      226.50 seconds
TestRunner_rfcomm-tester      PASS      16.89 seconds
TestRunner_sco-tester         PASS      20.33 seconds
TestRunner_ioctl-tester       PASS      19.27 seconds
TestRunner_mesh-tester        PASS      14.27 seconds
TestRunner_smp-tester         PASS      15.26 seconds
TestRunner_userchan-tester    PASS      11.91 seconds
IncrementalBuild              PASS      31.63 seconds



---
Regards,
Linux Bluetooth


--===============5130158513878729622==--
