Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 13/18] eir: Use bt_get_* helper functions to access unaligned memory
Date: Tue, 4 Sep 2012 16:41:32 +0200
Message-ID: <1346769697-9930-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/eir.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 9d42917..50912a0 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -55,7 +55,8 @@ static void eir_parse_uuid16(struct eir_data *eir, void *data, uint8_t len)
 
 	service.type = SDP_UUID16;
 	for (i = 0; i < len / 2; i++, uuid16++) {
-		service.value.uuid16 = btohs(bt_get_unaligned(uuid16));
+		service.value.uuid16 = bt_get_le16(uuid16);
+
 		uuid_str = bt_uuid2string(&service);
 		eir->services = g_slist_append(eir->services, uuid_str);
 	}
@@ -70,7 +71,8 @@ static void eir_parse_uuid32(struct eir_data *eir, void *data, uint8_t len)
 
 	service.type = SDP_UUID32;
 	for (i = 0; i < len / 4; i++, uuid32++) {
-		service.value.uuid32 = btohl(bt_get_unaligned(uuid32));
+		service.value.uuid32 = bt_get_le32(uuid32);
+
 		uuid_str = bt_uuid2string(&service);
 		eir->services = g_slist_append(eir->services, uuid_str);
 	}
-- 
1.7.9.5

