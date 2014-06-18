Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 06/11] android/gatt: Fix warning by rearranging allocation
Date: Wed, 18 Jun 2014 16:33:49 +0300
Message-Id: <1403098434-28193-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

We need to allocate array of uint8_t so fix allocation parameter, this
also removes unneeded type conversion.

This fixes clang warnings:
...
android/gatt.c:5967:29: warning: Result of 'calloc' is converted to a
pointer of type 'uint8_t', which is incompatible with sizeof operand
type 'uint16_t'
        entry->value = (uint8_t *) new0(uint16_t, 1);
                        ~~~~~~~~~  ^~~~~~~~~~~~~~~~~
./src/shared/util.h:81:26: note: expanded from macro 'new0'
                         ^~~~~~      ~~~~~~~~~
...
---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 626a65d..2bef5ab 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5969,7 +5969,7 @@ static void gatt_srvc_change_read_cb(uint16_t handle, uint16_t offset,
 	ccc = bt_get_gatt_ccc(&dev->bdaddr);
 	entry->state = REQUEST_DONE;
 
-	entry->value = (uint8_t *) new0(uint16_t, 1);
+	entry->value = new0(uint8_t, 2);
 	if (!entry->value) {
 		entry->error = ATT_ECODE_INSUFF_RESOURCES;
 
-- 
1.8.3.2

