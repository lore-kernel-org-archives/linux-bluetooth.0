Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E0FC001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 02:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346836AbjJTCPz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 22:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346758AbjJTCPx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 22:15:53 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6FD124
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 19:15:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c63588b554so229178a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 19:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697768150; x=1698372950; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wEzBPumrYIZLxXqYgNtOinmju1uEH2VyGSMtuS4Jx3E=;
        b=UmJWWEaLnJtWxZZ2Gf/Wwpn+M+NIxVgbrq2cmqoCtNmqZrq+ab5XbYYs7dAbKQToJy
         EISeWplSNRlD06s1Pt7JBDc57TeijB7aqzkvhLhzsFJOpEPQwe1ZJHwbZ384E3gCP/ws
         xsBwFs7SwNtkI9V06qDt4CXjTB1yLx/d11s6+v6/aYzhUbEd+Yiw5bYHDkufdtTIsgzV
         XwdJxQsAATNuG4FCNvxCdFl3NScO+wsWIR91e8FzhEAvzMNPUkXt3cerPH8+hXHo3S2A
         hgQw1Sc1arfCQGuT8piEyLGSI4/YeDAlUSXt3n4joyooyYEbk5MGiuVAQrsHgUdJOOw7
         jwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697768150; x=1698372950;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEzBPumrYIZLxXqYgNtOinmju1uEH2VyGSMtuS4Jx3E=;
        b=s1aUwr8h2auifPgqJvD1rmdtNSe4gAgSiE1UnP3ua1OD/eanB8jJzoE/YUJp7G5xZs
         5kGv2Q/jMQrWQ+l9yE6ipSa/hsdSgeX8sLP0onhApxeF9BhVEygw8oeHL3oEk0FpDgz2
         rpxNI3vYa+IEpnxLGBN2xociBTSzOUukhzgPPMkskueO8pgmhjVturZ56a9zoR4Pv0J1
         iHlapZfbrFM/xhayc6Mbs/JRv6XwxZxLrJvRzXe9Om7HnFnhlI0rK0imr394jW7zBaZI
         KIIOfD/tMs/rn++5LTLOIAEZM/CwUdo0CemnI8X1aN446oyJHhd5GgmMTZmNZoBykYmz
         VHxg==
X-Gm-Message-State: AOJu0YyrLm/ya7H6vVPed565FQhP8lTy9jFaYbwjSHnNv6BzsFRLd9Qf
        5kgTBdwA+e7L+F6D702AnZCsSxkeOqE=
X-Google-Smtp-Source: AGHT+IFwzz9gBC9wdqPxtOGmlsmwSL73gYNVAD2Ai2BcRV3Kd9QhfRiPHXsF1fyJfMr1cg4oWhKltg==
X-Received: by 2002:a05:6830:264a:b0:6bc:e8dd:9f4d with SMTP id f10-20020a056830264a00b006bce8dd9f4dmr498935otu.11.1697768150362;
        Thu, 19 Oct 2023 19:15:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.158.177])
        by smtp.gmail.com with ESMTPSA id h1-20020a625301000000b006be484e5b9asm455905pfb.188.2023.10.19.19.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 19:15:50 -0700 (PDT)
Message-ID: <6531e2d6.620a0220.dd5b2.2a2d@mx.google.com>
Date:   Thu, 19 Oct 2023 19:15:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2582322842382551344=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: [v3] Bluetooth: btusb: Add return error code
In-Reply-To: <20231020012233.223650-1-youwan@nfschina.com>
References: <20231020012233.223650-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2582322842382551344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794914

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      40.95 seconds
CheckAllWarning               PASS      45.05 seconds
CheckSparse                   PASS      51.37 seconds
CheckSmatch                   PASS      137.07 seconds
BuildKernel32                 PASS      39.47 seconds
TestRunnerSetup               PASS      617.66 seconds
TestRunner_l2cap-tester       PASS      35.72 seconds
TestRunner_iso-tester         PASS      64.46 seconds
TestRunner_bnep-tester        PASS      12.46 seconds
TestRunner_mgmt-tester        FAIL      255.30 seconds
TestRunner_rfcomm-tester      PASS      19.88 seconds
TestRunner_sco-tester         PASS      22.28 seconds
TestRunner_ioctl-tester       PASS      21.75 seconds
TestRunner_mesh-tester        PASS      16.15 seconds
TestRunner_smp-tester         PASS      17.19 seconds
TestRunner_userchan-tester    PASS      13.59 seconds
IncrementalBuild              PASS      38.04 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: btusb: Add return error code
WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13429962.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.936 seconds


---
Regards,
Linux Bluetooth


--===============2582322842382551344==--
