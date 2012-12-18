Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] hog: Refactor hog init and exit functions
Date: Tue, 18 Dec 2012 11:41:20 -0300
Message-Id: <1355841681-2589-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
References: <1355841681-2589-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch simply renames hog_manager_init and hog_manager_exit
functions to hog_init and hog_exit.
---
 profiles/input/hog_device.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 7efabf2..47f0e43 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -873,7 +873,7 @@ static struct btd_profile hog_profile = {
 	.device_remove	= hog_device_remove,
 };
 
-static int hog_manager_init(void)
+static int hog_init(void)
 {
 	int err;
 
@@ -886,7 +886,7 @@ static int hog_manager_init(void)
 	return btd_profile_register(&hog_profile);
 }
 
-static void hog_manager_exit(void)
+static void hog_exit(void)
 {
 	if (suspend_supported)
 		suspend_exit();
@@ -894,15 +894,5 @@ static void hog_manager_exit(void)
 	btd_profile_unregister(&hog_profile);
 }
 
-static int hog_init(void)
-{
-	return hog_manager_init();
-}
-
-static void hog_exit(void)
-{
-	hog_manager_exit();
-}
-
 BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 							hog_init, hog_exit)
-- 
1.8.0.1

