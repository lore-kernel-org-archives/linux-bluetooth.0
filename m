Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EFF3234
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439575; cv=none; b=YrLpMIbeSNc/NtgEF0h+LdcIF1gTooDt6Lkqitsfx6IgY801vmMP2NrCbbcYEayi/WM4k+mvWxv06Y0CTDkjQzQ2Dg+LdqiEMCPQRIwzAYCgmty8nLFquiYkSKqX5IujiHxHVqbSujBx0sE2OGHi2+13Kv2sllMnJ9X2EAE8h9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439575; c=relaxed/simple;
	bh=BGj6HIn2vPBH1Inw5aUBvHT/f7zzArFGEfn+t5jiXdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU2a5ZLX9AAwdLV2hSmZ6wwADhAx6cOuDGC83YhPQl9eLT89qevqd1vSwQfVdIxQ4R19KL3qwVq+zvjkBbkOgVUNG7Lo1rlbDp0Cl/Rv7NWw+KrsOzVBC7Pw5oGN1dM4vRIPTvjbjHa3rpE/SgcM8WmH2VZfAax34yF/JUye/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSAq/Jz+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSAq/Jz+"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso45076601fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743439571; x=1744044371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW0zm2pD/yA54vYEc4z8sokP/7noWEDhDxKO5Qftbh4=;
        b=RSAq/Jz+B1SIeHCyrOx2aHR46i6IOZbAJwlqJi9NVbDLX/WUATcpf3h4ccoK/dlS2b
         WoMjg9970wlTPCHCjNHkDrfRI69TwTHYvtbOb/r3anHZjjAOSlS/vvUHUMsfyI+yjKDE
         hqfsowfKBMkkStzlGD7c57j38zM3EGg1Ahh3PpDOl9+qJb1uYEn/8vHHH/joZWc2b2rg
         MCB0qXHE0HWFueP+g9z4SnRfunIkKIpCn8G9NzJ2jiCLAmDdCb/QCAi1sZtmnnntfi6M
         PWsaf2jrhgT3+3kgt9XgDWCacGM3J4u4W8XzMmSRTNcHxhvnbPNnIWU5xOkO/FBbcYi1
         YuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439571; x=1744044371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW0zm2pD/yA54vYEc4z8sokP/7noWEDhDxKO5Qftbh4=;
        b=ufRiBbjAUnW7b6VuI59xv00WuJx1Kve3Qz+IbFA2nFrNSu7Z8hfBU1+rx5+x4wtqGy
         FFWUDZgOTP6NEGKHtO/eyEukQLRzQ7oX8ueEaoan73SCbexEOKoPoSNF4YSeKJU9kVG9
         HyDecnYHtUjtKtwpRtFIK+vhcv6ttVE0sAQJpi++ApDIz3Xjx0iWWJuONDTsC9YYbKWq
         n2hq5VscNk5lnbu+oa9lvwY1i1ELlbEH+uMcxJyf/fvpkqVZ+sTbtxjuGidFwq6yYhCZ
         B/mnWVUCGXEVAONGeGIj581mGCORyg4kwFZFuAec7HXwSXn5Absw0DgSUSoKosUaNyzG
         nioQ==
X-Gm-Message-State: AOJu0YzusXIYHeH0/BotYMR8gsiJuqeKhUGFGPJCKEBxyfe7mmZ11KYE
	c44BCrwu/nxju8rgTdCrP6H3f67fKTdE1QpjAL5tdyxSJM9ollPK2lmqZphgP8khIFDc4/BSHw9
	324IvQDyePOWbwOGkiH4fNjE0bXp/Sg==
X-Gm-Gg: ASbGncu6b7qmdbEWaUyD6ZDV7IkG+nd1ooXul0kFRUKe4y3wj1dXAz24r4dmqtwNrrx
	ay2HcqVFWFalNhdHVShlRMJjaxMjB8jGxZNVSryA3Z0h570tnNXXYNFbpznSeYEEn0gbXQi4FTn
	9lzNs2DaIIY+xn97Dc4j71CB33
