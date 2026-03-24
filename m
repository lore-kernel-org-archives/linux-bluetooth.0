Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F1317143
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386037; cv=pass; b=VaxsuQWxeSiYqcd3g9/P+MNrcv5uDvuP+b7vWtDEcOx2rZGq742jvENh3aTYsajo3atB8aINQEQD7GrIm5cQwl3NIzOnk5fgSrTW+5LBkudiuXdO1h33OoAsGPxyORI6212IHndAEBDvDiys0hg7zPL7juuXo1y8z5CD/Q6zoCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386037; c=relaxed/simple;
	bh=jfw7kmK0RNNByqSOe1UR8fp7ajsy6tOe8ReQjIwIiWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9+9AT4xknnrtVRHKRnT95D1dUt940evKVAxuF4MjWIJxng5YjkCQegYS8HRzW409m+PC1U/IQZ7RVnStXXS0k6a+SvI18RKHmk9YdcDgKIbftJ5SuAX2VfP8GATkGPa7f+zmKfsY1BxYm6Vb0e2t3u/Id6Qso/zBIRCK574Hv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VuoHg9Tw; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VuoHg9Tw"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fgMr54BVYz49Q5g;
	Tue, 24 Mar 2026 23:00:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774386022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=478J/X0+DrvTZUtXeGoaRcFWXFNEXy3aQOa4DhG/LEM=;
	b=VuoHg9TweMREfeMiG6Kz1wBIzx3ZXKYhkI0Cgqn4NHa8k4jwvVtQ0IZL8qpvPL31tRPvQW
	bmt5I//1LNun89GQs1npVdcm8jRbiaqBxPhIoCtJ5KtDv3/7n7oEtP1kMUGYQAWW7vV+z/
	2tfNuxRBXBro1EvtEWNQcNfvtX5HEHx+ESHEtaLExybECemsboaKmYxh8lSbSHSXimFwHa
	0WQfSUWZTajHyzL1FuAOSa27XGQTBfmBzwcqonpkFP8HrsURax9/rrsUKgKkqfLNge6yVw
	uqBtBS9cWl89SASoXXV9N9lq4BLxPAqwJitjyG6dAv/wHWOkUOnxdRzXOVfIoQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774386022;
	b=Qv0/mDFH3AUgrTyFzv8PLaqGz2fOP5snG7MV4Ly4nnXRfcqZuZ+yD8ELuSaB68YAXkpGN1
	63H3K0cdqySJBvpOeE4tTjxDMD0er0nKWtzoHHWkhQ1JpoglJeu9OpP49Yjb3QuPwbT5Am
	Avbwj/Qn1l1Zy1+9pOoBoZM8Luab4OTWKHzBWAb2JDxC3nyr7Vzx5PgtBU80sgnhINF4BK
	q/1oR5TXDInpvFeh3OW9X2jgOoyzPOvgazDTWSlQNl7RJqEsEJJij4Q73u6O6ka2J9EzXO
	Rm0iS2S+xVZ68aTlZ50Zt+cDTL6SXJFCQ2Br9jbwzmou/AThYAxiSjhR+PkcGA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774386022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=478J/X0+DrvTZUtXeGoaRcFWXFNEXy3aQOa4DhG/LEM=;
	b=CTCTXE5W4Fg7I1RfEALCuqq91XTGN7e268RXHeUOGXdlP2+eZwwAQuveY907/fhzFXCsMj
	3Wk0Xw5Cz4LJuZjvnM+ZKRHiSUi4aXqSYyPV8eCuosCuZdd3DcbvdXoyJotYGI2JsgjsO1
	F7xY+bDNzv1X7dXa9NRrzLpk7GEzwiGnMyYArW8AaC6lJHYVPdANaHH28V59jIa21IXwjM
	0yQrWpMrtkHSJcbi8vRkA6fhJ6ZIPXkM+X86jkBsDyhQekFeD2Zbo7Q+9i+WLrcGIb+QAX
	kh30+oRYwoIHPafZDidm6DFTwydYvy8ZnWw5Ov1G/lnw4QrBWBLBjglXM6NBIg==
