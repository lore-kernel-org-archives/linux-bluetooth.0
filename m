Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFF1E1023
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436793; cv=none; b=NrHIWLYCftBuC0Bp69Bd16XAKSYDHl33/Ips9qLe9aD+U+axFFEqBol4w3W7Oear38jzR6aUR3fRs4hW3XBuNnZE70LebZyw7mWt1sd9cFjSDK8hiPZlq2ObsoTmzaJBELu2cGbdWxtgmGsN3R+hYgcUio8xfR/5KL4Qup3P7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436793; c=relaxed/simple;
	bh=Dzbn9brOjxuf583PSVzICi8eBqqH5mG0iY8UUWcFY9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFJWunaMxF1UHHB9F1I3gzOW+KIsumAJ/G2kuJAUJIBTO0OBJfzLYHnDfIWL+F+8UQQHZkxfNvWBiWKUro6H/eknXkzxLOVp6fv6HV8x/I0gySahAV7HkOo1MYaoc4Ca9i2pRh+Ro94jNBPJvElwccGFSE89zTIGsDfule9Mdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWVrXc2o; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWVrXc2o"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54954fa61c9so2798526e87.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436789; x=1744041589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyVg6YQJaMUUTzpDu7mAyVbHkkDyqxQmEJAsIwEWtoE=;
        b=PWVrXc2oOKsJVk5hpyZ6Ev4ukPyteMnHXpgQTOdklAov3bB9NlniM4SIUoTikx0sjW
         CcuhZ3BPTU9Jwd6+uv2lM0SwgYNr+czC9avbRQzEX4y+TwAzDfJ+FZxsvpMdeCoyPgOh
         a0woxBOTtMsS+dj8bUU6kWddfSmGnAqun2c9uWoyvElQk6LXcIru0zZ7kh2v/5YrGFM7
         m6cATOsPiBBjK6GqBPI64LAQJzWvUKcdnMYpO/wRlA3GhWu9eJQq491z5w3077B2sQgt
         cIO2iH2qjVnP9oijM/JB11PxSGKxrwniUjpdi/QjOw1cLcdKSw603ncQe0BMuhSIs5PA
         3U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436789; x=1744041589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyVg6YQJaMUUTzpDu7mAyVbHkkDyqxQmEJAsIwEWtoE=;
        b=qN/h1KWIZPhFeb1xn6aqDEpSWp37/5XWgwZYD7Yjn601vrE37W24E7ER5XdIxiTizv
         IThRoz6Kn1Aup8DgOChvmJuaFEZXY54e/HpL4QJIlKkUOT8CshZKl90JFl4JKidTwEkz
         nbR2CCQuhPgiiqAEV3JRQ4cTDpNE0P6DrJ12PdAHiWhIjXf/voN9xXTw8c2H5qCTtmQl
         d0/X6g/ZLleIm4EGOzzkTDG6xWi2jGrjqj116qSgHZSMVtNN+tXP8TX5wgT6crdHiJFq
         d69th4jlSYoafbJoOpAp/VV6lJC6TyfAhPF3XKBs53DT9kAgR14CFX6seeqPk7Am7AY6
         VIwA==
X-Gm-Message-State: AOJu0YzcH84OOtauWnoKw3g3a7W/k7hDS7/EnJZ3T93P2zOll4lAi2yE
	5QrLQSZVhTMPeP30kRBuZGoQaG0fthAs0NvVrEX+O8lzXevV51EjLC1N7neNow8GZ+0HBPXOy8B
	xCYxubhMm7RVE1FXIa3Qu0fuqe3EDHQ==
X-Gm-Gg: ASbGncsLewNF3EwI5NUIT7Drh+WZ1vxlXHEArDiu2AYDB+7CRW4nCCehozxRnXyOztL
	InXnRSHq4AA2m6piBxZefQf1Woa4GZC5aseuUBhgT3/F4WRuWwbVXAx7bEv0dCoi+L4SdyDVsVc
	VFu/jOihWuFzkoGQ4aDQreWA9k
