Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 04/17] lib: Add GATT Primary Service UUID
Date: Wed, 27 Nov 2013 17:50:44 -0300
Message-Id: <1385585457-26951-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1385585457-26951-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/uuid.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 95e5a9a..87e0bd0 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -105,6 +105,9 @@ extern "C" {
 #define OBEX_MNS_UUID		"00001133-0000-1000-8000-00805f9b34fb"
 #define OBEX_MAP_UUID		"00001134-0000-1000-8000-00805f9b34fb"
 
+/* GATT UUIDs section */
+#define GATT_PRIM_SVC_UUID				0x2800
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
1.8.3.1

