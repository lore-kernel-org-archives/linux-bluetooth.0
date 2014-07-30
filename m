Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] anroid/hidhost: Set security to MEDUIM after connect
Date: Wed, 30 Jul 2014 11:38:48 +0200
Message-Id: <1406713130-3825-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
References: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to spec connection with HoG device should always be
encrypted.
---
 android/hidhost.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hidhost.c b/android/hidhost.c
index 4b718c6..da5f818 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -802,6 +802,11 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 		goto fail;
 	}
 
+	if (!bt_gatt_set_security(addr, BT_IO_SEC_MEDIUM)) {
+		error("Failed to set security level");
+		goto fail;
+	}
+
 	DBG("");
 
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_CONNECTED);
-- 
1.9.3