X-Google-Smtp-Source: AGHT+IFu8i0iUJc4ZSCSVBTT5PLV3Lg8Yt9bnZsv0qF9dxRfIYSe3wBTueWB5fYC2tU49TChdf73X/T93xjpagApukQ=
X-Received: by 2002:a05:6512:b08:b0:549:8924:2212 with SMTP id
 2adb3069b0e04-54b10dc7dd2mr3457629e87.17.1743436788758; Mon, 31 Mar 2025
 08:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi>
In-Reply-To: <a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 31 Mar 2025 11:59:34 -0400
X-Gm-Features: AQ5f1JoTyATDhtSSdFSK7SunL5QYw4li49ZwbQErjzONi8sLmUSK8ZT3DHPG4j4
Message-ID: <CABBYNZKrq+7Jb5SFJ0NrELSEiQBY0oBdG6x9qd7HkkkRAVhhxA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools: add BPF timestamping tests
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Mar 30, 2025 at 8:16=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add some tests for BPF timestamping on Bluetooth sockets.
>
> These require additional tester kernel config, and at build time
> the vmlinux image.
>
> Add cgroup mount to test-runner.
>
> Add documentation to tester config for this.
>
> Add tests:
>
> ISO Send - TX BPF Timestamping
> ---
>
> Notes:
>     This probably needs to wait for the corresponding kernel patch series=
 to
>     settle down.
>
>  Makefile.tools      |  29 ++++++
>  configure.ac        |  36 ++++++-
>  doc/test-runner.rst |  26 ++++-
>  doc/tester.config   |   5 +
>  tools/iso-tester.c  |  71 ++++++++++++-
>  tools/test-runner.c |   1 +
>  tools/tester.bpf.c  |  92 +++++++++++++++++
>  tools/tester.bpf.h  |   7 ++

Usually we only do one . for source files, so names shall probably be
tester-bpf.{c,h}.

>  tools/tester.h      | 244 ++++++++++++++++++++++++++++++++++++--------
>  9 files changed, 463 insertions(+), 48 deletions(-)
>  create mode 100644 tools/tester.bpf.c
>  create mode 100644 tools/tester.bpf.h
>
> diff --git a/Makefile.tools b/Makefile.tools
> index e60c31b1d..a35af54fc 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -144,6 +144,7 @@ tools_l2cap_tester_SOURCES =3D tools/l2cap-tester.c t=
ools/tester.h monitor/bt.h \
>                                 emulator/smp.c
>  tools_l2cap_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +tools_l2cap_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
>
>  tools_rfcomm_tester_SOURCES =3D tools/rfcomm-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -191,6 +192,7 @@ tools_sco_tester_SOURCES =3D tools/sco-tester.c tools=
/tester.h monitor/bt.h \
>                                 emulator/smp.c
>  tools_sco_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +tools_sco_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
>
>  tools_hci_tester_SOURCES =3D tools/hci-tester.c monitor/bt.h
>  tools_hci_tester_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> @@ -212,6 +214,7 @@ tools_iso_tester_SOURCES =3D tools/iso-tester.c tools=
/tester.h monitor/bt.h \
>                                 emulator/smp.c
>  tools_iso_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +tools_iso_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
>
>  tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -221,6 +224,32 @@ tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.c =
monitor/bt.h \
>                                 emulator/smp.c
>  tools_ioctl_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +
> +if TESTING_BPF
> +tools/vmlinux.h: $(BPF_VMLINUX)
> +       bpftool btf dump file $(BPF_VMLINUX) format c > $@.new
> +       mv -f $@.new $@
> +
> +tools/tester.bpf.o: $(srcdir)/tools/tester.bpf.c tools/vmlinux.h
> +       $(CLANG_BPF) -Wall -Werror -Os -g --target=3Dbpf -Itools -c -o $@=
 $<
