Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/2] android/handsfree: Add support for enabling mSBC codec
Date: Thu, 13 Mar 2014 23:52:15 +0100
Message-Id: <1394751135-2747-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1394751135-2747-1-git-send-email-szymon.janc@gmail.com>
References: <1394751135-2747-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree.c |  4 ++++
 android/handsfree.c     | 18 +++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 31793b0..1cdb447 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -214,6 +214,10 @@ static uint8_t get_mode(void)
 					(!strcasecmp(value, "hsp_only")))
 		return HAL_MODE_HANDSFREE_HSP_ONLY;
 
+	if (property_get("bluetooth.handsfree_mode", value, "") > 0 &&
+					(!strcasecmp(value, "esco_msbc")))
+		return HAL_MODE_HANDSFREE_ESCO_MSBC;
+
 	return HAL_MODE_DEFAULT;
 }
 
diff --git a/android/handsfree.c b/android/handsfree.c
index e488859..319bf91 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -150,6 +150,8 @@ static struct {
 	guint sco_watch;
 } device;
 
+static uint8_t hal_mode = HAL_MODE_DEFAULT;
+
 static bdaddr_t adapter_addr;
 static struct ipc *hal_ipc = NULL;
 
@@ -181,6 +183,14 @@ static void device_set_state(uint8_t state)
 				HAL_EV_HANDSFREE_CONN_STATE, sizeof(ev), &ev);
 }
 
+static void init_codecs(void)
+{
+	memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+
+	if (hal_mode == HAL_MODE_HANDSFREE_ESCO_MSBC)
+		device.codecs[MSBC_OFFSET].local_supported = true;
+}
+
 static void device_set_audio_state(uint8_t state)
 {
 	struct hal_ev_handsfree_audio_state ev;
@@ -207,7 +217,7 @@ static void device_init(const bdaddr_t *bdaddr)
 
 	memcpy(device.inds, inds_defaults, sizeof(device.inds));
 
-	memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+	init_codecs();
 
 	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
 }
@@ -1252,8 +1262,8 @@ static void at_cmd_bac(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 		if (!(device.features & HFP_HF_FEAT_CODEC))
 			goto failed;
 
-		/* Clear list of codecs */
-		memcpy(device.codecs, codecs_defaults, sizeof(device.codecs));
+		/* set codecs to defaults */
+		init_codecs();
 		device.negotiated_codec = 0;
 
 		/* At least CVSD mandatory codec must exist
@@ -2487,6 +2497,8 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
+	hal_mode = mode;
+
 	return true;
 }
 
-- 
1.9.0

