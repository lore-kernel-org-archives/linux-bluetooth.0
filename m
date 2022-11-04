Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA92C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 22:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKDWET (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKDWER (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 18:04:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7465FBCBA
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 15:04:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z1so3931571qkl.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmIjNgaRtYwib3RmIFWhQyEtDtfsKrH/PS6ZR+xJfhw=;
        b=pD/Jb5NQGUI0DmeGqXFFRDH1rIeX3Fq9x8VOXvhfi/p036kVLILvsiJ5xBz+uQocsV
         CBwC8gJspRlAWD2zDAvZEVixuf3fKKd3C+IvDJnwtFtWWX9vsS2u0N46myDwM1GL1kHU
         f25Et4reb07BdV6l4/n6TgF0+2eoY8pdz4fuu5gi/ZixfN+ZYvnXhMihdbL2KZk5CN8x
         P5P/Bj4M2yGAjkd5xNiuqSR0p/c4GO4NH4fSOzI8xXVT9gioIgj/EWh9t+xiSwJfGKsp
         ULzlvPG0GMDE+NblSZXjmy04Prfv3Sdxwbs9DOKHtcAV4N6BqQCN8o/h+X5/F1fR+Ty9
         4gAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmIjNgaRtYwib3RmIFWhQyEtDtfsKrH/PS6ZR+xJfhw=;
        b=kV5KKRYhaXDePb6gE0+BXe3J/ESpyNcGbkoVoyjUGke8J9pvpaWv7CG4iP1FRz/oKM
         NMg+uuXrml+T6dEAM0eP6aO5ijoMibIcDggVxOgndsqigpe/k1FYXXBmMnUh13aJxo/9
         rtk+tuvxI9itGXamLA4/2X6fZRtWtynZjC4n57+kMOZiQYyyoNE367P0swMPPr6LL5+p
         /Z/EPvfWIl5pdo9eXXOfLM76fpKeZGkKslH/NtOujkCnFpNGI9ZIDItYMszIxemp3t90
         XEy6UO+aCY+fkcWcbi0uM5gU68pOnKXUXEcTk6AsGBnbUhXqDwcp2RIwAN2V7Edx4xgA
         SvGg==
X-Gm-Message-State: ACrzQf1g0vMHZiocXmuJE9D9fH+FY4zeQPlzJ261knIqZn40X1N/KX+k
        fc1YlgTTyeG1ECSrz4f5DC3t1+L+Vihylw==
X-Google-Smtp-Source: AMsMyM5ll3P8aN5zx777PUY39I8zGb3lQ+mT+wpelKZoVK3iqIpgtJR+mC1t19mLAQroqNX1LwAPNw==
X-Received: by 2002:a05:620a:14ab:b0:6fa:2ddd:a6bd with SMTP id x11-20020a05620a14ab00b006fa2ddda6bdmr21218565qkj.683.1667599452475;
        Fri, 04 Nov 2022 15:04:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.153.224])
        by smtp.gmail.com with ESMTPSA id i15-20020a05622a08cf00b00398313f286dsm371607qte.40.2022.11.04.15.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:04:11 -0700 (PDT)
Message-ID: <63658c5b.050a0220.abbe1.14c5@mx.google.com>
Date:   Fri, 04 Nov 2022 15:04:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4665071976305927519=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sven@svenpeter.dev
Subject: RE: Broadcom/Apple Bluetooth driver for Apple Silicon
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221104211303.70222-2-sven@svenpeter.dev>
References: <20221104211303.70222-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4665071976305927519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=692274

---Test result---

Test Summary:
CheckPatch                    FAIL      7.46 seconds
GitLint                       FAIL      2.01 seconds
SubjectPrefix                 FAIL      2.61 seconds
BuildKernel                   PASS      34.62 seconds
BuildKernel32                 PASS      31.22 seconds
Incremental Build with patchesPASS      151.12 seconds
TestRunner: Setup             PASS      513.16 seconds
TestRunner: l2cap-tester      PASS      17.36 seconds
TestRunner: iso-tester        PASS      16.95 seconds
TestRunner: bnep-tester       PASS      6.66 seconds
TestRunner: mgmt-tester       PASS      107.82 seconds
TestRunner: rfcomm-tester     PASS      10.55 seconds
TestRunner: sco-tester        PASS      9.93 seconds
TestRunner: ioctl-tester      PASS      11.21 seconds
TestRunner: mesh-tester       PASS      8.08 seconds
TestRunner: smp-tester        PASS      9.90 seconds
TestRunner: userchan-tester   PASS      6.88 seconds

Details
##############################
Test: CheckPatch - FAIL - 7.46 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v5,1/7] dt-bindings: net: Add generic Bluetooth controller\WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#115: 
 .../{ => bluetooth}/qualcomm-bluetooth.yaml   |  6 ++--

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

total: 0 errors, 3 warnings, 71 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13032592.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v5,3/7] arm64: dts: apple: t8103: Add Bluetooth controller\WARNING:UNDOCUMENTED_DT_STRING: DT compatible string vendor "pci14e4" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#210: FILE: arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:83:
+		compatible = "pci14e4,5f69";

total: 0 errors, 1 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13032594.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 2.01 seconds
Run gitlint with rule in .gitlint
[v5,1/7] dt-bindings: net: Add generic Bluetooth controller
15: B1 Line exceeds max length (93>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml"
16: B1 Line exceeds max length (91>80): " rename Documentation/devicetree/bindings/net/{ => bluetooth}/qualcomm-bluetooth.yaml (96%)"

[v5,2/7] dt-bindings: net: Add Broadcom BCM4377 family PCIe Bluetooth
14: B1 Line exceeds max length (95>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml"


##############################
Test: SubjectPrefix - FAIL - 2.61 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============4665071976305927519==--
