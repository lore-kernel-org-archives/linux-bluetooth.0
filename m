Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F01A680A
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485418; cv=pass; b=HJkQUXtodQCQR/mzr8UmrEROMgZG+ASdnoS+wQF9p/g9GIUJAHj38/8UNrnxSLgm+EOftrAzWKK8K0e1QZRcO2s1BCFOClv5vPZpSOBq3DMbh4n6p/F+A6/bkDDTsfoRk8b52uy/Vv93mYI+OJOYSCVDTl6Yg87jveVncjYzwmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485418; c=relaxed/simple;
	bh=sh0zeQn5O8VzF+54Ggz1ffVzI2UaxFr3WgCHDYveM0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgEujXEnmzV5eD/HTwP3GhdwR03AdYilRU6o3o+YrmEkqotuXY/Z8cO8npm4ZHfUa85i5arl0lefSotVh9seBjk63aLrjcs2CUtY7U9V0Sa1LmVZ1zUTUVcCDXuHsabojasGBc+X9jiCpIbbGTDcDKIZvafcqGsxfoqbGeMs4CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDU1d1Tg; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDU1d1Tg"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso4691184d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 13:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772485416; cv=none;
        d=google.com; s=arc-20240605;
        b=bWoxRLNdd0NAwuUhUbTVap6o1WnkGE0xzuA0iVLqWc5VFhS0z+pZCAqTetXPgs24wQ
         DRIz8NDty+pxdQz9pv/K5n6aR1ZaTM/B32477gMA3ieOhfxc/TYG0e3o/xgv1QZzIrBm
         M86eRxxXdpR5QRiZNzk1nPiE0DB+Qj1wrbtXkPiKBS1P4QQDNh+pOWlH0UI+t2oeasQe
         njeTi8+CsPtA1rujRh5JZ4e7U8mtPj0opEs6/oUsqENgmYT6JUV82PVcoB5kjITwoIwm
         ETt0NBt75mW/VQFj/CB3e0g8V7Hdg/48fM1j82DAaAP4+OqUZgZNkyorKs9uEQFV0yIU
         u5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wd7x6jdQaF90GGHYrkwj555OpqVQJwsaHCZ8MP78tww=;
        fh=Z9hGMtH+nV7MTezAcoX1lSU6H8xrK+zqv/aC+jUf9uk=;
        b=aVcKTFXAadN7T8HWU3TexwswPKf56nnb2mW7Iln1AUa+c3pbL6y+e4uSF1n9N6VMaV
         eVQJ7JA1jtw9YUkGAm6dqRc2N4b01aDA501CxaM12Yxr5OmhVrMhhKyTyiVBHx9eqj3J
         ZQPWBQNmnXqnpKH2Hjuu32ah5Y6W5xMIEFtn4b1mB6MFB2XT5cqu15YbScp+7/SQbPlY
         cTgDwaMlE1FRJJlhtryDcYul1H8VTws0rXoVo0FT+FoX5Ks0oihsM1gU02WhmFj/mpSz
         PIwrq7PQk6MypN7iMgnEHraEptuz+c01v1N2hunLjIE77UX0gfwXEr2q+mWhjkBi4hbW
         53Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772485416; x=1773090216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd7x6jdQaF90GGHYrkwj555OpqVQJwsaHCZ8MP78tww=;
        b=RDU1d1TgNc+bf/1anwLvskOIwd8yzCt2CUtZqGJLzzJtH4/YMcy5g6SQMMZw07qe5x
         yZve+Fo/8Gkz6SsFoGPsWsy2sJneeumUUCf0HjfsbjLKbW/lLG9Xxmg63tf1Jkdx+f1K
         Kbe/YlKn2Vl32WoWDrNISm/GaQTSY8JZe/o+vikbuSFQn6RwPKiBCp/GazVsMEpvwDGV
         LszK32OlMlR3Aavr/xVA0hScS/T5DLRC6yZKE7Y9FfcH1w2ilrnUDdkgRenDZ82+QE5/
         UKQc0OQiEH3F6EDrTFPbyof8fTnxohJWB8yEOKSaIohfrLX4HiDfUAiIjZsd0aM7vCv6
         qtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772485416; x=1773090216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wd7x6jdQaF90GGHYrkwj555OpqVQJwsaHCZ8MP78tww=;
        b=Rxk+OBuKQeMWQZjtXMwZJ05KfOf2Evc7LOko5dE/TnrPRfj0iaUq9vZEmJZQJMv8G5
         Ve6cCuSlb7wdIbB67xJJFI1NRDbA0dSdZsIAG/2lFgaY+wQUCfl96ZC2AqKGGGQtLe4F
         5WM97KmEEGpCZbUj1cMuGktfVpQ6d5CXZcm/+w7uvO+xyjCjRmmKO81yFKLs0o2V9IO+
         xoarmgq4Lh1SS3zYV0OKqvmxX2w0VVo28iKYNv7LK2gO5B1Nyj140yMqacjdnVEqPlk+
         /zGnLx5y3Evg0PHzU8/A0HC1HApp0CYTK/StZ2t9nVgBdhwHO7ulDYVtYkt2LgAPuo3m
         Sgag==
