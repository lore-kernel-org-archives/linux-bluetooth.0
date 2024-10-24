Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C01EABD2
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782246; cv=none; b=sR8lgfdYdHWM14FF1usNcbSfgOdRRityEbRgKr56AxFXFMESOR3WQ12QuozuLEwKngzHHdYmYS+wbDUd6N+z8wX0z/Ne5+R9fjhmmUkSvdnGdJAe+cDmg8Dt+nQrcjGTV8+eLFFkhxx43IpMy8nYspfMUrI4v1WcEolha3Qrpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782246; c=relaxed/simple;
	bh=ETN7VRShkt+5EnId9a4gwv7VdaLh0qnkn49LlRf2TpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZv6pxKsKhLd+ToRgajgVuWD/UMOFovppEiIZKUBSSfdoPheXJiwReXqLAb8cNSOj4GwuSMIjENDSJwh46JG7UO1n7hcTXfMogbBC+jr7dHLLghb2gq6YJyUxzavwDzL76M4FI9aToCLz8XZkQH6KE9UmtocpPCahO4i/IR/XFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF6yI9zE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF6yI9zE"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fc968b3545so10773501fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729782241; x=1730387041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeEzum1HaCdHE/28KJWO79dKsZlptFhz7DJ5mK3q9zo=;
        b=EF6yI9zE3YUiGs1DiWn/uKXtJcFHZxeGE+2WW0mXIzE+H2ZR8z1QFJMqppUFStcXbs
         aQEvq7XGXpyVXJVE0HJQ58HPK8MXnNRWH/47ASm/lzRe+6Hl1gp9cEdxA2wBZcRyXhi3
         AlHWsANgWqfp+ToNFL65TwY8UV+61pFvZ+tcImF2jT0CkIsPe0dUdN4YHDTWAGIxnI7O
         7IgzkWid02KAm4oHexveJLVAHgWjE61HEO7NM3fLCtok80PllDwdD8P7FFPXUstC6G8H
         S0mq2N8Of4KmvXv59t6ScwiP0HVH/HRQYUHYA+mCuKdeSpehiaL5ko8VaSxIMtbZwr3M
         2yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782241; x=1730387041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeEzum1HaCdHE/28KJWO79dKsZlptFhz7DJ5mK3q9zo=;
        b=GwdCWneQSnwhQakhRg9yA/NR63WSturfqhFFMAPq6aFvRDrZuqQaheW18/UbSpObku
         gBI+8mmbNJDVRUWiRHed1x/dDYK0bY885L3HCP7VqYasgEFi6vnIh3o7DV5CdLwInDes
         LHAr1Axg3VJKSw3XNa8LhpUjn0g09yohuOEEkgUs5YPPxiVxg9l+0hvlADhWWu26K/7t
         Ige22XuZ+9CvGiQjfW17gls/w3vVoQ8ZH9wsMuiPPWJpsWrWBD7UAFry8o958KKrTcIM
         39EHgXxghyCckmRMgUDdteYFPshMR4Le8ImhvbDLzaTnbZ0VyrAOMT7PkD9TszH62/OX
         qnzw==
X-Gm-Message-State: AOJu0YxePDlCTI+tj9Y/z6LCAlXFI96MBAT4kRM4SRaDaKiUtGdrKL97
	R5dUCbEbFRWOAoYO6rcV5wthythTvKihY0WhcuzHleMNh0KPP30ZozEQF4X/Amnjht72F2oSc+c
	AqWHJExs/g6ToiT3rUS7Z/hzjQdXc4ocb
X-Google-Smtp-Source: AGHT+IEJ8OTWHmMwF1gpVT+hEjKvBL9RC5PYn+xKVP3HQ6Htr5cQQB4uAvhFnuudR3IgqYYSjtz0IvwJWlfEx1mQXtI=
X-Received: by 2002:a2e:4e1a:0:b0:2fb:6027:7bfd with SMTP id
 38308e7fff4ca-2fc9d345dbdmr27707881fa.27.1729782240590; Thu, 24 Oct 2024
 08:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723112505.3019642-1-quic_dgangire@quicinc.com>
In-Reply-To: <20240723112505.3019642-1-quic_dgangire@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Oct 2024 11:03:46 -0400
Message-ID: <CABBYNZ+SA6BmRQju16PtsUB+CxCEKvGfYXxdRXG+s0T5ky1QUQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] obexd: Add system bus support for obexd
To: quic_dgangire@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 23, 2024 at 7:25=E2=80=AFAM <quic_dgangire@quicinc.com> wrote:
>
> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
>
> Currently obexd uses session bus.
> Distros  where session bus is not supported and still obex profiles
> are required in that case use system bus instead of session bus
> which can be configured with new optional feature

Well system bus is normally used by daemon that require root(like)
access, having obexd running as a system service is sort of dangerous
since it means remote access as root to part of the filesystem
(similar to allowing FTP access as root user).

> Additional optional feature has been added to achieve this
> with name --enable-use-systembus-for-obexd
>
> steps to configure system bus
> ./configure --enable-use-systembus-for-obexd

If we allow such a thing I'd like to have it as a runtime option, not
just as a build-time one, since we might want to be able to run obexd
under test-runner for testing automation, but for example the
test-runner environment currently doesn't start any session bus.

Btw, if you guys are after a stable environment for test
automation/qualification I highly recommend looking into the
test-runner:

