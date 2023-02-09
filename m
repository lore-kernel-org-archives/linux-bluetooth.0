Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313F1C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Feb 2023 07:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBIHCi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Feb 2023 02:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBIHCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Feb 2023 02:02:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB293EFE0
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 23:02:30 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o13so1266240pjg.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Feb 2023 23:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Iq3a/eNQKwZgNLpFukrCQWu3W5sBS3qZhytbQJBcQ=;
        b=DleWXXndwnCZWaxsOs3F0ysk1JXUOSM+kOh1D7ORKcpZXu69FZjzNl1F59Fmbvw1X2
         RUKCBaFptQFbVgoelAIP+sUPH9RNfK5Hh4shEUUTIMISipJJhOrNCD4MUzeBhWecAsus
         VTgAXEIK8OhPagUSU0fvfwnKpeEnfmkngYa6w4W/aBfGttRHxkQW+qUatxYdm/pYUvtm
         lmk5/7Rh22HHXAcNZEBMiElaTLBhN1R6dW4aP0gfAOZ5ZpAUwjKqAwC4LeTdDq02efbR
         eaNYsyqIzwZwhubQwrGkTyW543bNHr+I8gfry5UGLlcVV/La3QLLaht/VLzVt/8ay6Wo
         cybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0Iq3a/eNQKwZgNLpFukrCQWu3W5sBS3qZhytbQJBcQ=;
        b=xdqC5zNfncrW+nV/FeDF92F1aEXc2fEYRMxKOvYO7w08H7dznq9Xmg1TtufMWKomAM
         nOSg0QUefL5r6g4v3zz7ML7Cm1LouPT7qineuSP2iDvnrYmPlSsfX3kVdL6TXiFy/KzY
         s3/Mq4nvKFaiU0IMEc67nnpPMaXmVnFo8m56m2BnxR5S/BpvYc6Ncq5leL+P6pI8889D
         AiI0ZlZuh0F3o0VjvMipS7W71Dt5MZ7Lve7oBHZdG3l51He2wPRs40AE/5Ga6ePUjwnb
         dKVrH1SOFjvry3+tJD9cVv6uaSU9LzUC4uGOjmtYUuvxzrXpcyZDf3jTqY2uwaP6BlkB
         6CQA==
X-Gm-Message-State: AO0yUKUC9Rqscznvy+6wnsC4KpHsLW/V4nwfxDTgFMq4EdDLKVzj5fdy
        V8+2leTKkKPesnmrFN+rbiPAE3gIeBU=
X-Google-Smtp-Source: AK7set/5qA9y6Cec6qDnOx5sNzgdGzTXjAVn66pRkiOQ9NMvA3w6/nBpF7keDzhoidrneTsB+icjdA==
X-Received: by 2002:a17:902:f1d3:b0:19a:5a0a:85b with SMTP id e19-20020a170902f1d300b0019a5a0a085bmr994491plc.66.1675926149494;
        Wed, 08 Feb 2023 23:02:29 -0800 (PST)
Received: from [172.17.0.2] ([20.171.107.98])
        by smtp.gmail.com with ESMTPSA id s11-20020a170903200b00b00188c9c11559sm654013pla.1.2023.02.08.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 23:02:29 -0800 (PST)
Message-ID: <63e49a85.170a0220.a48fe.11bc@mx.google.com>
Date:   Wed, 08 Feb 2023 23:02:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4295437578417026057=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, victor@allwinnertech.com
Subject: RE: [v2] Bluetooth: btrtl: Add support for RTL8852BS
In-Reply-To: <20230209063438.49788-1-victor@allwinnertech.com>
References: <20230209063438.49788-1-victor@allwinnertech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4295437578417026057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=720188

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.86 seconds
CheckAllWarning               PASS      34.35 seconds
CheckSparse                   WARNING   38.28 seconds
CheckSmatch                   WARNING   106.76 seconds
BuildKernel32                 PASS      29.91 seconds
TestRunnerSetup               PASS      429.78 seconds
TestRunner_l2cap-tester       PASS      15.85 seconds
TestRunner_iso-tester         PASS      16.53 seconds
TestRunner_bnep-tester        PASS      5.39 seconds
TestRunner_mgmt-tester        PASS      107.72 seconds
TestRunner_rfcomm-tester      PASS      8.60 seconds
TestRunner_sco-tester         PASS      7.92 seconds
TestRunner_ioctl-tester       PASS      9.21 seconds
TestRunner_mesh-tester        PASS      6.74 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.60 seconds
IncrementalBuild              PASS      27.94 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4295437578417026057==--
