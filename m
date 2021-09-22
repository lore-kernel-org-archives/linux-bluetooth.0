Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07187C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E140B61019
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhIVV51 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbhIVV51 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 17:57:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F9C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:55:56 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l13so4311638qtv.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YycY3cP6tPNl6qAKX2IXm2CAphNMTuQctSrEMeXMYI4=;
        b=cJc2Gjm8R0smoyXoki7s2xs/1tfq3YgSXBVZJjGasi3jXphF0CpCae35IciEkSi3Dv
         +BAHgXd1wbVGJ1ET/lVl6XoV3rkR8b/8CAg4rMDBd32n9S+b4cEEW6BABdDPK4PJZef7
         h0YBx4kyJv3/F+YeNEM5mhFPVPrPA4layoMh93xuMnVwI8uyH2RyWC7rZwTzMBmkQV3u
         KzbT3CTZbKcSLgdyU+Y40hLnxydxKmbcccdtkbwYkyHe0pEWpWcS6AfUEJvK0ulvPX1G
         GmTViTFoJOVSTlIBm5vMUmYnjSA2iVy7MNjol9+UDveXQEUBJIHPmIIOBEcGqny9Bzvu
         MihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YycY3cP6tPNl6qAKX2IXm2CAphNMTuQctSrEMeXMYI4=;
        b=5R2L8Ma985NE3k2X3vH7MD3n+2XQ2bW4fPcoJoVDCGvrDXBUaABgmN0zMfOHrFrzOp
         3PKD4cdVC+OeX/57rP2+g1OV/uSZnKsLVCq+t2sA7z7AkCVZt3+ffL3Dtrb8w/AreS2W
         1gwOA7Wf2cdi5FdvJqfdS9LWH+JXUG4XIuZwHlFjnseY+OtlHpnLBnW9fqTcwlpxPG4Q
         m7BrWTfv8yhzlbd+DYK5242tIISmxgDHcdJ3sjK5HXCYItbMUYUSbQjif7+KPFTRdP/E
         IpdAekoo0XSznHwSpouEs4F5Vqbmh5lSb0hpdVUVdS1GYFXZkfWElVCCEMtQDGWARec1
         6UMw==
X-Gm-Message-State: AOAM533zLb5MmID4CE1KWvsEBySrr1B3AJhAqveqSPjudTciwgf0chW2
        1MbJ2tcg6bZZOBcziKLB4RQlfw0oDKI=
X-Google-Smtp-Source: ABdhPJwyrmcmZqJN2cm/xfdcLbH/441fMYDCbniv7Gfn5bUijsfZ/YHefG6Onggv+jEW1HoKyhZcog==
X-Received: by 2002:ac8:4f0b:: with SMTP id b11mr1713874qte.124.1632347755606;
        Wed, 22 Sep 2021 14:55:55 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.115.231])
        by smtp.gmail.com with ESMTPSA id u7sm2401273qtc.75.2021.09.22.14.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:55:55 -0700 (PDT)
Message-ID: <614ba66b.1c69fb81.16884.3742@mx.google.com>
Date:   Wed, 22 Sep 2021 14:55:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1843457040356933854=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/mgmt: Set MTU to UINT16_MAX
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210922213402.1978215-1-luiz.dentz@gmail.com>
References: <20210922213402.1978215-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1843457040356933854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551265

---Test result---

Test Summary:
CheckPatch                    FAIL      5.51 seconds
GitLint                       FAIL      3.56 seconds
Prep - Setup ELL              PASS      50.85 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      9.27 seconds
Build - Make                  PASS      215.58 seconds
Make Check                    PASS      10.15 seconds
Make Distcheck                PASS      256.89 seconds
Build w/ext ELL - Configure   PASS      9.66 seconds
Build w/ext ELL - Make        PASS      203.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,4/4] adapter: Truncate number of LTKs loaded if over MGMT MTU
WARNING:TYPO_SPELLING: 'accomodate' may be misspelled - perhaps 'accommodate'?
#91: 
If MGMT MTU cannot accomodate all the existing LTKs only send the ones
                   ^^^^^^^^^^

/github/workspace/src/12511495.patch total: 0 errors, 1 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12511495.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/4] shared/mgmt: Set MTU to UINT16_MAX
Config Error: Source contains parsing errors: '/.gitlint'
	[line 52]: '~                                                                                                                                               \n'
	[line 53]: '~                                             \n'

[BlueZ,2/4] lib: Fix HCI_MAX_ACL_SIZE
Config Error: Source contains parsing errors: '/.gitlint'
	[line 52]: '~                                                                                                                                               \n'
	[line 53]: '~                                             \n'

[BlueZ,3/4] shared/mgmt: Add mgmt_get_mtu
Config Error: Source contains parsing errors: '/.gitlint'
	[line 52]: '~                                                                                                                                               \n'
	[line 53]: '~                                             \n'

[BlueZ,4/4] adapter: Truncate number of LTKs loaded if over MGMT MTU
Config Error: Source contains parsing errors: '/.gitlint'
	[line 52]: '~                                                                                                                                               \n'
	[line 53]: '~                                             \n'




---
Regards,
Linux Bluetooth


--===============1843457040356933854==--
