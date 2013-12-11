Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/8] android/pts: Add PTS PIXIT for DID
Date: Wed, 11 Dec 2013 16:27:12 +0100
Message-Id: <1386775638-24941-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
References: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This complements PTS PICS configuration.
---
 android/Makefile.am   |  3 ++-
 android/pixit-did.txt | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 android/pixit-did.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index f3e77c3..0ffbdb0 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -106,4 +106,5 @@ endif
 EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-gap.txt android/pics-hid.txt \
 		android/pics-pan.txt android/pics-did.txt \
-		android/pics-opp.txt android/pics-pbap.txt
+		android/pics-opp.txt android/pics-pbap.txt \
+		android/pixit-did.txt
diff --git a/android/pixit-did.txt b/android/pixit-did.txt
new file mode 100644
index 0000000..2527845
--- /dev/null
+++ b/android/pixit-did.txt
@@ -0,0 +1,22 @@
+DID PIXIT for the PTS tool.
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_security_enabled					False
+TSPX_ClientExecutableURL				False (*)
+TSPX_ServiceDescription					False (*)
+TSPX_DocumentationURL					False (*)
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_class_of_device_pts				200404
+TSPX_device_search_time					30
+TSPX_delete_link_key					False
+TSPX_pin_code						0000
+TSPX_time_guard						200000
+TSPX_use_implicit_send					True
+TSPX_secure_simple_pairing_pass_key_confirmation	False
+-------------------------------------------------------------------------------
-- 
1.8.3.2

