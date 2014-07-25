Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/5] android/tester-ng: Fix structure members constness
Date: Fri, 25 Jul 2014 12:45:03 +0200
Message-Id: <1406285106-14588-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's better to know what actually may change by looking at the structure
definitions. Some api calls can modify their parameters (returning file
descriptor in socket HAL API) but most of them don't.

This patch mostly applies to action_data and test_case structs that defines
the actual test case.
---
 android/tester-main.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/android/tester-main.h b/android/tester-main.h
index 1bff9b3..e2ecaab 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -216,28 +216,28 @@ struct bt_action_data {
 	bt_bdaddr_t *addr;
 
 	/* Remote props action arguments */
-	int prop_type;
-	bt_property_t *prop;
+	const int prop_type;
+	const bt_property_t *prop;
 
 	/* Bonding requests parameters */
 	bt_pin_code_t *pin;
-	uint8_t pin_len;
-	uint8_t ssp_variant;
-	bool accept;
+	const uint8_t pin_len;
+	const uint8_t ssp_variant;
+	const bool accept;
 
 	/* Socket HAL specific params */
-	btsock_type_t sock_type;
-	int channel;
+	const btsock_type_t sock_type;
+	const int channel;
 	const uint8_t *service_uuid;
 	const char *service_name;
-	int flags;
+	const int flags;
 	int *fd;
 };
 
 /* bthost's l2cap server setup parameters */
 struct emu_set_l2cap_data {
-	uint16_t psm;
-	bthost_l2cap_connect_cb func;
+	const uint16_t psm;
+	const bthost_l2cap_connect_cb func;
 	void *user_data;
 };
 
@@ -271,9 +271,9 @@ struct step {
 };
 
 struct test_case {
-	uint8_t emu_type;
-	char *title;
-	uint16_t step_num;
+	const uint8_t emu_type;
+	const char *title;
+	const uint16_t step_num;
 	const struct step const *step;
 };
 
-- 
1.9.1

