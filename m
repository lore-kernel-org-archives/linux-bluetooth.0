Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CDF350D53
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607942; cv=pass; b=YH43Yv1bVdnVBYyNitUJr2DpnPIGCqti1bCE/0QfR2VNLwZydC5FSbP31vb20SBuB77JnqrT2ZQsZt4X7Zz6ECApeI2VYNJXbzCmZMnycE+VkAX1v2vKkjznj8hBpU3f3zmocw8ayyfJkS3oOhaC4iDtWy5DNSkyHiNe6hRRvxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607942; c=relaxed/simple;
	bh=rQO83v4pXk5S1QT1cGYkJRpy/Yhwyr+O3RoVJ9YeNPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6b/RtQprg8j6soq9Ki3MRiO+LI0ot7jomutBqjsyYzSckjKZSGGsnmezBlSL4qCOTyiXwe1DPPFedxMegRDfShzgMzXCarFmkDj7IbUuJ2Sc0wBYErvD3b9gNmR8IVyXKPbcXpuJbN9KTenoWAPE/apUARJRWQR1sb2rIFAQjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=juvH73vI; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="juvH73vI"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cN2wQ01Gzz49Q1Z;
	Thu, 11 Sep 2025 19:25:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1757607926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R+FHNVf7CK/b0P3Q3ka+JLZlyS5DVnPOrflYa5pZvrE=;
	b=juvH73vIZkk4lvOIIWJz76dJYhXD1ivFjY4JO3baMBKpuHZKMPAEIUHOBEsGaW7vgaX2ID
	ZAmBT9DCP/TmTjagz/lvSEe9ns0njORHbuIcQTZzw60TByy4wG167i7USUkM/8y8BVFCoD
	7xuZBELW9gYMjpaw8+7/35ggr+vuQmo1GALYtgIW7KUMwgiZXYQ8RU6XWy5jyiqiis7zcc
	7RAsgU5rsnkvNZLLUqb1orhXyVLZbbpbXVXDpZTczDiVf+0ugaVwfUyczc4tMkzZUlHiGG
	hl3c6q3gqUVE7Lta7DzaGyAQx2xFUk6wlYqOrpG5fcu/e37JjVRCAL/ANtSl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1757607926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R+FHNVf7CK/b0P3Q3ka+JLZlyS5DVnPOrflYa5pZvrE=;
	b=WoCcU/AjCW6foyNXY8J1RgyhBM/fEhREYkRbSymP0FrKI8U4PHmzsmxjXSuKo4amYESjhA
	qI4JzFLnKCvWdInCAN1rwMw9uhCuhWbTr/N2YaBxwbCKBKjvkvTrRRB8K4a0lfPGhRz/iI
	4TlOuOboNNcHg4e7WptipXf8TJc3ZfiV+KqNkqTY6NUnTvvJqU9gIT4FfIC12uv0Sxnm9N
	WcQUBKgnwE9QE7YJYwbjvqxx9cIs4D8ZMjk7iDxrviOHPdOGaw+jYKLLk4jiNYRTI01AMH
	XhOZYBLwR2Nh6VcUV1KH1y/XQ6/WdkLcURh1PjhM1G3Hh5nsfUfVBGeJcXsoWg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1757607926; a=rsa-sha256;
	cv=none;
	b=G9p4bZTcM5Wq501y0wZcQ31sk4lCh2eGlDfIoz+qtL936u9VUbbLJubRGE3YOVkMzSqLj1
	ql5QSKDDivL8mmuXp1GGcbpicKVVARQQ4q2uYlhQEIDQTAuSuRUtkO/jrbNWFWX1ivFnmN
	Bt3Bon3hRzUsdW5yYO70LUvowbd5ruw5LYFG11HMy2gbucg7lXkRSs3cZJNADrjGTsc1aL
	HfaZE4S2yaQfKbXChh3aMipmZRK/zxWxNybCU5ddTPUPu33kIiMHg3HrRsKHkNPQL3Ilcj
	ukwfMR01FmVSGIDjM1FH5WscXPy95UxvLuVTQAD7chjIOAUE74VY1ruw2vt7LQ==
