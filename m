Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2480BC28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CAF208E4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 16:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgEFQnb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 12:43:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40770 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFQnb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 12:43:31 -0400
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8D873CED08;
        Wed,  6 May 2020 18:53:10 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [Bluez PATCH v1 1/2] doc:adding a WidebandSpeechEnabled Api
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZKf2pBSEmBQvLg9Yoy7rR-TfPbokac=mm=wzNo1gwo0YA@mail.gmail.com>
Date:   Wed, 6 May 2020 18:43:28 +0200
Cc:     Alain Michaud <alainmichaud@google.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <075F8853-744B-44F9-B92D-3AE764832C07@holtmann.org>
References: <20200403153331.101846-1-alainm@chromium.org>
 <CALWDO_VvEBqSgJgKHMM7D9G3tTrDEC2u0NUTrPyOsNuOC_F5kQ@mail.gmail.com>
 <CABBYNZJ0SF-atqPx6B26P4Coz2YUXMvSFnW=QnXPUD6i98o-4g@mail.gmail.com>
 <CALWDO_Ubb9NTAqQwv+q9XCKKoC6q2YE2nxX+N5o24fqp3xbvCQ@mail.gmail.com>
 <CABBYNZLvxwtivQZ0Fwv_uZeJZBK6x85Nb8Kr+0orFPteeQcEhg@mail.gmail.com>
 <CALWDO_VPRpxa-jpvQWzR0=ynwi-_v-N3oUz7dthwotfJeb25TQ@mail.gmail.com>
 <CABBYNZ+oJtU+sjc_NFdhPMXVq5d4P-uTgmec9_s7dNVJzpDaQQ@mail.gmail.com>
 <CALWDO_Ux+=YtWsvnNxwpO7W_PSbAmUukyh6MHUoBqStNF7qC2Q@mail.gmail.com>
 <CALWDO_UJtMpTmvWj6KsAJkwzDE=ZXA_bq2Cp2DR-gcBgvQT0cA@mail.gmail.com>
 <CALWDO_WpiztCRau98_eFegrCKNsK4VigKQhw7kvyzFgKLm3NZA@mail.gmail.com>
 <CABBYNZJq43bjTneJ9wsCpzfMWHOGdZyhBFTDfAZcYUWFCv5brQ@mail.gmail.com>
 <CALWDO_XXb8riTsVfVTsYngYwY3u6sZeHDLP9Es8DnfBJfzgkGg@mail.gmail.com>
 <CABBYNZKf2pBSEmBQvLg9Yoy7rR-TfPbokac=mm=wzNo1gwo0YA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>>>>>>>>>>>> This change adds an adapter Api to report the controller's
