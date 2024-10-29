Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F52071E4
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210795; cv=none; b=bAvbvPRsQ2ucK0VCrQ1NQGa5RfxqOTciyy28+5L2xjL6POxmg7SuNtt77cB/E7rW1uJMlJxNtMy9QSBh8v3+LI5fxNn/CO49r5oRHcSjtep1NHgncl0pn5FdE/G5plfmpYg/p0eQ6cLV69SLO9SijVhSTNEyVQYzeYmg/5G3+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210795; c=relaxed/simple;
	bh=NL/+aZCoucC64jFQlQ1O+NpINUIVEA+QhDUc+PChsnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pac/L7pU89XmLixV2SAzhtUjd2jzhVEsUAB3e9S7rnXXHMde6fQ79UF2Ez5sAEI1axIfkHVE6xVbCanZ2wITa59C6QpZFzyQquWy5l2vgI14WYODyo+vX9nEVGINzypk6iyqcqLkczGzaYX8gPKwiBEjvFQqYs7uoNYp+YLTEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrglyFwV; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrglyFwV"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso82235401fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 07:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730210791; x=1730815591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7bIpGszCr1HYjXm2O7xhr2JPjlcbwHGX/Dezzvg1qk=;
        b=lrglyFwVtFQBzrEfxzRPMZaz6TBW14Y0ZPBdPzwjIYcQr7dR7lyA917kvfNIx/a1HX
         mViQLoW74QVTH4fRIQ6m0K2P+FYo9d7swejbnygnOV7Lugz9mWHEogq7phywGsPjhSFs
         mfEnrTopdUmVt0cJgeR1DOanxgSZxffE+rXNHrVQcEykuQ+lV5ZLMT48yt0f8c/gD7au
         PWKnlUvWFyHdMKyuUAu57wpczleiIHEU/x0qyzW13/B2eNCOwIIhc/aagiWb1FCUVjK0
         76hMGqec2ExWTYXjQWkU3i7U3q+CqHC1FQnqK63fi1jvmxVL0AyM7gG51/RHxLWoGxW2
         64Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210791; x=1730815591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7bIpGszCr1HYjXm2O7xhr2JPjlcbwHGX/Dezzvg1qk=;
        b=pj7+fH1yEcDNgrroSAeHF5EgGvGiuZZ5GOmZiYPZOMsR4zDph7iAlcMDuF+XzTdVuO
         xwMzPhviQAxw/2i3JvWkRX8qSf6rMurfDr98SWU2Rtrxul2rPFlMtbHtouLZjj0QJYC9
         xPpY9vGYhempOk730YTll/VOcGt1DCXXbm/VMIY5SXG4N6tIv9CbirTn/HkSc+sQ38ak
         l0piROYJ2s1eXsMKJxTfkdDHk3+Wwpyj/JR6+OMCxozgzh+rPALitIATjC4QF9T4vTSL
         zT+VJYacS5cXHaSJP4tBeY62sI8m6Vp/5wZckNRJMh3kH18nDE7eQBpiah5ezsrg603c
         zzVA==
X-Gm-Message-State: AOJu0Yz40LFxuOwo9kCAmTgV+yEZEVQZdsEwm0LmMSAMdx04EhnKFesl
	b6c6zQT/aXFgxZHr3vpWPP/DP2uIZJEE7bqvAw0mKFKr1Xm6QvY18lKTDHqCHBzOBABerRnQ63W
	TfMk+hZ/XaYTut+WysdlDM3rWwLE=
X-Google-Smtp-Source: AGHT+IFEeFm8+8pM4fl77UdVXhMfTc0dyPrx/C9o0IN1xGVKFqHH+Da1WB+30+WEHhZCUAbHb+efclxejU2GRfQGMxg=
X-Received: by 2002:a05:651c:514:b0:2fb:5206:1675 with SMTP id
 38308e7fff4ca-2fcbdff1ffdmr92855981fa.27.1730210790458; Tue, 29 Oct 2024
 07:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723112505.3019642-1-quic_dgangire@quicinc.com>
 <CABBYNZ+SA6BmRQju16PtsUB+CxCEKvGfYXxdRXG+s0T5ky1QUQ@mail.gmail.com> <1c78c2cd-a6ee-4ba4-a6ce-c16c4d9030d9@quicinc.com>