> +
> +tools/tester.skel.h: tools/tester.bpf.o
> +       bpftool gen skeleton $< > $@.new
> +       mv -f $@.new $@
> +
> +tools_sco_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> +tools_iso_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> +tools_l2cap_tester_SOURCES +=3D $(builddir)/tools/tester.skel.h
> +
> +tools_sco_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> +tools_iso_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> +tools_l2cap_tester_CPPFLAGS +=3D -I$(builddir)/tools $(LIBBPF_CFLAGS)
> +
> +tools_sco_tester_LDADD +=3D $(LIBBPF_LIBS)
> +tools_iso_tester_LDADD +=3D $(LIBBPF_LIBS)
> +tools_l2cap_tester_LDADD +=3D $(LIBBPF_LIBS)
> +endif
> +
>  endif
>
>  if TOOLS
> diff --git a/configure.ac b/configure.ac
> index 0fa49f686..627b91e77 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -390,10 +390,38 @@ AC_ARG_ENABLE(testing, AS_HELP_STRING([--enable-tes=
ting],
>  AM_CONDITIONAL(TESTING, test "${enable_testing}" =3D "yes")
>
>  if (test "${enable_testing}" =3D "yes"); then
> -   AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLETION=
],
> -       [], [], [[#include <time.h>
> -               #include <linux/errqueue.h>
> -               #include <linux/net_tstamp.h>]])
> +       AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLE=
TION],
> +               [], [], [[#include <time.h>
> +                       #include <linux/errqueue.h>
> +                       #include <linux/net_tstamp.h>]])
> +fi
> +
> +AC_ARG_ENABLE(testing-bpf, AS_HELP_STRING([--enable-testing-bpf[=3DPATH/=
TO/VMLINUX]],
> +                       [enable BPF testing tools]),
> +                       [enable_testing_bpf=3Dyes; enable_testing_bpf_arg=
=3D${enableval}],
> +                       [enable_bpf=3Dno])
> +AM_CONDITIONAL(TESTING_BPF, test "${enable_testing_bpf}" =3D "yes")
> +
> +if (test "${enable_testing_bpf}" =3D "yes"); then
> +       AC_ARG_VAR(CLANG_BPF, [CLANG compiler (for BPF)])
> +       AC_ARG_VAR(BPFTOOL, [bpftool])
> +       AC_ARG_VAR(BPF_VMLINUX, [vmlinux image to use for BPF testing])
> +       AC_PATH_PROG([CLANG_BPF], [clang], "no")
> +       if (test "${CLANG_BPF}" =3D=3D "no"); then
> +               AC_MSG_ERROR([clang for BPF missing])
> +       fi
> +       AC_PATH_PROG([BPFTOOL], [bpftool], "no")
> +       if (test "${BPFTOOL}" =3D=3D "no"); then
> +               AC_MSG_ERROR([bpftool missing])
> +       fi
> +       PKG_CHECK_MODULES(LIBBPF, libbpf >=3D 1.4, [], [AC_MSG_ERROR([lib=
bpf missing])])
> +        if (test "${enable_testing_bpf_arg}" !=3D "yes"); then
> +               BPF_VMLINUX=3D${enable_testing_bpf_arg}
> +       elif (test "${BPF_VMLINUX}" =3D ""); then
> +               BPF_VMLINUX=3D/sys/kernel/btf/vmlinux
> +       fi
> +       AC_MSG_NOTICE([using BPF_VMLINUX=3D${BPF_VMLINUX} for BPF testing=
])
> +       AC_DEFINE(HAVE_BPF, 1, [Define to 1 if bpf testing is required])
>  fi
>
>  AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
> diff --git a/doc/test-runner.rst b/doc/test-runner.rst
> index 423a9379c..549b2bcba 100644
> --- a/doc/test-runner.rst
> +++ b/doc/test-runner.rst
> @@ -91,8 +91,8 @@ Bluetooth
>
>         CONFIG_UHID=3Dy
>
> -Lock debuging
> --------------
> +Lock debugging
> +--------------
>
>  To catch locking related issues the following set of kernel config
>  options may be useful:
> @@ -110,6 +110,19 @@ options may be useful:
>         CONFIG_DEBUG_MUTEXES=3Dy
>         CONFIG_KASAN=3Dy
>
> +BPF testing
> +-----------
> +
> +For BPF related tests:
> +
> +.. code-block::
> +
> +       CONFIG_BPF=3Dy
> +       CONFIG_BPF_JIT=3Dy
> +       CONFIG_CGROUPS=3Dy
> +       CONFIG_CGROUP_BPF=3Dy
> +
> +
>  EXAMPLES
>  =3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -127,6 +140,15 @@ Running a specific test of mgmt-tester
>
>         $ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester -s "<=
name>"
>
> +Compiling and running BPF tests
> +-------------------------------
> +
> +.. code-block::
> +
> +       $ ./configure --enable-testing --enable-testing-bpf=3D/home/me/li=
nux/vmlinux
> +       $ make
> +       $ tools/test-runner -k /home/me/linux/arch/x86_64/boot/bzImage --=
 tools/iso-tester -s BPF
> +
>  Running bluetoothctl with emulated controller
>  ---------------------------------------------
>
> diff --git a/doc/tester.config b/doc/tester.config
> index 099eddc79..548e4c629 100644
> --- a/doc/tester.config
> +++ b/doc/tester.config
> @@ -57,3 +57,8 @@ CONFIG_PROVE_RCU=3Dy
>  CONFIG_LOCKDEP=3Dy
>  CONFIG_DEBUG_MUTEXES=3Dy
>  CONFIG_KASAN=3Dy
> +
> +CONFIG_BPF=3Dy
> +CONFIG_BPF_JIT=3Dy
> +CONFIG_CGROUPS=3Dy
> +CONFIG_CGROUP_BPF=3Dy
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index 350775fdd..da164c771 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -517,6 +517,9 @@ struct iso_client_data {
>
>         /* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
>         bool no_poll_errqueue;
> +
> +       /* Enable BPF TX timestamping */
> +       bool bpf_timestamping;

Let's keep it short, bpf_ts.

>  };
>
>  typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *i=
o,
> @@ -697,6 +700,13 @@ static void test_pre_setup(const void *test_data)
>                         return;
>         }
>
> +#ifndef HAVE_BPF
> +       if (isodata && isodata->bpf_timestamping) {
> +               if (tester_pre_setup_skip_by_default())
> +                       return;
> +       }
> +#endif
> +
>         data->mgmt =3D mgmt_new_default();
>         if (!data->mgmt) {
>                 tester_warn("Failed to setup management interface");
> @@ -738,6 +748,8 @@ static void test_post_teardown(const void *test_data)
>                           NULL, NULL, NULL);
>         }
>
> +       tx_tstamp_teardown(&data->tx_ts);
> +
>         hciemu_unref(data->hciemu);
>         data->hciemu =3D NULL;
>  }
> @@ -776,7 +788,7 @@ static void test_data_free(void *test_data)
>                 user->accept_reason =3D reason; \
>                 tester_add_full(name, data, \
>                                 test_pre_setup, setup, func, NULL, \
> -                               test_post_teardown, 2, user, test_data_fr=
ee); \
> +                               test_post_teardown, 3, user, test_data_fr=
ee); \
>         } while (0)
>
>  #define test_iso(name, data, setup, func) \
> @@ -1094,6 +1106,19 @@ static const struct iso_client_data connect_send_t=
x_no_poll_timestamping =3D {
>         .no_poll_errqueue =3D true,
>  };
>
> +static const struct iso_client_data connect_send_tx_bpf_timestamping =3D=
 {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .send =3D &send_16_2_1,
> +       .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
> +                                       SOF_TIMESTAMPING_OPT_ID |
> +                                       SOF_TIMESTAMPING_TX_SOFTWARE |
> +                                       SOF_TIMESTAMPING_TX_COMPLETION),
> +       .repeat_send =3D 1,
> +       .repeat_send_pre_ts =3D 2,
> +       .bpf_timestamping =3D true,
> +};
> +
>  static const struct iso_client_data listen_16_2_1_recv =3D {
>         .qos =3D QOS_16_2_1,
>         .expect_err =3D 0,
> @@ -2254,6 +2279,24 @@ static gboolean iso_fail_errqueue(GIOChannel *io, =
GIOCondition cond,
>         return FALSE;
>  }
>
> +static gboolean iso_bpf_io(GIOChannel *io, GIOCondition cond,
> +                                                       gpointer user_dat=
a)
> +{
> +       struct test_data *data =3D user_data;
> +       int err;
> +
> +       err =3D tx_tstamp_bpf_process(&data->tx_ts, &data->step);
> +       if (err > 0)
> +               return TRUE;
> +       else if (err)
> +               tester_test_failed();
> +       else if (!data->step)
> +               tester_test_passed();
> +
> +       data->io_id[2] =3D 0;
> +       return FALSE;
> +}
> +
>  static gboolean iso_timer_errqueue(gpointer user_data)
>  {
>         struct test_data *data =3D user_data;
> @@ -2293,7 +2336,24 @@ static void iso_tx_timestamping(struct test_data *=
data, GIOChannel *io)
>
>         sk =3D g_io_channel_unix_get_fd(io);
>
> -       if (isodata->no_poll_errqueue) {
> +       if (isodata->bpf_timestamping) {
> +               GIOChannel *bpf_io;
> +
> +               err =3D tx_tstamp_bpf_start(&data->tx_ts, sk);
> +               if (err < 0) {
> +                       tester_warn("BPF timestamping failed: %s (%d)",
> +                               strerror(-err), err);
> +                       tester_test_failed();
> +                       return;
> +               }
> +
> +               bpf_io =3D g_io_channel_unix_new(err);
> +               data->io_id[2] =3D g_io_add_watch(bpf_io,
> +                                               G_IO_IN | G_IO_ERR | G_IO=
_HUP,
> +                                               iso_bpf_io, data);
> +               g_io_channel_unref(bpf_io);
> +               return;
> +       } else if (isodata->no_poll_errqueue) {
>                 uint32_t flag =3D 0;
>
>                 err =3D setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
> @@ -2393,6 +2453,8 @@ static void iso_send(struct test_data *data, GIOCha=
nnel *io)
>         for (count =3D 0; count < isodata->repeat_send + 1; ++count)
>                 iso_send_data(data, io);
>
> +       g_io_channel_set_close_on_unref(io, FALSE);
> +
>         if (isodata->bcast) {
>                 tester_test_passed();
>                 return;
> @@ -3647,6 +3709,11 @@ int main(int argc, char *argv[])
>                         &connect_send_tx_no_poll_timestamping, setup_powe=
red,
>                         test_connect);
>
> +       /* Test TX timestamping using BPF */
> +       test_iso("ISO Send - TX BPF Timestamping",
> +                       &connect_send_tx_bpf_timestamping, setup_powered,
> +                       test_connect);
> +
>         test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powe=
red,
>                                                         test_listen);
>
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 1d770330c..84c0f90ad 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -127,6 +127,7 @@ static const struct {
>         { "tmpfs",    "/run",     "mode=3D0755", MS_NOSUID|MS_NODEV|MS_ST=
RICTATIME },
>         { "tmpfs",    "/tmp",              NULL, 0 },
>         { "debugfs",  "/sys/kernel/debug", NULL, 0 },
> +       { "cgroup2",  "/sys/fs/cgroup", NULL, 0 },
>         { }
>  };
>
> diff --git a/tools/tester.bpf.c b/tools/tester.bpf.c
> new file mode 100644
> index 000000000..9aed99aad
> --- /dev/null
> +++ b/tools/tester.bpf.c
> @@ -0,0 +1,92 @@
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#ifndef AF_BLUETOOTH
> +#define AF_BLUETOOTH 31
> +#endif
> +
> +#ifndef SOL_SOCKET
> +#define SOL_SOCKET 1
> +#endif
> +
> +#include "tester.bpf.h"
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +       __uint(max_entries, 256 * 1024);
> +} tx_tstamp_events SEC(".maps");
> +
> +static inline void tx_tstamp_event_emit(__u32 type, __u32 tskey)
> +{
> +       struct tx_tstamp_event *event;
> +
> +       event =3D bpf_ringbuf_reserve(&tx_tstamp_events, sizeof(*event), =
0);
> +       if (!event)
> +               return;
> +
> +       event->type =3D type;
> +       event->id =3D tskey;
> +       event->nsec =3D bpf_ktime_get_ns();
> +
> +       bpf_ringbuf_submit(event, 0);
> +}
> +
> +SEC("sockops")
> +int skops_sockopt(struct bpf_sock_ops *skops)
> +{
> +       struct bpf_sock *bpf_sk =3D skops->sk;
> +       struct bpf_sock_ops_kern *skops_kern;
> +       struct skb_shared_info *shinfo;
> +       const struct sk_buff *skb;
> +
> +       if (!bpf_sk)
> +               return 1;
> +
> +       if (skops->family !=3D AF_BLUETOOTH)
> +               return 1;
> +
> +       skops_kern =3D bpf_cast_to_kern_ctx(skops);
> +       skb =3D skops_kern->skb;
> +       shinfo =3D bpf_core_cast(skb->head + skb->end, struct skb_shared_=
info);
> +
> +       switch (skops->op) {
> +       case BPF_SOCK_OPS_TSTAMP_SENDMSG_CB:
> +               bpf_sock_ops_enable_tx_tstamp(skops_kern, 0);
> +               break;
> +       case BPF_SOCK_OPS_TSTAMP_SCHED_CB:
> +               tx_tstamp_event_emit(SCM_TSTAMP_SCHED, shinfo->tskey);
> +               break;
> +       case BPF_SOCK_OPS_TSTAMP_SND_SW_CB:
> +               tx_tstamp_event_emit(SCM_TSTAMP_SND, shinfo->tskey);
> +               break;
> +       case BPF_SOCK_OPS_TSTAMP_ACK_CB:
> +               tx_tstamp_event_emit(SCM_TSTAMP_ACK, shinfo->tskey);
> +               break;
> +       case BPF_SOCK_OPS_TSTAMP_COMPLETION_CB:
> +               tx_tstamp_event_emit(SCM_TSTAMP_COMPLETION, shinfo->tskey=
);
> +               break;
> +       }
> +
> +       return 1;
> +}
> +
> +SEC("cgroup/setsockopt")
> +int _setsockopt(struct bpf_sockopt *ctx)
> +{
> +       if (ctx->level =3D=3D SOL_CUSTOM_TESTER) {
> +               int flag =3D SK_BPF_CB_TX_TIMESTAMPING;
> +
> +               bpf_setsockopt(ctx->sk, SOL_SOCKET,
> +                       SK_BPF_CB_FLAGS, &flag, sizeof(flag));
> +
> +               ctx->optlen =3D -1;
> +               return 1;
> +       }
> +
> +       return 1;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/tester.bpf.h b/tools/tester.bpf.h
> new file mode 100644
> index 000000000..1b3d06bc8
> --- /dev/null
> +++ b/tools/tester.bpf.h
> @@ -0,0 +1,7 @@
> +struct tx_tstamp_event {
> +       __u32 type;
> +       __u32 id;
> +       __u64 nsec;
> +};
> +
> +#define SOL_CUSTOM_TESTER      0x89abcdef
> diff --git a/tools/tester.h b/tools/tester.h
> index 4e7d7226b..02d2f1d34 100644
> --- a/tools/tester.h
> +++ b/tools/tester.h
> @@ -11,13 +11,22 @@
>  #include <stdlib.h>
>  #include <stdint.h>
>  #include <time.h>
> +#include <fcntl.h>
> +#include <sys/stat.h>
>  #include <sys/socket.h>
>  #include <linux/errqueue.h>
>  #include <linux/net_tstamp.h>
>
>  #include <glib.h>
>
> -#define SEC_NSEC(_t)  ((_t) * 1000000000LL)
> +#ifdef HAVE_BPF
> +#include <linux/bpf.h>
> +#include <bpf/libbpf.h>
> +#include "tester.bpf.h"
> +#include "tester.skel.h"
> +#endif
> +
> +#define SEC_NSEC(_t)  ((_t) * 1000000000ULL)
>  #define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
>
>  #if !HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION
> @@ -39,6 +48,12 @@ struct tx_tstamp_data {
>         unsigned int sent;
>         uint32_t so_timestamping;
>         bool stream;
> +#ifdef HAVE_BPF
> +       struct tester_bpf *skel;
> +       struct ring_buffer *buf;
> +       int cgroup_fd;
> +       int bpf_err;
> +#endif
>  };
>
>  static inline void tx_tstamp_init(struct tx_tstamp_data *data,
> @@ -88,6 +103,51 @@ static inline int tx_tstamp_expect(struct tx_tstamp_d=
ata *data, size_t len)
>         return steps;
>  }
>
> +static inline int tx_tstamp_validate(struct tx_tstamp_data *data,
> +                               const char *source, uint32_t type, uint32=
_t id,
> +                               uint64_t nsec, uint64_t now)
> +{
> +       unsigned int i;
> +
> +       if (now < nsec || now > nsec + SEC_NSEC(10)) {
> +               tester_warn("nonsense in timestamp");
> +               return -EINVAL;
> +       }
> +
> +       if (data->pos >=3D data->count) {
> +               tester_warn("Too many timestamps");
> +               return -EINVAL;
> +       }
> +
> +       /* Find first unreceived timestamp of the right type */
> +       for (i =3D 0; i < data->count; ++i) {
> +               if (data->expect[i].type >=3D 0xffff)
> +                       continue;
> +
> +               if (type =3D=3D data->expect[i].type) {
> +                       data->expect[i].type =3D 0xffff;
> +                       break;
> +               }
> +       }
> +       if (i =3D=3D data->count) {
> +               tester_warn("Bad timestamp type %u", type);
> +               return -EINVAL;
> +       }
> +
> +       if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
> +                               id !=3D data->expect[i].id) {
> +               tester_warn("Bad timestamp id %u", id);
> +               return -EINVAL;
> +       }
> +
> +       tester_print("Got valid %s TX timestamp %u (type %u, id %u)",
> +                                                       source, i, type, =
id);
> +
> +       ++data->pos;
> +
> +       return data->count - data->pos;
> +}
> +
>  static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, in=
t len)
>  {
>         unsigned char control[512];
> @@ -99,7 +159,6 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data=
 *data, int sk, int len)
>         struct scm_timestamping *tss =3D NULL;
>         struct sock_extended_err *serr =3D NULL;
>         struct timespec now;
> -       unsigned int i;
>
>         iov.iov_base =3D buf;
>         iov.iov_len =3D sizeof(buf);
> @@ -159,42 +218,147 @@ static inline int tx_tstamp_recv(struct tx_tstamp_=
data *data, int sk, int len)
>
>         clock_gettime(CLOCK_REALTIME, &now);
>
> -       if (TS_NSEC(&now) < TS_NSEC(tss->ts) ||
> -                       TS_NSEC(&now) > TS_NSEC(tss->ts) + SEC_NSEC(10)) =
{
> -               tester_warn("nonsense in timestamp");
> -               return -EINVAL;
> -       }
> -
> -       if (data->pos >=3D data->count) {
> -               tester_warn("Too many timestamps");
> -               return -EINVAL;
> -       }
> -
> -       /* Find first unreceived timestamp of the right type */
> -       for (i =3D 0; i < data->count; ++i) {
> -               if (data->expect[i].type >=3D 0xffff)
> -                       continue;
> -
> -               if (serr->ee_info =3D=3D data->expect[i].type) {
> -                       data->expect[i].type =3D 0xffff;
> -                       break;
> -               }
> -       }
> -       if (i =3D=3D data->count) {
> -               tester_warn("Bad timestamp type %u", serr->ee_info);
> -               return -EINVAL;
> -       }
> -
> -       if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
> -                               serr->ee_data !=3D data->expect[i].id) {
> -               tester_warn("Bad timestamp id %u", serr->ee_data);
> -               return -EINVAL;
> -       }
> -
> -       tester_print("Got valid TX timestamp %u (type %u, id %u)", i,
> -                                               serr->ee_info, serr->ee_d=
ata);
> -
> -       ++data->pos;
> -
> -       return data->count - data->pos;
> +       return tx_tstamp_validate(data, "socket", serr->ee_info, serr->ee=
_data,
> +                                       TS_NSEC(tss->ts), TS_NSEC(&now));
>  }
> +
> +
> +#ifdef HAVE_BPF
> +
> +static inline int tx_tstamp_event_handler(void *ctx, void *buf, size_t s=
ize)
> +{
> +       struct tx_tstamp_data *data =3D ctx;
> +       struct tx_tstamp_event *event =3D buf;
> +       struct timespec now;
> +
> +       if (size < sizeof(*event)) {
> +               tester_warn("Bad BPF event");
> +               return -EIO;
> +       }
> +
> +       clock_gettime(CLOCK_MONOTONIC, &now);
> +
> +       data->bpf_err =3D tx_tstamp_validate(data, "BPF", event->type, ev=
ent->id,
> +                                               event->nsec, TS_NSEC(&now=
));
> +       return data->bpf_err;
> +}
> +
> +static inline int tx_tstamp_bpf_start(struct tx_tstamp_data *data, int s=
k)
> +{
> +       int flag;
> +
> +       data->cgroup_fd =3D open("/sys/fs/cgroup", O_RDONLY);
> +       if (data->cgroup_fd < 0) {
> +               tester_warn("opening cgroup failed");
> +               goto fail;
> +       }
> +
> +       data->skel =3D tester_bpf__open_and_load();
> +       if (!data->skel)
> +               goto fail;
> +
> +       data->buf =3D ring_buffer__new(
> +                       bpf_map__fd(data->skel->maps.tx_tstamp_events),
> +                       tx_tstamp_event_handler, data, NULL);
> +       if (!data->buf) {
> +               tester_warn("ringbuffer failed");
> +               goto fail;
> +       }
> +
> +       if (tester_bpf__attach(data->skel)) {
> +               tester_warn("attach failed");
> +               goto fail;
> +       }
> +
> +       data->skel->links.skops_sockopt =3D
> +               bpf_program__attach_cgroup(data->skel->progs.skops_sockop=
t,
> +                                                       data->cgroup_fd);
> +       if (!data->skel->links.skops_sockopt) {
> +               tester_warn("BFP sockops attach cgroup failed");
> +               goto fail;
> +       }
> +
> +       data->skel->links._setsockopt =3D
> +               bpf_program__attach_cgroup(data->skel->progs._setsockopt,
> +                                                       data->cgroup_fd);
> +       if (!data->skel->links._setsockopt) {
> +               tester_warn("BFP setsockopt attach cgroup failed");
> +               goto fail;
> +       }
> +
> +       flag =3D 0;
> +       if (setsockopt(sk, SOL_CUSTOM_TESTER, 0, &flag, sizeof(flag))) {
> +               tester_warn("BFP setsockopt failed");
> +               goto fail;
> +       }
> +
> +       tester_print("BPF test program attached");
> +       return ring_buffer__epoll_fd(data->buf);
> +
> +fail:
> +       if (data->buf)
> +               ring_buffer__free(data->buf);
> +       if (data->skel)
> +               tester_bpf__destroy(data->skel);
> +       if (data->cgroup_fd > 0)
> +               close(data->cgroup_fd);
> +       data->buf =3D NULL;
> +       data->skel =3D NULL;
> +       data->cgroup_fd =3D 0;
> +       return -EIO;
> +}
> +
> +static inline bool tx_tstamp_bpf_process(struct tx_tstamp_data *data, in=
t *step)
> +{
> +       int err;
> +
> +       err =3D ring_buffer__consume(data->buf);
> +       if (err < 0) {
> +               data->bpf_err =3D err;
> +       } else if (step) {
> +               if (*step >=3D err)
> +                       *step -=3D err;
> +               else
> +                       data->bpf_err =3D -E2BIG;
> +       }
> +
> +       return data->bpf_err;
> +}
> +
> +static inline void tx_tstamp_teardown(struct tx_tstamp_data *data)
> +{
> +       if (data->skel)
> +               tester_bpf__detach(data->skel);
> +       if (data->cgroup_fd > 0)
> +               close(data->cgroup_fd);
> +       if (data->buf)
> +               ring_buffer__free(data->buf);
> +       if (data->skel) {
> +               tester_bpf__destroy(data->skel);
> +               tester_print("BPF test program removed");
> +       }
> +
> +       data->buf =3D NULL;
> +       data->skel =3D NULL;
> +       data->cgroup_fd =3D 0;
> +}
> +
> +#else
> +
> +static inline int tx_tstamp_bpf_start(struct tx_tstamp_data *data, int s=
k)
> +{
> +       tester_warn("Tester compiled without BPF");
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline bool tx_tstamp_bpf_process(struct tx_tstamp_data *data, in=
t *step)
> +{
> +       return false;
> +}
> +
> +static inline void tx_tstamp_teardown(struct tx_tstamp_data *data)
> +{
> +}
> +
> +#endif
> +
> --
> 2.49.0

Btw, does BPF also use the error queue? Or better yet can we avoid
waiting up bluetoothd id the process/pipewire use the BPF mode to be
notified of packet completion?

--=20
Luiz Augusto von Dentz
