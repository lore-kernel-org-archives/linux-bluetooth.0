Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB69EC678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCGWk0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjCGWjc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:39:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC747A93
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:38:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x11so11261269pln.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678228735;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hXTjTmMwl8SlMaC3L8PoJh3aUu8IGG+9sgKyG3A52xI=;
        b=cvn4YVWMoGB/1GCt+kVqfvig996ZLuOl4sMxpIgHOV31cyvfBMtr/tqEo9MBZWVRBe
         XFszRs40QkH/nnCu9fKZRXfhweEzL3PzyrKclFLwSOy3GK9QoqtE6rW5dPywn4GX6anp
         zsDyf+8P6P61Nxtn0pSOpfBnC8sCm7glm/b44S1wvYCFa8Y17nz0MlPVsy4b0j5/q23i
         s4XMLtfGgbEErXeF9cplN3soi9jTbhQ2OKIYrnDKg+bEa/nKiCZL8ZgBD4BzRFaojjXA
         z8vXu3KQvIxKkIZUPfjKJCGdhkRHhb7WwT7UYQYWL4H5fqv+rrl+gFx36OpzRa1Mytk2
         LZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228735;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXTjTmMwl8SlMaC3L8PoJh3aUu8IGG+9sgKyG3A52xI=;
        b=7dTeVHYnsMJcZvfD9EgY2fuhALvQWzRdhnqT8+QPL5xXzbyOjEaxmRcxk9XTm+kP3F
         U+r2pS7oGKD7Z40VaOVyTWmkiR6+R8jnb+9PMdtlrIv2dkfwMO+jZtQnoouwceH48Sne
         Kvg+P4+VTW0WFJMUSsjcQNZNI3YnNZpLG5V+bt0sFA2JB3Py/Gt1S9ICa0dNe0zJVbvE
         6zSv3oGvtychVelbwHsGCpi5aBDLIhroSuDt3KakoAEBh7lNoP9aCRlBgvORLOLpHeRO
         wS4DozpHQNsy0bMWB37Sp+icEdBS7zkJlPPnjC6UhwcOMWaX5PPyHL/xkYWjfzmvZJ6A
         JuDA==
X-Gm-Message-State: AO0yUKVG6vZjOEfrphHcK/l1Z/WUIi5BSosJkvloo9jRiWoMefmmx8lW
        6M3/XfxC8f7c8b/yx8Avg1SDBiXJ1Zw=
X-Google-Smtp-Source: AK7set+tymlFgNf/WU8BtBexyJfALqHOQgf4cr0W/at92H45SaSnkNJuVzI39yugQzyhNeJ/+LHfUw==
X-Received: by 2002:a17:90b:4d07:b0:23a:87cf:de93 with SMTP id mw7-20020a17090b4d0700b0023a87cfde93mr14711210pjb.15.1678228735516;
        Tue, 07 Mar 2023 14:38:55 -0800 (PST)
Received: from [172.17.0.2] ([13.64.11.210])
        by smtp.gmail.com with ESMTPSA id fz3-20020a17090b024300b00233567a978csm9643046pjb.42.2023.03.07.14.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:38:55 -0800 (PST)
Message-ID: <6407bcff.170a0220.12e4d.2605@mx.google.com>
Date:   Tue, 07 Mar 2023 14:38:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4437500138851746736=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, len.brown@intel.com
Subject: RE: [1/1] hci_qca: do not interfere with system suspend
In-Reply-To: <7687c4239424f2a49c6c596d19eea8dd7ebe8a30.1678226070.git.len.brown@intel.com>
References: <7687c4239424f2a49c6c596d19eea8dd7ebe8a30.1678226070.git.len.brown@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4437500138851746736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727635

---Test result---

Test Summary:
CheckPatch                    FAIL      1.03 seconds
GitLint                       FAIL      0.69 seconds
SubjectPrefix                 FAIL      0.52 seconds
BuildKernel                   PASS      43.24 seconds
CheckAllWarning               PASS      46.75 seconds
CheckSparse                   PASS      52.71 seconds
CheckSmatch                   PASS      138.45 seconds
BuildKernel32                 PASS      41.14 seconds
TestRunnerSetup               PASS      584.50 seconds
TestRunner_l2cap-tester       PASS      20.02 seconds
TestRunner_iso-tester         PASS      22.58 seconds
TestRunner_bnep-tester        PASS      7.54 seconds
TestRunner_mgmt-tester        PASS      142.44 seconds
TestRunner_rfcomm-tester      PASS      11.71 seconds
TestRunner_sco-tester         PASS      10.70 seconds
TestRunner_ioctl-tester       PASS      12.86 seconds
TestRunner_mesh-tester        PASS      9.27 seconds
TestRunner_smp-tester         PASS      10.25 seconds
TestRunner_userchan-tester    PASS      7.73 seconds
IncrementalBuild              PASS      38.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] hci_qca: do not interfere with system suspend
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#87: 
hci_uart_qca serial0-0: PM: dpm_run_callback(): acpi_subsys_suspend+0x0/0x70 returns -110

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13164790.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/1] hci_qca: do not interfere with system suspend

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
18: B1 Line exceeds max length (89>80): "hci_uart_qca serial0-0: PM: dpm_run_callback(): acpi_subsys_suspend+0x0/0x70 returns -110"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============4437500138851746736==--
