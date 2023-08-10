Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511C9C001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjHJPks (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjHJPkr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 11:40:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7071926B6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 08:40:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686b879f605so775993b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691682047; x=1692286847;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RTE2VwxqSvNw9G+Db+MDnFIrkfuee8iN8Zi75Zale9o=;
        b=q0YBO7Qm1uxV3LT/h0wavSI87E5JoAclecNr6IqwT22hh//wjXxzVaWfK85vPrmIYj
         4eS1b+fNrGABcRMAWiU7C+7T3d4etYGphod68DdwkL6E18ppvc24PIWYRpuXgq7R6bcZ
         LeGB4VRM2ohVNkm4Scl2iCrUzlLOoQaFapPYrMttnNg9aTlxJbpxcwOp1wRwD/OPgwOq
         MPqPooLEWqhD8vSOG6h205r+YXtmT6S+zqVHYd7ZBi27ZxvwZ4DzG3bL7Ifff86O18Jm
         vSkebl/uQYIBhh1egUJQGfq333SmXehb7UbN4ERJhYkm8fG3mAkTPSqDj/fb5+NFJAbP
         CLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691682047; x=1692286847;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTE2VwxqSvNw9G+Db+MDnFIrkfuee8iN8Zi75Zale9o=;
        b=HzOGzAmwXL5JJGfccVY1FWmSmYbk+hjfgB9DqqhwbOkb/pt9qy1O9ICTgUVNHqUXSs
         wfYc51wp/H1M4r/G35CsE6DCRXjJxMw3QbznplEwlE+vRZrlzaSR8o0deOl2ZC3aPaCe
         I2XZyv4RLnL4MborKReMYxJ7mVwFhHOje9Y3MWBoEbHJcKLS6GDlteDRuysHKNOy/6Ku
         /99oq2oqhzg3YiB9NQvg+sx+K5cyP9vbg9ufk9idz1QUU3QMKuacqVlLKr1LaEyf+C62
         3tkgqwqnrLAX9HeMB3DdiDc0MkCMUrrfC6PRl9AXc6evaMtHQFEDK1hzSKFuX4zXPTIT
         wnnQ==
X-Gm-Message-State: AOJu0YxsCtdsHd7bmJ80lceqL2JgOW1ES2MNmbNKYtwi32289A1cfrxY
        jHuPXJqMcqyO0T+FEA5NX8VbrNc6hZY=
X-Google-Smtp-Source: AGHT+IEjZBp5oT280qPMbAnoYSTP3J9Mm+uBKDCgp0SMNxAi0mebZ/AaAzhkF02mDstc0l+5eBojVg==
X-Received: by 2002:a05:6a20:54a0:b0:133:6e6e:2b11 with SMTP id i32-20020a056a2054a000b001336e6e2b11mr3362974pzk.2.1691682046623;
        Thu, 10 Aug 2023 08:40:46 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.3.50])
        by smtp.gmail.com with ESMTPSA id l6-20020a62be06000000b0066f37665a63sm1677628pff.73.2023.08.10.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:40:46 -0700 (PDT)
Message-ID: <64d504fe.620a0220.501f8.2f84@mx.google.com>
Date:   Thu, 10 Aug 2023 08:40:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1813517245673660557=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: [v3] Bluetooth: Add device 0bda:4853 to blacklist/quirk table
In-Reply-To: <20230810144507.9599-1-Larry.Finger@lwfinger.net>
References: <20230810144507.9599-1-Larry.Finger@lwfinger.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1813517245673660557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=775015

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.48 seconds
CheckAllWarning               PASS      43.44 seconds
CheckSparse                   PASS      49.73 seconds
CheckSmatch                   PASS      132.93 seconds
BuildKernel32                 PASS      38.36 seconds
TestRunnerSetup               PASS      583.14 seconds
TestRunner_l2cap-tester       PASS      27.85 seconds
TestRunner_iso-tester         PASS      64.30 seconds
TestRunner_bnep-tester        PASS      12.62 seconds
TestRunner_mgmt-tester        FAIL      248.25 seconds
TestRunner_rfcomm-tester      PASS      18.96 seconds
TestRunner_sco-tester         PASS      21.98 seconds
TestRunner_ioctl-tester       PASS      22.04 seconds
TestRunner_mesh-tester        PASS      16.13 seconds
TestRunner_smp-tester         PASS      17.00 seconds
TestRunner_userchan-tester    PASS      13.54 seconds
IncrementalBuild              PASS      36.30 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    1.888 seconds


---
Regards,
Linux Bluetooth


--===============1813517245673660557==--
