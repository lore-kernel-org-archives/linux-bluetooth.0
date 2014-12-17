Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/7] android/tester: Refractor properties veryfying
Date: Wed, 17 Dec 2014 15:01:35 +0100
Message-Id: <1418824897-25342-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418824897-25342-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418824897-25342-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pre condition for properties veryfying is to have set expected
properties in step - there is no need to check it inside veryfying
function. However veryfying function should check if number of expected
or received number of properties is valid. If properties are expected
but number of them is 0, test should fail.
---
 android/tester-main.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 152459d..a8a7bd3 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -501,6 +501,15 @@ static int verify_property(bt_property_t *exp_props, int exp_num_props,
 	int i, j;
 	int exp_prop_to_find = exp_num_props;
 
+	if (rec_num_props == 0)
+		return 1;
+
+	if (exp_num_props == 0) {
+		tester_debug("Wrong number of expected properties given");
+		tester_test_failed();
+		return 1;
+	}
+
 	/* Get first exp prop to match and search for it */
 	for (i = 0; i < exp_num_props; i++) {
 		for (j = 0; j < rec_num_props; j++) {
@@ -511,14 +520,6 @@ static int verify_property(bt_property_t *exp_props, int exp_num_props,
 		}
 	}
 
-	if ((i == 0) && exp_props) {
-		tester_warn("No property was verified: %s", exp_num_props ?
-				"unknown error!" :
-				"wrong \'.callback_result.num_properties\'?");
-
-		return 1;
-	}
-
 	return exp_prop_to_find;
 }
 
-- 
1.9.3

