Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B307EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjF3PiC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF3PiA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 11:38:00 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20BFB4
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 08:37:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b73b839025so1663098a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688139479; x=1690731479;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X6eNdFMzqm1g/spLAH6TbBAwwOc9LyCfbsAJKTK8QbE=;
        b=TbK1HnmFAIjOFJ2tX6FM4+L9gxzBrkYKPxXHaeTcA/CUxQYr1tzKU6y7pBMhK3oryU
         C9X4Hcl/dxLEjgOpgvYMI96oW3guAqyWq7Huepzwsi4S/JYU1iwJ1Wkt+Q7lO9I4n369
         MnwJpThGJXT9Yx1kj8p6UFbGb1lddR4OO1y4TTB3sqPLNRD2XpNkyOgbI5MBsQaQgg7/
         EUvm4fsHAZTK5DNTc94cNULX9gH5OCqzwux+Rd7KgiJAN3jgnmA2f5vAE5t3MeswZPXK
         Je9pNttFqCoL5jV58bnTjX6R8m4aEhgz6mWq+TA5U3YZA5sZFmPelfdtorWOEFbczOrH
         taCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139479; x=1690731479;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6eNdFMzqm1g/spLAH6TbBAwwOc9LyCfbsAJKTK8QbE=;
        b=HhBRyUP0DsuF0gkMjynHpBpEc7bAnQO6wM2byx3QeXjlvZmoqCCQgFnYT7tD3Pykgx
         oH2TzE8/krVGI+IWAeHniHBn6N59KmmhALg2rrlQvttbOX5W58xpEJqTQ+WhgePlVZL4
         gd7vKqxLJHA2Zu3Bk/qAhG2Z3k32eIAs8Rp8S07iHSNGCMtv1ZD5lX0RZ+ZbrEQpc7EC
         KMGZL6zSZF9+bEVRbKgcuex1M6cBsXeJKidTHz1SkQA/nwLxsR/nKDwz/IJZpUVs7msh
         yYSA/76CroWKaO0JaMUTMdY79BEX2fWt6T+CVDwcVqlayNsR3ZwpieYBhuC3wKf/4Euf
         eCoQ==
X-Gm-Message-State: AC+VfDwB6TcE6LX15WT3WXIPdVtCG5X6/RQ56R1aDCYx/8KLEPb4xUnY
        2Sb9Tnw04P4/KMCyuSdd0orb3BFhiwE=
X-Google-Smtp-Source: ACHHUZ555qZfVojiT9tc/Jzqnu+ous0eM0DpPHpjFgQHX8vx6V58uut7zf3nyetWxJ2H6tSoSCCEjQ==
X-Received: by 2002:a05:6830:2044:b0:6b8:9224:c363 with SMTP id f4-20020a056830204400b006b89224c363mr3756831otp.17.1688139478909;
        Fri, 30 Jun 2023 08:37:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.10])
        by smtp.gmail.com with ESMTPSA id z15-20020a9d62cf000000b006b83a36c08bsm3848317otk.53.2023.06.30.08.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:37:58 -0700 (PDT)
Message-ID: <649ef6d6.9d0a0220.92703.6eb7@mx.google.com>
Date:   Fri, 30 Jun 2023 08:37:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7794052301864687615=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Notify user space about failed bis connections
In-Reply-To: <20230630144930.216553-2-iulia.tanasescu@nxp.com>
References: <20230630144930.216553-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7794052301864687615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761573

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      40.34 seconds
CheckAllWarning               PASS      44.14 seconds
CheckSparse                   WARNING   49.73 seconds
CheckSmatch                   WARNING   134.10 seconds
BuildKernel32                 PASS      38.65 seconds
TestRunnerSetup               PASS      549.57 seconds
TestRunner_l2cap-tester       PASS      16.46 seconds
TestRunner_iso-tester         PASS      29.71 seconds
TestRunner_bnep-tester        PASS      7.14 seconds
TestRunner_mgmt-tester        PASS      154.52 seconds
TestRunner_rfcomm-tester      PASS      11.29 seconds
TestRunner_sco-tester         PASS      12.48 seconds
TestRunner_ioctl-tester       PASS      12.31 seconds
TestRunner_mesh-tester        PASS      8.98 seconds
TestRunner_smp-tester         PASS      10.21 seconds
TestRunner_userchan-tester    PASS      7.52 seconds
IncrementalBuild              PASS      37.31 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============7794052301864687615==--
