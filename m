Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D594B2311D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgLVLrN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 06:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgLVLrM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 06:47:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 131A42311D;
        Tue, 22 Dec 2020 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608637591;
        bh=eVINleRRtL7ju74/ofbjvqqv/rEo6Um5VaKHbtbwQhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUCWQbfhiq2gMbMcuK4o4FvezullljvQ7p6d7qm5YCm10R0fhYX3wGZ3eWZ95vWCU
         R+3GF43gnzDs4m7scPQmYNt50sZrw+pIg4NGQkR/VIeE1hqulVszaq3iZDdArfsq+J
         bI09bf5+oDjzD9Sr1+Cp1A8OdVURCeXJYWNrI+bYsDCOOkiZVTVxhdhgPuxUhSFqHC
         +DxvFDErt8OBhdKwyVNOqOXxvnGsm5qIqMBWyv1X+EcQ/mvW84WE50XVdbFxINS3ge
         fT4SNLPwGIEtQPUz2xGvGZjKDSTp0A0GUsNeJ4q2a4z+rkAKx2HeGUZwHewqWtntGD
         KRt+z+kIrIo3w==
Received: by pali.im (Postfix)
        id A1B9E848; Tue, 22 Dec 2020 12:46:28 +0100 (CET)
Date:   Tue, 22 Dec 2020 12:46:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Message-ID: <20201222114628.pq3lmrvzepel3dj4@pali>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
 <20201221211437.4s27cl6t4v27sugh@pali>
 <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
 <20201222092100.ru5inf45v55qoa4m@pali>
 <BC13598F-C074-4CB3-B24E-10A6E0CF84DB@holtmann.org>
 <20201222101930.awcxtsgltrrde2d3@pali>
 <F698F31D-063A-4A9E-B2BD-D61FA937F561@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F698F31D-063A-4A9E-B2BD-D61FA937F561@holtmann.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

On Tuesday 22 December 2020 12:04:52 Marcel Holtmann wrote:
> Hi Pali,
> 
> >>>>>>> There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC but currently there is no way to select this mode.
> >>>>>>> Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
> >>>>>> 
> >>>>>> It is in our plan to support HW offloading, but that doesn't mean all
> >>>>>> platforms will be supported since that depends on the PCM lines being
> >>>>>> connected to BT controller in the first place.
> >>>>> 
> >>>>> Dedicated PCM lines are used in embedded world and maybe also still in
> >>>>> some mobile segment. I remember that e.g. Nokia N900 had this setup. And
> >>>>> it was quite crazy how it was finally configured... but it worked!
> >>>>> 
> >>>>> But this is nothing for classic x86 laptops with USB bluetooth
> >>>>> controllers on classic intel bluetooth+wifi mPCIe cards where SCO
> >>>>> traffic is routed via HCI (over USB). And not via dedicated PCM pins.
> >>>>> Moreover I think there are not any mainstream laptop which have PCM pins
> >>>>> on mPCIe slots usable for such bluetooth mPCIe cards.
> >>>>> 
> >>>>> For classic desktop / laptop it is needed to deal with fact that SCO
> >>>>> audio is routed via HCI (like A2DP) and therefore support for Enhanced
> >>>>> Setup Synchronous Connection HCI command.
> >>>>> 
> >>>>> AFAIK even for routing SCO over PCM when mSBC hw encoder is used,
> >>>>> Enhanced Setup Synchronous Connection HCI command is required.
> >>>> 
> >>>> So you are saying that we should do PCM over HCI and that would
> >>>> actually work (meaning we have enough bandwidth)?
> >>> 
> >>> This is something which needs to be tested. And without full
> >>> implementation (with control of all parameters) we cannot say YES or NO.
> >>> 
> >>> And if you are aware of bandwidth, Enhanced Setup Synchronous Connection
> >>> HCI command allows you to use also software based CVSD codec. Meaning
> >>> that CVSD encoding/decoding can be done by application and therefore
> >>> decreasing amount of data to transfer to bluetooth adapter.
> >>> 
> >>> As I said this command is needed also if you want to use mSBC hw encoder
> >>> over PCM, so I think usage of Enhanced Setup Synchronous Connection HCI
> >>> command always have benefits to implement it (I have unfinished and
> >>> untested implementation).
> >> 
> >> CVSD is an air codec only. Controller<->Host is PCM in that case.
> > 
> > Hello!
> > 
> > This is not fully truth. You can use also use CVSD between Controller
> > and Host. Enhanced Setup Synchronous Connection HCI allows you to do it.
> 
> so the spec is unclear in case of HCI transport. It could be stipulated that CVSD is also possible. However it is not practical since the controller would have to re-encode in case a different air codec is used. The reality is that all “legacy” devices decided for CVSD air codec and PCM host codec.
> 
> Going into this direction of allowing CVSD as host codec is just a waste of time.

Well, people are complaining about CVSD quality and there are still lot
of headsets which support only CVSD. Therefore I see a good reason to
try encode/decode of CVSD in software and check if software encoder or
decoder cannot increase this quality. I'm not saying that it can really
improve it but without testing we do not know. And as I know how poor
are some hardware implementations of codecs (but not all) I would not be
surprised if for some bluetooth adapters this can really increase
quality for CVSD transports... But without real tests we do not know.

> >> Only with mSBC you have both air codec and Controller<->Host running with mSBC.
> > 
> > No, you can use it also with other codecs. With all transparent codecs
> > and CVSD, alaw and ulaw based on capabilities of your bluetooth
> > adapters.
> 
> The case when it is not CVSD, alaw and ulaw is pretty clear written in the spec. Both have to be transparent.

Yes, for air part it has to be either: CVSD, ALAW, ULAW or TRANSPARENT.
So all other additional codecs use transparent on AIR part.

But on local part it can be also any other codec defined in some
assigned number document.

> I think that the spec and the assigned numbers document is not really clear in specifying which of the Coding_Format fields apply when HCI transport is used vs external channel.

It is months ago when I read specification last time, but I think that
at the time when I read it I understood that also CVSD codec may be used
by local part if is supported.

> I would really assume that when the host is running the codec, then it is transparent.

This is truth for "Setup Synchronous Connection". But not for "Enhanced
Setup Synchronous Connection". In "Enhanced" version you can have local
codec for host also "CVSD", also "mSBC" and also any other which adapter
returns in the "local codec" list or in "vendor codec" list. And for
local part in "Enhanced" version this is *not* transparent anymore.

Of course "Enhanced" version support also "transparent" code and behave
like in classic non-enhanced version.

> When the codec is offload to the controller, then the host transport is Linear PCM.
> 
> So you I would plan for CVSD<->CVSD<->PCM, Transparent<->{mSBC,LC3}<->PCM, Transparent<->Transparent<->{mSBC,LC3} for the SCO/eSCO cases.

You forgot AuriStream codec which is used and heavily supported by lot
of headsets. Just people do not know that is is supported.

I would really suggest to look at my API for specifying codec parameters
on socket and allow usage of "Enhanced Setup Synchronous Connection".

I do not think it is waste of time. At least it allows doing all kind of
test what adapters support and what is the quality of transport.

> Regards
> 
> Marcel
> 
