Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD80C77B61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 23:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjDYXLl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 19:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjDYXLk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 19:11:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518018EB3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 16:11:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso4651810b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682464229; x=1685056229;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6j5hYe658HjH821uXZ/J0MXsYGEv6OZxaR0xmsdaHYg=;
        b=qHNfqv5s5MPTC6JwkSrgeTFu2ibnEmPrOWdv3WP7OK3FQe51H/5EXDR1S1PmpXfULn
         Z3SEKin6Y8fiZplnNFJD9wqHm34mRNDLG6DOO8gHojbIHVUPjH7F75mUslf0G3fA6c6I
         EzU8Zv/aZsXaa0NI9Hx+tyStte0ILgmreO5juxEK/HTV90PE+hVYQhZptX70dkUSthfn
         gJxWSJmdeds4LhgciAD12bCQEZ19GcCF6H41Wqo/lRTdj49laJn+eWUafqZz8jtCleqv
         y0qVKmz2sZcqWFAjY39tI2ZvUN5CcRIVU5v67kxTU3Tb4C4FRzQcYFg06e2edYR8NaGW
         4KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682464229; x=1685056229;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6j5hYe658HjH821uXZ/J0MXsYGEv6OZxaR0xmsdaHYg=;
        b=AHXa7vaqP5YO/+AjbOPc6U7FrqCftIP9LYH+QBHhDocmKrIMJG9K7Hm2r0t2hI8hie
         ptEC56glzP2TUgrc+V2fbtQW8k9QyeC91TLKYG/G8oqq7rq2rLEp/y1ah8F5QKJgKUJA
         SJ/onAkVljSclUrfsUilOmOwSds9WmXXJ4CDneOZjDYxO5gom+IB3psPNUp52elfn4Zy
         +2nyk19C7rfEzymLU9KIwOD37FyZhlgMXiQrDlFWSuDcDX6D39T+16C/KPK0pfOwVxLU
         ahUC+b19fy9YdHf7f1CrkhIFwAeKz9uM+YsZ5jFq/p9e7oO4Us8pRDzwVz5cx430zPpN
         bNcA==
X-Gm-Message-State: AAQBX9ehhjtZHAnLREkVMlXH/dtA02q2+5JdcIgH1VG2m3rqBTX0nDqa
        tPL27X3HWF7Vz1V1fmRtf78caxPJ2RI=
X-Google-Smtp-Source: AKy350YkaueGYtLqP2/8eTbsTJp8ugXW067OYXTvJ/grWHtgBiWDAhSRh9pXHAIlaY9WdZ37D19YNg==
X-Received: by 2002:a05:6a00:17a9:b0:63d:489c:971 with SMTP id s41-20020a056a0017a900b0063d489c0971mr27624246pfg.24.1682464228745;
        Tue, 25 Apr 2023 16:10:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.133.139])
        by smtp.gmail.com with ESMTPSA id i69-20020a628748000000b00640e12b6464sm2877295pfe.178.2023.04.25.16.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 16:10:28 -0700 (PDT)
Message-ID: <64485de4.620a0220.1b815.6767@mx.google.com>
Date:   Tue, 25 Apr 2023 16:10:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2720634433673680590=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/7] media: Fix not storing Preferred Delay properly
In-Reply-To: <20230425204729.3943583-1-luiz.dentz@gmail.com>
References: <20230425204729.3943583-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2720634433673680590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743154

---Test result---

Test Summary:
CheckPatch                    FAIL      3.54 seconds
GitLint                       PASS      1.82 seconds
BuildEll                      PASS      26.72 seconds
BluezMake                     PASS      771.20 seconds
MakeCheck                     FAIL      11.44 seconds
MakeDistcheck                 PASS      154.02 seconds
CheckValgrind                 PASS      245.93 seconds
CheckSmatch                   PASS      329.77 seconds
bluezmakeextell               PASS      99.34 seconds
IncrementalBuild              PASS      4381.54 seconds
ScanBuild                     PASS      999.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,6/7] shared/lc3: Update configuration to use iovec
ERROR:SPACING: need consistent spacing around '>>' (ctx:WxV)
#124: FILE: src/shared/lc3.h:56:
+	LC3_IOV(0x02, LC3_FREQ, _freq, _freq >>8, \
 	                                     ^

/github/workspace/src/src/13223798.patch total: 1 errors, 0 warnings, 125 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13223798.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: MakeCheck - FAIL
Desc: Run Bluez Make Check
Output:

make[3]: *** [Makefile:11261: test-suite.log] Error 1
make[2]: *** [Makefile:11369: check-TESTS] Error 2
make[1]: *** [Makefile:11777: check-am] Error 2
make: *** [Makefile:11779: check] Error 2


---
Regards,
Linux Bluetooth


--===============2720634433673680590==--
