Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC3158862
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212439; cv=none; b=F5wGpd/1LDd4Fka/ezHgyQOKBOl72HbVUDmQLyg6KIBI1mX8mtoVolNRhpo56ggbCcoMCxqnhUcynTc65JfhlNC8ouXHmMM4AWsQJW9mKeo1o+hlJW1meW0vgD0KEU7V/CudFkDfOrSpO1MONebsS5FKojR7hLzezv1eRaKDLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212439; c=relaxed/simple;
	bh=DI8VLJggXrZVj/0npZ/gqkc9v6BEqfa4AkPgFPELpug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlDVhb2O8vG2lMJNKFPyS5a3ehZSvZmSTiqcWngXYw/7VvF/kXZkpYCaAsNUD7t3/40TH0ypDYR+dlDmbiQro+kVMm+SjdEh8d468Ug9tyN29H/qnMS6P79e1JIiXeaCKUtN/wpOuwOXBBMFzBelXIXqMLNj7p4BdBDb8zIVjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBj0GowQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBj0GowQ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613802a6bso51758801fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739212435; x=1739817235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45U1kw6kgh6ok7M3TfJjEYgmJe0YGZWD5j5o9AGhEQg=;
        b=GBj0GowQUahkWYEI3l/d34yJXwgUHTkOpnHYdslatUuS+xbE/j5LPuw5t3pnLbwYpm
         QE1YlbbcXmIZon2OvFfudRRIYUD/92LO+Fm6TvdSOEG8/JTvdu/eUkghC6HH8ZPxukIT
         F+SGLLm5qIGVifpX0/UnY7GPC/pD7nn3Pco42JkDBesiMvFP4jK20HjiH/ZVpWVYkThb
         1GSBtd4bFCaomF07RMhIpHZWSYEcYnM1ozLh/TVYlThomw0BAuw8QOgcBqgmM1aLgNqR
         ToljhU7Ir+BkQO4ZhevUweuEQt9ShodUHJOEh7sQytvjjOKsx3f4gi9QUhCFvwpbHtt7
         hbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212435; x=1739817235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45U1kw6kgh6ok7M3TfJjEYgmJe0YGZWD5j5o9AGhEQg=;
        b=N4U+8NOSukRfCJyMkCJxRongOtuIxNXSmPfS4fq+/afn8UpBfhUMorV/XW6BONEdvq
         g+2vo9Qo/3nkCSNegomlvHq5F12653rJsWppNfsxgzAGI9LfwbbgcRSEr0uT+bnB0R6H
         PQjs5LFhc0x4sgTYuxF+zpdSbRUYWeahyiNEX2mWEkWh8/5g+b6mxhhB7ykRRp4BRedb
         FHTS7ksJVsfcOYkC585kd4okVh/jbuug3pJ1CaYTa2HuQI6cEqKIF0m5AYv2zxyaqE5B
         uzNKpaDCNXeR5KIrZtBZmYFJeb6XAU750Ob8/VQ/mT8NvrhpehmErstBqgZkdfP62BaX
         LkHA==
X-Gm-Message-State: AOJu0YyYyIpQvDx9Sg+9y4llDm4OsjYPm42AJcPFnwvBUTmWiivbqAcG
	NZAa4g8ARW4zKAYcJFltiYLfq68cieqJmAHmDwPC9H1LJeIdKRpKrJfOGRVhdUeMriFTr3Dn/JC
	n2l42pdXj8DfXCv2RMwv8n0czxwhFF2mk
X-Gm-Gg: ASbGncugNPEFshARPKnNvsTfLtLYd5P6WZnJ/lnTym7WPqJm4+rtE04MYskOkeUWrAA
	zWki81/yk8y0H4QMWsiiouJQYlUekj+qBUBfmcruGYuNlV5IQw/Y9j/Ek2LnvXAbO9NE7WCI=
