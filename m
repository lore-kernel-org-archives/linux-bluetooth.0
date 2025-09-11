Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A15238166
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605946; cv=none; b=BpsxtD8Kd+hcX8BdhVN4sH9gywYLk4HJxWJWLNn8FXrchhafGbRfxM6HZsXT88eWzCYva7uPxLchuzJwQqtPk+JfH3SFLJvGTEi5dLcUwUawAWlMPE7g9Y31z2fwX6dcVXJbrvJu1+OjJJ7tfCr5JdfsKLsOGNl+W4gRh1r5Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605946; c=relaxed/simple;
	bh=UzH0eYPwsUYlZSxY/65PT5ULT89b8WwXTmxY273tsJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qil+xH0hn9utaSykrtDR9YmjM/eSXYL2TBegve5qgvpgzJznjF0dpHljanSXjjxP5LyZWnUhF3fsOdadYYyzuzCTq0WaKdxMFuiid/lq8IZztzPYNUvHDeS+G9GUc83ZqnQ/7NsZwhx4Nf0Ac5GGjS8eQ/G3itbavRlqIa+gJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH0h3UwI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH0h3UwI"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336b88c5362so8489631fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757605942; x=1758210742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtdROpwVGdhPhIY3ZlJuc2l4ffeTLnne6/qeiEsU5Vo=;
        b=bH0h3UwIN6LDH6PmTYMYI0ZpCRnrpy812RQL3m6z/WSlY311dPLKdImlmIyRLri46k
         Ybz4U4UqINKGhfev1NQsuM5GRY1nL4cyTklNLElQP99OeTiJI4yghJ5G9B9pPvoZMGwS
         cSKIDrg0dhBfIVoU3tHMsEdY/j2UCjzoFNTZEvaVI43eTSHQ4Oso5imbrVunjOgpW7Sm
         sxyJ60HEc5NGUIATGTebB1oUPDAYKf1n4sMokBmrDA1HCvPJ36P6lUaiWW+iq//QfbZL
         HmC7zXxgoOv0al6Xx90yiHi2kGrg4T5LABOs7mUkILxtgi4In42NHm+AHIR//MPpiaKn
         98cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605942; x=1758210742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtdROpwVGdhPhIY3ZlJuc2l4ffeTLnne6/qeiEsU5Vo=;
        b=fxouHAocuC6OJTRJhHl8N+LYkdV9jvCFRiRPEApBu3NiKYytm6noCsFlo+gFj3a8H0
         ZO0Hb8E7I1xjB8wf4PPv1vUboGgnnAi0UPg1+tTljJFDABaHfbeYneGr2sNOR/bdo4rT
         KqxcQS3SfzlSSXlYifs7SWaGq8b4Qn5kSLSOZyNVS3Kqmb/whlIK4VlaKY06VKDwz27s
         sJ1dA4r27peHo4NJijAJUfv8KZyBdvRuW6/xwi0/OaL9e9SC4AQdv3p95qaxzqWtPr8F
         EDb7Q4Ngr9E4X8hXtWB2nmQyXDE70mv51sq9IJ/lMHoNb5D0AsVNNYpRr2peWB075UVI
         mf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0HJ/V/M12QWUX8YM5nlZBRrqGeNFJHJq6fshDbT1a89VQB6NVMrVrUUZN6BjoXiS9DSnj819jPxrzOZHA/UI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8t8sKw+IG8nihrd4OEbjnXBI2XJoZgNK9I3f35O9naIMMi0Qg
	Qgoe/ufe8X3TR73gIS9KoX77BF1scRHbCGoPu1hiHM0yQKmNR0rnk9gYwOW8bX/TEda4R+32US0
	vnmAts6bIhvG+Or17ijTOufgQO2C0WSo=
X-Gm-Gg: ASbGnctLltnKLiuvsdKlVf4hcl9/Zmod3BQbkcLXMtJclExUbL6QZpgylDCTZRzq4Lp
	GTE3Gb6y+jX5riiTxBnoYlZK9OJzXtk4nUVErgQt7sH2xqdnoHnmqHlFbIDEpmk9foF4aCSeOiw
	KnlPwyGwn1W0uxOZVpfjyY5D0tZsM+9ZIkzE+I7jCrm816q2zV7RXa3TKp5PjZdGTduaO/eqqNO
	KkkwGvPSqvRSGOk8SUtud6quwZ9/jkDMtOMLXVv7+UR0Q==
