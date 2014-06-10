Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Add Android CTS tests results
Date: Tue, 10 Jun 2014 15:22:24 +0200
Message-Id: <1402406544-32666-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am |  1 +
 android/cts.txt     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 android/cts.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 3e48ddc..3429adb 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -220,6 +220,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/init.bluetooth.rc \
 				android/hal-ipc-api.txt \
 				android/audio-ipc-api.txt \
+				android/cts.txt \
 				android/pics-rfcomm.txt \
 				android/pics-spp.txt \
 				android/pics-sdp.txt \
diff --git a/android/cts.txt b/android/cts.txt
new file mode 100644
index 0000000..bf351b1
--- /dev/null
+++ b/android/cts.txt
@@ -0,0 +1,32 @@
+Android Compatibility Test Suite results
+
+Tested: 10-June-2014
+Android version: 4.4.2
+
+-------------------------------------------------------------------------------
+android.bluetooth.cts.BasicAdapterTest (automated tests)
+Test Name				Result	Notes
+-------------------------------------------------------------------------------
+testAndroidTestCaseSetupProperly	PASS
+test_checkBluetoothAddress		PASS
+test_enableDisable			PASS
+test_getAddress				PASS
+test_getBondedDevices			PASS
+test_getDefaultAdapter			PASS
+test_getName				PASS
+test_getRemoteDevice			PASS
+test_listenUsingRfcommWithServiceRecord	PASS
+-------------------------------------------------------------------------------
+
+
+-------------------------------------------------------------------------------
+com.android.cts.verifier (manual tests)
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+Toggle Bluetooth	PASS
+Insecure Client		PASS
+Insecure Server		PASS	Required kernel patch commit ID:
+				6453462e99e8be13a2c8f2b3535f340b742d8192
+Secure Client		PASS
+Secure Server		PASS
+-------------------------------------------------------------------------------
-- 
1.9.1

