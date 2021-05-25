Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A411C2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29742613F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 18:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhEYSL6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 14:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEYSLw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 14:11:52 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423CFC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 11:10:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i4so44347808ybe.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmyimM5cHvH2Y+w3J5MKIzLQS3i1SKw1Mrf45YMrUfY=;
        b=RWfDKKY4xBLmsXpxhQb5gHYOv80efugGBCMVpe5GE+svyA4u0fhcRx9AwAJ1e0aLet
         6YqUy2+UEblKQRLZrWwrPZctIqdRVev6q7yDMTVPA6cCt3b+wYkYOvEAQDwBhqAfeM9Y
         1ifSfiA7eS29WNF8LDjAm/tqfjkqIzusXWqMNp6g9TcsPpQFAbPyYOM6XTnIDgHR7m9/
         RWNR3BgvGs+7ln3RekpgCcL/yBuepOyn1sPIWL8qnWaBe1tzhYQIEiZK0Fu2oLDj2XxQ
         AjP5Hm8fpTxCRluPf7Z212OGKpxEx91JevWNk3tKXF9wCTeYtTxttG2Mi/euJw1VAgwD
         0E7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmyimM5cHvH2Y+w3J5MKIzLQS3i1SKw1Mrf45YMrUfY=;
        b=dRUXP+PNcFgjUR0O91fcWFSZHOS9Kq3QHr8G0kMzOK/gwpx6+Cl5i1mP+iskUFrKLX
         RtSWx1eH2zd8ma0zgOxCRX1KTxphlRPOuk+4SkAnkn1L+YgxZtbII+iwsNuMhKTDDSBH
         rODpc6W73fxqlB5Vmc9fu8zhFn19RqdvkRCx+LzptZG6S7w8/TPwexN19zrXlMbvDUuy
         XK+KBItggKJ3ARlTex0SPFjVfZrbkI+tca++77gzkwRNLoM9yaXkKQg+7Nxeo877kO6q
         y1ZsBO4uaEpVTf6TmQYoTmmUSBiFhwht29k4ozNBbEnnVxTr4gaHPCEHiUizdn1JORtY
         spgQ==
X-Gm-Message-State: AOAM5327Fn9QVsUH/iYZG3DXqbH4ca4EaREkDxyouyEZ2xea8UNXfT2Y
        b9EH6THupG0+IPFRQxlZY9tqgHbyuctEMfanD1qJCR75E3U=
X-Google-Smtp-Source: ABdhPJyeeFGtYpvdN2oPo2KXLo8OajGUAL2xu0ztskg/ETTKHgiJgwMAWfWwSrS9n49V7Bp6G8bqMAPckrzBlW0jJ00=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr47009993ybu.282.1621966220474;
 Tue, 25 May 2021 11:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
 <DM8PR11MB5573280FAB275DCEE789D389F5259@DM8PR11MB5573.namprd11.prod.outlook.com>
 <52914cbc-4004-8389-fa7b-6b42cf8f85e1@googlemail.com>
In-Reply-To: <52914cbc-4004-8389-fa7b-6b42cf8f85e1@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 May 2021 11:10:09 -0700
Message-ID: <CABBYNZKtApu7Q4kU+msfLco-ihDrx5kWiugDRT0ic3_Tb1YSGg@mail.gmail.com>
Subject: Re: BT Intel: Regression loading firmware in linux-5.13-rc3
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Tue, May 25, 2021 at 8:08 AM Chris Clayton <chris2553@googlemail.com> wrote:
>
> Thanks for your reply, Kiran.
>
> Does the phrase "next release" mean linux-5.13-rc4 or the next release of linux-firmware?  I just want to know what to
> look out for.
>
> Thanks
>
> Chris
>
>
> On 25/05/2021 11:14, K, Kiran wrote:
> > Hi Chris,
> >
> > This is a known issue related to firmware and is expected to be fixed in next release.
> >
> > Thanks,
> > Kiran
> >
> >
> >> -----Original Message-----
> >> From: Chris Clayton <chris2553@googlemail.com>
> >> Sent: Tuesday, May 25, 2021 3:28 PM
> >> To: linux-bluetooth@vger.kernel.org; Von Dentz, Luiz
> >> <luiz.von.dentz@intel.com>
> >> Subject: BT Intel: Regression loading firmware in linux-5.13-rc3
> >>
> >> Hi,
> >>
> >> I've built and installed 5.13-rc3+ (freshly pulled from Linus' tree). On booting
> >> it I find that none of my bluetooth devices can connect. In the output from
> >> dmesg I find:
> >>
> >> [    8.170332] Bluetooth: hci0: Firmware revision 0.0 build 121 week 7 2021
> >> [    8.171339] bluetooth hci0: Direct firmware load for intel/ibt-19-16-0.sfi
> >> failed with error -2
> >> [    8.171871] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-16-
> >> 0.sfi (-2)
> >>
> >> As you can see it is looking for a non-existent firmware file intel/ibt-19-16-
> >> 0.sfi. intel/ibt-19-16-4.{ddc,sfi} do exist and both 5.12.6 and 5.10.39
> >> successfully load those.
> >>
> >> If I create symbolic links from the ibt-19-16-4 files to ibt-19-16-0 equivalents,
> >> rc3 loads them and my bluetooth devices work fine. I can't find any ibt-19-16-
> >> 0 files in the lkinux-firmware tree on kernel.org (or anywhere else for that
> >> matter).
> >>
> >> I looked at the changes introduced in 5.13 and found a couple of suspects -
> >> d68903da4e220d1e6b7c6ecdb853c36144c6acc9
> >> (Bluetooth: btintel: Consolidate intel_version parsing) and its parent commit
> >> 0a460d8fe2db6887169a19b048ea0c90f8bdc3b7
> >> (Bluetooth: btintel: Consolidate intel_version_tlv parsing). Both were
> >> authored by Luiz Augusto von Dentz and make changes to code that
> >> processes the firmware version data. I built a kernel with
> >> 0a460d8fe2db6887169a19b048ea0c90f8bdc3b7
> >> checked out and that loads the installed firmware fine.
> >> d68903da4e220d1e6b7c6ecdb853c36144c6acc9, however, seems to be the
> >> the change that breaks things because it tries (and obviously fails) to load ibt-
> >> 19-16-0.sfi.
> >>
> >> I can provide any additional diagnostics or test a fix, but please copy me in to
> >> any email because I'm not subscribed to the list.
> >>
> >> In the meantime, I'll use my symlinks workaround.
> >>
> >> Thanks,
> >>
> >> Chris

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=183dce5a7fd3040ced6a220b0aa536c926f10cd9

That said we shall probably merge it to 5.13 before it is released.

-- 
Luiz Augusto von Dentz