X-Google-Smtp-Source: AGHT+IGrN/8EMGOTxERB/bPazYY6mlndAYQhg99/jbJ5ZeybUgWCbwqkUcP8nib4/oXNcbf5J+ILw6Ls+TnN4AAdrak=
X-Received: by 2002:a2e:b8c1:0:b0:332:3fd0:15fb with SMTP id
 38308e7fff4ca-33b47e182fbmr53571971fa.0.1757605942018; Thu, 11 Sep 2025
 08:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911135301.1538126-1-pwaago@cisco.com> <CABBYNZLBJ_Q6S+OGam-Q92Agbe0HK5dX4WxFrFpnntcDhu1gow@mail.gmail.com>
 <PH0PR11MB5596318A1EFBC5DF72C41D5CCF09A@PH0PR11MB5596.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5596318A1EFBC5DF72C41D5CCF09A@PH0PR11MB5596.namprd11.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Sep 2025 11:52:09 -0400
X-Gm-Features: Ac12FXxjGOW2832pzr-ahvyuX9_nKNbF1uENCsGjYEUpwee7X75HpSF3Xm2HL2w
Message-ID: <CABBYNZ+==BYte8=C5jLwDrMs-GJkvOOxAXRMPO2Zv=2zxk8C2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio: Add support for specific error codes for
 A2DP configuration
To: "Per Waago (pwaago)" <pwaago@cisco.com>
Cc: Pauli Virtanen <pav@iki.fi>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Per,

On Thu, Sep 11, 2025 at 11:12=E2=80=AFAM Per Waago (pwaago) <pwaago@cisco.c=
om> wrote:
>
> Hi Luiz, thanks for reviewing.
>
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Thursday, September 11, 2025 16:43
> > To: Per Waago (pwaago); Pauli Virtanen
> > Cc: linux-bluetooth@vger.kernel.org
> > Subject: Re: [PATCH BlueZ] audio: Add support for specific error codes =
for A2DP configuration
> >
> > Hi Per,
> >
> > On Thu, Sep 11, 2025 at 9:56=E2=80=AFAM Per Waag=C3=B8 <pwaago@cisco.co=
m> wrote:
> > >
> > > The A2DP specification defines error codes that shall be used if
> > > the codec capabilities contain improper settings. This change allows
> > > clients to trigger the sending of these specific error codes by
> > > returning the corresponding error messages from
> > > MediaEndpoint1.SetConfiguration.
> > >
> > > This update is fully backwards compatible: clients passing other erro=
r
> > > messages will continue to receive the default error code as before. O=
n
> > > older BlueZ versions, these new errors will also result in the defaul=
t
> > > error code, enabling clients to implement support for the new errors
> > > without breaking compatibility.
> >
> > While I can see the value for debugging I doubt we could do any
> > handling of these errors, so the result would be the same regardless
> > of what error is sent back it is not recoverable.
> >
>
> The main motivation for adding them is to be able to pass the
> mandatory qualification tests, which now checks the errors codes
> returned from SetConfiguration in detail. I don't think they are very
> useful otherwise.
>
> The errors are specified in table 5.5 in the A2DP spec:
> https://www.bluetooth.com/specifications/specs/html/?src=3Da2dp_v1-4-1_17=
52513648/A2DP_v1.4.1/out/en/index-en.html#UUID-0ba19ee9-7277-1068-d2dc-b9e6=
38cca568_Table_5.5
>
> I included all of them for completeness. In that table, it is also stated
> which codecs they apply to. Some are SBC-specific, some apply to all code=
cs or
> other codecs.

Ok this is very annoying if PTS suddenly adds a new test case that
checks error codes that otherwise are only useful for debugging. I'd
say that it probably needs a configuration entry to skip these tests,
btw this seems to be introduced in 1.4.1:

https://www.bluetooth.com/specifications/specs/html/?src=3Da2dp_v1-4-1_1752=
513648/A2DP_v1.4.1/out/en/index-en.html#UUID-05a1c924-2070-eb38-c2cc-a9ffa1=
78bdb9

