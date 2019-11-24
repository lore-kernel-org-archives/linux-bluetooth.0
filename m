Return-Path: <SRS0=IqEA=ZQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E03C432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 11:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198A32075E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 11:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5uNDyo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKXLNS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Nov 2019 06:13:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51612 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfKXLNS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Nov 2019 06:13:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so11923537wme.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2019 03:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6sx//xYqOxQnnuAbsu4jTT4yLuEaGMRUHBwBPKSBPo=;
        b=F5uNDyo33CUOjw1CTAiUFD8/7+v5erhtApaxXCLFmeOt8YgC3ISt3DXxBLDBG05GVJ
         QEA34QtjJfl6B3QI5WLtuSmrAyWFie0Pj1KSFxHwVtq+X7pClIdaHQnBUKpHyK/PCYpM
         0JuCCqAstNdBdraKW6D8x9b7d1k2wVIGTgSy9ORRPw1UWzn3vQ91A40WITso+U3rqh6y
         xnt020oOGhsL3wo16uOkx1sKc+ML+gx1OW3J0vAD6NhY4Yqlnw/Wew8W5aKKp4CIPsku
         aeMQROi8GBwHxPCsf8APfo8aOuaODHoElooC/pTnWP6XQoVYyxUUoIT4B64vwSz7NHGi
         W7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6sx//xYqOxQnnuAbsu4jTT4yLuEaGMRUHBwBPKSBPo=;
        b=H7rkzAs/pJ2OgEEWq7GmaL97qDY0vQ6nnX+dH3qxjqdgRBBtgpOlSldgRg02UcHcRO
         k5vePfxePxFkPsp5OXUEzI5+TqBpFGUX4XHdWXbXWFxBeGIJC4GgeEFXZHz+bS5d9K26
         1nSRqjQtHVwODu27rtMrmIlyRK5Du9fK0oR3dY4dOuEVFWKOCN57jZ8yqoP0M4CYKn9D
         NX+gJEXE3k7IGtSWAXQHo69ZdaQf0Cc/09sW7aS2oaJUvxuthIbI9cWzIlwzPi6drstD
         Fjupn5DEKmNk3ij67hz7uiWfbcMNs5JaHuHrBD0cNzW5d8L1Gac3CO4polpeJlF6VuqU
         4PMg==
X-Gm-Message-State: APjAAAUO6ljypNfHJGvRMvrC2xrEPy48BJ8OajHyfGs9YwHZmo2nQOyP
        b60q38GDL6sJ3zf3H/wYduY=
X-Google-Smtp-Source: APXvYqyss45ShsYHM5GaK1jnKH+vBtwV8/Aa1gsljgNc3Qv2PMkZaTgeELj7a8EVx4ip5PSPZPN9tA==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr25919693wmc.113.1574593995252;
        Sun, 24 Nov 2019 03:13:15 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x6sm5904558wrw.34.2019.11.24.03.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Nov 2019 03:13:14 -0800 (PST)
Date:   Sun, 24 Nov 2019 12:13:13 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: HCI Set custom bandwidth for AuriStream SCO codec
Message-ID: <20191124111313.gaqjyxmmxigmwmpr@pali>
References: <20190708210616.x2dlnzjhnplu37bz@pali>
 <D0A44CC7-CABC-408A-894E-AAD700FA9B0D@holtmann.org>
 <20190718100939.bwl26qcfxe6ppcto@pali>
 <20191027220945.wmb3g55wtrmqbnmz@pali>
 <1CFFA8EF-1B2A-466E-8901-BFB849F20442@holtmann.org>
 <20191119171342.mwfzszu7xwabi7to@pali>
 <392B6AA9-7512-472A-8F22-D86F2A7F1EDC@holtmann.org>
 <20191120074411.xtyw34kb3gc73zvk@pali>
 <20191121224455.orhslaa6zdmlwe43@pali>
 <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="phi6swe5cjv2unup"
