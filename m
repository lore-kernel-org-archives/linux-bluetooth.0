Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] audio/control: Remove unused control_is_active function
Date: Wed, 25 Mar 2015 09:52:46 +0100
Message-Id: <1427273567-8711-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/control.c | 10 ----------
 profiles/audio/control.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 4db5b92..f4656d8 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -338,13 +338,3 @@ int control_init_remote(struct btd_service *service)
 
 	return 0;
 }
-
-gboolean control_is_active(struct btd_service *service)
-{
-	struct control *control = btd_service_get_user_data(service);
-
-	if (control && control->session)
-		return TRUE;
-
-	return FALSE;
-}
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index da8f16c..4bda896 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -29,7 +29,6 @@ struct btd_service;
 int control_init_target(struct btd_service *service);
 int control_init_remote(struct btd_service *service);
 void control_unregister(struct btd_service *service);
-gboolean control_is_active(struct btd_service *service);
 
 int control_connect(struct btd_service *service);
 int control_disconnect(struct btd_service *service);
-- 
1.9.3

