Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 2/6] hog: Add suspend back-end selection
Date: Wed, 29 Aug 2012 17:53:06 -0300
Message-Id: <1346273590-16693-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
 <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series introduces back-end selection for HoG suspend drivers.
The default back-end is called "dummy", added for testing purpose only.
---
 Makefile.am  | 3 +++
 acinclude.m4 | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index f6eb96b..198515b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -439,6 +439,9 @@ audio/telephony.c: audio/@TELEPHONY_DRIVER@
 profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
+profiles/input/suspend.c: profiles/input/@HOG_SUSPEND_DRIVER@
+	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+
 scripts/%.rules:
 	$(AM_V_GEN)cp $(subst 97-,,$@) $@
 
diff --git a/acinclude.m4 b/acinclude.m4
index 39b0a18..ed2d011 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -185,6 +185,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	datafiles_enable=yes
 	telephony_driver=dummy
 	sap_driver=dummy
+	hog_suspend_driver=dummy
 	dbusoob_enable=no
 	wiimote_enable=no
 	gatt_enable=no
@@ -288,6 +289,12 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		wiimote_enable=${enableval}
 	])
 
+	AC_ARG_WITH(gatt, AC_HELP_STRING([--with-hog-suspend=DRIVER], [select HoG suspend driver]), [
+		hog_suspend_driver=${withval}
+	])
+
+	AC_SUBST([HOG_SUSPEND_DRIVER], [suspend-${hog_suspend_driver}.c])
+
 	AC_ARG_ENABLE(gatt, AC_HELP_STRING([--enable-gatt], [enable gatt module]), [
 		gatt_enable=${enableval}
 	])
-- 
1.7.12