Message-ID: <c465caa2c8771fc233f832415b5d1d6e5f155fee.camel@iki.fi>
Subject: Re: [PATCH BlueZ v3 09/20] test-runner: use virtio-serial for
 implementing -u device forwarding
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 24 Mar 2026 23:00:16 +0200
In-Reply-To: <CABBYNZK+y9Ar3m563pqFhaoU0TfHfOMhJtvyT_ZhamnA-K41dw@mail.gmail.com>
References: <cover.1774214693.git.pav@iki.fi>
	 <34a731c7f20b905dc4b60e66a8c31e5bf3284017.1774214693.git.pav@iki.fi>
	 <CABBYNZK+y9Ar3m563pqFhaoU0TfHfOMhJtvyT_ZhamnA-K41dw@mail.gmail.com>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ti, 2026-03-24 kello 16:24 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Mar 22, 2026 at 5:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu o=
r
> > kernel seems to be sometimes dropping part of the sent data or insert
> > spurious \0 bytes, leading to sporadic errors like:
> >=20
> >     kernel: Bluetooth: hci0: command 0x0c52 tx timeout
> >     kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
> >     btvirt: packet error, unknown type: 0
> >=20
> > This appears to occur most often when host system is under load, e.g.
> > due to multiple test-runners running at the same time.  The problem is
> > not specific to btvirt, but seems to be in the qemu serial device layer
> > vs. kernel interaction.
> >=20
> > Change test-runner to use virtserialport to forward the btvirt
> > connection inside the VM, as virtio-serial doesn't appear to have these
> > problems.
> >=20
> > Since it's not a TTY device, we have to do vport <-> tty-with-hci-ldisc
> > forwarding of the data in test-runner, so this becomes a bit more
> > involved.
>=20
> Lets try to sort this out first before we go into the functional
> framework. Does the vport not working as tty perhaps require a kernel
> driver or something to enable direct operation?

Looks like qemu has different option for the virtio TTY device. We can
replace this patch with the following -> v4

I'll wait for other comments on the series before continuing.


diff --git a/tools/test-runner.c b/tools/test-runner.c
index b3e0b0cfe..0e3bfb8b7 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -306,7 +306,7 @@ static void start_qemu(void)
                                testargs);
=20
        argv =3D alloca(sizeof(qemu_argv) +
-                       (sizeof(char *) * (6 + (num_devs * 4))) +
+                       (sizeof(char *) * (8 + (num_devs * 4))) +
                        (sizeof(char *) * (usb_dev ? 4 : 0)) +
                        (sizeof(char *) * num_extra_opts));
        memcpy(argv, qemu_argv, sizeof(qemu_argv));
@@ -330,14 +330,19 @@ static void start_qemu(void)
        argv[pos++] =3D "-append";
        argv[pos++] =3D (char *) cmdline;
=20
+       if (num_devs) {
+               argv[pos++] =3D "-device";
+               argv[pos++] =3D "virtio-serial";
+       }
+
        for (i =3D 0; i < num_devs; i++) {
                char *chrdev, *serdev;
=20
                chrdev =3D alloca(48 + strlen(device_path));
                sprintf(chrdev, "socket,path=3D%s,id=3Dbt%d", device_path,
i);
=20
-               serdev =3D alloca(48);
-               sprintf(serdev, "pci-serial,chardev=3Dbt%d", i);
+               serdev =3D alloca(64);
+               sprintf(serdev, "virtconsole,chardev=3Dbt%d,name=3Dbt.%d",
i, i);
=20
                argv[pos++] =3D "-chardev";
                argv[pos++] =3D chrdev;
@@ -910,7 +915,7 @@ static void run_command(char *cmdname, char *home)
        }
