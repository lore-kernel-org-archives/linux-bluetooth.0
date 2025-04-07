Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47115C158
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033475; cv=none; b=uj3sj4JhCjd1P3rKFScDDhicu+hH6OvWeuGxSRIp2rC+vO8y4R/gBAr43BMN5bnfjdC684EAzoYbbYcBEGbgNSfhCGKOLVjdMIXY2tmaHjUF2zrLqJi8OVIBCDfiZ1xSyJZ99WG6FtIuPgrSNNIo6IZljFlvxBN3PN5taskK4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033475; c=relaxed/simple;
	bh=tXEnuRvaEP+k+BCNvC7ntWemRFMpYvqAElYz7gaqCvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW6736oSkNwbSaSeXBZGYBlWXWpJOYY1G8v8z4YnlvEZIp2e5b9plU6QdMhLoUIzYRHAGHXzXsc7LsJflM5JucR+TWsGFjHB7iU+34U4L44LIQRIww+aYJnTJDl1f1nmS1OrRmIvuM3UuB5/GvSMHK3cILrKuBqIj1O1J175WnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZT0sjNz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZT0sjNz"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30eef9ce7feso44970331fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Apr 2025 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744033471; x=1744638271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2Wc+s/cUpai22J6QxaOJ4EpDn+osmSFnrhaeVanLs4=;
        b=DZT0sjNzyg0zhRPCuZMFqsUGWEAGuiBx+LhpgLRMYa/llC72BUZP4A7qTe0pyMOsIG
         pn1XOJ9IUWouK/tdqdUBxGKkpuwgChWORjR1VgylnQthbWBPknP0wGynwUHtB0FyhgqP
         fMijx5bfFVw1x6fcc8kOICXcr+BT1eJ6Elv32c223aHteXpLnPiiTMukFuc0mI32Ujkh
         vi/XLEEeSghlP/KZtswuwHt8vey05Nmzd2Yt8Szc+X1sEBo40hLE3iYajmHlkpql6TFI
         vVO61e2jqKCL/DdokwfFs9hkDtzg5qp5+DJUr94WXxpd9PRBYHusUm5xunI8nkuhzhMz
         RYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033471; x=1744638271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2Wc+s/cUpai22J6QxaOJ4EpDn+osmSFnrhaeVanLs4=;
        b=npQJGdDxKAsGMGMWXg6dIOg+XAWMB6Ku/mGJjy1VvRl4/c1XQYxwvvcgIQ9h7YwurI
         Ic+1Tx3s0irKTngtfnR4EOwsnrjqX5gEbvF+5tjeva0YGShP9FGyTX7DpTkpFPLu2G3d
         OFvMDcRXF1dFZs+dCqVms9UdacWTf6aWX2Y3FwYOK2zs8c26/yqTUu4mCRemHNFExf1H
         8U8Moqts4bDP3YP3seNJcBLxtcCEYVxTnmKWpJheBrlhmutsVAV2FlYAx31DYupV+sFm
         YUU9DagwI0YLE/bRrzPtTERLfgE+Nm83tSGg89U94A5s+8nny+RmeCsqfKfP+vxKsRtq
         dahQ==
X-Gm-Message-State: AOJu0YwiFbPm5TBsb/fKGgXeI4mIXx+6iM06PAhpPJsjL9tkPlEaOIgt
	CzAKg/knoafRnjfT3eO7Ha28YSmwAlMWamXe6oYS4fbXSruPflM3bIM3N2WpjGqxwfpZ3037K+O
	ra9g18QVb/BILMNOkA2kG/4ndG7SCXw==
X-Gm-Gg: ASbGncvC1RJgBFMAM5uF5F9WlW4GqUGaR44ac4MQNW5xvvVgvDmdd591N5/Cjt3FLiS
	89gOnh60NO2DxIuSu+XOzb68ElgK1khd61uxUKoWiPci3kzHqfedeSIS9g9lsx9D5p6UeQKiKl6
	I1VGQ3ZyNA+YBMgRFbL5HLhIze
