Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398364A32
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910742; cv=none; b=XkIyiLbTIJqkb+cm/RPcPqB+6SBHrBSfTPpyhzsFKK5AUidiK0NjiK9cYRXxLaCiBuTnWsJx+zWKeYZehhQXXg2Uq1MDQDUQw1kInvBZ1JolnTM2dwenUJl/Ve8BdTQV0WjjyB8znJ4WlkjlzHmj6PP4CKeI/M++kOg9V8hoklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910742; c=relaxed/simple;
	bh=g3fmYQksCs73RjkP4gtT5MJh6zioexlLuvNZtlFi90U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CX3DltXHbL4vs3j6T/hikGmGt5i8pNdYMupkeb24trTa5ae5ufYZCt9zluxVgD8JLdkz7n+JYLVsBJ9d843pA6BlGJNpYcuaM9yd/mK0awNN1NUCgtE5rTxFcNaDDFrSnT9kYotEE6ryAUhKQZKqbLsgKpcEwZSgL+ErPXhBzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcuFNTEv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcuFNTEv"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d2505352e6so29673191fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709910738; x=1710515538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msHiviXJG9rjegsNwvqJgm9WhCXX1asQQEsD+UqZ9/U=;
        b=PcuFNTEvuXqShALes46FjcrRsgoxS3AOJgyPD+28prkU45RRQfUOJLjluMkEj+79bX
         xHZNLv3fSmOzNdXuRAGfFt0z7GbpvtGDe0eqk7+rrxj2YHYNX9joqKYdiqgib1Y3DFSo
         bG+Q3l6jaGRQtKEujud5MC3WfCe6bwJzvznq2u843LdgRI4bu2CNQ5rhGMgDdwWYX4YT
         ock/1r06HEI/wkIA4Rz8PjJGFTKjmbImX6/ttKIpY9E+Kl60rK1CnuZP7O1A9aTG6gFZ
         aoKIyyVCOBc09DNnwnBqxxaCBKqQ1hyWjWDmKwmD8URu1yP9wFvXla6jaNJIOxExiYMF
         /IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709910738; x=1710515538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msHiviXJG9rjegsNwvqJgm9WhCXX1asQQEsD+UqZ9/U=;
        b=D7jjCIqGpcNMnx6/PgTROglL0wPs6FTILnxlomInbTqsfeCNzL8wgU5/1Q52Jx5m1I
         tdHro6yHSinHtN9cY8N5tf/G+VceKUsg4qvBAoBpx1pDD9epDONAn5XKap75tug6j0j6
         J/U13SOGJC7W4sHPwHeZbjZrTr07T7PW/5HIOg4EVs20O9r6uAAkHmFwyb4OSTQNvycX
         R+248l6tGq+O1Z4ghlxZsZ/2j0GoZkqlgIODgVAePCxuAQYeiIxje5Ya6E3N3YICpWWL
         WJefKUU3/9ms1bm8gh8ao5rYgW4bcyBCKugONuoe6H5fdel/FDi3v9bK7tPQOKhsK9AD
         slEA==
X-Gm-Message-State: AOJu0YwjPEpPh1ByKliC76UwC3rKzntRtS+UxT02tyLssepGY2hQjvmI
	0MJy2V8Rumq2cK5Jzf3U+hfSo068lmk/yJgFr5bwB0M0PsEzpq5iu1oXKhvZHxUQURbvTjW9LWw
	xRMF9vWwaBuv3wrpT8fk6DChbltY=
X-Google-Smtp-Source: AGHT+IGApeQfUMT9oupNaBlsKpOWtrpO6fT0m4REFQX0gKqrdmN+Gn0eVjwt2zsVpOEM7BRoznzQ6hlw3ZMpW9l/a+w=
X-Received: by 2002:a2e:9d86:0:b0:2d2:7a4e:f5ec with SMTP id
 c6-20020a2e9d86000000b002d27a4ef5ecmr3352144ljj.7.1709910738013; Fri, 08 Mar
 2024 07:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
