Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 03/12] android/health: Add HDP definitions
Date: Fri, 27 Jun 2014 14:24:54 +0300
Message-Id: <1403868303-8129-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403868303-8129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/health.h b/android/health.h
index 0b32fd3..ab7d478 100644
--- a/android/health.h
+++ b/android/health.h
@@ -21,5 +21,13 @@
  *
  */
 
+#define HDP_MDEP_ECHO		0x00
+#define HDP_MDEP_INITIAL	0x01
+#define HDP_MDEP_FINAL		0x7F
+
+#define HDP_NO_PREFERENCE_DC	0x00
+#define HDP_RELIABLE_DC		0x01
+#define HDP_STREAMING_DC	0x02
+
 bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode);
 void bt_health_unregister(void);
-- 
1.8.3.2