X-Google-Smtp-Source: AGHT+IE/UQhq3z3p0Dwbma09ScZ27K1EtYi0nEiwmIRhIcDjClplXnWEySdNdcvb+JrYCcqcCa7k/NBoeaJURHXqkBk=
X-Received: by 2002:a05:651c:2129:b0:308:f01f:1829 with SMTP id
 38308e7fff4ca-308f01f1f54mr14230051fa.6.1739212434590; Mon, 10 Feb 2025
 10:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739097949.git.pav@iki.fi> <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
 <CABBYNZJccrs7n4mK1YYF+SyKG46d2mkmcem_Ayg77nm3FtJ93w@mail.gmail.com> <102f133fbd176f8c4eacc02d837c1ff075648236.camel@iki.fi>
In-Reply-To: <102f133fbd176f8c4eacc02d837c1ff075648236.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 10 Feb 2025 13:33:41 -0500
X-Gm-Features: AWEUYZn_PWKp9qiaRcpilVtRLNdJckEb4Tw1JDTmXBCi9XiNM6FNlFedc5fN2VM
Message-ID: <CABBYNZ+TVD7a9+OnN5UjsJHOqvurP3rh4LAYr6NuePfpZiq18g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Feb 10, 2025 at 1:15=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2025-02-10 kello 10:13 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sun, Feb 9, 2025 at 5:46=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrot=
e:
> > >
> > > Add special implementation of fd watcher GSource for audio use.
> > >
> > > For audio use cases, sound server may turn on TX timestamping on a
> > > socket that we are watching.  In this case, we shall not consider the=
 TX
> > > timestamping POLLERR as a socket error condition, nor read the TX
> > > timestamps.
> > >
> > > When TX timestamps appear in errqueue, switch from fd poll wait to
> > > polling the fd at regular intervals.  This is because unread errqueue
> > > causes poll() to wake up immediately, so the mainloop cannot block on
> > > that, and we have to use a timer instead with some reasonable timeout
> > > for the use case.
> > >
> > > This rate limits wakeups on new TX timestamps we aren't going to read=
,
> > > and also avoids the busy looping if timestamping was left on but
> > > errqueue is not flushed.
> > >
> > > Implement this only for io-glib; it is only needed for audio use case=
s
> > > that anyway are using glib.  Uses features from GLib 2.36 (from 2013)=
 so
