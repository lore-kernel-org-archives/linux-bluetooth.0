Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 2/4] input: Fix memory leak at hogdev struct removal
Date: Fri, 30 Nov 2012 15:31:31 -0300
Message-Id: <1354300294-9105-2-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1354300294-9105-1-git-send-email-paulo.borges@openbossa.org>
References: <1354300294-9105-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/hog_device.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 0a5fb58..a873eac 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -705,6 +705,7 @@ static void hog_device_free(struct hog_device *hogdev)
 {
 	btd_device_unref(hogdev->device);
 	g_slist_free_full(hogdev->reports, report_free);
+	g_attrib_unref(hogdev->attrib);
 	g_free(hogdev->hog_primary);
 	g_free(hogdev);
 }
-- 
1.7.9.5

