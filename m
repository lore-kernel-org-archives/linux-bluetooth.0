Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCHv2 4/5] Add Exchange MTU operation in GATT library
Date: Thu, 17 Mar 2011 10:55:19 -0400
Message-Id: <1300373720-14772-4-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
References: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/gatt.c |   13 +++++++++++++
 attrib/gatt.h |    3 +++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 28654af..0b69daf 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -534,6 +534,19 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 							user_data, NULL);
 }
 
+guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
+							gpointer user_data)
+{
+	uint8_t *buf;
+	int buflen;
+	guint16 plen;
+
+	buf = g_attrib_get_buffer(attrib, &buflen);
+	plen = enc_mtu_req(mtu, buf, buflen);
+	return g_attrib_send(attrib, 0, ATT_OP_MTU_REQ, buf, plen, func,
+							user_data, NULL);
+}
+
 guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
diff --git a/attrib/gatt.h b/attrib/gatt.h
index c6d3843..221d94d 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -48,3 +48,6 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 				bt_uuid_t *uuid, GAttribResultFunc func,
 				gpointer user_data);
+
+guint gatt_exchange_mtu(GAttrib *attrib, uint16_t mtu, GAttribResultFunc func,
+							gpointer user_data);
-- 
1.7.0.4

