Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=2.228.72.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562504;
	b=w6qUoTo1SeTE4MWtpE6fTGzbFJtGr2aSvL0XpZ5Ehrj0KLJqgaRMPZWCFNi6dE6MWy+o
	 lr+6Z/G2wQpmavliLm7J/c1+BbMQmhD0DuhEovytnLziBj1TQlDlkpCXgMTdO2JueJ6aZ
	 n9VCn4jlKSYNoLnAUt1cf5IWBMJxC367rEyb6UUT9DHd63QVQlbrf2CQ6dnwQ7Y2nBCJI
	 aAItMQYEnbizL7qEHYTt/94dk3Ixywt6njHDII9vflH1r6icxNVOLZDAGOZ3Lq+2X831d
	 Ytz5Cj4OTbclyGUBOYqPo7QdgUr42ASmG4HP1Q7A1FqVs+tR5XEQTBJJ1TmAO2PFf/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562504;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yVi6AlvWSXHZWmmojzLvai7s2DBK3gysh9PI7nvwecY=;
	b=djlnHw6f+03Cfmm0VWrcbnG+gGqCbyVXJ0iLoe/qm1SD/qP6XaZo6WuH9asgF6S4U8dJ
	 PC1l78mXBOOFHhWuVLUHAWOO/tsletTd3wn6fBE3pYEowPS3OvSZcsVg7l94RtpjhdKJM
	 KcC7uJuaw5gapeJHL9f7kuBdEbclaSkSDaShnvRQyTinbbSu907EcnR3J0ltYpuKWtsB/
	 Ar4OLBojROTZvpS+JzojRV6A105Ho8pg4FCjA27uyosSCVO80pLZZyHa74Vc7sYUsrlTk
	 sr40sSf0SpaozIivmbYZXFFmO8FcaL3DLXIt5js5wONx1WFWzSsTH4GLZcZVz1yPT/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewiz.org;
	spf=pass smtp.mailfrom=codewiz.org;
	dkim=pass header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=HBgPJoY3;
	arc=none smtp.remote-ip=2.228.72.60
Received: from morpheus.develer.net (morpheus.develer.net [2.228.72.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE6606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23BE6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewiz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=HBgPJoY3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codewiz.org; s=mail;
	t=1794562501; bh=IVBoSRQnNVFZ2A4xNmVrTy/Rj2ptVRcnVKMaGHTik3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBgPJoY3xO9ZUd9To4IdWPbvGqgYLK1pfTrvNQRI4kxIVIRgIYtaHXFDY6qlBOg72
	 A0Vlc064FdPcfLMXVQcQl2gU0/N2R4eNeDxTC73xr6XB2QBx/FHnP9t7ZbsL2I/GER
	 MBxzgWvfrv5M7pIBQ0Coo43iIVxRSXn6SfNCdsMc=
Received: from giskard.lan (unknown [IPv6:2404:7a80:ff26:6c00:fb7a:abd8:86ed:512c])
	(Authenticated sender: bernie)
	by morpheus.develer.net (Postfix) with ESMTPSA id 5ED6C247D7F;
	Fri, 13 Nov 2026 10:35:00 +0100 (CET)
From: Bernie Innocenti <bernie@codewiz.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bernie Innocenti <bernie@codewiz.org>
Subject: [PATCH BlueZ 1/2] cups: Read the IEEE 1284 device ID over SDP
Date: Fri, 13 Nov 2026 18:34:27 +0900
Message-ID: <20261113093428.2971436-2-bernie@codewiz.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113093428.2971436-1-bernie@codewiz.org>
References: <20261113093428.2971436-1-bernie@codewiz.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device1 has no DiscoverServices method, so the device ID was never
found. Read the 1284ID attribute of the HCRP record directly, as the
print path already does for the channel and PSMs.

Assisted-by: Claude:claude-fable-5
---
 profiles/cups/cups.h |   1 +
 profiles/cups/main.c | 217 ++++---------------------------------------
 profiles/cups/sdp.c  |  48 ++++++++++
 3 files changed, 65 insertions(+), 201 deletions(-)

diff --git a/profiles/cups/cups.h b/profiles/cups/cups.h
index bdaa89498..f2ec8aec7 100644
--- a/profiles/cups/cups.h
+++ b/profiles/cups/cups.h
@@ -20,6 +20,7 @@ enum {					/**** Backend exit codes ****/
 
 int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
 int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm);
+char *sdp_search_ieee1284_id(sdp_session_t *sdp);
 
 int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int copies, const char *cups_class);
 int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, unsigned short data_psm, int fd, int copies, const char *cups_class);
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index d56c942b9..bcd6d2f9f 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -44,136 +44,21 @@ static GMainLoop *loop = NULL;
 static DBusConnection *conn = NULL;
 static gboolean doing_disco = FALSE;
 
