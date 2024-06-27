Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12113A276
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510066; cv=none; b=EI/XKN6z3Q8H7vf2hPXsfgK6V8w/EfZD2EVP+1lyMmmMAS5Cu5F/e/GmcxJBZOw48xskjGkdcHEGpt523bHjZ8WuIP0QrMRlWldvXcbGZdhkogwqIW2vryA9cGvbuzS2y+92LP6DM4eUvocVn7WQ6OgR67X5cl8iBGxNjO88KHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510066; c=relaxed/simple;
	bh=eaeeSikbmA0CaQ37rG388Wj1AaHc4pikQ5mal4TsREc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjCdCpsuKqy33fDd2SlYEJ4NPo5f7A52jta9MuyL9qyXfwa05d+A5h95pOF1ilMQJx0i7G/0l0fRRl0+gYDrm4O6Fjl5TMNxXZfCwLbJm9/ojLbzXdW5I/B2a71C3F30f0UTCT1t25ewqIHxHgTO6pDsH0jmeACUHPOFbjw8e4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD0FNSCN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD0FNSCN"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so104704561fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719510063; x=1720114863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhtT3xDHjyOfpc9yEUyymfqT8uGxOqySbfmMWiHYafs=;
        b=KD0FNSCNISFNPVry4z6ZCyAL5TqsqYKzsPAeNB2jKbcNRSTsiq0j9MB0CO7rpdEBDV
         R/s0rapxG1RiMAS65FDZz/gNcraNhh6sv/GnBqzLEKqKBLWdTe5HIrU+CfRYfZ41KTll
         fuiKTLWM39kigsA6cRDlXfB5K4cp+9h9utFOt5G5GL4QioFK7izScrM2k7xE+pMlnoZ2
         C/egcig47B+9gl/0YQwVqpmB9D1NGkZTMll+J5t4DYZADe59+mK+tjPrsrTDNcKtZTL/
         IpUXe2TaYl/6M9JrUT53Vdid/WhRNKn/9htusU3vpTeg29HctPnnQXqj5IRTfy/e/0ft
         hArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510063; x=1720114863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhtT3xDHjyOfpc9yEUyymfqT8uGxOqySbfmMWiHYafs=;
        b=LfpziSMAk9ozW+Sx8c3ZGY5Emq63gVxA0hZ9Eb86uYk02BBi6QFijLkmiUXgIxliZb
         9Aiyuue+W3m/5fD6j/7hhQyRLGmHaezhoLSWT0a1PiLQLTRnXtf7oQc7+muvOlzSdX9m
         Y5apYHbu2EcfrtTnl3QCIjuqI07oYnMQyDeGJpi5fd3l03MQpGbGv6Chbcbm3tJQNM5Y
         1uOP77BABrjBacLNmU89/7c8OX4kyfBR0NkcMNrcQwFy1wWf1XilaLkOt0R+UAsl7wtW
         SSlHxASU7RkWLTcXOH0dizbOT3v2J93HF+veKqdi9cMMA5rTb6HuWX/7rRZKKSdwClsA
         dBbg==
X-Forwarded-Encrypted: i=1; AJvYcCUeoIc1j6eeeuhkt3Dj36SjqQRZZzjcNMQL43SxGyuv91co9CsS6UM3sDNEdrBylBIZ8vr3WOBj4K1OBhfb4osLmq4hDRSTgKoVBGL766XK
X-Gm-Message-State: AOJu0Yx01fq7blLf2zMAMf+0ufQ0ZBznuipp37VAUUNjHWjqKBMK9076
	VbRKhJyxYjMh18zZmHLv3hQKl3r9s+uJ9QlKYBFLvOIhTe7wrN76Vo8BYORXbdg+DtkubriXnvR
	plxhGRCFKMlkpX3/kYnusFiH+M5yS6g==
