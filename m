Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/socket: Fix wrong memory access
Date: Wed, 12 Feb 2014 16:13:16 +0200
Message-Id: <1392214396-2576-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes accessing proto[2] in the code.
---
 android/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/socket.c b/android/socket.c
index c62ca61..1551e9b 100644
--- a/android/socket.c
+++ b/android/socket.c
@@ -190,7 +190,7 @@ static sdp_record_t *create_rfcomm_record(uint8_t chan, uuid_t *uuid,
 {
 	sdp_list_t *svclass_id;
 	sdp_list_t *seq, *proto_seq, *pbg_seq;
-	sdp_list_t *proto[2];
+	sdp_list_t *proto[3];
 	uuid_t l2cap_uuid, rfcomm_uuid, obex_uuid, pbg_uuid;
 	sdp_data_t *channel;
 	sdp_record_t *record;
-- 
1.8.3.2

