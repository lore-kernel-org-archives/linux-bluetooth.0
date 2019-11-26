Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B43C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C9C20722
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 08:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7o1Jd2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKZIAe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:00:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47099 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfKZIAd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 03:00:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so17773642wrl.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 00:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sPrEx3f7PIr/AehHkiaahQgyYZ5b8sS4hKy17C4wjeM=;
        b=n7o1Jd2fPzHr/UqpRm6IzfCyS1xFZzL32YzQqGn0/49mP/SKovthTNskwmENRL2U/+
         +FSGq9INzivqXA2/KvgRyRkRqM3Z4epQGpArOgvs53p4pddQwlcBPsVIXBAwn7blzf4o
         ZTf+3wtoMoV9BNBpRPcac4Tt6ZSaDTWCSamhXVq/IEsGA1AbNYUdo6qjuMnJOODm01O9
         icS6x8W8GIM3q+nVgHrc9L6FiZhR/8WktabkBtDNj+2WcTToA54MkY/TyktbJTxrbI1Q
         cw4A52+5nuxcErJzP4tGJwnTDFVzTaXJL0J8lL19MdmVMEgPX0pTllGxeJlJUFUYnOK4
         jB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sPrEx3f7PIr/AehHkiaahQgyYZ5b8sS4hKy17C4wjeM=;
        b=V3YKiKix/b6ykzyAuOALHFNe1qz7jm/l3Ra5IjGUPeZjdipMl6Rl6ndSualF88yUzh
         hUqe4kSIdsTgJ2sR+pGqQT7p3Kv6e4EFPL1c9XYENk5dmQd93QMrBQ2fyKQa0EO5m7d4
         DW1/JzP1qGnig8iIOBBq1DM8xYFZlWOuVTzUtnYK6H++GcLpGlfgIp9MRy181UXiZvB/
         nnMC3Ot1BssroR0k8ec4lsqAEjOvZw7QmjG5HWgWi3eBUGNF94AeeuQlFbl7yJvYrBPb
         X20lcGMJ8FkDBidqFcz9106U3h/OQsMMpJ71nObmP7grNBUtloY2s/el4bhbBag7nM3S
         4xgQ==
X-Gm-Message-State: APjAAAU13q4ZU9HoyQuE0Le3Z8s2cNNu2ayHUl6lZXDTDz8vD4ymAz14
        GLwsoe5QnQ3BsSBU8YjXJZc=
X-Google-Smtp-Source: APXvYqx0LAsdimk9FFt/GmAFb1MWRHpbIJXonSOXTC++pvDYzcHmhxtK/PWDMzMrcr58RTKno80FxA==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr19007210wrt.219.1574755229992;
        Tue, 26 Nov 2019 00:00:29 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v128sm2314078wmb.14.2019.11.26.00.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Nov 2019 00:00:29 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:00:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191126080028.2gz43ragmi4zmk6h@pali>
References: <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
 <20191119171342.mwfzszu7xwabi7to@pali>
 <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
 <20191120074411.xtyw34kb3gc73zvk@pali>
 <20191121224455.orhslaa6zdmlwe43@pali>
 <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
 <20191124111313.gaqjyxmmxigmwmpr@pali>
 <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org>
 <20191126074610.wy5pgjgskv6rxr7y@pali>
 <5ED40B51-1909-46CC-B9BD-9903C18751E5@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bo6frin4grrzmf7b"
