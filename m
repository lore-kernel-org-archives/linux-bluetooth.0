Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix using uninitialized variable
Date: Mon, 11 Aug 2014 10:17:02 +0300
Message-Id: <1407741422-30755-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix typo not initializing variable. Silence warnings:

...
/android/tester-hdp.c: 71 in create_app()
/android/tester-hdp.c: 97 in create_app()
...
>>>     Using uninitialized value "mdep2". Field
>>>     "mdep2.mdep_description" is uninitialized.
71              reg->mdep_cfg[1] = mdep2;
...
>>>     Using uninitialized value "mdep2". Field
>>>     "mdep2.mdep_description" is uninitialized.
97              reg->mdep_cfg[1] = mdep2;
...
---
 android/tester-hdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index 9193609..bfe8a99 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -43,8 +43,9 @@ static bthl_reg_param_t *create_app(hdp_app_reg_type type)
 
 	mdep1.data_type = 4100;
 	mdep1.mdep_description = "pulse-oximeter";
+
 	mdep2.data_type = 4100;
-	mdep1.mdep_description = "pulse-oximeter";
+	mdep2.mdep_description = "pulse-oximeter";
 
 	switch (type) {
 	case HDP_APP_SINK_RELIABLE:
-- 
1.9.1

