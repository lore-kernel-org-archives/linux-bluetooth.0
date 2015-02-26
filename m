Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 11/16] attrib/gatt: Improve robustness when searching for included services
Date: Thu, 26 Feb 2015 10:39:38 +0100
Message-Id: <1424943583-30061-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this patch it is possible to enter infinite loop when
searching included services on remote device. This patch fixes that.

Issue happens when remote device replies with ending handle which is
lower than start handle we use for search
---
 attrib/gatt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index bc2f92a..ea5c1cf 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -55,6 +55,7 @@ struct included_discovery {
 	unsigned int	id;
 	int		refs;
 	int		err;
+	uint16_t	start_handle;
 	uint16_t	end_handle;
 	GSList		*includes;
 	gatt_cb_t	cb;
@@ -549,8 +550,19 @@ static void find_included_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 
 	att_data_list_free(list);
 
+	/*
+	 * If last handle is lower from previous start handle then it is smth
+	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 */
+	if (last_handle < isd->start_handle) {
+		isd->err = ATT_ECODE_UNLIKELY;
+		goto done;
+	}
+
+	isd->start_handle = last_handle + 1;
+
 	if (last_handle < isd->end_handle)
-		find_included(isd, last_handle + 1);
+		find_included(isd, isd->start_handle);
 
 done:
 	if (isd->err == 0)
@@ -564,6 +576,7 @@ unsigned int gatt_find_included(GAttrib *attrib, uint16_t start, uint16_t end,
 
 	isd = g_new0(struct included_discovery, 1);
 	isd->attrib = g_attrib_ref(attrib);
+	isd->start_handle = start;
 	isd->end_handle = end;
 	isd->cb = func;
 	isd->user_data = user_data;
-- 
1.8.4

