Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/6] MAP: Use input parameters for folder listing
Date: Wed, 14 Mar 2012 23:54:30 +0100
Message-Id: <1331765673-12860-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
References: <1331765673-12860-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mas.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/mas.c b/plugins/mas.c
index 8eefe5f..f6d4799 100644
--- a/plugins/mas.c
+++ b/plugins/mas.c
@@ -478,6 +478,9 @@ static void *folder_listing_open(const char *name, int oflag, mode_t mode,
 				void *driver_data, size_t *size, int *err)
 {
 	struct mas_session *mas = driver_data;
+	/* 1024 is the default when there was no MaxListCount sent */
+	uint16_t max = 1024;
+	uint16_t offset = 0;
 
 	if (oflag != O_RDONLY) {
 		*err = -EBADR;
@@ -486,9 +489,11 @@ static void *folder_listing_open(const char *name, int oflag, mode_t mode,
 
 	DBG("name = %s", name);
 
-	/* 1024 is the default when there was no MaxListCount sent */
-	*err = messages_get_folder_listing(mas->backend_data, name, 1024, 0,
-			get_folder_listing_cb, mas);
+	map_ap_get_u16(mas->inparams, MAP_AP_MAXLISTCOUNT, &max);
+	map_ap_get_u16(mas->inparams, MAP_AP_STARTOFFSET, &offset);
+
+	*err = messages_get_folder_listing(mas->backend_data, name, max,
+					offset, get_folder_listing_cb, mas);
 
 	mas->buffer = g_string_new("");
 
-- 
1.7.5.1

