Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DD3C64ED8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Feb 2023 01:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBYBTm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 20:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBYBRl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:41 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D7C2069C
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 17:17:32 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id b12so822161ils.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 17:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677287852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gWR1bIRdn53sjt6AJIoPK9LKx+6zpBwtLeQFPmE2N1Y=;
        b=kurEygrgJpf+a7jn8tr9bEHgPlfsTFE7su4nPogpmSJF96eE/fT8BFfwdUMNNMz2j5
         8KFvakLwSuTMBKYW7oi1aRtTv6vdPJ3Y7llc0nswZfdKK7KiEq3WdrF+lqn08lVTWXi+
         xSFFatuH81NfLaJaFudd8hcsWW7/htcIASciCtmjSgam9GVSqQfQayRMZRR6Rcy6Nhta
         4Wy/azQCgthzemMktZ09U9dDrUHkXU5qFhJ1eyOj2oYRWBeuyBAXs739NSTsKCJHf2Ie
         g7MRlVTyK49FVmWW9j94TDBZB3yc2DOQFha3m14DsEYPKkcwJtctBqpWcZeJknervuy+
         RAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677287852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWR1bIRdn53sjt6AJIoPK9LKx+6zpBwtLeQFPmE2N1Y=;
        b=2nfKIeR19JioktLH1wFNYUOvm4NmBgvbMQg89ufvkPqaMu0KzdT9Y8Ecox4AFMCxEO
         v7UqyjH2BjHgNUohd6bnZNMeR/NfTBKQxFRNSogM0B2hrYZVsmGK8wiQHxXBUs3//DPD
         5v1qsZtGHmLDKDNdzrk9IGhd87qLVIu2XLn/+/SDUObMm0pk4XYtDMF1ER6O711jigbl
         u2NkirRgAZu7OWSEdFllo+aIl6EB/oaXCbYMCHJ9mrt/W4/fF8aFpJSTpze6vOVWjveP
         22aBIc817/9iVmaZiM4Kv7O0fgS9LNWRkYYlwZ/UpzMwVY4tox8UYJtMjcE//Yn8azSe
         nGUg==
X-Gm-Message-State: AO0yUKU58gvTw7QQM+mxilSOVlPura5kzyxx+k9oCQreLWtPRC5RpPzE
        zNP0y96OFxKHYogmxi+kG1ieLrWDwR4=
X-Google-Smtp-Source: AK7set/0bP/FXKJicqy3NR2YI3PDvgSBZnQE62nYRSfetyvsng6wqh/mL+SnJHmmNP5Kjkk9MyOilA==
X-Received: by 2002:a05:6e02:1c25:b0:316:ecbf:5573 with SMTP id m5-20020a056e021c2500b00316ecbf5573mr9793856ilh.12.1677287851778;
        Fri, 24 Feb 2023 17:17:31 -0800 (PST)
Received: from [172.17.0.2] ([40.77.93.35])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b00314007fdbc2sm180746ilq.62.2023.02.24.17.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:31 -0800 (PST)
Message-ID: <63f961ab.920a0220.c41fc.052d@mx.google.com>
Date:   Fri, 24 Feb 2023 17:17:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7182551188788600555=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/3] Bluetooth: hci_core: Make hci_conn_hash_add append to the list
In-Reply-To: <20230225002052.3866357-1-luiz.dentz@gmail.com>
References: <20230225002052.3866357-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7182551188788600555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724805

---Test result---

Test Summary:
CheckPatch                    FAIL      1.96 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      31.97 seconds
CheckAllWarning               PASS      34.63 seconds
CheckSparse                   PASS      39.41 seconds
CheckSmatch                   PASS      109.16 seconds
BuildKernel32                 PASS      30.46 seconds
TestRunnerSetup               PASS      439.59 seconds
TestRunner_l2cap-tester       PASS      15.85 seconds
TestRunner_iso-tester         PASS      16.80 seconds
TestRunner_bnep-tester        PASS      5.43 seconds
TestRunner_mgmt-tester        PASS      108.45 seconds
TestRunner_rfcomm-tester      PASS      8.63 seconds
TestRunner_sco-tester         PASS      7.96 seconds
TestRunner_ioctl-tester       PASS      9.26 seconds
TestRunner_mesh-tester        PASS      6.87 seconds
TestRunner_smp-tester         PASS      7.79 seconds
TestRunner_userchan-tester    PASS      5.65 seconds
IncrementalBuild              PASS      38.78 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/3] Bluetooth: hci_core: Make hci_conn_hash_add append to the list
WARNING: Use a single space after To:
#98: 
To:

ERROR: Unrecognized email address: ''
#98: 
To:

ERROR: Missing Signed-off-by: line by nominal patch author ''

total: 2 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13151871.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7182551188788600555==--
