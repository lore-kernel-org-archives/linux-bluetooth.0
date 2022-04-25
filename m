Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9741EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Apr 2022 03:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiDYEAr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 00:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiDYEAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 00:00:41 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48335AAC
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Apr 2022 20:57:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id ay11so9564600qtb.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Apr 2022 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=q8EHtyqbOZZ1mLehoEkfXE2ylwvKIneqK4tXb+Acae0=;
        b=NSHhW9c8dM7oHsfm8HzHKy54oqgJjLFZEZ9rJP1tvmy91GamD8pCYo9GSO5LHv+2dN
         gb5pnHviTinRIp9SdMSdf4oDoiCU+/pMSu7B0Ni84eZTcSphdGEKYk/HpkKzmBlQOK1y
         OMawLHiA8HsqaQteNffvm4yQb7jWxnjzHRM9WjDq7SCCo429xFXDjAIepoX7iT2VkTqg
         BDFj/HNMi3pitJvN//Da0B0+85Cj7MdSJn2Ivv0h22Chnl6SHjOUHUISRQqvf0bBfGjz
         kaoobK9UgwIVntafyCrirI/kSGP53K7MkBLHB82eb1YRR0qmkTPAGCho4uhQazFwhIu8
         l54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=q8EHtyqbOZZ1mLehoEkfXE2ylwvKIneqK4tXb+Acae0=;
        b=K1EQNsB6mAa66SLMBSqqxy97h0BqtCGDjlq2PbqdtUgr8mPbsneDDcoOG6oYps8G8I
         dHMvQAg7un5r6RzcA1iSPm3sBe73LnReEwFwT1+4mpUmUWh2b2kPCjE29f6tX1X2C8hA
         OkoxO0EnEfbjuM02QlTv2cAWRVKr0dO78eQ61+JXcNQhwGlNW/216fh00o1S3d4hFVAH
         mi9MURhdWTKZmsX4ieDRGJDvVEcJosjKqzmSnkmkFXkYZl0KvbO28IaSqjY9qzIZ2P9j
         +ec+LC5EfztRKJ8yv3MEoyQQ+f2Iq/+pqLAsR2GPdEnl5Tfw+uHKsdJB87am4l8OUxaT
         DsMw==
X-Gm-Message-State: AOAM532YJ++ybFquwAaCWnYtgA7VcYCjj6eChRdmW1yakrWT7SpDeDdQ
        EaWNv3JRl4TScFhU0/XGRLEh4lONGyOQEA==
X-Google-Smtp-Source: ABdhPJxnxhsmO/5IGupJbHhi/ves2+01BN0JHHoZSxSOr+LjizG61JZV/dbucleVj6u3Ljob7d0TJA==
X-Received: by 2002:ac8:5b95:0:b0:2f3:6d44:9611 with SMTP id a21-20020ac85b95000000b002f36d449611mr399151qta.163.1650859055738;
        Sun, 24 Apr 2022 20:57:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.40.246])
        by smtp.gmail.com with ESMTPSA id b17-20020ac87fd1000000b002f34449232bsm5962056qtk.9.2022.04.24.20.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 20:57:35 -0700 (PDT)
Message-ID: <62661c2f.1c69fb81.9d03a.ffd3@mx.google.com>
Date:   Sun, 24 Apr 2022 20:57:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8326595720246713578=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ian@linux.cowan.aero
Subject: RE: drivers: net: bluetooth: centralize function exit and print error
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220425030053.517168-1-ian@linux.cowan.aero>
References: <20220425030053.517168-1-ian@linux.cowan.aero>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8326595720246713578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=635140

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 FAIL      0.83 seconds
BuildKernel                   PASS      31.73 seconds
BuildKernel32                 PASS      29.18 seconds
Incremental Build with patchesPASS      38.44 seconds
TestRunner: Setup             PASS      474.46 seconds
TestRunner: l2cap-tester      PASS      17.79 seconds
TestRunner: bnep-tester       PASS      6.41 seconds
TestRunner: mgmt-tester       PASS      104.80 seconds
TestRunner: rfcomm-tester     PASS      9.90 seconds
TestRunner: sco-tester        PASS      9.63 seconds
TestRunner: smp-tester        PASS      9.66 seconds
TestRunner: userchan-tester   PASS      6.67 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.83 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8326595720246713578==--
