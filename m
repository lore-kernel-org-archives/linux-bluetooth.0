Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH 3/7] meshd: Header files for mesh access layer and utilities
Date: Wed, 25 Apr 2018 07:20:38 -0700
Message-Id: <20180425142042.1262-4-brian.gix@intel.com>
In-Reply-To: <20180425142042.1262-1-brian.gix@intel.com>
References: <20180425142042.1262-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Inga Stotland <inga.stotland@intel.com>

This adds initial implementation of Mesh access layer functionality
---
 meshd/common/agent.h     |  42 ++++++++++++++
 meshd/common/mesh-defs.h |  84 +++++++++++++++++++++++++++
 meshd/common/util.h      |  25 ++++++++
 meshd/src/appkey.h       |  43 ++++++++++++++
 meshd/src/cfgmod.h       |  98 +++++++++++++++++++++++++++++++
 meshd/src/mesh.h         |  32 +++++++++++
 meshd/src/model.h        | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 meshd/src/node.h         |  80 ++++++++++++++++++++++++++
 meshd/src/storage.h      |  51 +++++++++++++++++
 9 files changed, 601 insertions(+)
 create mode 100644 meshd/common/agent.h
 create mode 100644 meshd/common/mesh-defs.h
 create mode 100644 meshd/common/util.h
 create mode 100644 meshd/src/appkey.h
 create mode 100644 meshd/src/cfgmod.h
 create mode 100644 meshd/src/mesh.h
 create mode 100644 meshd/src/model.h
 create mode 100644 meshd/src/node.h
 create mode 100644 meshd/src/storage.h

