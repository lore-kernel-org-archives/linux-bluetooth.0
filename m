Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F9EC38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIGSTP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIGSTN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 14:19:13 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B30B14E2
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 11:19:11 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j6so11107404qkl.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=5jSbObFAC3h2Ft3Eu/dKXrhc8qHFK9rnOMvEL4NTtPc=;
        b=KEyysZmfJ4zo3zAjAMQIneSo9TPnFGi3Y3tfW/3TWXLgLo+V+lzwPXHzabofMntRuH
         gTw/xwSzd0x2cUlZepga3Idl/NsWytY9YwpaVEu3q7SounGnGS33PvFF+pvROzeMds2I
         hl2wj40fKd37hIW6350pmyp+UKNmLKXdmZgoJFxFplY/YRxGMJGJIkPc7sAmh6q/noZi
         YxAHwn78d8P18CsDqBK0nJAhIc2MNYXusM6b0Sw3CJFKU+Wq0CCF1ad3q1NfkS4Crdlf
         FcinVg+zbsyQSo15La4w9czT+YDAhLH7F3pA1jiiZteOA5tshrCWRW+N22ZvpSVMoK8b
         dnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=5jSbObFAC3h2Ft3Eu/dKXrhc8qHFK9rnOMvEL4NTtPc=;
        b=8Iuom9mcCxfFMjrXYmFBISJ/sIaeW4UgAvzmcihhn0hUZuMrhV8EcyKKag78PFighU
         KG0nVfPQS8U2R/l5gjAkJg/ZkyWRIaE8yv0puoU1SgIdx/eB3bNbCoIbTC9svuJ27TDZ
         xA4D/Q39Gd/mA0mxm81EsulDCtuQWOsxpr5tcrif0em6k49G7grpFw76q0FIjIGTWMoH
         dXztn1N+BUgwoyofGZHDdE7F52XPjtmk2Pna20Sdd1nnHmSa78/6Zy1+GHb87XJ5h9ZI
         yY+nJMG4XK+A1j+brdZgcpcfz7mKpn1o4LTMs18CunvxEh+uabd6wnF5snO26bUOb6Fj
         dG+w==
X-Gm-Message-State: ACgBeo1jKHwKKH54o8Kq4iFmIuf3LKsxcncwzgzICAJMucEoNTpzMqEK
        vVTw2trVqf2AXHVUE1FBlbkjnOJgefU=
X-Google-Smtp-Source: AA6agR7vwwo94WXw9dU40LUtYnomMZtq1S76S/p571WUST2NMiIEpxlsDie1U0Tlk0GPm1C4/8ODmQ==
X-Received: by 2002:a05:620a:bc5:b0:6b6:64e9:2617 with SMTP id s5-20020a05620a0bc500b006b664e92617mr3540231qki.378.1662574750254;
        Wed, 07 Sep 2022 11:19:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.102.61])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a445100b006b8fb2a1145sm15273272qkp.124.2022.09.07.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:19:10 -0700 (PDT)
Message-ID: <6318e09e.050a0220.93abd.47d8@mx.google.com>
Date:   Wed, 07 Sep 2022 11:19:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0313679658171589615=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sven@svenpeter.dev
Subject: RE: Broadcom/Apple Bluetooth driver for Apple Silicon
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220907170935.11757-2-sven@svenpeter.dev>
References: <20220907170935.11757-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0313679658171589615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=674956

---Test result---

Test Summary:
CheckPatch                    FAIL      2.08 seconds
GitLint                       FAIL      2.87 seconds
SubjectPrefix                 FAIL      1.69 seconds
BuildKernel                   PASS      34.57 seconds
BuildKernel32                 PASS      30.39 seconds
Incremental Build with patchesPASS      112.15 seconds
TestRunner: Setup             PASS      502.59 seconds
TestRunner: l2cap-tester      PASS      17.04 seconds
TestRunner: iso-tester        PASS      15.74 seconds
TestRunner: bnep-tester       PASS      6.33 seconds
TestRunner: mgmt-tester       PASS      100.03 seconds
TestRunner: rfcomm-tester     PASS      9.84 seconds
TestRunner: sco-tester        PASS      9.41 seconds
TestRunner: smp-tester        PASS      9.38 seconds
TestRunner: userchan-tester   PASS      6.45 seconds

Details
##############################
Test: CheckPatch - FAIL - 2.08 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,1/5] dt-bindings: net: Add generic Bluetooth controller\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#136: 
new file mode 100644

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

total: 0 errors, 3 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12969309.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 2.87 seconds
Run gitlint with rule in .gitlint
[v2,1/5] dt-bindings: net: Add generic Bluetooth controller
23: B1 Line exceeds max length (83>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth-controller.yaml"

[v2,2/5] dt-bindings: net: Add Broadcom BCM4377 family PCIe Bluetooth
18: B1 Line exceeds max length (85>80): " create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm4377-bluetooth.yaml"

[v2,3/5] Bluetooth: hci_event: Add quirk to ignore byte in LE Extended Adv Report
1: T1 Title exceeds max length (81>80): "[v2,3/5] Bluetooth: hci_event: Add quirk to ignore byte in LE Extended Adv Report"


##############################
Test: SubjectPrefix - FAIL - 1.69 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0313679658171589615==--
