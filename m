Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BEFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 07:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjADHBA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Jan 2023 02:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjADHA7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Jan 2023 02:00:59 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC6B296
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 23:00:57 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id t17so12977817qvw.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jan 2023 23:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eRaX9pwusz9LR0nnm4RejGPXLWocpttFvSmXHtItZMU=;
        b=TiTV2IRjvpFTA+wnkX9Js9KLqLSP7TSj1NmB2okCdGCZLG0JhHXi4o+pN3UXTMJF0T
         K2rTBOnMFtxIiSipC+JqwXg7a7G5mBR6gozvPyVC9sfkkmUs3cXw4LPYAkbWPTcWHgre
         LQxzzvK+lhTMjv6aSromuF1Och3GgaXRRk6Sj24ytPN7GYj6xptw8MEOTpt3VsmwBDM9
         htlyNuJ2GilNhRriubIiuriQ1zMshIC1aYAb5kk+FzulxE9iy3oQb7FPOpM90/Ao378y
         6/t8jcD1tfqIVnxu3/T3ZmPa+wwrnPX71o0Jjsz6dEuIW71NYcqF6q60xKiWD2I5NKNG
         0dCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRaX9pwusz9LR0nnm4RejGPXLWocpttFvSmXHtItZMU=;
        b=JWaX4oPaoGpe+Tv/Oz21D6udaiQOMhBgBYw0nw+Er7FZecIRx2cyt+Jql7MJLdtKjw
         XtuyDhSwf5KfvY2o5MEavawJSCdVDHICvCUY+206KbFGn1OWtjJRnZTe5lTvCtdlxWus
         wrkRiFtgKsdURDkfIKUmZtWCDfoauaBvtLpHC2dY+UALx6ZajUoH+emTYeMW4ro9rFwv
         IMe7epH83XMiqhaWT+h16MvSdN8eMI5iDg3HtoiEq3lPL7tjjzUwbxz5J4WEZkwS0zOb
         MUyg7qvwuEqRP4d2UoH0kNAl/JNLNG3nW5fAk2SmYmuEgBs/xChje4Ajqmi6a1thZFT3
         84zA==
X-Gm-Message-State: AFqh2kpf4HXIrZ15SSRBGbJU+ygI54+8t49jguzHZIEKupBUyDzN+TmR
        bAOVetQrLHb5zPTUDskIgE4RiDE5746KfA==
X-Google-Smtp-Source: AMrXdXuFV4Tf6uBaz7RVuY9Dk5+yJZcZN3V+pH3BPaimoAa99kif9bElCcEQEusJg275Lp7vYn2D2Q==
X-Received: by 2002:a05:6214:2c06:b0:4e3:6a82:82ba with SMTP id lc6-20020a0562142c0600b004e36a8282bamr77121768qvb.33.1672815656640;
        Tue, 03 Jan 2023 23:00:56 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.113])
        by smtp.gmail.com with ESMTPSA id m20-20020a05620a24d400b006fc9fe67e34sm23751716qkn.81.2023.01.03.23.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 23:00:56 -0800 (PST)
Message-ID: <63b52428.050a0220.f9d6f.f217@mx.google.com>
Date:   Tue, 03 Jan 2023 23:00:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0825366806258399692=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, shaozhengchao@huawei.com
Subject: RE: Bluetooth: hci_conn: fix memory leak in hci_le_terminate_big() and hci_le_big_terminate()
In-Reply-To: <20230104064623.1140644-1-shaozhengchao@huawei.com>
References: <20230104064623.1140644-1-shaozhengchao@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0825366806258399692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=708675

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.85 seconds
CheckAllWarning               PASS      35.37 seconds
CheckSparse                   PASS      39.44 seconds
CheckSmatch                   PASS      106.53 seconds
BuildKernel32                 PASS      30.45 seconds
TestRunnerSetup               PASS      439.69 seconds
TestRunner_l2cap-tester       PASS      16.69 seconds
TestRunner_iso-tester         PASS      17.27 seconds
TestRunner_bnep-tester        PASS      5.90 seconds
TestRunner_mgmt-tester        PASS      110.61 seconds
TestRunner_rfcomm-tester      PASS      9.14 seconds
TestRunner_sco-tester         PASS      8.44 seconds
TestRunner_ioctl-tester       PASS      9.89 seconds
TestRunner_mesh-tester        PASS      7.42 seconds
TestRunner_smp-tester         PASS      8.27 seconds
TestRunner_userchan-tester    PASS      6.04 seconds
IncrementalBuild              PASS      28.83 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_conn: fix memory leak in hci_le_terminate_big() and hci_le_big_terminate()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "Bluetooth: hci_conn: fix memory leak in hci_le_terminate_big() and hci_le_big_terminate()"


---
Regards,
Linux Bluetooth


--===============0825366806258399692==--
