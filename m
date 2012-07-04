Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 15/28] emulator: move it to the tools folder
Date: Wed,  4 Jul 2012 10:17:34 +0200
Message-Id: <1341389867-30749-16-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 .gitignore              |    2 +-
 Makefile.tools          |   12 +-
 emulator/btdev.c        | 1076 -----------------------------------------------
 emulator/btdev.h        |   38 --
 emulator/main.c         |   73 ----
 emulator/server.c       |  288 -------------
 emulator/server.h       |   30 --
 emulator/vhci.c         |  133 ------
 emulator/vhci.h         |   35 --
 tools/emulator/btdev.c  | 1076 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/emulator/btdev.h  |   38 ++
 tools/emulator/main.c   |   73 ++++
 tools/emulator/server.c |  288 +++++++++++++
 tools/emulator/server.h |   30 ++
 tools/emulator/vhci.c   |  133 ++++++
 tools/emulator/vhci.h   |   35 ++
 16 files changed, 1680 insertions(+), 1680 deletions(-)
 delete mode 100644 emulator/btdev.c
 delete mode 100644 emulator/btdev.h
 delete mode 100644 emulator/main.c
 delete mode 100644 emulator/server.c
 delete mode 100644 emulator/server.h
 delete mode 100644 emulator/vhci.c
 delete mode 100644 emulator/vhci.h
 create mode 100644 tools/emulator/btdev.c
 create mode 100644 tools/emulator/btdev.h
 create mode 100644 tools/emulator/main.c
 create mode 100644 tools/emulator/server.c
 create mode 100644 tools/emulator/server.h
 create mode 100644 tools/emulator/vhci.c
 create mode 100644 tools/emulator/vhci.h

diff --git a/.gitignore b/.gitignore
index c7d079e..aaf52c3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -88,7 +88,7 @@ compat/pand
 unit/test-eir
 mgmt/btmgmt
 monitor/btmon
