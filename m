Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 21/22] core: Fix creating 128-bit uuid_t based on GATT service
Date: Mon, 24 Mar 2014 16:25:42 -0300
Message-Id: <1395689143-11091-22-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sdp_uuid128_create() gets the 128-bit UUID on big-endian (human-readable
format) byte order. Service declaration attributes puts the UUIDs in the
attribute value field using little endian order. This patch converts the
128-bit UUID from little-endian to big-endian before creating uuid_t.
---
 src/attrib-server.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 953a3f2..114c8a1 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -318,9 +318,13 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 
 	if (a->len == 2)
 		sdp_uuid16_create(&svc, get_le16(a->data));
-	else if (a->len == 16)
-		sdp_uuid128_create(&svc, a->data);
-	else
+	else if (a->len == 16) {
+		uint8_t be128[16];
+
+		/* Converting from LE to BE */
+		bswap_128(a->data, be128);
+		sdp_uuid128_create(&svc, be128);
+	} else
 		return 0;
 
 	record = server_record_new(&svc, handle, end);
-- 
1.8.3.1