X-Google-Smtp-Source: AGHT+IESGCgY00bGTRqT7nYM1n5whzPoXSF9Zx/4rjBSZMhX4aXg40RFSGVvNML0imLVSF4nGOvKITGw4E00yihdoTU=
X-Received: by 2002:a2e:9fcb:0:b0:30b:9813:b010 with SMTP id
 38308e7fff4ca-30de0349ecbmr32979431fa.31.1743439570628; Mon, 31 Mar 2025
 09:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi>
 <CABBYNZKrq+7Jb5SFJ0NrELSEiQBY0oBdG6x9qd7HkkkRAVhhxA@mail.gmail.com> <e40a83725842a54cc8b363b687b6fa030a98e422.camel@iki.fi>
In-Reply-To: <e40a83725842a54cc8b363b687b6fa030a98e422.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Mar 2025 12:45:58 -0400
X-Gm-Features: AQ5f1Jo9GjuuHpQrYnvnhcFQbeOMONv_jq-fdU4BwNbTZlZfRsiOK3ASfHXkSo4
Message-ID: <CABBYNZL40M=2ouPdfuuzCdE__=FhiFycamiGk51Ch+F5Z+SkmQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools: add BPF timestamping tests
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Mar 31, 2025 at 12:28=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2025-03-31 kello 11:59 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sun, Mar 30, 2025 at 8:16=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Add some tests for BPF timestamping on Bluetooth sockets.
> > >
> > > These require additional tester kernel config, and at build time
> > > the vmlinux image.
> > >
> > > Add cgroup mount to test-runner.
> > >
> > > Add documentation to tester config for this.
> > >
> > > Add tests:
> > >
> > > ISO Send - TX BPF Timestamping
> > > ---
> > >
> > > Notes:
> > >     This probably needs to wait for the corresponding kernel patch se=
ries to
> > >     settle down.
> > >
> > >  Makefile.tools      |  29 ++++++
> > >  configure.ac        |  36 ++++++-
> > >  doc/test-runner.rst |  26 ++++-
> > >  doc/tester.config   |   5 +
> > >  tools/iso-tester.c  |  71 ++++++++++++-
> > >  tools/test-runner.c |   1 +
> > >  tools/tester.bpf.c  |  92 +++++++++++++++++
> > >  tools/tester.bpf.h  |   7 ++
> >
> > Usually we only do one . for source files, so names shall probably be
> > tester-bpf.{c,h}.
>
> Ok. The .bpf.c convention was used used in some places.
>
> > >  tools/tester.h      | 244 ++++++++++++++++++++++++++++++++++++------=
--
> > >  9 files changed, 463 insertions(+), 48 deletions(-)
> > >  create mode 100644 tools/tester.bpf.c
> > >  create mode 100644 tools/tester.bpf.h
> > >
> > > diff --git a/Makefile.tools b/Makefile.tools
> > > index e60c31b1d..a35af54fc 100644
> > > --- a/Makefile.tools
> > > +++ b/Makefile.tools
> > > @@ -144,6 +144,7 @@ tools_l2cap_tester_SOURCES =3D tools/l2cap-tester=
.c tools/tester.h monitor/bt.h \
> > >                                 emulator/smp.c
> > >  tools_l2cap_tester_LDADD =3D lib/libbluetooth-internal.la \
> > >                                 src/libshared-glib.la $(GLIB_LIBS)
> > > +tools_l2cap_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> > >
> > >  tools_rfcomm_tester_SOURCES =3D tools/rfcomm-tester.c monitor/bt.h \
> > >                                 emulator/hciemu.h emulator/hciemu.c \
> > > @@ -191,6 +192,7 @@ tools_sco_tester_SOURCES =3D tools/sco-tester.c t=
ools/tester.h monitor/bt.h \
> > >                                 emulator/smp.c
> > >  tools_sco_tester_LDADD =3D lib/libbluetooth-internal.la \
> > >                                 src/libshared-glib.la $(GLIB_LIBS)
> > > +tools_sco_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> > >
> > >  tools_hci_tester_SOURCES =3D tools/hci-tester.c monitor/bt.h
> > >  tools_hci_tester_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> > > @@ -212,6 +214,7 @@ tools_iso_tester_SOURCES =3D tools/iso-tester.c t=
ools/tester.h monitor/bt.h \
> > >                                 emulator/smp.c
> > >  tools_iso_tester_LDADD =3D lib/libbluetooth-internal.la \
> > >                                 src/libshared-glib.la $(GLIB_LIBS)
> > > +tools_iso_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> > >
> > >  tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.c monitor/bt.h \
> > >                                 emulator/hciemu.h emulator/hciemu.c \
> > > @@ -221,6 +224,32 @@ tools_ioctl_tester_SOURCES =3D tools/ioctl-teste=
r.c monitor/bt.h \
> > >                                 emulator/smp.c
> > >  tools_ioctl_tester_LDADD =3D lib/libbluetooth-internal.la \
> > >                                 src/libshared-glib.la $(GLIB_LIBS)
> > > +
> > > +if TESTING_BPF
> > > +tools/vmlinux.h: $(BPF_VMLINUX)
> > > +       bpftool btf dump file $(BPF_VMLINUX) format c > $@.new
> > > +       mv -f $@.new $@
> > > +
> > > +tools/tester.bpf.o: $(srcdir)/tools/tester.bpf.c tools/vmlinux.h
> > > +       $(CLANG_BPF) -Wall -Werror -Os -g --target=3Dbpf -Itools -c -=
o $@ $<
> > > +
> > > +tools/tester.skel.h: tools/tester.bpf.o
> > > +       bpftool gen skeleton $< > $@.new
> > > +       mv -f $@.new $@
> > > +
> > > +tools_sco_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> > > +tools_iso_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> > > +tools_l2cap_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> > > +
> > > +tools_sco_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> > > +tools_iso_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> > > +tools_l2cap_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS=
)
> > > +
> > > +tools_sco_tester_LDADD +=3D $(LIBBPF_LIBS)
> > > +tools_iso_tester_LDADD +=3D $(LIBBPF_LIBS)
> > > +tools_l2cap_tester_LDADD +=3D $(LIBBPF_LIBS)
> > > +endif
> > > +
> > >  endif
> > >
> > >  if TOOLS
> > > diff --git a/configure.ac b/configure.ac
> > > index 0fa49f686..627b91e77 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -390,10 +390,38 @@ AC_ARG_ENABLE(testing, AS_HELP_STRING([--enable=
-testing],
> > >  AM_CONDITIONAL(TESTING, test "${enable_testing}" =3D "yes")
> > >
> > >  if (test "${enable_testing}" =3D "yes"); then
> > > -   AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLE=
TION],
> > > -       [], [], [[#include <time.h>
> > > -               #include <linux/errqueue.h>
> > > -               #include <linux/net_tstamp.h>]])
> > > +       AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_CO=
MPLETION],
> > > +               [], [], [[#include <time.h>
> > > +                       #include <linux/errqueue.h>
> > > +                       #include <linux/net_tstamp.h>]])
> > > +fi
> > > +
> > > +AC_ARG_ENABLE(testing-bpf, AS_HELP_STRING([--enable-testing-bpf[=3DP=
ATH/TO/VMLINUX]],
> > > +                       [enable BPF testing tools]),
> > > +                       [enable_testing_bpf=3Dyes; enable_testing_bpf=
_arg=3D${enableval}],
> > > +                       [enable_bpf=3Dno])
> > > +AM_CONDITIONAL(TESTING_BPF, test "${enable_testing_bpf}" =3D "yes")
> > > +
> > > +if (test "${enable_testing_bpf}" =3D "yes"); then
> > > +       AC_ARG_VAR(CLANG_BPF, [CLANG compiler (for BPF)])
> > > +       AC_ARG_VAR(BPFTOOL, [bpftool])
> > > +       AC_ARG_VAR(BPF_VMLINUX, [vmlinux image to use for BPF testing=
])
> > > +       AC_PATH_PROG([CLANG_BPF], [clang], "no")
> > > +       if (test "${CLANG_BPF}" =3D=3D "no"); then
> > > +               AC_MSG_ERROR([clang for BPF missing])
> > > +       fi
> > > +       AC_PATH_PROG([BPFTOOL], [bpftool], "no")
> > > +       if (test "${BPFTOOL}" =3D=3D "no"); then
> > > +               AC_MSG_ERROR([bpftool missing])
> > > +       fi
> > > +       PKG_CHECK_MODULES(LIBBPF, libbpf >=3D 1.4, [], [AC_MSG_ERROR(=
[libbpf missing])])
> > > +        if (test "${enable_testing_bpf_arg}" !=3D "yes"); then
> > > +               BPF_VMLINUX=3D${enable_testing_bpf_arg}
> > > +       elif (test "${BPF_VMLINUX}" =3D ""); then
> > > +               BPF_VMLINUX=3D/sys/kernel/btf/vmlinux
> > > +       fi
> > > +       AC_MSG_NOTICE([using BPF_VMLINUX=3D${BPF_VMLINUX} for BPF tes=
ting])
> > > +       AC_DEFINE(HAVE_BPF, 1, [Define to 1 if bpf testing is require=
d])
> > >  fi
> > >
> > >  AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
> > > diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> > > index 423a9379c..549b2bcba 100644
> > > --- a/doc/test-runner.rst
> > > +++ b/doc/test-runner.rst
> > > @@ -91,8 +91,8 @@ Bluetooth
> > >
> > >         CONFIG_UHID=3Dy
> > >
> > > -Lock debuging
> > > --------------
> > > +Lock debugging
> > > +--------------
> > >
> > >  To catch locking related issues the following set of kernel config
> > >  options may be useful:
> > > @@ -110,6 +110,19 @@ options may be useful:
> > >         CONFIG_DEBUG_MUTEXES=3Dy
> > >         CONFIG_KASAN=3Dy
> > >
> > > +BPF testing
> > > +-----------
> > > +
> > > +For BPF related tests:
> > > +
> > > +.. code-block::
> > > +
> > > +       CONFIG_BPF=3Dy
> > > +       CONFIG_BPF_JIT=3Dy
> > > +       CONFIG_CGROUPS=3Dy
> > > +       CONFIG_CGROUP_BPF=3Dy
> > > +
> > > +
> > >  EXAMPLES
> > >  =3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > @@ -127,6 +140,15 @@ Running a specific test of mgmt-tester
> > >
> > >         $ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester -=
s "<name>"
> > >
> > > +Compiling and running BPF tests
> > > +-------------------------------
> > > +
> > > +.. code-block::
> > > +
> > > +       $ ./configure --enable-testing --enable-testing-bpf=3D/home/m=
e/linux/vmlinux
> > > +       $ make
> > > +       $ tools/test-runner -k /home/me/linux/arch/x86_64/boot/bzImag=
e -- tools/iso-tester -s BPF
> > > +
> > >  Running bluetoothctl with emulated controller
> > >  ---------------------------------------------
> > >
> > > diff --git a/doc/tester.config b/doc/tester.config
> > > index 099eddc79..548e4c629 100644
> > > --- a/doc/tester.config
> > > +++ b/doc/tester.config
> > > @@ -57,3 +57,8 @@ CONFIG_PROVE_RCU=3Dy
> > >  CONFIG_LOCKDEP=3Dy
> > >  CONFIG_DEBUG_MUTEXES=3Dy
> > >  CONFIG_KASAN=3Dy
> > > +
> > > +CONFIG_BPF=3Dy
> > > +CONFIG_BPF_JIT=3Dy
> > > +CONFIG_CGROUPS=3Dy
> > > +CONFIG_CGROUP_BPF=3Dy
> > > diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> > > index 350775fdd..da164c771 100644
> > > --- a/tools/iso-tester.c
> > > +++ b/tools/iso-tester.c
> > > @@ -517,6 +517,9 @@ struct iso_client_data {
> > >
> > >         /* Disable BT_POLL_ERRQUEUE before enabling TX timestamping *=
/
> > >         bool no_poll_errqueue;
> > > +
> > > +       /* Enable BPF TX timestamping */
> > > +       bool bpf_timestamping;
> >
> > Let's keep it short, bpf_ts.
>
> Ok.
>
> [clip]
> > Btw, does BPF also use the error queue? Or better yet can we avoid
> > waiting up bluetoothd id the process/pipewire use the BPF mode to be
> > notified of packet completion?
>
> BPF timestamping does not use errqueue, so it avoids the wakeup
> problem.
>
> It's harder to deploy:
>
> - needs CAP_NET_ADMIN afaik, and to be attached to a cgroup
>
> - BPF part may need recompilation if kernel structs it uses change
> (maybe not that often since it's mostly skb_shared_info)
>
> Not so great for sound servers running as user.

Ouch, then indeed it is not that great, I thought it could be one of
the motivations why you were investing time to implement it, well I
guess it is more for the sake of completeness?

--=20
Luiz Augusto von Dentz
