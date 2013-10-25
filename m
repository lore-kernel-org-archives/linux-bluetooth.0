Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/hal: Use defined function to check that interface is ready
Date: Fri, 25 Oct 2013 16:28:45 +0300
Message-Id: <1382707726-20118-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-bluetooth.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 894f5b5..282a680 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -78,10 +78,15 @@ void bt_thread_disassociate(void)
 		bt_hal_cbacks->thread_evt_cb(DISASSOCIATE_JVM);
 }
 
+static bool interface_ready(void)
+{
+	return bt_hal_cbacks != NULL;
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
-	if (!bt_hal_cbacks)
+	if (!interface_ready())
 		return;
 
 	switch (opcode) {
@@ -97,11 +102,6 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	}
 }
 
-static bool interface_ready(void)
-{
-	return bt_hal_cbacks != NULL;
-}
-
 static int init(bt_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
-- 
1.7.10.4

