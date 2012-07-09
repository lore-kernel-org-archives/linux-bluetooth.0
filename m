Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 12/14] cups: move it to profiles folder
Date: Mon,  9 Jul 2012 18:10:34 -0300
Message-Id: <1341868236-9704-12-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341868236-9704-1-git-send-email-gustavo@padovan.org>
References: <1341868236-9704-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.tools       |   12 +-
 cups/cups.h          |   38 ---
 cups/hcrp.c          |  368 ---------------------
 cups/main.c          |  896 --------------------------------------------------
 cups/sdp.c           |  119 -------
 cups/spp.c           |  118 -------
 profiles/cups/cups.h |   38 +++
 profiles/cups/hcrp.c |  368 +++++++++++++++++++++
 profiles/cups/main.c |  896 ++++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/cups/sdp.c  |  119 +++++++
 profiles/cups/spp.c  |  118 +++++++
 11 files changed, 1547 insertions(+), 1543 deletions(-)
 delete mode 100644 cups/cups.h
 delete mode 100644 cups/hcrp.c
 delete mode 100644 cups/main.c
 delete mode 100644 cups/sdp.c
 delete mode 100644 cups/spp.c
 create mode 100644 profiles/cups/cups.h
 create mode 100644 profiles/cups/hcrp.c
 create mode 100644 profiles/cups/main.c
 create mode 100644 profiles/cups/sdp.c
 create mode 100644 profiles/cups/spp.c

diff --git a/Makefile.tools b/Makefile.tools
index 56839b7..fccac2d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -148,12 +148,16 @@ EXTRA_DIST += tools/dfubabel.1 tools/avctrl.8
 if CUPS
 cupsdir = $(libdir)/cups/backend
 
-cups_PROGRAMS = cups/bluetooth
+cups_PROGRAMS = profiles/cups/bluetooth
 
-cups_bluetooth_SOURCES = $(gdbus_sources) cups/main.c cups/cups.h \
-					cups/sdp.c cups/spp.c cups/hcrp.c
+profiles_cups_bluetooth_SOURCES = $(gdbus_sources) profiles/cups/main.c \
+					profiles/cups/cups.h \
+					profiles/cups/sdp.c \
+					profiles/cups/spp.c \
+					profiles/cups/hcrp.c
 
-cups_bluetooth_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ lib/libbluetooth-private.la
+profiles_cups_bluetooth_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ \
+				lib/libbluetooth-private.la
 endif
 
 
