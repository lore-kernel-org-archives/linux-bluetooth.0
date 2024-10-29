Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1F195F22
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218289; cv=none; b=lAIFctXJQyRREf199QDdZYkNxA6SecxQ64zjf3SqSx+HEbo2jsZnwulZpKULO+muB/fehu6Guo5cNd9+M58v2ONV7cHfoUtN5pD3bdIdBf13zMmWBv8rweebvi7rn/Vh8h+j2acBF1+Dm+vtDeIY8WhKJaGMJjiivANAIbnLSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218289; c=relaxed/simple;
	bh=RfaqQw7QDXfvQQupw+KFQEoJZBbJOiOz+XshJxUYUt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5+Z1SF4h/N35OTjLJERyz5R8WaxtYTI0f7WoZp8K7KhvMc19NF5o5k5WJnkQhXG9cbnGu74X7BbSR9Y3Eki+BH9aQcuqaPrvzloAFRmTysDH3wH6e9wGdQBZiVrypUDkbkPOIi/Lsx1cCw6sMvJ07PlQFZabwFCtIYcAmXL2KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/aVu025; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/aVu025"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb49510250so56400831fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730218285; x=1730823085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGKSf1RQDoq4leQF9plpKCObOb5uYapRxzL7RO8b8jg=;
        b=F/aVu025Mb3VLOjiXP6LPWCZE0p14D3GzpDpd9SREW6LwmJyehTA91a0YJlsUM33WR
         G4GcnLZgXZwnsvdQlnkb3m8U1XUlFxvHjQwryBZrPNkNoUXGoHwChKTKkg+bTrh95+aK
         fKSwTs3XeibarRYnzUSMHoGmuBBJYNdO0c8eaFyCM0cUO3NfhTmRFAVwHM1TacsizUb8
         cHRze9LRyWacNZvdsSPD+B3LLneBYpTGLYjKCaIa/zcjOauI7vkwlISQoNt+I+fLD1Sm
         KpQE+Ps6Iun4thBMoliTKsQU+Tg/ZAz98drm1mUFqV3AetkqAlTLcT4gy4w45EYVUNki
         48jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218285; x=1730823085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGKSf1RQDoq4leQF9plpKCObOb5uYapRxzL7RO8b8jg=;
        b=eHD+SFugKphDyp29bZCTFLoGhxKpeZD/uyRYN9pESbGmXnhUCuE9bRQBBlDwqJisNf
         i992EXLV/pFlcoEozIFwkSxZf0K9XmZbkleauzy0SOKxM3FcIhO3/P0jHcVju4B6RiMb
         d20x7k5wgF6vtAO4373GoBffdg/uFTyQQV20Y4ZJhGsV/VoOgJ1mqTz6BGscHBlZZeJB
         S8LHSec6E26Fjr79yrMmFQ3qNwsCJ+8FlByJybPhkmdpbeZItEVvgDK+uCyURbRAX6Ay
         E63Yv01tSOaNswyks/zVolsClLkVbF7CdFM2mpzI5obD7+yeYfQ67ZExteVMpCkZ4UBh
         5pLQ==
X-Gm-Message-State: AOJu0YzRMFKGTgbvjD/twEfIWOreF7ZeDH25/+2Trq3ZFXh3LRhi6n2a
	74Ef4HdT+eD/qz6SjSfZnxy/Pb2WcPiWqQZqzPgWb3Hh8/jEP41oe9U+noOm4/hv0feIQsHOend
	OD/DxzSqnmyJys55p1ohDXKR/5JBXDQ==
X-Google-Smtp-Source: AGHT+IFQ3Xqd35Swwo0jTdiBNeNfV/ZKD076hI/SmiH7op8atLW47unHGDYEvAKM8lPfkaHKgkSVk08aqU0vKDK4TnQ=
X-Received: by 2002:a05:651c:2226:b0:2fb:51f3:9212 with SMTP id
 38308e7fff4ca-2fcbdf5fa27mr65313661fa.6.1730218284702; Tue, 29 Oct 2024
 09:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029151647.1282872-1-hadess@hadess.net> <CABBYNZJ9=2sahn9ELk9rm76fs4jY=ObxMEANN5NLghz4CWGy_A@mail.gmail.com>
 <d788531f9118d22b447e8fcc83e7caef10cc4a9b.camel@hadess.net>
