Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D81F1526
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738273022; cv=none; b=T41l7IG2kQEyhyRLfNQXCn0ElfXoOU0dcxZBneAuFaSFoAglyanCnWcA3UXA8Z+whtY2rEzlXHWZFF+NYtYZbFaX1VTcqXuyMxFCeukjvtTBoEpUNUsyZ6/Yk1fTW5CqIodRkAx3+Fl8sFZXS7TjhCox2nTbXamGDp6V4PsbPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738273022; c=relaxed/simple;
	bh=h1V9j9t9KmUF53R8ZNVk9Yn2fYA8mADqv41wbqdtlW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELk7aWRyk7T6DiX5mrulRNgp6pjzm+nqbCNs6hZTqRXxnVybO71g68xbS/q2/DEQf5kv1+VNJge1IJZgRK6/Y0fiB3a1DNWKp+9PD/hLDjx90drMDsGA0+hsvVs11sZmZNecO+bqsUciQq9dC811KLYzxVXCC1qXpUVr+2ZuMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jinzfxnS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jinzfxnS"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30761be8fcfso12764821fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738273018; x=1738877818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEz1R3Azjh+kelfEv/38BRpHbGuGVYbu6BqFLa+SFFA=;
        b=jinzfxnSwP0e+CVNIk/2BNu0UblncQQ9RAQPB+h3/u4KihSU7tt1TSpUWbmSr7ViGN
         JBx6/o2xCgbRzm/8jOCljcYjBN5tJp8nN3exP23ZyEJbYW4GyRik4lN+qy3iSwrbaa5z
         UoY610Z8jE9yKHXsRsLnp6Jn/rko121F7//IHhClQmAMmhbooDrEaoz9PNmY9pxnOV7L
         EZrySCfkbaOHeqpIMnutgKqsMRp/htIIwb41nisduClYOjK9Qi9TnMvF7WfOv6S12sWh
         Xg0B5v950WfU1mtDmXMiuCcwC3mk/KVhV9Fzt7wImScVKt9dwgpJPr8XYBh+raA5gbXA
         OEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738273018; x=1738877818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEz1R3Azjh+kelfEv/38BRpHbGuGVYbu6BqFLa+SFFA=;
        b=OPeuZTAA9sxO5HpDOwT2ykpDIENuA8HvjfFKeIZ6CMP2BtElbJCuVNqZ45WYH3EdMj
         GIWDY7ICGNBSEm1swIbADNCdCZR7QUpPRLu8m7Ie+D/IdMlbq68rSj1nw0QZs2pWTDc5
         ydPXYM00cLCyLX9armpadFLyBB0TsnQmysV3lYESfabcvrfvyNFEw9S0rcBYHX7C5M4t
         OjoimeCeVVQQhz36ebbsiTVHDudMkS1ipDy1NYpn1G5JJ89UTobNvq1dGDxasjvIg6GG
         03ZXjJQktJf5tbFw6kx2vlr+99z1TTr/X4x957MUWOSvqe46/DAvajNzZCkcCi6NZ5pI
         cjDQ==
X-Gm-Message-State: AOJu0YzluAiNPigJpNsB9S4eRus5oIixuPnopzZ+rrC6OJi5agfzLvMH
	PEsZGV/7VaGj7MqPYhdLPMOIytsLyDuJFV7vHoOZCZw9esfLL8Vn6l6/y9tVuMHoY3qRxByDcIg
	cIsZmOjhhppgO3SKxulq2yEy8yyHYQ/fL
X-Gm-Gg: ASbGncv/WzhkFIxG0POGbSatadxt/bNleTP0RVDaMr3SOq349e+LH0JBvuFxkHnXbRp
	PAiI0+oIqCZnNAltbQ2g3zlsm9qgZODYx7XdVq/6MHW2XPJdNn2jEXPDNbY1xtduSwad8M15EXw
	==
X-Google-Smtp-Source: AGHT+IEgeLIUWK7q9IW8APJS5C/vAidH0NNzxt0MMr30mCG7FsuWtEtA/PFVwWN2OaxbPxD/D1IU+qHQa7f87bw4REc=
X-Received: by 2002:a05:651c:b0e:b0:300:7f87:a6a with SMTP id
 38308e7fff4ca-307968b86f0mr31803421fa.7.1738273018157; Thu, 30 Jan 2025
 13:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128174327.1477546-1-quic_amisjain@quicinc.com>
 <CABBYNZL-26H=BuJvPbrqF8oswWiGWxiX8atNdt5ULYt5Xs3VgA@mail.gmail.com> <9c3b4bf424904d30888ec68677696cc3@quicinc.com>
In-Reply-To: <9c3b4bf424904d30888ec68677696cc3@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Jan 2025 16:36:46 -0500
X-Gm-Features: AWEUYZlWx94IrYm_VRn0uuAVNGJ8w-pWNP6pQwJzN4prT_y3Rqh2vghOXEJL1E0
Message-ID: <CABBYNZ+gaab9B3Yq15H4VB7M9=n6si4aM33TE-tBk++TQPDqCQ@mail.gmail.com>
Subject: Re: [PATCH v1] obex: Add supported features tag in MAP Client Connect Request
To: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>, "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>, 
	"Anubhav Gupta (QUIC)" <quic_anubhavg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Thu, Jan 30, 2025 at 2:38=E2=80=AFPM Amisha Jain (QUIC)
