Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        inga.stotland@intel.com, Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v5 03/14] mesh: Infrastructure for Mesh daemon
Date: Fri,  6 Jul 2018 10:12:55 -0700
Message-Id: <20180706171306.13501-4-brian.gix@intel.com>
In-Reply-To: <20180706171306.13501-1-brian.gix@intel.com>
References: <20180706171306.13501-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/display.c         |  67 +++++
 mesh/hci.c             | 699 +++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-io-generic.c | 660 ++++++++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-io.c         | 187 +++++++++++++
 4 files changed, 1613 insertions(+)
 create mode 100644 mesh/display.c
 create mode 100644 mesh/hci.c
 create mode 100644 mesh/mesh-io-generic.c
 create mode 100644 mesh/mesh-io.c

diff --git a/mesh/display.c b/mesh/display.c
new file mode 100644
index 000000000..adf92cae0
--- /dev/null
+++ b/mesh/display.c
@@ -0,0 +1,67 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <termios.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <ell/ell.h>
+
+#include "display.h"
+
+#define likely(x)   __builtin_expect(!!(x), 1)
+#define unlikely(x) __builtin_expect(!!(x), 0)
+
+static unsigned int cached_num_columns;
+
+unsigned int num_columns(void)
+{
+	struct winsize ws;
+
+	if (likely(cached_num_columns > 0))
+		return cached_num_columns;
+
+	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0 || ws.ws_col == 0)
+		cached_num_columns = 80;
+	else
+		cached_num_columns = ws.ws_col;
+
+	return cached_num_columns;
+}
+
+void print_packet(const char *label, const void *data, uint16_t size)
+{
+	struct timeval pkt_time;
+
+	gettimeofday(&pkt_time, NULL);
+
+	if (size > 0) {
+		char *str;
+
+		str = l_util_hexstring(data, size);
+		l_info("%05d.%03d %s: %s",
+				(uint32_t) pkt_time.tv_sec % 100000,
+				(uint32_t) pkt_time.tv_usec/1000, label, str);
+		l_free(str);
+	} else
+		l_info("%05d.%03d %s: empty",
+				(uint32_t) pkt_time.tv_sec % 100000,
+				(uint32_t) pkt_time.tv_usec/1000, label);
+}
diff --git a/mesh/hci.c b/mesh/hci.c
new file mode 100644
index 000000000..da6838a55
--- /dev/null
+++ b/mesh/hci.c
@@ -0,0 +1,699 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/uio.h>
+#include <sys/socket.h>
+#include <ell/ell.h>
+
+#include "monitor/bt.h"
+
+#include "mesh/hci.h"
+
+#define BTPROTO_HCI	1
+struct sockaddr_hci {
+	sa_family_t	hci_family;
+	unsigned short	hci_dev;
+	unsigned short  hci_channel;
+};
+#define HCI_CHANNEL_USER	1
+
+struct bt_hci {
+	int ref_count;
+	struct l_io *io;
+	bool is_stream;
+	bool writer_active;
+	uint8_t num_cmds;
+	uint8_t num_pkts;
+	unsigned int next_cmd_id;
+	unsigned int next_evt_id;
+	struct l_queue *cmd_queue;
+	struct l_queue *rsp_queue;
+	struct l_queue *evt_list;
+	struct l_queue *pkt_queue;
+	bt_hci_receive_func_t receive_callback;
+	bt_hci_destroy_func_t receive_destroy;
+	void *receive_data;
+};
+
+struct cmd {
+	unsigned int id;
+	uint16_t opcode;
+	void *data;
+	uint8_t size;
+	bt_hci_callback_func_t callback;
+	bt_hci_destroy_func_t destroy;
+	void *user_data;
+};
+
+struct evt {
+	unsigned int id;
+	uint8_t event;
+	bt_hci_callback_func_t callback;
+	bt_hci_destroy_func_t destroy;
+	void *user_data;
+};
+
+struct pkt {
+	uint16_t handle;
+	uint8_t flags;
+	void *data;
+	uint16_t size;
+};
+
+static void cmd_free(void *data)
+{
+	struct cmd *cmd = data;
+
+	if (cmd->destroy)
+		cmd->destroy(cmd->user_data);
+
+	l_free(cmd->data);
+	l_free(cmd);
+}
+
+static void evt_free(void *data)
+{
+	struct evt *evt = data;
+
+	if (evt->destroy)
+		evt->destroy(evt->user_data);
+
+	l_free(evt);
+}
+
+static void pkt_free(void *data)
+{
+	struct pkt *pkt = data;
+
+	l_free(pkt->data);
+	l_free(pkt);
+}
+
+static void send_command(struct bt_hci *hci, uint16_t opcode,
+						void *data, uint8_t size)
+{
+	uint8_t type = BT_H4_CMD_PKT;
+	struct bt_hci_cmd_hdr hdr;
+	struct iovec iov[3];
+	int fd, iovcnt;
+
+	hdr.opcode = L_CPU_TO_LE16(opcode);
+	hdr.plen = size;
+
+	iov[0].iov_base = &type;
+	iov[0].iov_len  = 1;
+	iov[1].iov_base = &hdr;
+	iov[1].iov_len  = sizeof(hdr);
+
+	if (size > 0) {
+		iov[2].iov_base = data;
+		iov[2].iov_len  = size;
+		iovcnt = 3;
+	} else
+		iovcnt = 2;
+
+	fd = l_io_get_fd(hci->io);
+	if (fd < 0) {
+		l_error("hci->io Bad");
+		return;
+	}
+
+	if (writev(fd, iov, iovcnt) < 0) {
+		l_error("writev Bad");
+		return;
+	}
+
+	hci->num_cmds--;
+}
+
+static void send_packet(struct bt_hci *hci, uint16_t handle, uint8_t flags,
+						void *data, uint8_t size)
+{
+	uint8_t type = BT_H4_ACL_PKT;
+	struct bt_hci_acl_hdr hdr;
+	struct iovec iov[3];
+	int fd, iovcnt;
+
+	hdr.handle = L_CPU_TO_LE16(flags << 12 | handle);
+	hdr.dlen = L_CPU_TO_LE16(size);
+
+	iov[0].iov_base = &type;
+	iov[0].iov_len  = 1;
+	iov[1].iov_base = &hdr;
+	iov[1].iov_len  = sizeof(hdr);
+
+	if (size > 0) {
+		iov[2].iov_base = data;
+		iov[2].iov_len  = size;
+		iovcnt = 3;
+	} else
+		iovcnt = 2;
+
+	fd = l_io_get_fd(hci->io);
+	if (fd < 0) {
+		l_error("hci->io Bad");
+		return;
+	}
+
+	if (writev(fd, iov, iovcnt) < 0) {
+		l_error("writev Bad");
+		return;
+	}
+
+	hci->num_pkts--;
+}
+
+static bool io_write_callback(struct l_io *io, void *user_data)
+{
+	struct bt_hci *hci = user_data;
+	struct cmd *cmd;
+
+	if (hci->num_cmds > 0)
+		cmd = l_queue_pop_head(hci->cmd_queue);
+	else
+		cmd = NULL;
+
+	if (cmd) {
+		send_command(hci, cmd->opcode, cmd->data, cmd->size);
+		l_queue_push_tail(hci->rsp_queue, cmd);
+	} else {
+		struct pkt *pkt;
+
+		if (hci->num_pkts < 1)
+			goto done;
+
+		pkt = l_queue_pop_head(hci->pkt_queue);
+		if (pkt) {
+			send_packet(hci, pkt->handle, pkt->flags,
+							pkt->data, pkt->size);
+			pkt_free(pkt);
+		}
+	}
+
+	if (!l_queue_isempty(hci->pkt_queue))
+		return true;
+
+done:
+	hci->writer_active = false;
+
+	return false;
+}
+
+static void wakeup_writer(struct bt_hci *hci)
+{
+	if (hci->writer_active)
+		return;
+
+	if (l_queue_isempty(hci->cmd_queue) && l_queue_isempty(hci->pkt_queue))
+		return;
+
+	if (!l_io_set_write_handler(hci->io, io_write_callback, hci, NULL))
+		return;
+
+	hci->writer_active = true;
+}
+
+static bool match_cmd_opcode(const void *a, const void *b)
+{
+	const struct cmd *cmd = a;
+	uint16_t opcode = L_PTR_TO_UINT(b);
+
+	return cmd->opcode == opcode;
+}
+
+static void process_response(struct bt_hci *hci, uint16_t opcode,
+					const void *data, size_t size)
+{
+	struct cmd *cmd;
+
+	if (opcode == BT_HCI_CMD_NOP)
+		goto done;
+
+	cmd = l_queue_remove_if(hci->rsp_queue, match_cmd_opcode,
+						L_UINT_TO_PTR(opcode));
+	if (!cmd)
+		goto done;
+
+	if (cmd->callback)
+		cmd->callback(data, size, cmd->user_data);
+
+	cmd_free(cmd);
+
+done:
+	wakeup_writer(hci);
+}
+
+static void process_notify(void *data, void *user_data)
+{
+	struct bt_hci_evt_hdr *hdr = user_data;
+	struct evt *evt = data;
+
+	if (evt->event == hdr->evt)
+		evt->callback(user_data + sizeof(struct bt_hci_evt_hdr),
+						hdr->plen, evt->user_data);
+}
+
+static void process_event(struct bt_hci *hci, const void *data, size_t size)
+{
+	const struct bt_hci_evt_hdr *hdr = data;
+	const struct bt_hci_evt_cmd_complete *cc;
+	const struct bt_hci_evt_cmd_status *cs;
+	const struct bt_hci_evt_num_completed_packets *cp;
+
+	if (size < sizeof(struct bt_hci_evt_hdr))
+		return;
+
+	data += sizeof(struct bt_hci_evt_hdr);
+	size -= sizeof(struct bt_hci_evt_hdr);
+
+	if (hdr->plen != size)
+		return;
+
+	switch (hdr->evt) {
+	case BT_HCI_EVT_CMD_COMPLETE:
+		if (size < sizeof(*cc))
+			return;
+		cc = data;
+		hci->num_cmds = cc->ncmd;
+		process_response(hci, L_LE16_TO_CPU(cc->opcode),
+						data + sizeof(*cc),
+						size - sizeof(*cc));
+		break;
+
+	case BT_HCI_EVT_CMD_STATUS:
+		if (size < sizeof(*cs))
+			return;
+		cs = data;
+		hci->num_cmds = cs->ncmd;
+		process_response(hci, L_LE16_TO_CPU(cs->opcode),
+							&cs->status, 1);
+		break;
+
+	case BT_HCI_EVT_NUM_COMPLETED_PACKETS:
+		if (size < sizeof(*cp))
+			return;
+		cp = data;
+		l_debug("BT_HCI_EVT_NUM_COMPLETED_PACKETS:%d", cp->count);
+		/* Ignoring handle information for now */
+		hci->num_pkts = cp->count;
+		wakeup_writer(hci);
+		break;
+
+	default:
+		l_queue_foreach(hci->evt_list, process_notify, (void *) hdr);
+		break;
+	}
+}
+
+static void process_acl(struct bt_hci *hci, const void *data, size_t size)
+{
+	const struct bt_hci_acl_hdr *hdr = data;
+	uint16_t handle;
+
+	if (size < sizeof(struct bt_hci_acl_hdr))
+		return;
+
+	data += sizeof(struct bt_hci_acl_hdr);
+	size -= sizeof(struct bt_hci_acl_hdr);
+
+	if (L_LE16_TO_CPU(hdr->dlen) != size)
+		return;
+
+	handle = L_LE16_TO_CPU(hdr->handle);
+
+	if (hci->receive_callback)
+		hci->receive_callback(handle & 0x0fff, handle >> 12,
+					data, size, hci->receive_data);
+}
+
+static bool io_read_callback(struct l_io *io, void *user_data)
+{
+	struct bt_hci *hci = user_data;
+	uint8_t buf[512];
+	ssize_t len;
+	int fd;
+
+	fd = l_io_get_fd(hci->io);
+	if (fd < 0)
+		return false;
+
+	if (hci->is_stream)
+		return false;
+
+	len = read(fd, buf, sizeof(buf));
+	if (len < 0)
+		return false;
+
+	if (len < 1)
+		return true;
+
+	switch (buf[0]) {
+	case BT_H4_EVT_PKT:
+		process_event(hci, buf + 1, len - 1);
+		break;
+	case BT_H4_ACL_PKT:
+		process_acl(hci, buf + 1, len - 1);
+		break;
+	default:
+		l_info("%2.2x-RXed", buf[0]);
+	}
+
+	return true;
+}
+
+static struct bt_hci *create_hci(int fd)
+{
+	struct bt_hci *hci;
+
+	if (fd < 0)
+		return NULL;
+
+	hci = l_new(struct bt_hci, 1);
+
+	hci->io = l_io_new(fd);
+
+	hci->is_stream = true;
+	hci->writer_active = false;
+	hci->num_cmds = 1;
+	hci->num_pkts = 1;
+	hci->next_cmd_id = 1;
+	hci->next_evt_id = 1;
+
+	hci->cmd_queue = l_queue_new();
+	hci->rsp_queue = l_queue_new();
+	hci->evt_list = l_queue_new();
+	hci->pkt_queue = l_queue_new();
+
+	if (!l_io_set_read_handler(hci->io, io_read_callback, hci, NULL)) {
+		l_queue_destroy(hci->pkt_queue, NULL);
+		l_queue_destroy(hci->evt_list, NULL);
+		l_queue_destroy(hci->rsp_queue, NULL);
+		l_queue_destroy(hci->cmd_queue, NULL);
+		l_io_destroy(hci->io);
+		l_free(hci);
+		return NULL;
+	}
+
+	return bt_hci_ref(hci);
+}
+
+struct bt_hci *bt_hci_new(int fd)
+{
+	struct bt_hci *hci;
+
+	hci = create_hci(fd);
+	if (!hci)
+		return NULL;
+
+	return hci;
+}
+
+static int create_socket(uint16_t index, uint16_t channel)
+{
+	struct sockaddr_hci addr;
+	int fd;
+
+	fd = socket(PF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC | SOCK_NONBLOCK,
+								BTPROTO_HCI);
+	if (fd < 0)
+		return -1;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.hci_family = AF_BLUETOOTH;
+	addr.hci_dev = index;
+	addr.hci_channel = channel;
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+struct bt_hci *bt_hci_new_user_channel(uint16_t index)
+{
+	struct bt_hci *hci;
+	int fd;
+
+	fd = create_socket(index, HCI_CHANNEL_USER);
+	if (fd < 0)
+		return NULL;
+
+	hci = create_hci(fd);
+	if (!hci) {
+		close(fd);
+		return NULL;
+	}
+
+	hci->is_stream = false;
+
+	bt_hci_set_close_on_unref(hci, true);
+
+	return hci;
+}
+
+struct bt_hci *bt_hci_ref(struct bt_hci *hci)
+{
+	if (!hci)
+		return NULL;
+
+	__sync_fetch_and_add(&hci->ref_count, 1);
+
+	return hci;
+}
+
+void bt_hci_unref(struct bt_hci *hci)
+{
+	if (!hci)
+		return;
+
+	if (__sync_sub_and_fetch(&hci->ref_count, 1))
+		return;
+
+	if (hci->receive_destroy)
+		hci->receive_destroy(hci->receive_data);
+
+	l_queue_destroy(hci->pkt_queue, pkt_free);
+	l_queue_destroy(hci->evt_list, evt_free);
+	l_queue_destroy(hci->cmd_queue, cmd_free);
+	l_queue_destroy(hci->rsp_queue, cmd_free);
+
+	l_io_destroy(hci->io);
+
+	l_free(hci);
+}
+
+bool bt_hci_set_close_on_unref(struct bt_hci *hci, bool do_close)
+{
+	if (!hci)
+		return false;
+
+	return l_io_set_close_on_destroy(hci->io, do_close);
+}
+
+unsigned int bt_hci_send(struct bt_hci *hci, uint16_t opcode,
+				const void *data, uint8_t size,
+				bt_hci_callback_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy)
+{
+	struct cmd *cmd;
+
+	if (!hci)
+		return 0;
+
+	cmd = l_new(struct cmd, 1);
+
+	cmd->opcode = opcode;
+	cmd->size = size;
+
+	if (cmd->size > 0)
+		cmd->data = l_memdup(data, cmd->size);
+
+	if (hci->next_cmd_id < 1)
+		hci->next_cmd_id = 1;
+
+	cmd->id = hci->next_cmd_id++;
+
+	cmd->callback = callback;
+	cmd->destroy = destroy;
+	cmd->user_data = user_data;
+
+	if (!l_queue_push_tail(hci->cmd_queue, cmd)) {
+		l_free(cmd->data);
+		l_free(cmd);
+		return 0;
+	}
+
+	wakeup_writer(hci);
+
+	return cmd->id;
+}
+
+static bool match_cmd_id(const void *a, const void *b)
+{
+	const struct cmd *cmd = a;
+	unsigned int id = L_PTR_TO_UINT(b);
+
+	return cmd->id == id;
+}
+
+bool bt_hci_cancel(struct bt_hci *hci, unsigned int id)
+{
+	struct cmd *cmd;
+
+	if (!hci || !id)
+		return false;
+
+	cmd = l_queue_remove_if(hci->cmd_queue, match_cmd_id,
+						L_UINT_TO_PTR(id));
+	if (!cmd) {
+		cmd = l_queue_remove_if(hci->rsp_queue, match_cmd_id,
+							L_UINT_TO_PTR(id));
+		if (!cmd)
+			return false;
+	}
+
+	cmd_free(cmd);
+
+	wakeup_writer(hci);
+
+	return true;
+}
+
+bool bt_hci_flush(struct bt_hci *hci)
+{
+	if (!hci)
+		return false;
+
+	if (hci->writer_active) {
+		l_io_set_write_handler(hci->io, NULL, NULL, NULL);
+		hci->writer_active = false;
+	}
+
+	l_queue_clear(hci->cmd_queue, cmd_free);
+	l_queue_clear(hci->rsp_queue, cmd_free);
+
+	return true;
+}
+
+unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
+				bt_hci_callback_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy)
+{
+	struct evt *evt;
+
+	if (!hci)
+		return 0;
+
+	evt = l_new(struct evt, 1);
+
+	evt->event = event;
+
+	if (hci->next_evt_id < 1)
+		hci->next_evt_id = 1;
+
+	evt->id = hci->next_evt_id++;
+
+	evt->callback = callback;
+	evt->destroy = destroy;
+	evt->user_data = user_data;
+
+	if (!l_queue_push_tail(hci->evt_list, evt)) {
+		l_free(evt);
+		return 0;
+	}
+
+	return evt->id;
+}
+
+static bool match_evt_id(const void *a, const void *b)
+{
+	const struct evt *evt = a;
+	unsigned int id = L_PTR_TO_UINT(b);
+
+	return evt->id == id;
+}
+
+bool bt_hci_unregister(struct bt_hci *hci, unsigned int id)
+{
+	struct evt *evt;
+
+	if (!hci || !id)
+		return false;
+
+	evt = l_queue_remove_if(hci->evt_list, match_evt_id,
+						L_UINT_TO_PTR(id));
+	if (!evt)
+		return false;
+
+	evt_free(evt);
+
+	return true;
+}
+
+bool bt_hci_receive(struct bt_hci *hci, bt_hci_receive_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy)
+{
+	if (!hci)
+		return false;
+
+	if (hci->receive_destroy)
+		hci->receive_destroy(hci->receive_data);
+
+	hci->receive_callback = callback;
+	hci->receive_destroy = destroy;
+	hci->receive_data = user_data;
+
+	return true;
+}
+
+bool bt_hci_write(struct bt_hci *hci, uint16_t handle, uint8_t flags,
+				const void *data, uint16_t size)
+{
+	struct pkt *pkt;
+
+	if (!hci)
+		return false;
+
+	pkt = l_new(struct pkt, 1);
+
+	pkt->handle = handle;
+	pkt->flags = flags;
+	pkt->size = size;
+
+	if (pkt->size > 0)
+		pkt->data = l_memdup(data, pkt->size);
+
+	if (!l_queue_push_tail(hci->pkt_queue, pkt)) {
+		l_free(pkt->data);
+		l_free(pkt);
+		return false;
+	}
+
+	wakeup_writer(hci);
+
+	return true;
+}
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
new file mode 100644
index 000000000..7a974cff3
--- /dev/null
+++ b/mesh/mesh-io-generic.c
@@ -0,0 +1,660 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/time.h>
+#include <ell/ell.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+
+#include "monitor/bt.h"
+
+#include "mesh/hci.h"
+#include "mesh/display.h"
+#include "mesh/mesh-io.h"
+#include "mesh/mesh-io-api.h"
+
+#include "mesh/mesh-io-generic.h"
+
+struct mesh_io_private {
+	uint16_t index;
+	struct bt_hci *hci;
+	struct l_timeout *tx_timeout;
+	struct l_queue *rx_regs;
+	struct l_queue *tx_pkts;
+	uint8_t filters[3]; /* Simple filtering on AD type only */
+	bool sending;
+	struct tx_pkt *tx;
+	uint16_t interval;
+};
+
+struct pvt_rx_reg {
+	uint8_t filter_id;
+	mesh_io_recv_func_t cb;
+	void *user_data;
+};
+
+struct process_data {
+	struct mesh_io_private		*pvt;
+	const uint8_t			*data;
+	uint8_t				len;
+	struct mesh_io_recv_info	info;
+};
+
+struct tx_pkt {
+	struct mesh_io_send_info	info;
+	bool				delete;
+	uint8_t				len;
+	uint8_t				pkt[30];
+};
+
+struct tx_pattern {
+	const uint8_t			*data;
+	uint8_t				len;
+};
+
+static uint32_t get_instant(void)
+{
+	struct timeval tm;
+	uint32_t instant;
+
+	gettimeofday(&tm, NULL);
+	instant = tm.tv_sec * 1000;
+	instant += tm.tv_usec / 1000;
+
+	return instant;
+}
+
+static uint32_t instant_remaining_ms(uint32_t instant)
+{
+	instant -= get_instant();
+	return instant;
+}
+
+static void process_rx_callbacks(void *v_rx, void *v_reg)
+{
+	struct pvt_rx_reg *rx_reg = v_rx;
+	struct process_data *rx = v_reg;
+	uint8_t ad_type;
+
+	ad_type = rx->pvt->filters[rx_reg->filter_id - 1];
+
+	if (rx->data[0] == ad_type && rx_reg->cb)
+		rx_reg->cb(rx_reg->user_data, &rx->info, rx->data, rx->len);
+}
+
+static void process_rx(struct mesh_io_private *pvt, int8_t rssi,
+					uint32_t instant,
+					const uint8_t *data, uint8_t len)
+{
+	struct process_data rx = {
+		.pvt = pvt,
+		.data = data,
+		.len = len,
+		.info.instant = instant,
+		.info.chan = 7,
+		.info.rssi = rssi,
+	};
+
+	l_queue_foreach(pvt->rx_regs, process_rx_callbacks, &rx);
+}
+
+static void event_adv_report(struct mesh_io *io, const void *buf, uint8_t size)
+{
+	const struct bt_hci_evt_le_adv_report *evt = buf;
+	const uint8_t *adv;
+	uint32_t instant;
+	uint8_t adv_len;
+	uint16_t len = 0;
+	int8_t rssi;
+
+	if (evt->event_type != 0x03)
+		return;
+
+	if (evt->addr_type != BDADDR_LE_PUBLIC &&
+			evt->addr_type != BDADDR_LE_RANDOM)
+		return;
+
+	instant = get_instant();
+	adv = evt->data;
+	adv_len = evt->data_len;
+
+	/* rssi is just beyond last byte of data */
+	rssi = (int8_t) adv[adv_len];
+
+	while (len < adv_len - 1) {
+		uint8_t field_len = adv[0];
+
+		/* Check for the end of advertising data */
+		if (field_len == 0)
+			break;
+
+		len += field_len + 1;
+
+		/* Do not continue data parsing if got incorrect length */
+		if (len > adv_len)
+			break;
+
+		/* TODO: Create an Instant to use */
+		process_rx(io->pvt, rssi, instant, adv + 1, adv[0]);
+
+		adv += field_len + 1;
+	}
+}
+
+static void event_callback(const void *buf, uint8_t size, void *user_data)
+{
+	uint8_t event = l_get_u8(buf);
+	struct mesh_io *io = user_data;
+
+	switch (event) {
+	case BT_HCI_EVT_LE_ADV_REPORT:
+		event_adv_report(io, buf + 1, size - 1);
+		break;
+
+	default:
+		l_info("Other Meta Evt - %d", event);
+	}
+}
+
+static bool dev_init(uint16_t index, struct mesh_io *io)
+{
+	struct mesh_io_private *tmp;
+
+	if (!io || io->pvt)
+		return false;
+
+	tmp = l_new(struct mesh_io_private, 1);
+
+	if (tmp == NULL)
+		return false;
+
+	tmp->rx_regs = l_queue_new();
+	tmp->tx_pkts = l_queue_new();
+	if (!tmp->rx_regs || !tmp->tx_pkts)
+		goto fail;
+
+	tmp->hci = bt_hci_new_user_channel(index);
+	if (!tmp->hci)
+		goto fail;
+
+	bt_hci_register(tmp->hci, BT_HCI_EVT_LE_META_EVENT,
+						event_callback, io, NULL);
+
+	io->pvt = tmp;
+	return true;
+
+fail:
+	l_queue_destroy(tmp->rx_regs, l_free);
+	l_queue_destroy(tmp->tx_pkts, l_free);
+	l_free(tmp);
+	return false;
+}
+
+static bool dev_destroy(struct mesh_io *io)
+{
+	struct mesh_io_private *pvt = io->pvt;
+
+	if (!pvt)
+		return true;
+
+	bt_hci_unref(pvt->hci);
+	l_timeout_remove(pvt->tx_timeout);
+	l_queue_destroy(pvt->rx_regs, l_free);
+	l_queue_destroy(pvt->tx_pkts, l_free);
+	l_free(pvt);
+	io->pvt = NULL;
+
+	return true;
+}
+
+static bool dev_caps(struct mesh_io *io, struct mesh_io_caps *caps)
+{
+	struct mesh_io_private *pvt = io->pvt;
+
+	if (!pvt || !caps)
+		return false;
+
+	caps->max_num_filters = sizeof(pvt->filters);
+	caps->window_accuracy = 50;
+
+	return true;
+}
+
+static void send_cancel_done(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct bt_hci_cmd_le_set_random_address cmd;
+
+	if (!pvt)
+		return;
+
+	pvt->sending = false;
+
+	/* At end of any burst of ADVs, change random address */
+	l_getrandom(cmd.addr, 6);
+	cmd.addr[5] |= 0xc0;
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_RANDOM_ADDRESS,
+				&cmd, sizeof(cmd), NULL, NULL, NULL);
+}
+
+static void send_cancel(struct mesh_io_private *pvt)
+{
+	struct bt_hci_cmd_le_set_adv_enable cmd;
+
+	if (!pvt)
+		return;
+
+	if (!pvt->sending) {
+		send_cancel_done(NULL, 0, pvt);
+		return;
+	}
+
+	cmd.enable = 0x00;	/* Disable advertising */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_ADV_ENABLE,
+				&cmd, sizeof(cmd),
+				send_cancel_done, pvt, NULL);
+}
+
+static void set_send_adv_enable(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct bt_hci_cmd_le_set_adv_enable cmd;
+
+	if (!pvt)
+		return;
+
+	pvt->sending = true;
+	cmd.enable = 0x01;	/* Enable advertising */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_ADV_ENABLE,
+				&cmd, sizeof(cmd), NULL, NULL, NULL);
+}
+
+static void set_send_adv_data(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct tx_pkt *tx;
+	struct bt_hci_cmd_le_set_adv_data cmd;
+
+	if (!pvt || !pvt->tx)
+		return;
+
+	tx = pvt->tx;
+	if (tx->len >= sizeof(cmd.data))
+		goto done;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.len = tx->len + 1;
+	cmd.data[0] = tx->len;
+	memcpy(cmd.data + 1, tx->pkt, tx->len);
+
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_ADV_DATA,
+					&cmd, sizeof(cmd),
+					set_send_adv_enable, pvt, NULL);
+done:
+	if (tx->delete)
+		l_free(tx);
+
+	pvt->tx = NULL;
+}
+
+static void set_send_adv_params(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct bt_hci_cmd_le_set_adv_parameters cmd;
+	uint16_t hci_interval;
+
+	if (!pvt)
+		return;
+
+	hci_interval = (pvt->interval * 16) / 10;
+	cmd.min_interval = L_CPU_TO_LE16(hci_interval);
+	cmd.max_interval = L_CPU_TO_LE16(hci_interval);
+	cmd.type = 0x03; /* ADV_NONCONN_IND */
+	cmd.own_addr_type = 0x01; /* ADDR_TYPE_RANDOM */
+	cmd.direct_addr_type = 0x00;
+	memset(cmd.direct_addr, 0, 6);
+	cmd.channel_map = 0x07;
+	cmd.filter_policy = 0x03;
+
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_ADV_PARAMETERS,
+				&cmd, sizeof(cmd),
+				set_send_adv_data, pvt, NULL);
+}
+
+static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
+							uint16_t interval)
+{
+	struct bt_hci_cmd_le_set_adv_enable cmd;
+
+	pvt->tx = tx;
+	pvt->interval = interval;
+
+	if (!pvt->sending) {
+		set_send_adv_params(NULL, 0, pvt);
+		return;
+	}
+
+	cmd.enable = 0x00;	/* Disable advertising */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_ADV_ENABLE,
+				&cmd, sizeof(cmd),
+				set_send_adv_params, pvt, NULL);
+}
+
+static void tx_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct tx_pkt *tx;
+	uint16_t ms;
+	uint8_t count;
+
+	if (!pvt)
+		return;
+
+	tx = l_queue_pop_head(pvt->tx_pkts);
+	if (!tx) {
+		l_timeout_remove(timeout);
+		pvt->tx_timeout = NULL;
+		send_cancel(pvt);
+		return;
+	}
+
+	if (tx->info.type == MESH_IO_TIMING_TYPE_GENERAL) {
+		ms = tx->info.u.gen.interval;
+		count = tx->info.u.gen.cnt;
+		if (count != MESH_IO_TX_COUNT_UNLIMITED)
+			tx->info.u.gen.cnt--;
+	} else {
+		ms = 25;
+		count = 1;
+	}
+
+	tx->delete = !!(count == 1);
+
+	send_pkt(pvt, tx, ms);
+
+	if (count == 1) {
+		/* send_pkt will delete when done */
+		tx = l_queue_peek_head(pvt->tx_pkts);
+		if (tx && tx->info.type == MESH_IO_TIMING_TYPE_POLL_RSP) {
+			ms = instant_remaining_ms(tx->info.u.poll_rsp.instant +
+						tx->info.u.poll_rsp.delay);
+		}
+	} else
+		l_queue_push_tail(pvt->tx_pkts, tx);
+
+	if (timeout) {
+		pvt->tx_timeout = timeout;
+		l_timeout_modify_ms(timeout, ms);
+	} else
+		pvt->tx_timeout = l_timeout_create_ms(ms, tx_timeout,
+								pvt, NULL);
+}
+
+static void tx_worker(void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct tx_pkt *tx;
+	uint32_t delay;
+
+	tx = l_queue_peek_head(pvt->tx_pkts);
+	if (!tx)
+		return;
+
+	switch (tx->info.type) {
+	case MESH_IO_TIMING_TYPE_GENERAL:
+		if (tx->info.u.gen.min_delay == tx->info.u.gen.max_delay)
+			delay = tx->info.u.gen.min_delay;
+		else {
+			l_getrandom(&delay, sizeof(delay));
+			delay %= tx->info.u.gen.max_delay -
+						tx->info.u.gen.min_delay;
+			delay += tx->info.u.gen.min_delay;
+		}
+		break;
+
+	case MESH_IO_TIMING_TYPE_POLL:
+		if (tx->info.u.poll.min_delay == tx->info.u.poll.max_delay)
+			delay = tx->info.u.poll.min_delay;
+		else {
+			l_getrandom(&delay, sizeof(delay));
+			delay %= tx->info.u.poll.max_delay -
+						tx->info.u.poll.min_delay;
+			delay += tx->info.u.poll.min_delay;
+		}
+		break;
+
+	case MESH_IO_TIMING_TYPE_POLL_RSP:
+		/* Delay until Instant + Delay */
+		delay = instant_remaining_ms(tx->info.u.poll_rsp.instant +
+						tx->info.u.poll_rsp.delay);
+		if (delay > 255)
+			delay = 0;
+		break;
+
+	default:
+		return;
+	}
+
+	if (!delay)
+		tx_timeout(pvt->tx_timeout, pvt);
+	else if (pvt->tx_timeout)
+		l_timeout_modify_ms(pvt->tx_timeout, delay);
+	else
+		pvt->tx_timeout = l_timeout_create_ms(delay, tx_timeout,
+								pvt, NULL);
+}
+
+static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	struct mesh_io_private *pvt = io->pvt;
+	struct tx_pkt *tx;
+	bool sending = false;
+
+	if (!info || !data || !len || len > sizeof(tx->pkt))
+		return false;
+
+
+	tx = l_new(struct tx_pkt, 1);
+	if (!tx)
+		return false;
+
+	memcpy(&tx->info, info, sizeof(tx->info));
+	memcpy(&tx->pkt, data, len);
+	tx->len = len;
+
+	if (info->type == MESH_IO_TIMING_TYPE_POLL_RSP)
+		l_queue_push_head(pvt->tx_pkts, tx);
+	else {
+		sending = !l_queue_isempty(pvt->tx_pkts);
+		l_queue_push_tail(pvt->tx_pkts, tx);
+	}
+
+	if (!sending) {
+		l_timeout_remove(pvt->tx_timeout);
+		pvt->tx_timeout = NULL;
+		l_idle_oneshot(tx_worker, pvt, NULL);
+	}
+
+	return true;
+}
+
+static bool find_by_ad_type(const void *a, const void *b)
+{
+	const struct tx_pkt *tx = a;
+	uint8_t ad_type = L_PTR_TO_UINT(b);
+
+	return !ad_type || ad_type == tx->pkt[0];
+}
+
+static bool find_by_pattern(const void *a, const void *b)
+{
+	const struct tx_pkt *tx = a;
+	const struct tx_pattern *pattern = b;
+
+	if (tx->len < pattern->len)
+		return false;
+
+	return (!memcmp(tx->pkt, pattern->data, pattern->len));
+}
+
+static bool tx_cancel(struct mesh_io *io, uint8_t *data, uint8_t len)
+{
+	struct mesh_io_private *pvt = io->pvt;
+	struct tx_pkt *tx;
+
+	if (!data)
+		return false;
+
+	if (len == 1) {
+		do {
+			tx = l_queue_remove_if(pvt->tx_pkts, find_by_ad_type,
+							L_UINT_TO_PTR(data[0]));
+			l_free(tx);
+		} while (tx);
+	}  else {
+		struct tx_pattern pattern = {
+			.data = data,
+			.len = len
+		};
+
+		do {
+			tx = l_queue_remove_if(pvt->tx_pkts, find_by_pattern,
+								&pattern);
+			l_free(tx);
+		} while (tx);
+	}
+
+	if (l_queue_isempty(pvt->tx_pkts)) {
+		send_cancel(pvt);
+		l_timeout_remove(pvt->tx_timeout);
+		pvt->tx_timeout = NULL;
+	}
+
+	return true;
+}
+
+static bool find_by_filter_id(const void *a, const void *b)
+{
+	const struct pvt_rx_reg *rx_reg = a;
+	uint8_t filter_id = L_PTR_TO_UINT(b);
+
+	return rx_reg->filter_id == filter_id;
+}
+
+static bool recv_register(struct mesh_io *io, uint8_t filter_id,
+				mesh_io_recv_func_t cb, void *user_data)
+{
+	struct bt_hci_cmd_le_set_scan_enable cmd;
+	struct mesh_io_private *pvt = io->pvt;
+	struct pvt_rx_reg *rx_reg;
+	bool scanning;
+
+	l_info("%s %d", __func__, filter_id);
+	if (!cb || !filter_id || filter_id > sizeof(pvt->filters))
+		return false;
+
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter_id,
+						L_UINT_TO_PTR(filter_id));
+
+	if (!rx_reg) {
+		rx_reg = l_new(struct pvt_rx_reg, 1);
+		if (!rx_reg)
+			return false;
+	}
+
+	rx_reg->filter_id = filter_id;
+	rx_reg->cb = cb;
+	rx_reg->user_data = user_data;
+
+	scanning = !l_queue_isempty(pvt->rx_regs);
+
+	l_queue_push_head(pvt->rx_regs, rx_reg);
+
+	if (!scanning) {
+		cmd.enable = 0x01;	/* Enable scanning */
+		cmd.filter_dup = 0x00;	/* Report duplicates */
+		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+				&cmd, sizeof(cmd), NULL, NULL, NULL);
+	}
+
+	return true;
+}
+
+static bool recv_deregister(struct mesh_io *io, uint8_t filter_id)
+{
+	struct bt_hci_cmd_le_set_scan_enable cmd;
+	struct mesh_io_private *pvt = io->pvt;
+
+	struct pvt_rx_reg *rx_reg;
+
+	rx_reg = l_queue_remove_if(pvt->rx_regs, find_by_filter_id,
+						L_UINT_TO_PTR(filter_id));
+
+	if (rx_reg)
+		l_free(rx_reg);
+
+	if (l_queue_isempty(pvt->rx_regs)) {
+		cmd.enable = 0x00;	/* Disable scanning */
+		cmd.filter_dup = 0x00;	/* Report duplicates */
+		bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+				&cmd, sizeof(cmd), NULL, NULL, NULL);
+
+	}
+
+	return true;
+}
+
+static bool filter_set(struct mesh_io *io,
+		uint8_t filter_id, const uint8_t *data, uint8_t len,
+		mesh_io_status_func_t callback, void *user_data)
+{
+	struct mesh_io_private *pvt = io->pvt;
+
+	l_info("%s id: %d, --> %2.2x", __func__, filter_id, data[0]);
+	if (!data || !len || !filter_id || filter_id > sizeof(pvt->filters))
+		return false;
+
+	pvt->filters[filter_id - 1] = data[0];
+
+	/* TODO: Delayed Call to successful status */
+
+	return true;
+}
+
+const struct mesh_io_api mesh_io_generic = {
+	.init = dev_init,
+	.destroy = dev_destroy,
+	.caps = dev_caps,
+	.send = send_tx,
+	.reg = recv_register,
+	.dereg = recv_deregister,
+	.set = filter_set,
+	.cancel = tx_cancel,
+};
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
new file mode 100644
index 000000000..762eb2c6f
--- /dev/null
+++ b/mesh/mesh-io.c
@@ -0,0 +1,187 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <ell/ell.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+
+#include "mesh/mesh-defs.h"
+
+#include "mesh/mesh-io.h"
+#include "mesh/mesh-io-api.h"
+
+/* List of Mesh-IO Type headers */
+#include "mesh/mesh-io-generic.h"
+
+/* List of Supported Mesh-IO Types */
+static const struct mesh_io_table table[] = {
+	{MESH_IO_TYPE_GENERIC,	&mesh_io_generic},
+};
+
+static struct l_queue *io_list;
+
+static bool match_by_io(const void *a, const void *b)
+{
+	return a == b;
+}
+
+static bool match_by_index(const void *a, const void *b)
+{
+	const struct mesh_io *io = a;
+
+	return io->index == L_PTR_TO_UINT(b);
+}
+
+struct mesh_io *mesh_io_new(uint16_t index, enum mesh_io_type type)
+{
+	const struct mesh_io_api	*api = NULL;
+	struct mesh_io			*io;
+	uint16_t			i;
+
+	l_info("%s %d\n", __func__, type);
+	for (i = 0; i < L_ARRAY_SIZE(table); i++) {
+		if (table[i].type == type) {
+			api = table[i].api;
+			break;
+		}
+	}
+
+	io = l_queue_find(io_list, match_by_index, L_UINT_TO_PTR(index));
+
+	if (api == NULL || api->init == NULL || io != NULL)
+		return NULL;
+
+	io = l_new(struct mesh_io, 1);
+
+	if (io == NULL)
+		return NULL;
+
+	io->type = type;
+	io->index = index;
+	io->api = api;
+	if (!api->init(index, io))
+		goto fail;
+
+	if (io_list == NULL)
+		io_list = l_queue_new();
+
+	if (api->set) {
+		uint8_t pkt = MESH_AD_TYPE_NETWORK;
+		uint8_t bec = MESH_AD_TYPE_BEACON;
+		uint8_t prv = MESH_AD_TYPE_PROVISION;
+
+		api->set(io, 1, &bec, 1, NULL, NULL);
+		api->set(io, 2, &prv, 1, NULL, NULL);
+		api->set(io, 3, &pkt, 1, NULL, NULL);
+	}
+
+	if (l_queue_push_head(io_list, io))
+		return io;
+
+fail:
+	if (api->destroy)
+		api->destroy(io);
+
+	l_free(io);
+	return NULL;
+}
+
+void mesh_io_destroy(struct mesh_io *io)
+{
+	io = l_queue_remove_if(io_list, match_by_io, io);
+
+	if (io && io->api && io->api->destroy)
+		io->api->destroy(io);
+
+	l_free(io);
+
+	if (l_queue_isempty(io_list)) {
+		l_queue_destroy(io_list, NULL);
+		io_list = NULL;
+	}
+}
+
+bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps)
+{
+	io = l_queue_find(io_list, match_by_io, io);
+
+	if (io && io->api && io->api->caps)
+		return io->api->caps(io, caps);
+
+	return false;
+}
+
+bool mesh_io_register_recv_cb(struct mesh_io *io, uint8_t filter_id,
+				mesh_io_recv_func_t cb, void *user_data)
+{
+	io = l_queue_find(io_list, match_by_io, io);
+
+	if (io && io->api && io->api->reg)
+		return io->api->reg(io, filter_id, cb, user_data);
+
+	return false;
+}
+
+bool mesh_io_deregister_recv_cb(struct mesh_io *io, uint8_t filter_id)
+{
+	io = l_queue_find(io_list, match_by_io, io);
+
+	if (io && io->api && io->api->dereg)
+		return io->api->dereg(io, filter_id);
+
+	return false;
+}
+
+bool mesh_set_filter(struct mesh_io *io, uint8_t filter_id,
+				const uint8_t *data, uint8_t len,
+				mesh_io_status_func_t cb, void *user_data)
+{
+	io = l_queue_find(io_list, match_by_io, io);
+
+	if (io && io->api && io->api->set)
+		return io->api->set(io, filter_id, data, len, cb, user_data);
+
+	return false;
+}
+
+bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
+					const uint8_t *data, uint16_t len)
+{
+	io = l_queue_find(io_list, match_by_io, io);
+
+	if (io && io->api && io->api->send)
+		return io->api->send(io, info, data, len);
+
+	return false;
+}
+
+bool mesh_io_send_cancel(struct mesh_io *io, uint8_t *pattern, uint8_t len)
+{
+	io = l_queue_find(io_list, match_by_io, io);
+
+	if (io && io->api && io->api->cancel)
+		return io->api->cancel(io, pattern, len);
+
+	return false;
+}
-- 
2.14.4

