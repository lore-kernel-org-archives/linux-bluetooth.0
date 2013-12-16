Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] l2cap-tester: Remove unneeded variable
Date: Mon, 16 Dec 2013 10:57:41 +0200
Message-Id: <1387184262-21439-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387184262-21439-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

err is only used to assign -errno before return.
---
 tools/l2cap-tester.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index e4dade2..4b1e5e2 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -489,15 +489,14 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm)
 {
 	const uint8_t *master_bdaddr;
 	struct sockaddr_l2 addr;
-	int sk, err;
+	int sk;
 
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET | SOCK_NONBLOCK,
 							BTPROTO_L2CAP);
 	if (sk < 0) {
-		err = -errno;
 		tester_warn("Can't create socket: %s (%d)", strerror(errno),
 									errno);
-		return err;
+		return -errno;
 	}
 
 	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
@@ -517,11 +516,10 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm)
 		addr.l2_bdaddr_type = BDADDR_BREDR;
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = -errno;
 		tester_warn("Can't bind socket: %s (%d)", strerror(errno),
 									errno);
 		close(sk);
-		return err;
+		return -errno;
 	}
 
 	return sk;
-- 
1.8.3.2

