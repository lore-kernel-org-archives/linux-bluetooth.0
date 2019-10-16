Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE27AFA3728
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92664207FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbfJPTGp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:06:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37506 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJPTGp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 15:06:45 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p2E5701B0.dip0.t-ipconnect.de [46.87.1.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id D0B69CECDD;
        Wed, 16 Oct 2019 21:15:40 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: Determinate EDR speed
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191013093947.cbqczgnt3uo3f5wi@pali>
Date:   Wed, 16 Oct 2019 21:06:41 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Brian Gix <brian.gix@intel.com>,
        "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <FE2F255A-6762-485B-9166-8348CFB18168@holtmann.org>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
 <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali>
 <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
 <20191011200420.hbrutdclfva2uqpv@pali>
 <CABBYNZL8u2kUnPqiA56DtZyAPZEAUQBaBOC-wuqUQmOW6ZJ=Og@mail.gmail.com>
 <20191013073603.6jnczqr4fk7lpyxq@pali>
 <CABBYNZJx6ZKfBftJoZ2b0pdUXyuY23kA1OUAsZTA4KHVLwoF3w@mail.gmail.com>
 <20191013093947.cbqczgnt3uo3f5wi@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>>>>>> Currently bluez API, method Acquire() already inform called application
>>>>>>>> what is socket MTU for input and output. So from this information it is
>>>>>>>> possible to detect if device supports EDR 3 or not.
>>>>>>>> 
>>>>>>>> But it is too late to have this information. I need to send SBC
>>>>>>>> parameters to bluez first when doing A2DP negotiation, this is early
>>>>>>>> steps before Acquire() is called.
>>>>>>> 
>>>>>>> This seems to be the kind of information which is fixed, for the life of the pairing.
>>>>>>> 
>>>>>>> What if you assumed the lower speed the first time you connected, determined the
>>>>>>> speed during the first streaming, and then either immediately renegotiate (caching the identifying
>>>>>>> information
>>>>>>> of the SNK), or just cache the information for future connections.
>>>>>>> 
>>>>>>> Or the reverse, and assume fast, but immediately adjust down if you aren't getting what you hoped for.
>>>>>>> 
>>>>>>> In any case, this would be a "Device Setup" glitch which you could note as a routine part of pairing in the
>>>>>>> documentation.
>>>>>> 
>>>>>> Or, Stream "Silence" the first time you connect, in order to determine throughput.  It would add 1-2 seconds to
>>>>>> your connection time perhaps, but would be less noticable to the user.
>>>>> 
>>>>> This increase connection time, increase complexity of implementation
>>>>> (lot of things can fail) and just complicate lot of things there. Plus
>>>>> adds that glitch which is not user friendly.
>>>>> 
>>>>> Also bluetooth devices, like headsets, probably do not expects that
>>>>> somebody is going to do such thing and we can hit other implementation
>>>>> problems...
>>>>> 
>>>>> And moreover it is just big hack and workaround for that problem. Not a
>>>>> reasonable solution.
>>>>> 
>>>>> In btmon I can see it, so kernel already knows that information. Why it
>>>>> cannot tell it to userspace and bluetooth daemon to client application?
>>>>> 
>>>>> Client application (e.g. pulseaudio) should really know if is going to
>>>>> talk with bluetooth device with EDR 2 or EDR 3.
>>>>> 
>>>>>>> 
>>>>>>>> Therefore I'm asking for some way how to get information if device
>>>>>>>> supports EDR 2 or EDR 3. This is basically requirement for proper
>>>>>>>> implementation of SBC in high quality mode. So if there are not such API
>>>>>>>> yet, could it be exported from kernel to userspace and bluetoothd
>>>>>>>> daemon?
>>>>>>>> 
>>>>>>>> See these two articles for more details about SBC and its high quality:
>>>>>>>> 
>>>>>>>> https://habr.com/en/post/456182/
>>>>>>>> http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-xq-bluetooth-audio-codec
>>>>>>>> 
>>>>>>>>>> Is there any bluez API for it?
>>>>>>>>>> 
>>>> 
>>>> There quite a few assumption here that are not really how it is
>>>> implemented in BlueZ:
>>>> 
>>>> 1. The L2CAP MTU is not based on the ACL link (should be relatively
>>>> easy to change)
>>>> 2. L2CAP MTU is not required to be symmetric.
>>>> 3. Since the ACL link is shared for all channels we shouldn't really
>>>> assume all throughput will be available
>>>> 4. PA flow control is not just filling up packets and sending them
>>>> when they are full to maximize speed, instead it send packets when
>>>> necessary to maintain a constant speed so the MTU may not be fully
>>>> used, in fact trying to maximize the MTU may result in higher latency
>>>> since packets would be sent less frequently.
>>>> 
>>>> With this in mind I think the only thing we should look into is to
>>>> adjust the default L2CAP MTU to match the underline ACL Link, so it
>>>> maximizes throughput, the remote side may choose a different MTU which
>>>> will have to follow though.
>>> 
>>> Hi Luiz! The main problem is not MTU size, as I wrote I cannot use it
>>> normally for distinguish for usage of SBC XQ or not. Instead of MTU I
>>> rather need to know if device supports EDR 2 or EDR 3.
>> 
>> I was trying to implement this on the kernel to match the MTU size of
>> L2CAP with ACL but the packet type current in use by the connection is
>> not exposed in the connection complete, or at least I couldn't any
>> reference to it, we could possibly expose the packet types via socket
>> option as well but changing it at runtime is probably not a good idea.
> 
> Hello, when I run btmon, I see following information very early before
> creating A2DP connection:
> 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
>        Status: Success (0x00)
>        Handle: 35
>        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
>          ...
>          Enhanced Data Rate ACL 2 Mbps mode
>          Enhanced Data Rate ACL 3 Mbps mode
> 
> I do not need to change MTU size, I would just like to know EDR features
> capabilities. Cannot be those information exported somehow from kernel?
> I guess that kernel should have these information if it can send it to
> btmon.

so I have not seen a single device that only supports one of these two modes. They all support both and if possible you want to use 3 Mpbs anyway since that safes power.

Regards

Marcel

