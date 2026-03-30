Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65023BC67C
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873856; cv=none; b=fZ42+NqBdjFcvHn0Z6LQfWWVxRVUOhAn5rpI49E2KTEvVZzl4a19o6fz+XM/WPqDrINGe7MrvkEWaEph2Y5aJnmpbHmf8GMU0voQ2jaaPASGU4wL9XuAUGgKmkNGci0lnJKgiLd1cmkNFDB5AZ7YnHSVJPslo+C6rYoWbsSPkP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873856; c=relaxed/simple;
	bh=TPU3iMmd41AvXAsd8WbV34P1GBsC8OW8KqLcvg1dtPo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TWgNDxOpntkh4iJkIgEN1kd3InMxxZ5uG9ACV6I9Qw3jXWO8uKbZTx+t+5bKT+RsTh1YLibPKAzkuuJE+hMUyhSNjUUQOefR33G4ZwCDAoTY/vVx7HIYClYmM/Bizp0OXVJ/Uu2Qealm52av7dJKZJS1Woxkl32R5D6kPTdVZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10B9A3EC20;
	Mon, 30 Mar 2026 12:30:52 +0000 (UTC)
Message-ID: <e0edff5ac18ef0181ff9fc7a009d21fb10fbfb54.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3 09/20] test-runner: use virtio-serial for
 implementing -u device forwarding
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Mon, 30 Mar 2026 14:30:52 +0200
In-Reply-To: <34a731c7f20b905dc4b60e66a8c31e5bf3284017.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
	 <34a731c7f20b905dc4b60e66a8c31e5bf3284017.1774214693.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFKk5jQ1M66HTqhvUVKC1kH1gZMcmXX19ap+8kAie8kuK9hZ7m5onqSvYDnSQlDbPI5UaOqBE2R6NXR5x5OvxC5VYnqp23tXf80YeiveEHEUIaUjgZvyuRfoTKAADFW/Csafqc3A0YFWBjdk7j4xYfMz0ZWnICQx4Dxszl1VxNr3Ug2eynl7MGvhmRY3QER39MIne9FUYR4UrRFApR1EPG/wMTP/fU+Hhu2GM3qB5nZy3mK4/Y2WGLTTnIluLTiTY23uJq/qduV6UmROqtnF4yPiFylWTSIvDfoaRmGXvaBc2ej2lKTTZJFtoGTXoPv46y3qY319vL/cHh2Mc8pG7lXl3M5WBVsXTQI0RQHry3tado4llL9Glb6D+YIMrUyA9YBbGKeQ1y0tRt2Y+Qu6XW6HTq3H2T/4LsQfUYz/UQYaI24tV50Ux3eZIa/HeYv1xgAi1qeRKas1H0DlqbeF++07wFFvBRL5Q4l9fpJJNKsHDbVt7hDYdMG7ss1okBwwPdaLZuwLbDV4MLx1DltKyXD31q2xKvH7zILWqAFvWWbssfiwyVHf8ujXffGlWmjiSKHtp1gj0rwXPlHfmjpJb8PGEFZbPhAwapFXvcnevH3NWZXkpEDQCzwfWjW32u7FrxH6bl8b50MNbroanCqG/j6+zRjoqL8VKKYxQtAKuuysQ
X-GND-State: clean
X-GND-Score: -100

