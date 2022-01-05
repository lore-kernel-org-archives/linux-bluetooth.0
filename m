Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1EFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jan 2022 22:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbiAEW3w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jan 2022 17:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiAEW3s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jan 2022 17:29:48 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661FBC061245
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jan 2022 14:29:48 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c2so618254pfc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jan 2022 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XjePjuhyrdXt04VoOoE7I1BSAD2Vkj8udnQDpF7lkY=;
        b=Dh5yHXsN3x5tXsIhs+RimaKc/lROtudlIIBeGZ9lyOT9NMqqlDrdjUwJLIHTST4D2a
         +buwg4ZpsP1HCruKhQVClXonLeb3jVlMyHkxq4mUNEP0LSBaSJODf5Zqgsn45AjIJU5o
         QXqISuYFnD1vgXSJLO2QWXAx6O63N0v/5uw/aTl3axp45d6zmIo61m3q6sDie3hNkIg7
         xTUV/ToIzJ6AlGqcVDdviO97+w/3WdTrK/LNV91Z+QC5c8S3B+6Ngvc3inXFj0UEkp/d
         eq3kqXBUuQ3jP9wWlCDHo2Kr5dDw8999ehRbmytq4eCRHswWFUbcmn9gPGuiAv0PRKAy
         JWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XjePjuhyrdXt04VoOoE7I1BSAD2Vkj8udnQDpF7lkY=;
        b=xFzf2AOC4SmD5V0bOzVDyk8VSStFWUjmmroB19Wz1IOz6MrqQFINtLhgOzbNfeeVq/
         GDuKKRisL6QjhQAli8buvzfn4vErfdQp5Wz9iePB+Qx09eId2x1jX5qAz9x4bvYunwP7
         sq2MFYb1O02jVfVI5c0+FFOSWvsn1aliUMYHz+1kd/0z2bF4ZmPWeKzJOkR5FZubvp5i
         Gnbxf0XsdOFJtaBXkbmuDYJUdVIFVPP/LQamALC+HGxYn/R4/0zfHka09OhsvQx+CLcU
         Pao+D3MFTPsy2TGsE4Zz90xH8JN4A9QyKUVXhSX6KTNq8W0zn4SzacZVLJ/D7dgRbxXb
         dNdw==
X-Gm-Message-State: AOAM530D3o0z7OBm5YINPl2xRlYGB59TxJjHWb+0Y0Ii/ioR2dUEpmvg
        ilXMf4t8fp2bjwOnJHS6ZPbYb4V/8ek=
X-Google-Smtp-Source: ABdhPJxaaM6+2BQwUEg3stLw10/7BzLTi+cCAVFJU6bW6qJEevfmLYNAd+lJICtMTBEfhvIO4Jhjqg==
X-Received: by 2002:a63:f706:: with SMTP id x6mr50134443pgh.69.1641421787335;
        Wed, 05 Jan 2022 14:29:47 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l2sm126178pfc.42.2022.01.05.14.29.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 14:29:47 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] configure: Fix use of obsolete macros
Date:   Wed,  5 Jan 2022 14:29:46 -0800
Message-Id: <20220105222946.3235852-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings when using autoconf >= 2.70:

  configure.ac:19: warning: The macro `AC_LANG_C' is obsolete.
  configure.ac:45: warning: The macro `AC_HELP_STRING' is obsolete.
  configure.ac:440: warning: AC_OUTPUT should be used without arguments.

The macros are replacing following the autoconf documentation:

https://www.gnu.org/software/autoconf/manual/autoconf-2.70/html_node/Obsolete-Macros.html