<quic_amisjain@quicinc.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Tuesday, January 28, 2025 11:20 PM
> > To: Amisha Jain (QUIC) <quic_amisjain@quicinc.com>
> > Cc: linux-bluetooth@vger.kernel.org; Mohammed Sameer Mulla (QUIC)
> > <quic_mohamull@quicinc.com>; Harish Bandi (QUIC)
> > <quic_hbandi@quicinc.com>; Anubhav Gupta (QUIC)
> > <quic_anubhavg@quicinc.com>
> > Subject: Re: [PATCH v1] obex: Add supported features tag in MAP Client
> > Connect Request
> >
> > Hi Amisha,
> >
> > On Tue, Jan 28, 2025 at 12:43=E2=80=AFPM Amisha Jain <quic_amisjain@qui=
cinc.com>
> > wrote:
> > >
> > > This change is required for below PTS testcase -
> > >
> > > 1. MAP/MCE/MFB/BV-06-C
> > > Verify that the MCE sends its MapSupportedFeatures in the OBEX Connec=
t
> > > request if the MSE declares support for the feature
> > > MapSupportedFeatures in Connect Request in its SDP record.
> > >
> > > If Server's SDP record contains the field 'MapSupportedFeatures in
> > > Connect Request' as supported then include the supported features tag
> > > in obex connect request.
> >
> > Can you include the btmon output with and without?
> >
> btmon output does not captures obex packet so adding snoop packet -

Hmm, seems you are right, we only had it for hcidump not btmon.

> Obex Connect request with this change -
> OBEX
>         Role: Central
>         Address: 0
>         Packet Status: Final Packet
>         Opcode: Connect
>         Length: 35
>         OBEX Version Number: 0x10
>         flags
>         Maximum Packet Length: 1800
>         Target
>                 Header Encoding: Byte Sequence
>                 Header ID: Target
>                 Length: 19
>                 Target: MAS
>         Application Parameters
>                 Header Encoding: Byte Sequence
>                 Header ID: Application Parameters
>                 Length: 9
>                 Parameter
>                         Tag: Map Supported Features
>                         Length: 4
>                         Value
>                                 : Messages-Listing Format Version 1.1
>                                 : Extended Event Report 1.1
>                                 : Instance Information Feature
>                                 : Delete Feature
>                                 : Uploading Feature
>                                 : Browsing Feature
>                                 : Notification Feature
>                                 : Notification Registration Feature
>
> Obex Connect request without this change -
> OBEX
>         Role: Central
>         Address: 0
>         Packet Status: Final Packet
>         Opcode: Connect
>         Length: 26
>         OBEX Version Number: 0x10
>         flags
>         Maximum Packet Length: 1800
>         Target
>                 Header Encoding: Byte Sequence
>                 Header ID: Target
>                 Length: 19
>                 Target: MAS

Please include this info as part of the patch description.

> > > ---
> > >  obexd/client/map.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/obexd/client/map.c b/obexd/client/map.c index
> > > b8820335b..2fd0f74ec 100644
> > > --- a/obexd/client/map.c
> > > +++ b/obexd/client/map.c
> > > @@ -39,6 +39,7 @@
> > >  #define OBEX_MAS_UUID \
> > >
> > "\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
> > >  #define OBEX_MAS_UUID_LEN 16
> > > +#define SUPPORTED_FEATURES_TAG  0x29
> > >
> > >  #define MAP_INTERFACE "org.bluez.obex.MessageAccess1"
> > >  #define MAP_MSG_INTERFACE "org.bluez.obex.Message1"
> > > @@ -2179,6 +2180,23 @@ static void parse_service_record(struct
> > map_data *map)
> > >                 map->supported_features =3D 0x0000001f;  }
> > >
> > > +static void *map_supported_features(struct obc_session *session) {
> > > +       const void *data;
> > > +
> > > +       /* Supported Feature Bits */
> > > +       data =3D obc_session_get_attribute(session,
> > > +                                       SDP_ATTR_MAP_SUPPORTED_FEATUR=
ES);
> > > +       if (!data)
> > > +               return NULL;
> > > +
> > > +       if(*(uint32_t *)data & 0x00080000)
> > > +               return g_obex_apparam_set_uint32(NULL,
> > SUPPORTED_FEATURES_TAG,
> > > +                               0x0000027f);
> >
> > Don't think it is safe to check the data like above, we don't know if f=
ield
> > returned is really 32 bits, perhaps it would be a good idea to introduc=
e
> > something like obc_session_get_attribute_le32 that would ensure the val=
ue is
> > really 32 bits and also check its little/big endian in the process.
> >
>
> As per the BT Spec, 32 bits field is reserved for 'MapSupportedFeatures' =
attribute in SDP record. So, it will be always 32 bits. Each bit correspond=
s to each feature. If any feature is not supported then that bit will be ze=
ro.

First 32 bits is not a proper format without us knowing in what byte
order it is, second we need to actually check the attribute is
correctly formatted and properly do it matches the expected size, now
perhaps you are saying that is our own SDP record we are talking
about, but that doesn't change the fact that there should be checks to
make sure we don't access invalid memory if something goes wrong.

>
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > >  static int map_probe(struct obc_session *session)  {
> > >         struct map_data *map;
> > > @@ -2224,6 +2242,7 @@ static struct obc_driver map =3D {
> > >         .uuid =3D MAS_UUID,
> > >         .target =3D OBEX_MAS_UUID,
> > >         .target_len =3D OBEX_MAS_UUID_LEN,
> > > +       .supported_features =3D map_supported_features,
> > >         .probe =3D map_probe,
> > >         .remove =3D map_remove
> > >  };
> > > --
> > > 2.34.1
> > >
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Amisha



--=20
Luiz Augusto von Dentz
