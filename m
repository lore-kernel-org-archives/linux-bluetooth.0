Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5061EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 16:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjGJQCn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGJQCk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 12:02:40 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F26C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 09:02:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39ca120c103so3266805b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689004958; x=1691596958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XItR1y6b3uVnlw9fvVueVop2Viu8xYEXcJoxrokcheM=;
        b=FTKEtpf2jA3VzxGxmg4+PlbuNi8DIQK02dE369NNquCCOKLBCZKBn+6mZTOTHiOLE9
         BQvZmLYb7pYgcVsiOXd4WJWQHFqRdnCWLdecMqxtPu24EYn9Xdt655Y5yJdlnqnHok/N
         +DNWGp+Jf1GOq7a7jZRbxwDYf+5xIHMqMu7XJNLwb6DG5cQKuQZBx5y515EhZxqPbEbr
         RF4LuLV8kkPd/qagREJPkJaj+Wx2AHoTIPsMI66LRc/4gYH/RFdeahICiJS5f2cGZnf6
         BuGbPzG4zXvVdeIZdWzl/of2WAkIn1A90TkC0j/fBZ3S9oqic4X5wMnLnZ91nzLgo4ws
         c+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689004958; x=1691596958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XItR1y6b3uVnlw9fvVueVop2Viu8xYEXcJoxrokcheM=;
        b=LrvOWw0muVFwFRLhIh0fWINUCtgdGtt2lt4kAGjtzz12tgDhVW94aGEh/Wjp2eVsol
         +MWE/07wqZ/HFKiUsYU3GCLSPVwKWxdOL3WglUyKPQ+rxmya4WSQAdvlOEL6EbU5K2wU
         0rfnh74ho5m0ncTQvO0eQABeQ5EyyGFp53KOeKIDUSzQgiHwGOFu/axv5xq1L4IaQaTx
         ro6LAE8FFKS434o5/KCLTcDQuLcqrsglUNs2F95r1+pRnCDSz6XrhKciLRYUqHyFIW8v
         5giYvAOIIq8XyDd907SA41/CBXy2feb1nRX/zwZJtyq03Q+ZtIeooFJlCIOsOwS0CXpe
         Rb2A==
X-Gm-Message-State: ABy/qLZoUN0UFB1dSrvV+rQX4hurr1hEOT+sYDyU0xPYM5mw7xbCvfR3
        NakcRs9FlorRxU1lZXw0Vh3b5jp0R0E=
X-Google-Smtp-Source: APBJJlHFips434dBbN06HEhyG80mt+aF1jMuFKm9hqp4NQtcL5B+Fc3QPAGcpOCEZrV+xof2I/WMLw==
X-Received: by 2002:a05:6808:905:b0:3a1:dcba:ed7b with SMTP id w5-20020a056808090500b003a1dcbaed7bmr11575761oih.53.1689004957889;
        Mon, 10 Jul 2023 09:02:37 -0700 (PDT)
Received: from [172.17.0.2] ([65.52.35.3])
        by smtp.gmail.com with ESMTPSA id y14-20020a056808130e00b003a1f1933957sm46443oiv.16.2023.07.10.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 09:02:37 -0700 (PDT)
Message-ID: <64ac2b9d.050a0220.3b35.0690@mx.google.com>
Date:   Mon, 10 Jul 2023 09:02:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2061425517291739484=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
In-Reply-To: <20230710151723.15617-1-jlee@suse.com>
References: <20230710151723.15617-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2061425517291739484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764081

---Test result---

Test Summary:
CheckPatch                    FAIL      0.84 seconds
GitLint                       FAIL      0.51 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      33.31 seconds
CheckAllWarning               PASS      36.54 seconds
CheckSparse                   PASS      41.27 seconds
CheckSmatch                   PASS      114.64 seconds
BuildKernel32                 PASS      32.48 seconds
TestRunnerSetup               PASS      487.10 seconds
TestRunner_l2cap-tester       PASS      22.77 seconds
TestRunner_iso-tester         PASS      40.83 seconds
TestRunner_bnep-tester        PASS      10.48 seconds
TestRunner_mgmt-tester        PASS      211.04 seconds
TestRunner_rfcomm-tester      PASS      15.72 seconds
TestRunner_sco-tester         PASS      16.73 seconds
TestRunner_ioctl-tester       PASS      17.64 seconds
TestRunner_mesh-tester        PASS      12.98 seconds
TestRunner_smp-tester         PASS      13.90 seconds
TestRunner_userchan-tester    PASS      10.94 seconds
IncrementalBuild              PASS      30.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
WARNING: From:/Signed-off-by: email address mismatch: 'From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>' != 'Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>'

total: 0 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13307193.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (107>80): "Closes: https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/ [1]"
15: B1 Line exceeds max length (110>80): "Closes: https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/ [2]"


---
Regards,
Linux Bluetooth


--===============2061425517291739484==--
