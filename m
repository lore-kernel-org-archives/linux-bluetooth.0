Return-Path: <cyrus@holtmann.org>
Message-ID: <518906A8.7060708@asianux.com>
Date: Tue, 07 May 2013 21:50:32 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, gustavo@padovan.org,
 johan.hedberg@gmail.com
CC: David Miller <davem@davemloft.net>, dh.herrmann@gmail.com,
 Jiri Kosina <jkosina@suse.cz>,
 andrei.emeltchenko@intel.com, linux-bluetooth@vger.kernel.org,
 netdev <netdev@vger.kernel.org>
Subject: [PATCH] Bluetooth: hidp: using strlcpy or strcpy instead of strncpy
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>


For NUL terminated string, need always let it ended by zero.

Since have already called memcpy() to initialize 'ci', so need not
redundent initializations.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 net/bluetooth/hidp/core.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 940f5ac..9a8ae63 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -76,25 +76,21 @@ static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo
 	ci->flags = session->flags;
 	ci->state = BT_CONNECTED;
 
-	ci->vendor  = 0x0000;
-	ci->product = 0x0000;
-	ci->version = 0x0000;
-
 	if (session->input) {
 		ci->vendor  = session->input->id.vendor;
 		ci->product = session->input->id.product;
 		ci->version = session->input->id.version;
 		if (session->input->name)
-			strncpy(ci->name, session->input->name, 128);
+			strlcpy(ci->name, session->input->name, 128);
 		else
-			strncpy(ci->name, "HID Boot Device", 128);
+			strcpy(ci->name, "HID Boot Device");
 	}
 
 	if (session->hid) {
 		ci->vendor  = session->hid->vendor;
 		ci->product = session->hid->product;
 		ci->version = session->hid->version;
-		strncpy(ci->name, session->hid->name, 128);
+		strlcpy(ci->name, session->hid->name, 128);
 	}
 }
 
-- 
1.7.7.6
