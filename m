Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296A253B5A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293092; cv=none; b=I2CBJiqHPAh5Zk9B/4giYgEgOPZ8/2ClZgivmd2inRxCwr/MDKrZcFewRV6JT419j+/97jVKX5iJODH33jRtyFb5lYj7vZGL56BxNmixuuI7tLCVg3rWkeu9uag2Tr/p7+VxruPQpSE2wNBdfLs3rNfVizHQArJqdJyUMtkFfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293092; c=relaxed/simple;
	bh=XtrflRaNWDNVYU2DByLIdyFlvD30I9PY8Q8koBRuoEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SudWZpctSiZOT8T4ApOftMUa+SwRmSLuweM9MbpSXWKEhw+U/rTzVzdqXyTwUe9voeN6AENEdQGZBItmFmAOI9yuYYnNIVeXuUY/QCYQIaQem5u/00ucajI9uSJDarbFMXidA1/rchBGrd/aXu8S64QPgQ4UPlwDlLD86/yNT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liguZ6bZ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liguZ6bZ"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307bc125e2eso54189781fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 08:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739293088; x=1739897888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBUEdh03PhpsYw2G5smeUiKH9KireFuVzMWiXgTBbaw=;
        b=liguZ6bZvT6VkJBeIVmnIMB/Cl/qiDs+5xuppzePRBFXkjyJ0K981ppp9gU+ayA1G5
         B2w+aRot5wxuTKAloPuQtPtOKrLFb851bwxi0Vo4p3AY6/Nm246OX4hehCn7498X1Fae
         MlsAw4626c5EJygAleAxxBjmtVAnNy9GfD8bvBuLcnzmw7XNOgugevK2pQvJ2l6ySWvh
         lPL3sCbYDiS2UMkVV4jPCLOQzalGz0Bf2nVvURLSiiv4ICEzu9Jjfx/+HhvpxdZVVcTR
         5diD33E954bDgM1ouDaPaEX27Mokclp7gw67qkishP4sqfXmRZ+mO9soiP7lP2Kv8GDb
         +Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739293088; x=1739897888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBUEdh03PhpsYw2G5smeUiKH9KireFuVzMWiXgTBbaw=;
        b=ptiyCdsuHcgbQnLPNzu1Z+gFKTkAnSSAKPYzbjz1/QIg2vyJeuLbNhvkfhc0Vf1bkW
         YBU5dzkmNMTmZBKrFDOtc7IhukBDTbv84YLvPY5er5S6YngpKlNoE5At1snqaOLiVOyJ
         yFHVNlsMOVRzBoYvK/AnWlo5YuAxganftUGIi5WnDIiMXtSL/OL5RZnyK73ceAVtkbKo
         kSxzZFi+DIzCdOsse+cb0taaIsk76SYTkSL6/GrIPH7pBH+2ecATfQ9cTwmHeIu/z89z
         7y3Hl2RVyhEHfeUTZa1IfuG3h/sXYh+oyBtrgWJQ2dyo1VvDIu3ya0NNx8aQ9RXRFGSi
         /TjQ==
X-Gm-Message-State: AOJu0YwrL7/8q3ZbqHNTQJlCAqQrcMvOO2hir+apt679VeUIN4JVrFID
	O11LavTdO3rMS4UNuQtm+wj9L7yyL+UY19MgAxCebGkHMy/MelwBS01dC7KWj2iprrrsCvDpBFP
	CNSHRtzTzFXdKnoJp6Wkjime3CDiG1hkr
X-Gm-Gg: ASbGnct/2j9gNLRuorIvZBU9lFsNH0T01oIYsklkZTdHdJO7zewTP0MGj8oszK0ZDU3
	I3+tKyVIDAz+F+RRtBEuzu748AMz8x1oBIY3niH1DSko/uFhvi9Zgo6r+fQwfWO6e/fyrcOJJOw
	==
X-Google-Smtp-Source: AGHT+IH5358SGIloI6jzbL3S15Jn0QO5QmqxoFuePBD9sLv4JrFZwlcDHiDBmJimeonFBtLcJaNvdH1DjbZwDPycSE4=
X-Received: by 2002:a05:651c:220c:b0:307:e0c3:5293 with SMTP id
 38308e7fff4ca-309036ea829mr760851fa.36.1739293087670; Tue, 11 Feb 2025
 08:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122113256.1107629-1-hadess@hadess.net> <20250122113256.1107629-3-hadess@hadess.net>
 <CABBYNZLP-n25ZYVvJz2E8+kbkS5ah23tqZmeVkYLwt1xCAWamA@mail.gmail.com> <78217e353bbeedce89a47e40365c73cc2f44179d.camel@hadess.net>
