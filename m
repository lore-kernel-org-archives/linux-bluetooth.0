Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/2] tools/btproxy: Fix buffer overflow with unix
 socket
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <caa787c0-e9f7-a917-fec9-0edb4e8fa1ec@jp.fujitsu.com>
Message-ID: <39747053-107c-6fa1-f791-5c8609fe533e@jp.fujitsu.com>
Date: Wed, 4 Oct 2017 15:25:34 +0900
MIME-Version: 1.0
In-Reply-To: <caa787c0-e9f7-a917-fec9-0edb4e8fa1ec@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btproyx with a unix socket has the similar problem as btmon as below.
So this patch fixes btproxy by the similar way as btmon.

 *** strcpy_chk: buffer overflow detected ***: program terminated
    at 0x4C3085C: ??? (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
    by 0x4C34E46: __strcpy_chk (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
    by 0x401B74: strcpy (string3.h:110)
    by 0x401B74: open_unix (btproxy.c:625)
    by 0x401B74: main (btproxy.c:901)
---
Changes in v2:
 - split v1 patch into this patch for btproxy and another patch for btmon.
 - move the check of pathname length before unlink()
 - fail in open_unix() if pathname length is too long.

 tools/btproxy.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/btproxy.c b/tools/btproxy.c
index f06661d..ae0ff74 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -610,8 +610,15 @@ static void server_callback(int fd, uint32_t events, void *user_data)
 static int open_unix(const char *path)
 {
 	struct sockaddr_un addr;
+	size_t len;
 	int fd;
 
+	len = strlen(path);
+	if (len > sizeof(addr.sun_path) - 1) {
+		fprintf(stderr, "Path too long\n");
+		return -1;
+	}
+
 	unlink(path);
 
 	fd = socket(PF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
@@ -622,7 +629,7 @@ static int open_unix(const char *path)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
-	strcpy(addr.sun_path, path);
+	strncpy(addr.sun_path, path, len);
 
 	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		perror("Failed to bind Unix server socket");
@@ -797,9 +804,16 @@ int main(int argc, char *argv[])
 				server_address = "0.0.0.0";
 			break;
 		case 'u':
-			if (optarg)
+			if (optarg) {
+				struct sockaddr_un addr;
+
 				unix_path = optarg;
-			else
+				if (strlen(unix_path) >
+						sizeof(addr.sun_path) - 1) {
+					fprintf(stderr, "Path too long\n");
+					return EXIT_FAILURE;
+				}
+			} else
 				unix_path = "/tmp/bt-server-bredr";
 			break;
 		case 'p':
-- 
2.7.4