On Sun, 2026-03-22 at 23:29 +0200, Pauli Virtanen wrote:
> Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu
> or
> kernel seems to be sometimes dropping part of the sent data or insert
> spurious \0 bytes, leading to sporadic errors like:
>=20
> =C2=A0=C2=A0=C2=A0 kernel: Bluetooth: hci0: command 0x0c52 tx timeout
> =C2=A0=C2=A0=C2=A0 kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
> =C2=A0=C2=A0=C2=A0 btvirt: packet error, unknown type: 0
>=20
> This appears to occur most often when host system is under load, e.g.
> due to multiple test-runners running at the same time.=C2=A0 The problem
> is
> not specific to btvirt, but seems to be in the qemu serial device
> layer
> vs. kernel interaction.
>=20
> Change test-runner to use virtserialport to forward the btvirt
> connection inside the VM, as virtio-serial doesn't appear to have
> these
> problems.
>=20
> Since it's not a TTY device, we have to do vport <-> tty-with-hci-
> ldisc
> forwarding of the data in test-runner, so this becomes a bit more
> involved.
> ---
> =C2=A0Makefile.tools=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0configure.ac=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 9 ++
> =C2=A0tools/test-runner.c | 300 +++++++++++++++++++++++++++++++++--------=
-
> --
> =C2=A03 files changed, 241 insertions(+), 70 deletions(-)
>=20
> diff --git a/Makefile.tools b/Makefile.tools
> index f6de2e685..6e30a535f 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -321,6 +321,8 @@ tools_btgatt_server_SOURCES =3D tools/btgatt-
> server.c src/uuid-helper.c
> =C2=A0tools_btgatt_server_LDADD =3D src/libshared-mainloop.la \
> =C2=A0						lib/libbluetooth-
> internal.la
> =C2=A0
> +tools_test_runner_LDADD =3D $(OPENPTY_LIBS)
> +
> =C2=A0tools_rctest_LDADD =3D lib/libbluetooth-internal.la
> =C2=A0
> =C2=A0tools_l2test_LDADD =3D lib/libbluetooth-internal.la
> diff --git a/configure.ac b/configure.ac
> index 52de7d665..3bc1f5c44 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -251,6 +251,15 @@ AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-
> tools],
> =C2=A0		[disable Bluetooth tools]),
> [enable_tools=3D${enableval}])
> =C2=A0AM_CONDITIONAL(TOOLS, test "${enable_tools}" !=3D "no")
> =C2=A0
> +openpty_libs=3D
> +if (test "${enable_tools}" !=3D "no"); then
> +	AC_CHECK_FUNCS([openpty], [openpty_libs=3D],
> +	=C2=A0 [AC_CHECK_LIB([util], [openpty], [openpty_libs=3D-lutil],
> +	=C2=A0=C2=A0=C2=A0 [AC_CHECK_LIB([bsd], [openpty], [openpty_libs=3D-lbs=
d],
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [AC_MSG_ERROR([openpty not found])])])])

Why check for -lbsd? The openpty(3) man page just says "-lutil". Is
this maybe copy/pasted from software that can also run on BSD?

