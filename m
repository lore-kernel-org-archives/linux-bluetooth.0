Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1C1EF0B4
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296993; cv=none; b=dXapBbhnKk/gxtqsnZ0EY+BkB6UwqGxejojot/p+JFnsmfktni/K7U6Dg2biYNAmEVqF5urv4FoYeJjdcN1JEnEiXyAVjGPk3mzptxh5ZtHuwy4RG3HxNp0HUtpg5wN/67Y9hUSRj75LmmnjzCJQrKj4c4hChAUY0ZzimudUfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296993; c=relaxed/simple;
	bh=Dzwkwsdj9vzX44fktjsoCUxNbvrCQGG33HUG6Psbkhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhONfLisxShyZaRJSvR91OGi7TsxoG/STcnxBUViNaK7qULE76HL8cYRRJTwMvhGWanA5Focimp35G/ueKkQPj+4OoSNovnsWDv2PMcRYh6Oygpb21gqzOPUdzXA0xje3/JOT+35ljYeiRiyo5FfT+650qyXWsFa5/6mBbk4LCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVBAz4fI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVBAz4fI"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so52696641fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730296989; x=1730901789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0lB6ysQlSDdmhiXmo/k0qqC7FFglcJ35Sb0VQUCKlg=;
        b=AVBAz4fIriHRQ27ojzwyzbEqchG8pJqcUxLchph4LtdIJVrh0cgeCyWrw8OiTGAG4M
         YZaZexlpYntxarIaxB+9Usz16io6X8knXJ6YSbJZ2HaxZjwKjVP4DVd0cDFi64+xrMBv
         AzhqFWbn8J5bwN3yZ2bLX+BUrJHv7b5VWNka6GDOwFS40HsuonhJU6akGeQehXI4fzBp
         i2utHcqF70U6MHhPjUPTtGik8l2MeT9lycI+hPOG9DtEWVbsgaG07KkIMKCdZ4vrip2p
         FJh+0SbxNeekS/eJjQy/dBbL1WbNn0yX792Z0lJhdBevMOkMwnBEp/kANhhv79Yw4yYz
         XZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296989; x=1730901789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0lB6ysQlSDdmhiXmo/k0qqC7FFglcJ35Sb0VQUCKlg=;
        b=ZKZNI66P2plVpZwyUpLjHLpxJmFBhBU73CvxpJ4Vkqt0UjBnNzqPyb06LE2/Mj94nf
         BWDtGUIIiKuL4h4l/gedR3S9XdaVqDkSZFu9f3a8xRbrMgVoYa3IxDn4yooMNJ5PFp2H
         f3ChMw4i79Yk0bdAtEbNn5jgZxvPQPtC7BF6IhfMNQeOLSG3jCLG2yythNxWCQnPQZSJ
         DJMU7upNXbXv4bv8bJCmEiid6DTOxt94rS1gHSlctkoMci4YeREB4CmPnucOW8sA6tf1
         OE6/arNBaU5EQIcQhvVk554zuVSG+CxlM5lIUh6mDiLvAr3/1t1WwViyCOasAhzy/Tm4
         m1XA==
X-Gm-Message-State: AOJu0YzghpXqt6nHiz1Y+BOgt5aPMUP3KYV/MYpc//Mvmbpal/YtOK3E
	p00zHkqyISybwxzdr7g5ZCVorPDetgM8zaa+UCodKjsGYAjyOV1fVn+DkRYKDOrDP57UgC3x6Fd
	sfc8haV7tN4r06DWKw4/DRzQP7sc=
X-Google-Smtp-Source: AGHT+IEy4rGgxthuwuqv/Nkw/+h1kMhxz1X8oB2IFSowtlkHWSjoigCQlHkCO9tLLRLdxIwY84hQRAOU1QQ7tp9eJVk=
X-Received: by 2002:a05:651c:1546:b0:2fb:60d8:7445 with SMTP id
 38308e7fff4ca-2fcbdf62117mr75573881fa.6.1730296988199; Wed, 30 Oct 2024
 07:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030115001.1278503-1-quic_dgangire@quicinc.com>
