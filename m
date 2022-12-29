Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1280BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 10:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiL2K6O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 05:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiL2K6J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 05:58:09 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575CDF04
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 02:58:08 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id 3so9551405iou.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dkl+S0qQTp84V8nQ2X7X+u7jEjKnedbD8/wecF0R+V0=;
        b=Uz1n5drGcckwxvIxC9CtOx+jRKbXu+oteXYZTIFAlSP25eOz2svUyWMJc6KFPQhruI
         L8F9eyAYIxW0Je1adjS+8lV+KvThxDAMrTzeI0/2H8OZxVCyA+Sqp4KL1YnR0OeIF4+K
         dDifwjSQOzrUCqs5JUyLprY0mOUfAneelVBrdWSsB6TH4oJBtWuz4pTF7m74LJeFEuE4
         Jimik6NhkkUZLhJb2VuGr292RY3p29LdqWcqSfPzENke8sHxdunWro5zW0zEleqsXTdv
         Pmx7CWxVNo8IjEEETcBwGzHkTAd88jFZrPEDci6gjnT/0uphdXtGe960LKb1MZBtIXt4
         5U0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkl+S0qQTp84V8nQ2X7X+u7jEjKnedbD8/wecF0R+V0=;
        b=dcWwgY0CWx4PskufA7O43ntcmDHrIVaSJkhAUXJNDnFIYQdZHsPmp8Ru7V+eWWuurN
         rNJ5+FeznLUgRt1BZcrEWARmnu3P/JFM7e1Jy5i2n5RPoBImjTuOJrsLDsAgUVaZkHd2
         flm+SgEbBf92Xvu5zdkxseGq1toChAcjyQQPp+2CjE1ujKK2Xas+f0wY9O1qIxWnY9Cq
         ySfdR7wfZ/JoXCWWghZVyNtT7mRRNRJhU6JG62vrFYYorH/r9sYTETV6GQaK+vuJYO0N
         YtztBJtK3khvTCM6Db9N7hSXSpc/zP029zFLttCjwzBxawL5OaAZTDtAlB64mIrVLcke
         JNgw==
X-Gm-Message-State: AFqh2ko9Mu0XSVN4BXtL4SPk3PBpfcjF/ku9EuNERR71lT8S4DubuUFK
        GG8kB4Br58wNdGESuh2rBTsby0lTpgo=
X-Google-Smtp-Source: AMrXdXvNaYyzpoZFEL7j97RZYiDf4AXmyez/mnYJNe0X8EOIK8W8g4OEqFKQpXleWkWHFMswhB9xdA==
X-Received: by 2002:a6b:dd08:0:b0:6df:f420:8999 with SMTP id f8-20020a6bdd08000000b006dff4208999mr21366180ioc.15.1672311487065;
        Thu, 29 Dec 2022 02:58:07 -0800 (PST)
Received: from [172.17.0.2] ([13.86.65.52])
        by smtp.gmail.com with ESMTPSA id q26-20020a05663810da00b0036c8a246f54sm5990775jad.142.2022.12.29.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 02:58:06 -0800 (PST)
Message-ID: <63ad72be.050a0220.3f416.71a6@mx.google.com>
Date:   Thu, 29 Dec 2022 02:58:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4212604652345656425=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: [v2] Bluetooth: hci_qca: Fix driver shutdown on closed serdev
In-Reply-To: <20221229102829.403917-1-krzysztof.kozlowski@linaro.org>
References: <20221229102829.403917-1-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4212604652345656425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=707494

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.41 seconds
CheckAllWarning               PASS      34.25 seconds
CheckSparse                   WARNING   38.73 seconds
CheckSmatch                   PASS      105.67 seconds
BuildKernel32                 PASS      30.25 seconds
TestRunnerSetup               PASS      437.49 seconds
TestRunner_l2cap-tester       PASS      16.61 seconds
TestRunner_iso-tester         PASS      17.11 seconds
TestRunner_bnep-tester        PASS      5.75 seconds
TestRunner_mgmt-tester        PASS      109.64 seconds
TestRunner_rfcomm-tester      PASS      9.02 seconds
TestRunner_sco-tester         PASS      8.39 seconds
TestRunner_ioctl-tester       PASS      9.74 seconds
TestRunner_mesh-tester        PASS      7.16 seconds
TestRunner_smp-tester         PASS      8.16 seconds
TestRunner_userchan-tester    PASS      6.01 seconds
IncrementalBuild              PASS      28.30 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] Bluetooth: hci_qca: Fix driver shutdown on closed serdev
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#93: 
  Unable to handle kernel paging request at virtual address 0072662f67726fd7

total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13083411.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: hci_qca: Fix driver shutdown on closed serdev

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (99>80): "  CPU: 6 PID: 1 Comm: systemd-shutdow Tainted: G        W          6.1.0-rt5-00325-g8a5f56bcfcca #8"
28: B1 Line exceeds max length (99>80): "  CPU: 7 PID: 1 Comm: systemd-shutdow Not tainted 6.1.0-next-20221220-00014-gb85aaf97fb01-dirty #28"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/hci_qca.c:1014:26: warning: cast to restricted __le16drivers/bluetooth/hci_qca.c:1028:37: warning: cast to restricted __le32


---
Regards,
Linux Bluetooth


--===============4212604652345656425==--
