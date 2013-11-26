Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android: Do not dereference possible NULL pointer
Date: Tue, 26 Nov 2013 16:05:50 +0200
Message-Id: <1385474750-18331-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385474750-18331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

eir might be NULL, do not derefernce it in debug and print instead
pointer.
---
 android/bluetooth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index aa684bd..77ce519 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -916,8 +916,8 @@ static void mgmt_device_found_event(uint16_t index, uint16_t length,
 	flags = btohl(ev->flags);
 
 	ba2str(&ev->addr.bdaddr, addr);
-	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u eir %u",
-				index, addr, ev->rssi, flags, eir_len, *eir);
+	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u eir %p",
+				index, addr, ev->rssi, flags, eir_len, eir);
 
 	confirm_name = flags & MGMT_DEV_FOUND_CONFIRM_NAME;
 
-- 
1.8.3.2

