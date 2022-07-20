Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6D4C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 03:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiGTDLY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jul 2022 23:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242417AbiGTDKw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jul 2022 23:10:52 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52A7AB1C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jul 2022 20:08:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n138so12126130iod.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jul 2022 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tAekEPxBk+zOiyfXcS4QMftqKgjMWB028UeBqlkuxcY=;
        b=nZd7o7NhdfZtua1i4hDWi2xRg90Xd4qcO1un5W2lJG855S9tqUgOWMcnANZ0n3j9Rf
         DFx6HaLFvtWmuvrwunowPVYvpCaW099gZcMqBSiP6NkiGHP+k3AfkcAxAqJpEyyLBLMD
         XffaHdv3/fKUp9ndyay11RZRj1pJeoxlZ+zumzDRb8u1vQQPDmGyi6929BtkrNXY21r2
         OSPScfmmLjFzyYpl5qMlz6R+7WruqgQgAxPoQmfiJp/wgP1yzJh/RxAR0qiEv/9RdOq4
         QYcUuReDrmQ4a9FHB02Oo2RTHwbX8fzuU1LTx67r3PSsUVG6tWfK/TlXEiV9tTqIkaON
         nNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tAekEPxBk+zOiyfXcS4QMftqKgjMWB028UeBqlkuxcY=;
        b=w0s3ynmL2/tSuWa62kYC87Vb1jZfgijCLN33cw206xXs+m6DfkP8wDRGLonLaJrwhI
         UpnuMTW/f+rHCcNGKjOI4rniB3Y+gXiffxXYZzFD83IjLsvUt8U3dM2089s/x8St/B1h
         YAg0vm6i2Q3tw+2OrX1jr0GFKCTzh+Mmx+28aoW4IpPA6NYE+hd3LkLdwG2/aj+gBxTm
         putIuJPBg7XEhnFlhez8VXnNsGdpJkpMYHIjuU8VC3ByiYIufzmVFW0kY1ilZo11aGd7
         06l1uKQ/Q1nPMDPaJDamZYRnVGfe55TdYaFSnONBiwu21eImr/88kdPrid10TfKuwnu1
         9a/Q==
X-Gm-Message-State: AJIora+6xXtUUtTiJ/UZy5U9jqIB70Z/l1cZ6LyMooFq/1nZ0SAPmUJJ
        QXEaIqirfMBx+vA10YYHFvOUbOMrgAA=
X-Google-Smtp-Source: AGRyM1vOA3vDyoSnZ3ib8zRkirIMC+jr+Zvq9Vkr0IcjMMlw4LsG2V/7q7fgaR8EUrZ7q9TQYSMV0g==
X-Received: by 2002:a05:6638:3820:b0:33f:7caa:7912 with SMTP id i32-20020a056638382000b0033f7caa7912mr18382999jav.227.1658286480039;
        Tue, 19 Jul 2022 20:08:00 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.5.91])
        by smtp.gmail.com with ESMTPSA id n14-20020a056638264e00b0033f5c35704esm7414290jat.54.2022.07.19.20.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 20:07:59 -0700 (PDT)
Message-ID: <62d7718f.1c69fb81.55c6.7e70@mx.google.com>
Date:   Tue, 19 Jul 2022 20:07:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0617153077713217335=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, faenkhauser@gmail.com
Subject: RE: drivers/bluetooth: Add PID of Foxconn bluetooth Adapter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220720011002.5221-1-faenkhauser@gmail.com>
References: <20220720011002.5221-1-faenkhauser@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0617153077713217335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661295

---Test result---

Test Summary:
CheckPatch                    FAIL      2.63 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 FAIL      0.63 seconds
BuildKernel                   PASS      34.64 seconds
BuildKernel32                 PASS      28.81 seconds
Incremental Build with patchesPASS      40.77 seconds
TestRunner: Setup             PASS      494.12 seconds
TestRunner: l2cap-tester      PASS      16.89 seconds
TestRunner: bnep-tester       PASS      5.67 seconds
TestRunner: mgmt-tester       PASS      96.20 seconds
TestRunner: rfcomm-tester     PASS      9.09 seconds
TestRunner: sco-tester        PASS      8.71 seconds
TestRunner: smp-tester        PASS      8.82 seconds
TestRunner: userchan-tester   PASS      5.79 seconds

Details
##############################
Test: CheckPatch - FAIL - 2.63 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
drivers/bluetooth: Add PID of Foxconn bluetooth Adapter\ERROR:MISSING_SIGN_OFF: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12923221.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL - 0.63 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0617153077713217335==--
