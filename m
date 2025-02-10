Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A62528E4
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200452; cv=none; b=Ql4lS1fsqz+MCKM89fDrkBQO45OMGemdOEGI+TJXuXtb1iXAPscrAi0ktw2dUdTMSQmqD1cv6HG+ZUBOabzwDrXuY8kIcLIzNz/mzTP2hyV1R3DrSaNfJYdfyEYlJTTvI/qTR0fLnck+Dk7RTMwXgvkvF1mCcbBbcutjyog9gC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200452; c=relaxed/simple;
	bh=uI1dddXrntPzYSyvbKeP+7vAOOUO8vOjK8WuIfHuRhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UB5uqlQLSxIiiBhoh1GNntteeXX4qAkrfKLBii9rld3q4Mrzar8T+94G7nvsHA0b9dMXryWfl2JkUbIJmcfcCLqNrEPfWt+KT9qanky0ZtPl5xmHxvXqbhez/X4wSDaDSYlOZgPHSS2/xlhkoLRGgOlHKgxXNFAII07dl6pjQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICq+0D8g; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICq+0D8g"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a04so46066351fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200448; x=1739805248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HOM4fqqCjU59wZsyWcFIFEIerPOKaSL782MNFXQJQ4=;
        b=ICq+0D8gWxHog9ZnADoCvrcPqWzAnDgo60qMRhIcvw3EobODyAWLNKg25arFB3gNMA
         Nt5xWkb7+RQoi11oDCc/wNhBcOnEkIz/qauw6hpMN++EI3HrMgsBjGr21XDTsqNLuLvJ
         K6pXcHylSa0jVwiQJraekRe/CXXuqcnVemYOlXX1vAEa7yKQboXs6vNi7qspqeK1rPv1
         jcWGtOKDlHkMQEOATQaIAIBRhwObIlYzRtK4Mlhk4WuAqrJAG5XHpIpI2aqiGDb1LZpD
         dKftsnikOtLrf6gJUAccfngvljX0+5gYH3s5QbVkjkgd4S5lbqIjSBUlXK+adJc5H4Rv
         j4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200448; x=1739805248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HOM4fqqCjU59wZsyWcFIFEIerPOKaSL782MNFXQJQ4=;
        b=wzUBfOhiScSOyUKM+DcLss1NJTq2SHVjMPPbkKxsOhugnAAy8d/VX+ybODTSE7YCAd
         meW6L2Sq56gZyEvDDidKoKI4Q3IQBfS976Un1WstvEReh9T8FiZpHPGXoMpc26aYWfMv
         BFafCzsatKQLNoljE5HIswPEnhSsyropAtQ0iqgQiSVptO0Gz9zdiNroaOM/tP0E8qiI
         mOhGzP6vSwxkkEw7j7jC+ndnMNkelhkdLgrIZ5SEo/Gw9Nc1/L3g1JCnnIc4aFD6SXZ1
         dBoyaOwPCHNv2k64N0TzWDwx7pM1l6YH2m8MZo4IE2oSP1gVN3nkgLwlsVWw+5Kss+ef
         GJWA==
X-Gm-Message-State: AOJu0Ywq+imK6bRN6Dc6l2ORkJmjx82O3AoujsFrcpeeGm3XMZMLg3Zx
	mkThPFSZ16VCMAgB9ZIyzGh8fllKqLtjhEvnhlyXXTHePbWfYD3bVmIy9NNTdFNI11T0EvyAxxz
	O9crg5Ah8lAIpjIOYgzsoJqwTF3gZJcUtnFc=
X-Gm-Gg: ASbGncsfzkwOinPcYuXx+mgstjfaF1AwoWlmk4LFlu00vWgIT2XDdkXacVdhv+bxmP9
	UGjkAhSpnOf8Kkwte4X8o4s045yxLnJ9llyi8+G6hKqwj+fOHb22QxxyJw4iEL+jG3GbQ0Df3CA
	==
