Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 1/4] Filtering interface name from program arguments
Date: Tue, 28 Dec 2010 10:06:16 +0100
Message-ID: <1293527176-12320-1-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <AANLkTi%3dzo%3dpgCCgJ%3dsL9bUftf6Vv7nO7xac92zU6gECC%40mail.gmail.com>
References: <AANLkTi%3dzo%3dpgCCgJ%3dsL9bUftf6Vv7nO7xac92zU6gECC%40mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

tools: Name must be "hciX", where X is 0..HCI_MAX_DEV. Any other like "tty1,
"hci001" or "hci1x" will no longer work as "hci1".
tools: Add info that "bdaddr" can be put for parameter "interface".
---
 attrib/gatttool.c |    9 ++++++---
 compat/pand.c     |    2 +-
 lib/hci.c         |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
 lib/hci_lib.h     |    1 +
 test/hciemu.c     |    9 +++++----
 test/l2test.c     |    8 +++++---
 test/rctest.c     |   10 ++++++----
 tools/ciptool.c   |    9 +++++----
 tools/hciconfig.c |    8 +++++++-
 tools/hcitool.c   |    4 ++--
 tools/l2ping.c    |   11 +++++++----
 tools/main.c      |    7 ++++---
 tools/sdptool.c   |    9 +++++----
 13 files changed, 98 insertions(+), 41 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index a234e36..43b4f57 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -105,10 +105,13 @@ static GIOChannel *do_connect(gboolean le)
 
 	/* Local adapter */
 	if (opt_src != NULL) {
-		if (!strncmp(opt_src, "hci", 3))
-			hci_devba(atoi(opt_src + 3), &sba);
-		else
+		int devid;
+
+		devid = hci_filter_devname(opt_src);
+		if (devid < 0)
 			str2ba(opt_src, &sba);
+		else
+			hci_devba(devid, &sba);
 	} else
 		bacpy(&sba, BDADDR_ANY);
 
diff --git a/compat/pand.c b/compat/pand.c
index c3860fa..7331fad 100644
--- a/compat/pand.c
+++ b/compat/pand.c
@@ -586,7 +586,7 @@ static const char *main_help =
 	"\t--role -r <role>          Local PAN role (PANU, NAP, GN)\n"
 	"\t--service -d <role>       Remote PAN service (PANU, NAP, GN)\n"
 	"\t--ethernet -e <name>      Network interface name\n"
-	"\t--device -i <bdaddr>      Source bdaddr\n"
+	"\t--device -i <hciX|bdaddr> Source interface or bdaddr\n"
 	"\t--nosdp -D                Disable SDP\n"
 	"\t--auth -A                 Enable authentication\n"
 	"\t--encrypt -E              Enable encryption\n"
diff --git a/lib/hci.c b/lib/hci.c
index 048fda4..fb29f87 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -887,22 +887,56 @@ int hci_get_route(bdaddr_t *bdaddr)
 				(long) (bdaddr ? bdaddr : BDADDR_ANY));
 }
 
+/* return 1 if string is decimal number without leading zeros
+ * return 0 if not */
+static int is_devnumber(const char *c)
+{
+	if (c[0] == '0' && c[1] != 0)
+		return 0;
+
+	while (*c) {
+		if (*c < '0' || *c > '9')
+			return 0;
+		++c;
+	}
+	return 1;
+}
+
+/* return HCI dev_id from string like "hciX", where X is dev_id
+ * return -1 if str has invalid format */
+int hci_filter_devname(const char *str)
+{
+	int dev_id;
+
+	if ((strlen(str) >= 4) && (!strncmp(str, "hci", 3)) &&
+		(is_devnumber(str + 3)))
+		dev_id = atoi(str + 3);
+	else
+		dev_id = -1;
+
+	if (dev_id >= HCI_MAX_DEV)
+		dev_id = -1;
+
+	return dev_id;
+}
+
+/* return dev_id, which is on UP state, from 'hciX' or 'bdaddr'
+ * otherwise return -1 */
 int hci_devid(const char *str)
 {
 	bdaddr_t ba;
-	int id = -1;
+	int dev_id;
 
-	if (!strncmp(str, "hci", 3) && strlen(str) >= 4) {
-		id = atoi(str + 3);
-		if (hci_devba(id, &ba) < 0)
-			return -1;
-	} else {
+	dev_id = hci_filter_devname(str);
+	if (dev_id < 0) {
 		errno = ENODEV;
 		str2ba(str, &ba);
-		id = hci_for_each_dev(HCI_UP, __same_bdaddr, (long) &ba);
+		dev_id = hci_for_each_dev(HCI_UP, __same_bdaddr, (long) &ba);
+	} else if (hci_devba(dev_id, &ba) < 0) {
+		return -1;
 	}
 
-	return id;
+	return dev_id;
 }
 
 int hci_devinfo(int dev_id, struct hci_dev_info *di)
@@ -925,6 +959,8 @@ int hci_devinfo(int dev_id, struct hci_dev_info *di)
 	return ret;
 }
 