>>>>>>>>>>>>> widebandspeech enabled state.
>>>>>>>>>>> 
>>>>>>>>>>> I wonder if this shouldn't be queried over SCO socket, or simple fail
>>>>>>>>>>> with BT_VOICE when using BT_VOICE_TRANSPARENT which is how what is
>>>>>>>>>>> normally used when using mSBC.
>>>>>>>>>> 
>>>>>>>>>> I think there is value in both.
>>>>>>>>> 
>>>>>>>>> Can you expand on that? I think this might generate confusion if the
>>>>>>>>> property indicates support for it but HFP implementation don't support
>>>>>>>>> it, since the later is usually implemented as a external profile so we
>>>>>>>>> don't have the features it may support, or perhaps the intention here
>>>>>>>>> is to actually indicate when it is in use?
>>>>>>>> 
>>>>>>>> This is a signal that the adapter supports it and has everything
>>>>>>>> enabled to support it.   Driver indicated it supports it and erroneous
>>>>>>>> data reporting was enabled.  The profile has it's own state which may
>>>>>>>> indicate if msbc will be used, but this will be on a per connection
>>>>>>>> basis and is independent from this adapter property.
>>>>>>>> 
>>>>>>>> The value in this property is to support diagnostic UX about
>>>>>>>> controller capabilities/state and also allow profiles that are
>>>>>>>> implemented outside of bluetoothd to see which codec it can attempt to
>>>>>>>> negotiate with the device.
>>>>>>> 
>>>>>>> For diagnosic I think we would be better off with some dedicated
>>>>>>> interface to query this, as for the later the information we are
>>>>>>> giving does not actually tell anything about the codec support, which
>>>>>>> was part of my original argument that for the likes of HFP and other
>>>>>>> profiles using it it might not be enough and they still need to use
>>>>>>> BT_VOICE in order to enable the use of custom codecs, if you take
>>>>>>> ofono for example it does implement support for wideband speech
>>>>>>> already and it would completely disregard this property which can give
>>>>>>> the false impression that wideband speech cannot be activated when in
>>>>>>> fact it can, it just don't have erroneous data reporting enable, so
>>>>>>> perhaps we should indicate the actual adapter feature (e.g.
>>>>>>> ErrnoneousDataReporting) not the profile feature here, so the profile
>>>>>>> implementation can check weather this would disable use of wideband
>>>>>>> speech or not, futhermore we should probably report the errors back to
>>>>>>> the SCO socket or is that just for diagnostic and cannot be used to
>>>>>>> adjust the streaming?
>>>>>> 
>>>>>> My original patch actually had this MGMT feature called erroneous data
>>>>>> reporting and Marcel argued against it.  If you both agree, then I'm
>>>>>> happy to rename all of this to erroneous data reporting.  We'd still
>>>>>> need some way for the driver support to be messaged some other way
>>>>>> though. see:
>>>>>> 
>>>>>> if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
>>>>>>        set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
>>> 
>>> So this will get a little bit confusing if we don't have a HFP
>>> implementation that actually does implement the profile parts to
>>> enable wideband speech so I wonder if we should rename it to the
>>> underline feature it enables, that said this sort of feature is
>>> probably easier to be queried over the socket itself rather than over
>>> D-Bus so it can be used in conjunction with the likes of BT_VOICE,
>>> also regarding the erroneous data should that be also enabled by the
>>> HFP profile, because depending on the platform it may not support
>>> wideband speech so enabling erroneous data automatically may result in
>>> artifacs, specially in cases where the codecs don't have error
>>> correction or data loss concealment to handle data with possible error
>>> and lost data respectively, btw we don't seem to be parsing the
>>> SCO/ESCO flags and even if we do this properly we need to find a way
>>> to notify them over the socket so things like plc works properly.
>> 
>> This indeed makes sense, but we'll need to decide how erroneous data
>> reporting gets enabled.  The SCO socket is a per connection scope
>> thing while erroneous data reporting is a controller level thing.
> 
> The way I would have done this is to make use of recvmsg and then add
> the packet flags as msg_flags:
> 
>   recvmsg()
>       The recvmsg() call uses a msghdr structure to minimize the
> number of directly supplied arguments.  This structure is defined as
> follows in <sys/socket.h>:
> 
>           struct iovec {                    /* Scatter/gather array items */
>               void  *iov_base;              /* Starting address */
>               size_t iov_len;               /* Number of bytes to transfer */
>           };
> 
>           struct msghdr {
>               void         *msg_name;       /* Optional address */
>               socklen_t     msg_namelen;    /* Size of address */
>               struct iovec *msg_iov;        /* Scatter/gather array */
>               size_t        msg_iovlen;     /* # elements in msg_iov */
>               void         *msg_control;    /* Ancillary data, see below */
>               size_t        msg_controllen; /* Ancillary data buffer len */
>               int           msg_flags;      /* Flags on received message */
>           };
> 
> But to make this backward compatible I would recommend adding a
> socketopt that enables this new behavior and in case there is more
> than one SCO socket those that did not use the sockopt should probably
> drop packets with error or lost data so they work as without erroneous
> data report since in that case the application will likely be using
> regular reads it won't be able to detect the use of msg_flags.

I think that I already send an example on how to do that a while ago. Don’t remember if that was a private email or addressed to the mailing list, but I remember showing how this can be done. Or I confused this with something similar :(

Regards

Marcel