-emulator/btvirt
+tools/emulator/btvirt
 
 doc/*.bak
 doc/*.stamp
diff --git a/Makefile.tools b/Makefile.tools
index 1626a4b..e1be0fa 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -50,7 +50,7 @@ tools_ppporc_LDADD = lib/libbluetooth-private.la
 
 tools_hcieventmask_LDADD = lib/libbluetooth-private.la
 
-noinst_PROGRAMS += mgmt/btmgmt monitor/btmon emulator/btvirt
+noinst_PROGRAMS += mgmt/btmgmt monitor/btmon tools/emulator/btvirt
 
 mgmt_btmgmt_SOURCES = mgmt/main.c src/glib-helper.c
 mgmt_btmgmt_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
@@ -63,11 +63,11 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 					monitor/packet.h monitor/packet.c
 monitor_btmon_LDADD = lib/libbluetooth-private.la
 
-emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
-					monitor/mainloop.h monitor/mainloop.c \
-					emulator/server.h emulator/server.c \
-					emulator/vhci.h emulator/vhci.c \
-					emulator/btdev.h emulator/btdev.c
+emulator_btvirt_SOURCES = tools/emulator/main.c monitor/bt.h \
+			monitor/mainloop.h monitor/mainloop.c \
+			tools/emulator/server.h tools/emulator/server.c \
+			tools/emulator/vhci.h tools/emulator/vhci.c \
+			tools/emulator/btdev.h tools/emulator/btdev.c
 
 if READLINE
 bin_PROGRAMS += attrib/gatttool
diff --git a/emulator/btdev.c b/emulator/btdev.c
deleted file mode 100644
index 7d4517a..0000000
--- a/emulator/btdev.c
+++ /dev/null
@@ -1,1076 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <ctype.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include "bt.h"
-#include "btdev.h"
-
-#define le16_to_cpu(val) (val)
-#define cpu_to_le16(val) (val)
-
-struct btdev {
-	struct btdev *conn;
-
-	btdev_send_func send_handler;
-	void *send_data;
-
-        uint16_t manufacturer;
-        uint8_t  version;
-	uint16_t revision;
-	uint8_t  commands[64];
-	uint8_t  features[8];
-	uint16_t acl_mtu;
-	uint16_t acl_max_pkt;
-	uint8_t  country_code;
-	uint8_t  bdaddr[6];
-	uint8_t  le_features[8];
-	uint8_t  le_states[8];
-
-	uint16_t default_link_policy;
-	uint8_t  event_mask[8];
-	uint8_t  event_filter;
-	uint8_t  name[248];
-	uint8_t  dev_class[3];
-	uint16_t voice_setting;
-	uint16_t conn_accept_timeout;
-	uint16_t page_timeout;
-	uint8_t  scan_enable;
-	uint8_t  auth_enable;
-	uint8_t  inquiry_mode;
-	uint8_t  afh_assess_mode;
-	uint8_t  ext_inquiry_fec;
-	uint8_t  ext_inquiry_rsp[240];
-	uint8_t  simple_pairing_mode;
-	uint8_t  le_supported;
-	uint8_t  le_simultaneous;
-	uint8_t  le_event_mask[8];
-};
-
-#define MAX_BTDEV_ENTRIES 16
-
-static struct btdev *btdev_list[MAX_BTDEV_ENTRIES] = { };
-
-static inline int add_btdev(struct btdev *btdev)
-{
-	int i, index = -1;
-
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		if (btdev_list[i] == NULL) {
-			index = i;
-			btdev_list[index] = btdev;
-			break;
-		}
-	}
-
-	return index;
-}
-
-static inline int del_btdev(struct btdev *btdev)
-{
-	int i, index = -1;
-
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		if (btdev_list[i] == btdev) {
-			index = i;
-			btdev_list[index] = NULL;
-			break;
-		}
-	}
-
-	return index;
-}
-
-static inline struct btdev *find_btdev_by_bdaddr(const uint8_t *bdaddr)
-{
-	int i;
-
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		if (btdev_list[i] && !memcmp(btdev_list[i]->bdaddr, bdaddr, 6))
-			return btdev_list[i];
-	}
-
-	return NULL;
-}
-
-static void hexdump(const unsigned char *buf, uint16_t len)
-{
-	static const char hexdigits[] = "0123456789abcdef";
-	char str[68];
-	uint16_t i;
-
-	if (!len)
-		return;
-
-	for (i = 0; i < len; i++) {
-		str[((i % 16) * 3) + 0] = hexdigits[buf[i] >> 4];
-		str[((i % 16) * 3) + 1] = hexdigits[buf[i] & 0xf];
-		str[((i % 16) * 3) + 2] = ' ';
-		str[(i % 16) + 49] = isprint(buf[i]) ? buf[i] : '.';
-
-		if ((i + 1) % 16 == 0) {
-			str[47] = ' ';
-			str[48] = ' ';
-			str[65] = '\0';
-			printf("%-12c%s\n", ' ', str);
-			str[0] = ' ';
-		}
-	}
-
-	if (i % 16 > 0) {
-		uint16_t j;
-		for (j = (i % 16); j < 16; j++) {
-			str[(j * 3) + 0] = ' ';
-			str[(j * 3) + 1] = ' ';
-			str[(j * 3) + 2] = ' ';
-			str[j + 49] = ' ';
-		}
-		str[47] = ' ';
-		str[48] = ' ';
-		str[65] = '\0';
-		printf("%-12c%s\n", ' ', str);
-	}
-}
-
-static void get_bdaddr(uint16_t id, uint8_t *bdaddr)
-{
-	bdaddr[0] = id & 0xff;
-	bdaddr[1] = id >> 8;
-	bdaddr[2] = 0x00;
-	bdaddr[3] = 0x01;
-	bdaddr[4] = 0xaa;
-	bdaddr[5] = 0x00;
-}
-
-struct btdev *btdev_create(uint16_t id)
-{
-	struct btdev *btdev;
-
-	btdev = malloc(sizeof(*btdev));
-	if (!btdev)
-		return NULL;
-
-	memset(btdev, 0, sizeof(*btdev));
-
-	btdev->manufacturer = 63;
-	btdev->version = 0x06;
-	btdev->revision = 0x0000;
-
-	btdev->features[0] |= 0x04;	/* Encryption */
-	btdev->features[0] |= 0x20;	/* Role switch */
-	btdev->features[0] |= 0x80;	/* Sniff mode */
-	btdev->features[1] |= 0x08;	/* SCO link */
-	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
-	btdev->features[3] |= 0x80;	/* Extended SCO link */
-	btdev->features[4] |= 0x08;	/* AFH capable slave */
-	btdev->features[4] |= 0x10;	/* AFH classification slave */
-	btdev->features[4] |= 0x40;	/* LE Supported */
-	btdev->features[5] |= 0x02;	/* Sniff subrating */
-	btdev->features[5] |= 0x04;	/* Pause encryption */
-	btdev->features[5] |= 0x08;	/* AFH capable master */
-	btdev->features[5] |= 0x10;	/* AFH classification master */
-	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
-	btdev->features[6] |= 0x02;	/* Simultaneous LE and BR/EDR */
-	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
-	btdev->features[6] |= 0x10;	/* Encapsulated PDU */
-	btdev->features[6] |= 0x20;	/* Erroneous Data Reporting */
-	btdev->features[6] |= 0x40;	/* Non-flushable Packet Boundary Flag */
-	btdev->features[7] |= 0x01;	/* Link Supervision Timeout Event */
-	btdev->features[7] |= 0x02;	/* Inquiry TX Power Level */
-	btdev->features[7] |= 0x80;	/* Extended features */
-
-	btdev->acl_mtu = 192;
-	btdev->acl_max_pkt = 1;
-
-	btdev->country_code = 0x00;
-
-	get_bdaddr(id, btdev->bdaddr);
-
-	add_btdev(btdev);
-
-	return btdev;
-}
-
-void btdev_destroy(struct btdev *btdev)
-{
-	if (!btdev)
-		return;
-
-	del_btdev(btdev);
-
-	free(btdev);
-}
-
-void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
-							void *user_data)
-{
-	if (!btdev)
-		return;
-
-	btdev->send_handler = handler;
-	btdev->send_data = user_data;
-}
-
-static void send_packet(struct btdev *btdev, const void *data, uint16_t len)
-{
-	if (!btdev->send_handler)
-		return;
-
-	btdev->send_handler(data, len, btdev->send_data);
-}
-
-static void send_event(struct btdev *btdev, uint8_t event,
-						const void *data, uint8_t len)
-{
-	struct bt_hci_evt_hdr *hdr;
-	uint16_t pkt_len;
-	void *pkt_data;
-
-	pkt_len = 1 + sizeof(*hdr) + len;
-
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
-
-	hdr = pkt_data + 1;
-	hdr->evt = event;
-	hdr->plen = len;
-
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*hdr), data, len);
-
-	send_packet(btdev, pkt_data, pkt_len);
-
-	free(pkt_data);
-}
-
-static void cmd_complete(struct btdev *btdev, uint16_t opcode,
-						const void *data, uint8_t len)
-{
-	struct bt_hci_evt_hdr *hdr;
-	struct bt_hci_evt_cmd_complete *cc;
-	uint16_t pkt_len;
-	void *pkt_data;
-
-	pkt_len = 1 + sizeof(*hdr) + sizeof(*cc) + len;
-
-	pkt_data = malloc(pkt_len);
-	if (!pkt_data)
-		return;
-
-	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
-
-	hdr = pkt_data + 1;
-	hdr->evt = BT_HCI_EVT_CMD_COMPLETE;
-	hdr->plen = sizeof(*cc) + len;
-
-	cc = pkt_data + 1 + sizeof(*hdr);
-	cc->ncmd = 0x01;
-	cc->opcode = cpu_to_le16(opcode);
-
-	if (len > 0)
-		memcpy(pkt_data + 1 + sizeof(*hdr) + sizeof(*cc), data, len);
-
-	send_packet(btdev, pkt_data, pkt_len);
-
-	free(pkt_data);
-}
-
-static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
-{
-	struct bt_hci_evt_cmd_status cs;
-
-	cs.status = status;
-	cs.ncmd = 0x01;
-	cs.opcode = cpu_to_le16(opcode);
-
-	send_event(btdev, BT_HCI_EVT_CMD_STATUS, &cs, sizeof(cs));
-}
-
-static void num_completed_packets(struct btdev *btdev)
-{
-	if (btdev->conn) {
-		struct bt_hci_evt_num_completed_packets ncp;
-
-		ncp.num_handles = 1;
-		ncp.handle = cpu_to_le16(42);
-		ncp.count = cpu_to_le16(1);
-
-		send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS,
-							&ncp, sizeof(ncp));
-	}
-}
-
-static void inquiry_complete(struct btdev *btdev, uint8_t status)
-{
-	struct bt_hci_evt_inquiry_complete ic;
-	int i;
-
-	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
-		if (!btdev_list[i] || btdev_list[i] == btdev)
-			continue;
-
-		if (!(btdev_list[i]->scan_enable & 0x02))
-			continue;
-
-		if (btdev->inquiry_mode == 0x02 &&
-					btdev_list[i]->ext_inquiry_rsp[0]) {
-			struct bt_hci_evt_ext_inquiry_result ir;
-
-			ir.num_resp = 0x01;
-			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
-			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
-			ir.rssi = -60;
-			memcpy(ir.data, btdev_list[i]->ext_inquiry_rsp, 240);
-
-			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT,
-							&ir, sizeof(ir));
-			continue;
-		}
-
-		if (btdev->inquiry_mode > 0x00) {
-			struct bt_hci_evt_inquiry_result_with_rssi ir;
-
-			ir.num_resp = 0x01;
-			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
-			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
-			ir.rssi = -60;
-
-			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT_WITH_RSSI,
-							&ir, sizeof(ir));
-		} else {
-			struct bt_hci_evt_inquiry_result ir;
-
-			ir.num_resp = 0x01;
-			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
-			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
-
-			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT,
-							&ir, sizeof(ir));
-		}
-        }
-
-	ic.status = status;
-
-	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
-}
-
-static void conn_complete(struct btdev *btdev,
-					const uint8_t *bdaddr, uint8_t status)
-{
-	struct bt_hci_evt_conn_complete cc;
-
-	if (!status) {
-		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
-
-		btdev->conn = remote;
-		remote->conn = btdev;
-
-		cc.status = status;
-		memcpy(cc.bdaddr, btdev->bdaddr, 6);
-		cc.encr_mode = 0x00;
-
-		cc.handle = cpu_to_le16(42);
-		cc.link_type = 0x01;
-
-		send_event(remote, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
-
-		cc.handle = cpu_to_le16(42);
-		cc.link_type = 0x01;
-	} else {
-		cc.handle = cpu_to_le16(0x0000);
-		cc.link_type = 0x01;
-	}
-
-	cc.status = status;
-	memcpy(cc.bdaddr, bdaddr, 6);
-	cc.encr_mode = 0x00;
-
-	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
-}
-
-static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
-{
-	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
-
-	if (remote) {
-		if (remote->scan_enable & 0x01) {
-			struct bt_hci_evt_conn_request cr;
-
-			memcpy(cr.bdaddr, btdev->bdaddr, 6);
-			memcpy(cr.dev_class, btdev->dev_class, 3);
-			cr.link_type = 0x01;
-
-			send_event(remote, BT_HCI_EVT_CONN_REQUEST,
-							&cr, sizeof(cr));
-		} else
-			conn_complete(btdev, bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
-	} else
-		conn_complete(btdev, bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
-}
-
-static void disconnect_complete(struct btdev *btdev, uint16_t handle,
-							uint8_t reason)
-{
-	struct bt_hci_evt_disconnect_complete dc;
-	struct btdev *remote;
-
-	if (!btdev) {
-		dc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		dc.handle = cpu_to_le16(handle);
-		dc.reason = 0x00;
-
-		send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE,
-							&dc, sizeof(dc));
-		return;
-	}
-
-	dc.status = BT_HCI_ERR_SUCCESS;
-	dc.handle = cpu_to_le16(handle);
-	dc.reason = reason;
-
-	remote = btdev->conn;
-
-	btdev->conn = NULL;
-	remote->conn = NULL;
-
-	send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
-	send_event(remote, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
-}
-
-static void name_request_complete(struct btdev *btdev,
-					const uint8_t *bdaddr, uint8_t status)
-{
-        struct bt_hci_evt_remote_name_req_complete nc;
-
-	nc.status = status;
-	memcpy(nc.bdaddr, bdaddr, 6);
-	memset(nc.name, 0, 248);
-
-	if (!status) {
-		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
-
-		if (remote)
-			memcpy(nc.name, remote->name, 248);
-		else
-			nc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-	}
-
-	send_event(btdev, BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE,
-							&nc, sizeof(nc));
-}
-
-static void remote_features_complete(struct btdev *btdev, uint16_t handle)
-{
-	struct bt_hci_evt_remote_features_complete rfc;
-
-	if (btdev->conn) {
-		rfc.status = BT_HCI_ERR_SUCCESS;
-		rfc.handle = cpu_to_le16(handle);
-		memcpy(rfc.features, btdev->conn->features, 8);
-	} else {
-		rfc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		rfc.handle = cpu_to_le16(handle);
-		memset(rfc.features, 0, 8);
-	}
-
-	send_event(btdev, BT_HCI_EVT_REMOTE_FEATURES_COMPLETE,
-							&rfc, sizeof(rfc));
-}
-
-static void remote_ext_features_complete(struct btdev *btdev, uint16_t handle,
-								uint8_t page)
-{
-	struct bt_hci_evt_remote_ext_features_complete refc;
-
-	if (btdev->conn && page < 0x02) {
-		refc.handle = cpu_to_le16(handle);
-		refc.page = page;
-		refc.max_page = 0x01;
-
-		switch (page) {
-		case 0x00:
-			refc.status = BT_HCI_ERR_SUCCESS;
-			memcpy(refc.features, btdev->conn->features, 8);
-			break;
-		case 0x01:
-			refc.status = BT_HCI_ERR_SUCCESS;
-			memset(refc.features, 0, 8);
-			break;
-		default:
-			refc.status = BT_HCI_ERR_INVALID_PARAMETERS;
-			memset(refc.features, 0, 8);
-			break;
-		}
-	} else {
-		refc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		refc.handle = cpu_to_le16(handle);
-		refc.page = page;
-		refc.max_page = 0x01;
-		memset(refc.features, 0, 8);
-	}
-
-	send_event(btdev, BT_HCI_EVT_REMOTE_EXT_FEATURES_COMPLETE,
-							&refc, sizeof(refc));
-}
-
-static void remote_version_complete(struct btdev *btdev, uint16_t handle)
-{
-	struct bt_hci_evt_remote_version_complete rvc;
-
-	if (btdev->conn) {
-		rvc.status = BT_HCI_ERR_SUCCESS;
-		rvc.handle = cpu_to_le16(handle);
-		rvc.lmp_ver = btdev->conn->version;
-		rvc.manufacturer = cpu_to_le16(btdev->conn->manufacturer);
-		rvc.lmp_subver = cpu_to_le16(btdev->conn->revision);
-	} else {
-		rvc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
-		rvc.handle = cpu_to_le16(handle);
-		rvc.lmp_ver = 0x00;
-		rvc.manufacturer = cpu_to_le16(0);
-		rvc.lmp_subver = cpu_to_le16(0);
-	}
-
-	send_event(btdev, BT_HCI_EVT_REMOTE_VERSION_COMPLETE,
-							&rvc, sizeof(rvc));
-}
-
-static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
-{
-	const struct bt_hci_cmd_hdr *hdr = data;
-	const struct bt_hci_cmd_create_conn *cc;
-	const struct bt_hci_cmd_disconnect *dc;
-	const struct bt_hci_cmd_create_conn_cancel *ccc;
-	const struct bt_hci_cmd_accept_conn_request *acr;
-	const struct bt_hci_cmd_reject_conn_request *rcr;
-	const struct bt_hci_cmd_remote_name_request *rnr;
-	const struct bt_hci_cmd_remote_name_request_cancel *rnrc;
-	const struct bt_hci_cmd_read_remote_features *rrf;
-	const struct bt_hci_cmd_read_remote_ext_features *rref;
-	const struct bt_hci_cmd_read_remote_version *rrv;
-	const struct bt_hci_cmd_write_default_link_policy *wdlp;
-	const struct bt_hci_cmd_set_event_mask *sem;
-	const struct bt_hci_cmd_set_event_filter *sef;
-	const struct bt_hci_cmd_write_local_name *wln;
-	const struct bt_hci_cmd_write_conn_accept_timeout *wcat;
-	const struct bt_hci_cmd_write_page_timeout *wpt;
-	const struct bt_hci_cmd_write_scan_enable *wse;
-	const struct bt_hci_cmd_write_auth_enable *wae;
-	const struct bt_hci_cmd_write_class_of_dev *wcod;
-	const struct bt_hci_cmd_write_voice_setting *wvs;
-	const struct bt_hci_cmd_write_inquiry_mode *wim;
-	const struct bt_hci_cmd_write_afh_assess_mode *waam;
-	const struct bt_hci_cmd_write_ext_inquiry_rsp *weir;
-	const struct bt_hci_cmd_write_simple_pairing_mode *wspm;
-	const struct bt_hci_cmd_write_le_host_supported *wlhs;
-	const struct bt_hci_cmd_le_set_event_mask *lsem;
-	struct bt_hci_rsp_read_default_link_policy rdlp;
-	struct bt_hci_rsp_read_stored_link_key rslk;
-	struct bt_hci_rsp_write_stored_link_key wslk;
-	struct bt_hci_rsp_delete_stored_link_key dslk;
-	struct bt_hci_rsp_read_local_name rln;
-	struct bt_hci_rsp_read_conn_accept_timeout rcat;
-	struct bt_hci_rsp_read_page_timeout rpt;
-	struct bt_hci_rsp_read_scan_enable rse;
-	struct bt_hci_rsp_read_auth_enable rae;
-	struct bt_hci_rsp_read_class_of_dev rcod;
-	struct bt_hci_rsp_read_voice_setting rvs;
-	struct bt_hci_rsp_read_inquiry_mode rim;
-	struct bt_hci_rsp_read_afh_assess_mode raam;
-	struct bt_hci_rsp_read_ext_inquiry_rsp reir;
-	struct bt_hci_rsp_read_simple_pairing_mode rspm;
-	struct bt_hci_rsp_read_inquiry_rsp_tx_power rirtp;
-	struct bt_hci_rsp_read_le_host_supported rlhs;
-	struct bt_hci_rsp_read_local_version rlv;
-	struct bt_hci_rsp_read_local_commands rlc;
-	struct bt_hci_rsp_read_local_features rlf;
-	struct bt_hci_rsp_read_local_ext_features rlef;
-	struct bt_hci_rsp_read_buffer_size rbs;
-	struct bt_hci_rsp_read_country_code rcc;
-	struct bt_hci_rsp_read_bd_addr rba;
-	struct bt_hci_rsp_read_data_block_size rdbs;
-	struct bt_hci_rsp_le_read_buffer_size lrbs;
-	struct bt_hci_rsp_le_read_local_features lrlf;
-	struct bt_hci_rsp_le_read_supported_states lrss;
-	uint16_t opcode;
-	uint8_t status, page;
-
-	if (len < sizeof(*hdr))
-		return;
-
-	opcode = le16_to_cpu(hdr->opcode);
-
-	switch (opcode) {
-	case BT_HCI_CMD_INQUIRY:
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		inquiry_complete(btdev, BT_HCI_ERR_SUCCESS);
-		break;
-
-	case BT_HCI_CMD_INQUIRY_CANCEL:
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_CREATE_CONN:
-		cc = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_request(btdev, cc->bdaddr);
-		break;
-
-	case BT_HCI_CMD_DISCONNECT:
-		dc = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		disconnect_complete(btdev, le16_to_cpu(dc->handle), dc->reason);
-		break;
-
-	case BT_HCI_CMD_CREATE_CONN_CANCEL:
-		ccc = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_complete(btdev, ccc->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
-		break;
-
-	case BT_HCI_CMD_ACCEPT_CONN_REQUEST:
-		acr = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_complete(btdev, acr->bdaddr, BT_HCI_ERR_SUCCESS);
-		break;
-
-	case BT_HCI_CMD_REJECT_CONN_REQUEST:
-		rcr = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		conn_complete(btdev, rcr->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
-		break;
-
-	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
-		rnr = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		name_request_complete(btdev, rnr->bdaddr, BT_HCI_ERR_SUCCESS);
-		break;
-
-	case BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL:
-		rnrc = data + sizeof(*hdr);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		name_request_complete(btdev, rnrc->bdaddr,
-						BT_HCI_ERR_UNKNOWN_CONN_ID);
-		break;
-
-	case BT_HCI_CMD_READ_REMOTE_FEATURES:
-		rrf = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		remote_features_complete(btdev, le16_to_cpu(rrf->handle));
-		break;
-
-	case BT_HCI_CMD_READ_REMOTE_EXT_FEATURES:
-		rref = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		remote_ext_features_complete(btdev, le16_to_cpu(rref->handle),
-								rref->page);
-		break;
-
-	case BT_HCI_CMD_READ_REMOTE_VERSION:
-		rrv = data + sizeof(*hdr);
-		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
-		remote_version_complete(btdev, le16_to_cpu(rrv->handle));
-		break;
-
-	case BT_HCI_CMD_READ_DEFAULT_LINK_POLICY:
-		rdlp.status = BT_HCI_ERR_SUCCESS;
-		rdlp.policy = cpu_to_le16(btdev->default_link_policy);
-		cmd_complete(btdev, opcode, &rdlp, sizeof(rdlp));
-		break;
-
-	case BT_HCI_CMD_WRITE_DEFAULT_LINK_POLICY:
-		wdlp = data + sizeof(*hdr);
-		btdev->default_link_policy = le16_to_cpu(wdlp->policy);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_SET_EVENT_MASK:
-		sem = data + sizeof(*hdr);
-		memcpy(btdev->event_mask, sem->mask, 8);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_RESET:
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_SET_EVENT_FILTER:
-		sef = data + sizeof(*hdr);
-		btdev->event_filter = sef->type;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_STORED_LINK_KEY:
-		rslk.status = BT_HCI_ERR_SUCCESS;
-		rslk.max_num_keys = cpu_to_le16(0);
-		rslk.num_keys = cpu_to_le16(0);
-		cmd_complete(btdev, opcode, &rslk, sizeof(rslk));
-		break;
-
-	case BT_HCI_CMD_WRITE_STORED_LINK_KEY:
-		wslk.status = BT_HCI_ERR_SUCCESS;
-		wslk.num_keys = 0;
-		cmd_complete(btdev, opcode, &wslk, sizeof(wslk));
-		break;
-
-	case BT_HCI_CMD_DELETE_STORED_LINK_KEY:
-		dslk.status = BT_HCI_ERR_SUCCESS;
-		dslk.num_keys = cpu_to_le16(0);
-		cmd_complete(btdev, opcode, &dslk, sizeof(dslk));
-		break;
-
-	case BT_HCI_CMD_WRITE_LOCAL_NAME:
-		wln = data + sizeof(*hdr);
-		memcpy(btdev->name, wln->name, 248);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_LOCAL_NAME:
-		rln.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rln.name, btdev->name, 248);
-		cmd_complete(btdev, opcode, &rln, sizeof(rln));
-		break;
-
-	case BT_HCI_CMD_READ_CONN_ACCEPT_TIMEOUT:
-		rcat.status = BT_HCI_ERR_SUCCESS;
-		rcat.timeout = cpu_to_le16(btdev->conn_accept_timeout);
-		cmd_complete(btdev, opcode, &rcat, sizeof(rcat));
-		break;
-
-	case BT_HCI_CMD_WRITE_CONN_ACCEPT_TIMEOUT:
-		wcat = data + sizeof(*hdr);
-		btdev->conn_accept_timeout = le16_to_cpu(wcat->timeout);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_PAGE_TIMEOUT:
-		rpt.status = BT_HCI_ERR_SUCCESS;
-		rpt.timeout = cpu_to_le16(btdev->page_timeout);
-		cmd_complete(btdev, opcode, &rpt, sizeof(rpt));
-		break;
-
-	case BT_HCI_CMD_WRITE_PAGE_TIMEOUT:
-		wpt = data + sizeof(*hdr);
-		btdev->page_timeout = le16_to_cpu(wpt->timeout);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_SCAN_ENABLE:
-		rse.status = BT_HCI_ERR_SUCCESS;
-		rse.enable = btdev->scan_enable;
-		cmd_complete(btdev, opcode, &rse, sizeof(rse));
-		break;
-
-	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
-		wse = data + sizeof(*hdr);
-		btdev->scan_enable = wse->enable;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_AUTH_ENABLE:
-		rae.status = BT_HCI_ERR_SUCCESS;
-		rae.enable = btdev->auth_enable;
-		cmd_complete(btdev, opcode, &rae, sizeof(rae));
-		break;
-
-	case BT_HCI_CMD_WRITE_AUTH_ENABLE:
-		wae = data + sizeof(*hdr);
-		btdev->auth_enable = wae->enable;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_CLASS_OF_DEV:
-		rcod.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rcod.dev_class, btdev->dev_class, 3);
-		cmd_complete(btdev, opcode, &rcod, sizeof(rcod));
-		break;
-
-	case BT_HCI_CMD_WRITE_CLASS_OF_DEV:
-		wcod = data + sizeof(*hdr);
-		memcpy(btdev->dev_class, wcod->dev_class, 3);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_VOICE_SETTING:
-		rvs.status = BT_HCI_ERR_SUCCESS;
-		rvs.setting = cpu_to_le16(btdev->voice_setting);
-		cmd_complete(btdev, opcode, &rvs, sizeof(rvs));
-		break;
-
-	case BT_HCI_CMD_WRITE_VOICE_SETTING:
-		wvs = data + sizeof(*hdr);
-		btdev->voice_setting = le16_to_cpu(wvs->setting);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_INQUIRY_MODE:
-		rim.status = BT_HCI_ERR_SUCCESS;
-		rim.mode = btdev->inquiry_mode;
-		cmd_complete(btdev, opcode, &rim, sizeof(rim));
-		break;
-
-	case BT_HCI_CMD_WRITE_INQUIRY_MODE:
-		wim = data + sizeof(*hdr);
-		btdev->inquiry_mode = wim->mode;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_AFH_ASSESS_MODE:
-		raam.status = BT_HCI_ERR_SUCCESS;
-		raam.mode = btdev->afh_assess_mode;
-		cmd_complete(btdev, opcode, &raam, sizeof(raam));
-		break;
-
-	case BT_HCI_CMD_WRITE_AFH_ASSESS_MODE:
-		waam = data + sizeof(*hdr);
-		btdev->afh_assess_mode = waam->mode;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_EXT_INQUIRY_RSP:
-		reir.status = BT_HCI_ERR_SUCCESS;
-		reir.fec = btdev->ext_inquiry_fec;
-		memcpy(reir.data, btdev->ext_inquiry_rsp, 240);
-		cmd_complete(btdev, opcode, &reir, sizeof(reir));
-		break;
-
-	case BT_HCI_CMD_WRITE_EXT_INQUIRY_RSP:
-		weir = data + sizeof(*hdr);
-		btdev->ext_inquiry_fec = weir->fec;
-		memcpy(btdev->ext_inquiry_rsp, weir->data, 240);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_SIMPLE_PAIRING_MODE:
-		rspm.status = BT_HCI_ERR_SUCCESS;
-		rspm.mode = btdev->simple_pairing_mode;
-		cmd_complete(btdev, opcode, &rspm, sizeof(rspm));
-		break;
-
-	case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
-		wspm = data + sizeof(*hdr);
-		btdev->simple_pairing_mode = wspm->mode;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_INQUIRY_RSP_TX_POWER:
-		rirtp.status = BT_HCI_ERR_SUCCESS;
-		rirtp.level = 0;
-		cmd_complete(btdev, opcode, &rirtp, sizeof(rirtp));
-		break;
-
-	case BT_HCI_CMD_READ_LE_HOST_SUPPORTED:
-		rlhs.status = BT_HCI_ERR_SUCCESS;
-		rlhs.supported = btdev->le_supported;
-		rlhs.simultaneous = btdev->le_simultaneous;
-		cmd_complete(btdev, opcode, &rlhs, sizeof(rlhs));
-		break;
-
-	case BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED:
-		wlhs = data + sizeof(*hdr);
-		btdev->le_supported = wlhs->supported;
-		btdev->le_simultaneous = wlhs->simultaneous;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_READ_LOCAL_VERSION:
-		rlv.status = BT_HCI_ERR_SUCCESS;
-		rlv.hci_ver = btdev->version;
-		rlv.hci_rev = cpu_to_le16(btdev->revision);
-		rlv.lmp_ver = btdev->version;
-		rlv.manufacturer = cpu_to_le16(btdev->manufacturer);
-		rlv.lmp_subver = cpu_to_le16(btdev->revision);
-		cmd_complete(btdev, opcode, &rlv, sizeof(rlv));
-		break;
-
-	case BT_HCI_CMD_READ_LOCAL_COMMANDS:
-		rlc.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rlc.commands, btdev->commands, 64);
-		cmd_complete(btdev, opcode, &rlc, sizeof(rlc));
-		break;
-
-	case BT_HCI_CMD_READ_LOCAL_FEATURES:
-		rlf.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rlf.features, btdev->features, 8);
-		cmd_complete(btdev, opcode, &rlf, sizeof(rlf));
-		break;
-
-	case BT_HCI_CMD_READ_LOCAL_EXT_FEATURES:
-		page = ((const uint8_t *) data)[sizeof(*hdr)];
-		switch (page) {
-		case 0x00:
-			rlef.status = BT_HCI_ERR_SUCCESS;
-			rlef.page = 0x00;
-			rlef.max_page = 0x01;
-			memcpy(rlef.features, btdev->features, 8);
-			break;
-		case 0x01:
-			rlef.status = BT_HCI_ERR_SUCCESS;
-			rlef.page = 0x01;
-			rlef.max_page = 0x01;
-			memset(rlef.features, 0, 8);
-			if (btdev->simple_pairing_mode)
-				rlef.features[0] |= 0x01;
-			if (btdev->le_supported)
-				rlef.features[0] |= 0x02;
-			if (btdev->le_simultaneous)
-				rlef.features[0] |= 0x04;
-			break;
-		default:
-			rlef.status = BT_HCI_ERR_INVALID_PARAMETERS;
-			rlef.page = page;
-			rlef.max_page = 0x01;
-			memset(rlef.features, 0, 8);
-			break;
-		}
-		cmd_complete(btdev, opcode, &rlef, sizeof(rlef));
-		break;
-
-	case BT_HCI_CMD_READ_BUFFER_SIZE:
-		rbs.status = BT_HCI_ERR_SUCCESS;
-		rbs.acl_mtu = cpu_to_le16(btdev->acl_mtu);
-		rbs.sco_mtu = 0;
-		rbs.acl_max_pkt = cpu_to_le16(btdev->acl_max_pkt);
-		rbs.sco_max_pkt = cpu_to_le16(0);
-		cmd_complete(btdev, opcode, &rbs, sizeof(rbs));
-		break;
-
-	case BT_HCI_CMD_READ_COUNTRY_CODE:
-		rcc.status = BT_HCI_ERR_SUCCESS;
-		rcc.code = btdev->country_code;
-		cmd_complete(btdev, opcode, &rcc, sizeof(rcc));
-		break;
-
-	case BT_HCI_CMD_READ_BD_ADDR:
-		rba.status = BT_HCI_ERR_SUCCESS;
-		memcpy(rba.bdaddr, btdev->bdaddr, 6);
-		cmd_complete(btdev, opcode, &rba, sizeof(rba));
-		break;
-
-	case BT_HCI_CMD_READ_DATA_BLOCK_SIZE:
-		rdbs.status = BT_HCI_ERR_SUCCESS;
-		rdbs.max_acl_len = cpu_to_le16(btdev->acl_mtu);
-		rdbs.block_len = cpu_to_le16(btdev->acl_mtu);
-		rdbs.num_blocks = cpu_to_le16(btdev->acl_max_pkt);
-		cmd_complete(btdev, opcode, &rdbs, sizeof(rdbs));
-		break;
-
-	case BT_HCI_CMD_LE_SET_EVENT_MASK:
-		lsem = data + sizeof(*hdr);
-		memcpy(btdev->le_event_mask, lsem->mask, 8);
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_LE_READ_BUFFER_SIZE:
-		lrbs.status = BT_HCI_ERR_SUCCESS;
-		lrbs.le_mtu = cpu_to_le16(btdev->acl_mtu);
-		lrbs.le_max_pkt = btdev->acl_max_pkt;
-		cmd_complete(btdev, opcode, &lrbs, sizeof(lrbs));
-		break;
-
-	case BT_HCI_CMD_LE_READ_LOCAL_FEATURES:
-		lrlf.status = BT_HCI_ERR_SUCCESS;
-		memcpy(lrlf.features, btdev->le_features, 8);
-		cmd_complete(btdev, opcode, &lrlf, sizeof(lrlf));
-		break;
-
-	case BT_HCI_CMD_LE_SET_SCAN_PARAMETERS:
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_LE_SET_SCAN_ENABLE:
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
-	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
-		lrss.status = BT_HCI_ERR_SUCCESS;
-		memcpy(lrss.states, btdev->le_states, 8);
-		cmd_complete(btdev, opcode, &lrss, sizeof(lrss));
-		break;
-
-	default:
-		printf("Unsupported command 0x%4.4x\n", opcode);
-		hexdump(data, len);
-		cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
-		break;
-	}
-}
-
-void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
-{
-	uint8_t pkt_type;
-
-	if (!btdev)
-		return;
-
-	if (len < 1)
-		return;
-
-	pkt_type = ((const uint8_t *) data)[0];
-
-	switch (pkt_type) {
-	case BT_H4_CMD_PKT:
-		process_cmd(btdev, data + 1, len - 1);
-		break;
-	case BT_H4_ACL_PKT:
-		if (btdev->conn)
-			send_packet(btdev->conn, data, len);
-		num_completed_packets(btdev);
-		break;
-	default:
-		printf("Unsupported packet 0x%2.2x\n", pkt_type);
-		break;
-	}
-}
diff --git a/emulator/btdev.h b/emulator/btdev.h
deleted file mode 100644
index 7b211a2..0000000
--- a/emulator/btdev.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <stdint.h>
-
-typedef void (*btdev_send_func) (const void *data, uint16_t len,
-							void *user_data);
-
-struct btdev;
-
-struct btdev *btdev_create(uint16_t id);
-void btdev_destroy(struct btdev *btdev);
-
-void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
-							void *user_data);
-
-void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len);
diff --git a/emulator/main.c b/emulator/main.c
deleted file mode 100644
index 125460d..0000000
--- a/emulator/main.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
-
-#include "mainloop.h"
-#include "server.h"
-#include "vhci.h"
-
-static void signal_callback(int signum, void *user_data)
-{
-	switch (signum) {
-	case SIGINT:
-	case SIGTERM:
-		mainloop_quit();
-		break;
-	}
-}
-
-int main(int argc, char *argv[])
-{
-	struct vhci *vhci;
-	struct server *server;
-	sigset_t mask;
-
-	mainloop_init();
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGINT);
-	sigaddset(&mask, SIGTERM);
-
-	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
-
-	vhci = vhci_open(VHCI_TYPE_BREDR, 0x23);
-	if (!vhci) {
-		fprintf(stderr, "Failed to open Virtual HCI device\n");
-		return 1;
-	}
-
-	server = server_open_unix("/tmp/bt-server-bredr", 0x42);
-	if (!server) {
-		fprintf(stderr, "Failed to open server channel\n");
-		vhci_close(vhci);
-		return 1;
-	}
-
-	return mainloop_run();
-}
diff --git a/emulator/server.c b/emulator/server.c
deleted file mode 100644
index 1ff9904..0000000
--- a/emulator/server.c
+++ /dev/null
@@ -1,288 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <ctype.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-#include <sys/epoll.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/hci.h>
-
-#include "mainloop.h"
-#include "btdev.h"
-#include "server.h"
-
-struct server {
-	uint16_t id;
-	int fd;
-};
-
-struct client {
-	int fd;
-	struct btdev *btdev;
-	uint8_t *pkt_data;
-	uint8_t pkt_type;
-	uint16_t pkt_expect;
-	uint16_t pkt_len;
-	uint16_t pkt_offset;
-};
-
-static void server_destroy(void *user_data)
-{
-	struct server *server = user_data;
-
-	close(server->fd);
-
-	free(server);
-}
-
-static void client_destroy(void *user_data)
-{
-	struct client *client = user_data;
-
-	btdev_destroy(client->btdev);
-
-	close(client->fd);
-
-	free(client);
-}
-
-static void client_write_callback(const void *data, uint16_t len,
-							void *user_data)
-{
-	struct client *client = user_data;
-	ssize_t written;
-
-	written = send(client->fd, data, len, MSG_DONTWAIT);
-	if (written < 0)
-		return;
-}
-
-static void client_read_callback(int fd, uint32_t events, void *user_data)
-{
-	struct client *client = user_data;
-	static uint8_t buf[4096];
-	uint8_t *ptr = buf;
-	ssize_t len;
-	uint16_t count;
-
-	if (events & (EPOLLERR | EPOLLHUP))
-		return;
-
-again:
-	len = recv(fd, buf + client->pkt_offset,
-			sizeof(buf) - client->pkt_offset, MSG_DONTWAIT);
-	if (len < 0) {
-		if (errno == EAGAIN)
-			goto again;
-		return;
-	}
-
-	count = client->pkt_offset + len;
-
-	while (count > 0) {
-		hci_command_hdr *cmd_hdr;
-
-		if (!client->pkt_data) {
-			client->pkt_type = ptr[0];
-
-			switch (client->pkt_type) {
-			case HCI_COMMAND_PKT:
-				if (count < HCI_COMMAND_HDR_SIZE + 1) {
-					client->pkt_offset += len;
-					return;
-				}
-				cmd_hdr = (hci_command_hdr *) (ptr + 1);
-				client->pkt_expect = HCI_COMMAND_HDR_SIZE +
-							cmd_hdr->plen + 1;
-				client->pkt_data = malloc(client->pkt_expect);
-				client->pkt_len = 0;
-				break;
-			default:
-				printf("packet error\n");
-				return;
-			}
-
-			client->pkt_offset = 0;
-		}
-
-		if (count >= client->pkt_expect) {
-			memcpy(client->pkt_data + client->pkt_len,
-						ptr, client->pkt_expect);
-			ptr += client->pkt_expect;
-			count -= client->pkt_expect;
-
-			btdev_receive_h4(client->btdev, client->pkt_data,
-					client->pkt_len + client->pkt_expect);
-
-			free(client->pkt_data);
-			client->pkt_data = NULL;
-		} else {
-			memcpy(client->pkt_data + client->pkt_len, ptr, count);
-			client->pkt_len += count;
-			client->pkt_expect -= count;
-			count = 0;
-		}
-	}
-}
-
-static int accept_client(int fd)
-{
-	struct sockaddr_un addr;
-	socklen_t len;
-	int nfd;
-
-	memset(&addr, 0, sizeof(addr));
-	len = sizeof(addr);
-
-	if (getsockname(fd, (struct sockaddr *) &addr, &len) < 0) {
-		perror("Failed to get socket name");
-		return -1;
-	}
-
-	printf("Request for %s\n", addr.sun_path);
-
-	nfd = accept(fd, (struct sockaddr *) &addr, &len);
-	if (nfd < 0) {
-		perror("Failed to accept client socket");
-		return -1;
-	}
-
-	return nfd;
-}
-
-static void server_accept_callback(int fd, uint32_t events, void *user_data)
-{
-	struct server *server = user_data;
-	struct client *client;
-
-	if (events & (EPOLLERR | EPOLLHUP))
-		return;
-
-	client = malloc(sizeof(*client));
-	if (!client)
-		return;
-
-	memset(client, 0, sizeof(*client));
-
-	client->fd = accept_client(server->fd);
-	if (client->fd < 0) {
-		free(client);
-		return;
-	}
-
-	client->btdev = btdev_create(server->id);
-	if (!client->btdev) {
-		close(client->fd);
-		free(client);
-		return;
-	}
-
-	btdev_set_send_handler(client->btdev, client_write_callback, client);
-
-	if (mainloop_add_fd(client->fd, EPOLLIN, client_read_callback,
-						client, client_destroy) < 0) {
-		btdev_destroy(client->btdev);
-		close(client->fd);
-		free(client);
-	}
-}
-
-static int open_server(const char *path)
-{
-	struct sockaddr_un addr;
-	int fd;
-
-	unlink(path);
-
-	fd = socket(PF_UNIX, SOCK_STREAM, 0);
-	if (fd < 0) {
-		perror("Failed to open server socket");
-		return -1;
-	}
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family = AF_UNIX;
-	strcpy(addr.sun_path, path);
-
-	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		perror("Failed to bind server socket");
-		close(fd);
-		return -1;
-	}
-
-	if (listen(fd, 5) < 0) {
-		perror("Failed to listen server socket");
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
-struct server *server_open_unix(const char *path, uint16_t id)
-{
-	struct server *server;
-
-	server = malloc(sizeof(*server));
-	if (!server)
-		return NULL;
-
-	memset(server, 0, sizeof(*server));
-	server->id = id;
-
-	server->fd = open_server(path);
-	if (server->fd < 0) {
-		free(server);
-		return NULL;
-	}
-
-	if (mainloop_add_fd(server->fd, EPOLLIN, server_accept_callback,
-						server, server_destroy) < 0) {
-		close(server->fd);
-		free(server);
-		return NULL;
-	}
-
-	return server;
-}
-
-void server_close(struct server *server)
-{
-	if (!server)
-		return;
-
-	mainloop_remove_fd(server->fd);
-}
diff --git a/emulator/server.h b/emulator/server.h
deleted file mode 100644
index 836db5f..0000000
--- a/emulator/server.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <stdint.h>
-
-struct server;
-
-struct server *server_open_unix(const char *path, uint16_t id);
-void server_close(struct server *server);
diff --git a/emulator/vhci.c b/emulator/vhci.c
deleted file mode 100644
index 940e562..0000000
--- a/emulator/vhci.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
-
-#include "mainloop.h"
-#include "btdev.h"
-#include "vhci.h"
-
-struct vhci {
-	enum vhci_type type;
-	int fd;
-	struct btdev *btdev;
-};
-
-static void vhci_destroy(void *user_data)
-{
-	struct vhci *vhci = user_data;
-
-	btdev_destroy(vhci->btdev);
-
-	close(vhci->fd);
-
-	free(vhci);
-}
-
-static void vhci_write_callback(const void *data, uint16_t len, void *user_data)
-{
-	struct vhci *vhci = user_data;
-	ssize_t written;
-
-	written = write(vhci->fd, data, len);
-	if (written < 0)
-		return;
-}
-
-static void vhci_read_callback(int fd, uint32_t events, void *user_data)
-{
-	struct vhci *vhci = user_data;
-	unsigned char buf[4096];
-	ssize_t len;
-
-	if (events & (EPOLLERR | EPOLLHUP))
-		return;
-
-	len = read(vhci->fd, buf, sizeof(buf));
-	if (len < 0)
-		return;
-
-	btdev_receive_h4(vhci->btdev, buf, len);
-}
-
-struct vhci *vhci_open(enum vhci_type type, uint16_t id)
-{
-	struct vhci *vhci;
-
-	switch (type) {
-	case VHCI_TYPE_BREDR:
-		break;
-	case VHCI_TYPE_AMP:
-		return NULL;
-	}
-
-	vhci = malloc(sizeof(*vhci));
-	if (!vhci)
-		return NULL;
-
-	memset(vhci, 0, sizeof(*vhci));
-	vhci->type = type;
-
-	vhci->fd = open("/dev/vhci", O_RDWR | O_NONBLOCK);
-	if (vhci->fd < 0) {
-		free(vhci);
-		return NULL;
-	}
-
-	vhci->btdev = btdev_create(id);
-	if (!vhci->btdev) {
-		close(vhci->fd);
-		free(vhci);
-		return NULL;
-	}
-
-	btdev_set_send_handler(vhci->btdev, vhci_write_callback, vhci);
-
-	if (mainloop_add_fd(vhci->fd, EPOLLIN, vhci_read_callback,
-						vhci, vhci_destroy) < 0) {
-		btdev_destroy(vhci->btdev);
-		close(vhci->fd);
-		free(vhci);
-		return NULL;
-	}
-
-	return vhci;
-}
-
-void vhci_close(struct vhci *vhci)
-{
-	if (!vhci)
-		return;
-
-	mainloop_remove_fd(vhci->fd);
-}
diff --git a/emulator/vhci.h b/emulator/vhci.h
deleted file mode 100644
index 4abb183..0000000
--- a/emulator/vhci.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011-2012  Intel Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <stdint.h>
-
-enum vhci_type {
-	VHCI_TYPE_BREDR	= 0,
-	VHCI_TYPE_AMP	= 1,
-};
-
-struct vhci;
-
-struct vhci *vhci_open(enum vhci_type type, uint16_t id);
-void vhci_close(struct vhci *vhci);
diff --git a/tools/emulator/btdev.c b/tools/emulator/btdev.c
new file mode 100644
index 0000000..7d4517a
--- /dev/null
+++ b/tools/emulator/btdev.c
@@ -0,0 +1,1076 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <ctype.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "bt.h"
+#include "btdev.h"
+
+#define le16_to_cpu(val) (val)
+#define cpu_to_le16(val) (val)
+
+struct btdev {
+	struct btdev *conn;
+
+	btdev_send_func send_handler;
+	void *send_data;
+
+        uint16_t manufacturer;
+        uint8_t  version;
+	uint16_t revision;
+	uint8_t  commands[64];
+	uint8_t  features[8];
+	uint16_t acl_mtu;
+	uint16_t acl_max_pkt;
+	uint8_t  country_code;
+	uint8_t  bdaddr[6];
+	uint8_t  le_features[8];
+	uint8_t  le_states[8];
+
+	uint16_t default_link_policy;
+	uint8_t  event_mask[8];
+	uint8_t  event_filter;
+	uint8_t  name[248];
+	uint8_t  dev_class[3];
+	uint16_t voice_setting;
+	uint16_t conn_accept_timeout;
+	uint16_t page_timeout;
+	uint8_t  scan_enable;
+	uint8_t  auth_enable;
+	uint8_t  inquiry_mode;
+	uint8_t  afh_assess_mode;
+	uint8_t  ext_inquiry_fec;
+	uint8_t  ext_inquiry_rsp[240];
+	uint8_t  simple_pairing_mode;
+	uint8_t  le_supported;
+	uint8_t  le_simultaneous;
+	uint8_t  le_event_mask[8];
+};
+
+#define MAX_BTDEV_ENTRIES 16
+
+static struct btdev *btdev_list[MAX_BTDEV_ENTRIES] = { };
+
+static inline int add_btdev(struct btdev *btdev)
+{
+	int i, index = -1;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (btdev_list[i] == NULL) {
+			index = i;
+			btdev_list[index] = btdev;
+			break;
+		}
+	}
+
+	return index;
+}
+
+static inline int del_btdev(struct btdev *btdev)
+{
+	int i, index = -1;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (btdev_list[i] == btdev) {
+			index = i;
+			btdev_list[index] = NULL;
+			break;
+		}
+	}
+
+	return index;
+}
+
+static inline struct btdev *find_btdev_by_bdaddr(const uint8_t *bdaddr)
+{
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (btdev_list[i] && !memcmp(btdev_list[i]->bdaddr, bdaddr, 6))
+			return btdev_list[i];
+	}
+
+	return NULL;
+}
+
+static void hexdump(const unsigned char *buf, uint16_t len)
+{
+	static const char hexdigits[] = "0123456789abcdef";
+	char str[68];
+	uint16_t i;
+
+	if (!len)
+		return;
+
+	for (i = 0; i < len; i++) {
+		str[((i % 16) * 3) + 0] = hexdigits[buf[i] >> 4];
+		str[((i % 16) * 3) + 1] = hexdigits[buf[i] & 0xf];
+		str[((i % 16) * 3) + 2] = ' ';
+		str[(i % 16) + 49] = isprint(buf[i]) ? buf[i] : '.';
+
+		if ((i + 1) % 16 == 0) {
+			str[47] = ' ';
+			str[48] = ' ';
+			str[65] = '\0';
+			printf("%-12c%s\n", ' ', str);
+			str[0] = ' ';
+		}
+	}
+
+	if (i % 16 > 0) {
+		uint16_t j;
+		for (j = (i % 16); j < 16; j++) {
+			str[(j * 3) + 0] = ' ';
+			str[(j * 3) + 1] = ' ';
+			str[(j * 3) + 2] = ' ';
+			str[j + 49] = ' ';
+		}
+		str[47] = ' ';
+		str[48] = ' ';
+		str[65] = '\0';
+		printf("%-12c%s\n", ' ', str);
+	}
+}
+
+static void get_bdaddr(uint16_t id, uint8_t *bdaddr)
+{
+	bdaddr[0] = id & 0xff;
+	bdaddr[1] = id >> 8;
+	bdaddr[2] = 0x00;
+	bdaddr[3] = 0x01;
+	bdaddr[4] = 0xaa;
+	bdaddr[5] = 0x00;
+}
+
+struct btdev *btdev_create(uint16_t id)
+{
+	struct btdev *btdev;
+
+	btdev = malloc(sizeof(*btdev));
+	if (!btdev)
+		return NULL;
+
+	memset(btdev, 0, sizeof(*btdev));
+
+	btdev->manufacturer = 63;
+	btdev->version = 0x06;
+	btdev->revision = 0x0000;
+
+	btdev->features[0] |= 0x04;	/* Encryption */
+	btdev->features[0] |= 0x20;	/* Role switch */
+	btdev->features[0] |= 0x80;	/* Sniff mode */
+	btdev->features[1] |= 0x08;	/* SCO link */
+	btdev->features[3] |= 0x40;	/* RSSI with inquiry results */
+	btdev->features[3] |= 0x80;	/* Extended SCO link */
+	btdev->features[4] |= 0x08;	/* AFH capable slave */
+	btdev->features[4] |= 0x10;	/* AFH classification slave */
+	btdev->features[4] |= 0x40;	/* LE Supported */
+	btdev->features[5] |= 0x02;	/* Sniff subrating */
+	btdev->features[5] |= 0x04;	/* Pause encryption */
+	btdev->features[5] |= 0x08;	/* AFH capable master */
+	btdev->features[5] |= 0x10;	/* AFH classification master */
+	btdev->features[6] |= 0x01;	/* Extended Inquiry Response */
+	btdev->features[6] |= 0x02;	/* Simultaneous LE and BR/EDR */
+	btdev->features[6] |= 0x08;	/* Secure Simple Pairing */
+	btdev->features[6] |= 0x10;	/* Encapsulated PDU */
+	btdev->features[6] |= 0x20;	/* Erroneous Data Reporting */
+	btdev->features[6] |= 0x40;	/* Non-flushable Packet Boundary Flag */
+	btdev->features[7] |= 0x01;	/* Link Supervision Timeout Event */
+	btdev->features[7] |= 0x02;	/* Inquiry TX Power Level */
+	btdev->features[7] |= 0x80;	/* Extended features */
+
+	btdev->acl_mtu = 192;
+	btdev->acl_max_pkt = 1;
+
+	btdev->country_code = 0x00;
+
+	get_bdaddr(id, btdev->bdaddr);
+
+	add_btdev(btdev);
+
+	return btdev;
+}
+
+void btdev_destroy(struct btdev *btdev)
+{
+	if (!btdev)
+		return;
+
+	del_btdev(btdev);
+
+	free(btdev);
+}
+
+void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
+							void *user_data)
+{
+	if (!btdev)
+		return;
+
+	btdev->send_handler = handler;
+	btdev->send_data = user_data;
+}
+
+static void send_packet(struct btdev *btdev, const void *data, uint16_t len)
+{
+	if (!btdev->send_handler)
+		return;
+
+	btdev->send_handler(data, len, btdev->send_data);
+}
+
+static void send_event(struct btdev *btdev, uint8_t event,
+						const void *data, uint8_t len)
+{
+	struct bt_hci_evt_hdr *hdr;
+	uint16_t pkt_len;
+	void *pkt_data;
+
+	pkt_len = 1 + sizeof(*hdr) + len;
+
+	pkt_data = malloc(pkt_len);
+	if (!pkt_data)
+		return;
+
+	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
+
+	hdr = pkt_data + 1;
+	hdr->evt = event;
+	hdr->plen = len;
+
+	if (len > 0)
+		memcpy(pkt_data + 1 + sizeof(*hdr), data, len);
+
+	send_packet(btdev, pkt_data, pkt_len);
+
+	free(pkt_data);
+}
+
+static void cmd_complete(struct btdev *btdev, uint16_t opcode,
+						const void *data, uint8_t len)
+{
+	struct bt_hci_evt_hdr *hdr;
+	struct bt_hci_evt_cmd_complete *cc;
+	uint16_t pkt_len;
+	void *pkt_data;
+
+	pkt_len = 1 + sizeof(*hdr) + sizeof(*cc) + len;
+
+	pkt_data = malloc(pkt_len);
+	if (!pkt_data)
+		return;
+
+	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
+
+	hdr = pkt_data + 1;
+	hdr->evt = BT_HCI_EVT_CMD_COMPLETE;
+	hdr->plen = sizeof(*cc) + len;
+
+	cc = pkt_data + 1 + sizeof(*hdr);
+	cc->ncmd = 0x01;
+	cc->opcode = cpu_to_le16(opcode);
+
+	if (len > 0)
+		memcpy(pkt_data + 1 + sizeof(*hdr) + sizeof(*cc), data, len);
+
+	send_packet(btdev, pkt_data, pkt_len);
+
+	free(pkt_data);
+}
+
+static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
+{
+	struct bt_hci_evt_cmd_status cs;
+
+	cs.status = status;
+	cs.ncmd = 0x01;
+	cs.opcode = cpu_to_le16(opcode);
+
+	send_event(btdev, BT_HCI_EVT_CMD_STATUS, &cs, sizeof(cs));
+}
+
+static void num_completed_packets(struct btdev *btdev)
+{
+	if (btdev->conn) {
+		struct bt_hci_evt_num_completed_packets ncp;
+
+		ncp.num_handles = 1;
+		ncp.handle = cpu_to_le16(42);
+		ncp.count = cpu_to_le16(1);
+
+		send_event(btdev, BT_HCI_EVT_NUM_COMPLETED_PACKETS,
+							&ncp, sizeof(ncp));
+	}
+}
+
+static void inquiry_complete(struct btdev *btdev, uint8_t status)
+{
+	struct bt_hci_evt_inquiry_complete ic;
+	int i;
+
+	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
+		if (!btdev_list[i] || btdev_list[i] == btdev)
+			continue;
+
+		if (!(btdev_list[i]->scan_enable & 0x02))
+			continue;
+
+		if (btdev->inquiry_mode == 0x02 &&
+					btdev_list[i]->ext_inquiry_rsp[0]) {
+			struct bt_hci_evt_ext_inquiry_result ir;
+
+			ir.num_resp = 0x01;
+			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
+			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.rssi = -60;
+			memcpy(ir.data, btdev_list[i]->ext_inquiry_rsp, 240);
+
+			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT,
+							&ir, sizeof(ir));
+			continue;
+		}
+
+		if (btdev->inquiry_mode > 0x00) {
+			struct bt_hci_evt_inquiry_result_with_rssi ir;
+
+			ir.num_resp = 0x01;
+			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
+			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+			ir.rssi = -60;
+
+			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT_WITH_RSSI,
+							&ir, sizeof(ir));
+		} else {
+			struct bt_hci_evt_inquiry_result ir;
+
+			ir.num_resp = 0x01;
+			memcpy(ir.bdaddr, btdev_list[i]->bdaddr, 6);
+			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
+
+			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT,
+							&ir, sizeof(ir));
+		}
+        }
+
+	ic.status = status;
+
+	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+}
+
+static void conn_complete(struct btdev *btdev,
+					const uint8_t *bdaddr, uint8_t status)
+{
+	struct bt_hci_evt_conn_complete cc;
+
+	if (!status) {
+		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+
+		btdev->conn = remote;
+		remote->conn = btdev;
+
+		cc.status = status;
+		memcpy(cc.bdaddr, btdev->bdaddr, 6);
+		cc.encr_mode = 0x00;
+
+		cc.handle = cpu_to_le16(42);
+		cc.link_type = 0x01;
+
+		send_event(remote, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+
+		cc.handle = cpu_to_le16(42);
+		cc.link_type = 0x01;
+	} else {
+		cc.handle = cpu_to_le16(0x0000);
+		cc.link_type = 0x01;
+	}
+
+	cc.status = status;
+	memcpy(cc.bdaddr, bdaddr, 6);
+	cc.encr_mode = 0x00;
+
+	send_event(btdev, BT_HCI_EVT_CONN_COMPLETE, &cc, sizeof(cc));
+}
+
+static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
+{
+	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+
+	if (remote) {
+		if (remote->scan_enable & 0x01) {
+			struct bt_hci_evt_conn_request cr;
+
+			memcpy(cr.bdaddr, btdev->bdaddr, 6);
+			memcpy(cr.dev_class, btdev->dev_class, 3);
+			cr.link_type = 0x01;
+
+			send_event(remote, BT_HCI_EVT_CONN_REQUEST,
+							&cr, sizeof(cr));
+		} else
+			conn_complete(btdev, bdaddr, BT_HCI_ERR_PAGE_TIMEOUT);
+	} else
+		conn_complete(btdev, bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+}
+
+static void disconnect_complete(struct btdev *btdev, uint16_t handle,
+							uint8_t reason)
+{
+	struct bt_hci_evt_disconnect_complete dc;
+	struct btdev *remote;
+
+	if (!btdev) {
+		dc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		dc.handle = cpu_to_le16(handle);
+		dc.reason = 0x00;
+
+		send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE,
+							&dc, sizeof(dc));
+		return;
+	}
+
+	dc.status = BT_HCI_ERR_SUCCESS;
+	dc.handle = cpu_to_le16(handle);
+	dc.reason = reason;
+
+	remote = btdev->conn;
+
+	btdev->conn = NULL;
+	remote->conn = NULL;
+
+	send_event(btdev, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
+	send_event(remote, BT_HCI_EVT_DISCONNECT_COMPLETE, &dc, sizeof(dc));
+}
+
+static void name_request_complete(struct btdev *btdev,
+					const uint8_t *bdaddr, uint8_t status)
+{
+        struct bt_hci_evt_remote_name_req_complete nc;
+
+	nc.status = status;
+	memcpy(nc.bdaddr, bdaddr, 6);
+	memset(nc.name, 0, 248);
+
+	if (!status) {
+		struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
+
+		if (remote)
+			memcpy(nc.name, remote->name, 248);
+		else
+			nc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	}
+
+	send_event(btdev, BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE,
+							&nc, sizeof(nc));
+}
+
+static void remote_features_complete(struct btdev *btdev, uint16_t handle)
+{
+	struct bt_hci_evt_remote_features_complete rfc;
+
+	if (btdev->conn) {
+		rfc.status = BT_HCI_ERR_SUCCESS;
+		rfc.handle = cpu_to_le16(handle);
+		memcpy(rfc.features, btdev->conn->features, 8);
+	} else {
+		rfc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		rfc.handle = cpu_to_le16(handle);
+		memset(rfc.features, 0, 8);
+	}
+
+	send_event(btdev, BT_HCI_EVT_REMOTE_FEATURES_COMPLETE,
+							&rfc, sizeof(rfc));
+}
+
+static void remote_ext_features_complete(struct btdev *btdev, uint16_t handle,
+								uint8_t page)
+{
+	struct bt_hci_evt_remote_ext_features_complete refc;
+
+	if (btdev->conn && page < 0x02) {
+		refc.handle = cpu_to_le16(handle);
+		refc.page = page;
+		refc.max_page = 0x01;
+
+		switch (page) {
+		case 0x00:
+			refc.status = BT_HCI_ERR_SUCCESS;
+			memcpy(refc.features, btdev->conn->features, 8);
+			break;
+		case 0x01:
+			refc.status = BT_HCI_ERR_SUCCESS;
+			memset(refc.features, 0, 8);
+			break;
+		default:
+			refc.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			memset(refc.features, 0, 8);
+			break;
+		}
+	} else {
+		refc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		refc.handle = cpu_to_le16(handle);
+		refc.page = page;
+		refc.max_page = 0x01;
+		memset(refc.features, 0, 8);
+	}
+
+	send_event(btdev, BT_HCI_EVT_REMOTE_EXT_FEATURES_COMPLETE,
+							&refc, sizeof(refc));
+}
+
+static void remote_version_complete(struct btdev *btdev, uint16_t handle)
+{
+	struct bt_hci_evt_remote_version_complete rvc;
+
+	if (btdev->conn) {
+		rvc.status = BT_HCI_ERR_SUCCESS;
+		rvc.handle = cpu_to_le16(handle);
+		rvc.lmp_ver = btdev->conn->version;
+		rvc.manufacturer = cpu_to_le16(btdev->conn->manufacturer);
+		rvc.lmp_subver = cpu_to_le16(btdev->conn->revision);
+	} else {
+		rvc.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		rvc.handle = cpu_to_le16(handle);
+		rvc.lmp_ver = 0x00;
+		rvc.manufacturer = cpu_to_le16(0);
+		rvc.lmp_subver = cpu_to_le16(0);
+	}
+
+	send_event(btdev, BT_HCI_EVT_REMOTE_VERSION_COMPLETE,
+							&rvc, sizeof(rvc));
+}
+
+static void process_cmd(struct btdev *btdev, const void *data, uint16_t len)
+{
+	const struct bt_hci_cmd_hdr *hdr = data;
+	const struct bt_hci_cmd_create_conn *cc;
+	const struct bt_hci_cmd_disconnect *dc;
+	const struct bt_hci_cmd_create_conn_cancel *ccc;
+	const struct bt_hci_cmd_accept_conn_request *acr;
+	const struct bt_hci_cmd_reject_conn_request *rcr;
+	const struct bt_hci_cmd_remote_name_request *rnr;
+	const struct bt_hci_cmd_remote_name_request_cancel *rnrc;
+	const struct bt_hci_cmd_read_remote_features *rrf;
+	const struct bt_hci_cmd_read_remote_ext_features *rref;
+	const struct bt_hci_cmd_read_remote_version *rrv;
+	const struct bt_hci_cmd_write_default_link_policy *wdlp;
+	const struct bt_hci_cmd_set_event_mask *sem;
+	const struct bt_hci_cmd_set_event_filter *sef;
+	const struct bt_hci_cmd_write_local_name *wln;
+	const struct bt_hci_cmd_write_conn_accept_timeout *wcat;
+	const struct bt_hci_cmd_write_page_timeout *wpt;
+	const struct bt_hci_cmd_write_scan_enable *wse;
+	const struct bt_hci_cmd_write_auth_enable *wae;
+	const struct bt_hci_cmd_write_class_of_dev *wcod;
+	const struct bt_hci_cmd_write_voice_setting *wvs;
+	const struct bt_hci_cmd_write_inquiry_mode *wim;
+	const struct bt_hci_cmd_write_afh_assess_mode *waam;
+	const struct bt_hci_cmd_write_ext_inquiry_rsp *weir;
+	const struct bt_hci_cmd_write_simple_pairing_mode *wspm;
+	const struct bt_hci_cmd_write_le_host_supported *wlhs;
+	const struct bt_hci_cmd_le_set_event_mask *lsem;
+	struct bt_hci_rsp_read_default_link_policy rdlp;
+	struct bt_hci_rsp_read_stored_link_key rslk;
+	struct bt_hci_rsp_write_stored_link_key wslk;
+	struct bt_hci_rsp_delete_stored_link_key dslk;
+	struct bt_hci_rsp_read_local_name rln;
+	struct bt_hci_rsp_read_conn_accept_timeout rcat;
+	struct bt_hci_rsp_read_page_timeout rpt;
+	struct bt_hci_rsp_read_scan_enable rse;
+	struct bt_hci_rsp_read_auth_enable rae;
+	struct bt_hci_rsp_read_class_of_dev rcod;
+	struct bt_hci_rsp_read_voice_setting rvs;
+	struct bt_hci_rsp_read_inquiry_mode rim;
+	struct bt_hci_rsp_read_afh_assess_mode raam;
+	struct bt_hci_rsp_read_ext_inquiry_rsp reir;
+	struct bt_hci_rsp_read_simple_pairing_mode rspm;
+	struct bt_hci_rsp_read_inquiry_rsp_tx_power rirtp;
+	struct bt_hci_rsp_read_le_host_supported rlhs;
+	struct bt_hci_rsp_read_local_version rlv;
+	struct bt_hci_rsp_read_local_commands rlc;
+	struct bt_hci_rsp_read_local_features rlf;
+	struct bt_hci_rsp_read_local_ext_features rlef;
+	struct bt_hci_rsp_read_buffer_size rbs;
+	struct bt_hci_rsp_read_country_code rcc;
+	struct bt_hci_rsp_read_bd_addr rba;
+	struct bt_hci_rsp_read_data_block_size rdbs;
+	struct bt_hci_rsp_le_read_buffer_size lrbs;
+	struct bt_hci_rsp_le_read_local_features lrlf;
+	struct bt_hci_rsp_le_read_supported_states lrss;
+	uint16_t opcode;
+	uint8_t status, page;
+
+	if (len < sizeof(*hdr))
+		return;
+
+	opcode = le16_to_cpu(hdr->opcode);
+
+	switch (opcode) {
+	case BT_HCI_CMD_INQUIRY:
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		inquiry_complete(btdev, BT_HCI_ERR_SUCCESS);
+		break;
+
+	case BT_HCI_CMD_INQUIRY_CANCEL:
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_CREATE_CONN:
+		cc = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		conn_request(btdev, cc->bdaddr);
+		break;
+
+	case BT_HCI_CMD_DISCONNECT:
+		dc = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		disconnect_complete(btdev, le16_to_cpu(dc->handle), dc->reason);
+		break;
+
+	case BT_HCI_CMD_CREATE_CONN_CANCEL:
+		ccc = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		conn_complete(btdev, ccc->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+		break;
+
+	case BT_HCI_CMD_ACCEPT_CONN_REQUEST:
+		acr = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		conn_complete(btdev, acr->bdaddr, BT_HCI_ERR_SUCCESS);
+		break;
+
+	case BT_HCI_CMD_REJECT_CONN_REQUEST:
+		rcr = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		conn_complete(btdev, rcr->bdaddr, BT_HCI_ERR_UNKNOWN_CONN_ID);
+		break;
+
+	case BT_HCI_CMD_REMOTE_NAME_REQUEST:
+		rnr = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		name_request_complete(btdev, rnr->bdaddr, BT_HCI_ERR_SUCCESS);
+		break;
+
+	case BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL:
+		rnrc = data + sizeof(*hdr);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		name_request_complete(btdev, rnrc->bdaddr,
+						BT_HCI_ERR_UNKNOWN_CONN_ID);
+		break;
+
+	case BT_HCI_CMD_READ_REMOTE_FEATURES:
+		rrf = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		remote_features_complete(btdev, le16_to_cpu(rrf->handle));
+		break;
+
+	case BT_HCI_CMD_READ_REMOTE_EXT_FEATURES:
+		rref = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		remote_ext_features_complete(btdev, le16_to_cpu(rref->handle),
+								rref->page);
+		break;
+
+	case BT_HCI_CMD_READ_REMOTE_VERSION:
+		rrv = data + sizeof(*hdr);
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		remote_version_complete(btdev, le16_to_cpu(rrv->handle));
+		break;
+
+	case BT_HCI_CMD_READ_DEFAULT_LINK_POLICY:
+		rdlp.status = BT_HCI_ERR_SUCCESS;
+		rdlp.policy = cpu_to_le16(btdev->default_link_policy);
+		cmd_complete(btdev, opcode, &rdlp, sizeof(rdlp));
+		break;
+
+	case BT_HCI_CMD_WRITE_DEFAULT_LINK_POLICY:
+		wdlp = data + sizeof(*hdr);
+		btdev->default_link_policy = le16_to_cpu(wdlp->policy);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_SET_EVENT_MASK:
+		sem = data + sizeof(*hdr);
+		memcpy(btdev->event_mask, sem->mask, 8);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_RESET:
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_SET_EVENT_FILTER:
+		sef = data + sizeof(*hdr);
+		btdev->event_filter = sef->type;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_STORED_LINK_KEY:
+		rslk.status = BT_HCI_ERR_SUCCESS;
+		rslk.max_num_keys = cpu_to_le16(0);
+		rslk.num_keys = cpu_to_le16(0);
+		cmd_complete(btdev, opcode, &rslk, sizeof(rslk));
+		break;
+
+	case BT_HCI_CMD_WRITE_STORED_LINK_KEY:
+		wslk.status = BT_HCI_ERR_SUCCESS;
+		wslk.num_keys = 0;
+		cmd_complete(btdev, opcode, &wslk, sizeof(wslk));
+		break;
+
+	case BT_HCI_CMD_DELETE_STORED_LINK_KEY:
+		dslk.status = BT_HCI_ERR_SUCCESS;
+		dslk.num_keys = cpu_to_le16(0);
+		cmd_complete(btdev, opcode, &dslk, sizeof(dslk));
+		break;
+
+	case BT_HCI_CMD_WRITE_LOCAL_NAME:
+		wln = data + sizeof(*hdr);
+		memcpy(btdev->name, wln->name, 248);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_LOCAL_NAME:
+		rln.status = BT_HCI_ERR_SUCCESS;
+		memcpy(rln.name, btdev->name, 248);
+		cmd_complete(btdev, opcode, &rln, sizeof(rln));
+		break;
+
+	case BT_HCI_CMD_READ_CONN_ACCEPT_TIMEOUT:
+		rcat.status = BT_HCI_ERR_SUCCESS;
+		rcat.timeout = cpu_to_le16(btdev->conn_accept_timeout);
+		cmd_complete(btdev, opcode, &rcat, sizeof(rcat));
+		break;
+
+	case BT_HCI_CMD_WRITE_CONN_ACCEPT_TIMEOUT:
+		wcat = data + sizeof(*hdr);
+		btdev->conn_accept_timeout = le16_to_cpu(wcat->timeout);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_PAGE_TIMEOUT:
+		rpt.status = BT_HCI_ERR_SUCCESS;
+		rpt.timeout = cpu_to_le16(btdev->page_timeout);
+		cmd_complete(btdev, opcode, &rpt, sizeof(rpt));
+		break;
+
+	case BT_HCI_CMD_WRITE_PAGE_TIMEOUT:
+		wpt = data + sizeof(*hdr);
+		btdev->page_timeout = le16_to_cpu(wpt->timeout);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_SCAN_ENABLE:
+		rse.status = BT_HCI_ERR_SUCCESS;
+		rse.enable = btdev->scan_enable;
+		cmd_complete(btdev, opcode, &rse, sizeof(rse));
+		break;
+
+	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+		wse = data + sizeof(*hdr);
+		btdev->scan_enable = wse->enable;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_AUTH_ENABLE:
+		rae.status = BT_HCI_ERR_SUCCESS;
+		rae.enable = btdev->auth_enable;
+		cmd_complete(btdev, opcode, &rae, sizeof(rae));
+		break;
+
+	case BT_HCI_CMD_WRITE_AUTH_ENABLE:
+		wae = data + sizeof(*hdr);
+		btdev->auth_enable = wae->enable;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_CLASS_OF_DEV:
+		rcod.status = BT_HCI_ERR_SUCCESS;
+		memcpy(rcod.dev_class, btdev->dev_class, 3);
+		cmd_complete(btdev, opcode, &rcod, sizeof(rcod));
+		break;
+
+	case BT_HCI_CMD_WRITE_CLASS_OF_DEV:
+		wcod = data + sizeof(*hdr);
+		memcpy(btdev->dev_class, wcod->dev_class, 3);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_VOICE_SETTING:
+		rvs.status = BT_HCI_ERR_SUCCESS;
+		rvs.setting = cpu_to_le16(btdev->voice_setting);
+		cmd_complete(btdev, opcode, &rvs, sizeof(rvs));
+		break;
+
+	case BT_HCI_CMD_WRITE_VOICE_SETTING:
+		wvs = data + sizeof(*hdr);
+		btdev->voice_setting = le16_to_cpu(wvs->setting);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_INQUIRY_MODE:
+		rim.status = BT_HCI_ERR_SUCCESS;
+		rim.mode = btdev->inquiry_mode;
+		cmd_complete(btdev, opcode, &rim, sizeof(rim));
+		break;
+
+	case BT_HCI_CMD_WRITE_INQUIRY_MODE:
+		wim = data + sizeof(*hdr);
+		btdev->inquiry_mode = wim->mode;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_AFH_ASSESS_MODE:
+		raam.status = BT_HCI_ERR_SUCCESS;
+		raam.mode = btdev->afh_assess_mode;
+		cmd_complete(btdev, opcode, &raam, sizeof(raam));
+		break;
+
+	case BT_HCI_CMD_WRITE_AFH_ASSESS_MODE:
+		waam = data + sizeof(*hdr);
+		btdev->afh_assess_mode = waam->mode;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_EXT_INQUIRY_RSP:
+		reir.status = BT_HCI_ERR_SUCCESS;
+		reir.fec = btdev->ext_inquiry_fec;
+		memcpy(reir.data, btdev->ext_inquiry_rsp, 240);
+		cmd_complete(btdev, opcode, &reir, sizeof(reir));
+		break;
+
+	case BT_HCI_CMD_WRITE_EXT_INQUIRY_RSP:
+		weir = data + sizeof(*hdr);
+		btdev->ext_inquiry_fec = weir->fec;
+		memcpy(btdev->ext_inquiry_rsp, weir->data, 240);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_SIMPLE_PAIRING_MODE:
+		rspm.status = BT_HCI_ERR_SUCCESS;
+		rspm.mode = btdev->simple_pairing_mode;
+		cmd_complete(btdev, opcode, &rspm, sizeof(rspm));
+		break;
+
+	case BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE:
+		wspm = data + sizeof(*hdr);
+		btdev->simple_pairing_mode = wspm->mode;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_INQUIRY_RSP_TX_POWER:
+		rirtp.status = BT_HCI_ERR_SUCCESS;
+		rirtp.level = 0;
+		cmd_complete(btdev, opcode, &rirtp, sizeof(rirtp));
+		break;
+
+	case BT_HCI_CMD_READ_LE_HOST_SUPPORTED:
+		rlhs.status = BT_HCI_ERR_SUCCESS;
+		rlhs.supported = btdev->le_supported;
+		rlhs.simultaneous = btdev->le_simultaneous;
+		cmd_complete(btdev, opcode, &rlhs, sizeof(rlhs));
+		break;
+
+	case BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED:
+		wlhs = data + sizeof(*hdr);
+		btdev->le_supported = wlhs->supported;
+		btdev->le_simultaneous = wlhs->simultaneous;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_READ_LOCAL_VERSION:
+		rlv.status = BT_HCI_ERR_SUCCESS;
+		rlv.hci_ver = btdev->version;
+		rlv.hci_rev = cpu_to_le16(btdev->revision);
+		rlv.lmp_ver = btdev->version;
+		rlv.manufacturer = cpu_to_le16(btdev->manufacturer);
+		rlv.lmp_subver = cpu_to_le16(btdev->revision);
+		cmd_complete(btdev, opcode, &rlv, sizeof(rlv));
+		break;
+
+	case BT_HCI_CMD_READ_LOCAL_COMMANDS:
+		rlc.status = BT_HCI_ERR_SUCCESS;
+		memcpy(rlc.commands, btdev->commands, 64);
+		cmd_complete(btdev, opcode, &rlc, sizeof(rlc));
+		break;
+
+	case BT_HCI_CMD_READ_LOCAL_FEATURES:
+		rlf.status = BT_HCI_ERR_SUCCESS;
+		memcpy(rlf.features, btdev->features, 8);
+		cmd_complete(btdev, opcode, &rlf, sizeof(rlf));
+		break;
+
+	case BT_HCI_CMD_READ_LOCAL_EXT_FEATURES:
+		page = ((const uint8_t *) data)[sizeof(*hdr)];
+		switch (page) {
+		case 0x00:
+			rlef.status = BT_HCI_ERR_SUCCESS;
+			rlef.page = 0x00;
+			rlef.max_page = 0x01;
+			memcpy(rlef.features, btdev->features, 8);
+			break;
+		case 0x01:
+			rlef.status = BT_HCI_ERR_SUCCESS;
+			rlef.page = 0x01;
+			rlef.max_page = 0x01;
+			memset(rlef.features, 0, 8);
+			if (btdev->simple_pairing_mode)
+				rlef.features[0] |= 0x01;
+			if (btdev->le_supported)
+				rlef.features[0] |= 0x02;
+			if (btdev->le_simultaneous)
+				rlef.features[0] |= 0x04;
+			break;
+		default:
+			rlef.status = BT_HCI_ERR_INVALID_PARAMETERS;
+			rlef.page = page;
+			rlef.max_page = 0x01;
+			memset(rlef.features, 0, 8);
+			break;
+		}
+		cmd_complete(btdev, opcode, &rlef, sizeof(rlef));
+		break;
+
+	case BT_HCI_CMD_READ_BUFFER_SIZE:
+		rbs.status = BT_HCI_ERR_SUCCESS;
+		rbs.acl_mtu = cpu_to_le16(btdev->acl_mtu);
+		rbs.sco_mtu = 0;
+		rbs.acl_max_pkt = cpu_to_le16(btdev->acl_max_pkt);
+		rbs.sco_max_pkt = cpu_to_le16(0);
+		cmd_complete(btdev, opcode, &rbs, sizeof(rbs));
+		break;
+
+	case BT_HCI_CMD_READ_COUNTRY_CODE:
+		rcc.status = BT_HCI_ERR_SUCCESS;
+		rcc.code = btdev->country_code;
+		cmd_complete(btdev, opcode, &rcc, sizeof(rcc));
+		break;
+
+	case BT_HCI_CMD_READ_BD_ADDR:
+		rba.status = BT_HCI_ERR_SUCCESS;
+		memcpy(rba.bdaddr, btdev->bdaddr, 6);
+		cmd_complete(btdev, opcode, &rba, sizeof(rba));
+		break;
+
+	case BT_HCI_CMD_READ_DATA_BLOCK_SIZE:
+		rdbs.status = BT_HCI_ERR_SUCCESS;
+		rdbs.max_acl_len = cpu_to_le16(btdev->acl_mtu);
+		rdbs.block_len = cpu_to_le16(btdev->acl_mtu);
+		rdbs.num_blocks = cpu_to_le16(btdev->acl_max_pkt);
+		cmd_complete(btdev, opcode, &rdbs, sizeof(rdbs));
+		break;
+
+	case BT_HCI_CMD_LE_SET_EVENT_MASK:
+		lsem = data + sizeof(*hdr);
+		memcpy(btdev->le_event_mask, lsem->mask, 8);
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_LE_READ_BUFFER_SIZE:
+		lrbs.status = BT_HCI_ERR_SUCCESS;
+		lrbs.le_mtu = cpu_to_le16(btdev->acl_mtu);
+		lrbs.le_max_pkt = btdev->acl_max_pkt;
+		cmd_complete(btdev, opcode, &lrbs, sizeof(lrbs));
+		break;
+
+	case BT_HCI_CMD_LE_READ_LOCAL_FEATURES:
+		lrlf.status = BT_HCI_ERR_SUCCESS;
+		memcpy(lrlf.features, btdev->le_features, 8);
+		cmd_complete(btdev, opcode, &lrlf, sizeof(lrlf));
+		break;
+
+	case BT_HCI_CMD_LE_SET_SCAN_PARAMETERS:
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_LE_SET_SCAN_ENABLE:
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
+	case BT_HCI_CMD_LE_READ_SUPPORTED_STATES:
+		lrss.status = BT_HCI_ERR_SUCCESS;
+		memcpy(lrss.states, btdev->le_states, 8);
+		cmd_complete(btdev, opcode, &lrss, sizeof(lrss));
+		break;
+
+	default:
+		printf("Unsupported command 0x%4.4x\n", opcode);
+		hexdump(data, len);
+		cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
+		break;
+	}
+}
+
+void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
+{
+	uint8_t pkt_type;
+
+	if (!btdev)
+		return;
+
+	if (len < 1)
+		return;
+
+	pkt_type = ((const uint8_t *) data)[0];
+
+	switch (pkt_type) {
+	case BT_H4_CMD_PKT:
+		process_cmd(btdev, data + 1, len - 1);
+		break;
+	case BT_H4_ACL_PKT:
+		if (btdev->conn)
+			send_packet(btdev->conn, data, len);
+		num_completed_packets(btdev);
+		break;
+	default:
+		printf("Unsupported packet 0x%2.2x\n", pkt_type);
+		break;
+	}
+}
diff --git a/tools/emulator/btdev.h b/tools/emulator/btdev.h
new file mode 100644
index 0000000..7b211a2
--- /dev/null
+++ b/tools/emulator/btdev.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdint.h>
+
+typedef void (*btdev_send_func) (const void *data, uint16_t len,
+							void *user_data);
+
+struct btdev;
+
+struct btdev *btdev_create(uint16_t id);
+void btdev_destroy(struct btdev *btdev);
+
+void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
+							void *user_data);
+
+void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len);
diff --git a/tools/emulator/main.c b/tools/emulator/main.c
new file mode 100644
index 0000000..125460d
--- /dev/null
+++ b/tools/emulator/main.c
@@ -0,0 +1,73 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+
+#include "mainloop.h"
+#include "server.h"
+#include "vhci.h"
+
+static void signal_callback(int signum, void *user_data)
+{
+	switch (signum) {
+	case SIGINT:
+	case SIGTERM:
+		mainloop_quit();
+		break;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct vhci *vhci;
+	struct server *server;
+	sigset_t mask;
+
+	mainloop_init();
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
+
+	vhci = vhci_open(VHCI_TYPE_BREDR, 0x23);
+	if (!vhci) {
+		fprintf(stderr, "Failed to open Virtual HCI device\n");
+		return 1;
+	}
+
+	server = server_open_unix("/tmp/bt-server-bredr", 0x42);
+	if (!server) {
+		fprintf(stderr, "Failed to open server channel\n");
+		vhci_close(vhci);
+		return 1;
+	}
+
+	return mainloop_run();
+}
diff --git a/tools/emulator/server.c b/tools/emulator/server.c
new file mode 100644
index 0000000..1ff9904
--- /dev/null
+++ b/tools/emulator/server.c
@@ -0,0 +1,288 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <ctype.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+
+#include "mainloop.h"
+#include "btdev.h"
+#include "server.h"
+
+struct server {
+	uint16_t id;
+	int fd;
+};
+
+struct client {
+	int fd;
+	struct btdev *btdev;
+	uint8_t *pkt_data;
+	uint8_t pkt_type;
+	uint16_t pkt_expect;
+	uint16_t pkt_len;
+	uint16_t pkt_offset;
+};
+
+static void server_destroy(void *user_data)
+{
+	struct server *server = user_data;
+
+	close(server->fd);
+
+	free(server);
+}
+
+static void client_destroy(void *user_data)
+{
+	struct client *client = user_data;
+
+	btdev_destroy(client->btdev);
+
+	close(client->fd);
+
+	free(client);
+}
+
+static void client_write_callback(const void *data, uint16_t len,
+							void *user_data)
+{
+	struct client *client = user_data;
+	ssize_t written;
+
+	written = send(client->fd, data, len, MSG_DONTWAIT);
+	if (written < 0)
+		return;
+}
+
+static void client_read_callback(int fd, uint32_t events, void *user_data)
+{
+	struct client *client = user_data;
+	static uint8_t buf[4096];
+	uint8_t *ptr = buf;
+	ssize_t len;
+	uint16_t count;
+
+	if (events & (EPOLLERR | EPOLLHUP))
+		return;
+
+again:
+	len = recv(fd, buf + client->pkt_offset,
+			sizeof(buf) - client->pkt_offset, MSG_DONTWAIT);
+	if (len < 0) {
+		if (errno == EAGAIN)
+			goto again;
+		return;
+	}
+
+	count = client->pkt_offset + len;
+
+	while (count > 0) {
+		hci_command_hdr *cmd_hdr;
+
+		if (!client->pkt_data) {
+			client->pkt_type = ptr[0];
+
+			switch (client->pkt_type) {
+			case HCI_COMMAND_PKT:
+				if (count < HCI_COMMAND_HDR_SIZE + 1) {
+					client->pkt_offset += len;
+					return;
+				}
+				cmd_hdr = (hci_command_hdr *) (ptr + 1);
+				client->pkt_expect = HCI_COMMAND_HDR_SIZE +
+							cmd_hdr->plen + 1;
+				client->pkt_data = malloc(client->pkt_expect);
+				client->pkt_len = 0;
+				break;
+			default:
+				printf("packet error\n");
+				return;
+			}
+
+			client->pkt_offset = 0;
+		}
+
+		if (count >= client->pkt_expect) {
+			memcpy(client->pkt_data + client->pkt_len,
+						ptr, client->pkt_expect);
+			ptr += client->pkt_expect;
+			count -= client->pkt_expect;
+
+			btdev_receive_h4(client->btdev, client->pkt_data,
+					client->pkt_len + client->pkt_expect);
+
+			free(client->pkt_data);
+			client->pkt_data = NULL;
+		} else {
+			memcpy(client->pkt_data + client->pkt_len, ptr, count);
+			client->pkt_len += count;
+			client->pkt_expect -= count;
+			count = 0;
+		}
+	}
+}
+
+static int accept_client(int fd)
+{
+	struct sockaddr_un addr;
+	socklen_t len;
+	int nfd;
+
+	memset(&addr, 0, sizeof(addr));
+	len = sizeof(addr);
+
+	if (getsockname(fd, (struct sockaddr *) &addr, &len) < 0) {
+		perror("Failed to get socket name");
+		return -1;
+	}
+
+	printf("Request for %s\n", addr.sun_path);
+
+	nfd = accept(fd, (struct sockaddr *) &addr, &len);
+	if (nfd < 0) {
+		perror("Failed to accept client socket");
+		return -1;
+	}
+
+	return nfd;
+}
+
+static void server_accept_callback(int fd, uint32_t events, void *user_data)
+{
+	struct server *server = user_data;
+	struct client *client;
+
+	if (events & (EPOLLERR | EPOLLHUP))
+		return;
+
+	client = malloc(sizeof(*client));
+	if (!client)
+		return;
+
+	memset(client, 0, sizeof(*client));
+
+	client->fd = accept_client(server->fd);
+	if (client->fd < 0) {
+		free(client);
+		return;
+	}
+
+	client->btdev = btdev_create(server->id);
+	if (!client->btdev) {
+		close(client->fd);
+		free(client);
+		return;
+	}
+
+	btdev_set_send_handler(client->btdev, client_write_callback, client);
+
+	if (mainloop_add_fd(client->fd, EPOLLIN, client_read_callback,
+						client, client_destroy) < 0) {
+		btdev_destroy(client->btdev);
+		close(client->fd);
+		free(client);
+	}
+}
+
+static int open_server(const char *path)
+{
+	struct sockaddr_un addr;
+	int fd;
+
+	unlink(path);
+
+	fd = socket(PF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("Failed to open server socket");
+		return -1;
+	}
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, path);
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("Failed to bind server socket");
+		close(fd);
+		return -1;
+	}
+
+	if (listen(fd, 5) < 0) {
+		perror("Failed to listen server socket");
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+struct server *server_open_unix(const char *path, uint16_t id)
+{
+	struct server *server;
+
+	server = malloc(sizeof(*server));
+	if (!server)
+		return NULL;
+
+	memset(server, 0, sizeof(*server));
+	server->id = id;
+
+	server->fd = open_server(path);
+	if (server->fd < 0) {
+		free(server);
+		return NULL;
+	}
+
+	if (mainloop_add_fd(server->fd, EPOLLIN, server_accept_callback,
+						server, server_destroy) < 0) {
+		close(server->fd);
+		free(server);
+		return NULL;
+	}
+
+	return server;
+}
+
+void server_close(struct server *server)
+{
+	if (!server)
+		return;
+
+	mainloop_remove_fd(server->fd);
+}
diff --git a/tools/emulator/server.h b/tools/emulator/server.h
new file mode 100644
index 0000000..836db5f
--- /dev/null
+++ b/tools/emulator/server.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdint.h>
+
+struct server;
+
+struct server *server_open_unix(const char *path, uint16_t id);
+void server_close(struct server *server);
diff --git a/tools/emulator/vhci.c b/tools/emulator/vhci.c
new file mode 100644
index 0000000..940e562
--- /dev/null
+++ b/tools/emulator/vhci.c
@@ -0,0 +1,133 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+
+#include "mainloop.h"
+#include "btdev.h"
+#include "vhci.h"
+
+struct vhci {
+	enum vhci_type type;
+	int fd;
+	struct btdev *btdev;
+};
+
+static void vhci_destroy(void *user_data)
+{
+	struct vhci *vhci = user_data;
+
+	btdev_destroy(vhci->btdev);
+
+	close(vhci->fd);
+
+	free(vhci);
+}
+
+static void vhci_write_callback(const void *data, uint16_t len, void *user_data)
+{
+	struct vhci *vhci = user_data;
+	ssize_t written;
+
+	written = write(vhci->fd, data, len);
+	if (written < 0)
+		return;
+}
+
+static void vhci_read_callback(int fd, uint32_t events, void *user_data)
+{
+	struct vhci *vhci = user_data;
+	unsigned char buf[4096];
+	ssize_t len;
+
+	if (events & (EPOLLERR | EPOLLHUP))
+		return;
+
+	len = read(vhci->fd, buf, sizeof(buf));
+	if (len < 0)
+		return;
+
+	btdev_receive_h4(vhci->btdev, buf, len);
+}
+
+struct vhci *vhci_open(enum vhci_type type, uint16_t id)
+{
+	struct vhci *vhci;
+
+	switch (type) {
+	case VHCI_TYPE_BREDR:
+		break;
+	case VHCI_TYPE_AMP:
+		return NULL;
+	}
+
+	vhci = malloc(sizeof(*vhci));
+	if (!vhci)
+		return NULL;
+
+	memset(vhci, 0, sizeof(*vhci));
+	vhci->type = type;
+
+	vhci->fd = open("/dev/vhci", O_RDWR | O_NONBLOCK);
+	if (vhci->fd < 0) {
+		free(vhci);
+		return NULL;
+	}
+
+	vhci->btdev = btdev_create(id);
+	if (!vhci->btdev) {
+		close(vhci->fd);
+		free(vhci);
+		return NULL;
+	}
+
+	btdev_set_send_handler(vhci->btdev, vhci_write_callback, vhci);
+
+	if (mainloop_add_fd(vhci->fd, EPOLLIN, vhci_read_callback,
+						vhci, vhci_destroy) < 0) {
+		btdev_destroy(vhci->btdev);
+		close(vhci->fd);
+		free(vhci);
+		return NULL;
+	}
+
+	return vhci;
+}
+
+void vhci_close(struct vhci *vhci)
+{
+	if (!vhci)
+		return;
+
+	mainloop_remove_fd(vhci->fd);
+}
diff --git a/tools/emulator/vhci.h b/tools/emulator/vhci.h
new file mode 100644
index 0000000..4abb183
--- /dev/null
+++ b/tools/emulator/vhci.h
@@ -0,0 +1,35 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2012  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdint.h>
+
+enum vhci_type {
+	VHCI_TYPE_BREDR	= 0,
+	VHCI_TYPE_AMP	= 1,
+};
+
+struct vhci;
+
+struct vhci *vhci_open(enum vhci_type type, uint16_t id);
+void vhci_close(struct vhci *vhci);
-- 
1.7.10.2