In-Reply-To: <1c78c2cd-a6ee-4ba4-a6ce-c16c4d9030d9@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Oct 2024 10:06:18 -0400
Message-ID: <CABBYNZ+NR+OGpTeRkwJbHHDZGOsAs5PJ=LEZWe2v3tgiRd117g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1] obexd: Add system bus support for obexd
To: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damodar,

On Tue, Oct 29, 2024 at 1:21=E2=80=AFAM Damodar Reddy GangiReddy
<quic_dgangire@quicinc.com> wrote:
>
> Hi Luiz,
>
> On 10/24/2024 8:33 PM, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Tue, Jul 23, 2024 at 7:25=E2=80=AFAM <quic_dgangire@quicinc.com> wro=
te:
> >>
> >> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
> >>
> >> Currently obexd uses session bus.
> >> Distros  where session bus is not supported and still obex profiles
> >> are required in that case use system bus instead of session bus
> >> which can be configured with new optional feature
> >
> > Well system bus is normally used by daemon that require root(like)
> > access, having obexd running as a system service is sort of dangerous
> > since it means remote access as root to part of the filesystem
> > (similar to allowing FTP access as root user).
> >
> >> Additional optional feature has been added to achieve this
> >> with name --enable-use-systembus-for-obexd
> >>
> >> steps to configure system bus
> >> ./configure --enable-use-systembus-for-obexd
> >
> > If we allow such a thing I'd like to have it as a runtime option, not
> > just as a build-time one, since we might want to be able to run obexd
> > under test-runner for testing automation, but for example the
> > test-runner environment currently doesn't start any session bus.
> >
> To Have it as a runtime option.
> Can we add something similarly as below to achieve it at runtime
> in the obexd main.c file. Like obexd -d
> -d, --debug=3DDEBUG        Enable debug information output
>
> Our Approach: (Not precise we will give proper name convention)
> -b --bus=3Dsystem       Use System bus
> -s --bus=3Dsession      Use Session bus

You just need one option for setting it to use system bus, session
shall remain the default, but we probably need to document that the
system option requires root access and shall be used with care.

> I'd like to have it as a runtime option, not
>  just as a build-time one?
> Ideally we should be setting configuration at runtime or compile time
> but not at both right.?
>
> Suppose at compile time we use --enable-use-systembus-for-obexd which mea=
ns
> system bus is configured. But at run time we say it to use session bus.
> How to handle this scenario and which should be priority?
>
> If our Understanding is not clear.Please ellaborate more on how to achiev=
e it.

No need to have a built-time option since the default should remain to
be the session bus.

