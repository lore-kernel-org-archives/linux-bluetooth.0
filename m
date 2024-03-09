Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7728E22
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Mar 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709986927; cv=pass; b=rqZihoJ3A02kvyLSYAvLtMD9HIQxovw0iCABkQFmvdlt0KkOGounCmP+DCWBFYZiTTEHz8JZ2n2zwO06lzeiLIpSqhe2JdqL8ZFy3jNDH+NjNTOgDZy74rkmWeGqIXWpfcyFle0/P4kNYbqYZrb3/1EjK9GTVRk8y8hoU96Ol8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709986927; c=relaxed/simple;
	bh=jazmEOKhFoBnfG5wxfJU+YJVWOKMigKrwfpb/QKN9FA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISd15fGttx5gtiPTtbQdVSfHka7ZcIGOqnSoYVck/TPynrg5b7lBhcOXZlYjQTD+sIQSlJ9/P048gO4+ZPUsB5lP3WQ2wX8+Kjpk5afD+KANQZf12nYz9FRTBj4DJpbQ84EGbML/ClGudAPDnVM+XpjMXiDvNzTumiDvZ3wKHL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=QiCoDSGz; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="QiCoDSGz"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TsMbk2pY8z49Q5W;
	Sat,  9 Mar 2024 14:21:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709986915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KBc2Zr6UQHVVRdRONs/nkHIXTlFzspC87Mm+qsp54JM=;
	b=QiCoDSGzhvUSpRgF4MXec6GsSdn2Lk0g2rodaW1tu/rpxHRB2wnYIwokYkSyDkpXEHjcK5
	9oZaRLaQWDcNNEs01jwNEakqMWLlDeCJWsHjF/pJgSc2hmJGnLs8DEE8BMa6vVIKaUW/mU
	QOLYjCjfV+cny0iYEotYpOQOO4H0ZhnW5AczeUlOD1iel4DnD+aAzoKGhpYbRh9KaaChGC
	/1JaeWkyDYV9wOwJZFl3u7rmEBymkokNnI9bGvCsTJEiQpjKE2u6mHsVlOET1tYhpawhvu
	Hqg6/uGjJhcDkrXqksOhNVtnYAd3DJDPh933VIl9a20paPt1mUyGewI0Zw3hQw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709986915; a=rsa-sha256;
	cv=none;
	b=jsUQJfq8ZJ9qlS66M9qblx+r+F9U7BulOQY19KnSo6Ef1Unl88HmUWbSM4EstgfYvqTkRi
	ZrFBa0SQk1Ri3Zz2rJRDaqm2AYRHIAVavrhfoQvVHJsR+QnQv+TJBWhcS0HQF3CLOkpJfT
	n9u6HSHVWM+ZP2Twsfx3sTyc4zx2qW+OrdFTG8usENA7keUr+ZvI5F8RmB/XPF2hiicmYb
	tVw/Uy5kEk8jbj/KCq5/EZEl6lgdoLsaA3c59S2IGQm+3sdSNAIDTL5ZynLCTAQ1Aqu+lK
	W6WFEfEw6QMnEoSRQJLLvPLZXu1BUm4zWqb0YT/KWKfylp2r+/O6z3ydyMARNA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709986915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KBc2Zr6UQHVVRdRONs/nkHIXTlFzspC87Mm+qsp54JM=;
	b=BouTo2jqfFP/FB/9eAue+1e/vxyTpACQsqM3/3WUuFmCHRc6w4rG34zPztWD0749Z5m3Se
	YhWMm0/dBLElvhSp7FoMunupRzt7TYe4LqppSE3oyi0SzsM++sfMqWCIwHajaRcexwIBZd
	0UUy0wgkQvO2CTlbW4IdJdqKXdIARXP6DU+ZbLncRsu+mauymSV3DO/VPZRC/NC0iAw2AG
	VcDc4Q1jzdyOmgs2zuvDwJDnby5Uo9iEcLOZhVFCar1ImBpsQ2mqzpG0qUj69B32171nPH
	O9XL+k4CkNPXiJ1ypPvCIdB7SqIyElnsuQ1mGrLFDbQAK6LN1x8bC2+1EGf9ug==
