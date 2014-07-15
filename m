Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 02/10] android/tester-ng: Fix for not checking callback count in step
Date: Tue, 15 Jul 2014 10:24:51 +0200
Message-Id: <1405412699-6358-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If no callback count was set in the step, test passed despite valid properties
still waiting to be verified.
---
 android/tester-main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index 8a1f6ed..f5bcb1c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -376,6 +376,14 @@ static int verify_property(bt_property_t *exp_props, int exp_num_props,
 		}
 	}
 
+	if ((i == 0) && exp_props) {
+		tester_warn("No property was verified: %s", exp_num_props ?
+				"unknown error!" :
+				"wrong \'.callback_result.num_properties\'?");
+
+		return 1;
+	}
+
 	return exp_prop_to_find;
 }
 
-- 
1.9.1

