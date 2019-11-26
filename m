Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47804C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 09:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA5820722
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 09:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuLANRf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfKZJmF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:42:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43967 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfKZJmF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 04:42:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so16025687oie.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 01:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jf5EIjsF1zIE4rZEsCdq3UZYbpBfbbo8P8PdG6Ci7Uw=;
        b=nuLANRf/SAN6QDcDNRp1kK7WjB2iV/QBo+XRjWwHmP4C1vYLkXht2LIgiBBZdy50mr
         Ak9xWDg8/+wlLMjCVWInogD9Y1AYqaQcCUrOqVHVy6b/U8sBc12HGkxxItf99A9cqICL
         p+PczEpZsXx7psz2KuLUDJ7GZo7H3giHIWSNFiXWDFyPgIhWmDRDQKbP/af2t132XimA
         DPmm8pPBrMkzqyTUoTXXKSw+DWPbshmdgsY7V93eOUMZAPlJoZFKv5l9gi858yybQmDI
         9EAn1akrUqqxevm99SmQGW36hQhTi+iNXyQw61M9GbcLVf7lNGImNkQMU4zs/U5MQecU
         mr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jf5EIjsF1zIE4rZEsCdq3UZYbpBfbbo8P8PdG6Ci7Uw=;
        b=KJrUEHUugnHAcdO8unCioU6K+n20acsO2n4PJzwedq+/faCPUzqo00G47AI32R0tBU
         AMVxilbrvgqi7xwo40KStJRbyUX+UPKmBAwkpz6HbAo+ZHw/0uVMXnPnu6CP/3YniRs+
         s9jnS4Q+2vL4GG14VGOL26vEGDAmua4rbEj2ZzesOucH3dkeb6WeLVJFGvSG71H47925
         ZELxSAOcwc8Raq5yt97qhTd1xXo6sGQ2b0mCButX9E3SRgUZFcjXl9qN2xDHkcMKhYsw
         SqZGtRuEERSVw+v0e1NkJ/U9SMSm2GQoOaslrjnvaBUsJYtbS6wwqQ9qibWreSng5BcG
         /Tsg==
X-Gm-Message-State: APjAAAU9cds7tnInDoLpPesDPsw2POp8DviSKcUkvbdOmKVmSA3sLJKx
        NeN9DbPFMkNgq0nhlM50R9W+mFpS1UmEIVf2bJM=
X-Google-Smtp-Source: APXvYqw2zhqR6Icz1wA1cpRS7jDl0Zyd9AMV9bcH0ddAt+X9/ckTzAYicUegkM9SdCvXjSOaMKzSXZEH85A5UwVFLfc=
X-Received: by 2002:aca:da06:: with SMTP id r6mr2771534oig.82.1574761323512;
 Tue, 26 Nov 2019 01:42:03 -0800 (PST)
MIME-Version: 1.0
References: <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
 <20191119171342.mwfzszu7xwabi7to@pali> <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
 <20191120074411.xtyw34kb3gc73zvk@pali> <20191121224455.orhslaa6zdmlwe43@pali>
 <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org> <20191124111313.gaqjyxmmxigmwmpr@pali>
 <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org> <20191126074610.wy5pgjgskv6rxr7y@pali>
 <5ED40B51-1909-46CC-B9BD-9903C18751E5@holtmann.org> <20191126080028.2gz43ragmi4zmk6h@pali>
In-Reply-To: <20191126080028.2gz43ragmi4zmk6h@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 26 Nov 2019 11:41:50 +0200
Message-ID: <CABBYNZK-C9sn-6VB73E_JnKmtzL5mFdgQ0o0VhMN0bTFgKm_ZQ@mail.gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>, Pavel Machek <pavel@ucw.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Tue, Nov 26, 2019 at 10:00 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> On Tuesday 26 November 2019 08:58:44 Marcel Holtmann wrote:
> > Hi Pali,
> >
> > >>>>> I played more with C99 flexible arrays and seems that gcc support=
s it
> > >>>>> without any problems. I'm sending another attempt of API implemen=
tation,
> > >>>>> now with more fields which are needed for Enhanced Setup Synchron=
ous
> > >>>>> Connection command. This command is not supported by kernel yet, =
but
> > >>>>> should be easy to add it. So my ioctl API is prepared for it. Enh=
anced
> > >>>>> Setup Synchronous Connection command would be needed to use hardw=
are
> > >>>>> mSBC codec encoder/decoder.
> > >>>>>
> > >>>>> --
> > >>>>> Pali Roh=C3=A1r
> > >>>>> pali.rohar@gmail.com
> > >>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/blue=
tooth/bluetooth.h
> > >>>>> index fabee6db0abb..29590c6749d5 100644
> > >>>>> --- a/include/net/bluetooth/bluetooth.h
> > >>>>> +++ b/include/net/bluetooth/bluetooth.h
> > >>>>> @@ -116,12 +116,49 @@ struct bt_voice {
> > >>>>>         __u16 setting;
> > >>>>> };
> > >>>>>
> > >>>>> -#define BT_VOICE_TRANSPARENT                   0x0003
> > >>>>> -#define BT_VOICE_CVSD_16BIT                    0x0060
> > >>>>> -
> > >>>>> #define BT_SNDMTU               12
> > >>>>> #define BT_RCVMTU               13
> > >>>>>
> > >>>>> +#define BT_VOICE_SETUP         14
> > >>>>> +#define BT_VOICE_PKT_TYPE_CAP_SCO      BIT(0)
> > >>>>> +#define BT_VOICE_PKT_TYPE_CAP_ESCO     BIT(1)
> > >>>>> +struct bt_voice_pkt_type {
> > >>>>> +       __u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
> > >>>>> +       __u8 retrans_effort;
> > >>>>> +       __u16 pkt_type;
> > >>>>> +       __u16 max_latency;
> > >>>>> +};
> > >>>>> +#define BT_VOICE_SETUP_FEATURE_CONFIG          BIT(0) /* Additio=
nal configuration fields after voice_settings are set (including other feat=
ures) */
> > >>>>> +#define BT_VOICE_SETUP_FEATURE_ADD_SCO         BIT(1) /* Can use=
 Add Synchronous Connection */
