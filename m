Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A1C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKSF3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiKSF3r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:29:47 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA752147
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:29:45 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id v8so4845252qkg.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=apRDuK0iJB8Pof8cOJ/jVca+OnKLpH027Ea39sEG4H4=;
        b=EZYew25LLASAlYlcjWmzUqdQJfYB2EXqiFs4whPeqdrMxkNE0b8N1999TGNYoGSKsG
         CfaQ3UUGDdIit9OvEpfLyenXiHcIC8bCulGjMqcrdyzImXdQC8HupizgDSYSD68K4D3+
         Bwl7CelYNLOd+MZ0S4u6sJtznEb5seueGvv88Kk0cAC2H555A7nniPJb7UVLaYdrrThW
         J8pPZ3rdkb6Bu9jMu5J345lXaqlekvQSnnqqjLhdVYMr1Et1jvjWOdoA19lxrU2nb8tQ
         OGs8mGqJOAWZCmgsvQ5jvXr1VGsoBnnuiODqFhLY5c20xsSYvBpAPKQCVyn9t20Svgxj
         sEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apRDuK0iJB8Pof8cOJ/jVca+OnKLpH027Ea39sEG4H4=;
        b=K7cP8M6F37Rw2moTDNmeMabHp+ROm1YMpjlGIwd3RaLLi7G140gO4KQMBn4K12RZJv
         Xu0750Aa9Sjwdh3rsEcC4k4T6UJ1/8DEGF3+tFUIKarT1+5Wbh1Jm1cs6IQVH8PTalY0
         5kgmOC79x6xjCVc17V8uje0R8TYTZZr08sGwufagrFn/Lt9LSb3cIsaxebnxUcCY8G9A
         IWcFqs+7IuROYiTDCbyaKNVZ/zwnIAPc+oSZ7sigm65ljgOn5S2nVWkNPbbuC2zROYnX
         f6jFCycN3jYLGw+UjaQbLcXFEiOyq5YF9tJL1tnhN6O5PPQSLrccytt9ZTYFamWL+xYN
         Do7A==
X-Gm-Message-State: ANoB5pmvQbqwB4PRL1XHVyyrBIej7i2LFB3dLzkOlcTx9uxrEzKWlgYG
        vhdl3DVH31I6lI2SJuhVcQhvupo/4hdrEA==
X-Google-Smtp-Source: AA0mqf4hDKhjzS3kdL2oSgPJJPTPHAARPHiIk5BFLfirDCcpWgnizmW9nhhXvMBKBlrDMYpk77SkjA==
X-Received: by 2002:a05:620a:b8d:b0:6fb:df4f:d990 with SMTP id k13-20020a05620a0b8d00b006fbdf4fd990mr2677079qkh.181.1668835784377;
        Fri, 18 Nov 2022 21:29:44 -0800 (PST)
Received: from [172.17.0.2] ([4.227.212.22])
        by smtp.gmail.com with ESMTPSA id gd10-20020a05622a5c0a00b003a5c6ad428asm3199734qtb.92.2022.11.18.21.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:29:44 -0800 (PST)
Message-ID: <637869c8.050a0220.768b3.ed2b@mx.google.com>
Date:   Fri, 18 Nov 2022 21:29:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3944723973961557138=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: Fix u8 overflow
In-Reply-To: <20221118200145.1741199-1-iam@sung-woo.kim>
References: <20221118200145.1741199-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3944723973961557138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697073

---Test result---

Test Summary:
CheckPatch                    FAIL      1.01 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      34.03 seconds
BuildKernel32                 PASS      30.61 seconds
TestRunnerSetup               PASS      430.95 seconds
TestRunner_l2cap-tester       PASS      16.47 seconds
TestRunner_iso-tester         PASS      15.65 seconds
TestRunner_bnep-tester        PASS      5.60 seconds
TestRunner_mgmt-tester        PASS      109.00 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         PASS      9.09 seconds
TestRunner_ioctl-tester       PASS      10.32 seconds
TestRunner_mesh-tester        PASS      7.08 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      5.91 seconds
IncrementalBuild              PASS      31.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Fix u8 overflow
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
= Note: Linux version 6.1.0-rc2 (x86_64)                               0.264594

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13048756.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: Fix u8 overflow

20: B2 Line has trailing whitespace: "        08 00 01 00 02 01 04 00 01 10 ff ff              ............    "
23: B2 Line has trailing whitespace: "        0a 00 01 00 04 01 06 00 40 00 00 00 00 00        ........@.....  "
33: B2 Line has trailing whitespace: "        08 00 01 00 04 01 04 00 40 00 00 00              ........@...    "


---
Regards,
Linux Bluetooth


--===============3944723973961557138==--
