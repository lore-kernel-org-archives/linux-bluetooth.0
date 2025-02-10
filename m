Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959EA1F8BAF
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739211349; cv=pass; b=aOtJNLG6+rnQeU4/LuPttjvLT9R71YmMqVCxsw5Qzm5Pbo6OoWz9ulEOAUCfwvofvSp+vUwJVPRCezI/NP9LiEOACA6dLeKpjG3wFH0FXblP1um0KiY3vLK+ucon4GInNdL0w4zH9RfiFbl0M0reE8CA8AMNqzvcA5EOvmsXD4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739211349; c=relaxed/simple;
	bh=eLTHzsNCtKSYRCzh1U684lv038xpcBGLsroR/Kf9NwI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9Y41KyxletUSIL+EEqF3rMiL56mIb5UkX1RpGdutpWGWq+8xpOo071mR081hD8QtBEiseegxPY/cPI+WIvceb105QFrY3qdKM1FFjq2H3kvH0I270K3L466rKAlBhyxCo4hDGbqAelYv23jfzFRHdDULkvbDrLN4yR/2uzSoPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=tKfEyhMr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="tKfEyhMr"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YsCRz67k0z49PyM;
	Mon, 10 Feb 2025 20:15:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739211344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=99uJra2oRhfkX9RWtmHBKUk3YYW9cJxtUJT2IHVEzfA=;
	b=tKfEyhMrt4FrPLeNTPLBPXS8Chi07xoxQ6gXM/2nPEM5HO1uZweWQY5SKAy1jDjEjhrHcp
	VC/p6CbrIf6DpQnFkkJqalHgoK6stilNoJ2beIHVxGABw9FH224Yz+SY3zApeYF6cF+Rq6
	iffBHSvD9mbH93D4hhK78ZX/SoEQOruesQXwiKXC5jsb5AxQbwlfvEcFROUxBZmXPX7/Ky
	cygWaLnmIxqdFgFP4vGu3+XaBJvyOwB1hCZTKh7UW/T23me3UFMvhx/EajEUUlGl0tAfQO
	GTn+APS8zpnBoom9qmpWt60TdOgnuihB7A3QcvuJt/YNEC+3vvd2nr6cfgmCbw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739211344; a=rsa-sha256;
	cv=none;
	b=SnrPmHv0J+F5Q7PMNBPJh88y0ExRxH0p3I83koLxooclhTAON7kuTbvd5YexetHkTHWDwi
	ngkFIHVHUghSjmwDvMvA1c08vGPG7VdLDmBp1jIMCbIlchGO9hI48Rdpxz2/ZMwaAaE7wz
	Sdh63U9I+U87JGKNyEoVsTTJ4Zgm0HBwjyaNkOK9BOlCa9+0BP6ciBunbXhqQAb4SeRmKL
	CNu6FMvJEyHq5PU87ige51gFT82+2JPVl9w5vTVmvkd+LYdUMummfvfUaJKB0KPAjzpKgT
	mZ5b28krDI7YcLJY3rP+ZWC6GZz1hWZMVztCcV5jpOtjbSVGs3Z0Frp/lULOqA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739211344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=99uJra2oRhfkX9RWtmHBKUk3YYW9cJxtUJT2IHVEzfA=;
	b=I4pVkZc9QqteTHxjYSSmUAgvH7k2ko6HBJwi4fm3ykRyxbrdTBrgtIaff09VTaJSr/o5Qb
	Z1TMLskotSOW4Atfgt9uCmzjaxDjPoV3iBOaIF4x9o4q/EqIJ6Th2tViygyElc2KSCUvOo
	9olm/go5W2BJ+kOlTOAqvEF0AptwIFPbv6DL8YxIROxvdufW7a7nNNu/Db1s5L9pgyomdb
	FOZuvou80h2XoQu9/03vLoif6DKNbaAuWGe9mJ5yk13xzB2SB1HPalr8HblJ4DHR8yLIO0
	m7W+Q3G68/gw34SXM9EnfewaaPZz0dtuuM3G7e0bRgt4sJjLLyiFAv4+axr+ZA==
Message-ID: <102f133fbd176f8c4eacc02d837c1ff075648236.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with
 TX timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 10 Feb 2025 20:15:41 +0200
In-Reply-To: <CABBYNZJccrs7n4mK1YYF+SyKG46d2mkmcem_Ayg77nm3FtJ93w@mail.gmail.com>
References: <cover.1739097949.git.pav@iki.fi>
	 <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
	 <CABBYNZJccrs7n4mK1YYF+SyKG46d2mkmcem_Ayg77nm3FtJ93w@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-02-10 kello 10:13 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Feb 9, 2025 at 5:46=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > Add special implementation of fd watcher GSource for audio use.
