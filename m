Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Fix starting the security procedure when setting the MTU
Date: Mon,  9 May 2011 14:56:28 -0300
Message-Id: <1304963788-2926-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The default security level of btio is BT_IO_SEC_MEDIUM, and for
LE links this would cause encryption to be started. So, we set the
security level to LOW (a no-op) and the MTU to the desired value.
---
 attrib/gattrib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 8c15e52..55ec645 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -540,6 +540,7 @@ gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 
 	if (!bt_io_set(attrib->io, BT_IO_L2CAP, NULL,
 			BT_IO_OPT_OMTU, mtu,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 			BT_IO_OPT_INVALID))
 		return FALSE;
 
-- 
1.7.4.3

