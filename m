Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] gattrib: Fix not changing the buffer size when mtu is reduced
Date: Wed, 26 Nov 2014 09:45:51 +0100
Message-Id: <1416991551-21617-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416991551-21617-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416991551-21617-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using larger buffer than mtu resulted in not sending the message at all
as encode_pdu() in shared/att.c fails when provided data buffer is larger
than current mtu.
---
 attrib/gattrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index a04a0ee..f20b4f9 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -325,7 +325,7 @@ uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu)
 {
 	/* Clients of this expect a buffer to use. */
-	if (mtu > attrib->buflen) {
+	if (mtu != attrib->buflen) {
 		attrib->buf = g_realloc(attrib->buf, mtu);
 		attrib->buflen = mtu;
 	}
-- 
1.9.1

