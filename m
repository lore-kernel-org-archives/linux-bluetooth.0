Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B7EC2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABA4217F4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzEwQptR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgADKhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:37:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35959 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgADKhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 05:37:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so44636182wru.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jan 2020 02:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O8T4cGfNG7KfHEkXB2hndkVFKUeiMMdJlDN6YhAYQPY=;
        b=HzEwQptR5tQN57Wy12WIRF081ZQJptjembyEQvxbrCi1zYAu6OWfNgXh7B6fyI3fB0
         YnU6pqZHhJhKjDKKfYKxGgylLr+Fl0gqPbyGzqu7cGXJ9gyJvd9uboavy1qerkUyOX4Q
         u2o2/aTsGSpSlTr364GXJ9hbx026SJ98j/kBj/QZOXp4Uw07jBZWXArSjinhqDSdN+pS
         /Z8Ie8xPoWZkc0p+D3ZteGxW8YdXJ4fNCYJfEnZNyMaoKJ/1mLJsjYcdVqoVHC8zX3e2
         iA7dXV+eKuGoRk4Yc4YcGq9bdY+e0Drr06F53C0OtCuvjS9aOSy7SxeUy5/tntBF2xfr
         xRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8T4cGfNG7KfHEkXB2hndkVFKUeiMMdJlDN6YhAYQPY=;
        b=jskiRRyTAx8uGQ75Oegbh+mzoTKlwumXAagx7QQdCSYJQDGHf3YLmOi+f8F3QEhobT
         VDXU4AcyFdW/wbFgsyAdnxYQj3ag79F0SjPa5T2C8H+k0/kjsr0lF8lyHyXT2hJ18H+V
         7NlthvKCl/rvK5oUOgdvN3RaZjajSVavNs46poFTIjn8wAOaAlZK8qYYT4w5CUgfZ9NK
         ft6jUDwkfJjwIuv4scO48IAGngJzfBqnQztVgg7FWk4kau+XkuzAlw8ASpYJK0cSFhOE
         fwC+cabmTaNEDfTdA3TiX7NfRZdmMX+pmwE4bVD8z1Ry1JftNu0yXvXriyWpOTX9mYj1
         ag5g==
X-Gm-Message-State: APjAAAV/yJPOeJid/jDlxaKXMEErXn90QBZv/feaEIxkg69ermsxImt0
        pT1atL6BY5dwe6GiPhM5SGg=
X-Google-Smtp-Source: APXvYqxTyOB0QpaeBVbAZx0yFSULGZ/FC7LKgeqzTmAyFCmAPbuG0uaheTCO0JD+A8oouBDE/hI+0Q==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr92100550wrj.225.1578134223875;
        Sat, 04 Jan 2020 02:37:03 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s8sm62716194wrt.57.2020.01.04.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 02:37:02 -0800 (PST)
Date:   Sat, 4 Jan 2020 11:37:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20200104103702.2aoubrrndlxbjlm3@pali>
References: <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
 <20191124111313.gaqjyxmmxigmwmpr@pali>
 <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org>
 <20191126074610.wy5pgjgskv6rxr7y@pali>
 <5ED40B51-1909-46CC-B9BD-9903C18751E5@holtmann.org>
 <20191126080028.2gz43ragmi4zmk6h@pali>
 <CABBYNZK-C9sn-6VB73E_JnKmtzL5mFdgQ0o0VhMN0bTFgKm_ZQ@mail.gmail.com>
 <20191126095838.qd26pg7yvbutikyb@pali>
 <20191205092847.phvm3yf7rxq33637@pali>
 <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tvfk7exsylmpnrhp"
