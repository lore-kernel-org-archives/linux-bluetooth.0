Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595CFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 01:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 225EA22A83
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 01:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgLVBzs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 20:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBzs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 20:55:48 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD4C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 17:55:07 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q25so13262983oij.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 17:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EEJ9XDEDxh32XxCT/9b3NAcSNe+PSiQul44bfGmlkRU=;
        b=AR2cg79zchew2H3/ClYxVtztROrvesbovCjLjZiBWGrvDU1/9Z4is08ZdRxgisBb4T
         ohEGb/GZz1Xl5wBdsxGaOjKqZCYgvNpMRWFLn+N23aQhq30ejsYupXjH2yfTaVMOAZ95
         wP1R8icYVS3+jTPFckhlSGcrZzQiqIlLmJE6leWV4KImVlmAWiaD9K85bKzePxxHQ4e/
         Vlreb+l7bR+nZuqnXiNIaVTTPhMh76ExSErRlAO8rHO5p+T3g9k437HIqbS6Z5N0LVvN
         /lOslhsvdSx1NsgWH8SSUDlKXs/ZQsrgAQwkbxfcPSoNpHdwG92iy1KbdZkQvn14KL1s
         ATpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EEJ9XDEDxh32XxCT/9b3NAcSNe+PSiQul44bfGmlkRU=;
        b=NPa67205GBok54kH9mohrzFsa0OAqwiitBu3d6d/4Gb/9FLjJwoERAj5VaJpDJsXjG
         pPX40qideqNvNseuKl/GXL4FmKps1unjK0iM7oZqEjJwo3qUXta5O2P7k2Jml1sR6mrx
         GwCzcCQEt4Ip6Yrd3OrX/NeRhaASzy2gFIYPgZwe7kut2WoMVzaNP2QouPmkAJMLuMEl
         4a6AkMiiiDLCRuum7uPNdpZG8z6tv7iXFkfki8OUqcVi0fL73e1+c9CttawUkMPDEGRx
         mVgJGdorUqzYue8hlVxDqG15Mmm7K45cLd/FnyrXD3obS50RrhCmkX5rozj3w9zogFfV
         frxw==
X-Gm-Message-State: AOAM531pJGtWa14JPKXga5TG5BfBa9UJUbS3JD1PwbPbg+ednK6iLAd3
        rY5jJqPB7hzMQr9ZXsJK8ojjfAmewMqxX4IEaNQ=
X-Google-Smtp-Source: ABdhPJzVQbMvtLYMMm8JiJrbVMJOlz6uzdri9QtVnlYnJfVRjgc13YlNYMlANUNJ8CYdbgx50Y8H0alAw4cAH+J2Rfk=
X-Received: by 2002:aca:f456:: with SMTP id s83mr12845702oih.58.1608602107332;
 Mon, 21 Dec 2020 17:55:07 -0800 (PST)
MIME-Version: 1.0
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com> <20201221211437.4s27cl6t4v27sugh@pali>
In-Reply-To: <20201221211437.4s27cl6t4v27sugh@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Dec 2020 17:54:56 -0800
Message-ID: <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
Subject: Re: Default to HW mSBC on capable controllers ?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Dec 21, 2020 at 1:14 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Friday 18 December 2020 11:43:32 Luiz Augusto von Dentz wrote:
> > Hi Joakim,
> >
> > On Fri, Dec 18, 2020 at 10:48 AM Joakim Tjernlund
> > <Joakim.Tjernlund@infinera.com> wrote:
> > >
> > > There seems to be quite a few USB controllers gaining the BTUSB_WIDEB=
AND_SPEECH which I guess means HW mSBC but currently there is no way to sel=
ect this mode.
> > > Any idea if one could patch the kernel to default to HW mSBC and user=
 apps like bluealsa/pulseaudio would just use it automatically?
> >
> > It is in our plan to support HW offloading, but that doesn't mean all
> > platforms will be supported since that depends on the PCM lines being
> > connected to BT controller in the first place.
>
> Dedicated PCM lines are used in embedded world and maybe also still in
> some mobile segment. I remember that e.g. Nokia N900 had this setup. And
> it was quite crazy how it was finally configured... but it worked!
>
> But this is nothing for classic x86 laptops with USB bluetooth
> controllers on classic intel bluetooth+wifi mPCIe cards where SCO
> traffic is routed via HCI (over USB). And not via dedicated PCM pins.
> Moreover I think there are not any mainstream laptop which have PCM pins
> on mPCIe slots usable for such bluetooth mPCIe cards.
>
> For classic desktop / laptop it is needed to deal with fact that SCO
> audio is routed via HCI (like A2DP) and therefore support for Enhanced
> Setup Synchronous Connection HCI command.
>
> AFAIK even for routing SCO over PCM when mSBC hw encoder is used,
> Enhanced Setup Synchronous Connection HCI command is required.

So you are saying that we should do PCM over HCI and that would
actually work (meaning we have enough bandwidth)? From power point of
view this makes very little sense imo, since all the cycle we save on
no encoding we probably lose with more data to transmit, so are we
looking into use HW encoder just to fix the quality of codec?

--=20
Luiz Augusto von Dentz