> >=20
> > For audio use cases, sound server may turn on TX timestamping on a
> > socket that we are watching.  In this case, we shall not consider the T=
X
> > timestamping POLLERR as a socket error condition, nor read the TX
> > timestamps.
> >=20
> > When TX timestamps appear in errqueue, switch from fd poll wait to
> > polling the fd at regular intervals.  This is because unread errqueue
> > causes poll() to wake up immediately, so the mainloop cannot block on
> > that, and we have to use a timer instead with some reasonable timeout
> > for the use case.
> >=20
> > This rate limits wakeups on new TX timestamps we aren't going to read,
> > and also avoids the busy looping if timestamping was left on but
> > errqueue is not flushed.
> >=20
> > Implement this only for io-glib; it is only needed for audio use cases
> > that anyway are using glib.  Uses features from GLib 2.36 (from 2013) s=
o
> > update configure.ac also.
> > ---
> >  Makefile.am          |   1 +
> >  acinclude.m4         |   3 +-
> >  configure.ac         |   2 +-
> >  src/shared/io-glib.c | 157 ++++++++++++++++++++++++++++++++++++++++++-
> >  src/shared/io-glib.h |  20 ++++++
> >  5 files changed, 179 insertions(+), 4 deletions(-)
> >  create mode 100644 src/shared/io-glib.h
> >=20
> > diff --git a/Makefile.am b/Makefile.am
> > index 0821530e6..f958e2b99 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -253,6 +253,7 @@ shared_sources +=3D src/shared/shell.c src/shared/s=
hell.h
> >  endif
> >=20
> >  src_libshared_glib_la_SOURCES =3D $(shared_sources) \
> > +                               src/shared/io-glib.h \
> >                                 src/shared/io-glib.c \
> >                                 src/shared/timeout-glib.c \
> >                                 src/shared/mainloop-glib.c \
> > diff --git a/acinclude.m4 b/acinclude.m4
> > index 168117840..598986d6e 100644
> > --- a/acinclude.m4
> > +++ b/acinclude.m4
> > @@ -63,8 +63,7 @@ AC_DEFUN([COMPILER_FLAGS], [
> >                 with_cflags=3D"$with_cflags -Wformat -Wformat-security"
> >                 with_cflags=3D"$with_cflags -Wstringop-overflow"
> >                 with_cflags=3D"$with_cflags -DG_DISABLE_DEPRECATED"
> > -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_28"
> > -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=
=3DGLIB_VERSION_2_32"
> > +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_36"
> >         fi
> >         AC_SUBST([WARNING_CFLAGS], $with_cflags)
> >  ])
> > diff --git a/configure.ac b/configure.ac
> > index 75841e4c9..d2b0bab2f 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -81,7 +81,7 @@ AC_CHECK_DECLS([basename], [],
> >                                  ])
> >=20
> >=20
> > -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
> > +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.36)
>=20
> I hope this doesn't come with other surprises though, afaik glib had
> the bad habit of adding its own set of dependencies which made us
> stick to such old versions.

Glib 2.36 was released in 2013, I hope all BlueZ builds use something
newer...

We might want to keep the max version limit in maintainer mode, though,
to get warnings if using too new API features.

