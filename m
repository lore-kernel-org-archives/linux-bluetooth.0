Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/hal-sock: Check socket type in connect
Date: Wed,  6 Nov 2013 16:03:31 +0200
Message-Id: <1383746614-15077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Only RFCOMM sockets are supported in Android.
---
 android/hal-sock.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index 131877a..cd85f1f 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -83,6 +83,11 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 
 	DBG("uuid %p chan %d sock %p type %d", uuid, chan, sock, type);
 
+	if (type != BTSOCK_RFCOMM) {
+		error("Socket type %u not supported", type);
+		return BT_STATUS_UNSUPPORTED;
+	}
+
 	cmd.flags = flags;
 	cmd.type = type;
 	cmd.channel = chan;
-- 
1.7.10.4