Fixes: https://github.com/bluez/bluez/issues/246
---
 acinclude.m4 | 12 ++++----
 configure.ac | 87 ++++++++++++++++++++++++++--------------------------
 2 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index b388dfc11..c5d6de7b3 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -71,13 +71,13 @@ AC_DEFUN([COMPILER_FLAGS], [
 AC_DEFUN([MISC_FLAGS], [
 	misc_cflags=""
 	misc_ldflags=""
-	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
+	AC_ARG_ENABLE(optimization, AS_HELP_STRING([--disable-optimization],
 			[disable code optimization through compiler]), [
 		if (test "${enableval}" = "no"); then
 			misc_cflags="$misc_cflags -O0"
 		fi
 	])
-	AC_ARG_ENABLE(asan, AC_HELP_STRING([--enable-asan],
+	AC_ARG_ENABLE(asan, AS_HELP_STRING([--enable-asan],
 			[enable linking with address sanitizer]), [
 		save_LIBS=$LIBS
 		AC_CHECK_LIB(asan, _init)
@@ -90,7 +90,7 @@ AC_DEFUN([MISC_FLAGS], [
 			AC_SUBST([ASAN_LIB], ${ac_cv_lib_asan__init})
 		fi
 	])
-	AC_ARG_ENABLE(lsan, AC_HELP_STRING([--enable-lsan],
+	AC_ARG_ENABLE(lsan, AS_HELP_STRING([--enable-lsan],
 			[enable linking with address sanitizer]), [
 		save_LIBS=$LIBS
 		AC_CHECK_LIB(lsan, _init)
@@ -103,7 +103,7 @@ AC_DEFUN([MISC_FLAGS], [
 			AC_SUBST([ASAN_LIB], ${ac_cv_lib_lsan__init})
 		fi
 	])
-	AC_ARG_ENABLE(ubsan, AC_HELP_STRING([--enable-ubsan],
+	AC_ARG_ENABLE(ubsan, AS_HELP_STRING([--enable-ubsan],
 			[enable linking with address sanitizer]), [
 		save_LIBS=$LIBS
 		AC_CHECK_LIB(ubsan, _init)
@@ -115,14 +115,14 @@ AC_DEFUN([MISC_FLAGS], [
 			misc_ldflags="$misc_ldflags -fsanitize=undefined";
 		fi
 	])
-	AC_ARG_ENABLE(debug, AC_HELP_STRING([--enable-debug],
+	AC_ARG_ENABLE(debug, AS_HELP_STRING([--enable-debug],
 			[enable compiling with debugging information]), [
 		if (test "${enableval}" = "yes" &&
 				test "${ac_cv_prog_cc_g}" = "yes"); then
 			misc_cflags="$misc_cflags -g"
 		fi
 	])
-	AC_ARG_ENABLE(pie, AC_HELP_STRING([--enable-pie],
+	AC_ARG_ENABLE(pie, AS_HELP_STRING([--enable-pie],
 			[enable position independent executables flag]), [
 		if (test "${enableval}" = "yes" &&
 				test "${ac_cv_prog_cc_pie}" = "yes"); then
diff --git a/configure.ac b/configure.ac
index 849e1db46..052a1e7d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -16,7 +16,7 @@ PKG_PROG_PKG_CONFIG
 
 COMPILER_FLAGS
 
-AC_LANG_C
+AC_LANG([C])
 
 AC_C_RESTRICT
 
@@ -49,7 +49,7 @@ MISC_FLAGS
 AM_CONDITIONAL(VALGRIND, test "${enable_valgrind}" = "yes" &&
 		test "$ASAN_LIB" != "yes" && test "LSAN_LIB" != "yes")
 
-AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
+AC_ARG_ENABLE(threads, AS_HELP_STRING([--enable-threads],
 		[enable threading support]), [enable_threads=${enableval}])
 
 AC_CHECK_FUNCS(explicit_bzero)
@@ -88,7 +88,7 @@ PKG_CHECK_MODULES(DBUS, dbus-1 >= 1.6, dummy=yes,
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
-AC_ARG_WITH([dbusconfdir], AC_HELP_STRING([--with-dbusconfdir=DIR],
+AC_ARG_WITH([dbusconfdir], AS_HELP_STRING([--with-dbusconfdir=DIR],
 				[path to D-Bus configuration directory]),
 					[path_dbusconfdir=${withval}])
 if (test -z "${path_dbusconfdir}"); then
@@ -101,7 +101,7 @@ if (test -z "${path_dbusconfdir}"); then
 fi
 AC_SUBST(DBUS_CONFDIR, [${path_dbusconfdir}])
 
-AC_ARG_WITH([dbussystembusdir], AC_HELP_STRING([--with-dbussystembusdir=DIR],
+AC_ARG_WITH([dbussystembusdir], AS_HELP_STRING([--with-dbussystembusdir=DIR],
 				[path to D-Bus system bus services directory]),
 					[path_dbussystembusdir=${withval}])
 if (test -z "${path_dbussystembusdir}"); then
@@ -114,7 +114,7 @@ if (test -z "${path_dbussystembusdir}"); then
 fi
 AC_SUBST(DBUS_SYSTEMBUSDIR, [${path_dbussystembusdir}])
 
-AC_ARG_WITH([dbussessionbusdir], AC_HELP_STRING([--with-dbussessionbusdir=DIR],
+AC_ARG_WITH([dbussessionbusdir], AS_HELP_STRING([--with-dbussessionbusdir=DIR],
 				[path to D-Bus session bus services directory]),
 					[path_dbussessionbusdir=${withval}])
 if (test -z "${path_dbussessionbusdir}"); then
@@ -127,7 +127,7 @@ if (test -z "${path_dbussessionbusdir}"); then
 fi
 AC_SUBST(DBUS_SESSIONBUSDIR, [${path_dbussessionbusdir}])
 
-AC_ARG_WITH([zsh-completion-dir], AC_HELP_STRING([--with-zsh-completion-dir=DIR],
+AC_ARG_WITH([zsh-completion-dir], AS_HELP_STRING([--with-zsh-completion-dir=DIR],
 				[path to install zsh completions]),
 					[path_zshcompletiondir=${withval}],
 						[path_zshcompletiondir="yes"])
@@ -139,7 +139,7 @@ fi
 AC_SUBST(ZSH_COMPLETIONDIR, [${path_zshcompletiondir}])
 AM_CONDITIONAL(ZSH_COMPLETIONS, test "${path_zshcompletiondir}" != "no")
 
-AC_ARG_ENABLE(backtrace, AC_HELP_STRING([--enable-backtrace],
+AC_ARG_ENABLE(backtrace, AS_HELP_STRING([--enable-backtrace],
 		[compile backtrace support]), [enable_backtrace=${enableval}])
 
 if (test "${enable_backtrace}" = "yes"); then
@@ -153,55 +153,55 @@ if (test "${enable_backtrace}" = "yes"); then
 	AC_SUBST(BACKTRACE_LIBS)
 fi
 
-AC_ARG_ENABLE(library, AC_HELP_STRING([--enable-library],
+AC_ARG_ENABLE(library, AS_HELP_STRING([--enable-library],
 		[install Bluetooth library]), [enable_library=${enableval}])
 AM_CONDITIONAL(LIBRARY, test "${enable_library}" = "yes")
 
-AC_ARG_ENABLE(test, AC_HELP_STRING([--enable-test],
+AC_ARG_ENABLE(test, AS_HELP_STRING([--enable-test],
 		[enable test/example scripts]), [enable_test=${enableval}])
 AM_CONDITIONAL(TEST, test "${enable_test}" = "yes")
 
-AC_ARG_ENABLE(nfc, AC_HELP_STRING([--enable-nfc],
+AC_ARG_ENABLE(nfc, AS_HELP_STRING([--enable-nfc],
 		[enable NFC paring]), [enable_nfc=${enableval}])
 AM_CONDITIONAL(NFC, test "${enable_nfc}" = "yes")
 
-AC_ARG_ENABLE(sap, AC_HELP_STRING([--enable-sap],
+AC_ARG_ENABLE(sap, AS_HELP_STRING([--enable-sap],
 		[enable SAP profile]), [enable_sap=${enableval}])
 AM_CONDITIONAL(SAP, test "${enable_sap}" = "yes")
 
-AC_ARG_ENABLE(a2dp, AC_HELP_STRING([--disable-a2dp],
+AC_ARG_ENABLE(a2dp, AS_HELP_STRING([--disable-a2dp],
 		[disable A2DP profile]), [enable_a2dp=${enableval}])
 AM_CONDITIONAL(A2DP, test "${enable_a2dp}" != "no")
 
-AC_ARG_ENABLE(avrcp, AC_HELP_STRING([--disable-avrcp],
+AC_ARG_ENABLE(avrcp, AS_HELP_STRING([--disable-avrcp],
 		[disable AVRCP profile]), [enable_avrcp=${enableval}])
 AM_CONDITIONAL(AVRCP, test "${enable_avrcp}" != "no")
 
-AC_ARG_ENABLE(network, AC_HELP_STRING([--disable-network],
+AC_ARG_ENABLE(network, AS_HELP_STRING([--disable-network],
 		[disable network profiles]), [enable_network=${enableval}])
 AM_CONDITIONAL(NETWORK, test "${enable_network}" != "no")
 
-AC_ARG_ENABLE(hid, AC_HELP_STRING([--disable-hid],
+AC_ARG_ENABLE(hid, AS_HELP_STRING([--disable-hid],
 		[disable HID profile]), [enable_hid=${enableval}])
 AM_CONDITIONAL(HID, test "${enable_hid}" != "no")
 
-AC_ARG_ENABLE(hog, AC_HELP_STRING([--disable-hog],
+AC_ARG_ENABLE(hog, AS_HELP_STRING([--disable-hog],
 		[disable HoG profile]), [enable_hog=${enableval}])
 AM_CONDITIONAL(HOG, test "${enable_hog}" != "no")
 
-AC_ARG_ENABLE(health, AC_HELP_STRING([--enable-health],
+AC_ARG_ENABLE(health, AS_HELP_STRING([--enable-health],
 		[enable health profiles]), [enable_health=${enableval}])
 AM_CONDITIONAL(HEALTH, test "${enable_health}" = "yes")
 
-AC_ARG_ENABLE(tools, AC_HELP_STRING([--disable-tools],
+AC_ARG_ENABLE(tools, AS_HELP_STRING([--disable-tools],
 		[disable Bluetooth tools]), [enable_tools=${enableval}])
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" != "no")
 
-AC_ARG_ENABLE(monitor, AC_HELP_STRING([--disable-monitor],
+AC_ARG_ENABLE(monitor, AS_HELP_STRING([--disable-monitor],
 		[disable Bluetooth monitor]), [enable_monitor=${enableval}])
 AM_CONDITIONAL(MONITOR, test "${enable_monitor}" != "no")
 
-AC_ARG_ENABLE(udev, AC_HELP_STRING([--disable-udev],
+AC_ARG_ENABLE(udev, AS_HELP_STRING([--disable-udev],
 		[disable udev device support]), [enable_udev=${enableval}])
 if (test "${enable_tools}" != "no" && test "${enable_udev}" != "no"); then
 	PKG_CHECK_MODULES(UDEV, libudev >= 172, dummy=yes,
@@ -214,7 +214,7 @@ if (test "${enable_tools}" != "no" && test "${enable_udev}" != "no"); then
 fi
 AM_CONDITIONAL(UDEV, test "${enable_udev}" != "no")
 
-AC_ARG_WITH([udevdir], AC_HELP_STRING([--with-udevdir=DIR],
+AC_ARG_WITH([udevdir], AS_HELP_STRING([--with-udevdir=DIR],
 			[path to udev directory]), [path_udevdir=${withval}])
 if (test "${enable_udev}" != "no" && test -z "${path_udevdir}"); then
 	AC_MSG_CHECKING([udev directory])
@@ -226,11 +226,11 @@ if (test "${enable_udev}" != "no" && test -z "${path_udevdir}"); then
 fi
 AC_SUBST(UDEV_DIR, [${path_udevdir}])
 
-AC_ARG_ENABLE(cups, AC_HELP_STRING([--disable-cups],
+AC_ARG_ENABLE(cups, AS_HELP_STRING([--disable-cups],
                 [disable CUPS printer support]), [enable_cups=${enableval}])
 AM_CONDITIONAL(CUPS, test "${enable_cups}" != "no")
 
-AC_ARG_ENABLE(mesh, AC_HELP_STRING([--enable-mesh],
+AC_ARG_ENABLE(mesh, AS_HELP_STRING([--enable-mesh],
 		[enable Mesh profile support]), [enable_mesh=${enableval}])
 AM_CONDITIONAL(MESH, test "${enable_mesh}" = "yes")
 
@@ -241,7 +241,7 @@ if (test "${enable_mesh}" = "yes"); then
 	AC_SUBST(JSON_LIBS)
 fi
 
-AC_ARG_ENABLE(midi, AC_HELP_STRING([--enable-midi],
+AC_ARG_ENABLE(midi, AS_HELP_STRING([--enable-midi],
                 [enable MIDI support]), [enable_midi=${enableval}])
 AM_CONDITIONAL(MIDI, test "${enable_midi}" = "yes")
 
@@ -252,7 +252,7 @@ if (test "${enable_midi}" = "yes"); then
 	AC_SUBST(ALSA_LIBS)
 fi
 
-AC_ARG_ENABLE(obex, AC_HELP_STRING([--disable-obex],
+AC_ARG_ENABLE(obex, AS_HELP_STRING([--disable-obex],
 		[disable OBEX profile support]), [enable_obex=${enableval}])
 if (test "${enable_obex}" != "no"); then
 	PKG_CHECK_MODULES(ICAL, libical, dummy=yes,
@@ -262,11 +262,11 @@ if (test "${enable_obex}" != "no"); then
 fi
 AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
 
-AC_ARG_ENABLE(btpclient, AC_HELP_STRING([--enable-btpclient],
+AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
 		[enable BTP client]), [enable_btpclient=${enableval}])
 AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
 
-AC_ARG_ENABLE([external_ell], AC_HELP_STRING([--enable-external-ell],
+AC_ARG_ENABLE([external_ell], AS_HELP_STRING([--enable-external-ell],
 				[enable external Embedded Linux library]),
 					[enable_external_ell=${enableval}])
 if (test "${enable_external_ell}" = "yes"); then
@@ -281,7 +281,7 @@ AM_CONDITIONAL(EXTERNAL_ELL, test "${enable_external_ell}" = "yes" ||
 AM_CONDITIONAL(LIBSHARED_ELL, test "${enable_btpclient}" = "yes" ||
 						test "${enable_mesh}" = "yes")
 
-AC_ARG_ENABLE(client, AC_HELP_STRING([--disable-client],
+AC_ARG_ENABLE(client, AS_HELP_STRING([--disable-client],
 		[disable command line client]), [enable_client=${enableval}])
 AM_CONDITIONAL(CLIENT, test "${enable_client}" != "no")
 
@@ -291,12 +291,12 @@ if (test "${enable_client}" != "no" || test "${enable_mesh}" = "yes"); then
 fi
 AM_CONDITIONAL(READLINE, test "${enable_readline}" = "yes")
 
-AC_ARG_ENABLE(systemd, AC_HELP_STRING([--disable-systemd],
+AC_ARG_ENABLE(systemd, AS_HELP_STRING([--disable-systemd],
 		[disable systemd integration]), [enable_systemd=${enableval}])
 AM_CONDITIONAL(SYSTEMD, test "${enable_systemd}" != "no")
 
 AC_ARG_WITH([systemdsystemunitdir],
-			AC_HELP_STRING([--with-systemdsystemunitdir=DIR],
+			AS_HELP_STRING([--with-systemdsystemunitdir=DIR],
 			[path to systemd system unit directory]),
 					[path_systemunitdir=${withval}])
 if (test "${enable_systemd}" != "no" && test -z "${path_systemunitdir}"); then
@@ -310,7 +310,7 @@ fi
 AC_SUBST(SYSTEMD_SYSTEMUNITDIR, [${path_systemunitdir}])
 
 AC_ARG_WITH([systemduserunitdir],
-			AC_HELP_STRING([--with-systemduserunitdir=DIR],
+			AS_HELP_STRING([--with-systemduserunitdir=DIR],
 			[path to systemd user unit directory]),
 					[path_userunitdir=${withval}])
 if (test "${enable_systemd}" != "no" && test -z "${path_userunitdir}"); then
@@ -323,12 +323,12 @@ if (test "${enable_systemd}" != "no" && test -z "${path_userunitdir}"); then
 fi
 AC_SUBST(SYSTEMD_USERUNITDIR, [${path_userunitdir}])
 
-AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
+AC_ARG_ENABLE(datafiles, AS_HELP_STRING([--disable-datafiles],
 			[do not install configuration and data files]),
 					[enable_datafiles=${enableval}])
 AM_CONDITIONAL(DATAFILES, test "${enable_datafiles}" != "no")
 
-AC_ARG_ENABLE(manpages, AC_HELP_STRING([--disable-manpages],
+AC_ARG_ENABLE(manpages, AS_HELP_STRING([--disable-manpages],
 			[disable building of manual pages]),
 					[enable_manpages=${enableval}])
 if (test "${enable_manpages}" != "no"); then
@@ -341,36 +341,36 @@ AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" != "no")
 AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" != "no" &&
 				test "${RST2MAN}" != "no")
 
-AC_ARG_ENABLE(testing, AC_HELP_STRING([--enable-testing],
+AC_ARG_ENABLE(testing, AS_HELP_STRING([--enable-testing],
 			[enable testing tools]),
 					[enable_testing=${enableval}])
 AM_CONDITIONAL(TESTING, test "${enable_testing}" = "yes")
 
-AC_ARG_ENABLE(experimental, AC_HELP_STRING([--enable-experimental],
+AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
 			[enable experimental tools]),
 					[enable_experimental=${enableval}])
 AM_CONDITIONAL(EXPERIMENTAL, test "${enable_experimental}" = "yes")
 
-AC_ARG_ENABLE(deprecated, AC_HELP_STRING([--enable-deprecated],
+AC_ARG_ENABLE(deprecated, AS_HELP_STRING([--enable-deprecated],
 			[enable deprecated tools]),
 					[enable_deprecated=${enableval}])
 AM_CONDITIONAL(DEPRECATED, test "${enable_deprecated}" = "yes")
 
-AC_ARG_ENABLE(sixaxis, AC_HELP_STRING([--enable-sixaxis],
+AC_ARG_ENABLE(sixaxis, AS_HELP_STRING([--enable-sixaxis],
 		[enable sixaxis plugin]), [enable_sixaxis=${enableval}])
 AM_CONDITIONAL(SIXAXIS, test "${enable_sixaxis}" = "yes" &&
 					 test "${enable_udev}" != "no")
 
-AC_ARG_ENABLE(hid2hci, AC_HELP_STRING([--enable-hid2hci],
+AC_ARG_ENABLE(hid2hci, AS_HELP_STRING([--enable-hid2hci],
 		[enable hid2hci tool]), [enable_hid2hci=${enableval}])
 AM_CONDITIONAL(HID2HCI, test "${enable_hid2hci}" = "yes" &&
 					test "${enable_udev}" != "no")
 
-AC_ARG_ENABLE(logger, AC_HELP_STRING([--enable-logger],
+AC_ARG_ENABLE(logger, AS_HELP_STRING([--enable-logger],
 		[enable HCI logger service]), [enable_logger=${enableval}])
 AM_CONDITIONAL(LOGGER, test "${enable_logger}" = "yes")
 
-AC_ARG_ENABLE(admin, AC_HELP_STRING([--enable-admin],
+AC_ARG_ENABLE(admin, AS_HELP_STRING([--enable-admin],
 		[enable admin policy plugin]), [enable_admin=${enableval}])
 AM_CONDITIONAL(ADMIN, test "${enable_admin}" = "yes")
 
@@ -404,7 +404,7 @@ AC_DEFINE_UNQUOTED(MESH_STORAGEDIR, "${storagedir}/mesh",
 			[Directory for the mesh daemon storage files])
 AC_SUBST(MESH_STORAGEDIR, "${storagedir}/mesh")
 
-AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
+AC_ARG_ENABLE(android, AS_HELP_STRING([--enable-android],
 			[enable BlueZ for Android]),
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
@@ -426,7 +426,7 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
-AC_ARG_WITH([phonebook], AC_HELP_STRING([--with-phonebook=PLUGIN],
+AC_ARG_WITH([phonebook], AS_HELP_STRING([--with-phonebook=PLUGIN],
 			[obexd phonebook plugin (default=dummy)]),
 			[plugin_phonebook=${withval}])
 if (test -z "${plugin_phonebook}"); then
@@ -446,4 +446,5 @@ if (test "${plugin_phonebook}" = "ebook"); then
 fi
 AC_SUBST(PLUGIN_PHONEBOOK, [${plugin_phonebook}])
 
-AC_OUTPUT(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
+AC_CONFIG_FILES(Makefile src/bluetoothd.rst lib/bluez.pc mesh/bluetooth-meshd.rst)
+AC_OUTPUT
-- 
2.33.1

