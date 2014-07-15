Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 03/10] android/tester-ng: Set proper callback count
Date: Tue, 15 Jul 2014 10:24:52 +0200
Message-Id: <1405412699-6358-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This was a missing piece after fixing the callback count verifying
routine.
---
 android/tester-bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 202d085..fc04c9d 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -157,6 +157,7 @@ static struct step bluetooth_setprop_bdname_success_steps[] = {
 	{
 		.callback = CB_BT_ADAPTER_PROPERTIES,
 		.callback_result.properties = &setprop_bdname_prop,
+		.callback_result.num_properties = 1,
 	}
 };
 static struct test_case bluetooth_setprop_bdname_success_tc = {
@@ -192,6 +193,7 @@ static struct step bluetooth_setprop_scanmode_success_steps[] = {
 	{
 		.callback = CB_BT_ADAPTER_PROPERTIES,
 		.callback_result.properties = &setprop_scanmode_prop,
+		.callback_result.num_properties = 1,
 	},
 };
 static struct test_case bluetooth_setprop_scanmode_success_tc = {
-- 
1.9.1

