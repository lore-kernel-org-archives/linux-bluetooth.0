Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A67C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 21:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiGTVJm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGTVJm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 17:09:42 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6A1A07C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 14:09:40 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id m10so10532756qvu.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qop7GijbfcF8b+d/0oeJWW4ep30ZV0jhUdydtpa2s40=;
        b=nDRKUa8A/sS8Xdtu1+x3V1mx/k5SpVnBZg8tML+vi22WuHEYc75gRWwoE8gfZadr2W
         Ns+5yzt/OysU7z7x8yrm4K6LdDr91gH5mOnZ7zMyn2bMTIA7vhk6diN+Du49WTM/0glb
         jGLUi0Qe6W/ViErfah32JsC68o21ZTsKcvghkQRMF7QnzKY/4JhRBFywAktQ79W0Bmal
         LFtwpe5FvngWTeb0TBq4ZswsLOJlIYQWVOTd81ZXYZiCn+J/jv6+ljkK7KXoYgZlaNZf
         Y2UnDXIAG/pqQ6HxRq4edpEpvbOHv2Cp3dNxbP9nE37M87QPOajuDqOjDw3hUnu6S5sQ
         qWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qop7GijbfcF8b+d/0oeJWW4ep30ZV0jhUdydtpa2s40=;
        b=qAGHpmy+t7YSVGupuJRFKxXaA4GlfDYC8xNObIY5jQmVnNRlWKB0ctbzmvxaD+Ak0b
         rp8uCZQ6IUh9SVlRTz6/A5mnkOHFiviecdoa6/VYQi3A8HvoqJio9oKI6ST/iv/MTJmp
         HZ4fwshGzIQCaDAaG03Nig1gth5xcd46+L13oHuCVN8WaNCdobwOzwFhmrexItiC8RKE
         3BhKw7fApaeCQFspZO6iTJYix5J/dQS71hOOWdZm1xeeY+5QXvbGSNBUN/t2UYK2O89/
         sgL2mhZgVhZN5DX3k03HKq53dDYFdul5MA8MTsQUNYBMLHZaoiKUq6QxFtshZjAbsEfr
         G4BA==
X-Gm-Message-State: AJIora8du55D1Or9I9jIeF7AmM+1ejIJ+IcYkgYvZOiJuy0xi1u6sE1c
        RgXrYRCSGuHZtTByhcdyCJsm2tBWR8w=
X-Google-Smtp-Source: AGRyM1vYtpfIVsySGxYGEktqiR4dhe9ULX5TMre3HOrMfRDWm5Knqu2Q3c72DlEhEBrRXgGKea7BsA==
X-Received: by 2002:a05:6214:20a9:b0:473:6e47:956 with SMTP id 9-20020a05621420a900b004736e470956mr30981353qvd.31.1658351379578;
        Wed, 20 Jul 2022 14:09:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.165.156])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b006a6ce613c7csm158992qkp.89.2022.07.20.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:09:39 -0700 (PDT)
Message-ID: <62d86f13.1c69fb81.ab080.0916@mx.google.com>
Date:   Wed, 20 Jul 2022 14:09:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8287330276396189473=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add Mesh functionality to net/bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220720194511.320773-2-brian.gix@intel.com>
References: <20220720194511.320773-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8287330276396189473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661590

---Test result---

Test Summary:
CheckPatch                    FAIL      6.31 seconds
GitLint                       PASS      2.21 seconds
SubjectPrefix                 PASS      1.95 seconds
BuildKernel                   PASS      35.54 seconds
BuildKernel32                 PASS      30.11 seconds
Incremental Build with patchesPASS      75.43 seconds
TestRunner: Setup             PASS      539.23 seconds
TestRunner: l2cap-tester      PASS      17.34 seconds
TestRunner: bnep-tester       PASS      6.01 seconds
TestRunner: mgmt-tester       FAIL      99.83 seconds
TestRunner: rfcomm-tester     PASS      9.65 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.31 seconds
TestRunner: userchan-tester   PASS      6.19 seconds

Details
##############################
Test: CheckPatch - FAIL - 6.31 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v5,2/2] Bluetooth: Add experimental wrapper for MGMT based mesh\CHECK:BRACES: Unbalanced braces around else statement
#244: FILE: net/bluetooth/mgmt.c:4568:
+	else {

total: 0 errors, 0 warnings, 1 checks, 182 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12924471.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 99.83 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.093 seconds



---
Regards,
Linux Bluetooth


--===============8287330276396189473==--
