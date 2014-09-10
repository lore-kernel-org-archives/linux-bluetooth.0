Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/4] android/hal-ipc-api: Fix define for HF-Client
Date: Wed, 10 Sep 2014 13:11:34 +0200
Message-Id: <1410347494-22084-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410347494-22084-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 0948af2..f6e1680 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2083,7 +2083,7 @@ Notifications:
 Bluetooth Handsfree Client HAL (ID 10)
 ======================================
 
-Android HAL name: "hf_client" (BT_PROFILE_HF_CLIENT_ID)
+Android HAL name: "hf_client" (BT_PROFILE_HANDSFREE_CLIENT_ID)
 
 Commands and response:
 
-- 
1.8.4