> > > update configure.ac also.
> > > ---
> > >  Makefile.am          |   1 +
> > >  acinclude.m4         |   3 +-
> > >  configure.ac         |   2 +-
> > >  src/shared/io-glib.c | 157 +++++++++++++++++++++++++++++++++++++++++=
+-
> > >  src/shared/io-glib.h |  20 ++++++
> > >  5 files changed, 179 insertions(+), 4 deletions(-)
> > >  create mode 100644 src/shared/io-glib.h
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index 0821530e6..f958e2b99 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -253,6 +253,7 @@ shared_sources +=3D src/shared/shell.c src/shared=
/shell.h
> > >  endif
> > >
> > >  src_libshared_glib_la_SOURCES =3D $(shared_sources) \
> > > +                               src/shared/io-glib.h \
> > >                                 src/shared/io-glib.c \
> > >                                 src/shared/timeout-glib.c \
> > >                                 src/shared/mainloop-glib.c \
> > > diff --git a/acinclude.m4 b/acinclude.m4
> > > index 168117840..598986d6e 100644
> > > --- a/acinclude.m4
> > > +++ b/acinclude.m4
> > > @@ -63,8 +63,7 @@ AC_DEFUN([COMPILER_FLAGS], [
> > >                 with_cflags=3D"$with_cflags -Wformat -Wformat-securit=
y"
> > >                 with_cflags=3D"$with_cflags -Wstringop-overflow"
> > >                 with_cflags=3D"$with_cflags -DG_DISABLE_DEPRECATED"
> > > -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIR=
ED=3DGLIB_VERSION_2_28"
> > > -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWE=
D=3DGLIB_VERSION_2_32"
> > > +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIR=
ED=3DGLIB_VERSION_2_36"
> > >         fi
> > >         AC_SUBST([WARNING_CFLAGS], $with_cflags)
> > >  ])
> > > diff --git a/configure.ac b/configure.ac
> > > index 75841e4c9..d2b0bab2f 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -81,7 +81,7 @@ AC_CHECK_DECLS([basename], [],
> > >                                  ])
> > >
> > >
> > > -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
> > > +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.36)
> >
> > I hope this doesn't come with other surprises though, afaik glib had
> > the bad habit of adding its own set of dependencies which made us
> > stick to such old versions.
>
> Glib 2.36 was released in 2013, I hope all BlueZ builds use something
> newer...
>
> We might want to keep the max version limit in maintainer mode, though,
> to get warnings if using too new API features.
>
> >
> > >
> > >  if (test "${enable_threads}" =3D "yes"); then
> > >         AC_DEFINE(NEED_THREADS, 1, [Define if threading support is re=
quired])
> > > diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> > > index 754043db1..bea9b2c32 100644
> > > --- a/src/shared/io-glib.c
> > > +++ b/src/shared/io-glib.c
> > > @@ -13,10 +13,14 @@
> > >  #endif
> > >
> > >  #include <errno.h>
> > > +#include <sys/socket.h>
> > >
> > >  #include <glib.h>
> > >
> > >  #include "src/shared/io.h"
> > > +#include "src/shared/io-glib.h"
> > > +
> > > +#define        IO_ERR_WATCH_RATELIMIT          (500 * G_TIME_SPAN_MI=
LLISECOND)
> > >
> > >  struct io_watch {
> > >         struct io *io;
> > > @@ -29,11 +33,19 @@ struct io_watch {
> > >  struct io {
> > >         int ref_count;
> > >         GIOChannel *channel;
> > > +       bool err_watch;
> > >         struct io_watch *read_watch;
> > >         struct io_watch *write_watch;
> > >         struct io_watch *disconnect_watch;
> > >  };
> > >
> > > +struct io_err_watch {
> > > +       GSource                 source;
> > > +       GIOChannel              *io;
> > > +       GIOCondition            events;
> > > +       gpointer                tag;
> > > +};
> > > +
> > >  static struct io *io_ref(struct io *io)
> > >  {
> > >         if (!io)
> > > @@ -179,10 +191,17 @@ static struct io_watch *watch_new(struct io *io=
, GIOCondition cond,
> > >
> > >         prio =3D cond =3D=3D G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_P=
RIORITY_DEFAULT;
> > >
> > > -       watch->id =3D g_io_add_watch_full(io->channel, prio,
> > > +       if (!io->err_watch)
> > > +               watch->id =3D g_io_add_watch_full(io->channel, prio,
> > > +                                               cond | G_IO_ERR | G_I=
O_NVAL,
> > > +                                               watch_callback, watch=
,
> > > +                                               watch_destroy);
> > > +       else
> > > +               watch->id =3D io_glib_add_err_watch_full(io->channel,=
 prio,
> > >                                                 cond | G_IO_ERR | G_I=
O_NVAL,
> > >                                                 watch_callback, watch=
,
> > >                                                 watch_destroy);
> > > +
> > >         if (watch->id =3D=3D 0) {
> > >                 watch_destroy(watch);
> > >                 return NULL;
> > > @@ -250,6 +269,15 @@ bool io_set_disconnect_handler(struct io *io, io=
_callback_func_t callback,
> > >         return io_set_handler(io, G_IO_HUP, callback, user_data, dest=
roy);
> > >  }
> > >
> > > +bool io_set_use_err_watch(struct io *io, bool err_watch)
> > > +{
> > > +       if (!io)
> > > +               return false;
> > > +
> > > +       io->err_watch =3D err_watch;
> > > +       return true;
> > > +}
> > > +
> > >  ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
> > >  {
> > >         int fd;
> > > @@ -278,3 +306,130 @@ bool io_shutdown(struct io *io)
> > >         return g_io_channel_shutdown(io->channel, TRUE, NULL)
> > >                                                         =3D=3D G_IO_S=
TATUS_NORMAL;
> > >  }
> > > +
> > > +/*
> > > + * GSource implementation that tolerates non-empty MSG_ERRQUEUE, wit=
hout
> > > + * attempting to flush it. This is intended for use with TX timestam=
ping in
> > > + * cases where someone else is reading the timestamps and we are onl=
y interested
> > > + * in POLLHUP or socket errors.
> > > + */
> > > +
> > > +static gint64 io_err_watch_wakeup;
> > > +
> > > +static gboolean io_err_watch_dispatch(GSource *source,
> > > +                               GSourceFunc callback, gpointer user_d=
ata)
> > > +{
> > > +       struct io_err_watch *watch =3D (void *)source;
> > > +       const GIOFunc func =3D (void *)callback;
> > > +       const gint64 timeout =3D IO_ERR_WATCH_RATELIMIT;
> > > +       GIOCondition cond;
> > > +       int fd;
> > > +
> > > +       if (!func)
> > > +               return FALSE;
> > > +
> > > +       fd =3D g_io_channel_unix_get_fd(watch->io);
> > > +
> > > +       /*
> > > +        * If woken up by POLLERR only, and SO_ERROR is not set, igno=
re this
> > > +        * event. Also disable polling for some time so that we don't=
 consume
> > > +        * too much CPU on events we are not interested in, or busy l=
oop if
> > > +        * nobody is flushing the errqueue.
> > > +        */
> >
> > Not sure if I asked about this before, but have you consider disabling
> > POLLERR completely in case we detect the errqueue is in use? Because
> > even with rate limit I think we may still impact the system, the only
> > problem is then if by disabling POLLERR we would get in trouble
> > detecting disconnections? It shall result in POLLHUP though, so if we
> > only care about it for disconnection I assume it would be sufficient.
>
> It's not possible to disable wakeups on POLLERR & POLLHUP:
>
> https://man.archlinux.org/man/poll.2.en
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/eventpoll.c?h=3Dv6.13&id=3Dffd294d346d185b70e28b1a28abe367bbfe53c04#n2391

Ah, so that means POLLERR and POLLHUP are always enabled together?

> You could use EPOLLET to only wake up once per event -- but bluez would
> then still wakeup on the 7.5ms interval. Glib also doesn't use epoll(),
> so there's more parts of GSource to reimplement, need to poll from
> separate thread etc., so the implementation gets more complex than
> here.
>
> To get something better than the timer-polled version, I think you'd
> need to add some new flag to kernel for this.

Yeah, well I guess that would be even harder if we need to a new flag
since that would mean we would need to update glib to understand it
and then bump the dependency of it, or we would have to reimplement
the whole IO handling to use the non-glib version, the glib way will
most likely make releases adding a hard dependency for distros and
reimplementing the whole IO will probably require a lot of work, that
said Id welcome if we could work in that direction otherwise we need
another way to track the disconnection of ISO and A2DP streams.

> > > +       if (watch->tag)
> > > +               cond =3D g_source_query_unix_fd(&watch->source, watch=
->tag);
> > > +       else
> > > +               cond =3D 0;
> > > +
> > > +       if (cond =3D=3D G_IO_ERR) {
> > > +               int err, ret;
> > > +               socklen_t len =3D sizeof(err);
> > > +
> > > +               ret =3D getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &l=
en);
> > > +               if (ret =3D=3D 0 && err =3D=3D 0) {
> > > +                       g_source_remove_unix_fd(&watch->source, watch=
->tag);
> > > +                       watch->tag =3D NULL;
> > > +
> > > +                       /* io_err watches all wake up at the same tim=
e */
> > > +                       if (!io_err_watch_wakeup)
> > > +                               io_err_watch_wakeup =3D g_get_monoton=
ic_time()
> > > +                                                               + tim=
eout;
> > > +
> > > +                       g_source_set_ready_time(&watch->source,
> > > +                                                       io_err_watch_=
wakeup);
> > > +                       return TRUE;
> > > +               }
> > > +       }
> > > +
> > > +       if (g_source_get_ready_time(&watch->source) !=3D -1) {
> > > +               g_assert(!watch->tag);
> > > +               io_err_watch_wakeup =3D 0;
> > > +               watch->tag =3D g_source_add_unix_fd(&watch->source, f=
d,
> > > +                                                       watch->events=
);
> > > +               g_source_set_ready_time(&watch->source, -1);
> > > +       }
> > > +
> > > +       cond &=3D watch->events;
> > > +
> > > +       if (cond)
> > > +               return func(watch->io, cond, user_data);
> > > +       else
> > > +               return TRUE;
> > > +}
> > > +
> > > +static void io_err_watch_finalize(GSource *source)
> > > +{
> > > +       struct io_err_watch *watch =3D (void *)source;
> > > +
> > > +       if (watch->tag)
> > > +               g_source_remove_unix_fd(&watch->source, watch->tag);
> > > +
> > > +       g_io_channel_unref(watch->io);
> > > +}
> > > +
> > > +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> > > +                                       GIOCondition events,
> > > +                                       GIOFunc func, gpointer user_d=
ata,
> > > +                                       GDestroyNotify notify)
> > > +{
> > > +       static GSourceFuncs source_funcs =3D {
> > > +               .dispatch =3D io_err_watch_dispatch,
> > > +               .finalize =3D io_err_watch_finalize,
> > > +       };
> > > +       GSourceFunc callback =3D (void *)func;
> > > +       struct io_err_watch *watch;
> > > +       gint fd;
> > > +       guint id;
> > > +
> > > +       g_return_val_if_fail(!(events & (G_IO_IN | G_IO_OUT)), 0);
> > > +       g_return_val_if_fail(events, 0);
> > > +       g_return_val_if_fail(func, 0);
> > > +
> > > +       fd =3D g_io_channel_unix_get_fd(io);
> > > +
> > > +       watch =3D (void *)g_source_new(&source_funcs,
> > > +                                       sizeof(struct io_err_watch));
> > > +
> > > +       watch->io =3D g_io_channel_ref(io);
> > > +       watch->events =3D events;
> > > +       watch->tag =3D g_source_add_unix_fd(&watch->source, fd, event=
s);
> > > +
> > > +       g_source_set_name((void *)watch, "io_glib_err_watch");
> > > +       g_source_set_callback(&watch->source, callback, user_data, no=
tify);
> > > +
> > > +       if (priority !=3D G_PRIORITY_DEFAULT)
> > > +               g_source_set_priority(&watch->source, priority);
> > > +
> > > +       id =3D g_source_attach(&watch->source, NULL);
> > > +       g_source_unref(&watch->source);
> > > +
> > > +       return id;
> > > +}
> > > +
> > > +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events, GIO=
Func func,
> > > +                                                       gpointer user=
_data)
> > > +{
> > > +       return io_glib_add_err_watch_full(io, G_PRIORITY_DEFAULT, eve=
nts,
> > > +                                                       func, user_da=
ta, NULL);
> > > +}
> > > diff --git a/src/shared/io-glib.h b/src/shared/io-glib.h
> > > new file mode 100644
> > > index 000000000..1db6fd468
> > > --- /dev/null
> > > +++ b/src/shared/io-glib.h
> > > @@ -0,0 +1,20 @@
> > > +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> > > +/*
> > > + *
> > > + *  BlueZ - Bluetooth protocol stack for Linux
> > > + *
> > > + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
> > > + *
> > > + *
> > > + */
> > > +
> > > +#include <glib.h>
> > > +
> > > +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events,
> > > +                               GIOFunc func, gpointer user_data);
> > > +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> > > +                               GIOCondition events, GIOFunc func,
> > > +                               gpointer user_data,
> > > +                               GDestroyNotify notify);
> > > +
> >
> > Hmm, I think it is probably not a good idea to start using headers
> > like this, I'd consider just making it return 0 for non-glib.
>
> Ok.
>
> > > +bool io_set_use_err_watch(struct io *io, bool err_watch);
> > > --
> > > 2.48.1
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
