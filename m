Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	inga.stotland@intel.com
Subject: [PATCH BlueZ v5 09/14] mesh: Source files for mesh access layer and utilities
Date: Fri,  6 Jul 2018 10:13:01 -0700
Message-Id: <20180706171306.13501-10-brian.gix@intel.com>
In-Reply-To: <20180706171306.13501-1-brian.gix@intel.com>
References: <20180706171306.13501-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Inga Stotland <inga.stotland@intel.com>

This adds initial implementation of BT Mesh access layer
functionality plus utilities.
---
 mesh/agent.c   | 229 ++++++++++++++++
 mesh/appkey.c  | 536 ++++++++++++++++++++++++++++++++++++
 mesh/btmesh.c  | 176 ++++++++++++
 mesh/main.c    | 174 ++++++++++++
 mesh/mesh.c    | 184 +++++++++++++
 mesh/node.c    | 851 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/storage.c | 672 +++++++++++++++++++++++++++++++++++++++++++++
 mesh/util.c    |  71 +++++
 8 files changed, 2893 insertions(+)
 create mode 100644 mesh/agent.c
 create mode 100644 mesh/appkey.c
 create mode 100644 mesh/btmesh.c
 create mode 100644 mesh/main.c
 create mode 100644 mesh/mesh.c
 create mode 100644 mesh/node.c
 create mode 100644 mesh/storage.c
 create mode 100644 mesh/util.c

