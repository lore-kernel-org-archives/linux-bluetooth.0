Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 6/8] Remove omtu parameter from LE bt_io_connect calls
Date: Wed,  6 Jun 2012 21:41:01 -0300
Message-Id: <1339029663-25654-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to set the omtu of L2CAP ATT fixed channel. We
use the default value.
---
 attrib/utils.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/attrib/utils.c b/attrib/utils.c
index c951f44..92bba09 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -94,7 +94,6 @@ GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_DEST_TYPE, dest_type,
 				BT_IO_OPT_CID, ATT_CID,
-				BT_IO_OPT_OMTU, mtu,
 				BT_IO_OPT_SEC_LEVEL, sec,
 				BT_IO_OPT_INVALID);
 	else
-- 
1.7.10.3

