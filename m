Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 02/16] android/hardware: Add HFP Client Interface ID.
Date: Wed, 10 Sep 2014 13:34:00 +0200
Message-Id: <1410348854-26249-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hardware/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/hardware/bluetooth.h b/android/hardware/bluetooth.h
index c00a8f7..0d3283b 100644
--- a/android/hardware/bluetooth.h
+++ b/android/hardware/bluetooth.h
@@ -37,6 +37,7 @@ __BEGIN_DECLS
 /* Bluetooth profile interface IDs */
 
 #define BT_PROFILE_HANDSFREE_ID "handsfree"
+#define BT_PROFILE_HANDSFREE_CLIENT_ID "handsfree_client"
 #define BT_PROFILE_ADVANCED_AUDIO_ID "a2dp"
 #define BT_PROFILE_HEALTH_ID "health"
 #define BT_PROFILE_SOCKETS_ID "socket"
-- 
1.8.4

