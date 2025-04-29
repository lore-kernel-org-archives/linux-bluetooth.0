Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7A253F25
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961145; cv=none; b=W3O4oelpj7+FETJgegMjNpHI2opA3vnooFdanK2i9QTOpYobH/p6a5nwJLlqBNy2DCJ3qKNptb+Qr7G8lezo84D9UnBANYsD2fo5kM/KvZzJ4dhI084gAuyYRm9o0w7rLyIxwiiE+JKe6lE5M+wUr08AULav933h2Ez+2IFF+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961145; c=relaxed/simple;
	bh=tsOUpHJXHa86OBfDqlSvcVGAGPCInF5cA6shv4D7MNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsBoHfVBgACZTfDcd2hfQpT9oJ7oTePU4vduQHuEqKzwQWuqLutBZ2z3k5ZMKDnIvXJaV5+H1go9ffJ+Zgc68eVUthFDrsYPFhVj0ZE8lPmhn0Ch5sFMof/9sFiXsSbZm0AnSpPIXSMGRIzu9mBu5BLk8Er0nPlgr/q5LbxWeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg4xiFxs; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg4xiFxs"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bee278c2aso3177231fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745961141; x=1746565941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BekqeTx3yNEQyrapDAVoU44bCBmr268STbNFx1WfTyw=;
        b=Cg4xiFxs883JiMu0TuXPDGbHVMH8gjNFC9E2eoI+tugualDprSKQSgxTI6zhOdfHhj
         bD3cK4gzUDwI0PhOHmZxMLxVGkooe7ipEheiTjveUSwv/0g17CAU/uEg+oNiwtLoYzNH
         GhVcKqi5qm2iitmNfwmEZdHkllYIMRy1ANmSFvC0KXIugp3QDsgAKIdfrrZbP6aGaeZv
         ErD7zyi6WClBW7RjW4j0ljQM81Tr9R5fXjKqiXTJzMYEVosLnzS+uYXDzrUikz5DJ0Jj
         VyvtjKahOJsb677Gn0YA7FMa25CX6GKn3h1Wm0wjtiKicDWEJW5siNWIoS1oaGgL9gnK
         kAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745961141; x=1746565941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BekqeTx3yNEQyrapDAVoU44bCBmr268STbNFx1WfTyw=;
        b=qLowWDcWKrv5MvicRAi0a6CfmyjKDNlRDKJTgTGcXexR1hrAj4606vfS//Rt3/ITAj
         Fqasenrt+b4l1hAJELWHBf6gtzGWa2he9wR6VTqMHHPQObXOgM2sB367ks/49nSA7rCi
         orBLQqWENLY+T8gjSyPheGyFcwuXfXI9xnSggu+L+gx8ny6RmXjUmaIjd1+CureKHtdp
         +ErQcbk9ONkTl8QYupI1BdNy6nkge5vVI/7TlodRd9gNIulohcWmWeEWo/hN9LjVhTZR
         Fsw6/EmZtNQ6EnqH1GPnIBcOc4C/4R3yOO1nAvYiVJObYWbnyeusnA0RzQscFURn5fQg
         2MXw==
X-Gm-Message-State: AOJu0YzBWcmRd+fZmbnXTUPTutz5hFi164w4ap5XfQCTg7VtnoEafpsd
	qJRlbZiWQbrW954Nmsk+2DEUHmYov9IcDkrIisGFCF8KoCks4akTopuPYGwg4PPdCkvIcOjDMdf
	PYwcJaGp3fUv3FCm/wm0a/7oj9s7I5Jw5
X-Gm-Gg: ASbGnctL5UWqcSw9S8T4yuoNnvC8Fcfk3gbFHQo0fFS9HJU0S2wDdM4Fk05Xr28Y1fE
	VQE+L4OSLe54hH1UXUSimLQyMzbYO8XlH6K3KdUDqpU++BhaGG4rz45vKPEGD6CXRaqivvixuLo
	/R+KT8yczr4S+Sr4S/v597
