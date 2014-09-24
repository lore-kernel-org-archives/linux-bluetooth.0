Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 02/15] android/tester: Change function names
Date: Wed, 24 Sep 2014 13:37:47 +0200
Message-Id: <1411558680-26856-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Functions which refers to specific actions should have "action"
suffix.
---
 android/tester-gatt.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index f30d0eb..7997d8a 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -470,7 +470,7 @@ static void gatt_client_get_characteristic_action(void)
 	schedule_action_verification(step);
 }
 
-static void gatt_client_get_descriptor(void)
+static void gatt_client_get_descriptor_action(void)
 {
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
@@ -487,7 +487,7 @@ static void gatt_client_get_descriptor(void)
 	schedule_action_verification(step);
 }
 
-static void gatt_client_get_included(void)
+static void gatt_client_get_included_action(void)
 {
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
@@ -946,7 +946,8 @@ static struct test_case test_cases[] = {
 							&get_char_data_1),
 		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_SUCCESS,
 				CONN1_ID, &service_1, &characteristic_1, 4),
-		ACTION_SUCCESS(gatt_client_get_descriptor, &get_desc_data_1),
+		ACTION_SUCCESS(gatt_client_get_descriptor_action,
+							&get_desc_data_1),
 		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_SUCCESS, CONN1_ID,
 				&service_1, &characteristic_1, &desc_1),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
@@ -977,11 +978,13 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_SUCCESS,
 							CONN1_ID, &service_1,
 							&characteristic_1, 4),
-		ACTION_SUCCESS(gatt_client_get_descriptor, &get_desc_data_1),
+		ACTION_SUCCESS(gatt_client_get_descriptor_action,
+							&get_desc_data_1),
 		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_SUCCESS, CONN1_ID,
 						&service_1, &characteristic_1,
 						&desc_1),
-		ACTION_SUCCESS(gatt_client_get_descriptor, &get_desc_data_2),
+		ACTION_SUCCESS(gatt_client_get_descriptor_action,
+							&get_desc_data_2),
 		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_SUCCESS, CONN1_ID,
 						&service_1, &characteristic_1,
 						&desc_2),
@@ -1012,7 +1015,8 @@ static struct test_case test_cases[] = {
 							&get_char_data_1),
 		CALLBACK_GATTC_GET_CHARACTERISTIC_CB(GATT_STATUS_SUCCESS,
 				CONN1_ID, &service_1, &characteristic_1, 4),
-		ACTION_SUCCESS(gatt_client_get_descriptor, &get_desc_data_1),
+		ACTION_SUCCESS(gatt_client_get_descriptor_action,
+							&get_desc_data_1),
 		CALLBACK_GATTC_GET_DESCRIPTOR(GATT_STATUS_FAILURE, CONN1_ID,
 				&service_1, &characteristic_1, NULL),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
@@ -1038,7 +1042,8 @@ static struct test_case test_cases[] = {
 						CONN1_ID, CLIENT1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
-		ACTION_SUCCESS(gatt_client_get_included, &get_incl_data_1),
+		ACTION_SUCCESS(gatt_client_get_included_action,
+							&get_incl_data_1),
 		CALLBACK_GATTC_GET_INCLUDED(GATT_STATUS_SUCCESS, CONN1_ID,
 						&service_1, &included_1),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
@@ -1064,7 +1069,8 @@ static struct test_case test_cases[] = {
 						CONN1_ID, CLIENT1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
-		ACTION_SUCCESS(gatt_client_get_included, &get_incl_data_1),
+		ACTION_SUCCESS(gatt_client_get_included_action,
+							&get_incl_data_1),
 		CALLBACK_GATTC_GET_INCLUDED(GATT_STATUS_SUCCESS, CONN1_ID,
 						&service_1, &included_2),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
@@ -1090,7 +1096,8 @@ static struct test_case test_cases[] = {
 						CONN1_ID, CLIENT1_ID),
 		ACTION_SUCCESS(gatt_client_search_services, &search_services_1),
 		CALLBACK_GATTC_SEARCH_COMPLETE(GATT_STATUS_SUCCESS, CONN1_ID),
-		ACTION_SUCCESS(gatt_client_get_included, &get_incl_data_1),
+		ACTION_SUCCESS(gatt_client_get_included_action,
+							&get_incl_data_1),
 		CALLBACK_GATTC_GET_INCLUDED(GATT_STATUS_FAILURE, CONN1_ID,
 							&service_1, NULL),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
-- 
1.9.3

