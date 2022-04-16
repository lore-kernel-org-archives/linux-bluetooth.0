Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFA8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Apr 2022 00:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356685AbiDPAGS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 20:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiDPAGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 20:06:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF242A11
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 17:03:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id e10so7606105qka.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=V3UZCF+nBmCKZNtIypCIvOyjkg1YJfSwvmDPl3YH+Gk=;
        b=EsHw0kXUGTqymVf0npC5jxJe0eU+z3cMH1XPIuicQ7dlcYT/kiIsom4gOm8gAsX/Xq
         dcwt1Ct7cIoJI9Aeh82MY4vB2UWcoi50smmnFHpDUzr5sxu35hTL1l9iQqTv6+ywoGsf
         a0VheElOlWSeqfVjfjqgpEWnrt7IuPYLYxoc7ydp/Lx3k815qPG7goSsaqsEnzybgEdP
         fmay/W6czInJPXPG7zND7ZdIs6tjFIXjYmjdGCfucM5C/JjpVbI4OI/8yVT+Q12Kw2TZ
         X5nHJZSE99t13AaKd0fNWOj9u9bhMhIsi8OY5VOW1GalmrQiVXL9XEoPIc474WNqMXpi
         68kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=V3UZCF+nBmCKZNtIypCIvOyjkg1YJfSwvmDPl3YH+Gk=;
        b=qErdMjMJdg6qlIFMkPZ/w9U2/TgjRgFF2zOR+7Dar03Cqn+SnAzUPy4exsV6zk0H+f
         pbewjzfBSAdWr147vlheneJ3dd2UT+INZYRjA2Uabmyn1Re3d9xy3OUvnzxVbnebPO1j
         +DMG7OR6e+4cvp/bnIBBwuNcR26H6L2haAAYF3leXqQWQTPHQFz/eq5rmOmC8iHTnAId
         5YPdStSLqjQBh3o+I3Q2K6RdZ0XCtmtyBzy1c/GA2+vKYc6/RoW0Nt4IN2OJ2u6svdpO
         LqQxAylrpwLSlRjBn84ebexrtc7AUweWqnB75EoTbNqDpCLMqwG4liE8tP7wRGJQ5YOg
         dL5w==
X-Gm-Message-State: AOAM5331zI+TYtcMt5NPet3r7wRnUOqXHluXMVKKs55uhwTo7gmY8KFB
        weT7O3zoXWZ7YYGvjyjZXyn8ko++2hEGlg==
X-Google-Smtp-Source: ABdhPJxiyJ9RakWuEOGIg3oWwaNDeEqtwT6RHt0wlCUyprzPk8v/GVfOXth4nnQJOeItExzWKuIgxA==
X-Received: by 2002:a05:620a:c55:b0:67e:125b:38ea with SMTP id u21-20020a05620a0c5500b0067e125b38eamr816141qki.396.1650067426154;
        Fri, 15 Apr 2022 17:03:46 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.105.71])
        by smtp.gmail.com with ESMTPSA id n186-20020a37bdc3000000b0069c218173e8sm3138483qkf.112.2022.04.15.17.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 17:03:45 -0700 (PDT)
Message-ID: <625a07e1.1c69fb81.a257c.1e95@mx.google.com>
Date:   Fri, 15 Apr 2022 17:03:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0540002070173347521=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] storage: Add support for STATE_DIRECTORY environment variable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220415212251.1065432-1-luiz.dentz@gmail.com>
References: <20220415212251.1065432-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0540002070173347521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632674

---Test result---

Test Summary:
CheckPatch                    FAIL      4.99 seconds
GitLint                       PASS      3.13 seconds
Prep - Setup ELL              PASS      50.90 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.20 seconds
Build - Make                  PASS      1488.98 seconds
Make Check                    PASS      12.67 seconds
Make Check w/Valgrind         PASS      526.21 seconds
Make Distcheck                PASS      271.84 seconds
Build w/ext ELL - Configure   PASS      10.50 seconds
Build w/ext ELL - Make        PASS      1451.75 seconds
Incremental Build with patchesPASS      4519.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/3] storage: Add support for STATE_DIRECTORY environment variable
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(3, 4) over __attribute__((format(printf, 3, 4)))
#888: FILE: src/textfile.h:12:
+					__attribute__((format(printf, 3, 4)));

/github/workspace/src/12815401.patch total: 0 errors, 1 warnings, 715 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12815401.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,2/3] main: Add support for CONFIGURATION_DIRECTORY environment variable
WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'main', this function's name, in a string
#161: FILE: src/main.c:1222:
+	main_conf = load_config(option_configfile ? : "main.conf");

/github/workspace/src/12815399.patch total: 0 errors, 1 warnings, 67 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12815399.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0540002070173347521==--
