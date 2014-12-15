Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 4/5] attrib/gattrib: Fix gattrib send command
Date: Mon, 15 Dec 2014 10:59:06 +0100
Message-Id: <1418637547-20848-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If client provides id to the g_attrib_send function it should be taken
into account and appropriate bt_att_send* should be called
---
 attrib/gattrib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 3ce6748..cf0bf3b 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -276,8 +276,12 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 		destroy_cb = attrib_callbacks_remove;
 	}
 
-	return bt_att_send(attrib->att, pdu[0], (void *)pdu + 1, len - 1,
-						response_cb, cb, destroy_cb);
+	if (id == 0)
+		return bt_att_send(attrib->att, pdu[0], (void *)pdu + 1,
+					len - 1, response_cb, cb, destroy_cb);
+
+	return bt_att_send_with_id(attrib->att, id, pdu[0], (void *)pdu + 1,
+					len - 1, response_cb, cb, destroy_cb);
 }
 
 gboolean g_attrib_cancel(GAttrib *attrib, guint id)
-- 
1.8.4