In-Reply-To: <78217e353bbeedce89a47e40365c73cc2f44179d.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Feb 2025 11:57:55 -0500
X-Gm-Features: AWEUYZmCZAIpkwsp1uzKEwYuw0WHyIQ4vwO2rEMg5XImztA6kcs5BxCJ0TXMkAE
Message-ID: <CABBYNZKx3OTGXNxWuh8wf+iOqnSfZuX3Z9j4JXOj8MCy72+_+A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] device: Better "Connect" debug
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Feb 11, 2025 at 11:00=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Wed, 2025-01-22 at 14:57 -0500, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Wed, Jan 22, 2025 at 6:33=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et>
> > wrote:
> > >
> > > Output clearer debug information so that it's possible to follow
> > > the
> > > decisions made by the bluetoothd daemon when a client such as
> > > bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
> > > device.
> > > ---
> > >  client/error.c |  1 +
> > >  client/main.c  |  5 +++--
> > >  src/device.c   | 36 +++++++++++++++++++++++++++++-------
> > >  3 files changed, 33 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/client/error.c b/client/error.c
> > > index 975e4030dfc0..aa8a058cce98 100644
> > > --- a/client/error.c
> > > +++ b/client/error.c
> > > @@ -19,6 +19,7 @@ struct {
> > >         { "br-connection-profile-unavailable", "Exhausted the list
> > > of BR/EDR profiles to connect to" },
> > >         { "br-connection-busy", "Cannot connect, connection busy"
> > > },
> > >         { "br-connection-adapter-not-powered", "Cannot connect,
> > > adapter is not powered" },
> > > +       { "br-connection-page-timeout", "Device is unpowered or not
> > > in range" },
> >
> > Not really following why do you want to translate the error message
> > in
> > bluetoothctl and not directly on bluetoothd side? Well perhaps there
> > could be application expecting these strings to be sort of errors
> > code
> > really, in that case perhaps this is valid but I'd rather have it
> > output both error.message and its description, but I would begin by
> > defining them in the documentation:
> >
> > https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#voi=
d-connect
> >
> > Right now we only document the error.code not the error.message
>
> I'd like to give the opportunity to front-ends to still be able to
> differentiate the different errors, but also dump in their logs a
> human-readable version of the error if they don't want to differentiate
> it in the UI.
>
> What do you think of passing:
>
> error code =3D org.bluez.Error.Failed
> error.message =3D "BlueZ.Error:br-connection-page-timeout:Device is unpow=
ered or not in range"
>
> This would be a bit similar to how GDBus (the GLib one) encodes object
> error codes over the wire:
> https://gitlab.gnome.org/GNOME/glib/blob/glib-2-80/gio/gdbuserror.c#L410
>
> This means that we can get nicer error messages in bluetoothctl, and
> front-ends like gnome-bluetooth can use the error code to translate it
> to other languages, or present it differently.
>
> What do you think?

I fine with that, like I said for me the error message was sort of
free format but perhaps it is not for some application reading into it
as they expect the string to work as error (sub)code, in that case
changing these string may actually be considered breaking an API,
honestly I don't know if we should consider adding more error codes
and leave the message as free format otherwise this will keep
happening.

> >
> > >  };
> > >
> > >  const char *error_code_to_str(const char *error_code)
> > > diff --git a/client/main.c b/client/main.c
> > > index 322326ab9b80..0c39e8795762 100644
> > > --- a/client/main.c
> > > +++ b/client/main.c
> > > @@ -30,6 +30,7 @@
> > >  #include "gdbus/gdbus.h"
> > >  #include "print.h"
> > >  #include "agent.h"
> > > +#include "error.h"
> > >  #include "gatt.h"
> > >  #include "advertising.h"
> > >  #include "adv_monitor.h"
> > > @@ -1977,8 +1978,8 @@ static void connect_reply(DBusMessage
> > > *message, void *user_data)
> > >         dbus_error_init(&error);
> > >
> > >         if (dbus_set_error_from_message(&error, message) =3D=3D TRUE)=
 {
> > > -               bt_shell_printf("Failed to connect: %s %s\n",
> > > error.name,
> > > -                               error.message);
> > > +               bt_shell_printf("Failed to connect: %s: %s\n",
> > > error.name,
> > > +                               error_code_to_str(error.message));
> > >                 dbus_error_free(&error);
> > >                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
> > >         }
> > > diff --git a/src/device.c b/src/device.c
> > > index e8bff718c201..9ec6b4d4bd2e 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -2477,8 +2477,9 @@ static DBusMessage *connect_profiles(struct
> > > btd_device *dev, uint8_t bdaddr_type
> > >         DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
> > >
> > > dbus_message_get_sender(msg));
> > >
> > > -       if (dev->pending || dev->connect || dev->browse)
> > > +       if (dev->pending || dev->connect || dev->browse) {
> > >                 return btd_error_in_progress_str(msg,
> > > ERR_BREDR_CONN_BUSY);
> > > +       }
> > >
> > >         if (!btd_adapter_get_powered(dev->adapter)) {
> > >                 return btd_error_not_ready_str(msg,
> > > @@ -2497,6 +2498,7 @@ static DBusMessage *connect_profiles(struct
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
> > >                                 return
> > > btd_error_not_available_str(msg,
> > > @@ -2509,8 +2511,10 @@ static DBusMessage *connect_profiles(struct
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
> > > @@ -2583,12 +2587,20 @@ static uint8_t select_conn_bearer(struct
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
> > > @@ -2596,20 +2608,30 @@ static DBusMessage
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
> > > 2.47.1
> > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
