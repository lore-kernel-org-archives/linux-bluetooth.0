Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 17/17] android/hal-health: trivial: Remove empty line
Date: Mon, 16 Jun 2014 10:57:52 +0300
Message-Id: <1402905472-17643-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-health.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index b8df5a7..af31634 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -143,7 +143,6 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 
 		if (status != BT_STATUS_SUCCESS)
 			return status;
-
 	}
 
 	*app_id = rsp.app_id;
-- 
1.8.3.2

