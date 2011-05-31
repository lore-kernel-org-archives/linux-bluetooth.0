Return-Path: <cyrus@holtmann.org>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-bluetooth@vger.kernel.org
Cc: Nobuhiro Iwamatsu <iwamatsu@debian.org>
Subject: [PATCH] Fix install path for udevdir
Date: Tue, 31 May 2011 16:48:05 +0900
Message-Id: <1306828085-30834-1-git-send-email-iwamatsu@nigauri.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nobuhiro Iwamatsu <iwamatsu@debian.org>

If PCMCIA enabled, udevdir value override from /lib/udev to
$(libexecdir)/udev.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@debian.org>
---
 Makefile.am |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 175f8c9..5325d6d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -355,8 +355,6 @@ EXTRA_DIST += scripts/bluetooth.rules \
 		scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules
 
 if PCMCIA
-udevdir = $(libexecdir)/udev
-
 dist_udev_SCRIPTS = scripts/bluetooth_serial
 endif
 
-- 
1.7.5.1

