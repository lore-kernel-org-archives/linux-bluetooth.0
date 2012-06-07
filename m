Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 7/8] Fix gatt_connect for BR/EDR
Date: Wed,  6 Jun 2012 21:41:02 -0300
Message-Id: <1339029663-25654-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use BT_IO_OPT_IMTU instead of BT_IO_OPT_OMTU in bt_io_connect.
We cannot control omtu value since it is negotiated during L2CAP
configuration phase.
---
 attrib/utils.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/utils.c b/attrib/utils.c
index 92bba09..f809b1f 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -101,7 +101,7 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 				BT_IO_OPT_SOURCE_BDADDR, &sba,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_PSM, psm,
-				BT_IO_OPT_OMTU, mtu,
+				BT_IO_OPT_IMTU, mtu,
 				BT_IO_OPT_SEC_LEVEL, sec,
 				BT_IO_OPT_INVALID);
 
-- 
1.7.10.3