diff --git a/cups/cups.h b/cups/cups.h
deleted file mode 100644
index f4e0c01..0000000
--- a/cups/cups.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-enum {					/**** Backend exit codes ****/
-	CUPS_BACKEND_OK = 0,		/* Job completed successfully */
-	CUPS_BACKEND_FAILED = 1,	/* Job failed, use error-policy */
-	CUPS_BACKEND_AUTH_REQUIRED = 2,	/* Job failed, authentication required */
-	CUPS_BACKEND_HOLD = 3,		/* Job failed, hold job */
-	CUPS_BACKEND_STOP = 4,		/* Job failed, stop queue */
-	CUPS_BACKEND_CANCEL = 5,	/* Job failed, cancel job */
-	CUPS_BACKEND_RETRY = 6,		/* Failure requires us to retry (BlueZ specific) */
-};
-
-int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
-int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm);
-
-int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int copies, const char *cups_class);
-int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, unsigned short data_psm, int fd, int copies, const char *cups_class);
diff --git a/cups/hcrp.c b/cups/hcrp.c
deleted file mode 100644
index a93dda0..0000000
--- a/cups/hcrp.c
+++ /dev/null
@@ -1,368 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/l2cap.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <netinet/in.h>
-
-#include "cups.h"
-
-#define HCRP_PDU_CREDIT_GRANT		0x0001
-#define HCRP_PDU_CREDIT_REQUEST		0x0002
-#define HCRP_PDU_GET_LPT_STATUS		0x0005
-
-#define HCRP_STATUS_FEATURE_UNSUPPORTED	0x0000
-#define HCRP_STATUS_SUCCESS		0x0001
-#define HCRP_STATUS_CREDIT_SYNC_ERROR	0x0002
-#define HCRP_STATUS_GENERIC_FAILURE	0xffff
-
-struct hcrp_pdu_hdr {
-	uint16_t pid;
-	uint16_t tid;
-	uint16_t plen;
-} __attribute__ ((packed));
-#define HCRP_PDU_HDR_SIZE 6
-
-struct hcrp_credit_grant_cp {
-	uint32_t credit;
-} __attribute__ ((packed));
-#define HCRP_CREDIT_GRANT_CP_SIZE 4
-
-struct hcrp_credit_grant_rp {
-	uint16_t status;
-} __attribute__ ((packed));
-#define HCRP_CREDIT_GRANT_RP_SIZE 2
-
-struct hcrp_credit_request_rp {
-	uint16_t status;
-	uint32_t credit;
-} __attribute__ ((packed));
-#define HCRP_CREDIT_REQUEST_RP_SIZE 6
-
-struct hcrp_get_lpt_status_rp {
-	uint16_t status;
-	uint8_t  lpt_status;
-} __attribute__ ((packed));
-#define HCRP_GET_LPT_STATUS_RP_SIZE 3
-
-static int hcrp_credit_grant(int sk, uint16_t tid, uint32_t credit)
-{
-	struct hcrp_pdu_hdr hdr;
-	struct hcrp_credit_grant_cp cp;
-	struct hcrp_credit_grant_rp rp;
-	unsigned char buf[128];
-	int len;
-
-	hdr.pid = htons(HCRP_PDU_CREDIT_GRANT);
-	hdr.tid = htons(tid);
-	hdr.plen = htons(HCRP_CREDIT_GRANT_CP_SIZE);
-	cp.credit = credit;
-	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
-	memcpy(buf + HCRP_PDU_HDR_SIZE, &cp, HCRP_CREDIT_GRANT_CP_SIZE);
-	len = write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_GRANT_CP_SIZE);
-	if (len < 0)
-		return len;
-
-	len = read(sk, buf, sizeof(buf));
-	if (len < 0)
-		return len;
-
-	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
-	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_GRANT_RP_SIZE);
-
-	if (ntohs(rp.status) != HCRP_STATUS_SUCCESS) {
-		errno = EIO;
-		return -1;
-	}
-
-	return 0;
-}
-
-static int hcrp_credit_request(int sk, uint16_t tid, uint32_t *credit)
-{
-	struct hcrp_pdu_hdr hdr;
-	struct hcrp_credit_request_rp rp;
-	unsigned char buf[128];
-	int len;
-
-	hdr.pid = htons(HCRP_PDU_CREDIT_REQUEST);
-	hdr.tid = htons(tid);
-	hdr.plen = htons(0);
-	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
-	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
-	if (len < 0)
-		return len;
-
-	len = read(sk, buf, sizeof(buf));
-	if (len < 0)
-		return len;
-
-	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
-	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_REQUEST_RP_SIZE);
-
-	if (ntohs(rp.status) != HCRP_STATUS_SUCCESS) {
-		errno = EIO;
-		return -1;
-	}
-
-	if (credit)
-		*credit = ntohl(rp.credit);
-
-	return 0;
-}
-
-static int hcrp_get_lpt_status(int sk, uint16_t tid, uint8_t *lpt_status)
-{
-	struct hcrp_pdu_hdr hdr;
-	struct hcrp_get_lpt_status_rp rp;
-	unsigned char buf[128];
-	int len;
-
-	hdr.pid = htons(HCRP_PDU_GET_LPT_STATUS);
-	hdr.tid = htons(tid);
-	hdr.plen = htons(0);
-	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
-	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
-	if (len < 0)
-		return len;
-
-	len = read(sk, buf, sizeof(buf));
-	if (len < 0)
-		return len;
-
-	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
-	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_GET_LPT_STATUS_RP_SIZE);
-
-	if (ntohs(rp.status) != HCRP_STATUS_SUCCESS) {
-		errno = EIO;
-		return -1;
-	}
-
-	if (lpt_status)
-		*lpt_status = rp.lpt_status;
-
-	return 0;
-}
-
-static inline int hcrp_get_next_tid(int tid)
-{
-	if (tid > 0xf000)
-		return 0;
-	else
-		return tid + 1;
-}
-
-int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, unsigned short data_psm, int fd, int copies, const char *cups_class)
-{
-	struct sockaddr_l2 addr;
-	struct l2cap_options opts;
-	socklen_t size;
-	unsigned char buf[2048];
-	int i, ctrl_sk, data_sk, count, len, timeout = 0;
-	unsigned int mtu;
-	uint8_t status;
-	uint16_t tid = 0;
-	uint32_t tmp, credit = 0;
-
-	if ((ctrl_sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) {
-		perror("ERROR: Can't create socket");
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.l2_family = AF_BLUETOOTH;
-	bacpy(&addr.l2_bdaddr, src);
-
-	if (bind(ctrl_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("ERROR: Can't bind socket");
-		close(ctrl_sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.l2_family = AF_BLUETOOTH;
-	bacpy(&addr.l2_bdaddr, dst);
-	addr.l2_psm = htobs(ctrl_psm);
-
-	if (connect(ctrl_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("ERROR: Can't connect to device");
-		close(ctrl_sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	if ((data_sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) {
-		perror("ERROR: Can't create socket");
-		close(ctrl_sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.l2_family = AF_BLUETOOTH;
-	bacpy(&addr.l2_bdaddr, src);
-
-	if (bind(data_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("ERROR: Can't bind socket");
-		close(data_sk);
-		close(ctrl_sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.l2_family = AF_BLUETOOTH;
-	bacpy(&addr.l2_bdaddr, dst);
-	addr.l2_psm = htobs(data_psm);
-
-	if (connect(data_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("ERROR: Can't connect to device");
-		close(data_sk);
-		close(ctrl_sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	fputs("STATE: -connecting-to-device\n", stderr);
-
-	memset(&opts, 0, sizeof(opts));
-	size = sizeof(opts);
-
-	if (getsockopt(data_sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &size) < 0) {
-		perror("ERROR: Can't get socket options");
-		close(data_sk);
-		close(ctrl_sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	mtu = opts.omtu;
-
-	/* Ignore SIGTERM signals if printing from stdin */
-	if (fd == 0) {
-#ifdef HAVE_SIGSET
-		sigset(SIGTERM, SIG_IGN);
-#elif defined(HAVE_SIGACTION)
-		memset(&action, 0, sizeof(action));
-		sigemptyset(&action.sa_mask);
-		action.sa_handler = SIG_IGN;
-		sigaction(SIGTERM, &action, NULL);
-#else
-		signal(SIGTERM, SIG_IGN);
-#endif /* HAVE_SIGSET */
-	}
-
-	tid = hcrp_get_next_tid(tid);
-	if (hcrp_credit_grant(ctrl_sk, tid, 0) < 0) {
-		fprintf(stderr, "ERROR: Can't grant initial credits\n");
-		close(data_sk);
-		close(ctrl_sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	for (i = 0; i < copies; i++) {
-
-		if (fd != 0) {
-			fprintf(stderr, "PAGE: 1 1\n");
-			lseek(fd, 0, SEEK_SET);
-		}
-
-		while (1) {
-			if (credit < mtu) {
-				tid = hcrp_get_next_tid(tid);
-				if (!hcrp_credit_request(ctrl_sk, tid, &tmp)) {
-					credit += tmp;
-					timeout = 0;
-				}
-			}
-
-			if (!credit) {
-				if (timeout++ > 300) {
-					tid = hcrp_get_next_tid(tid);
-					if (!hcrp_get_lpt_status(ctrl_sk, tid, &status))
-						fprintf(stderr, "ERROR: LPT status 0x%02x\n", status);
-					break;
-				}
-
-				sleep(1);
-				continue;
-			}
-
-			count = read(fd, buf, (credit > mtu) ? mtu : credit);
-			if (count <= 0)
-				break;
-
-			len = write(data_sk, buf, count);
-			if (len < 0) {
-				perror("ERROR: Error writing to device");
-				close(data_sk);
-				close(ctrl_sk);
-				return CUPS_BACKEND_FAILED;
-			}
-
-			if (len != count)
-				fprintf(stderr, "ERROR: Can't send complete data\n");
-
-			credit -= len;
-		}
-
-	}
-
-	close(data_sk);
-	close(ctrl_sk);
-
-	return CUPS_BACKEND_OK;
-}
diff --git a/cups/main.c b/cups/main.c
deleted file mode 100644
index a884c6e..0000000
--- a/cups/main.c
+++ /dev/null
@@ -1,896 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/socket.h>
-#include <glib.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <gdbus.h>
-
-#include "cups.h"
-
-struct cups_device {
-	char *bdaddr;
-	char *name;
-	char *id;
-};
-
-static GSList *device_list = NULL;
-static GMainLoop *loop = NULL;
-static DBusConnection *conn = NULL;
-static gboolean doing_disco = FALSE;
-
-#define ATTRID_1284ID 0x0300
-
-struct context_data {
-	gboolean found;
-	char *id;
-};
-
-static void element_start(GMarkupParseContext *context,
-				const gchar *element_name,
-				const gchar **attribute_names,
-				const gchar **attribute_values,
-				gpointer user_data, GError **err)
-{
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
-						"org.bluez.Device",
-						"DiscoverServices");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &hcr_print);
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
-
-	dbus_message_unref(message);
-
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init(reply, &reply_iter);
-
-	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
-		dbus_message_unref(reply);
-		return NULL;
-	}
-
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
-
-	return id;
-}
-
-static void print_printer_details(const char *name, const char *bdaddr,
-								const char *id)
-{
-	char *uri, *escaped;
-
-	escaped = g_strdelimit(g_strdup(name), "\"", '\'');
-	uri = g_strdup_printf("bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
-				bdaddr[0], bdaddr[1],
-				bdaddr[3], bdaddr[4],
-				bdaddr[6], bdaddr[7],
-				bdaddr[9], bdaddr[10],
-				bdaddr[12], bdaddr[13],
-				bdaddr[15], bdaddr[16]);
-	printf("direct %s \"%s\" \"%s (Bluetooth)\"", uri, escaped, escaped);
-	if (id != NULL)
-		printf(" \"%s\"\n", id);
-	else
-		printf("\n");
-	g_free(escaped);
-	g_free(uri);
-}
-
-static void add_device_to_list(const char *name, const char *bdaddr,
-								const char *id)
-{
-	struct cups_device *device;
-	GSList *l;
-
-	/* Look for the device in the list */
-	for (l = device_list; l != NULL; l = l->next) {
-		device = (struct cups_device *) l->data;
-
-		if (strcmp(device->bdaddr, bdaddr) == 0) {
-			if (device->name != name) {
-				g_free(device->name);
-				device->name = g_strdup(name);
-			}
-			g_free(device->id);
-			device->id = g_strdup(id);
-			return;
-		}
-	}
-
-	/* Or add it to the list if it's not there */
-	device = g_new0(struct cups_device, 1);
-	device->bdaddr = g_strdup(bdaddr);
-	device->name = g_strdup(name);
-	device->id = g_strdup(id);
-
-	device_list = g_slist_prepend(device_list, device);
-	print_printer_details(device->name, device->bdaddr, device->id);
-}
-
-static gboolean parse_device_properties(DBusMessageIter *reply_iter,
-						char **name, char **bdaddr)
-{
-	guint32 class = 0;
-	DBusMessageIter reply_iter_entry;
-
-	if (dbus_message_iter_get_arg_type(reply_iter) != DBUS_TYPE_ARRAY)
-		return FALSE;
-
-	dbus_message_iter_recurse(reply_iter, &reply_iter_entry);
-
-	while (dbus_message_iter_get_arg_type(&reply_iter_entry) ==
-							DBUS_TYPE_DICT_ENTRY) {
-		const char *key;
-		DBusMessageIter dict_entry, iter_dict_val;
-
-		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
-
-		/* Key == Class ? */
-		dbus_message_iter_get_basic(&dict_entry, &key);
-		if (!key) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-
-		if (strcmp(key, "Class") != 0 &&
-				strcmp(key, "Alias") != 0 &&
-				strcmp(key, "Address") != 0) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-
-		/* Try to get the value */
-		if (!dbus_message_iter_next(&dict_entry)) {
-			dbus_message_iter_next(&reply_iter_entry);
-			continue;
-		}
-		dbus_message_iter_recurse(&dict_entry, &iter_dict_val);
-		if (strcmp(key, "Class") == 0) {
-			dbus_message_iter_get_basic(&iter_dict_val, &class);
-		} else {
-			const char *value;
-			dbus_message_iter_get_basic(&iter_dict_val, &value);
-			if (strcmp(key, "Alias") == 0) {
-				*name = g_strdup(value);
-			} else if (bdaddr) {
-				*bdaddr = g_strdup(value);
-			}
-		}
-		dbus_message_iter_next(&reply_iter_entry);
-	}
-
-	if (class == 0)
-		return FALSE;
-	if (((class & 0x1f00) >> 8) == 0x06 && (class & 0x80))
-		return TRUE;
-
-	return FALSE;
-}
-
-static gboolean device_is_printer(const char *adapter, const char *device_path, char **name, char **bdaddr)
-{
-	DBusMessage *message, *reply;
-	DBusMessageIter reply_iter;
-	gboolean retval;
-
-	message = dbus_message_new_method_call("org.bluez", device_path,
-							"org.bluez.Device",
-							"GetProperties");
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
-
-	dbus_message_unref(message);
-
-	if (!reply)
-		return FALSE;
-
-	dbus_message_iter_init(reply, &reply_iter);
-
-	retval = parse_device_properties(&reply_iter, name, bdaddr);
-
-	dbus_message_unref(reply);
-
-	return retval;
-}
-
-static void remote_device_found(const char *adapter, const char *bdaddr,
-							const char *name)
-{
-	DBusMessage *message, *reply, *adapter_reply;
-	DBusMessageIter iter;
-	char *object_path = NULL;
-	char *id;
-
-	adapter_reply = NULL;
-
-	if (adapter == NULL) {
-		message = dbus_message_new_method_call("org.bluez", "/",
-							"org.bluez.Manager",
-							"DefaultAdapter");
-
-		adapter_reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
-
-		dbus_message_unref(message);
-
-		if (!adapter_reply)
-			return;
-
-		if (dbus_message_get_args(adapter_reply, NULL,
-					DBUS_TYPE_OBJECT_PATH, &adapter,
-					DBUS_TYPE_INVALID) == FALSE) {
-			dbus_message_unref(adapter_reply);
-			return;
-		}
-	}
-
-	message = dbus_message_new_method_call("org.bluez", adapter,
-							"org.bluez.Adapter",
-							"FindDevice");
-	dbus_message_iter_init_append(message, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
-
-	if (adapter_reply != NULL)
-		dbus_message_unref(adapter_reply);
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
-
-	dbus_message_unref(message);
-
-	if (!reply) {
-		message = dbus_message_new_method_call("org.bluez", adapter,
-							"org.bluez.Adapter",
-							"CreateDevice");
-		dbus_message_iter_init_append(message, &iter);
-		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
-
-		reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, NULL);
-
-		dbus_message_unref(message);
-
-		if (!reply)
-			return;
-	}
-
-	if (dbus_message_get_args(reply, NULL,
-					DBUS_TYPE_OBJECT_PATH, &object_path,
-					DBUS_TYPE_INVALID) == FALSE) {
-		dbus_message_unref(reply);
-		return;
-	}
-
-	id = device_get_ieee1284_id(adapter, object_path);
-	add_device_to_list(name, bdaddr, id);
-	g_free(id);
-
-	dbus_message_unref(reply);
-}
-
-static void discovery_completed(void)
-{
-	g_slist_free(device_list);
-	device_list = NULL;
-
-	g_main_loop_quit(loop);
-}
-
-static void remote_device_disappeared(const char *bdaddr)
-{
-	GSList *l;
-
-	for (l = device_list; l != NULL; l = l->next) {
-		struct cups_device *device = l->data;
-
-		if (strcmp(device->bdaddr, bdaddr) == 0) {
-			g_free(device->name);
-			g_free(device->bdaddr);
-			g_free(device);
-			device_list = g_slist_delete_link(device_list, l);
-			return;
-		}
-	}
-}
-
-static gboolean list_known_printers(const char *adapter)
-{
-	DBusMessageIter reply_iter, iter_array;
-	DBusError error;
-	DBusMessage *message, *reply;
-
-	message = dbus_message_new_method_call("org.bluez", adapter,
-						"org.bluez.Adapter",
-						"ListDevices");
-	if (message == NULL)
-		return FALSE;
-
-	dbus_error_init(&error);
-	reply = dbus_connection_send_with_reply_and_block(conn, message,
-								-1, &error);
-
-	dbus_message_unref(message);
-
-	if (dbus_error_is_set(&error))
-		return FALSE;
-
-	dbus_message_iter_init(reply, &reply_iter);
-	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
-		dbus_message_unref(reply);
-		return FALSE;
-	}
-
-	dbus_message_iter_recurse(&reply_iter, &iter_array);
-	while (dbus_message_iter_get_arg_type(&iter_array) ==
-						DBUS_TYPE_OBJECT_PATH) {
-		const char *object_path;
-		char *name = NULL;
-		char *bdaddr = NULL;
-
-		dbus_message_iter_get_basic(&iter_array, &object_path);
-		if (device_is_printer(adapter, object_path, &name, &bdaddr)) {
-			char *id;
-
-			id = device_get_ieee1284_id(adapter, object_path);
-			add_device_to_list(name, bdaddr, id);
-			g_free(id);
-		}
-		g_free(name);
-		g_free(bdaddr);
-		dbus_message_iter_next(&iter_array);
-	}
-
-	dbus_message_unref(reply);
-
-	return FALSE;
-}
-
-static DBusHandlerResult filter_func(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	if (dbus_message_is_signal(message, "org.bluez.Adapter",
-						"DeviceFound")) {
-		const char *adapter, *bdaddr;
-		char *name;
-		DBusMessageIter iter;
-
-		dbus_message_iter_init(message, &iter);
-		dbus_message_iter_get_basic(&iter, &bdaddr);
-		dbus_message_iter_next(&iter);
-
-		adapter = dbus_message_get_path(message);
-		if (parse_device_properties(&iter, &name, NULL))
-			remote_device_found(adapter, bdaddr, name);
-		g_free (name);
-	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
-						"DeviceDisappeared")) {
-		const char *bdaddr;
-
-		dbus_message_get_args(message, NULL,
-					DBUS_TYPE_STRING, &bdaddr,
-					DBUS_TYPE_INVALID);
-		remote_device_disappeared(bdaddr);
-	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
-						"PropertyChanged")) {
-		DBusMessageIter iter, value_iter;
-		const char *name;
-		gboolean discovering;
-
-		dbus_message_iter_init(message, &iter);
-		dbus_message_iter_get_basic(&iter, &name);
-		if (name == NULL || strcmp(name, "Discovering") != 0)
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-		dbus_message_iter_next(&iter);
-		dbus_message_iter_recurse(&iter, &value_iter);
-		dbus_message_iter_get_basic(&value_iter, &discovering);
-
-		if (discovering == FALSE && doing_disco) {
-			doing_disco = FALSE;
-			discovery_completed();
-		}
-	}
-
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-}
-
-static gboolean list_printers(void)
-{
-	/* 1. Connect to the bus
-	 * 2. Get the manager
-	 * 3. Get the default adapter
-	 * 4. Get a list of devices
-	 * 5. Get the class of each device
-	 * 6. Print the details from each printer device
-	 */
-	DBusError error;
-	dbus_bool_t hcid_exists;
-	DBusMessage *reply, *message;
-	DBusMessageIter reply_iter;
-	char *adapter, *match;
-
-	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-	if (conn == NULL)
-		return TRUE;
-
-	dbus_error_init(&error);
-	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
-	if (dbus_error_is_set(&error))
-		return TRUE;
-
-	if (!hcid_exists)
-		return TRUE;
-
-	/* Get the default adapter */
-	message = dbus_message_new_method_call("org.bluez", "/",
-						"org.bluez.Manager",
-						"DefaultAdapter");
-	if (message == NULL) {
-		dbus_connection_unref(conn);
-		return FALSE;
-	}
-
-	reply = dbus_connection_send_with_reply_and_block(conn,
-							message, -1, &error);
-
-	dbus_message_unref(message);
-
-	if (dbus_error_is_set(&error)) {
-		dbus_connection_unref(conn);
-		/* No adapter */
-		return TRUE;
-	}
-
-	dbus_message_iter_init(reply, &reply_iter);
-	if (dbus_message_iter_get_arg_type(&reply_iter) !=
-						DBUS_TYPE_OBJECT_PATH) {
-		dbus_message_unref(reply);
-		dbus_connection_unref(conn);
-		return FALSE;
-	}
-
-	dbus_message_iter_get_basic(&reply_iter, &adapter);
-	adapter = g_strdup(adapter);
-	dbus_message_unref(reply);
-
-	if (!dbus_connection_add_filter(conn, filter_func, adapter, g_free)) {
-		g_free(adapter);
-		dbus_connection_unref(conn);
-		return FALSE;
-	}
-
-#define MATCH_FORMAT				\
-	"type='signal',"			\
-	"interface='org.bluez.Adapter',"	\
-	"sender='org.bluez',"			\
-	"path='%s'"
-
-	match = g_strdup_printf(MATCH_FORMAT, adapter);
-	dbus_bus_add_match(conn, match, &error);
-	g_free(match);
-
-	/* Add the the recent devices */
-	list_known_printers(adapter);
-
-	doing_disco = TRUE;
-	message = dbus_message_new_method_call("org.bluez", adapter,
-					"org.bluez.Adapter",
-					"StartDiscovery");
-
-	if (!dbus_connection_send_with_reply(conn, message, NULL, -1)) {
-		dbus_message_unref(message);
-		dbus_connection_unref(conn);
-		g_free(adapter);
-		return FALSE;
-	}
-	dbus_message_unref(message);
-
-	loop = g_main_loop_new(NULL, TRUE);
-	g_main_loop_run(loop);
-
-	g_free(adapter);
-	dbus_connection_unref(conn);
-
-	return TRUE;
-}
-
-static gboolean print_ieee1284(const char *bdaddr)
-{
-	DBusMessage *message, *reply, *adapter_reply;
-	DBusMessageIter iter;
-	char *object_path = NULL;
-	char *adapter;
-	char *id;
-
-	adapter_reply = NULL;
-
-	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-	if (conn == NULL)
-		return FALSE;
-
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
-			"org.bluez.Adapter",
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
-				"org.bluez.Adapter",
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
-	printf("%s", id);
-	g_free(id);
-
-	dbus_message_unref(reply);
-
-	return TRUE;
-}
-
-/*
- *  Usage: printer-uri job-id user title copies options [file]
- *
- */
-
-int main(int argc, char *argv[])
-{
-	sdp_session_t *sdp;
-	bdaddr_t bdaddr;
-	unsigned short ctrl_psm, data_psm;
-	uint8_t channel, b[6];
-	char *ptr, str[3], device[18], service[12];
-	const char *uri, *cups_class;
-	int i, err, fd, copies, proto;
-
-	/* Make sure status messages are not buffered */
-	setbuf(stderr, NULL);
-
-	/* Make sure output is not buffered */
-	setbuf(stdout, NULL);
-
-	/* Ignore SIGPIPE signals */
-#ifdef HAVE_SIGSET
-	sigset(SIGPIPE, SIG_IGN);
-#elif defined(HAVE_SIGACTION)
-	memset(&action, 0, sizeof(action));
-	action.sa_handler = SIG_IGN;
-	sigaction(SIGPIPE, &action, NULL);
-#else
-	signal(SIGPIPE, SIG_IGN);
-#endif /* HAVE_SIGSET */
-
-	if (argc == 1) {
-		if (list_printers() == TRUE)
-			return CUPS_BACKEND_OK;
-		else
-			return CUPS_BACKEND_FAILED;
-	} else if (argc == 3 && strcmp(argv[1], "--get-deviceid") == 0) {
-		if (bachk(argv[2]) < 0) {
-			fprintf(stderr, "Invalid Bluetooth address '%s'\n",
-					argv[2]);
-			return CUPS_BACKEND_FAILED;
-		}
-		if (print_ieee1284(argv[2]) == FALSE)
-			return CUPS_BACKEND_FAILED;
-		return CUPS_BACKEND_OK;
-	}
-
-	if (argc < 6 || argc > 7) {
-		fprintf(stderr, "Usage: bluetooth job-id user title copies"
-				" options [file]\n");
-		fprintf(stderr, "       bluetooth --get-deviceid [bdaddr]\n");
-		return CUPS_BACKEND_FAILED;
-	}
-
-	if (argc == 6) {
-		fd = 0;
-		copies = 1;
-	} else {
-		if ((fd = open(argv[6], O_RDONLY)) < 0) {
-			perror("ERROR: Unable to open print file");
-			return CUPS_BACKEND_FAILED;
-		}
-		copies = atoi(argv[4]);
-	}
-
-	uri = getenv("DEVICE_URI");
-	if (!uri)
-		uri = argv[0];
-
-	if (strncasecmp(uri, "bluetooth://", 12)) {
-		fprintf(stderr, "ERROR: No device URI found\n");
-		return CUPS_BACKEND_FAILED;
-	}
-
-	ptr = argv[0] + 12;
-	for (i = 0; i < 6; i++) {
-		strncpy(str, ptr, 2);
-		b[i] = (uint8_t) strtol(str, NULL, 16);
-		ptr += 2;
-	}
-	sprintf(device, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-			b[0], b[1], b[2], b[3], b[4], b[5]);
-
-	str2ba(device, &bdaddr);
-
-	ptr = strchr(ptr, '/');
-	if (ptr) {
-		strncpy(service, ptr + 1, 12);
-
-		if (!strncasecmp(ptr + 1, "spp", 3))
-			proto = 1;
-		else if (!strncasecmp(ptr + 1, "hcrp", 4))
-			proto = 2;
-		else
-			proto = 0;
-	} else {
-		strcpy(service, "auto");
-		proto = 0;
-	}
-
-	cups_class = getenv("CLASS");
-
-	fprintf(stderr,
-		"DEBUG: %s device %s service %s fd %d copies %d class %s\n",
-			argv[0], device, service, fd, copies,
-			cups_class ? cups_class : "(none)");
-
-	fputs("STATE: +connecting-to-device\n", stderr);
-
-service_search:
-	sdp = sdp_connect(BDADDR_ANY, &bdaddr, SDP_RETRY_IF_BUSY);
-	if (!sdp) {
-		fprintf(stderr, "ERROR: Can't open Bluetooth connection\n");
-		return CUPS_BACKEND_FAILED;
-	}
-
-	switch (proto) {
-	case 1:
-		err = sdp_search_spp(sdp, &channel);
-		break;
-	case 2:
-		err = sdp_search_hcrp(sdp, &ctrl_psm, &data_psm);
-		break;
-	default:
-		proto = 2;
-		err = sdp_search_hcrp(sdp, &ctrl_psm, &data_psm);
-		if (err) {
-			proto = 1;
-			err = sdp_search_spp(sdp, &channel);
-		}
-		break;
-	}
-
-	sdp_close(sdp);
-
-	if (err) {
-		if (cups_class) {
-			fputs("INFO: Unable to contact printer, queuing on "
-					"next printer in class...\n", stderr);
-			sleep(5);
-			return CUPS_BACKEND_FAILED;
-		}
-		sleep(20);
-		fprintf(stderr, "ERROR: Can't get service information\n");
-		goto service_search;
-	}
-
-connect:
-	switch (proto) {
-	case 1:
-		err = spp_print(BDADDR_ANY, &bdaddr, channel,
-						fd, copies, cups_class);
-		break;
-	case 2:
-		err = hcrp_print(BDADDR_ANY, &bdaddr, ctrl_psm, data_psm,
-						fd, copies, cups_class);
-		break;
-	default:
-		err = CUPS_BACKEND_FAILED;
-		fprintf(stderr, "ERROR: Unsupported protocol\n");
-		break;
-	}
-
-	if (err == CUPS_BACKEND_FAILED && cups_class) {
-		fputs("INFO: Unable to contact printer, queuing on "
-					"next printer in class...\n", stderr);
-		sleep(5);
-		return CUPS_BACKEND_FAILED;
-	} else if (err == CUPS_BACKEND_RETRY) {
-		sleep(20);
-		goto connect;
-	}
-
-	if (fd != 0)
-		close(fd);
-
-	if (!err)
-		fprintf(stderr, "INFO: Ready to print\n");
-
-	return err;
-}
diff --git a/cups/sdp.c b/cups/sdp.c
deleted file mode 100644
index c7f17a4..0000000
--- a/cups/sdp.c
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <signal.h>
-#include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include "cups.h"
-
-int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm)
-{
-	sdp_list_t *srch, *attrs, *rsp;
-	uuid_t svclass;
-	uint16_t attr1, attr2;
-	int err;
-
-	if (!sdp)
-		return -1;
-
-	sdp_uuid16_create(&svclass, HCR_PRINT_SVCLASS_ID);
-	srch = sdp_list_append(NULL, &svclass);
-
-	attr1 = SDP_ATTR_PROTO_DESC_LIST;
-	attrs = sdp_list_append(NULL, &attr1);
-	attr2 = SDP_ATTR_ADD_PROTO_DESC_LIST;
-	attrs = sdp_list_append(attrs, &attr2);
-
-	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
-	if (err)
-		return -1;
-
-	for (; rsp; rsp = rsp->next) {
-		sdp_record_t *rec = (sdp_record_t *) rsp->data;
-		sdp_list_t *protos;
-
-		if (!sdp_get_access_protos(rec, &protos)) {
-			unsigned short psm = sdp_get_proto_port(protos, L2CAP_UUID);
-			if (psm > 0) {
-				*ctrl_psm = psm;
-			}
-		}
-
-		if (!sdp_get_add_access_protos(rec, &protos)) {
-			unsigned short psm = sdp_get_proto_port(protos, L2CAP_UUID);
-			if (psm > 0 && *ctrl_psm > 0) {
-				*data_psm = psm;
-				return 0;
-			}
-		}
-	}
-
-	return -1;
-}
-
-int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel)
-{
-	sdp_list_t *srch, *attrs, *rsp;
-	uuid_t svclass;
-	uint16_t attr;
-	int err;
-
-	if (!sdp)
-		return -1;
-
-	sdp_uuid16_create(&svclass, SERIAL_PORT_SVCLASS_ID);
-	srch = sdp_list_append(NULL, &svclass);
-
-	attr = SDP_ATTR_PROTO_DESC_LIST;
-	attrs = sdp_list_append(NULL, &attr);
-
-	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
-	if (err)
-		return -1;
-
-	for (; rsp; rsp = rsp->next) {
-		sdp_record_t *rec = (sdp_record_t *) rsp->data;
-		sdp_list_t *protos;
-
-		if (!sdp_get_access_protos(rec, &protos)) {
-			uint8_t ch = sdp_get_proto_port(protos, RFCOMM_UUID);
-			if (ch > 0) {
-				*channel = ch;
-				return 0;
-			}
-		}
-	}
-
-	return -1;
-}
diff --git a/cups/spp.c b/cups/spp.c
deleted file mode 100644
index d906ed2..0000000
--- a/cups/spp.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <signal.h>
-#include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include "cups.h"
-
-int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int copies, const char *cups_class)
-{
-	struct sockaddr_rc addr;
-	unsigned char buf[2048];
-	int i, sk, err, len;
-
-	if ((sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
-		perror("ERROR: Can't create socket");
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	addr.rc_family = AF_BLUETOOTH;
-	bacpy(&addr.rc_bdaddr, src);
-	addr.rc_channel = 0;
-
-	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("ERROR: Can't bind socket");
-		close(sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	addr.rc_family = AF_BLUETOOTH;
-	bacpy(&addr.rc_bdaddr, dst);
-	addr.rc_channel = channel;
-
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("ERROR: Can't connect to device");
-		close(sk);
-		if (cups_class)
-			return CUPS_BACKEND_FAILED;
-		else
-			return CUPS_BACKEND_RETRY;
-	}
-
-	fputs("STATE: -connecting-to-device\n", stderr);
-
-	/* Ignore SIGTERM signals if printing from stdin */
-	if (fd == 0) {
-#ifdef HAVE_SIGSET
-		sigset(SIGTERM, SIG_IGN);
-#elif defined(HAVE_SIGACTION)
-		memset(&action, 0, sizeof(action));
-		sigemptyset(&action.sa_mask);
-		action.sa_handler = SIG_IGN;
-		sigaction(SIGTERM, &action, NULL);
-#else
-		signal(SIGTERM, SIG_IGN);
-#endif /* HAVE_SIGSET */
-	}
-
-	for (i = 0; i < copies; i++) {
-
-		if (fd != 0) {
-			fprintf(stderr, "PAGE: 1 1\n");
-			lseek(fd, 0, SEEK_SET);
-		}
-
-		while ((len = read(fd, buf, sizeof(buf))) > 0) {
-			err = write(sk, buf, len);
-			if (err < 0) {
-				perror("ERROR: Error writing to device");
-				close(sk);
-				return CUPS_BACKEND_FAILED;
-			}
-		}
-
-	}
-
-	close(sk);
-
-	return CUPS_BACKEND_OK;
-}
diff --git a/profiles/cups/cups.h b/profiles/cups/cups.h
new file mode 100644
index 0000000..f4e0c01
--- /dev/null
+++ b/profiles/cups/cups.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+enum {					/**** Backend exit codes ****/
+	CUPS_BACKEND_OK = 0,		/* Job completed successfully */
+	CUPS_BACKEND_FAILED = 1,	/* Job failed, use error-policy */
+	CUPS_BACKEND_AUTH_REQUIRED = 2,	/* Job failed, authentication required */
+	CUPS_BACKEND_HOLD = 3,		/* Job failed, hold job */
+	CUPS_BACKEND_STOP = 4,		/* Job failed, stop queue */
+	CUPS_BACKEND_CANCEL = 5,	/* Job failed, cancel job */
+	CUPS_BACKEND_RETRY = 6,		/* Failure requires us to retry (BlueZ specific) */
+};
+
+int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
+int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm);
+
+int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int copies, const char *cups_class);
+int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, unsigned short data_psm, int fd, int copies, const char *cups_class);
diff --git a/profiles/cups/hcrp.c b/profiles/cups/hcrp.c
new file mode 100644
index 0000000..a93dda0
--- /dev/null
+++ b/profiles/cups/hcrp.c
@@ -0,0 +1,368 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/socket.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/l2cap.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include <netinet/in.h>
+
+#include "cups.h"
+
+#define HCRP_PDU_CREDIT_GRANT		0x0001
+#define HCRP_PDU_CREDIT_REQUEST		0x0002
+#define HCRP_PDU_GET_LPT_STATUS		0x0005
+
+#define HCRP_STATUS_FEATURE_UNSUPPORTED	0x0000
+#define HCRP_STATUS_SUCCESS		0x0001
+#define HCRP_STATUS_CREDIT_SYNC_ERROR	0x0002
+#define HCRP_STATUS_GENERIC_FAILURE	0xffff
+
+struct hcrp_pdu_hdr {
+	uint16_t pid;
+	uint16_t tid;
+	uint16_t plen;
+} __attribute__ ((packed));
+#define HCRP_PDU_HDR_SIZE 6
+
+struct hcrp_credit_grant_cp {
+	uint32_t credit;
+} __attribute__ ((packed));
+#define HCRP_CREDIT_GRANT_CP_SIZE 4
+
+struct hcrp_credit_grant_rp {
+	uint16_t status;
+} __attribute__ ((packed));
+#define HCRP_CREDIT_GRANT_RP_SIZE 2
+
+struct hcrp_credit_request_rp {
+	uint16_t status;
+	uint32_t credit;
+} __attribute__ ((packed));
+#define HCRP_CREDIT_REQUEST_RP_SIZE 6
+
+struct hcrp_get_lpt_status_rp {
+	uint16_t status;
+	uint8_t  lpt_status;
+} __attribute__ ((packed));
+#define HCRP_GET_LPT_STATUS_RP_SIZE 3
+
+static int hcrp_credit_grant(int sk, uint16_t tid, uint32_t credit)
+{
+	struct hcrp_pdu_hdr hdr;
+	struct hcrp_credit_grant_cp cp;
+	struct hcrp_credit_grant_rp rp;
+	unsigned char buf[128];
+	int len;
+
+	hdr.pid = htons(HCRP_PDU_CREDIT_GRANT);
+	hdr.tid = htons(tid);
+	hdr.plen = htons(HCRP_CREDIT_GRANT_CP_SIZE);
+	cp.credit = credit;
+	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
+	memcpy(buf + HCRP_PDU_HDR_SIZE, &cp, HCRP_CREDIT_GRANT_CP_SIZE);
+	len = write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_GRANT_CP_SIZE);
+	if (len < 0)
+		return len;
+
+	len = read(sk, buf, sizeof(buf));
+	if (len < 0)
+		return len;
+
+	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
+	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_GRANT_RP_SIZE);
+
+	if (ntohs(rp.status) != HCRP_STATUS_SUCCESS) {
+		errno = EIO;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int hcrp_credit_request(int sk, uint16_t tid, uint32_t *credit)
+{
+	struct hcrp_pdu_hdr hdr;
+	struct hcrp_credit_request_rp rp;
+	unsigned char buf[128];
+	int len;
+
+	hdr.pid = htons(HCRP_PDU_CREDIT_REQUEST);
+	hdr.tid = htons(tid);
+	hdr.plen = htons(0);
+	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
+	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
+	if (len < 0)
+		return len;
+
+	len = read(sk, buf, sizeof(buf));
+	if (len < 0)
+		return len;
+
+	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
+	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_REQUEST_RP_SIZE);
+
+	if (ntohs(rp.status) != HCRP_STATUS_SUCCESS) {
+		errno = EIO;
+		return -1;
+	}
+
+	if (credit)
+		*credit = ntohl(rp.credit);
+
+	return 0;
+}
+
+static int hcrp_get_lpt_status(int sk, uint16_t tid, uint8_t *lpt_status)
+{
+	struct hcrp_pdu_hdr hdr;
+	struct hcrp_get_lpt_status_rp rp;
+	unsigned char buf[128];
+	int len;
+
+	hdr.pid = htons(HCRP_PDU_GET_LPT_STATUS);
+	hdr.tid = htons(tid);
+	hdr.plen = htons(0);
+	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
+	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
+	if (len < 0)
+		return len;
+
+	len = read(sk, buf, sizeof(buf));
+	if (len < 0)
+		return len;
+
+	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
+	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_GET_LPT_STATUS_RP_SIZE);
+
+	if (ntohs(rp.status) != HCRP_STATUS_SUCCESS) {
+		errno = EIO;
+		return -1;
+	}
+
+	if (lpt_status)
+		*lpt_status = rp.lpt_status;
+
+	return 0;
+}
+
+static inline int hcrp_get_next_tid(int tid)
+{
+	if (tid > 0xf000)
+		return 0;
+	else
+		return tid + 1;
+}
+
+int hcrp_print(bdaddr_t *src, bdaddr_t *dst, unsigned short ctrl_psm, unsigned short data_psm, int fd, int copies, const char *cups_class)
+{
+	struct sockaddr_l2 addr;
+	struct l2cap_options opts;
+	socklen_t size;
+	unsigned char buf[2048];
+	int i, ctrl_sk, data_sk, count, len, timeout = 0;
+	unsigned int mtu;
+	uint8_t status;
+	uint16_t tid = 0;
+	uint32_t tmp, credit = 0;
+
+	if ((ctrl_sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) {
+		perror("ERROR: Can't create socket");
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family = AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, src);
+
+	if (bind(ctrl_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("ERROR: Can't bind socket");
+		close(ctrl_sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family = AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, dst);
+	addr.l2_psm = htobs(ctrl_psm);
+
+	if (connect(ctrl_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("ERROR: Can't connect to device");
+		close(ctrl_sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	if ((data_sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0) {
+		perror("ERROR: Can't create socket");
+		close(ctrl_sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family = AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, src);
+
+	if (bind(data_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("ERROR: Can't bind socket");
+		close(data_sk);
+		close(ctrl_sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.l2_family = AF_BLUETOOTH;
+	bacpy(&addr.l2_bdaddr, dst);
+	addr.l2_psm = htobs(data_psm);
+
+	if (connect(data_sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("ERROR: Can't connect to device");
+		close(data_sk);
+		close(ctrl_sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	fputs("STATE: -connecting-to-device\n", stderr);
+
+	memset(&opts, 0, sizeof(opts));
+	size = sizeof(opts);
+
+	if (getsockopt(data_sk, SOL_L2CAP, L2CAP_OPTIONS, &opts, &size) < 0) {
+		perror("ERROR: Can't get socket options");
+		close(data_sk);
+		close(ctrl_sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	mtu = opts.omtu;
+
+	/* Ignore SIGTERM signals if printing from stdin */
+	if (fd == 0) {
+#ifdef HAVE_SIGSET
+		sigset(SIGTERM, SIG_IGN);
+#elif defined(HAVE_SIGACTION)
+		memset(&action, 0, sizeof(action));
+		sigemptyset(&action.sa_mask);
+		action.sa_handler = SIG_IGN;
+		sigaction(SIGTERM, &action, NULL);
+#else
+		signal(SIGTERM, SIG_IGN);
+#endif /* HAVE_SIGSET */
+	}
+
+	tid = hcrp_get_next_tid(tid);
+	if (hcrp_credit_grant(ctrl_sk, tid, 0) < 0) {
+		fprintf(stderr, "ERROR: Can't grant initial credits\n");
+		close(data_sk);
+		close(ctrl_sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	for (i = 0; i < copies; i++) {
+
+		if (fd != 0) {
+			fprintf(stderr, "PAGE: 1 1\n");
+			lseek(fd, 0, SEEK_SET);
+		}
+
+		while (1) {
+			if (credit < mtu) {
+				tid = hcrp_get_next_tid(tid);
+				if (!hcrp_credit_request(ctrl_sk, tid, &tmp)) {
+					credit += tmp;
+					timeout = 0;
+				}
+			}
+
+			if (!credit) {
+				if (timeout++ > 300) {
+					tid = hcrp_get_next_tid(tid);
+					if (!hcrp_get_lpt_status(ctrl_sk, tid, &status))
+						fprintf(stderr, "ERROR: LPT status 0x%02x\n", status);
+					break;
+				}
+
+				sleep(1);
+				continue;
+			}
+
+			count = read(fd, buf, (credit > mtu) ? mtu : credit);
+			if (count <= 0)
+				break;
+
+			len = write(data_sk, buf, count);
+			if (len < 0) {
+				perror("ERROR: Error writing to device");
+				close(data_sk);
+				close(ctrl_sk);
+				return CUPS_BACKEND_FAILED;
+			}
+
+			if (len != count)
+				fprintf(stderr, "ERROR: Can't send complete data\n");
+
+			credit -= len;
+		}
+
+	}
+
+	close(data_sk);
+	close(ctrl_sk);
+
+	return CUPS_BACKEND_OK;
+}
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
new file mode 100644
index 0000000..a884c6e
--- /dev/null
+++ b/profiles/cups/main.c
@@ -0,0 +1,896 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/socket.h>
+#include <glib.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include <gdbus.h>
+
+#include "cups.h"
+
+struct cups_device {
+	char *bdaddr;
+	char *name;
+	char *id;
+};
+
+static GSList *device_list = NULL;
+static GMainLoop *loop = NULL;
+static DBusConnection *conn = NULL;
+static gboolean doing_disco = FALSE;
+
+#define ATTRID_1284ID 0x0300
+
+struct context_data {
+	gboolean found;
+	char *id;
+};
+
+static void element_start(GMarkupParseContext *context,
+				const gchar *element_name,
+				const gchar **attribute_names,
+				const gchar **attribute_values,
+				gpointer user_data, GError **err)
+{
+	struct context_data *ctx_data = user_data;
+
+	if (!strcmp(element_name, "record"))
+		return;
+
+	if (!strcmp(element_name, "attribute")) {
+		int i;
+		for (i = 0; attribute_names[i]; i++) {
+			if (strcmp(attribute_names[i], "id") != 0)
+				continue;
+			if (strtol(attribute_values[i], 0, 0) == ATTRID_1284ID)
+				ctx_data->found = TRUE;
+			break;
+		}
+		return;
+	}
+
+	if (ctx_data->found  && !strcmp(element_name, "text")) {
+		int i;
+		for (i = 0; attribute_names[i]; i++) {
+			if (!strcmp(attribute_names[i], "value")) {
+				ctx_data->id = g_strdup(attribute_values[i] + 2);
+				ctx_data->found = FALSE;
+			}
+		}
+	}
+}
+
+static GMarkupParser parser = {
+	element_start, NULL, NULL, NULL, NULL
+};
+
+static char *sdp_xml_parse_record(const char *data)
+{
+	GMarkupParseContext *ctx;
+	struct context_data ctx_data;
+	int size;
+
+	size = strlen(data);
+	ctx_data.found = FALSE;
+	ctx_data.id = NULL;
+	ctx = g_markup_parse_context_new(&parser, 0, &ctx_data, NULL);
+
+	if (g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) {
+		g_markup_parse_context_free(ctx);
+		g_free(ctx_data.id);
+		return NULL;
+	}
+
+	g_markup_parse_context_free(ctx);
+
+	return ctx_data.id;
+}
+
+static char *device_get_ieee1284_id(const char *adapter, const char *device)
+{
+	DBusMessage *message, *reply;
+	DBusMessageIter iter, reply_iter;
+	DBusMessageIter reply_iter_entry;
+	const char *hcr_print = "00001126-0000-1000-8000-00805f9b34fb";
+	const char *xml;
+	char *id = NULL;
+
+	/* Look for the service handle of the HCRP service */
+	message = dbus_message_new_method_call("org.bluez", device,
+						"org.bluez.Device",
+						"DiscoverServices");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &hcr_print);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init(reply, &reply_iter);
+
+	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
+		dbus_message_unref(reply);
+		return NULL;
+	}
+
+	dbus_message_iter_recurse(&reply_iter, &reply_iter_entry);
+
+	/* Hopefully we only get one handle, or take a punt */
+	while (dbus_message_iter_get_arg_type(&reply_iter_entry) ==
+							DBUS_TYPE_DICT_ENTRY) {
+		guint32 key;
+		DBusMessageIter dict_entry;
+
+		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
+
+		/* Key ? */
+		dbus_message_iter_get_basic(&dict_entry, &key);
+		if (!key) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
+
+		/* Try to get the value */
+		if (!dbus_message_iter_next(&dict_entry)) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
+
+		dbus_message_iter_get_basic(&dict_entry, &xml);
+
+		id = sdp_xml_parse_record(xml);
+		if (id != NULL)
+			break;
+		dbus_message_iter_next(&reply_iter_entry);
+	}
+
+	dbus_message_unref(reply);
+
+	return id;
+}
+
+static void print_printer_details(const char *name, const char *bdaddr,
+								const char *id)
+{
+	char *uri, *escaped;
+
+	escaped = g_strdelimit(g_strdup(name), "\"", '\'');
+	uri = g_strdup_printf("bluetooth://%c%c%c%c%c%c%c%c%c%c%c%c",
+				bdaddr[0], bdaddr[1],
+				bdaddr[3], bdaddr[4],
+				bdaddr[6], bdaddr[7],
+				bdaddr[9], bdaddr[10],
+				bdaddr[12], bdaddr[13],
+				bdaddr[15], bdaddr[16]);
+	printf("direct %s \"%s\" \"%s (Bluetooth)\"", uri, escaped, escaped);
+	if (id != NULL)
+		printf(" \"%s\"\n", id);
+	else
+		printf("\n");
+	g_free(escaped);
+	g_free(uri);
+}
+
+static void add_device_to_list(const char *name, const char *bdaddr,
+								const char *id)
+{
+	struct cups_device *device;
+	GSList *l;
+
+	/* Look for the device in the list */
+	for (l = device_list; l != NULL; l = l->next) {
+		device = (struct cups_device *) l->data;
+
+		if (strcmp(device->bdaddr, bdaddr) == 0) {
+			if (device->name != name) {
+				g_free(device->name);
+				device->name = g_strdup(name);
+			}
+			g_free(device->id);
+			device->id = g_strdup(id);
+			return;
+		}
+	}
+
+	/* Or add it to the list if it's not there */
+	device = g_new0(struct cups_device, 1);
+	device->bdaddr = g_strdup(bdaddr);
+	device->name = g_strdup(name);
+	device->id = g_strdup(id);
+
+	device_list = g_slist_prepend(device_list, device);
+	print_printer_details(device->name, device->bdaddr, device->id);
+}
+
+static gboolean parse_device_properties(DBusMessageIter *reply_iter,
+						char **name, char **bdaddr)
+{
+	guint32 class = 0;
+	DBusMessageIter reply_iter_entry;
+
+	if (dbus_message_iter_get_arg_type(reply_iter) != DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(reply_iter, &reply_iter_entry);
+
+	while (dbus_message_iter_get_arg_type(&reply_iter_entry) ==
+							DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter dict_entry, iter_dict_val;
+
+		dbus_message_iter_recurse(&reply_iter_entry, &dict_entry);
+
+		/* Key == Class ? */
+		dbus_message_iter_get_basic(&dict_entry, &key);
+		if (!key) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
+
+		if (strcmp(key, "Class") != 0 &&
+				strcmp(key, "Alias") != 0 &&
+				strcmp(key, "Address") != 0) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
+
+		/* Try to get the value */
+		if (!dbus_message_iter_next(&dict_entry)) {
+			dbus_message_iter_next(&reply_iter_entry);
+			continue;
+		}
+		dbus_message_iter_recurse(&dict_entry, &iter_dict_val);
+		if (strcmp(key, "Class") == 0) {
+			dbus_message_iter_get_basic(&iter_dict_val, &class);
+		} else {
+			const char *value;
+			dbus_message_iter_get_basic(&iter_dict_val, &value);
+			if (strcmp(key, "Alias") == 0) {
+				*name = g_strdup(value);
+			} else if (bdaddr) {
+				*bdaddr = g_strdup(value);
+			}
+		}
+		dbus_message_iter_next(&reply_iter_entry);
+	}
+
+	if (class == 0)
+		return FALSE;
+	if (((class & 0x1f00) >> 8) == 0x06 && (class & 0x80))
+		return TRUE;
+
+	return FALSE;
+}
+
+static gboolean device_is_printer(const char *adapter, const char *device_path, char **name, char **bdaddr)
+{
+	DBusMessage *message, *reply;
+	DBusMessageIter reply_iter;
+	gboolean retval;
+
+	message = dbus_message_new_method_call("org.bluez", device_path,
+							"org.bluez.Device",
+							"GetProperties");
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!reply)
+		return FALSE;
+
+	dbus_message_iter_init(reply, &reply_iter);
+
+	retval = parse_device_properties(&reply_iter, name, bdaddr);
+
+	dbus_message_unref(reply);
+
+	return retval;
+}
+
+static void remote_device_found(const char *adapter, const char *bdaddr,
+							const char *name)
+{
+	DBusMessage *message, *reply, *adapter_reply;
+	DBusMessageIter iter;
+	char *object_path = NULL;
+	char *id;
+
+	adapter_reply = NULL;
+
+	if (adapter == NULL) {
+		message = dbus_message_new_method_call("org.bluez", "/",
+							"org.bluez.Manager",
+							"DefaultAdapter");
+
+		adapter_reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, NULL);
+
+		dbus_message_unref(message);
+
+		if (!adapter_reply)
+			return;
+
+		if (dbus_message_get_args(adapter_reply, NULL,
+					DBUS_TYPE_OBJECT_PATH, &adapter,
+					DBUS_TYPE_INVALID) == FALSE) {
+			dbus_message_unref(adapter_reply);
+			return;
+		}
+	}
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+							"org.bluez.Adapter",
+							"FindDevice");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+	if (adapter_reply != NULL)
+		dbus_message_unref(adapter_reply);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!reply) {
+		message = dbus_message_new_method_call("org.bluez", adapter,
+							"org.bluez.Adapter",
+							"CreateDevice");
+		dbus_message_iter_init_append(message, &iter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+		reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, NULL);
+
+		dbus_message_unref(message);
+
+		if (!reply)
+			return;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_OBJECT_PATH, &object_path,
+					DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(reply);
+		return;
+	}
+
+	id = device_get_ieee1284_id(adapter, object_path);
+	add_device_to_list(name, bdaddr, id);
+	g_free(id);
+
+	dbus_message_unref(reply);
+}
+
+static void discovery_completed(void)
+{
+	g_slist_free(device_list);
+	device_list = NULL;
+
+	g_main_loop_quit(loop);
+}
+
+static void remote_device_disappeared(const char *bdaddr)
+{
+	GSList *l;
+
+	for (l = device_list; l != NULL; l = l->next) {
+		struct cups_device *device = l->data;
+
+		if (strcmp(device->bdaddr, bdaddr) == 0) {
+			g_free(device->name);
+			g_free(device->bdaddr);
+			g_free(device);
+			device_list = g_slist_delete_link(device_list, l);
+			return;
+		}
+	}
+}
+
+static gboolean list_known_printers(const char *adapter)
+{
+	DBusMessageIter reply_iter, iter_array;
+	DBusError error;
+	DBusMessage *message, *reply;
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+						"org.bluez.Adapter",
+						"ListDevices");
+	if (message == NULL)
+		return FALSE;
+
+	dbus_error_init(&error);
+	reply = dbus_connection_send_with_reply_and_block(conn, message,
+								-1, &error);
+
+	dbus_message_unref(message);
+
+	if (dbus_error_is_set(&error))
+		return FALSE;
+
+	dbus_message_iter_init(reply, &reply_iter);
+	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_ARRAY) {
+		dbus_message_unref(reply);
+		return FALSE;
+	}
+
+	dbus_message_iter_recurse(&reply_iter, &iter_array);
+	while (dbus_message_iter_get_arg_type(&iter_array) ==
+						DBUS_TYPE_OBJECT_PATH) {
+		const char *object_path;
+		char *name = NULL;
+		char *bdaddr = NULL;
+
+		dbus_message_iter_get_basic(&iter_array, &object_path);
+		if (device_is_printer(adapter, object_path, &name, &bdaddr)) {
+			char *id;
+
+			id = device_get_ieee1284_id(adapter, object_path);
+			add_device_to_list(name, bdaddr, id);
+			g_free(id);
+		}
+		g_free(name);
+		g_free(bdaddr);
+		dbus_message_iter_next(&iter_array);
+	}
+
+	dbus_message_unref(reply);
+
+	return FALSE;
+}
+
+static DBusHandlerResult filter_func(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	if (dbus_message_is_signal(message, "org.bluez.Adapter",
+						"DeviceFound")) {
+		const char *adapter, *bdaddr;
+		char *name;
+		DBusMessageIter iter;
+
+		dbus_message_iter_init(message, &iter);
+		dbus_message_iter_get_basic(&iter, &bdaddr);
+		dbus_message_iter_next(&iter);
+
+		adapter = dbus_message_get_path(message);
+		if (parse_device_properties(&iter, &name, NULL))
+			remote_device_found(adapter, bdaddr, name);
+		g_free (name);
+	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
+						"DeviceDisappeared")) {
+		const char *bdaddr;
+
+		dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &bdaddr,
+					DBUS_TYPE_INVALID);
+		remote_device_disappeared(bdaddr);
+	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
+						"PropertyChanged")) {
+		DBusMessageIter iter, value_iter;
+		const char *name;
+		gboolean discovering;
+
+		dbus_message_iter_init(message, &iter);
+		dbus_message_iter_get_basic(&iter, &name);
+		if (name == NULL || strcmp(name, "Discovering") != 0)
+			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+		dbus_message_iter_next(&iter);
+		dbus_message_iter_recurse(&iter, &value_iter);
+		dbus_message_iter_get_basic(&value_iter, &discovering);
+
+		if (discovering == FALSE && doing_disco) {
+			doing_disco = FALSE;
+			discovery_completed();
+		}
+	}
+
+	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+}
+
+static gboolean list_printers(void)
+{
+	/* 1. Connect to the bus
+	 * 2. Get the manager
+	 * 3. Get the default adapter
+	 * 4. Get a list of devices
+	 * 5. Get the class of each device
+	 * 6. Print the details from each printer device
+	 */
+	DBusError error;
+	dbus_bool_t hcid_exists;
+	DBusMessage *reply, *message;
+	DBusMessageIter reply_iter;
+	char *adapter, *match;
+
+	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (conn == NULL)
+		return TRUE;
+
+	dbus_error_init(&error);
+	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
+	if (dbus_error_is_set(&error))
+		return TRUE;
+
+	if (!hcid_exists)
+		return TRUE;
+
+	/* Get the default adapter */
+	message = dbus_message_new_method_call("org.bluez", "/",
+						"org.bluez.Manager",
+						"DefaultAdapter");
+	if (message == NULL) {
+		dbus_connection_unref(conn);
+		return FALSE;
+	}
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+							message, -1, &error);
+
+	dbus_message_unref(message);
+
+	if (dbus_error_is_set(&error)) {
+		dbus_connection_unref(conn);
+		/* No adapter */
+		return TRUE;
+	}
+
+	dbus_message_iter_init(reply, &reply_iter);
+	if (dbus_message_iter_get_arg_type(&reply_iter) !=
+						DBUS_TYPE_OBJECT_PATH) {
+		dbus_message_unref(reply);
+		dbus_connection_unref(conn);
+		return FALSE;
+	}
+
+	dbus_message_iter_get_basic(&reply_iter, &adapter);
+	adapter = g_strdup(adapter);
+	dbus_message_unref(reply);
+
+	if (!dbus_connection_add_filter(conn, filter_func, adapter, g_free)) {
+		g_free(adapter);
+		dbus_connection_unref(conn);
+		return FALSE;
+	}
+
+#define MATCH_FORMAT				\
+	"type='signal',"			\
+	"interface='org.bluez.Adapter',"	\
+	"sender='org.bluez',"			\
+	"path='%s'"
+
+	match = g_strdup_printf(MATCH_FORMAT, adapter);
+	dbus_bus_add_match(conn, match, &error);
+	g_free(match);
+
+	/* Add the the recent devices */
+	list_known_printers(adapter);
+
+	doing_disco = TRUE;
+	message = dbus_message_new_method_call("org.bluez", adapter,
+					"org.bluez.Adapter",
+					"StartDiscovery");
+
+	if (!dbus_connection_send_with_reply(conn, message, NULL, -1)) {
+		dbus_message_unref(message);
+		dbus_connection_unref(conn);
+		g_free(adapter);
+		return FALSE;
+	}
+	dbus_message_unref(message);
+
+	loop = g_main_loop_new(NULL, TRUE);
+	g_main_loop_run(loop);
+
+	g_free(adapter);
+	dbus_connection_unref(conn);
+
+	return TRUE;
+}
+
+static gboolean print_ieee1284(const char *bdaddr)
+{
+	DBusMessage *message, *reply, *adapter_reply;
+	DBusMessageIter iter;
+	char *object_path = NULL;
+	char *adapter;
+	char *id;
+
+	adapter_reply = NULL;
+
+	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (conn == NULL)
+		return FALSE;
+
+	message = dbus_message_new_method_call("org.bluez", "/",
+			"org.bluez.Manager",
+			"DefaultAdapter");
+
+	adapter_reply = dbus_connection_send_with_reply_and_block(conn,
+			message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!adapter_reply)
+		return FALSE;
+
+	if (dbus_message_get_args(adapter_reply, NULL,
+			DBUS_TYPE_OBJECT_PATH, &adapter,
+			DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(adapter_reply);
+		return FALSE;
+	}
+
+	message = dbus_message_new_method_call("org.bluez", adapter,
+			"org.bluez.Adapter",
+			"FindDevice");
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
+
+	if (adapter_reply != NULL)
+		dbus_message_unref(adapter_reply);
+
+	reply = dbus_connection_send_with_reply_and_block(conn,
+			message, -1, NULL);
+
+	dbus_message_unref(message);
+
+	if (!reply) {
+		message = dbus_message_new_method_call("org.bluez", adapter,
+				"org.bluez.Adapter",
+				"CreateDevice");
+		dbus_message_iter_init_append(message, &iter);
+		dbus_message_iter_append_basic(&iter,
+				DBUS_TYPE_STRING, &bdaddr);
+
+		reply = dbus_connection_send_with_reply_and_block(conn,
+				message, -1, NULL);
+
+		dbus_message_unref(message);
+
+		if (!reply)
+			return FALSE;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_OBJECT_PATH, &object_path,
+					DBUS_TYPE_INVALID) == FALSE) {
+		dbus_message_unref(reply);
+		return FALSE;
+	}
+
+	id = device_get_ieee1284_id(adapter, object_path);
+	if (id == NULL) {
+		dbus_message_unref(reply);
+		return FALSE;
+	}
+	printf("%s", id);
+	g_free(id);
+
+	dbus_message_unref(reply);
+
+	return TRUE;
+}
+
+/*
+ *  Usage: printer-uri job-id user title copies options [file]
+ *
+ */
+
+int main(int argc, char *argv[])
+{
+	sdp_session_t *sdp;
+	bdaddr_t bdaddr;
+	unsigned short ctrl_psm, data_psm;
+	uint8_t channel, b[6];
+	char *ptr, str[3], device[18], service[12];
+	const char *uri, *cups_class;
+	int i, err, fd, copies, proto;
+
+	/* Make sure status messages are not buffered */
+	setbuf(stderr, NULL);
+
+	/* Make sure output is not buffered */
+	setbuf(stdout, NULL);
+
+	/* Ignore SIGPIPE signals */
+#ifdef HAVE_SIGSET
+	sigset(SIGPIPE, SIG_IGN);
+#elif defined(HAVE_SIGACTION)
+	memset(&action, 0, sizeof(action));
+	action.sa_handler = SIG_IGN;
+	sigaction(SIGPIPE, &action, NULL);
+#else
+	signal(SIGPIPE, SIG_IGN);
+#endif /* HAVE_SIGSET */
+
+	if (argc == 1) {
+		if (list_printers() == TRUE)
+			return CUPS_BACKEND_OK;
+		else
+			return CUPS_BACKEND_FAILED;
+	} else if (argc == 3 && strcmp(argv[1], "--get-deviceid") == 0) {
+		if (bachk(argv[2]) < 0) {
+			fprintf(stderr, "Invalid Bluetooth address '%s'\n",
+					argv[2]);
+			return CUPS_BACKEND_FAILED;
+		}
+		if (print_ieee1284(argv[2]) == FALSE)
+			return CUPS_BACKEND_FAILED;
+		return CUPS_BACKEND_OK;
+	}
+
+	if (argc < 6 || argc > 7) {
+		fprintf(stderr, "Usage: bluetooth job-id user title copies"
+				" options [file]\n");
+		fprintf(stderr, "       bluetooth --get-deviceid [bdaddr]\n");
+		return CUPS_BACKEND_FAILED;
+	}
+
+	if (argc == 6) {
+		fd = 0;
+		copies = 1;
+	} else {
+		if ((fd = open(argv[6], O_RDONLY)) < 0) {
+			perror("ERROR: Unable to open print file");
+			return CUPS_BACKEND_FAILED;
+		}
+		copies = atoi(argv[4]);
+	}
+
+	uri = getenv("DEVICE_URI");
+	if (!uri)
+		uri = argv[0];
+
+	if (strncasecmp(uri, "bluetooth://", 12)) {
+		fprintf(stderr, "ERROR: No device URI found\n");
+		return CUPS_BACKEND_FAILED;
+	}
+
+	ptr = argv[0] + 12;
+	for (i = 0; i < 6; i++) {
+		strncpy(str, ptr, 2);
+		b[i] = (uint8_t) strtol(str, NULL, 16);
+		ptr += 2;
+	}
+	sprintf(device, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+			b[0], b[1], b[2], b[3], b[4], b[5]);
+
+	str2ba(device, &bdaddr);
+
+	ptr = strchr(ptr, '/');
+	if (ptr) {
+		strncpy(service, ptr + 1, 12);
+
+		if (!strncasecmp(ptr + 1, "spp", 3))
+			proto = 1;
+		else if (!strncasecmp(ptr + 1, "hcrp", 4))
+			proto = 2;
+		else
+			proto = 0;
+	} else {
+		strcpy(service, "auto");
+		proto = 0;
+	}
+
+	cups_class = getenv("CLASS");
+
+	fprintf(stderr,
+		"DEBUG: %s device %s service %s fd %d copies %d class %s\n",
+			argv[0], device, service, fd, copies,
+			cups_class ? cups_class : "(none)");
+
+	fputs("STATE: +connecting-to-device\n", stderr);
+
+service_search:
+	sdp = sdp_connect(BDADDR_ANY, &bdaddr, SDP_RETRY_IF_BUSY);
+	if (!sdp) {
+		fprintf(stderr, "ERROR: Can't open Bluetooth connection\n");
+		return CUPS_BACKEND_FAILED;
+	}
+
+	switch (proto) {
+	case 1:
+		err = sdp_search_spp(sdp, &channel);
+		break;
+	case 2:
+		err = sdp_search_hcrp(sdp, &ctrl_psm, &data_psm);
+		break;
+	default:
+		proto = 2;
+		err = sdp_search_hcrp(sdp, &ctrl_psm, &data_psm);
+		if (err) {
+			proto = 1;
+			err = sdp_search_spp(sdp, &channel);
+		}
+		break;
+	}
+
+	sdp_close(sdp);
+
+	if (err) {
+		if (cups_class) {
+			fputs("INFO: Unable to contact printer, queuing on "
+					"next printer in class...\n", stderr);
+			sleep(5);
+			return CUPS_BACKEND_FAILED;
+		}
+		sleep(20);
+		fprintf(stderr, "ERROR: Can't get service information\n");
+		goto service_search;
+	}
+
+connect:
+	switch (proto) {
+	case 1:
+		err = spp_print(BDADDR_ANY, &bdaddr, channel,
+						fd, copies, cups_class);
+		break;
+	case 2:
+		err = hcrp_print(BDADDR_ANY, &bdaddr, ctrl_psm, data_psm,
+						fd, copies, cups_class);
+		break;
+	default:
+		err = CUPS_BACKEND_FAILED;
+		fprintf(stderr, "ERROR: Unsupported protocol\n");
+		break;
+	}
+
+	if (err == CUPS_BACKEND_FAILED && cups_class) {
+		fputs("INFO: Unable to contact printer, queuing on "
+					"next printer in class...\n", stderr);
+		sleep(5);
+		return CUPS_BACKEND_FAILED;
+	} else if (err == CUPS_BACKEND_RETRY) {
+		sleep(20);
+		goto connect;
+	}
+
+	if (fd != 0)
+		close(fd);
+
+	if (!err)
+		fprintf(stderr, "INFO: Ready to print\n");
+
+	return err;
+}
diff --git a/profiles/cups/sdp.c b/profiles/cups/sdp.c
new file mode 100644
index 0000000..c7f17a4
--- /dev/null
+++ b/profiles/cups/sdp.c
@@ -0,0 +1,119 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/socket.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include "cups.h"
+
+int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm)
+{
+	sdp_list_t *srch, *attrs, *rsp;
+	uuid_t svclass;
+	uint16_t attr1, attr2;
+	int err;
+
+	if (!sdp)
+		return -1;
+
+	sdp_uuid16_create(&svclass, HCR_PRINT_SVCLASS_ID);
+	srch = sdp_list_append(NULL, &svclass);
+
+	attr1 = SDP_ATTR_PROTO_DESC_LIST;
+	attrs = sdp_list_append(NULL, &attr1);
+	attr2 = SDP_ATTR_ADD_PROTO_DESC_LIST;
+	attrs = sdp_list_append(attrs, &attr2);
+
+	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
+	if (err)
+		return -1;
+
+	for (; rsp; rsp = rsp->next) {
+		sdp_record_t *rec = (sdp_record_t *) rsp->data;
+		sdp_list_t *protos;
+
+		if (!sdp_get_access_protos(rec, &protos)) {
+			unsigned short psm = sdp_get_proto_port(protos, L2CAP_UUID);
+			if (psm > 0) {
+				*ctrl_psm = psm;
+			}
+		}
+
+		if (!sdp_get_add_access_protos(rec, &protos)) {
+			unsigned short psm = sdp_get_proto_port(protos, L2CAP_UUID);
+			if (psm > 0 && *ctrl_psm > 0) {
+				*data_psm = psm;
+				return 0;
+			}
+		}
+	}
+
+	return -1;
+}
+
+int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel)
+{
+	sdp_list_t *srch, *attrs, *rsp;
+	uuid_t svclass;
+	uint16_t attr;
+	int err;
+
+	if (!sdp)
+		return -1;
+
+	sdp_uuid16_create(&svclass, SERIAL_PORT_SVCLASS_ID);
+	srch = sdp_list_append(NULL, &svclass);
+
+	attr = SDP_ATTR_PROTO_DESC_LIST;
+	attrs = sdp_list_append(NULL, &attr);
+
+	err = sdp_service_search_attr_req(sdp, srch, SDP_ATTR_REQ_INDIVIDUAL, attrs, &rsp);
+	if (err)
+		return -1;
+
+	for (; rsp; rsp = rsp->next) {
+		sdp_record_t *rec = (sdp_record_t *) rsp->data;
+		sdp_list_t *protos;
+
+		if (!sdp_get_access_protos(rec, &protos)) {
+			uint8_t ch = sdp_get_proto_port(protos, RFCOMM_UUID);
+			if (ch > 0) {
+				*channel = ch;
+				return 0;
+			}
+		}
+	}
+
+	return -1;
+}
diff --git a/profiles/cups/spp.c b/profiles/cups/spp.c
new file mode 100644
index 0000000..d906ed2
--- /dev/null
+++ b/profiles/cups/spp.c
@@ -0,0 +1,118 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2003-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/socket.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/rfcomm.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include "cups.h"
+
+int spp_print(bdaddr_t *src, bdaddr_t *dst, uint8_t channel, int fd, int copies, const char *cups_class)
+{
+	struct sockaddr_rc addr;
+	unsigned char buf[2048];
+	int i, sk, err, len;
+
+	if ((sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
+		perror("ERROR: Can't create socket");
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	addr.rc_family = AF_BLUETOOTH;
+	bacpy(&addr.rc_bdaddr, src);
+	addr.rc_channel = 0;
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("ERROR: Can't bind socket");
+		close(sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	addr.rc_family = AF_BLUETOOTH;
+	bacpy(&addr.rc_bdaddr, dst);
+	addr.rc_channel = channel;
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("ERROR: Can't connect to device");
+		close(sk);
+		if (cups_class)
+			return CUPS_BACKEND_FAILED;
+		else
+			return CUPS_BACKEND_RETRY;
+	}
+
+	fputs("STATE: -connecting-to-device\n", stderr);
+
+	/* Ignore SIGTERM signals if printing from stdin */
+	if (fd == 0) {
+#ifdef HAVE_SIGSET
+		sigset(SIGTERM, SIG_IGN);
+#elif defined(HAVE_SIGACTION)
+		memset(&action, 0, sizeof(action));
+		sigemptyset(&action.sa_mask);
+		action.sa_handler = SIG_IGN;
+		sigaction(SIGTERM, &action, NULL);
+#else
+		signal(SIGTERM, SIG_IGN);
+#endif /* HAVE_SIGSET */
+	}
+
+	for (i = 0; i < copies; i++) {
+
+		if (fd != 0) {
+			fprintf(stderr, "PAGE: 1 1\n");
+			lseek(fd, 0, SEEK_SET);
+		}
+
+		while ((len = read(fd, buf, sizeof(buf))) > 0) {
+			err = write(sk, buf, len);
+			if (err < 0) {
+				perror("ERROR: Error writing to device");
+				close(sk);
+				return CUPS_BACKEND_FAILED;
+			}
+		}
+
+	}
+
+	close(sk);
+
+	return CUPS_BACKEND_OK;
+}
-- 
1.7.10.2

