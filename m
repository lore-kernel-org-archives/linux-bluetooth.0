Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D57ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Oct 2022 19:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJ1TEj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJ1TEh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Oct 2022 15:04:37 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F042DEA
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 12:04:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u2so9523750ljl.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Oct 2022 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4b9sz4ugHIcdLRQb67EBQwaBMJWvpqxatOEnY5HdOLI=;
        b=pXV8luEA4PWSU+c6tVmLbQjw8xp2mPq4V2yW24Xd5lefpYNYXtRF+m54trZOedc41X
         juQ4wb3g1zjTpkENeuhOPsLo0Iy0slN3Zd1cTfNKFveiHEyjz+dN298DgkANuTmN0Uus
         vdtz2U2cdSWQjgVtuvDmdWeAsOVgGKvagC9HkvOzI7sPkB6aFYv+ilQO/fCSH0Cpte56
         qz8wMtd9vWP2ie4iSrwlOJk9WhKXX6fvZzbXgcMY8jqlUheiDo6GErqW+u0K5fCAxkje
         pTl+bbCzivxrW6kknKdJavKYQZFo450APswCxYKERSL1HpRDqAm0R4F6Tlwk+uuCkg1N
         73FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4b9sz4ugHIcdLRQb67EBQwaBMJWvpqxatOEnY5HdOLI=;
        b=a72FSWFosfvx3shRw4L4KQ4hJOJxXVwmhO6zeV/70HPKrC9wZwIRCGdy1swF7QygYb
         CvbCe5zRnOTlYqniZnltqJsv7wmolCtYlzTz92edrLTV/EorqoPqbU5FoDsFu8J6Vgn5
         Zset9wYNyJSZYU26eJpTAN4612nuywnvqTbekG2BOQ7wkeWhOcdVNLLTM8XT8FRgsfff
         MhA46ZosOJJIHCHFoU6YfjyPqKBM9Vm9i3WWI7eTrhrRCPx5LtZIIhHKYNQswIAldGMu
         /QE4+YY/g/gMcfr8ZavJKRBSD/1A8almQm4NC7COVVjptkO51iLVSTwOdqu6zzE4jfhJ
         pzyw==
X-Gm-Message-State: ACrzQf3i8BWaa04qhQLx4Pgl/zsV/5WfYNdkOUIgJLy+smFiZAsifyP4
        RRD1Od2gwmr54OSRqNYcdx4OmWhjd3dpX5fVm8jKTsYO
X-Google-Smtp-Source: AMsMyM6Ev9loD7xUGVAN+tDAOr9prfqlwAhLmekdY4fEGG9jgzvrsu41ONo0CHdSMSPP6hecZwtoFWmP7QxzGc9DsCg=
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id
 m4-20020a2ea884000000b0025dd8a2d18cmr349028ljq.305.1666983865981; Fri, 28 Oct
 2022 12:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150822.26120-2-sven@svenpeter.dev> <635aae47.c80a0220.f8596.406a@mx.google.com>
In-Reply-To: <635aae47.c80a0220.f8596.406a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Oct 2022 12:04:13 -0700
Message-ID: <CABBYNZJHUEtT7QPx7rFkS0=CiEqWpDz7=q98p9qPcR-XBdWCEw@mail.gmail.com>
Subject: Re: Broadcom/Apple Bluetooth driver for Apple Silicon
To:     linux-bluetooth@vger.kernel.org
Cc:     sven@svenpeter.dev, Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Oct 27, 2022 at 9:20 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689494
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      6.26 seconds
> GitLint                       FAIL      1.97 seconds
> SubjectPrefix                 FAIL      2.59 seconds
> BuildKernel                   PASS      33.98 seconds
> BuildKernel32                 PASS      30.00 seconds
> Incremental Build with patchesPASS      146.18 seconds
> TestRunner: Setup             PASS      506.50 seconds
> TestRunner: l2cap-tester      PASS      17.12 seconds
> TestRunner: iso-tester        PASS      16.02 seconds
> TestRunner: bnep-tester       PASS      6.33 seconds
> TestRunner: mgmt-tester       PASS      103.02 seconds
> TestRunner: rfcomm-tester     PASS      10.09 seconds
> TestRunner: sco-tester        PASS      9.42 seconds
> TestRunner: ioctl-tester      PASS      10.55 seconds
> TestRunner: mesh-tester       PASS      7.71 seconds
> TestRunner: smp-tester        PASS      9.46 seconds
> TestRunner: userchan-tester   PASS      6.54 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 6.26 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> [v4,1/7] dt-bindings: net: Add generic Bluetooth controller\Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 6, in <module>
>     from ply import lex, yacc

We might want to fix this to install the ply module.

> ModuleNotFoundError: No module named 'ply'
> WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
> #115:
>  .../{ => bluetooth}/qualcomm-bluetooth.yaml   |  6 ++--
>
> WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>
> WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>
> total: 0 errors, 3 warnings, 71 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/13022301.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> [v4,3/7] arm64: dts: apple: t8103: Add Bluetooth controller\WARNING:UNDOCUMENTED_DT_STRING: DT compatible string vendor "pci14e4" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
> #210: FILE: arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:83:
> +               compatible = "pci14e4,5f69";
>
> total: 0 errors, 1 warnings, 68 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/13022303.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 1.97 seconds
> Run gitlint with rule in .gitlint
> [v4,1/7] dt-bindings: net: Add generic Bluetooth controller
> 15: B1 Line exceeds max length (93>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml"
> 16: B1 Line exceeds max length (91>80): " rename Documentation/devicetree/bindings/net/{ => bluetooth}/qualcomm-bluetooth.yaml (96%)"
>
> [v4,2/7] dt-bindings: net: Add Broadcom BCM4377 family PCIe Bluetooth
> 14: B1 Line exceeds max length (95>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml"
>
>
> ##############################
> Test: SubjectPrefix - FAIL - 2.59 seconds
> Check subject contains "Bluetooth" prefix
> "Bluetooth: " is not specified in the subject
> "Bluetooth: " is not specified in the subject
> "Bluetooth: " is not specified in the subject

@Sven you can probably ignore these errors since not all patches are
bluetooth specific these are probably a false positives.

@Tedd Btw, for new drivers the CI won't be able to build test so I
wonder if we should have a special Kconfig option that select all the
drivers so we don't have to keep updating the ci.config everytime a
new driver is introduced?

-- 
Luiz Augusto von Dentz