X-Google-Smtp-Source: AGHT+IEmqiBB+wjOpcF/ZpNpH2xxf3KhIuTsrKoslOOftpGERhw+R304i87k8xaV+kO+X5TeTc66KZuNlUY9nRJkXhw=
X-Received: by 2002:a05:651c:220a:b0:308:f455:1f93 with SMTP id
 38308e7fff4ca-308f455212amr8028511fa.27.1739200447575; Mon, 10 Feb 2025
 07:14:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739097949.git.pav@iki.fi> <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
In-Reply-To: <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 10 Feb 2025 10:13:55 -0500
X-Gm-Features: AWEUYZmFxQBfMOEvEETZIqs7F1TGTZZW39SrPETdc6QgTIJ9RHdTAY9CAT_XSFs
Message-ID: <CABBYNZJccrs7n4mK1YYF+SyKG46d2mkmcem_Ayg77nm3FtJ93w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Feb 9, 2025 at 5:46=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add special implementation of fd watcher GSource for audio use.
>
> For audio use cases, sound server may turn on TX timestamping on a
> socket that we are watching.  In this case, we shall not consider the TX
> timestamping POLLERR as a socket error condition, nor read the TX
> timestamps.
>
> When TX timestamps appear in errqueue, switch from fd poll wait to
> polling the fd at regular intervals.  This is because unread errqueue
> causes poll() to wake up immediately, so the mainloop cannot block on
> that, and we have to use a timer instead with some reasonable timeout
> for the use case.
>
> This rate limits wakeups on new TX timestamps we aren't going to read,
> and also avoids the busy looping if timestamping was left on but
> errqueue is not flushed.
>
> Implement this only for io-glib; it is only needed for audio use cases
> that anyway are using glib.  Uses features from GLib 2.36 (from 2013) so
> update configure.ac also.
> ---
>  Makefile.am          |   1 +
>  acinclude.m4         |   3 +-
>  configure.ac         |   2 +-
>  src/shared/io-glib.c | 157 ++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/io-glib.h |  20 ++++++
>  5 files changed, 179 insertions(+), 4 deletions(-)
>  create mode 100644 src/shared/io-glib.h
>
> diff --git a/Makefile.am b/Makefile.am
> index 0821530e6..f958e2b99 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -253,6 +253,7 @@ shared_sources +=3D src/shared/shell.c src/shared/she=
ll.h
>  endif
>
>  src_libshared_glib_la_SOURCES =3D $(shared_sources) \
> +                               src/shared/io-glib.h \
>                                 src/shared/io-glib.c \
>                                 src/shared/timeout-glib.c \
>                                 src/shared/mainloop-glib.c \
> diff --git a/acinclude.m4 b/acinclude.m4
> index 168117840..598986d6e 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -63,8 +63,7 @@ AC_DEFUN([COMPILER_FLAGS], [
>                 with_cflags=3D"$with_cflags -Wformat -Wformat-security"
>                 with_cflags=3D"$with_cflags -Wstringop-overflow"
>                 with_cflags=3D"$with_cflags -DG_DISABLE_DEPRECATED"
> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_28"
> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=3D=
GLIB_VERSION_2_32"
> +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_36"
>         fi
>         AC_SUBST([WARNING_CFLAGS], $with_cflags)
>  ])
> diff --git a/configure.ac b/configure.ac
> index 75841e4c9..d2b0bab2f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -81,7 +81,7 @@ AC_CHECK_DECLS([basename], [],
>                                  ])
>
>
> -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
> +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.36)

I hope this doesn't come with other surprises though, afaik glib had
the bad habit of adding its own set of dependencies which made us
stick to such old versions.

