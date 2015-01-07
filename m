Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 1/6] monitor: Make the parameter name generic
Date: Wed, 07 Jan 2015 13:53:15 +0530
Message-id: <1420619000-24211-2-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
References: <1420619000-24211-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changed dcid to cid to make it sound generic as this function is called
with both dcid and scid.
---
 monitor/l2cap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 0b6f752..a09bbbc 100644
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

