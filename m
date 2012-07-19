Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: mgmt: Fix possible NULL dereference
Date: Thu, 19 Jul 2012 12:49:51 +0300
Message-Id: <1342691392-4006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

hdev might be dereferenced in handler->func functions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/mgmt.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2a0f695..48a83c9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2801,14 +2801,15 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
-	if (hdev)
+	if (hdev) {
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

