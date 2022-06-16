Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 10:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359791AbiFPKDQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359684AbiFPKDP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 06:03:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CCE5C875
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 03:03:14 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p8so1292915oip.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MFWp6HUcWXu5HkKJXsy0eMkUJswSg4B+bJqfmKRT2Vc=;
        b=SgkQeRkBJH5Hq/4Q6+F2rVID/QVfXW5LZtdHzpOCbGkMD3tunw1A5ug4E1gMhdrDhb
         FeWt67nko1BV4JhkzeFA7eIsBlKPZrg2VjpjcGshZxfDgEf8nx9xYeAcxc2objcFd0p3
         BJ3QQYn60FF/3A23ReKqIW15ClUs1nJoGjJsf4S7oPc7Ef9Q90AY0u5nDTTS5AHxMMa3
         aukzkh0NAGXEbTwlTniIgqqMDBYUZynfQdqr2loUxPX+9naCR7IgZNTZVcUb9AMVmmpb
         2DgQ22FaTf8dxW3REbSBWP7FsXPUiNEcVX2ySxNgbyUpmIhm8cf3S4hgUGZ/VqANbeR5
         tc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MFWp6HUcWXu5HkKJXsy0eMkUJswSg4B+bJqfmKRT2Vc=;
        b=ddbcl+96J1uYb3eHytm0ahF24/md3kZCVOOaJnsHL1I3bVjugaKj4eCCuxMgGOGrq0
         lhUKGIhYgZRqKbdBI8XeoDF58khPqMu1XdESajIsLOzjT9cnFmBaE1Q3HcdzVm7LorGB
         dsGJbRZqcqGhrUaq8l/6BbLWE2vOMDB9fzzdVhgtpN+WuGfZhVp716QzAS+Lq5mBqf7S
         TYmfU2uyaaeaXnCvl6aO94o5MlZfRHgnvdGWx1KpN+Pio+hWjmYDxwMkwU5aEMbJQ6n4
         UDxa2yww9DDnuPG0t/53yb01veRIrFSqcyqsh9MVCEO9Wat8dmuUB/lAy2zr/KST9ulU
         G98Q==
X-Gm-Message-State: AJIora9cbMawvzyRzJQt8lpF2gkZBcxVlzIS1vLGLMgehVsQ3qOcN2DN
        66BNOkREnE1/kIYy285W/BZDR46i/dw=
X-Google-Smtp-Source: AGRyM1t11iiV7yyZT2j7V6ELrMsEIu9H76CEBOEIXyTcRZEEj5gQduXRm4RcquU6QbUxMBNQuvNThg==
X-Received: by 2002:a05:6808:178a:b0:32f:134f:9d2 with SMTP id bg10-20020a056808178a00b0032f134f09d2mr2125158oib.59.1655373793211;
        Thu, 16 Jun 2022 03:03:13 -0700 (PDT)
Received: from [172.17.0.2] ([13.84.216.53])
        by smtp.gmail.com with ESMTPSA id c12-20020a056830348c00b0060c44580a09sm641268otu.43.2022.06.16.03.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 03:03:13 -0700 (PDT)
Message-ID: <62aaffe1.1c69fb81.64601.13f7@mx.google.com>
Date:   Thu, 16 Jun 2022 03:03:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2799396748675173034=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, a.fatoum@pengutronix.de
Subject: RE: Bluetooth: hci_sync: complete LE connection on any event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220616092418.738877-1-a.fatoum@pengutronix.de>
References: <20220616092418.738877-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2799396748675173034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650944

---Test result---

Test Summary:
CheckPatch                    FAIL      1.24 seconds
GitLint                       FAIL      0.68 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      30.24 seconds
BuildKernel32                 PASS      26.88 seconds
Incremental Build with patchesPASS      37.54 seconds
TestRunner: Setup             PASS      461.76 seconds
TestRunner: l2cap-tester      PASS      12.67 seconds
TestRunner: bnep-tester       PASS      5.63 seconds
TestRunner: mgmt-tester       PASS      96.61 seconds
TestRunner: rfcomm-tester     PASS      9.16 seconds
TestRunner: sco-tester        PASS      8.80 seconds
TestRunner: smp-tester        PASS      8.85 seconds
TestRunner: userchan-tester   PASS      5.89 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.24 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: hci_sync: complete LE connection on any event\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
[1]: https://lore.kernel.org/linux-bluetooth/a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de/

total: 0 errors, 1 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12883653.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.68 seconds
Run gitlint with rule in .gitlint
Bluetooth: hci_sync: complete LE connection on any event
14: B1 Line exceeds max length (97>80): "[1]: https://lore.kernel.org/linux-bluetooth/a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de/"




---
Regards,
Linux Bluetooth


--===============2799396748675173034==--