>
>  if (test "${enable_threads}" =3D "yes"); then
>         AC_DEFINE(NEED_THREADS, 1, [Define if threading support is requir=
ed])
> diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> index 754043db1..bea9b2c32 100644
> --- a/src/shared/io-glib.c
> +++ b/src/shared/io-glib.c
> @@ -13,10 +13,14 @@
>  #endif
>
>  #include <errno.h>
> +#include <sys/socket.h>
>
>  #include <glib.h>
>
>  #include "src/shared/io.h"
> +#include "src/shared/io-glib.h"
> +
> +#define        IO_ERR_WATCH_RATELIMIT          (500 * G_TIME_SPAN_MILLIS=
ECOND)
>
>  struct io_watch {
>         struct io *io;
> @@ -29,11 +33,19 @@ struct io_watch {
>  struct io {
>         int ref_count;
>         GIOChannel *channel;
> +       bool err_watch;
>         struct io_watch *read_watch;
>         struct io_watch *write_watch;
>         struct io_watch *disconnect_watch;
>  };
>
> +struct io_err_watch {
> +       GSource                 source;
> +       GIOChannel              *io;
> +       GIOCondition            events;
> +       gpointer                tag;
> +};
> +
>  static struct io *io_ref(struct io *io)
>  {
>         if (!io)
> @@ -179,10 +191,17 @@ static struct io_watch *watch_new(struct io *io, GI=
OCondition cond,
>
>         prio =3D cond =3D=3D G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_PRIOR=
ITY_DEFAULT;
>
> -       watch->id =3D g_io_add_watch_full(io->channel, prio,
> +       if (!io->err_watch)
> +               watch->id =3D g_io_add_watch_full(io->channel, prio,
> +                                               cond | G_IO_ERR | G_IO_NV=
AL,
> +                                               watch_callback, watch,
> +                                               watch_destroy);
> +       else
> +               watch->id =3D io_glib_add_err_watch_full(io->channel, pri=
o,
>                                                 cond | G_IO_ERR | G_IO_NV=
AL,
>                                                 watch_callback, watch,
>                                                 watch_destroy);
> +
>         if (watch->id =3D=3D 0) {
>                 watch_destroy(watch);
>                 return NULL;
> @@ -250,6 +269,15 @@ bool io_set_disconnect_handler(struct io *io, io_cal=
lback_func_t callback,
>         return io_set_handler(io, G_IO_HUP, callback, user_data, destroy)=
;
>  }
>
> +bool io_set_use_err_watch(struct io *io, bool err_watch)
> +{
> +       if (!io)
> +               return false;
> +
> +       io->err_watch =3D err_watch;
> +       return true;
> +}
> +
>  ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
>  {
>         int fd;
> @@ -278,3 +306,130 @@ bool io_shutdown(struct io *io)
>         return g_io_channel_shutdown(io->channel, TRUE, NULL)
>                                                         =3D=3D G_IO_STATU=
S_NORMAL;
>  }
> +
> +/*
> + * GSource implementation that tolerates non-empty MSG_ERRQUEUE, without
> + * attempting to flush it. This is intended for use with TX timestamping=
 in
> + * cases where someone else is reading the timestamps and we are only in=
terested
> + * in POLLHUP or socket errors.
> + */
> +
> +static gint64 io_err_watch_wakeup;
> +
> +static gboolean io_err_watch_dispatch(GSource *source,
> +                               GSourceFunc callback, gpointer user_data)
> +{
> +       struct io_err_watch *watch =3D (void *)source;
> +       const GIOFunc func =3D (void *)callback;
> +       const gint64 timeout =3D IO_ERR_WATCH_RATELIMIT;
> +       GIOCondition cond;
> +       int fd;
> +
> +       if (!func)
> +               return FALSE;
> +
> +       fd =3D g_io_channel_unix_get_fd(watch->io);
> +
> +       /*
> +        * If woken up by POLLERR only, and SO_ERROR is not set, ignore t=
his
> +        * event. Also disable polling for some time so that we don't con=
sume
> +        * too much CPU on events we are not interested in, or busy loop =
if
> +        * nobody is flushing the errqueue.
> +        */

Not sure if I asked about this before, but have you consider disabling
POLLERR completely in case we detect the errqueue is in use? Because
even with rate limit I think we may still impact the system, the only
problem is then if by disabling POLLERR we would get in trouble
detecting disconnections? It shall result in POLLHUP though, so if we
only care about it for disconnection I assume it would be sufficient.

> +       if (watch->tag)
> +               cond =3D g_source_query_unix_fd(&watch->source, watch->ta=
g);
> +       else
> +               cond =3D 0;
> +
> +       if (cond =3D=3D G_IO_ERR) {
> +               int err, ret;
> +               socklen_t len =3D sizeof(err);
> +
> +               ret =3D getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &len);
> +               if (ret =3D=3D 0 && err =3D=3D 0) {
> +                       g_source_remove_unix_fd(&watch->source, watch->ta=
g);
> +                       watch->tag =3D NULL;
> +
> +                       /* io_err watches all wake up at the same time */
> +                       if (!io_err_watch_wakeup)
> +                               io_err_watch_wakeup =3D g_get_monotonic_t=
ime()
> +                                                               + timeout=
;
> +
> +                       g_source_set_ready_time(&watch->source,
> +                                                       io_err_watch_wake=
up);
> +                       return TRUE;
> +               }
> +       }
> +
> +       if (g_source_get_ready_time(&watch->source) !=3D -1) {
> +               g_assert(!watch->tag);
> +               io_err_watch_wakeup =3D 0;
> +               watch->tag =3D g_source_add_unix_fd(&watch->source, fd,
> +                                                       watch->events);
> +               g_source_set_ready_time(&watch->source, -1);
> +       }
> +
> +       cond &=3D watch->events;
> +
> +       if (cond)
> +               return func(watch->io, cond, user_data);
> +       else
> +               return TRUE;
> +}
> +
> +static void io_err_watch_finalize(GSource *source)
> +{
> +       struct io_err_watch *watch =3D (void *)source;
> +
> +       if (watch->tag)
> +               g_source_remove_unix_fd(&watch->source, watch->tag);
> +
> +       g_io_channel_unref(watch->io);
> +}
> +
> +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> +                                       GIOCondition events,
> +                                       GIOFunc func, gpointer user_data,
> +                                       GDestroyNotify notify)
> +{
> +       static GSourceFuncs source_funcs =3D {
> +               .dispatch =3D io_err_watch_dispatch,
> +               .finalize =3D io_err_watch_finalize,
> +       };
> +       GSourceFunc callback =3D (void *)func;
> +       struct io_err_watch *watch;
> +       gint fd;
> +       guint id;
> +
> +       g_return_val_if_fail(!(events & (G_IO_IN | G_IO_OUT)), 0);
> +       g_return_val_if_fail(events, 0);
> +       g_return_val_if_fail(func, 0);
> +
> +       fd =3D g_io_channel_unix_get_fd(io);
> +
> +       watch =3D (void *)g_source_new(&source_funcs,
> +                                       sizeof(struct io_err_watch));
> +
> +       watch->io =3D g_io_channel_ref(io);
> +       watch->events =3D events;
> +       watch->tag =3D g_source_add_unix_fd(&watch->source, fd, events);
> +
> +       g_source_set_name((void *)watch, "io_glib_err_watch");
> +       g_source_set_callback(&watch->source, callback, user_data, notify=
);
> +
> +       if (priority !=3D G_PRIORITY_DEFAULT)
> +               g_source_set_priority(&watch->source, priority);
> +
> +       id =3D g_source_attach(&watch->source, NULL);
> +       g_source_unref(&watch->source);
> +
> +       return id;
> +}
> +
> +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events, GIOFunc=
 func,
> +                                                       gpointer user_dat=
a)
> +{
> +       return io_glib_add_err_watch_full(io, G_PRIORITY_DEFAULT, events,
> +                                                       func, user_data, =
NULL);
> +}
> diff --git a/src/shared/io-glib.h b/src/shared/io-glib.h
> new file mode 100644
> index 000000000..1db6fd468
> --- /dev/null
> +++ b/src/shared/io-glib.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
> + *
> + *
> + */
> +
> +#include <glib.h>
> +
> +guint io_glib_add_err_watch(GIOChannel *io, GIOCondition events,
> +                               GIOFunc func, gpointer user_data);
> +guint io_glib_add_err_watch_full(GIOChannel *io, gint priority,
> +                               GIOCondition events, GIOFunc func,
> +                               gpointer user_data,
> +                               GDestroyNotify notify);
> +

Hmm, I think it is probably not a good idea to start using headers
like this, I'd consider just making it return 0 for non-glib.

> +bool io_set_use_err_watch(struct io *io, bool err_watch);
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
