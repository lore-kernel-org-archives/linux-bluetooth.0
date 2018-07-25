Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Simon Schubert <2@0x2c.org>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Schubert <2@0x2c.org>
Subject: [PATCH BlueZ 1/1] input/hog-lib: set notify bit on every connection
Date: Wed, 25 Jul 2018 16:07:28 -0400
Message-Id: <20180725200728.11835-2-2@0x2c.org>
In-Reply-To: <20180725200728.11835-1-2@0x2c.org>
References: <20180725200728.11835-1-2@0x2c.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

At least the Microsoft Bluetooth Mobile Mouse 3600 does not persist
the CCC.  To work around this bug, we check and process the CCC like
we would do for an initial discovery.
---
 profiles/input/hog-lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index d9ed80689..d3439b8ba 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1610,10 +1610,10 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-		r->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					r->value_handle,
-					report_value_cb, r, NULL);
+		if (r->type == HOG_REPORT_TYPE_INPUT) {
+			read_char(r->hog, r->hog->attrib,
+				  r->ccc_handle, ccc_read_cb, r);
+		}
 	}
 
 	return true;
-- 
2.18.0