Message-ID: <c08268bb7ba7e69c5522ee4929f8eab4a99ad3d9.camel@iki.fi>
Subject: Re: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with
 TX timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 09 Mar 2024 14:21:51 +0200
In-Reply-To: <CABBYNZKjiqCP9ZvONLFRS5ni1_Ljhdri76D4FCCXeBSsP=0AUg@mail.gmail.com>
References: 
	<31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
	 <CABBYNZKjiqCP9ZvONLFRS5ni1_Ljhdri76D4FCCXeBSsP=0AUg@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

pe, 2024-03-08 kello 10:12 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Mar 7, 2024 at 4:05=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
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
> > This avoids consuming CPU waking up on timestamps we aren't going to
> > read, and also avoids busy looping if timestamping was left on but
> > errqueue is not flushed.
> >=20
> > Implement this only for io-glib; it is only needed for audio use cases
> > that anyway are using glib.  Uses features from GLib 2.36 (from 2013) s=
o
> > update configure.ac also.
>=20
> Do we really need to enable the TX timestamping on the daemon side
> though? Or that being enabled at pipewire enables it on all fd that
> have been duplicated? I'd assume that was not the case but perhaps the
> kernel code is actually doing TX timestamping regardless if the socket
> had it enabled or not? Btw, I'd consider disabling the POLLERR
> entirely if that happens and just rely on POLLHUP/shutdown to clean
> up, or perhaps we can set up a BPF filter that drops the errqueue
> messages that way we don't have to change anything on how we handle
> POLLERR since that should prevent the daemon to be wakeup.

setsockopt(), and errqueue are socket-level things, so what you do on
one fd handle affects all the others. E.g. getsockopt() in BlueZ sees
any setsockopt() done in Pipewire, similarly for recvmsg() from RX
queue or errqueue, or poll() wakeups on POLLIN / POLLERR / etc.

SO_TIMESTAMPING is only set on Pipewire side, and kernel sends
timestamps only when it is set, but you get all its effects also on the
fd BlueZ has when it's enabled on a fd PW has, since it's the same
socket.

Since errqueue is shared, any packets recv'd from it on BlueZ side, are
not received on Pipewire side.

