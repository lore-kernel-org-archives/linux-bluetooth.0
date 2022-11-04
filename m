Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F495C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 08:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKDIDc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKDIDa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 04:03:30 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C12639
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 01:03:27 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so4800029fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=umgpV6lfSdCgSKhjlFTrtnC3ryWFU1MnjsICH5Pq8Xw=;
        b=kD87VooPYRj/0P0NVNBdZnJ7JUAVulN/mjcoPqjPwdtqiXS7ocOIlPm9A2k6V7D/gU
         octlaS+uByDFHbTt3tzEyjxwmWMpw3cafK01wWZ2OQdiu2r5P0IJ/ncr1HG3GgJ6kK+d
         siSyuQ/NzVWNfuHP2qDRfC2Cz80L660mrcAL+kpPfJ7/auDObj0y93HtVxrOVV0HgPrq
         EJeJ+ZX1BoeHZLEUMlR73l2K1h66esaMNdWGCgaRYX2ZXV9ALI8ygVRHYiyyZXXqSg32
         UCPhdz6sDxKN4/2Z1AwUUIVJc8ApT6edMI3CODSOP+qMpAcqalI0dp99LC4Ukn7WZZ3o
         aWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umgpV6lfSdCgSKhjlFTrtnC3ryWFU1MnjsICH5Pq8Xw=;
        b=e6AKsgd5vibqOi285zuhGupAUU9X/GQwZRJrwNQoFnVlo09wFfSe4hlzvqAPnmncbd
         XkIp0ZX+meW8HLKAzgrrAdWVB5vLYi1/QU6k9kcyxhi84V4ampSOlrZpDfw/chQf5DCC
         LqnT6dofTJkwt0J8URa9n6m3wO1P0umTrWyeVmuGZ06iJs69DO7+YH428PYbgqfSgti1
         zURbNDLpeEFiZmh2ap/x2qM5uq4Ln+565xjUpAABcuSqjxrM8AvhzyOHzHuJ8yr+nqOt
         KFCqngKmr5dP1wGOBVMuOmar9cWeMLKr6cr9gku1bMK4tVvbMjtAqgj853rF0Ws7dT+a
         ZDcA==
X-Gm-Message-State: ACrzQf38IYnjr943pQBWXjLWfrrWkhMiyhNt+ZE7m9I2gl9kLn5TmFFE
        1eQX6uZ1hP+2HLaXkwAofI54aSq9MKs=
X-Google-Smtp-Source: AMsMyM5MzzKWU9tyf4jmCt9LZRp7uVun/vCq1EOQkTo8JxQsVEIfCmK0aos7F2hqJXIMem9bmmPlzQ==
X-Received: by 2002:a05:6870:179a:b0:140:74d7:ff5b with SMTP id r26-20020a056870179a00b0014074d7ff5bmr925328oae.131.1667549006409;
        Fri, 04 Nov 2022 01:03:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.202.163])
        by smtp.gmail.com with ESMTPSA id g13-20020a056830160d00b0066193df8edasm1209651otr.34.2022.11.04.01.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:03:26 -0700 (PDT)
Message-ID: <6364c74e.050a0220.d1c17.5bcd@mx.google.com>
Date:   Fri, 04 Nov 2022 01:03:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5491290158671125636=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5491290158671125636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      2.77 seconds
GitLint                       PASS      1.56 seconds
SubjectPrefix                 FAIL      1.47 seconds
BuildKernel                   PASS      34.13 seconds
BuildKernel32                 PASS      30.32 seconds
Incremental Build with patchesPASS      50.73 seconds
TestRunner: Setup             PASS      504.89 seconds
TestRunner: l2cap-tester      PASS      16.86 seconds
TestRunner: iso-tester        PASS      16.30 seconds
TestRunner: bnep-tester       PASS      6.27 seconds
TestRunner: mgmt-tester       PASS      102.15 seconds
TestRunner: rfcomm-tester     PASS      10.00 seconds
TestRunner: sco-tester        PASS      9.37 seconds
TestRunner: ioctl-tester      PASS      10.59 seconds
TestRunner: mesh-tester       PASS      7.63 seconds
TestRunner: smp-tester        PASS      9.48 seconds
TestRunner: userchan-tester   PASS      6.41 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 1.47 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============5491290158671125636==--
