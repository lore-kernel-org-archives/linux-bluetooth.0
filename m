Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Fix registering HoG service for non-HoG profiles
Date: Mon,  8 Oct 2012 21:04:34 -0300
Message-Id: <1349741074-16665-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need to handle the case that the device has multiple HoG services,
but before registering we must check the service UUID.
---
 profiles/input/hog_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index 362c38a..9dbaff2 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -91,6 +91,9 @@ static int hog_device_probe(struct btd_profile *p, struct btd_device *device,
 		struct gatt_primary *prim = l->data;
 		struct hog_device *hogdev;
 
+		if (strcmp(prim->uuid, HOG_UUID) != 0)
+			continue;
+
 		hogdev = hog_device_register(device, prim);
 		if (hogdev == NULL)
 			continue;
-- 
1.7.12.2

