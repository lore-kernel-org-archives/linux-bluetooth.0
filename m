Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C66C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56E322AAC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 10:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLVKUO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 05:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgLVKUO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 05:20:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F31C522AAC;
        Tue, 22 Dec 2020 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608632373;
        bh=fnFESCrIYqaC4XtvJBjfzmhzwKYExEDcvCgvEHtqX8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMzqHC/I6lYsNLAk1Nku7yqs6J1rr9euzzdPb4wfAPA0EjtjXSJy9mAhLN6jDQGBK
         KcVNYyyRcAAd7SNS0tdrEMvWM+oSHocF0COsjF9DPHpfpl8kmiqAj5xx0iEhOUNh2v
         U8NYyVLxQMcPu9QBVhho4SLchPXh6WA9VZoY0pXayJcGjw7YBYM+HwPqM61KeIcZN6
         druRl7SP0Wc5JqHKj/o2zk9AvUkFqTsLd3mGYd2tjrUFRlgFjL5x7opffBAmcSb5a3
         IsoVP5TApYHYxQZJtNvNcA16VIcULCZKIVUF8CVW9Z5ewrEW8Wt3N84IGE1Aix5kig
         btQ8gBjn8jORg==
Received: by pali.im (Postfix)
        id 811D7848; Tue, 22 Dec 2020 11:19:30 +0100 (CET)
Date:   Tue, 22 Dec 2020 11:19:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201222101930.awcxtsgltrrde2d3@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
 <20201221211437.4s27cl6t4v27sugh@pali>
 <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
 <20201222092100.ru5inf45v55qoa4m@pali>
 <BC13598F-C074-4CB3-B24E-10A6E0CF84DB@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC13598F-C074-4CB3-B24E-10A6E0CF84DB@holtmann.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 22 December 2020 11:05:19 Marcel Holtmann wrote:
> Hi Pali,
> 
> >>>>> There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC but currently there is no way to select this mode.
> >>>>> Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> >>>> 
> >>>> It is in our plan to support HW offloading, but that doesn't mean all
> >>>> platforms will be supported since that depends on the PCM lines being
> >>>> connected to BT controller in the first place.
> >>> 
> >>> Dedicated PCM lines are used in embedded world and maybe also still in
> >>> some mobile segment. I remember that e.g. Nokia N900 had this setup. And
> >>> it was quite crazy how it was finally configured... but it worked!
> >>> 
> >>> But this is nothing for classic x86 laptops with USB bluetooth
> >>> controllers on classic intel bluetooth+wifi mPCIe cards where SCO
> >>> traffic is routed via HCI (over USB). And not via dedicated PCM pins.
> >>> Moreover I think there are not any mainstream laptop which have PCM pins
> >>> on mPCIe slots usable for such bluetooth mPCIe cards.
> >>> 
> >>> For classic desktop / laptop it is needed to deal with fact that SCO
> >>> audio is routed via HCI (like A2DP) and therefore support for Enhanced
> >>> Setup Synchronous Connection HCI command.
> >>> 
> >>> AFAIK even for routing SCO over PCM when mSBC hw encoder is used,
> >>> Enhanced Setup Synchronous Connection HCI command is required.
> >> 
> >> So you are saying that we should do PCM over HCI and that would
> >> actually work (meaning we have enough bandwidth)?
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
> 
> CVSD is an air codec only. Controller<->Host is PCM in that case.

Hello!

This is not fully truth. You can use also use CVSD between Controller
and Host. Enhanced Setup Synchronous Connection HCI allows you to do it.

> Only with mSBC you have both air codec and Controller<->Host running with mSBC.

No, you can use it also with other codecs. With all transparent codecs
and CVSD, alaw and ulaw based on capabilities of your bluetooth
adapters.

> Regards
> 
> Marcel
> 
> 
