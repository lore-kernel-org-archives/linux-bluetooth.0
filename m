Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955934BA53
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383910; cv=pass; b=aWK/ItNEwv8iI8Ly3ntnsnoEpdN6hf/vEc6Ryea9xbKo3UN+G2c+o0CynjAMbP9P8xik2zB2BemJ03Zvbws5q0JC7laO5C2NdFUfcJfDg9ljeO2YlAq70pQb2pYJ2TrhwQLXMjSLIg0vq+IeU03t9hTDq12H3oVBGgKom1NLswY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383910; c=relaxed/simple;
	bh=fjXGi1FEy99a7qfiUAOodJKNwKkA4Nldh6cvIf1ewcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZRcaQeBOOzgLe88KfATy2LrxhkWtuRjhFeCVk2bIjRIl4d8E7dJNRQWxJiq/FU9blmNIynGg2Z8P7FOQsxXBAXZPlEVYfPscG6kVf3W5yQarNwVWiHijB5NyWB+0SuVRWJFG4pw4QeRr0lXD7pKM33nj5Uu1Ti5ovj82LsqUYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jheGYwee; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jheGYwee"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a7109f568so43604047b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 13:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774383908; cv=none;
        d=google.com; s=arc-20240605;
        b=eVXNobCfewY8R0U+EqY0EWYTwyRGEn/xpamB+tHFSdecEwXUTh2ffteKZYe8fQkaP4
         PT8gIciE1ZOTgWYO0yWp9Msx3xnvKt6KprMpmY+DkwOUxSHLZGIO/j6SAADKvwcrLDZX
         0h7voEgnizps21xDORxJfqtxMgb91Pl0tePwT6y95RIjIFspYiI2LJEUyqHNg4nO1IQJ
         xMMil75IT6nDMUDp6YCgIL677zzTRPUSoB9TsvzpoNyGJU5lMFf+uWwoyGZaKd59CCDt
         fa71YH1Jj+XhaHPr9nAAjhlIoL9Q0m7L1GpslPaDglHRmE38IPG9C9WlT5RbfQcc6dxk
         FojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kMMh8N8jjmvLUpjVdXaHY66ikXLH8cBqBq/w41pwgk=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=Xr8ATxfnX2iDow5qGQq8l/YMzD5K3V59JfygQehJRPARYjRZRGR3fpmjHvdaQzAotk
         XkPE/aF4ti+Et0Svw8fW8YgaM0ZX49am1Yul+97dUDf1WxrUMAgkljGtGM/j9eqfk4mw
         AIeof3fM2Wah89vEJ1kUJUp6/RO9+n8Zux5lY8js1lHLDczdSmiixwPgFFE0GGCScQYx
         fe4gD0ekd30B+S35JHlNDAUy1UD2hkSI3MMhyvbeVG5FcDd+TVMwiof1kCQyGR1morgQ
         JbG1zRFX+shprkGgljd4p88xV009sI0PPZTQpyO5VhPS3gGiyE7w142aPP4zLyxzCqoS
         zXTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774383908; x=1774988708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kMMh8N8jjmvLUpjVdXaHY66ikXLH8cBqBq/w41pwgk=;
        b=jheGYweee6KUakwelh+SSgEgVmBdJFZ+pLFUHtl3Q4zufXW7qUgEjTflmmZM42zl2I
         pNTy2HTMHCzd219/243qw2rXPoKLzyBwh+noNGD/mGQEUt9K768M9U37odmVFg/iSy1T
         Jpp8mAxThrv6pcPBlNPR+/+4cz5XeKG0eS4R55yr8HkQ/wrKhCqL2QFUTBm+mcyUdtvH
         LckXKB9BJQmdK0f/7VmmPeFQv+D4rTDmdxiQY/sCMlMvL4+wlXI8+vGeBQYxUcLQICd9
         7ykhIs+yZShtDJgmrhCneFT9i/p+lD7lYfYpF7aoyQrl8xZF7uBdU4KTUGCbd07R6l+u
         TElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383908; x=1774988708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kMMh8N8jjmvLUpjVdXaHY66ikXLH8cBqBq/w41pwgk=;
        b=akRc7TradmBG23F2OAaS1Cxg1N1pUKv/pWqqYCQc/eb+rG+U74uMQBKwWFq7+vqNYu
         INDQui6DJrSH2DItY4+w/5XZmsync0O/gnGAfVOCuz1dTGkFXj6z8DTcqPmP1t/hR8+r
         Lhui9gSMDNRwKqmhM4DnaJIe2nek/s1+60lL5vmMrwo/0r5GIajdXuZIVnGUMvWw+R7M
         S0mCcHIGIQVwxVDuy4g6S4RdMCY2VBPk6v2ryyLg76hxF6JyaNSZ0yJcdHInEdfh8PTy
         Ojm8g+n4QbSevXNWVUYchAR7XzocJAcIKPoP4pNc9SwjEtIyxxrjI1AV7yIZ6D3QM1gh
         tuKg==
