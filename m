Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v3 01/14] meshd: Shared private meshd interfaces
Date: Wed, 25 Apr 2018 11:20:29 -0700
Message-Id: <20180425182042.31938-2-brian.gix@intel.com>
In-Reply-To: <20180425182042.31938-1-brian.gix@intel.com>
References: <20180425182042.31938-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 meshd/src/crypto.h          | 164 ++++++++++++++++++
 meshd/src/display.h         |  29 ++++
 meshd/src/friend.h          |  57 +++++++
 meshd/src/hci.h             |  56 +++++++
 meshd/src/mesh-io-api.h     |  58 +++++++
 meshd/src/mesh-io-generic.h |  20 +++
 meshd/src/mesh-io.h         |  99 +++++++++++
 meshd/src/net.h             | 392 ++++++++++++++++++++++++++++++++++++++++++++
 meshd/src/prov.h            | 162 ++++++++++++++++++
 meshd/src/provision.h       |  30 ++++
 10 files changed, 1067 insertions(+)
 create mode 100644 meshd/src/crypto.h
 create mode 100644 meshd/src/display.h
 create mode 100644 meshd/src/friend.h
 create mode 100644 meshd/src/hci.h
 create mode 100644 meshd/src/mesh-io-api.h
 create mode 100644 meshd/src/mesh-io-generic.h
 create mode 100644 meshd/src/mesh-io.h
 create mode 100644 meshd/src/net.h
 create mode 100644 meshd/src/prov.h
 create mode 100644 meshd/src/provision.h

