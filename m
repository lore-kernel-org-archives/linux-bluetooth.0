Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D480AC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 03:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiGVDQm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGVDQl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 23:16:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F09121AF
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 20:16:40 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id i1so367150ilk.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 20:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5n9dbPjJJasoYVJc7SCPIN8GgOgCFo/guh/N3SEYw/s=;
        b=IXLcBuh7topQ0Apb9e+Ys5wkya9/zbEl2g7zKR4GYWLtrxKCu8FWr/+VVOLJun+yAC
         wBdDyMHyVasifzCOObNRvjHgXSlddgk+L+2o7NZHLdfm+uaj0P9vhu0mfFyCYeiIFGXJ
         Ve4hhTq+OPO3QmK9Dz2ymndommZZhaCYRrgxeHXMcIJ1J1cQ5tJrD0xD9hg4scnAgjpN
         W4guJmcfjZ2X98HQDvU2bxWCUXCeROwoi+DFrHfWRNo5KGDL2KixWza4p4xD8rWlMIGB
         NZL/MZkMwYCrmH3LJPZiGq+jNGqtbAN2kU7J4Wl7uvsgq1jm5wDeWu8b332xosUPY/aG
         o3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5n9dbPjJJasoYVJc7SCPIN8GgOgCFo/guh/N3SEYw/s=;
        b=z2M+Rqk5MUCbrWlh7xP8D3cmIsd1pNbe6/syojevju6qfXogAiaZzX+9lSBuOGeBn2
         n6NKuYzbIM5CwaudPkKwkgawZbp8WhNSw5XDQyl2TOWUgFeOGGv7dSQa+Cy8okYDEbI2
         WJPrL1+kqANBc3614tWB3SIf3VGQxHwDJU3SD+jyF00zdb6xfqbeHvBwbPisiEdaDEb0
         tCYMrtcN/sEJZjwmcAgH0OQMIub8ZKsgS6UxtsrxUP56I2bkmPN8YtDHcrz6jjRinBxP
         DBaDvj3+QeT3Qs8lZs92GvSfp3kM/WHNI14QqW81DsNqNwy3+/xH0hlUirubkCDKdNtX
         0ONg==
X-Gm-Message-State: AJIora/oIZe3RHi1/+3/qEVhefPrlBxz2yKHJK355w7NbASf+FHPz2iN
        gvpQZ7m4cVK+GLf3ybXSDJuGfONFaPo=
X-Google-Smtp-Source: AGRyM1tncNUV7c1rSkuyjqLkfC0h+BvWsHQSS+lWIG6vbQlV8K6LJAwzrfdRCZgi3Gy35DH0AkDi2A==
X-Received: by 2002:a92:d202:0:b0:2dd:402:1af3 with SMTP id y2-20020a92d202000000b002dd04021af3mr614794ily.152.1658459799143;
        Thu, 21 Jul 2022 20:16:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.9.62.131])
        by smtp.gmail.com with ESMTPSA id q15-20020a0566022f0f00b0067b85bb05besm1618959iow.17.2022.07.21.20.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 20:16:38 -0700 (PDT)
Message-ID: <62da1696.1c69fb81.a3158.1d4c@mx.google.com>
Date:   Thu, 21 Jul 2022 20:16:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7590797139539877012=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, faenkhauser@gmail.com
Subject: RE: Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220722020100.11221-1-faenkhauser@gmail.com>
References: <20220722020100.11221-1-faenkhauser@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7590797139539877012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662046

---Test result---

Test Summary:
CheckPatch                    FAIL      1.49 seconds
GitLint                       FAIL      0.79 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      36.45 seconds
BuildKernel32                 PASS      31.56 seconds
Incremental Build with patchesPASS      52.93 seconds
TestRunner: Setup             PASS      540.11 seconds
TestRunner: l2cap-tester      PASS      17.45 seconds
TestRunner: bnep-tester       PASS      5.92 seconds
TestRunner: mgmt-tester       PASS      100.69 seconds
TestRunner: rfcomm-tester     PASS      9.45 seconds
TestRunner: sco-tester        PASS      9.08 seconds
TestRunner: smp-tester        PASS      9.27 seconds
TestRunner: userchan-tester   PASS      6.13 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.49 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#80: 
Found on HP's website ( https://support.hp.com/us-en/drivers/selfservice/swdetails/hp-envy-x360-15.6-inch-2-in-1-laptop-pc-15-ey0000/2101086013/swItemId/ob-288116-1 )

total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12925888.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.79 seconds
Run gitlint with rule in .gitlint
Bluetooth: Add VID/PID 0489/e0e0 for MediaTek MT7921
3: B1 Line exceeds max length (166>80): "Found on HP's website ( https://support.hp.com/us-en/drivers/selfservice/swdetails/hp-envy-x360-15.6-inch-2-in-1-laptop-pc-15-ey0000/2101086013/swItemId/ob-288116-1 )"




---
Regards,
Linux Bluetooth


--===============7590797139539877012==--
