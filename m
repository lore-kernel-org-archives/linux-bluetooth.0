Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 19 Nov 2010 17:36:58 -0800
Subject: RE: [PATCH v2] Implement Characteristic Value Read using UUID in
 the gatttool
Message-ID: <35B17FE5076C7040809188FBE7913F98406D58BBF0@SC1EXMB-MBCL.global.atheros.com>
References: <1290173697-20097-1-git-send-email-sheldon.demario@openbossa.org>
In-Reply-To: <1290173697-20097-1-git-send-email-sheldon.demario@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Sheldon Demario
Sent: Friday, November 19, 2010 5:35 AM
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario
Subject: [PATCH v2] Implement Characteristic Value Read using UUID in the gatttool

Sub-procedure used to read a Characteristic Value when the client
only knows the characteristic UUID and doesn't know the handle.
More than one handle and attribute value pair can be returned,
it is up to the user define the handles range based on the service
handles range.

Usage example:
$gatttool --char-read --uuid=2a00 -i hcix -b xx:xx:xx:xx:xx:xx
---
 attrib/gatt.c     |   15 ++++++++++++---
 attrib/gatt.h     |    4 ++++
 attrib/gatttool.c |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 2c87daf..bca8b49 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -74,13 +74,22 @@ guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 				GAttribResultFunc func, gpointer user_data)
 {
-	uint8_t pdu[ATT_DEFAULT_MTU];
 	uuid_t uuid;
-	guint16 plen;
 
 	sdp_uuid16_create(&uuid, GATT_CHARAC_UUID);
 
-	plen = enc_read_by_type_req(start, end, &uuid, pdu, sizeof(pdu));
+	return gatt_read_char_by_uuid(attrib, start, end, &uuid, func,
+							user_data);
+}
+
+guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
+					uuid_t *uuid, GAttribResultFunc func,
+					gpointer user_data)
+{
+	uint8_t pdu[ATT_DEFAULT_MTU];
+	guint16 plen;
+
+	plen = enc_read_by_type_req(start, end, uuid, pdu, sizeof(pdu));
 	if (plen == 0)
 		return 0;
 
diff --git a/attrib/gatt.h b/attrib/gatt.h
index 4e7d88b..1e1e628 100644
--- a/attrib/gatt.h
+++ b/attrib/gatt.h
@@ -41,3 +41,7 @@ guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 
 guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 				GDestroyNotify notify, gpointer user_data);
+
+guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
+				uuid_t *uuid, GAttribResultFunc func,
+				gpointer user_data);
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index e961431..d0ef6d3 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -398,10 +398,49 @@ done:
 		g_main_loop_quit(event_loop);
 }
 
+static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	struct att_data_list *list;
+	int i;
+
+	if (status != 0) {
+		g_printerr("Read characteristics by UUID failed: %s\n",
+							att_ecode2str(status));
+		goto done;
+	}
+
+	list = dec_read_by_type_resp(pdu, plen);
+	if (list == NULL)
+		goto done;
+
+	for (i = 0; i < list->num; i++) {
+		uint8_t *value = list->data[i];
+		int j;
+
+		g_print("handle: 0x%04x \t value: ", att_get_u16(value));
+		value += 2;
+		for (j = 0; j < list->len - 2; j++, value++)
+			g_print("%02x ", *value);
+		g_print("\n");
+	}
+
+	att_data_list_free(list);
+
+done:
+	g_main_loop_quit(event_loop);
+}
+
[MTsai] in your call back function here, you assume that "read_by_type_request" operation has completed. In the case of example with uuid=0x2a00 (device name), this is probably true. However, if there are multiple characteristics with same UUID within the database, then server probably has not sent all the characteristic value back yet, shall you check to see if the reading is really completed (comparing the handle), otherwise, issue another read_by_type_request with starting handle = attribute handle+1?

 static gboolean characteristics_read(gpointer user_data)
 {
 	GAttrib *attrib = user_data;
 
+	if (opt_uuid != NULL) {
+		gatt_read_char_by_uuid(attrib, opt_start, opt_end, opt_uuid,
+						char_read_by_uuid_cb, attrib);
+		return FALSE;
+	}
+
 	if (opt_handle <= 0) {
 		g_printerr("A valid handle is required\n");
 		g_main_loop_quit(event_loop);
-- 
1.7.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
