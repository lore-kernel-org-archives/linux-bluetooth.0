Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v3 03/27] input: Simplify code since UUID is known
Date: Fri, 26 Apr 2013 08:16:59 +0200
Message-Id: <1366957043-2383-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1366957043-2383-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The UUID in this code path is fixed so trivially use it instead of
using the provided probe parameter.
---
 profiles/input/manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index d30ba67..8bbf768 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -59,7 +59,7 @@ static int hid_device_probe(struct btd_profile *p, struct btd_device *device,
 								GSList *uuids)
 {
 	const char *path = device_get_path(device);
-	const sdp_record_t *rec = btd_device_get_record(device, uuids->data);
+	const sdp_record_t *rec = btd_device_get_record(device, HID_UUID);
 
 	DBG("path %s", path);
 
-- 
1.8.1.4

