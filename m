Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171211145839.19573-3-sbrown@cortland.com>
References: <20171211145839.19573-1-sbrown@cortland.com> <20171211145839.19573-3-sbrown@cortland.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 Dec 2017 13:12:42 -0200
Message-ID: <CABBYNZJB-j5+LF5TY+j=MJEc9YMPvSXyEh4spUSd7O_-eQ4ikA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mesh: meshctl: Add commands
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Mon, Dec 11, 2017 at 12:58 PM,  <sbrown@cortland.com> wrote:
> From: Steve Brown <sbrown@cortland.com>
>
> Get/Set Proxy
> Get/Set Ident
> Get/Set Relay
> Set Heartbeat
> Get Publication
> Get/Set Subscription

Ive split these into individual patches for command and then add in
the description what the expected output, etc. Btw I think it would be
better to switch from get-set style to cmd [value], so if there is no
arguments then it just read the value, that way reduce the amount of
commands and also make the autocomplete a lot more useful since the
commands shall start with something other than set/get.

>   The json database is not updated (WIP)
> Get App
> ---
>  mesh/config-client.c | 446 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  mesh/net.c           |  20 ++-
>  2 files changed, 444 insertions(+), 22 deletions(-)
>
> diff --git a/mesh/config-client.c b/mesh/config-client.c
> index 3d618b6a6..35ccbff45 100644
> --- a/mesh/config-client.c
> +++ b/mesh/config-client.c
> @@ -61,6 +61,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
>         uint8_t ele_idx;
>         struct mesh_publication pub;
>         int n;
> +       uint16_t i;
>
>         if (mesh_opcode_get(data, len, &opcode, &n)) {
>                 len -= n;
> @@ -158,6 +159,29 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
>                         prov_db_add_binding(node, addr - src, mod_id, app_idx);
>                 break;
>
> +       case OP_NODE_IDENTITY_STATUS:
> +               if (len != 4)
> +                       return true;
> +               bt_shell_printf("Network index 0x%04x has "
> +                               "Node Identity state 0x%02x %s\n",
> +                               get_le16(data + 1), data[3],
> +                               mesh_status_str(data[0]));
> +
> +       case OP_CONFIG_RELAY_STATUS:
> +               if (len != 2)
> +                       return true;
> +               bt_shell_printf("Node %4.4x Relay state: 0x%02x"
> +                               " count: %d steps: %d\n",
> +                               src, data[0], data[1]>>5, data[1] & 0x1f);
> +               break;
> +
> +       case OP_CONFIG_PROXY_STATUS:
> +               if (len != 1)
> +                       return true;
> +               bt_shell_printf("Node %4.4x Proxy state: 0x%02x\n",
> +                               src, data[0]);
> +               break;
> +
>         case OP_CONFIG_DEFAULT_TTL_STATUS:
>                 if (len != 1)
>                         return true;
> @@ -170,9 +194,9 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
>                 if (len != 12 && len != 14)
>                         return true;
>
> -               bt_shell_printf("\nSet publication for node %4.4x status: %s\n", src,
> -                               data[0] == MESH_STATUS_SUCCESS ? "Success" :
> -                                               mesh_status_str(data[0]));
> +               bt_shell_printf("\nSet publication for node %4.4x status: %s\n",
> +                               src, data[0] == MESH_STATUS_SUCCESS ?
> +                               "Success" : mesh_status_str(data[0]));
>
>                 if (data[0] != MESH_STATUS_SUCCESS)
>                         return true;
> @@ -189,6 +213,7 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
>                 pub.ttl = data[7];
>                 pub.period = data[8];
>                 n = (data[8] & 0x3f);
> +               bt_shell_printf("Publication address: 0x%04x\n", pub.u.addr16);
>                 switch (data[8] >> 6) {
>                 case 0:
>                         bt_shell_printf("Period: %d ms\n", n * 100);
> @@ -206,7 +231,8 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
>
>                 pub.retransmit = data[9];
>                 bt_shell_printf("Retransmit count: %d\n", data[9] >> 5);
> -               bt_shell_printf("Retransmit Interval Steps: %d\n", data[9] & 0x1f);
> +               bt_shell_printf("Retransmit Interval Steps: %d\n",
> +                               data[9] & 0x1f);
>
>                 ele_idx = ele_addr - node_get_primary(node);
>
> @@ -218,7 +244,81 @@ static bool client_msg_recvd(uint16_t src, uint8_t *data,
>                         prov_db_node_set_model_pub(node, ele_idx, mod_id,
>                                      node_model_pub_get(node, ele_idx, mod_id));
>                 break;
> +
> +       /* Per Mesh Profile 4.3.2.19 */
> +       case OP_CONFIG_MODEL_SUB_STATUS:
> +               bt_shell_printf("\nSubscription changed"
> +                               " for node %4.4x status: %s\n", src,
> +                               data[0] == MESH_STATUS_SUCCESS ? "Success" :
> +                                               mesh_status_str(data[0]));
> +
> +               if (data[0] != MESH_STATUS_SUCCESS)
> +                       return true;
> +
> +               bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
> +               bt_shell_printf("Subscr Addr:\t%4.4x\n", get_le16(data + 3));
> +               bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 5));
> +               break;
> +
> +               /* TODO */
> +               /* Save subscription info in database */
> +
> +       /* Per Mesh Profile 4.3.2.27 */
> +       case OP_CONFIG_MODEL_SUB_LIST:
> +
> +               bt_shell_printf("\nSubscription list for node %4.4x "
> +                               "length: %u status: %s\n", src, len,
> +                               data[0] == MESH_STATUS_SUCCESS ? "Success" :
> +                                               mesh_status_str(data[0]));
> +
> +               if (data[0] != MESH_STATUS_SUCCESS)
> +                       return true;
> +
> +               bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
> +               bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 3));
> +
> +               for (i = 5; i < len; i += 2)
> +                       bt_shell_printf("Subscr Addr:\t%4.4x\n",
> +                                       get_le16(data + i));
> +               break;
> +
> +       /* Per Mesh Profile 4.3.2.50 */
> +       case OP_MODEL_APP_LIST:
> +               bt_shell_printf("\nModel App Key list for node %4.4x "
> +                               "length: %u status: %s\n", src, len,
> +                               data[0] == MESH_STATUS_SUCCESS ? "Success" :
> +                                               mesh_status_str(data[0]));
> +
> +               if (data[0] != MESH_STATUS_SUCCESS)
> +                       return true;
> +
> +               bt_shell_printf("Element Addr:\t%4.4x\n", get_le16(data + 1));
> +               bt_shell_printf("Model ID:\t%4.4x\n", get_le16(data + 3));
> +
> +               for (i = 5; i < len; i += 2)
> +                       bt_shell_printf("Model App Key:\t%4.4x\n",
> +                                       get_le16(data + i));
> +               break;
> +
> +       /* Per Mesh Profile 4.3.2.63 */
> +       case OP_CONFIG_HEARTBEAT_PUB_STATUS:
> +               bt_shell_printf("\nSet heartbeat for node %4.4x status: %s\n",
> +                               src,
> +                               data[0] == MESH_STATUS_SUCCESS ? "Success" :
> +                                               mesh_status_str(data[0]));
> +
> +               if (data[0] != MESH_STATUS_SUCCESS)
> +                       return true;
> +
> +               bt_shell_printf("Destination:\t%4.4x\n", get_le16(data + 1));
> +               bt_shell_printf("Count:\t\t%2.2x\n", data[3]);
> +               bt_shell_printf("Period:\t\t%2.2x\n", data[4]);
> +               bt_shell_printf("TTL:\t\t%2.2x\n", data[5]);
> +               bt_shell_printf("Features:\t%4.4x\n", get_le16(data + 6));
> +               bt_shell_printf("Net_Idx:\t%4.4x\n", get_le16(data + 8));
> +               break;
>         }
> +
>         return true;
>  }
>
> @@ -287,6 +387,23 @@ static bool config_send(uint8_t *buf, uint16_t len)
>
>  }
>
> +static void cmd_default(uint32_t opcode)
> +{
> +       uint16_t n;
> +       uint8_t msg[32];
> +
> +       if (IS_UNASSIGNED(target)) {
> +               bt_shell_printf("Destination not set\n");
> +               return;
> +       }
> +
> +       n = mesh_opcode_set(opcode, msg);
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send command (opcode 0x%x)\n",
> +                                                               opcode);
> +}
> +
>  static void cmd_get_composition(int argc, char *argv[])
>  {
>         uint16_t n;
> @@ -518,6 +635,113 @@ static void cmd_bind(int argc, char *argv[])
>                 bt_shell_printf("Failed to send \"MODEL APP BIND\"\n");
>  }
>
> +static void cmd_set_ident(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[2 + 3 + 4];
> +       int parm_cnt;
> +
> +       if (!verify_config_target(target))
> +               return;
> +
> +       n = mesh_opcode_set(OP_NODE_IDENTITY_SET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 2) {
> +               bt_shell_printf("bad arguments\n");
> +               return;
> +       }
> +
> +       put_le16(parms[0], msg + n);
> +       n += 2;
> +       msg[n++] = parms[1];
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"SET IDENTITY\"\n");
> +}
> +
> +static void cmd_get_ident(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[2 + 2 + 4];
> +       int parm_cnt;
> +
> +       if (!verify_config_target(target))
> +               return;
> +
> +       n = mesh_opcode_set(OP_NODE_IDENTITY_GET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 1) {
> +               bt_shell_printf("bad arguments\n");
> +               return;
> +       }
> +
> +       put_le16(parms[0], msg + n);
> +       n += 2;
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"GET IDENTITY\"\n");
> +}
> +
> +static void cmd_set_proxy(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[2 + 1 + 4];
> +       int parm_cnt;
> +
> +       if (!verify_config_target(target))
> +               return;
> +
> +       n = mesh_opcode_set(OP_CONFIG_PROXY_SET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 1) {
> +               bt_shell_printf("bad arguments");
> +               return;
> +       }
> +
> +       msg[n++] = parms[0];
> +       msg[n++] = parms[1];
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"SET PROXY\"\n");
> +}
> +
> +static void cmd_get_proxy(int argc, char *argv[])
> +{
> +       cmd_default(OP_CONFIG_PROXY_GET);
> +}
> +
> +static void cmd_set_relay(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[2 + 2 + 4];
> +       int parm_cnt;
> +
> +       if (!verify_config_target(target))
> +               return;
> +
> +       n = mesh_opcode_set(OP_CONFIG_RELAY_SET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 3) {
> +               bt_shell_printf("bad arguments\n");
> +               return;
> +       }
> +
> +       msg[n++] = parms[0];
> +       msg[n++] = (parms[1] << 5) | parms[2];
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"SET RELAY\"\n");
> +}
> +
> +static void cmd_get_relay(int argc, char *argv[])
> +{
> +       cmd_default(OP_CONFIG_RELAY_GET);
> +}
> +
>  static void cmd_set_ttl(int argc, char *argv[])
>  {
>         uint16_t n;
> @@ -556,7 +780,7 @@ static void cmd_set_pub(int argc, char *argv[])
>         n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_SET, msg);
>
>         parm_cnt = read_input_parameters(argc, argv);
> -       if (parm_cnt != 5) {
> +       if (parm_cnt != 6) {
>                 bt_shell_printf("Bad arguments\n");
>                 return;
>         }
> @@ -574,14 +798,14 @@ static void cmd_set_pub(int argc, char *argv[])
>         /* Publish period  step count and step resolution */
>         msg[n++] = parms[3];
>         /* Publish retransmit count & interval steps */
> -       msg[n++] = (1 << 5) + 2;
> +       msg[n++] = parms[4];
>         /* Model Id */
> -       if (parms[4] > 0xffff) {
> -               put_le16(parms[4] >> 16, msg + n);
> -               put_le16(parms[4], msg + n + 2);
> +       if (parms[5] > 0xffff) {
> +               put_le16(parms[5] >> 16, msg + n);
> +               put_le16(parms[5], msg + n + 2);
>                 n += 4;
>         } else {
> -               put_le16(parms[4], msg + n);
> +               put_le16(parms[5], msg + n);
>                 n += 2;
>         }
>
> @@ -589,21 +813,176 @@ static void cmd_set_pub(int argc, char *argv[])
>                 bt_shell_printf("Failed to send \"SET MODEL PUBLICATION\"\n");
>  }
>
> -static void cmd_default(uint32_t opcode)
> +static void cmd_get_pub(int argc, char *argv[])
>  {
>         uint16_t n;
>         uint8_t msg[32];
> +       int parm_cnt;
>
>         if (IS_UNASSIGNED(target)) {
>                 bt_shell_printf("Destination not set\n");
>                 return;
>         }
>
> -       n = mesh_opcode_set(opcode, msg);
> +       n = mesh_opcode_set(OP_CONFIG_MODEL_PUB_GET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 2) {
> +               bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +               return;
> +       }
> +
> +       /* Element Address */
> +       put_le16(parms[0], msg + n);
> +       n += 2;
> +       /* Model Id */
> +       if (parms[1] > 0xffff) {
> +               put_le16(parms[1] >> 16, msg + n);
> +               put_le16(parms[1], msg + n + 2);
> +               n += 4;
> +       } else {
> +               put_le16(parms[1], msg + n);
> +               n += 2;
> +       }
>
>         if (!config_send(msg, n))
> -               bt_shell_printf("Failed to send command (opcode 0x%x)\n",
> -                                                               opcode);
> +               bt_shell_printf("Failed to send \"GET MODEL PUBLICATION\"\n");
> +}
> +
> +static void cmd_sub_add(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[32];
> +       int parm_cnt;
> +
> +       if (IS_UNASSIGNED(target)) {
> +               bt_shell_printf("Destination not set\n");
> +               return;
> +       }
> +
> +       n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_ADD, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 3) {
> +               bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +               return;
> +       }
> +
> +       /* Per Mesh Profile 4.3.2.19 */
> +       /* Element Address */
> +       put_le16(parms[0], msg + n);
> +       n += 2;
> +       /* Subscription Address */
> +       put_le16(parms[1], msg + n);
> +       n += 2;
> +       /* SIG Model ID */
> +       put_le16(parms[2], msg + n);
> +       n += 2;
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"ADD SUBSCRIPTION\"\n");
> +}
> +
> +static void cmd_sub_get(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[32];
> +       int parm_cnt;
> +
> +       if (IS_UNASSIGNED(target)) {
> +               bt_shell_printf("Destination not set\n");
> +               return;
> +       }
> +
> +       n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_GET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 2) {
> +               bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +               return;
> +       }
> +
> +       /* Per Mesh Profile 4.3.2.27 */
> +       /* Element Address */
> +       put_le16(parms[0], msg + n);
> +       n += 2;
> +       /* Model ID */
> +       put_le16(parms[1], msg + n);
> +       n += 2;
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"GET SUB GET\"\n");
> +}
> +
> +static void cmd_get_app(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[32];
> +       int parm_cnt;
> +
> +       if (IS_UNASSIGNED(target)) {
> +               bt_shell_printf("Destination not set\n");
> +               return;
> +       }
> +
> +       n = mesh_opcode_set(OP_MODEL_APP_GET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 2) {
> +               bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +               return;
> +       }
> +
> +       /* Per Mesh Profile 4.3.2.49 */
> +       /* Element Address */
> +       put_le16(parms[0], msg + n);
> +       n += 2;
> +       /* Model ID */
> +       put_le16(parms[1], msg + n);
> +       n += 2;
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"GET APP GET\"\n");
> +}
> +
> +static void cmd_set_hb(int argc, char *argv[])
> +{
> +       uint16_t n;
> +       uint8_t msg[32];
> +       int parm_cnt;
> +
> +       if (IS_UNASSIGNED(target)) {
> +               bt_shell_printf("Destination not set\n");
> +               return;
> +       }
> +
> +       n = mesh_opcode_set(OP_CONFIG_HEARTBEAT_PUB_SET, msg);
> +
> +       parm_cnt = read_input_parameters(argc, argv);
> +       if (parm_cnt != 5) {
> +               bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +               return;
> +       }
> +
> +       /* Per Mesh Profile 4.3.2.62 */
> +       /* Publish address */
> +       put_le16(parms[0], msg + n);
> +       n += 2;
> +       /* Count Log */
> +       msg[n++] = parms[1];
> +       /* Period Log */
> +       msg[n++] = parms[2];
> +       /* Heartbeat TTL */
> +       msg[n++] = DEFAULT_TTL;
> +       /* Features */
> +       put_le16(parms[3], msg + n);
> +       n += 2;
> +       /* NetKey Index */
> +       put_le16(parms[4], msg + n);
> +       n += 2;
> +
> +       if (!config_send(msg, n))
> +               bt_shell_printf("Failed to send \"SET HEARTBEAT PUBLICATION\"\n");
>  }
>
>  static void cmd_get_ttl(int argc, char *argv[])
> @@ -614,27 +993,52 @@ static void cmd_get_ttl(int argc, char *argv[])
>  static const struct bt_shell_menu cfg_menu = {
>         .name = "config",
>         .entries = {
> -       {"target",              "<unicast>",                    cmd_set_node,
> +       {"target",              "<unicast>",            cmd_set_node,
>                                                 "Set target node to configure"},
>         {"get-composition",     "[<page_num>]",         cmd_get_composition,
>                                                 "Get Composition Data"},
> -       {"add-netkey",          "<net_idx>",                    cmd_add_net_key,
> +       {"add-netkey",          "<net_idx>",            cmd_add_net_key,
>                                                 "Add network key"},
> -       {"del-netkey",          "<net_idx>",                    cmd_del_net_key,
> +       {"del-netkey",          "<net_idx>",            cmd_del_net_key,
>                                                 "Delete network key"},
> -       {"add-appkey",          "<app_idx>",                    cmd_add_app_key,
> +       {"add-appkey",          "<app_idx>",            cmd_add_app_key,
>                                                 "Add application key"},
> -       {"del-appkey",          "<app_idx>",                    cmd_del_app_key,
> +       {"del-appkey",          "<app_idx>",            cmd_del_app_key,
>                                                 "Delete application key"},
>         {"bind",                "<ele_idx> <app_idx> <mod_id> [cid]",
>                                 cmd_bind,       "Bind app key to a model"},
> -       {"set-ttl",             "<ttl>",                        cmd_set_ttl,
> +       {"set-ttl",             "<ttl>",                cmd_set_ttl,
>                                                 "Set default TTL"},
> +       {"set-proxy",           "<proxy>",              cmd_set_proxy,
> +                                               "Set proxy state"},
> +       {"get-proxy",           NULL,                   cmd_get_proxy,
> +                                               "Get proxy state"},
> +       {"set-ident",           "<net_idx> <state>",    cmd_set_ident,
> +                                               "Set node identity state"},
> +       {"get-ident",           "<net_idx>",            cmd_get_ident,
> +                                               "Get node identity state"},
> +       {"set-relay",           "<relay> <rexmt count> <rexmt steps>",
> +                                                       cmd_set_relay,
> +                                               "Set relay"},
> +       {"get-relay",           NULL,                   cmd_get_relay,
> +                                               "Get relay"},
>         {"get-ttl",             NULL,                   cmd_get_ttl,
>                                                 "Get default TTL"},
>         {"set-pub", "<ele_addr> <pub_addr> <app_idx> "
> -                                               "<period (step|res)> <model>",
> +                       "<period (step|res)> <re-xmt (count|per)> <model>",
>                                 cmd_set_pub,    "Set publication"},
> +       {"get-pub", "<ele_addr> <model>",               cmd_get_pub,
> +                                               "Get publication"},
> +       {"set-hb", "<pub_addr> <count> <period> <features> <net_idx>",
> +                               cmd_set_hb,     "Set heartbeat"},
> +       {"add-sub", "<ele_addr> <sub_addr> <model id>",
> +                               cmd_sub_add,    "Subscription add"},
> +       {"get-sub", "<ele_addr> <model id>",
> +                               cmd_sub_get,    "Subscription get"},
> +
> +       {"get-app", "<ele_addr> <model id>",
> +                               cmd_get_app,    "Get App Keys"},
> +
>         {} },
>  };
>
> diff --git a/mesh/net.c b/mesh/net.c
> index 421dc6955..20dfcb8a8 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -1399,6 +1399,24 @@ static bool ctl_rxed(uint16_t net_idx, uint32_t iv_index,
>                 uint8_t *trans, uint16_t len)
>  {
>         /* TODO: Handle control messages */
> +
> +       /* Per Mesh Profile 3.6.5.10 */
> +       if (trans[0] == NET_OP_HEARTBEAT) {
> +               uint16_t feat = get_be16(trans + 2);
> +
> +               bt_shell_printf("HEARTBEAT src: %4.4x dst: %4.4x \
> +                               TTL: %2.2x feat: %s%s%s%s\n",
> +                               src, dst, trans[1],
> +                               (feat & MESH_FEATURE_RELAY) ? "relay " : "",
> +                               (feat & MESH_FEATURE_PROXY) ? "proxy " : "",
> +                               (feat & MESH_FEATURE_FRIEND) ? "friend " : "",
> +                               (feat & MESH_FEATURE_LPN) ? "lpn" : "");
> +               return true;
> +       }
> +
> +       bt_shell_printf("unrecognized control message src:%4.4x dst:%4.4x len:%d\n",
> +                       src, dst, len);
> +       print_byte_array("msg: ", trans, len);
>         return false;
>  }
>
> @@ -2098,7 +2116,7 @@ bool net_access_layer_send(uint8_t ttl, uint16_t src, uint32_t dst,
>         if (!result)
>                 return false;
>
> -       segN = SEG_MAX(len + sizeof(uint32_t));
> +       segN = SEG_MAX(len + sizeof(mic32));
>
>         /* Only one ACK required SAR message per destination at a time */
>         if (segN && IS_UNICAST(dst)) {
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
