Return-Path: <SRS0=IqEA=ZQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ABC432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 11:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8276A2073F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 11:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKXLCP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Nov 2019 06:02:15 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45153 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfKXLCP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Nov 2019 06:02:15 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6A972CECD5;
        Sun, 24 Nov 2019 12:11:21 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191121230015.be7qyufbll2khhbx@pali>
Date:   Sun, 24 Nov 2019 12:02:13 +0100
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <668251B3-32EC-41B5-BA31-BB364A7E7D69@holtmann.org>
References: <CABBYNZJKO07p-8ufP7=4WUYS1oLhnsKY_pnP6-0SbVzi=CYZsQ@mail.gmail.com>
 <20190519212157.GB31403@amd> <20190607130245.mv4ch6dxnuptzdki@pali>
 <ED456CCA-CF85-48D9-B7E9-9B0BF02A32FC@holtmann.org>
 <20190708122512.qqfvtm455ltxxg3h@pali>
 <E4A6E61C-DE37-4E5D-9401-71CCE4AE2419@holtmann.org>
 <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <814EF218-4123-4C29-BECB-AF1B556C0F67@holtmann.org>
 <20191121230015.be7qyufbll2khhbx@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>>>>>>>>>>> to be honest, I would rather see WBS implementation finally
>>>>>>>>>>>>> reach PA before we start digging into this.
>>>>>>>>>>>> 
>>>>>>>>>>>> First I want to finish improving A2DP codec support in pulseaudio. Later
>>>>>>>>>>>> I can look at HSP/HFP profiles. Ideally it should have modular/plugin
>>>>>>>>>>>> extensible design. So the aim is that adding new codec would be very
>>>>>>>>>>>> simple, without need to hack something related to mSBC/WBC, AuriStream
>>>>>>>>>>>> or any other codec.
>>>>>>>>>>> 
>>>>>>>>>>> Well HSP don't have support for codec negotiation, but yes a modular
>>>>>>>>>>> design is probably recommended.
>>>>>>>>>>> 
>>>>>>>>>>>> But for AuriStream I need to set custom SCO parameters as described
>>>>>>>>>>>> below and currently kernel does not support it. This is why I'm asking
>>>>>>>>>>>> how kernel can export for userspace configuration of SCO parameters...
>>>>>>>>>>> 
>>>>>>>>>>> We can always come up with socket options but we got to see the value
>>>>>>>>>>> it would bring since AuriStream don't look that popular among
>>>>>>>>>>> headsets, at least Ive never seem any device advertising it like
>>>>>>>>>>> apt-X, etc.
>>>>>>>>>> 
>>>>>>>>>> Pali clearly has such device and he is willing to work on it. Surely
>>>>>>>>>> that means it is popular enough to be supported...?
>>>>>>>>> 
>>>>>>>>> Just put AT+CSRSF=0,0,0,0,0,7 to google search and you would see that
>>>>>>>>> not only I have such device...
>>>>>>>>> 
>>>>>>>>> So I would really would like to see that kernel finally stops blocking
>>>>>>>>> usage of this AuriStream codec.
>>>>>>>> 
>>>>>>>> we need to figure out on how we do the kernel API to allow you this specific setting.
>>>>>>> 
>>>>>>> Hi Marcel! Kernel API for userspace should be simple. Just add two
>>>>>>> ioctls for retrieving and setting structure with custom parameters:
>>>>>>> 
>>>>>>> syncPktTypes = 0x003F
>>>>>>> bandwidth = 4000
>>>>>>> max_latency = 16
>>>>>>> voice_settings = 0x63
>>>>>>> retx_effort = 2
>>>>>>> 
>>>>>>> Or add more ioctls, one ioctl per parameter. There is already only ioctl
>>>>>>> for voice settings and moreover it is whitelisted only for two values.
>>>>>> 
>>>>>> it is not that simple actually. Most profiles define a certain set of parameters and then they try to configure better settings and only fallback to a specification defined default as last resort.
>>>>> 
>>>>> Ok. I see that there is another "example" configuration for AuriStream
>>>>> with just different syncPktTypes = 0x02BF and bandwidth = 3850.
>>>>> 
>>>>> So it really is not simple as it can be seen.
>>>> 
>>>> currently the stepping for mSBC and CVSD are hard-coded in esco_param_cvsd and esco_param_msbc arrays in hci_conn.c and then selected by the ->setting parameter.
>>>> 
>>>> So either we provide an new socket option (for example BT_VOICE_EXT) or we extend BT_VOICE to allow providing the needed information. However this needs to be flexible array size since we should then be able to encode multiple stepping that are tried in order.
>>>> 
>>>> My preference is that we extend BT_VOICE and not introduce a new socket option. So feel free to propose how we can load the full tables into the SCO socket. I mean we are not really far off actually. The only difference is that currently the tables are in the hci_conn.c file and selected by the provided voice->setting. However nothing really stops us from providing the full table via user space.
>>> 
>>> Ok. I will look at it and I will try to propose how to extend current
>>> BT_VOICE ioctl API for supporting all those new parameters.
>>> 
>>>>>>>> We have kept is really simple since there was only CVSD and mSBC as of now.
>>>>>>> 
>>>>>>> Seems that custom codecs are already widely used, so it would be great
>>>>>>> it Linux kernel allows to use also other codecs in future without need
>>>>>>> to explicitly whitelist them.
>>>>>> 
>>>>>> This is an overstatement. I see only one custom codec being used. Unless you have heard from others. However as stated above, I think we need to provide an array of settings that are similar defined to what the HFP spec does. Then we just load the whole set into the kernel.
>>>>> 
>>>>> CVSD and mSBC are in use. IIRC specification also mandates ulaw a alaw
>>>>> codecs but I have not seen it used. Has somebody tried to implement it?
>>>>> I think just replacing voice_settings should be enough as encoding /
>>>>> decoding should be done in bluetooth firmware / hardware.
>>>>> 
>>>>> And then there is AuriStream which based on google results it supported
>>>>> by lot of headsets.
>>>>> 
>>>>> So at least 3 different codecs are widely supported by headset.
>>>> 
>>>> The ulaw and alaw air codecs are in theory possible, but nobody in the history of Bluetooth has used them. So just ignore that part of the specification. For air codecs you have either CVSD or transparent. And then with transparent you get mSBC and AuriStream.
>>> 
>>> More interesting question would be if alaw codec can be used in
>>> transparent mode by transmitter and in "normal alaw" mode by receiver.
>>> So it is possible to "tell" bluetooth chip "hey, I have already prepared
>>> alaw or CVSD packets for you”?
>> 
>> actually alaw is an over the air codec. Using it in transparent mode has no profile support. So while possible, it is not interoperable.
> 
> I'm looking at Voice Setting parameters and it is possible to set Input
> Coding Format to alaw and also Air Coding Format to alaw. It is not
> Transparent Air mode, so above problem with profile interoperability
> does not have to be there. So in theory it should be possible to
> configure bluetooth chip to pass-thru alaw data without re-encoding
> them. So after new API for "unlocking" other non-whitelisted Voice
> Settings is there, this can start to be tested...
> 
> Apparently there is no CVSD Input Coding Format in Voice Setting, so
> CVSD codec data cannot be pass-thru to bt chip via existing Setup
> Synchronous Connection. But there is Enhanced Setup Synchronous
> Connection command which does not use Voice Setting structure which
> seems to be more powerfull in codec handling.

ignore the alaw and ulaw codecs since they are not used. It is a relic from the early years of Bluetooth.

Regards

Marcel

