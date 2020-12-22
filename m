Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C806C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5CD23105
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 11:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgLVLFf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 06:05:35 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40286 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgLVLFf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 06:05:35 -0500
Received: from mac-pro.holtmann.net (p4ff9fbc9.dip0.t-ipconnect.de [79.249.251.201])
        by mail.holtmann.org (Postfix) with ESMTPSA id 722A1CED1D;
        Tue, 22 Dec 2020 12:12:10 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: Default to HW mSBC on capable controllers ?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201222101930.awcxtsgltrrde2d3@pali>
Date:   Tue, 22 Dec 2020 12:04:52 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F698F31D-063A-4A9E-B2BD-D61FA937F561@holtmann.org>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
 <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
 <20201221211437.4s27cl6t4v27sugh@pali>
 <CABBYNZ+tGt4Duf=aYzWPG0OSATj0ZN6oQeFmvw=Un_JVK9C_rQ@mail.gmail.com>
 <20201222092100.ru5inf45v55qoa4m@pali>
 <BC13598F-C074-4CB3-B24E-10A6E0CF84DB@holtmann.org>
 <20201222101930.awcxtsgltrrde2d3@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>>>>> There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SPEECH which I guess means HW mSBC but currently there is no way to select this mode.
>>>>>>> Any idea if one could patch the kernel to default to HW mSBC and user apps like bluealsa/pulseaudio would just use it automatically?
>>>>>> 
>>>>>> It is in our plan to support HW offloading, but that doesn't mean all
>>>>>> platforms will be supported since that depends on the PCM lines being
>>>>>> connected to BT controller in the first place.
>>>>> 
>>>>> Dedicated PCM lines are used in embedded world and maybe also still in
>>>>> some mobile segment. I remember that e.g. Nokia N900 had this setup. And
>>>>> it was quite crazy how it was finally configured... but it worked!
>>>>> 
>>>>> But this is nothing for classic x86 laptops with USB bluetooth
>>>>> controllers on classic intel bluetooth+wifi mPCIe cards where SCO
>>>>> traffic is routed via HCI (over USB). And not via dedicated PCM pins.
>>>>> Moreover I think there are not any mainstream laptop which have PCM pins
>>>>> on mPCIe slots usable for such bluetooth mPCIe cards.
>>>>> 
>>>>> For classic desktop / laptop it is needed to deal with fact that SCO
>>>>> audio is routed via HCI (like A2DP) and therefore support for Enhanced
>>>>> Setup Synchronous Connection HCI command.
>>>>> 
>>>>> AFAIK even for routing SCO over PCM when mSBC hw encoder is used,
>>>>> Enhanced Setup Synchronous Connection HCI command is required.
>>>> 
>>>> So you are saying that we should do PCM over HCI and that would
>>>> actually work (meaning we have enough bandwidth)?
>>> 
>>> This is something which needs to be tested. And without full
>>> implementation (with control of all parameters) we cannot say YES or NO.
>>> 
>>> And if you are aware of bandwidth, Enhanced Setup Synchronous Connection
>>> HCI command allows you to use also software based CVSD codec. Meaning
>>> that CVSD encoding/decoding can be done by application and therefore
>>> decreasing amount of data to transfer to bluetooth adapter.
>>> 
>>> As I said this command is needed also if you want to use mSBC hw encoder
>>> over PCM, so I think usage of Enhanced Setup Synchronous Connection HCI
>>> command always have benefits to implement it (I have unfinished and
>>> untested implementation).
>> 
>> CVSD is an air codec only. Controller<->Host is PCM in that case.
> 
> Hello!
> 
> This is not fully truth. You can use also use CVSD between Controller
> and Host. Enhanced Setup Synchronous Connection HCI allows you to do it.

so the spec is unclear in case of HCI transport. It could be stipulated that CVSD is also possible. However it is not practical since the controller would have to re-encode in case a different air codec is used. The reality is that all “legacy” devices decided for CVSD air codec and PCM host codec.

Going into this direction of allowing CVSD as host codec is just a waste of time.

>> Only with mSBC you have both air codec and Controller<->Host running with mSBC.
> 
> No, you can use it also with other codecs. With all transparent codecs
> and CVSD, alaw and ulaw based on capabilities of your bluetooth
> adapters.

The case when it is not CVSD, alaw and ulaw is pretty clear written in the spec. Both have to be transparent. I think that the spec and the assigned numbers document is not really clear in specifying which of the Coding_Format fields apply when HCI transport is used vs external channel.

I would really assume that when the host is running the codec, then it is transparent. When the codec is offload to the controller, then the host transport is Linear PCM.

So you I would plan for CVSD<->CVSD<->PCM, Transparent<->{mSBC,LC3}<->PCM, Transparent<->Transparent<->{mSBC,LC3} for the SCO/eSCO cases.

Regards

Marcel

