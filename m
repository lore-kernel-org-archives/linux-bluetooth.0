Return-Path: <cyrus@holtmann.org>
Message-ID: <49637037.7060408@unknown.za.net>
Date: Tue, 06 Jan 2009 16:52:39 +0200
From: Jesse Long <jpl@unknown.za.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: rfcomm exit code patch
References: <49626427.1020501@unknown.za.net> <1231209509.13304.10.camel@californication>
In-Reply-To: <1231209509.13304.10.camel@californication>
Content-Type: multipart/mixed;
 boundary="------------030202040004020604020602"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030202040004020604020602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:
> Hi Jesse,
>
>   
>> rfcomm does not always indicate failure in it's exit codes, which is a 
>> problem when automating things.
>>
>> Please consider this patch.
>>     
>
> your patch is full of whitespaces/tabs coding style violations. Please
> fix them first.
>
> Also error return values should be negative.
>
> Regards
>
> Marcel
>   
Hi Marcel,

Thanks for the reply. Apologies. Here is a new patch.

Regards,
Jesse



--------------030202040004020604020602
Content-Type: text/x-patch;
 name="bluez-rfcomm-exitcode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-rfcomm-exitcode.patch"

--- bluez-4.25/rfcomm/main.c	2008-08-05 23:14:56.000000000 +0200
+++ bluez-4.25-exitcode/rfcomm/main.c	2009-01-06 16:40:19.000000000 +0200
@@ -226,10 +226,12 @@
 	req.dev_id = dev;
 
 	err = ioctl(ctl, RFCOMMRELEASEDEV, &req);
-	if (err < 0)
+	if (err < 0){
 		perror("Can't release device");
+		return -1;
+	}
 
-	return err;
+	return 0;
 }
 
 static int release_all(int ctl)
@@ -241,7 +243,7 @@
 	dl = malloc(sizeof(*dl) + RFCOMM_MAX_DEV * sizeof(*di));
 	if (!dl) {
 		perror("Can't allocate memory");
-		exit(1);
+		return -1;
 	}
 
 	dl->dev_num = RFCOMM_MAX_DEV;
@@ -249,7 +251,7 @@
 
 	if (ioctl(ctl, RFCOMMGETDEVLIST, (void *) dl) < 0) {
 		perror("Can't get device list");
-		exit(1);
+		return -1;
 	}
 
 	for (i = 0; i < dl->dev_num; i++)
@@ -310,7 +312,7 @@
 	free(cmdargv);
 }
 
-static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	struct sockaddr_rc laddr, raddr;
 	struct rfcomm_dev_req req;
@@ -329,7 +331,7 @@
 	if (argc < 2) {
 		if (rfcomm_read_config(rfcomm_config_file) < 0) {
 			perror("Can't open RFCOMM config file");
-			return;
+			return -1;
 		}
 
 		raddr.rc_family = AF_BLUETOOTH;
@@ -338,7 +340,7 @@
 
 		if (bacmp(&raddr.rc_bdaddr, BDADDR_ANY) == 0) {
 			fprintf(stderr, "Can't find a config entry for rfcomm%d\n", dev);
-			return;
+			return -1;
 		}
 	} else {
 		raddr.rc_family = AF_BLUETOOTH;
@@ -353,7 +355,7 @@
 	sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
 	if (sk < 0) {
 		perror("Can't create RFCOMM socket");
-		return;
+		return -1;
 	}
 
 	if (linger) {
@@ -361,27 +363,28 @@
 
 		if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
 			perror("Can't set linger option");
-			return;
+			close(sk);
+			return -1;
 		}
 	}
 
 	if (bind(sk, (struct sockaddr *) &laddr, sizeof(laddr)) < 0) {
 		perror("Can't bind RFCOMM socket");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	if (connect(sk, (struct sockaddr *) &raddr, sizeof(raddr)) < 0) {
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
@@ -396,7 +399,7 @@
 	if (dev < 0) {
 		perror("Can't create RFCOMM TTY");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
@@ -463,7 +466,7 @@
 	printf("Disconnected\n");
 
 	close(fd);
-	return;
+	return 0;
 
 release:
 	memset(&req, 0, sizeof(req));
@@ -472,9 +475,10 @@
 	ioctl(ctl, RFCOMMRELEASEDEV, &req);
 
 	close(sk);
+	return -1;
 }
 
-static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	struct sockaddr_rc laddr, raddr;
 	struct rfcomm_dev_req req;
@@ -493,7 +497,7 @@
 	sk = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
 	if (sk < 0) {
 		perror("Can't create RFCOMM socket");
-		return;
+		return -1;
 	}
 
 	lm = 0;
@@ -509,13 +513,13 @@
 	if (lm && setsockopt(sk, SOL_RFCOMM, RFCOMM_LM, &lm, sizeof(lm)) < 0) {
 		perror("Can't set RFCOMM link mode");
 		close(sk);
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
@@ -529,7 +533,7 @@
 	if (getsockname(nsk, (struct sockaddr *)&laddr, &alen) < 0) {
 		perror("Can't get RFCOMM socket name");
 		close(nsk);
-		return;
+		return -1;
 	}
 
 	if (linger) {
@@ -538,7 +542,7 @@
 		if (setsockopt(nsk, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
 			perror("Can't set linger option");
 			close(nsk);
-			return;
+			return -1;
 		}
 	}
 
@@ -554,7 +558,7 @@
 	if (dev < 0) {
 		perror("Can't create RFCOMM TTY");
 		close(sk);
-		return;
+		return -1;
 	}
 
 	snprintf(devname, MAXPATHLEN - 1, "/dev/rfcomm%d", dev);
@@ -629,7 +633,7 @@
 	printf("Disconnected\n");
 
 	close(fd);
-	return;
+	return 0;
 
 release:
 	memset(&req, 0, sizeof(req));
@@ -638,33 +642,37 @@
 	ioctl(ctl, RFCOMMRELEASEDEV, &req);
 
 	close(sk);
+	return -1;
 }
 
-static void cmd_watch(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+static int cmd_watch(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
+	int retv = 0;
+
 	while (!__io_canceled) {
-		cmd_listen(ctl, dev, bdaddr, argc, argv);
+		retv = cmd_listen(ctl, dev, bdaddr, argc, argv);
 		usleep(10000);
 	}
+	return retv;
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
 	if (strcmp(argv[0], "all") == 0)
 		print_dev_list(ctl, 0);
@@ -677,12 +685,13 @@
 
 		print_dev_info(&di);
 	}
+	return 0;
 }
 
 struct {
 	char *cmd;
 	char *alt;
-	void (*func)(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv);
+	int (*func)(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv);
 	char *opt;
 	char *doc;
 } command[] = {
@@ -828,13 +837,14 @@
 		dev_id = atoi(argv[1]);
 
 	for (i = 0; command[i].cmd; i++) {
+		int retv;
 		if (strncmp(command[i].cmd, argv[0], 4) && strncmp(command[i].alt, argv[0], 4))
 			continue;
 		argc--;
 		argv++;
-		command[i].func(ctl, dev_id, &bdaddr, argc, argv);
+		retv = command[i].func(ctl, dev_id, &bdaddr, argc, argv);
 		close(ctl);
-		exit(0);
+		exit(retv ? 1 : 0);
 	}
 
 	usage();

--------------030202040004020604020602--
