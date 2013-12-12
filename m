Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hal-sock: Fix returning unsupported instead of invalid
Date: Thu, 12 Dec 2013 12:58:13 +0200
Message-Id: <1386845893-14304-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For socket type 0 we shall return BT_STATUS_PARM_INVALID,
BT_STATUS_UNSUPPORTED shall be returned for unsupported socket types
like L2CAP.
---
 android/hal-sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index f45be30..301c77f 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -54,7 +54,7 @@ static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
-	if ((!uuid && chan <= 0) || !sock) {
+	if ((!uuid && chan <= 0) || !sock || !type) {
 		error("Invalid params: uuid %s, chan %d, sock %p",
 						btuuid2str(uuid), chan, sock);
 		return BT_STATUS_PARM_INVALID;
-- 
1.8.3.2