X-Google-Smtp-Source: AGHT+IHIIplFpUv2ojd8RsyBQ4BQg/47412IYkbAg+NTIyFbbQbVYSUKPNx7Yjwj2rG7sC0X0zbpkf6hhMX8aR+8M8s=
X-Received: by 2002:a05:651c:510:b0:30d:69cd:ddcf with SMTP id
 38308e7fff4ca-30f0a025e8fmr38951151fa.0.1744033470691; Mon, 07 Apr 2025
 06:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <632807049a6b64e11103b95163ffa5de8f18a4ed.1743846534.git.pav@iki.fi>
In-Reply-To: <632807049a6b64e11103b95163ffa5de8f18a4ed.1743846534.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Apr 2025 09:44:18 -0400
X-Gm-Features: ATxdqUEoi8PiCmNAQq_limpbkHoxYgvL9JxURpoRD9WrP1gMzFDWJ8bpIb2KuVM
Message-ID: <CABBYNZKFtmi1LDABw+ysA-0o0E0ME_KwkPbUxJAaaov8pQP+mw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] tools: add BPF timestamping tests
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Apr 5, 2025 at 5:50=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
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
> ISO Send - TX BPF + Socket Timestamping
> ---
>
> Notes:
>     v2:
>     - automake: nodist, BUILD_SOURCES, CLEANFILES, silence output
>     - fix return type of tx_tstamp_bpf_process
>     - separate timestamp tracking for socket & BPF, add test enabling bot=
h
>     - match BPF tskey handling to the current plan
>
>  Makefile.tools       |  39 +++++++
>  configure.ac         |  36 +++++-
>  doc/test-runner.rst  |  28 ++++-
>  doc/tester.config    |   8 ++
>  tools/iso-tester.c   |  97 +++++++++++++++-
>  tools/l2cap-tester.c |   2 +-
>  tools/sco-tester.c   |   2 +-
>  tools/test-runner.c  |   1 +
>  tools/tester-bpf.c   | 101 +++++++++++++++++
>  tools/tester-bpf.h   |   7 ++
>  tools/tester.h       | 264 ++++++++++++++++++++++++++++++++++++-------

Might be a good idea to split into separate patches, e.g. enable BPF
build then introduce tester-bpf, test-runner followed by the new
tests.

>  11 files changed, 531 insertions(+), 54 deletions(-)
>  create mode 100644 tools/tester-bpf.c
>  create mode 100644 tools/tester-bpf.h
>
> diff --git a/Makefile.tools b/Makefile.tools
> index e60c31b1d..75bd3daaf 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -144,6 +144,8 @@ tools_l2cap_tester_SOURCES =3D tools/l2cap-tester.c t=
ools/tester.h monitor/bt.h \
>                                 emulator/smp.c
>  tools_l2cap_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +tools_l2cap_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> +nodist_tools_l2cap_tester_SOURCES =3D
>
>  tools_rfcomm_tester_SOURCES =3D tools/rfcomm-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -191,6 +193,8 @@ tools_sco_tester_SOURCES =3D tools/sco-tester.c tools=
/tester.h monitor/bt.h \
>                                 emulator/smp.c
>  tools_sco_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +tools_sco_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> +nodist_tools_sco_tester_SOURCES =3D
>
>  tools_hci_tester_SOURCES =3D tools/hci-tester.c monitor/bt.h
>  tools_hci_tester_LDADD =3D src/libshared-glib.la $(GLIB_LIBS)
> @@ -212,6 +216,8 @@ tools_iso_tester_SOURCES =3D tools/iso-tester.c tools=
/tester.h monitor/bt.h \
>                                 emulator/smp.c
>  tools_iso_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +tools_iso_tester_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS)
> +nodist_tools_iso_tester_SOURCES =3D
>
>  tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.c monitor/bt.h \
>                                 emulator/hciemu.h emulator/hciemu.c \
> @@ -221,6 +227,39 @@ tools_ioctl_tester_SOURCES =3D tools/ioctl-tester.c =
monitor/bt.h \
>                                 emulator/smp.c
>  tools_ioctl_tester_LDADD =3D lib/libbluetooth-internal.la \
>                                 src/libshared-glib.la $(GLIB_LIBS)
> +
> +if TESTING_BPF
> +tools/vmlinux.h: $(BPF_VMLINUX)
> +       $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> +               bpftool btf dump file $(BPF_VMLINUX) format c > $@.new &&=
 \
