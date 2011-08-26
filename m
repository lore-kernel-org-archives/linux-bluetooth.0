Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/6] gobex: add root support to test-server
Date: Fri, 26 Aug 2011 12:49:36 +0300
Message-Id: <1314352176-12244-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
References: <1314352176-12244-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/test-server.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/tools/test-server.c b/tools/test-server.c
index d7ffe50..728e2ad 100644
--- a/tools/test-server.c
+++ b/tools/test-server.c
@@ -45,6 +45,7 @@ static GSList *clients = NULL;
 static gboolean option_packet = FALSE;
 static gboolean option_bluetooth = FALSE;
 static int option_channel = -1;
+static char *option_root = NULL;
 
 static void sig_term(int sig)
 {
@@ -63,6 +64,8 @@ static GOptionEntry options[] = {
 			&option_packet, "Packet based transport" },
 	{ "stream", 's', G_OPTION_FLAG_REVERSE, G_OPTION_ARG_NONE,
 			&option_packet, "Stream based transport" },
+	{ "root", 'r', 0, G_OPTION_ARG_STRING,
+			&option_root, "Root dir", "/..." },
 	{ NULL },
 };
 
@@ -411,6 +414,11 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
+	if (option_root && chdir(option_root) > 0) {
+		perror("chdir:");
+		exit(EXIT_FAILURE);
+	}
+
 	if (option_bluetooth)
 		server_id = bluetooth_listen();
 	else
-- 
1.7.6

