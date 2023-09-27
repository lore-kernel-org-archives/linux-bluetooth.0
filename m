Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7DE82CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 17:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjI0RGE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0RGE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 13:06:04 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8683D92
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 10:06:02 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7a50a1d1246so4569383241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695834361; x=1696439161; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SNEtZ7lQ1rGNsY4vOGr45QI22udTbZ3xbm1HarE8iIU=;
        b=mBW+DGQA9Dq2pvb1xHw/jYXERA93klCqfg/GbPNXNv7l6W5zmjuI3tPukBMuSuvUBL
         L4/rtZQ+T4Wn76KJZLzzvrMYiVszbcUH2kqBpP/pd8057TMi4eRSNpDgoq7DMtg+YBMR
         AEOKItLdnd1pujAem5wYRlexZ+IOE4bkzd39D1HHej9b0j588NATdDqs7+h4qZP3zQIX
         gCj4pAlkiyBF3q2XTOl8IuguNi8Bo7jQ9Qr328aLiPfk2Bwk0ZqTb4avq7tIVwVpvcEH
         ONLou69mxdQCLI1fwTCcknmTTMyzsjqQ84+XF26DEOS1jo886Z62Bmm2AXv7wYrPKduF
         sdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834361; x=1696439161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNEtZ7lQ1rGNsY4vOGr45QI22udTbZ3xbm1HarE8iIU=;
        b=QfkM1b7Yzhm0iWVnYzuWV4RZqmf63F/7nIlZJPbudjXY2Ss1KksMAn9Bunki7BqsYw
         dm4QC/9NqcZ9D3XtxEkmZCn/WHztNXT+Hr2Q0T5mLmJS801O+JKN5VCUle8jIwpgewqU
         kikWJv2RS9qIxZFVm4A4O091QpKOrCIV49+cmQeaN7DYz/zs3SsJGznMI31wx5vf+x0r
         DK6PV11okkWIb9KPbyv3k2uFUJIi9EV8L7jkFY+1J243UYfDd8DsnODtMGQSNygp1hbB
         hhYxz8Yn2GCVDoPr/Qz5F5RnbdXIK3rKL4dGxVa2d3NofZWHzhOy6fbPZIfIqKE6AsEo
         CJWw==
X-Gm-Message-State: AOJu0Yz2aAmjhQaR5bzoOWIyG04WNIKo9GzyYLTkzbMvcctGKmnYkpJ1
        JGytd/bM+7RJUpNL4W/acfSl1tBtVMs=
X-Google-Smtp-Source: AGHT+IELVTABY0za1GNrMtzRvH0l4CftdQ/HAazVfdtrP1EkQH0dUJhNVrKlMzGnGXFeVW5tjtrwZA==
X-Received: by 2002:a1f:e2c1:0:b0:49a:5545:72dc with SMTP id z184-20020a1fe2c1000000b0049a554572dcmr2383009vkg.9.1695834361410;
        Wed, 27 Sep 2023 10:06:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.163.147])
        by smtp.gmail.com with ESMTPSA id x14-20020ac86b4e000000b004181e5a724csm2073613qts.88.2023.09.27.10.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:06:01 -0700 (PDT)
Message-ID: <651460f9.c80a0220.21cfc.96cc@mx.google.com>
Date:   Wed, 27 Sep 2023 10:06:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1431582336267054573=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dg573847474@gmail.com
Subject: RE: Bluetooth: hci_core: fix potential deadlock on &hci_dev_list_lock
In-Reply-To: <20230927161358.32353-1-dg573847474@gmail.com>
References: <20230927161358.32353-1-dg573847474@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1431582336267054573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788180

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.14 seconds
CheckAllWarning               PASS      36.80 seconds
CheckSparse                   PASS      42.36 seconds
CheckSmatch                   PASS      114.53 seconds
BuildKernel32                 PASS      32.74 seconds
TestRunnerSetup               PASS      501.56 seconds
TestRunner_l2cap-tester       PASS      31.05 seconds
TestRunner_iso-tester         PASS      52.30 seconds
TestRunner_bnep-tester        PASS      10.54 seconds
TestRunner_mgmt-tester        PASS      224.86 seconds
TestRunner_rfcomm-tester      PASS      16.31 seconds
TestRunner_sco-tester         PASS      19.87 seconds
TestRunner_ioctl-tester       PASS      18.49 seconds
TestRunner_mesh-tester        PASS      13.49 seconds
TestRunner_smp-tester         PASS      14.55 seconds
TestRunner_userchan-tester    PASS      11.30 seconds
IncrementalBuild              PASS      31.30 seconds



---
Regards,
Linux Bluetooth


--===============1431582336267054573==--