In-Reply-To: <20241030115001.1278503-1-quic_dgangire@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Oct 2024 10:02:55 -0400
Message-ID: <CABBYNZJE_uobe+T0LdL5zV-7bkwd_RcP4e-qZPueEDbr-poGEQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] obexd: Add system bus support for obexd
To: quic_dgangire@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 30, 2024 at 7:50=E2=80=AFAM <quic_dgangire@quicinc.com> wrote:
>
> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
>
> Currently obexd uses session bus.
> Distros  where session bus is not supported and still obex profiles
> are required in that case use system bus instead of session bus
> which can be configured at run time.
>
> ---
>  obexd/client/ftp.c      |  7 ++++++-
>  obexd/client/map.c      |  7 ++++++-
>  obexd/client/opp.c      |  7 ++++++-
>  obexd/client/pbap.c     |  7 ++++++-
>  obexd/client/session.c  |  7 ++++++-
>  obexd/client/sync.c     |  7 ++++++-
>  obexd/plugins/pcsuite.c |  5 ++++-
>  obexd/src/main.c        |  8 ++++++++
>  obexd/src/manager.c     |  8 +++++++-
>  obexd/src/obexd.h       |  1 +
>  src/bluetooth.conf      | 12 ++++++++++++
>  11 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
> index 160e0636a..83ddb51cc 100644
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
> @@ -463,7 +464,11 @@ int ftp_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (obex_option_system_bus())
> +               conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       else
> +               conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 513dcaf14..c81e9c524 100644
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
> @@ -2063,7 +2064,11 @@ int map_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (obex_option_system_bus())
> +               conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       else
> +               conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/opp.c b/obexd/client/opp.c
> index 90d0c0c8e..2d402d77e 100644
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
> @@ -178,7 +179,11 @@ int opp_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (obex_option_system_bus())
> +               conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       else
> +               conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 2d2aa9508..fe5da5c80 100644
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
> @@ -1303,7 +1304,11 @@ int pbap_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (obex_option_system_bus())
> +               conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       else
> +               conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 13a834e14..889c43936 100644
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
> @@ -591,7 +592,11 @@ struct obc_session *obc_session_create(const char *s=
ource,
>         if (driver =3D=3D NULL)
>                 return NULL;
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (obex_option_system_bus())
> +               conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       else
> +               conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +
>         if (conn =3D=3D NULL)
>                 return NULL;
>
> diff --git a/obexd/client/sync.c b/obexd/client/sync.c
> index 92faf4434..ef2c338c0 100644
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
> @@ -224,7 +225,11 @@ int sync_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       if (obex_option_system_bus())
> +               conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
> +       else
> +               conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
> index 07c444ff2..70e67e5d3 100644
> --- a/obexd/plugins/pcsuite.c
> +++ b/obexd/plugins/pcsuite.c
> @@ -322,7 +322,10 @@ static gboolean send_backup_dbus_message(const char =
*oper,
>
>         file_size =3D size ? *size : 0;
>
> -       conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
> +       if (obex_option_system_bus())
> +               conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
> +       else
> +               conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);

Seem like this is being duplicated all over the place, I'd suggest we
move this logic under some helper function which takes care of
detecting which bus shall be used and return the DBusConnection
directly so we also get rid of g_dbus_setup_bus above which seems
incorrect.

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
> index 3c0c2a7cc..f85e0e9bb 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -488,7 +488,13 @@ gboolean manager_init(void)
>
>         dbus_error_init(&err);
>
> -       connection =3D g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, =
&err);
> +       if (obex_option_system_bus())
> +               connection =3D
> +                       g_dbus_setup_bus(DBUS_BUS_SYSTEM, OBEXD_SERVICE, =
&err);
> +       else
> +               connection =3D
> +                       g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE,=
 &err);
> +
>         if (connection =3D=3D NULL) {
>                 if (dbus_error_is_set(&err) =3D=3D TRUE) {
>                         fprintf(stderr, "%s\n", err.message);
> diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
> index af5265da5..54f91545b 100644
> --- a/obexd/src/obexd.h
> +++ b/obexd/src/obexd.h
> @@ -28,3 +28,4 @@ gboolean obex_option_auto_accept(void);
>  const char *obex_option_root_folder(void);
>  gboolean obex_option_symlinks(void);
>  const char *obex_option_capability(void);
> +gboolean obex_option_system_bus(void);
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index b6c614908..f8879c8bb 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -21,10 +21,22 @@
>      <allow send_interface=3D"org.freedesktop.DBus.ObjectManager"/>
>      <allow send_interface=3D"org.freedesktop.DBus.Properties"/>
>      <allow send_interface=3D"org.mpris.MediaPlayer2.Player"/>
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
>    </policy>
>
>    <policy context=3D"default">
>      <allow send_destination=3D"org.bluez"/>
> +    <allow send_destination=3D"org.bluez.obex"/>
>    </policy>

That is not the file for obexd though, so we might need to to create
e.g. obex.conf to allow it to be run as system daemon, anyway the
point is that if obexd is disabled during the build it interfaces
shall also be disabled in the configuration file therefore we need a
dedicated D-Bus policy file.

>  </busconfig>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
