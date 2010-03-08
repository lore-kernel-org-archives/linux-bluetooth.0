Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Fix compilation when --enable-test is passed
Date: Mon,  8 Mar 2010 20:01:32 -0300
Message-Id: <1268089292-18303-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When --enable-test is passed along with --disable-alsa and
--disable-gstreamer, the SBC lib is not built, which breaks
compilation of the ipctest test program.
---
 acinclude.m4 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 2e4444d..0eaf236 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -316,7 +316,8 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 
 	AM_CONDITIONAL(SNDFILE, test "${sndfile_enable}" = "yes" && test "${sndfile_found}" = "yes")
 	AM_CONDITIONAL(USB, test "${usb_enable}" = "yes" && test "${usb_found}" = "yes")
-	AM_CONDITIONAL(SBC, test "${alsa_enable}" = "yes" || test "${gstreamer_enable}" = "yes")
+	AM_CONDITIONAL(SBC, test "${alsa_enable}" = "yes" || test "${gstreamer_enable}" = "yes" ||
+			test "${test_enable}" = "yes")
 	AM_CONDITIONAL(ALSA, test "${alsa_enable}" = "yes" && test "${alsa_found}" = "yes")
 	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" = "yes" && test "${gstreamer_found}" = "yes")
 	AM_CONDITIONAL(AUDIOPLUGIN, test "${audio_enable}" = "yes")
-- 
1.7.0

