Return-Path: <SRS0=lPNB=Z3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B392C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E2E24653
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 09:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvi++btq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfLEJ2w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:28:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45515 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEJ2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 04:28:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so2548086wrj.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2019 01:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=g83Uxc2ArmKhJaeGKMBMfxsXiJn7IyanJzVShjXqJWs=;
        b=Jvi++btqMfRg0pgtR1RvJGa9EKtm9gxGbOdGUm7dubteJETZOG2wcgYkl++PujdjEp
         BzmOew3M8oc1qMSR/g//6bkLpMRdegU9EiUFbxjEi4pmwENj4XjROaAQlqZ2klKU/EH2
         xzAZt15rrNSD1rdNDB4XVcw6YSAuW7LhwkrZNlQusS07SCJrAE8XJYikAkEtyRft+1Kj
         EPxhOavDRTZbZpdRzHv7tL+RS0QQyP2oxRZ7uCbUGucuVJUCpx4ytiC22c/42W+Ld2Af
         oEq12W9mrOem5qAU0KVJcqGO3bRMtAGIPw8sru0pkEHTBTq/TzwXBQV+3eUCQI9OHptK
         iTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=g83Uxc2ArmKhJaeGKMBMfxsXiJn7IyanJzVShjXqJWs=;
        b=Wmg+Yc8Ygi9Ahon6JT22zF/qs2h0DE8TgFm6QdHRpodgmw6yj+CzwlY2fIuwXvlqUe
         gzoWNFn/xl3kz3ysjTkUqTIcBCQYwTD6JetzeXQdeEBmU7kcWkI6pDI0tlzKefbj1yS0
         yzoz955ayBlySH2Gi6R66ijoNugB2D7ADmC9t7HOMABMJ2P4CrqdUjaZAw4tCRdW5w8D
         DaLPkL/ZuCxoo8lwQ2gGfKa8CWmUC8aMce6QmKC1Z5Ob/3JECQ6V5rcV90CfEUU03rZi
         J4X0SpUaDeAfmowNTLSxyr+j3a+ma7w356tO2D+jO81DAtmX/5uz1R8DnCKXIAtp5DOB
         nH0g==
X-Gm-Message-State: APjAAAWyFfNOwrHqEmuOUQe0kfPrMmQT0OBkHqZZQ6126YEjPNunYfbm
        nZLBu7jOtJB8sKQZuuSXixE=
X-Google-Smtp-Source: APXvYqz61nGStEfjw4aGBr4RtlN4qI1hDRmy5211dRei4Ax6ZdXE5GXrSgVwtIWUBLbmueSVLKtjXQ==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr3801073wru.318.1575538129428;
        Thu, 05 Dec 2019 01:28:49 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g25sm1547631wmh.3.2019.12.05.01.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Dec 2019 01:28:48 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:28:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>, Pavel Machek <pavel@ucw.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191205092847.phvm3yf7rxq33637@pali>
References: <20191120074411.xtyw34kb3gc73zvk@pali>
 <20191121224455.orhslaa6zdmlwe43@pali>
 <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
 <20191124111313.gaqjyxmmxigmwmpr@pali>
 <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org>
 <20191126074610.wy5pgjgskv6rxr7y@pali>
 <5ED40B51-1909-46CC-B9BD-9903C18751E5@holtmann.org>
 <20191126080028.2gz43ragmi4zmk6h@pali>
 <CABBYNZK-C9sn-6VB73E_JnKmtzL5mFdgQ0o0VhMN0bTFgKm_ZQ@mail.gmail.com>
 <20191126095838.qd26pg7yvbutikyb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126095838.qd26pg7yvbutikyb@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 26 November 2019 10:58:38 Pali Rohár wrote:
