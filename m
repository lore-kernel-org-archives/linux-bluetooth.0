Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/11] android/README: Update customization section
Date: Mon, 15 Sep 2014 16:49:15 +0200
Message-Id: <1410792555-24765-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
References: <1410792555-24765-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/android/README b/android/README
index 20b61a6..bbbcb5f 100644
--- a/android/README
+++ b/android/README
@@ -190,9 +190,11 @@ It is possible to customize BlueZ for Android through Android system properties.
 This may include enabling extra profiles or features inside HALs implementation
 These properties are read on Bluetooth stack startup only and require stack
 restart if changed. All customization properties names start with
-"persist.sys.bluetooth." followed by specific HAL name e.g.
-"persist.sys.bluetooth.handsfree". This section list available customization
-options.
+"persist.sys.bluetooth." or "ro.bluerooth." followed by specific HAL name e.g.
+"persist.sys.bluetooth.handsfree". If both are present "persist.sys.bluetooth."
+takes precedence. This allows for read only properties to be set during build
+leaving enough flexibility for developing or debugging purposes.
+This section list available customization options.
 
 Property	Value		Description
 -------------------------------------------
@@ -205,6 +207,12 @@ handsfree	hfp		Enable Handsfree Profile (HFP) with narrowband
 		hfp_wbs		Enable Handsfree Profile (HFP) with narrowband
 				and wideband speech support
 		<none>		Don't enable Handsfree Profile (HFP)
+vendor		<any>		Set vendor name in DIS. If not set fallback to
+				"ro.product.manufacturer".
+model		<any>		Set model name used as default adapter name.
+				If not set fallback to "ro.product.model".
+name		<any>		Set model number in DIS. If not set fallback to
+				"ro.product.name".
 
 
 Building and running on Linux
-- 
1.9.3