diff --git a/meshd/src/crypto.h b/meshd/src/crypto.h
new file mode 100644
index 000000000..251b2cc7f
--- /dev/null
+++ b/meshd/src/crypto.h
@@ -0,0 +1,164 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+
+bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
+					const uint8_t *aad, uint16_t aad_len,
+					const uint8_t *msg, uint16_t msg_len,
+					uint8_t *out_msg,
+					void *out_mic, size_t mic_size);
+bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
+				const uint8_t *aad, uint16_t aad_len,
+				const uint8_t *enc_msg, uint16_t enc_msg_len,
+				uint8_t *out_msg,
+				void *out_mic, size_t mic_size);
+bool mesh_aes_ecb_one(const uint8_t key[16],
+			const uint8_t plaintext[16], uint8_t encrypted[16]);
+bool mesh_crypto_nkik(const uint8_t network_key[16], uint8_t identity_key[16]);
+bool mesh_crypto_nkbk(const uint8_t network_key[16], uint8_t beacon_key[16]);
+bool mesh_crypto_nkpk(const uint8_t network_key[16], uint8_t proxy_key[16]);
+bool mesh_crypto_identity(const uint8_t net_key[16], uint16_t addr,
+							uint8_t id[16]);
+bool mesh_crypto_beacon_cmac(const uint8_t encryption_key[16],
+				const uint8_t network_id[16],
+				uint32_t iv_index, bool kr,
+				bool iu, uint64_t *cmac);
+bool mesh_crypto_network_nonce(bool frnd, uint8_t ttl, uint32_t seq,
+				uint16_t src, uint32_t iv_index,
+				uint8_t nonce[13]);
+bool mesh_crypto_network_encrypt(bool ctl, uint8_t ttl,
+				uint32_t seq, uint16_t src,
+				uint32_t iv_index,
+				const uint8_t net_key[16],
+				const uint8_t *enc_msg, uint8_t enc_msg_len,
+				uint8_t *out, void *net_mic);
+bool mesh_crypto_network_decrypt(bool frnd, uint8_t ttl,
+				uint32_t seq, uint16_t src,
+				uint32_t iv_index,
+				const uint8_t net_key[16],
+				const uint8_t *enc_msg, uint8_t enc_msg_len,
+				uint8_t *out, void *net_mic, size_t mic_size);
+bool mesh_crypto_application_nonce(uint32_t seq, uint16_t src,
+				uint16_t dst, uint32_t iv_index,
+				bool aszmic, uint8_t nonce[13]);
+bool mesh_crypto_device_nonce(uint32_t seq, uint16_t src,
+				uint16_t dst, uint32_t iv_index,
+				bool aszmic, uint8_t nonce[13]);
+bool mesh_crypto_application_encrypt(uint8_t akf, uint32_t seq, uint16_t src,
+					uint16_t dst, uint32_t iv_index,
+					const uint8_t app_key[16],
+					const uint8_t *aad, uint8_t aad_len,
+					const uint8_t *msg, uint8_t msg_len,
+					uint8_t *out,
+					void *app_mic, size_t mic_size);
+bool mesh_crypto_application_decrypt(uint8_t akf, uint32_t seq, uint16_t src,
+				uint16_t dst, uint32_t iv_index,
+				const uint8_t app_key[16],
+				const uint8_t *aad, uint8_t aad_len,
+				const uint8_t *enc_msg, uint8_t enc_msg_len,
+				uint8_t *out, void *app_mic, size_t mic_size);
+bool mesh_crypto_device_key(const uint8_t secret[32],
+						const uint8_t salt[16],
+						uint8_t device_key[16]);
+bool mesh_crypto_virtual_addr(const uint8_t virtual_label[16],
+						uint16_t *v_addr);
+bool mesh_crypto_nonce(const uint8_t secret[32],
+					const uint8_t salt[16],
+					uint8_t nonce[13]);
+bool mesh_crypto_k1(const uint8_t ikm[16], const uint8_t salt[16],
+		const void *info, size_t info_len, uint8_t okm[16]);
+bool mesh_crypto_k2(const uint8_t n[16], const uint8_t *p, size_t p_len,
+							uint8_t net_id[1],
+							uint8_t enc_key[16],
+							uint8_t priv_key[16]);
+bool mesh_crypto_k3(const uint8_t n[16], uint8_t out64[8]);
+bool mesh_crypto_k4(const uint8_t a[16], uint8_t out5[1]);
+bool mesh_crypto_s1(const void *info, size_t len, uint8_t salt[16]);
+bool mesh_crypto_prov_prov_salt(const uint8_t conf_salt[16],
+					const uint8_t prov_rand[16],
+					const uint8_t dev_rand[16],
+					uint8_t prov_salt[16]);
+bool mesh_crypto_prov_conf_key(const uint8_t secret[32],
+					const uint8_t salt[16],
+					uint8_t conf_key[16]);
+bool mesh_crypto_session_key(const uint8_t secret[32],
+					const uint8_t salt[16],
+					uint8_t session_key[16]);
+bool mesh_crypto_privacy_counter(uint32_t iv_index,
+						const uint8_t *payload,
+						uint8_t privacy_counter[16]);
+bool mesh_crypto_network_obfuscate(const uint8_t privacy_key[16],
+					const uint8_t privacy_counter[16],
+					bool ctl, uint8_t ttl, uint32_t seq,
+					uint16_t src, uint8_t *out);
+bool mesh_crypto_network_clarify(const uint8_t privacy_key[16],
+				const uint8_t privacy_counter[16],
+				const uint8_t net_hdr[6],
+				bool *ctl, uint8_t *ttl,
+				uint32_t *seq, uint16_t *src);
+
+bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
+				uint32_t seq,
+				uint16_t src, uint16_t dst,
+				uint8_t opcode,
+				bool segmented, uint8_t key_id,
+				bool szmic, bool relay, uint16_t seqZero,
+				uint8_t segO, uint8_t segN,
+				const uint8_t *payload, uint8_t payload_len,
+				uint8_t *packet, uint8_t *packet_len);
+bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
+				bool *ctl, uint8_t *ttl, uint32_t *seq,
+				uint16_t *src, uint16_t *dst,
+				uint32_t *cookie, uint8_t *opcode,
+				bool *segmented, uint8_t *key_id,
+				bool *szmic, bool *relay, uint16_t *seqZero,
+				uint8_t *segO, uint8_t *segN,
+				const uint8_t **payload, uint8_t *payload_len);
+bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
+				uint8_t *out, uint16_t payload_len,
+				uint16_t src, uint16_t dst, uint8_t key_id,
+				uint32_t seq_num, uint32_t iv_index,
+				bool aszmic,
+				const uint8_t application_key[16]);
+bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
+				const uint8_t *payload, uint16_t payload_len,
+				bool szmict,
+				uint16_t src, uint16_t dst, uint8_t key_id,
+				uint32_t seq_num, uint32_t iv_index,
+				uint8_t *out,
+				const uint8_t application_key[16]);
+bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
+				const uint8_t network_key[16],
+				uint32_t iv_index,
+				const uint8_t privacy_key[16]);
+bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
+				bool proxy, uint8_t *out, uint32_t iv_index,
+				const uint8_t network_key[16],
+				const uint8_t privacy_key[16]);
+bool mesh_crypto_packet_label(uint8_t *packet, uint8_t packet_len,
+				uint16_t iv_index, uint8_t network_id);
+
+uint8_t mesh_crypto_compute_fcs(const uint8_t *packet, uint8_t packet_len);
+bool mesh_crypto_check_fcs(const uint8_t *packet, uint8_t packet_len,
+							uint8_t received_fcs);
+bool mesh_crypto_aes_cmac(const uint8_t key[16], const uint8_t *msg,
+					size_t msg_len, uint8_t res[16]);
+
diff --git a/meshd/src/display.h b/meshd/src/display.h
new file mode 100644
index 000000000..d43292741
--- /dev/null
+++ b/meshd/src/display.h
@@ -0,0 +1,29 @@
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
+#define COLOR_OFF	"\x1B[0m"
+#define COLOR_RED	"\x1B[0;91m"
+#define COLOR_GREEN	"\x1B[0;92m"
+#define COLOR_YELLOW	"\x1B[0;93m"
+#define COLOR_BLUE	"\x1B[0;94m"
+
+unsigned int num_columns(void);
+
+void print_packet(const char *label, const void *data, uint16_t size);
+
diff --git a/meshd/src/friend.h b/meshd/src/friend.h
new file mode 100644
index 000000000..1fa6ec92a
--- /dev/null
+++ b/meshd/src/friend.h
@@ -0,0 +1,57 @@
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
+#define OP_FRND_REQUEST			0x8040
+#define OP_FRND_INQUIRY			0x8041
+#define OP_FRND_CONFIRM			0x8042
+#define OP_FRND_SUB_LIST_ADD		0x8043
+#define OP_FRND_SUB_LIST_CONFIRM	0x8044
+#define OP_FRND_SUB_LIST_REMOVE		0x8045
+#define OP_FRND_NEGOTIATE		0x8046
+#define OP_FRND_CLEAR			0x8047
+
+void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
+						struct mesh_friend *frnd);
+void friend_request(struct mesh_net *net, uint16_t src, uint8_t minReq,
+			uint8_t delay, uint32_t timeout, uint16_t prev,
+			uint8_t num_elements, uint16_t cntr, int8_t rssi);
+void friend_clear_confirm(struct mesh_net *net, uint16_t src, uint16_t lpn,
+							uint16_t lpnCounter);
+void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
+			uint16_t lpnCounter, struct mesh_friend *frnd);
+void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
+					const uint8_t *pkt, uint8_t len);
+void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
+					const uint8_t *pkt, uint8_t len);
+void mesh_friend_relay_init(struct mesh_net *net, uint16_t addr);
+
+/* Low-Power-Node role */
+void frnd_sub_add(struct mesh_net *net, uint32_t parms[7]);
+void frnd_sub_del(struct mesh_net *net, uint32_t parms[7]);
+void frnd_poll(struct mesh_net *net, bool retry);
+void frnd_clear(struct mesh_net *net);
+void frnd_ack_poll(struct mesh_net *net);
+void frnd_poll_cancel(struct mesh_net *net);
+void frnd_request_friend(struct mesh_net *net, uint8_t cache,
+			uint8_t offer_delay, uint8_t delay, uint32_t timeout);
+void frnd_offer(struct mesh_net *net, uint16_t src, uint8_t window,
+			uint8_t cache, uint8_t sub_list_size,
+			int8_t r_rssi, int8_t l_rssi, uint16_t fn_cnt);
+void frnd_key_refresh(struct mesh_net *net, uint8_t phase);
+struct mesh_key_set *frnd_get_key(struct mesh_net *net);
diff --git a/meshd/src/hci.h b/meshd/src/hci.h
new file mode 100644
index 000000000..a1362b76a
--- /dev/null
+++ b/meshd/src/hci.h
@@ -0,0 +1,56 @@
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
+struct bt_hci;
+
+typedef void (*bt_hci_destroy_func_t)(void *user_data);
+
+struct bt_hci *bt_hci_new(int fd);
+struct bt_hci *bt_hci_new_user_channel(uint16_t index);
+struct bt_hci *bt_hci_new_raw_device(uint16_t index);
+
+struct bt_hci *bt_hci_ref(struct bt_hci *hci);
+void bt_hci_unref(struct bt_hci *hci);
+
+bool bt_hci_set_close_on_unref(struct bt_hci *hci, bool do_close);
+
+typedef void (*bt_hci_callback_func_t)(const void *data, uint8_t size,
+							void *user_data);
+
+unsigned int bt_hci_send(struct bt_hci *hci, uint16_t opcode,
+				const void *data, uint8_t size,
+				bt_hci_callback_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy);
+bool bt_hci_cancel(struct bt_hci *hci, unsigned int id);
+bool bt_hci_flush(struct bt_hci *hci);
+
+unsigned int bt_hci_register(struct bt_hci *hci, uint8_t event,
+				bt_hci_callback_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy);
+bool bt_hci_unregister(struct bt_hci *hci, unsigned int id);
+
+typedef void (*bt_hci_receive_func_t)(uint16_t handle, uint8_t flags,
+					const void *data, uint16_t size,
+							void *user_data);
+
+bool bt_hci_receive(struct bt_hci *hci, bt_hci_receive_func_t callback,
+				void *user_data, bt_hci_destroy_func_t destroy);
+
+bool bt_hci_write(struct bt_hci *hci, uint16_t handle, uint8_t flags,
+				const void *data, uint16_t size);
diff --git a/meshd/src/mesh-io-api.h b/meshd/src/mesh-io-api.h
new file mode 100644
index 000000000..f69fceeb2
--- /dev/null
+++ b/meshd/src/mesh-io-api.h
@@ -0,0 +1,58 @@
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
+struct mesh_io_private;
+
+typedef bool (*mesh_io_init_t)(uint16_t index, struct mesh_io *io);
+typedef bool (*mesh_io_destroy_t)(struct mesh_io *io);
+typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
+typedef bool (*mesh_io_send_t)(struct mesh_io *io,
+					struct mesh_io_send_info *info,
+					const uint8_t *data, uint16_t len);
+typedef bool (*mesh_io_register_t)(struct mesh_io *io, uint8_t filter_id,
+				mesh_io_recv_func_t cb, void *user_data);
+typedef bool (*mesh_io_deregister_t)(struct mesh_io *io, uint8_t filter_id);
+typedef bool (*mesh_io_filter_set_t)(struct mesh_io *io,
+			uint8_t filter_id, const uint8_t *data, uint8_t len,
+			mesh_io_status_func_t callback, void *user_data);
+typedef bool (*mesh_io_tx_cancel_t)(struct mesh_io *io, uint8_t *pattern,
+								uint8_t len);
+
+struct mesh_io_api {
+	mesh_io_init_t		init;
+	mesh_io_destroy_t	destroy;
+	mesh_io_caps_t		caps;
+	mesh_io_send_t		send;
+	mesh_io_register_t	reg;
+	mesh_io_deregister_t	dereg;
+	mesh_io_filter_set_t	set;
+	mesh_io_tx_cancel_t	cancel;
+};
+
+struct mesh_io {
+	enum mesh_io_type		type;
+	uint16_t			index;
+	const struct mesh_io_api	*api;
+	struct mesh_io_private		*pvt;
+};
+
+struct mesh_io_table {
+	enum mesh_io_type		type;
+	const struct mesh_io_api	*api;
+};
diff --git a/meshd/src/mesh-io-generic.h b/meshd/src/mesh-io-generic.h
new file mode 100644
index 000000000..4bf4d5cb7
--- /dev/null
+++ b/meshd/src/mesh-io-generic.h
@@ -0,0 +1,20 @@
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
+extern const struct mesh_io_api mesh_io_generic;
diff --git a/meshd/src/mesh-io.h b/meshd/src/mesh-io.h
new file mode 100644
index 000000000..754f6129c
--- /dev/null
+++ b/meshd/src/mesh-io.h
@@ -0,0 +1,99 @@
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
+struct mesh_io;
+
+#define MESH_IO_FILTER_BEACON	1
+#define MESH_IO_FILTER_PROV	2
+#define MESH_IO_FILTER_NET	3
+
+#define MESH_IO_TX_COUNT_UNLIMITED	0
+
+enum mesh_io_type {
+	MESH_IO_TYPE_NONE = 0,
+	MESH_IO_TYPE_GENERIC
+};
+
+enum mesh_io_timing_type {
+	MESH_IO_TIMING_TYPE_GENERAL = 1,
+	MESH_IO_TIMING_TYPE_POLL,
+	MESH_IO_TIMING_TYPE_POLL_RSP
+};
+
+struct mesh_io_recv_info {
+	uint32_t instant;
+	uint8_t chan;
+	int8_t rssi;
+};
+
+struct mesh_io_send_info {
+	enum mesh_io_timing_type type;
+	union {
+		struct {
+			uint16_t interval;
+			uint8_t cnt;
+			uint8_t min_delay;
+			uint8_t max_delay;
+		} gen;
+
+		struct {
+			uint16_t scan_duration;
+			uint8_t scan_delay;
+			uint8_t filter_ids[2];
+			uint8_t min_delay;
+			uint8_t max_delay;
+		} poll;
+
+		struct {
+			uint32_t instant;
+			uint8_t delay;
+		} poll_rsp;
+
+	} u;
+};
+
+struct mesh_io_caps {
+	uint8_t max_num_filters;
+	uint8_t window_accuracy;
+};
+
+typedef void (*mesh_io_recv_func_t)(void *user_data,
+					struct mesh_io_recv_info *info,
+					const uint8_t *data, uint16_t len);
+
+typedef void (*mesh_io_status_func_t)(void *user_data, int status,
+							uint8_t filter_id);
+
+struct mesh_io *mesh_io_new(uint16_t index, enum mesh_io_type type);
+void mesh_io_destroy(struct mesh_io *io);
+
+bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps);
+
+bool mesh_io_register_recv_cb(struct mesh_io *io, uint8_t filter_id,
+				mesh_io_recv_func_t cb, void *user_data);
+
+bool mesh_io_deregister_recv_cb(struct mesh_io *io, uint8_t filter_id);
+
+bool mesh_set_filter(struct mesh_io *io, uint8_t filter_id,
+				const uint8_t *data, uint8_t len,
+				mesh_io_status_func_t cb, void *user_data);
+
+bool mesh_io_send(struct mesh_io *io, struct mesh_io_send_info *info,
+					const uint8_t *data, uint16_t len);
+bool mesh_io_send_cancel(struct mesh_io *io, uint8_t *pattern, uint8_t len);
diff --git a/meshd/src/net.h b/meshd/src/net.h
new file mode 100644
index 000000000..e48380314
--- /dev/null
+++ b/meshd/src/net.h
@@ -0,0 +1,392 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+struct mesh_io;
+struct mesh_node;
+
+#define DEV_ID	0
+
+#define UNUSED_KEY_IDX	0xffff
+
+#define APP_ID_DEV	0
+#define APP_ID_ANY	((unsigned int) -1)
+#define NET_ID_ANY	(APP_ID_ANY - 1)
+
+#define CTL		0x80
+#define TTL_MASK	0x7f
+#define SEQ_MASK	0xffffff
+
+#define CREDFLAG_MASK	0x1000
+#define APP_IDX_MASK	0x0fff
+#define APP_IDX_DEV	0x7fff
+#define APP_IDX_ANY	0x8000
+#define APP_IDX_NET	0xffff
+
+#define NET_IDX_INVALID	0xffff
+#define NET_NID_INVALID	0xff
+
+#define KEY_CACHE_SIZE	64
+#define FRND_CACHE_MAX	32
+
+#define MAX_UNSEG_LEN	15 /* msg_len == 11 + sizeof(MIC) */
+#define MAX_SEG_LEN	12 /* UnSeg length - 3 octets overhead */
+#define SEG_MAX(len)	(((len) <= MAX_UNSEG_LEN) ? 0 : \
+						(((len) - 1) / MAX_SEG_LEN))
+#define SEG_OFF(seg)	((seg) * MAX_SEG_LEN)
+#define MAX_SEG_TO_LEN(seg)	((seg) ? SEG_OFF((seg) + 1) : MAX_UNSEG_LEN)
+
+#define SEGMENTED	0x80
+#define UNSEGMENTED	0x00
+#define SEG_HDR_SHIFT	31
+#define IS_SEGMENTED(hdr)	(!!((hdr) & (true << SEG_HDR_SHIFT)))
+
+#define KEY_ID_MASK	0x7f
+#define KEY_AID_MASK	0x3f
+#define KEY_ID_AKF	0x40
+#define KEY_AID_SHIFT	0
+#define AKF_HDR_SHIFT	30
+#define KEY_HDR_SHIFT	24
+#define HAS_APP_KEY(hdr)	(!!((hdr) & (true << AKF_HDR_SHIFT)))
+
+#define OPCODE_MASK	0x7f
+#define OPCODE_HDR_SHIFT	24
+#define RELAY		0x80
+#define RELAY_HDR_SHIFT	23
+#define SZMIC		0x80
+#define SZMIC_HDR_SHIFT	23
+#define SEQ_ZERO_MASK	0x1fff
+#define SEQ_ZERO_HDR_SHIFT	10
+#define IS_RELAYED(hdr)	(!!((hdr) & (true << RELAY_HDR_SHIFT)))
+#define HAS_MIC64(hdr)	(!!((hdr) & (true << SZMIC_HDR_SHIFT)))
+
+#define SEG_MASK	0x1f
+#define SEGO_HDR_SHIFT	5
+#define SEGN_HDR_SHIFT	0
+#define SEG_TOTAL(hdr)	(((hdr) >> SEGN_HDR_SHIFT) & SEG_MASK)
+
+/* Mask of Hdr bits which must be constant over entire incoming SAR message */
+/* (SEG || AKF || AID || SZMIC || SeqZero || SegN) */
+#define HDR_KEY_MASK		((true << SEG_HDR_SHIFT) |		\
+				(KEY_ID_MASK << KEY_HDR_SHIFT) |	\
+				(true << SZMIC_HDR_SHIFT) |		\
+				(SEQ_ZERO_MASK << SEQ_ZERO_HDR_SHIFT) |	\
+				(SEG_MASK << SEGN_HDR_SHIFT))
+
+#define HDR_ACK_MASK		((OPCODE_MASK << OPCODE_HDR_SHIFT) |	\
+				(SEQ_ZERO_MASK << SEQ_ZERO_HDR_SHIFT))
+
+
+
+#define MSG_CACHE_SIZE		70
+#define REPLAY_CACHE_SIZE	10
+
+/* Proxy Configuration Opcodes */
+#define PROXY_OP_SET_FILTER_TYPE	0x00
+#define PROXY_OP_FILTER_ADD		0x01
+#define PROXY_OP_FILTER_DEL		0x02
+#define PROXY_OP_FILTER_STATUS		0x03
+
+/* Proxy Filter Defines */
+#define PROXY_FILTER_WHITELIST		0x00
+#define PROXY_FILTER_BLACKLIST		0x01
+
+/* Network Tranport Opcodes */
+#define NET_OP_SEG_ACKNOWLEDGE		0x00
+#define NET_OP_FRND_POLL		0x01
+#define NET_OP_FRND_UPDATE		0x02
+#define NET_OP_FRND_REQUEST		0x03
+#define NET_OP_FRND_OFFER		0x04
+#define NET_OP_FRND_CLEAR		0x05
+#define NET_OP_FRND_CLEAR_CONFIRM	0x06
+
+#define NET_OP_PROXY_SUB_ADD		0x07
+#define NET_OP_PROXY_SUB_REMOVE		0x08
+#define NET_OP_PROXY_SUB_CONFIRM	0x09
+#define NET_OP_HEARTBEAT		0x0a
+
+#define FRND_OPCODE(x) \
+		((x) >= NET_OP_FRND_POLL && (x) <= NET_OP_FRND_CLEAR_CONFIRM)
+
+struct mesh_net_addr_range {
+	uint16_t low;
+	uint16_t high;
+	uint16_t next;
+};
+
+struct mesh_net_prov_caps {
+	uint8_t num_ele;
+	uint16_t algorithms;
+	uint8_t pub_type;
+	uint8_t static_type;
+	uint8_t output_size;
+	uint16_t output_action;
+	uint8_t input_size;
+	uint16_t input_action;
+} __packed;
+
+struct mesh_net_heartbeat {
+	struct l_timeout *pub_timer;
+	struct l_timeout *sub_timer;
+	struct timeval sub_time;
+	bool sub_enabled;
+	uint32_t pub_period;
+	uint32_t sub_period;
+	uint32_t sub_start;
+	uint16_t pub_dst;
+	uint16_t pub_count;
+	uint16_t pub_features;
+	uint16_t features;
+	uint16_t pub_net_idx;
+	uint16_t sub_src;
+	uint16_t sub_dst;
+	uint16_t sub_count;
+	uint8_t pub_ttl;
+	uint8_t sub_min_hops;
+	uint8_t sub_max_hops;
+};
+
+struct mesh_key_set {
+	bool frnd;
+	uint8_t nid;
+	uint8_t enc_key[16];
+	uint8_t privacy_key[16];
+};
+
+struct mesh_friend {
+	struct mesh_net *net;
+	struct l_queue *pkt_cache;
+	struct l_timeout *timeout;
+	void *pkt;
+	uint16_t *grp_list;
+	uint32_t poll_timeout;
+	uint32_t last_hdr;
+	uint16_t dst; /* Primary Element unicast addr */
+	uint16_t fn_cnt;
+	uint16_t lp_cnt;
+	int16_t grp_cnt;
+	struct mesh_key_set key_set;
+	struct mesh_key_set new_key_set;
+	uint8_t ele_cnt;
+	uint8_t frd;
+	uint8_t frw;
+	bool seq;
+	bool last;
+};
+
+struct mesh_frnd_pkt {
+	uint32_t iv_index;
+	uint32_t seq;
+	uint16_t src;
+	uint16_t dst;
+	uint16_t size;
+	uint8_t segN;
+	uint8_t segO;
+	uint8_t ttl;
+	uint8_t tc;
+	bool szmict;
+	union {
+		struct {
+			uint8_t key_id;
+		} m;
+		struct {
+			uint16_t seq0;
+		} a;
+		struct {
+			uint8_t opcode;
+		} c;
+	} u;
+	uint8_t data[];
+};
+
+struct mesh_friend_seg_one {
+	uint32_t hdr;
+	uint32_t seq;
+	bool sent;
+	bool md;
+	uint8_t data[15];
+};
+
+struct mesh_friend_seg_12 {
+	uint32_t hdr;
+	uint32_t seq;
+	bool sent;
+	bool md;
+	uint8_t data[12];
+};
+
+struct mesh_friend_msg {
+	uint32_t iv_index;
+	uint32_t flags;
+	uint16_t src;
+	uint16_t dst;
+	uint8_t ttl;
+	uint8_t cnt_in;
+	uint8_t cnt_out;
+	uint8_t last_len;
+	bool done;
+	bool ctl;
+	union {
+		struct mesh_friend_seg_one one[1]; /* Single segment */
+		struct mesh_friend_seg_12 s12[0]; /* Array of segments */
+	} u;
+};
+
+typedef void (*mesh_status_func_t)(void *user_data, bool result);
+typedef void (*mesh_net_status_func_t)(uint16_t remote, uint8_t status,
+					void *data, uint16_t size,
+					void *user_data);
+
+struct mesh_net *mesh_net_new(uint16_t index);
+struct mesh_net *mesh_net_ref(struct mesh_net *net);
+void mesh_net_unref(struct mesh_net *net);
+void mesh_net_flush_msg_queues(struct mesh_net *net);
+void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update);
+bool mesh_net_iv_index_update(struct mesh_net *net);
+bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t number);
+uint32_t mesh_net_get_seq_num(struct mesh_net *net);
+uint32_t mesh_net_next_seq_num(struct mesh_net *net);
+bool mesh_net_set_default_ttl(struct mesh_net *net, uint8_t ttl);
+uint8_t mesh_net_get_default_ttl(struct mesh_net *net);
+bool mesh_net_get_frnd_seq(struct mesh_net *net);
+void mesh_net_set_frnd_seq(struct mesh_net *net, bool seq);
+uint16_t mesh_net_get_address(struct mesh_net *net);
+bool mesh_net_register_unicast(struct mesh_net *net,
+					uint16_t unicast, uint8_t num_ele);
+bool mesh_net_set_friend(struct mesh_net *net, uint16_t friend_addr);
+uint16_t mesh_net_get_friend(struct mesh_net *net);
+uint8_t mesh_net_get_num_ele(struct mesh_net *net);
+bool mesh_net_set_beacon_mode(struct mesh_net *net, bool enable);
+bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable);
+bool mesh_net_set_relay_mode(struct mesh_net *net, bool enable, uint8_t cnt,
+							uint8_t interval);
+bool mesh_net_set_friend_mode(struct mesh_net *net, bool enable);
+bool mesh_net_add_keyset(struct mesh_net *net, struct mesh_key_set *key_set);
+bool mesh_net_remove_keyset(struct mesh_net *net, struct mesh_key_set *key_set);
+int mesh_net_del_key(struct mesh_net *net, uint16_t net_idx);
+int mesh_net_add_key(struct mesh_net *net, bool update,
+					uint16_t net_idx, const void *key);
+uint32_t mesh_net_get_iv_index(struct mesh_net *net);
+void mesh_net_get_snb_state(struct mesh_net *net,
+					uint8_t *flags, uint32_t *iv_index);
+bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
+							uint8_t key[16]);
+bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io);
+struct mesh_io *mesh_net_detach(struct mesh_net *net);
+struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
+
+bool mesh_net_flush(struct mesh_net *net);
+void mesh_net_transport_send(struct mesh_net *net, struct mesh_key_set *key_set,
+				bool fast, uint32_t iv_index, uint8_t ttl,
+				uint32_t seq, uint16_t src, uint16_t dst,
+				const uint8_t *msg, uint16_t msg_len);
+
+unsigned int mesh_net_app_send(struct mesh_net *net, bool frnd_cred,
+				uint16_t src, uint16_t dst, uint8_t key_id,
+				uint8_t ttl, uint32_t seq, uint32_t iv_index,
+				bool szmic, const void *msg, uint16_t msg_len,
+				mesh_net_status_func_t status_func,
+				void *user_data);
+void mesh_net_app_send_cancel(struct mesh_net *net, unsigned int id);
+void mesh_net_ack_send(struct mesh_net *net, struct mesh_key_set *key_set,
+				uint32_t iv_index, uint8_t ttl, uint32_t seq,
+				uint16_t src, uint16_t dst, bool rly,
+				uint16_t seqZero, uint32_t ack_flags);
+struct mesh_net_prov_caps *mesh_net_prov_caps_get(struct mesh_net *net);
+uint8_t *mesh_net_priv_key_get(struct mesh_net *net);
+bool mesh_net_priv_key_set(struct mesh_net *net, uint8_t key[32]);
+uint8_t *mesh_net_prov_rand(struct mesh_net *net);
+uint16_t mesh_net_prov_uni(struct mesh_net *net, uint8_t ele_cnt);
+bool mesh_net_id_uuid_set(struct mesh_net *net, uint8_t uuid[16]);
+uint8_t *mesh_net_test_addr(struct mesh_net *net);
+int mesh_net_get_identity_mode(struct mesh_net *net, uint16_t idx,
+								uint8_t *mode);
+char *mesh_net_id_name(struct mesh_net *net);
+bool mesh_net_test_mode(struct mesh_net *net);
+bool mesh_net_dst_reg(struct mesh_net *net, uint16_t dst);
+bool mesh_net_dst_unreg(struct mesh_net *net, uint16_t dst);
+struct mesh_friend *mesh_friend_new(struct mesh_net *net, uint16_t dst,
+					uint8_t ele_cnt, uint8_t frd,
+					uint8_t frw, uint32_t fpt,
+					uint16_t fn_cnt, uint16_t lp_cnt);
+void mesh_friend_free(void *frnd);
+bool mesh_friend_clear(struct mesh_net *net, struct mesh_friend *frnd);
+void mesh_friend_sub_add(struct mesh_net *net, uint16_t lpn, uint8_t ele_cnt,
+							uint8_t grp_cnt,
+							const uint8_t *list);
+void mesh_friend_sub_del(struct mesh_net *net, uint16_t lpn, uint8_t cnt,
+						const uint8_t *del_list);
+uint8_t mesh_net_key_refresh_phase_set(struct mesh_net *net, uint16_t net_idx,
+							uint8_t transition);
+uint8_t mesh_net_key_refresh_phase_get(struct mesh_net *net, uint16_t net_idx,
+							uint8_t *phase);
+int mesh_net_kr_phase_one(struct mesh_net *net, uint16_t net_idx,
+							const uint8_t *key);
+int mesh_net_key_refresh_phase_two(struct mesh_net *net, uint16_t net_idx);
+int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t net_idx);
+void mesh_net_send_seg(struct mesh_net *net, struct mesh_key_set *key_set,
+				uint32_t iv_index, uint8_t ttl, uint32_t seq,
+				uint16_t src, uint16_t dst, uint32_t hdr,
+				const void *seg, uint16_t seg_len);
+uint16_t mesh_net_get_features(struct mesh_net *net);
+struct mesh_net_heartbeat *mesh_net_heartbeat_get(struct mesh_net *net);
+void mesh_net_heartbeat_init(struct mesh_net *net);
+void mesh_net_heartbeat_send(struct mesh_net *net);
+void mesh_net_uni_range_set(struct mesh_net *net,
+				struct mesh_net_addr_range *range);
+struct mesh_net_addr_range mesh_net_uni_range_get(struct mesh_net *net);
+void mesh_net_provisioner_mode_set(struct mesh_net *net, bool mode);
+bool mesh_net_provisioner_mode_get(struct mesh_net *net);
+bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *count);
+uint16_t mesh_net_get_primary_idx(struct mesh_net *net);
+void mesh_net_sub_list_add(struct mesh_net *net, uint16_t addr);
+void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr);
+uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr);
+struct mesh_io *mesh_net_get_io(struct mesh_net *net);
+bool mesh_net_local_node_set(struct mesh_net *net, struct mesh_node *node,
+							bool provisioner);
+struct mesh_node *mesh_net_local_node_get(struct mesh_net *net);
+bool mesh_net_set_crpl(struct mesh_net *net, uint16_t crpl);
+uint16_t mesh_net_get_crpl(struct mesh_net *net);
+bool mesh_net_have_key(struct mesh_net *net, uint16_t net_idx);
+bool mesh_net_jconfig_set(struct mesh_net *net, void *jconfig);
+void *mesh_net_jconfig_get(struct mesh_net *net);
+bool mesh_net_cfg_file_set(struct mesh_net *net, const char *cfg);
+bool mesh_net_cfg_file_get(struct mesh_net *net, const char **cfg);
+bool mesh_net_is_local_address(struct mesh_net *net, uint16_t addr);
+void mesh_net_set_window_accuracy(struct mesh_net *net, uint8_t accuracy);
+void mesh_net_transmit_params_set(struct mesh_net *net, uint8_t count,
+							uint16_t interval);
+void mesh_net_transmit_params_get(struct mesh_net *net, uint8_t *count,
+							uint16_t *interval);
+struct mesh_prov *mesh_net_get_prov(struct mesh_net *net);
+void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov);
+void mesh_net_provisioned_set(struct mesh_net *net, bool provisioned);
+bool mesh_net_provisioned_get(struct mesh_net *net);
+bool mesh_net_provisioned_new(struct mesh_net *net, uint8_t device_key[16],
+				uint16_t net_idx,  uint8_t net_key[16],
+				uint16_t unicast, uint16_t snb_flags,
+				uint32_t iv_index, mesh_status_func_t cb,
+				void *user_data);
diff --git a/meshd/src/prov.h b/meshd/src/prov.h
new file mode 100644
index 000000000..09fe6c3cd
--- /dev/null
+++ b/meshd/src/prov.h
@@ -0,0 +1,162 @@
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
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
+struct mesh_net;
+struct mesh_dev;
+
+enum mesh_trans {
+	MESH_TRANS_IDLE,
+	MESH_TRANS_TX,
+	MESH_TRANS_RX,
+};
+
+enum mesh_bearer {
+	MESH_BEARER_IDLE,
+	MESH_BEARER_ADV,
+};
+
+enum mesh_prov_mode {
+	MESH_PROV_MODE_NONE,
+	MESH_PROV_MODE_INITIATOR,
+	MESH_PROV_MODE_GATT_ACCEPTOR,
+	MESH_PROV_MODE_ADV_ACCEPTOR,
+	MESH_PROV_MODE_GATT_CLIENT,
+	MESH_PROV_MODE_MESH_SERVER,
+	MESH_PROV_MODE_MESH_CLIENT,
+	MESH_PROV_MODE_MESH_GATT_CLIENT,
+};
+
+struct mesh_prov;
+typedef void (*mesh_prov_open_func_t)(struct mesh_prov *prov);
+typedef void (*mesh_prov_close_func_t)(struct mesh_prov *prov, uint8_t reason);
+typedef void (*mesh_prov_send_func_t)(bool success, struct mesh_prov *prov);
+typedef void (*mesh_prov_receive_func_t)(const void *data, uint16_t size,
+							struct mesh_prov *prov);
+
+struct prov_invite {
+	uint8_t attention;
+} __packed;
+
+struct prov_start {
+	uint8_t algorithm;
+	uint8_t pub_key;
+	uint8_t auth_method;
+	uint8_t auth_action;
+	uint8_t auth_size;
+} __packed;
+
+struct conf_input {
+	struct prov_invite		invite;
+	struct mesh_net_prov_caps	caps;
+	struct prov_start		start;
+	uint8_t				prv_pub_key[64];
+	uint8_t				dev_pub_key[64];
+} __packed;
+
+struct mesh_prov {
+	int ref_count;
+	struct mesh_dev *dev;
+	struct mesh_net *net;
+	enum mesh_prov_mode mode;
+	enum mesh_trans trans;
+	enum mesh_bearer bearer;
+	uint8_t uuid[16];
+	uint8_t caps[12];
+
+	uint32_t conn_id;
+	uint16_t net_idx;
+	uint16_t remote;
+	uint16_t addr;
+	uint16_t expected_len;
+	uint16_t packet_len;
+	uint8_t local_msg_num;
+	uint8_t peer_msg_num;
+	uint8_t last_peer_msg_num;
+	uint8_t got_segs;
+	uint8_t expected_segs;
+	uint8_t expected_fcs;
+	uint8_t packet_buf[80];
+	uint8_t peer_buf[80];
+	struct timeval tx_start;
+	struct l_timeout *tx_timeout;
+
+	/* Provisioning credentials and crypto material */
+	struct conf_input conf_inputs;
+	uint8_t dev_key[16];
+	uint8_t conf_salt[16];
+	uint8_t s_key[16];
+	uint8_t s_nonce[13];
+	uint8_t conf_key[16];
+	uint8_t conf[16];
+	uint8_t r_conf[16];
+	uint8_t rand_auth[32];
+	uint8_t prov_salt[16];
+	uint8_t secret[32];
+	uint8_t r_public[64];
+	uint8_t l_public[64];
+	/* End Provisioning credentials and crypto material */
+
+	mesh_prov_open_func_t open_callback;
+	mesh_prov_close_func_t close_callback;
+	mesh_prov_receive_func_t receive_callback;
+	void *receive_data;
+	mesh_prov_send_func_t send_callback;
+	void *send_data;
+};
+
+struct mesh_prov *mesh_prov_new(struct mesh_net *net, uint16_t remote);
+
+struct mesh_prov *mesh_prov_ref(struct mesh_prov *prov);
+void mesh_prov_unref(struct mesh_prov *prov);
+
+bool mesh_prov_gatt_client(struct mesh_prov *prov, struct mesh_dev *dev,
+					uint8_t uuid[16],
+					mesh_prov_open_func_t open_callback,
+					mesh_prov_close_func_t close_callback,
+					mesh_prov_receive_func_t recv_callback,
+					void *user_data);
+
+bool mesh_prov_listen(struct mesh_net *net, uint8_t uuid[16], uint8_t caps[12],
+					mesh_prov_open_func_t open_callback,
+					mesh_prov_close_func_t close_callback,
+					mesh_prov_receive_func_t recv_callback,
+					void *user_data);
+
+bool mesh_prov_connect(struct mesh_prov *prov, struct mesh_dev *dev,
+					uint16_t net_idx, uint8_t uuid[16],
+					mesh_prov_open_func_t open_callback,
+					mesh_prov_close_func_t close_callback,
+					mesh_prov_receive_func_t recv_callback,
+					void *user_data);
+
+unsigned int mesh_prov_send(struct mesh_prov *prov,
+					const void *data, uint16_t size,
+					mesh_prov_send_func_t send_callback,
+					void *user_data);
+bool mesh_prov_cancel(struct mesh_prov *prov, unsigned int id);
+
+bool mesh_prov_close(struct mesh_prov *prov, uint8_t reason);
+void mesh_prov_set_addr(struct mesh_prov *prov, uint16_t addr);
+uint16_t mesh_prov_get_addr(struct mesh_prov *prov);
+void mesh_prov_set_idx(struct mesh_prov *prov, uint16_t net_idx);
+uint16_t mesh_prov_get_idx(struct mesh_prov *prov);
diff --git a/meshd/src/provision.h b/meshd/src/provision.h
new file mode 100644
index 000000000..0c59bf037
--- /dev/null
+++ b/meshd/src/provision.h
@@ -0,0 +1,30 @@
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
+struct mesh_prov;
+struct l_queue;
+
+void initiator_prov_open(struct mesh_prov *prov);
+void initiator_prov_close(struct mesh_prov *prov, uint8_t reason);
+void initiator_prov_receive(const void *pkt, uint16_t size,
+							struct mesh_prov *prov);
+void acceptor_prov_open(struct mesh_prov *prov);
+void acceptor_prov_close(struct mesh_prov *prov, uint8_t reason);
+void acceptor_prov_receive(const void *pkt, uint16_t size,
+							struct mesh_prov *prov);
-- 
2.14.3