X-Google-Smtp-Source: AGHT+IF896iQhyse/q8R603w0EEh56ZVLo+uvrAGu4hym0vL7XMcWBzgBrm1DsdIxxU/4RBOhKNDQ6YIR0eA2LitQaA=
X-Received: by 2002:a2e:bccd:0:b0:30d:6a77:c498 with SMTP id
 38308e7fff4ca-31e7cc04951mr1186031fa.4.1745961140892; Tue, 29 Apr 2025
 14:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429141533.803295-1-kernel.org@pileofstuff.org>
 <20250429141533.803295-5-kernel.org@pileofstuff.org> <CABBYNZ+_8LkqmOTsZW3S9-QO3kv=cfrXz0TpwsH8vK6aOQ27ug@mail.gmail.com>
 <aBEmaj4SJimd8iDL@andrews-2024-laptop.sayers>
In-Reply-To: <aBEmaj4SJimd8iDL@andrews-2024-laptop.sayers>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Apr 2025 17:12:08 -0400
X-Gm-Features: ATxdqUFNnAaaDbmh4M1oYS1KeFUrDAVNu02erdD6DuoOdGGY0CaD7aYw5FdI7A8
Message-ID: <CABBYNZ+=pEWZgd-CSyj0gRBP0O9MdY21X+--t0L0Xa+9P15oYw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 4/6] obexd: Unregister profiles when the user is inactive
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Apr 29, 2025 at 3:20=E2=80=AFPM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> On Tue, Apr 29, 2025 at 01:25:26PM -0400, Luiz Augusto von Dentz wrote:
> > Hi Andrew,
> >
> > On Tue, Apr 29, 2025 at 10:15=E2=80=AFAM Andrew Sayers
> > <kernel.org@pileofstuff.org> wrote:
> > >
> > > Obexd is usually run as a user service, and can exhibit surprising
> > > behaviour if two users are logged in at the same time.
> > >
> > > Unregister profiles when the user is detected to be off-seat.
> > >
> > > It may be impossible to detect whether a user is on-seat in some case=
s.
> > > For example, a version of obexd compiled with systemd support might b=
e
> > > run outside of a systemd environment.  Warn and leave services
> > > registered if that happens.
> > >
> > > Obexd can be run as a system service, in which case this check makes =
no
> > > sense.  Disable this check when called with `--system-bus`.
> > >
> > > Obexd can also be run by a user that does not have an active session.
> > > For example, someone could use `ssh` to access the system.  There mig=
ht
> > > be a use case where someone needs Bluetooth access but can't log in w=
ith
> > > a keyboard, or there might be a security issue with doing so.  This i=
sn't
> > > handled explicitly by this patch, but a future patch could add suppor=
t
> > > by calling `logind_set(FALSE)` in the same way as is currently done
> > > with `--system-bus`.
> > >
> > > Unregister profiles by closing private connections instead of sending
> > > UnregisterProfile on the shared connection.  Pipewire has apparently
> > > found the latter to cause long shutdown delays, because bluetoothd
> > > may be shutting down and unable to handle this message.
> > >
> > > Based in large part on the wireplumber code mentioned by Pauli Virtan=
en:
> > > https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/mod=
ules/module-logind.c#L52
> > >
> > > Other services are likely to need similar functionality,
> > > so I have created a gist to demonstrate the basic technique:
> > > https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1=
e
> > >
> > > Suggested-by: Pauli Virtanen <pav@iki.fi>
> > > Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> > > ---
> > >  Makefile.obexd            |  10 ++
> > >  obexd/client/pbap.c       |  17 ++-
> > >  obexd/plugins/bluetooth.c |  14 ++-
> > >  obexd/src/logind.c        | 239 ++++++++++++++++++++++++++++++++++++=
++
> > >  obexd/src/logind.h        |  26 +++++
> > >  obexd/src/main.c          |   4 +
> > >  6 files changed, 305 insertions(+), 5 deletions(-)
> > >  create mode 100644 obexd/src/logind.c
> > >  create mode 100644 obexd/src/logind.h
> > >
> > > diff --git a/Makefile.obexd b/Makefile.obexd
> > > index 74dd977a0..b59cfaf8f 100644
> > > --- a/Makefile.obexd
> > > +++ b/Makefile.obexd
> > > @@ -67,6 +67,7 @@ obexd_src_obexd_SOURCES =3D $(btio_sources) $(gobex=
_sources) \
> > >                         obexd/src/main.c obexd/src/obexd.h \
> > >                         obexd/src/plugin.h obexd/src/plugin.c \
> > >                         obexd/src/log.h obexd/src/log.c \
> > > +                       obexd/src/logind.h obexd/src/logind.c \
> > >                         obexd/src/manager.h obexd/src/manager.c \
> > >                         obexd/src/obex.h obexd/src/obex.c obexd/src/o=
bex-priv.h \
> > >                         obexd/src/mimetype.h obexd/src/mimetype.c \
> > > @@ -96,6 +97,8 @@ obexd_src_obexd_LDADD =3D lib/libbluetooth-internal=
.la \
> > >
> > >  if EXTERNAL_PLUGINS
> > >  obexd_src_obexd_LDFLAGS =3D $(AM_LDFLAGS) -Wl,--export-dynamic
> > > +else
> > > +obexd_src_obexd_LDFLAGS =3D
> > >  endif
> > >
> > >  obexd_src_obexd_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CF=
LAGS) \
> > > @@ -109,6 +112,13 @@ obexd-add-service-symlink:
> > >  obexd-remove-service-symlink:
> > >  endif
> > >
> > > +if OBEX
> > > +if SYSTEMD
> > > +obexd_src_obexd_CPPFLAGS +=3D -DSYSTEMD
> > > +obexd_src_obexd_LDFLAGS +=3D -lsystemd
> > > +endif
> > > +endif
> > > +
> > >  obexd_src_obexd_SHORTNAME =3D obexd
> > >
> > >  obexd_builtin_files =3D obexd/src/builtin.h $(obexd_builtin_nodist)
> > > diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> > > index 90f8bdc02..51b523592 100644
> > > --- a/obexd/client/pbap.c
> > > +++ b/obexd/client/pbap.c
> > > @@ -27,6 +27,7 @@
> > >  #include "gdbus/gdbus.h"
> > >
> > >  #include "obexd/src/log.h"
> > > +#include "obexd/src/logind.h"
> > >  #include "obexd/src/obexd.h"
> > >
> > >  #include "transfer.h"
> > > @@ -1454,13 +1455,13 @@ static struct obc_driver pbap =3D {
> > >         .remove =3D pbap_remove
> > >  };
> > >
> > > -int pbap_init(void)
> > > +static int pbap_init_cb(void)
> > >  {
> > >         int err;
> > >
> > >         DBG("");
> > >
> > > -       conn =3D obex_get_dbus_connection();
> > > +       conn =3D obex_setup_dbus_connection_private(NULL, NULL);
> > >         if (!conn)
> > >                 return -EIO;
> > >
> > > @@ -1481,7 +1482,7 @@ int pbap_init(void)
> > >         return 0;
> > >  }
> > >
> > > -void pbap_exit(void)
> > > +static void pbap_exit_cb(void)
> > >  {
> > >         DBG("");
> > >
> > > @@ -1496,9 +1497,19 @@ void pbap_exit(void)
> > >         }
> > >
> > >         if (conn) {
> > > +               dbus_connection_close(conn);
> > >                 dbus_connection_unref(conn);
> > >                 conn =3D NULL;
> > >         }
> > >
> > >         obc_driver_unregister(&pbap);
> > >  }
> > > +
> > > +int pbap_init(void)
> > > +{
> > > +       return logind_register(pbap_init_cb, pbap_exit_cb);
> > > +}
> > > +void pbap_exit(void)
> > > +{
> > > +       return logind_unregister(pbap_init_cb, pbap_exit_cb);
> > > +}
> > > diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> > > index 8cf718922..7ff27a8a8 100644
> > > --- a/obexd/plugins/bluetooth.c
> > > +++ b/obexd/plugins/bluetooth.c
> > > @@ -35,6 +35,7 @@
> > >  #include "obexd/src/transport.h"
> > >  #include "obexd/src/service.h"
> > >  #include "obexd/src/log.h"
> > > +#include "obexd/src/logind.h"
> > >
> > >  #define BT_RX_MTU 32767
> > >  #define BT_TX_MTU 32767
> > > @@ -426,7 +427,7 @@ static const struct obex_transport_driver driver =
=3D {
> > >
> > >  static unsigned int listener_id =3D 0;
> > >
> > > -static int bluetooth_init(void)
> > > +static int bluetooth_init_cb(void)
> > >  {
> > >         connection =3D g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NU=
LL);
> > >         if (connection =3D=3D NULL)
> > > @@ -438,7 +439,7 @@ static int bluetooth_init(void)
> > >         return obex_transport_driver_register(&driver);
> > >  }
> > >
> > > -static void bluetooth_exit(void)
> > > +static void bluetooth_exit_cb(void)
> > >  {
> > >         GSList *l;
> > >
> > > @@ -462,4 +463,13 @@ static void bluetooth_exit(void)
> > >         obex_transport_driver_unregister(&driver);
> > >  }
> > >
> > > +static int bluetooth_init(void)
> > > +{
> > > +       return logind_register(bluetooth_init_cb, bluetooth_exit_cb);
> > > +}
> > > +static void bluetooth_exit(void)
> > > +{
> > > +       return logind_unregister(bluetooth_init_cb, bluetooth_exit_cb=
);
> > > +}
> > > +
> > >  OBEX_PLUGIN_DEFINE(bluetooth, bluetooth_init, bluetooth_exit)
> > > diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> > > new file mode 100644
> > > index 000000000..ff2bf3219
> > > --- /dev/null
> > > +++ b/obexd/src/logind.c
> > > @@ -0,0 +1,239 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + *
> > > + *  Enable functionality only when the user is active
> > > + *
> > > + *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
> > > + *
> > > + *
> > > + */
> > > +
> > > +#ifdef SYSTEMD
> > > +
> > > +#include <assert.h>
> > > +#include <errno.h>
> > > +#include <poll.h>
> > > +#include <stddef.h>
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <time.h>
> > > +#include <unistd.h>
> > > +#include <glib.h>
> > > +
> > > +#include <systemd/sd-login.h>
> > > +
> > > +#include "obexd/src/log.h"
> > > +#include "obexd/src/logind.h"
> > > +
> > > +static sd_login_monitor * monitor;
> > > +static int uid;
> > > +static gboolean active =3D FALSE;
> > > +static gboolean monitoring_enabled =3D TRUE;
> > > +static guint event_source;
> > > +
> > > +struct callback_pair {
> > > +       logind_init_cb init_cb;
> > > +       logind_exit_cb exit_cb;
> > > +};
> > > +
> > > +GSList *callbacks;
> > > +
> > > +static void call_init_cb(gpointer data, gpointer user_data)
> > > +{
> > > +       int res;
> > > +
> > > +       res =3D ((struct callback_pair *)data)->init_cb();
> > > +       if (res)
> > > +               *(int *)user_data =3D res;
> > > +}
> > > +static void call_exit_cb(gpointer data, gpointer user_data)
> > > +{
> > > +       ((struct callback_pair *)data)->exit_cb();
> > > +}
> > > +
> > > +static int update(void)
> > > +{
> > > +       char *state =3D NULL;
> > > +       gboolean state_is_active;
> > > +       int res;
> > > +
> > > +       res =3D sd_login_monitor_flush(monitor);
> > > +       if (res < 0)
> > > +               return res;
> > > +       res =3D sd_uid_get_state(uid, &state);
> > > +       state_is_active =3D g_strcmp0(state, "active");
> > > +       free(state);
> > > +       if (res < 0)
> > > +               return res;
> > > +
> > > +       if (state_is_active) {
> > > +               if (!active)
> > > +                       return 0;
> > > +       } else {
> > > +               res =3D sd_uid_get_seats(uid, 1, NULL);
> > > +               if (res < 0)
> > > +                       return res;
> > > +               if (active =3D=3D !!res)
> > > +                       return 0;
> > > +       }
> > > +       active ^=3D TRUE;
> > > +       res =3D 0;
> > > +       g_slist_foreach(callbacks, active ? call_init_cb : call_exit_=
cb, &res);
> > > +       return res;
> > > +}
> > > +
> > > +static int check_event(void)
> > > +{
> > > +       int res;
> > > +
> > > +       res =3D sd_login_monitor_flush(monitor);
> > > +       if (res < 0)
> > > +               return res;
> > > +       if (!monitoring_enabled)
> > > +               return 0;
> > > +       res =3D update();
> > > +       if (res < 0)
> > > +               return res;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +
> > > +static gboolean event_handler(GIOChannel *source, GIOCondition condi=
tion,
> > > +                               gpointer data)
> > > +{
> > > +       int res;
> > > +
> > > +       res =3D check_event();
> > > +       if (res) {
> > > +               error("%s: %s", __func__, strerror(-res));
> > > +               return FALSE;
> > > +       }
> > > +
> > > +       return TRUE;
> > > +}
> > > +
> > > +static int logind_init(void)
> > > +{
> > > +       GIOChannel *channel;
> > > +       int events;
> > > +       int fd;
> > > +       int res;
> > > +
> > > +       monitor =3D NULL;
> > > +
> > > +       DBG("");
> > > +
> > > +       if (!monitoring_enabled)
> > > +               return 0;
> > > +
> > > +       uid =3D getuid();
> > > +
> > > +       res =3D sd_login_monitor_new("uid", &monitor);
> > > +       if (res < 0) {
> > > +               monitor =3D NULL;
> > > +               goto FAIL;
> > > +       }
> > > +
> > > +       // Check this after creating the monitor, in case of race con=
ditions:
> > > +       res =3D update();
> > > +       if (res < 0)
> > > +               goto FAIL;
> > > +
> > > +       events =3D res =3D sd_login_monitor_get_events(monitor);
> > > +       if (res < 0)
> > > +               goto FAIL;
> > > +
> > > +       fd =3D res =3D sd_login_monitor_get_fd(monitor);
> > > +       if (res < 0)
> > > +               goto FAIL;
> > > +
> > > +       channel =3D g_io_channel_unix_new(fd);
> > > +
> > > +       g_io_channel_set_close_on_unref(channel, TRUE);
> > > +       g_io_channel_set_encoding(channel, NULL, NULL);
> > > +       g_io_channel_set_buffered(channel, FALSE);
> > > +
> > > +       event_source =3D g_io_add_watch(channel, events, event_handle=
r, NULL);
> > > +
> > > +       g_io_channel_unref(channel);
> > > +
> > > +       return check_event();
> > > +
> > > +FAIL:
> > > +       sd_login_monitor_unref(monitor);
> > > +       monitoring_enabled =3D FALSE;
> > > +       active =3D TRUE;
> > > +       return res;
> > > +}
> > > +
> > > +static void logind_exit(void)
> > > +{
> > > +       if (event_source) {
> > > +               g_source_remove(event_source);
> > > +               event_source =3D 0;
> > > +       }
> > > +       sd_login_monitor_unref(monitor);
> > > +}
> > > +
> > > +static gint find_cb(gconstpointer a, gconstpointer b)
> > > +{
> > > +       return ((struct callback_pair *)a)->init_cb - (logind_init_cb=
)b;
> > > +}
> > > +
> > > +int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
> > > +{
> > > +       struct callback_pair *cbs;
> > > +
> > > +       if (!monitoring_enabled)
> > > +               return init_cb();
> > > +       if (callbacks =3D=3D NULL) {
> > > +               int res;
> > > +
> > > +               res =3D logind_init();
> > > +               if (res) {
> > > +                       error("logind_init(): %s - login detection di=
sabled",
> > > +                               strerror(-res));
> > > +                       return init_cb();
> > > +               }
> > > +       }
> > > +       cbs =3D g_new(struct callback_pair, 1);
> > > +       cbs->init_cb =3D init_cb;
> > > +       cbs->exit_cb =3D exit_cb;
> > > +       callbacks =3D g_slist_prepend(callbacks, cbs);
> > > +       return active ? init_cb() : 0;
> > > +}
> > > +void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_c=
b)
> > > +{
> > > +       GSList *cb_node;
> > > +
> > > +       if (!monitoring_enabled)
> > > +               return exit_cb();
> > > +       if (active)
> > > +               exit_cb();
> > > +       cb_node =3D g_slist_find_custom(callbacks, init_cb, find_cb);
> > > +       if (cb_node !=3D NULL)
> > > +               callbacks =3D g_slist_delete_link(callbacks, cb_node)=
;
> > > +       if (callbacks =3D=3D NULL)
> > > +               logind_exit();
> > > +}
> > > +
> > > +int logind_set(gboolean enabled)
> > > +{
> > > +       int res =3D 0;
> > > +
> > > +       if (monitoring_enabled =3D=3D enabled)
> > > +               return 0;
> > > +
> > > +       monitoring_enabled =3D enabled;
> > > +       if (enabled) {
> > > +               active =3D FALSE;
> > > +               return update();
> > > +       }
> > > +
> > > +       active =3D TRUE;
> > > +       g_slist_foreach(callbacks, call_exit_cb, &res);
> > > +       return res;
> > > +}
> > > +
> > > +#endif
> > > diff --git a/obexd/src/logind.h b/obexd/src/logind.h
> > > new file mode 100644
> > > index 000000000..1a92a8b87
> > > --- /dev/null
> > > +++ b/obexd/src/logind.h
> > > @@ -0,0 +1,26 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + *
> > > + *  Enable functionality only when the user is active
> > > + *
> > > + *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
> > > + *
> > > + *
> > > + */
> > > +
> > > +#ifdef SYSTEMD
> > > +
> > > +typedef int (*logind_init_cb)(void);
> > > +typedef void (*logind_exit_cb)(void);
> > > +
> > > +int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb);
> > > +void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_c=
b);
> > > +int logind_set(gboolean enabled);
> > > +
> > > +#else
> > > +
> > > +#define logind_register(init_cb, exit_cb) init_cb()
> > > +#define logind_unregister(init_cb, exit_cb) exit_cb()
> > > +#define logind_set(enabled) 0
> > > +
> > > +#endif
> > > diff --git a/obexd/src/main.c b/obexd/src/main.c
> > > index ca95a70de..df150973e 100644
> > > --- a/obexd/src/main.c
> > > +++ b/obexd/src/main.c
> > > @@ -35,6 +35,7 @@
> > >  #include "../client/manager.h"
> > >
> > >  #include "log.h"
> > > +#include "logind.h"
> > >  #include "obexd.h"
> > >  #include "server.h"
> > >
> > > @@ -283,6 +284,9 @@ int main(int argc, char *argv[])
> > >
> > >         __obex_log_init(option_debug, option_detach);
> > >
> > > +       if (option_system_bus)
> > > +               logind_set(FALSE);
> > > +
> > >         DBG("Entering main loop");
> > >
> > >         main_loop =3D g_main_loop_new(NULL, FALSE);
> > > --
> > > 2.49.0
> >
> > Applying: obexd: Unregister profiles when the user is inactive
> > WARNING:MACRO_ARG_UNUSED: Argument 'exit_cb' is not used in function-li=
ke macro
> > #409: FILE: obexd/src/logind.h:22:
> > +#define logind_register(init_cb, exit_cb) init_cb()
> >
> > WARNING:MACRO_ARG_UNUSED: Argument 'init_cb' is not used in function-li=
ke macro
> > #410: FILE: obexd/src/logind.h:23:
> > +#define logind_unregister(init_cb, exit_cb) exit_cb()
> >
> > WARNING:MACRO_ARG_UNUSED: Argument 'enabled' is not used in function-li=
ke macro
> > #411: FILE: obexd/src/logind.h:24:
> > +#define logind_set(enabled) 0
>
> Those #define's are dummy implementations for use when systemd is disable=
d.
> Which of these would you rather silence the warnings with?
>
>     // inline functions:
>     static inline int logind_set(gboolean enabled) { return 0; }

I think inline is probably better, but I don't have a strong opinion
about the usage of the options below.

>     // comma operator:
>     #define logind_set(enabled) (enabled,0)
>
>     // varargs:
>     #define login_set(...) 0
>
> >
> > --
> > Luiz Augusto von Dentz
> >



--=20
Luiz Augusto von Dentz
