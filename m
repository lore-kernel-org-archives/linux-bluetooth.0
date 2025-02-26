Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D42185B8
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602455; cv=none; b=L922DuDq8p2PlxdqA56MLf27tsnP4tZWKhJoLd5of/eZWDR2nczQf08LJyo00xxz8Nfb5NxXXwdbIgdv2UWphD21RIS//YTSvYUJrLYIjl2TJFDTQ3PVqhqtjGjSEST14G3YWZAm8pZa2/O+Lr9XfUtVtjRj+jpIBWLOFNSm6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602455; c=relaxed/simple;
	bh=y9p3IJrV7DaVn2tksMptHr+n5DKa5BJPLGuPDhk5EW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOWYPabner1B9R4pl701EY4tXDxd846m4rmFkMLszgtX5Gh7VLFxo+zCK5JozzyW41+uJberHW7NwymDc7IaFVrFMduiBRym+gKpGDkM5sBEC3a3XMQxqu+EftA7VPdxLlS2V4UyTAMJk9uKcdmI0bdbN7UWmrYpvrolBZapv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBuUVxLj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBuUVxLj"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30615661f98so2552151fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740602452; x=1741207252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OOoTcAEwXXthp0FmxfDkrLaym3x4TvOLOWUB9g6nKc=;
        b=nBuUVxLjRELStHJohXVobjinkYzKxpJUBF26vBhZwJ7cbUG33OQP7ph+VTySTGQIWy
         0dt9ZDnG9XPzqF/8izcN/KJRwPURJa9nqyd5F1/f2gXLXSz98Kab7fe3PHgnC0ShRs8I
         /jn+pGKnGS3P0QIw0PeFeWDUbO9pknClmvxH+IcfaOlDOZXu3RJUns7I76j1isExZ3TD
         XMEKkCWVaa2BDBKnmbY7T+F5idHt906hXJD4Tze/8NCQayjdJLQAqCTpITe6w8XnD390
         DD5FscHz6bCUJTpoMnOZpwV/Q87olzL0V+ys3eOfa5Ql7QPoQve7xUyNPNI76ad83Yu/
         Koyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740602452; x=1741207252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OOoTcAEwXXthp0FmxfDkrLaym3x4TvOLOWUB9g6nKc=;
        b=wI9ouY+erGCKUfnElFXnmL9j4ScUhqhw6z5W4DaRpuIs91aiQjWe95fLtBKrpjb30u
         IrNQZoqlOVqj6h6+/LQU6omjdo02f2VnU0dY2GESjIWK5rR+eOgnUoK6aK1yoweIbsNW
         r9sVEtt9ylFUvrUj/RlSYOjzo//BSPyO5Iu+S/3XYv/MCyMIUTaSHOQM1jcU44Cg7Kj5
         AuCGKUcOihJQ8FsucBfENqoOWCN9cfLY9Jj+DVy+5C92erLRKBKo/CZShcv4cWDZmInU
         /N4wpp2CLs4HxVxlX3X7UEvmtLq/0GOrrbWDO7K18YNyYCES8BcESX+6WHRB2BQtKqYp
         +f/g==
X-Forwarded-Encrypted: i=1; AJvYcCWefMzIOwsgH+tknwUh+Fv7Fcej6PjGUnYtwv2c6Xb52ILYx2x2xBIFHoV6L1pyzkO0frqKhl1Lg0aW/nOV5ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjvzT+vwUkpceQlpIr+J4A3w/7lKsXy/JoPHEOYGvYtq9KQUfP
	NlmSw8Q0ey7JH8sb8pmSOHScBQv7fHEint8jc3QaY2DlTs4ws9qV35EauHoYS2ZHtUh8Jpptix/
	Uizww0Z0aEDCCm5lgUhi9xK8Ry0T3Oxga
X-Gm-Gg: ASbGncsMr1ah7sJEC7GJPTOCXLf5o3NwMiC90EgAgnvuDtBkqphN6KeYAzPu8uUPERv
	oTWIv+jxQxLZXu/eMGCT+use6kZYKK0TEiw01mtRMPYMQtU4KZU3aeE7zS5FNaL4yRqlYabQhZl
	/fZkcbwQ==
X-Google-Smtp-Source: AGHT+IEeFPdG5twj1LH4wuv85iOqaeicGMFmk3kjCokJ7K4Wz/nvbAFTNBwTO0771itXCY/F6BvfTVRmPJgo+PR3fhg=
X-Received: by 2002:a2e:9c98:0:b0:307:dc1f:e465 with SMTP id
 38308e7fff4ca-30a80c419a4mr45810841fa.22.1740602451684; Wed, 26 Feb 2025
 12:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224111056.3255513-1-quic_amisjain@quicinc.com>
 <98149822-8ac9-4099-bb44-16f79419ddc3@molgen.mpg.de> <1937d5048f91464a8bb32fe2466a94b8@quicinc.com>
In-Reply-To: <1937d5048f91464a8bb32fe2466a94b8@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Feb 2025 01:40:39 +0500
X-Gm-Features: AQ5f1JoBsAgyX4S0hr29GNH7pcikJckxHdUuftbxeLR7hS-latY-MwXZizSa9SY
Message-ID: <CABBYNZKd4sqemB3UJW7OyMS_N0LFA9sPqcD61gBnfYnvYcTkEA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] obex: Add messages_get_message() implementation
 for MAP plugin
To: "Amisha Jain (QUIC)" <quic_amisjain@quicinc.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>, "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>, 
	"Anubhav Gupta (QUIC)" <quic_anubhavg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha,

