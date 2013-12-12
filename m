Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] android/hal-sock: Fix returning incorrect error code
Date: Thu, 12 Dec 2013 17:17:54 +0200
Message-Id: <1386861474-29524-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386861474-29524-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

For socket type 0 we shall return BT_STATUS_PARM_INVALID.
---
 android/hal-sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index 301c77f..c39ca6a 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -81,7 +81,7 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 {
 	struct hal_cmd_sock_connect cmd;
 
-	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
+	if ((!uuid && chan <= 0) || !bdaddr || !sock || !type) {
 		error("Invalid params: bd_addr %s, uuid %s, chan %d, sock %p",
 			bdaddr2str(bdaddr), btuuid2str(uuid), chan, sock);
 		return BT_STATUS_PARM_INVALID;
-- 
1.8.3.2

