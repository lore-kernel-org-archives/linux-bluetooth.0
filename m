Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B919ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 17:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiISRhJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiISRg5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 13:36:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AA4399C7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:36:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b75so289187pfb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=dkUeLZFPr7ClOS8JzcXJdvZpJ2LPgD3ApjtNtjAFdjo=;
        b=jjX7Hz4UWlbm/Yc8KIYcOvA/dKQfqB7yJ+G1s7Kc/AaMDjsbC7il1g2HiyWlUG8KKX
         Ljwhw1991cjjNHLbuT/p4tIXAtdR4tRfP6aLJXbsKk84lM300zKzuxJ7+9LR9hKQCP7x
         wP0+TcMr4gmXIj7r7/5qSt467nHpyDNsWJpXHHDY/ZRPI5J6NnBLTfmgI7BA8N8A19VK
         HJwUniVj+YFY48MZnVFboFozHdO9oIOydMJO/zeranHyjcRaIOBCIMM74Aodi7tu3Aca
         0WsmxPsn1Y/at+QRKvI0wRlbZlLXNNWiYiK1WizaYtEzSUfsBIv48DfDUfphePL3xkQU
         BsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dkUeLZFPr7ClOS8JzcXJdvZpJ2LPgD3ApjtNtjAFdjo=;
        b=v13EoIrSUli+1RblFBbARM7twKobNmgS/X5Mb/WJJ1pR8H3+YsKjIVPGkBEignsGE4
         LLY9b/23WH6HjisYDCcQJ0LxO5kN+pbP9j67PLSpA2WthueGL0Z7FQ9S1f1f4VVdVTrP
         21cEBK9WMaBEl0vOrwP36Aaq//qC+oMIurBsdw3jTKcZWrlaISuoJ5tTRednbuj8f7c7
         35vQo0f+pb3zRmljJ4qJCoqYIqAwW05G2fM9pc9erLpB0zi/z6f6yHzY2bEkvbCOyp5J
         P0w7IrDPt0oMLL4iDKg9PZhvh2XyVwOBpbJYLrxk0z5+OrrsbQYAu0631GCgXok0/XjH
         ZXpA==
X-Gm-Message-State: ACrzQf3Gl0UEclEdSMLzszzTOITfx3kAiyXq2v1tBZukaLJTwoWARP0/
        DQBZkq3HykWFTp3jCweuyv5nMT4mvvA=
X-Google-Smtp-Source: AMsMyM4ZUAv1v4JCK+4Qy5tYLVKi9+pyYh+QhJ+PVy6BbPoURej6/ge3iEQxPRxFGEDWfP8I6HWcFA==
X-Received: by 2002:a65:6bd3:0:b0:42b:9117:b9d1 with SMTP id e19-20020a656bd3000000b0042b9117b9d1mr16554631pgw.238.1663609014996;
        Mon, 19 Sep 2022 10:36:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.70.211])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001780e4e6b65sm11592341plh.114.2022.09.19.10.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:36:54 -0700 (PDT)
Message-ID: <6328a8b6.170a0220.fdaad.40ae@mx.google.com>
Date:   Mon, 19 Sep 2022 10:36:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8249576115663090724=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sven@svenpeter.dev
Subject: RE: Broadcom/Apple Bluetooth driver for Apple Silicon
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220919164834.62739-2-sven@svenpeter.dev>
References: <20220919164834.62739-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8249576115663090724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678304

---Test result---

Test Summary:
CheckPatch                    FAIL      4.96 seconds
GitLint                       FAIL      0.94 seconds
SubjectPrefix                 FAIL      0.92 seconds
BuildKernel                   PASS      46.10 seconds
BuildKernel32                 PASS      41.23 seconds
Incremental Build with patchesPASS      195.83 seconds
TestRunner: Setup             PASS      684.65 seconds
TestRunner: l2cap-tester      PASS      21.17 seconds
TestRunner: iso-tester        PASS      21.91 seconds
TestRunner: bnep-tester       PASS      8.38 seconds
TestRunner: mgmt-tester       PASS      133.37 seconds
TestRunner: rfcomm-tester     PASS      13.04 seconds
TestRunner: sco-tester        PASS      12.12 seconds
TestRunner: smp-tester        PASS      11.98 seconds
TestRunner: userchan-tester   PASS      8.66 seconds

Details
##############################
Test: CheckPatch - FAIL - 4.96 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3,1/7] dt-bindings: net: Add generic Bluetooth controller\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#125: 
 .../{ => bluetooth}/qualcomm-bluetooth.yaml   |  6 ++--

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

total: 0 errors, 3 warnings, 71 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12980751.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v3,3/7] arm64: dts: apple: t8103: Add Bluetooth controller\WARNING:UNDOCUMENTED_DT_STRING: DT compatible string vendor "pci14e4" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#212: FILE: arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:81:
+		compatible = "pci14e4,5f69";

total: 0 errors, 1 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12980754.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.94 seconds
Run gitlint with rule in .gitlint
[v3,1/7] dt-bindings: net: Add generic Bluetooth controller
25: B1 Line exceeds max length (93>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml"
26: B1 Line exceeds max length (91>80): " rename Documentation/devicetree/bindings/net/{ => bluetooth}/qualcomm-bluetooth.yaml (96%)"

[v3,2/7] dt-bindings: net: Add Broadcom BCM4377 family PCIe Bluetooth
25: B1 Line exceeds max length (95>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml"


##############################
Test: SubjectPrefix - FAIL - 0.92 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8249576115663090724==--
