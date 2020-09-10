Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC212C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C1C206E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hjq7AZLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIJXkb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgIJXk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 19:40:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C27C061573
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:40:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z17so4505579lfi.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2020 16:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LL+0tAnbh6vsc5NLzOGUZJ2LiSX5vj0sdF2jqns5ZEk=;
        b=Hjq7AZLuC2zzMKTEDWd4ZqgkY1LwfdOHUdbuh8Xf6iZsAwfGFujyQAyB2BM4Y2UO+m
         9wMmuURMrN1oD/ubD4LqETRskgJjN1RHGJydHYgAIYlEyZmJFOoNClTlHs2Qw0nhso8D
         n3wzp5jcvHCPp982o4qxQyN4loXyJIwJIFmj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LL+0tAnbh6vsc5NLzOGUZJ2LiSX5vj0sdF2jqns5ZEk=;
        b=jY30Xw/CjSowTpKRDOQjPQoUocRiePKm6gspJoyvPtuldOmjVojf/0q0vH510q0L6v
         7UjJuw9jEsILkPoxPCdOw+Ru93QnhjS/utCGL+ss6Zp4Se/RABeh9Pr22cJFG1Z/qyhO
         E9mYRSG7uABxA+ONB903Smmfa0xGYZyKdH7wahymCfBnTOwDHnIROvIbG6G0AJsUSekP
         7rPGoWqBgZ9zh83GVxuvD6FdC3g08hlibmdTzRBj0c74N8N1badtizYsaQbn0aEamQWV
         DF89Lr7qxGv/kEhprwlxCItWM0HrxVk2ha3eCT8Ab670efhmn8EyqT3fKOS1gxQAdlh7
         AO/w==
X-Gm-Message-State: AOAM531OzGEQphvvQTLz/T6OlPZRhNY99Q3SdxCYPgbE7ulc/nIA9cxo
        NevCVvXefA4hAHHbxS9FzfySVThQh1Z18FbeQl9NCWUu2R0=
X-Google-Smtp-Source: ABdhPJw74mjAXvOR2iBexESgyIU/D6q96PAzM1bifGw0/kisRDVFArMn+CtASOjpHVdofm8I2sALZbu1FSxdJXGa26M=
X-Received: by 2002:a19:915b:: with SMTP id y27mr5396514lfj.134.1599781225251;
 Thu, 10 Sep 2020 16:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200910161528.BlueZ.v4.2.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
 <5f5ab67f.1c69fb81.a94e4.274c@mx.google.com>
In-Reply-To: <5f5ab67f.1c69fb81.a94e4.274c@mx.google.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 10 Sep 2020 16:40:14 -0700
Message-ID: <CABmPvSF1FhoFoz_1yk+eAo-h+xUo2cT4ZHfjN0y37xFLt7wK=A@mail.gmail.com>
Subject: Re: [BlueZ,v4,2/8] adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1
 interface
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

The style check was modified recently,so we are not sure about this
particular license warning. Can you provide some guidance here?

Thanks,
Miao

On Thu, Sep 10, 2020 at 4:28 PM <bluez.test.bot@gmail.com> wrote:
>
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While we are preparing for reviewing the patches, we found the following
> issue/warning.
>
> Test Result:
> checkpatch Failed
>
> Outputs:
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #94: FILE: src/adv_monitor.c:1:
> +/*
>
> WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> #247: FILE: src/adv_monitor.h:1:
> +/*
>
> - total: 0 errors, 2 warnings, 235 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> Your patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
>
> ---
> Regards,
> Linux Bluetooth
