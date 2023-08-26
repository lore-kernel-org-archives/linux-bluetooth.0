Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2747C83F01
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Aug 2023 09:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHZJfs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Aug 2023 05:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjHZJfn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Aug 2023 05:35:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FB31BF1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 02:35:40 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76d9023c942so112237185a.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Aug 2023 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693042540; x=1693647340;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n5RB4Mc2BEs8aTjvUAQxohm74L6M0zxwY0BAhAlI4HE=;
        b=hn0TYF7Cqcp/74h5JasjMI4L28boNoXi6jkn1OD0h0DGPr8onfqgMu3olvHVpBM3Td
         5FaDiMO9T8XjodjFzqB2ZFTjAEib8pw/FkZVSa2Dh9l9GFdPqdUpdHOKbOKuDYnrUjNh
         N9r0PkCNOFW75CeWvTSAv3gyC/BjnKGiKDg6lGxkWXuinGHgREvfiED6SjO9m5JkCy2x
         eXNgN9uCnEOx4RXDLzoSjWKwiVoJUodZUYyK37xKU5gEtIt72T+nLyFBG37R2Y3Du2tF
         +eMR5OA//28BmjKJwxcQWw7011b0wLY3uXJJbwrrQ7+dQ2EPAmP/iFKu/aYj2XGqVwIr
         JB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693042540; x=1693647340;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5RB4Mc2BEs8aTjvUAQxohm74L6M0zxwY0BAhAlI4HE=;
        b=bQiW5LH7KQ2hmmMsJG2MZYmaTj4ZKteRJSyFuzoLWS9omlBmpK4YfnjxUd4hPqwLaJ
         pDxOzoLRf+70NHAsqaVbhoTFFhzKcI7MrVYCZmvdSkvEalOkRtpqvxGfYUOYhMPWGIJX
         amOskL/PP6fcEUxDacQSFkVJn7CVc0ltH24Z7YLrWkCd6x+8eQ7Z76rhOTF73Oy+tp98
         8wof9dUMbsC0hFWsYfa3TlqG9d0MEZ1+xVEbHEq6ruujcRvJZGfbJQhO64SNRR1fwF+u
         KQk3jXyoyDR8dW+CYKx84wU/Z33nl2VytAoQ4CRBSjidNu1ajUzGj3vwhG9/BC4DzT+u
         akSw==
X-Gm-Message-State: AOJu0YyWeIDxWWaPeo4slVIGBxdyUgQ75k1MCVP/rX7NHlfp9jFq9GiF
        wrzNGBf7ZnQ/wXGFXxp9m8pnfQl/NFDaOw==
X-Google-Smtp-Source: AGHT+IE+gZLTGmjyeL17Sv7hbpuVb+B5ZtkuzOk8FEL8gbt9v5WbIL37kWdFNAsKqypi3L86z8D5Bw==
X-Received: by 2002:a37:ad05:0:b0:76d:aa3b:d48 with SMTP id f5-20020a37ad05000000b0076daa3b0d48mr14824470qkm.66.1693042539800;
        Sat, 26 Aug 2023 02:35:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.22.81])
        by smtp.gmail.com with ESMTPSA id r16-20020a0ce290000000b0064f43efc844sm1142602qvl.32.2023.08.26.02.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 02:35:39 -0700 (PDT)
Message-ID: <64e9c76b.0c0a0220.7c741.4782@mx.google.com>
Date:   Sat, 26 Aug 2023 02:35:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1509366458149519613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, herbert@gondor.apana.org.au
Subject: RE: KEYS: Include linux/errno.h in linux/verification.h
In-Reply-To: <ZOm5mX0+oUGzO3xh@gondor.apana.org.au>
References: <ZOm5mX0+oUGzO3xh@gondor.apana.org.au>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1509366458149519613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=779564

---Test result---

Test Summary:
CheckPatch                    FAIL      1.18 seconds
GitLint                       FAIL      0.64 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      34.28 seconds
CheckAllWarning               PASS      37.34 seconds
CheckSparse                   PASS      42.76 seconds
CheckSmatch                   PASS      115.58 seconds
BuildKernel32                 PASS      32.92 seconds
TestRunnerSetup               PASS      501.03 seconds
TestRunner_l2cap-tester       PASS      28.86 seconds
TestRunner_iso-tester         PASS      51.48 seconds
TestRunner_bnep-tester        PASS      11.30 seconds
TestRunner_mgmt-tester        PASS      225.81 seconds
TestRunner_rfcomm-tester      PASS      16.97 seconds
TestRunner_sco-tester         PASS      20.59 seconds
TestRunner_ioctl-tester       PASS      19.16 seconds
TestRunner_mesh-tester        PASS      14.39 seconds
TestRunner_smp-tester         PASS      15.43 seconds
TestRunner_userchan-tester    PASS      12.02 seconds
IncrementalBuild              PASS      31.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
KEYS: Include linux/errno.h in linux/verification.h
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
> >> include/linux/verification.h:23:11: error: use of undeclared identifier 'EINVAL'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13366546.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
KEYS: Include linux/errno.h in linux/verification.h

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B2 Line has trailing whitespace: "> "
8: B1 Line exceeds max length (85>80): "> >> include/linux/verification.h:23:11: error: use of undeclared identifier 'EINVAL'"
15: B1 Line exceeds max length (82>80): "Closes: https://lore.kernel.org/oe-kbuild-all/202308261414.HKw1Mrip-lkp@intel.com/"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1509366458149519613==--
