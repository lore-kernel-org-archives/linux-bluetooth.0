Return-Path: <brian.gix@intel.com>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	inga.stotland@intel.com,
	Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v5 07/14] mesh: Add Accessors to Transport layer data
Date: Fri,  6 Jul 2018 10:12:59 -0700
Message-Id: <20180706171306.13501-8-brian.gix@intel.com>
In-Reply-To: <20180706171306.13501-1-brian.gix@intel.com>
References: <20180706171306.13501-1-brian.gix@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/net.c | 549 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 549 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index 0dafa1780..544f9efa5 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -828,6 +828,226 @@ void mesh_net_unref(struct mesh_net *net)
 	l_free(net);
 }
 
+bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t number)
+{
+	if (!net)
+		return false;
+
+	net->cached_seq_num = net->seq_num = number;
+
+	return true;
+}
+
+bool mesh_net_set_default_ttl(struct mesh_net *net, uint8_t ttl)
+{
+	if (!net)
+		return false;
+
+	net->default_ttl = ttl;
+
+	return true;
+}
+
+uint32_t mesh_net_get_seq_num(struct mesh_net *net)
+{
+	if (!net)
+		return 0;
+
+	return net->seq_num;
+}
+
+uint8_t mesh_net_get_default_ttl(struct mesh_net *net)
+{
+	if (!net)
+		return 0;
+
+	return net->default_ttl;
+}
+
+uint16_t mesh_net_get_address(struct mesh_net *net)
+{
+	if (!net)
+		return 0;
+
+	return net->src_addr;
+}
+
+bool mesh_net_register_unicast(struct mesh_net *net,
+					uint16_t address, uint8_t num_ele)
+{
+	if (!net || !IS_UNICAST(address) || !num_ele)
+		return false;
+
+	l_info("mesh_net_set_address: 0x%x", address);
+	net->src_addr = address;
+	net->last_addr = address + num_ele - 1;
+	if (net->last_addr < net->src_addr)
+		return false;
+
+	do {
+		mesh_net_dst_reg(net, address);
+		address++;
+		num_ele--;
+	} while (num_ele > 0);
+
+	return true;
+}
+
+uint8_t mesh_net_get_num_ele(struct mesh_net *net)
+{
+	if (!net)
+		return 0;
+
+	return net->last_addr - net->src_addr + 1;
+}
+
+bool mesh_net_set_proxy_mode(struct mesh_net *net, bool enable)
+{
+	if (!net)
+		return false;
+
+	/* No support for proxy yet */
+	if (enable) {
+		l_error("Proxy not supported!");
+		return false;
+	}
+
+	trigger_heartbeat(net, FEATURE_PROXY, enable);
+	return true;
+}
+
+bool mesh_net_set_friend_mode(struct mesh_net *net, bool enable)
+{
+	if (!net)
+		return false;
+
+	if (net->friend_enable && !enable)
+		l_queue_clear(net->friends, mesh_friend_free);
+
+	net->friend_enable = enable;
+	trigger_heartbeat(net, FEATURE_FRIEND, enable);
+	return true;
+}
+
+bool mesh_net_set_relay_mode(struct mesh_net *net, bool enable,
+				uint8_t cnt, uint8_t interval)
+{
+	if (!net)
+		return false;
+
+	net->relay.enable = enable;
+	net->relay.count = cnt;
+	net->relay.interval = interval;
+	trigger_heartbeat(net, FEATURE_RELAY, enable);
+	return true;
+}
+
+struct mesh_net_prov_caps *mesh_net_prov_caps_get(struct mesh_net *net)
+{
+	if (net)
+		return &net->prov_caps;
+
+	return NULL;
+}
+
+char *mesh_net_id_name(struct mesh_net *net)
+{
+	if (net && net->id_name[0])
+		return net->id_name;
+
+	return NULL;
+}
+
+bool mesh_net_id_uuid_set(struct mesh_net *net, uint8_t uuid[16])
+{
+	if (!net)
+		return false;
+
+	memcpy(net->id_uuid, uuid, 16);
+
+	return true;
+}
+
+uint8_t *mesh_net_priv_key_get(struct mesh_net *net)
+{
+	if (net)
+		return net->prov_priv_key;
+
+	return NULL;
+}
+
+bool mesh_net_priv_key_set(struct mesh_net *net, uint8_t key[32])
+{
+	if (!net)
+		return false;
+
+	memcpy(net->prov_priv_key, key, 32);
+	return true;
+}
+
+uint8_t *mesh_net_test_addr(struct mesh_net *net)
+{
+	const uint8_t zero_addr[] = {0, 0, 0, 0, 0, 0};
+
+	if (net && memcmp(net->test_bd_addr, zero_addr, 6))
+		return net->test_bd_addr;
+
+	return NULL;
+}
+
+uint8_t *mesh_net_prov_rand(struct mesh_net *net)
+{
+	if (net)
+		return net->prov_rand;
+
+	return NULL;
+}
+
+uint16_t mesh_net_prov_uni(struct mesh_net *net, uint8_t ele_cnt)
+{
+	uint16_t uni;
+	uint16_t next;
+
+	if (!net)
+		return 0;
+
+	next = net->prov_uni_addr.next + ele_cnt;
+	if (next > 0x8000 || next > net->prov_uni_addr.high)
+		return UNASSIGNED_ADDRESS;
+
+	uni = net->prov_uni_addr.next;
+	net->prov_uni_addr.next = next;
+
+	return uni;
+}
+
+bool mesh_net_test_mode(struct mesh_net *net)
+{
+	if (net)
+		return net->test_mode;
+
+	return false;
+}
+
+int mesh_net_get_identity_mode(struct mesh_net *net, uint16_t idx,
+								uint8_t *mode)
+{
+	struct mesh_subnet *subnet;
+
+	if (!net)
+		return MESH_STATUS_UNSPECIFIED_ERROR;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+	if (!subnet)
+		return MESH_STATUS_INVALID_NETKEY;
+
+	/* Currently, proxy mode is not supported */
+	*mode = MESH_MODE_UNSUPPORTED;
+
+	return MESH_STATUS_SUCCESS;
+}
+
 int mesh_net_del_key(struct mesh_net *net, uint16_t idx)
 {
 	struct mesh_subnet *subnet;
@@ -924,6 +1144,98 @@ void mesh_net_flush_msg_queues(struct mesh_net *net)
 	l_queue_clear(net->fast_cache, mesh_msg_free);
 }
 
