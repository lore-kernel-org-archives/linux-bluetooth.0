Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] android/handsfree-client: Trivial fix typo
Date: Tue,  2 Dec 2014 12:03:20 +0100
Message-Id: <1417518200-18428-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1417518200-18428-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1417518200-18428-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h          | 2 +-
 android/handsfree-client.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 33b53c5..e0be314 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -2223,7 +2223,7 @@ struct hal_ev_hf_client_call_waiting {
 } __attribute__((packed));
 
 #define HAL_HF_CLIENT_DIRECTION_OUTGOING	0x00
-#define HAL_HF_CLIENT_DIRECTION_INCOMIGN	0x01
+#define HAL_HF_CLIENT_DIRECTION_INCOMING	0x01
 
 #define HAL_HF_CLIENT_CALL_STATE_ACTIVE			0x00
 #define HAL_HF_CLIENT_CALL_STATE_HELD			0x01
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 5f7f68a..1caeaed 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -956,7 +956,7 @@ static void clcc_cb(struct hfp_context *context, void *user_data)
 	ev->index = val;
 
 	if (!hfp_context_get_number(context, &val) ||
-				val > HAL_HF_CLIENT_DIRECTION_INCOMIGN) {
+				val > HAL_HF_CLIENT_DIRECTION_INCOMING) {
 		error("hf-client: Could not get direction");
 		return;
 	}
-- 
1.8.4

