Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/10] Bluetooth: Fix checkpatch errors, code style issues and typos in hidp
Date: Mon, 21 Mar 2011 14:20:01 +0100
Message-ID: <1300713606-23523-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hidp/core.c |   37 ++++++++++++++++++++-----------------
 net/bluetooth/hidp/hidp.h |    4 ++--
 net/bluetooth/hidp/sock.c |    7 ++++---
 3 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 2429ca2..ba546d4 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -54,22 +54,24 @@ static DECLARE_RWSEM(hidp_session_sem);
 static LIST_HEAD(hidp_session_list);
 
 static unsigned char hidp_keycode[256] = {
-	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
-	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
-	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
-	 27, 43, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
-	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
-	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
-	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
-	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
-	115,114,  0,  0,  0,121,  0, 89, 93,124, 92, 94, 95,  0,  0,  0,
-	122,123, 90, 91, 85,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
-	 29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
-	150,158,159,128,136,177,178,176,142,152,173,140
+	  0,   0,   0,   0,  30,  48,  46,  32,  18,  33,  34,  35,  23,  36,
+	 37,  38,  50,  49,  24,  25,  16,  19,  31,  20,  22,  47,  17,  45,
+	 21,  44,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  28,   1,
+	 14,  15,  57,  12,  13,  26,  27,  43,  43,  39,  40,  41,  51,  52,
+	 53,  58,  59,  60,  61,  62,  63,  64,  65,  66,  67,  68,  87,  88,
+	 99,  70, 119, 110, 102, 104, 111, 107, 109, 106, 105, 108, 103,  69,
+	 98,  55,  74,  78,  96,  79,  80,  81,  75,  76,  77,  71,  72,  73,
+	 82,  83,  86, 127, 116, 117, 183, 184, 185, 186, 187, 188, 189, 190,
+	191, 192, 193, 194, 134, 138, 130, 132, 128, 129, 131, 137, 133, 135,
+	136, 113, 115, 114,   0,   0,   0, 121,   0,  89,  93, 124,  92,  94,
+	 95,   0,   0,   0, 122, 123,  90,  91,  85,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
+	 29,  42,  56, 125,  97,  54, 100, 126, 164, 166, 165, 163, 161, 115,
+	114, 113, 150, 158, 159, 128, 136, 177, 178, 176, 142, 152, 173, 140
 };
 
 static unsigned char hidp_mkeyspat[] = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 };
@@ -569,7 +571,8 @@ static int hidp_session(void *arg)
 	while (!atomic_read(&session->terminate)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (ctrl_sk->sk_state != BT_CONNECTED || intr_sk->sk_state != BT_CONNECTED)
+		if (ctrl_sk->sk_state != BT_CONNECTED ||
+				intr_sk->sk_state != BT_CONNECTED)
 			break;
 
 		while ((skb = skb_dequeue(&ctrl_sk->sk_receive_queue))) {
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index 8d934a1..28bb9ce 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -82,8 +82,8 @@
 #define HIDP_BLUETOOTH_VENDOR_ID	9
 
 struct hidp_connadd_req {
-	int   ctrl_sock;	// Connected control socket
-	int   intr_sock;	// Connteted interrupt socket
+	int   ctrl_sock;	/* Connected control socket */
+	int   intr_sock;	/* Connected interrupt socket */
 	__u16 parser;
 	__u16 rd_size;
 	__u8 __user *rd_data;
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 250dfd4..178ac7f 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -85,7 +85,8 @@ static int hidp_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 			return err;
 		}
 
-		if (csock->sk->sk_state != BT_CONNECTED || isock->sk->sk_state != BT_CONNECTED) {
+		if (csock->sk->sk_state != BT_CONNECTED ||
+				isock->sk->sk_state != BT_CONNECTED) {
 			sockfd_put(csock);
 			sockfd_put(isock);
 			return -EBADFD;
@@ -140,8 +141,8 @@ static int hidp_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 
 #ifdef CONFIG_COMPAT
 struct compat_hidp_connadd_req {
-	int   ctrl_sock;	// Connected control socket
-	int   intr_sock;	// Connteted interrupt socket
+	int   ctrl_sock;	/* Connected control socket */
+	int   intr_sock;	/* Connected interrupt socket */
 	__u16 parser;
 	__u16 rd_size;
 	compat_uptr_t rd_data;
-- 
1.7.0.4

