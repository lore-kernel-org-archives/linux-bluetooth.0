Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E69C001DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Aug 2023 00:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbjHLAFb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjHLAFb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 20:05:31 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34931FCF
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 17:05:26 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bca857accbso2312473a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798726; x=1692403526;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+tPHGou3prGjNpzXJQqALBk935Nszy8D0NtiOPN0LQ=;
        b=XoTc95WnzuFFQpD/q96e7li+KWLO7sbFqPNZfeK+8DF7hjAJ8MTV356WaUcdN3euuU
         QtWQ5VSp7SQeEjz/bVtRlDyM3ooNE82aGgiEFZwjFlNefiWIC2MYlHWUtg+Zyr/CvDkD
         rfuPl7xc6ZNkIiHhAH6Xvq2VrLI85QYBODbQfi8JwZ/yguOJxmw9Nl6zWSO9HeU05ezH
         HOBQReLVdfc+5tsCtQ3g8XwryzEUrq48iA8lnffBek3tJUnR9PeGU1fa/BwayrDRe2lR
         0Q1+1gOO4NXGFQbg/Q3VUZ3MEs8Hp+vwzydDOd3/6zBZkEFC/dJ7zXxHPdZqGqEXYLx5
         +kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798726; x=1692403526;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+tPHGou3prGjNpzXJQqALBk935Nszy8D0NtiOPN0LQ=;
        b=Oxip4HSpwYOwaD9psKH32vhJ3QryDnxalUyxq0Q3tKtuUw64w8vSGEds0symBnKV7P
         5ZRDkoXzSIidAnNq/L2tj9oO7wE1oGOK4xlLv9VgbZrudpGpKDTfCn6K/dWvioIy+3Ae
         oyIfdoxBWsx6SWH5jxbblWdAJjYOd2GbKffY8Mt+jUSGABvGQJpfSZeXdz1B96xzC3dA
         iJzyqzLogTCqDsyhOgesQIuNyr2u4jGicSMjViWrY9HBxSMCOhczQUk2mCh7pEAf0WEz
         AHLmrn1qy837Ijjdhy81E5EMSPRTtj3Ri/x/oR40UIPUBMShUcfBky0ZoRh6Zv406Vs8
         UG9g==
X-Gm-Message-State: AOJu0YwuReBE6tkvEew+xqn0sVp4LT7UpAXIJRBisE3ojhPiPBOBrMN5
        d/EcFgpaLyXJ2R+h2GBO3B09YleP15E=
X-Google-Smtp-Source: AGHT+IF6+DsiJL5HgKliloYlyKXLyrOG4EcW9JQpetR1pfdT1/babdLIEXNojbgtXn76wFd9OJ92lg==
X-Received: by 2002:a05:6870:e893:b0:1be:9a37:cf12 with SMTP id q19-20020a056870e89300b001be9a37cf12mr3786031oan.42.1691798726036;
        Fri, 11 Aug 2023 17:05:26 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.140.114])
        by smtp.gmail.com with ESMTPSA id a11-20020a4aae4b000000b00566250a04f6sm2058091oon.18.2023.08.11.17.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:05:25 -0700 (PDT)
Message-ID: <64d6ccc5.4a0a0220.6c169.f90b@mx.google.com>
Date:   Fri, 11 Aug 2023 17:05:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3476120935166596496=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
In-Reply-To: <20230811231610.2025814-1-luiz.dentz@gmail.com>
References: <20230811231610.2025814-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3476120935166596496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=775536

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      38.70 seconds
CheckAllWarning               PASS      42.94 seconds
CheckSparse                   PASS      49.10 seconds
CheckSmatch                   PASS      132.56 seconds
BuildKernel32                 PASS      37.95 seconds
TestRunnerSetup               PASS      580.39 seconds
TestRunner_l2cap-tester       PASS      33.28 seconds
TestRunner_iso-tester         PASS      65.22 seconds
TestRunner_bnep-tester        PASS      13.54 seconds
TestRunner_mgmt-tester        FAIL      263.32 seconds
TestRunner_rfcomm-tester      PASS      20.26 seconds
TestRunner_sco-tester         PASS      22.74 seconds
TestRunner_ioctl-tester       PASS      22.66 seconds
TestRunner_mesh-tester        PASS      16.88 seconds
TestRunner_smp-tester         PASS      18.08 seconds
TestRunner_userchan-tester    PASS      14.55 seconds
IncrementalBuild              PASS      35.85 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 495 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.888 seconds
LL Privacy - Unpair 2 (Remove from AL)               Timed out    4.983 seconds


---
Regards,
Linux Bluetooth


--===============3476120935166596496==--