diff --git a/meshd/common/agent.h b/meshd/common/agent.h
new file mode 100644
index 000000000..6fb475691
--- /dev/null
+++ b/meshd/common/agent.h
@@ -0,0 +1,42 @@
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
+ *
+ */
+
+#define MAX_HEXADECIMAL_OOB_LEN	128
+#define DECIMAL_OOB_LEN		4
+#define MAX_ASCII_OOB_LEN		16
+
+enum oob_type {
+	NONE,
+	HEXADECIMAL,
+	DECIMAL,
+	ASCII,
+	OUTPUT,
+} oob_type_t;
+
+typedef void (*agent_input_cb)(enum oob_type type, void *input, uint16_t len,
+							void *user_data);
+bool agent_input_request(enum oob_type type, uint16_t max_len,
+					agent_input_cb cb, void *user_data);
+
+bool agent_output_request(const char *str);
+void agent_output_request_cancel(void);
+bool agent_completion(void);
+bool agent_input(const char *input);
+void agent_release(void);
diff --git a/meshd/common/mesh-defs.h b/meshd/common/mesh-defs.h
new file mode 100644
index 000000000..d40fc43e8
--- /dev/null
+++ b/meshd/common/mesh-defs.h
@@ -0,0 +1,84 @@
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
+#define MESH_AD_TYPE_PROVISION	0x29
+#define MESH_AD_TYPE_NETWORK	0x2A
+#define MESH_AD_TYPE_BEACON	0x2B
+
+#define FEATURE_RELAY	1
+#define FEATURE_PROXY	2
+#define FEATURE_FRIEND	4
+#define FEATURE_LPN	8
+
+#define MESH_MODE_DISABLED	0
+#define MESH_MODE_ENABLED	1
+#define MESH_MODE_UNSUPPORTED	2
+
+#define KEY_REFRESH_PHASE_NONE	0x00
+#define KEY_REFRESH_PHASE_ONE	0x01
+#define KEY_REFRESH_PHASE_TWO	0x02
+#define KEY_REFRESH_PHASE_THREE	0x03
+
+#define DEFAULT_TTL		0xff
+
+/* Supported algorithms for provisioning */
+#define ALG_FIPS_256_ECC	0x0001
+
+/* Input OOB action bit flags */
+#define OOB_IN_PUSH	0x0001
+#define OOB_IN_TWIST	0x0002
+#define OOB_IN_NUMBER	0x0004
+#define OOB_IN_ALPHA	0x0008
+
+/* Output OOB action bit flags */
+#define OOB_OUT_BLINK	0x0001
+#define OOB_OUT_BEEP	0x0002
+#define OOB_OUT_VIBRATE	0x0004
+#define OOB_OUT_NUMBER	0x0008
+#define OOB_OUT_ALPHA	0x0010
+
+#define UNASSIGNED_ADDRESS	0x0000
+#define PROXIES_ADDRESS	0xfffc
+#define FRIENDS_ADDRESS	0xfffd
+#define RELAYS_ADDRESS		0xfffe
+#define ALL_NODES_ADDRESS	0xffff
+#define VIRTUAL_ADDRESS_LOW	0x8000
+#define VIRTUAL_ADDRESS_HIGH	0xbfff
+#define GROUP_ADDRESS_LOW	0xc000
+#define GROUP_ADDRESS_HIGH	0xff00
+
+#define NODE_IDENTITY_STOPPED		0x00
+#define NODE_IDENTITY_RUNNING		0x01
+#define NODE_IDENTITY_NOT_SUPPORTED	0x02
+
+#define PRIMARY_ELE_IDX		0x00
+
+#define VENDOR_ID_MASK		0xffff0000
+
+#define MAX_KEY_IDX		0x0fff
+
+#define IS_UNASSIGNED(x)	((x) == UNASSIGNED_ADDRESS)
+#define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) && \
+					((x) < VIRTUAL_ADDRESS_LOW))
+#define IS_VIRTUAL(x)		(((x) >= VIRTUAL_ADDRESS_LOW) && \
+					((x) <= VIRTUAL_ADDRESS_HIGH))
+#define IS_GROUP(x)		(((x) >= GROUP_ADDRESS_LOW) && \
+					((x) <= GROUP_ADDRESS_HIGH))
+#define IS_ALL_NODES(x)	((x) == ALL_NODES_ADDRESS)
diff --git a/meshd/common/util.h b/meshd/common/util.h
new file mode 100644
index 000000000..ed880bce7
--- /dev/null
+++ b/meshd/common/util.h
@@ -0,0 +1,25 @@
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
+uint32_t get_timestamp_secs(void);
+bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
+							uint16_t out_len);
+size_t hex2str(uint8_t *in, size_t in_len, char *out, size_t out_len);
+
diff --git a/meshd/src/appkey.h b/meshd/src/appkey.h
new file mode 100644
index 000000000..8fce3dcd0
--- /dev/null
+++ b/meshd/src/appkey.h
@@ -0,0 +1,43 @@
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
+/* TODO: get this number from configuration */
+#define MAX_APP_KEYS	32
+
+bool appkey_key_init(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
+				uint8_t *key_value, uint8_t *new_key_value);
+void appkey_key_free(void *data);
+int appkey_packet_decrypt(struct mesh_net *net, bool szmict, uint32_t seq,
+				uint32_t iv_index, uint16_t src, uint16_t dst,
+				uint8_t *virt, uint16_t virt_size,
+				uint8_t key_id, const uint8_t *data,
+				uint16_t data_size, uint8_t *out);
+bool appkey_msg_in_replay_cache(struct mesh_net *net, uint16_t idx,
+				uint16_t src, uint16_t crpl, uint32_t seq,
+				uint32_t iv_index);
+const uint8_t *appkey_get_key(struct mesh_net *net, uint16_t app_idx,
+							uint8_t *key_id);
+bool appkey_have_key(struct mesh_net *net, uint16_t app_idx);
+int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
+					const uint8_t *new_key, bool update);
+int appkey_key_delete(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx);
+void appkey_delete_bound_keys(struct mesh_net *net, uint16_t net_idx);
+uint8_t appkey_list(struct mesh_net *net, uint16_t net_idx, uint8_t *buf,
+					uint16_t buf_size, uint16_t *size);
diff --git a/meshd/src/cfgmod.h b/meshd/src/cfgmod.h
new file mode 100644
index 000000000..bedb0c6f6
--- /dev/null
+++ b/meshd/src/cfgmod.h
@@ -0,0 +1,98 @@
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
+#define CONFIG_SRV_MODEL	(VENDOR_ID_MASK | 0x0000)
+#define CONFIG_CLI_MODEL	(VENDOR_ID_MASK | 0x0001)
+
+/* New List */
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
+/* Health opcodes in health-mod.h */
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
+void mesh_config_srv_init(struct mesh_net *net, uint8_t ele_idx);
diff --git a/meshd/src/mesh.h b/meshd/src/mesh.h
new file mode 100644
index 000000000..7cd1e6158
--- /dev/null
+++ b/meshd/src/mesh.h
@@ -0,0 +1,32 @@
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
+struct bt_mesh;
+struct mesh_net;
+
+struct bt_mesh *mesh_create(uint16_t index);
+struct bt_mesh *mesh_ref(struct bt_mesh *mesh);
+void mesh_unref(struct bt_mesh *mesh);
+bool mesh_load_config(struct bt_mesh *mesh, const char *in_config_name);
+bool mesh_set_output(struct bt_mesh *mesh, const char *out_config_name);
+const char *mesh_status_str(uint8_t err);
+
+/* Command line testing */
+struct mesh_net *mesh_get_net(struct bt_mesh *mesh);
diff --git a/meshd/src/model.h b/meshd/src/model.h
new file mode 100644
index 000000000..3a41bd722
--- /dev/null
+++ b/meshd/src/model.h
@@ -0,0 +1,146 @@
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
+#include <ell/ell.h>
+
+struct mesh_model;
+
+#define OP_UNRELIABLE			0x0100
+
+#define MAX_BINDINGS	10
+#define MAX_GRP_PER_MOD	10
+
+#define	VIRTUAL_BASE			0x10000
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
+#define MESH_STATUS_FEATURE_NO_SUPPORT	0x0a
+#define MESH_STATUS_CANNOT_UPDATE	0x0b
+#define MESH_STATUS_CANNOT_REMOVE	0x0c
+#define MESH_STATUS_CANNOT_BIND		0x0d
+#define MESH_STATUS_UNABLE_CHANGE_STATE	0x0e
+#define MESH_STATUS_CANNOT_SET		0x0f
+#define MESH_STATUS_UNSPECIFIED_ERROR	0x10
+#define MESH_STATUS_INVALID_BINDING	0x11
+
+#define OP_MODEL_TEST			0x8000fffe
+#define OP_MODEL_INVALID		0x8000ffff
+
+#define USE_PUB_VALUE			0x00
+
+#define ACTION_ADD		1
+#define ACTION_UPDATE		2
+#define ACTION_DELETE		3
+
+struct mesh_model_pub {
+	uint32_t addr;
+	uint16_t idx;
+	uint8_t ttl;
+	uint8_t credential;
+	uint8_t period;
+	uint8_t retransmit;
+};
+
+typedef void (*mesh_model_unregister)(void *user_data);
+typedef bool (*mesh_model_recv_cb)(uint16_t src, uint32_t dst, uint16_t unicast,
+					uint16_t app_idx, const uint8_t *data,
+					uint16_t len, uint8_t ttl,
+					const void *user_data);
+typedef int (*mesh_model_bind_cb)(uint16_t app_idx, int action);
+typedef int (*mesh_model_pub_cb)(struct mesh_model_pub *pub);
+typedef int (*mesh_model_sub_cb)(uint16_t sub_addr, int action);
+
+struct mesh_model_ops {
+	mesh_model_unregister unregister;
+	mesh_model_recv_cb recv;
+	mesh_model_bind_cb bind;
+	mesh_model_pub_cb pub;
+	mesh_model_sub_cb sub;
+};
+
+struct mesh_model *mesh_model_new(uint8_t ele_idx, uint32_t id, bool vendor);
+void mesh_model_free(void *data);
+uint32_t mesh_model_get_model_id(const struct mesh_model *model);
+bool mesh_model_vendor_register(struct mesh_net *net, uint8_t ele_idx,
+					uint32_t mod_id,
+					const struct mesh_model_ops *cbs,
+					void *user_data);
+bool mesh_model_register(struct mesh_net *net, uint8_t ele_idx, uint32_t mod_id,
+					const struct mesh_model_ops *cbs,
+							void *user_data);
+struct mesh_model_pub *mesh_model_pub_get(struct mesh_net *net, uint8_t ele_idx,
+						uint32_t mod_id, int *status);
+int mesh_model_pub_set(struct mesh_net *net, uint16_t addr, uint32_t id,
+			const uint8_t *mod_addr, uint16_t idx, bool cred_flag,
+			uint8_t ttl, uint8_t period, uint8_t retransmit,
+			bool b_virt, uint16_t *dst);
+struct mesh_model *mesh_model_init(struct mesh_net *net, uint8_t ele_idx,
+						struct mesh_db_model *db_mod);
+
+int mesh_model_binding_add(struct mesh_net *net, uint16_t addr, uint32_t id,
+						uint16_t app_idx);
+int mesh_model_binding_del(struct mesh_net *net, uint16_t addr, uint32_t id,
+						uint16_t idx);
+int mesh_model_get_bindings(struct mesh_net *net, uint16_t addr, uint32_t id,
+				uint8_t *buf, uint16_t buf_len, uint16_t *size);
+int mesh_model_sub_add(struct mesh_net *net, uint16_t addr, uint32_t id,
+						const uint8_t *grp, bool b_virt,
+						uint16_t *dst);
+int mesh_model_sub_del(struct mesh_net *net, uint16_t addr, uint32_t id,
+						const uint8_t *grp, bool b_virt,
+						uint16_t *dst);
+int mesh_model_sub_del_all(struct mesh_net *net, uint16_t addr, uint32_t id);
+int mesh_model_sub_ovr(struct mesh_net *net, uint16_t addr, uint32_t id,
+						const uint8_t *grp, bool b_virt,
+						uint16_t *dst);
+int mesh_model_sub_get(struct mesh_net *net, uint16_t addr, uint32_t id,
+			uint8_t *buf, uint16_t buf_size, uint16_t *size);
+uint16_t mesh_model_cfg_blk(uint8_t *pkt);
+unsigned int mesh_model_send(struct mesh_net *net, uint32_t mod_id,
+				uint16_t src, uint32_t target,
+				uint16_t app_idx, uint8_t ttl,
+				const void *msg, uint16_t msg_len);
+
+bool mesh_model_rx(struct mesh_net *net, bool szmict, uint32_t seq0,
+			uint32_t seq, uint32_t iv_index, uint8_t ttl,
+			uint16_t src, uint16_t dst, uint8_t key_id,
+			const uint8_t *data, uint16_t size);
+
+void mesh_model_app_key_generate_new(struct mesh_net *net, uint16_t net_idx);
+void mesh_model_app_key_delete(struct mesh_net *net, struct l_queue *models,
+								uint16_t idx);
+struct l_queue *mesh_model_get_appkeys(struct mesh_net *net);
+void *mesh_model_get_local_node_data(struct mesh_net *net);
+void mesh_model_add_virtual(struct mesh_net *net, const uint8_t *v);
+void mesh_model_del_virtual(struct mesh_net *net, uint32_t va24);
+void mesh_model_list_virtual(struct mesh_net *net);
+uint16_t mesh_model_opcode_set(uint32_t opcode, uint8_t *buf);
+bool mesh_model_opcode_get(const uint8_t *buf, uint16_t size,
+					uint32_t *opcode, uint16_t *n);
diff --git a/meshd/src/node.h b/meshd/src/node.h
new file mode 100644
index 000000000..8ebb41941
--- /dev/null
+++ b/meshd/src/node.h
@@ -0,0 +1,80 @@
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
+#include "meshd/mesh-json/mesh-db.h"
+
+struct mesh_net;
+struct mesh_node;
+
+/* To prevent local node JSON cache thrashing, minimum update times */
+#define MIN_SEQ_TRIGGER	32
+#define MIN_SEQ_CACHE		(2*MIN_SEQ_TRIGGER)
+#define MIN_SEQ_CACHE_TIME	(5*60)
+
+struct mesh_node *node_new(void);
+void node_free(struct mesh_node *node);
+uint8_t *node_uuid_get(struct mesh_node *node);
+struct mesh_node *node_find_by_addr(uint16_t addr);
+struct mesh_node *node_find_by_uuid(uint8_t uuid[16]);
+bool node_is_provisioned(struct mesh_node *node);
+bool node_app_key_delete(struct mesh_net *net, uint16_t addr,
+				uint16_t net_idx, uint16_t idx);
+bool node_net_key_delete(struct mesh_node *node, uint16_t index);
+bool node_set_primary(struct mesh_node *node, uint16_t unicast);
+uint16_t node_get_primary(struct mesh_node *node);
+uint16_t node_get_primary_net_idx(struct mesh_node *node);
+bool node_set_device_key(struct mesh_node *node, uint8_t key[16]);
+const uint8_t *node_get_device_key(struct mesh_node *node);
+void node_set_num_elements(struct mesh_node *node, uint8_t num_ele);
+uint8_t node_get_num_elements(struct mesh_node *node);
+bool node_parse_composition(struct mesh_node *node, uint8_t *buf, uint16_t len);
+struct l_queue *node_get_net_keys(struct mesh_node *node);
+struct l_queue *node_get_app_keys(struct mesh_node *node);
+bool node_add_binding(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t app_idx);
+bool node_del_binding(struct mesh_node *node, uint8_t ele_idx,
+			uint32_t model_id, uint16_t app_idx);
+uint8_t node_default_ttl_get(struct mesh_node *node);
+bool node_default_ttl_set(struct mesh_node *node, uint8_t ttl);
+bool node_set_sequence_number(struct mesh_node *node, uint32_t seq);
+uint32_t node_get_sequence_number(struct mesh_node *node);
+int node_get_element_idx(struct mesh_node *node, uint16_t ele_addr);
+struct l_queue *node_get_element_models(struct mesh_node *node, uint8_t ele_idx,
+								int *status);
+struct mesh_model *node_get_model(struct mesh_node *node, uint8_t ele_idx,
+						uint32_t id, int *status);
+uint16_t node_get_crpl(struct mesh_node *node);
+struct mesh_node *node_create_from_storage(struct mesh_net *net,
+						struct mesh_db_node *db_node,
+								bool local);
+uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz);
+uint8_t node_lpn_mode_get(struct mesh_node *node);
+bool node_relay_mode_set(struct mesh_node *node, bool enable, uint8_t cnt,
+							uint16_t interval);
+uint8_t node_relay_mode_get(struct mesh_node *node, uint8_t *cnt,
+							uint16_t *interval);
+bool node_proxy_mode_set(struct mesh_node *node, bool enable);
+uint8_t node_proxy_mode_get(struct mesh_node *node);
+bool node_beacon_mode_set(struct mesh_node *node, bool enable);
+uint8_t node_beacon_mode_get(struct mesh_node *node);
+bool node_friend_mode_set(struct mesh_node *node, bool enable);
+uint8_t node_friend_mode_get(struct mesh_node *node);
+uint32_t node_seq_cache(struct mesh_node *node);
+void node_cleanup(struct mesh_net *net);
diff --git a/meshd/src/storage.h b/meshd/src/storage.h
new file mode 100644
index 000000000..341932dba
--- /dev/null
+++ b/meshd/src/storage.h
@@ -0,0 +1,51 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017-2918  Intel Corporation. All rights reserved.
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
+struct mesh_net;
+
+bool storage_parse_config(struct mesh_net *net, const char *config_name);
+bool storage_save_config(struct mesh_net *net, const char *config_name,
+			bool no_wait, mesh_status_func_t cb, void *user_data);
+bool storage_save_new_config(struct mesh_net *net, const char *config_name,
+					mesh_status_func_t cb, void *user_data);
+void storage_release(struct mesh_net *net);
+
+bool storage_model_bind(struct mesh_net *net, uint16_t addr, uint32_t id,
+						uint16_t app_idx, bool unbind);
+
+bool storage_local_set_ttl(struct mesh_net *net, uint8_t ttl);
+bool storage_local_set_relay(struct mesh_net *net, bool enable, uint8_t count,
+							uint8_t interval);
+bool storage_local_set_transmit_params(struct mesh_net *net, uint8_t count,
+							uint8_t interval);
+bool storage_local_set_mode(struct mesh_net *net, uint8_t mode,
+							const char *mode_name);
+bool storage_local_net_key_add(struct mesh_net *net, uint16_t net_idx,
+					const uint8_t key[16], int phase);
+bool storage_local_net_key_del(struct mesh_net *net, uint16_t net_idx);
+bool storage_local_app_key_add(struct mesh_net *net, uint16_t net_idx,
+			uint16_t app_idx, const uint8_t key[16], bool update);
+bool storage_local_app_key_del(struct mesh_net *net, uint16_t net_idx,
+							uint16_t app_idx);
+bool storage_local_write_sequence_number(struct mesh_net *net, uint32_t seq);
+bool storage_local_set_iv_index(struct mesh_net *net, uint32_t iv_index,
+								bool update);
+bool storage_local_set_device_key(struct mesh_net *net, uint8_t dev_key[16]);
+bool storage_local_set_unicast(struct mesh_net *net, uint16_t unicast);
-- 
2.14.3

