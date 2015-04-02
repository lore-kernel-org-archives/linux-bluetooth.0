Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/3] btattach: Add SetBaudRate ioctl call
Date: Thu,  2 Apr 2015 16:38:02 +0200
Message-Id: <1427985483-31580-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com>
References: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btattach.c  | 22 ++++++++++++++++++----
 tools/hciattach.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index 63620e4..d97429e 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -106,7 +106,8 @@ static void local_version_callback(const void *data, uint8_t size,
 }
 
 static int attach_proto(const char *path, unsigned int proto,
-					unsigned int flags, const char *type)
+					unsigned int flags, const char *type,
+					unsigned int speed)
 {
 	int fd, dev_id;
 
@@ -128,6 +129,14 @@ static int attach_proto(const char *path, unsigned int proto,
 		}
 	}
 
+	if (speed) {
+		if (ioctl(fd, HCIUARTSETBAUDRATE, speed) < 0) {
+			perror("Failed to set speed");
+			close(fd);
+			return -1;
+		}
+	}
+
 	if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
 		perror("Failed to set protocol");
 		close(fd);
@@ -202,6 +211,7 @@ static const struct option main_options[] = {
 	{ "bredr",   required_argument, NULL, 'B' },
 	{ "amp",     required_argument, NULL, 'A' },
 	{ "type",    required_argument, NULL, 't' },
+	{ "speed",   required_argument, NULL, 's' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -210,6 +220,7 @@ static const struct option main_options[] = {
 int main(int argc, char *argv[])
 {
 	const char *bredr_path = NULL, *amp_path = NULL, *type = NULL;
+	unsigned int speed = 0;
 	bool raw_device = false;
 	sigset_t mask;
 	int exit_status, count = 0;
@@ -217,7 +228,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "B:A:t:Rvh",
+		opt = getopt_long(argc, argv, "B:A:t:s:Rvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -229,6 +240,9 @@ int main(int argc, char *argv[])
 		case 'A':
 			amp_path = optarg;
 			break;
+		case 's':
+			speed = atoi(optarg);
+			break;
 		case 't':
 			type = optarg;
 			break;
@@ -270,7 +284,7 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(bredr_path, HCI_UART_H4, flags, type);
+		fd = attach_proto(bredr_path, HCI_UART_H4, flags, type, speed);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
@@ -289,7 +303,7 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(amp_path, HCI_UART_H4, flags, type);
+		fd = attach_proto(amp_path, HCI_UART_H4, flags, type, speed);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 8a199e9..2a084f7 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -33,6 +33,7 @@
 #define HCIUARTSETFLAGS		_IOW('U', 203, int)
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 #define HCIUARTSETDEVTYPE	_IOW('U', 205, int)
+#define HCIUARTSETBAUDRATE	_IOW('U', 206, int)
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
-- 
1.9.1

