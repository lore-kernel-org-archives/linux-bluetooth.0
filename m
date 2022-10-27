Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BBBECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Oct 2022 16:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiJ0QOE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Oct 2022 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbiJ0QOB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Oct 2022 12:14:01 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8718DD53
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 09:14:00 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id i12so1754186qvs.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Oct 2022 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wPA/eTnnWXEiDQDMqU/cT/z73jJNGwY7OJXqzFBqgS4=;
        b=OjpHoUirBo4/LkNqtR0fhrmB3WG6Y0s7XcWfVvKZXqXJx/ik2z2TkMuz9k3PnsaCvq
         MFV+OuM6HoV1a6ZEP9iWG4DbNLAYjKHLoXnlLFCkei4+dN0w6JCdOJ+MN3Gw0iL1RFDZ
         Ry6Cz1X92XT8sofq2kZiQWf7mLTf8U3Vtt2V7ChqYCgMWEkAiVwHbVHsRzTDfRS6+U5N
         +LCSSgXdPj4rNBhjRU1BX+B+sEY6fGoR5sm16fHYz2YAK4RFW4VEJXp6zDaoApRRxY/9
         k6qr6NFCiyFIQ21mRNsWEZxSU4r2tCuoIXjvfrhm9I1BAfYDt24euluHIbKZBi1kb7Ve
         8CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPA/eTnnWXEiDQDMqU/cT/z73jJNGwY7OJXqzFBqgS4=;
        b=ISrHhA5m9Ulrw2f9RVeS9KuV7I0i7jv1sxMBVjqmeGtC7OjWeQMUj5Hs2Y61zzwn+G
         M0Q1pbkAsSyQtpiwxEdm2hdjXDgTUH3ClcwJao44BzRIVuxBRvyDGnn1dVjYUIADQl9t
         j998Nqp0B2o50ReSwf7une0fgPrRUwEyM1+V8iuFShjQ3I3bLMsO4Mz57QwcRsGAWjUj
         vOziPFuGPA+JQpCozaMiiQecbHDVe7tiqJz7uk8eVL4aBP+/ZxzCY8DnLyjtRynfFtcO
         +amVMjvqp+OZOQd2qRlV4LQncVF6zFm6TZJWYTorHoejAh+fTxh5+hHkiBmVp+23laL4
         kl9A==
X-Gm-Message-State: ACrzQf3HeKhbr8y7G/izn9MOIAYMaCO80MTnr3Ax04L+tjIQsh4Qseff
        9xiOVilcZ+QM0uoYOff+bewp0b2ZMU1nMw==
X-Google-Smtp-Source: AMsMyM7DiSXXIxYfA6JdnXgICBm9YgXEQPnBw0OFBWjF0cD16ZVd14xKkZazJm4oCuZjpqv1R5QURQ==
X-Received: by 2002:a05:6214:2307:b0:46e:5fbc:3c30 with SMTP id gc7-20020a056214230700b0046e5fbc3c30mr41315553qvb.21.1666887239221;
        Thu, 27 Oct 2022 09:13:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.10.206.249])
        by smtp.gmail.com with ESMTPSA id a9-20020ac84d89000000b0039d0366af44sm1106410qtw.1.2022.10.27.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 09:13:59 -0700 (PDT)
Message-ID: <635aae47.c80a0220.f8596.406a@mx.google.com>
Date:   Thu, 27 Oct 2022 09:13:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4966444638724703530=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sven@svenpeter.dev
Subject: RE: Broadcom/Apple Bluetooth driver for Apple Silicon
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221027150822.26120-2-sven@svenpeter.dev>
References: <20221027150822.26120-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4966444638724703530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689494

---Test result---

Test Summary:
CheckPatch                    FAIL      6.26 seconds
GitLint                       FAIL      1.97 seconds
SubjectPrefix                 FAIL      2.59 seconds
BuildKernel                   PASS      33.98 seconds
BuildKernel32                 PASS      30.00 seconds
Incremental Build with patchesPASS      146.18 seconds
TestRunner: Setup             PASS      506.50 seconds
TestRunner: l2cap-tester      PASS      17.12 seconds
TestRunner: iso-tester        PASS      16.02 seconds
TestRunner: bnep-tester       PASS      6.33 seconds
TestRunner: mgmt-tester       PASS      103.02 seconds
TestRunner: rfcomm-tester     PASS      10.09 seconds
TestRunner: sco-tester        PASS      9.42 seconds
TestRunner: ioctl-tester      PASS      10.55 seconds
TestRunner: mesh-tester       PASS      7.71 seconds
TestRunner: smp-tester        PASS      9.46 seconds
TestRunner: userchan-tester   PASS      6.54 seconds

Details
##############################
Test: CheckPatch - FAIL - 6.26 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v4,1/7] dt-bindings: net: Add generic Bluetooth controller\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#115: 
 .../{ => bluetooth}/qualcomm-bluetooth.yaml   |  6 ++--

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst

total: 0 errors, 3 warnings, 71 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13022301.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v4,3/7] arm64: dts: apple: t8103: Add Bluetooth controller\WARNING:UNDOCUMENTED_DT_STRING: DT compatible string vendor "pci14e4" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
#210: FILE: arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:83:
+		compatible = "pci14e4,5f69";

total: 0 errors, 1 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13022303.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.97 seconds
Run gitlint with rule in .gitlint
[v4,1/7] dt-bindings: net: Add generic Bluetooth controller
15: B1 Line exceeds max length (93>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml"
16: B1 Line exceeds max length (91>80): " rename Documentation/devicetree/bindings/net/{ => bluetooth}/qualcomm-bluetooth.yaml (96%)"

[v4,2/7] dt-bindings: net: Add Broadcom BCM4377 family PCIe Bluetooth
14: B1 Line exceeds max length (95>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml"


##############################
Test: SubjectPrefix - FAIL - 2.59 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============4966444638724703530==--
