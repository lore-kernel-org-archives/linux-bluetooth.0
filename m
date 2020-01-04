Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2DEC2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA31217F4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgADKER convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:04:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42218 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgADKER (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 05:04:17 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id CAFA3CED12;
        Sat,  4 Jan 2020 11:13:30 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191205092847.phvm3yf7rxq33637@pali>
Date:   Sat, 4 Jan 2020 11:04:14 +0100
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
References: <20191120074411.xtyw34kb3gc73zvk@pali>
 <20191121224455.orhslaa6zdmlwe43@pali>
 <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
 <20191124111313.gaqjyxmmxigmwmpr@pali>
 <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org>
 <20191126074610.wy5pgjgskv6rxr7y@pali>
 <5ED40B51-1909-46CC-B9BD-9903C18751E5@holtmann.org>
 <20191126080028.2gz43ragmi4zmk6h@pali>
 <CABBYNZK-C9sn-6VB73E_JnKmtzL5mFdgQ0o0VhMN0bTFgKm_ZQ@mail.gmail.com>
 <20191126095838.qd26pg7yvbutikyb@pali> <20191205092847.phvm3yf7rxq33637@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>>>>>>>> I played more with C99 flexible arrays and seems that gcc supports it
>>>>>>>>>> without any problems. I'm sending another attempt of API implementation,
>>>>>>>>>> now with more fields which are needed for Enhanced Setup Synchronous
>>>>>>>>>> Connection command. This command is not supported by kernel yet, but
>>>>>>>>>> should be easy to add it. So my ioctl API is prepared for it. Enhanced
>>>>>>>>>> Setup Synchronous Connection command would be needed to use hardware
>>>>>>>>>> mSBC codec encoder/decoder.
>>>>>>>>>> 
>>>>>>>>>> --
>>>>>>>>>> Pali Rohár
>>>>>>>>>> pali.rohar@gmail.com
>>>>>>>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>>>>>>>>>> index fabee6db0abb..29590c6749d5 100644
>>>>>>>>>> --- a/include/net/bluetooth/bluetooth.h
>>>>>>>>>> +++ b/include/net/bluetooth/bluetooth.h
>>>>>>>>>> @@ -116,12 +116,49 @@ struct bt_voice {
>>>>>>>>>>        __u16 setting;
>>>>>>>>>> };
>>>>>>>>>> 
>>>>>>>>>> -#define BT_VOICE_TRANSPARENT                   0x0003
>>>>>>>>>> -#define BT_VOICE_CVSD_16BIT                    0x0060
>>>>>>>>>> -
>>>>>>>>>> #define BT_SNDMTU               12
>>>>>>>>>> #define BT_RCVMTU               13
>>>>>>>>>> 
>>>>>>>>>> +#define BT_VOICE_SETUP         14
>>>>>>>>>> +#define BT_VOICE_PKT_TYPE_CAP_SCO      BIT(0)
>>>>>>>>>> +#define BT_VOICE_PKT_TYPE_CAP_ESCO     BIT(1)
>>>>>>>>>> +struct bt_voice_pkt_type {
>>>>>>>>>> +       __u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
>>>>>>>>>> +       __u8 retrans_effort;
>>>>>>>>>> +       __u16 pkt_type;
>>>>>>>>>> +       __u16 max_latency;
>>>>>>>>>> +};
>>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_CONFIG          BIT(0) /* Additional configuration fields after voice_settings are set (including other features) */
>>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_ADD_SCO         BIT(1) /* Can use Add Synchronous Connection */
>>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO       BIT(2) /* Can use Setup Synchronous Connection */
>>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO   BIT(3) /* Can use Enhanced Setup Synchronous Connection */
>>>>>>>>>> +struct bt_voice_setup {
>>>>>>>>>> +       __u16 voice_setting;
>>>>>>>>>> +       __u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
>>>>>>>>>> +       __u8 pkt_types_count;
>>>>>>>>>> +       __u32 tx_bandwidth;
>>>>>>>>>> +       __u32 rx_bandwidth;
>>>>>>>>>> +       __u32 input_bandwidth;
>>>>>>>>>> +       __u32 output_bandwidth;
>>>>>>>>>> +       __u8 tx_coding_format[5];
>>>>>>>>>> +       __u8 rx_coding_format[5];
>>>>>>>>>> +       __u8 input_coding_format[5];
>>>>>>>>>> +       __u8 output_coding_format[5];
>>>>>>>>>> +       __u16 tx_codec_frame_size;
>>>>>>>>>> +       __u16 rx_codec_frame_size;
>>>>>>>>>> +       __u16 input_coded_data_size;
>>>>>>>>>> +       __u16 output_coded_data_size;
>>>>>>>>>> +       __u8 input_pcm_data_format;
>>>>>>>>>> +       __u8 output_pcm_data_format;
>>>>>>>>>> +       __u8 input_pcm_msb_position;
>>>>>>>>>> +       __u8 output_pcm_msb_position;
>>>>>>>>>> +       __u8 input_data_path;
>>>>>>>>>> +       __u8 output_data_path;
>>>>>>>>>> +       __u8 input_unit_size;
>>>>>>>>>> +       __u8 output_unit_size;
>>>>>>>>>> +       struct bt_voice_pkt_type pkt_types[];
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>> 
>>>>>>>>> lets not mush these together. One of these are air codecs and setup defined by a profile, the other are local codec path defined by the platform.
>>>>>>>> 
>>>>>>>> You are right that air codecs are defined by profile and local codecs by
>>>>>>>> platform / bluetooth adapter. But ...
>>>>>>>> 
>>>>>>>>> You will also not have multiple local codec path. That will be one and they will not be negotiated. The eSCO settings however will be negotiated.
>>>>>>>> 
>>>>>>>> Above structure specify exactly one codec setup and then multiple packet
>>>>>>>> types. See that flexible array is only for packet types, not for whole
>>>>>>>> codec structure.
>>>>>>>> 
>>>>>>>> And all above parameters are required for Enhanced Setup Synchronous
>>>>>>>> Connection command. So kernel needs to know what should put into
>>>>>>>> Enhanced Setup Synchronous Connection command when creating a new SCO
>>>>>>>> connection. So for supporting Enhanced Setup Synchronous Connection
>>>>>>>> command userspace needs to pass all above parameters to kernel.
>>>>>>>> 
>>>>>>>> And usage of Enhanced Setup Synchronous Connection is required when we
>>>>>>>> want to use in-hardware encoding/decoding of mSBC codec. E.g. new
>>>>>>>> Thinkpads already have bluetooth adapter which supports encoding and
>>>>>>>> decoding of mSBC codec in hardware.
>>>>>>>> 
>>>>>>>> So above structure as I define is really needed. Do you see it now?
>>>>>>> 
>>>>>>> the information are needed, but not that struct. It makes no sense to hand this problem of configuring the PCM data path correctly to the profile code. So I am not going to do that. The profile itself has no interest in how the platform is built. What you are going to do is configure possible PCM data path options and then the kernel will use that information for Enhanced Sync Setup. However the profile should only provide the over-the-air settings since that is what is going to be negotiated during the profile setup.
>>>>>> 
>>>>>> Userspace needs to know if kernel expects sound data (via write()) in
>>>>>> mSBC or in PCM_s16le. Also userspace needs to know if kernel provides
>>>>>> (via read()) sound data in mSBC, PCM_s16le or in other format. Otherwise
>>>>>> userspace is not possible to send any data to remote headset correctly.
>>>>> 
>>>>> true, but the profile implementation doesn’t care. It is the audio component eg. PA that cares. Only because HCI has a single command for things, doesn’t mean we are stuffing all of the information via a single ioctl and then let userspace deal with the mess. That is not how we designed things.
>>>> 
>>>> Ok, so how would userspace then can set those other informations?
>>> 
>>> So to jump in the middle of the discussion but what other formats does
>>> the userspace would like to use? Afaik we only have PCM_s16le and
>>> transparent encoded data support so far.
>> 
>> Hi Luiz! As I wrote above, e.g. bluetooth adapters in new Thinkpads
>> supports in-hardware mSBC encoding/decoding. So you need to say to
>> adapter if you want mSBC or PCM_s16le. Not "transparent". But it needs
>> to use "Enhanced Setup Synchronous Connection" call not just basic
>> "Setup Synchronous Connection". Structure which I defined above is just
>> copy of parameters which needs to be passed to "Enhanced Setup
>> Synchronous Connection" call.
>> 
> 
> Hello, can we move forward in this problem? If above my proposed API for
> setting codecs settings is not suitable, could you please propose
> different which would provide needed functionality?
> 
> Because kernel is currently blocking usage of any other codec and
> therefore without fixing this issue it is not possible to use any other
> codec.
> 
> Also kernel is blocking usage of hardware mSBC encoder and decoder which
> is part of bluetooth adapters (e.g. in new Thinkpads) so it is still
> needed to do whole encoding / decoding in software...

the interface to the kernel needs to minimal. Tell it what you want and it tells you back what you got. Exposing a HCI command structure via ioctl is not the solution.

Regards

Marcel

