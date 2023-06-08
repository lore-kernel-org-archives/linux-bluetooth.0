Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A5C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjFHS5I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFHS5H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 14:57:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C52718
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 11:57:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-651ffcc1d3dso709354b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jun 2023 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686250623; x=1688842623;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fU+f9uPymzLRdY+2Anubc3rIwoGLFdIIvcb3ek7hVLI=;
        b=VoFQ2YS5lDdKjaaoYGrPgJE/QhD9yoA4eZFEiZit3oD/ywVH0D2qm1188uWeFffYU1
         B5p8TSea6mFfMdibMCRWLuoA7hT3HWjll/1QV4p9o+xw7e3bewiKdMs9b5htmYOaCZxB
         ua5bpiA3fCEwifNRq5ACNvwZ1IihU4mEHozNAWiMMtIqAqeLdqQgvqYMQZZodU49dPQv
         7gFwJiDQYf0hUtsY+b7eL2M6V32QlMNxa76JOuI3+9pKAskERUp/lW7VRepphS+TiRYO
         58aO3EeTb1zQfL6jLv3zjO6SvNcg+jvPm9DlwahJ1MQZ6BbD9WP9wEwTWyF/nQZ01p6b
         MTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686250623; x=1688842623;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fU+f9uPymzLRdY+2Anubc3rIwoGLFdIIvcb3ek7hVLI=;
        b=cRFiagumFYtSuYD8BKKcKDtJ2EHUtKsICLDJM2tyffURCDtpYk1yoEpopOiyLWKJso
         nDSmiVYnaWvVEUkueFLD5HgZYAAp/RivgaY/MD4EDGF6S7FPZHw9RKc07nnoMs4hTLSw
         kxrAzbP3myRhMuuS6alcjoXrYykZEySbUd99/IhSkWoBmASPz7CgBN+9GtLLMx4e9xdc
         aAMS3i/Uy0Pg7cpRmUhzLHtNzuxsd5f5Erg2RqkMXg8u+5s8cLmhmxcqpzCFuVQ6n3Ne
         AujZnTNObwGiNoUUBgx/jzf3j48pGrKrfpuw3trQ7/RI8DzVB32DiXP4rO9GBa6tpENQ
         g46A==
X-Gm-Message-State: AC+VfDwwlsmYJulmSjHsxzQBvxegZh7XTvIZhpgHTY79C4ZD/5og+3KJ
        DVr088/5tuz5A07vh1yrnFU69s/QfLQ=
X-Google-Smtp-Source: ACHHUZ7KG/XVtdQHf1I8FEyJRoT9WAodvZioS0K2xRt805djTH6yEUIeNETGFNkJZj8Gj5nj3bFVyA==
X-Received: by 2002:a17:902:ecc2:b0:1ad:8c8f:afb1 with SMTP id a2-20020a170902ecc200b001ad8c8fafb1mr7276495plh.39.1686250623505;
        Thu, 08 Jun 2023 11:57:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.49.55])
        by smtp.gmail.com with ESMTPSA id c16-20020a170903235000b001b017d0fecfsm1730182plh.293.2023.06.08.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:57:03 -0700 (PDT)
Message-ID: <6482247f.170a0220.82845.398c@mx.google.com>
Date:   Thu, 08 Jun 2023 11:57:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5226768461829360742=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Rework sync_interval to be sync_factor
In-Reply-To: <20230608182037.3332558-1-luiz.dentz@gmail.com>
References: <20230608182037.3332558-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5226768461829360742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=755411

---Test result---

Test Summary:
CheckPatch                    FAIL      1.20 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      32.31 seconds
CheckAllWarning               PASS      34.94 seconds
CheckSparse                   PASS      39.56 seconds
CheckSmatch                   PASS      110.57 seconds
BuildKernel32                 PASS      30.77 seconds
TestRunnerSetup               PASS      439.85 seconds
TestRunner_l2cap-tester       PASS      16.79 seconds
TestRunner_iso-tester         PASS      21.88 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      111.91 seconds
TestRunner_rfcomm-tester      PASS      8.55 seconds
TestRunner_sco-tester         PASS      7.86 seconds
TestRunner_ioctl-tester       PASS      9.20 seconds
TestRunner_mesh-tester        PASS      6.77 seconds
TestRunner_smp-tester         PASS      7.78 seconds
TestRunner_userchan-tester    PASS      5.55 seconds
IncrementalBuild              PASS      29.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: ISO: Rework sync_interval to be sync_factor
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#98: 
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)

total: 0 errors, 1 warnings, 0 checks, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13272671.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: ISO: Rework sync_interval to be sync_factor

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
22: B1 Line exceeds max length (89>80): "        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)"


---
Regards,
Linux Bluetooth


--===============5226768461829360742==--
