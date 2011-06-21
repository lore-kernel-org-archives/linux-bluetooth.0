Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Fix hid2hci compilation error
Date: Tue, 21 Jun 2011 11:14:44 +0200
Message-ID: <1308647684-22612-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Do not compile hid2hci if udev is not present.
---
 acinclude.m4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index d77937b..10e648d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -400,7 +400,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(TOOLS, test "${tools_enable}" = "yes")
 	AM_CONDITIONAL(BCCMD, test "${bccmd_enable}" = "yes")
 	AM_CONDITIONAL(PCMCIA, test "${pcmcia_enable}" = "yes")
-	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" = "yes" && test "${usb_found}" = "yes")
+	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" = "yes" && test "${usb_found}" = "yes" && test "${udev_found}" = "yes")
 	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" = "yes" && test "${usb_found}" = "yes")
 	AM_CONDITIONAL(UDEVRULES, test "${udevrules_enable}" = "yes")
 	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
-- 
on behalf of ST-Ericsson

