Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99194C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 22:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiBPWCY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:02:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiBPWCW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 17:02:22 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CCCF1E8E
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:02:09 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a28so4636776qvb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=luV+r8LfB0lS4jxL8lK9AxshcjXWfr5+kTHzsKpqBeU=;
        b=GvYRIWejswA4TTTFOe46YysRd3nYPU54rEMvKRbsSZByPgWVIikSp0k3L2VUQAhSkb
         mlhXKDdV9yWe8f2dIVWegAO0yLbljVKfdaTRO9KRo7aIAd2TLMbNn10fjZ04zBWCw0FD
         4C/0/qORw8dSDNl3Nqt4JylRJuObJTxc/rjBur3hLRoBglDYc/XjgmoUknSEaMTHv0sS
         QB/3X2buaH6yY9wpXI1xtsutBn+8cpp9yxQVXeEd2I+3a2QeWIHxmk17mAjrn2GVpEug
         4ec9uHYzMW328rL1XtykE5zhnqU5ESxWy4SXEItFnOsSKf0/W9nF05aU2rZdDPGZTJKM
         3N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=luV+r8LfB0lS4jxL8lK9AxshcjXWfr5+kTHzsKpqBeU=;
        b=VSXnVwmCU6BX5NrprQ43G8S1irv0v+k2v0EUgPyR7A+Y+9j2AEYkuuXPmloNbxtCCH
         LcLHaOLiCGZEY1reIUAZTyUKTwhwYKiTV+bL5bzHuhjbM6pQEEaDykawJlpHkdyi38/g
         ijYnF8rtgp6AqGEAUFN+ZbeSJkbkPgIY1iCHzyXzwJzX0W/+yOqgDFL+7gnNfJv5CiTA
         Fn62QQ9tPpRMy4+3/yb+xXpu9a04aUE+9ojhngFQHjAbPlZUMXqll678EhMD/2A7Lwx/
         dSUZev2rbrOQSSbXzp0fmpfwH64tylEnvSxdLEIOKzjIjvcoZswS6+twkoVLqG+FmWWy
         iFxQ==
X-Gm-Message-State: AOAM532nxKFC9GZh3NjwYVkxL11lehtukbtiVfdfzAXrLk5xQPwp3yQ/
        YNaq8G+zH5L39lJhe+eHg1Mt53rLuRJNCg==
X-Google-Smtp-Source: ABdhPJyNiR31F7/6tPQEo3NuIHuxEmLT6b06P7Hzv6p2OOWHYCcV8FZXrI4TXxv0zORbbsEhBFXLzw==
X-Received: by 2002:a05:6214:62a:b0:42c:411f:6d92 with SMTP id a10-20020a056214062a00b0042c411f6d92mr3384488qvx.65.1645048928281;
        Wed, 16 Feb 2022 14:02:08 -0800 (PST)
Received: from [172.17.0.2] ([40.70.59.247])
        by smtp.gmail.com with ESMTPSA id j11sm22643339qtj.74.2022.02.16.14.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:02:08 -0800 (PST)
Message-ID: <620d7460.1c69fb81.d04b.f26e@mx.google.com>
Date:   Wed, 16 Feb 2022 14:02:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3376780959816499092=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luca@z3ntu.xyz
Subject: RE: Wifi & Bluetooth on LG G Watch R
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220216212433.1373903-3-luca@z3ntu.xyz>
References: <20220216212433.1373903-3-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3376780959816499092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615144

---Test result---

Test Summary:
CheckPatch                    FAIL      1.78 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      37.42 seconds
BuildKernel32                 PASS      32.54 seconds
Incremental Build with patchesPASS      44.92 seconds
TestRunner: Setup             PASS      579.45 seconds
TestRunner: l2cap-tester      PASS      16.06 seconds
TestRunner: bnep-tester       PASS      7.36 seconds
TestRunner: mgmt-tester       PASS      121.35 seconds
TestRunner: rfcomm-tester     PASS      9.99 seconds
TestRunner: sco-tester        PASS      9.33 seconds
TestRunner: smp-tester        PASS      9.44 seconds
TestRunner: userchan-tester   PASS      7.63 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.78 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[2/5] Bluetooth: hci_bcm: add BCM43430A0\WARNING:UNDOCUMENTED_DT_STRING: DT compatible string "brcm,bcm43430a0-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#71: FILE: drivers/bluetooth/hci_bcm.c:1516:
+	{ .compatible = "brcm,bcm43430a0-bt" },

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12749111.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3376780959816499092==--
