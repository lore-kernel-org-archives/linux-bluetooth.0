Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/4] gatt: Remove unneeded handle range check
Date: Fri, 28 Sep 2012 11:47:51 -0300
Message-Id: <1348843674-10878-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1348843674-10878-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the Service Changed is a read-only control point, it not necessary
to compare the previous value read. This logic was added to compare the
result of the read operation with the received indications. Repeated
indications containing the same range is a valid procedure.
---
 profiles/gatt/gas.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index d189221..a828fcd 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -44,7 +44,6 @@ struct gas {
 	struct btd_device *device;
 	struct att_range gap;	/* GAP Primary service range */
 	struct att_range gatt;	/* GATT Primary service range */
-	struct att_range changed; /* Affected handle range */
 	GAttrib *attrib;
 	guint attioid;
 	guint changed_ind;
@@ -152,12 +151,6 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	olen = enc_confirmation(opdu, plen);
 	g_attrib_send(gas->attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
 
-	if (gas->changed.start == start && gas->changed.end == end)
-		return;
-
-	gas->changed.start = start;
-	gas->changed.end = end;
-
 	btd_device_gatt_set_service_changed(gas->device, start, end);
 }
 
-- 
1.7.12

