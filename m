Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH] lib: Fix two size constants
Date: Tue, 11 Jun 2013 14:16:42 -0700
Message-Id: <1370985402-27535-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes the value of RESET_FAILED_CONTACT_COUNTER_RP_SIZE and
RESET_FAILED_CONTACT_COUNTER_RP_SIZE macros to respect the
associated struct.
---

Hi! I was playing with the libbluetooth and found these two constants
wrongly defined. I actually checked with the Core spec that the structs
are fine... but I still have a very very naive question:

Why don't you use sizeof(some_struct) and be happy???

Thanks!
Alex.

 lib/hci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 56c9316..898cf52 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1350,7 +1350,7 @@ typedef struct {
 	uint8_t		status;
 	uint16_t	handle;
 } __attribute__ ((packed)) reset_failed_contact_counter_rp;
-#define RESET_FAILED_CONTACT_COUNTER_RP_SIZE 4
+#define RESET_FAILED_CONTACT_COUNTER_RP_SIZE 3
 
 #define OCF_READ_LINK_QUALITY		0x0003
 typedef struct {
@@ -1764,7 +1764,7 @@ typedef struct {
 	uint16_t	handle;
 	uint8_t		encrypt;
 } __attribute__ ((packed)) evt_encrypt_change;
-#define EVT_ENCRYPT_CHANGE_SIZE 5
+#define EVT_ENCRYPT_CHANGE_SIZE 4
 
 #define EVT_CHANGE_CONN_LINK_KEY_COMPLETE	0x09
 typedef struct {
-- 
1.8.3