> +               mv -f $@.new $@
> +
> +tools/tester-bpf.o: $(srcdir)/tools/tester-bpf.c tools/vmlinux.h
> +       $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> +               $(CLANG_BPF) -Wall -Werror -Os -g --target=3Dbpf -Itools =
-c -o $@ $<
> +
> +tools/tester-skel.h: tools/tester-bpf.o
> +       $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> +               bpftool gen skeleton $< > $@.new && \
> +               mv -f $@.new $@
> +
> +BPF_BUILT_SOURCES =3D $(builddir)/tools/tester-skel.h $(builddir)/tools/=
vmlinux.h
> +
> +nodist_tools_sco_tester_SOURCES +=3D $(BPF_BUILT_SOURCES)
> +nodist_tools_iso_tester_SOURCES +=3D $(BPF_BUILT_SOURCES)
> +nodist_tools_l2cap_tester_SOURCES +=3D $(BPF_BUILT_SOURCES)
> +BUILT_SOURCES +=3D $(BPF_BUILT_SOURCES)
> +CLEANFILES +=3D $(BPF_BUILT_SOURCES)
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
> index 2ea727256..6f09e248f 100644
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
> +       if (test "${enable_testing_bpf_arg}" !=3D "yes"); then
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
> index 423a9379c..09fb4b248 100644
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
> @@ -110,6 +110,21 @@ options may be useful:
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
> +       CONFIG_BPF_SYSCALL=3Dy
> +       CONFIG_BPF_JIT=3Dy
> +       CONFIG_CGROUPS=3Dy
> +       CONFIG_CGROUP_BPF=3Dy
> +       CONFIG_DEBUG_INFO_DWARF5=3Dy
> +       CONFIG_DEBUG_INFO_BTF=3Dy
> +
>  EXAMPLES
>  =3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -127,6 +142,15 @@ Running a specific test of mgmt-tester
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
> index 099eddc79..70e345c52 100644
> --- a/doc/tester.config
> +++ b/doc/tester.config
> @@ -57,3 +57,11 @@ CONFIG_PROVE_RCU=3Dy
>  CONFIG_LOCKDEP=3Dy
>  CONFIG_DEBUG_MUTEXES=3Dy
>  CONFIG_KASAN=3Dy
> +
> +CONFIG_BPF=3Dy
> +CONFIG_BPF_SYSCALL=3Dy
> +CONFIG_BPF_JIT=3Dy
> +CONFIG_CGROUPS=3Dy
> +CONFIG_CGROUP_BPF=3Dy
> +CONFIG_DEBUG_INFO_DWARF5=3Dy
> +CONFIG_DEBUG_INFO_BTF=3Dy
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index 350775fdd..858321730 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -471,12 +471,13 @@ struct test_data {
>         uint16_t handle;
>         uint16_t acl_handle;
>         struct queue *io_queue;
> -       unsigned int io_id[4];
> +       unsigned int io_id[5];
>         uint8_t client_num;
>         int step;
>         bool reconnect;
>         bool suspending;
>         struct tx_tstamp_data tx_ts;
> +       struct tx_tstamp_data bpf_tx_ts;
>  };
>
>  struct iso_client_data {
> @@ -517,6 +518,9 @@ struct iso_client_data {
>
>         /* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
>         bool no_poll_errqueue;
> +
> +       /* Enable BPF TX timestamping */
> +       bool bpf_ts;
>  };
>
>  typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *i=
o,
> @@ -697,6 +701,13 @@ static void test_pre_setup(const void *test_data)
>                         return;
>         }
>
> +#ifndef HAVE_BPF
> +       if (isodata && isodata->bpf_ts) {
> +               if (tester_pre_setup_skip_by_default())
> +                       return;
> +       }
> +#endif
> +
>         data->mgmt =3D mgmt_new_default();
>         if (!data->mgmt) {
>                 tester_warn("Failed to setup management interface");
> @@ -738,6 +749,9 @@ static void test_post_teardown(const void *test_data)
>                           NULL, NULL, NULL);
>         }
>
> +       tx_tstamp_teardown(&data->tx_ts);
> +       tx_tstamp_teardown(&data->bpf_tx_ts);
> +
>         hciemu_unref(data->hciemu);
>         data->hciemu =3D NULL;
>  }
> @@ -776,7 +790,7 @@ static void test_data_free(void *test_data)
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
> @@ -1094,6 +1108,29 @@ static const struct iso_client_data connect_send_t=
x_no_poll_timestamping =3D {
>         .no_poll_errqueue =3D true,
>  };
>
> +static const struct iso_client_data connect_send_tx_bpf_timestamping =3D=
 {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .send =3D &send_16_2_1,
> +       .so_timestamping =3D 0,
> +       .repeat_send =3D 1,
> +       .repeat_send_pre_ts =3D 2,
> +       .bpf_ts =3D true,
> +};
> +
> +static const struct iso_client_data connect_send_tx_bpf_sk_timestamping =
=3D {
> +       .qos =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .send =3D &send_16_2_1,
> +       .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
> +                                       SOF_TIMESTAMPING_OPT_ID |
> +                                       SOF_TIMESTAMPING_TX_SOFTWARE |
> +                                       SOF_TIMESTAMPING_TX_COMPLETION),
> +       .repeat_send =3D 1,
> +       .repeat_send_pre_ts =3D 2,
> +       .bpf_ts =3D true,
> +};
> +
>  static const struct iso_client_data listen_16_2_1_recv =3D {
>         .qos =3D QOS_16_2_1,
>         .expect_err =3D 0,
> @@ -2254,6 +2291,24 @@ static gboolean iso_fail_errqueue(GIOChannel *io, =
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
> +       err =3D tx_tstamp_bpf_process(&data->bpf_tx_ts, &data->step);
> +       if (err > 0)
> +               return TRUE;
> +       else if (err)
> +               tester_test_failed();
> +       else if (!data->step)
> +               tester_test_passed();
> +
> +       data->io_id[4] =3D 0;
> +       return FALSE;
> +}
> +
>  static gboolean iso_timer_errqueue(gpointer user_data)
>  {
>         struct test_data *data =3D user_data;
> @@ -2281,18 +2336,40 @@ static void iso_tx_timestamping(struct test_data =
*data, GIOChannel *io)
>         int err;
>         unsigned int count;
>
> -       if (!(isodata->so_timestamping & TS_TX_RECORD_MASK))
> +       if (!(isodata->so_timestamping & TS_TX_RECORD_MASK) && !isodata->=
bpf_ts)
>                 return;
>
>         tester_print("Enabling TX timestamping");
>
> -       tx_tstamp_init(&data->tx_ts, isodata->so_timestamping, false);
> +       tx_tstamp_init(&data->tx_ts, isodata->so_timestamping, false, fal=
se);
> +       tx_tstamp_init(&data->bpf_tx_ts, isodata->so_timestamping, false,=
 true);
>
> -       for (count =3D 0; count < isodata->repeat_send + 1; ++count)
> +       for (count =3D 0; count < isodata->repeat_send + 1; ++count) {
>                 data->step +=3D tx_tstamp_expect(&data->tx_ts, 0);
> +               if (isodata->bpf_ts)
> +                       data->step +=3D tx_tstamp_expect(&data->bpf_tx_ts=
, 0);
> +       }
>
>         sk =3D g_io_channel_unix_get_fd(io);
>
> +       if (isodata->bpf_ts) {
> +               GIOChannel *bpf_io;
> +
> +               err =3D tx_tstamp_bpf_start(&data->bpf_tx_ts, sk);
> +               if (err < 0) {
> +                       tester_warn("BPF timestamping failed: %s (%d)",
> +                               strerror(-err), err);
> +                       tester_test_failed();
> +                       return;
> +               }
> +
> +               bpf_io =3D g_io_channel_unix_new(err);
> +               data->io_id[4] =3D g_io_add_watch(bpf_io,
> +                                               G_IO_IN | G_IO_ERR | G_IO=
_HUP,
> +                                               iso_bpf_io, data);
> +               g_io_channel_unref(bpf_io);
> +       }
> +
>         if (isodata->no_poll_errqueue) {
>                 uint32_t flag =3D 0;
>
> @@ -2393,6 +2470,8 @@ static void iso_send(struct test_data *data, GIOCha=
nnel *io)
>         for (count =3D 0; count < isodata->repeat_send + 1; ++count)
>                 iso_send_data(data, io);
>
> +       g_io_channel_set_close_on_unref(io, FALSE);
> +
>         if (isodata->bcast) {
>                 tester_test_passed();
>                 return;
> @@ -3647,6 +3726,14 @@ int main(int argc, char *argv[])
>                         &connect_send_tx_no_poll_timestamping, setup_powe=
red,
>                         test_connect);
>
> +       /* Test TX timestamping using BPF */
> +       test_iso("ISO Send - TX BPF Timestamping",
> +                       &connect_send_tx_bpf_timestamping, setup_powered,
> +                       test_connect);
> +       test_iso("ISO Send - TX BPF + Socket Timestamping",
> +                       &connect_send_tx_bpf_sk_timestamping, setup_power=
ed,
> +                       test_connect);
> +
>         test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powe=
red,
>                                                         test_listen);
>
> diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
> index 41ef62578..350823a01 100644
> --- a/tools/l2cap-tester.c
> +++ b/tools/l2cap-tester.c
> @@ -1382,7 +1382,7 @@ static void l2cap_tx_timestamping(struct test_data =
*data, GIOChannel *io)
>         tester_print("Enabling TX timestamping");
>
>         tx_tstamp_init(&data->tx_ts, l2data->so_timestamping,
> -                                       l2data->sock_type =3D=3D SOCK_STR=
EAM);
> +                               l2data->sock_type =3D=3D SOCK_STREAM, fal=
se);
>
>         for (count =3D 0; count < l2data->repeat_send + 1; ++count)
>                 data->step +=3D tx_tstamp_expect(&data->tx_ts, l2data->da=
ta_len);
> diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> index 650f8bab3..0b234b37b 100644
> --- a/tools/sco-tester.c
> +++ b/tools/sco-tester.c
> @@ -767,7 +767,7 @@ static void sco_tx_timestamping(struct test_data *dat=
a, GIOChannel *io)
>
>         tester_print("Enabling TX timestamping");
>
> -       tx_tstamp_init(&data->tx_ts, scodata->so_timestamping, false);
> +       tx_tstamp_init(&data->tx_ts, scodata->so_timestamping, false, fal=
se);
>
>         for (count =3D 0; count < scodata->repeat_send + 1; ++count)
>                 data->step +=3D tx_tstamp_expect(&data->tx_ts, 0);
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
> diff --git a/tools/tester-bpf.c b/tools/tester-bpf.c
> new file mode 100644
> index 000000000..dcea6cc87
> --- /dev/null
> +++ b/tools/tester-bpf.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2025  Pauli Virtanen
> + *
> + */
> +
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
> +#include "tester-bpf.h"
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
> diff --git a/tools/tester-bpf.h b/tools/tester-bpf.h
> new file mode 100644
> index 000000000..1b3d06bc8
> --- /dev/null
> +++ b/tools/tester-bpf.h
> @@ -0,0 +1,7 @@
> +struct tx_tstamp_event {
> +       __u32 type;
> +       __u32 id;
> +       __u64 nsec;
> +};
> +
> +#define SOL_CUSTOM_TESTER      0x89abcdef
> diff --git a/tools/tester.h b/tools/tester.h
> index 4e7d7226b..16816fb6e 100644
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
> +#include "tester-bpf.h"
> +#include "tester-skel.h"
> +#endif
> +
> +#define SEC_NSEC(_t)  ((_t) * 1000000000ULL)
>  #define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
>
>  #if !HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION
> @@ -39,16 +48,24 @@ struct tx_tstamp_data {
>         unsigned int sent;
>         uint32_t so_timestamping;
>         bool stream;
> +       bool bpf;
> +#ifdef HAVE_BPF
> +       struct tester_bpf *skel;
> +       struct ring_buffer *buf;
> +       int cgroup_fd;
> +       int bpf_err;
> +#endif
>  };
>
>  static inline void tx_tstamp_init(struct tx_tstamp_data *data,
> -                               uint32_t so_timestamping, bool stream)
> +                               uint32_t so_timestamping, bool stream, bo=
ol bpf)
>  {
>         memset(data, 0, sizeof(*data));
>         memset(data->expect, 0xff, sizeof(data->expect));
>
>         data->so_timestamping =3D so_timestamping;
>         data->stream =3D stream;
> +       data->bpf =3D bpf;
>  }
>
>  static inline int tx_tstamp_expect(struct tx_tstamp_data *data, size_t l=
en)
> @@ -59,6 +76,21 @@ static inline int tx_tstamp_expect(struct tx_tstamp_da=
ta *data, size_t len)
>         if (data->stream && len)
>                 data->sent +=3D len - 1;
>
> +       if (data->bpf) {
> +               bool have_tskey =3D
> +                       data->so_timestamping & SOF_TIMESTAMPING_OPT_ID &=
&
> +                       data->so_timestamping & SOF_TIMESTAMPING_TX_RECOR=
D_MASK;
> +
> +               g_assert(pos + 2 <=3D ARRAY_SIZE(data->expect));
> +               data->expect[pos].type =3D SCM_TSTAMP_SND;
> +               data->expect[pos].id =3D have_tskey ? data->sent : 0;
> +               pos++;
> +               data->expect[pos].type =3D SCM_TSTAMP_COMPLETION;
> +               data->expect[pos].id =3D have_tskey ? data->sent : 0;
> +               pos++;
> +               goto done;
> +       }
> +
>         if (data->so_timestamping & SOF_TIMESTAMPING_TX_SCHED) {
>                 g_assert(pos < ARRAY_SIZE(data->expect));
>                 data->expect[pos].type =3D SCM_TSTAMP_SCHED;
> @@ -80,6 +112,7 @@ static inline int tx_tstamp_expect(struct tx_tstamp_da=
ta *data, size_t len)
>                 pos++;
>         }
>
> +done:
>         if (!data->stream || len)
>                 data->sent++;
>
> @@ -88,6 +121,51 @@ static inline int tx_tstamp_expect(struct tx_tstamp_d=
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
> +       if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID || data->bpf=
) &&
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
> @@ -99,7 +177,6 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data=
 *data, int sk, int len)