+/* return status 0 and bdaddr assigned to dev_id
+ * otherwise status -1 */
 int hci_devba(int dev_id, bdaddr_t *bdaddr)
 {
 	struct hci_dev_info di;
diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index b63a2a4..ef00f99 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -60,6 +60,7 @@ int hci_inquiry(int dev_id, int len, int num_rsp, const uint8_t *lap, inquiry_in
 int hci_devinfo(int dev_id, struct hci_dev_info *di);
 int hci_devba(int dev_id, bdaddr_t *bdaddr);
 int hci_devid(const char *str);
+int hci_filter_devname(const char *str);
 
 int hci_read_local_name(int dd, int len, char *name, int to);
 int hci_write_local_name(int dd, const char *name, int to);
diff --git a/test/hciemu.c b/test/hciemu.c
index a20374f..ae33d72 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -1234,15 +1234,16 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	if (strlen(argv[0]) > 3 && !strncasecmp(argv[0], "hci", 3)) {
+	dev = hci_filter_devname(argv[0]);
+	if (dev < 0) {
+		if (getbdaddrbyname(argv[0], &vdev.bdaddr) < 0)
+			exit(1);
+	} else {
 		dev = hci_devid(argv[0]);
 		if (dev < 0) {
 			perror("Invalid device");
 			exit(1);
 		}
-	} else {
-		if (getbdaddrbyname(argv[0], &vdev.bdaddr) < 0)
-			exit(1);
 	}
 
 	if (detach) {
diff --git a/test/l2test.c b/test/l2test.c
index 17883a9..438ba39 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -1101,6 +1101,7 @@ int main(int argc, char *argv[])
 {
 	struct sigaction sa;
 	int opt, sk, mode = RECV, need_addr = 0;
+	int devid;
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
@@ -1175,10 +1176,11 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'i':
-			if (!strncasecmp(optarg, "hci", 3))
-				hci_devba(atoi(optarg + 3), &bdaddr);
-			else
+			devid = hci_filter_devname(optarg);
+			if (devid < 0)
 				str2ba(optarg, &bdaddr);
+			else
+				hci_devba(devid, &bdaddr);
 			break;
 
 		case 'P':
diff --git a/test/rctest.c b/test/rctest.c
index b3804f5..a828ad9 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -579,7 +579,7 @@ static void usage(void)
 		"\t-m multiple connects\n");
 
 	printf("Options:\n"
-		"\t[-b bytes] [-i device] [-P channel] [-U uuid]\n"
+		"\t[-b bytes] [-i hciX|bdaddr] [-P channel] [-U uuid]\n"
 		"\t[-L seconds] enabled SO_LINGER option\n"
 		"\t[-W seconds] enable deferred setup\n"
 		"\t[-B filename] use data packets from file\n"
@@ -597,6 +597,7 @@ int main(int argc, char *argv[])
 {
 	struct sigaction sa;
 	int opt, sk, mode = RECV, need_addr = 0;
+	int devid;
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
@@ -644,10 +645,11 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'i':
-			if (!strncasecmp(optarg, "hci", 3))
-				hci_devba(atoi(optarg + 3), &bdaddr);
-			else
+			devid = hci_filter_devname(optarg);
+			if (devid < 0)
 				str2ba(optarg, &bdaddr);
+			else
+				hci_devba(devid, &bdaddr);
 			break;
 
 		case 'P':
diff --git a/tools/ciptool.c b/tools/ciptool.c
index edce9da..ec602ef 100644
--- a/tools/ciptool.c
+++ b/tools/ciptool.c
@@ -427,7 +427,7 @@ static void usage(void)
 		"\n");
 
 	printf("Options:\n"
-		"\t-i [hciX|bdaddr]   Local HCI device or BD Address\n"
+		"\t-i <hciX|bdaddr>   Local HCI device or BD Address\n"
 		"\t-h, --help         Display help\n"
 		"\n");
 
@@ -455,10 +455,11 @@ int main(int argc, char *argv[])
 	while ((opt = getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
-			if (!strncmp(optarg, "hci", 3))
-				hci_devba(atoi(optarg + 3), &bdaddr);
-			else
+			i = hci_filter_devname(optarg);
+			if (i < 0)
 				str2ba(optarg, &bdaddr);
+			else
+				hci_devba(i, &bdaddr);
 			break;
 		case 'h':
 			usage();
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index f0ae11c..e20963d 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1849,7 +1849,13 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
-	di.dev_id = atoi(argv[0] + 3);
+	i = hci_filter_devname(argv[0]);
+	if (i < 0) {
+		fprintf(stderr, "No valid device name.\n");
+		exit(1);
+	}
+	di.dev_id = i;
+
 	argc--; argv++;
 
 	if (ioctl(ctl, HCIGETDEVINFO, (void *) &di)) {
diff --git a/tools/hcitool.c b/tools/hcitool.c
index d50adaf..dc70e63 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2560,8 +2560,8 @@ static void usage(void)
 	printf("Usage:\n"
 		"\thcitool [options] <command> [command parameters]\n");
 	printf("Options:\n"
-		"\t--help\tDisplay help\n"
-		"\t-i dev\tHCI device\n");
+		"\t--help                 Display help\n"
+		"\t-i <hciX|bdaddr>       Local HCI device or BD Address\n");
 	printf("Commands:\n");
 	for (i = 0; command[i].cmd; i++)
 		printf("\t%-4s\t%s\n", command[i].cmd,
diff --git a/tools/l2ping.c b/tools/l2ping.c
index 29fb3d0..58c5faf 100644
--- a/tools/l2ping.c
+++ b/tools/l2ping.c
@@ -255,7 +255,8 @@ static void usage(void)
 {
 	printf("l2ping - L2CAP ping\n");
 	printf("Usage:\n");
-	printf("\tl2ping [-i device] [-s size] [-c count] [-t timeout] [-d delay] [-f] [-r] [-v] <bdaddr>\n");
+	printf("\tl2ping [-i <hciX|bdaddr>] [-s size] [-c count] [-t timeout] "
+		"[-d delay] [-f] [-r] [-v] <bdaddr>\n");
 	printf("\t-f  Flood ping (delay = 0)\n");
 	printf("\t-r  Reverse ping\n");
 	printf("\t-v  Verify request and response payload\n");
@@ -264,6 +265,7 @@ static void usage(void)
 int main(int argc, char *argv[])
 {
 	int opt;
+	int devid;
 
 	/* Default options */
 	bacpy(&bdaddr, BDADDR_ANY);
@@ -271,10 +273,11 @@ int main(int argc, char *argv[])
 	while ((opt=getopt(argc,argv,"i:d:s:c:t:frv")) != EOF) {
 		switch(opt) {
 		case 'i':
-			if (!strncasecmp(optarg, "hci", 3))
-				hci_devba(atoi(optarg + 3), &bdaddr);
-			else
+			devid = hci_filter_devname(optarg);
+			if (devid < 0)
 				str2ba(optarg, &bdaddr);
+			else
+				hci_devba(devid, &bdaddr);
 			break;
 
 		case 'd':
diff --git a/tools/main.c b/tools/main.c
index 6800445..c000fba 100644
--- a/tools/main.c
+++ b/tools/main.c
@@ -753,10 +753,11 @@ int main(int argc, char *argv[])
 	while ((opt = getopt_long(argc, argv, "+i:f:rahAESML:", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
-			if (strncmp(optarg, "hci", 3) == 0)
-				hci_devba(atoi(optarg + 3), &bdaddr);
-			else
+			dev_id = hci_filter_devname(optarg);
+			if (dev_id < 0)
 				str2ba(optarg, &bdaddr);
+			else
+				hci_devba(dev_id, &bdaddr);
 			break;
 
 		case 'f':
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 140a46a..c782e62 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -4209,7 +4209,7 @@ static void usage(void)
 		"\tsdptool [options] <command> [command parameters]\n");
 	printf("Options:\n"
 		"\t-h\t\tDisplay help\n"
-		"\t-i\t\tSpecify source interface\n");
+		"\t-i\t\tSpecify source interface or bdaddr\n");
 
 	printf("Commands:\n");
 	for (i = 0; command[i].cmd; i++)
@@ -4242,10 +4242,11 @@ int main(int argc, char *argv[])
 	while ((opt=getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
-			if (!strncmp(optarg, "hci", 3))
-				hci_devba(atoi(optarg + 3), &interface);
-			else
+			i = hci_filter_devname(optarg);
+			if (i < 0)
 				str2ba(optarg, &interface);
+			else
+				hci_devba(i, &interface);
 			break;
 
 		case 'h':
-- 
1.7.0.4

