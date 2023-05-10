Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B9C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjEJJ5T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjEJJ5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 05:57:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4D59C3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 02:57:09 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-75776686671so197281885a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 02:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683712628; x=1686304628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd8z0WtISJwdoSw7N5NwoqgjMnW9Guxu1pvhaqnVHWU=;
        b=QGw3PpwiGK17QGgnll0Gar4Lg6XJAEyEkj6LcSPS0aVp0N5fQgEzkpXgot67Cz9HFJ
         LxXnSWPnT+Tu8aLRSf69uXJkvNJRBRADWoMjjhB4Y7dPzYPMHmR/cVfQ+g894vyrXCME
         iYiZz2ftXGb8nkbrIYqVnXJiF+mB87gt/iH638ufkThV6RIaDVt4KXtreW0pCA3xy+xn
         woRx2wZJ1qGPTd2P/v8hjtpWtAx6VaxgC8M/jYULZV+04Yehvw2FADPG1XtDHNbomPN4
         bYJ3acBDUc5atR9Do7GLn1pp6ZAfSRoK5OfmlDtf/l3Vu7DB2k7JimktSbAO8HjA5oxa
         kjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683712628; x=1686304628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd8z0WtISJwdoSw7N5NwoqgjMnW9Guxu1pvhaqnVHWU=;
        b=VD1y+tmIqb//cKXpmNQl9un3OUxCh+gGyzJyC6NBTvKwU7Fcbv77/NjYwQYjv7+Yr+
         A06mJpfiP8yM0pZMRR6uIr2UJCFUlsOkDTY29w5P54UiwLurs39S9rcOJybNCgcWHIl4
         82rknZZVsIhn4D5eECP2eiMitTa/m3gMvvGy5N7j6u22OstDT2w3nnkDeWdaKtFCFnRP
         W1y7/DIc24RKWuImBQG5QkyzJFf25WJXmQ2sxfQezQK2zC6IM6oLRlRmSazsmhnu+0h4
         LMa/bC9xJVWDC5wASlCBSJLJty+k+MUPlKpgcTmnz5Ngt0asfNjDR/skwRbhZnDcfy6e
         49zg==
X-Gm-Message-State: AC+VfDwpNWx5h+E5V2gezce9ul3BVJmEfmQ8YW9XrdydOei60+TkaUCN
        RLNv36S66qJUF16EQXNrb+Ak//ADR9g=
X-Google-Smtp-Source: ACHHUZ68Uorhigps8kE6gF+l464ZdtrxZcXlZHhduAmhs+69MYegnRC+0suGjWBjapHsu2c9ra8kqg==
X-Received: by 2002:a05:622a:2cf:b0:3ef:6513:75ff with SMTP id a15-20020a05622a02cf00b003ef651375ffmr26504535qtx.7.1683712627876;
        Wed, 10 May 2023 02:57:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.163.146])
        by smtp.gmail.com with ESMTPSA id e2-20020ac845c2000000b003f0a7c13fcdsm1237267qto.74.2023.05.10.02.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 02:57:07 -0700 (PDT)
Message-ID: <645b6a73.c80a0220.3e0fb.6282@mx.google.com>
Date:   Wed, 10 May 2023 02:57:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0008631811193714525=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luca.weiss@fairphone.com
Subject: RE: Bluetooth: btqca: make sure to handle byte order for soc_id
In-Reply-To: <20230510-btqca-byte-order-v1-1-82e6a371c5aa@fairphone.com>
References: <20230510-btqca-byte-order-v1-1-82e6a371c5aa@fairphone.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0008631811193714525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746366

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.66 seconds
CheckAllWarning               PASS      35.30 seconds
CheckSparse                   PASS      39.75 seconds
CheckSmatch                   PASS      110.33 seconds
BuildKernel32                 PASS      30.74 seconds
TestRunnerSetup               PASS      439.27 seconds
TestRunner_l2cap-tester       PASS      16.58 seconds
TestRunner_iso-tester         PASS      20.49 seconds
TestRunner_bnep-tester        PASS      5.32 seconds
TestRunner_mgmt-tester        PASS      112.02 seconds
TestRunner_rfcomm-tester      PASS      8.57 seconds
TestRunner_sco-tester         PASS      7.91 seconds
TestRunner_ioctl-tester       PASS      9.21 seconds
TestRunner_mesh-tester        PASS      6.70 seconds
TestRunner_smp-tester         PASS      7.78 seconds
TestRunner_userchan-tester    PASS      5.60 seconds
IncrementalBuild              PASS      29.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btqca: make sure to handle byte order for soc_id
WARNING: Reported-by: should be immediately followed by Link: with a URL to the report
#94: 
Reported-by: Simon Horman <simon.horman@corigine.com>
Fixes: 059924fdf6c1 ("Bluetooth: btqca: Use NVM files based on SoC ID for WCN3991")

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13236686.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0008631811193714525==--
