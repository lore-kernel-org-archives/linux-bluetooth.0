Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90106C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 00:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbiCHAzF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiCHAzE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 19:55:04 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95811CE
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 16:54:07 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2d07ae0b1c0so184837637b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Mar 2022 16:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7Ho/P7lZ6w2v/bbh5/0X/Bq1CWvN5lwiHcU/mrgn5Lk=;
        b=TEXgjMLDbBVIA3na1n+eMiclvjt9MdtbZqT2+KizR4LFSDrOd4eJF50k6FXEUVDi5v
         pEcwHhrkQMIyQFz2uIcfWZm2Scb5fp8EO47SVqdn62FqcM+W3v614fz2eNztPYE4jZ0+
         BkXh+ApJAz79x4hbYhKZ4y7VgmiTJd8ic/xsq4F7lxtz4El05qMHLTEPkON83bWqRNga
         /BiAXI1zqLNAwkh3k+TCV85d4bMPkx/yVVCPd1J2CRHkN4EkobbAAKHjF8+48zp3LCkP
         wx85vYHvg3Ey6RAIusdJwIo3UBtz13apOAWWX4Au/1yYGU6kkSztaig1IKgnofsgq2ZR
         TO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7Ho/P7lZ6w2v/bbh5/0X/Bq1CWvN5lwiHcU/mrgn5Lk=;
        b=DCTeqn13QeEJcXd7UVtJz/puOcHVHZyBjJEffLZlZiHnJufGldsHOjyOrj8O64vYh7
         F/PSx1h38VRI14QbcVAlMCoSIBF77Rtaftr/vNAICv9K0IOgq12YroLlhiK6LqQpxCbM
         658d7BIm/2cD8RETMTsGscOPjSorpDbX5FAj95GNQutDlaALfVyRaR2Q2P96XpTnLbyC
         c1n1XavUNF7Ttd0OubFQOf2ujOFdJ0atF/5ETgyS0wO1oXROd62gM83Os03wofScxAnt
         bGmnEdKJGX/ZahNg8dYEVhBFfiMy1t59z26uIxcgZ9q7kWHpzWC8M+nvrTKGrahzI0qt
         dmSg==
X-Gm-Message-State: AOAM5338XaihpX+NVq6htETCD7V8gr5Qh00Yu7rWcxozWUWat/Pmo1of
        0PaM4tKlvdh8nCWYR7FwGHGfUCQqFibjOCozi47XnzHr
X-Google-Smtp-Source: ABdhPJwxmcjFuZZczV4FJwZQUMMmixhExf9HXqKC0kmGJsCvQlt7AmgAOGSkaQcHLpbJHiH+ToGNDosiprQFJLKqm9E=
X-Received: by 2002:a81:9115:0:b0:2dc:2daf:4b8b with SMTP id
 i21-20020a819115000000b002dc2daf4b8bmr11172152ywg.376.1646700846928; Mon, 07
 Mar 2022 16:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20220303003136.4882-1-luiz.dentz@gmail.com> <6220333d.1c69fb81.59e13.3197@mx.google.com>
In-Reply-To: <6220333d.1c69fb81.59e13.3197@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Mar 2022 16:53:56 -0800
Message-ID: <CABBYNZL=R4AGKhz48hgpttBZmhVAUFtg6ONxBJA0A3dS92JHtQ@mail.gmail.com>
Subject: Re: [BlueZ] client: Add support for scan <le/bredr>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Mar 2, 2022 at 7:17 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619734
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.60 seconds
> GitLint                       PASS      1.09 seconds
> Prep - Setup ELL              PASS      50.66 seconds
> Build - Prep                  PASS      0.92 seconds
> Build - Configure             PASS      10.27 seconds
> Build - Make                  PASS      1761.16 seconds
> Make Check                    PASS      13.30 seconds
> Make Check w/Valgrind         PASS      532.70 seconds
> Make Distcheck                PASS      280.62 seconds
> Build w/ext ELL - Configure   PASS      10.33 seconds
> Build w/ext ELL - Make        PASS      1735.38 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ] client: Add support for scan <le/bredr>
> WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> #102: FILE: client/main.c:1419:
> +static const char *scan_arguments[] = {
>
> /github/workspace/src/12766921.patch total: 0 errors, 1 warnings, 61 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12766921.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed.
-- 
Luiz Augusto von Dentz
