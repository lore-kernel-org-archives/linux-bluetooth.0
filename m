Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 3/4] android: Update bond state on auth and connect failed
Date: Fri, 15 Nov 2013 19:04:00 +0100
Message-ID: <1384538641-1873-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1384538641-1873-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 57 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 853f5a8..37ac7b1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -987,16 +987,51 @@ static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
 			HAL_EV_ACL_STATE_CHANGED, sizeof(hal_ev), &hal_ev, -1);
 }
 
+static uint8_t status_mgmt2hal(uint8_t mgmt)
+{
+	switch (mgmt) {
+	case MGMT_STATUS_SUCCESS:
+		return HAL_STATUS_SUCCESS;
+	case MGMT_STATUS_NO_RESOURCES:
+		return HAL_STATUS_NOMEM;
+	case MGMT_STATUS_BUSY:
+		return HAL_STATUS_BUSY;
+	case MGMT_STATUS_NOT_SUPPORTED:
+		return HAL_STATUS_UNSUPPORTED;
+	case MGMT_STATUS_INVALID_PARAMS:
+		return HAL_STATUS_INVALID;
+	case MGMT_STATUS_AUTH_FAILED:
+		return HAL_STATUS_AUTH_FAILURE;
+	case MGMT_STATUS_NOT_CONNECTED:
+		return HAL_STATUS_REMOTE_DEVICE_DOWN;
+	default:
+		return HAL_STATUS_FAILED;
+	}
+}
+
 static void mgmt_connect_failed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
+	const struct mgmt_ev_connect_failed *ev = param;
+
 	DBG("");
+
+	/* In case security mode 3 pairing we will get connect failed event
+	* in case e.g wrong PIN code entered. Let's check if device is
+	* bonding, if so update bond state */
+	set_device_bond_state(&ev->addr.bdaddr, status_mgmt2hal(ev->status),
+							HAL_BOND_STATE_NONE);
 }
 
 static void mgmt_auth_failed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
+	const struct mgmt_ev_auth_failed *ev = param;
+
 	DBG("");
+
+	set_device_bond_state(&ev->addr.bdaddr, status_mgmt2hal(ev->status),
+							HAL_BOND_STATE_NONE);
 }
 
 static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
@@ -1924,28 +1959,6 @@ static uint8_t set_property(void *buf, uint16_t len)
 	}
 }
 
-static uint8_t status_mgmt2hal(uint8_t mgmt)
-{
-	switch (mgmt) {
-	case MGMT_STATUS_SUCCESS:
-		return HAL_STATUS_SUCCESS;
-	case MGMT_STATUS_NO_RESOURCES:
-		return HAL_STATUS_NOMEM;
-	case MGMT_STATUS_BUSY:
-		return HAL_STATUS_BUSY;
-	case MGMT_STATUS_NOT_SUPPORTED:
-		return HAL_STATUS_UNSUPPORTED;
-	case MGMT_STATUS_INVALID_PARAMS:
-		return HAL_STATUS_INVALID;
-	case MGMT_STATUS_AUTH_FAILED:
-		return HAL_STATUS_AUTH_FAILURE;
-	case MGMT_STATUS_NOT_CONNECTED:
-		return HAL_STATUS_REMOTE_DEVICE_DOWN;
-	default:
-		return HAL_STATUS_FAILED;
-	}
-}
-
 static void pair_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-- 
1.8.4

