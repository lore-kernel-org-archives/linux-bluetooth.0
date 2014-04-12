Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	claudio.takahasi@openbossa.org, anderson.lizardo@openbossa.org,
	armansito@chromium.org,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 02/10] attrib: Expose write execute
Date: Sun, 13 Apr 2014 00:00:23 +0200
Message-Id: <1397340031-29711-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397340031-29711-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is needed to cover Android API
---
 attrib/gatt.c | 6 ++++++
 attrib/gatt.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index e461ab7..f5917db 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -871,6 +871,12 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, const uint8_t *value,
 	return prepare_write(long_write);
 }
 
+guint gatt_execute_write(GAttrib *attrib, uint8_t flags,
+				GAttribResultFunc func, gpointer user_data)
+{
+	return execute_write(attrib, flags, func, user_data);
+}
+
 guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
 					const uint8_t *value, size_t vlen,
 					GAttribResultFunc func,
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 76820e0..3fe6041 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -89,6 +89,8 @@ guint gatt_reliable_write_char(GAttrib *attrib, uint16_t handle,
 					GAttribResultFunc func,
 					gpointer user_data);
 
+guint gatt_execute_write(GAttrib *attrib, uint8_t flags,
+				GAttribResultFunc func, gpointer user_data);
 
 guint gatt_discover_char_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data);
-- 
1.8.4

