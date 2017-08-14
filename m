Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <brian.gix@intel.com>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Subject: [PATCH 2/5] mesh: define APIs for Bluetooth Mesh
Date: Mon, 14 Aug 2017 12:01:16 -0700
Message-Id: <20170814190119.8684-3-brian.gix@intel.com>
In-Reply-To: <20170814190119.8684-1-brian.gix@intel.com>
References: <20170814190119.8684-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/README         |  26 ++++++++
 mesh/agent.h        |  58 ++++++++++++++++++
 mesh/config-model.h | 119 +++++++++++++++++++++++++++++++++++
 mesh/crypto.h       | 133 +++++++++++++++++++++++++++++++++++++++
 mesh/gatt.h         |  47 ++++++++++++++
 mesh/keys.h         |  43 +++++++++++++
 mesh/mesh-net.h     | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/net.h          |  72 ++++++++++++++++++++++
 mesh/node.h         | 146 +++++++++++++++++++++++++++++++++++++++++++
 mesh/onoff-model.h  |  50 +++++++++++++++
 mesh/prov-db.h      |  52 ++++++++++++++++
 mesh/prov.h         |  43 +++++++++++++
 mesh/util.h         |  71 +++++++++++++++++++++
 13 files changed, 1034 insertions(+)
 create mode 100644 mesh/README
 create mode 100644 mesh/agent.h
 create mode 100644 mesh/config-model.h
 create mode 100644 mesh/crypto.h
 create mode 100644 mesh/gatt.h
 create mode 100644 mesh/keys.h
 create mode 100644 mesh/mesh-net.h
 create mode 100644 mesh/net.h
 create mode 100644 mesh/node.h
 create mode 100644 mesh/onoff-model.h
 create mode 100644 mesh/prov-db.h
 create mode 100644 mesh/prov.h
 create mode 100644 mesh/util.h

