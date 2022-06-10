Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A03CC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 06:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbiFJGAC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 02:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbiFJGAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 02:00:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5988912F370
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 23:00:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p129so29822069oig.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 23:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upc+RveBaYT20kTs64JzTHHAariU3F85lMZ3oUi2vKQ=;
        b=SQ2//HMRvYHojwHK2ROg/anyAts1bSc7+4V1M+HJm4YBwH+pfMWh4FsL442P9/G1yR
         ZKCz0rvwhfC3zA3paN2rf0nBDjCxoJGTbu7+iBEWY2Wv9lwU9L82taP3z+tc4CUGRQqy
         7RVX5xNRh0hDE9hKhFo9/SCxhwngsfI9l4Mq8P6Jcw/TvvJSmiqgGgqGynyDKSG5mtpB
         vJFKD/y2amnSadsXyC2vE7POaG98XrG9f/PX3hyPehDmSXrIWr3ibN2g92iIoGzpe7Ma
         2HqldjW42vPCq1ytcq1P1EiI9un5NdjhWB1VpPTxzr+mKBwNv+bwdFqYeUzpOtG84Qed
         eHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upc+RveBaYT20kTs64JzTHHAariU3F85lMZ3oUi2vKQ=;
        b=sxKDilTLVvdCqDLzRHYv2qvRGGwPMZckA+aXsr+h15sF64fO9GRIz2WcaKFohGY2fr
         V4BwN1hTO3tjmnID6xTaH6RdP69IrghRCr8xD3jKMXJe6eT5iUsTO9mohNtnC3KnxzsI
         MO1hVq7vMHSTcIP0YJN0FJ4fl7ZEOM3XNH1fKONWPMWzigMKgd9XA0ymLFm0cDO7uvBV
         LtBYY6wVV9bZ2bDCukUdnwdvMj0N0ut1c1URbrI9T2sHXZru3Dk8NSznt2B/PE1iY0Pc
         lkAnoUE8gkRCae3XDuhOxToxThcNgq1RrcGzrO07KS8RNnkbZfw7+bQa+f3hejiJ8F7j
         pPkA==
X-Gm-Message-State: AOAM531AJR1oSx6IcrpM3hNA4WoKzbvYrOyrQo1Otgcb0XTFfS7Hm0MN
        hgfx2XDpGoX1TDBn8j3YMiKuTNmkwAS1bewhP1I=
X-Google-Smtp-Source: ABdhPJxsBhCvH7eEyUJIXrIURNB7/Hg71lwZIDbEcBadWN4UzZToAkhBHVNrXE88zALIeVKD4hMw/nnShsA5mRtLY94=
X-Received: by 2002:a05:6808:ec2:b0:2f7:34db:691e with SMTP id
 q2-20020a0568080ec200b002f734db691emr3700555oiv.252.1654840800591; Thu, 09
 Jun 2022 23:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220608051418.197426-1-hj.tedd.an@gmail.com> <165483421250.4028.11832437428068065483.git-patchwork-notify@kernel.org>
In-Reply-To: <165483421250.4028.11832437428068065483.git-patchwork-notify@kernel.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Fri, 10 Jun 2022 11:29:49 +0530
Message-ID: <CAOVXEJ+WK09SxCZTcwKOCa_ZkJpoRn6=kPOa+bYUtLTri9wDjg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Fix not deleting the folder after removing
 the device
To:     patchwork-bot+bluetooth@kernel.org
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Issue fixed with this patch

On Fri, Jun 10, 2022 at 10:04 AM <patchwork-bot+bluetooth@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue,  7 Jun 2022 22:14:18 -0700 you wrote:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> >
> > This patch fixes the issue not deleting the device folder when the
> > device is removed.
> > ---
> >  src/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Here is the summary with links:
>   - [BlueZ] device: Fix not deleting the folder after removing the device
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ebc2b5a3e48
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