Content-Disposition: inline
In-Reply-To: <390FC814-FBC2-4225-82C2-0CB866F01471@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--phi6swe5cjv2unup
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 24 November 2019 12:04:39 Marcel Holtmann wrote:
> Hi Pali,
>=20
> > I played more with C99 flexible arrays and seems that gcc supports it
> > without any problems. I'm sending another attempt of API implementation,
> > now with more fields which are needed for Enhanced Setup Synchronous
> > Connection command. This command is not supported by kernel yet, but
> > should be easy to add it. So my ioctl API is prepared for it. Enhanced
> > Setup Synchronous Connection command would be needed to use hardware
> > mSBC codec encoder/decoder.
> >=20
> > --=20
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index fabee6db0abb..29590c6749d5 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -116,12 +116,49 @@ struct bt_voice {
> > 	__u16 setting;
> > };
> >=20
> > -#define BT_VOICE_TRANSPARENT			0x0003
> > -#define BT_VOICE_CVSD_16BIT			0x0060
> > -
> > #define BT_SNDMTU		12
> > #define BT_RCVMTU		13
> >=20
> > +#define BT_VOICE_SETUP		14
> > +#define BT_VOICE_PKT_TYPE_CAP_SCO	BIT(0)
> > +#define BT_VOICE_PKT_TYPE_CAP_ESCO	BIT(1)
> > +struct bt_voice_pkt_type {
> > +	__u8 capability; /* bitmask of BT_VOICE_PKT_TYPE_CAP_* */
> > +	__u8 retrans_effort;
> > +	__u16 pkt_type;
> > +	__u16 max_latency;
> > +};
> > +#define BT_VOICE_SETUP_FEATURE_CONFIG		BIT(0) /* Additional configurat=
ion fields after voice_settings are set (including other features) */
> > +#define BT_VOICE_SETUP_FEATURE_ADD_SCO		BIT(1) /* Can use Add Synchron=
ous Connection */
> > +#define BT_VOICE_SETUP_FEATURE_SETUP_SCO	BIT(2) /* Can use Setup Synch=
ronous Connection */
> > +#define BT_VOICE_SETUP_FEATURE_ENH_SETUP_SCO	BIT(3) /* Can use Enhance=
d Setup Synchronous Connection */
> > +struct bt_voice_setup {
> > +	__u16 voice_setting;
> > +	__u8 features; /* bitmask of BT_VOICE_SETUP_FEATURE_* */
> > +	__u8 pkt_types_count;
> > +	__u32 tx_bandwidth;
> > +	__u32 rx_bandwidth;
> > +	__u32 input_bandwidth;
> > +	__u32 output_bandwidth;
> > +	__u8 tx_coding_format[5];
> > +	__u8 rx_coding_format[5];
> > +	__u8 input_coding_format[5];
> > +	__u8 output_coding_format[5];
> > +	__u16 tx_codec_frame_size;
> > +	__u16 rx_codec_frame_size;
> > +	__u16 input_coded_data_size;
> > +	__u16 output_coded_data_size;
> > +	__u8 input_pcm_data_format;
> > +	__u8 output_pcm_data_format;
> > +	__u8 input_pcm_msb_position;
> > +	__u8 output_pcm_msb_position;
> > +	__u8 input_data_path;
> > +	__u8 output_data_path;
> > +	__u8 input_unit_size;
> > +	__u8 output_unit_size;
> > +	struct bt_voice_pkt_type pkt_types[];
> > +};
> > +
>=20
> lets not mush these together. One of these are air codecs and setup defin=
ed by a profile, the other are local codec path defined by the platform.

You are right that air codecs are defined by profile and local codecs by
platform / bluetooth adapter. But ...

> You will also not have multiple local codec path. That will be one and th=
ey will not be negotiated. The eSCO settings however will be negotiated.

Above structure specify exactly one codec setup and then multiple packet
types. See that flexible array is only for packet types, not for whole
codec structure.

And all above parameters are required for Enhanced Setup Synchronous
Connection command. So kernel needs to know what should put into
Enhanced Setup Synchronous Connection command when creating a new SCO
connection. So for supporting Enhanced Setup Synchronous Connection
command userspace needs to pass all above parameters to kernel.

And usage of Enhanced Setup Synchronous Connection is required when we
want to use in-hardware encoding/decoding of mSBC codec. E.g. new
Thinkpads already have bluetooth adapter which supports encoding and
decoding of mSBC codec in hardware.

So above structure as I define is really needed. Do you see it now?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--phi6swe5cjv2unup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdplxwAKCRCL8Mk9A+RD
UoZKAJ4gv/a8RyNGoM64MsMY2GFJn0y8yQCfQP6if58n0d3S38iwFqOc6r+B5co=
=Dvtu
-----END PGP SIGNATURE-----

--phi6swe5cjv2unup--
