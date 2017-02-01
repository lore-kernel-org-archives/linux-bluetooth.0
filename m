Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Carlo Caione <carlo@caione.org>
To: linux-bluetooth@vger.kernel.org, linux@endlessm.com
Cc: Carlo Caione <carlo@endlessm.com>
Subject: [PATCH] tools/btattach: Add detach option
Date: Wed,  1 Feb 2017 18:14:31 +0100
Message-Id: <20170201171431.9633-1-carlo@caione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 tools/btattach.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index 5adbc8d..f1f115d 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -194,6 +194,7 @@ static void usage(void)
 		"\t-P, --protocol <proto> Specify protocol type\n"
 		"\t-S, --speed <baudrate> Specify which baudrate to use\n"
 		"\t-N, --noflowctl        Disable flow control\n"
+		"\t-D, --detach           Open device and then fork\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -203,6 +204,7 @@ static const struct option main_options[] = {
 	{ "protocol", required_argument, NULL, 'P' },
 	{ "speed",    required_argument, NULL, 'S' },
 	{ "noflowctl",no_argument,       NULL, 'N' },
+	{ "detach",   no_argument,       NULL, 'D' },
 	{ "version",  no_argument,       NULL, 'v' },
 	{ "help",     no_argument,       NULL, 'h' },
 	{ }
@@ -230,7 +232,7 @@ static const struct {
 int main(int argc, char *argv[])
 {
 	const char *bredr_path = NULL, *amp_path = NULL, *proto = NULL;
-	bool flowctl = true, raw_device = false;
+	bool flowctl = true, raw_device = false, detach = false;
 	sigset_t mask;
 	int exit_status, count = 0, proto_id = HCI_UART_H4;
 	unsigned int speed = B115200;
@@ -263,6 +265,9 @@ int main(int argc, char *argv[])
 		case 'N':
 			flowctl = false;
 			break;
+		case 'D':
+			detach = true;
+			break;
 		case 'R':
 			raw_device = true;
 			break;
@@ -348,6 +353,9 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	if (detach && fork())
+		return 0;
+
 	exit_status = mainloop_run();
 
 	return exit_status;
-- 
2.9.3

