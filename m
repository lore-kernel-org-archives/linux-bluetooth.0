Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Subject: [PATCH] network: Check full BNEP UUID
Date: Fri, 27 Jul 2012 11:06:40 +0200
Message-ID: <1343380000-24935-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an issue where only the 2 bytes containing
the service ID was checked from the BNEP UUID.
Fixes behavior for BT testcases TP/PAN/MISC/UUID/BV-01-C &
TP/PAN/MISC/UUID/BV-02-C.
---
 profiles/network/server.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/profiles/network/server.c b/profiles/network/server.c
index 480c7e2..15ea1cb 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -54,6 +54,11 @@
 #define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer"
 #define SETUP_TIMEOUT		1
 
+static uint128_t bluetooth_base_uuid = {
+	.data = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB}
+};
+
 /* Pending Authorization */
 struct network_session {
 	bdaddr_t	dst;		/* Remote Bluetooth Address */
@@ -313,6 +318,22 @@ static uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req,
 		break;
 	case 4: /* UUID32 */
 	case 16: /* UUID128 */
+		/*
+		 * Check that the bytes in the UUID, except the service ID itself, are
+		 * correct. The service ID is checked in bnep_setup_chk().
+		 */
+		if (memcmp(dest, bluetooth_base_uuid.data, 2))
+			return BNEP_CONN_INVALID_DST;
+		if (memcmp(source, bluetooth_base_uuid.data, 2))
+			return BNEP_CONN_INVALID_SRC;
+
+		if (req->uuid_size == 16) {
+			if (memcmp(&dest[4], &bluetooth_base_uuid.data[4], 12))
+				return BNEP_CONN_INVALID_DST;
+			if (memcmp(&source[4], &bluetooth_base_uuid.data[4], 12))
+				return BNEP_CONN_INVALID_SRC;
+		}
+
 		*dst_role = bt_get_be32(dest);
 		*src_role = bt_get_be32(source);
 		break;
-- 
1.7.11.1

