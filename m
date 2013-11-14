Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 01/16] android/hal-sock: Add debug flag printing
Date: Thu, 14 Nov 2013 17:11:40 +0200
Message-Id: <1384441915-23966-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384441915-23966-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sock.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-sock.c b/android/hal-sock.c
index b7bc88e..eafa451 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -55,8 +55,8 @@ static bt_status_t sock_listen(btsock_type_t type, const char *service_name,
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	DBG("uuid %s chan %d sock %p type %d service_name %s",
-			btuuid2str(uuid), chan, sock, type, service_name);
+	DBG("uuid %s chan %d sock %p type %d service_name %s flags 0x%02x",
+		btuuid2str(uuid), chan, sock, type, service_name, flags);
 
 	switch (type) {
 	case BTSOCK_RFCOMM:
@@ -82,8 +82,8 @@ static bt_status_t sock_connect(const bt_bdaddr_t *bdaddr, btsock_type_t type,
 		return BT_STATUS_PARM_INVALID;
 	}
 
-	DBG("uuid %s chan %d sock %p type %d", btuuid2str(uuid), chan, sock,
-									type);
+	DBG("uuid %s chan %d sock %p type %d flags 0x%02x",
+		btuuid2str(uuid), chan, sock, type, flags);
 
 	if (type != BTSOCK_RFCOMM) {
 		error("Socket type %u not supported", type);
-- 
1.7.10.4