-#define ATTRID_1284ID 0x0300
-
-struct context_data {
-	gboolean found;
-	char *id;
-};
-
-static void element_start(GMarkupParseContext *context,
-				const char *element_name,
-				const char **attribute_names,
-				const char **attribute_values,
-				gpointer user_data, GError **err)
+static char *device_get_ieee1284_id(const char *address)
 {
-	struct context_data *ctx_data = user_data;
-
-	if (!strcmp(element_name, "record"))
-		return;
-
-	if (!strcmp(element_name, "attribute")) {
-		int i;
-		for (i = 0; attribute_names[i]; i++) {
-			if (strcmp(attribute_names[i], "id") != 0)
-				continue;
-			if (strtol(attribute_values[i], 0, 0) == ATTRID_1284ID)
-				ctx_data->found = TRUE;
-			break;
-		}
-		return;
-	}
-
-	if (ctx_data->found  && !strcmp(element_name, "text")) {
-		int i;
-		for (i = 0; attribute_names[i]; i++) {
-			if (!strcmp(attribute_names[i], "value")) {
-				ctx_data->id = g_strdup(attribute_values[i] + 2);
-				ctx_data->found = FALSE;
-			}
-		}
-	}
-}
-
-static GMarkupParser parser = {
-	element_start, NULL, NULL, NULL, NULL
-};
-
-static char *sdp_xml_parse_record(const char *data)
-{
-	GMarkupParseContext *ctx;
-	struct context_data ctx_data;
-	int size;
-
-	size = strlen(data);
-	ctx_data.found = FALSE;
-	ctx_data.id = NULL;
-	ctx = g_markup_parse_context_new(&parser, 0, &ctx_data, NULL);
-
-	if (g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) {
-		g_markup_parse_context_free(ctx);
-		g_free(ctx_data.id);
-		return NULL;
-	}
-
-	g_markup_parse_context_free(ctx);
-
-	return ctx_data.id;
-}
-
-static char *device_get_ieee1284_id(const char *adapter, const char *device)
-{
-	DBusMessage *message, *reply;
-	DBusMessageIter iter, reply_iter;
-	DBusMessageIter reply_iter_entry;
-	const char *hcr_print = "00001126-0000-1000-8000-00805f9b34fb";
-	const char *xml;
-	char *id = NULL;
-
-	/* Look for the service handle of the HCRP service */
-	message = dbus_message_new_method_call("org.bluez", device,
-						"org.bluez.Device1",
-						"DiscoverServices");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &hcr_print);
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
+	sdp_session_t *sdp;
+	bdaddr_t bdaddr;
+	char *id;
 
-	dbus_message_unref(message);
+	str2ba(address, &bdaddr);
 
-	if (!reply)
+	sdp = sdp_connect(BDADDR_ANY, &bdaddr, SDP_RETRY_IF_BUSY);
+	if (!sdp)
 		return NULL;
 
-	dbus_message_iter_init(reply, &reply_iter);
-
-	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
-		dbus_message_unref(reply);
-		return NULL;
-	}
+	id = sdp_search_ieee1284_id(sdp);
 
-	dbus_message_iter_recurse(&reply_iter, &reply_iter_entry);
-
-	/* Hopefully we only get one handle, or take a punt */
-	while (dbus_message_iter_get_arg_type(&reply_iter_entry) ==
-							DBUS_TYPE_DICT_ENTRY) {
-		guint32 key;
-		DBusMessageIter dict_entry;
-
-		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
-
-		/* Key ? */
-		dbus_message_iter_get_basic(&dict_entry, &key);
-		if (!key) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-
-		/* Try to get the value */
-		if (!dbus_message_iter_next(&dict_entry)) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-
-		dbus_message_iter_get_basic(&dict_entry, &xml);
-
-		id = sdp_xml_parse_record(xml);
-		if (id != NULL)
-			break;
-		dbus_message_iter_next(&reply_iter_entry);
-	}
-
-	dbus_message_unref(reply);
+	sdp_close(sdp);
 
 	return id;
 }
@@ -362,9 +247,9 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 		return;
 	}
 
-	id = device_get_ieee1284_id(adapter, object_path);
+	id = device_get_ieee1284_id(bdaddr);
 	add_device_to_list(name, bdaddr, id);
-	g_free(id);
+	free(id);
 
 	dbus_message_unref(reply);
 }
@@ -434,9 +319,9 @@ static gboolean list_known_printers(const char *adapter)
 		if (device_is_printer(adapter, object_path, &name, &bdaddr)) {
 			char *id;
 
-			id = device_get_ieee1284_id(adapter, object_path);
+			id = device_get_ieee1284_id(bdaddr);
 			add_device_to_list(name, bdaddr, id);
-			g_free(id);
+			free(id);
 		}
 		g_free(name);
 		g_free(bdaddr);
