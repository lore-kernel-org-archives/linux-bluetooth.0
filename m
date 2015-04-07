Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] tools: Add protocol option for btattach utility
Date: Tue,  7 Apr 2015 16:16:52 +0200
Message-Id: <1428416212-2017-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btattach.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index b7948a3..a7d5dbc 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -187,28 +187,43 @@ static void usage(void)
 	printf("options:\n"
 		"\t-B, --bredr <device>   Attach BR/EDR controller\n"
 		"\t-A, --amp <device>     Attach AMP controller\n"
+		"\t-P, --protocol <proto> Specify protocol type\n"
 		"\t-h, --help             Show help options\n");
 }
 
 static const struct option main_options[] = {
-	{ "bredr",   required_argument, NULL, 'B' },
-	{ "amp",     required_argument, NULL, 'A' },
-	{ "version", no_argument,       NULL, 'v' },
-	{ "help",    no_argument,       NULL, 'h' },
+	{ "bredr",    required_argument, NULL, 'B' },
+	{ "amp",      required_argument, NULL, 'A' },
+	{ "protocol", required_argument, NULL, 'P' },
+	{ "version",  no_argument,       NULL, 'v' },
+	{ "help",     no_argument,       NULL, 'h' },
+};
+
+static const struct {
+	unsigned int id;
+	const char *name;
+} proto_table[] = {
+	{HCI_UART_H4,    "h4"},
+	{HCI_UART_BCSP,  "bcsp"},
+	{HCI_UART_3WIRE, "3wire"},
+	{HCI_UART_H4DS,  "h4ds"},
+	{HCI_UART_LL,    "ll"},
+	{HCI_UART_ATH3K, "ath3k"},
+	{HCI_UART_INTEL, "intel"},
 	{ }
 };
 
 int main(int argc, char *argv[])
 {
-	const char *bredr_path = NULL, *amp_path = NULL;
+	const char *bredr_path = NULL, *amp_path = NULL, *proto = NULL;
 	bool raw_device = false;
 	sigset_t mask;
-	int exit_status, count = 0;
+	int exit_status, count = 0, proto_id = HCI_UART_H4;
 
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "B:A:Rvh",
+		opt = getopt_long(argc, argv, "B:A:P:Rvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -220,6 +235,9 @@ int main(int argc, char *argv[])
 		case 'A':
 			amp_path = optarg;
 			break;
+		case 'P':
+			proto = optarg;
+			break;
 		case 'R':
 			raw_device = true;
 			break;
@@ -247,6 +265,22 @@ int main(int argc, char *argv[])
 
 	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
 
+	if (proto) {
+		unsigned int i;
+
+		for (i = 0; proto_table[i].name; i++) {
+			if (!strcmp(proto_table[i].name, proto)) {
+				proto_id = proto_table[i].id;
+				break;
+			}
+		}
+
+		if (!proto_table[i].name) {
+			fprintf(stderr, "Invalid protocol\n");
+			return EXIT_FAILURE;
+		}
+	}
+
 	if (bredr_path) {
 		unsigned long flags;
 		int fd;
@@ -258,7 +292,7 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(bredr_path, HCI_UART_H4, flags);
+		fd = attach_proto(bredr_path, proto_id, flags);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
@@ -277,7 +311,7 @@ int main(int argc, char *argv[])
 		if (raw_device)
 			flags = (1 << HCI_UART_RAW_DEVICE);
 
-		fd = attach_proto(amp_path, HCI_UART_H4, flags);
+		fd = attach_proto(amp_path, proto_id, flags);
 		if (fd >= 0) {
 			mainloop_add_fd(fd, 0, uart_callback, NULL, NULL);
 			count++;
-- 
1.9.1
