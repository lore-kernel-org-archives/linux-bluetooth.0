Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] android/tester-pan: Make cid_data static
Date: Thu,  7 Aug 2014 17:13:06 +0300
Message-Id: <1407420787-8293-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407420787-8293-1-git-send-email-luiz.dentz@gmail.com>
References: <1407420787-8293-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-pan.c b/android/tester-pan.c
index da5b771..c293022 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -28,7 +28,7 @@ struct emu_cid_data {
 	uint16_t nap_cid;
 };
 
-struct emu_cid_data cid_data;
+static struct emu_cid_data cid_data;
 static uint8_t pan_conn_req_pdu[] = { 0x01, 0x01, 0x02, 0x11, 0x16,
 								0x11, 0x15 };
 static uint8_t pan_conn_rsp_pdu[] = { 0x01, 0x02, 0x00, 0x00 };
-- 
1.9.3