poll() wakes up with POLLERR when something is in errqueue, see sk-
>sk_error_queue check in bt_sock_poll. This is the same for all of
net/* afaics. The poll() wakeup is again socket-wide.

POLLERR is always enabled in poll() / epoll() / select(), this is set
in fs/eventpoll.c side. AFAIK there's no way to stop waking up on it.

E.g. removing G_IO_ERR from the g_io_add_watch flags=C2=A0results to busy
loop inside GLib if something is left in the errqueue.

The net/* TX timestamping design is also such that after turning off
SO_TIMESTAMPING on a socket, it will still send TX timestamps for any
packets queued before the setsockopt().

These things seem to be design decisions in the net/* TX timestamping.

***

Re BPF: it looks hard, we'd have to make epoll() wait differently for
different fds. I'm not sure if fs/eventpoll.c has necessary BPF hooks?

I don't think we can drop messages from errqueue, since it'd be socket
level and we'd like some process to read them. It also looks like
sk_filter is not used on the errqueue in net/*

Can it really be done?

***

We probably could however have a custom setsockopt(SOL_BLUETOOTH,
BT_DISABLE_ERRQUEUE_POLL) that optionally disables POLLERR for non-
empty errqueue in bt_sock_poll(), which probably should work.

Then the TX timestamps would be need to be read by periodically waking
up to flush the queue, but that'd be natural to do here since we are
anyway waking up periodically to send packets.

Unless I'm missing something, the viable options are we (i) do that, or
(ii) do like in this patch, or (iii) use ioctl or something instead.

I'd maybe go with the new setsockopt(), if that works?

>=20
> > ---
> >=20
> > Notes:
> >     This was the remaining BlueZ part of the TX timestamping additions.
> >     Couldn't find a better way to do it, but it has to be done, so that=
 the
> >     TX timestamping can be used for the purpose it would be added.
> >=20
> >     I'll probably send v2 for the others in a few days.
> >=20
> >  acinclude.m4         |   3 +-
> >  configure.ac         |   2 +-
> >  src/shared/io-glib.c | 153 ++++++++++++++++++++++++++++++++++++++++++-
> >  src/shared/io-glib.h |  20 ++++++
> >  4 files changed, 174 insertions(+), 4 deletions(-)
> >  create mode 100644 src/shared/io-glib.h
> >=20
> > diff --git a/acinclude.m4 b/acinclude.m4
> > index 4b73a5bfc..6c36c177e 100644
> > --- a/acinclude.m4
> > +++ b/acinclude.m4
> > @@ -62,8 +62,7 @@ AC_DEFUN([COMPILER_FLAGS], [
> >                 with_cflags=3D"$with_cflags -Wswitch-enum"
> >                 with_cflags=3D"$with_cflags -Wformat -Wformat-security"
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
> > index 9ebc250cf..959a27b4d 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -72,7 +72,7 @@ AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
> >=20
> >  AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhi=
d.h sys/random.h)
> >=20
> > -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
> > +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.36)
> >=20
> >  if (test "${enable_threads}" =3D "yes"); then
> >         AC_DEFINE(NEED_THREADS, 1, [Define if threading support is requ=
ired])
> > diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> > index 754043db1..8b76348dd 100644
> > --- a/src/shared/io-glib.c
> > +++ b/src/shared/io-glib.c
> > @@ -13,10 +13,12 @@
> >  #endif
> >=20
> >  #include <errno.h>
> > +#include <sys/socket.h>
> >=20
> >  #include <glib.h>
> >=20
> >  #include "src/shared/io.h"
> > +#include "src/shared/io-glib.h"
> >=20
> >  struct io_watch {
> >         struct io *io;
> > @@ -29,11 +31,19 @@ struct io_watch {
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
> > @@ -179,10 +189,17 @@ static struct io_watch *watch_new(struct io *io, =
GIOCondition cond,
> >=20
> >         prio =3D cond =3D=3D G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_PRI=
ORITY_DEFAULT;
> >=20
> > -       watch->id =3D g_io_add_watch_full(io->channel, prio,
> > +       if (!io->err_watch)
> > +               watch->id =3D g_io_add_watch_full(io->channel, prio,
> >                                                 cond | G_IO_ERR | G_IO_=
NVAL,
> >                                                 watch_callback, watch,
> >                                                 watch_destroy);
> > +       else
> > +               watch->id =3D io_glib_add_err_watch_full(io->channel, p=
rio,
> > +                                               cond | G_IO_ERR | G_IO_=
NVAL,
> > +                                               watch_callback, watch,
> > +                                               watch_destroy);
> > +
> >         if (watch->id =3D=3D 0) {
> >                 watch_destroy(watch);
> >                 return NULL;
> > @@ -250,6 +267,15 @@ bool io_set_disconnect_handler(struct io *io, io_c=
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
> > @@ -278,3 +304,128 @@ bool io_shutdown(struct io *io)
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
> > +       GIOFunc func =3D (void *)callback;
> > +       gint64 timeout =3D 500 * G_TIME_SPAN_MILLISECOND;
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
> > +        * event. Also disable polling for some time so that we don't b=
usy loop
> > +        * if nobody is reading from the errqueue.
> > +        */
> > +
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
> > +       g_source_set_static_name((void *)watch, "io_glib_err_watch");
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
> > +bool io_set_use_err_watch(struct io *io, bool err_watch);
> > --
> > 2.44.0
> >=20
> >=20
>=20
>=20