> On Tuesday 26 November 2019 11:41:50 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> > 
> > On Tue, Nov 26, 2019 at 10:00 AM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Tuesday 26 November 2019 08:58:44 Marcel Holtmann wrote:
> > > > Hi Pali,
> > > >
> > > > >>>>> I played more with C99 flexible arrays and seems that gcc supports it
> > > > >>>>> without any problems. I'm sending another attempt of API implementation,
> > > > >>>>> now with more fields which are needed for Enhanced Setup Synchronous
> > > > >>>>> Connection command. This command is not supported by kernel yet, but
> > > > >>>>> should be easy to add it. So my ioctl API is prepared for it. Enhanced
> > > > >>>>> Setup Synchronous Connection command would be needed to use hardware
> > > > >>>>> mSBC codec encoder/decoder.
> > > > >>>>>
> > > > >>>>> --
> > > > >>>>> Pali Rohár
> > > > >>>>> pali.rohar@gmail.com
> > > > >>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > > > >>>>> index fabee6db0abb..29590c6749d5 100644
> > > > >>>>> --- a/include/net/bluetooth/bluetooth.h
> > > > >>>>> +++ b/include/net/bluetooth/bluetooth.h
> > > > >>>>> @@ -116,12 +116,49 @@ struct bt_voice {
> > > > >>>>>         __u16 setting;
> > > > >>>>> };
> > > > >>>>>
> > > > >>>>> -#define BT_VOICE_TRANSPARENT                   0x0003
> > > > >>>>> -#define BT_VOICE_CVSD_16BIT                    0x0060
> > > > >>>>> -
> > > > >>>>> #define BT_SNDMTU               12
> > > > >>>>> #define BT_RCVMTU               13
> > > > >>>>>
> > > > >>>>> +#define BT_VOICE_SETUP         14
> > > > >>>>> +#define BT_VOICE_PKT_TYPE_CAP_SCO      BIT(0)
> > > > >>>>> +#define BT_VOICE_PKT_TYPE_CAP_ESCO     BIT(1)
> > > > >>>>> +struct bt_voice_pkt_type {
> > > > >>>>> +       __u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
> > > > >>>>> +       __u8 retrans_effort;
> > > > >>>>> +       __u16 pkt_type;
> > > > >>>>> +       __u16 max_latency;
> > > > >>>>> +};
> > > > >>>>> +#define BT_VOICE_SETUP_FEATURE_CONFIG          BIT(0) /* Additional configuration fields after voice_settings are set (including other features) */
> > > > >>>>> +#define BT_VOICE_SETUP_FEATURE_ADD_SCO         BIT(1) /* Can use Add Synchronous Connection */
> > > > >>>>> +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO       BIT(2) /* Can use Setup Synchronous Connection */
> > > > >>>>> +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO   BIT(3) /* Can use Enhanced Setup Synchronous Connection */
> > > > >>>>> +struct bt_voice_setup {
> > > > >>>>> +       __u16 voice_setting;
> > > > >>>>> +       __u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
> > > > >>>>> +       __u8 pkt_types_count;
> > > > >>>>> +       __u32 tx_bandwidth;
> > > > >>>>> +       __u32 rx_bandwidth;
> > > > >>>>> +       __u32 input_bandwidth;
> > > > >>>>> +       __u32 output_bandwidth;
> > > > >>>>> +       __u8 tx_coding_format[5];
> > > > >>>>> +       __u8 rx_coding_format[5];
> > > > >>>>> +       __u8 input_coding_format[5];
> > > > >>>>> +       __u8 output_coding_format[5];
> > > > >>>>> +       __u16 tx_codec_frame_size;
> > > > >>>>> +       __u16 rx_codec_frame_size;
> > > > >>>>> +       __u16 input_coded_data_size;
> > > > >>>>> +       __u16 output_coded_data_size;
> > > > >>>>> +       __u8 input_pcm_data_format;
> > > > >>>>> +       __u8 output_pcm_data_format;
> > > > >>>>> +       __u8 input_pcm_msb_position;
> > > > >>>>> +       __u8 output_pcm_msb_position;
> > > > >>>>> +       __u8 input_data_path;
> > > > >>>>> +       __u8 output_data_path;
> > > > >>>>> +       __u8 input_unit_size;
> > > > >>>>> +       __u8 output_unit_size;
> > > > >>>>> +       struct bt_voice_pkt_type pkt_types[];
> > > > >>>>> +};
> > > > >>>>> +
> > > > >>>>
> > > > >>>> lets not mush these together. One of these are air codecs and setup defined by a profile, the other are local codec path defined by the platform.
> > > > >>>
> > > > >>> You are right that air codecs are defined by profile and local codecs by
> > > > >>> platform / bluetooth adapter. But ...
> > > > >>>
> > > > >>>> You will also not have multiple local codec path. That will be one and they will not be negotiated. The eSCO settings however will be negotiated.
> > > > >>>
> > > > >>> Above structure specify exactly one codec setup and then multiple packet
> > > > >>> types. See that flexible array is only for packet types, not for whole
> > > > >>> codec structure.
> > > > >>>
> > > > >>> And all above parameters are required for Enhanced Setup Synchronous
> > > > >>> Connection command. So kernel needs to know what should put into
> > > > >>> Enhanced Setup Synchronous Connection command when creating a new SCO
> > > > >>> connection. So for supporting Enhanced Setup Synchronous Connection
> > > > >>> command userspace needs to pass all above parameters to kernel.
> > > > >>>
> > > > >>> And usage of Enhanced Setup Synchronous Connection is required when we
> > > > >>> want to use in-hardware encoding/decoding of mSBC codec. E.g. new
> > > > >>> Thinkpads already have bluetooth adapter which supports encoding and
> > > > >>> decoding of mSBC codec in hardware.
> > > > >>>
> > > > >>> So above structure as I define is really needed. Do you see it now?
> > > > >>
> > > > >> the information are needed, but not that struct. It makes no sense to hand this problem of configuring the PCM data path correctly to the profile code. So I am not going to do that. The profile itself has no interest in how the platform is built. What you are going to do is configure possible PCM data path options and then the kernel will use that information for Enhanced Sync Setup. However the profile should only provide the over-the-air settings since that is what is going to be negotiated during the profile setup.
> > > > >
> > > > > Userspace needs to know if kernel expects sound data (via write()) in
> > > > > mSBC or in PCM_s16le. Also userspace needs to know if kernel provides
> > > > > (via read()) sound data in mSBC, PCM_s16le or in other format. Otherwise
> > > > > userspace is not possible to send any data to remote headset correctly.
> > > >
> > > > true, but the profile implementation doesn’t care. It is the audio component eg. PA that cares. Only because HCI has a single command for things, doesn’t mean we are stuffing all of the information via a single ioctl and then let userspace deal with the mess. That is not how we designed things.
> > >
> > > Ok, so how would userspace then can set those other informations?
> > 
> > So to jump in the middle of the discussion but what other formats does
> > the userspace would like to use? Afaik we only have PCM_s16le and
> > transparent encoded data support so far.
> 
> Hi Luiz! As I wrote above, e.g. bluetooth adapters in new Thinkpads
> supports in-hardware mSBC encoding/decoding. So you need to say to
> adapter if you want mSBC or PCM_s16le. Not "transparent". But it needs
> to use "Enhanced Setup Synchronous Connection" call not just basic
> "Setup Synchronous Connection". Structure which I defined above is just
> copy of parameters which needs to be passed to "Enhanced Setup
> Synchronous Connection" call.
> 

Hello, can we move forward in this problem? If above my proposed API for
setting codecs settings is not suitable, could you please propose
different which would provide needed functionality?

Because kernel is currently blocking usage of any other codec and
therefore without fixing this issue it is not possible to use any other
codec.

Also kernel is blocking usage of hardware mSBC encoder and decoder which
is part of bluetooth adapters (e.g. in new Thinkpads) so it is still
needed to do whole encoding / decoding in software...

-- 
Pali Rohár
pali.rohar@gmail.com
