Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3D2144DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438512; cv=pass; b=ZVRhwbhG3IRjkjYM2XXtidcOfewh0nqzJQNTbUEUcj/KVhVn/hCpf4WKA1u8ecd162//dEn7sH2Yw8MrQbE2JmmOLaYsMet9DGjWfsJvLhaZmH7bggZxAdNb1YHKg8mK3afJgQeb/N2MBUS3EqlMpxqeVCGSbaBRWqrA7HPq79U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438512; c=relaxed/simple;
	bh=h/Yt0vYaKAjtREK5UJWS97/He+T2SeYH9wVerNU+TYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQGgB/8wlQ8zgEx1CFJcyeGIe/BsKlqQyKzXFzFJtrt/wQF5HF0DuY2RH3wqDIcb1bqYRo0m3FU4jXLwgT7UMQdZUdSJsfKdZ/wz5IVJ+RThIBHG0dXsH6KyHy1yGNbY/5NNVUqID0u6/fjxVyor5xnOOhlB6L4fra8u5jNjN5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=E+TyvSoS; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="E+TyvSoS"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZRGlN3clpz49PyJ;
	Mon, 31 Mar 2025 19:28:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743438496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ob2yRyGdVdth3b22z5xauAkHyongTDM5bcugc5rPwuc=;
	b=E+TyvSoSL8osBLan3izzOZgl3kJTdUdNfrMqCY0bZMqxKQ1gLnyTuwjsynCz2pBnDGBwXV
	UjGn7GYY7ZlQbRs+g5m56IweVs6QiuLykj8H5I3xxb+Z2h4O+7uvlWfcFOOAYy/VLZWVkK
	3rgwlCY0ocM/D2iucdhUl4d7SuRetHtag0Lz1gYrr4dUwjTBuByyQKMR+dNDXRrlzMmEcH
	RZtrO3vrjI25iTHNuiEUA2gPZnBqXHVkVLzG5NraQpsIw8nBz31jSp1DTnSYplNWoHQJMV
	58bfJD39QkvlBgFHvZV5BGeihFRO+V4eGHdcSK/L8Xnx6KkRdVHnCoCnNmg7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743438496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ob2yRyGdVdth3b22z5xauAkHyongTDM5bcugc5rPwuc=;
	b=CbBBCBW7aoiLiV/bAyt/Lh7FiOTvM+or4GLmxzyg3hCOQlwdY5CAzR98TCj+m48z0ghTb0
	192cqA/UNC9/upvDx05mmmXVzn1wnMmd/I+LGtNEeOLBAJkpv2HDbbwyAV0+Wl+ksvlsx0
	+VhS/tQIcsxYZ3bBPAaqrl6GnPdDJmquzM6uotXDpsp/yNTtalS3zIxLDaXScENbOfU49K
	TXrFPaqpNaHXxgiLYdga+TdAT33I9qJDgoWMGZcj3oiEnkY7EJgHr3SgPgO/JlkkwEDYAP
	v45cDplaiLrKOunvm2ovpTS5LNfEb65gQZl+7KP6zhY3zvtNZORDf4iVngccug==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743438496; a=rsa-sha256;
	cv=none;
	b=kBKvXFMQzE6ae4wOjeblkYE7uDsmmmzemGe74jwrD05CRlTXKNw57l7Ttzvu7/2jd3gbfk
	g6xsB+Lko1RKm5bUf2/Mg04xfPqWfryiolJ2XGJsB8sACbgDyDviQx0wtyrQZV8kV21peW
	ts4SVWTIIdfAzTVD3wPULQchJf+O9aV/9x8s9rH0gO7c00GEq92s1M0kHKBfEp0TPPzUUf
	DQqyLq9MRdihcqKmJ37wr+UIm5M/aVodciXstEHU/KSCYha+nuNTlKV57gkLFQYuDg0/aQ
	7TQz46S90lEGWH53nlDe104qLhJ3v7wuL4X2mL3pCWJZghUxxbj0vDjGPE1VMw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <e40a83725842a54cc8b363b687b6fa030a98e422.camel@iki.fi>
