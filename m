Return-Path: <lcapitulino@conectiva.com.br>
Message-ID: <42B2FFF1.80400@conectiva.com.br>
Date: Fri, 17 Jun 2005 13:53:05 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: Re: [RESEND] - Fixes rfcomm program error codes.
References: <42B1DA59.6040608@conectiva.com.br>	 <1118957041.8980.101.camel@pegasus>  <42B1E63F.204@conectiva.com.br> <1118959732.8980.107.camel@pegasus>
In-Reply-To: <1118959732.8980.107.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------050003070305050409070600"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050003070305050409070600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel,

Marcel Holtmann wrote:

> lets keep it using "exit(1)". It is an historic issue. Send a patch for
> the few cases we did it wrong.

Okay, it's attached. Note that:

1) Some functions returns -1 on error, I didn't change it
2) Create all devices and release all devices returns success if all devices
could be created (or released), otherwise it returns error (IOW, if we get
an error to create or release at least one device, the program returns error)
3) I've added some missing checks
4) If you enter with an unknown parameter it does 'exit(1)' instead of
'exit(0)', because it's an error.

rfcomm/main.c |  135 ++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 95 insertions(+), 40 deletions(-)

PS: The parameters for raw terminal mode (-r) and configfile (-f)
are not documented, I think a patch for it doesn't pay off. :)

-- 
Luiz Fernando N. Capitulino

--------------050003070305050409070600
Content-Type: text/x-patch;
 name="rfcomm_return_codes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rfcomm_return_codes.patch"

 rfcomm/main.c |  135 ++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 95 insertions(+), 40 deletions(-)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/rfcomm/main.c a~/rfcomm/main.c
--- a/rfcomm/main.c	2004-11-25 10:05:16.000000000 -0200
+++ a~/rfcomm/main.c	2005-06-16 21:08:58.000000000 -0300
@@ -165,7 +165,7 @@ static int create_dev(int ctl, int dev, 
 
 		if (bacmp(&req.dst, BDADDR_ANY) == 0) {
 			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
-			return -EFAULT;
+			return -1;
 		}
 		
 	} else {
@@ -193,6 +193,8 @@ static int create_all(int ctl)
 		return err;
 	}
 
+	err = -1;
+
 	for (i = 0; i < RFCOMM_MAX_DEV; i++) {
 		if (!rfcomm_opts[i].bind)
 			continue;
@@ -204,11 +206,15 @@ static int create_all(int ctl)
 		bacpy(&req.dst, &rfcomm_opts[i].bdaddr);
 		req.channel = rfcomm_opts[i].channel;
 
-		if (bacmp(&req.dst, BDADDR_ANY) != 0)
-			ioctl(ctl, RFCOMMCREATEDEV, &req);
+		if (bacmp(&req.dst, BDADDR_ANY) != 0) {
+			if (ioctl(ctl, RFCOMMCREATEDEV, &req) < 0)
+				fprintf(stderr, "Warning: failed to create RFCOMM device: rfcomm%d\n", i);
+			else
+				err = 0;
+		}
 	}
 
-	return 0;
+	return err;
 }
 
 static int release_dev(int ctl, int dev, uint32_t flags)
@@ -229,7 +235,7 @@ static int release_all(int ctl)
 {
 	struct rfcomm_dev_list_req *dl;
 	struct rfcomm_dev_info *di;
-	int i;
+	int i, err = 0;
 
 	dl = malloc(sizeof(*dl) + RFCOMM_MAX_DEV * sizeof(*di));
 	if (!dl) {
@@ -246,9 +252,10 @@ static int release_all(int ctl)
 	}
 
 	for (i = 0; i < dl->dev_num; i++)
-		release_dev(ctl, (di + i)->id, 0);
+		if (release_dev(ctl, (di + i)->id, 0) < 0)
+			err = -1;
 
-	return 0;
+	return err;
 }
 
 static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