> > Btw, if you guys are after a stable environment for test
> > automation/qualification I highly recommend looking into the
> > test-runner:
> >
> > https://github.com/bluez/bluez/blob/master/doc/test-runner.rst
> >
> >> ---
> >>  Makefile.obexd          | 14 ++++++++++++++
> >>  configure.ac            |  9 +++++++++
> >>  obexd/client/ftp.c      |  3 ++-
> >>  obexd/client/map.c      |  3 ++-
> >>  obexd/client/opp.c      |  3 ++-
> >>  obexd/client/pbap.c     |  3 ++-
> >>  obexd/client/session.c  |  3 ++-
> >>  obexd/client/sync.c     |  3 ++-
> >>  obexd/plugins/pcsuite.c |  3 ++-
> >>  obexd/src/manager.c     |  3 ++-
> >>  src/bluetooth.conf      | 12 ++++++++++++
> >>  tools/obexctl.c         |  3 ++-
> >>  12 files changed, 53 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/Makefile.obexd b/Makefile.obexd
> >> index b7e9f2d33..87432cc37 100644
> >> --- a/Makefile.obexd
> >> +++ b/Makefile.obexd
> >> @@ -2,6 +2,19 @@
> >>  if OBEX
> >>
> >>  if SYSTEMD
> >> +
> >> +if USE_SYSTEMBUS_FOR_OBEXD
> >> +
> >> +systemdsystemunit_DATA +=3D obexd/src/obex.service
> >> +dbussystembus_DATA +=3D obexd/src/org.bluez.obex.service
> >> +
> >> +obexd-add-service-symlink:
> >> +       $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbu=
s-org.bluez.obex.service
> >> +
> >> +obexd-remove-service-symlink:
> >> +       rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.s=
ervice
> >> +else
> >> +
> >>  systemduserunitdir =3D $(SYSTEMD_USERUNITDIR)
> >>  systemduserunit_DATA =3D obexd/src/obex.service
> >>
> >> @@ -13,6 +26,7 @@ obexd-add-service-symlink:
> >>
> >>  obexd-remove-service-symlink:
> >>         rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.ser=
vice
> >> +endif
> >>  else
> >>  obexd-add-service-symlink:
> >>  obexd-remove-service-symlink:
> >> diff --git a/configure.ac b/configure.ac
> >> index d31eb1656..cc9a55f4c 100644
> >> --- a/configure.ac
> >> +++ b/configure.ac
> >> @@ -283,6 +283,15 @@ if (test "${enable_obex}" !=3D "no"); then
> >>  fi
> >>  AM_CONDITIONAL(OBEX, test "${enable_obex}" !=3D "no")
> >>
> >> +AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-s=
ystembus-for-obexd],
> >> +               [enable systembus for obexd]), [enable_use_systembus_f=
or_obexd=3D${enableval}])
> >> +AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_=
for_obexd}" =3D "yes")
> >> +if (test "${enable_use_systembus_for_obexd}" =3D "yes"); then
> >> +       AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want=
 to use system bus for obexd.])
> >> +else
> >> +       AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want=
 to use session bus for obexd.])
