Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/8] attrib-server: Remove global le_io variable
Date: Tue, 20 Dec 2011 16:57:58 +0100
Message-Id: <1324396681-27276-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1324396681-27276-5-git-send-email-sancane@gmail.com>
References: <1324396681-27276-1-git-send-email-sancane@gmail.com>
 <1324396681-27276-2-git-send-email-sancane@gmail.com>
 <1324396681-27276-3-git-send-email-sancane@gmail.com>
 <1324396681-27276-4-git-send-email-sancane@gmail.com>
 <1324396681-27276-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get ride of the global low energy channel in order to use the low
energy channel managed in each adapter.
---
 src/attrib-server.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 8681652..5c0f9b4 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -83,8 +83,6 @@ struct group_elem {
 	uint16_t len;
 };
 
-static GIOChannel *le_io = NULL;
-
 /* GAP attribute handles */
 static uint16_t name_handle = 0x0000;
 static uint16_t appearance_handle = 0x0000;
@@ -864,7 +862,7 @@ static uint16_t mtu_exchange(struct gatt_channel *channel, uint16_t mtu,
 	else
 		channel->mtu = MIN(mtu, channel->mtu);
 
-	bt_io_set(le_io, BT_IO_L2CAP, NULL,
+	bt_io_set(channel->gadapter->le_io, BT_IO_L2CAP, NULL,
 			BT_IO_OPT_OMTU, channel->mtu,
 			BT_IO_OPT_INVALID);
 
-- 
1.7.8

