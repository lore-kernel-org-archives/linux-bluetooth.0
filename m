Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obex: Fix always searching UUID using 128 bit format
Date: Thu,  5 Oct 2017 16:11:09 +0300
Message-Id: <20171005131109.13999-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When discovering the SDP records the code should attempt to use
16 bit format whenever possible.
---
 obexd/client/bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index e35124a0c..0c043e0ac 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -306,6 +306,8 @@ static gboolean service_callback(GIOChannel *io, GIOCondition cond,
 	if (bt_string2uuid(&uuid, session->service) < 0)
 		goto failed;
 
+	sdp_uuid128_to_uuid(&uuid);
+
 	search = sdp_list_append(NULL, &uuid);
 	attrid = sdp_list_append(NULL, &range);
 
-- 
2.13.6

