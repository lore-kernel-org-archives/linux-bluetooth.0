Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA7C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 22:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKDWhy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDWhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 18:37:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5232FC24
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 15:37:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p8so9172836lfu.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=feNasQO4KUNyuzGRprjB24/IfNY70OVfkAUBxg/f9W0=;
        b=ZqFQJRQIVGGv3v1gtCxdkyN+/9Gth2TE90K0z7bl71MQRfGKXAzGryTvzyugw8ob/A
         QbGasUmiptv6x28JmhDC4E1GxrWCgWVi+SsYqEbLgyoz42sqwdpr2MT7kz11noqWrNkm
         mtUnsqP7xYqHvMIBglAk8o8lkv6zj/Km9IWDs/ejiwdZu6xDCdBQTWgOwo/B1pZIOJKe
         Pdzoo3xa05n3n0bGLK4lopeveXZjNtuC3huDg3W5ZmJ3ZMYasZCZdDvuKil87DwOwo4J
         peXcBdQ/z7AF0jpvSp3jnh1w86hw33xIWiSxkrdoHo1qGzZVJyJw1k0eEV8v6DPcsQGE
         fyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feNasQO4KUNyuzGRprjB24/IfNY70OVfkAUBxg/f9W0=;
        b=UKasoH+33BrueVU1T4axUfCcwKDFof//nOTRBfks6w7ViZKRwfM+wv2euu7Uui03g7
         17MsXceXjcZZ+2BhO8F1vCr6X+bXKax87ruIYbJVh0OLhiBa/04zOZhlkQ+7RAyJ/Tyz
         YV5mUphDAT5dybkDOlZUMRamMBqsW9vfJ2yhpnVIJiYZiwoI/Uq7Pg3TJV5mdzg5h3qj
         RlWVCQGKwrEnqpPFSrCms/3LYuccp1T6AO277WcK3m6jn7kyu7hDBFr4NPr9vgo5TgYQ
         F4RIcupkcfuAatcdkakvq96GggXSjRHzhzXG++8S4l6r4f8bCcHtSv9fIk+Sd4HoqFNg
         qW5g==
X-Gm-Message-State: ACrzQf0zgFa3fSCfGNfChuSlZfpwMwjEYJy0puTeQspFr0Jy0g7hjFdl
        V+kk6bK7MXDdVLoyzZ9qnDCtk5YTazbZuzYpWifCr29d
X-Google-Smtp-Source: AMsMyM5bHgNp2nJvcyGO7U4eGegx0Nt4FJogCzTDB1EwiEzalksmI1V5s23GYMnLnjruO/ZqKeT7WEdXvHxaweX1ZOg=
X-Received: by 2002:a05:6512:3f2a:b0:4ae:612b:f47b with SMTP id
 y42-20020a0565123f2a00b004ae612bf47bmr13479396lfa.106.1667601468961; Fri, 04
 Nov 2022 15:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221104211303.70222-2-sven@svenpeter.dev> <63658c5b.050a0220.abbe1.14c5@mx.google.com>
In-Reply-To: <63658c5b.050a0220.abbe1.14c5@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Nov 2022 15:37:37 -0700
Message-ID: <CABBYNZJ20Uw8_++2d1HyND-1UZcn5UzzuBcSqhk0W5VhszLutQ@mail.gmail.com>
Subject: Re: Broadcom/Apple Bluetooth driver for Apple Silicon
To:     linux-bluetooth@vger.kernel.org
Cc:     sven@svenpeter.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sven,

On Fri, Nov 4, 2022 at 3:15 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=692274
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      7.46 seconds
> GitLint                       FAIL      2.01 seconds
> SubjectPrefix                 FAIL      2.61 seconds
> BuildKernel                   PASS      34.62 seconds
> BuildKernel32                 PASS      31.22 seconds
> Incremental Build with patchesPASS      151.12 seconds
> TestRunner: Setup             PASS      513.16 seconds
> TestRunner: l2cap-tester      PASS      17.36 seconds
> TestRunner: iso-tester        PASS      16.95 seconds
> TestRunner: bnep-tester       PASS      6.66 seconds
> TestRunner: mgmt-tester       PASS      107.82 seconds
> TestRunner: rfcomm-tester     PASS      10.55 seconds
> TestRunner: sco-tester        PASS      9.93 seconds
> TestRunner: ioctl-tester      PASS      11.21 seconds
> TestRunner: mesh-tester       PASS      8.08 seconds
> TestRunner: smp-tester        PASS      9.90 seconds
> TestRunner: userchan-tester   PASS      6.88 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 7.46 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> [v5,1/7] dt-bindings: net: Add generic Bluetooth controller\WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
> #115:
>  .../{ => bluetooth}/qualcomm-bluetooth.yaml   |  6 ++--
>
> WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>
> WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>
> total: 0 errors, 3 warnings, 71 lines checked

The other errors you can probably ignore but this one above got my
attention, it seems we are doing the right by having the documentation
changes as a separate patch but checkpatch is still complaining?

>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/13032592.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> [v5,3/7] arm64: dts: apple: t8103: Add Bluetooth controller\WARNING:UNDOCUMENTED_DT_STRING: DT compatible string vendor "pci14e4" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
> #210: FILE: arch/arm64/boot/dts/apple/t8103-jxxx.dtsi:83:
> +               compatible = "pci14e4,5f69";
>
> total: 0 errors, 1 warnings, 68 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/13032594.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 2.01 seconds
> Run gitlint with rule in .gitlint
> [v5,1/7] dt-bindings: net: Add generic Bluetooth controller
> 15: B1 Line exceeds max length (93>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml"
> 16: B1 Line exceeds max length (91>80): " rename Documentation/devicetree/bindings/net/{ => bluetooth}/qualcomm-bluetooth.yaml (96%)"
>
> [v5,2/7] dt-bindings: net: Add Broadcom BCM4377 family PCIe Bluetooth
> 14: B1 Line exceeds max length (95>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml"
>
>
> ##############################
> Test: SubjectPrefix - FAIL - 2.61 seconds
> Check subject contains "Bluetooth" prefix
> "Bluetooth: " is not specified in the subject
> "Bluetooth: " is not specified in the subject
> "Bluetooth: " is not specified in the subject
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
