Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 2/7] monitor: Make the parameter name generic
Date: Fri, 21 Nov 2014 19:17:40 +0530
Message-id: <1416577665-21876-3-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
References: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changed dcid to cid to make it sound generic as this function is called
with both dcid and scid.
---
 monitor/l2cap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 635b967..48fab8c 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -421,7 +421,7 @@ static struct {
 };
 
 static void print_config_options(const struct l2cap_frame *frame,
-				uint8_t offset, uint16_t dcid, bool response)
+				uint8_t offset, uint16_t cid, bool response)
 {
 	const uint8_t *data = frame->data + offset;
 	uint16_t size = frame->size - offset;
@@ -496,7 +496,7 @@ static void print_config_options(const struct l2cap_frame *frame,
                         break;
 		case 0x04:
 			if (response)
-				assign_mode(frame, data[consumed + 2], dcid);
+				assign_mode(frame, data[consumed + 2], cid);
 
 			switch (data[consumed + 2]) {
 			case 0x00:
-- 
1.9.1

