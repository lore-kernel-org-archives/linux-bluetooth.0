Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Christian Fetzer <christian.fetzer@bmw-carit.de>
Subject: [PATCH 7/8] obexd: Change behavior of parse_filter_read
Date: Fri, 11 Jan 2013 16:55:56 +0100
Message-Id: <1357919757-10334-8-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1357919757-10334-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Calls to ListMessages with filter 'Read' set to true should
request the MSE to send read messages only.

The old code requests the MSE to send unread messages only.
This behavior is not matching the other filters.
---
 obexd/client/map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 3e4cde9..99982c0 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1179,9 +1179,9 @@ static GObexApparam *parse_filter_read(GObexApparam *apparam,
 	dbus_message_iter_get_basic(iter, &dbus_status);
 
 	if (dbus_status)
-		status = FILTER_READ_STATUS_ONLY_UNREAD;
-	else
 		status = FILTER_READ_STATUS_ONLY_READ;
+	else
+		status = FILTER_READ_STATUS_ONLY_UNREAD;
 
 	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERREADSTATUS,
 								status);
-- 
1.8.1

