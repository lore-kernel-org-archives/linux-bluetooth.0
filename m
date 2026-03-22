Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0E37F729
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215025; cv=pass; b=c+GaqqoMFhjXbdjpxfyeBm84gjmBNg6ioGB8XvKvLy2pQhFxAUiWUTxsyl3K2olegk5FQ5DUIZdglntnDSZGDlxyVZb967sVgiqU5OQZmI1YK4WRNL0N9eGP3dhn48SozcToafdU6FsHkrA+s1riRnAYqC6ExGSVVJCGn6AFzgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215025; c=relaxed/simple;
	bh=mHtLA+wYFyW4sEzzuHDseq6Uu6z7fNCD7vEfCK2z1sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn2wbZMSpZz7UyYc6371mZKbRzVaX2tIoSDyR8UV+r4rkPuFM3uBH/mjtLzFSWyXXwVKPp0c29L3WYKzcJlE2ijDG39uwm6Ejw0hy5c6PkIx60gZr0y+lpD6OIPy6IgcteXDWNSBiCiWOtmh8vY75rkZIHaRL12W494VILcTDlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=E7+jh39U; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="E7+jh39U"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8bW2VdCzyw8;
	Sun, 22 Mar 2026 23:30:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vifZ5Bl+NNkzULKpYdpJbdBN9CLaicALlPpn4pdgxJk=;
	b=E7+jh39Ux5K61PAAx8S6ZS1QXX1jxB2Zto8GR2vBD5ogLAo4949MrnzqS/NgsFtnqRKmh9
	YIvHX+UizmZuMXpfbEeSfjKxMrXhOnngLJxHYsDWvkSuCwWgyQVqe4QZ5Ik1tdJeqszEQH
	mUqOj+cPti/+Ku8ahA63eZFx1JhKqRo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215015;
	b=jXJgNVsC0Yq1Nx+Ip//67Q7u8gOo6yGkKA2bGWnQb/S0rBVkzUrQCXtul3Y9cdn0yAdnWN
	7FC10N9hcQnbwoPIyZUKnIphG3qCvcILuO9wl2sdCM6gEXdokMvWRzz8XEr8y6/dB50mzW
	+twljnqvWIQUmNecjL6jy0C6C4yG5SY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vifZ5Bl+NNkzULKpYdpJbdBN9CLaicALlPpn4pdgxJk=;
	b=C8Ytp7QBTYUI+sBe+DNmaUACYO+L3BZPk9UhRWI2v5OJDefPzg11msZalOFsQDhgpgmJug
	ms/yrnOXxjzJ36eoDZn0cuTj9qc8flpLxhyPyBs1oleAHkcemPD+fqdJGcbkO2bvjSvJZK
	wv9nKHevRJjdsjQVucXQgIXhou97Klo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 09/20] test-runner: use virtio-serial for implementing -u device forwarding
Date: Sun, 22 Mar 2026 23:29:58 +0200
Message-ID: <34a731c7f20b905dc4b60e66a8c31e5bf3284017.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using pci-serial to forward eg. btvirt sockets is unreliable, as qemu or
kernel seems to be sometimes dropping part of the sent data or insert
spurious \0 bytes, leading to sporadic errors like:

    kernel: Bluetooth: hci0: command 0x0c52 tx timeout
    kernel: Bluetooth: hci0: Opcode 0x0c52 failed: -110
    btvirt: packet error, unknown type: 0

This appears to occur most often when host system is under load, e.g.
due to multiple test-runners running at the same time.  The problem is
not specific to btvirt, but seems to be in the qemu serial device layer
vs. kernel interaction.

Change test-runner to use virtserialport to forward the btvirt
connection inside the VM, as virtio-serial doesn't appear to have these
problems.

Since it's not a TTY device, we have to do vport <-> tty-with-hci-ldisc
forwarding of the data in test-runner, so this becomes a bit more
involved.
---
 Makefile.tools      |   2 +
 configure.ac        |   9 ++
 tools/test-runner.c | 300 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 241 insertions(+), 70 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index f6de2e685..6e30a535f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -321,6 +321,8 @@ tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
 tools_btgatt_server_LDADD = src/libshared-mainloop.la \
 						lib/libbluetooth-internal.la
 
