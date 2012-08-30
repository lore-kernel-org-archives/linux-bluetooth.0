Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH] attrib: Check key size when verifying requirements
Date: Thu, 30 Aug 2012 15:35:08 +0300
Message-ID: <1346330108-13984-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

The attrib server should return an error in case the channel is
encrypted but the key size is not sufficient. For now, simply check that
the key size is at least 7, which is the minimal allowed key size.
---
 attrib/gattrib.c    |   12 ++++++++++++
 attrib/gattrib.h    |    1 +
 src/attrib-server.c |    3 +++
 3 files changed, 16 insertions(+)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 108d1d3..59bad6f 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -678,6 +678,18 @@ gboolean g_attrib_is_encrypted(GAttrib *attrib)
 	return sec_level > BT_IO_SEC_LOW;
 }
 
+gboolean g_attrib_is_keysize_sufficient(GAttrib *attrib)
+{
+	uint8_t key_size;
+
+	if (!bt_io_get(attrib->io, NULL,
+			BT_IO_OPT_KEY_SIZE, &key_size,
+			BT_IO_OPT_INVALID))
+		return FALSE;
+
+	return key_size >= 7;
+}
+
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 {
 	struct event *evt;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index bcff039..1935921 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -65,6 +65,7 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode,
 					GDestroyNotify notify);
 
 gboolean g_attrib_is_encrypted(GAttrib *attrib);
+gboolean g_attrib_is_keysize_sufficient(GAttrib *attrib);
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len);
 gboolean g_attrib_set_mtu(GAttrib *attrib, int mtu);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5cb1383..cf40ac8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -376,6 +376,9 @@ static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 		channel->encrypted = g_attrib_is_encrypted(channel->attrib);
 	if (reqs == ATT_AUTHENTICATION && !channel->encrypted)
 		return ATT_ECODE_AUTHENTICATION;
+	else if (reqs == ATT_AUTHENTICATION &&
+		 !g_attrib_is_keysize_sufficient(channel->attrib))
+		return ATT_ECODE_INSUFF_ENCR_KEY_SIZE;
 	else if (reqs == ATT_AUTHORIZATION)
 		return ATT_ECODE_AUTHORIZATION;
 
-- 
1.7.9.5

