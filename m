Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07292C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53C423124
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 09:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgLVJtZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 04:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLVJtZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 04:49:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10B0323120;
        Tue, 22 Dec 2020 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608630524;
        bh=ON2PvrNBTrQl4pidbLXh2k32PRkuCcRrHABCcBBNZpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFb7So6lzXl9xGTt4B6MDppZXPo7ZqNny1BVYv8+C3SK8l/x11zQ3hne3YrhnwsgV
         ifZvcs+eVk5s/uVMw7mtPEERCoLvIBDxWJjp96ZofOG1dMDbDpZMotoCcH4tvyV0Sc
         XAax/QUeKg6b8nWC6QS/91XtukJeFEqIyHyPU5IlieHwSeFx6WsGsNGq9McfxcfIV3
         VaA3Qd60GBl0YWw+IiTugKRxcBTR88nmwXkXlmpMEtRw1DPzSMLVCvv64lKZpS2kjy
         kqAmOarBr95jaVSgGaucwy1tp2zpd1qRAAVYc4YeSlwjqLO3FZX+htSSiefx7uzy5x
         c36Z/04xsNb0w==
Received: by pali.im (Postfix)
        id C916C848; Tue, 22 Dec 2020 10:48:41 +0100 (CET)
Date:   Tue, 22 Dec 2020 10:48:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201222094841.uf2klb43kfeot65n@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
 <20201221211437.4s27cl6t4v27sugh@pali>
 <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
 <20201222092100.ru5inf45v55qoa4m@pali>
 <BYAPR14MB2887B82FEA76188DE261115BE6DF0@BYAPR14MB2887.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR14MB2887B82FEA76188DE261115BE6DF0@BYAPR14MB2887.namprd14.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 22 December 2020 09:36:48 Jamie Mccrae wrote:
> Hi,
> 
> > On Monday 21 December 2020 17:54:56 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Mon, Dec 21, 2020 at 1:14 PM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > On Friday 18 December 2020 11:43:32 Luiz Augusto von Dentz wrote:
> > > > > Hi Joakim,
> > > > >
> > > > > On Fri, Dec 18, 2020 at 10:48 AM Joakim Tjernlund
> > > > > <Joakim.Tjernlund@infinera.com> wrote:
> > > > > >
> > > > > > There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC but currently there is no way to select this mode.
> > > > > > Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> > > > >
> > > > > It is in our plan to support HW offloading, but that doesn't mean all
> > > > > platforms will be supported since that depends on the PCM lines being
> > > > > connected to BT controller in the first place.
> > > >
> > > > Dedicated PCM lines are used in embedded world and maybe also still in
> > > > some mobile segment. I remember that e.g. Nokia N900 had this setup. And
> > > > it was quite crazy how it was finally configured... but it worked!
> > > >
> > > > But this is nothing for classic x86 laptops with USB bluetooth
> > > > controllers on classic intel bluetooth+wifi mPCIe cards where SCO
> > > > traffic is routed via HCI (over USB). And not via dedicated PCM pins.
> > > > Moreover I think there are not any mainstream laptop which have PCM pins
> > > > on mPCIe slots usable for such bluetooth mPCIe cards.
> > > >
> > > > For classic desktop / laptop it is needed to deal with fact that SCO
> > > > audio is routed via HCI (like A2DP) and therefore support for Enhanced
> > > > Setup Synchronous Connection HCI command.
> > > >
> > > > AFAIK even for routing SCO over PCM when mSBC hw encoder is used,
> > > > Enhanced Setup Synchronous Connection HCI command is required.
> > >
> > > So you are saying that we should do PCM over HCI and that would
> > > actually work (meaning we have enough bandwidth)?
> >
> > This is something which needs to be tested. And without full
> > implementation (with control of all parameters) we cannot say YES or NO.
> >
> > And if you are aware of bandwidth, Enhanced Setup Synchronous Connection
> > HCI command allows you to use also software based CVSD codec. Meaning
> > that CVSD encoding/decoding can be done by application and therefore
> > decreasing amount of data to transfer to bluetooth adapter.
> >
> > As I said this command is needed also if you want to use mSBC hw encoder
> > over PCM, so I think usage of Enhanced Setup Synchronous Connection HCI
> > command always have benefits to implement it (I have unfinished and
> > untested implementation).
> >
> > > From power point of
> > > view this makes very little sense imo, since all the cycle we save on
> > > no encoding we probably lose with more data to transmit, so are we
> > > looking into use HW encoder just to fix the quality of codec?
> >
> > That is a good question if power consumption would be increased or
> > decreased. Anyway, hw encoding may be able to achieve lower latency. So
> > I rather do not drop it prematurely without any tests.
> >
> > And another important thing, not all bluetooth adapters are USB based,
> > there are adapters connected over UART and SDIO. And every bus can
> > behave differently. USB is domain of laptops, UART can be found on
> > raspberry pi which is also heavily used. SDIO bluetooth is less used but
> > I have there at least device on which is running mainline kernel (5.10)
> > and has SDIO bluetooth.
> 
> Can confirm this, we have SDIO, USB and UART interfaces on the modules
> we supply.

I know :-) I have one of those your devel kits with jumpers for
selecting SDIO/USB/UART interface.

> There are some quirks on how to select routing for PCM, on

The nice feature of Enhanced Setup Synchronous Connection HCI command is
that you can choose routing (HCI or PCI) as argument of this command.

> CSR based designs I'm not sure if this can be changed on the fly via
> a command

If your adapter supports standard Enhanced Setup Synchronous Connection
HCI command and implement it according to specification, then yes, it
should support changing it via command without need to set any quirk or
jumper on board.

You may verify what your adapters support by script sco_features:
https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl

> but the default can be changed via changing the PSKEY
> configuration whilst in BCSP mode. On cypress modules you cannot
> change it dynamically at all, it requires a different firmware (which,
> conversely, cannot be obtained nor changed by users in the field).
> Thanks,
> Jamie
> THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY BE PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND MAY FURTHER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED RECIPIENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY THE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY OF LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE EXPRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