Message-ID: <bc0748e8f5b76ad8234bd301be1735f4187a89af.camel@iki.fi>
Subject: Re: [PATCH BlueZ] audio: Add support for specific error codes for
 A2DP configuration
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Per
 =?ISO-8859-1?Q?Waag=F8?=
	 <pwaago@cisco.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 11 Sep 2025 19:25:24 +0300
In-Reply-To: <CABBYNZLBJ_Q6S+OGam-Q92Agbe0HK5dX4WxFrFpnntcDhu1gow@mail.gmail.com>
References: <20250911135301.1538126-1-pwaago@cisco.com>
	 <CABBYNZLBJ_Q6S+OGam-Q92Agbe0HK5dX4WxFrFpnntcDhu1gow@mail.gmail.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=mQINBGX+qmEBEACt7O4iYRbX80B2OV+LbX06Mj1Wd67SVWwq2sAlI+6fK1YWbFu5jOWFy
 ShFCRGmwyzNvkVpK7cu/XOOhwt2URcy6DY3zhmd5gChz/t/NDHGBTezCh8rSO9DsIl1w9nNEbghUl
 cYmEvIhQjHH3vv2HCOKxSZES/6NXkskByXtkPVP8prHPNl1FHIO0JVVL7/psmWFP/eeB66eAcwIgd
 aUeWsA9+/AwcjqJV2pa1kblWjfZZw4TxrBgCB72dC7FAYs94ebUmNg3dyv8PQq63EnC8TAUTyph+M
 cnQiCPz6chp7XHVQdeaxSfcCEsOJaHlS+CtdUHiGYxN4mewPm5JwM1C7PW6QBPIpx6XFvtvMfG+Ny
 +AZ/jZtXxHmrGEJ5sz5YfqucDV8bMcNgnbFzFWxvVklafpP80O/4VkEZ8Og09kvDBdB6MAhr71b3O
 n+dE0S83rEiJs4v64/CG8FQ8B9K2p9HE55Iu3AyovR6jKajAi/iMKR/x4KoSq9Jgj9ZI3g86voWxM
 4735WC8h7vnhFSA8qKRhsbvlNlMplPjq0f9kVLg9cyNzRQBVrNcH6zGMhkMqbSvCTR5I1kY4SfU4f
 QqRF1Ai5f9Q9D8ExKb6fy7ct8aDUZ69Ms9N+XmqEL8C3+AAYod1XaXk9/hdTQ1Dhb51VPXAMWTICB
 dXi5z7be6KALQARAQABtCZQYXVsaSBWaXJ0YW5lbiA8cGF1bGkudmlydGFuZW5AaWtpLmZpPokCWg
 QTAQgARAIbAwUJEswDAAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBGrOSfUCZNEJOswAnOS
 aCbhLOrBPBQJl/qsDAhkBAAoJEOSaCbhLOrBPB/oP/1j6A7hlzheRhqcj+6sk+OgZZ+5eX7mBomyr
 76G+m/3RhPGlKbDxKTWtBZaIDKg2c0Q6yC1TegtxQ2EUD4kk7wKoHKj8dKbR29uS3OvURQR1guCo2
 /5kzQQVxQwhIoMdHJYF0aYNQgdA+ZJL09lDz+JC89xvup3spxbKYc9Iq6vxVLbVbjF9Uv/ncAC4Bs
 g1MQoMowhKsxwN5VlUdjqPZ6uGebZyC+gX6YWUHpPWcHQ1TxCD8TtqTbFU3Ltd3AYl7d8ygMNBEe3
 T7DV2GjBI06Xqdhydhz2G5bWPM0JSodNDE/m6MrmoKSEG0xTNkH2w3TWWD4o1snte9406az0YOwkk
 xDq9LxEVoeg6POceQG9UdcsKiiAJQXu/I0iUprkybRUkUj+3oTJQECcdfL1QtkuJBh+IParSF14/j
 Xojwnf7tE5rm7QvMWWSiSRewro1vaXjgGyhKNyJ+HCCgp5mw+ch7KaDHtg0fG48yJgKNpjkzGWfLQ
 BNXqtd8VYn1mCM3YM7qdtf9bsgjQqpvFiAh7jYGrhYr7geRjary1hTc8WwrxAxaxGvo4xZ1XYps3u
 ayy5dGHdiddk5KJ4iMTLSLH3Rucl19966COQeCwDvFMjkNZx5ExHshWCV5W7+xX/2nIkKUfwXRKfK
 dsVTL03FG0YvY/8A98EMbvlf4TnpyyaytBtQYXVsaSBWaXJ0YW5lbiA8cGF2QGlraS5maT6JAlcEE
 wEIAEEWIQRqzkn1AmTRCTrMAJzkmgm4SzqwTwUCZf6qYQIbAwUJEswDAAULCQgHAgIiAgYVCgkICw
 IEFgIDAQIeBwIXgAAKCRDkmgm4SzqwTxYZD/9hfC+CaihOESMcTKHoK9JLkO34YC0t8u3JAyetIz3
 Z9ek42FU8fpf58vbpKUIR6POdiANmKLjeBlT0D3mHW2ta90O1s711NlA1yaaoUw7s4RJb09W2Votb
 G02pDu2qhupD1GNpufArm3mOcYDJt0Rhh9DkTR2WQ9SzfnfzapjxmRQtMzkrH0GWX5OPv368IzfbJ
 S1fw79TXmRx/DqyHg+7/bvqeA3ZFCnuC/HQST72ncuQA9wFbrg3ZVOPAjqrjesEOFFL4RSaT0JasS
 XdcxCbAu9WNrHbtRZu2jo7n4UkQ7F133zKH4B0SD5IclLgK6Zc92gnHylGEPtOFpij/zCRdZw20VH
 xrPO4eI5Za4iRpnKhCbL85zHE0f8pDaBLD9L56UuTVdRvB6cKncL4T6JmTR6wbH+J+s4L3OLjsyx2
 LfEcVEh+xFsW87YQgVY7Mm1q+O94P2soUqjU3KslSxgbX5BghY2yDcDMNlfnZ3SdeRNbssgT28PAk
 5q9AmX/5YyNbexOCyYKZ9TLcAJJ1QLrHGoZaAIaR72K/kmVxy0oqdtAkvCQw4j2DCQDR0lQXsH2bl
 WTSfNIdSZd4pMxXHFF5iQbh+uReDc8rISNOFMAZcIMd+9jRNCbyGcoFiLa52yNGOLo7Im+CIlmZEt
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

