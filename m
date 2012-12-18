Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] hog: Rename hog_device_new
Date: Tue, 18 Dec 2012 15:49:47 -0300
Message-Id: <1355856590-19222-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
References: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hog_device_new function to hog_new_device.
---
 profiles/input/hog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 186f6b1..c68a089 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -680,7 +680,7 @@ static void attio_disconnected_cb(gpointer user_data)
 	hogdev->attrib = NULL;
 }
 
-static struct hog_device *hog_device_new(struct btd_device *device,
+static struct hog_device *hog_new_device(struct btd_device *device,
 								uint16_t id)
 {
 	struct hog_device *hogdev;
@@ -723,7 +723,7 @@ static struct hog_device *hog_device_register(struct btd_device *device,
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
 	GIOChannel *io;
 
-	hogdev = hog_device_new(device, prim->range.start);
+	hogdev = hog_new_device(device, prim->range.start);
 	if (!hogdev)
 		return NULL;
 
-- 
1.8.0.1

