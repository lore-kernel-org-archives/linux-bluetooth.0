Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F518C034
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755964; cv=none; b=ZtEu6qHrWKpo6ne/el2IQ1DKyqQsg9mPk7PGo3E6frnaDAluxsVGKZyTWpPwz1M2rPLmVq8ejZneWriSeHWn7XSIF3My5fGr2sXNwnItGFY3ueXzYieWQGKLCGX46+5pulKLDxTbB291p0qokzkmTQKGoaaZF+5Wy2XgXyq5XXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755964; c=relaxed/simple;
	bh=qtinABnVzwyCABs8YP0NxPGO+NPY9RvjsabMqyr1Yvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9xANUkMdnb3xMlNiJ+NMVVSZG0odLvviRRN/3Jdbh96K9itPjNHwrwYojRk/G2usPQiggSEbvP4Xm9C6D21T05Oh26jnjMUt7y8DMy70O2sZy71tHheE/BxE49WeW6PzOTjA1RJheFVEtuvJ5k5Gn3eGcImz1azOpWLeZR41eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ8Ft0LL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ8Ft0LL"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb49510250so48117931fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 13:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755960; x=1731360760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ws6SmZQ/5Fp1pYP18xb4G+QUs6qEQ/XvqGbw4apZJ0=;
        b=PZ8Ft0LLrbVvFlQJskicIFXAU5jd6zbP4lkGm7IpxU5K4fM24Zsy2scFr1VQ6CKTW0
         p2z8XvU7Gg4qAlo0hofaFDFjoEk1RBki180EzFEhi7hJ9uoFFzTco0fEKVl5G/PCZ+Dn
         Zg5UCikj/7kCXnIRC36YDgkHuhOOtHx+fswhFTKp7PlRz2ezaA8s0c8Ed2NLcQ1JC+SW
         jutZZl9wXsmVSbUl00aVZKgWyWJxSf/oGWB4TqyOwjePvQca6ci5CZ/av/qkKp9EpRTv
         X1JBEmJP3omzYpRwzRwdD/xwwLzFSj/jii5Yos2Rt4r8tOblT39KlmiwDhuvG8yYRy2u
         3U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755960; x=1731360760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ws6SmZQ/5Fp1pYP18xb4G+QUs6qEQ/XvqGbw4apZJ0=;
        b=LNYyFi+w+/EHvzM94IrCjkBP+woimyAtEBgsRNLnihMguVWTIyG+Mv0sR5VMzDpGsb
         RqpQhWG29A7oPEvQZZh9iDLpZHCbP+rKGLWbWJ+z3szJcNy5DlQ0Xe7lHlGJMtS4p507
         b0fUg03qH4GTqy7r2ogvD6qOG9kWwqLMsaBYVNcqGAeDDDo3UAu61UPKiwS8OZJd+OxR
         kLc2esQLgSkGToz8VSb3XS2l8VwElngLzNl6iv3Tr+gNNxqWNWN8FPLQ3k8e0jawcPCF
         rD+6yyo0qSHLgs+JP52y+xOQYfrrrnoo3YTLHaVNFidQHCv4kMVGz8gjVr87kM++i6tk
         d99w==
X-Gm-Message-State: AOJu0YxwtNncn8M9zCxe8BBJUnVlFuqZIvNxDQ9NX7Li/xuSJL/t1haI
	cNOgqzKMa9aCPwysxbRnH3rxPl1cOz1YoU/35jfMQFxWAG5fCR0G8SFlXTwyFZ5zADAxYiQj7vS
	6vY/kQGQ2gCxYIzltncc0cy+UQ60=
X-Google-Smtp-Source: AGHT+IE6jtb3u8mnr0C4IvrqT9NFOkehEkBZlcfenpanPSXzWJyc/nkZyKEeOveet1hp/rjvOKJAh+vWg6XrRuY0Jl4=
X-Received: by 2002:a2e:602:0:b0:2fa:d177:13e6 with SMTP id
 38308e7fff4ca-2fdec856fb2mr61952931fa.21.1730755959123; Mon, 04 Nov 2024
 13:32:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104124517.4112676-1-quic_dgangire@quicinc.com>
