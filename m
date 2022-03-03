Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 23:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiCCXF4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 18:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiCCXFz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 18:05:55 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D03B1A398
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 15:05:09 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id s1so6112918plg.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Mar 2022 15:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0rjVTAY/+PvZWNu9kV2z7bYdz12qsHvcveThNMhsXpI=;
        b=bB2HiSm8ycJnX4vwi0u6SG8Dt7gi8xKl5hEXDa2/m9Ozw54f6EbvyJO1qZf6Eqj01/
         3UfGdrIjm5B9rlreYWNkKXyontvN0frSm5N1SSvdZf3iOT+1vnWazGgkzU/ZMFxrsv1K
         Saebp0WzKUdPpajTXv9oNHXswVYqZ+hV7DMoVcoLy8YECfSbQkmaN4JMfpjEjs8Utct0
         pGjMzH4V+zYjNUT6e/lN+H6o2HzOGhn6PuaPhU2TWU8wpLC+6mS7Z+y5HsfmzCAujoLi
         xo5w60EAJ7g0mdh0bRuCJ3qYLgEwq8xHCUsNJhTpfDqrXK1Pmkq98hn5tF0T4Xu67q57
         kXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0rjVTAY/+PvZWNu9kV2z7bYdz12qsHvcveThNMhsXpI=;
        b=N1Ga/L4bLiJpmz0QtA1F3ZyQX3k3CGpNYUpnah8I1V/11Auhbhw4MA+iKf5oqr7iS1
         fs3tpQ/EAB328SQYBfWuweJ4U5JrOn7T+IGX8UP8FAynwfcJxr0Fvf/AZwhuqx7lQrkg
         /suBOxRakyrw4g22Z1wy//nWLcOmsoqB4Hi5FUHQXL4tgX5VZrOOxWogsAGOUg0q3opm
         bO51QFXrAH7OZIsWWCAuT8CKEXmVXbLqFbKnyBrYCz9uCjfH8u+CmPbzHfbZuvdcFZI3
         54oMh0UZNRpqqg5xKGnOjC2g2r1mWkTu2gTcEGbdZnQWAi4coJ6xMlUmniDZO/5alvZf
         RbaQ==
X-Gm-Message-State: AOAM5308YNvttN2gRnZb/ptbdCTcGuPmEnLwWuBwsK++z+vDaArzhlj8
        Ykj1URaK6g8agW9qz/KCliqcZbdTAyM=
X-Google-Smtp-Source: ABdhPJzDPTCNsr5w/xKaa3VWN1muNJ7NpAI2RZH59MdfZL3+2+j7PgkTwjLiOb8lQKYr0MwoDUbqQw==
X-Received: by 2002:a17:90b:4b10:b0:1be:f727:806b with SMTP id lx16-20020a17090b4b1000b001bef727806bmr7728248pjb.18.1646348708516;
        Thu, 03 Mar 2022 15:05:08 -0800 (PST)
Received: from [172.17.0.2] ([20.118.164.131])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm3837356pfu.40.2022.03.03.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:05:08 -0800 (PST)
Message-ID: <622149a4.1c69fb81.627fb.a1da@mx.google.com>
Date:   Thu, 03 Mar 2022 15:05:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8825846669454872176=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/3] Bluetooth: btusb: Make use of of BIT macro to declare flags
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220303221709.387865-1-luiz.dentz@gmail.com>
References: <20220303221709.387865-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8825846669454872176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=620130

---Test result---

Test Summary:
CheckPatch                    PASS      2.97 seconds
GitLint                       PASS      1.62 seconds
SubjectPrefix                 PASS      1.26 seconds
BuildKernel                   PASS      35.42 seconds
BuildKernel32                 PASS      26.94 seconds
Incremental Build with patchesPASS      72.59 seconds
TestRunner: Setup             PASS      479.12 seconds
TestRunner: l2cap-tester      PASS      13.62 seconds
TestRunner: bnep-tester       PASS      6.17 seconds
TestRunner: mgmt-tester       PASS      104.98 seconds
TestRunner: rfcomm-tester     FAIL      7.53 seconds
TestRunner: sco-tester        PASS      7.74 seconds
TestRunner: smp-tester        PASS      7.62 seconds
TestRunner: userchan-tester   PASS      6.40 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 7.53 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.153 seconds



---
Regards,
Linux Bluetooth


--===============8825846669454872176==--
