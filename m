Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/tester: Fix Discovery Stop - Success test case
Date: Fri, 21 Feb 2014 12:33:14 +0100
Message-Id: <1392982394-22845-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1392982394-22845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1392982394-22845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes start discovery returned status check what derives double
check of expected status. Returned status should be only checked for cancel
discovery.
---
 android/android-tester.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 618efde..baa0115 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2405,15 +2405,13 @@ static bool pre_inq_compl_hook(const void *dummy, uint16_t len, void *user_data)
 static void test_discovery_stop_success(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	bt_status_t status;
 
 	init_test_conditions(data);
 
 	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT, BT_HCI_CMD_INQUIRY,
 					pre_inq_compl_hook, data);
 
-	status = data->if_bluetooth->start_discovery();
-	check_expected_status(status);
+	data->if_bluetooth->start_discovery();
 }
 
 static void test_discovery_start_done(const void *test_data)
-- 
1.8.5.2