=20
        if (num_devs) {
-               const char *node =3D "/dev/ttyS1";
+               const char *node =3D "/dev/hvc0";
                unsigned int basic_flags, extra_flags;
=20
                printf("Attaching BR/EDR controller to %s\n", node);


>=20
> > ---
> >  Makefile.tools      |   2 +
> >  configure.ac        |   9 ++
> >  tools/test-runner.c | 300 +++++++++++++++++++++++++++++++++-----------
> >  3 files changed, 241 insertions(+), 70 deletions(-)
> >=20
> > diff --git a/Makefile.tools b/Makefile.tools
> > index f6de2e685..6e30a535f 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -321,6 +321,8 @@ tools_btgatt_server_SOURCES =3D tools/btgatt-server=
.c src/uuid-helper.c
> >  tools_btgatt_server_LDADD =3D src/libshared-mainloop.la \
> >                                                 lib/libbluetooth-intern=
al.la
> >=20
> > +tools_test_runner_LDADD =3D $(OPENPTY_LIBS)
> > +
> >  tools_rctest_LDADD =3D lib/libbluetooth-internal.la
> >=20
> >  tools_l2test_LDADD =3D lib/libbluetooth-internal.la
> > diff --git a/configure.ac b/configure.ac
> > index 52de7d665..3bc1f5c44 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -251,6 +251,15 @@ AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-too=
ls],
> >                 [disable Bluetooth tools]), [enable_tools=3D${enableval=
}])
> >  AM_CONDITIONAL(TOOLS, test "${enable_tools}" !=3D "no")
> >=20
> > +openpty_libs=3D
> > +if (test "${enable_tools}" !=3D "no"); then
> > +       AC_CHECK_FUNCS([openpty], [openpty_libs=3D],
> > +         [AC_CHECK_LIB([util], [openpty], [openpty_libs=3D-lutil],
> > +           [AC_CHECK_LIB([bsd], [openpty], [openpty_libs=3D-lbsd],
> > +                [AC_MSG_ERROR([openpty not found])])])])
> > +fi
> > +AC_SUBST(OPENPTY_LIBS, [${openpty_libs}])
> > +
> >  AC_ARG_ENABLE(monitor, AS_HELP_STRING([--disable-monitor],
> >                 [disable Bluetooth monitor]), [enable_monitor=3D${enabl=
eval}])
> >  AM_CONDITIONAL(MONITOR, test "${enable_monitor}" !=3D "no")
> > diff --git a/tools/test-runner.c b/tools/test-runner.c
> > index b3e0b0cfe..576313b79 100644
> > --- a/tools/test-runner.c
> > +++ b/tools/test-runner.c
> > @@ -24,6 +24,9 @@
> >  #include <getopt.h>
> >  #include <poll.h>
> >  #include <limits.h>
> > +#include <dirent.h>
> > +#include <pty.h>
> > +#include <stdint.h>
> >  #include <sys/wait.h>
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> > @@ -306,7 +309,7 @@ static void start_qemu(void)
> >                                 testargs);
> >=20
> >         argv =3D alloca(sizeof(qemu_argv) +
> > -                       (sizeof(char *) * (6 + (num_devs * 4))) +
> > +                       (sizeof(char *) * (8 + (num_devs * 4))) +
> >                         (sizeof(char *) * (usb_dev ? 4 : 0)) +
> >                         (sizeof(char *) * num_extra_opts));
> >         memcpy(argv, qemu_argv, sizeof(qemu_argv));
> > @@ -330,14 +333,17 @@ static void start_qemu(void)
> >         argv[pos++] =3D "-append";
> >         argv[pos++] =3D (char *) cmdline;
> >=20
> > +       argv[pos++] =3D "-device";
> > +       argv[pos++] =3D "virtio-serial";
> > +
> >         for (i =3D 0; i < num_devs; i++) {
> >                 char *chrdev, *serdev;
> >=20
> >                 chrdev =3D alloca(48 + strlen(device_path));
> >                 sprintf(chrdev, "socket,path=3D%s,id=3Dbt%d", device_pa=
th, i);
> >=20
> > -               serdev =3D alloca(48);
> > -               sprintf(serdev, "pci-serial,chardev=3Dbt%d", i);
> > +               serdev =3D alloca(64);
> > +               sprintf(serdev, "virtserialport,chardev=3Dbt%d,name=3Db=
t.%d", i, i);
> >=20
> >                 argv[pos++] =3D "-chardev";
> >                 argv[pos++] =3D chrdev;
> > @@ -360,65 +366,12 @@ static void start_qemu(void)
> >         execve(argv[0], argv, qemu_envp);
> >  }
> >=20
> > -static int open_serial(const char *path)
> > -{
> > -       struct termios ti;
> > -       int fd, saved_ldisc, ldisc =3D N_HCI;
> > -
> > -       fd =3D open(path, O_RDWR | O_NOCTTY);
> > -       if (fd < 0) {
> > -               perror("Failed to open serial port");
> > -               return -1;
> > -       }
> > -
> > -       if (tcflush(fd, TCIOFLUSH) < 0) {
> > -               perror("Failed to flush serial port");
> > -               close(fd);
> > -               return -1;
> > -       }
> > -
> > -       if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
> > -               perror("Failed get serial line discipline");
> > -               close(fd);
> > -               return -1;
> > -       }
> > -
> > -       /* Switch TTY to raw mode */
> > -       memset(&ti, 0, sizeof(ti));
> > -       cfmakeraw(&ti);
> > -
> > -       ti.c_cflag |=3D (B115200 | CLOCAL | CREAD);
> > -
> > -       /* Set flow control */
> > -       ti.c_cflag |=3D CRTSCTS;
> > -
> > -       if (tcsetattr(fd, TCSANOW, &ti) < 0) {
> > -               perror("Failed to set serial port settings");
> > -               close(fd);
> > -               return -1;
> > -       }
> > -
> > -       if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
> > -               perror("Failed set serial line discipline");
> > -               close(fd);
> > -               return -1;
> > -       }
> > -
> > -       printf("Switched line discipline from %d to %d\n", saved_ldisc,=
 ldisc);
