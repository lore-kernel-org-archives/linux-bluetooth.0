Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/gatt: Fix sign_cnt increment
Date: Mon,  6 Oct 2014 11:13:58 +0300
Message-Id: <1412583238-3307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1412581779-22424-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1412581779-22424-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index dbe067f..718b137 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3169,7 +3169,7 @@ static guint signed_write_cmd(struct gatt_device *dev, uint16_t handle,
 		return 0;
 	}
 
-	bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, sign_cnt++);
+	bt_update_sign_counter(&dev->bdaddr, LOCAL_CSRK, ++sign_cnt);
 
 	return res;
 }
-- 
1.9.1