https://github.com/bluez/bluez/blob/master/doc/test-runner.rst

> ---
>  Makefile.obexd          | 14 ++++++++++++++
>  configure.ac            |  9 +++++++++
>  obexd/client/ftp.c      |  3 ++-
>  obexd/client/map.c      |  3 ++-
>  obexd/client/opp.c      |  3 ++-
>  obexd/client/pbap.c     |  3 ++-
>  obexd/client/session.c  |  3 ++-
>  obexd/client/sync.c     |  3 ++-
>  obexd/plugins/pcsuite.c |  3 ++-
>  obexd/src/manager.c     |  3 ++-
>  src/bluetooth.conf      | 12 ++++++++++++
>  tools/obexctl.c         |  3 ++-
>  12 files changed, 53 insertions(+), 9 deletions(-)
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index b7e9f2d33..87432cc37 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -2,6 +2,19 @@
>  if OBEX
>
>  if SYSTEMD
> +
> +if USE_SYSTEMBUS_FOR_OBEXD
> +
> +systemdsystemunit_DATA +=3D obexd/src/obex.service
> +dbussystembus_DATA +=3D obexd/src/org.bluez.obex.service
> +
> +obexd-add-service-symlink:
> +       $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-o=
rg.bluez.obex.service
> +
> +obexd-remove-service-symlink:
> +       rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.serv=
ice
> +else
> +
>  systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
>  systemduserunit_DATA =3D obexd/src/obex.service
>
> @@ -13,6 +26,7 @@ obexd-add-service-symlink:
>
>  obexd-remove-service-symlink:
>         rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.servic=
e
> +endif
>  else
>  obexd-add-service-symlink:
>  obexd-remove-service-symlink:
> diff --git a/configure.ac b/configure.ac
> index d31eb1656..cc9a55f4c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -283,6 +283,15 @@ if (test "${enable_obex}" !=3D "no"); then
>  fi
>  AM_CONDITIONAL(OBEX, test "${enable_obex}" !=3D "no")
>
> +AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-syst=
embus-for-obexd],
> +               [enable systembus for obexd]), [enable_use_systembus_for_=
obexd=3D${enableval}])
> +AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_for=
_obexd}" =3D "yes")
> +if (test "${enable_use_systembus_for_obexd}" =3D "yes"); then
> +       AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want to=
 use system bus for obexd.])
> +else
> +       AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want to=
 use session bus for obexd.])
> +fi
> +
>  AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
>                 [enable BTP client]), [enable_btpclient=3D${enableval}])
>  AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" =3D "yes")
> diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
> index 160e0636a..e3cef32f6 100644
> --- a/obexd/client/ftp.c
> +++ b/obexd/client/ftp.c
> @@ -463,7 +463,8 @@ int ftp_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 513dcaf14..815806f52 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -2063,7 +2063,8 @@ int map_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/opp.c b/obexd/client/opp.c
> index 90d0c0c8e..4889a3a0f 100644
> --- a/obexd/client/opp.c
> +++ b/obexd/client/opp.c
> @@ -178,7 +178,8 @@ int opp_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 2d2aa9508..1658c853a 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -1303,7 +1303,8 @@ int pbap_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 7d8ebb04e..4e447e8eb 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -583,7 +583,8 @@ struct obc_session *obc_session_create(const char *so=
urce,
>         if (driver =3D=3D NULL)
>                 return NULL;
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>         if (conn =3D=3D NULL)
>                 return NULL;
>
> diff --git a/obexd/client/sync.c b/obexd/client/sync.c
> index 92faf4434..bd339adfa 100644
> --- a/obexd/client/sync.c
> +++ b/obexd/client/sync.c
> @@ -224,7 +224,8 @@ int sync_init(void)
>
>         DBG("");
>
> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>         if (!conn)
>                 return -EIO;
>
> diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
> index 07c444ff2..5daed2abb 100644
> --- a/obexd/plugins/pcsuite.c
> +++ b/obexd/plugins/pcsuite.c
> @@ -322,7 +322,8 @@ static gboolean send_backup_dbus_message(const char *=
oper,
>
>         file_size =3D size ? *size : 0;
>
> -       conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
> +       conn =3D g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL, NULL);
>
>         if (conn =3D=3D NULL)
>                 return FALSE;
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 3c0c2a7cc..dd83f056d 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -488,7 +488,8 @@ gboolean manager_init(void)
>
>         dbus_error_init(&err);
>
> -       connection =3D g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, =
&err);
> +       connection =3D g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
> +               DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
>         if (connection =3D=3D NULL) {
>                 if (dbus_error_is_set(&err) =3D=3D TRUE) {
>                         fprintf(stderr, "%s\n", err.message);
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
>
>  </busconfig>
> diff --git a/tools/obexctl.c b/tools/obexctl.c
> index 56a76915c..07dc1ae6b 100644
> --- a/tools/obexctl.c
> +++ b/tools/obexctl.c
> @@ -2154,7 +2154,8 @@ int main(int argc, char *argv[])
>         bt_shell_set_menu(&main_menu);
>         bt_shell_set_prompt(PROMPT_OFF);
>
> -       dbus_conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
> +       dbus_conn =3D g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
> +                               DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL,=
 NULL);
>
>         client =3D g_dbus_client_new(dbus_conn, "org.bluez.obex",
>                                                         "/org/bluez/obex"=
);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
