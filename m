Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD32C0015E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 16:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHFQAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFQAF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 12:00:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50751988
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 09:00:01 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-57026f4bccaso40842587b3.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691337600; x=1691942400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5wJU5JabgdT9+dDiMms2sobG2SkJ9CcH5U1nKHxRNFk=;
        b=Q/yrR+qCMS9WZmDhXo5v/SAjtCBOB7piSOphXu44HicCMRNYbW3JzesHJajmbTKAIR
         0wNaxwJyQp18yYQJVEyOzBTgMxGDgvwN/4gq9XYv3CzgstjXMJEBvZ7u8iV0X8nvVeqd
         71pvVh9iMCC4WT7T/SE9kVpCB3vZ69o9aK3WH/oC1DhSX5PvBkhvaxhjPo4Hf/GLX5tC
         yMhukLob/WWzEZsYP5nF5g4AeoDCGxIqzOKy0ueW+oxLooMdGbNPhhK6cb5P0LaJTcHm
         5kVLG4baYywrjK0QRKr2mtUNMCtJflbpB/z8NfnSMF+azQLHSUmQI4DeaHeb1r12WgBJ
         xKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691337600; x=1691942400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wJU5JabgdT9+dDiMms2sobG2SkJ9CcH5U1nKHxRNFk=;
        b=Ro5xEcRv5n7vBXDJs66vw0LsLLgMcwTfdtNZeges7OnQiA7fb4uwEK+RATk9PwD5NK
         gwsJTeLmbGmBsn4UM+UfS1jIRE7P1IoKnXWyU7hOykqOj0DD/xoD63JdGtXCgpiv+l8z
         7oA/3PGo1IA3q50Yaj8voZb7BAjRZUat++lx8qNr4ViSmoJY8MEG6N2dUEaeQLWkwNhr
         ViqzJFBMLXtbosZzr3SNtzJ3oxEuSVDVdTOwdyOYb0tKot3QfxFdfVnx3uIphCgIZ+E1
         pb470cNPbn3GprjLXiHXthhvhsmGH4IDB3UOZcs5Q5W2GzYRD3qkLEwOFYR+EO6AZoga
         QiGA==
X-Gm-Message-State: AOJu0Yz4AtHdmO3BQSQC4Y6d3xipsRgnMFKfphrvhigeO30vat5PEzAo
        7k04zb5jNffz2od2KPZtLDpnI/akikQ=
X-Google-Smtp-Source: AGHT+IHTVMRwJZgln0a7adwWWGR6u2Bq5PAbO4R8OF+zSdiI2iEtOuBqmIFILcIxjv9ddP8MzzC8uQ==
X-Received: by 2002:a81:4990:0:b0:576:c543:2a5f with SMTP id w138-20020a814990000000b00576c5432a5fmr7452195ywa.4.1691337600488;
        Sun, 06 Aug 2023 09:00:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.29])
        by smtp.gmail.com with ESMTPSA id w10-20020a0cb54a000000b0063d47a29e6fsm2222327qvd.55.2023.08.06.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 09:00:00 -0700 (PDT)
Message-ID: <64cfc380.0c0a0220.5d647.84d5@mx.google.com>
Date:   Sun, 06 Aug 2023 09:00:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8991176580645284981=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/3] Bluetooth: hci_sync: fix canceling LE scanning / CIS create conn state
In-Reply-To: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691331800.git.pav@iki.fi>
References: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691331800.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8991176580645284981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773436

---Test result---

Test Summary:
CheckPatch                    FAIL      2.27 seconds
GitLint                       FAIL      1.19 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      32.20 seconds
CheckAllWarning               PASS      35.20 seconds
CheckSparse                   PASS      40.12 seconds
CheckSmatch                   PASS      111.99 seconds
BuildKernel32                 PASS      31.53 seconds
TestRunnerSetup               PASS      472.33 seconds
TestRunner_l2cap-tester       PASS      22.17 seconds
TestRunner_iso-tester         PASS      43.64 seconds
TestRunner_bnep-tester        PASS      10.03 seconds
TestRunner_mgmt-tester        PASS      211.21 seconds
TestRunner_rfcomm-tester      PASS      15.03 seconds
TestRunner_sco-tester         PASS      18.23 seconds
TestRunner_ioctl-tester       PASS      17.04 seconds
TestRunner_mesh-tester        PASS      12.45 seconds
TestRunner_smp-tester         PASS      13.56 seconds
TestRunner_userchan-tester    PASS      10.49 seconds
IncrementalBuild              PASS      40.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/3] Bluetooth: hci_sync: fix use-after-free in hci_disconnect_all_sync
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#100: 
CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W          6.5.0-rc1+ #10

total: 0 errors, 1 warnings, 0 checks, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13342873.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/3] Bluetooth: hci_sync: fix use-after-free in hci_disconnect_all_sync

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (99>80): "BUG: KASAN: slab-use-after-free in hci_set_powered_sync (net/bluetooth/hci_sync.c:5424) [bluetooth]"
17: B1 Line exceeds max length (81>80): "Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014"


---
Regards,
Linux Bluetooth


--===============8991176580645284981==--