> +fi
> +AC_SUBST(OPENPTY_LIBS, [${openpty_libs}])
> +
> =C2=A0AC_ARG_ENABLE(monitor, AS_HELP_STRING([--disable-monitor],
> =C2=A0		[disable Bluetooth monitor]),
> [enable_monitor=3D${enableval}])
> =C2=A0AM_CONDITIONAL(MONITOR, test "${enable_monitor}" !=3D "no")
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index b3e0b0cfe..576313b79 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -24,6 +24,9 @@
> =C2=A0#include <getopt.h>
> =C2=A0#include <poll.h>
> =C2=A0#include <limits.h>
> +#include <dirent.h>
> +#include <pty.h>
> +#include <stdint.h>
> =C2=A0#include <sys/wait.h>
> =C2=A0#include <sys/stat.h>
> =C2=A0#include <sys/types.h>
> @@ -306,7 +309,7 @@ static void start_qemu(void)
> =C2=A0				testargs);
> =C2=A0
> =C2=A0	argv =3D alloca(sizeof(qemu_argv) +
> -			(sizeof(char *) * (6 + (num_devs * 4))) +
> +			(sizeof(char *) * (8 + (num_devs * 4))) +
> =C2=A0			(sizeof(char *) * (usb_dev ? 4 : 0)) +
> =C2=A0			(sizeof(char *) * num_extra_opts));
> =C2=A0	memcpy(argv, qemu_argv, sizeof(qemu_argv));
> @@ -330,14 +333,17 @@ static void start_qemu(void)
> =C2=A0	argv[pos++] =3D "-append";
> =C2=A0	argv[pos++] =3D (char *) cmdline;
> =C2=A0
> +	argv[pos++] =3D "-device";
> +	argv[pos++] =3D "virtio-serial";
> +
> =C2=A0	for (i =3D 0; i < num_devs; i++) {
> =C2=A0		char *chrdev, *serdev;
> =C2=A0
> =C2=A0		chrdev =3D alloca(48 + strlen(device_path));
> =C2=A0		sprintf(chrdev, "socket,path=3D%s,id=3Dbt%d",
> device_path, i);
> =C2=A0
> -		serdev =3D alloca(48);
> -		sprintf(serdev, "pci-serial,chardev=3Dbt%d", i);
> +		serdev =3D alloca(64);
> +		sprintf(serdev,
> "virtserialport,chardev=3Dbt%d,name=3Dbt.%d", i, i);
> =C2=A0
> =C2=A0		argv[pos++] =3D "-chardev";
> =C2=A0		argv[pos++] =3D chrdev;
> @@ -360,65 +366,12 @@ static void start_qemu(void)
> =C2=A0	execve(argv[0], argv, qemu_envp);
> =C2=A0}
> =C2=A0
> -static int open_serial(const char *path)
> -{
> -	struct termios ti;
> -	int fd, saved_ldisc, ldisc =3D N_HCI;
> -
> -	fd =3D open(path, O_RDWR | O_NOCTTY);
> -	if (fd < 0) {
> -		perror("Failed to open serial port");
> -		return -1;
> -	}
> -
> -	if (tcflush(fd, TCIOFLUSH) < 0) {
> -		perror("Failed to flush serial port");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
> -		perror("Failed get serial line discipline");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	/* Switch TTY to raw mode */
> -	memset(&ti, 0, sizeof(ti));
> -	cfmakeraw(&ti);
> -
> -	ti.c_cflag |=3D (B115200 | CLOCAL | CREAD);
> -
> -	/* Set flow control */
> -	ti.c_cflag |=3D CRTSCTS;
> -
> -	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
> -		perror("Failed to set serial port settings");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
> -		perror("Failed set serial line discipline");
> -		close(fd);
> -		return -1;
> -	}
> -
> -	printf("Switched line discipline from %d to %d\n",
> saved_ldisc, ldisc);
> -
> -	return fd;
> -}
> -
> -static int attach_proto(const char *path, unsigned int proto,
> +static int attach_proto(int fd, unsigned int proto,
> =C2=A0					unsigned int
> mandatory_flags,
> =C2=A0					unsigned int optional_flags)
> =C2=A0{
> =C2=A0	unsigned int flags =3D mandatory_flags | optional_flags;
> -	int fd, dev_id;
> -
> -	fd =3D open_serial(path);
> -	if (fd < 0)
> -		return -1;
> +	int dev_id;
> =C2=A0
> =C2=A0	if (ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
> =C2=A0		if (errno =3D=3D EINVAL) {
> @@ -895,13 +848,222 @@ static int start_audio_server(pid_t pids[2])
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static bool find_attach_dev(char path[PATH_MAX])
> +{
> +	const char *vport_path =3D "/sys/class/virtio-ports";
> +	struct dirent *entry;
> +	DIR *dir;
> +
> +	dir =3D opendir(vport_path);
> +	if (!dir)
> +		return false;
> +
> +	while ((entry =3D readdir(dir)) !=3D NULL) {
> +		FILE *f;
> +		char buf[64];
> +		size_t size;
> +
> +		snprintf(path, PATH_MAX, "%s/%s/name", vport_path,
> +								entr
> y->d_name);
> +		f =3D fopen(path, "r");
> +		if (!f)
> +			continue;
> +
> +		size =3D fread(buf, 1, sizeof(buf) - 1, f);
> +		buf[size] =3D 0;
> +
> +		fclose(f);
> +
> +		if (strncmp(buf, "bt.", 3) =3D=3D 0) {
> +			snprintf(path, PATH_MAX, "/dev/%s", entry-
> >d_name);
> +			closedir(dir);
> +			return true;
> +		}
> +	}
> +
> +	closedir(dir);
> +	return false;
> +}
> +
> +static void copy_fd_bidi(int src, int dst)
> +{
> +	fd_set rfds, wfds;
> +	int fd[2] =3D { src, dst };
> +	uint8_t buf[2][4096];
> +	size_t size[2] =3D { 0, 0 };
> +	size_t pos[2] =3D { 0, 0 };
> +	int i, ret;
> +
> +	/* Simple copying of data src <-> dst to both directions */
> +
> +	for (i =3D 0; i < 2; ++i) {
> +		int flags =3D fcntl(fd[i], F_GETFL);
> +
> +		if (fcntl(fd[i], F_SETFL, flags | O_NONBLOCK) < 0) {
> +			perror("fcntl");
> +			goto error;
> +		}
> +	}
> +
> +	while (1) {
> +		FD_ZERO(&rfds);
> +		FD_ZERO(&wfds);
> +
> +		for (i =3D 0; i < 2; ++i) {
> +			if (size[i])
> +				FD_SET(fd[i], &wfds);
> +			else
> +				FD_SET(fd[1 - i], &rfds);
> +		}
> +
> +		ret =3D select(FD_SETSIZE, &rfds, &wfds, NULL, NULL);
> +		if (ret < 0) {
> +			if (errno =3D=3D EINTR)
> +				continue;
> +			perror("select");
> +			goto error;
> +		}
> +
> +		for (i =3D 0; i < 2; ++i) {
> +			ssize_t s;
> +
> +			if (!size[i] && FD_ISSET(fd[1 - i], &rfds))
> {
> +				s =3D read(fd[1 - i], buf[i],
> sizeof(buf[i]));
> +				if (s >=3D 0) {
> +					size[i] =3D s;
> +					pos[i] =3D 0;
> +				} else if (errno =3D=3D EINTR) {
> +					/* ok */
> +				} else {
> +					perror("read");
> +					goto error;
> +				}
> +
> +			}
> +
> +			if (size[i]) {
> +				s =3D write(fd[i], buf[i] + pos[i],
> size[i]);
> +				if (s >=3D 0) {
> +					size[i] -=3D s;
> +					pos[i] +=3D s;
> +				} else if (errno =3D=3D EINTR || errno
> =3D=3D EAGAIN
> +						|| errno =3D=3D
> EWOULDBLOCK) {
> +					/* ok */
> +				} else {
> +					perror("write");
> +					goto error;
> +				}
> +			}
> +		}
> +	}
> +	return;
> +
> +error:
> +	fprintf(stderr, "Bluetooth controller forward terminated
> with error\n");
> +	exit(1);
> +}
> +
> +static int start_controller_forward(const char *path, pid_t
> *controller_pid)
> +{
> +	struct termios ti;
> +	pid_t pid;
> +	int src =3D -1, dst =3D -1, fd =3D -1;
> +	int ret, saved_ldisc, ldisc =3D N_HCI;
> +
> +	/* virtio-serial ports cannot be used for HCI line disciple,
> so
> +	 * openpty() serial device and forward data to/from it.
> +	 */
> +
> +	src =3D open(path, O_RDWR);
> +	if (src < 0)
> +		goto error;
> +
> +	/* Raw mode TTY */
> +	memset(&ti, 0, sizeof(ti));
> +	cfmakeraw(&ti);
> +	ti.c_cflag |=3D B115200 | CLOCAL | CREAD;
> +
> +	/* With flow control */
> +	ti.c_cflag |=3D CRTSCTS;
> +
> +	ret =3D openpty(&dst, &fd, NULL, &ti, NULL);
> +	if (ret < 0)
> +		goto error;
> +
> +	if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
> +		perror("Failed get serial line discipline");
> +		goto error;
> +	}
> +
> +	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
> +		perror("Failed set serial line discipline");
> +		goto error;
> +	}
> +
> +	printf("Switched line discipline from %d to %d\n",
> saved_ldisc, ldisc);
> +
> +	pid =3D fork();
> +	if (pid < 0) {
> +		perror("Failed to fork new process");
> +		goto error;
> +	} else if (pid =3D=3D 0) {
> +		close(fd);
> +		copy_fd_bidi(src, dst);
> +		exit(0);
> +	}
> +
> +	*controller_pid =3D pid;
> +
> +	close(src);
> +	close(dst);
> +	return fd;
> +
> +error:
> +	if (src >=3D 0)
> +		close(src);
> +	if (dst >=3D 0)
> +		close(dst);
> +	if (fd >=3D 0)
> +		close(fd);
> +	return -1;
> +}
> +
> +static int attach_controller(pid_t *controller_pid)
> +{
> +	unsigned int basic_flags, extra_flags;
> +	char path[PATH_MAX];
> +	int fd;
> +
> +	*controller_pid =3D -1;
> +
> +	if (!find_attach_dev(path)) {
> +		printf("Failed to find Bluetooth controller
> virtio\n");
> +		return -1;
> +	}
> +
> +	printf("Forwarding Bluetooth controller from %s\n", path);
> +
> +	fd =3D start_controller_forward(path, controller_pid);
> +	if (fd < 0) {
> +		printf("Failed to forward Bluetooth controller\n");
> +		return -1;
> +	}
> +
> +	basic_flags =3D (1 << HCI_UART_RESET_ON_INIT);
> +	extra_flags =3D (1 << HCI_UART_VND_DETECT);
> +
> +	printf("Attaching Bluetooth controller\n");
> +
> +	return attach_proto(fd, HCI_UART_H4, basic_flags,
> extra_flags);
> +}
> +
> =C2=A0static void run_command(char *cmdname, char *home)
> =C2=A0{
> =C2=A0	char *argv[9], *envp[3];
> =C2=A0	int pos =3D 0, idx =3D 0;
> =C2=A0	int serial_fd;
> =C2=A0	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
> -	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dbus_session_pid, audio_pid[2];
> +		dbus_session_pid, audio_pid[2], controller_pid;
> =C2=A0	int i;
> =C2=A0
> =C2=A0	if (!home) {
> @@ -910,18 +1072,11 @@ static void run_command(char *cmdname, char
> *home)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (num_devs) {
> -		const char *node =3D "/dev/ttyS1";
> -		unsigned int basic_flags, extra_flags;
> -
> -		printf("Attaching BR/EDR controller to %s\n", node);
> -
> -		basic_flags =3D (1 << HCI_UART_RESET_ON_INIT);
> -		extra_flags =3D (1 << HCI_UART_VND_DETECT);
> -
> -		serial_fd =3D attach_proto(node, HCI_UART_H4,
> basic_flags,
> -
> 								extra_flags);
> -	} else
> +		serial_fd =3D attach_controller(&controller_pid);
> +	} else {
> =C2=A0		serial_fd =3D -1;
> +		controller_pid =3D -1;
> +	}
> =C2=A0
> =C2=A0	if (start_dbus) {
> =C2=A0		create_dbus_system_conf();
> @@ -1063,6 +1218,11 @@ start_next:
> =C2=A0			monitor_pid =3D -1;
> =C2=A0		}
> =C2=A0
> +		if (corpse =3D=3D controller_pid) {
> +			printf("Controller terminated\n");
> +			controller_pid =3D -1;
> +		}
> +
> =C2=A0		for (i =3D 0; i < 2; ++i) {
> =C2=A0			if (corpse =3D=3D audio_pid[i]) {
> =C2=A0				printf("Audio server %d
> terminated\n", i);
