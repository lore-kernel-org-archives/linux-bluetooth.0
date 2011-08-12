Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 3/3] MAP/Tracker: Fix condition for skipping folders
Date: Fri, 12 Aug 2011 16:00:43 +0200
Message-Id: <1313157643-5387-3-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1313157643-5387-1-git-send-email-lkslawek@gmail.com>
References: <1313157643-5387-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/messages-tracker.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
index a9e9c6a..22d923d 100644
--- a/plugins/messages-tracker.c
+++ b/plugins/messages-tracker.c
@@ -266,7 +266,7 @@ static gboolean async_get_folder_listing(void *s) {
 				folder_count++, dir = g_slist_next(dir)) {
 		struct message_folder *dir_data = dir->data;
 
-		if (count == FALSE && session->offset < folder_count)
+		if (count == FALSE && session->offset <= folder_count)
 			session->folder_list_cb(session, -EAGAIN, 0,
 					dir_data->name, session->user_data);
 	}
-- 
1.7.4.1