to, 2025-09-11 kello 10:43 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Per,
>=20
> On Thu, Sep 11, 2025 at 9:56=E2=80=AFAM Per Waag=C3=B8 <pwaago@cisco.com>=
 wrote:
> >=20
> > The A2DP specification defines error codes that shall be used if
> > the codec capabilities contain improper settings. This change allows
> > clients to trigger the sending of these specific error codes by
> > returning the corresponding error messages from
> > MediaEndpoint1.SetConfiguration.
> >=20
> > This update is fully backwards compatible: clients passing other error
> > messages will continue to receive the default error code as before. On
> > older BlueZ versions, these new errors will also result in the default
> > error code, enabling clients to implement support for the new errors
> > without breaking compatibility.
>=20
> While I can see the value for debugging I doubt we could do any
> handling of these errors, so the result would be the same regardless
> of what error is sent back it is not recoverable.
>=20
> @Pauli Virtanen Perhaps you can give some feedback regarding these
> codes, would pipewire be interested in generating specific error
> codes? Some of them seems to be SBC specific like bitpool.

Pipewire can start generating specific error codes if required by
specification / PTS, but I think there's probably not much real use for
these codes otherwise since it should be clear from capability bitmasks
what the cause for error is.

> > This change enables passing A2DP/SNK/AVP/* and A2DP/SRC/AVP/*
> > qualification tests.
> > ---
> >  doc/org.bluez.MediaEndpoint.rst | 37 ++++++++++++++++
> >  profiles/audio/a2dp.c           | 78 ++++++++++++++++++++++++++++++---
> >  profiles/audio/a2dp.h           |  5 ++-
> >  profiles/audio/avdtp.c          |  4 +-
> >  profiles/audio/media.c          | 20 +++++----
> >  src/error.h                     | 38 ++++++++++++++++
> >  6 files changed, 165 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpo=
int.rst
> > index 474cc1160..2721d473e 100644
> > --- a/doc/org.bluez.MediaEndpoint.rst
> > +++ b/doc/org.bluez.MediaEndpoint.rst
> > @@ -54,6 +54,43 @@ be configured and the properties must contain the fo=
llowing properties:
> >=20
> >         See **org.bluez.MediaTransport(5)** QoS property.
> >=20
> > +       Possible errors:
> > +               :org.bluez.Error.A2DP.InvalidCodecType:
> > +               :org.bluez.Error.A2DP.NotSupportedCodecType:
> > +               :org.bluez.Error.A2DP.InvalidSamplingFrequency:
> > +               :org.bluez.Error.A2DP.NotSupportedSamplingFrequency:
> > +               :org.bluez.Error.A2DP.InvalidChannelMode:
> > +               :org.bluez.Error.A2DP.NotSupportedChannelMode:
> > +               :org.bluez.Error.A2DP.InvalidSubbands:
> > +               :org.bluez.Error.A2DP.NotSupportedSubbands:
> > +               :org.bluez.Error.A2DP.InvalidAllocationMethod:
> > +               :org.bluez.Error.A2DP.NotSupportedAllocationMethod:
> > +               :org.bluez.Error.A2DP.InvalidMinimumBitpoolValue:
> > +               :org.bluez.Error.A2DP.NotSupportedMinimumBitpoolValue:
> > +               :org.bluez.Error.A2DP.InvalidMaximumBitpoolValue:
> > +               :org.bluez.Error.A2DP.NotSupportedMaximumBitpoolValue:
> > +               :org.bluez.Error.A2DP.InvalidInvalidLayer:
> > +               :org.bluez.Error.A2DP.NotSupportedLayer:
> > +               :org.bluez.Error.A2DP.NotSupporterdCRC:
> > +               :org.bluez.Error.A2DP.NotSupporterdMPF:
> > +               :org.bluez.Error.A2DP.NotSupporterdVBR:
> > +               :org.bluez.Error.A2DP.InvalidBitRate:
> > +               :org.bluez.Error.A2DP.NotSupportedBitRate:
> > +               :org.bluez.Error.A2DP.InvalidObjectType:
> > +               :org.bluez.Error.A2DP.NotSupportedObjectType:
> > +               :org.bluez.Error.A2DP.InvalidChannels:
> > +               :org.bluez.Error.A2DP.NotSupportedChannels:
> > +               :org.bluez.Error.A2DP.InvalidVersion:
> > +               :org.bluez.Error.A2DP.NotSupportedVersion:
> > +               :org.bluez.Error.A2DP.NotSupportedMaximumSUL:
> > +               :org.bluez.Error.A2DP.InvalidBlockLength:
> > +               :org.bluez.Error.A2DP.InvalidCPType:
> > +               :org.bluez.Error.A2DP.InvalidCPFormat:
> > +               :org.bluez.Error.A2DP.InvalidCodecParameter:
> > +               :org.bluez.Error.A2DP.NotSupportedCodecParameter:
> > +               :org.bluez.Error.A2DP.InvalidDRC:
> > +               :org.bluez.Error.A2DP.NotSupportedDRC:
>=20
> Introducing a error domain for A2DP is probably a good idea, but this
> only applies to endpoints that are A2DP specific, so this need to be
> adjusted to e.g.: possible for A2DP or something like that, also I
> don't know how the client would be able to tell it can return these
> errors? Or the expectation is that the client can start sending them
> immediately since the old behavior will convert them to
> AVDTP_UNSUPPORTED_CONFIGURATION anyway?
>=20
> While at it split the commit to have the documentation changes as a
> separate change.
>=20
> >  array{byte} SelectConfiguration(array{byte} capabilities)
> >  `````````````````````````````````````````````````````````
> >=20
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index c0a53eae9..661843a89 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -157,6 +157,73 @@ static GSList *servers =3D NULL;
> >  static GSList *setups =3D NULL;
> >  static unsigned int cb_id =3D 0;
> >=20
> > +struct a2dp_error {
> > +       const char *error_name;
> > +       uint8_t error_code;
> > +};
> > +
> > +#define A2DP_ERROR_PREFIX ERROR_INTERFACE ".A2DP."
> > +
> > +static struct a2dp_error config_errors[] =3D {
> > +       {"InvalidCodecType", A2DP_INVALID_CODEC_TYPE},
> > +       {"NotSupportedCodecType", A2DP_NOT_SUPPORTED_CODEC_TYPE},
> > +       {"InvalidSamplingFrequency", A2DP_INVALID_SAMPLING_FREQUENCY},
> > +       {"NotSupportedSamplingFrequency",
> > +                               A2DP_NOT_SUPPORTED_SAMPLING_FREQUENCY},
> > +       {"InvalidChannelMode", A2DP_INVALID_CHANNEL_MODE},
> > +       {"NotSupportedChannelMode", A2DP_NOT_SUPPORTED_CHANNEL_MODE},
> > +       {"InvalidSubbands", A2DP_INVALID_SUBBANDS},
> > +       {"NotSupportedSubbands", A2DP_NOT_SUPPORTED_SUBBANDS},
> > +       {"InvalidAllocationMethod", A2DP_INVALID_ALLOCATION_METHOD},
> > +       {"NotSupportedAllocationMethod", A2DP_NOT_SUPPORTED_ALLOCATION_=
METHOD},
> > +       {"InvalidMinimumBitpoolValue",
> > +                               A2DP_INVALID_MINIMUM_BITPOOL_VALUE},
> > +       {"NotSupportedMinimumBitpoolValue",
> > +                               A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VALU=
E},
> > +       {"InvalidMaximumBitpoolValue", A2DP_INVALID_MAXIMUM_BITPOOL_VAL=
UE},
> > +       {"NotSupportedMaximumBitpoolValue",
> > +                               A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALU=
E},
> > +       {"InvalidInvalidLayer", A2DP_INVALID_INVALID_LAYER},
> > +       {"NotSupportedLayer", A2DP_NOT_SUPPORTED_LAYER},
> > +       {"NotSupporterdCRC", A2DP_NOT_SUPPORTERD_CRC},
> > +       {"NotSupporterdMPF", A2DP_NOT_SUPPORTERD_MPF},
> > +       {"NotSupporterdVBR", A2DP_NOT_SUPPORTERD_VBR},
> > +       {"InvalidBitRate", A2DP_INVALID_BIT_RATE},
> > +       {"NotSupportedBitRate", A2DP_NOT_SUPPORTED_BIT_RATE},
> > +       {"InvalidObjectType", A2DP_INVALID_OBJECT_TYPE},
> > +       {"NotSupportedObjectType", A2DP_NOT_SUPPORTED_OBJECT_TYPE},
> > +       {"InvalidChannels", A2DP_INVALID_CHANNELS},
> > +       {"NotSupportedChannels", A2DP_NOT_SUPPORTED_CHANNELS},
> > +       {"InvalidVersion", A2DP_INVALID_VERSION},
> > +       {"NotSupportedVersion", A2DP_NOT_SUPPORTED_VERSION},
> > +       {"NotSupportedMaximumSUL", A2DP_NOT_SUPPORTED_MAXIMUM_SUL},
> > +       {"InvalidBlockLength", A2DP_INVALID_BLOCK_LENGTH},
> > +       {"InvalidCPType", A2DP_INVALID_CP_TYPE},
> > +       {"InvalidCPFormat", A2DP_INVALID_CP_FORMAT},
> > +       {"InvalidCodecParameter", A2DP_INVALID_CODEC_PARAMETER},
> > +       {"NotSupportedCodecParameter", A2DP_NOT_SUPPORTED_CODEC_PARAMET=
ER},
> > +       {"InvalidDRC", A2DP_INVALID_DRC},
> > +       {"NotSupportedDRC", A2DP_NOT_SUPPORTED_DRC}
> > +};
> > +
> > +uint8_t a2dp_parse_config_error(const char *error_name)
> > +{
> > +       size_t prefix_length;
> > +       size_t i;
> > +
> > +       prefix_length =3D strlen(A2DP_ERROR_PREFIX);
> > +       if (strncmp(A2DP_ERROR_PREFIX, error_name, prefix_length))
> > +               return AVDTP_UNSUPPORTED_CONFIGURATION;
> > +
> > +       error_name +=3D prefix_length;
> > +       for (i =3D 0; i < ARRAY_SIZE(config_errors); i++) {
> > +               if (strcmp(config_errors[i].error_name, error_name) =3D=
=3D 0)
> > +                       return config_errors[i].error_code;
> > +       }
> > +
> > +       return AVDTP_UNSUPPORTED_CONFIGURATION;
> > +}
> > +
> >  static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
> >  {
> >         setup->ref++;
> > @@ -688,11 +755,10 @@ done:
> >         return FALSE;
> >  }
> >=20
> > -static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret=
)
> > +static void endpoint_setconf_cb(struct a2dp_setup *setup, uint8_t erro=
r_code)
> >  {
> > -       if (ret =3D=3D FALSE)
> > -               setup_error_init(setup, AVDTP_MEDIA_CODEC,
> > -                                       AVDTP_UNSUPPORTED_CONFIGURATION=
);
> > +       if (error_code !=3D 0)
> > +               setup_error_init(setup, AVDTP_MEDIA_CODEC, error_code);
> >=20
> >         auto_config(setup);
> >         setup_unref(setup);
> > @@ -865,11 +931,11 @@ static gboolean endpoint_getcap_ind(struct avdtp =
*session,
> >         return TRUE;
> >  }
> >=20
> > -static void endpoint_open_cb(struct a2dp_setup *setup, gboolean ret)
> > +static void endpoint_open_cb(struct a2dp_setup *setup, uint8_t error_c=
ode)
> >  {
> >         int err =3D error_to_errno(setup->err);
> >=20
> > -       if (ret =3D=3D FALSE) {
> > +       if (error_code !=3D 0) {
> >                 setup->stream =3D NULL;
> >                 finalize_setup_errno(setup, -EPERM, finalize_config, NU=
LL);
> >                 goto done;
> > diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
> > index c698bc983..afa02c12d 100644
> > --- a/profiles/audio/a2dp.h
> > +++ b/profiles/audio/a2dp.h
> > @@ -15,7 +15,8 @@ struct a2dp_setup;
> >=20
> >  typedef void (*a2dp_endpoint_select_t) (struct a2dp_setup *setup, void=
 *ret,
> >                                         int size);
> > -typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup, gboo=
lean ret);
> > +typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup,
> > +                                       uint8_t error_code);
> >=20
> >  struct a2dp_endpoint {
> >         const char *(*get_name) (struct a2dp_sep *sep, void *user_data)=
;
> > @@ -70,6 +71,8 @@ unsigned int a2dp_select_capabilities(struct avdtp *s=
ession,
> >  unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
> >                                 a2dp_config_cb_t cb, GSList *caps,
> >                                 void *user_data);
> > +uint8_t a2dp_parse_config_error(const char *error_name);
> > +
> >  unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
> >                                 a2dp_stream_cb_t cb, void *user_data);
> >  unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
> > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > index 30648251f..ed4e22b26 100644
> > --- a/profiles/audio/avdtp.c
> > +++ b/profiles/audio/avdtp.c
> > @@ -1494,8 +1494,8 @@ static void setconf_cb(struct avdtp *session, str=
uct avdtp_stream *stream,
> >         struct conf_rej rej;
> >=20
> >         if (err !=3D NULL) {
> > -               rej.error =3D AVDTP_UNSUPPORTED_CONFIGURATION;
> > -               rej.category =3D err->err.error_code;
> > +               rej.error =3D err->err.error_code;
> > +               rej.category =3D AVDTP_UNSUPPORTED_CONFIGURATION;
> >                 avdtp_send(session, session->in_cmd.transaction,
> >                            AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATI=
ON,
> >                            &rej, sizeof(rej));
> > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > index 9b3042c18..332f643bb 100644
> > --- a/profiles/audio/media.c
> > +++ b/profiles/audio/media.c
> > @@ -333,7 +333,7 @@ static void endpoint_reply(DBusPendingCall *call, v=
oid *user_data)
> >         DBusMessage *reply;
> >         DBusMessageIter args, props;
> >         DBusError err;
> > -       gboolean value;
> > +       uint8_t error_code;
> >         void *ret =3D NULL;
> >         int size =3D -1;
> >=20
> > @@ -356,8 +356,12 @@ static void endpoint_reply(DBusPendingCall *call, =
void *user_data)
> >=20
> >                 if (dbus_message_is_method_call(request->msg,
> >                                         MEDIA_ENDPOINT_INTERFACE,
> > -                                       "SetConfiguration"))
> > +                                       "SetConfiguration")) {
> >                         endpoint_remove_transport(endpoint, request->tr=
ansport);
> > +                       error_code =3D a2dp_parse_config_error(err.name=
);
> > +                       ret =3D &error_code;
> > +                       size =3D 1;
> > +               }
> >=20
> >                 dbus_error_free(&err);
> >                 goto done;
> > @@ -390,8 +394,8 @@ static void endpoint_reply(DBusPendingCall *call, v=
oid *user_data)
> >         }
> >=20
> >         size =3D 1;
> > -       value =3D TRUE;
> > -       ret =3D &value;
> > +       error_code =3D 0;
> > +       ret =3D &error_code;
> >=20
> >  done:
> >         dbus_message_unref(reply);
> > @@ -634,9 +638,9 @@ static void config_cb(struct media_endpoint *endpoi=
nt, void *ret, int size,
> >                                                         void *user_data=
)
> >  {
> >         struct a2dp_config_data *data =3D user_data;
> > -       gboolean *ret_value =3D ret;
> > +       uint8_t *ret_value =3D ret;
> >=20
> > -       data->cb(data->setup, ret_value ? *ret_value : FALSE);
> > +       data->cb(data->setup, ret_value ? *ret_value : 1);
> >  }
> >=20
> >  static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
> > @@ -1098,7 +1102,7 @@ static void pac_config_cb(struct media_endpoint *=
endpoint, void *ret, int size,
> >                                                         void *user_data=
)
> >  {
> >         struct pac_config_data *data =3D user_data;
> > -       gboolean *ret_value =3D ret;
> > +       uint8_t *error_code =3D ret;
> >         struct media_transport *transport;
> >=20
> >         /* If transport was cleared, configuration was cancelled */
> > @@ -1106,7 +1110,7 @@ static void pac_config_cb(struct media_endpoint *=
endpoint, void *ret, int size,
> >         if (!transport)
> >                 return;
> >=20
> > -       data->cb(data->stream, ret_value ? 0 : -EINVAL);
> > +       data->cb(data->stream, error_code =3D=3D 0 ? 0 : -EINVAL);
> >  }
> >=20
> >  static struct media_transport *pac_ucast_config(struct bt_bap_stream *=
stream,
> > diff --git a/src/error.h b/src/error.h
> > index 47602d39b..8157795c2 100644
> > --- a/src/error.h
> > +++ b/src/error.h
> > @@ -88,3 +88,41 @@ DBusMessage *btd_error_profile_unavailable(DBusMessa=
ge *msg);
> >  DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
> >  DBusMessage *btd_error_bredr_errno(DBusMessage *msg, int err);
> >  DBusMessage *btd_error_le_errno(DBusMessage *msg, int err);
> > +
> > +enum a2dp_error_codes : uint8_t {
> > +       A2DP_INVALID_CODEC_TYPE =3D 0xc1,
> > +       A2DP_NOT_SUPPORTED_CODEC_TYPE =3D 0xc2,
> > +       A2DP_INVALID_SAMPLING_FREQUENCY =3D 0xc3,
> > +       A2DP_NOT_SUPPORTED_SAMPLING_FREQUENCY =3D 0xc4,
> > +       A2DP_INVALID_CHANNEL_MODE =3D 0xc5,
> > +       A2DP_NOT_SUPPORTED_CHANNEL_MODE =3D 0xc6,
> > +       A2DP_INVALID_SUBBANDS =3D 0xc7,
> > +       A2DP_NOT_SUPPORTED_SUBBANDS =3D 0xc8,
> > +       A2DP_INVALID_ALLOCATION_METHOD =3D 0xc9,
> > +       A2DP_NOT_SUPPORTED_ALLOCATION_METHOD =3D 0xca,
> > +       A2DP_INVALID_MINIMUM_BITPOOL_VALUE =3D 0xcb,
> > +       A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VALUE =3D 0xcc,
> > +       A2DP_INVALID_MAXIMUM_BITPOOL_VALUE =3D 0xcd,
> > +       A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALUE =3D 0xce,
> > +       A2DP_INVALID_INVALID_LAYER =3D 0xcf,
> > +       A2DP_NOT_SUPPORTED_LAYER =3D 0xd0,
> > +       A2DP_NOT_SUPPORTERD_CRC =3D 0xd1,
> > +       A2DP_NOT_SUPPORTERD_MPF =3D 0xd2,
> > +       A2DP_NOT_SUPPORTERD_VBR =3D 0xd3,
> > +       A2DP_INVALID_BIT_RATE =3D 0xd4,
> > +       A2DP_NOT_SUPPORTED_BIT_RATE =3D 0xd5,
> > +       A2DP_INVALID_OBJECT_TYPE =3D 0xd6,
> > +       A2DP_NOT_SUPPORTED_OBJECT_TYPE =3D 0xd7,
> > +       A2DP_INVALID_CHANNELS =3D 0xd8,
> > +       A2DP_NOT_SUPPORTED_CHANNELS =3D 0xd9,
> > +       A2DP_INVALID_VERSION =3D 0xda,
> > +       A2DP_NOT_SUPPORTED_VERSION =3D 0xdb,
> > +       A2DP_NOT_SUPPORTED_MAXIMUM_SUL =3D 0xdc,
> > +       A2DP_INVALID_BLOCK_LENGTH =3D 0xdd,
> > +       A2DP_INVALID_CP_TYPE =3D 0xe0,
> > +       A2DP_INVALID_CP_FORMAT =3D 0xe1,
> > +       A2DP_INVALID_CODEC_PARAMETER =3D 0xe2,
> > +       A2DP_NOT_SUPPORTED_CODEC_PARAMETER =3D 0xe3,
> > +       A2DP_INVALID_DRC =3D 0xe4,
> > +       A2DP_NOT_SUPPORTED_DRC =3D 0xe5,
> > +};
>=20
> Hmm, I guess there should be part of a2dp.h since this error header is
> about D-Bus not A2DP codes.
>=20
> > --
> > 2.43.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