+tools_test_runner_LDADD = $(OPENPTY_LIBS)
+
 tools_rctest_LDADD = lib/libbluetooth-internal.la
 
 tools_l2test_LDADD = lib/libbluetooth-internal.la
diff --git a/configure.ac b/configure.ac
index 52de7d665..3bc1f5c44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -251,6 +251,15 @@ AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
 
+openpty_libs=
+if (test "${enable_tools}" != "no"); then
+	AC_CHECK_FUNCS([openpty], [openpty_libs=],
+	  [AC_CHECK_LIB([util], [openpty], [openpty_libs=-lutil],
+	    [AC_CHECK_LIB([bsd], [openpty], [openpty_libs=-lbsd],
+                [AC_MSG_ERROR([openpty not found])])])])
+fi
+AC_SUBST(OPENPTY_LIBS, [${openpty_libs}])
+
 AC_ARG_ENABLE(monitor, AS_HELP_STRING([--disable-monitor],
 		[disable Bluetooth monitor]), [enable_monitor=${enableval}])
 AM_CONDITIONAL(MONITOR, test "${enable_monitor}" != "no")
diff --git a/tools/test-runner.c b/tools/test-runner.c
index b3e0b0cfe..576313b79 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -24,6 +24,9 @@
 #include <getopt.h>
 #include <poll.h>
 #include <limits.h>
+#include <dirent.h>
+#include <pty.h>
+#include <stdint.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -306,7 +309,7 @@ static void start_qemu(void)
 				testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
-			(sizeof(char *) * (6 + (num_devs * 4))) +
+			(sizeof(char *) * (8 + (num_devs * 4))) +
 			(sizeof(char *) * (usb_dev ? 4 : 0)) +
 			(sizeof(char *) * num_extra_opts));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
@@ -330,14 +333,17 @@ static void start_qemu(void)
 	argv[pos++] = "-append";
 	argv[pos++] = (char *) cmdline;
 
+	argv[pos++] = "-device";
+	argv[pos++] = "virtio-serial";
+
 	for (i = 0; i < num_devs; i++) {
 		char *chrdev, *serdev;
 
 		chrdev = alloca(48 + strlen(device_path));
 		sprintf(chrdev, "socket,path=%s,id=bt%d", device_path, i);
 
-		serdev = alloca(48);
-		sprintf(serdev, "pci-serial,chardev=bt%d", i);
+		serdev = alloca(64);
+		sprintf(serdev, "virtserialport,chardev=bt%d,name=bt.%d", i, i);
 
 		argv[pos++] = "-chardev";
 		argv[pos++] = chrdev;
@@ -360,65 +366,12 @@ static void start_qemu(void)
 	execve(argv[0], argv, qemu_envp);
 }
 
