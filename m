Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9E0C43215
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 07:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A0820748
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 07:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLUtDY5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfKZHqP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 02:46:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46238 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfKZHqP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 02:46:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so17729812wrl.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 23:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zc9WbRJiJdJcjiAGV2smffMvq6oyWdAb1ojKwQ1oh5E=;
        b=TLUtDY5YvfGoyT5R4ydG4H/+c997bvVLpC3GiUIReBbyp0AFLdujPZpcfGXGHzCGCT
         uItqhcZvfF/Ldqf8AniMee4I9OVwQ/UqwLk7OzjQieXuiX0aFq1OvzgzXHoRNX1BaWkI
         rpevdXzWxo5HeVg6Ou4Z0r7nfdpLqCYrTk3wh30BW4zeAzW+zRapRxNCntV5yuHNEqkb
         +tA7anrdDnpXz8LrkU46N3G6OX05rUmU2SG4TF5PkHIpIsIFbO2iVZA0R2TB3PCP6Aar
         Di9Fn0JQnfgQ4M3EKSYcfHke1Bxx9Un9JF6c7mYZVZzO2/hzZoqlzRLFP1YpngM9VO1k
         EXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zc9WbRJiJdJcjiAGV2smffMvq6oyWdAb1ojKwQ1oh5E=;
        b=ju4okDsCdVcMIhjQZ6r3O74zHzeSi80kGQS6apFxf+esnS5RBVcDCEW7lKbvdMob0s
         7MFUVA0ecgIhAC8o7RQbwBzj4fGNWcTHqrOS5OR8eeXtfysEdrmoxDunjdMRcuKMG8TK
         JAorNLcK7JQoXwmyYD3pOHfcapVR/CI4dU48gZ9kEe78Z2VNPi22XS0wYmuwvxpA0Ei1
         U7A/4M/+Oh6x6/06dr42rIjHfRBxiyypZGxSP/OcE0DYaAG3J0qSVL5IBq+ckXqt0i/8
         O/4xUSk6Oh8PQZcldawHjWucrrYJS/V9aCQuV47la1FEpZ/a0rjs9N5DJzGITRWxa66v
         ZuXQ==
X-Gm-Message-State: APjAAAVq1VitXew3n5tPGkqCw+59m/HKyiJWAqIrfa7bzbXaZSWV+5HC
        saCar5Qm3J+BSbSU2QV0/Ig=
X-Google-Smtp-Source: APXvYqzd04YqiFnlFx03gzEetD7iToLgAz1ISfC6CioKc4bj9IyvZ36IcpKcXXHjU7t9+TvtuTt4hw==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr36063255wro.122.1574754372789;
        Mon, 25 Nov 2019 23:46:12 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c11sm13596297wrv.92.2019.11.25.23.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Nov 2019 23:46:11 -0800 (PST)
Date:   Tue, 26 Nov 2019 08:46:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191126074610.wy5pgjgskv6rxr7y@pali>
References: <20190718100939.bwl26qcfxe6ppcto@pali>
 <20191027220945.wmb3g55wtrmqbnmz@pali>
 <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
 <20191119171342.mwfzszu7xwabi7to@pali>
 <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
 <20191120074411.xtyw34kb3gc73zvk@pali>
 <20191121224455.orhslaa6zdmlwe43@pali>
 <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
 <20191124111313.gaqjyxmmxigmwmpr@pali>
 <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7lb2z4g7eugkw5ds"