In-Reply-To: <d788531f9118d22b447e8fcc83e7caef10cc4a9b.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Oct 2024 12:11:11 -0400
Message-ID: <CABBYNZKj9AwCzT8J4TvPzNk1VR-Z2Jj1X4+DQT_uqYVXhYR-wg@mail.gmail.com>
Subject: Re: [BlueZ] device: Better "Connect" debug
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Oct 29, 2024 at 12:03=E2=80=AFPM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Tue, 2024-10-29 at 11:36 -0400, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Tue, Oct 29, 2024 at 11:17=E2=80=AFAM Bastien Nocera <hadess@hadess.=
net>
> > wrote:
> > >
> > > Output clearer debug information so that it's possible to follow
> > > the
> > > decisions made by the bluetoothd daemon when a client such as
> > > bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
> > > device.
> > > ---
> > >  src/device.c | 39 ++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 32 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/src/device.c b/src/device.c
> > > index 7585184de50c..8756aef41aab 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -2462,10 +2462,13 @@ static DBusMessage *connect_profiles(struct
> > > btd_device *dev, uint8_t bdaddr_type
> > >         DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
> > >
> > > dbus_message_get_sender(msg));
> > >
> > > -       if (dev->pending || dev->connect || dev->browse)
> > > +       if (dev->pending || dev->connect || dev->browse) {
> > > +               DBG("Cannot connect, connection busy");
> > >                 return btd_error_in_progress_str(msg,
> > > ERR_BREDR_CONN_BUSY);
> >
> > I think for this type of debug we are better off introducing directly
> > into our gdbus lib so we get the information of both method calls and
> > replies when debug is enabled, thoughts?
>
> I don't really mind leaving the debug messages that are already
> associated with a return value out of the patch.

Let's do that then, so we don't pollute the source with more debug
messages that would be removed later.

> What did you have in mind for modifying gdbus? Stashing debug messages
> in the reply?

There is already a message as part of the reply in case of error so we
would just print it on reply.

> >
> > > +       }
> > >
> > >         if (!btd_adapter_get_powered(dev->adapter)) {
> > > +               DBG("Cannot connect, adapter is not powered");
> > >                 return btd_error_not_ready_str(msg,
> > >
> > > ERR_BREDR_CONN_ADAPTER_NOT_POWERED);
> > >         }
> > > @@ -2482,8 +2485,10 @@ static DBusMessage *connect_profiles(struct
> > > btd_device *dev, uint8_t bdaddr_type
> > >                                                         "Connect")
> > > &&
> > >                                 find_service_with_state(dev-
> > > >services,
> > >
> > > BTD_SERVICE_STATE_CONNECTED)) {
> > > +                               DBG("Already connected to
> > > services");
> > >                                 return
> > > dbus_message_new_method_return(msg);
> > >                         } else {
> > > +                               DBG("Exhausted the list of BR/EDR
> > > profiles to connect to");
> > >                                 return
> > > btd_error_not_available_str(msg,
> > >
> > > ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
> > >                         }
> > > @@ -2494,8 +2499,10 @@ static DBusMessage *connect_profiles(struct
> > > btd_device *dev, uint8_t bdaddr_type
> > >
> > >         err =3D connect_next(dev);
> > >         if (err < 0) {
> > > -               if (err =3D=3D -EALREADY)
> > > +               if (err =3D=3D -EALREADY) {
> > > +                       DBG("Already connected");
> > >                         return dbus_message_new_method_return(msg);
> > > +               }
> > >                 return btd_error_failed(msg,
> > >
> > > btd_error_bredr_conn_from_errno(err));
> > >         }
> > > @@ -2568,12 +2575,20 @@ static uint8_t select_conn_bearer(struct
> > > btd_device *dev)
> > >         return dev->bdaddr_type;
> > >  }
> > >
> > > +static const char *bdaddr_type_strs[] =3D {
> > > +       "BR/EDR",
> > > +       "LE public",
> > > +       "LE random"
> > > +};
> > > +
> > >  static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage
> > > *msg,
> > >                                                         void
> > > *user_data)
> > >  {
> > >         struct btd_device *dev =3D user_data;
> > >         uint8_t bdaddr_type;
> > >
> > > +       DBG("Calling \"Connect\" for device %s", dev->path);
> > > +
> > >         if (dev->bredr_state.connected) {
> > >                 /*
> > >                  * Check if services have been resolved and there
> > > is at least
> > > @@ -2581,20 +2596,30 @@ static DBusMessage
> > > *dev_connect(DBusConnection *conn, DBusMessage *msg,
> > >                  */
> > >                 if (dev->bredr_state.svc_resolved &&
> > >                         find_service_with_state(dev->services,
> > > -
> > > BTD_SERVICE_STATE_CONNECTED))
> > > +
> > > BTD_SERVICE_STATE_CONNECTED)) {
> > >                         bdaddr_type =3D dev->bdaddr_type;
> > > -               else
> > > +                       DBG("Selecting address type %s, as BR/EDR
> > > services are resolved "
> > > +                           " and connected", bdaddr_type_strs[dev-
> > > >bdaddr_type]);
> > > +               } else {
> > >                         bdaddr_type =3D BDADDR_BREDR;
> > > -       } else if (dev->le_state.connected && dev->bredr)
> > > +                       DBG("Selecting address type BR/EDR, as
> > > services not resolved "
> > > +                           "or not connected");
> > > +               }
> > > +       } else if (dev->le_state.connected && dev->bredr) {
> > >                 bdaddr_type =3D BDADDR_BREDR;
> > > -       else
> > > +               DBG("Selecting address type BR/EDR, as LE already
> > > connected");
> > > +       } else {
> > >                 bdaddr_type =3D select_conn_bearer(dev);
> > > +               DBG("Selecting address type %s",
> > > bdaddr_type_strs[dev->bdaddr_type]);
> > > +       }
> > >
> > >         if (bdaddr_type !=3D BDADDR_BREDR) {
> > >                 int err;
> > >
> > > -               if (dev->le_state.connected)
> > > +               if (dev->le_state.connected) {
> > > +                       DBG("Device already connected through LE");
> > >                         return dbus_message_new_method_return(msg);
> > > +               }
> > >
> > >                 btd_device_set_temporary(dev, false);
> > >
> > > --
> > > 2.47.0
> > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
