Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB90C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Dec 2022 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLURHN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Dec 2022 12:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLURHK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Dec 2022 12:07:10 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A019C31
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Dec 2022 09:07:09 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-460bb6ec44bso26556827b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Dec 2022 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BLZ64Pi0ioJ5auALwaUvMQokXTXsRA5OuDFak2kZipg=;
        b=Ip26KYSiZfaOaJpGhyC7DliZiQ3k6WooIeXDZKELmXNXgN0iRTXcNz/tSciwUdtuKG
         vC4aMFevPtyYYnsLDtL5388Nd4SCRvitUUHEqYGiWq900QGrbmwz94PzOUEQXG9pWKer
         jEeEJRdXHLzauq7pWZgQVkxppPb7CkYD5pvrfg55lpo8yztF8seWOhgGfzmitT4n5lqH
         fouqV2MYzPSU34a1jZiZ1Jub0R3E0/WLQ93scRa1gqajxmTj3P5s0VbHsq6fln1JrGov
         WV0Sbv2BZNhqI1/2kL8VgsxoPqkxC0/kZBBuHKwM5wubRyhvORCUcc38CKshWCmgRqSv
         r/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLZ64Pi0ioJ5auALwaUvMQokXTXsRA5OuDFak2kZipg=;
        b=2FSISLue7gQ4VWEAPUL460W3z/Z7T5fRyL2902YVcSxzMjK7b65JbtPSSYO4mbTkcc
         5MbPYhFMNvBrfyQeM/V8R+dyL6FzCKs7U7tTfgdPuA4MxSGaiLETDrpkVXzBAiaoE7g2
         ZJyUoGFaaRO8Epr80qZbBVYn8uPGOreD/fkz7mIcFM8eZUIDnJ71gmPHZnhtGSm64KhH
         VHgHAEOZztmTZ3zSeJ8EEcILNsVKxMFI7924jS3GAdg9m6xjiHpKGr8nAReDwIiCGvCQ
         cvEYVYMX6YBoFCYmmyJFlUKj6Ksz0FG/dxU19PAYesE/y3oTSBrJgKxZ9ITYqfvhYHwr
         4Q5g==
X-Gm-Message-State: AFqh2kr9dO4IMK/fCVkVJZHuq/29Y6sy4Ov6qqSntmgZpI9wX5LLQSz2
        pSCM3zuZ2adgJdoP9zrYbw3vkBNDoAtBcA==
X-Google-Smtp-Source: AMrXdXsj3t1EEUny5kLxUTd0MsxKVQmmzKFcyXfx5KgRUuh/g76EjbhIpPA4+hSV/FJSMolH3clecA==
X-Received: by 2002:a05:7500:6a01:b0:ec:9dc1:609d with SMTP id jv1-20020a0575006a0100b000ec9dc1609dmr252740gab.69.1671642428428;
        Wed, 21 Dec 2022 09:07:08 -0800 (PST)
Received: from [172.17.0.2] ([172.177.65.64])
        by smtp.gmail.com with ESMTPSA id az39-20020a05620a172700b006fbbdc6c68fsm11070266qkb.68.2022.12.21.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:07:08 -0800 (PST)
Message-ID: <63a33d3c.050a0220.91454.7ef4@mx.google.com>
Date:   Wed, 21 Dec 2022 09:07:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0790112767593302357=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: [1/2] serdev: ttyport: fix use-after-free on closed TTY
In-Reply-To: <20221221163249.1058459-1-krzysztof.kozlowski@linaro.org>
References: <20221221163249.1058459-1-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0790112767593302357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706276

---Test result---

Test Summary:
CheckPatch                    FAIL      1.90 seconds
GitLint                       FAIL      0.96 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      33.90 seconds
CheckAllWarning               PASS      37.11 seconds
CheckSparse                   PASS      41.60 seconds
BuildKernel32                 PASS      32.92 seconds
TestRunnerSetup               PASS      468.46 seconds
TestRunner_l2cap-tester       PASS      17.01 seconds
TestRunner_iso-tester         PASS      17.65 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        PASS      114.31 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         PASS      8.66 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        PASS      7.47 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.34 seconds
IncrementalBuild              PASS      37.02 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] serdev: ttyport: fix use-after-free on closed TTY
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
  Unable to handle kernel paging request at virtual address 0072662f67726fd7

total: 0 errors, 1 warnings, 72 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13078922.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[2/2] Bluetooth: hci_qca: Fix driver shutdown on closed serdev
WARNING: Avoid unnecessary line continuations
#122: FILE: drivers/bluetooth/hci_qca.c:2174:
+		if (test_bit(QCA_BT_OFF, &qca->flags) || \

total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13078923.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] serdev: ttyport: fix use-after-free on closed TTY

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (99>80): "  CPU: 6 PID: 1 Comm: systemd-shutdow Tainted: G        W          6.1.0-rt5-00325-g8a5f56bcfcca #8"
24: B1 Line exceeds max length (99>80): "  CPU: 7 PID: 1 Comm: systemd-shutdow Not tainted 6.1.0-next-20221220-00014-gb85aaf97fb01-dirty #28"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============0790112767593302357==--