> > -
> > -       return fd;
> > -}
> > -
> > -static int attach_proto(const char *path, unsigned int proto,
> > +static int attach_proto(int fd, unsigned int proto,
> >                                         unsigned int mandatory_flags,
> >                                         unsigned int optional_flags)
> >  {
> >         unsigned int flags =3D mandatory_flags | optional_flags;
> > -       int fd, dev_id;
> > -
> > -       fd =3D open_serial(path);
> > -       if (fd < 0)
> > -               return -1;
> > +       int dev_id;
> >=20
> >         if (ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
> >                 if (errno =3D=3D EINVAL) {
> > @@ -895,13 +848,222 @@ static int start_audio_server(pid_t pids[2])
> >         return 0;
> >  }
> >=20
> > +static bool find_attach_dev(char path[PATH_MAX])
> > +{
> > +       const char *vport_path =3D "/sys/class/virtio-ports";
> > +       struct dirent *entry;
> > +       DIR *dir;
> > +
> > +       dir =3D opendir(vport_path);
> > +       if (!dir)
> > +               return false;
> > +
> > +       while ((entry =3D readdir(dir)) !=3D NULL) {
> > +               FILE *f;
> > +               char buf[64];
> > +               size_t size;
> > +
> > +               snprintf(path, PATH_MAX, "%s/%s/name", vport_path,
> > +                                                               entry->=
d_name);
> > +               f =3D fopen(path, "r");
> > +               if (!f)
> > +                       continue;
> > +
> > +               size =3D fread(buf, 1, sizeof(buf) - 1, f);
> > +               buf[size] =3D 0;
> > +
> > +               fclose(f);
> > +
> > +               if (strncmp(buf, "bt.", 3) =3D=3D 0) {
> > +                       snprintf(path, PATH_MAX, "/dev/%s", entry->d_na=
me);
> > +                       closedir(dir);
> > +                       return true;
> > +               }
> > +       }
> > +
> > +       closedir(dir);
> > +       return false;
> > +}
> > +
> > +static void copy_fd_bidi(int src, int dst)
> > +{
> > +       fd_set rfds, wfds;
> > +       int fd[2] =3D { src, dst };
> > +       uint8_t buf[2][4096];
> > +       size_t size[2] =3D { 0, 0 };
> > +       size_t pos[2] =3D { 0, 0 };
> > +       int i, ret;
> > +
> > +       /* Simple copying of data src <-> dst to both directions */
> > +
> > +       for (i =3D 0; i < 2; ++i) {
> > +               int flags =3D fcntl(fd[i], F_GETFL);
> > +
> > +               if (fcntl(fd[i], F_SETFL, flags | O_NONBLOCK) < 0) {
> > +                       perror("fcntl");
> > +                       goto error;
> > +               }
> > +       }
> > +
> > +       while (1) {
> > +               FD_ZERO(&rfds);
> > +               FD_ZERO(&wfds);
> > +
> > +               for (i =3D 0; i < 2; ++i) {
> > +                       if (size[i])
> > +                               FD_SET(fd[i], &wfds);
> > +                       else
> > +                               FD_SET(fd[1 - i], &rfds);
> > +               }
> > +
> > +               ret =3D select(FD_SETSIZE, &rfds, &wfds, NULL, NULL);
> > +               if (ret < 0) {
> > +                       if (errno =3D=3D EINTR)
> > +                               continue;
> > +                       perror("select");
> > +                       goto error;
> > +               }
> > +
> > +               for (i =3D 0; i < 2; ++i) {
> > +                       ssize_t s;
> > +
> > +                       if (!size[i] && FD_ISSET(fd[1 - i], &rfds)) {
> > +                               s =3D read(fd[1 - i], buf[i], sizeof(bu=
f[i]));
> > +                               if (s >=3D 0) {
> > +                                       size[i] =3D s;
> > +                                       pos[i] =3D 0;
> > +                               } else if (errno =3D=3D EINTR) {
> > +                                       /* ok */
> > +                               } else {
> > +                                       perror("read");
> > +                                       goto error;
> > +                               }
> > +
> > +                       }
> > +
> > +                       if (size[i]) {
> > +                               s =3D write(fd[i], buf[i] + pos[i], siz=
e[i]);
> > +                               if (s >=3D 0) {
> > +                                       size[i] -=3D s;
> > +                                       pos[i] +=3D s;
> > +                               } else if (errno =3D=3D EINTR || errno =
=3D=3D EAGAIN
> > +                                               || errno =3D=3D EWOULDB=
LOCK) {
> > +                                       /* ok */
> > +                               } else {
> > +                                       perror("write");
> > +                                       goto error;
> > +                               }
> > +                       }
> > +               }
> > +       }
>=20
> It doesn't look that great if you ask me. I think this requires us to
> copy significantly more data than before, likely resulting in worse
> performance, which could be detrimental in resource-limited
> environments like GitHub CI/CD.
>=20
> > +       return;
> > +
> > +error:
> > +       fprintf(stderr, "Bluetooth controller forward terminated with e=
rror\n");
> > +       exit(1);
> > +}
> > +
> > +static int start_controller_forward(const char *path, pid_t *controlle=
r_pid)
> > +{
> > +       struct termios ti;
> > +       pid_t pid;
> > +       int src =3D -1, dst =3D -1, fd =3D -1;
> > +       int ret, saved_ldisc, ldisc =3D N_HCI;
> > +
> > +       /* virtio-serial ports cannot be used for HCI line disciple, so
> > +        * openpty() serial device and forward data to/from it.
> > +        */
> > +
> > +       src =3D open(path, O_RDWR);
> > +       if (src < 0)
> > +               goto error;
> > +
> > +       /* Raw mode TTY */
> > +       memset(&ti, 0, sizeof(ti));
> > +       cfmakeraw(&ti);
> > +       ti.c_cflag |=3D B115200 | CLOCAL | CREAD;
> > +
> > +       /* With flow control */
> > +       ti.c_cflag |=3D CRTSCTS;
> > +
> > +       ret =3D openpty(&dst, &fd, NULL, &ti, NULL);
> > +       if (ret < 0)
> > +               goto error;
> > +
> > +       if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
> > +               perror("Failed get serial line discipline");
> > +               goto error;
> > +       }
> > +
> > +       if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
> > +               perror("Failed set serial line discipline");
> > +               goto error;
> > +       }
> > +
> > +       printf("Switched line discipline from %d to %d\n", saved_ldisc,=
 ldisc);
> > +
> > +       pid =3D fork();
> > +       if (pid < 0) {
> > +               perror("Failed to fork new process");
> > +               goto error;
> > +       } else if (pid =3D=3D 0) {
> > +               close(fd);
> > +               copy_fd_bidi(src, dst);
> > +               exit(0);
> > +       }
> > +
> > +       *controller_pid =3D pid;
> > +
> > +       close(src);
> > +       close(dst);
> > +       return fd;
> > +
> > +error:
> > +       if (src >=3D 0)
> > +               close(src);
> > +       if (dst >=3D 0)
> > +               close(dst);
> > +       if (fd >=3D 0)
> > +               close(fd);
> > +       return -1;
> > +}
> > +
> > +static int attach_controller(pid_t *controller_pid)
> > +{
> > +       unsigned int basic_flags, extra_flags;
> > +       char path[PATH_MAX];
> > +       int fd;
> > +
> > +       *controller_pid =3D -1;
> > +
> > +       if (!find_attach_dev(path)) {
> > +               printf("Failed to find Bluetooth controller virtio\n");
> > +               return -1;
> > +       }
> > +
> > +       printf("Forwarding Bluetooth controller from %s\n", path);
> > +
> > +       fd =3D start_controller_forward(path, controller_pid);
> > +       if (fd < 0) {
> > +               printf("Failed to forward Bluetooth controller\n");
> > +               return -1;
> > +       }
> > +
> > +       basic_flags =3D (1 << HCI_UART_RESET_ON_INIT);
> > +       extra_flags =3D (1 << HCI_UART_VND_DETECT);
> > +
> > +       printf("Attaching Bluetooth controller\n");
> > +
> > +       return attach_proto(fd, HCI_UART_H4, basic_flags, extra_flags);
> > +}
> > +
> >  static void run_command(char *cmdname, char *home)
> >  {
> >         char *argv[9], *envp[3];
> >         int pos =3D 0, idx =3D 0;
> >         int serial_fd;
> >         pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
> > -             dbus_session_pid, audio_pid[2];
> > +               dbus_session_pid, audio_pid[2], controller_pid;
> >         int i;
> >=20
> >         if (!home) {
> > @@ -910,18 +1072,11 @@ static void run_command(char *cmdname, char *hom=
e)
> >         }
> >=20
> >         if (num_devs) {
> > -               const char *node =3D "/dev/ttyS1";
> > -               unsigned int basic_flags, extra_flags;
> > -
> > -               printf("Attaching BR/EDR controller to %s\n", node);
> > -
> > -               basic_flags =3D (1 << HCI_UART_RESET_ON_INIT);
> > -               extra_flags =3D (1 << HCI_UART_VND_DETECT);
> > -
> > -               serial_fd =3D attach_proto(node, HCI_UART_H4, basic_fla=
gs,
> > -                                                               extra_f=
lags);
> > -       } else
> > +               serial_fd =3D attach_controller(&controller_pid);
> > +       } else {
> >                 serial_fd =3D -1;
> > +               controller_pid =3D -1;
> > +       }
> >=20
> >         if (start_dbus) {
> >                 create_dbus_system_conf();
> > @@ -1063,6 +1218,11 @@ start_next:
> >                         monitor_pid =3D -1;
> >                 }
> >=20
> > +               if (corpse =3D=3D controller_pid) {
> > +                       printf("Controller terminated\n");
> > +                       controller_pid =3D -1;
> > +               }
> > +
> >                 for (i =3D 0; i < 2; ++i) {
> >                         if (corpse =3D=3D audio_pid[i]) {
> >                                 printf("Audio server %d terminated\n", =
i);
> > --
> > 2.53.0
> >=20
> >=20
>=20

--=20
Pauli Virtanen