X-Google-Smtp-Source: AGHT+IEbjj66QZZVONlTFISbHiB8WwFvVv4baQi0juyaSp65txmAKNMhh1vLsdTcNwBpDtlk3OMDT557iNZpZGV0Yig=
X-Received: by 2002:a2e:3817:0:b0:2ec:5172:dbc4 with SMTP id
 38308e7fff4ca-2ec57978cb8mr88611541fa.12.1719510062216; Thu, 27 Jun 2024
 10:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625063533.30536-1-quic_amisjain@quicinc.com>
 <dac1d55c940b3a9afb971263c8195e765e77c598.camel@iki.fi> <8ae5c6f5-e005-42d9-ad5b-ea53a978a85a@quicinc.com>
 <93bef84b37237fcc9fac8d7e7a80bd640f01d064.camel@iki.fi>
In-Reply-To: <93bef84b37237fcc9fac8d7e7a80bd640f01d064.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Jun 2024 13:40:49 -0400
Message-ID: <CABBYNZK2Gp__8ceYNeDEyPXWxuxnX4QL22aBuXbcmkDJ0HF57A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth : Update the mas session structure
To: Pauli Virtanen <pav@iki.fi>
Cc: Amisha Jain <quic_amisjain@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 27, 2024 at 12:24=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2024-06-26 kello 11:40 +0530, Amisha Jain kirjoitti:
> > Hi,
> >
> > Correct! The problem here is manager_emit_transfer_property() is
> > expecting the structure of type 'obex_transfer' and we are passing the
> > structure of session type which will be type mismatch and inappropriate
> > values will be populated in further calls in code. Hence property "Size=
"
> > will never emit on console(obexctl) as it is not set properly and might
> > cause crash/disconnection.
> >
> >  > diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> >  > index a4bae857f..ed219d3e7 100644
> >  > --- a/obexd/src/obex.c
> >  > +++ b/obexd/src/obex.c
> >  > @@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session
> > *os, const char *filename)
> >  >                  return err;
> >  >          }
> >  >
> >  > +       if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D
> > OBJECT_SIZE_UNKNOWN)
> >  > +               manager_emit_transfer_property(os->service_data, "Si=
ze");
> >  > +
> >  >          os->path =3D g_strdup(filename);
> >  >
> >
> >
> > One way to resolve this issue is to add the additional field in
> > 'mas_session' so it can cast to struct 'obex_transfer'. We are adding
> > new field 'char *path' as only transfer->path will be invoked and passe=
d
> > further.
>
> Yes, thank you for clarification.
>
> Although I'm not BlueZ maintainer, I think relying on type punning
> mas_session and obex_transfer by adding fields so that their memory
> representation is partly the same is not very good practice. Other
> plugins like ftp.c seem also have similar issue.

Yeah, it clearly was not intended to be that way.

> One could consider some ways to avoid doing this, e.g. move the
>
>         if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_SIZE=
_UNKNOWN)
>                 manager_emit_transfer_property(os->service_data, "Size");
>
> after each call to obex_put_stream_start in plugins/*.c
> client/mns.c. For plugins where there's no transfer, it maybe can be
> omitted.

I think this was intended to be called directly by the plugins
otherwise we need to always create transfer objects for each object
being transferred and that be set as os->service_data which obviously
isn't the case here.

> >
> > void manager_emit_transfer_property(struct obex_transfer *transfer,
> >                                                               char *nam=
e)
> > {
> >       if (!transfer->path)
> >               return;
> >
> >       g_dbus_emit_property_changed(connection, transfer->path,
> >                                       TRANSFER_INTERFACE, name);
> > }
> >
> >  >> Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
> >  >> ---
> >  >>   obexd/plugins/mas.c | 4 +++-
> >  >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >  >>
> >  >> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> >  >> index 10b972d65..71bf12ad3 100644
> >  >> --- a/obexd/plugins/mas.c
> >  >> +++ b/obexd/plugins/mas.c
> >  >> @@ -51,6 +51,8 @@
> >  >>   #define ML_BODY_END "</MAP-msg-listing>"
> >  >>
> >  >>   struct mas_session {
> >  >> + uint8_t notification_status;
> >  >> + char *path;
> >  >>           struct mas_request *request;
> >  >>           void *backend_data;
> >  >>           gboolean finished;
> >  >> @@ -59,7 +61,6 @@ struct mas_session {
> >  >>           GObexApparam *inparams;
> >  >>           GObexApparam *outparams;
> >  >>           gboolean ap_sent;
> >  >> - uint8_t notification_status;
> >  >>   };
> >  >>
> >  >>   static const uint8_t MAS_TARGET[TARGET_SIZE] =3D {
> >  >> @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session
> > *os, int *err)
> >  >>                   goto failed;
> >  >>
> >  >>           manager_register_session(os);
> >  >> + mas->path =3D NULL;
> >  >
> >
> > There is no transfer already registered for mas during connection, so
> > setting the path to NULL.
> >
> > On 6/25/2024 9:09 PM, Pauli Virtanen wrote:
> > > Hi,
> > >
> > > ti, 2024-06-25 kello 12:05 +0530, Amisha Jain kirjoitti:
> > > > Update the 'mas_session' structure such that
> > > > manager_emit_transfer_property(os->service_data, "Size")
> > > > will get the proper structure in arguments as
> > > > expected like structure 'obex_transfer' and transfer->path
> > > > won't be populated with inappropriate value.
> > > >
> > > > As there is no new transfer registered during mas connect,
> > > > hence setting the path to NULL to avoid invoking the
> > > > g_dbus_emit_property_changed() property.
> > > >
> > > > Signed-off-by: Amisha Jain <quic_amisjain@quicinc.com>
> > > > ---
> > > >   obexd/plugins/mas.c | 4 +++-
> > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> > > > index 10b972d65..71bf12ad3 100644
> > > > --- a/obexd/plugins/mas.c
> > > > +++ b/obexd/plugins/mas.c
> > > > @@ -51,6 +51,8 @@
> > > >   #define ML_BODY_END "</MAP-msg-listing>"
> > > >
> > > >   struct mas_session {
> > > > + uint8_t notification_status;
> > > > + char *path;
> > > >           struct mas_request *request;
> > > >           void *backend_data;
> > > >           gboolean finished;
> > > > @@ -59,7 +61,6 @@ struct mas_session {
> > > >           GObexApparam *inparams;
> > > >           GObexApparam *outparams;
> > > >           gboolean ap_sent;
> > > > - uint8_t notification_status;
> > > >   };
> > > >
> > > >   static const uint8_t MAS_TARGET[TARGET_SIZE] =3D {
> > > > @@ -125,6 +126,7 @@ static void *mas_connect(struct obex_session *o=
s, int *err)
> > > >                   goto failed;
> > > >
> > > >           manager_register_session(os);
> > > > + mas->path =3D NULL;
> > >
> > > Maybe the problem here is that the change in commit bb160515185e
> > > ("obexd: Emit Size property of transfer after open()") is not right?
> > >
> > > diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> > > index a4bae857f..ed219d3e7 100644
> > > --- a/obexd/src/obex.c
> > > +++ b/obexd/src/obex.c
> > > @@ -779,6 +779,9 @@ int obex_put_stream_start(struct obex_session *os=
, const char *filename)
> > >                  return err;
> > >          }
> > >
> > > +       if (os->size !=3D OBJECT_SIZE_DELETE && os->size !=3D OBJECT_=
SIZE_UNKNOWN)
> > > +               manager_emit_transfer_property(os->service_data, "Siz=
e");
> > > +
> > >          os->path =3D g_strdup(filename);
> > >
> > > This casts os->service_data to obex_transfer which IIUC does not work
> > > for most the plugins, as it's the session struct.
> > >
> > > Maybe plugins can emit the transfer property change in their open()
> > > callback, for the plugins where it makes sense?
> > >
> > > >
> > > >           return mas;
> > > >
> > >
>
> --
> Pauli Virtanen
>


--=20
Luiz Augusto von Dentz
