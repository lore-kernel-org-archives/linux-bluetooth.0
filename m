Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 05/15] android/readme: Add information about handsfree-client
Date: Mon, 15 Sep 2014 13:51:18 +0200
Message-Id: <1410781888-1952-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/README b/android/README
index 20b61a6..6b6a62e 100644
--- a/android/README
+++ b/android/README
@@ -37,6 +37,9 @@ features (currently epoll_create1 and ppoll calls for Android 4.4). Sample
 Bionic for Android 4.4 with all required features backported is available at
 https://code.google.com/p/aosp-bluez.platform-bionic/
 
+- Some of the bluetooth HALs are available only when BLUEZ_EXTENSIONS flag is
+set in BoardConfig.mk or similar. Please read below for detail which HALs needs
+that.
 
 Runtime requirements
 --------------------
@@ -257,6 +260,7 @@ health        bt_hl.h            complete
 pan           bt_pan.h           complete
 avrcp         bt_rc.h            complete
 socket        bt_sock.h          complete
+hf-client     bt_hf_client.h     initial
 
 
 Implementation shortcomings
@@ -323,6 +327,12 @@ methods:
 client->set_adv_data               missing kernel support for vendor data
 client->connect                    is_direct parameter is ignored
 
+HAL HF Client
+-------------
+
+Available on Android only when BLUEZ_EXTENSIONS flag set in BoardConfig.mk
+
+
 Audio SCO HAL
 =============
 
-- 
1.8.4

