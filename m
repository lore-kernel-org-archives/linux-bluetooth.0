Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75400C38145
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Sep 2022 16:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiICQM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Sep 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiICQM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Sep 2022 12:12:28 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0FA5726A
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Sep 2022 09:12:28 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11f34610d4aso12020227fac.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Sep 2022 09:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=pKix8NoX8ZN/pF5fHMrlypgAI2z+kkLx/hw9HTAg9EA=;
        b=BeTxq/4jqrQ2jY5mz40Edb7RWAGeukIfiB3TqJklvSf5nZTYZbehk/tvigvEai0DzM
         PDsbUA9+1cC79fWIuafprrv3l8xdzuzpoh09z0vsdz1t6vGSvJUuWro/8FUdW+BsFCV/
         w0LNhMmHCZMkxFwMX45lI512vKTnaoyWtnJgKv5uzUPrM3ljd2+JG+wQkKtFsyMy1Ee+
         jHc0PQxObTmOT0Sub+m5TEQ7tBY5TfCuAixtNQiPf35d8ZH4CiMwpT18nOpuYryCyZSS
         z70zfamaUU9XlKcONDS+hgzCmjiFEimyQOFD3mPN6+nGA8TMEzsE4cy/phDU7oJwtV7u
         ckXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=pKix8NoX8ZN/pF5fHMrlypgAI2z+kkLx/hw9HTAg9EA=;
        b=TRSDzQCSyBZguZynP9VYF95J5C4S+cw/9xcchDXfpKQp9lZfdwBZRl/6DGZfZj+f1M
         +ibfmpt5gsX+BR8BE4PFQWa+r5L1hCJRY8UDmLiQOOMWerEvYwuhOGMg9fnWkshtdzEC
         NkAvsyBLiaLrRkhSw0a4LxTbAi/zLfZ12/R/GVX8H8B7Q8bH3XVRcPnGPqnSfUoyPSQr
         otN4vN73mROO15rAdrTQWFHusGjtV/EnxyvVOVt4bHgeAF2s9RKADVM3o8knqmI5YYSs
         ZYQs3D8pVMBhmi+WQUnPNCvqHflh9qvEsEzBEeGdOkdMCGa6kWD7Ip2em/KF76z0uah0
         uDGg==
X-Gm-Message-State: ACgBeo3DRxGf2qVtqii/nChzR8KlcxNclVaTvpn6h1Ci5Q/QoPXRsFq+
        CQM7UOnkwMOVx9azPhPwv7X3Q06BccQ=
X-Google-Smtp-Source: AA6agR6POfTmbcFQF2rBCHJ81BePe/aOOU5fOTC2TeB969NXJsg0A7PqJBzbaGbsoW27UX1eMgs9tQ==
X-Received: by 2002:a05:6870:a9a5:b0:125:6123:3c64 with SMTP id ep37-20020a056870a9a500b0012561233c64mr3518103oab.283.1662221547138;
        Sat, 03 Sep 2022 09:12:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.116.162])
        by smtp.gmail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm2866903oab.3.2022.09.03.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 09:12:26 -0700 (PDT)
Message-ID: <63137cea.050a0220.c184.bf2b@mx.google.com>
Date:   Sat, 03 Sep 2022 09:12:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2562116144941003725=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <b7d8d14f-6ef9-a2c0-0a7c-cdbdf6f12551@I-love.SAKURA.ne.jp>
References: <b7d8d14f-6ef9-a2c0-0a7c-cdbdf6f12551@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2562116144941003725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673830

---Test result---

Test Summary:
CheckPatch                    FAIL      1.92 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      46.71 seconds
BuildKernel32                 PASS      41.98 seconds
Incremental Build with patchesPASS      60.74 seconds
TestRunner: Setup             PASS      695.46 seconds
TestRunner: l2cap-tester      PASS      21.77 seconds
TestRunner: iso-tester        PASS      22.27 seconds
TestRunner: bnep-tester       PASS      8.61 seconds
TestRunner: mgmt-tester       PASS      136.49 seconds
TestRunner: rfcomm-tester     PASS      12.60 seconds
TestRunner: sco-tester        PASS      12.50 seconds
TestRunner: smp-tester        PASS      12.46 seconds
TestRunner: userchan-tester   PASS      9.00 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.92 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: L2CAP: initialize delayed works at l2cap_chan_create()\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#84: 
commit be8597239379f0f5 ("Bluetooth: initialize skb_queue_head at
l2cap_chan_create()").

total: 1 errors, 0 warnings, 0 checks, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12964990.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2562116144941003725==--