Content-Disposition: inline
In-Reply-To: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--tvfk7exsylmpnrhp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 04 January 2020 11:04:14 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>>>>>>> I played more with C99 flexible arrays and seems that gcc supp=
orts it
> >>>>>>>>>> without any problems. I'm sending another attempt of API imple=
mentation,
> >>>>>>>>>> now with more fields which are needed for Enhanced Setup Synch=
ronous
> >>>>>>>>>> Connection command. This command is not supported by kernel ye=
t, but
> >>>>>>>>>> should be easy to add it. So my ioctl API is prepared for it. =
Enhanced
> >>>>>>>>>> Setup Synchronous Connection command would be needed to use ha=
rdware
> >>>>>>>>>> mSBC codec encoder/decoder.
> >>>>>>>>>>=20
> >>>>>>>>>> --
> >>>>>>>>>> Pali Roh=C3=A1r
> >>>>>>>>>> pali.rohar@gmail.com
> >>>>>>>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/b=
luetooth/bluetooth.h
> >>>>>>>>>> index fabee6db0abb..29590c6749d5 100644
> >>>>>>>>>> --- a/include/net/bluetooth/bluetooth.h
> >>>>>>>>>> +++ b/include/net/bluetooth/bluetooth.h
> >>>>>>>>>> @@ -116,12 +116,49 @@ struct bt_voice {
> >>>>>>>>>>        __u16 setting;
> >>>>>>>>>> };
> >>>>>>>>>>=20
> >>>>>>>>>> -#define BT_VOICE_TRANSPARENT                   0x0003
> >>>>>>>>>> -#define BT_VOICE_CVSD_16BIT                    0x0060
> >>>>>>>>>> -
> >>>>>>>>>> #define BT_SNDMTU               12
> >>>>>>>>>> #define BT_RCVMTU               13
> >>>>>>>>>>=20
> >>>>>>>>>> +#define BT_VOICE_SETUP         14
> >>>>>>>>>> +#define BT_VOICE_PKT_TYPE_CAP_SCO      BIT(0)
> >>>>>>>>>> +#define BT_VOICE_PKT_TYPE_CAP_ESCO     BIT(1)
> >>>>>>>>>> +struct bt_voice_pkt_type {
> >>>>>>>>>> +       __u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_*=
 */
> >>>>>>>>>> +       __u8 retrans_effort;
> >>>>>>>>>> +       __u16 pkt_type;
> >>>>>>>>>> +       __u16 max_latency;
> >>>>>>>>>> +};
> >>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_CONFIG          BIT(0) /* Addi=
tional configuration fields after voice_settings are set (including other f=
eatures) */
> >>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_ADD_SCO         BIT(1) /* Can =
use Add Synchronous Connection */
> >>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO       BIT(2) /* Can =
use Setup Synchronous Connection */
> >>>>>>>>>> +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO   BIT(3) /* Can =
use Enhanced Setup Synchronous Connection */
> >>>>>>>>>> +struct bt_voice_setup {
> >>>>>>>>>> +       __u16 voice_setting;
> >>>>>>>>>> +       __u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* =
*/
> >>>>>>>>>> +       __u8 pkt_types_count;
> >>>>>>>>>> +       __u32 tx_bandwidth;
> >>>>>>>>>> +       __u32 rx_bandwidth;
> >>>>>>>>>> +       __u32 input_bandwidth;
> >>>>>>>>>> +       __u32 output_bandwidth;
> >>>>>>>>>> +       __u8 tx_coding_format[5];
> >>>>>>>>>> +       __u8 rx_coding_format[5];
> >>>>>>>>>> +       __u8 input_coding_format[5];
> >>>>>>>>>> +       __u8 output_coding_format[5];
> >>>>>>>>>> +       __u16 tx_codec_frame_size;
> >>>>>>>>>> +       __u16 rx_codec_frame_size;
> >>>>>>>>>> +       __u16 input_coded_data_size;
> >>>>>>>>>> +       __u16 output_coded_data_size;
> >>>>>>>>>> +       __u8 input_pcm_data_format;
> >>>>>>>>>> +       __u8 output_pcm_data_format;
> >>>>>>>>>> +       __u8 input_pcm_msb_position;
> >>>>>>>>>> +       __u8 output_pcm_msb_position;
> >>>>>>>>>> +       __u8 input_data_path;
> >>>>>>>>>> +       __u8 output_data_path;
> >>>>>>>>>> +       __u8 input_unit_size;
> >>>>>>>>>> +       __u8 output_unit_size;
> >>>>>>>>>> +       struct bt_voice_pkt_type pkt_types[];
> >>>>>>>>>> +};
> >>>>>>>>>> +
> >>>>>>>>>=20
> >>>>>>>>> lets not mush these together. One of these are air codecs and s=
etup defined by a profile, the other are local codec path defined by the pl=
atform.
> >>>>>>>>=20
> >>>>>>>> You are right that air codecs are defined by profile and local c=
odecs by
> >>>>>>>> platform / bluetooth adapter. But ...
> >>>>>>>>=20
> >>>>>>>>> You will also not have multiple local codec path. That will be =
one and they will not be negotiated. The eSCO settings however will be nego=
tiated.
> >>>>>>>>=20
> >>>>>>>> Above structure specify exactly one codec setup and then multipl=
e packet
> >>>>>>>> types. See that flexible array is only for packet types, not for=
 whole
