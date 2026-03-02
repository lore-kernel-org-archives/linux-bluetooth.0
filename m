Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD861A681B
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489661; cv=pass; b=CF08P15PaJkqxZ6qZdgva8PFehurgRSMAJaDuRW6uzLDbOiJe91IrMoqB+qXQB+yGQA3uM0ikFz6ZY3Rlu5iPeaxEknwznXH5CQllViKnC0KJQBGgdSgiNlJOZcnNqLUvfOBQ8QnmiIAszpXDNNZ/HLigjoDJTMRBE+YB9U+u+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489661; c=relaxed/simple;
	bh=ScqlLeslyjGBImNqBFV/1g2iLWOPWAJ0vzsshAH11BQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqnH6B5r4tvA90Llukq0bWWnGwFB8QW5O9ImuRzYt3dcf/n+jznqnEMWxHTsfYqrRH3+o2tf42hLGjawhDT6VTHKHtyh2q2YUbEwlnLv4s4FeKGIe4ysVl23HNsygg8Tg3kj+sw9yfT9UGvnZPnWYy2smEtChy6xg7oiPOOoa0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZVLI/OXK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZVLI/OXK"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fPtWP71Ctz49Pv9;
	Tue, 03 Mar 2026 00:14:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772489650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2xrxotLyv2o9GLfxvAQ6MmGfeagREhQVFYuBIe+en4=;
	b=ZVLI/OXKKqaOlOLRgS7QavXlI6tVGGEF5hhHcTaMl482X6nEGTdipLi7YmJu1RQedOjgDR
	4ljn3sCPm34LD7ATmKt2ojC82ZHLAuJ6uWK2V969cbVvY0MXonjyG0GWUwynfabOa4FktZ
	4ny7OExYm8tdeAL9c35z13+v7KuH6l29bwq3znejQorpHgJPhkkBJGVyWgnCvxCbZfTL7H
	8X8GqJCdl0XgfAcfHfCPMLZPWlbyJVvRv1c4UDv8uuQHYV1Xiclw3gh6xyAJZ9/R+PBelQ
	fWwkfrUFQCynnSIMVMTaChXPwZzX8KWb7pTdHulIm9yjSRSXw+UctAhalvdE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1772489650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2xrxotLyv2o9GLfxvAQ6MmGfeagREhQVFYuBIe+en4=;
	b=S7m3tVb0m02ZMtuUjQPtEfanJ0prBYaoDh1Sid8lBmKd6QYc6vzx8rtgpL7UZCkhRl+6cT
	YjB/+hdhEi95YNl5KTNU+lIj7sMR/phlVyPJPCEjj86mPaoJwzh2GRr3OQvb/LwXFUKfg1
	vzNfsrq3Nibm/sw6Wud0aR3MIY3l/1tI6CVNJ7f5RmxU2/0FZzUrAmV/FD6APaS/PBGzcx
	HzqDvKfropxL2Ncd3ZMgw3oU0QhHmqGIHu1znfWJsBtnDadCUZDNpE+lijtTHpZ6zVOAfX
	Z85YPGRP6w+Up+Z91yteQFCH0rpq+EcilFdLGkSGbVDjSYXH4NrrazNmYxCJuw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1772489650;
	b=DY5mO9ay/LJvu3CV48Lw0lFrEX88aPPK5mDt7rAh7uPxa2R5yqI4Y3j+lL6qfe275LS+cc
	8FRj5ZAZqsb9W9puiRaTBj7SsTk9PNTNpHASMzn3p3695ELXg/iMe8z6/yQvyB6eE4Uq4y
	KiFT112X6k5SEsj+1oWCzDkV8zKZHky00zbrUY48PwLarNCnPGF8bCmw+0FqBrg+eTESLw
	5Px2zIO8UTGwdCVQCGnfN4sQJC4lgRafKGfP+ToOIjoLQCJLBvLoTCGxzHXAnsfZLYmBly
	OV53D0TZkHJSplsnDCff4unmksUaNZ8C34OYCCfX1nlzpSBAEYkraNA/iJvn/g==
Message-ID: <29cb857314f69a5dd79a20161ad3182bf0036d28.camel@iki.fi>
Subject: Re: [PATCH BlueZ 07/11] test-runner: use virtio-serial for
 implementing -u device forwarding
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	 <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 03 Mar 2026 00:14:07 +0200
In-Reply-To: <CABBYNZJGkH4iBQbotoELVf5PUNr9tcKn0E6N87r+0TiRYmcuYQ@mail.gmail.com>
References: <cover.1772282574.git.pav@iki.fi>
	 <4fcc1157a7ca09b2a9c394cfb11f2083fecaa3e1.1772282574.git.pav@iki.fi>
	 <CABBYNZJGkH4iBQbotoELVf5PUNr9tcKn0E6N87r+0TiRYmcuYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-03-02 kello 16:03 -0500, Luiz Augusto von Dentz kirjoitti:
> On Sat, Feb 28, 2026 at 7:52=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
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
>=20
> Interesting, so this comes down the pci-serial being unreliable?=C2=A0

The sporadic corruptions are not specific to btvirt (occur also with
the test rpc channel here if setup via serial chardev), are not present
with virtio-serial, and appear only when the parent machine is under
load. I did not find the root cause for this.

It sounds strange to me, I'd expect qemu serial be heavily used.

It could be test-runner.c is setting up the serial channel wrong for
the -u option, but I did not find if it could be fixed.

> There
> have been occurrences of this even without attaching any controller
> with the VM, LL Privacy tests in mgmt-tester do occasionally timeout
> like above, but perhaps that is a different issue.

mgmt-tester btdev connects via vhci and runs inside the vm, so this
sounds like different issue.

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
> I wonder if we could just use virtio_bt
> (https://github.com/torvalds/linux/blob/master/drivers/bluetooth/virtio_b=
t.c)
> here, instead of using a serial, so we don't have to copy the data
> both ways? Or perhaps the problem is that this was never completed
> upstream @Marcel Holtmann?

At first sight it looks like Qemu does not support virtio-bluetooth.

> > ---
> >  tools/test-runner.c | 300 +++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 230 insertions(+), 70 deletions(-)
> >=20
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