>         struct scm_timestamping *tss =3D NULL;
>         struct sock_extended_err *serr =3D NULL;
>         struct timespec now;
> -       unsigned int i;
>
>         iov.iov_base =3D buf;
>         iov.iov_len =3D sizeof(buf);
> @@ -159,42 +236,147 @@ static inline int tx_tstamp_recv(struct tx_tstamp_=
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
> +               tester_warn("BPF sockops attach cgroup failed");
> +               goto fail;
> +       }
> +
> +       data->skel->links._setsockopt =3D
> +               bpf_program__attach_cgroup(data->skel->progs._setsockopt,
> +                                                       data->cgroup_fd);
> +       if (!data->skel->links._setsockopt) {
> +               tester_warn("BPF setsockopt attach cgroup failed");
> +               goto fail;
> +       }
> +
> +       flag =3D 0;
> +       if (setsockopt(sk, SOL_CUSTOM_TESTER, 0, &flag, sizeof(flag))) {
> +               tester_warn("BPF setsockopt failed");
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
> +static inline int tx_tstamp_bpf_process(struct tx_tstamp_data *data, int=
 *step)
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
> +static inline int tx_tstamp_bpf_process(struct tx_tstamp_data *data, int=
 *step)
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
>
>


--=20
Luiz Augusto von Dentz