BlueZ SDP record is still 1.4 (a2dp_ver =3D 0x0104), it seems 1.4.1 is
an errata only change but that introduces new error codes which is
really intrusive to say the least.

> > @Pauli Virtanen Perhaps you can give some feedback regarding these
> > codes, would pipewire be interested in generating specific error
> > codes? Some of them seems to be SBC specific like bitpool.
> >
> > > This change enables passing A2DP/SNK/AVP/* and A2DP/SRC/AVP/*
> > > qualification tests.
> > > ---
> > >  doc/org.bluez.MediaEndpoint.rst | 37 ++++++++++++++++
> > >  profiles/audio/a2dp.c           | 78 ++++++++++++++++++++++++++++++-=
--
> > >  profiles/audio/a2dp.h           |  5 ++-
> > >  profiles/audio/avdtp.c          |  4 +-
> > >  profiles/audio/media.c          | 20 +++++----
> > >  src/error.h                     | 38 ++++++++++++++++
> > >  6 files changed, 165 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEnd=
point.rst
> > > index 474cc1160..2721d473e 100644
> > > --- a/doc/org.bluez.MediaEndpoint.rst
> > > +++ b/doc/org.bluez.MediaEndpoint.rst
> > > @@ -54,6 +54,43 @@ be configured and the properties must contain the =
following properties:
> > >
> > >         See **org.bluez.MediaTransport(5)** QoS property.
> > >
> > > +       Possible errors:
> > > +               :org.bluez.Error.A2DP.InvalidCodecType:
> > > +               :org.bluez.Error.A2DP.NotSupportedCodecType:
> > > +               :org.bluez.Error.A2DP.InvalidSamplingFrequency:
> > > +               :org.bluez.Error.A2DP.NotSupportedSamplingFrequency:
> > > +               :org.bluez.Error.A2DP.InvalidChannelMode:
> > > +               :org.bluez.Error.A2DP.NotSupportedChannelMode:
> > > +               :org.bluez.Error.A2DP.InvalidSubbands:
> > > +               :org.bluez.Error.A2DP.NotSupportedSubbands:
> > > +               :org.bluez.Error.A2DP.InvalidAllocationMethod:
> > > +               :org.bluez.Error.A2DP.NotSupportedAllocationMethod:
> > > +               :org.bluez.Error.A2DP.InvalidMinimumBitpoolValue:
> > > +               :org.bluez.Error.A2DP.NotSupportedMinimumBitpoolValue=
:
> > > +               :org.bluez.Error.A2DP.InvalidMaximumBitpoolValue:
> > > +               :org.bluez.Error.A2DP.NotSupportedMaximumBitpoolValue=
:
> > > +               :org.bluez.Error.A2DP.InvalidInvalidLayer:
> > > +               :org.bluez.Error.A2DP.NotSupportedLayer:
> > > +               :org.bluez.Error.A2DP.NotSupporterdCRC:
> > > +               :org.bluez.Error.A2DP.NotSupporterdMPF:
> > > +               :org.bluez.Error.A2DP.NotSupporterdVBR:
> > > +               :org.bluez.Error.A2DP.InvalidBitRate:
> > > +               :org.bluez.Error.A2DP.NotSupportedBitRate:
> > > +               :org.bluez.Error.A2DP.InvalidObjectType:
> > > +               :org.bluez.Error.A2DP.NotSupportedObjectType:
> > > +               :org.bluez.Error.A2DP.InvalidChannels:
> > > +               :org.bluez.Error.A2DP.NotSupportedChannels:
> > > +               :org.bluez.Error.A2DP.InvalidVersion:
> > > +               :org.bluez.Error.A2DP.NotSupportedVersion:
> > > +               :org.bluez.Error.A2DP.NotSupportedMaximumSUL:
> > > +               :org.bluez.Error.A2DP.InvalidBlockLength:
> > > +               :org.bluez.Error.A2DP.InvalidCPType:
> > > +               :org.bluez.Error.A2DP.InvalidCPFormat:
> > > +               :org.bluez.Error.A2DP.InvalidCodecParameter:
> > > +               :org.bluez.Error.A2DP.NotSupportedCodecParameter:
> > > +               :org.bluez.Error.A2DP.InvalidDRC:
> > > +               :org.bluez.Error.A2DP.NotSupportedDRC:
> >
> > Introducing a error domain for A2DP is probably a good idea, but this
> > only applies to endpoints that are A2DP specific, so this need to be
> > adjusted to e.g.: possible for A2DP or something like that, also I
> > don't know how the client would be able to tell it can return these
> > errors? Or the expectation is that the client can start sending them
> > immediately since the old behavior will convert them to
> > AVDTP_UNSUPPORTED_CONFIGURATION anyway?
> >
>
> That was what I thought. The clients can just start sending these, and
> they will be converted to the correct error code if bluez supports it
> or to AVDTP_UNSUPPORTED_CONFIGURATION otherwise.
>
> > While at it split the commit to have the documentation changes as a
> > separate change.
>
> Will adjust text and split into a separate commit.
>
> >
> > >  array{byte} SelectConfiguration(array{byte} capabilities)
> > >  `````````````````````````````````````````````````````````
> > >
> > > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > > index c0a53eae9..661843a89 100644
> > > --- a/profiles/audio/a2dp.c
> > > +++ b/profiles/audio/a2dp.c
> > > @@ -157,6 +157,73 @@ static GSList *servers =3D NULL;
> > >  static GSList *setups =3D NULL;
> > >  static unsigned int cb_id =3D 0;
> > >
> > > +struct a2dp_error {
> > > +       const char *error_name;
> > > +       uint8_t error_code;
> > > +};
> > > +
> > > +#define A2DP_ERROR_PREFIX ERROR_INTERFACE ".A2DP."
> > > +
> > > +static struct a2dp_error config_errors[] =3D {
> > > +       {"InvalidCodecType", A2DP_INVALID_CODEC_TYPE},
> > > +       {"NotSupportedCodecType", A2DP_NOT_SUPPORTED_CODEC_TYPE},
> > > +       {"InvalidSamplingFrequency", A2DP_INVALID_SAMPLING_FREQUENCY}=
,
> > > +       {"NotSupportedSamplingFrequency",
> > > +                               A2DP_NOT_SUPPORTED_SAMPLING_FREQUENCY=
},
> > > +       {"InvalidChannelMode", A2DP_INVALID_CHANNEL_MODE},
> > > +       {"NotSupportedChannelMode", A2DP_NOT_SUPPORTED_CHANNEL_MODE},
> > > +       {"InvalidSubbands", A2DP_INVALID_SUBBANDS},
> > > +       {"NotSupportedSubbands", A2DP_NOT_SUPPORTED_SUBBANDS},
> > > +       {"InvalidAllocationMethod", A2DP_INVALID_ALLOCATION_METHOD},
> > > +       {"NotSupportedAllocationMethod", A2DP_NOT_SUPPORTED_ALLOCATIO=
N_METHOD},
> > > +       {"InvalidMinimumBitpoolValue",
> > > +                               A2DP_INVALID_MINIMUM_BITPOOL_VALUE},
> > > +       {"NotSupportedMinimumBitpoolValue",
> > > +                               A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VA=
LUE},
> > > +       {"InvalidMaximumBitpoolValue", A2DP_INVALID_MAXIMUM_BITPOOL_V=
ALUE},
> > > +       {"NotSupportedMaximumBitpoolValue",
> > > +                               A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VA=
LUE},
> > > +       {"InvalidInvalidLayer", A2DP_INVALID_INVALID_LAYER},
> > > +       {"NotSupportedLayer", A2DP_NOT_SUPPORTED_LAYER},
> > > +       {"NotSupporterdCRC", A2DP_NOT_SUPPORTERD_CRC},
> > > +       {"NotSupporterdMPF", A2DP_NOT_SUPPORTERD_MPF},
> > > +       {"NotSupporterdVBR", A2DP_NOT_SUPPORTERD_VBR},
> > > +       {"InvalidBitRate", A2DP_INVALID_BIT_RATE},
> > > +       {"NotSupportedBitRate", A2DP_NOT_SUPPORTED_BIT_RATE},
> > > +       {"InvalidObjectType", A2DP_INVALID_OBJECT_TYPE},
> > > +       {"NotSupportedObjectType", A2DP_NOT_SUPPORTED_OBJECT_TYPE},
> > > +       {"InvalidChannels", A2DP_INVALID_CHANNELS},
> > > +       {"NotSupportedChannels", A2DP_NOT_SUPPORTED_CHANNELS},
> > > +       {"InvalidVersion", A2DP_INVALID_VERSION},
> > > +       {"NotSupportedVersion", A2DP_NOT_SUPPORTED_VERSION},
> > > +       {"NotSupportedMaximumSUL", A2DP_NOT_SUPPORTED_MAXIMUM_SUL},
> > > +       {"InvalidBlockLength", A2DP_INVALID_BLOCK_LENGTH},
> > > +       {"InvalidCPType", A2DP_INVALID_CP_TYPE},
> > > +       {"InvalidCPFormat", A2DP_INVALID_CP_FORMAT},
> > > +       {"InvalidCodecParameter", A2DP_INVALID_CODEC_PARAMETER},
> > > +       {"NotSupportedCodecParameter", A2DP_NOT_SUPPORTED_CODEC_PARAM=
ETER},
> > > +       {"InvalidDRC", A2DP_INVALID_DRC},
> > > +       {"NotSupportedDRC", A2DP_NOT_SUPPORTED_DRC}
> > > +};
> > > +
> > > +uint8_t a2dp_parse_config_error(const char *error_name)
> > > +{
> > > +       size_t prefix_length;
> > > +       size_t i;
> > > +
> > > +       prefix_length =3D strlen(A2DP_ERROR_PREFIX);
> > > +       if (strncmp(A2DP_ERROR_PREFIX, error_name, prefix_length))
> > > +               return AVDTP_UNSUPPORTED_CONFIGURATION;
> > > +
> > > +       error_name +=3D prefix_length;
> > > +       for (i =3D 0; i < ARRAY_SIZE(config_errors); i++) {
> > > +               if (strcmp(config_errors[i].error_name, error_name) =
=3D=3D 0)
> > > +                       return config_errors[i].error_code;
> > > +       }
> > > +
> > > +       return AVDTP_UNSUPPORTED_CONFIGURATION;
> > > +}
> > > +
> > >  static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
> > >  {
> > >         setup->ref++;
> > > @@ -688,11 +755,10 @@ done:
> > >         return FALSE;
> > >  }
> > >
> > > -static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean r=
et)
> > > +static void endpoint_setconf_cb(struct a2dp_setup *setup, uint8_t er=
ror_code)
> > >  {
> > > -       if (ret =3D=3D FALSE)
> > > -               setup_error_init(setup, AVDTP_MEDIA_CODEC,
> > > -                                       AVDTP_UNSUPPORTED_CONFIGURATI=
ON);
> > > +       if (error_code !=3D 0)
> > > +               setup_error_init(setup, AVDTP_MEDIA_CODEC, error_code=
);
> > >
> > >         auto_config(setup);
> > >         setup_unref(setup);
> > > @@ -865,11 +931,11 @@ static gboolean endpoint_getcap_ind(struct avdt=
p *session,
> > >         return TRUE;
> > >  }
> > >
> > > -static void endpoint_open_cb(struct a2dp_setup *setup, gboolean ret)
> > > +static void endpoint_open_cb(struct a2dp_setup *setup, uint8_t error=
_code)
> > >  {
> > >         int err =3D error_to_errno(setup->err);
> > >
> > > -       if (ret =3D=3D FALSE) {
> > > +       if (error_code !=3D 0) {
> > >                 setup->stream =3D NULL;
> > >                 finalize_setup_errno(setup, -EPERM, finalize_config, =
NULL);
> > >                 goto done;
> > > diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
> > > index c698bc983..afa02c12d 100644
> > > --- a/profiles/audio/a2dp.h
> > > +++ b/profiles/audio/a2dp.h
> > > @@ -15,7 +15,8 @@ struct a2dp_setup;
> > >
> > >  typedef void (*a2dp_endpoint_select_t) (struct a2dp_setup *setup, vo=
id *ret,
> > >                                         int size);
> > > -typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup, gb=
oolean ret);
> > > +typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup,
> > > +                                       uint8_t error_code);
> > >
> > >  struct a2dp_endpoint {
> > >         const char *(*get_name) (struct a2dp_sep *sep, void *user_dat=
a);
> > > @@ -70,6 +71,8 @@ unsigned int a2dp_select_capabilities(struct avdtp =
*session,
> > >  unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep=
,
> > >                                 a2dp_config_cb_t cb, GSList *caps,
> > >                                 void *user_data);
> > > +uint8_t a2dp_parse_config_error(const char *error_name);
> > > +
> > >  unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep=
,
> > >                                 a2dp_stream_cb_t cb, void *user_data)=
;
> > >  unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *se=
p,
> > > diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> > > index 30648251f..ed4e22b26 100644
> > > --- a/profiles/audio/avdtp.c
> > > +++ b/profiles/audio/avdtp.c
> > > @@ -1494,8 +1494,8 @@ static void setconf_cb(struct avdtp *session, s=
truct avdtp_stream *stream,
> > >         struct conf_rej rej;
> > >
> > >         if (err !=3D NULL) {
> > > -               rej.error =3D AVDTP_UNSUPPORTED_CONFIGURATION;
> > > -               rej.category =3D err->err.error_code;
> > > +               rej.error =3D err->err.error_code;
> > > +               rej.category =3D AVDTP_UNSUPPORTED_CONFIGURATION;
> > >                 avdtp_send(session, session->in_cmd.transaction,
> > >                            AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURA=
TION,
> > >                            &rej, sizeof(rej));
> > > diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> > > index 9b3042c18..332f643bb 100644
> > > --- a/profiles/audio/media.c
> > > +++ b/profiles/audio/media.c
> > > @@ -333,7 +333,7 @@ static void endpoint_reply(DBusPendingCall *call,=
 void *user_data)
> > >         DBusMessage *reply;
> > >         DBusMessageIter args, props;
> > >         DBusError err;
> > > -       gboolean value;
> > > +       uint8_t error_code;
> > >         void *ret =3D NULL;
> > >         int size =3D -1;
> > >
> > > @@ -356,8 +356,12 @@ static void endpoint_reply(DBusPendingCall *call=
, void *user_data)
> > >
> > >                 if (dbus_message_is_method_call(request->msg,
> > >                                         MEDIA_ENDPOINT_INTERFACE,
> > > -                                       "SetConfiguration"))
> > > +                                       "SetConfiguration")) {
> > >                         endpoint_remove_transport(endpoint, request->=
transport);
> > > +                       error_code =3D a2dp_parse_config_error(err.na=
me);
> > > +                       ret =3D &error_code;
> > > +                       size =3D 1;
> > > +               }
> > >
> > >                 dbus_error_free(&err);
> > >                 goto done;
> > > @@ -390,8 +394,8 @@ static void endpoint_reply(DBusPendingCall *call,=
 void *user_data)
> > >         }
> > >
> > >         size =3D 1;
> > > -       value =3D TRUE;
> > > -       ret =3D &value;
> > > +       error_code =3D 0;
> > > +       ret =3D &error_code;
> > >
> > >  done:
> > >         dbus_message_unref(reply);
> > > @@ -634,9 +638,9 @@ static void config_cb(struct media_endpoint *endp=
oint, void *ret, int size,
> > >                                                         void *user_da=
ta)
> > >  {
> > >         struct a2dp_config_data *data =3D user_data;
> > > -       gboolean *ret_value =3D ret;
> > > +       uint8_t *ret_value =3D ret;
> > >
> > > -       data->cb(data->setup, ret_value ? *ret_value : FALSE);
> > > +       data->cb(data->setup, ret_value ? *ret_value : 1);
> > >  }
> > >
> > >  static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
> > > @@ -1098,7 +1102,7 @@ static void pac_config_cb(struct media_endpoint=
 *endpoint, void *ret, int size,
> > >                                                         void *user_da=
ta)
> > >  {
> > >         struct pac_config_data *data =3D user_data;
> > > -       gboolean *ret_value =3D ret;
> > > +       uint8_t *error_code =3D ret;
> > >         struct media_transport *transport;
> > >
> > >         /* If transport was cleared, configuration was cancelled */
> > > @@ -1106,7 +1110,7 @@ static void pac_config_cb(struct media_endpoint=
 *endpoint, void *ret, int size,
> > >         if (!transport)
> > >                 return;
> > >
> > > -       data->cb(data->stream, ret_value ? 0 : -EINVAL);
> > > +       data->cb(data->stream, error_code =3D=3D 0 ? 0 : -EINVAL);
> > >  }
> > >
> > >  static struct media_transport *pac_ucast_config(struct bt_bap_stream=
 *stream,
> > > diff --git a/src/error.h b/src/error.h
> > > index 47602d39b..8157795c2 100644
> > > --- a/src/error.h
> > > +++ b/src/error.h
> > > @@ -88,3 +88,41 @@ DBusMessage *btd_error_profile_unavailable(DBusMes=
sage *msg);
> > >  DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
> > >  DBusMessage *btd_error_bredr_errno(DBusMessage *msg, int err);
> > >  DBusMessage *btd_error_le_errno(DBusMessage *msg, int err);
> > > +
> > > +enum a2dp_error_codes : uint8_t {
> > > +       A2DP_INVALID_CODEC_TYPE =3D 0xc1,
> > > +       A2DP_NOT_SUPPORTED_CODEC_TYPE =3D 0xc2,
> > > +       A2DP_INVALID_SAMPLING_FREQUENCY =3D 0xc3,
> > > +       A2DP_NOT_SUPPORTED_SAMPLING_FREQUENCY =3D 0xc4,
> > > +       A2DP_INVALID_CHANNEL_MODE =3D 0xc5,
> > > +       A2DP_NOT_SUPPORTED_CHANNEL_MODE =3D 0xc6,
> > > +       A2DP_INVALID_SUBBANDS =3D 0xc7,
> > > +       A2DP_NOT_SUPPORTED_SUBBANDS =3D 0xc8,
> > > +       A2DP_INVALID_ALLOCATION_METHOD =3D 0xc9,
> > > +       A2DP_NOT_SUPPORTED_ALLOCATION_METHOD =3D 0xca,
> > > +       A2DP_INVALID_MINIMUM_BITPOOL_VALUE =3D 0xcb,
> > > +       A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VALUE =3D 0xcc,
> > > +       A2DP_INVALID_MAXIMUM_BITPOOL_VALUE =3D 0xcd,
> > > +       A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALUE =3D 0xce,
> > > +       A2DP_INVALID_INVALID_LAYER =3D 0xcf,
> > > +       A2DP_NOT_SUPPORTED_LAYER =3D 0xd0,
> > > +       A2DP_NOT_SUPPORTERD_CRC =3D 0xd1,
> > > +       A2DP_NOT_SUPPORTERD_MPF =3D 0xd2,
> > > +       A2DP_NOT_SUPPORTERD_VBR =3D 0xd3,
> > > +       A2DP_INVALID_BIT_RATE =3D 0xd4,
> > > +       A2DP_NOT_SUPPORTED_BIT_RATE =3D 0xd5,
> > > +       A2DP_INVALID_OBJECT_TYPE =3D 0xd6,
> > > +       A2DP_NOT_SUPPORTED_OBJECT_TYPE =3D 0xd7,
> > > +       A2DP_INVALID_CHANNELS =3D 0xd8,
> > > +       A2DP_NOT_SUPPORTED_CHANNELS =3D 0xd9,
> > > +       A2DP_INVALID_VERSION =3D 0xda,
> > > +       A2DP_NOT_SUPPORTED_VERSION =3D 0xdb,
> > > +       A2DP_NOT_SUPPORTED_MAXIMUM_SUL =3D 0xdc,
> > > +       A2DP_INVALID_BLOCK_LENGTH =3D 0xdd,
> > > +       A2DP_INVALID_CP_TYPE =3D 0xe0,
> > > +       A2DP_INVALID_CP_FORMAT =3D 0xe1,
> > > +       A2DP_INVALID_CODEC_PARAMETER =3D 0xe2,
> > > +       A2DP_NOT_SUPPORTED_CODEC_PARAMETER =3D 0xe3,
> > > +       A2DP_INVALID_DRC =3D 0xe4,
> > > +       A2DP_NOT_SUPPORTED_DRC =3D 0xe5,
> > > +};
> >
> > Hmm, I guess there should be part of a2dp.h since this error header is
> > about D-Bus not A2DP codes.
> >
>
> Ok, will move them to a2dp.h
>


--=20
Luiz Augusto von Dentz