> >> +fi
> >> +
> >>  AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
> >>                 [enable BTP client]), [enable_btpclient=3D${enableval}=
])
> >>  AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" =3D "yes")
> >> diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
> >> index 160e0636a..e3cef32f6 100644
> >> --- a/obexd/client/ftp.c
> >> +++ b/obexd/client/ftp.c
> >> @@ -463,7 +463,8 @@ int ftp_init(void)
> >>
> >>         DBG("");
> >>
> >> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> >> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
> >>         if (!conn)
> >>                 return -EIO;
> >>
> >> diff --git a/obexd/client/map.c b/obexd/client/map.c
> >> index 513dcaf14..815806f52 100644
> >> --- a/obexd/client/map.c
> >> +++ b/obexd/client/map.c
> >> @@ -2063,7 +2063,8 @@ int map_init(void)
> >>
> >>         DBG("");
> >>
> >> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> >> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
> >>         if (!conn)
> >>                 return -EIO;
> >>
> >> diff --git a/obexd/client/opp.c b/obexd/client/opp.c
> >> index 90d0c0c8e..4889a3a0f 100644
> >> --- a/obexd/client/opp.c
> >> +++ b/obexd/client/opp.c
> >> @@ -178,7 +178,8 @@ int opp_init(void)
> >>
> >>         DBG("");
> >>
> >> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> >> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
> >>         if (!conn)
> >>                 return -EIO;
> >>
> >> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> >> index 2d2aa9508..1658c853a 100644
> >> --- a/obexd/client/pbap.c
> >> +++ b/obexd/client/pbap.c
> >> @@ -1303,7 +1303,8 @@ int pbap_init(void)
> >>
> >>         DBG("");
> >>
> >> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> >> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
> >>         if (!conn)
> >>                 return -EIO;
> >>
> >> diff --git a/obexd/client/session.c b/obexd/client/session.c
> >> index 7d8ebb04e..4e447e8eb 100644
> >> --- a/obexd/client/session.c
> >> +++ b/obexd/client/session.c
> >> @@ -583,7 +583,8 @@ struct obc_session *obc_session_create(const char =
*source,
> >>         if (driver =3D=3D NULL)
> >>                 return NULL;
> >>
> >> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> >> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
> >>         if (conn =3D=3D NULL)
> >>                 return NULL;
> >>
> >> diff --git a/obexd/client/sync.c b/obexd/client/sync.c
> >> index 92faf4434..bd339adfa 100644
> >> --- a/obexd/client/sync.c
> >> +++ b/obexd/client/sync.c
> >> @@ -224,7 +224,8 @@ int sync_init(void)
> >>
> >>         DBG("");
> >>
> >> -       conn =3D dbus_bus_get(DBUS_BUS_SESSION, NULL);
> >> +       conn =3D dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
> >>         if (!conn)
> >>                 return -EIO;
> >>
> >> diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
> >> index 07c444ff2..5daed2abb 100644
> >> --- a/obexd/plugins/pcsuite.c
> >> +++ b/obexd/plugins/pcsuite.c
> >> @@ -322,7 +322,8 @@ static gboolean send_backup_dbus_message(const cha=
r *oper,
> >>
> >>         file_size =3D size ? *size : 0;
> >>
> >> -       conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
> >> +       conn =3D g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL, NULL=
);
> >>
> >>         if (conn =3D=3D NULL)
> >>                 return FALSE;
> >> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> >> index 3c0c2a7cc..dd83f056d 100644
> >> --- a/obexd/src/manager.c
> >> +++ b/obexd/src/manager.c
> >> @@ -488,7 +488,8 @@ gboolean manager_init(void)
> >>
> >>         dbus_error_init(&err);
> >>
> >> -       connection =3D g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVIC=
E, &err);
> >> +       connection =3D g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +               DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, OBEXD_SERVICE, &er=
r);
> >>         if (connection =3D=3D NULL) {
> >>                 if (dbus_error_is_set(&err) =3D=3D TRUE) {
> >>                         fprintf(stderr, "%s\n", err.message);
> >> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> >> index b6c614908..f8879c8bb 100644
> >> --- a/src/bluetooth.conf
> >> +++ b/src/bluetooth.conf
> >> @@ -21,10 +21,22 @@
> >>      <allow send_interface=3D"org.freedesktop.DBus.ObjectManager"/>
> >>      <allow send_interface=3D"org.freedesktop.DBus.Properties"/>
> >>      <allow send_interface=3D"org.mpris.MediaPlayer2.Player"/>
> >> +    <allow own=3D"org.bluez.obex"/>
> >> +    <allow send_destination=3D"org.bluez.obex"/>
> >> +    <allow send_interface=3D"org.bluez.obex.Agent1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.Client1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.Session1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.Transfer1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.ObjectPush1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.PhonebookAccess1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.Synchronization1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.MessageAccess1"/>
> >> +    <allow send_interface=3D"org.bluez.obex.Message1"/>
> >>    </policy>
> >>
> >>    <policy context=3D"default">
> >>      <allow send_destination=3D"org.bluez"/>
> >> +    <allow send_destination=3D"org.bluez.obex"/>
> >>    </policy>
> >>
> >>  </busconfig>
> >> diff --git a/tools/obexctl.c b/tools/obexctl.c
> >> index 56a76915c..07dc1ae6b 100644
> >> --- a/tools/obexctl.c
> >> +++ b/tools/obexctl.c
> >> @@ -2154,7 +2154,8 @@ int main(int argc, char *argv[])
> >>         bt_shell_set_menu(&main_menu);
> >>         bt_shell_set_prompt(PROMPT_OFF);
> >>
> >> -       dbus_conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
> >> +       dbus_conn =3D g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
> >> +                               DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NU=
LL, NULL);
> >>
> >>         client =3D g_dbus_client_new(dbus_conn, "org.bluez.obex",
> >>                                                         "/org/bluez/ob=
ex");
> >> --
> >> 2.34.1
> >>
> >>
> >
> >
> Kind Regards,
> Damodar.



--=20
Luiz Augusto von Dentz
