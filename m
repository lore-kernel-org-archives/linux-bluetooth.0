Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/5] android/tester: Indentation fix
Date: Wed,  3 Sep 2014 10:56:40 +0200
Message-Id: <1409734601-8078-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index c0f384c..fb8e11b 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1884,8 +1884,7 @@ void bt_set_property_action(void)
 
 	prop = (bt_property_t *)current_data_step->set_data;
 
-	step->action_status = data->if_bluetooth->set_adapter_property(
-									prop);
+	step->action_status = data->if_bluetooth->set_adapter_property(prop);
 
 	schedule_action_verification(step);
 }
-- 
1.9.1

