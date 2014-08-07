Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android/tester: Fix mixing different enum types
Date: Thu,  7 Aug 2014 17:13:07 +0300
Message-Id: <1407420787-8293-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407420787-8293-1-git-send-email-luiz.dentz@gmail.com>
References: <1407420787-8293-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-main.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.h b/android/tester-main.h
index 3f0d46e..54c53f0 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -318,8 +318,8 @@ struct emu_set_l2cap_data {
  * matching with expected step data.
  */
 struct bt_callback_data {
-	bt_state_t state;
-	bt_status_t status;
+	int state;
+	int status;
 	int num_properties;
 	bt_property_t *properties;
 
-- 
1.9.3

