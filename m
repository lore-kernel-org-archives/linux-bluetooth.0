Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2] lib: Correct length name in write assoc struct
Date: Thu, 19 Jul 2012 12:08:24 +0300
Message-Id: <1342688905-31924-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Correct name from assoc_length to remaining_length.
---
 lib/hci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.h b/lib/hci.h
index b68dbc2..3dbb221 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1408,7 +1408,7 @@ typedef struct {
 typedef struct {
 	uint8_t		handle;
 	uint16_t	length_so_far;
-	uint16_t	assoc_length;
+	uint16_t	remaining_length;
 	uint8_t		fragment[HCI_MAX_NAME_LENGTH];
 } __attribute__ ((packed)) write_remote_amp_assoc_cp;
 #define WRITE_REMOTE_AMP_ASSOC_CP_SIZE 253
-- 
1.7.9.5