@@ -268,7 +275,7 @@ static void cmd_connect(int ctl, int dev
 	if (argc < 2) {
 		if (rfcomm_read_config(rfcomm_config_file) < 0) {
 			perror("Can't open RFCOMM config file");
-			return;
+			exit(1);
 		}
 
 		raddr.rc_family = AF_BLUETOOTH;
@@ -277,7 +284,7 @@ static void cmd_connect(int ctl, int dev
 
 		if (bacmp(&raddr.rc_bdaddr, BDADDR_ANY) == 0) {
 			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
-			return;
+			exit(1);
 		}
 	} else {
 		raddr.rc_family = AF_BLUETOOTH;
@@ -291,26 +298,26 @@ static void cmd_connect(int ctl, int dev
 
 	if ((sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
 		perror("Can't create RFCOMM socket");
-		return;
+		exit(1);
 	}
 
 	if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
 		perror("Can't bind RFCOMM socket");
 		close(sk);
-		return;
+		exit(1);
 	}
 
 	if (connect(sk, (struct sockaddr *)&raddr, sizeof(raddr)) < 0) {
 		perror("Can't connect RFCOMM socket");
 		close(sk);
-		return;
+		exit(1);
 	}
 
 	alen = sizeof(laddr);
 	if (getsockname(sk, (struct sockaddr *)&laddr, &alen) < 0) {
 		perror("Can't get RFCOMM socket name");
 		close(sk);
-		return;
+		exit(1);
 	}
 
 	memset(&req, 0, sizeof(req));
@@ -324,7 +331,7 @@ static void cmd_connect(int ctl, int dev
 	if ((dev = ioctl(sk, RFCOMMCREATEDEV, &req)) < 0) {
 		perror("Can't create RFCOMM TTY");
 		close(sk);
-		return;
+		exit(1);
 	}
 
 	snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
@@ -344,7 +351,7 @@ static void cmd_connect(int ctl, int dev
 			ioctl(ctl, RFCOMMRELEASEDEV, &req);
 
 			close(sk);
-			return;
+			exit(1);
 		}
 	}
 
@@ -352,7 +359,10 @@ static void cmd_connect(int ctl, int dev
 		tcflush(fd, TCIOFLUSH);
 
 		cfmakeraw(&ti);
-		tcsetattr(fd, TCSANOW, &ti);
+		if (tcsetattr(fd, TCSANOW, &ti) < 0) {
+			perror("Can't set attributes");
+			exit(1);
+		}
 	}
 
 	close(sk);
@@ -364,15 +374,30 @@ static void cmd_connect(int ctl, int dev
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   = SA_NOCLDSTOP;
 	sa.sa_handler = SIG_IGN;
-	sigaction(SIGCHLD, &sa, NULL);
-	sigaction(SIGPIPE, &sa, NULL);
+	if (sigaction(SIGCHLD, &sa, NULL) < 0) {
+		perror("Can't change SIGCHLD disposition");
+		exit(1);
+	}
+	if (sigaction(SIGPIPE, &sa, NULL) < 0) {
+		perror("Can't change SIGPIPE disposition");
+		exit(1);
+	}
 
 	sa.sa_handler = sig_term;
-	sigaction(SIGTERM, &sa, NULL);
-	sigaction(SIGINT,  &sa, NULL);
+	if (sigaction(SIGTERM, &sa, NULL) < 0) {
+		perror("Can't change SIGTERM disposition");
+		exit(1);
+	}
+	if (sigaction(SIGINT,  &sa, NULL) < 0) {
+		perror("Can't change SIGINT disposition");
+		exit(1);
+	}
 
 	sa.sa_handler = sig_hup;
-	sigaction(SIGHUP, &sa, NULL);
+	if (sigaction(SIGHUP, &sa, NULL) < 0) {
+		perror("Can't change SIGHUP disposition");
+		exit(1);
+	}
 
 	p.fd = fd;
 	p.events = POLLERR | POLLHUP;
@@ -404,27 +429,33 @@ static void cmd_listen(int ctl, int dev,
 
 	if ((sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
 		perror("Can't create RFCOMM socket");
-		return;
+		exit(1);
 	}
 
 	if (bind(sk, (struct sockaddr *)&laddr, sizeof(laddr)) < 0) {
 		perror("Can't bind RFCOMM socket");
 		close(sk);
-		return;
+		exit(1);
 	}
 
 	printf("Waiting for connection on channel %d\n", laddr.rc_channel);
 
-	listen(sk, 10);
+	if (listen(sk, 10) < 0) {
+		perror("Can't set socket queue limit");
+		exit(1);
+	}
 
 	alen = sizeof(raddr);
-	nsk = accept(sk, (struct sockaddr *) &raddr, &alen);
+	if ((nsk = accept(sk, (struct sockaddr *) &raddr, &alen)) < 0) {
+		perror("Can't accept connection");
+		exit(1);
+	}
 
 	alen = sizeof(laddr);
 	if (getsockname(nsk, (struct sockaddr *)&laddr, &alen) < 0) {
 		perror("Can't get RFCOMM socket name");
 		close(nsk);
-		return;
+		exit(1);
 	}
 
 	memset(&req, 0, sizeof(req));
@@ -438,7 +469,7 @@ static void cmd_listen(int ctl, int dev,
 	if ((dev = ioctl(nsk, RFCOMMCREATEDEV, &req)) < 0) {
 		perror("Can't create RFCOMM TTY");
 		close(sk);
-		return;
+		exit(1);
 	}
 
 	snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
@@ -458,7 +489,7 @@ static void cmd_listen(int ctl, int dev,
 			ioctl(ctl, RFCOMMRELEASEDEV, &req);
 
 			close(sk);
-			return;
+			exit(1);
 		}
 	}
 
@@ -466,7 +497,10 @@ static void cmd_listen(int ctl, int dev,
 		tcflush(fd, TCIOFLUSH);
 
 		cfmakeraw(&ti);
-		tcsetattr(fd, TCSANOW, &ti);
+		if (tcsetattr(fd, TCSANOW, &ti) < 0) {
+			perror("Can't set attributes");
+			exit(1);
+		}
 	}
 
 	close(sk);
@@ -479,15 +513,32 @@ static void cmd_listen(int ctl, int dev,
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   = SA_NOCLDSTOP;
 	sa.sa_handler = SIG_IGN;
-	sigaction(SIGCHLD, &sa, NULL);
-	sigaction(SIGPIPE, &sa, NULL);
+	if (sigaction(SIGCHLD, &sa, NULL) < 0) {
+		perror("Can't change SIGCHLD disposition");
+		exit(1);
+	}
+
+	if (sigaction(SIGPIPE, &sa, NULL) < 0) {
+		perror("Can't change SIGPIPE disposition");
+		exit(1);
+	}
 
 	sa.sa_handler = sig_term;
-	sigaction(SIGTERM, &sa, NULL);
-	sigaction(SIGINT,  &sa, NULL);
+	if (sigaction(SIGTERM, &sa, NULL) < 0) {
+		perror("Can't change SIGTERM disposition");
+		exit(1);
+	}
+
+	if (sigaction(SIGINT,  &sa, NULL) < 0) {
+		perror("Can't change SIGINT disposition");
+		exit(1);
+	}
 
 	sa.sa_handler = sig_hup;
-	sigaction(SIGHUP, &sa, NULL);
+	if (sigaction(SIGHUP, &sa, NULL) < 0) {
+		perror("Can't change SIGHUP disposition");
+		exit(1);
+	}
 
 	p.fd = fd;
 	p.events = POLLERR | POLLHUP;
@@ -505,10 +556,13 @@ static void cmd_listen(int ctl, int dev,
 
 static void cmd_create(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
-	if (strcmp(argv[0], "all") == 0)
-		create_all(ctl);
-	else
-		create_dev(ctl, dev, 0, bdaddr, argc, argv);
+	if (strcmp(argv[0], "all") == 0) {
+		if (create_all(ctl) < 0)
+			exit(1);
+	} else {
+		if (create_dev(ctl, dev, 0, bdaddr, argc, argv) < 0)
+			exit(1);
+	}
 }
 
 static void cmd_release(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
@@ -516,7 +570,8 @@ static void cmd_release(int ctl, int dev
 	if (strcmp(argv[0], "all") == 0)
 		release_all(ctl);
 	else
-		release_dev(ctl, dev, 0);
+		if (release_dev(ctl, dev, 0) < 0)
+			exit(1);
 }
 
 static void cmd_show(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
@@ -616,7 +671,7 @@ int main(int argc, char *argv[]) 
 			exit(0);
 
 		default:
-			exit(0);
+			exit(1);
 		}
 	}
 

--------------050003070305050409070600--