+uint32_t mesh_net_get_iv_index(struct mesh_net *net)
+{
+	if (!net)
+		return 0xffffffff;
+
+	return net->iv_index - (iv_is_updating(net) ? 1 : 0);
+}
+
+/* TODO: net key index? */
+void mesh_net_get_snb_state(struct mesh_net *net, uint8_t *flags,
+							uint32_t *iv_index)
+{
+	struct mesh_subnet *subnet;
+
+	if (!net || !flags || !iv_index)
+		return;
+
+	*iv_index = net->iv_index;
+	*flags = (net->iv_upd_state == IV_UPD_UPDATING) ? 0x02 : 0x00;
+
+	subnet = get_primary_subnet(net);
+	if (subnet)
+		*flags |= subnet->key_refresh ? 0x01 : 0x00;
+}
+
+bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
+							uint8_t key_buf[16])
+{
+	struct mesh_subnet *subnet;
+
+	if (!net)
+		return false;
+
+	subnet = l_queue_find(net->subnets, match_key_index,
+							L_UINT_TO_PTR(idx));
+	if (!subnet)
+		return false;
+
+	if (!new_key) {
+		memcpy(key_buf, subnet->current.key, 16);
+		return true;
+	}
+
+	if (subnet->updated.key_set.nid == NET_NID_INVALID)
+		return false;
+
+	memcpy(key_buf, subnet->updated.key, 16);
+	return true;
+}
+
+bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *size)
+{
+	const struct l_queue_entry *entry;
+	uint16_t n, buf_size;
+
+	if (!net || !buf || !size)
+		return false;
+
+	buf_size = *size;
+	if (buf_size < l_queue_length(net->subnets) * 2)
+		return false;
+
+	n = 0;
+	entry = l_queue_get_entries(net->subnets);
+
+	for (; entry; entry = entry->next) {
+		struct mesh_subnet *subnet = entry->data;
+
+		l_put_le16(subnet->idx, buf);
+		n += 2;
+	}
+
+	*size = n;
+	return true;
+}
+
+bool mesh_net_get_frnd_seq(struct mesh_net *net)
+{
+	if (!net)
+		return false;
+
+	return net->friend_seq;
+}
+
+void mesh_net_set_frnd_seq(struct mesh_net *net, bool seq)
+{
+	if (!net)
+		return;
+
+	net->friend_seq = seq;
+}
+
 static bool match_cache(const void *a, const void *b)
 {
 	const struct mesh_msg *msg = a;
@@ -2865,6 +3177,34 @@ void mesh_net_sub_list_del(struct mesh_net *net, uint16_t addr)
 			0, 0, 0, msg, n);
 }
 