X-Gm-Message-State: AOJu0YzokgAcEh7at2WzVxFpgKrKe1Rzu3ZE0+Hotf9o5TOlb1n0Gu7E
	7hQZOIz3z9rv+KvBQFF5G7CiQkg0LVknNaCwEkSSr9s3i1QlAyS/b4mMSB6LHwldxULJOKy27o7
	jXjIxPOCP/yaTURU3cKFLv9nVTLIFohU=
X-Gm-Gg: ATEYQzxuae/wDYwjww2VEUdc/aEv7KdIa0mw4UBU0m0Uxct2OMaR0QZ8r9i+9xpGVn6
	QcJTo27V2+1nU+dSCzHg0IRz8HBJ/O9emr+qyqw8EnRtiKd2I+wFedfeIp9PUL77RRFdElupZ1F
	H4pGfEwYLkwo+zXQgmRikRo4djXcoBueYFNe2TE9MWSt9rcB3qrjo1Unv0z9V4Ha/I0pZsKBDk9
	+X+jxIGERu91XbyS6B2ao9Ecjfk2dcld7gn+1mP+x+S3WUdNf03PsjjH4a4suAeOyfAhkotpeSf
	TsEDviE2ujXBExbrUWit0vOj8Tgj78W5ev6J/cAB1QP195WNNqt6Ct68Emjumo1C+/XZ+cXkwcV
	EB3PR
X-Received: by 2002:a05:690e:edb:b0:64c:9a08:9948 with SMTP id
 956f58d0204a3-64cc2302f31mr10457463d50.76.1772485415791; Mon, 02 Mar 2026
 13:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772282574.git.pav@iki.fi> <4fcc1157a7ca09b2a9c394cfb11f2083fecaa3e1.1772282574.git.pav@iki.fi>
In-Reply-To: <4fcc1157a7ca09b2a9c394cfb11f2083fecaa3e1.1772282574.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Mar 2026 16:03:24 -0500
X-Gm-Features: AaiRm53-3P14Alfj8XVk4DQtycMDy8PobtVRF4emr5TPGnDvkK5qwkZvi6-X5AY
Message-ID: <CABBYNZJGkH4iBQbotoELVf5PUNr9tcKn0E6N87r+0TiRYmcuYQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 07/11] test-runner: use virtio-serial for
 implementing -u device forwarding
To: Pauli Virtanen <pav@iki.fi>, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Feb 28, 2026 at 7:52=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu or
> kernel seems to be sometimes dropping part of the sent data or insert
> spurious \0 bytes, leading to sporadic errors like:
>
>     kernel: Bluetooth: hci0: command 0x0c52 tx timeout
>     kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
>     btvirt: packet error, unknown type: 0

Interesting, so this comes down the pci-serial being unreliable? There
have been occurrences of this even without attaching any controller
with the VM, LL Privacy tests in mgmt-tester do occasionally timeout
like above, but perhaps that is a different issue.

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

I wonder if we could just use virtio_bt
(https://github.com/torvalds/linux/blob/master/drivers/bluetooth/virtio_bt.=
c)
here, instead of using a serial, so we don't have to copy the data
both ways? Or perhaps the problem is that this was never completed
upstream @Marcel Holtmann?

> ---
>  tools/test-runner.c | 300 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 230 insertions(+), 70 deletions(-)
>
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