@@ -601,84 +486,14 @@ static gboolean list_printers(void)
 
 static gboolean print_ieee1284(const char *bdaddr)
 {
-	DBusMessage *message, *reply, *adapter_reply;
-	DBusMessageIter iter;
-	char *object_path = NULL;
-	char *adapter;
 	char *id;
 
-	adapter_reply = NULL;
-
-	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-	if (conn == NULL)
+	id = device_get_ieee1284_id(bdaddr);
+	if (id == NULL)
 		return FALSE;
 
-	message = dbus_message_new_method_call("org.bluez", "/",
-			"org.bluez.Manager",
-			"DefaultAdapter");
-
-	adapter_reply = dbus_connection_send_with_reply_and_block(conn,
-			message, -1, NULL);
-
-	dbus_message_unref(message);
-
-	if (!adapter_reply)
-		return FALSE;
-
-	if (dbus_message_get_args(adapter_reply, NULL,
-			DBUS_TYPE_OBJECT_PATH, &adapter,
-			DBUS_TYPE_INVALID) == FALSE) {
-		dbus_message_unref(adapter_reply);
-		return FALSE;
-	}
-
-	message = dbus_message_new_method_call("org.bluez", adapter,
-			"org.bluez.Adapter1",
-			"FindDevice");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
-
-	if (adapter_reply != NULL)
-		dbus_message_unref(adapter_reply);
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-			message, -1, NULL);
-
-	dbus_message_unref(message);
-
-	if (!reply) {
-		message = dbus_message_new_method_call("org.bluez", adapter,
-				"org.bluez.Adapter1",
-				"CreateDevice");
-		dbus_message_iter_init_append(message, &iter);
-		dbus_message_iter_append_basic(&iter,
-				DBUS_TYPE_STRING, &bdaddr);
-
-		reply = dbus_connection_send_with_reply_and_block(conn,
-				message, -1, NULL);
-
-		dbus_message_unref(message);
-
-		if (!reply)
-			return FALSE;
-	}
-
-	if (dbus_message_get_args(reply, NULL,
-					DBUS_TYPE_OBJECT_PATH, &object_path,
-					DBUS_TYPE_INVALID) == FALSE) {
-		dbus_message_unref(reply);
-		return FALSE;
-	}
-
-	id = device_get_ieee1284_id(adapter, object_path);
-	if (id == NULL) {
-		dbus_message_unref(reply);
-		return FALSE;
-	}
 	printf("%s", id);
-	g_free(id);
-
-	dbus_message_unref(reply);
+	free(id);
 
 	return TRUE;
 }
diff --git a/profiles/cups/sdp.c b/profiles/cups/sdp.c
index 5d83b8ea9..d34d732c1 100644
--- a/profiles/cups/sdp.c
+++ b/profiles/cups/sdp.c
@@ -15,6 +15,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
+#include <string.h>
 #include <signal.h>
 #include <sys/socket.h>
 
@@ -24,6 +25,8 @@
 
 #include "cups.h"
 
+#define ATTRID_1284ID 0x0300
+
 int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm)
 {
 	sdp_list_t *srch, *attrs, *rsp;
@@ -104,3 +107,48 @@ int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel)
 
 	return -1;
 }
+
+char *sdp_search_ieee1284_id(sdp_session_t *sdp)
+{
+	sdp_list_t *srch, *attrs, *rsp, *l;
+	uuid_t svclass;
+	uint16_t attr;
+	char *id = NULL;
+	int err;
+
+	if (!sdp)
+		return NULL;
+
+	sdp_uuid16_create(&svclass, HCR_PRINT_SVCLASS_ID);
+	srch = sdp_list_append(NULL, &svclass);
+
+	attr = ATTRID_1284ID;
+	attrs = sdp_list_append(NULL, &attr);
+
+	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL,
+								attrs, &rsp);
+	sdp_list_free(srch, NULL);
+	sdp_list_free(attrs, NULL);
+	if (err)
+		return NULL;
+
+	for (l = rsp; l; l = l->next) {
+		sdp_record_t *rec = l->data;
+		sdp_data_t *data = sdp_data_get(rec, ATTRID_1284ID);
+		int len;
+
+		/* The device ID is preceded by its two length bytes */
+		if (!id && data && SDP_IS_TEXT_STR(data->dtd)) {
+			len = data->unitSize - sizeof(uint8_t);
+
+			if (len > 2)
+				id = strndup(data->val.str + 2, len - 2);
+		}
+
+		sdp_record_free(rec);
+	}
+
+	sdp_list_free(rsp, NULL);
+
+	return id;
+}
-- 
2.56.1