Content-Disposition: inline
In-Reply-To: <8A14D8FE-A2B1-437E-B7A8-FAE5B39ADC5E@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--7lb2z4g7eugkw5ds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 26 November 2019 08:24:04 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>> I played more with C99 flexible arrays and seems that gcc supports it
> >>> without any problems. I'm sending another attempt of API implementati=
on,
> >>> now with more fields which are needed for Enhanced Setup Synchronous
> >>> Connection command. This command is not supported by kernel yet, but
> >>> should be easy to add it. So my ioctl API is prepared for it. Enhanced
> >>> Setup Synchronous Connection command would be needed to use hardware
> >>> mSBC codec encoder/decoder.
> >>>=20
> >>> --=20
> >>> Pali Roh=C3=A1r
> >>> pali.rohar@gmail.com
> >>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> >>> index fabee6db0abb..29590c6749d5 100644
> >>> --- a/include/net/bluetooth/bluetooth.h
> >>> +++ b/include/net/bluetooth/bluetooth.h
> >>> @@ -116,12 +116,49 @@ struct bt_voice {
> >>> 	__u16 setting;
> >>> };
> >>>=20
> >>> -#define BT_VOICE_TRANSPARENT			0x0003
> >>> -#define BT_VOICE_CVSD_16BIT			0x0060
> >>> -
> >>> #define BT_SNDMTU		12
> >>> #define BT_RCVMTU		13
> >>>=20
> >>> +#define BT_VOICE_SETUP		14
> >>> +#define BT_VOICE_PKT_TYPE_CAP_SCO	BIT(0)
> >>> +#define BT_VOICE_PKT_TYPE_CAP_ESCO	BIT(1)
> >>> +struct bt_voice_pkt_type {
> >>> +	__u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
> >>> +	__u8 retrans_effort;
> >>> +	__u16 pkt_type;
> >>> +	__u16 max_latency;
> >>> +};
> >>> +#define BT_VOICE_SETUP_FEATURE_CONFIG		BIT(0) /* Additional configur=
ation fields after voice_settings are set (including other features) */
> >>> +#define BT_VOICE_SETUP_FEATURE_ADD_SCO		BIT(1) /* Can use Add Synchr=
onous Connection */
> >>> +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO	BIT(2) /* Can use Setup Syn=
chronous Connection */
> >>> +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO	BIT(3) /* Can use Enhan=
ced Setup Synchronous Connection */
> >>> +struct bt_voice_setup {
> >>> +	__u16 voice_setting;
> >>> +	__u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
> >>> +	__u8 pkt_types_count;
> >>> +	__u32 tx_bandwidth;
> >>> +	__u32 rx_bandwidth;
> >>> +	__u32 input_bandwidth;
> >>> +	__u32 output_bandwidth;
> >>> +	__u8 tx_coding_format[5];
> >>> +	__u8 rx_coding_format[5];
> >>> +	__u8 input_coding_format[5];
> >>> +	__u8 output_coding_format[5];
> >>> +	__u16 tx_codec_frame_size;
> >>> +	__u16 rx_codec_frame_size;
> >>> +	__u16 input_coded_data_size;
> >>> +	__u16 output_coded_data_size;
> >>> +	__u8 input_pcm_data_format;
> >>> +	__u8 output_pcm_data_format;
> >>> +	__u8 input_pcm_msb_position;
> >>> +	__u8 output_pcm_msb_position;
> >>> +	__u8 input_data_path;
> >>> +	__u8 output_data_path;
> >>> +	__u8 input_unit_size;
> >>> +	__u8 output_unit_size;
> >>> +	struct bt_voice_pkt_type pkt_types[];
> >>> +};
> >>> +
> >>=20
> >> lets not mush these together. One of these are air codecs and setup de=
fined by a profile, the other are local codec path defined by the platform.
> >=20
> > You are right that air codecs are defined by profile and local codecs by
> > platform / bluetooth adapter. But ...
> >=20
> >> You will also not have multiple local codec path. That will be one and=
 they will not be negotiated. The eSCO settings however will be negotiated.
> >=20
> > Above structure specify exactly one codec setup and then multiple packet
> > types. See that flexible array is only for packet types, not for whole
> > codec structure.
> >=20
> > And all above parameters are required for Enhanced Setup Synchronous
> > Connection command. So kernel needs to know what should put into
> > Enhanced Setup Synchronous Connection command when creating a new SCO
> > connection. So for supporting Enhanced Setup Synchronous Connection
> > command userspace needs to pass all above parameters to kernel.
> >=20
> > And usage of Enhanced Setup Synchronous Connection is required when we
> > want to use in-hardware encoding/decoding of mSBC codec. E.g. new
> > Thinkpads already have bluetooth adapter which supports encoding and
> > decoding of mSBC codec in hardware.
> >=20
> > So above structure as I define is really needed. Do you see it now?
>=20
> the information are needed, but not that struct. It makes no sense to han=
d this problem of configuring the PCM data path correctly to the profile co=
de. So I am not going to do that. The profile itself has no interest in how=
 the platform is built. What you are going to do is configure possible PCM =
data path options and then the kernel will use that information for Enhance=
d Sync Setup. However the profile should only provide the over-the-air sett=
ings since that is what is going to be negotiated during the profile setup.

Userspace needs to know if kernel expects sound data (via write()) in
mSBC or in PCM_s16le. Also userspace needs to know if kernel provides
(via read()) sound data in mSBC, PCM_s16le or in other format. Otherwise
userspace is not possible to send any data to remote headset correctly.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7lb2z4g7eugkw5ds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdzYQAAKCRCL8Mk9A+RD
UnRxAJ4jv+c5ivd+AOx5bpxotEEM/OTleACeI9/NZkOW4LgwvbHdCTpeAPNeqOw=
=US3p
-----END PGP SIGNATURE-----

--7lb2z4g7eugkw5ds--
