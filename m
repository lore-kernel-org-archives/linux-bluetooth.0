Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Extend Characteristic Write to support Write Without Response
Date: Wed,  9 Mar 2011 16:03:50 -0300
Message-Id: <1299697431-7670-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If callback is not informed, Write Command will be used to execute
a Write Without Response sub-procedure. Error is not returned by the
server no matter the result of the operation.
---
 attrib/gatt.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index ae482f1..2b0d827 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -502,8 +502,12 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 	guint16 plen;
 
-	plen = enc_write_req(handle, value, vlen, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, 0, ATT_OP_WRITE_REQ, pdu, plen, func,
+	if (func)
+		plen = enc_write_req(handle, value, vlen, pdu, sizeof(pdu));
+	else
+		plen = enc_write_cmd(handle, value, vlen, pdu, sizeof(pdu));
+
+	return g_attrib_send(attrib, 0, pdu[0], pdu, plen, func,
 							user_data, NULL);
 }
 
-- 
1.7.4.1