>=20
> >=20
> >  if (test "${enable_threads}" =3D "yes"); then
> >         AC_DEFINE(NEED_THREADS, 1, [Define if threading support is requ=
ired])
> > diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> > index 754043db1..bea9b2c32 100644
> > --- a/src/shared/io-glib.c
> > +++ b/src/shared/io-glib.c
> > @@ -13,10 +13,14 @@
> >  #endif
> >=20
> >  #include <errno.h>
> > +#include <sys/socket.h>
> >=20
> >  #include <glib.h>
> >=20
> >  #include "src/shared/io.h"
> > +#include "src/shared/io-glib.h"
> > +
> > +#define        IO_ERR_WATCH_RATELIMIT          (500 * G_TIME_SPAN_MILL=
ISECOND)
> >=20
> >  struct io_watch {
> >         struct io *io;
> > @@ -29,11 +33,19 @@ struct io_watch {
> >  struct io {
> >         int ref_count;
> >         GIOChannel *channel;
> > +       bool err_watch;
> >         struct io_watch *read_watch;
> >         struct io_watch *write_watch;
> >         struct io_watch *disconnect_watch;
> >  };
> >=20
> > +struct io_err_watch {
> > +       GSource                 source;
> > +       GIOChannel              *io;
> > +       GIOCondition            events;
> > +       gpointer                tag;
> > +};
> > +
> >  static struct io *io_ref(struct io *io)
> >  {
> >         if (!io)
> > @@ -179,10 +191,17 @@ static struct io_watch *watch_new(struct io *io, =
GIOCondition cond,
> >=20
> >         prio =3D cond =3D=3D G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_PRI=
ORITY_DEFAULT;
> >=20
> > -       watch->id =3D g_io_add_watch_full(io->channel, prio,
> > +       if (!io->err_watch)
> > +               watch->id =3D g_io_add_watch_full(io->channel, prio,
> > +                                               cond | G_IO_ERR | G_IO_=
NVAL,
> > +                                               watch_callback, watch,
> > +                                               watch_destroy);
> > +       else
> > +               watch->id =3D io_glib_add_err_watch_full(io->channel, p=
rio,
> >                                                 cond | G_IO_ERR | G_IO_=
NVAL,
> >                                                 watch_callback, watch,
> >                                                 watch_destroy);
> > +
> >         if (watch->id =3D=3D 0) {
> >                 watch_destroy(watch);
> >                 return NULL;
> > @@ -250,6 +269,15 @@ bool io_set_disconnect_handler(struct io *io, io_c=
allback_func_t callback,
> >         return io_set_handler(io, G_IO_HUP, callback, user_data, destro=
y);
> >  }
> >=20
> > +bool io_set_use_err_watch(struct io *io, bool err_watch)
> > +{
> > +       if (!io)
> > +               return false;
> > +
> > +       io->err_watch =3D err_watch;
> > +       return true;
> > +}
> > +
> >  ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> >  {
> >         int fd;
> > @@ -278,3 +306,130 @@ bool io_shutdown(struct io *io)
> >         return g_io_channel_shutdown(io->channel, TRUE, NULL)
> >                                                         =3D=3D G_IO_STA=
TUS_NORMAL;
> >  }
> > +
> > +/*
> > + * GSource implementation that tolerates non-empty MSG_ERRQUEUE, witho=
ut
> > + * attempting to flush it. This is intended for use with TX timestampi=
ng in
> > + * cases where someone else is reading the timestamps and we are only =
interested
> > + * in POLLHUP or socket errors.
> > + */
> > +
> > +static gint64 io_err_watch_wakeup;
> > +
> > +static gboolean io_err_watch_dispatch(GSource *source,
> > +                               GSourceFunc callback, gpointer user_dat=
a)
> > +{
> > +       struct io_err_watch *watch =3D (void *)source;
> > +       const GIOFunc func =3D (void *)callback;
> > +       const gint64 timeout =3D IO_ERR_WATCH_RATELIMIT;
> > +       GIOCondition cond;
> > +       int fd;
> > +
> > +       if (!func)
> > +               return FALSE;
> > +
> > +       fd =3D g_io_channel_unix_get_fd(watch->io);
> > +
> > +       /*
> > +        * If woken up by POLLERR only, and SO_ERROR is not set, ignore=
 this
> > +        * event. Also disable polling for some time so that we don't c=
onsume
> > +        * too much CPU on events we are not interested in, or busy loo=
p if
> > +        * nobody is flushing the errqueue.
> > +        */
>=20
> Not sure if I asked about this before, but have you consider disabling
> POLLERR completely in case we detect the errqueue is in use? Because
> even with rate limit I think we may still impact the system, the only
> problem is then if by disabling POLLERR we would get in trouble
> detecting disconnections? It shall result in POLLHUP though, so if we
> only care about it for disconnection I assume it would be sufficient.

It's not possible to disable wakeups on POLLERR & POLLHUP:

https://man.archlinux.org/man/poll.2.en

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
eventpoll.c?h=3Dv6.13&id=3Dffd294d346d185b70e28b1a28abe367bbfe53c04#n2391

You could use EPOLLET to only wake up once per event -- but bluez would
then still wakeup on the 7.5ms interval. Glib also doesn't use epoll(),
so there's more parts of GSource to reimplement, need to poll from
separate thread etc., so the implementation gets more complex than
here.

To get something better than the timer-polled version, I think you'd
need to add some new flag to kernel for this.

> > +       if (watch->tag)
> > +               cond =3D g_source_query_unix_fd(&watch->source, watch->=
tag);
> > +       else
> > +               cond =3D 0;
> > +
> > +       if (cond =3D=3D G_IO_ERR) {
> > +               int err, ret;
> > +               socklen_t len =3D sizeof(err);
> > +
> > +               ret =3D getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &len=
);
> > +               if (ret =3D=3D 0 && err =3D=3D 0) {
> > +                       g_source_remove_unix_fd(&watch->source, watch->=
tag);
> > +                       watch->tag =3D NULL;
> > +
> > +                       /* io_err watches all wake up at the same time =
*/
> > +                       if (!io_err_watch_wakeup)
> > +                               io_err_watch_wakeup =3D g_get_monotonic=
_time()
> > +                                                               + timeo=
ut;
> > +
> > +                       g_source_set_ready_time(&watch->source,
> > +                                                       io_err_watch_wa=
keup);
> > +                       return TRUE;
> > +               }
> > +       }
> > +
> > +       if (g_source_get_ready_time(&watch->source) !=3D -1) {
> > +               g_assert(!watch->tag);
> > +               io_err_watch_wakeup =3D 0;
> > +               watch->tag =3D g_source_add_unix_fd(&watch->source, fd,
> > +                                                       watch->events);
> > +               g_source_set_ready_time(&watch->source, -1);
> > +       }
> > +
> > +       cond &=3D watch->events;
> > +
> > +       if (cond)
> > +               return func(watch->io, cond, user_data);
> > +       else
> > +               return TRUE;
> > +}
> > +
> > +static void io_err_watch_finalize(GSource *source)
> > +{
> > +       struct io_err_watch *watch =3D (void *)source;
> > +
> > +       if (watch->tag)
> > +               g_source_remove_unix_fd(&watch->source, watch->tag);
> > +
> > +       g_io_channel_unref(watch->io);
> > +}
> > +
> > +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> > +                                       GIOCondition events,
> > +                                       GIOFunc func, gpointer user_dat=
a,
> > +                                       GDestroyNotify notify)
> > +{
> > +       static GSourceFuncs source_funcs =3D {
> > +               .dispatch =3D io_err_watch_dispatch,
> > +               .finalize =3D io_err_watch_finalize,
> > +       };
> > +       GSourceFunc callback =3D (void *)func;
> > +       struct io_err_watch *watch;
> > +       gint fd;
> > +       guint id;
> > +
> > +       g_return_val_if_fail(!(events & (G_IO_IN | G_IO_OUT)), 0);
> > +       g_return_val_if_fail(events, 0);
> > +       g_return_val_if_fail(func, 0);
> > +
> > +       fd =3D g_io_channel_unix_get_fd(io);
> > +
> > +       watch =3D (void *)g_source_new(&source_funcs,
> > +                                       sizeof(struct io_err_watch));
> > +
> > +       watch->io =3D g_io_channel_ref(io);
> > +       watch->events =3D events;
> > +       watch->tag =3D g_source_add_unix_fd(&watch->source, fd, events)=
;
> > +
> > +       g_source_set_name((void *)watch, "io_glib_err_watch");
> > +       g_source_set_callback(&watch->source, callback, user_data, noti=
fy);
> > +
> > +       if (priority !=3D G_PRIORITY_DEFAULT)
> > +               g_source_set_priority(&watch->source, priority);
> > +
> > +       id =3D g_source_attach(&watch->source, NULL);
> > +       g_source_unref(&watch->source);
> > +
> > +       return id;
> > +}
> > +
> > +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events, GIOFu=
nc func,
> > +                                                       gpointer user_d=
ata)
> > +{
> > +       return io_glib_add_err_watch_full(io, G_PRIORITY_DEFAULT, event=
s,
> > +                                                       func, user_data=
, NULL);
> > +}
> > diff --git a/src/shared/io-glib.h b/src/shared/io-glib.h
> > new file mode 100644
> > index 000000000..1db6fd468
> > --- /dev/null
> > +++ b/src/shared/io-glib.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
> > + *
> > + *
> > + */
> > +
> > +#include <glib.h>
> > +
> > +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events,
> > +                               GIOFunc func, gpointer user_data);
> > +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> > +                               GIOCondition events, GIOFunc func,
> > +                               gpointer user_data,
> > +                               GDestroyNotify notify);
> > +
>=20
> Hmm, I think it is probably not a good idea to start using headers
> like this, I'd consider just making it return 0 for non-glib.

Ok.

> > +bool io_set_use_err_watch(struct io *io, bool err_watch);
> > --
> > 2.48.1

--=20
Pauli Virtanen
