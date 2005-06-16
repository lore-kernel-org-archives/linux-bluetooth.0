Return-Path: <lcapitulino@conectiva.com.br>
Message-ID: <42B1DA59.6040608@conectiva.com.br>
Date: Thu, 16 Jun 2005 17:00:25 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net, marcel@holtmann.org
Subject: [RESEND] - Fixes rfcomm program error codes.
Content-Type: multipart/mixed;
 boundary="------------010106010201060404050306"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010106010201060404050306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I sent this patch some days ago, but I saw that my e-mail client
took the bluez-users address. Hopes to not annoy you sending it
again (to the right place now).

rfcomm program does not return proper error codes to the environment,
this makes hard to use it from a shell script or from another program.

Here goes a patch to fix it. I didn't have much time to test it, so
any feedback is welcome.

- Changes functions to return -1 on error and 0 on success
- Adds missing error checks
- Adds missing error messages
- Fixes rfcomm exit() return codes

  rfcomm/main.c |  192 
+++++++++++++++++++++++++++++++++++++++-------------------
  1 files changed, 131 insertions(+), 61 deletions(-)

-- 
Luiz Fernando N. Capitulino

--------------010106010201060404050306
Content-Type: text/x-patch;
 name="rfcomm_return_codes_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rfcomm_return_codes_1.patch"


- Changes functions to return -1 on error and 0 on success
- Adds missing error checks
- Adds missing error messages
- Fixed rfcomm exit() return codes

 rfcomm/main.c |  192 +++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 131 insertions(+), 61 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/rfcomm/main.c a~/rfcomm/main.c
--- a/rfcomm/main.c	2004-11-25 10:05:16.000000000 -0200
+++ a~/rfcomm/main.c	2005-06-12 20:09:07.000000000 -0300
@@ -120,7 +120,7 @@ static void print_dev_info(struct rfcomm
 		di->flags ? rfcomm_flagstostr(di->flags) : "");
 }
 
