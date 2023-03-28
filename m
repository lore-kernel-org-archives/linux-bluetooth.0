Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA9AC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjC1RT6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjC1RT5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 13:19:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4BE1BF
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 10:19:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j13so11552267pjd.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680023982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rbCx4niGMuOBhbpTicZ+phYMlLTFANVVh5WJyznS4Wg=;
        b=Q2bNvLcnLjOf7h/4LsrO0VwS5VTZb0w0mVKN4icGik2zPVzaFh6NlsAURxHoX1wsG7
         NRFUzYh4MHE8fMMqtBYCS5A2wQYNU8tqQN8YEJ14ptEVoVxhKATI9IOE5N0jfnd3ZgCd
         2eG8YHtd8aATSAl3tjstdA/YTwul/479LrXLdlBhccYHa+YuZshtyYntOB5+DoKHVQRR
         b4BbDeRUBOOfIjDV+VwLiBIz2V6vvk0tXDcPTeHkceHYMnZb39MhdOD+2SB0j82R6+Je
         sIdqwPBBPTMW7KlucgjXavsBFfLMp/+U4Ylgx4wJWn9n6ul7aWnH+b62fgf2tOtvF1UJ
         ahaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680023982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbCx4niGMuOBhbpTicZ+phYMlLTFANVVh5WJyznS4Wg=;
        b=qkHGBn5xaKL2smDzcY9awVf29+slT7yPNM7quq52UYd94/Em9pDLq4JjAgndN22WWU
         sm/XNXQ4WS/Cw6tVH7kb4GOYRDU1lbf0rplJ6EzGvhw6RMta/ES2k/5iIu+UikOwOihG
         zLYSPSPUPaWX9rbR6hwsbzVzbC3tvMC/KcRpxWsWxxdvK/PvQctdaeJBlelX4u2P8fl9
         5h33IgqGzFaueBdJD3fMu6nUgdh255HD9Cu38BGK2tRMvkEIYY8mEjkxeRrS0a1JhXUR
         Ris57sv6xYFu+QVztkxd7TmRpFwv4YIDHuRJes2tRUZHLcs+HQ1bAAay44BeWDMzJxa8
         oAuQ==
X-Gm-Message-State: AAQBX9eQUgwvvqSyuCygk1v49N5X/agA4tSKkv//Sg78d1B2RwnRQpxH
        FINbPhfJ2FKk+6OfyEX8GakvkdFlaD0=
X-Google-Smtp-Source: AKy350ZQBsrwvW5Uc0G39QKKJdDd/dmYKG8elYXOPWmmtt+ij6QLDSzObGgA3svgiH5wmwpLefdnsg==
X-Received: by 2002:a17:90b:1e0c:b0:23f:7649:f011 with SMTP id pg12-20020a17090b1e0c00b0023f7649f011mr17203253pjb.43.1680023982147;
        Tue, 28 Mar 2023 10:19:42 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.46.52])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090a398f00b0023f9ad42118sm9415604pjb.28.2023.03.28.10.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:19:41 -0700 (PDT)
Message-ID: <642321ad.170a0220.934a4.050d@mx.google.com>
Date:   Tue, 28 Mar 2023 10:19:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5765082989962733896=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v10,1/4] Bluetooth: Add support for hci devcoredump
In-Reply-To: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
References: <20230328093000.v10.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5765082989962733896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734695

---Test result---

Test Summary:
CheckPatch                    FAIL      5.56 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      42.02 seconds
CheckAllWarning               PASS      46.32 seconds
CheckSparse                   PASS      51.47 seconds
CheckSmatch                   PASS      140.44 seconds
BuildKernel32                 PASS      41.77 seconds
TestRunnerSetup               PASS      582.94 seconds
TestRunner_l2cap-tester       PASS      19.69 seconds
TestRunner_iso-tester         PASS      23.16 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        PASS      127.09 seconds
TestRunner_rfcomm-tester      PASS      10.62 seconds
TestRunner_sco-tester         PASS      9.45 seconds
TestRunner_ioctl-tester       PASS      11.36 seconds
TestRunner_mesh-tester        PASS      8.60 seconds
TestRunner_smp-tester         PASS      10.21 seconds
TestRunner_userchan-tester    PASS      7.64 seconds
IncrementalBuild              PASS      57.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v10,1/4] Bluetooth: Add support for hci devcoredump
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#159: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 689 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13191347.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5765082989962733896==--
