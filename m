Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix dereference after NULL check
Date: Thu,  4 Oct 2012 13:56:58 +0300
Message-Id: <1349348218-676-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

hdev might be NULL, so we need to avoid possible NULL derefernce in
handler->func functions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b127b88..be3182c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2738,7 +2738,6 @@ static const struct mgmt_handler {
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	void *buf;
-	u8 *cp;
 	struct mgmt_hdr *hdr;
 	u16 opcode, index, len;
 	struct hci_dev *hdev = NULL;
@@ -2802,14 +2801,17 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
-	if (hdev)
+	if (hdev) {
+		u8 *cp;
+
 		mgmt_init_hdev(sk, hdev);
 
-	cp = buf + sizeof(*hdr);
+		cp = buf + sizeof(*hdr);
 
-	err = handler->func(sk, hdev, cp, len);
-	if (err < 0)
-		goto done;
+		err = handler->func(sk, hdev, cp, len);
+		if (err < 0)
+			goto done;
+	}
 
 	err = msglen;
 
-- 
1.7.9.5

