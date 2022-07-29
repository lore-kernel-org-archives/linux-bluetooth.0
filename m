Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF825C00144
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 16:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiG2QMC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiG2QMB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 12:12:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505F48C93
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 09:11:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o12so5020947pfp.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Bt4wccYnHS2AxbOygAUgNaEQg+sNfjRV1RqmdaX5vkY=;
        b=EPsmud3ZPwSftzv2GSpgsFK4xeuRSpXjyTW2aluS+X7XgS2Z5Rb2thLN1gojkt+khf
         bThzgFBMQ3Es069ITLdfiZEoCmc0fh6hGX4u7UUe6xNVq3RvFpZD0/Ng5OfgRG8KlsC1
         vjMkx+S4yaJ8jgf8Hbhd9WOUHJ1mkPQDkvkqjbyygjCr4A/QegXq0x7lofQS8Posmu7l
         ndBxMXyMDSb2T1/kFfvqYHibbo2MA3Rm2XHNzu3nxJ/ZdOAhhc0r4YhEgtUEup3qtF3F
         TeFnK3gGFOwiDhef6MkVQwkznmG8eoBfDDOofwmDmLjzNMKo5KyS6Td6/JCdlmj+eZx4
         ZQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Bt4wccYnHS2AxbOygAUgNaEQg+sNfjRV1RqmdaX5vkY=;
        b=WFdaG5z+PFlGKpEkEasVLQNbmM2FlAvH6jg2bijWDcvvAZtIlTCv1xo0rq9gSe7LcR
         S9+fqopMKfcAat/tzoP4M8C1+XcxiV+pklMMNY/lDEZkapXH6oKwVXN/LZgWjzRBa3SC
         nwaXKi8qpu70a5ztIXOp3gNBSNeMUKKE3QJM+FakTu8xZcBsqyS+7fZ0BO5v0kEpDDcX
         k1Pv7StgdXyRVkuO9I0WWw6a5U6mED9KYcHGLyEZhixMvFGJy3Y33n6XmESIfaxSePV7
         ncfsCqFiF56EsHud75jtXKN7GOQfVYtO9R15PDy5jvlCMe1nqPcfJIl5nIAB1XjFlN1i
         0Xow==
X-Gm-Message-State: AJIora+DngikpOwdTAsPOD6nrwruqHu+t+4nRF7QBGqriOU8S3i9mg67
        PHe5AQ9ie1NCN7jesuOZN7aebW0VeS8=
X-Google-Smtp-Source: AGRyM1sNKTPPLECoybm6aaIabBTRrZXUA0oKVLDD6Wng3jCJgDNdxngcMzwuMlGnVT9m1++9PJq4ug==
X-Received: by 2002:a05:6a00:2312:b0:52b:928:99dd with SMTP id h18-20020a056a00231200b0052b092899ddmr4100908pfh.77.1659111117285;
        Fri, 29 Jul 2022 09:11:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.167.139])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7984c000000b0052890d61628sm3069758pfq.60.2022.07.29.09.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 09:11:56 -0700 (PDT)
Message-ID: <62e406cc.a70a0220.181a1.4afc@mx.google.com>
Date:   Fri, 29 Jul 2022 09:11:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4994483733252333795=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [RESEND,v3] Bluetooth: btusb: mediatek: fix WMT command failure during runtime suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <96994209776d6643585426b4341bbe2dcd9f5116.1659105441.git.objelf@gmail.com>
References: <96994209776d6643585426b4341bbe2dcd9f5116.1659105441.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4994483733252333795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664093

---Test result---

Test Summary:
CheckPatch                    PASS      1.81 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      39.40 seconds
BuildKernel32                 PASS      34.29 seconds
Incremental Build with patchesPASS      46.34 seconds
TestRunner: Setup             PASS      563.81 seconds
TestRunner: l2cap-tester      PASS      17.85 seconds
TestRunner: bnep-tester       PASS      6.79 seconds
TestRunner: mgmt-tester       PASS      105.84 seconds
TestRunner: rfcomm-tester     PASS      10.14 seconds
TestRunner: sco-tester        PASS      9.90 seconds
TestRunner: smp-tester        PASS      9.74 seconds
TestRunner: userchan-tester   PASS      6.81 seconds

Details
##############################
Test: GitLint - FAIL - 0.55 seconds
Run gitlint with rule in .gitlint
[RESEND,v3] Bluetooth: btusb: mediatek: fix WMT command failure during runtime suspend
1: T1 Title exceeds max length (86>80): "[RESEND,v3] Bluetooth: btusb: mediatek: fix WMT command failure during runtime suspend"




---
Regards,
Linux Bluetooth


--===============4994483733252333795==--