X-Gm-Message-State: AOJu0Yyuii9M7BTre7ApWDf+Je6iKA0cHM7HTzGIabrhRi/LuJPXn3zL
	R7i2II4h13WlBXfKpGd1Wjmofx741983lsd5rHUu5BIERhGm4QUhsxZQpStH8mKpPVHTeVNY6sp
	d0hUqO5hQcyyYZD45B/az+iv0hTvSoDM=
X-Gm-Gg: ATEYQzxtrmRA+QO3Iivv0eltLrdxjuZ3QkdK/egpddiQM1CBsPaWq6mhvor11GCtZLw
	UAYGPuar79M4MFxghjt7KzRme6e12iPagqyCg2VD7Yf3fGdCavRMpnj0NLNn5TkUCqCuAdtorX2
	DQRRVVQBIAagjOrVbM7HPo/e+ihgSDlUFkOdLF+bnmY3POjpr4CIOI1OszVc4Wpsal93g9vFN2A
	3OUpiR5N+5RLo1jBKgLqzUfSrsJb6ARu1qObVud+2Exf4Y8FgjF7xuj2r2JEmc0KF8FKy9P4Pgr
	HzEaeIWZ7HexguhewCz6sAYO8LCQrBhXuDVv8M5JE7eDzZ9IwPEpdgeFf1iRLsHJl8F8RQ==
X-Received: by 2002:a05:690c:e3e1:b0:79a:ac83:ac84 with SMTP id
 00721157ae682-79acf650682mr12452497b3.41.1774383907416; Tue, 24 Mar 2026
 13:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774214693.git.pav@iki.fi> <34a731c7f20b905dc4b60e66a8c31e5bf3284017.1774214693.git.pav@iki.fi>
In-Reply-To: <34a731c7f20b905dc4b60e66a8c31e5bf3284017.1774214693.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 16:24:56 -0400
X-Gm-Features: AaiRm51aZqc4xlEehvAyQ2WP2w5XgtfBpddpTcGgQ_9JcfK7BpR2svpSUzXdA3o
Message-ID: <CABBYNZK+y9Ar3m563pqFhaoU0TfHfOMhJtvyT_ZhamnA-K41dw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 09/20] test-runner: use virtio-serial for
 implementing -u device forwarding
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Mar 22, 2026 at 5:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu or
> kernel seems to be sometimes dropping part of the sent data or insert
> spurious \0 bytes, leading to sporadic errors like:
>
>     kernel: Bluetooth: hci0: command 0x0c52 tx timeout
>     kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
>     btvirt: packet error, unknown type: 0
>
> This appears to occur most often when host system is under load, e.g.
> due to multiple test-runners running at the same time.  The problem is
> not specific to btvirt, but seems to be in the qemu serial device layer
> vs. kernel interaction.
>
> Change test-runner to use virtserialport to forward the btvirt
> connection inside the VM, as virtio-serial doesn't appear to have these
> problems.
>
> Since it's not a TTY device, we have to do vport <-> tty-with-hci-ldisc
> forwarding of the data in test-runner, so this becomes a bit more
> involved.

Lets try to sort this out first before we go into the functional
framework. Does the vport not working as tty perhaps require a kernel
driver or something to enable direct operation?

> ---
>  Makefile.tools      |   2 +
>  configure.ac        |   9 ++
>  tools/test-runner.c | 300 +++++++++++++++++++++++++++++++++-----------
>  3 files changed, 241 insertions(+), 70 deletions(-)
>
> diff --git a/Makefile.tools b/Makefile.tools
> index f6de2e685..6e30a535f 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -321,6 +321,8 @@ tools_btgatt_server_SOURCES =3D tools/btgatt-server.c=
 src/uuid-helper.c
