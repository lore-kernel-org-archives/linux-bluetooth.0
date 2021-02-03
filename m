Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88100C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 19:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3608B64F7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 19:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhBCTJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 14:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhBCTJt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 14:09:49 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9369DC061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Feb 2021 11:09:09 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i30so936962ota.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Feb 2021 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mS+V1zdv1LmbfJOaJJpofrDY0YCLXovO2Cal/UKKLwA=;
        b=HhpSGUyM5eA9A1ga7vm08YvuTdH8SKvsU0Qtq8nZoBcucs9cOFlMjZ/fxJ5/L8BF4a
         jKx43HTMz0BD2rdE5huAXFBVLsIPaNaFuus95mXr4t48io/0sIwVYbIPf3ZFOrdZqHcY
         Uu/vyrzMHnKFSuvxzzn4LRacbCPRVlDF+fuAADqUDx3n68u6Schh+dr/hE8+aFEv+DHx
         lFbFFSWu/vzuQZTvOAsU/bgaP7bqHuWNsHhUK7oA0pUIMQBLG8UJdNbV/TDkk6cV04KM
         zfwWC4BL/xdaIwijIshU7lRgLXnd3yqatRy71F9qL6DTmsRmUOymGb/bLyj8NjGZXSd8
         DyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mS+V1zdv1LmbfJOaJJpofrDY0YCLXovO2Cal/UKKLwA=;
        b=OuMr9Z6jEWbH2NV/WLOJrRXyGpzEDHbvcyDF9d2Wr75Jl+2t5LsjTu+Fs2b5TbkS84
         CVkNdWXPgKKP7QXfiOtjdB5Lz3DWJ3plYZ4Z+FchLNLjDTkmMDAwY91ytOTcEd8D72kU
         VmnX6xgLOrkexVMEOIKwL4lTmqvsOvaeUJx4cs5ubrA2JEjIEI8D4rVwIqoLyVCpEnLA
         wPSfvLBSTIwoG9I2HWZl8/LSEMp13fPbykXQLitTpxnw4ksinxYO80N/fZMLeBMgkbGm
         KPZCofOi8C9LiccM6P0UPf8/3AAOIQS4aH/k3QNYVla76DAuJKzEkHPf4DohhDFjqhK1
         6/Sg==
X-Gm-Message-State: AOAM530Slij2oZJLMOX4eZNGKsl8wFeVjen/1G4QtEmgwRZxpocMcJDp
        P/ncLtvtH+FHq9ClBQZEK2i5DUXQ0+5ngY4zbNwPEUlU4Mk=
X-Google-Smtp-Source: ABdhPJx5RKsGxGGwSs3KCGBijS90Z1pj5h2xZL6eMCoKX74UaeeneMlg14PKqOh+T3uaV975ucKBoWfGWuQ/Vz1SBPs=
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr3032972otq.371.1612379348522;
 Wed, 03 Feb 2021 11:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20210202034005.27697-1-hj.tedd.an@gmail.com> <6018d01f.1c69fb81.45e86.488c@mx.google.com>
In-Reply-To: <6018d01f.1c69fb81.45e86.488c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Feb 2021 11:08:56 -0800
Message-ID: <CABBYNZLybQhs1Atm1KfUk7+OMxKv=z9hLTL3WFzCddDEWcNp=A@mail.gmail.com>
Subject: Re: [BlueZ,v4,1/2] tools/bluemoon: Display FW version of firmware file
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     hj.tedd.an@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Mon, Feb 1, 2021 at 8:14 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=425781
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - FAIL
> Output:
> tools/bluemoon: Add support for checking other firmware file types
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #59: FILE: tools/bluemoon.c:757:
> +} __attribute__ ((packed));
>
> - total: 0 errors, 1 warnings, 168 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] tools/bluemoon: Add support for checking other firmware file" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
