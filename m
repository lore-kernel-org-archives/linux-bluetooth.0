Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Add temporary workaround to skip wrong OMTU for basic rate
Date: Thu,  7 Apr 2011 14:31:48 -0300
Message-Id: <1302197508-893-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch is required until MTU kernel patch is not integrated. Kernel
is returning zero for basic rate OMTU.
---
 attrib/gattrib.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 290cd96..8c15e52 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -409,7 +409,7 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	if (bt_io_get(attrib->io, BT_IO_L2CAP, NULL,
 			BT_IO_OPT_OMTU, &omtu,
 			BT_IO_OPT_INVALID)) {
-		if (omtu > ATT_MAX_MTU)
+		if (omtu == 0 || omtu > ATT_MAX_MTU)
 			omtu = ATT_MAX_MTU;
 	} else
 		omtu = ATT_DEFAULT_LE_MTU;
-- 
1.7.4.1