>  tools_btgatt_server_LDADD =3D src/libshared-mainloop.la \
>                                                 lib/libbluetooth-internal=
.la
>
> +tools_test_runner_LDADD =3D $(OPENPTY_LIBS)
> +
>  tools_rctest_LDADD =3D lib/libbluetooth-internal.la
>
>  tools_l2test_LDADD =3D lib/libbluetooth-internal.la
> diff --git a/configure.ac b/configure.ac
> index 52de7d665..3bc1f5c44 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -251,6 +251,15 @@ AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools=
],
>                 [disable Bluetooth tools]), [enable_tools=3D${enableval}]=
)
>  AM_CONDITIONAL(TOOLS, test "${enable_tools}" !=3D "no")
>
> +openpty_libs=3D
> +if (test "${enable_tools}" !=3D "no"); then
> +       AC_CHECK_FUNCS([openpty], [openpty_libs=3D],
> +         [AC_CHECK_LIB([util], [openpty], [openpty_libs=3D-lutil],
> +           [AC_CHECK_LIB([bsd], [openpty], [openpty_libs=3D-lbsd],
> +                [AC_MSG_ERROR([openpty not found])])])])
> +fi
> +AC_SUBST(OPENPTY_LIBS, [${openpty_libs}])
> +
>  AC_ARG_ENABLE(monitor, AS_HELP_STRING([--disable-monitor],
>                 [disable Bluetooth monitor]), [enable_monitor=3D${enablev=
al}])
>  AM_CONDITIONAL(MONITOR, test "${enable_monitor}" !=3D "no")
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index b3e0b0cfe..576313b79 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -24,6 +24,9 @@
>  #include <getopt.h>
>  #include <poll.h>
>  #include <limits.h>
> +#include <dirent.h>
> +#include <pty.h>
> +#include <stdint.h>
>  #include <sys/wait.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> @@ -306,7 +309,7 @@ static void start_qemu(void)
>                                 testargs);
>
>         argv =3D alloca(sizeof(qemu_argv) +
> -                       (sizeof(char *) * (6 + (num_devs * 4))) +
> +                       (sizeof(char *) * (8 + (num_devs * 4))) +
>                         (sizeof(char *) * (usb_dev ? 4 : 0)) +
>                         (sizeof(char *) * num_extra_opts));
>         memcpy(argv, qemu_argv, sizeof(qemu_argv));
> @@ -330,14 +333,17 @@ static void start_qemu(void)
>         argv[pos++] =3D "-append";
>         argv[pos++] =3D (char *) cmdline;
>
> +       argv[pos++] =3D "-device";
> +       argv[pos++] =3D "virtio-serial";
> +
>         for (i =3D 0; i < num_devs; i++) {
>                 char *chrdev, *serdev;
>
>                 chrdev =3D alloca(48 + strlen(device_path));
>                 sprintf(chrdev, "socket,path=3D%s,id=3Dbt%d", device_path=
, i);
>
> -               serdev =3D alloca(48);
> -               sprintf(serdev, "pci-serial,chardev=3Dbt%d", i);
> +               serdev =3D alloca(64);
> +               sprintf(serdev, "virtserialport,chardev=3Dbt%d,name=3Dbt.=
%d", i, i);
>
>                 argv[pos++] =3D "-chardev";
>                 argv[pos++] =3D chrdev;
> @@ -360,65 +366,12 @@ static void start_qemu(void)
>         execve(argv[0], argv, qemu_envp);
>  }
>
> -static int open_serial(const char *path)
> -{
> -       struct termios ti;
> -       int fd, saved_ldisc, ldisc =3D N_HCI;
> -
> -       fd =3D open(path, O_RDWR | O_NOCTTY);
> -       if (fd < 0) {
> -               perror("Failed to open serial port");
> -               return -1;
> -       }
> -
> -       if (tcflush(fd, TCIOFLUSH) < 0) {
> -               perror("Failed to flush serial port");
> -               close(fd);
> -               return -1;
> -       }
> -
> -       if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
> -               perror("Failed get serial line discipline");
> -               close(fd);
> -               return -1;
> -       }
> -
> -       /* Switch TTY to raw mode */
> -       memset(&ti, 0, sizeof(ti));
> -       cfmakeraw(&ti);
> -
> -       ti.c_cflag |=3D (B115200 | CLOCAL | CREAD);
> -
> -       /* Set flow control */
> -       ti.c_cflag |=3D CRTSCTS;
> -
> -       if (tcsetattr(fd, TCSANOW, &ti) < 0) {
> -               perror("Failed to set serial port settings");
> -               close(fd);
> -               return -1;
> -       }
> -
> -       if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
> -               perror("Failed set serial line discipline");
> -               close(fd);
> -               return -1;
> -       }
> -
> -       printf("Switched line discipline from %d to %d\n", saved_ldisc, l=
disc);
> -
> -       return fd;
> -}
> -
> -static int attach_proto(const char *path, unsigned int proto,
> +static int attach_proto(int fd, unsigned int proto,
>                                         unsigned int mandatory_flags,
>                                         unsigned int optional_flags)
>  {
>         unsigned int flags =3D mandatory_flags | optional_flags;
> -       int fd, dev_id;
> -
> -       fd =3D open_serial(path);
> -       if (fd < 0)
> -               return -1;
> +       int dev_id;
>
>         if (ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
>                 if (errno =3D=3D EINVAL) {
> @@ -895,13 +848,222 @@ static int start_audio_server(pid_t pids[2])
>         return 0;
>  }
>
> +static bool find_attach_dev(char path[PATH_MAX])
> +{
> +       const char *vport_path =3D "/sys/class/virtio-ports";
> +       struct dirent *entry;
> +       DIR *dir;
> +
> +       dir =3D opendir(vport_path);
> +       if (!dir)
> +               return false;
> +
> +       while ((entry =3D readdir(dir)) !=3D NULL) {
> +               FILE *f;
> +               char buf[64];
> +               size_t size;
> +
> +               snprintf(path, PATH_MAX, "%s/%s/name", vport_path,
> +                                                               entry->d_=
name);
> +               f =3D fopen(path, "r");
> +               if (!f)
> +                       continue;
> +
> +               size =3D fread(buf, 1, sizeof(buf) - 1, f);
> +               buf[size] =3D 0;
> +
> +               fclose(f);
> +
> +               if (strncmp(buf, "bt.", 3) =3D=3D 0) {
> +                       snprintf(path, PATH_MAX, "/dev/%s", entry->d_name=
);
> +                       closedir(dir);
> +                       return true;
> +               }
> +       }
> +
> +       closedir(dir);
> +       return false;
> +}
> +
> +static void copy_fd_bidi(int src, int dst)
> +{
> +       fd_set rfds, wfds;
> +       int fd[2] =3D { src, dst };
> +       uint8_t buf[2][4096];
> +       size_t size[2] =3D { 0, 0 };
> +       size_t pos[2] =3D { 0, 0 };
> +       int i, ret;
> +
> +       /* Simple copying of data src <-> dst to both directions */
> +
> +       for (i =3D 0; i < 2; ++i) {
> +               int flags =3D fcntl(fd[i], F_GETFL);
> +
> +               if (fcntl(fd[i], F_SETFL, flags | O_NONBLOCK) < 0) {
> +                       perror("fcntl");
> +                       goto error;
> +               }
> +       }
> +
> +       while (1) {
> +               FD_ZERO(&rfds);
> +               FD_ZERO(&wfds);
> +
> +               for (i =3D 0; i < 2; ++i) {
> +                       if (size[i])
> +                               FD_SET(fd[i], &wfds);
> +                       else
> +                               FD_SET(fd[1 - i], &rfds);
> +               }
> +
> +               ret =3D select(FD_SETSIZE, &rfds, &wfds, NULL, NULL);
> +               if (ret < 0) {
> +                       if (errno =3D=3D EINTR)
> +                               continue;
> +                       perror("select");
> +                       goto error;
> +               }
> +
> +               for (i =3D 0; i < 2; ++i) {
> +                       ssize_t s;
> +
> +                       if (!size[i] && FD_ISSET(fd[1 - i], &rfds)) {
> +                               s =3D read(fd[1 - i], buf[i], sizeof(buf[=
i]));
> +                               if (s >=3D 0) {
> +                                       size[i] =3D s;
> +                                       pos[i] =3D 0;
> +                               } else if (errno =3D=3D EINTR) {
> +                                       /* ok */
> +                               } else {
> +                                       perror("read");
> +                                       goto error;
> +                               }
> +
> +                       }
> +
> +                       if (size[i]) {
> +                               s =3D write(fd[i], buf[i] + pos[i], size[=
i]);
> +                               if (s >=3D 0) {
> +                                       size[i] -=3D s;
> +                                       pos[i] +=3D s;
> +                               } else if (errno =3D=3D EINTR || errno =
=3D=3D EAGAIN
> +                                               || errno =3D=3D EWOULDBLO=
CK) {
> +                                       /* ok */
> +                               } else {
> +                                       perror("write");
> +                                       goto error;
> +                               }
> +                       }
> +               }
> +       }

It doesn't look that great if you ask me. I think this requires us to
copy significantly more data than before, likely resulting in worse
performance, which could be detrimental in resource-limited
environments like GitHub CI/CD.

> +       return;
> +
> +error:
> +       fprintf(stderr, "Bluetooth controller forward terminated with err=
or\n");
> +       exit(1);
> +}
> +
> +static int start_controller_forward(const char *path, pid_t *controller_=
pid)
> +{
> +       struct termios ti;
> +       pid_t pid;
> +       int src =3D -1, dst =3D -1, fd =3D -1;
> +       int ret, saved_ldisc, ldisc =3D N_HCI;
> +
> +       /* virtio-serial ports cannot be used for HCI line disciple, so
> +        * openpty() serial device and forward data to/from it.
> +        */
> +
> +       src =3D open(path, O_RDWR);
> +       if (src < 0)
> +               goto error;
> +
> +       /* Raw mode TTY */
> +       memset(&ti, 0, sizeof(ti));
> +       cfmakeraw(&ti);
> +       ti.c_cflag |=3D B115200 | CLOCAL | CREAD;
> +
> +       /* With flow control */
> +       ti.c_cflag |=3D CRTSCTS;
> +
> +       ret =3D openpty(&dst, &fd, NULL, &ti, NULL);
> +       if (ret < 0)
> +               goto error;
> +
> +       if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
> +               perror("Failed get serial line discipline");
> +               goto error;
> +       }
> +
> +       if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
> +               perror("Failed set serial line discipline");
> +               goto error;
> +       }
> +
> +       printf("Switched line discipline from %d to %d\n", saved_ldisc, l=
disc);
> +
> +       pid =3D fork();
> +       if (pid < 0) {
> +               perror("Failed to fork new process");
> +               goto error;
> +       } else if (pid =3D=3D 0) {
> +               close(fd);
> +               copy_fd_bidi(src, dst);
> +               exit(0);
> +       }
> +
> +       *controller_pid =3D pid;
> +
> +       close(src);
> +       close(dst);
> +       return fd;
> +
> +error:
> +       if (src >=3D 0)
> +               close(src);
> +       if (dst >=3D 0)
> +               close(dst);
> +       if (fd >=3D 0)
> +               close(fd);
> +       return -1;
> +}
> +
> +static int attach_controller(pid_t *controller_pid)
> +{
> +       unsigned int basic_flags, extra_flags;
> +       char path[PATH_MAX];
> +       int fd;
> +
> +       *controller_pid =3D -1;
> +
> +       if (!find_attach_dev(path)) {
> +               printf("Failed to find Bluetooth controller virtio\n");
> +               return -1;
> +       }
> +
> +       printf("Forwarding Bluetooth controller from %s\n", path);
> +
> +       fd =3D start_controller_forward(path, controller_pid);
> +       if (fd < 0) {
> +               printf("Failed to forward Bluetooth controller\n");
> +               return -1;
> +       }
> +
> +       basic_flags =3D (1 << HCI_UART_RESET_ON_INIT);
> +       extra_flags =3D (1 << HCI_UART_VND_DETECT);
> +
> +       printf("Attaching Bluetooth controller\n");
> +
> +       return attach_proto(fd, HCI_UART_H4, basic_flags, extra_flags);
> +}
> +
>  static void run_command(char *cmdname, char *home)
>  {
>         char *argv[9], *envp[3];
>         int pos =3D 0, idx =3D 0;
>         int serial_fd;
>         pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
> -             dbus_session_pid, audio_pid[2];
> +               dbus_session_pid, audio_pid[2], controller_pid;
>         int i;
>
>         if (!home) {
> @@ -910,18 +1072,11 @@ static void run_command(char *cmdname, char *home)
>         }
>
>         if (num_devs) {
> -               const char *node =3D "/dev/ttyS1";
> -               unsigned int basic_flags, extra_flags;
> -
> -               printf("Attaching BR/EDR controller to %s\n", node);
> -
> -               basic_flags =3D (1 << HCI_UART_RESET_ON_INIT);
> -               extra_flags =3D (1 << HCI_UART_VND_DETECT);
> -
> -               serial_fd =3D attach_proto(node, HCI_UART_H4, basic_flags=
,
> -                                                               extra_fla=
gs);
> -       } else
> +               serial_fd =3D attach_controller(&controller_pid);
> +       } else {
>                 serial_fd =3D -1;
> +               controller_pid =3D -1;
> +       }
>
>         if (start_dbus) {
>                 create_dbus_system_conf();
> @@ -1063,6 +1218,11 @@ start_next:
>                         monitor_pid =3D -1;
>                 }
>
> +               if (corpse =3D=3D controller_pid) {
> +                       printf("Controller terminated\n");
> +                       controller_pid =3D -1;
> +               }
> +
>                 for (i =3D 0; i < 2; ++i) {
>                         if (corpse =3D=3D audio_pid[i]) {
>                                 printf("Audio server %d terminated\n", i)=
;
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
