Return-Path: <SRS0=25t8=VJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B07CC742D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 18:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BEA21783
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 18:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfGLS7e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jul 2019 14:59:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47754 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfGLS7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jul 2019 14:59:33 -0400
Received: from [192.168.22.73] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 94B09CF2CB;
        Fri, 12 Jul 2019 21:07:59 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190708210616.x2dlnzjhnplu37bz@pali>
Date:   Fri, 12 Jul 2019 20:59:22 +0200
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
References: <20190506151651.pu2us2fgsf7w2vos@pali>
 <20190516183429.ql3hxtnmiabcq7tj@pali>
 <CABBYNZLJB0bK7o=Tvf9mhb5U41xAin6SdPY9=76AuEvpEiA_8g@mail.gmail.com>
 <20190519082305.q7y4gpmdhvx3vzvo@pali>
 <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd> <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>>>>>>> to be honest, I would rather see WBS implementation finally
>>>>>>>>> reach PA before we start digging into this.
>>>>>>>> 
>>>>>>>> First I want to finish improving A2DP codec support in pulseaudio. Later
>>>>>>>> I can look at HSP/HFP profiles. Ideally it should have modular/plugin
>>>>>>>> extensible design. So the aim is that adding new codec would be very
>>>>>>>> simple, without need to hack something related to mSBC/WBC, AuriStream
>>>>>>>> or any other codec.
>>>>>>> 
>>>>>>> Well HSP don't have support for codec negotiation, but yes a modular
>>>>>>> design is probably recommended.
>>>>>>> 
>>>>>>>> But for AuriStream I need to set custom SCO parameters as described
>>>>>>>> below and currently kernel does not support it. This is why I'm asking
>>>>>>>> how kernel can export for userspace configuration of SCO parameters...
>>>>>>> 
>>>>>>> We can always come up with socket options but we got to see the value
>>>>>>> it would bring since AuriStream don't look that popular among
>>>>>>> headsets, at least Ive never seem any device advertising it like
>>>>>>> apt-X, etc.
>>>>>> 
>>>>>> Pali clearly has such device and he is willing to work on it. Surely
>>>>>> that means it is popular enough to be supported...?
>>>>> 
>>>>> Just put AT+CSRSF=0,0,0,0,0,7 to google search and you would see that
>>>>> not only I have such device...
>>>>> 
>>>>> So I would really would like to see that kernel finally stops blocking
>>>>> usage of this AuriStream codec.
>>>> 
>>>> we need to figure out on how we do the kernel API to allow you this specific setting.
>>> 
>>> Hi Marcel! Kernel API for userspace should be simple. Just add two
>>> ioctls for retrieving and setting structure with custom parameters:
>>> 
>>> syncPktTypes = 0x003F
>>> bandwidth = 4000
>>> max_latency = 16
>>> voice_settings = 0x63
>>> retx_effort = 2
>>> 
>>> Or add more ioctls, one ioctl per parameter. There is already only ioctl
>>> for voice settings and moreover it is whitelisted only for two values.
>> 
>> it is not that simple actually. Most profiles define a certain set of parameters and then they try to configure better settings and only fallback to a specification defined default as last resort.
> 
> Ok. I see that there is another "example" configuration for AuriStream
> with just different syncPktTypes = 0x02BF and bandwidth = 3850.
> 
> So it really is not simple as it can be seen.

currently the stepping for mSBC and CVSD are hard-coded in esco_param_cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the ->setting parameter.

So either we provide an new socket option (for example BT_VOICE_EXT) or we extend BT_VOICE to allow providing the needed information. However this needs to be flexible array size since we should then be able to encode multiple stepping that are tried in order.

My preference is that we extend BT_VOICE and not introduce a new socket option. So feel free to propose how we can load the full tables into the SCO socket. I mean we are not really far off actually. The only difference is that currently the tables are in the hci_conn.c file and selected by the provided voice->setting. However nothing really stops us from providing the full table via user space.

>>>> We have kept is really simple since there was only CVSD and mSBC as of now.
>>> 
>>> Seems that custom codecs are already widely used, so it would be great
>>> it Linux kernel allows to use also other codecs in future without need
>>> to explicitly whitelist them.
>> 
>> This is an overstatement. I see only one custom codec being used. Unless you have heard from others. However as stated above, I think we need to provide an array of settings that are similar defined to what the HFP spec does. Then we just load the whole set into the kernel.
> 
> CVSD and mSBC are in use. IIRC specification also mandates ulaw a alaw
> codecs but I have not seen it used. Has somebody tried to implement it?
> I think just replacing voice_settings should be enough as encoding /
> decoding should be done in bluetooth firmware / hardware.
> 
> And then there is AuriStream which based on google results it supported
> by lot of headsets.
> 
> So at least 3 different codecs are widely supported by headset.

The ulaw and alaw air codecs are in theory possible, but nobody in the history of Bluetooth has used them. So just ignore that part of the specification. For air codecs you have either CVSD or transparent. And then with transparent you get mSBC and AuriStream.

>>>> I am also curious on what the assumptions are for the USB driver alternate settings are when using a different codec.
>>> 
>>> I did all above tests and kernel changes with USB bluetooth chip which
>>> is integrated in notebook's combo bt+wifi intel minipci-e card.
>> 
>> Good to know. Since for mSBC in theory they need a new alternate settings that wasn’t really available.
> 
> I understood that both mSBC and AuriStream uses "transparent" mode of
> transport and bluetooth chip itself does not know if it transmit mSBC or
> AuriStream as it does not do any encoding…

That is true, but still for transparent codec they defined a new alternate setting for USB.

Regards

Marcel

