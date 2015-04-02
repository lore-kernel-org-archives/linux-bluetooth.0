Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3] btattach: Add SetDevType ioctl call
Date: Thu,  2 Apr 2015 16:38:01 +0200
Message-Id: <1427985483-31580-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com>
References: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btattach.c  | 22 +++++++++++++++++-----
 tools/hciattach.h |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index b7948a3..63620e4 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -106,7 +106,7 @@ static void local_version_callback(const void *data, uint8_t size,
 }
 
 static int attach_proto(const char *path, unsigned int proto,
-						unsigned int flags)
+					unsigned int flags, const char *type)
 {
 	int fd, dev_id;
 
@@ -120,6 +120,14 @@ static int attach_proto(const char *path, unsigned int proto,
 		return -1;
 	}
 
+	if (type) {
+		if (ioctl(fd, HCIUARTSETDEVTYPE, type) < 0) {
+			perror("Failed to set device type");
+			close(fd);
+			return -1;
+		}
+	}
+
 	if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
 		perror("Failed to set protocol");
 		close(fd);
@@ -193,6 +201,7 @@ static void usage(void)
 static const struct option main_options[] = {
 	{ "bredr",   required_argument, NULL, 'B' },
 	{ "amp",     required_argument, NULL, 'A' },
+	{ "type",    required_argument, NULL, 't' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -200,7 +209,7 @@ static const struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
-	const char *bredr_path = NULL, *amp_path = NULL;
+	const char *bredr_path = NULL, *amp_path = NULL, *type = NULL;
 	bool raw_device = false;
 	sigset_t mask;
 	int exit_status, count = 0;
@@ -208,7 +217,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "B:A:Rvh",
+		opt = getopt_long(argc, argv, "B:A:t:Rvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -220,6 +229,9 @@ int main(int argc, char *argv[])
 		case 'A':
 			amp_path = optarg;
 			break;
+		case 't':
+			type = optarg;
+			break;
 		case 'R':
 			raw_device = true;
 			break;
@@ -258,7 +270,7 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(bredr_path, HCI_UART_H4, flags);
+		fd = attach_proto(bredr_path, HCI_UART_H4, flags, type);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
@@ -277,7 +289,7 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(amp_path, HCI_UART_H4, flags);
+		fd = attach_proto(amp_path, HCI_UART_H4, flags, type);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 2aaf075..8a199e9 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -32,6 +32,7 @@
 #define HCIUARTGETDEVICE	_IOR('U', 202, int)
 #define HCIUARTSETFLAGS		_IOW('U', 203, int)
 #define HCIUARTGETFLAGS		_IOR('U', 204, int)
+#define HCIUARTSETDEVTYPE	_IOW('U', 205, int)
 
 #define HCI_UART_H4	0
 #define HCI_UART_BCSP	1
-- 
1.9.1

