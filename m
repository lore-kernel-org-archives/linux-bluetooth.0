Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A2AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B402B64E11
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jan 2021 00:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhA3AGr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 19:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA3AGq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 19:06:46 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA6C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:06:06 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id t17so8083504qtq.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 16:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PFpMmXFY3YeFYcDSZUr5qwale7BhsZ0G/pFWEwfqc/g=;
        b=DHYzBf5ZG1sjLk2IIDUlAPGHQLGNilgkHuC+3eZCoKXK6mMRJL+Oh23zkG2eg+su1N
         lynd7592SlMkoHFjFg+yKASFhuhjyWgtAVMMxNVc834JfEg7DtYnLQ7Td9A9QFFuXBEc
         eJ9lAulU+zOTGEduywlHPzRjzrTcNV519mX5ox0FKg8sqNX52oWLkU00YuiK4Eve4AV8
         DkoXSbssrs8JLd5xMd2xQTCpOwqPWelHLUZ0mhF/9yFT9KF6r/GZx0/G/SMMAV65dm/O
         fp7N5nEmXPU98OAr/hSw/wGW5iKUMXTdVJekmFT2L+Jc7AZeiJe+LZmcRejM5l1L7OHQ
         AJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PFpMmXFY3YeFYcDSZUr5qwale7BhsZ0G/pFWEwfqc/g=;
        b=iWMGQx4UBcVsLl5V/UI5QqluDJ7R4v+9SGlx3+2xx3GuHDVVpmCPKo3376K32M+mJK
         w2LNbg9kvaFRp0xXQY9vVUSRZFgqsw4p2RjmT5XX7WnceQRQbyBtBWg+uTIqFyubVYAT
         ZMJYj8g3WhQL3tYJ5Db/3SslTeezx6wk47Wy/l9GGtCNtCH5QmA9X9GiB427USp29HiX
         noFpArdvWzxrvGQ3+yru/p1SaJTSyrQ1jt+mWNKIORrbph4jq6POsu1YXtlAz3p9LGW+
         JjpfzhNUFJW8mv6Kl0RAbrdtbz9RjF0Vldn+OlT2MVmcKjbvr7AfuWPHpHgUaM/pTVa8
         7NgQ==
X-Gm-Message-State: AOAM532OhcTktV0A9KnCGtv0zfvvkIabildsJIDQRq2/Jaffnt3O9NNp
        MhYPrwLaBCgczlmGeCc1Pws4HaMHMUk=
X-Google-Smtp-Source: ABdhPJzn9AAEZPPBJ2TyNaZRbd9uEuu02aTjhv30GL6ADJbNmCylCQhwKKT2rhvX9TbJuJvu2FNGbA==
X-Received: by 2002:ac8:6b8a:: with SMTP id z10mr7030554qts.384.1611965165220;
        Fri, 29 Jan 2021 16:06:05 -0800 (PST)
Received: from [172.17.0.2] ([20.44.106.163])
        by smtp.gmail.com with ESMTPSA id v12sm7230025qkg.63.2021.01.29.16.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 16:06:04 -0800 (PST)
Message-ID: <6014a2ec.1c69fb81.9d20.cee3@mx.google.com>
Date:   Fri, 29 Jan 2021 16:06:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7492900923050889288=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2,1/2] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210129235159.90017-1-hj.tedd.an@gmail.com>
References: <20210129235159.90017-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7492900923050889288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=424645

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
tools/bluemoon: Add support for checking other firware file types.
WARNING:TYPO_SPELLING: 'firware' may be misspelled - perhaps 'firmware'?
#4: 
Subject: [PATCH] tools/bluemoon: Add support for checking other firware file
                                                                ^^^^^^^

WARNING:TYPO_SPELLING: 'extenstion' may be misspelled - perhaps 'extension'?
#8: 
This patch checks the file extenstion and analyze the firmware file.
                           ^^^^^^^^^^

WARNING:TYPO_SPELLING: 'suppored' may be misspelled - perhaps 'supported'?
#38: FILE: tools/bluemoon.c:665:
+		/* This option is only suppored for the legacy ROM produce,
 		                       ^^^^^^^^

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#59: FILE: tools/bluemoon.c:757:
+} __attribute__ ((packed));

- total: 0 errors, 4 warnings, 168 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] tools/bluemoon: Add support for checking other firware file" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
tools/bluemoon: Add support for checking other firware file types.
1: T3 Title has trailing punctuation (.): "tools/bluemoon: Add support for checking other firware file types."


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7492900923050889288==--