In-Reply-To: <20241104124517.4112676-1-quic_dgangire@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Nov 2024 16:32:26 -0500
Message-ID: <CABBYNZ+ciuHSJv0HBwVcGSZ-WJnY+pnyScCDmoj+rwUByOMw-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3] obexd: Add system bus support for obexd
To: quic_dgangire@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 4, 2024 at 7:47=E2=80=AFAM <quic_dgangire@quicinc.com> wrote:
>
> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
>
> Currently obexd uses session bus.
> Distros  where session bus is not supported and still obex profiles
> are required in that case use system bus instead of session bus
> which can be configured at run time.
>
> An Command line option has been added to achieve it.
> { "system-bus", 's', 0, G_OPTION_ARG_NONE, &option_system_bus,
>                                 "Use System bus "},
>
> we can use option obexd -s to use system bus.
>
> ---
>  Makefile.am             |  6 +++++-
>  gdbus/gdbus.h           |  5 +++++
>  gdbus/mainloop.c        | 25 +++++++++++++++++++++++++
>  obexd/client/ftp.c      |  3 ++-
>  obexd/client/map.c      |  3 ++-
>  obexd/client/opp.c      |  3 ++-
>  obexd/client/pbap.c     |  3 ++-
>  obexd/client/session.c  |  3 ++-
>  obexd/client/sync.c     |  3 ++-
>  obexd/plugins/pcsuite.c |  2 +-
>  obexd/src/main.c        |  8 ++++++++
>  obexd/src/manager.c     |  4 +++-
>  obexd/src/obex.conf     | 28 ++++++++++++++++++++++++++++
>  obexd/src/obexd.h       |  3 +++
>  14 files changed, 90 insertions(+), 9 deletions(-)
>  create mode 100644 obexd/src/obex.conf
>
> diff --git a/Makefile.am b/Makefile.am
> index f639f7f8b..297d0774c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -39,6 +39,10 @@ if DATAFILES
>  dbusdir =3D $(DBUS_CONFDIR)/dbus-1/system.d
>  dbus_DATA =3D src/bluetooth.conf
>
> +if OBEX
> +dbus_DATA +=3D obexd/src/obex.conf
> +endif
> +
>  conf_DATA =3D src/main.conf
>  conf_DATA +=3D profiles/input/input.conf
>  conf_DATA +=3D profiles/network/network.conf
> @@ -421,7 +425,7 @@ manual_pages +=3D doc/org.bluez.obex.Client.5 doc/org=
.bluez.obex.Session.5 \
>
>  EXTRA_DIST +=3D src/genbuiltin src/bluetooth.conf \
>                         src/main.conf profiles/network/network.conf \
> -                       profiles/input/input.conf
> +                       profiles/input/input.conf obexd/src/obex.conf
>
>  test_scripts =3D
>  unit_tests =3D
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index d7be17661..8e0d9c1ea 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -40,6 +40,11 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, con=
st char *name,
>  DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
>                                                         DBusError *error)=
;
>
> +DBusConnection *get_dbus_connection(gboolean bus_type);
> +
> +DBusConnection *setup_dbus_connection(gboolean bus_type, const char *nam=
e,
> +                                                       DBusError *error)=
;
> +
>  gboolean g_dbus_request_name(DBusConnection *connection, const char *nam=
e,
>                                                         DBusError *error)=
;
>
> diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
> index a04ebb19b..7bf691191 100644
> --- a/gdbus/mainloop.c
> +++ b/gdbus/mainloop.c
> @@ -293,6 +293,31 @@ DBusConnection *g_dbus_setup_bus(DBusBusType type, c=
onst char *name,
>         return conn;
>  }
>
> +DBusConnection *get_dbus_connection(gboolean bus_type)
> +{
> +       DBusConnection *conn =3D NULL;
> +
> +       if (bus_type)
> +               conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       else
> +               conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +
> +       return conn;
> +}
> +
> +DBusConnection *setup_dbus_connection(gboolean bus_type, const char *nam=
e,
> +                                                       DBusError *error)
> +{
> +       DBusConnection *conn =3D NULL;
> +
> +       if (bus_type)
> +               conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, name, error);
> +       else
> +               conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, name, error);
> +
> +       return conn;
> +}

