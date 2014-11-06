Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 13/15] android/hardware: Update bt_hh.h header
Date: Thu,  6 Nov 2014 17:05:58 +0200
Message-Id: <1415286360-26268-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_hh.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/hardware/bt_hh.h b/android/hardware/bt_hh.h
index 09f547b..dad9586 100644
--- a/android/hardware/bt_hh.h
+++ b/android/hardware/bt_hh.h
@@ -99,10 +99,10 @@ typedef void (* bthh_virtual_unplug_callback)(bt_bdaddr_t *bd_addr, bthh_status_
  */
 typedef void (* bthh_hid_info_callback)(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid_info);
 
-/** Callback for get/set protocal api.
+/** Callback for get protocol api.
  *  the protocol mode is one of the value from bthh_protocol_mode_t
  */
-typedef void (* bthh_protocol_mode_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status,bthh_protocol_mode_t mode);
+typedef void (* bthh_protocol_mode_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status, bthh_protocol_mode_t mode);
 
 /** Callback for get/set_idle_time api.
  */
@@ -114,6 +114,11 @@ typedef void (* bthh_idle_time_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_
  */
 typedef void (* bthh_get_report_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status, uint8_t* rpt_data, int rpt_size);
 
+/** Callback for set_report/set_protocol api and if error
+ *  occurs for get_report/get_protocol api.
+ */
+typedef void (* bthh_handshake_callback)(bt_bdaddr_t *bd_addr, bthh_status_t hh_status);
+
 
 /** BT-HH callback structure. */
 typedef struct {
@@ -125,6 +130,7 @@ typedef struct {
     bthh_idle_time_callback         idle_time_cb;
     bthh_get_report_callback        get_report_cb;
     bthh_virtual_unplug_callback    virtual_unplug_cb;
+    bthh_handshake_callback         handshake_cb;
 
 } bthh_callbacks_t;
 
-- 
1.9.1

