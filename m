Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F85C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 20:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCC160F48
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 20:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhJOUMy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhJOUMx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 16:12:53 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CFC061570
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 13:10:46 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id e10so15725762uab.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Oct 2021 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OT5tslX+GqRv38DRbbnmyi05Y58mRQpuQcJLaDHKdDI=;
        b=mfOyCT4AxYsvGNevPG8kXzUGtUy3Ds988mp1xWOFvMizT7Pmc7c6xnS4Irq51WGRrD
         Y3Cg/90v+zPHHV1LSbmn4Mtv/xuz/xljdESAFFT1ejD6DbP5cJJMVq4Y9aKWVuGlMLs/
         4SaGPJt3Wg1pyZT37L2OZ48JF0sdVGUA6HQ+RF3KShbAALhslKbDPHEn8GGDEXOuVTD2
         tBPFHvyhTQDVrcJTvYBQLP3OI3WSK8pKwrfyb0Fjc/zftvpxFdh4n2xZZ8erdk8wsqOM
         3tVuG4yPMXrn5CHhZEgNVNys7TVOg8PooC2i2MMvy2BahhYHMH0995CijTiDIa05eZoQ
         1ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OT5tslX+GqRv38DRbbnmyi05Y58mRQpuQcJLaDHKdDI=;
        b=bAZb0achQnk5MhYCo6H9xnWOXFwUecd+r6VrjKqJ21KiOsHeL9Q5xJAb5581bZ45dh
         a+NFmFsVxS1jQwwbq5vyQezJhpSEqoGP8PXqiY7babMnspbM2SMVkIsxdK/j1oEPfW/F
         S8AcKTIUW79Lj0aLZuxdXShMoGIkKmRbZqlefltia6z3cDqbHmMZEqtDYD0THnPPkPHg
         0sw149o+RsrYnmArkurT5/YaUTnkZkDX+/vayrai8L4hVgk1R4g9cq3NJBEqQSWzZf+z
         ghfMskj+Dp+WIVe5e6cBv/V5u/aOvvKH0bElmb//Uo3Xiycc+8JgwkjpcfwX5QpXKeqt
         AzEA==
X-Gm-Message-State: AOAM5308BljbiBV3THDJ+T2401LD13Z5AkPVExApGvg95EAwCmB8JMgc
        OFeyVYpwlXKgy87hhaLjQ17dpdUE87WE8kPLNZeM9BnB
X-Google-Smtp-Source: ABdhPJxvHuaNrwfCdAt7SNP7FtB49NRyh7SX+Aj0mQVvtRTeW+Zr7vqY4x9YOEtjcJ8f7+sP1AuZ/o52R0lZiV8KfGw=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr16479421vsa.10.1634328645300;
 Fri, 15 Oct 2021 13:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211015050929.3130100-1-luiz.dentz@gmail.com> <61691372.1c69fb81.e2f2e.cdf5@mx.google.com>
In-Reply-To: <61691372.1c69fb81.e2f2e.cdf5@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 15 Oct 2021 13:10:34 -0700
Message-ID: <CABBYNZKwnHgj338SmyqxrP4CXmuEj_CuzMD4yUaBNfgEmYZ4pw@mail.gmail.com>
Subject: Re: [BlueZ,1/7] monitor: Add packet definitions for MSFT extension
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd, Manish,

On Thu, Oct 14, 2021 at 10:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=563859

Do you guys have any comments on this set? Id like to push it but I
haven't been able to validate if the PDU definitions, etc, are set
properly.

> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      4.45 seconds
> GitLint                       FAIL      2.34 seconds
> Prep - Setup ELL              PASS      56.30 seconds
> Build - Prep                  PASS      0.25 seconds
> Build - Configure             PASS      10.00 seconds
> Build - Make                  PASS      238.32 seconds
> Make Check                    PASS      9.34 seconds
> Make Distcheck                PASS      279.48 seconds
> Build w/ext ELL - Configure   PASS      10.29 seconds
> Build w/ext ELL - Make        PASS      226.33 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ,1/7] monitor: Add packet definitions for MSFT extension
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #101: FILE: monitor/msft.h:31:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #109: FILE: monitor/msft.h:39:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #120: FILE: monitor/msft.h:50:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #125: FILE: monitor/msft.h:55:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #132: FILE: monitor/msft.h:62:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #137: FILE: monitor/msft.h:67:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #146: FILE: monitor/msft.h:76:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #151: FILE: monitor/msft.h:81:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #160: FILE: monitor/msft.h:90:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #164: FILE: monitor/msft.h:94:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #170: FILE: monitor/msft.h:100:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #180: FILE: monitor/msft.h:110:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #186: FILE: monitor/msft.h:116:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #193: FILE: monitor/msft.h:123:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #198: FILE: monitor/msft.h:128:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #205: FILE: monitor/msft.h:135:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #210: FILE: monitor/msft.h:140:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #217: FILE: monitor/msft.h:147:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #224: FILE: monitor/msft.h:154:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #233: FILE: monitor/msft.h:163:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #243: FILE: monitor/msft.h:173:
> +} __attribute__((packed));
>
> /github/workspace/src/12560019.patch total: 0 errors, 21 warnings, 154 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12560019.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> [BlueZ,3/7] vhci: Read the controller index
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #173: FILE: emulator/vhci.c:95:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #179: FILE: emulator/vhci.c:101:
> +} __attribute__((packed));
>
> /github/workspace/src/12560021.patch total: 0 errors, 2 warnings, 172 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12560021.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> [BlueZ,5/7] hciemu: Use vhci_open to instanciate a vhci btdev
> WARNING:TYPO_SPELLING: 'instanciate' may be misspelled - perhaps 'instantiate'?
> #72:
> Subject: [PATCH BlueZ 5/7] hciemu: Use vhci_open to instanciate a vhci btdev
>                                                     ^^^^^^^^^^^
>
> /github/workspace/src/12560027.patch total: 0 errors, 1 warnings, 355 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12560027.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint with rule in .gitlint
> Output:
> [BlueZ,7/7] mgmt-tester: Make use of vhci_set_force_suspend/vhci_set_force_wakeup
> 1: T1 Title exceeds max length (81>80): "[BlueZ,7/7] mgmt-tester: Make use of vhci_set_force_suspend/vhci_set_force_wakeup"
>
>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
