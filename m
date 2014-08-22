Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/tester: Make Gatt stop listening after ACL disconnects
Date: Fri, 22 Aug 2014 14:40:49 +0200
Message-Id: <1408711249-6683-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408711249-6683-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are getting busy result if we try to stop the listen while ACL is
still connected.
---
 android/tester-gatt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 1d66309..10939e7 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -458,9 +458,6 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
-		ACTION_SUCCESS(gatt_client_stop_listen_action,
-							&client1_conn_req),
-		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_disconnect_action,
 							&client1_conn_req),
 		CALLBACK_GATTC_DISCONNECT(GATT_STATUS_SUCCESS,
@@ -470,6 +467,9 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(emu_remote_disconnect_hci_action, NULL),
 		CALLBACK_STATE(CB_BT_ACL_STATE_CHANGED,
 						BT_ACL_STATE_DISCONNECTED),
+		ACTION_SUCCESS(gatt_client_stop_listen_action,
+							&client1_conn_req),
+		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
-- 
1.9.1