> >>>>>>>> codec structure.
> >>>>>>>>=20
> >>>>>>>> And all above parameters are required for Enhanced Setup Synchro=
nous
> >>>>>>>> Connection command. So kernel needs to know what should put into
> >>>>>>>> Enhanced Setup Synchronous Connection command when creating a ne=
w SCO
> >>>>>>>> connection. So for supporting Enhanced Setup Synchronous Connect=
ion
> >>>>>>>> command userspace needs to pass all above parameters to kernel.
> >>>>>>>>=20
> >>>>>>>> And usage of Enhanced Setup Synchronous Connection is required w=
hen we
> >>>>>>>> want to use in-hardware encoding/decoding of mSBC codec. E.g. new
> >>>>>>>> Thinkpads already have bluetooth adapter which supports encoding=
 and
> >>>>>>>> decoding of mSBC codec in hardware.
> >>>>>>>>=20
> >>>>>>>> So above structure as I define is really needed. Do you see it n=
ow?
> >>>>>>>=20
> >>>>>>> the information are needed, but not that struct. It makes no sens=
e to hand this problem of configuring the PCM data path correctly to the pr=
ofile code. So I am not going to do that. The profile itself has no interes=
t in how the platform is built. What you are going to do is configure possi=
ble PCM data path options and then the kernel will use that information for=
 Enhanced Sync Setup. However the profile should only provide the over-the-=
air settings since that is what is going to be negotiated during the profil=
e setup.
> >>>>>>=20
> >>>>>> Userspace needs to know if kernel expects sound data (via write())=
 in
> >>>>>> mSBC or in PCM_s16le. Also userspace needs to know if kernel provi=
des
> >>>>>> (via read()) sound data in mSBC, PCM_s16le or in other format. Oth=
erwise
> >>>>>> userspace is not possible to send any data to remote headset corre=
ctly.
> >>>>>=20
> >>>>> true, but the profile implementation doesn=E2=80=99t care. It is th=
e audio component eg. PA that cares. Only because HCI has a single command =
for things, doesn=E2=80=99t mean we are stuffing all of the information via=
 a single ioctl and then let userspace deal with the mess. That is not how =
we designed things.
> >>>>=20
> >>>> Ok, so how would userspace then can set those other informations?
> >>>=20
> >>> So to jump in the middle of the discussion but what other formats does
> >>> the userspace would like to use? Afaik we only have PCM_s16le and
> >>> transparent encoded data support so far.
> >>=20
> >> Hi Luiz! As I wrote above, e.g. bluetooth adapters in new Thinkpads
> >> supports in-hardware mSBC encoding/decoding. So you need to say to
> >> adapter if you want mSBC or PCM_s16le. Not "transparent". But it needs
> >> to use "Enhanced Setup Synchronous Connection" call not just basic
> >> "Setup Synchronous Connection". Structure which I defined above is just
> >> copy of parameters which needs to be passed to "Enhanced Setup
> >> Synchronous Connection" call.
> >>=20
> >=20
> > Hello, can we move forward in this problem? If above my proposed API for
> > setting codecs settings is not suitable, could you please propose
> > different which would provide needed functionality?
> >=20
> > Because kernel is currently blocking usage of any other codec and
> > therefore without fixing this issue it is not possible to use any other
> > codec.
> >=20
> > Also kernel is blocking usage of hardware mSBC encoder and decoder which
> > is part of bluetooth adapters (e.g. in new Thinkpads) so it is still
> > needed to do whole encoding / decoding in software...
>=20
> the interface to the kernel needs to minimal. Tell it what you want and i=
t tells you back what you got. Exposing a HCI command structure via ioctl i=
s not the solution.

Marcel, as I said in first email, to use one specific AuriStream codec,
kernel needs to set following SCO properties:

  syncPktTypes =3D 0x003F
  bandwidth =3D 4000
  max_latency =3D 16
  voice_settings =3D 0x63
  retx_effort =3D 2

And to use hardware encoder (e.g. mSBC), kernel needs to userspace allow
to set all parameters for "Enhanced Setup Synchronous Connection" HCI
command.

Otherwise userspace cannot use hardware encoder/decoder.

I do no know how to create more minimal interface as one which I
proposed to allow usage of both AuriStream and also in-hardware
encoders/decoders.

If you do not like my proposed API for it, could you please show me
different solution for API which would allow userspace applications
(e.g. pulseaudio) to use AuriStream codec and also would be able to use
in-hardware encoder/decoders? So pulseaudio would not have to use own
software encoder/decoder when bluetooth adapter supports it in HW?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--tvfk7exsylmpnrhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhBqzAAKCRCL8Mk9A+RD
UvaeAJwPwf0BAVPRWM90mrCeRHC6G0WLcACfdhEiLCYmsqzU4GB3hrtqig2HQ6c=
=bSVL
-----END PGP SIGNATURE-----

--tvfk7exsylmpnrhp--