+/* TODO: change to use net index */
+bool mesh_net_set_friend(struct mesh_net *net, uint16_t friend_addr)
+{
+	if (!net)
+		return false;
+
+	net->bea_id = 0;
+
+	l_info("Set Frnd addr: %4.4x", friend_addr);
+	if (!friend_addr)
+		trigger_heartbeat(net, FEATURE_LPN, false);
+	else
+		trigger_heartbeat(net, FEATURE_LPN, true);
+
+	net->friend_addr = friend_addr;
+
+	set_network_beacon(get_primary_subnet(net), net);
+	return true;
+}
+
+uint16_t mesh_net_get_friend(struct mesh_net *net)
+{
+	if (!net)
+		return 0;
+
+	return net->friend_addr;
+}
+
 bool mesh_net_dst_reg(struct mesh_net *net, uint16_t dst)
 {
 	struct mesh_destination *dest = l_queue_find(net->destinations,
@@ -3518,6 +3858,27 @@ int mesh_net_key_refresh_finish(struct mesh_net *net, uint16_t idx)
 	return MESH_STATUS_SUCCESS;
 }
 
+uint16_t mesh_net_get_features(struct mesh_net *net)
+{
+	uint16_t features = 0;
+
+	if (net->relay.enable)
+		features |= FEATURE_RELAY;
+	if (net->proxy_enable)
+		features |= FEATURE_PROXY;
+	if (!l_queue_isempty(net->friends))
+		features |= FEATURE_FRIEND;
+	if (net->friend_addr != UNASSIGNED_ADDRESS)
+		features |= FEATURE_LPN;
+
+	return features;
+}
+
+struct mesh_net_heartbeat *mesh_net_heartbeat_get(struct mesh_net *net)
+{
+	return &net->heartbeat;
+}
+
 void mesh_net_heartbeat_send(struct mesh_net *net)
 {
 	struct mesh_net_heartbeat *hb = &net->heartbeat;
@@ -3545,6 +3906,49 @@ void mesh_net_heartbeat_init(struct mesh_net *net)
 	hb->features = mesh_net_get_features(net);
 }
 
+void mesh_net_uni_range_set(struct mesh_net *net,
+				struct mesh_net_addr_range *range)
+{
+	net->prov_uni_addr.low = range->low;
+	net->prov_uni_addr.high = range->high;
+	net->prov_uni_addr.next = range->next;
+}
+
+struct mesh_net_addr_range mesh_net_uni_range_get(struct mesh_net *net)
+{
+	return net->prov_uni_addr;
+}
+
+void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update)
+{
+	net->iv_index = index;
+	net->iv_update = update;
+}
+
+void mesh_net_provisioner_mode_set(struct mesh_net *net, bool mode)
+{
+	net->provisioner = mode;
+}
+
+bool mesh_net_provisioner_mode_get(struct mesh_net *net)
+{
+	return net->provisioner;
+}
+
+uint16_t mesh_net_get_primary_idx(struct mesh_net *net)
+{
+	struct mesh_subnet *subnet;
+
+	if (!net)
+		return NET_IDX_INVALID;
+
+	subnet = get_primary_subnet(net);
+	if (!subnet)
+		return NET_IDX_INVALID;
+
+	return subnet->idx;
+}
+
 uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr)
 {
 	struct mesh_friend *frnd = l_queue_find(net->friends, match_by_friend,
@@ -3570,6 +3974,143 @@ bool mesh_net_local_node_set(struct mesh_net *net, struct mesh_node *node,
 	return true;
 }
 
+struct mesh_node *mesh_net_local_node_get(struct mesh_net *net)
+{
+	return  net->local_node;
+}
+
+bool mesh_net_set_crpl(struct mesh_net *net, uint16_t crpl)
+{
+	if (!net)
+		return false;
+
+	net->crpl = crpl;
+	return true;
+}
+
+uint16_t mesh_net_get_crpl(struct mesh_net *net)
+{
+	if (!net)
+		return 0;
+
+	return net->crpl;
+}
+
+struct l_queue *mesh_net_get_app_keys(struct mesh_net *net)
+{
+	if (!net)
+		return NULL;
+
+	if (!net->app_keys)
+		net->app_keys = l_queue_new();
+
+	return net->app_keys;
+}
+
+bool mesh_net_have_key(struct mesh_net *net, uint16_t idx)
+{
+	if (!net)
+		return false;
+
+	return (l_queue_find(net->subnets, match_key_index,
+						L_UINT_TO_PTR(idx)) != NULL);
+}
+
+bool mesh_net_jconfig_set(struct mesh_net *net, void *jconfig)
+{
+	if (!net)
+		return false;
+
+	net->jconfig_local = jconfig;
+	return true;
+}
+
+void *mesh_net_jconfig_get(struct mesh_net *net)
+{
+	if (!net)
+		return NULL;
+
+	return  net->jconfig_local;
+}
+
+bool mesh_net_cfg_file_set(struct mesh_net *net, const char *cfg)
+{
+	if (!net)
+		return false;
+
+	net->cfg_file = cfg;
+	return true;
+}
+
+bool mesh_net_cfg_file_get(struct mesh_net *net, const char **cfg)
+{
+	if (!net)
+		return false;
+
+	*cfg = net->cfg_file;
+	return true;
+}
+
+bool mesh_net_is_local_address(struct mesh_net *net, uint16_t addr)
+{
+	if (!net)
+		return false;
+
+	return (addr >= net->src_addr && addr <= net->last_addr);
+}
+
+void mesh_net_set_window_accuracy(struct mesh_net *net, uint8_t accuracy)
+{
+	if (!net)
+		return;
+
+	net->window_accuracy = accuracy;
+}
+
+void mesh_net_transmit_params_set(struct mesh_net *net, uint8_t count,
+							uint16_t interval)
+{
+	if (!net)
+		return;
+
+	net->tx_interval = interval;
+	net->tx_cnt = count;
+}
+
+void mesh_net_transmit_params_get(struct mesh_net *net, uint8_t *count,
+							uint16_t *interval)
+{
+	if (!net)
+		return;
+
+	*interval = net->tx_interval;
+	*count = net->tx_cnt;
+}
+
+struct mesh_io *mesh_net_get_io(struct mesh_net *net)
+{
+	if (!net)
+		return NULL;
+
+	return net->io;
+}
+
+struct mesh_prov *mesh_net_get_prov(struct mesh_net *net)
+{
+	if (!net)
+		return NULL;
+
+	return net->prov;
+}
+
+void mesh_net_set_prov(struct mesh_net *net, struct mesh_prov *prov)
+{
+	if (!net)
+		return;
+
+	net->prov = prov;
+}
+
 bool mesh_net_provisioned_new(struct mesh_net *net, uint8_t device_key[16],
 				uint16_t net_idx,  uint8_t net_key[16],
 				uint16_t unicast, uint16_t snb_flags,
@@ -3637,3 +4178,11 @@ void mesh_net_provisioned_set(struct mesh_net *net, bool provisioned)
 					acceptor_prov_receive, net);
 	}
 }
+
+bool mesh_net_provisioned_get(struct mesh_net *net)
+{
+	if (!net)
+		return false;
+
+	return net->provisioned;
+}
-- 
2.14.4