-static int open_serial(const char *path)
-{
-	struct termios ti;
-	int fd, saved_ldisc, ldisc = N_HCI;
-
-	fd = open(path, O_RDWR | O_NOCTTY);
-	if (fd < 0) {
-		perror("Failed to open serial port");
-		return -1;
-	}
-
-	if (tcflush(fd, TCIOFLUSH) < 0) {
-		perror("Failed to flush serial port");
-		close(fd);
-		return -1;
-	}
-
-	if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
-		perror("Failed get serial line discipline");
-		close(fd);
-		return -1;
-	}
-
-	/* Switch TTY to raw mode */
-	memset(&ti, 0, sizeof(ti));
-	cfmakeraw(&ti);
-
-	ti.c_cflag |= (B115200 | CLOCAL | CREAD);
-
-	/* Set flow control */
-	ti.c_cflag |= CRTSCTS;
-
-	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
-		perror("Failed to set serial port settings");
-		close(fd);
-		return -1;
-	}
-
-	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
-		perror("Failed set serial line discipline");
-		close(fd);
-		return -1;
-	}
-
-	printf("Switched line discipline from %d to %d\n", saved_ldisc, ldisc);
-
-	return fd;
-}
-
-static int attach_proto(const char *path, unsigned int proto,
+static int attach_proto(int fd, unsigned int proto,
 					unsigned int mandatory_flags,
 					unsigned int optional_flags)
 {
 	unsigned int flags = mandatory_flags | optional_flags;
-	int fd, dev_id;
-
-	fd = open_serial(path);
-	if (fd < 0)
-		return -1;
+	int dev_id;
 
 	if (ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
 		if (errno == EINVAL) {
@@ -895,13 +848,222 @@ static int start_audio_server(pid_t pids[2])
 	return 0;
 }
 
+static bool find_attach_dev(char path[PATH_MAX])
+{
+	const char *vport_path = "/sys/class/virtio-ports";
+	struct dirent *entry;
+	DIR *dir;
+
+	dir = opendir(vport_path);
+	if (!dir)
+		return false;
+
+	while ((entry = readdir(dir)) != NULL) {
+		FILE *f;
+		char buf[64];
+		size_t size;
+
+		snprintf(path, PATH_MAX, "%s/%s/name", vport_path,
+								entry->d_name);
+		f = fopen(path, "r");
+		if (!f)
+			continue;
+
+		size = fread(buf, 1, sizeof(buf) - 1, f);
+		buf[size] = 0;
+
+		fclose(f);
+
+		if (strncmp(buf, "bt.", 3) == 0) {
+			snprintf(path, PATH_MAX, "/dev/%s", entry->d_name);
+			closedir(dir);
+			return true;
+		}
+	}
+
+	closedir(dir);
+	return false;
+}
+
+static void copy_fd_bidi(int src, int dst)
+{
+	fd_set rfds, wfds;
+	int fd[2] = { src, dst };
+	uint8_t buf[2][4096];
+	size_t size[2] = { 0, 0 };
+	size_t pos[2] = { 0, 0 };
+	int i, ret;
+
+	/* Simple copying of data src <-> dst to both directions */
+
+	for (i = 0; i < 2; ++i) {
+		int flags = fcntl(fd[i], F_GETFL);
+
+		if (fcntl(fd[i], F_SETFL, flags | O_NONBLOCK) < 0) {
+			perror("fcntl");
+			goto error;
+		}
+	}
+
+	while (1) {
+		FD_ZERO(&rfds);
+		FD_ZERO(&wfds);
+
+		for (i = 0; i < 2; ++i) {
+			if (size[i])
+				FD_SET(fd[i], &wfds);
+			else
+				FD_SET(fd[1 - i], &rfds);
+		}
+
+		ret = select(FD_SETSIZE, &rfds, &wfds, NULL, NULL);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			perror("select");
+			goto error;
+		}
+
+		for (i = 0; i < 2; ++i) {
+			ssize_t s;
+
+			if (!size[i] && FD_ISSET(fd[1 - i], &rfds)) {
+				s = read(fd[1 - i], buf[i], sizeof(buf[i]));
+				if (s >= 0) {
+					size[i] = s;
+					pos[i] = 0;
+				} else if (errno == EINTR) {
+					/* ok */
+				} else {
+					perror("read");
+					goto error;
+				}
+
+			}
+
+			if (size[i]) {
+				s = write(fd[i], buf[i] + pos[i], size[i]);
+				if (s >= 0) {
+					size[i] -= s;
+					pos[i] += s;
+				} else if (errno == EINTR || errno == EAGAIN
+						|| errno == EWOULDBLOCK) {
+					/* ok */
+				} else {
+					perror("write");
+					goto error;
+				}
+			}
+		}
+	}
+	return;
+
+error:
+	fprintf(stderr, "Bluetooth controller forward terminated with error\n");
+	exit(1);
+}
+
+static int start_controller_forward(const char *path, pid_t *controller_pid)
+{
+	struct termios ti;
+	pid_t pid;
+	int src = -1, dst = -1, fd = -1;
+	int ret, saved_ldisc, ldisc = N_HCI;
+
+	/* virtio-serial ports cannot be used for HCI line disciple, so
+	 * openpty() serial device and forward data to/from it.
+	 */
+
+	src = open(path, O_RDWR);
+	if (src < 0)
+		goto error;
+
+	/* Raw mode TTY */
+	memset(&ti, 0, sizeof(ti));
+	cfmakeraw(&ti);
+	ti.c_cflag |= B115200 | CLOCAL | CREAD;
+
+	/* With flow control */
+	ti.c_cflag |= CRTSCTS;
+
+	ret = openpty(&dst, &fd, NULL, &ti, NULL);
+	if (ret < 0)
+		goto error;
+
+	if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
+		perror("Failed get serial line discipline");
+		goto error;
+	}
+
+	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
+		perror("Failed set serial line discipline");
+		goto error;
+	}
+
+	printf("Switched line discipline from %d to %d\n", saved_ldisc, ldisc);
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		goto error;
+	} else if (pid == 0) {
+		close(fd);
+		copy_fd_bidi(src, dst);
+		exit(0);
+	}
+
+	*controller_pid = pid;
+
+	close(src);
+	close(dst);
+	return fd;
+
+error:
+	if (src >= 0)
+		close(src);
+	if (dst >= 0)
+		close(dst);
+	if (fd >= 0)
+		close(fd);
+	return -1;
+}
+
+static int attach_controller(pid_t *controller_pid)
+{
+	unsigned int basic_flags, extra_flags;
+	char path[PATH_MAX];
+	int fd;
+
+	*controller_pid = -1;
+
+	if (!find_attach_dev(path)) {
+		printf("Failed to find Bluetooth controller virtio\n");
+		return -1;
+	}
+
+	printf("Forwarding Bluetooth controller from %s\n", path);
+
+	fd = start_controller_forward(path, controller_pid);
+	if (fd < 0) {
+		printf("Failed to forward Bluetooth controller\n");
+		return -1;
+	}
+
+	basic_flags = (1 << HCI_UART_RESET_ON_INIT);
+	extra_flags = (1 << HCI_UART_VND_DETECT);
+
+	printf("Attaching Bluetooth controller\n");
+
+	return attach_proto(fd, HCI_UART_H4, basic_flags, extra_flags);
+}
+
 static void run_command(char *cmdname, char *home)
 {
 	char *argv[9], *envp[3];
 	int pos = 0, idx = 0;
 	int serial_fd;
 	pid_t pid, dbus_pid, daemon_pid, monitor_pid, emulator_pid,
-	      dbus_session_pid, audio_pid[2];
+		dbus_session_pid, audio_pid[2], controller_pid;
 	int i;
 
 	if (!home) {
@@ -910,18 +1072,11 @@ static void run_command(char *cmdname, char *home)
 	}
 
 	if (num_devs) {
-		const char *node = "/dev/ttyS1";
-		unsigned int basic_flags, extra_flags;
-
-		printf("Attaching BR/EDR controller to %s\n", node);
-
-		basic_flags = (1 << HCI_UART_RESET_ON_INIT);
-		extra_flags = (1 << HCI_UART_VND_DETECT);
-
-		serial_fd = attach_proto(node, HCI_UART_H4, basic_flags,
-								extra_flags);
-	} else
+		serial_fd = attach_controller(&controller_pid);
+	} else {
 		serial_fd = -1;
+		controller_pid = -1;
+	}
 
 	if (start_dbus) {
 		create_dbus_system_conf();
@@ -1063,6 +1218,11 @@ start_next:
 			monitor_pid = -1;
 		}
 
+		if (corpse == controller_pid) {
+			printf("Controller terminated\n");
+			controller_pid = -1;
+		}
+
 		for (i = 0; i < 2; ++i) {
 			if (corpse == audio_pid[i]) {
 				printf("Audio server %d terminated\n", i);
-- 
2.53.0

