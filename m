Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A58AC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 01:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjB1BRU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 20:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1BRT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 20:17:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487B244A6
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 17:17:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u5so5389222plq.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 17:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677547038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gYQilNlZ+rLZ59kLhEpxWUJ/Kiy/3TgghOm0h5oCPUo=;
        b=B9DNFOH6yq5rMZ2PRnvxffbK63a7DyA+25q2vlx5VlPYZMhnnMldzMQ+NHnLIfYL+7
         kAWonegnQ5FfVw/yskZshAnqwUk9qds5oe54aBNGPNzQ6Q5un/C/NlUBIjKOmxNDdYTb
         Vl1adNdxIkcxbiCQ6RN5NLV1X1WYoRRv76eC70vvWguHG8Iyr8h7qvRyDJdMkbmqYNkB
         DHqQSY0ws+L7tDSg1ZvzQ18ksIlMcyaU+FvTufzAj0RT74jpQyMDX2gs/CdRObopWaCb
         eBnBKswpvb1Psr93y+VcgQlwQs5w9MvSVoPDBf6KxedqcJu9wno3dXMM9bTh6GNdm+nb
         GB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677547038;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYQilNlZ+rLZ59kLhEpxWUJ/Kiy/3TgghOm0h5oCPUo=;
        b=lQvMnaJoBPWRFQR8x2TQbM+3HduhhNg++xtAlxJqF9qB2ZXiHpBpdHrF7IMS5p6wZh
         mGikC2m4BzC30dOobcJnDRFfcYkK/j64eXEnyCD1mxZlgNMVIsqNezeEissxTJLhaYpO
         vAbJOJ0tbe4GaczIQGaGXMllcmyB/nJauroZsopJCVAxJeMHdPEKbs9UozlEDPA4SVYH
         xDEO5iNDJuxj5/7SM3xDiWj+J6JrvZgCWWbkiHjGULNJ1IGr0HSERqfdAdTXWdd0n73j
         Se0q9fQUrtIdF9+tGnhalNTaWVlQrrRbpzEUH1ruV/6NlL33ITxpnPT1GLOjNikvB/8F
         n7Xg==
X-Gm-Message-State: AO0yUKWHG5nvAdod2GzOvKiSH34p3KQMqU98UmdD6W2tVqwb5l0dCh2X
        TY5I+bNqaRuLj6rWf6uyPP95cJQeqD4=
X-Google-Smtp-Source: AK7set/HfDqJn/nmyJYREKIiTXlEFYQK6Z4xDtwTGXV87ITui1ZRE4PMPXLqJ0E1Rr2rUSnuC/srDg==
X-Received: by 2002:a05:6a20:29a9:b0:cd:87ef:3f1a with SMTP id f41-20020a056a2029a900b000cd87ef3f1amr1253872pzh.3.1677547037689;
        Mon, 27 Feb 2023 17:17:17 -0800 (PST)
Received: from [172.17.0.2] ([20.171.107.98])
        by smtp.gmail.com with ESMTPSA id m3-20020aa78a03000000b005e06234e70esm4797037pfa.59.2023.02.27.17.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 17:17:17 -0800 (PST)
Message-ID: <63fd561d.a70a0220.d7361.832f@mx.google.com>
Date:   Mon, 27 Feb 2023 17:17:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0647485325948907015=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix smatch warning
In-Reply-To: <20230227235255.266852-1-luiz.dentz@gmail.com>
References: <20230227235255.266852-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0647485325948907015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725355

---Test result---

Test Summary:
CheckPatch                    FAIL      0.82 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      32.28 seconds
CheckAllWarning               PASS      34.37 seconds
CheckSparse                   PASS      38.71 seconds
CheckSmatch                   PASS      108.28 seconds
BuildKernel32                 PASS      30.33 seconds
TestRunnerSetup               PASS      438.50 seconds
TestRunner_l2cap-tester       PASS      15.83 seconds
TestRunner_iso-tester         PASS      16.59 seconds
TestRunner_bnep-tester        PASS      5.31 seconds
TestRunner_mgmt-tester        PASS      107.67 seconds
TestRunner_rfcomm-tester      PASS      8.70 seconds
TestRunner_sco-tester         PASS      7.87 seconds
TestRunner_ioctl-tester       PASS      9.24 seconds
TestRunner_mesh-tester        PASS      6.70 seconds
TestRunner_smp-tester         PASS      7.82 seconds
TestRunner_userchan-tester    PASS      5.65 seconds
IncrementalBuild              PASS      28.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: Fix smatch warning
WARNING: A patch subject line should describe the change not the tool that found it
#69: 
Subject: [PATCH] Bluetooth: hci_sync: Fix smatch warning

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13154313.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0647485325948907015==--
