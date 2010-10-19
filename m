Return-Path: <cyrus@holtmann.org>
From: Balamurugan Mahalingam <mbalamurugan@atheros.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <charubala@charubala.com>, Balamurugan
 Mahalingam <mbalamurugan@atheros.com>
Subject: [PATCH] Fix GUI crash while connecting Interlink Bluetooth Mouse in android platform.
Date: Tue, 19 Oct 2010 15:24:40 +0530
Message-ID: <1287482080-10093-1-git-send-email-mbalamurugan@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Crash is due to some junk characters in the device name.
The device name is copied from a string variable after freeing the memory it points to, so there were some junk characters in it which was the reason for the crash.
Fixing the issue by freeing the memory in string variable after device name is copied.

Signed-off-by: Balamurugan Mahalingam <mbalamurugan@atheros.com>
---
 compat/sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/sdp.c b/compat/sdp.c
index 8898136..ff2e39f 100644
--- a/compat/sdp.c
+++ b/compat/sdp.c
@@ -152,7 +152,6 @@ int get_stored_device_info(const bdaddr_t *src, const bdaddr_t *dst, struct hidp
 			&vendor, &product, &version, &subclass, &country,
 			&parser, desc, &req->flags, &pos);
 
-	free(str);
 
 	req->vendor   = vendor;
 	req->product  = product;
@@ -163,6 +162,7 @@ int get_stored_device_info(const bdaddr_t *src, const bdaddr_t *dst, struct hidp
 
 	snprintf(req->name, 128, "%s", str + pos);
 
+	free(str);
 	req->rd_size = strlen(desc) / 2;
 	req->rd_data = malloc(req->rd_size);
 	if (!req->rd_data) {
-- 
1.6.3.3