> > >>>>> +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO       BIT(2) /* Can use=
 Setup Synchronous Connection */
> > >>>>> +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO   BIT(3) /* Can use=
 Enhanced Setup Synchronous Connection */
> > >>>>> +struct bt_voice_setup {
> > >>>>> +       __u16 voice_setting;
> > >>>>> +       __u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
> > >>>>> +       __u8 pkt_types_count;
> > >>>>> +       __u32 tx_bandwidth;
> > >>>>> +       __u32 rx_bandwidth;
> > >>>>> +       __u32 input_bandwidth;
> > >>>>> +       __u32 output_bandwidth;
> > >>>>> +       __u8 tx_coding_format[5];
> > >>>>> +       __u8 rx_coding_format[5];
> > >>>>> +       __u8 input_coding_format[5];
> > >>>>> +       __u8 output_coding_format[5];
> > >>>>> +       __u16 tx_codec_frame_size;
> > >>>>> +       __u16 rx_codec_frame_size;
> > >>>>> +       __u16 input_coded_data_size;
> > >>>>> +       __u16 output_coded_data_size;
> > >>>>> +       __u8 input_pcm_data_format;
> > >>>>> +       __u8 output_pcm_data_format;
> > >>>>> +       __u8 input_pcm_msb_position;
> > >>>>> +       __u8 output_pcm_msb_position;
> > >>>>> +       __u8 input_data_path;
> > >>>>> +       __u8 output_data_path;
> > >>>>> +       __u8 input_unit_size;
> > >>>>> +       __u8 output_unit_size;
> > >>>>> +       struct bt_voice_pkt_type pkt_types[];
> > >>>>> +};
> > >>>>> +
> > >>>>
> > >>>> lets not mush these together. One of these are air codecs and setu=
p defined by a profile, the other are local codec path defined by the platf=
orm.
> > >>>
> > >>> You are right that air codecs are defined by profile and local code=
cs by
> > >>> platform / bluetooth adapter. But ...
> > >>>
> > >>>> You will also not have multiple local codec path. That will be one=
 and they will not be negotiated. The eSCO settings however will be negotia=
ted.
> > >>>
> > >>> Above structure specify exactly one codec setup and then multiple p=
acket
> > >>> types. See that flexible array is only for packet types, not for wh=
ole
> > >>> codec structure.
> > >>>
> > >>> And all above parameters are required for Enhanced Setup Synchronou=
s
> > >>> Connection command. So kernel needs to know what should put into
> > >>> Enhanced Setup Synchronous Connection command when creating a new S=
CO
> > >>> connection. So for supporting Enhanced Setup Synchronous Connection
> > >>> command userspace needs to pass all above parameters to kernel.
> > >>>
> > >>> And usage of Enhanced Setup Synchronous Connection is required when=
 we
> > >>> want to use in-hardware encoding/decoding of mSBC codec. E.g. new
> > >>> Thinkpads already have bluetooth adapter which supports encoding an=
d
> > >>> decoding of mSBC codec in hardware.
> > >>>
> > >>> So above structure as I define is really needed. Do you see it now?
> > >>
> > >> the information are needed, but not that struct. It makes no sense t=
o hand this problem of configuring the PCM data path correctly to the profi=
le code. So I am not going to do that. The profile itself has no interest i=
n how the platform is built. What you are going to do is configure possible=
 PCM data path options and then the kernel will use that information for En=
hanced Sync Setup. However the profile should only provide the over-the-air=
 settings since that is what is going to be negotiated during the profile s=
etup.
> > >
> > > Userspace needs to know if kernel expects sound data (via write()) in
> > > mSBC or in PCM_s16le. Also userspace needs to know if kernel provides
> > > (via read()) sound data in mSBC, PCM_s16le or in other format. Otherw=
ise
> > > userspace is not possible to send any data to remote headset correctl=
y.
> >
> > true, but the profile implementation doesn=E2=80=99t care. It is the au=
dio component eg. PA that cares. Only because HCI has a single command for =
things, doesn=E2=80=99t mean we are stuffing all of the information via a s=
ingle ioctl and then let userspace deal with the mess. That is not how we d=
esigned things.
>
> Ok, so how would userspace then can set those other informations?

So to jump in the middle of the discussion but what other formats does
the userspace would like to use? Afaik we only have PCM_s16le and
transparent encoded data support so far.

--=20
Luiz Augusto von Dentz
