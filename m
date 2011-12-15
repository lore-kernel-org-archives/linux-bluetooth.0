Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Correct structures for AMP Assoc Read
Date: Thu, 15 Dec 2011 11:48:03 +0200
Message-Id: <1323942483-24779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make struct names similar to kernel and remove static array since
fragment length can be other size than HCI_MAX_NAME_LENGTH, which
is for totally different purpose.
---
 lib/hci.h |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 51184ee..48692fa 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1382,17 +1382,16 @@ typedef struct {
 #define OCF_READ_LOCAL_AMP_ASSOC	0x000A
 typedef struct {
 	uint8_t		handle;
-	uint16_t	length_so_far;
-	uint16_t	assoc_length;
+	uint16_t	len_so_far;
+	uint16_t	max_len;
 } __attribute__ ((packed)) read_local_amp_assoc_cp;
-#define READ_LOCAL_AMP_ASSOC_CP_SIZE 5
+
 typedef struct {
 	uint8_t		status;
 	uint8_t		handle;
-	uint16_t	length;
-	uint8_t		fragment[HCI_MAX_NAME_LENGTH];
+	uint16_t	rem_len;
+	uint8_t		frag[0];
 } __attribute__ ((packed)) read_local_amp_assoc_rp;
-#define READ_LOCAL_AMP_ASSOC_RP_SIZE 252
 
 #define OCF_WRITE_REMOTE_AMP_ASSOC	0x000B
 typedef struct {
-- 
1.7.4.1

