Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9816C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jun 2023 13:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjFIN5P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jun 2023 09:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjFIN5N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jun 2023 09:57:13 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E8198C
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jun 2023 06:57:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-777a4c8e8f4so83708739f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jun 2023 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686319032; x=1688911032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OvKcjcn/QT1mwkwCNHu2EVohpss9TwbAJZwtm4h/Lug=;
        b=d2Dnu1Y2YPITi8yA8JhXVVTSq/JEda5I2EZ4MuzLUWVY5IxLwIy8Pv22lWJz43etkM
         PPFMP1gQVqJv4d9S113gon2bPqvka9YXEEdzByMMYSxv11H/N9DHJOOWJtQz7qoLRozH
         OQzn+SrooMr8HZ1xHCx82tJO14W7MrrmJlMceNPa85zYAO5jMu0x5FuOCBi3oetAim2I
         je4WAwV0kNAT2U/d/QM1+//xaR+1CcknaR6PpOG3ZUY5PcMTM6fDJojDmcwwUDJcsfwK
         Aca6KnhHZn1qAEERpKV175/0wHDB4i/JvuImGnbNkHgdM3x6htWGF1fSjMZ+v2cGhvwq
         nydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686319032; x=1688911032;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvKcjcn/QT1mwkwCNHu2EVohpss9TwbAJZwtm4h/Lug=;
        b=PLZhvVeBxCK5LGh3zIRHYFaHgRzXoWmrczgMm2jOBxuNZXA+hHBE34bc3FBq/N4yE1
         A5U7iy6wpYQu94FYGu4EeqVVTlSjnwIpU4P0Glq3DCIgwyOMt7T7ePafjhxs+I3qnnWU
         rUzzrGJrN3Z5/OitqptCrDSLtbZ5pXupauyVD9FEqngtHjvur5FghXFAlEzYlBgs16cg
         dA8CcPGE8Nn8xyGw/edCPBW4L1npTcy61xgyWAVihGEJQ0oPAMfvEwuD9ypbdBFn0fXf
         KfgHYzBoY+UhDbLzNdRBVXGZxe/f9TjQ58jGgmRZ5QpSliT8V+rRmx+EBrHdOK1ijeb8
         oYVw==
X-Gm-Message-State: AC+VfDyfgK1ClWqUvIWd4l3xQy9SagiqcW2E5v6JSFPt+4INByGTeEYL
        nshhhZtKCJ6eGNXoUTuIIBwiSQ954fI=
X-Google-Smtp-Source: ACHHUZ7PnrYbi9Kv9g6g+Mv/BcQA7isn4rN2lM6GzqJwegpsOwZ8ZLlm8NN3J4mBlVqUQVLIhgd6sA==
X-Received: by 2002:a5d:9644:0:b0:77a:cfbf:1d8f with SMTP id d4-20020a5d9644000000b0077acfbf1d8fmr1958776ios.13.1686319031799;
        Fri, 09 Jun 2023 06:57:11 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.22.99])
        by smtp.gmail.com with ESMTPSA id h4-20020a6b7a04000000b007701de8bb96sm1055520iom.54.2023.06.09.06.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:57:11 -0700 (PDT)
Message-ID: <64832fb7.6b0a0220.83447.18b6@mx.google.com>
Date:   Fri, 09 Jun 2023 06:57:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8293235141380024246=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, xianting.tian@linux.alibaba.com
Subject: RE: fixup potential cpu stall
In-Reply-To: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
References: <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8293235141380024246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=755724

---Test result---

Test Summary:
CheckPatch                    FAIL      2.07 seconds
GitLint                       PASS      0.89 seconds
SubjectPrefix                 FAIL      0.60 seconds
BuildKernel                   PASS      31.52 seconds
CheckAllWarning               PASS      35.09 seconds
CheckSparse                   PASS      39.28 seconds
CheckSmatch                   PASS      110.54 seconds
BuildKernel32                 PASS      30.66 seconds
TestRunnerSetup               PASS      441.30 seconds
TestRunner_l2cap-tester       PASS      16.46 seconds
TestRunner_iso-tester         PASS      21.93 seconds
TestRunner_bnep-tester        PASS      5.33 seconds
TestRunner_mgmt-tester        PASS      112.39 seconds
TestRunner_rfcomm-tester      PASS      8.67 seconds
TestRunner_sco-tester         PASS      7.87 seconds
TestRunner_ioctl-tester       PASS      9.21 seconds
TestRunner_mesh-tester        PASS      6.80 seconds
TestRunner_smp-tester         PASS      7.86 seconds
TestRunner_userchan-tester    PASS      5.59 seconds
IncrementalBuild              PASS      37.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/3] virtio-crypto: fixup potential cpu stall when free unused bufs
WARNING: From:/Signed-off-by: email address mismatch: 'From: Xianting Tian <tianxianting.txt@alibaba-inc.com>' != 'Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13273948.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============8293235141380024246==--