Don't recall suggesting putting these helpers into gdbus, how is this
going to help us in any way if it is just passing a bool instead of
the type?

>  DBusConnection *g_dbus_setup_private(DBusBusType type, const char *name,
>                                                         DBusError *error)
>  {
> diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
> index 160e0636a..31fcd42fb 100644
> --- a/obexd/client/ftp.c
> +++ b/obexd/client/ftp.c
> @@ -19,6 +19,7 @@
>  #include "gdbus/gdbus.h"
>
>  #include "obexd/src/log.h"
> +#include "obexd/src/obexd.h"
>  #include "transfer.h"
>  #include "session.h"
>  #include "driver.h"
> @@ -463,7 +464,7 @@ int ftp_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D get_dbus_connection(obex_option_system_bus());

What I suggested is that we have something similar to
btd_get_dbus_connection (e.g. obexd_get_dbus_connection) which returns
a static variable so it is the same reference.

>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 513dcaf14..2732eb7df 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -27,6 +27,7 @@
>  #include "gdbus/gdbus.h"
>
>  #include "obexd/src/log.h"
> +#include "obexd/src/obexd.h"
>  #include "obexd/src/map_ap.h"
>  #include "map-event.h"
>
> @@ -2063,7 +2064,7 @@ int map_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D get_dbus_connection(obex_option_system_bus());
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/opp.c b/obexd/client/opp.c
> index 90d0c0c8e..13c49d12f 100644
> --- a/obexd/client/opp.c
> +++ b/obexd/client/opp.c
> @@ -17,6 +17,7 @@
>  #include "gdbus/gdbus.h"
>
>  #include "obexd/src/log.h"
> +#include "obexd/src/obexd.h"
>
>  #include "transfer.h"
>  #include "session.h"
> @@ -178,7 +179,7 @@ int opp_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D get_dbus_connection(obex_option_system_bus());
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 2d2aa9508..5280cbac5 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -27,6 +27,7 @@
>  #include "gdbus/gdbus.h"
>
>  #include "obexd/src/log.h"
> +#include "obexd/src/obexd.h"
>
>  #include "transfer.h"
>  #include "session.h"
> @@ -1303,7 +1304,7 @@ int pbap_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D get_dbus_connection(obex_option_system_bus());
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 13a834e14..3460690dd 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -27,6 +27,7 @@
>  #include "gobex/gobex.h"
>
>  #include "obexd/src/log.h"
> +#include "obexd/src/obexd.h"
>  #include "transfer.h"
>  #include "session.h"
>  #include "driver.h"
> @@ -591,7 +592,7 @@ struct obc_session *obc_session_create(const char *so=
urce,
>         if (driver =3D=3D NULL)
>                 return NULL;
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D get_dbus_connection(obex_option_system_bus());
>         if (conn =3D=3D NULL)
>                 return NULL;
>
> diff --git a/obexd/client/sync.c b/obexd/client/sync.c
> index 92faf4434..0283d9729 100644
> --- a/obexd/client/sync.c
> +++ b/obexd/client/sync.c
> @@ -21,6 +21,7 @@
>  #include "gdbus/gdbus.h"
>
>  #include "obexd/src/log.h"
> +#include "obexd/src/obexd.h"
>
>  #include "transfer.h"
>  #include "session.h"
> @@ -224,7 +225,7 @@ int sync_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D get_dbus_connection(obex_option_system_bus());
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
> index 07c444ff2..06aca7366 100644
> --- a/obexd/plugins/pcsuite.c
> +++ b/obexd/plugins/pcsuite.c
> @@ -322,7 +322,7 @@ static gboolean send_backup_dbus_message(const char *=
oper,
>
>         file_size =3D size ? *size : 0;
>
> -       conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
> +       conn =3D setup_dbus_connection(obex_option_system_bus(), NULL, NU=
LL);
>
>         if (conn =3D=3D NULL)
>                 return FALSE;
> diff --git a/obexd/src/main.c b/obexd/src/main.c
> index 151574afa..aee86ebd1 100644
> --- a/obexd/src/main.c
> +++ b/obexd/src/main.c
> @@ -126,6 +126,7 @@ static char *option_noplugin =3D NULL;
>
>  static gboolean option_autoaccept =3D FALSE;
>  static gboolean option_symlinks =3D FALSE;
> +static gboolean option_system_bus =3D FALSE;
>
>  static gboolean parse_debug(const char *key, const char *value,
>                                 gpointer user_data, GError **error)
> @@ -164,6 +165,8 @@ static const GOptionEntry options[] =3D {
>                                 "scripts", "FILE" },
>         { "auto-accept", 'a', 0, G_OPTION_ARG_NONE, &option_autoaccept,
>                                 "Automatically accept push requests" },
> +       { "system-bus", 's', 0, G_OPTION_ARG_NONE, &option_system_bus,
> +                               "Use System bus "},
>         { NULL },
>  };
>
> @@ -172,6 +175,11 @@ gboolean obex_option_auto_accept(void)
>         return option_autoaccept;
>  }
>
> +gboolean obex_option_system_bus(void)
> +{
> +       return option_system_bus;
> +}
> +
>  const char *obex_option_root_folder(void)
>  {
>         return option_root;
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 3c0c2a7cc..dff2e3783 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -488,7 +488,9 @@ gboolean manager_init(void)
>
>         dbus_error_init(&err);
>
> -       connection =3D g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, =
&err);
> +       connection =3D
> +               setup_dbus_connection(obex_option_system_bus(),
> +                                                       OBEXD_SERVICE, &e=
rr);
>         if (connection =3D=3D NULL) {
>                 if (dbus_error_is_set(&err) =3D=3D TRUE) {
>                         fprintf(stderr, "%s\n", err.message);
> diff --git a/obexd/src/obex.conf b/obexd/src/obex.conf
> new file mode 100644
> index 000000000..114bdb882
> --- /dev/null
> +++ b/obexd/src/obex.conf
> @@ -0,0 +1,28 @@
> +<!-- This configuration file specifies the required security policies
> +     for Bluetooth core daemon to work. -->
> +
> +<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration =
1.0//EN"
> + "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
> +<busconfig>
> +
> +  <!-- ../system.conf have denied everything, so we just punch some hole=
s -->
> +
> +  <policy user=3D"root">
> +    <allow own=3D"org.bluez.obex"/>
> +    <allow send_destination=3D"org.bluez.obex"/>
> +    <allow send_interface=3D"org.bluez.obex.Agent1"/>
> +    <allow send_interface=3D"org.bluez.obex.Client1"/>
> +    <allow send_interface=3D"org.bluez.obex.Session1"/>
> +    <allow send_interface=3D"org.bluez.obex.Transfer1"/>
> +    <allow send_interface=3D"org.bluez.obex.ObjectPush1"/>
> +    <allow send_interface=3D"org.bluez.obex.PhonebookAccess1"/>
> +    <allow send_interface=3D"org.bluez.obex.Synchronization1"/>
> +    <allow send_interface=3D"org.bluez.obex.MessageAccess1"/>
> +    <allow send_interface=3D"org.bluez.obex.Message1"/>
> +  </policy>
> +
> +  <policy context=3D"default">
> +    <allow send_destination=3D"org.bluez.obex"/>
> +  </policy>
> +
> +</busconfig>
> diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
> index af5265da5..72b04b993 100644
> --- a/obexd/src/obexd.h
> +++ b/obexd/src/obexd.h
> @@ -8,6 +8,8 @@
>   *
>   */
>
> +#include "gdbus/gdbus.h"
> +
>  #define OBEX_OPP       (1 << 1)
>  #define OBEX_FTP       (1 << 2)
>  #define OBEX_BIP       (1 << 3)
> @@ -28,3 +30,4 @@ gboolean obex_option_auto_accept(void);
>  const char *obex_option_root_folder(void);
>  gboolean obex_option_symlinks(void);
>  const char *obex_option_capability(void);
> +gboolean obex_option_system_bus(void);

Or better yet, do obex_get_dbus_connection directly instead of getting
the option of system to only then resolve the connection in a second
call.

> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