On Wed, Feb 26, 2025 at 2:11=E2=80=AFAM Amisha Jain (QUIC)
<quic_amisjain@quicinc.com> wrote:
>
> Hi Paul,
>
> > -----Original Message-----
> > From: Paul Menzel <pmenzel@molgen.mpg.de>
> > Sent: Monday, February 24, 2025 7:34 PM
> > To: Amisha Jain (QUIC) <quic_amisjain@quicinc.com>
> > Cc: linux-bluetooth@vger.kernel.org; Mohammed Sameer Mulla (QUIC)
> > <quic_mohamull@quicinc.com>; Harish Bandi (QUIC)
> > <quic_hbandi@quicinc.com>; Anubhav Gupta (QUIC)
> > <quic_anubhavg@quicinc.com>
> > Subject: Re: [RESEND PATCH v2] obex: Add messages_get_message()
> > implementation for MAP plugin
> >
> > Dear Amisha,
> >
> >
> > Am 24.02.25 um 12:10 schrieb Amisha Jain:
> > > GET Message() operation should be supported for passing below PTS
> > > testcases -
> > >
> > > 1.MAP/MSE/MMB/BV-12-C
> > > Verify that the MSE can return an email message to the MCE.
> > > 2.MAP/MSE/MMB/BV-13-C
> > > Verify that the MSE can return a SMS message in native format to the =
MCE.
> >
> > a*n* SMS
> >
> > > 3.MAP/MSE/MMB/BV-14-C
> > > Verify that the MSE can return a SMS message with text trans-coded to
> > > UTF-8
> >
> > a*n*
> >
> > > to the MCE.
> >
> > I=E2=80=99d add a space after the bullet points (the dot).
> >
> > > Currently get message operation is not implemented, hence above
> > > testcases are failing.
> > > Added code to send the complete bmessage in response
> >
> > Should this be *message* or is *bmessage* some terminology?
> >
>
> This is 'bmessage', message format used by MAP to store messages.
> As per Spec, bMessages are application objects used by MAP for message tr=
ansport.
> Exchanged messages shall use the bMessage format.
>
> > > to the get request for the requested message handle.
> > >
> > > ---
> > >   obexd/plugins/mas.c            |  4 ++--
> > >   obexd/plugins/messages-dummy.c | 27 ++++++++++++++++++++++++++-
> > >   2 files changed, 28 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c index
> > > 10b972d65..f63fcf6c6 100644
> > > --- a/obexd/plugins/mas.c
> > > +++ b/obexd/plugins/mas.c
> > > @@ -612,11 +612,11 @@ static void *message_open(const char *name, int
> > oflag, mode_t mode,
> > >             return NULL;
> > >     }
> > >
> > > +   mas->buffer =3D g_string_new("");
> > > +
> > >     *err =3D messages_get_message(mas->backend_data, name, 0,
> > >                     get_message_cb, mas);
> > >
> > > -   mas->buffer =3D g_string_new("");
> > > -
> > >     if (*err < 0)
> > >             return NULL;
> > >     else
> > > diff --git a/obexd/plugins/messages-dummy.c
> > > b/obexd/plugins/messages-dummy.c index e313c6163..665face3f 100644
> > > --- a/obexd/plugins/messages-dummy.c
> > > +++ b/obexd/plugins/messages-dummy.c
> > > @@ -516,7 +516,32 @@ int messages_get_message(void *session, const
> > char *handle,
> > >                                     messages_get_message_cb callback,
> > >                                     void *user_data)
> > >   {
> > > -   return -ENOSYS;
> > > +   struct session *s =3D  session;
> > > +   FILE *fp;
> > > +   char *path;
> > > +   char buffer[1024];
> > > +
> > > +   DBG(" ");
> > > +   path =3D g_build_filename(s->cwd_absolute, handle, NULL);
> > > +   fp =3D fopen(path, "r");
> > > +   if (fp =3D=3D NULL) {
> > > +           DBG("fopen() failed");
> > > +           return -EBADR;
> > > +   }
> > > +
> > > +   /* 1024 is the maximum size of the line which is calculated to be=
 more
> > > +    * sufficient*/
> >
> > I do not fully grok this sentence. Could you please rephrase?
> >
>
> Sure, this corresponds to max size of a line in a file, as we are reading=
 the file line by line.
> Same way it is present in existing function - get_messages_listing().
>
> static gboolean get_messages_listing(void *d)
> {
>
>         struct message_listing_data *mld =3D d;
>         /* 1024 is the maximum size of the line which is calculated to be=
 more
>          * sufficient*/
>         char buffer[1024];
>         GMarkupParseContext *ctxt;
>
> > > +   while (fgets(buffer, 1024, fp)) {
> > > +           if (callback)
> > > +                   callback(session, 0, 0, (const char*)buffer, user=
_data);
> > > +   }
> > > +
> > > +   if (callback)
> > > +           callback(session, 0, 0, NULL, user_data);

Btw, if the callback is NULL then perhaps we shouldn't be looping with
fgets, I also thinking that perhaps the whole think about reading the
messages and copying it over to a buffer perhaps could be avoided,
perhaps using mmap is better here, although this is just the dummy
implementation with perhaps doesn't care so much about doing things in
a 'proper' way.

> > > +
> > > +   g_free(path);
> > > +   fclose(fp);
> > > +   return 0;
> > >   }
> > >
> > >   int messages_update_inbox(void *session, messages_status_cb
> > > callback,
> >
> >
> > Kind regards,
> >
> > Paul
>
> Thanks,
> Amisha



--=20
Luiz Augusto von Dentz
