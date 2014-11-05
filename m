Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/tester-gatt: Print handle for write
Date: Wed,  5 Nov 2014 16:11:08 +0200
Message-Id: <1415196669-582-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index f99100d..97473e5 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1180,6 +1180,9 @@ static void gatt_att_pdu_modify(void)
 		memcpy(raw_pdu + 1, &handle, sizeof(handle));
 		memcpy(raw_pdu + 3, value, set_data_len - sizeof(handle));
 
+		tester_debug("gatt: modify pdu write request handle to 0x%02x",
+									handle);
+
 		break;
 	}
 	default:
-- 
1.9.3

