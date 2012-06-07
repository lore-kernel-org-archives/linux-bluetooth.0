Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/8] gattrib: Fix g_attrib_set_mtu
Date: Wed,  6 Jun 2012 21:40:57 -0300
Message-Id: <1339029663-25654-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
References: <1339029663-25654-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

23 octets is the default (and minimum) ATT_MTU value. If someone tries
to set ATT_MTU less than 23 octets g_attrib_set_mtu should fail (return
FALSE). Additionally, there is no constraint regarding the maximum value
of ATT_MTU, so we should not check for it.

Also, we should not change the L2CAP ATT fixed channel MTU. bt_io_set
call will always fail since we are not supposed to change L2CAP MTU
after connection is established.
---
 attrib/gattrib.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 137e0ab..6729f36 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -627,14 +627,6 @@ uint8_t *g_attrib_get_buffer(GAttrib *attrib, int *len)
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 {
 	if (mtu < ATT_DEFAULT_LE_MTU)
-		mtu = ATT_DEFAULT_LE_MTU;
-
-	if (mtu > ATT_MAX_MTU)
-		mtu = ATT_MAX_MTU;
-
-	if (!bt_io_set(attrib->io, BT_IO_L2CAP, NULL,
-			BT_IO_OPT_OMTU, mtu,
-			BT_IO_OPT_INVALID))
 		return FALSE;
 
 	attrib->buf = g_realloc(attrib->buf, mtu);
-- 
1.7.10.3