Content-Disposition: inline
In-Reply-To: <5ED40B51-1909-46CC-B9BD-9903C18751E5@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--bo6frin4grrzmf7b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 26 November 2019 08:58:44 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>> I played more with C99 flexible arrays and seems that gcc supports =
it
> >>>>> without any problems. I'm sending another attempt of API implementa=
tion,
> >>>>> now with more fields which are needed for Enhanced Setup Synchronous
> >>>>> Connection command. This command is not supported by kernel yet, but
> >>>>> should be easy to add it. So my ioctl API is prepared for it. Enhan=
ced
> >>>>> Setup Synchronous Connection command would be needed to use hardware
> >>>>> mSBC codec encoder/decoder.
> >>>>>=20
> >>>>> --=20
> >>>>> Pali Roh=C3=A1r
> >>>>> pali.rohar@gmail.com
> >>>>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/blueto=
oth/bluetooth.h
> >>>>> index fabee6db0abb..29590c6749d5 100644
> >>>>> --- a/include/net/bluetooth/bluetooth.h
> >>>>> +++ b/include/net/bluetooth/bluetooth.h
> >>>>> @@ -116,12 +116,49 @@ struct bt_voice {
> >>>>> 	__u16 setting;
> >>>>> };
> >>>>>=20
> >>>>> -#define BT_VOICE_TRANSPARENT			0x0003
> >>>>> -#define BT_VOICE_CVSD_16BIT			0x0060
> >>>>> -
> >>>>> #define BT_SNDMTU		12
> >>>>> #define BT_RCVMTU		13
> >>>>>=20
> >>>>> +#define BT_VOICE_SETUP		14
> >>>>> +#define BT_VOICE_PKT_TYPE_CAP_SCO	BIT(0)
> >>>>> +#define BT_VOICE_PKT_TYPE_CAP_ESCO	BIT(1)
> >>>>> +struct bt_voice_pkt_type {
> >>>>> +	__u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
> >>>>> +	__u8 retrans_effort;
> >>>>> +	__u16 pkt_type;
> >>>>> +	__u16 max_latency;
> >>>>> +};
> >>>>> +#define BT_VOICE_SETUP_FEATURE_CONFIG		BIT(0) /* Additional config=
uration fields after voice_settings are set (including other features) */
> >>>>> +#define BT_VOICE_SETUP_FEATURE_ADD_SCO		BIT(1) /* Can use Add Sync=
hronous Connection */
> >>>>> +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO	BIT(2) /* Can use Setup S=
ynchronous Connection */
> >>>>> +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO	BIT(3) /* Can use Enh=
anced Setup Synchronous Connection */
> >>>>> +struct bt_voice_setup {
> >>>>> +	__u16 voice_setting;
> >>>>> +	__u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
> >>>>> +	__u8 pkt_types_count;
> >>>>> +	__u32 tx_bandwidth;
> >>>>> +	__u32 rx_bandwidth;
> >>>>> +	__u32 input_bandwidth;
> >>>>> +	__u32 output_bandwidth;
> >>>>> +	__u8 tx_coding_format[5];
> >>>>> +	__u8 rx_coding_format[5];
> >>>>> +	__u8 input_coding_format[5];
> >>>>> +	__u8 output_coding_format[5];
> >>>>> +	__u16 tx_codec_frame_size;
> >>>>> +	__u16 rx_codec_frame_size;
> >>>>> +	__u16 input_coded_data_size;
> >>>>> +	__u16 output_coded_data_size;
> >>>>> +	__u8 input_pcm_data_format;
> >>>>> +	__u8 output_pcm_data_format;
> >>>>> +	__u8 input_pcm_msb_position;
> >>>>> +	__u8 output_pcm_msb_position;
> >>>>> +	__u8 input_data_path;
> >>>>> +	__u8 output_data_path;
> >>>>> +	__u8 input_unit_size;
> >>>>> +	__u8 output_unit_size;
> >>>>> +	struct bt_voice_pkt_type pkt_types[];
> >>>>> +};
> >>>>> +
> >>>>=20
> >>>> lets not mush these together. One of these are air codecs and setup =
defined by a profile, the other are local codec path defined by the platfor=
m.
> >>>=20
> >>> You are right that air codecs are defined by profile and local codecs=
 by
> >>> platform / bluetooth adapter. But ...
> >>>=20
> >>>> You will also not have multiple local codec path. That will be one a=
nd they will not be negotiated. The eSCO settings however will be negotiate=
d.
> >>>=20
> >>> Above structure specify exactly one codec setup and then multiple pac=
ket
> >>> types. See that flexible array is only for packet types, not for whole
> >>> codec structure.
> >>>=20
> >>> And all above parameters are required for Enhanced Setup Synchronous
> >>> Connection command. So kernel needs to know what should put into
> >>> Enhanced Setup Synchronous Connection command when creating a new SCO
> >>> connection. So for supporting Enhanced Setup Synchronous Connection
> >>> command userspace needs to pass all above parameters to kernel.
> >>>=20
> >>> And usage of Enhanced Setup Synchronous Connection is required when we
> >>> want to use in-hardware encoding/decoding of mSBC codec. E.g. new
> >>> Thinkpads already have bluetooth adapter which supports encoding and
> >>> decoding of mSBC codec in hardware.
> >>>=20
> >>> So above structure as I define is really needed. Do you see it now?
> >>=20
> >> the information are needed, but not that struct. It makes no sense to =
hand this problem of configuring the PCM data path correctly to the profile=
 code. So I am not going to do that. The profile itself has no interest in =
how the platform is built. What you are going to do is configure possible P=
CM data path options and then the kernel will use that information for Enha=
nced Sync Setup. However the profile should only provide the over-the-air s=
ettings since that is what is going to be negotiated during the profile set=
up.
> >=20
> > Userspace needs to know if kernel expects sound data (via write()) in
> > mSBC or in PCM_s16le. Also userspace needs to know if kernel provides
> > (via read()) sound data in mSBC, PCM_s16le or in other format. Otherwise
> > userspace is not possible to send any data to remote headset correctly.
>=20
> true, but the profile implementation doesn=E2=80=99t care. It is the audi=
o component eg. PA that cares. Only because HCI has a single command for th=
ings, doesn=E2=80=99t mean we are stuffing all of the information via a sin=
gle ioctl and then let userspace deal with the mess. That is not how we des=
igned things.

Ok, so how would userspace then can set those other informations?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--bo6frin4grrzmf7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdzbmgAKCRCL8Mk9A+RD
Up9YAJ0Tu3e9qF7DRe/yQpzzdDxGiS8JwACgwkZeb3xlpwp0IrpA7iInHkMzpxQ=
=b7cj
-----END PGP SIGNATURE-----

--bo6frin4grrzmf7b--