-static void print_dev_list(int ctl, int flags)
+static int print_dev_list(int ctl, int flags)
 {
 	struct rfcomm_dev_list_req *dl;
 	struct rfcomm_dev_info *di;
@@ -129,7 +129,7 @@ static void print_dev_list(int ctl, int 
 	dl = malloc(sizeof(*dl) + RFCOMM_MAX_DEV * sizeof(*di));
 	if (!dl) {
 		perror("Can't allocate memory");
-		exit(1);
+		return -1;
 	}
 
 	dl->dev_num = RFCOMM_MAX_DEV;
@@ -137,11 +137,13 @@ static void print_dev_list(int ctl, int 
 
 	if (ioctl(ctl, RFCOMMGETDEVLIST, (void *) dl) < 0) {
 		perror("Can't get device list");
-		exit(1);
+		return -1;
 	}
 
 	for (i = 0; i < dl->dev_num; i++)
 		print_dev_info(di + i);
+
+	return 0;
 }
 
 static int create_dev(int ctl, int dev, uint32_t flags, bdaddr_t *bdaddr, int argc, char **argv)
@@ -165,7 +167,7 @@ static int create_dev(int ctl, int dev, 
 
 		if (bacmp(&req.dst, BDADDR_ANY) == 0) {
 			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
-			return -EFAULT;
+			return -1;
 		}
 		
 	} else {
@@ -205,7 +207,8 @@ static int create_all(int ctl)
 		req.channel = rfcomm_opts[i].channel;
 
 		if (bacmp(&req.dst, BDADDR_ANY) != 0)
-			ioctl(ctl, RFCOMMCREATEDEV, &req);
+			if (ioctl(ctl, RFCOMMCREATEDEV, &req) < 0)
+				perror("Can't create RFCOMM device");
 	}
 
 	return 0;
@@ -234,7 +237,7 @@ static int release_all(int ctl)
 	dl = malloc(sizeof(*dl) + RFCOMM_MAX_DEV * sizeof(*di));
 	if (!dl) {
 		perror("Can't allocate memory");
-		exit(1);
+		return -1;
 	}
 
 	dl->dev_num = RFCOMM_MAX_DEV;
@@ -242,7 +245,7 @@ static int release_all(int ctl)
 
 	if (ioctl(ctl, RFCOMMGETDEVLIST, (void *) dl) < 0) {
 		perror("Can't get device list");
-		exit(1);
+		return -1;
 	}
 
 	for (i = 0; i < dl->dev_num; i++)
@@ -251,7 +254,7 @@ static int release_all(int ctl)
 	return 0;
 }
 
-static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	struct sockaddr_rc laddr, raddr;
 	struct rfcomm_dev_req req;
@@ -268,7 +271,7 @@ static void cmd_connect(int ctl, int dev
 	if (argc < 2) {
 		if (rfcomm_read_config(rfcomm_config_file) < 0) {
 			perror("Can't open RFCOMM config file");
-			return;
+			return -1;
 		}
 
 		raddr.rc_family = AF_BLUETOOTH;
@@ -277,7 +280,7 @@ static void cmd_connect(int ctl, int dev
 
 		if (bacmp(&raddr.rc_bdaddr, BDADDR_ANY) == 0) {
 			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
-			return;
+			return -1;
 		}
 	} else {
 		raddr.rc_family = AF_BLUETOOTH;
@@ -291,26 +294,26 @@ static void cmd_connect(int ctl, int dev
 
 	if ((sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
 		perror("Can't create RFCOMM socket");
-		return;
+		return -1;
 	}
 
 	if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
 		perror("Can't bind RFCOMM socket");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	if (connect(sk, (struct sockaddr *)&raddr, sizeof(raddr)) < 0) {
 		perror("Can't connect RFCOMM socket");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	alen = sizeof(laddr);
 	if (getsockname(sk, (struct sockaddr *)&laddr, &alen) < 0) {
 		perror("Can't get RFCOMM socket name");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	memset(&req, 0, sizeof(req));
@@ -324,7 +327,7 @@ static void cmd_connect(int ctl, int dev
 	if ((dev = ioctl(sk, RFCOMMCREATEDEV, &req)) < 0) {
 		perror("Can't create RFCOMM TTY");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
@@ -344,35 +347,60 @@ static void cmd_connect(int ctl, int dev
 			ioctl(ctl, RFCOMMRELEASEDEV, &req);
 
 			close(sk);
-			return;
+			return -1;
 		}
 	}
 
+	close(sk);
+
 	if (rfcomm_raw_tty) {
-		tcflush(fd, TCIOFLUSH);
+		if (tcflush(fd, TCIOFLUSH) < 0) {
+			perror("Can't flush device data");
+			return -1;
+		}
 
 		cfmakeraw(&ti);
-		tcsetattr(fd, TCSANOW, &ti);
-	}
 
-	close(sk);
+		if (tcsetattr(fd, TCSANOW, &ti) < 0) {
+			perror("Can't set terminal attributes");
+			return -1;
+		}
+	}
 
 	ba2str(&req.dst, dst);
 	printf("Connected %s to %s on channel %d\n", devname, dst, req.channel);
-	printf("Press CTRL-C for hangup\n");
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   = SA_NOCLDSTOP;
 	sa.sa_handler = SIG_IGN;
-	sigaction(SIGCHLD, &sa, NULL);
-	sigaction(SIGPIPE, &sa, NULL);
+	if (sigaction(SIGCHLD, &sa, NULL) < 0) {
+		perror("Can't change SIGCHLD behaivor");
+		return -1;
+	}
+
+	if (sigaction(SIGPIPE, &sa, NULL) < 0) {
+		perror("Can't change SIGPIPE behaivor");
+		return -1;
+	}
 
 	sa.sa_handler = sig_term;
-	sigaction(SIGTERM, &sa, NULL);
-	sigaction(SIGINT,  &sa, NULL);
+	if (sigaction(SIGTERM, &sa, NULL) < 0) {
+		perror("Can't change SIGTERM behaivor");
+		return -1;
+	}
+
+	if (sigaction(SIGINT,  &sa, NULL) < 0) {
+		perror("Can't change SIGINT behaivor");
+		return -1;
+	}
+
+	printf("Press CTRL-C for hangup\n");
 
 	sa.sa_handler = sig_hup;
-	sigaction(SIGHUP, &sa, NULL);
+	if (sigaction(SIGHUP, &sa, NULL) < 0) {
+		perror("Can't change SIGHUP baivor");
+		return -1;
+	}
 
 	p.fd = fd;
 	p.events = POLLERR | POLLHUP;
@@ -386,9 +414,10 @@ static void cmd_connect(int ctl, int dev
 	printf("Disconnected\n");
 
 	close(fd);
+	return 0;
 }
 
-static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	struct sockaddr_rc laddr, raddr;
 	struct rfcomm_dev_req req;
@@ -404,27 +433,36 @@ static void cmd_listen(int ctl, int dev,
 
 	if ((sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
 		perror("Can't create RFCOMM socket");
-		return;
+		return -1;
 	}
 
 	if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
 		perror("Can't bind RFCOMM socket");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	printf("Waiting for connection on channel %d\n", laddr.rc_channel);
 
-	listen(sk, 10);
+	if (listen(sk, 10) < 0) {
+		perror("Can't listen RFCOMM socket");
+		close(sk);
+		return -1;
+	}
 
 	alen = sizeof(raddr);
-	nsk = accept(sk, (struct sockaddr *) &raddr, &alen);
+	if ((nsk = accept(sk, (struct sockaddr *) &raddr, &alen)) < 0) {
+		perror("Can't accept connection in RFCOMM socket");
+		close(sk);
+		return -1;
+	}
 
 	alen = sizeof(laddr);
 	if (getsockname(nsk, (struct sockaddr *)&laddr, &alen) < 0) {
 		perror("Can't get RFCOMM socket name");
+		close(sk);
 		close(nsk);
-		return;
+		return -1;
 	}
 
 	memset(&req, 0, sizeof(req));
@@ -438,7 +476,8 @@ static void cmd_listen(int ctl, int dev,
 	if ((dev = ioctl(nsk, RFCOMMCREATEDEV, &req)) < 0) {
 		perror("Can't create RFCOMM TTY");
 		close(sk);
-		return;
+		close(nsk);
+		return -1;
 	}
 
 	snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
@@ -458,36 +497,61 @@ static void cmd_listen(int ctl, int dev,
 			ioctl(ctl, RFCOMMRELEASEDEV, &req);
 
 			close(sk);
-			return;
+			return -1;
 		}
 	}
 
+	close(sk);
+	close(nsk);
+
 	if (rfcomm_raw_tty) {
-		tcflush(fd, TCIOFLUSH);
+		if (tcflush(fd, TCIOFLUSH) < 0) {
+			perror("Can't flush device data");
+			return -1;
+		}
 
 		cfmakeraw(&ti);
-		tcsetattr(fd, TCSANOW, &ti);
-	}
 
-	close(sk);
-	close(nsk);
+		if (tcsetattr(fd, TCSANOW, &ti) < 0) {
+			perror("Can't set terminal attributes");
+			return -1;
+		}
+	}
 
 	ba2str(&req.dst, dst);
 	printf("Connection from %s to %s\n", dst, devname);
-	printf("Press CTRL-C for hangup\n");
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   = SA_NOCLDSTOP;
 	sa.sa_handler = SIG_IGN;
-	sigaction(SIGCHLD, &sa, NULL);
-	sigaction(SIGPIPE, &sa, NULL);
+	if (sigaction(SIGCHLD, &sa, NULL) < 0) {
+		perror("Can't change SIGCHLD behaivor");
+		return -1;
+	}
+
+	if (sigaction(SIGPIPE, &sa, NULL) < 0) {
+		perror("Can't change SIGPIPE behaivor");
+		return -1;
+	}
 
 	sa.sa_handler = sig_term;
-	sigaction(SIGTERM, &sa, NULL);
-	sigaction(SIGINT,  &sa, NULL);
+	if (sigaction(SIGTERM, &sa, NULL) < 0) {
+		perror("Can't change SIGTERM behaivor");
+		return -1;
+	}
+
+	if (sigaction(SIGINT,  &sa, NULL) < 0) {
+		perror("Can't change SIGINT behaivor");
+		return -1;
+	}
+
+	printf("Press CTRL-C for hangup\n");
 
 	sa.sa_handler = sig_hup;
-	sigaction(SIGHUP, &sa, NULL);
+	if (sigaction(SIGHUP, &sa, NULL) < 0) {
+		perror("Can't change SIGHUP baivor");
+		return -1;
+	}
 
 	p.fd = fd;
 	p.events = POLLERR | POLLHUP;
@@ -501,43 +565,49 @@ static void cmd_listen(int ctl, int dev,
 	printf("Disconnected\n");
 
 	close(fd);
+	return 0;
 }
 
-static void cmd_create(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_create(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	if (strcmp(argv[0], "all") == 0)
-		create_all(ctl);
+		return create_all(ctl);
 	else
-		create_dev(ctl, dev, 0, bdaddr, argc, argv);
+		return create_dev(ctl, dev, 0, bdaddr, argc, argv);
 }
 
-static void cmd_release(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_release(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	if (strcmp(argv[0], "all") == 0)
-		release_all(ctl);
+		return release_all(ctl);
 	else
-		release_dev(ctl, dev, 0);
+		return release_dev(ctl, dev, 0);
 }
 
-static void cmd_show(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_show(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
+	int ret;
+
 	if (strcmp(argv[0], "all") == 0)
-		print_dev_list(ctl, 0);
+		ret = print_dev_list(ctl, 0);
 	else {
 		struct rfcomm_dev_info di = { id: atoi(argv[0]) };
 		if (ioctl(ctl, RFCOMMGETDEVINFO, &di) < 0) {
 			perror("Get info failed");
-			exit(1);
+			return -1;
 		}
 
 		print_dev_info(&di);
+		ret = 0;
 	}
+
+	return ret;
 }
 
 struct {
 	char *cmd;
 	char *alt;
-	void (*func)(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv);
+	int (*func)(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv);
 	char *opt;
 	char *doc;
 } command[] = {
@@ -587,7 +657,7 @@ int main(int argc, char *argv[]) 
 {
 
 	bdaddr_t bdaddr;
-	int i, opt, ctl, dev_id, show_all = 0;
+	int i, err, opt, ctl, dev_id, show_all = 0;
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
@@ -616,7 +686,7 @@ int main(int argc, char *argv[]) 
 			exit(0);
 
 		default:
-			exit(0);
+			exit(1);
 		}
 	}
 
@@ -633,9 +703,9 @@ int main(int argc, char *argv[]) 
 	}
 
 	if (show_all) {
-		print_dev_list(ctl, 0);
+		err = print_dev_list(ctl, 0);
 		close(ctl);
-		exit(0);
+		err ? exit(1) : exit(0);
 	}
 
 	if (strncmp(argv[1], "/dev/rfcomm", 11) == 0)
@@ -650,9 +720,9 @@ int main(int argc, char *argv[]) 
 			continue;
 		argc--;
 		argv++;
-		command[i].func(ctl, dev_id, &bdaddr, argc, argv);
+		err = command[i].func(ctl, dev_id, &bdaddr, argc, argv);
 		close(ctl);
-		exit(0);
+		err ? exit(1) : exit(0);
 	}
 
 	usage();

--------------010106010201060404050306--
