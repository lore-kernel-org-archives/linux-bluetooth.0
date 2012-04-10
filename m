Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd v2 2/3] MAP: Input parameters for GetMessagesListing
Date: Tue, 10 Apr 2012 16:47:40 +0200
Message-Id: <1334069261-3668-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1334069261-3668-1-git-send-email-lkslawek@gmail.com>
References: <1334069261-3668-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for input application parameters header given in
GetMessagesListing request.
---
 plugins/mas.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 97a37e4..76dc8e9 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -531,6 +531,9 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 {
 	struct mas_session *mas = driver_data;
 	struct messages_filter filter = { 0, };
+	/* 1024 is the default when there was no MaxListCount sent */
+	uint16_t max = 1024;
+	uint16_t offset = 0;
 
 	DBG("");
 
@@ -539,8 +542,28 @@ static void *msg_listing_open(const char *name, int oflag, mode_t mode,
 		return NULL;
 	}
 
-	*err = messages_get_messages_listing(mas->backend_data, name, 0xffff, 0,
-			&filter,
+	map_ap_get_u16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	map_ap_get_u16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
+
+	map_ap_get_u32(mas->inparams, MAP_AP_PARAMETERMASK,
+						&filter.parameter_mask);
+	map_ap_get_u8(mas->inparams, MAP_AP_FILTERMESSAGETYPE,
+						&filter.type);
+	filter.period_begin = map_ap_get_string(mas->inparams,
+						MAP_AP_FILTERPERIODBEGIN);
+	filter.period_end = map_ap_get_string(mas->inparams,
+						MAP_AP_FILTERPERIODEND);
+	map_ap_get_u8(mas->inparams, MAP_AP_FILTERREADSTATUS,
+						&filter.read_status);
+	filter.recipient = map_ap_get_string(mas->inparams,
+						MAP_AP_FILTERRECIPIENT);
+	filter.originator = map_ap_get_string(mas->inparams,
+						MAP_AP_FILTERORIGINATOR);
+	map_ap_get_u8(mas->inparams, MAP_AP_FILTERPRIORITY,
+						&filter.priority);
+
+	*err = messages_get_messages_listing(mas->backend_data, name, max,
+			offset, &filter,
 			get_messages_listing_cb, mas);
 
 	mas->buffer = g_string_new("");
-- 
1.7.5.1

