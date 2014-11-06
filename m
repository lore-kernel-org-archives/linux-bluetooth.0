Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 10/15] android/hardware: Update bt_pan.h header
Date: Thu,  6 Nov 2014 17:05:55 +0200
Message-Id: <1415286360-26268-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_pan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hardware/bt_pan.h b/android/hardware/bt_pan.h
index c8b36b4..83e7949 100644
--- a/android/hardware/bt_pan.h
+++ b/android/hardware/bt_pan.h
@@ -40,8 +40,8 @@ typedef enum {
 */
 typedef void (*btpan_connection_state_callback)(btpan_connection_state_t state, bt_status_t error,
                                                 const bt_bdaddr_t *bd_addr, int local_role, int remote_role);
-typedef void (*btpan_control_state_callback)(btpan_control_state_t state, bt_status_t error,
-                                            int local_role, const char* ifname);
+typedef void (*btpan_control_state_callback)(btpan_control_state_t state, int local_role,
+                                            bt_status_t error, const char* ifname);
 
 typedef struct {
     size_t size;
-- 
1.9.1