diff --git a/mesh/README b/mesh/README
new file mode 100644
index 0000000..ea561ef
--- /dev/null
+++ b/mesh/README
@@ -0,0 +1,26 @@
+MeshCtl - BlueZ GATT based Bluetooth Mesh Provisioner
+******************************************
+
+Copyright (C) 2017  Intel Corporation. All rights reserved.
+
+Compilation and installation
+============================
+
+In addition to main BlueZ requirements, MeshCtl needs the following:
+	- JSON library
+
+Configuration and options
+=========================
+
+	--enable-mesh
+
+		Build meshctl and other Bluetooth Mesh based tools and utils
+
+Information
+===========
+
+Mailing lists:
+	linux-bluetooth@vger.kernel.org
+
+For additional information about the project visit BlueZ web site:
+	http://www.bluez.org
diff --git a/mesh/agent.h b/mesh/agent.h
new file mode 100644
index 0000000..fe19353
--- /dev/null
+++ b/mesh/agent.h
@@ -0,0 +1,58 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_AGENT_H
+#define __MESH_AGENT_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define MAX_HEXADECIMAL_OOB_LEN	128
+#define DECIMAL_OOB_LEN		4
+#define MAX_ASCII_OOB_LEN		16
+
+typedef enum {
+	NONE,
+	HEXADECIMAL,
+	DECIMAL,
+	ASCII,
+	OUTPUT,
+} oob_type_t;
+
+typedef void (*agent_input_cb)(oob_type_t type, void *input, uint16_t len,
+					void *user_data);
+bool agent_input_request(oob_type_t type, uint16_t max_len, agent_input_cb cb,
+				void *user_data);
+
+bool agent_output_request(const char* str);
+void agent_output_request_cancel(void);
+bool agent_completion(void);
+bool agent_input(const char *input);
+void agent_release(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_AGENT_H */
diff --git a/mesh/config-model.h b/mesh/config-model.h
new file mode 100644
index 0000000..115491f
--- /dev/null
+++ b/mesh/config-model.h
@@ -0,0 +1,119 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_CONFIG_MODEL_H
+#define __MESH_CONFIG_MODEL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define CONFIG_SERVER_MODEL_ID	0x0000
+#define CONFIG_CLIENT_MODEL_ID	0x0001
+
+#define OP_APPKEY_ADD				0x00
+#define OP_APPKEY_DELETE			0x8000
+#define OP_APPKEY_GET				0x8001
+#define OP_APPKEY_LIST				0x8002
+#define OP_APPKEY_STATUS			0x8003
+#define OP_APPKEY_UPDATE			0x01
+#define OP_DEV_COMP_GET				0x8008
+#define OP_DEV_COMP_STATUS			0x02
+#define OP_CONFIG_BEACON_GET			0x8009
+#define OP_CONFIG_BEACON_SET			0x800A
+#define OP_CONFIG_BEACON_STATUS			0x800B
+#define OP_CONFIG_DEFAULT_TTL_GET		0x800C
+#define OP_CONFIG_DEFAULT_TTL_SET		0x800D
+#define OP_CONFIG_DEFAULT_TTL_STATUS		0x800E
+#define OP_CONFIG_FRIEND_GET			0x800F
+#define OP_CONFIG_FRIEND_SET			0x8010
+#define OP_CONFIG_FRIEND_STATUS			0x8011
+#define OP_CONFIG_PROXY_GET			0x8012
+#define OP_CONFIG_PROXY_SET			0x8013
+#define OP_CONFIG_PROXY_STATUS			0x8014
+#define OP_CONFIG_KEY_REFRESH_PHASE_GET		0x8015
+#define OP_CONFIG_KEY_REFRESH_PHASE_SET		0x8016
+#define OP_CONFIG_KEY_REFRESH_PHASE_STATUS	0x8017
+#define OP_CONFIG_MODEL_PUB_GET			0x8018
+#define OP_CONFIG_MODEL_PUB_SET			0x03
+#define OP_CONFIG_MODEL_PUB_STATUS		0x8019
+#define OP_CONFIG_MODEL_PUB_VIRT_SET		0x801A
+#define OP_CONFIG_MODEL_SUB_ADD			0x801B
+#define OP_CONFIG_MODEL_SUB_DELETE		0x801C
+#define OP_CONFIG_MODEL_SUB_DELETE_ALL		0x801D
+#define OP_CONFIG_MODEL_SUB_OVERWRITE		0x801E
+#define OP_CONFIG_MODEL_SUB_STATUS		0x801F
+#define OP_CONFIG_MODEL_SUB_VIRT_ADD		0x8020
+#define OP_CONFIG_MODEL_SUB_VIRT_DELETE		0x8021
+#define OP_CONFIG_MODEL_SUB_VIRT_OVERWRITE	0x8022
+#define OP_CONFIG_NETWORK_TRANSMIT_GET		0x8023
+#define OP_CONFIG_NETWORK_TRANSMIT_SET		0x8024
+#define OP_CONFIG_NETWORK_TRANSMIT_STATUS	0x8025
+#define OP_CONFIG_RELAY_GET			0x8026
+#define OP_CONFIG_RELAY_SET			0x8027
+#define OP_CONFIG_RELAY_STATUS			0x8028
+#define OP_CONFIG_MODEL_SUB_GET			0x8029
+#define OP_CONFIG_MODEL_SUB_LIST		0x802A
+#define OP_CONFIG_VEND_MODEL_SUB_GET		0x802B
+#define OP_CONFIG_VEND_MODEL_SUB_LIST		0x802C
+#define OP_CONFIG_POLL_TIMEOUT_LIST		0x802D
+#define OP_CONFIG_POLL_TIMEOUT_STATUS		0x802E
+#define OP_CONFIG_HEARTBEAT_PUB_GET		0x8038
+#define OP_CONFIG_HEARTBEAT_PUB_SET		0x8039
+#define OP_CONFIG_HEARTBEAT_PUB_STATUS		0x06
+#define OP_CONFIG_HEARTBEAT_SUB_GET		0x803A
+#define OP_CONFIG_HEARTBEAT_SUB_SET		0x803B
+#define OP_CONFIG_HEARTBEAT_SUB_STATUS		0x803C
+#define OP_MODEL_APP_BIND			0x803D
+#define OP_MODEL_APP_STATUS			0x803E
+#define OP_MODEL_APP_UNBIND			0x803F
+#define OP_NETKEY_ADD				0x8040
+#define OP_NETKEY_DELETE			0x8041
+#define OP_NETKEY_GET				0x8042
+#define OP_NETKEY_LIST				0x8043
+#define OP_NETKEY_STATUS			0x8044
+#define OP_NETKEY_UPDATE			0x8045
+#define OP_NODE_IDENTITY_GET			0x8046
+#define OP_NODE_IDENTITY_SET			0x8047
+#define OP_NODE_IDENTITY_STATUS			0x8048
+#define OP_NODE_RESET				0x8049
+#define OP_NODE_RESET_STATUS			0x804A
+#define OP_MODEL_APP_GET			0x804B
+#define OP_MODEL_APP_LIST			0x804C
+#define OP_VEND_MODEL_APP_GET			0x804C
+#define OP_VEND_MODEL_APP_LIST			0x804E
+
+bool config_server_init(void);
+bool config_client_init(void);
+void config_client_get_composition(uint32_t dst);
+void config_set_node(const char *args);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_CONFIG_MODEL_H */
diff --git a/mesh/crypto.h b/mesh/crypto.h
new file mode 100644
index 0000000..98bc065
--- /dev/null
+++ b/mesh/crypto.h
@@ -0,0 +1,133 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_CRYPTO_H
+#define __MESH_CRYPTO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <stdbool.h>
+#include <stdint.h>
+
+bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
+					const uint8_t *aad, uint16_t aad_len,
+					const uint8_t *msg, uint16_t msg_len,
+					uint8_t *out_msg, void *out_mic,
+					size_t mic_size);
+bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
+				const uint8_t *aad, uint16_t aad_len,
+				const uint8_t *enc_msg, uint16_t enc_msg_len,
+				uint8_t *out_msg, void *out_mic,
+				size_t mic_size);
+bool mesh_crypto_nkik(const uint8_t network_key[16], uint8_t identity_key[16]);
+bool mesh_crypto_nkbk(const uint8_t network_key[16], uint8_t beacon_key[16]);
+bool mesh_crypto_identity(const uint8_t net_key[16], uint16_t addr,
+							uint8_t id[16]);
+bool mesh_crypto_identity_check(const uint8_t net_key[16], uint16_t addr,
+							uint8_t id[16]);
+bool mesh_crypto_beacon_cmac(const uint8_t encryption_key[16],
+				const uint8_t network_id[16],
+				uint32_t iv_index, bool kr, bool iu,
+				uint64_t *cmac);
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
+					uint8_t *out, void *app_mic,
+					size_t mic_size);
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
+bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
+				const uint8_t network_key[16],
+				uint32_t iv_index,
+				const uint8_t privacy_key[16]);
+bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
+				bool proxy, uint8_t *out, uint32_t iv_index,
+				const uint8_t network_key[16],
+				const uint8_t privacy_key[16]);
+
+bool mesh_crypto_aes_cmac(const uint8_t key[16], const uint8_t *msg,
+					size_t msg_len, uint8_t res[16]);
+
+bool mesh_get_random_bytes(void *buf, size_t num_bytes);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/mesh/gatt.h b/mesh/gatt.h
new file mode 100644
index 0000000..d6e5ec3
--- /dev/null
+++ b/mesh/gatt.h
@@ -0,0 +1,47 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_GATT_H
+#define __MESH_GATT_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gdbus/gdbus.h"
+#include "node.h"
+
+uint16_t mesh_gatt_sar(uint8_t **pkt, uint16_t size);
+bool mesh_gatt_is_child(GDBusProxy *proxy, GDBusProxy *parent,
+			const char *name);
+bool mesh_gatt_write(GDBusProxy *proxy, uint8_t *buf, uint16_t len,
+			GDBusReturnFunction cb, void *user_data);
+bool mesh_gatt_notify(GDBusProxy *proxy, bool enable, GDBusReturnFunction cb,
+			void *user_data);
+void mesh_gatt_cleanup(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_GATT_H */
diff --git a/mesh/keys.h b/mesh/keys.h
new file mode 100644
index 0000000..5b955b2
--- /dev/null
+++ b/mesh/keys.h
@@ -0,0 +1,43 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define KR_PHASE_NONE		0x00
+#define KR_PHASE_ONE		0x01
+#define KR_PHASE_TWO		0x02
+#define KR_PHASE_INVALID	0xff
+
+bool keys_app_key_add(uint16_t net_idx, uint16_t app_idx, uint8_t *key,
+		      bool update);
+bool keys_net_key_add(uint16_t index, uint8_t *key, bool update);
+uint16_t keys_app_key_get_bound(uint16_t app_idx);
+uint8_t *keys_app_key_get(uint16_t app_idx, bool current);
+uint8_t *keys_net_key_get(uint16_t net_idx, bool current);
+bool keys_app_key_delete(uint16_t app_idx);
+bool keys_net_key_delete(uint16_t net_idx);
+uint8_t keys_get_kr_phase(uint16_t net_idx);
+bool keys_set_kr_phase(uint16_t index, uint8_t phase);
+void keys_cleanup_all(void);
diff --git a/mesh/mesh-net.h b/mesh/mesh-net.h
new file mode 100644
index 0000000..cb6c6e4
--- /dev/null
+++ b/mesh/mesh-net.h
@@ -0,0 +1,174 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_NETORK_H
+#define __MESH_NETORK_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* Proxy PDU Types */
+#define PROXY_NETWORK_PDU	0x00
+#define PROXY_MESH_BEACON	0x01
+#define PROXY_CONFIG_PDU	0x02
+#define PROXY_PROVISIONING_PDU	0x03
+
+#define CTL		0x80
+#define TTL_MASK 	0x7f
+#define SEQ_MASK	0xffffff
+
+#define CREDFLAG_MASK	0x1000
+#define APP_IDX_MASK	0x0fff
+#define APP_IDX_DEV	0x7fff
+#define APP_IDX_ANY	0x8000
+#define APP_IDX_NET	0xffff
+#define APP_IDX_INVALID	0xffff
+
+#define NET_IDX_INVALID	0xffff
+#define NET_IDX_PRIMARY	0x0000
+
+#define KEY_CACHE_SIZE 64
+#define FRND_CACHE_MAX 32
+
+#define UNASSIGNED_ADDRESS	0x0000
+#define PROXIES_ADDRESS		0xfffc
+#define FRIENDS_ADDRESS		0xfffd
+#define RELAYS_ADDRESS		0xfffe
+#define ALL_NODES_ADDRESS	0xffff
+#define VIRTUAL_ADDRESS_LOW	0x8000
+#define VIRTUAL_ADDRESS_HIGH	0xbfff
+#define GROUP_ADDRESS_LOW	0xc000
+#define GROUP_ADDRESS_HIGH	0xff00
+
+#define DEFAULT_TTL		0xff
+
+#define PRIMARY_ELEMENT_IDX	0x00
+
+#define MAX_UNSEG_LEN	15 /* msg_len == 11 + sizeof(MIC) */
+#define MAX_SEG_LEN	12 /* UnSeg length - 3 octets overhead */
+#define SEG_MAX(len)	(((len) <= MAX_UNSEG_LEN) ? 0 : \
+		(((len) - 1) / MAX_SEG_LEN))
+#define SEG_OFF(seg)	((seg) * MAX_SEG_LEN)
+#define MAX_SEG_TO_LEN(seg)	((seg) ? SEG_OFF((seg) + 1) : MAX_UNSEG_LEN)
+
+
+#define IS_UNASSIGNED(x)	((x) == UNASSIGNED_ADDRESS)
+#define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) && \
+					((x) < VIRTUAL_ADDRESS_LOW))
+#define IS_VIRTUAL(x)		(((x) >= VIRTUAL_ADDRESS_LOW) && \
+					((x) <= VIRTUAL_ADDRESS_HIGH))
+#define IS_GROUP(x)		(((x) >= GROUP_ADDRESS_LOW) && \
+					((x) <= GROUP_ADDRESS_HIGH))
+#define IS_ALL_NODES(x)		((x) == ALL_NODES_ADDRESS)
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
+/* Key refresh state on the mesh */
+#define NET_KEY_REFRESH_PHASE_NONE	0x00
+#define NET_KEY_REFRESH_PHASE_ONE	0x01
+#define NET_KEY_REFRESH_PHASE_TWO	0x02
+#define NET_KEY_REFRESH_PHASE_THREE	0x03
+
+#define MESH_FEATURE_RELAY	1
+#define MESH_FEATURE_PROXY	2
+#define MESH_FEATURE_FRIEND	4
+#define MESH_FEATURE_LPN	8
+
+#define MESH_MAX_ACCESS_PAYLOAD		380
+
+#define MESH_STATUS_SUCCESS		0x00
+#define MESH_STATUS_INVALID_ADDRESS	0x01
+#define MESH_STATUS_INVALID_MODEL	0x02
+#define MESH_STATUS_INVALID_APPKEY	0x03
+#define MESH_STATUS_INVALID_NETKEY	0x04
+#define MESH_STATUS_INSUFF_RESOURCES	0x05
+#define MESH_STATUS_IDX_ALREADY_STORED	0x06
+#define MESH_STATUS_INVALID_PUB_PARAM	0x07
+#define MESH_STATUS_NOT_SUB_MOD		0x08
+#define MESH_STATUS_STORAGE_FAIL	0x09
+#define MESH_STATUS_FEAT_NOT_SUP	0x0a
+#define MESH_STATUS_CANNOT_UPDATE	0x0b
+#define MESH_STATUS_CANNOT_REMOVE	0x0c
+#define MESH_STATUS_CANNOT_BIND		0x0d
+#define MESH_STATUS_UNABLE_CHANGE_STATE	0x0e
+#define MESH_STATUS_CANNOT_SET		0x0f
+#define MESH_STATUS_UNSPECIFIED_ERROR	0x10
+#define MESH_STATUS_INVALID_BINDING	0x11
+
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_NETORK_H */
diff --git a/mesh/net.h b/mesh/net.h
new file mode 100644
index 0000000..00866cb
--- /dev/null
+++ b/mesh/net.h
@@ -0,0 +1,72 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_NET_H
+#define __MESH_NET_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gdbus/gdbus.h"
+#include "node.h"
+
+typedef void (*net_mesh_session_open_callback)(int status);
+
+uint32_t net_get_iv_index(bool *iv_update);
+bool net_get_key(uint16_t net_idx, uint8_t *key);
+bool net_get_flags(uint16_t net_idx, uint8_t *out_flags);
+void net_set_iv_index(uint32_t index, bool update);
+uint32_t get_sequence_number(void);
+void set_sequence_number(uint32_t seq_number);
+uint16_t net_validate_proxy_beacon(const uint8_t *proxy_beacon);
+bool net_add_address_pool(uint16_t min, uint16_t max);
+uint16_t net_obtain_address(uint8_t num_elements);
+bool net_reserve_address_range(uint16_t base, uint8_t num_elements);
+void net_release_address(uint16_t addr, uint8_t num_elements);
+bool net_session_open(GDBusProxy *data_in, bool provisioner,
+					net_mesh_session_open_callback cb);
+void net_session_close(GDBusProxy *data_in);
+
+bool net_data_ready(uint8_t *ptr, uint8_t len);
+bool net_access_layer_send(uint8_t ttl, uint16_t src, uint32_t dst,
+				uint16_t app_idx, uint8_t *buf, uint16_t len);
+bool net_ctl_msg_send(uint8_t ttl, uint16_t src, uint16_t dst,
+					uint8_t *buf, uint16_t len);
+bool net_set_default_ttl(uint8_t ttl);
+uint8_t net_get_default_ttl(void);
+bool net_set_seq_num(uint32_t seq_num);
+uint32_t net_get_seq_num(void);
+void net_dest_ref(uint16_t dst);
+void net_dest_unref(uint16_t dst);
+bool net_register_unicast(uint16_t unicast, uint8_t count);
+bool net_register_group(uint16_t group_addr);
+uint32_t net_register_virtual(uint8_t buf[16]);
+bool mesh_model_recv(uint16_t app_idx, uint16_t src, uint32_t dst,
+						uint8_t *payload, uint16_t len);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_NET_H */
diff --git a/mesh/node.h b/mesh/node.h
new file mode 100644
index 0000000..40b964c
--- /dev/null
+++ b/mesh/node.h
@@ -0,0 +1,146 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_NODE_H
+#define __MESH_NODE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* Largest Possible GATT Packet: Provisioning Public Key + type + sar */
+#define MAX_GATT_SIZE	(64 + 1 + 1)
+
+#define GATT_SAR_MASK		0xc0
+#define GATT_SAR_COMPLETE	0x00
+#define GATT_SAR_FIRST		0x40
+#define GATT_SAR_CONTINUE	0x80
+#define GATT_SAR_LAST		0xc0
+#define GATT_TYPE_INVALID	0xff
+#define GATT_TYPE_MASK		0x3f
+
+struct mesh_node;
+
+#define ACTION_ADD		1
+#define ACTION_UPDATE		2
+#define ACTION_DELETE		3
+
+struct prov_svc_data {
+	uint16_t oob;
+	uint8_t dev_uuid[16];
+};
+
+struct mesh_node_composition {
+	bool relay;
+	bool proxy;
+	bool lpn;
+	bool friend;
+	uint16_t cid;
+	uint16_t pid;
+	uint16_t vid;
+	uint16_t crpl;
+};
+
+struct mesh_publication {
+	uint16_t app_idx;
+	union {
+		uint16_t addr16;
+		uint8_t va_128[16];
+	} u;
+	uint8_t ttl;
+	uint8_t credential;
+	uint8_t period;
+	uint8_t retransmit;
+};
+
+typedef bool (*node_model_recv_callback)(uint16_t src, uint8_t *data,
+						uint16_t len, void *user_data);
+typedef int (*node_model_bind_callback)(uint16_t app_idx, int action);
+typedef void (*node_model_pub_callback)(struct mesh_publication *pub);
+typedef void (*node_model_sub_callback)(uint16_t sub_addr, int action);
+
+struct mesh_model_ops {
+	node_model_recv_callback recv;
+	node_model_bind_callback bind;
+	node_model_pub_callback pub;
+	node_model_sub_callback sub;
+};
+
+struct mesh_node *node_find_by_addr(uint16_t addr);
+struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
+struct mesh_node *node_create_new(struct prov_svc_data *prov);
+struct mesh_node *node_new(void);
+void node_free(struct mesh_node *node);
+bool node_is_provisioned(struct mesh_node *node);
+void *node_get_prov(struct mesh_node *node);
+void node_set_prov(struct mesh_node *node, void *prov);
+bool node_app_key_add(struct mesh_node *node, uint16_t idx);
+bool node_net_key_add(struct mesh_node *node, uint16_t index);
+bool node_app_key_delete(struct mesh_node *node, uint16_t net_idx,
+				uint16_t idx);
+bool node_net_key_delete(struct mesh_node *node, uint16_t index);
+void node_set_primary(struct mesh_node *node, uint16_t unicast);
+uint16_t node_get_primary(struct mesh_node *node);
+uint16_t node_get_primary_net_idx(struct mesh_node *node);
+void node_set_device_key(struct mesh_node *node, uint8_t *key);
+uint8_t *node_get_device_key(struct mesh_node *node);
+void node_set_num_elements(struct mesh_node *node, uint8_t num_ele);
+uint8_t node_get_num_elements(struct mesh_node *node);
+bool node_parse_composition(struct mesh_node *node, uint8_t *buf, uint16_t len);
+GList *node_get_net_keys(struct mesh_node *node);
+GList *node_get_app_keys(struct mesh_node *node);
+void node_cleanup(void);
+
+bool node_set_local_node(struct mesh_node *node);
+struct mesh_node *node_get_local_node(void);
+void node_local_data_handler(uint16_t src, uint32_t dst,
+				uint32_t iv_index, uint32_t seq_num,
+				uint16_t app_idx, uint8_t *data, uint16_t len);
+
+bool node_local_model_register(uint8_t element_idx, uint16_t model_id,
+				struct mesh_model_ops *ops, void *user_data);
+bool node_local_vendor_model_register(uint8_t element_idx, uint32_t model_id,
+				struct mesh_model_ops *ops, void *user_data);
+
+bool node_set_element(struct mesh_node *node, uint8_t ele_idx);
+bool node_set_model(struct mesh_node *node, uint8_t ele_idx, uint32_t id);
+struct mesh_node_composition *node_get_composition(struct mesh_node *node);
+bool node_set_composition(struct mesh_node *node,
+				struct mesh_node_composition *comp);
+bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t app_idx);
+uint8_t node_get_default_ttl(struct mesh_node *node);
+bool node_set_default_ttl(struct mesh_node *node, uint8_t ttl);
+bool node_set_sequence_number(struct mesh_node *node, uint32_t seq);
+uint32_t node_get_sequence_number(struct mesh_node *node);
+bool node_set_iv_index(struct mesh_node *node, uint32_t iv_index);
+uint32_t node_get_iv_index(struct mesh_node *node);
+bool node_model_pub_set(struct mesh_node *node, uint8_t ele, uint32_t model_id,
+						struct mesh_publication *pub);
+struct mesh_publication *node_model_pub_get(struct mesh_node *node, uint8_t ele,
+							uint32_t model_id);
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_NODE_H */
diff --git a/mesh/onoff-model.h b/mesh/onoff-model.h
new file mode 100644
index 0000000..57f3ecc
--- /dev/null
+++ b/mesh/onoff-model.h
@@ -0,0 +1,50 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_GENERIC_ONOFF_MODEL_H
+#define __MESH_GENERIC_ONOFF_MODEL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define GENERIC_ONOFF_SERVER_MODEL_ID	0x1000
+#define GENERIC_ONOFF_CLIENT_MODEL_ID	0x1001
+
+#define OP_GENERIC_ONOFF_GET			0x8201
+#define OP_GENERIC_ONOFF_SET			0x8202
+#define OP_GENERIC_ONOFF_SET_UNACK		0x8203
+#define OP_GENERIC_ONOFF_STATUS			0x8204
+
+void onoff_set_node(const char *args);
+bool onoff_client_init(uint8_t ele);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_GENERIC_ONOFF_MODEL_H */
diff --git a/mesh/prov-db.h b/mesh/prov-db.h
new file mode 100644
index 0000000..6b95937
--- /dev/null
+++ b/mesh/prov-db.h
@@ -0,0 +1,52 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_PROV_DB_H
+#define __MESH_PROV_DB_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+bool prov_db_show(const char *filename);
+bool prov_db_read(const char *filename);
+bool prov_db_read_local_node(const char *filename, bool provisioner);
+bool prov_db_add_new_node(struct mesh_node *node);
+bool prov_db_add_node_composition(struct mesh_node *node, uint8_t *data,
+								uint16_t len);
+bool prov_db_node_keys(struct mesh_node *node, GList *idxs, const char *desc);
+bool prov_db_add_binding(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t app_idx);
+bool prov_db_node_set_ttl(struct mesh_node *node, uint8_t ttl);
+bool prov_db_node_set_iv_seq(struct mesh_node *node, uint32_t iv, uint32_t seq);
+bool prov_db_local_set_iv_index(uint32_t iv_index, bool update, bool prov);
+bool prov_db_local_set_seq_num(uint32_t seq_num);
+bool prov_db_node_set_model_pub(struct mesh_node *node, uint8_t ele_idx,
+							uint32_t model_id,
+						struct mesh_publication *pub);
+void prov_db_print_node_composition(struct mesh_node *node);
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_PROV_DB_H */
diff --git a/mesh/prov.h b/mesh/prov.h
new file mode 100644
index 0000000..c4e068a
--- /dev/null
+++ b/mesh/prov.h
@@ -0,0 +1,43 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_PROV_H
+#define __MESH_PROV_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct prov;
+
+typedef void (*provision_done_cb)(void *user_data, int status);
+
+bool prov_open(struct mesh_node *node, GDBusProxy *prov_in, uint16_t net_idx,
+		provision_done_cb cb, void *user_data);
+bool prov_data_ready(struct mesh_node *node, uint8_t *buf, uint8_t len);
+bool prov_complete(struct mesh_node *node, uint8_t status);
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_PROV_H */
diff --git a/mesh/util.h b/mesh/util.h
new file mode 100644
index 0000000..8212b53
--- /dev/null
+++ b/mesh/util.h
@@ -0,0 +1,71 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __MESH_UTIL_H
+#define __MESH_UTIL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdbool.h>
+
+#include "node.h"
+
+#define OP_UNRELIABLE			0x0100
+
+struct menu_entry {
+	const char *cmd;
+	const char *arg;
+	void (*func) (const char *arg);
+	const char *desc;
+};
+
+bool cmd_menu_init(const struct menu_entry *cmd_table);
+void cmd_menu_main(bool forced);
+bool add_cmd_menu(const char *name, const struct menu_entry *cmd_table);
+bool switch_cmd_menu(const char *name);
+void set_menu_prompt(const char *prefix, const char * node);
+void process_menu_cmd(const char *cmd, const char *arg);
+void print_cmd_menu(const struct menu_entry *cmd_table);
+void cmd_menu_cleanup(void);
+void print_byte_array(const char *prefix, const void *ptr, int len);
+bool str2hex(const char *str, uint16_t in_len, uint8_t *out_buf,
+		uint16_t out_len);
+size_t hex2str(uint8_t *in, size_t in_len, char *out,
+		size_t out_len);
+uint16_t mesh_opcode_set(uint32_t opcode, uint8_t *buf);
+bool mesh_opcode_get(const uint8_t *buf, uint16_t sz, uint32_t *opcode, int *n);
+const char *mesh_status_str(uint8_t status);
+void print_model_pub(uint16_t ele_addr, uint32_t mod_id,
+						struct mesh_publication *pub);
+void swap_u256_bytes(uint8_t *u256);
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MESH_UTIL_H */
-- 
2.9.5