Subject: Re: [PATCH BlueZ] tools: add BPF timestamping tests
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 31 Mar 2025 19:28:14 +0300
In-Reply-To: <CABBYNZKrq+7Jb5SFJ0NrELSEiQBY0oBdG6x9qd7HkkkRAVhhxA@mail.gmail.com>
References: 
	<a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi>
	 <CABBYNZKrq+7Jb5SFJ0NrELSEiQBY0oBdG6x9qd7HkkkRAVhhxA@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-03-31 kello 11:59 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Mar 30, 2025 at 8:16=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add some tests for BPF timestamping on Bluetooth sockets.
> >=20
> > These require additional tester kernel config, and at build time
> > the vmlinux image.
> >=20
> > Add cgroup mount to test-runner.
> >=20
> > Add documentation to tester config for this.
> >=20
> > Add tests:
> >=20
> > ISO Send - TX BPF Timestamping
> > ---
> >=20
> > Notes:
> >     This probably needs to wait for the corresponding kernel patch seri=
es to
> >     settle down.
> >=20
> >  Makefile.tools      |  29 ++++++
> >  configure.ac        |  36 ++++++-
> >  doc/test-runner.rst |  26 ++++-
> >  doc/tester.config   |   5 +
> >  tools/iso-tester.c  |  71 ++++++++++++-
> >  tools/test-runner.c |   1 +
> >  tools/tester.bpf.c  |  92 +++++++++++++++++
> >  tools/tester.bpf.h  |   7 ++
>=20
> Usually we only do one . for source files, so names shall probably be
> tester-bpf.{c,h}.

Ok. The .bpf.c convention was used used in some places.

> >  tools/tester.h      | 244 ++++++++++++++++++++++++++++++++++++--------
> >  9 files changed, 463 insertions(+), 48 deletions(-)
> >  create mode 100644 tools/tester.bpf.c
> >  create mode 100644 tools/tester.bpf.h
> >=20
> > diff --git a/Makefile.tools b/Makefile.tools
> > index e60c31b1d..a35af54fc 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -144,6 +144,7 @@ tools_l2cap_tester_SOURCES =3D tools/l2cap-tester.c=
 tools/tester.h monitor/bt.h \
