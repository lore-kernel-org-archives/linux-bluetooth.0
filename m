Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 01/19] android/hal-sock: Print bdaddr string instead of pointer
Date: Tue, 19 Nov 2013 15:29:51 +0200
Message-Id: <1384867809-18135-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384867809-18135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index eafa451..bd88ad8 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -77,8 +77,8 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 	struct hal_cmd_sock_connect cmd;
 
 	if ((!uuid && chan <= 0) || !bdaddr || !sock) {
-		error("Invalid params: bd_addr %p, uuid %s, chan %d, sock %p",
-					bdaddr, btuuid2str(uuid), chan, sock);
+		error("Invalid params: bd_addr %s, uuid %s, chan %d, sock %p",
+			bdaddr2str(bdaddr), btuuid2str(uuid), chan, sock);
 		return BT_STATUS_PARM_INVALID;
 	}
 
-- 
1.7.10.4