diff --git a/mesh/agent.c b/mesh/agent.c
new file mode 100644
index 000000000..1da10b7bd
--- /dev/null
+++ b/mesh/agent.c
@@ -0,0 +1,229 @@
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include <ell/ell.h>
+
+#include "src/shared/shell.h"
+
+#include "mesh/util.h"
+#include "mesh/agent.h"
+
+struct input_request {
+	enum oob_type type;
+	uint16_t len;
+	agent_input_cb cb;
+	void *user_data;
+};
+
+static struct input_request pending_request = {NONE, 0, NULL, NULL};
+
+bool agent_completion(void)
+{
+	if (pending_request.type == NONE)
+		return false;
+
+	return true;
+}
+
+static void reset_input_request(void)
+{
+	pending_request.type = NONE;
+	pending_request.len = 0;
+	pending_request.cb = NULL;
+	pending_request.user_data = NULL;
+}
+
+static void try_again(void)
+{
+	static int try_count;
+	enum oob_type type = pending_request.type;
+
+	if (try_count == 2) {
+		reset_input_request();
+		try_count = 0;
+		return;
+	}
+
+	pending_request.type = NONE;
+	agent_input_request(type, pending_request.len, pending_request.cb,
+						pending_request.user_data);
+
+	try_count++;
+}
+
+static void response_hexadecimal(const char *input, void *user_data)
+{
+	uint8_t buf[MAX_HEXADECIMAL_OOB_LEN];
+
+	if (!str2hex(input, strlen(input), buf, pending_request.len)) {
+		bt_shell_printf("Incorrect input: expecting %d hex octets\n",
+							pending_request.len);
+		try_again();
+		return;
+	}
+
+	if (pending_request.cb)
+		pending_request.cb(HEXADECIMAL, buf, pending_request.len,
+					pending_request.user_data);
+
+	reset_input_request();
+}
+
+static void response_decimal(const char *input, void *user_data)
+{
+	uint8_t buf[DECIMAL_OOB_LEN];
+
+	if (strlen(input) > pending_request.len) {
+		bt_shell_printf("Bad input: expected no more than %d digits\n",
+						pending_request.len);
+		try_again();
+		return;
+	}
+
+	l_put_be32(atoi(input), buf);
+
+	if (pending_request.cb)
+		pending_request.cb(DECIMAL, buf, DECIMAL_OOB_LEN,
+					pending_request.user_data);
+
+	reset_input_request();
+}
+
+static void response_ascii(const char *input, void *user_data)
+{
+	if (pending_request.cb)
+		pending_request.cb(ASCII, (uint8_t *) input, strlen(input),
+					pending_request.user_data);
+
+	reset_input_request();
+}
+
+static bool request_hexadecimal(uint16_t len)
+{
+	if (len > MAX_HEXADECIMAL_OOB_LEN)
+		return false;
+
+	bt_shell_printf("Request hexadecimal key (hex %d octets)\n", len);
+	bt_shell_prompt_input("mesh", "Enter key (hex number):",
+						response_hexadecimal, NULL);
+
+	return true;
+}
+
+static uint32_t power_ten(uint8_t power)
+{
+	uint32_t ret = 1;
+
+	while (power--)
+		ret *= 10;
+
+	return ret;
+}
+
+static bool request_decimal(uint16_t len)
+{
+	bt_shell_printf("Request decimal key (0 - %d)\n", power_ten(len) - 1);
+	bt_shell_prompt_input("mesh", "Enter Numeric key:", response_decimal,
+									NULL);
+
+	return true;
+}
+
+static bool request_ascii(uint16_t len)
+{
+	if (len > MAX_ASCII_OOB_LEN)
+		return false;
+
+	bt_shell_printf("Request ASCII key (max characters %d)\n", len);
+	bt_shell_prompt_input("mesh", "Enter key (ascii string):",
+							response_ascii, NULL);
+
+	return true;
+}
+
+bool agent_input_request(enum oob_type type, uint16_t max_len,
+					agent_input_cb cb, void *user_data)
+{
+	bool result;
+
+	if (pending_request.type != NONE)
+		return false;
+
+	switch (type) {
+	case HEXADECIMAL:
+		result = request_hexadecimal(max_len);
+		break;
+	case DECIMAL:
+		result = request_decimal(max_len);
+		break;
+	case ASCII:
+		result = request_ascii(max_len);
+		break;
+	case NONE:
+	case OUTPUT:
+	default:
+		return false;
+	};
+
+	if (result) {
+		pending_request.type = type;
+		pending_request.len = max_len;
+		pending_request.cb = cb;
+		pending_request.user_data = user_data;
+
+		return true;
+	}
+
+	return false;
+}
+
+static void response_output(const char *input, void *user_data)
+{
+	reset_input_request();
+}
+
+bool agent_output_request(const char *str)
+{
+	if (pending_request.type != NONE)
+		return false;
+
+	pending_request.type = OUTPUT;
+	bt_shell_prompt_input("mesh", str, response_output, NULL);
+	return true;
+}
+
+void agent_output_request_cancel(void)
+{
+	if (pending_request.type != OUTPUT)
+		return;
+
+	pending_request.type = NONE;
+	bt_shell_release_prompt("");
+}
diff --git a/mesh/appkey.c b/mesh/appkey.c
new file mode 100644
index 000000000..2ddb1eb80
--- /dev/null
+++ b/mesh/appkey.c
@@ -0,0 +1,536 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <ell/ell.h>
+
+#include "mesh/mesh-defs.h"
+
+#include "mesh/mesh.h"
+#include "mesh/node.h"
+#include "mesh/net.h"
+#include "mesh/crypto.h"
+#include "mesh/display.h"
+#include "mesh/model.h"
+#include "mesh/storage.h"
+#include "mesh/appkey.h"
+
+struct mesh_app_key {
+	struct l_queue *replay_cache;
+	uint16_t net_idx;
+	uint16_t app_idx;
+	uint8_t key[16];
+	uint8_t key_id;
+	uint8_t new_key[16];
+	uint8_t new_key_id;
+};
+
+struct mesh_msg {
+	uint32_t iv_index;
+	uint32_t seq;
+	uint16_t src;
+};
+
+struct mod_decrypt {
+	const uint8_t *data;
+	uint8_t *out;
+	struct mesh_app_key *key;
+	uint8_t *virt;
+	uint32_t seq;
+	uint32_t iv_idx;
+	uint16_t src;
+	uint16_t dst;
+	uint16_t idx;
+	uint16_t size;
+	uint16_t virt_size;
+	uint8_t key_id;
+	bool szmict;
+	bool decrypted;
+};
+
+static bool match_key_index(const void *a, const void *b)
+{
+	const struct mesh_app_key *key = a;
+	uint16_t idx = L_PTR_TO_UINT(b);
+
+	return key->app_idx == idx;
+}
+
+static bool match_replay_cache(const void *a, const void *b)
+{
+	const struct mesh_msg *msg = a;
+	uint16_t src = L_PTR_TO_UINT(b);
+
+	return src == msg->src;
+}
+
+static bool clean_old_iv_index(void *a, void *b)
+{
+	struct mesh_msg *msg = a;
+	uint32_t iv_index = L_PTR_TO_UINT(b);
+
+	if (iv_index < 2)
+		return false;
+
+	if (msg->iv_index < iv_index - 1) {
+		l_free(msg);
+		return true;
+	}
+
+	return false;
+}
+
+static void packet_decrypt(void *a, void *b)
+{
+	struct mesh_app_key *key = a;
+	struct mod_decrypt *dec = b;
+
+	l_debug("model.c - app_packet_decrypt");
+	if (dec->decrypted)
+		return;
+
+	if (key->key_id != dec->key_id &&
+			key->new_key_id != dec->key_id)
+		return;
+
+	dec->key = key;
+
+	if (key->key_id == dec->key_id) {
+		dec->decrypted = mesh_crypto_payload_decrypt(dec->virt,
+				dec->virt_size, dec->data, dec->size,
+				dec->szmict, dec->src, dec->dst, dec->key_id,
+				dec->seq, dec->iv_idx, dec->out, key->key);
+		if (dec->decrypted)
+			print_packet("Used App Key", dec->key->key, 16);
+		else
+			print_packet("Failed with App Key", dec->key->key, 16);
+	}
+
+	if (!dec->decrypted && key->new_key_id == dec->key_id) {
+		dec->decrypted = mesh_crypto_payload_decrypt(dec->virt,
+				dec->virt_size, dec->data, dec->size,
+				dec->szmict, dec->src, dec->dst, dec->key_id,
+				dec->seq, dec->iv_idx, dec->out, key->new_key);
+		if (dec->decrypted)
+			print_packet("Used App Key", dec->key->new_key, 16);
+		else
+			print_packet("Failed with App Key",
+							dec->key->new_key, 16);
+	}
+
+	if (dec->decrypted)
+		dec->idx = key->app_idx;
+}
+
+int appkey_packet_decrypt(struct mesh_net *net, bool szmict, uint32_t seq,
+				uint32_t iv_index, uint16_t src,
+				uint16_t dst, uint8_t *virt, uint16_t virt_size,
+				uint8_t key_id, const uint8_t *data,
+				uint16_t data_size, uint8_t *out)
+{
+	struct l_queue *app_keys;
+
+	struct mod_decrypt decrypt = {
+		.src = src,
+		.dst = dst,
+		.seq = seq,
+		.data = data,
+		.out = out,
+		.size = data_size,
+		.key_id = key_id,
+		.iv_idx = iv_index,
+		.virt = virt,
+		.virt_size = virt_size,
+		.szmict = szmict,
+		.decrypted = false,
+	};
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return -1;
+
+	l_queue_foreach(app_keys, packet_decrypt, &decrypt);
+
+	return decrypt.decrypted ? decrypt.idx : -1;
+}
+
+bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
+				uint16_t src, uint16_t crpl, uint32_t seq,
+				uint32_t iv_index)
+{
+	struct mesh_app_key *key;
+	struct mesh_msg *msg;
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return false;
+
+	l_debug("Test Replay src: %4.4x seq: %6.6x iv: %8.8x",
+						src, seq, iv_index);
+
+	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(idx));
+
+	if (!key)
+		return false;
+
+	msg = l_queue_find(key->replay_cache, match_replay_cache,
+						L_UINT_TO_PTR(src));
+
+	if (msg) {
+		if (iv_index > msg->iv_index) {
+			msg->seq = seq;
+			msg->iv_index = iv_index;
+			return false;
+		}
+
+		if (seq < msg->seq) {
+			l_info("Ignoring packet with lower sequence number");
+			return true;
+		}
+
+		if (seq == msg->seq) {
+			l_info("Message already processed (duplicate)");
+			return true;
+		}
+
+		msg->seq = seq;
+
+		return false;
+	}
+
+	l_debug("New Entry for %4.4x", src);
+	if (key->replay_cache == NULL)
+		key->replay_cache = l_queue_new();
+
+	/* Replay Cache is fixed sized */
+	if (l_queue_length(key->replay_cache) >= crpl) {
+		int ret = l_queue_foreach_remove(key->replay_cache,
+				clean_old_iv_index, L_UINT_TO_PTR(iv_index));
+
+		if (!ret)
+			return true;
+	}
+
+	msg = l_new(struct mesh_msg, 1);
+	msg->src = src;
+	msg->seq = seq;
+	msg->iv_index = iv_index;
+	l_queue_push_head(key->replay_cache, msg);
+
+	return false;
+}
+
+static struct mesh_app_key *app_key_new(void)
+{
+	struct mesh_app_key *key = l_new(struct mesh_app_key, 1);
+
+	key->new_key_id = 0xFF;
+	key->replay_cache = l_queue_new();
+	return key;
+}
+
+static bool set_key(struct mesh_app_key *key, uint16_t app_idx,
+			const uint8_t *key_value, bool is_new)
+{
+	uint8_t key_id;
+
+	if (!mesh_crypto_k4(key_value, &key_id))
+		return false;
+
+	key_id = KEY_ID_AKF | (key_id << KEY_AID_SHIFT);
+	if (!is_new)
+		key->key_id = key_id;
+	else
+		key->new_key_id = key_id;
+
+	memcpy(is_new ? key->new_key : key->key, key_value, 16);
+
+	return true;
+}
+
+void appkey_key_free(void *data)
+{
+	struct mesh_app_key *key = data;
+
+	if (!key)
+		return;
+
+	l_queue_destroy(key->replay_cache, l_free);
+	l_free(key);
+}
+
+bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
+				uint8_t *key_value, uint8_t *new_key_value)
+{
+	struct mesh_app_key *key;
+	struct l_queue *app_keys;
+
+	if (net_idx > MAX_KEY_IDX || app_idx > MAX_KEY_IDX)
+		return false;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return NULL;
+
+	key = app_key_new();
+	if (!key)
+		return false;
+
+	if (!mesh_net_have_key(net, net_idx))
+		return false;
+
+	key->net_idx = net_idx;
+
+	if (key_value && !set_key(key, app_idx, key_value, false))
+		return false;
+
+	if (new_key_value && !set_key(key, app_idx, new_key_value, true))
+		return false;
+
+	l_queue_push_tail(app_keys, key);
+
+	return true;
+}
+
+const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
+							uint8_t *key_id)
+{
+	struct mesh_app_key *app_key;
+	uint8_t phase;
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return NULL;
+
+	app_key = l_queue_find(app_keys, match_key_index,
+							L_UINT_TO_PTR(app_idx));
+	if (!app_key)
+		return NULL;
+
+	if (mesh_net_key_refresh_phase_get(net, app_key->net_idx, &phase) !=
+							MESH_STATUS_SUCCESS)
+		return NULL;
+
+	if (phase != KEY_REFRESH_PHASE_TWO) {
+		*key_id = app_key->key_id;
+		return app_key->key;
+	}
+
+	if (app_key->new_key_id == NET_NID_INVALID)
+		return NULL;
+
+	*key_id = app_key->new_key_id;
+	return app_key->new_key;
+}
+
+bool appkey_have_key(struct mesh_net *net, uint16_t app_idx)
+{
+	struct mesh_app_key *key;
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return false;
+
+	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
+
+	if (!key)
+		return false;
+	else
+		return true;
+}
+
+int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
+					const uint8_t *new_key, bool update)
+{
+	struct mesh_app_key *key;
+	struct l_queue *app_keys;
+	uint8_t phase = KEY_REFRESH_PHASE_NONE;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return MESH_STATUS_INSUFF_RESOURCES;
+
+	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
+
+	if (!mesh_net_have_key(net, net_idx) ||
+					(update && key->net_idx != net_idx))
+		return MESH_STATUS_INVALID_NETKEY;
+
+	if (update && !key)
+		return MESH_STATUS_INVALID_APPKEY;
+
+	mesh_net_key_refresh_phase_get(net, net_idx, &phase);
+	if (update && phase != KEY_REFRESH_PHASE_ONE)
+		return MESH_STATUS_CANNOT_UPDATE;
+
+	if (key) {
+		if (memcmp(new_key, key->key, 16) == 0)
+			return MESH_STATUS_SUCCESS;
+
+		if (!update) {
+			l_info("Failed to add key: index already stored %x",
+				(net_idx << 16) | app_idx);
+			return MESH_STATUS_IDX_ALREADY_STORED;
+		}
+	}
+
+	if (!key) {
+		if (l_queue_length(app_keys) <= MAX_APP_KEYS)
+			return MESH_STATUS_INSUFF_RESOURCES;
+
+		key = app_key_new();
+		if (!key)
+			return MESH_STATUS_INSUFF_RESOURCES;
+
+		if (!set_key(key, app_idx, new_key, false)) {
+			appkey_key_free(key);
+			return MESH_STATUS_INSUFF_RESOURCES;
+		}
+
+		if (!storage_local_app_key_add(net, net_idx, app_idx, new_key,
+								false)) {
+			appkey_key_free(key);
+			return MESH_STATUS_STORAGE_FAIL;
+		}
+
+		key->net_idx = net_idx;
+		key->app_idx = app_idx;
+		l_queue_push_tail(app_keys, key);
+	} else {
+		if (!set_key(key, app_idx, new_key, true))
+			return MESH_STATUS_INSUFF_RESOURCES;
+
+		if (!storage_local_app_key_add(net, net_idx, app_idx, new_key,
+								true))
+			return MESH_STATUS_STORAGE_FAIL;
+	}
+
+	l_queue_clear(key->replay_cache, l_free);
+
+	return MESH_STATUS_SUCCESS;
+}
+
+int appkey_key_delete(struct mesh_net *net, uint16_t net_idx,
+							uint16_t app_idx)
+{
+	struct mesh_app_key *key;
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return MESH_STATUS_INVALID_APPKEY;
+
+	key = l_queue_find(app_keys, match_key_index, L_UINT_TO_PTR(app_idx));
+
+	if (!key)
+		return MESH_STATUS_INVALID_APPKEY;
+
+	if (key->net_idx != net_idx)
+		return MESH_STATUS_INVALID_NETKEY;
+
+	node_app_key_delete(net, mesh_net_get_address(net), net_idx, app_idx);
+
+	l_queue_remove(app_keys, key);
+	appkey_key_free(key);
+
+	if (!storage_local_app_key_del(net, net_idx, app_idx))
+		return MESH_STATUS_STORAGE_FAIL;
+
+	return MESH_STATUS_SUCCESS;
+}
+
+void appkey_delete_bound_keys(struct mesh_net *net, uint16_t net_idx)
+{
+	const struct l_queue_entry *entry;
+	struct l_queue *app_keys;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys)
+		return;
+
+	entry = l_queue_get_entries(app_keys);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_app_key *key = entry->data;
+
+		appkey_key_delete(net, net_idx, key->app_idx);
+	}
+}
+
+uint8_t appkey_list(struct mesh_net *net, uint16_t net_idx, uint8_t *buf,
+					uint16_t buf_size, uint16_t *size)
+{
+	const struct l_queue_entry *entry;
+	uint32_t idx_pair;
+	int i;
+	uint16_t datalen;
+	struct l_queue *app_keys;
+
+	*size = 0;
+
+	app_keys = mesh_net_get_app_keys(net);
+	if (!app_keys || l_queue_isempty(app_keys))
+		return MESH_STATUS_SUCCESS;
+
+	idx_pair = 0;
+	i = 0;
+	datalen = 0;
+	entry = l_queue_get_entries(app_keys);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_app_key *key = entry->data;
+
+		if (net_idx != key->net_idx)
+			continue;
+
+		if (!(i & 0x1)) {
+			idx_pair = key->app_idx;
+		} else {
+			idx_pair <<= 12;
+			idx_pair += key->app_idx;
+			/* Unlikely, but check for overflow*/
+			if ((datalen + 3) > buf_size) {
+				l_warn("Appkey list too large");
+				goto done;
+			}
+			l_put_le32(idx_pair, buf);
+			buf += 3;
+			datalen += 3;
+		}
+		i++;
+	}
+
+	/* Process the last app key if present */
+	if (i & 0x1 && ((datalen + 2) <= buf_size)) {
+		l_put_le16(idx_pair, buf);
+		datalen += 2;
+	}
+
+done:
+	*size = datalen;
+
+	return MESH_STATUS_SUCCESS;
+}
diff --git a/mesh/btmesh.c b/mesh/btmesh.c
new file mode 100644
index 000000000..c312d85db
--- /dev/null
+++ b/mesh/btmesh.c
@@ -0,0 +1,176 @@
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <ctype.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <ell/ell.h>
+
+#include "src/shared/shell.h"
+#include "src/shared/mainloop.h"
+
+#include "mesh/mesh.h"
+#include "mesh/net.h"
+
+#define PROMPT COLOR_BLUE "[btmesh]" COLOR_OFF "# "
+
+static struct bt_mesh *mesh;
+
+static const struct option main_options[] = {
+	{ "index",	1,	0, 'i' },
+	{ "config",	1,	0, 'c' },
+	{ "save",	1,	0, 's' },
+	{ 0, 0, 0, 0 }
+};
+
+static const char *index_option;
+static const char *config_option;
+static const char *save_option;
+
+static const char **optargs[] = {
+	&index_option,
+	&config_option,
+	&save_option,
+};
+
+static const char *help[] = {
+	"Specify adapter index",
+	"Specify input configuration file",
+	"Specify output configuration file"
+};
+
+static const struct bt_shell_opt opt = {
+	.options = main_options,
+	.optno = sizeof(main_options) / sizeof(struct option),
+	.optstr = "i:c:s:",
+	.optarg = optargs,
+	.help = help,
+};
+
+static int get_arg_on_off(int argc, char *argv[])
+{
+	if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes"))
+		return 1;
+
+	if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no"))
+		return 0;
+
+	bt_shell_printf("Invalid argument %s\n", argv[1]);
+	return -1;
+}
+
+static void cmd_beacon(int argc, char *argv[])
+{
+	bool res;
+	int enable;
+
+	enable = get_arg_on_off(argc, argv);
+	if (enable < 0)
+		return;
+
+	res = mesh_net_set_beacon_mode(mesh_get_net(mesh), enable);
+	if (res)
+		bt_shell_printf("Local beacon mode is %s\n",
+				enable > 0 ? "enabled" : "disabled");
+	else
+		bt_shell_printf("Failed to set local beacon mode to %s\n",
+				enable > 0 ? "enabled" : "disabled");
+}
+
+static const struct bt_shell_menu main_menu = {
+	.name = "main",
+	.entries = {
+	{ "beacon",   "<enable>",  cmd_beacon, "Enable/disable beaconing"},
+	{ } },
+};
+
+static int get_index(const char *arg)
+{
+	if (strlen(arg) > 3 && !strncasecmp(arg, "hci", 3))
+		return atoi(&arg[3]);
+	else
+		return atoi(arg);
+}
+
+static void ell_event(int fd, uint32_t events, void *user_data)
+{
+	int timeout = l_main_prepare();
+
+	l_main_iterate(timeout);
+}
+
+int main(int argc, char *argv[])
+{
+	int index;
+	int fd;
+	int status;
+
+	l_log_set_stderr();
+	l_debug_enable("*");
+
+	if (!l_main_init())
+		return -1;
+
+	bt_shell_init(argc, argv, &opt);
+	bt_shell_set_menu(&main_menu);
+
+	if (!index_option) {
+		bt_shell_usage();
+		return 0;
+	}
+
+	if (config_option)
+		l_info("Reading local configuration from %s\n", config_option);
+
+	if (save_option)
+		l_info("Saving local configuration to %s\n", save_option);
+
+	bt_shell_set_prompt(PROMPT);
+
+	index = get_index(index_option);
+
+	l_info("Starting mesh on hci%d\n", index);
+
+	mesh = mesh_create(index);
+	if (!mesh || !mesh_load_config(mesh, config_option)) {
+		l_info("Failed to create mesh\n");
+		bt_shell_cleanup();
+		return EXIT_FAILURE;
+	}
+
+	if (save_option)
+		mesh_set_output(mesh, save_option);
+
+	fd = l_main_get_epoll_fd();
+	mainloop_add_fd(fd, EPOLLIN, ell_event, NULL, NULL);
+
+	status = bt_shell_attach(fileno(stdin));
+	bt_shell_run();
+
+	mesh_unref(mesh);
+	l_main_exit();
+
+	return status;
+}
diff --git a/mesh/main.c b/mesh/main.c
new file mode 100644
index 000000000..8c03f51eb
--- /dev/null
+++ b/mesh/main.c
@@ -0,0 +1,174 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <getopt.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <ctype.h>
+
+#include <sys/stat.h>
+#include <ell/ell.h>
+
+#include "mesh/mesh.h"
+#include "mesh/net.h"
+#include "mesh/storage.h"
+
+static const struct option main_options[] = {
+	{ "index",	required_argument,	NULL, 'i' },
+	{ "config",	optional_argument,	NULL, 'c' },
+	{ "nodetach",	no_argument,		NULL, 'n' },
+	{ "debug",	no_argument,		NULL, 'd' },
+	{ "help",	no_argument,		NULL, 'h' },
+	{ }
+};
+
+static void usage(void)
+{
+	l_info("");
+	l_info("Usage:\n"
+	       "\tmeshd [options]\n");
+	l_info("Options:\n"
+	       "\t--index <hcinum>  Use specified controller\n"
+	       "\t--config          Configuration file\n"
+	       "\t--nodetach        Run in foreground\n"
+	       "\t--debug           Enable debug output\n"
+	       "\t--help            Show %s information\n", __func__);
+}
+
+static void signal_handler(struct l_signal *signal, uint32_t signo,
+							void *user_data)
+{
+	static bool terminated;
+
+	switch (signo) {
+	case SIGINT:
+	case SIGTERM:
+		if (terminated)
+			return;
+		l_info("Terminating");
+		l_main_quit();
+		terminated = true;
+		break;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int status;
+	bool detached = true;
+	struct l_signal *signal;
+	sigset_t mask;
+	struct bt_mesh *mesh = NULL;
+	const char *config_file = NULL;
+
+	if (!l_main_init())
+		return -1;
+
+	l_log_set_stderr();
+
+	for (;;) {
+		int opt;
+		const char *str;
+
+		opt = getopt_long(argc, argv, "i:c:ndh", main_options, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'i':
+			if (strlen(optarg) > 3 && !strncmp(optarg, "hci", 3))
+				str = optarg + 3;
+			else
+				str = optarg;
+			if (!isdigit(*str)) {
+				l_error("Invalid controller index value");
+				status = EXIT_FAILURE;
+				goto done;
+			}
+
+			mesh = mesh_create(atoi(str));
+			if (!mesh) {
+				l_error("Failed to initialize mesh");
+				status = EXIT_FAILURE;
+				goto done;
+			}
+
+			break;
+		case 'n':
+			detached = false;
+			break;
+		case 'd':
+			l_debug_enable("*");
+			break;
+		case 'c':
+			config_file = optarg;
+			break;
+		case 'h':
+			usage();
+			status = EXIT_SUCCESS;
+			goto done;
+		default:
+			usage();
+			status = EXIT_FAILURE;
+			goto done;
+		}
+	}
+
+	if (!mesh) {
+		usage();
+		status = EXIT_FAILURE;
+		goto done;
+	}
+
+	if (!mesh_load_config(mesh, config_file)) {
+		l_error("Failed to load mesh configuration: %s", config_file);
+		status = EXIT_FAILURE;
+		goto done;
+	}
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+	signal = l_signal_create(&mask, signal_handler, NULL, NULL);
+
+	umask(0077);
+
+	if (detached) {
+		if (daemon(0, 0)) {
+			perror("Failed to start meshd daemon");
+			status = EXIT_FAILURE;
+			goto done;
+		}
+	}
+
+	status = l_main_run();
+
+	l_signal_remove(signal);
+
+done:
+	mesh_unref(mesh);
+	l_main_exit();
+
+	return status;
+}
diff --git a/mesh/mesh.c b/mesh/mesh.c
new file mode 100644
index 000000000..a6f733f5c
--- /dev/null
+++ b/mesh/mesh.c
@@ -0,0 +1,184 @@
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <time.h>
+#include <ell/ell.h>
+
+#include "lib/bluetooth.h"
+
+#include "mesh/mesh-defs.h"
+
+#include "mesh/mesh-io.h"
+#include "mesh/node.h"
+#include "mesh/net.h"
+#include "mesh/storage.h"
+#include "mesh/cfgmod.h"
+#include "mesh/model.h"
+#include "mesh/mesh.h"
+
+struct scan_filter {
+	uint8_t id;
+	const char *pattern;
+};
+
+struct bt_mesh {
+	struct mesh_net *net;
+	int ref_count;
+	struct l_queue *filters;
+	uint8_t max_filters;
+};
+
+static void save_exit_config(struct bt_mesh *mesh)
+{
+	const char *cfg_filename;
+
+	if (!mesh_net_cfg_file_get(mesh->net, &cfg_filename) || !cfg_filename)
+		return;
+
+	/* Preserve the last sequence number before saving configuration */
+	storage_local_write_sequence_number(mesh->net,
+					mesh_net_get_seq_num(mesh->net));
+
+	if (storage_save_config(mesh->net, cfg_filename, true, NULL, NULL))
+		l_info("Saved final configuration to %s", cfg_filename);
+}
+
+struct bt_mesh *mesh_create(uint16_t index)
+{
+	struct bt_mesh *mesh;
+	struct mesh_io *io;
+	struct mesh_io_caps caps;
+
+	mesh = l_new(struct bt_mesh, 1);
+	if (!mesh)
+		return NULL;
+
+	mesh->net = mesh_net_new(index);
+	if (!mesh->net) {
+		l_free(mesh);
+		return NULL;
+	}
+
+	io = mesh_io_new(index, MESH_IO_TYPE_GENERIC);
+	if (!io) {
+		mesh_net_unref(mesh->net);
+		l_free(mesh);
+		return NULL;
+	}
+
+	mesh_io_get_caps(io, &caps);
+	mesh->max_filters = caps.max_num_filters;
+
+	mesh_net_attach(mesh->net, io);
+	mesh_net_set_window_accuracy(mesh->net, caps.window_accuracy);
+
+	return mesh_ref(mesh);
+}
+
+struct bt_mesh *mesh_ref(struct bt_mesh *mesh)
+{
+	if (!mesh)
+		return NULL;
+
+	__sync_fetch_and_add(&mesh->ref_count, 1);
+
+	return mesh;
+}
+
+void mesh_unref(struct bt_mesh *mesh)
+{
+	struct mesh_io *io;
+
+	if (!mesh)
+		return;
+
+	if (__sync_sub_and_fetch(&mesh->ref_count, 1))
+		return;
+
+	if (mesh_net_provisioned_get(mesh->net))
+		save_exit_config(mesh);
+
+	node_cleanup(mesh->net);
+
+	storage_release(mesh->net);
+	io = mesh_net_detach(mesh->net);
+	if (io)
+		mesh_io_destroy(io);
+
+	mesh_net_unref(mesh->net);
+	l_free(mesh);
+}
+
+bool mesh_load_config(struct bt_mesh *mesh, const char *in_config_name)
+{
+	if (!storage_parse_config(mesh->net, in_config_name))
+		return false;
+
+	/* Register foundational models */
+	mesh_config_srv_init(mesh->net, PRIMARY_ELE_IDX);
+
+	return true;
+}
+
+bool mesh_set_output(struct bt_mesh *mesh, const char *config_name)
+{
+	if (!config_name)
+		return false;
+
+	return mesh_net_cfg_file_set(mesh->net, config_name);
+}
+
+const char *mesh_status_str(uint8_t err)
+{
+	switch (err) {
+	case MESH_STATUS_SUCCESS: return "Success";
+	case MESH_STATUS_INVALID_ADDRESS: return "Invalid Address";
+	case MESH_STATUS_INVALID_MODEL: return "Invalid Model";
+	case MESH_STATUS_INVALID_APPKEY: return "Invalid AppKey";
+	case MESH_STATUS_INVALID_NETKEY: return "Invalid NetKey";
+	case MESH_STATUS_INSUFF_RESOURCES: return "Insufficient Resources";
+	case MESH_STATUS_IDX_ALREADY_STORED: return "Key Idx Already Stored";
+	case MESH_STATUS_INVALID_PUB_PARAM: return "Invalid Publish Parameters";
+	case MESH_STATUS_NOT_SUB_MOD: return "Not a Subscribe Model";
+	case MESH_STATUS_STORAGE_FAIL: return "Storage Failure";
+	case MESH_STATUS_FEATURE_NO_SUPPORT: return "Feature Not Supported";
+	case MESH_STATUS_CANNOT_UPDATE: return "Cannot Update";
+	case MESH_STATUS_CANNOT_REMOVE: return "Cannot Remove";
+	case MESH_STATUS_CANNOT_BIND: return "Cannot bind";
+	case MESH_STATUS_UNABLE_CHANGE_STATE: return "Unable to change state";
+	case MESH_STATUS_CANNOT_SET: return "Cannot set";
+	case MESH_STATUS_UNSPECIFIED_ERROR: return "Unspecified error";
+	case MESH_STATUS_INVALID_BINDING: return "Invalid Binding";
+
+	default: return "Unknown";
+	}
+}
+
+struct mesh_net *mesh_get_net(struct bt_mesh *mesh)
+{
+	if (!mesh)
+		return NULL;
+
+	return mesh->net;
+}
diff --git a/mesh/node.c b/mesh/node.c
new file mode 100644
index 000000000..501ab8eea
--- /dev/null
+++ b/mesh/node.c
@@ -0,0 +1,851 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
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
+#include "mesh/mesh-defs.h"
+
+#include "mesh/mesh.h"
+#include "mesh/net.h"
+#include "mesh/node.h"
+#include "mesh/storage.h"
+#include "mesh/appkey.h"
+#include "mesh/model.h"
+
+#define MIN_COMP_SIZE 14
+
+struct node_element {
+	struct l_queue *models;
+	uint16_t location;
+	uint8_t idx;
+};
+
+struct node_composition {
+	uint16_t cid;
+	uint16_t pid;
+	uint16_t vid;
+	uint16_t crpl;
+};
+
+struct mesh_node {
+	struct mesh_net *net;
+	struct l_queue *net_keys;
+	struct l_queue *app_keys;
+	struct l_queue *elements;
+	time_t upd_sec;
+	uint32_t seq_number;
+	uint32_t seq_min_cache;
+	uint16_t primary;
+	uint16_t num_ele;
+	uint8_t dev_uuid[16];
+	uint8_t dev_key[16];
+	uint8_t ttl;
+	bool provisioner;
+	struct node_composition *comp;
+	struct {
+		uint16_t interval;
+		uint8_t cnt;
+		uint8_t mode;
+	} relay;
+	uint8_t lpn;
+	uint8_t proxy;
+	uint8_t friend;
+	uint8_t beacon;
+};
+
+static struct l_queue *nodes;
+
+static bool match_node_unicast(const void *a, const void *b)
+{
+	const struct mesh_node *node = a;
+	uint16_t dst = L_PTR_TO_UINT(b);
+
+	return (dst >= node->primary &&
+		dst <= (node->primary + node->num_ele - 1));
+}
+
+static bool match_device_uuid(const void *a, const void *b)
+{
+	const struct mesh_node *node = a;
+	const uint8_t *uuid = b;
+
+	return (memcmp(node->dev_uuid, uuid, 16) == 0);
+}
+
+static bool match_element_idx(const void *a, const void *b)
+{
+	const struct node_element *element = a;
+	uint32_t index = L_PTR_TO_UINT(b);
+
+	return (element->idx == index);
+}
+
+static bool match_key_idx(const void *a, const void *b)
+{
+	return (L_PTR_TO_UINT(a) == L_PTR_TO_UINT(b));
+}
+
+static bool match_model_id(const void *a, const void *b)
+{
+	const struct mesh_model *model = a;
+	uint32_t id = L_PTR_TO_UINT(b);
+
+	return (mesh_model_get_model_id(model) == id);
+}
+
+struct mesh_node *node_find_by_addr(uint16_t addr)
+{
+	if (!IS_UNICAST(addr))
+		return NULL;
+
+	return l_queue_find(nodes, match_node_unicast, L_UINT_TO_PTR(addr));
+}
+
+struct mesh_node *node_find_by_uuid(uint8_t uuid[16])
+{
+	return l_queue_find(nodes, match_device_uuid, uuid);
+}
+
+uint8_t *node_uuid_get(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	return node->dev_uuid;
+}
+
+struct mesh_node *node_new(void)
+{
+	struct mesh_node *node;
+
+	node = l_new(struct mesh_node, 1);
+
+	if (!node)
+		return NULL;
+
+	l_queue_push_tail(nodes, node);
+
+	return node;
+}
+
+static void element_free(void *data)
+{
+	struct node_element *element = data;
+
+	l_queue_destroy(element->models, mesh_model_free);
+	l_free(element);
+}
+
+static void free_node_resources(void *data)
+{
+	struct mesh_node *node = data;
+
+	l_queue_destroy(node->net_keys, NULL);
+	l_queue_destroy(node->app_keys, NULL);
+	l_queue_destroy(node->elements, element_free);
+	l_free(node->comp);
+
+	if (node->net)
+		mesh_net_unref(node->net);
+
+	l_free(node);
+}
+
+void node_free(struct mesh_node *node)
+{
+	if (!node)
+		return;
+	l_queue_remove(nodes, node);
+	free_node_resources(node);
+}
+
+static bool add_models(struct mesh_net *net, struct node_element *ele,
+						struct mesh_db_element *db_ele)
+{
+	const struct l_queue_entry *entry;
+
+	if (!ele->models)
+		ele->models = l_queue_new();
+	if (!ele->models)
+		return false;
+
+	entry = l_queue_get_entries(db_ele->models);
+	for (; entry; entry = entry->next) {
+		struct mesh_model *mod;
+		struct mesh_db_model *db_mod;
+
+		db_mod = entry->data;
+		mod = mesh_model_init(net, ele->idx, db_mod);
+		if (!mod)
+			return false;
+
+		l_queue_push_tail(ele->models, mod);
+	}
+
+	return true;
+}
+
+static bool add_element(struct mesh_node *node, struct mesh_db_element *db_ele)
+{
+	struct node_element *ele;
+
+	ele = l_new(struct node_element, 1);
+	if (!ele)
+		return false;
+
+	ele->idx = db_ele->index;
+	ele->location = db_ele->location;
+
+	if (!db_ele->models || !add_models(node->net, ele, db_ele))
+		return false;
+
+	l_queue_push_tail(node->elements, ele);
+	return true;
+}
+
+static bool add_elements(struct mesh_node *node, struct mesh_db_node *db_node)
+{
+	const struct l_queue_entry *entry;
+
+	if (!node->elements)
+		node->elements = l_queue_new();
+
+	if (!node->elements)
+		return false;
+
+	entry = l_queue_get_entries(db_node->elements);
+	for (; entry; entry = entry->next)
+		if (!add_element(node, entry->data))
+			return false;
+
+	return true;
+}
+
+struct mesh_node *node_create_from_storage(struct mesh_net *net,
+						struct mesh_db_node *db_node,
+								bool local)
+{
+	struct mesh_node *node;
+	unsigned int num_ele;
+
+	if (local && !net)
+		return NULL;
+
+	node = node_new();
+	if (!node)
+		return NULL;
+
+	node->comp = l_new(struct node_composition, 1);
+	if (!node->comp) {
+		node_free(node);
+		return NULL;
+	}
+
+	node->comp->cid = db_node->cid;
+	node->comp->pid = db_node->pid;
+	node->comp->vid = db_node->vid;
+	node->comp->crpl = db_node->crpl;
+	node->lpn = db_node->modes.lpn;
+
+	node->proxy = db_node->modes.proxy;
+	node->lpn = db_node->modes.lpn;
+	node->friend = db_node->modes.friend;
+	node->relay.mode = db_node->modes.relay.state;
+	node->relay.cnt = db_node->modes.relay.cnt;
+	node->relay.interval = db_node->modes.relay.interval;
+	node->beacon = db_node->modes.beacon;
+
+	l_info("relay %2.2x, proxy %2.2x, lpn %2.2x, friend %2.2x",
+	       node->relay.mode, node->proxy, node->friend, node->lpn);
+	node->ttl = db_node->ttl;
+	node->seq_number = db_node->seq_number;
+
+	num_ele = l_queue_length(db_node->elements);
+	if (num_ele > 0xff) {
+		node_free(node);
+		return NULL;
+	}
+
+	node->num_ele = num_ele;
+	if (num_ele != 0 && !add_elements(node, db_node)) {
+		node_free(node);
+		return NULL;
+	}
+
+	node->primary = db_node->unicast;
+
+	memcpy(node->dev_uuid, db_node->uuid, 16);
+
+	if (local)
+		node->net = mesh_net_ref(net);
+
+	return node;
+}
+
+void node_cleanup(struct mesh_net *net)
+{
+	struct mesh_node *node;
+
+	if (!net)
+		return;
+	node = mesh_net_local_node_get(net);
+	if (node)
+		node_free(node);
+
+	l_queue_destroy(nodes, free_node_resources);
+
+}
+
+bool node_is_provisioned(struct mesh_node *node)
+{
+	return (!IS_UNASSIGNED(node->primary));
+}
+
+bool node_net_key_delete(struct mesh_node *node, uint16_t idx)
+{
+	if (!node)
+		return false;
+
+	if (!l_queue_find(node->net_keys, match_key_idx, L_UINT_TO_PTR(idx)))
+		return false;
+
+	l_queue_remove(node->net_keys, L_UINT_TO_PTR(idx));
+	/* TODO: remove all associated app keys and bindings */
+	return true;
+}
+
+bool node_app_key_delete(struct mesh_net *net, uint16_t addr,
+				uint16_t net_idx, uint16_t app_idx)
+{
+	struct mesh_node *node;
+	uint32_t index;
+	const struct l_queue_entry *entry;
+
+	node = node_find_by_addr(addr);
+	if (!node)
+		return false;
+
+	index = (net_idx << 16) + app_idx;
+
+	if (!l_queue_find(node->app_keys, match_key_idx, L_UINT_TO_PTR(index)))
+		return false;
+
+	l_queue_remove(node->app_keys, L_UINT_TO_PTR(index));
+
+	storage_local_app_key_del(net, net_idx, app_idx);
+
+	entry = l_queue_get_entries(node->elements);
+	for (; entry; entry = entry->next) {
+		struct node_element *ele = entry->data;
+
+		mesh_model_app_key_delete(net, ele->models, app_idx);
+	}
+
+	return true;
+}
+
+bool node_set_primary(struct mesh_node *node, uint16_t unicast)
+{
+	if (!node)
+		return false;
+
+	node->primary = unicast;
+
+	/* If local node, save to storage */
+	if (node->net)
+		return storage_local_set_unicast(node->net, unicast);
+
+	/* TODO: for provisioner, store remote node info */
+	return true;
+}
+
+uint16_t node_get_primary(struct mesh_node *node)
+{
+	if (!node)
+		return UNASSIGNED_ADDRESS;
+	else
+		return node->primary;
+}
+
+bool node_set_device_key(struct mesh_node *node, uint8_t key[16])
+
+{
+	if (!node || !key)
+		return false;
+
+	memcpy(node->dev_key, key, 16);
+
+	/* If local node, save to storage */
+	if (node->net)
+		return storage_local_set_device_key(node->net, key);
+
+	/* TODO: for provisioner, store remote node info */
+	return true;
+}
+
+const uint8_t *node_get_device_key(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	else
+		return node->dev_key;
+}
+
+uint8_t node_get_num_elements(struct mesh_node *node)
+{
+	return node->num_ele;
+}
+
+struct l_queue *node_get_net_keys(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	else
+		return node->net_keys;
+}
+
+struct l_queue *node_get_app_keys(struct mesh_node *node)
+{
+	if (!node)
+		return NULL;
+	else
+		return node->app_keys;
+}
+
+struct l_queue *node_get_element_models(struct mesh_node *node,
+						uint8_t ele_idx, int *status)
+{
+	struct node_element *ele;
+
+	if (!node) {
+		if (status)
+			*status = MESH_STATUS_INVALID_ADDRESS;
+		return NULL;
+	}
+
+	ele = l_queue_find(node->elements, match_element_idx,
+							L_UINT_TO_PTR(ele_idx));
+	if (!ele) {
+		if (status)
+			*status = MESH_STATUS_INVALID_ADDRESS;
+		return NULL;
+	}
+
+	if (status)
+		*status = MESH_STATUS_SUCCESS;
+
+	return ele->models;
+}
+
+struct mesh_model *node_get_model(struct mesh_node *node, uint8_t ele_idx,
+						uint32_t id, int *status)
+{
+	struct l_queue *models;
+	struct mesh_model *model;
+
+	if (!node) {
+		if (status)
+			*status = MESH_STATUS_INVALID_ADDRESS;
+		return NULL;
+	}
+
+	models = node_get_element_models(node, ele_idx, status);
+	if (!models)
+		return NULL;
+
+	model = l_queue_find(models, match_model_id, L_UINT_TO_PTR(id));
+
+	if (status)
+		*status = (model) ? MESH_STATUS_SUCCESS :
+						MESH_STATUS_INVALID_MODEL;
+
+	return model;
+}
+
+uint8_t node_default_ttl_get(struct mesh_node *node)
+{
+	if (!node)
+		return DEFAULT_TTL;
+	return node->ttl;
+}
+
+bool node_default_ttl_set(struct mesh_node *node, uint8_t ttl)
+{
+	bool res, is_local;
+
+	if (!node)
+		return false;
+
+	is_local = (node->net && mesh_net_local_node_get(node->net) == node) ?
+		true : false;
+
+	res = storage_local_set_ttl(node->net, ttl);
+
+	if (res) {
+		node->ttl = ttl;
+		if (is_local)
+			mesh_net_set_default_ttl(node->net, ttl);
+	}
+
+	return res;
+}
+
+bool node_set_sequence_number(struct mesh_node *node, uint32_t seq)
+{
+	bool is_local;
+	struct timeval write_time;
+
+
+	if (!node)
+		return false;
+
+	node->seq_number = seq;
+
+	is_local = (node->net && mesh_net_local_node_get(node->net) == node) ?
+		true : false;
+
+	if (!is_local)
+		return true;
+
+	/*
+	 * Holistically determine worst case 5 minute sequence consumption
+	 * so that we typically (once we reach a steady state) rewrite the
+	 * local node file with a new seq cache value no more than once every
+	 * five minutes (or more)
+	 */
+	gettimeofday(&write_time, NULL);
+	if (node->upd_sec) {
+		uint32_t elapsed = write_time.tv_sec - node->upd_sec;
+
+		if (elapsed < MIN_SEQ_CACHE_TIME) {
+			uint32_t ideal = node->seq_min_cache;
+
+			l_info("Old Seq Cache: %d", node->seq_min_cache);
+
+			ideal *= (MIN_SEQ_CACHE_TIME / elapsed);
+
+			if (ideal > node->seq_min_cache + MIN_SEQ_CACHE)
+				node->seq_min_cache = ideal;
+			else
+				node->seq_min_cache += MIN_SEQ_CACHE;
+
+			l_info("New Seq Cache: %d", node->seq_min_cache);
+		}
+	}
+
+	node->upd_sec = write_time.tv_sec;
+
+	l_info("Storage-Write");
+	return storage_local_write_sequence_number(node->net, seq);
+}
+
+uint32_t node_get_sequence_number(struct mesh_node *node)
+{
+	if (!node)
+		return 0xffffffff;
+
+	return node->seq_number;
+}
+
+uint32_t node_seq_cache(struct mesh_node *node)
+{
+	if (node->seq_min_cache < MIN_SEQ_CACHE)
+		node->seq_min_cache = MIN_SEQ_CACHE;
+
+	return node->seq_min_cache;
+}
+
+int node_get_element_idx(struct mesh_node *node, uint16_t ele_addr)
+{
+	uint16_t addr;
+	uint8_t num_ele;
+
+	if (!node)
+		return -1;
+
+	num_ele = node_get_num_elements(node);
+	if (!num_ele)
+		return -2;
+
+	addr = node_get_primary(node);
+
+	if (ele_addr < addr || ele_addr >= addr + num_ele)
+		return -3;
+	else
+		return ele_addr - addr;
+}
+
+uint16_t node_get_crpl(struct mesh_node *node)
+{
+	if (!node)
+		return 0;
+
+	return node->comp->crpl;
+}
+
+uint8_t node_relay_mode_get(struct mesh_node *node, uint8_t *count,
+							uint16_t *interval)
+{
+	if (!node) {
+		*count = 0;
+		*interval = 0;
+		return MESH_MODE_DISABLED;
+	}
+
+	*count = node->relay.cnt;
+	*interval = node->relay.interval;
+	return node->relay.mode;
+}
+
+uint8_t node_lpn_mode_get(struct mesh_node *node)
+{
+	if (!node)
+		return MESH_MODE_DISABLED;
+
+	return node->lpn;
+}
+
+bool node_relay_mode_set(struct mesh_node *node, bool enable, uint8_t cnt,
+							uint16_t interval)
+{
+	bool res, is_local;
+
+	if (!node || node->relay.mode == MESH_MODE_UNSUPPORTED)
+		return false;
+
+	is_local = (node->net && mesh_net_local_node_get(node->net) == node) ?
+		true : false;
+
+	res = storage_local_set_relay(node->net, enable, cnt, interval);
+
+	if (res) {
+		node->relay.mode = enable ? MESH_MODE_ENABLED :
+							MESH_MODE_DISABLED;
+		node->relay.cnt = cnt;
+		node->relay.interval = interval;
+		if (is_local)
+			mesh_net_set_relay_mode(node->net, enable, cnt,
+								interval);
+	}
+
+	return res;
+}
+
+bool node_proxy_mode_set(struct mesh_node *node, bool enable)
+{
+	bool res, is_local;
+	uint8_t proxy;
+
+	if (!node || node->proxy == MESH_MODE_UNSUPPORTED)
+		return false;
+
+	is_local = (node->net && mesh_net_local_node_get(node->net) == node) ?
+		true : false;
+
+	proxy = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
+	res = storage_local_set_mode(node->net, proxy, "proxy");
+
+	if (res) {
+		node->proxy = proxy;
+		if (is_local)
+			mesh_net_set_proxy_mode(node->net, enable);
+	}
+
+	return res;
+}
+
+uint8_t node_proxy_mode_get(struct mesh_node *node)
+{
+	if (!node)
+		return MESH_MODE_DISABLED;
+
+	return node->proxy;
+}
+
+bool node_beacon_mode_set(struct mesh_node *node, bool enable)
+{
+	bool res, is_local;
+	uint8_t beacon;
+
+	if (!node)
+		return false;
+
+	is_local = (node->net && mesh_net_local_node_get(node->net) == node) ?
+		true : false;
+
+	beacon = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
+	res = storage_local_set_mode(node->net, beacon, "beacon");
+
+	if (res) {
+		node->beacon = beacon;
+		if (is_local)
+			mesh_net_set_beacon_mode(node->net, enable);
+	}
+
+	return res;
+}
+
+uint8_t node_beacon_mode_get(struct mesh_node *node)
+{
+	if (!node)
+		return MESH_MODE_DISABLED;
+
+	return node->beacon;
+}
+
+bool node_friend_mode_set(struct mesh_node *node, bool enable)
+{
+	bool res, is_local;
+	uint8_t friend;
+
+	if (!node || node->friend == MESH_MODE_UNSUPPORTED)
+		return false;
+
+	is_local = (node->net && mesh_net_local_node_get(node->net) == node) ?
+		true : false;
+
+	friend = enable ? MESH_MODE_ENABLED : MESH_MODE_DISABLED;
+	res = storage_local_set_mode(node->net, friend, "friend");
+
+	if (res) {
+		node->friend = friend;
+		if (is_local)
+			mesh_net_set_friend_mode(node->net, enable);
+	}
+
+	return res;
+}
+
+uint8_t node_friend_mode_get(struct mesh_node *node)
+{
+	if (!node)
+		return MESH_MODE_DISABLED;
+
+	return node->friend;
+}
+
+uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
+{
+	uint16_t n, features;
+	const struct l_queue_entry *ele_entry;
+
+	if (!node || !node->comp || sz < MIN_COMP_SIZE)
+		return 0;
+
+	n = 0;
+
+	l_put_le16(node->comp->cid, buf + n);
+	n += 2;
+	l_put_le16(node->comp->pid, buf + n);
+	n += 2;
+	l_put_le16(node->comp->vid, buf + n);
+	n += 2;
+	l_put_le16(node->comp->crpl, buf + n);
+	n += 2;
+
+	features = 0;
+
+	if (node->relay.mode != MESH_MODE_UNSUPPORTED)
+		features |= FEATURE_RELAY;
+	if (node->proxy != MESH_MODE_UNSUPPORTED)
+		features |= FEATURE_PROXY;
+	if (node->friend != MESH_MODE_UNSUPPORTED)
+		features |= FEATURE_FRIEND;
+	if (node->lpn != MESH_MODE_UNSUPPORTED)
+		features |= FEATURE_LPN;
+
+	l_put_le16(features, buf + n);
+	n += 2;
+
+	ele_entry = l_queue_get_entries(node->elements);
+	for (; ele_entry; ele_entry = ele_entry->next) {
+		struct node_element *ele = ele_entry->data;
+		const struct l_queue_entry *mod_entry;
+		uint8_t num_s = 0, num_v = 0;
+		uint8_t *mod_buf;
+
+		/* At least fit location and zeros for number of models */
+		if ((n + 4) > sz)
+			return n;
+		l_info("ele->location %d", ele->location);
+		l_put_le16(ele->location, buf + n);
+		n += 2;
+
+		/* Store models IDs, store num_s and num_v later */
+		mod_buf = buf + n;
+		n += 2;
+
+		/* Get SIG models */
+		mod_entry = l_queue_get_entries(ele->models);
+		for (; mod_entry; mod_entry = mod_entry->next) {
+			struct mesh_model *mod = mod_entry->data;
+			uint32_t mod_id;
+
+			mod_id = mesh_model_get_model_id(
+					(const struct mesh_model *) mod);
+
+			if ((mod_id >> 16) == 0xffff) {
+				if (n + 2 > sz)
+					goto element_done;
+
+				l_put_le16((uint16_t) (mod_id & 0xffff),
+								buf + n);
+				n += 2;
+				num_s++;
+			}
+		}
+
+		/* Get vendor models */
+		mod_entry = l_queue_get_entries(ele->models);
+		for (; mod_entry; mod_entry = mod_entry->next) {
+			struct mesh_model *mod = mod_entry->data;
+			uint32_t mod_id;
+			uint16_t vendor;
+
+			mod_id = mesh_model_get_model_id(
+					(const struct mesh_model *) mod);
+
+			vendor = (uint16_t) (mod_id >> 16);
+			if (vendor != 0xffff) {
+				if (n + 4 > sz)
+					goto element_done;
+
+				l_put_le16(vendor, buf + n);
+				n += 2;
+				l_put_le16((uint16_t) (mod_id & 0xffff),
+								buf + n);
+				n += 2;
+				num_v++;
+			}
+
+		}
+
+element_done:
+		mod_buf[0] = num_s;
+		mod_buf[1] = num_v;
+
+	}
+
+	return n;
+}
diff --git a/mesh/storage.c b/mesh/storage.c
new file mode 100644
index 000000000..85fa81dda
--- /dev/null
+++ b/mesh/storage.c
@@ -0,0 +1,672 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <json-c/json.h>
+#include <ell/ell.h>
+
+#include "mesh/mesh-defs.h"
+
+#include "mesh/mesh.h"
+#include "mesh/node.h"
+
+#include "mesh/net.h"
+#include "mesh/appkey.h"
+#include "mesh/model.h"
+#include "mesh/storage.h"
+
+/*
+ * TODO: figure out naming convention to store alternative nodes
+ * Mesh storage dir wil be in configure.ac
+ */
+#define DEVICE_COMPOSITION_FILE "../config/composition.json"
+#define NODE_CONGIGURATION_FILE "../config/configuration.json"
+
+static bool read_local_node_cb(struct mesh_db_node *db_node, void *user_data)
+{
+	struct mesh_net *net = user_data;
+	struct mesh_node *node;
+	uint32_t seq_number;
+	uint16_t crpl;
+	uint8_t ttl, mode, cnt, num_ele;
+	uint16_t unicast, interval;
+	uint8_t *uuid;
+
+	if (!net)
+		return false;
+
+	node = node_create_from_storage(net, db_node, true);
+	if (!node)
+		return false;
+
+	mesh_net_local_node_set(net, node, db_node->provisioner);
+	seq_number = node_get_sequence_number(node);
+	mesh_net_set_seq_num(net, seq_number);
+	ttl = node_default_ttl_get(node);
+	mesh_net_set_default_ttl(net, ttl);
+	crpl = node_get_crpl(node);
+	mesh_net_set_crpl(net, crpl);
+
+	mode = node_proxy_mode_get(node);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_proxy_mode(net, mode == MESH_MODE_ENABLED);
+
+	mode = node_friend_mode_get(node);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_friend_mode(net, mode == MESH_MODE_ENABLED);
+
+	mode = node_relay_mode_get(node, &cnt, &interval);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_relay_mode(net, mode == MESH_MODE_ENABLED, cnt,
+								interval);
+
+	mode = node_beacon_mode_get(node);
+	if (mode == MESH_MODE_ENABLED || mode == MESH_MODE_DISABLED)
+		mesh_net_set_beacon_mode(net, mode == MESH_MODE_ENABLED);
+
+	unicast = db_node->unicast;
+	num_ele = node_get_num_elements(node);
+
+	if (!IS_UNASSIGNED(unicast) &&
+		!mesh_net_register_unicast(net, unicast, num_ele))
+		return false;
+
+	uuid = node_uuid_get(node);
+	if (uuid)
+		mesh_net_id_uuid_set(net, uuid);
+	return true;
+}
+
+static bool read_net_keys_cb(uint16_t idx, uint8_t *key, uint8_t *new_key,
+						int phase, void *user_data)
+{
+	struct mesh_net *net = user_data;
+
+	if (!net)
+		return false;
+
+	if (mesh_net_add_key(net, false, idx, key) != MESH_STATUS_SUCCESS)
+		return false;
+	/* TODO: handle restoring key refresh phase and new keys */
+
+	return true;
+}
+
+static bool read_app_keys_cb(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
+					uint8_t *new_key, void *user_data)
+{
+	struct mesh_net *net = user_data;
+
+	if (!net)
+		return false;
+
+	return appkey_key_init(net, net_idx, app_idx, key, new_key);
+}
+
+static bool parse_local_node(struct mesh_net *net, json_object *jnode)
+{
+	bool bvalue;
+	uint32_t iv_index;
+	uint8_t key_buf[16];
+	uint8_t cnt;
+	uint16_t interval;
+
+	if (mesh_db_read_iv_index(jnode, &iv_index, &bvalue))
+		mesh_net_set_iv_index(net, iv_index, bvalue);
+
+	if (mesh_db_read_net_transmit(jnode, &cnt, &interval))
+		mesh_net_transmit_params_set(net, cnt, interval);
+
+	/* Node composition/configuration info */
+	if (!mesh_db_read_node(jnode, read_local_node_cb, net))
+		return false;
+
+	if (!mesh_db_read_net_keys(jnode, read_net_keys_cb, net))
+		return false;
+
+	/* TODO: use the actual "primary" network index for this node */
+	if (mesh_db_read_device_key(jnode, key_buf) &&
+		!node_set_device_key(mesh_net_local_node_get(net), key_buf))
+		return false;
+
+	mesh_db_read_app_keys(jnode, read_app_keys_cb, net);
+
+	return true;
+}
+
+static bool read_unprov_device_cb(struct mesh_db_node *db_node, void *user_data)
+{
+	struct mesh_net *net = user_data;
+	struct mesh_node *node;
+	uint16_t crpl;
+	uint8_t *uuid;
+
+	if (!net)
+		return false;
+
+	node = node_create_from_storage(net, db_node, true);
+
+	if (!node)
+		return false;
+
+	mesh_net_local_node_set(net, node, db_node->provisioner);
+	crpl = node_get_crpl(node);
+	mesh_net_set_crpl(net, crpl);
+
+	uuid = node_uuid_get(node);
+	if (uuid)
+		mesh_net_id_uuid_set(net, uuid);
+
+	return true;
+}
+
+static bool parse_unprovisioned_device(struct mesh_net *net, json_object *jnode)
+{
+	struct mesh_db_prov prov;
+	struct mesh_net_prov_caps *caps;
+	struct mesh_node *node;
+
+	/* Node composition/configuration info */
+	if (!mesh_db_read_unprovisioned_device(jnode,
+					read_unprov_device_cb, net))
+		return false;
+
+	if (!mesh_db_read_prov_info(jnode, &prov))
+		return false;
+
+	caps = mesh_net_prov_caps_get(net);
+	if (!caps)
+		return false;
+
+	node = mesh_net_local_node_get(net);
+	if (!node)
+		return false;
+
+	caps->num_ele = node_get_num_elements(node);
+	l_put_le16(prov.algorithm, &caps->algorithms);
+	caps->pub_type = prov.pub_type;
+	caps->static_type = prov.static_type;
+	caps->output_size = prov.output_oob.size;
+	l_put_le16(prov.output_oob.actions, &caps->output_action);
+	caps->input_size = prov.input_oob.size;
+	l_put_le16(prov.input_oob.actions, &caps->input_action);
+
+	return mesh_net_priv_key_set(net, prov.priv_key);
+}
+
+static bool parse_config(struct mesh_net *net, const char *config_name,
+							bool unprovisioned)
+{
+	int fd;
+	char *str;
+	const char *out;
+	struct stat st;
+	ssize_t sz;
+	json_object *jnode = NULL;
+	bool result = false;
+
+	if (!config_name)
+		return false;
+
+	fd = open(config_name, O_RDONLY);
+	if (!fd)
+		return false;
+
+	if (fstat(fd, &st) == -1) {
+		close(fd);
+		return false;
+	}
+
+	str = (char *) l_new(char, st.st_size + 1);
+	if (!str) {
+		close(fd);
+		return false;
+	}
+
+	sz = read(fd, str, st.st_size);
+	if (sz != st.st_size) {
+		l_error("Failed to read configuration file");
+		goto done;
+	}
+
+	jnode = json_tokener_parse(str);
+	if (!jnode)
+		goto done;
+
+	mesh_net_jconfig_set(net, jnode);
+
+	if (!unprovisioned)
+		result = parse_local_node(net, jnode);
+	else
+		result = parse_unprovisioned_device(net, jnode);
+
+	if (!result) {
+		storage_release(net);
+		goto done;
+	}
+
+	mesh_net_cfg_file_get(net, &out);
+	if (!out)
+		mesh_net_cfg_file_set(net, !unprovisioned ?
+					config_name : NODE_CONGIGURATION_FILE);
+done:
+	close(fd);
+	if (str)
+		l_free(str);
+
+	return result;
+}
+
+bool storage_parse_config(struct mesh_net *net, const char *config_name)
+{
+	bool result = false;
+	bool unprovisioned = !config_name;
+
+	if (unprovisioned) {
+		result = parse_config(net, DEVICE_COMPOSITION_FILE, true);
+		goto done;
+	}
+
+	result = parse_config(net, config_name, false);
+
+	if (!result) {
+		char *bak = (char *) l_malloc(strlen(config_name) + 5);
+
+		if (!bak)
+			goto done;
+
+		/* Fall-back to Backup version */
+		strncpy(bak, config_name, strlen(config_name) + 1);
+		bak = strncat(bak, ".bak", 5);
+
+		remove(config_name);
+		rename(bak, config_name);
+
+		result = parse_config(net, config_name, false);
+
+		l_free(bak);
+	}
+
+	/* If configuration read fails, try as unprovisioned device */
+	if (!result) {
+		l_info("Parse configuration failed, trying unprovisioned");
+		unprovisioned = true;
+		result = parse_config(net, DEVICE_COMPOSITION_FILE, true);
+	}
+
+done:
+	if (result)
+		mesh_net_provisioned_set(net, !unprovisioned);
+
+	return result;
+}
+
+bool storage_local_set_ttl(struct mesh_net *net, uint8_t ttl)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_write_int(jnode, "defaultTTL", ttl);
+}
+
+bool storage_local_set_relay(struct mesh_net *net, bool enable,
+				uint8_t count, uint8_t interval)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_write_relay_mode(jnode, enable, count, interval);
+}
+
+bool storage_local_set_transmit_params(struct mesh_net *net, uint8_t count,
+							uint8_t interval)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_write_net_transmit(jnode, count, interval);
+}
+
+bool storage_local_set_mode(struct mesh_net *net, uint8_t mode,
+						const char *mode_name)
+{
+	json_object *jnode;
+
+	if (!net || !mode_name)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_write_mode(jnode, mode_name, mode);
+}
+
+bool storage_model_bind(struct mesh_net *net, uint16_t addr, uint32_t mod_id,
+				uint16_t app_idx, bool unbind)
+{
+	json_object *jnode;
+	bool is_local;
+
+	if (!net)
+		return false;
+
+	is_local = mesh_net_is_local_address(net, addr);
+	if (is_local) {
+		int ele_idx;
+		bool is_vendor = (mod_id > 0xffff);
+
+		ele_idx = node_get_element_idx(mesh_net_local_node_get(net),
+									addr);
+		if (ele_idx < 0)
+			return false;
+
+		jnode = mesh_net_jconfig_get(net);
+		if (!jnode)
+			return false;
+
+		if (unbind)
+			return mesh_db_model_binding_del(jnode, ele_idx,
+						is_vendor, mod_id, app_idx);
+		else
+			return mesh_db_model_binding_add(jnode, ele_idx,
+						is_vendor, mod_id, app_idx);
+	}
+
+	/* TODO: write remote node bindings to provisioner DB */
+	return false;
+}
+
+bool storage_local_app_key_add(struct mesh_net *net, uint16_t net_idx,
+			uint16_t app_idx, const uint8_t key[16], bool update)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_app_key_add(jnode, net_idx, app_idx, key, update);
+}
+
+bool storage_local_app_key_del(struct mesh_net *net, uint16_t net_idx,
+					uint16_t app_idx)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_app_key_del(jnode, net_idx, app_idx);
+
+}
+
+bool storage_local_net_key_add(struct mesh_net *net, uint16_t net_idx,
+					const uint8_t key[16], int phase)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_net_key_add(jnode, net_idx, key, phase);
+}
+
+bool storage_local_net_key_del(struct mesh_net *net, uint16_t net_idx)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_net_key_del(jnode, net_idx);
+}
+
+bool storage_local_set_iv_index(struct mesh_net *net, uint32_t iv_index,
+								bool update)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_write_iv_index(jnode, iv_index, update);
+}
+
+bool storage_local_set_device_key(struct mesh_net *net, uint8_t dev_key[16])
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_write_device_key(jnode, dev_key);
+}
+
+bool storage_local_set_unicast(struct mesh_net *net, uint16_t unicast)
+{
+	json_object *jnode;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	return mesh_db_write_uint16_hex(jnode, "unicastAddress", unicast);
+}
+
+bool storage_local_write_sequence_number(struct mesh_net *net, uint32_t seq)
+{
+	json_object *jnode;
+	const char *cfg_file;
+	bool result;
+
+	if (!net)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	result = mesh_db_write_int(jnode, "sequenceNumber", seq);
+	if (!result)
+		return false;
+
+	result = mesh_net_cfg_file_get(net, &cfg_file);
+	if (result && cfg_file)
+		result = storage_save_config(net, cfg_file, false, NULL, NULL);
+
+	return result;
+}
+
+static bool save_config(struct mesh_net *net, const char *config_name)
+{
+	FILE *outfile;
+	const char *str;
+	json_object *jnode;
+	bool result = false;
+
+	if (!net || !config_name)
+		return false;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	outfile = fopen(config_name, "w");
+	if (!outfile) {
+		l_error("Failed to save configuration to %s", config_name);
+		return false;
+	}
+
+	str = json_object_to_json_string_ext(jnode, JSON_C_TO_STRING_PRETTY);
+
+	if (fwrite(str, sizeof(char), strlen(str), outfile) < strlen(str))
+		l_warn("Incomplete write of mesh configuration");
+	else
+		result = true;
+
+	fclose(outfile);
+
+	return result;
+}
+
+struct write_info {
+	const char *config_name;
+	struct mesh_net *net;
+	void *user_data;
+	mesh_status_func_t cb;
+};
+
+static void idle_save_config(void *user_data)
+{
+	struct write_info *info = user_data;
+	char *tmp = (char *) l_malloc(strlen(info->config_name) + 5);
+	char *bak = (char *) l_malloc(strlen(info->config_name) + 5);
+	bool result = false;
+
+	if (!tmp || !bak)
+		goto done;
+
+	strncpy(tmp, info->config_name, strlen(info->config_name)  + 1);
+	strncpy(bak, info->config_name, strlen(info->config_name)  + 1);
+	tmp = strncat(tmp, ".tmp", 5);
+	bak = strncat(bak, ".bak", 5);
+	remove(tmp);
+
+	l_debug("Storage-Wrote");
+	result = save_config(info->net, tmp);
+
+	if (result) {
+		remove(bak);
+		rename(info->config_name, bak);
+		rename(tmp, info->config_name);
+	}
+
+	remove(tmp);
+done:
+	l_free(tmp);
+	l_free(bak);
+
+	if (info->cb)
+		info->cb(info->user_data, result);
+
+	l_free(info);
+}
+
+bool storage_save_config(struct mesh_net *net, const char *config_name,
+			bool no_wait, mesh_status_func_t cb, void *user_data)
+{
+	struct write_info *info;
+
+	info = l_new(struct write_info, 1);
+	if (!info)
+		return false;
+
+	info->net = net;
+	info->config_name = config_name;
+	info->cb = cb;
+	info->user_data = user_data;
+
+	if (no_wait)
+		idle_save_config(info);
+	l_idle_oneshot(idle_save_config, info, NULL);
+
+	return true;
+}
+
+bool storage_save_new_config(struct mesh_net *net, const char *config_name,
+					mesh_status_func_t cb, void *user_data)
+{
+	json_object *jnode;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (!jnode)
+		return false;
+
+	mesh_db_remove_property(jnode, "provision");
+
+	return storage_save_config(net, config_name, false, cb, user_data);
+}
+
+void storage_release(struct mesh_net *net)
+{
+	json_object *jnode;
+
+	jnode = mesh_net_jconfig_get(net);
+	if (jnode)
+		json_object_put(jnode);
+
+	mesh_net_jconfig_set(net, NULL);
+}
diff --git a/mesh/util.c b/mesh/util.c
new file mode 100644
index 000000000..5d771431c
--- /dev/null
+++ b/mesh/util.c
@@ -0,0 +1,71 @@
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
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <time.h>
+
+#include "mesh/util.h"
+
+uint32_t get_timestamp_secs(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec;
+}
+
+bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
+							uint16_t out_len)
+{
+	uint16_t i;
+
+	if (in_len < out_len * 2)
+		return false;
+
+	for (i = 0; i < out_len; i++) {
+		if (sscanf(&str[i * 2], "%02hhx", &out[i]) != 1)
+			return false;
+	}
+
+	return true;
+}
+
+size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len)
+{
+	static const char hexdigits[] = "0123456789abcdef";
+	size_t i;
+
+	if (in_len * 2 > (out_len - 1))
+		return 0;
+
+	for (i = 0; i < in_len; i++) {
+		out[i * 2] = hexdigits[in[i] >> 4];
+		out[i * 2 + 1] = hexdigits[in[i] & 0xf];
+	}
+
+	out[in_len * 2] = '\0';
+	return i;
+}
-- 
2.14.4
