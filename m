Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/l2test: Fix memory leak
Date: Mon, 03 Aug 2015 17:27:32 +0530
Message-id: <1438603053-4865-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The code to exit from program is changed.
Rather than directly calling exit(), memory allocated to buf is released
to gracefully exit.
---
 tools/l2test.c |   55 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 386823f..973edd3 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1348,7 +1348,7 @@ static void usage(void)
 int main(int argc, char *argv[])
 {
 	struct sigaction sa;
-	int opt, sk, mode = RECV, need_addr = 0;
+	int opt, sk, mode = RECV, need_addr = 0, error = 0;
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
@@ -1476,7 +1476,8 @@ int main(int argc, char *argv[])
 			if (rfcmode == -1) {
 				print_lookup_values(l2cap_modes,
 						"List L2CAP modes:");
-				exit(1);
+				error = -1;
+				goto done;
 			}
 
 			break;
@@ -1487,7 +1488,8 @@ int main(int argc, char *argv[])
 			if (chan_policy == -1) {
 				print_lookup_values(chan_policies,
 						"List L2CAP chan policies:");
-				exit(1);
+				error = -1;
+				goto done;
 			}
 
 			break;
@@ -1554,7 +1556,8 @@ int main(int argc, char *argv[])
 			if (bdaddr_type == -1) {
 				print_lookup_values(bdaddr_types,
 						"List Address types:");
-				exit(1);
+				error = -1;
+				goto done;
 			}
 
 			break;
@@ -1569,7 +1572,8 @@ int main(int argc, char *argv[])
 
 		default:
 			usage();
-			exit(1);
+			error = -1;
+			goto done;
 		}
 	}
 
@@ -1582,7 +1586,8 @@ int main(int argc, char *argv[])
 
 	if (need_addr && !(argc - optind)) {
 		usage();
-		exit(1);
+		error = -1;
+		goto done;
 	}
 
 	if (data_size < 0)
@@ -1592,7 +1597,8 @@ int main(int argc, char *argv[])
 
 	if (!(buf = malloc(buffer_size))) {
 		perror("Can't allocate data buffer");
-		exit(1);
+		error = -1;
+		goto done;
 	}
 
 	memset(&sa, 0, sizeof(sa));
@@ -1609,8 +1615,10 @@ int main(int argc, char *argv[])
 
 		case CRECV:
 			sk = do_connect(argv[optind]);
-			if (sk < 0)
-				exit(1);
+			if (sk < 0) {
+				error = -1;
+				goto done;
+			}
 			recv_mode(sk);
 			break;
 
@@ -1620,8 +1628,10 @@ int main(int argc, char *argv[])
 
 		case SEND:
 			sk = do_connect(argv[optind]);
-			if (sk < 0)
-				exit(1);
+			if (sk < 0) {
+				error = -1;
+				goto done;
+			}
 			send_mode(sk);
 			break;
 
@@ -1643,8 +1653,10 @@ int main(int argc, char *argv[])
 
 		case SENDDUMP:
 			sk = do_connect(argv[optind]);
-			if (sk < 0)
-				exit(1);
+			if (sk < 0) {
+				error = -1;
+				goto done;
+			}
 			senddump_mode(sk);
 			break;
 
@@ -1658,24 +1670,29 @@ int main(int argc, char *argv[])
 
 		case CSENDRECV:
 			sk = do_connect(argv[optind]);
-			if (sk < 0)
-				exit(1);
-
+			if (sk < 0) {
+				error = -1;
+				goto done;
+			}
 			send_and_recv_mode(sk);
 			break;
 
 		case INFOREQ:
 			info_request(argv[optind]);
-			exit(0);
+			goto done;
 
 		case PAIRING:
 			do_pairing(argv[optind]);
-			exit(0);
+			goto done;
 	}
 
+/* gracefully exiting */
+done:
+	free(buf);
 	syslog(LOG_INFO, "Exit");
-
 	closelog();
+	if (error == -1)
+		return 1;
 
 	return 0;
 }
-- 
1.7.9.5

