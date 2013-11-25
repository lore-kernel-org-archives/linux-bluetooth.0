Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv9 13/21] android/hal-sock: Print bdaddr on connect
Date: Mon, 25 Nov 2013 15:08:49 +0200
Message-Id: <1385384937-29858-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385384937-29858-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index bd88ad8..e02a49a 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -82,8 +82,8 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	DBG("uuid %s chan %d sock %p type %d flags 0x%02x",
-		btuuid2str(uuid), chan, sock, type, flags);
+	DBG("bdaddr %s uuid %s chan %d sock %p type %d flags 0x%02x",
+		bdaddr2str(bdaddr), btuuid2str(uuid), chan, sock, type, flags);
 
 	if (type != BTSOCK_RFCOMM) {
 		error("Socket type %u not supported", type);
-- 
1.8.3.2