> >                                 emulator/smp.c
> >  tools_l2cap_tester_LDADD =3D lib/libbluetooth-internal.la \
> >                                 src/libshared-glib.la $(GLIB_LIBS)
> > +tools_l2cap_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> >=20
> >  tools_rfcomm_tester_SOURCES =3D tools/rfcomm-tester.c monitor/bt.h \
> >                                 emulator/hciemu.h emulator/hciemu.c \
> > @@ -191,6 +192,7 @@ tools_sco_tester_SOURCES =3D tools/sco-tester.c too=
ls/tester.h monitor/bt.h \
> >                                 emulator/smp.c
> >  tools_sco_tester_LDADD =3D lib/libbluetooth-internal.la \
> >                                 src/libshared-glib.la $(GLIB_LIBS)
> > +tools_sco_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> >=20
> >  tools_hci_tester_SOURCES =3D tools/hci-tester.c monitor/bt.h
> >  tools_hci_tester_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> > @@ -212,6 +214,7 @@ tools_iso_tester_SOURCES =3D tools/iso-tester.c too=
ls/tester.h monitor/bt.h \
> >                                 emulator/smp.c
> >  tools_iso_tester_LDADD =3D lib/libbluetooth-internal.la \
> >                                 src/libshared-glib.la $(GLIB_LIBS)
> > +tools_iso_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> >=20
> >  tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.c monitor/bt.h \
> >                                 emulator/hciemu.h emulator/hciemu.c \
> > @@ -221,6 +224,32 @@ tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.=
c monitor/bt.h \
> >                                 emulator/smp.c
> >  tools_ioctl_tester_LDADD =3D lib/libbluetooth-internal.la \
> >                                 src/libshared-glib.la $(GLIB_LIBS)
> > +
> > +if TESTING_BPF
> > +tools/vmlinux.h: $(BPF_VMLINUX)
> > +       bpftool btf dump file $(BPF_VMLINUX) format c > $@.new
> > +       mv -f $@.new $@
> > +
> > +tools/tester.bpf.o: $(srcdir)/tools/tester.bpf.c tools/vmlinux.h
> > +       $(CLANG_BPF) -Wall -Werror -Os -g --target=3Dbpf -Itools -c -o =
$@ $<
> > +
> > +tools/tester.skel.h: tools/tester.bpf.o
> > +       bpftool gen skeleton $< > $@.new
> > +       mv -f $@.new $@
> > +
> > +tools_sco_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> > +tools_iso_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> > +tools_l2cap_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> > +
> > +tools_sco_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> > +tools_iso_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> > +tools_l2cap_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> > +
> > +tools_sco_tester_LDADD +=3D $(LIBBPF_LIBS)
> > +tools_iso_tester_LDADD +=3D $(LIBBPF_LIBS)
> > +tools_l2cap_tester_LDADD +=3D $(LIBBPF_LIBS)
> > +endif
> > +
> >  endif
> >=20
> >  if TOOLS
> > diff --git a/configure.ac b/configure.ac
> > index 0fa49f686..627b91e77 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -390,10 +390,38 @@ AC_ARG_ENABLE(testing, AS_HELP_STRING([--enable-t=
esting],
> >  AM_CONDITIONAL(TESTING, test "${enable_testing}" =3D "yes")
> >=20
> >  if (test "${enable_testing}" =3D "yes"); then
> > -   AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLETI=
ON],
> > -       [], [], [[#include <time.h>
> > -               #include <linux/errqueue.h>
> > -               #include <linux/net_tstamp.h>]])
> > +       AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMP=
LETION],
> > +               [], [], [[#include <time.h>
> > +                       #include <linux/errqueue.h>
> > +                       #include <linux/net_tstamp.h>]])
> > +fi
> > +
> > +AC_ARG_ENABLE(testing-bpf, AS_HELP_STRING([--enable-testing-bpf[=3DPAT=
H/TO/VMLINUX]],
> > +                       [enable BPF testing tools]),
> > +                       [enable_testing_bpf=3Dyes; enable_testing_bpf_a=
rg=3D${enableval}],
> > +                       [enable_bpf=3Dno])
> > +AM_CONDITIONAL(TESTING_BPF, test "${enable_testing_bpf}" =3D "yes")
> > +
> > +if (test "${enable_testing_bpf}" =3D "yes"); then
> > +       AC_ARG_VAR(CLANG_BPF, [CLANG compiler (for BPF)])
> > +       AC_ARG_VAR(BPFTOOL, [bpftool])
> > +       AC_ARG_VAR(BPF_VMLINUX, [vmlinux image to use for BPF testing])
> > +       AC_PATH_PROG([CLANG_BPF], [clang], "no")
> > +       if (test "${CLANG_BPF}" =3D=3D "no"); then
> > +               AC_MSG_ERROR([clang for BPF missing])
> > +       fi
> > +       AC_PATH_PROG([BPFTOOL], [bpftool], "no")
> > +       if (test "${BPFTOOL}" =3D=3D "no"); then
> > +               AC_MSG_ERROR([bpftool missing])
> > +       fi
> > +       PKG_CHECK_MODULES(LIBBPF, libbpf >=3D 1.4, [], [AC_MSG_ERROR([l=
ibbpf missing])])
> > +        if (test "${enable_testing_bpf_arg}" !=3D "yes"); then
> > +               BPF_VMLINUX=3D${enable_testing_bpf_arg}
> > +       elif (test "${BPF_VMLINUX}" =3D ""); then
> > +               BPF_VMLINUX=3D/sys/kernel/btf/vmlinux
> > +       fi
> > +       AC_MSG_NOTICE([using BPF_VMLINUX=3D${BPF_VMLINUX} for BPF testi=
ng])
> > +       AC_DEFINE(HAVE_BPF, 1, [Define to 1 if bpf testing is required]=
)
> >  fi
> >=20
> >  AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
> > diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> > index 423a9379c..549b2bcba 100644
> > --- a/doc/test-runner.rst
> > +++ b/doc/test-runner.rst
> > @@ -91,8 +91,8 @@ Bluetooth
> >=20
> >         CONFIG_UHID=3Dy
> >=20
> > -Lock debuging
> > --------------
> > +Lock debugging
> > +--------------
> >=20
> >  To catch locking related issues the following set of kernel config
> >  options may be useful:
> > @@ -110,6 +110,19 @@ options may be useful:
> >         CONFIG_DEBUG_MUTEXES=3Dy
> >         CONFIG_KASAN=3Dy
> >=20
> > +BPF testing
> > +-----------
> > +
> > +For BPF related tests:
> > +
> > +.. code-block::
> > +
> > +       CONFIG_BPF=3Dy
> > +       CONFIG_BPF_JIT=3Dy
> > +       CONFIG_CGROUPS=3Dy
> > +       CONFIG_CGROUP_BPF=3Dy
> > +
> > +
> >  EXAMPLES
> >  =3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > @@ -127,6 +140,15 @@ Running a specific test of mgmt-tester
> >=20
> >         $ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester -s =
"<name>"
> >=20
> > +Compiling and running BPF tests
> > +-------------------------------
> > +
> > +.. code-block::
> > +
> > +       $ ./configure --enable-testing --enable-testing-bpf=3D/home/me/=
linux/vmlinux
> > +       $ make
> > +       $ tools/test-runner -k /home/me/linux/arch/x86_64/boot/bzImage =
-- tools/iso-tester -s BPF
> > +
> >  Running bluetoothctl with emulated controller
> >  ---------------------------------------------
> >=20
> > diff --git a/doc/tester.config b/doc/tester.config
> > index 099eddc79..548e4c629 100644
> > --- a/doc/tester.config
> > +++ b/doc/tester.config
> > @@ -57,3 +57,8 @@ CONFIG_PROVE_RCU=3Dy
> >  CONFIG_LOCKDEP=3Dy
> >  CONFIG_DEBUG_MUTEXES=3Dy
> >  CONFIG_KASAN=3Dy
> > +
> > +CONFIG_BPF=3Dy
> > +CONFIG_BPF_JIT=3Dy
> > +CONFIG_CGROUPS=3Dy
> > +CONFIG_CGROUP_BPF=3Dy
> > diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> > index 350775fdd..da164c771 100644
> > --- a/tools/iso-tester.c
> > +++ b/tools/iso-tester.c
> > @@ -517,6 +517,9 @@ struct iso_client_data {
> >=20
> >         /* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
> >         bool no_poll_errqueue;
> > +
> > +       /* Enable BPF TX timestamping */
> > +       bool bpf_timestamping;
>=20
> Let's keep it short, bpf_ts.

Ok.

[clip]
> Btw, does BPF also use the error queue? Or better yet can we avoid
> waiting up bluetoothd id the process/pipewire use the BPF mode to be
> notified of packet completion?

BPF timestamping does not use errqueue, so it avoids the wakeup
problem.

It's harder to deploy:

-=C2=A0needs CAP_NET_ADMIN afaik, and to be attached to a cgroup

- BPF part may need recompilation if kernel structs it uses change
(maybe not that often since it's mostly skb_shared_info)

Not so great for sound servers running as user.

--=20
Pauli Virtanen