In-Reply-To: <31e0a8235e5c04ad6ae171024e1127c2e7387e28.1709845195.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Mar 2024 10:12:05 -0500
Message-ID: <CABBYNZKjiqCP9ZvONLFRS5ni1_Ljhdri76D4FCCXeBSsP=0AUg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/io-glib: add watcher to be used with TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Mar 7, 2024 at 4:05=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
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
> This avoids consuming CPU waking up on timestamps we aren't going to
> read, and also avoids busy looping if timestamping was left on but
> errqueue is not flushed.
>
> Implement this only for io-glib; it is only needed for audio use cases
> that anyway are using glib.  Uses features from GLib 2.36 (from 2013) so
> update configure.ac also.

Do we really need to enable the TX timestamping on the daemon side
though? Or that being enabled at pipewire enables it on all fd that
have been duplicated? I'd assume that was not the case but perhaps the
kernel code is actually doing TX timestamping regardless if the socket
had it enabled or not? Btw, I'd consider disabling the POLLERR
entirely if that happens and just rely on POLLHUP/shutdown to clean
up, or perhaps we can set up a BPF filter that drops the errqueue
messages that way we don't have to change anything on how we handle
POLLERR since that should prevent the daemon to be wakeup.

> ---
>
> Notes:
>     This was the remaining BlueZ part of the TX timestamping additions.
>     Couldn't find a better way to do it, but it has to be done, so that t=
he
>     TX timestamping can be used for the purpose it would be added.
>
>     I'll probably send v2 for the others in a few days.
>
>  acinclude.m4         |   3 +-
>  configure.ac         |   2 +-
>  src/shared/io-glib.c | 153 ++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/io-glib.h |  20 ++++++
>  4 files changed, 174 insertions(+), 4 deletions(-)
>  create mode 100644 src/shared/io-glib.h
>
> diff --git a/acinclude.m4 b/acinclude.m4
> index 4b73a5bfc..6c36c177e 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -62,8 +62,7 @@ AC_DEFUN([COMPILER_FLAGS], [
>                 with_cflags=3D"$with_cflags -Wswitch-enum"
>                 with_cflags=3D"$with_cflags -Wformat -Wformat-security"
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
> index 9ebc250cf..959a27b4d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -72,7 +72,7 @@ AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
>
>  AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.=
h sys/random.h)
>
> -PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
> +PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.36)
>
>  if (test "${enable_threads}" =3D "yes"); then
>         AC_DEFINE(NEED_THREADS, 1, [Define if threading support is requir=
ed])
> diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> index 754043db1..8b76348dd 100644
> --- a/src/shared/io-glib.c
> +++ b/src/shared/io-glib.c
> @@ -13,10 +13,12 @@
>  #endif
>
>  #include <errno.h>
> +#include <sys/socket.h>
>
>  #include <glib.h>
>
>  #include "src/shared/io.h"
> +#include "src/shared/io-glib.h"
>
>  struct io_watch {
>         struct io *io;
> @@ -29,11 +31,19 @@ struct io_watch {
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
> @@ -179,10 +189,17 @@ static struct io_watch *watch_new(struct io *io, GI=
OCondition cond,
>
>         prio =3D cond =3D=3D G_IO_HUP ? G_PRIORITY_DEFAULT_IDLE : G_PRIOR=
ITY_DEFAULT;
>
> -       watch->id =3D g_io_add_watch_full(io->channel, prio,
> +       if (!io->err_watch)
> +               watch->id =3D g_io_add_watch_full(io->channel, prio,
>                                                 cond | G_IO_ERR | G_IO_NV=
AL,
>                                                 watch_callback, watch,
>                                                 watch_destroy);
> +       else
> +               watch->id =3D io_glib_add_err_watch_full(io->channel, pri=
o,
> +                                               cond | G_IO_ERR | G_IO_NV=
AL,
> +                                               watch_callback, watch,
> +                                               watch_destroy);
> +
>         if (watch->id =3D=3D 0) {
>                 watch_destroy(watch);
>                 return NULL;
> @@ -250,6 +267,15 @@ bool io_set_disconnect_handler(struct io *io, io_cal=
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
> @@ -278,3 +304,128 @@ bool io_shutdown(struct io *io)
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
> +       GIOFunc func =3D (void *)callback;
> +       gint64 timeout =3D 500 * G_TIME_SPAN_MILLISECOND;
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
> +        * event. Also disable polling for some time so that we don't bus=
y loop
> +        * if nobody is reading from the errqueue.
> +        */
> +
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
> +       g_source_set_static_name((void *)watch, "io_glib_err_watch");
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
> +bool io_set_use_err_watch(struct io *io, bool err_watch);
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
