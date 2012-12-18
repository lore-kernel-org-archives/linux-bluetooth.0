Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] hog: Rename hog_device_set_control_point
Date: Tue, 18 Dec 2012 15:49:46 -0300
Message-Id: <1355856590-19222-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
References: <1355856590-19222-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch renames hog_device_set_control_point function to
set_control_point.
---
 profiles/input/hog.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 00ec151..186f6b1 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -777,8 +777,7 @@ static int hog_device_unregister(struct hog_device *hogdev)
 	return 0;
 }
 
-static int hog_device_set_control_point(struct hog_device *hogdev,
-							gboolean suspend)
+static int set_control_point(struct hog_device *hogdev, gboolean suspend)
 {
 	uint8_t value = suspend ? 0x00 : 0x01;
 
@@ -802,7 +801,7 @@ static void set_suspend(gpointer data, gpointer user_data)
 	struct hog_device *hogdev = data;
 	gboolean suspend = GPOINTER_TO_INT(user_data);
 
-	hog_device_set_control_point(hogdev, suspend);
+	set_control_point(hogdev, suspend);
 }
 
 static void suspend_callback(void)
-- 
1.8.0.1

