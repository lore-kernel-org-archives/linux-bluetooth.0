Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4711BC47086
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2244C61358
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 20:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhEYUIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhEYUIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 16:08:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0636C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 13:07:08 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id f9so44786938ybo.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVN656SSKNaQlxJCj0G7QK1Aj/Hjf4bAj4VCZn+ACWM=;
        b=XaUZlgyJi9+KAGJx2n+PfjhDvrCAofIYSWaXfQH0MUDZkjiSpiRVhTVAZkX1vwkKgW
         smb4mfdz2CSXlWX8NkgAOpkk+IdI/Ta9Yv0+oxoHqh2PFxjoPrCGCrYp4qJL6IQWs9Y8
         eshsL6rHzH/8YgLmTiE2Bodf/5geBK5eBY4xjiN/WQ8khfQ2JRd78rap9Nu8PB6M/8us
         C7DQ5udVjizg0SJAL2GSjsOCybmIN3Nv01qgGUmgHY4uuXDQF9AL5Whny0y9jkRCXUZL
         8oDuOXB0joNKAURxMECybglNfU0+7tOr2uBs5PGny5tOV6yYlMOGZHgkPQlofKkP6OJS
         KE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVN656SSKNaQlxJCj0G7QK1Aj/Hjf4bAj4VCZn+ACWM=;
        b=UQ9N3Mu0pHaf+LlcXl48Tyg8JqQrTomNg618+05X40ECzk4C1a2StW/9e74nhg0NtW
         DupMDKMKVxs9m229wrVQMUVHhNoWUk15L3F3FtTWG3AjD/9yvGWQ7MMBelSPhSwJEqeO
         ar/cjRxfjLjjGxRZXQwxICPzraTQUH40mx2A4jeeaEJOnkgCr1EBs+gIGBBzyAAwhVHE
         baoRH6N1JDDpta3dHQXPLRvnIeDLTRKSYAySwpZ02s4pIc1JFidbm/N1FPF+MdyfSwpq
         916M5DHOErEi66OAkYjdpG/tEQiLoRMX/DmhhGYQMNAYFzR5rxPriRjsOG6tfES+2pTF
         w1qA==
X-Gm-Message-State: AOAM530nf5RIpnhTfCC9E3nehNMO3vqeHqjdC1KKTNtZojQ7APqCiopu
        YjNr+qqdZc4Sh94sZ3/eAaCS6ibHakBhYfSeTM0=
X-Google-Smtp-Source: ABdhPJz0mqscHOBKVyGogaMyeXuAaPjHH2KA4JC8EnTYT7VoPzXANLWbxUrToyOdVt4ozbOxfpmxE8WbybUkjqK56zM=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr47784858ybu.282.1621973227975;
 Tue, 25 May 2021 13:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
 <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
 <52914cbc-4004-8389-fa7b-6b42cf8f85e1@googlemail.com> <CABBYNZKtApu7Q4kU+msfLco-ihDrx5kWiugDRT0ic3_Tb1YSGg@mail.gmail.com>
 <d97da5b6-a337-3550-ace3-e6789fd9165f@googlemail.com>
In-Reply-To: <d97da5b6-a337-3550-ace3-e6789fd9165f@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 May 2021 13:06:57 -0700
Message-ID: <CABBYNZLYsM_LgKU8r0BRGp3hAk8m2OQWxnwtGz8VwidGCHRB-A@mail.gmail.com>
Subject: Re: BT Intel: Regression loading firmware in linux-5.13-rc3
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, May 25, 2021 at 12:22 PM Chris Clayton <chris2553@googlemail.com> wrote:
>
> Thanks Luiz.
>
> On 25/05/2021 19:10, Luiz Augusto von Dentz wrote:
> > Hi Chris,
> >
> > On Tue, May 25, 2021 at 8:08 AM Chris Clayton <chris2553@googlemail.com> wrote:
> >>
> >> Thanks for your reply, Kiran.
> >>
> >> Does the phrase "next release" mean linux-5.13-rc4 or the next release of linux-firmware?  I just want to know what to
> >> look out for.
> >>
> >> Thanks
> >>
> >> Chris
> >>
> >>
> >> On 25/05/2021 11:14, K, Kiran wrote:
> >>> Hi Chris,
> >>>
> >>> This is a known issue related to firmware and is expected to be fixed in next release.
> >>>
> >>> Thanks,
> >>> Kiran
> >>>
> >>>
> <snip>
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=183dce5a7fd3040ced6a220b0aa536c926f10cd9
> >
> > That said we shall probably merge it to 5.13 before it is released.
> > I think you should, otherwise, without patching, 5.13.0 will be broken for many bluetooth users.
>
> I've applied your patch your patch to Linus' latest and greatest (by hand - it doesn't apply cleanly to the current 5.13
> tree). The error messages are no longer produced and bluetooth is working fine, so...
>
> Tested-by: Chris Clayton <chris2553@googlemail.com>

Shall I have another pull request, or do we need to send this directly
to Linus somehow?

-- 
Luiz Augusto von Dentz
