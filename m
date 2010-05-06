Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 4/6] Remove extra spaces in test dir
Date: Fri,  7 May 2010 00:27:10 +0200
Message-Id: <1273184832-8265-4-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
References: <1273184832-8265-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/hciemu.c        |    6 +++---
 test/hstest.c        |    2 +-
 test/rctest.c        |   10 +++++-----
 test/scotest.c       |    2 +-
 test/test-textfile.c |    4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index 457add4..a20374f 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -295,7 +295,7 @@ static void command_complete(uint16_t ogf, uint16_t ocf, int plen, void *data)
 	he = (void *) ptr; ptr += HCI_EVENT_HDR_SIZE;
 
 	he->evt  = EVT_CMD_COMPLETE;
-	he->plen = EVT_CMD_COMPLETE_SIZE + plen; 
+	he->plen = EVT_CMD_COMPLETE_SIZE + plen;
 
 	cc = (void *) ptr; ptr += EVT_CMD_COMPLETE_SIZE;
 
@@ -327,7 +327,7 @@ static void connect_request(struct vhci_conn *conn)
 	he = (void *) ptr; ptr += HCI_EVENT_HDR_SIZE;
 
 	he->evt  = EVT_CONN_REQUEST;
-	he->plen = EVT_CONN_REQUEST_SIZE; 
+	he->plen = EVT_CONN_REQUEST_SIZE;
 
 	cr = (void *) ptr; ptr += EVT_CONN_REQUEST_SIZE;
 
@@ -355,7 +355,7 @@ static void connect_complete(struct vhci_conn *conn)
 	he = (void *) ptr; ptr += HCI_EVENT_HDR_SIZE;
 
 	he->evt  = EVT_CONN_COMPLETE;
-	he->plen = EVT_CONN_COMPLETE_SIZE; 
+	he->plen = EVT_CONN_COMPLETE_SIZE;
 
 	cc = (void *) ptr; ptr += EVT_CONN_COMPLETE_SIZE;
 
diff --git a/test/hstest.c b/test/hstest.c
index f24bc33..08f2257 100644
--- a/test/hstest.c
+++ b/test/hstest.c
@@ -277,7 +277,7 @@ int main(int argc, char *argv[])
 					case PLAY:
 						rlen = read(fd, buf, rlen);
 
-						wlen = 0; 
+						wlen = 0;
 						p = buf;
 						while (rlen > sco_mtu) {
 						        wlen += write(sd, p, sco_mtu);
diff --git a/test/rctest.c b/test/rctest.c
index a938a54..b3804f5 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -436,7 +436,7 @@ static void recv_mode(int sk)
 				if (r < 0)
 					syslog(LOG_ERR, "Read failed: %s (%d)",
 							strerror(errno), errno);
-				return;	
+				return;
 			}
 
 			if (timestamp) {
@@ -459,15 +459,15 @@ static void recv_mode(int sk)
 				seq = sq;
 			}
 			seq++;
-			
+
 			/* Check length */
 			l = btohs(*(uint16_t *) (buf + 4));
 			if (r != l) {
 				syslog(LOG_INFO, "size missmatch: %d -> %d", r, l);
 				continue;
 			}
-			
-			/* Verify data */	
+
+			/* Verify data */
 			for (i = 6; i < r; i++) {
 				if (buf[i] != 0x7f)
 					syslog(LOG_INFO, "data missmatch: byte %d 0x%2.2x", i, buf[i]);
@@ -511,7 +511,7 @@ static void do_send(int sk)
 		*(uint32_t *) buf = htobl(seq);
 		*(uint16_t *) (buf + 4) = htobs(data_size);
 		seq++;
-		
+
 		if (send(sk, buf, data_size, 0) <= 0) {
 			syslog(LOG_ERR, "Send failed: %s (%d)",
 							strerror(errno), errno);
diff --git a/test/scotest.c b/test/scotest.c
index a3d3ed2..50b622a 100644
--- a/test/scotest.c
+++ b/test/scotest.c
@@ -230,7 +230,7 @@ static void recv_mode(int sk)
 				if (r < 0)
 					syslog(LOG_ERR, "Read failed: %s (%d)",
 							strerror(errno), errno);
-				return;	
+				return;
 			}
 			total += r;
 		}
diff --git a/test/test-textfile.c b/test/test-textfile.c
index ab2f513..970e9e7 100644
--- a/test/test-textfile.c
+++ b/test/test-textfile.c
@@ -65,7 +65,7 @@ int main(int argc, char *argv[])
 
 
 	sprintf(key, "00:00:00:00:00:00");
-	if (textfile_del(filename, key) < 0) 
+	if (textfile_del(filename, key) < 0)
 		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
 
 	memset(value, 0, sizeof(value));
@@ -88,7 +88,7 @@ int main(int argc, char *argv[])
 	if (textfile_put(filename, key, value) < 0)
 		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
 
-	if (textfile_del(filename, key) < 0) 
+	if (textfile_del(filename, key) < 0)
 		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
 
 	str = textfile_get(filename, key);
-- 
1.7.0.4

