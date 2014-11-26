Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] gattrib: Fix not setting att's mtu size in g_attrib_new()
Date: Wed, 26 Nov 2014 09:45:50 +0100
Message-Id: <1416991551-21617-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We were setting only the buffer in gattrib but att was left with the
default value of 23 (LE transport layer defaults). For BREDR transport
layer this may result in using smaller MTU than the minimum allowed (48).

This was affecting cases when MTU Exchange was not supported by the
remote device and defaults were used.
---
 attrib/gattrib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index ce7f7b3..a04a0ee 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -83,6 +83,9 @@ GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
 	if (!attr->att)
 		goto fail;
 
+	if (!bt_att_set_mtu(attr->att, mtu))
+		goto fail;
+
 	attr->buf = malloc0(mtu);
 	attr->buflen = mtu;
 	if (!attr->buf)
-- 
1.9.1

