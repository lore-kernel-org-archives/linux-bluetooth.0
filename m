Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1818BC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 14:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB64D2343E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 14:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbhAMOrf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbhAMOre (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 09:47:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF9F2313C;
        Wed, 13 Jan 2021 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610549214;
        bh=v3aPVJ0p5J6rEfv3CEEw4tRh4E/LPzgmRGFcuL2kKEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tj25B7uNYGL8MLzqUZemjmtSGfvCHofR4tkXex27AtZ41mpr3KrXlV/bQ6Auea94Q
         RaLZudxXTNKBOL+6wI1SjYo5/NvrkEfdjhRPGTeHOyX7hay5Y5R+Soj3l71hA4ml84
         ZNomrd6/RNyKWZeVarDicsMolN6yhyAzFn0btUnzWLeI+XUTSSVU8QUlbqadrUcG+a
         JJlCzfuITmQx9H9XxTcs2PLPDeNh2ShFiEHA8QIvuzKHWu0DH+0sxs6lHHoe7W9u8i
         tMQitHMAH3jtXC115DCS4yP731sxWxypjtLb8KyTtORXkj1F57u09Mwd4We4Av2rXO
         yNCyC+t9k6ORg==
Received: by pali.im (Postfix)
        id 97C5076D; Wed, 13 Jan 2021 15:46:51 +0100 (CET)
Date:   Wed, 13 Jan 2021 15:46:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20210113144651.opemzlelw3baccm6@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
 <20201221211437.4s27cl6t4v27sugh@pali>
 <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 21 December 2020 17:54:56 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Mon, Dec 21, 2020 at 1:14 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Friday 18 December 2020 11:43:32 Luiz Augusto von Dentz wrote:
> > > Hi Joakim,
> > >
> > > On Fri, Dec 18, 2020 at 10:48 AM Joakim Tjernlund
> > > <Joakim.Tjernlund@infinera.com> wrote:
> > > >
> > > > There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC but currently there is no way to select this mode.
> > > > Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> > >
> > > It is in our plan to support HW offloading, but that doesn't mean all
> > > platforms will be supported since that depends on the PCM lines being
> > > connected to BT controller in the first place.
> >
> > Dedicated PCM lines are used in embedded world and maybe also still in
> > some mobile segment. I remember that e.g. Nokia N900 had this setup. And
> > it was quite crazy how it was finally configured... but it worked!
> >
> > But this is nothing for classic x86 laptops with USB bluetooth
> > controllers on classic intel bluetooth+wifi mPCIe cards where SCO
> > traffic is routed via HCI (over USB). And not via dedicated PCM pins.
> > Moreover I think there are not any mainstream laptop which have PCM pins
> > on mPCIe slots usable for such bluetooth mPCIe cards.
> >
> > For classic desktop / laptop it is needed to deal with fact that SCO
> > audio is routed via HCI (like A2DP) and therefore support for Enhanced
> > Setup Synchronous Connection HCI command.
> >
> > AFAIK even for routing SCO over PCM when mSBC hw encoder is used,
> > Enhanced Setup Synchronous Connection HCI command is required.
> 
> So you are saying that we should do PCM over HCI and that would
> actually work (meaning we have enough bandwidth)? From power point of
> view this makes very little sense imo, since all the cycle we save on
> no encoding we probably lose with more data to transmit

I do not think so that this applies to all setups. And even if you have
truth then at least CPU usage would be lower and CPU can be used for
additional work. So I do not think that usage of HW encoder/decoder
makes very little sense. In any case it can offload work from CPU.
