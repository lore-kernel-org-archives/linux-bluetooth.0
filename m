Return-Path: <cyrus@holtmann.org>
From: Dan Tian <Dan.Tian@Atheros.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Date: Thu, 15 Jul 2010 15:39:17 +0800
Subject: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux BT3
 team.
Message-ID: <CDAFEDABF718A54BABD0DA5476695307CE881EC3@SHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From d94973250b15e03cae3299f6828f46d29e19bf33 Mon Sep 17 00:00:00 2001
From: Haijun.Liu <Haijun.Liu@Atheros.com>
Date: Wed, 14 Jul 2010 22:51:05 +0800
Subject: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux BT3 team.


Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>
---
 include/net/bluetooth/ampmgr.h |  309 ++++++
 net/bluetooth/ampmgr.c         | 2217 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 2526 insertions(+), 0 deletions(-)
 create mode 100755 include/net/bluetooth/ampmgr.h
 create mode 100755 net/bluetooth/ampmgr.c

diff --git a/include/net/bluetooth/ampmgr.h b/include/net/bluetooth/ampmgr.h
new file mode 100755
index 0000000..6fe752a
--- /dev/null
+++ b/include/net/bluetooth/ampmgr.h
@@ -0,0 +1,309 @@
+#ifndef _AMPMGR_H
+#define _AMPMGR_H
+
+#define AMP_COMMAND_REJ                0x01
+#define AMP_DISCOVER_REQ       0x02
+#define AMP_DISCOVER_RSP       0x03
+#define AMP_CHANGE_NOTIFY      0x04
+#define AMP_CHANGE_RSP         0x05
+#define AMP_INFO_REQ           0x06
+#define AMP_INFO_RSP           0x07
+#define AMP_ASSOC_REQ          0x08
+#define AMP_ASSOC_RSP          0x09
+#define AMP_CREATE_PHY_LINK_REQ        0x0A
+#define AMP_CREATE_PHY_LINK_RSP        0x0B
+#define AMP_DISC_PHY_LINK_REQ  0x0C
+#define AMP_DISC_PHY_LINK_RSP  0x0D
+
+
+struct a2mp_cmd_hdr {
+       __u8       code;
+       __u8       ident;
+       __le16     len;
+} __attribute__ ((packed));
+
+#define AMP_CMD_HDR_LENGTH     0x04
+
+
+struct a2mp_cmd_rej {
+       __le16  reason;
+} __attribute__ ((packed));
+
+#define AMP_DEFAULT_MTU                670
+#define AMP_DEFAULT_EXT_FEAT_MASK 0
+
+struct a2mp_discover_req {
+       __le16  mtu;
+       __le16  ext_feature_mask;
+} __attribute__ ((packed));
+
+struct a2mp_discover_rsp {
+       __le16  mtu;
+       __le16  ext_feature_mask;
+       __u8    data[0];
+} __attribute__ ((packed));
+
+struct a2mp_change_notify {
+       __u8    data[0];
+} __attribute__ ((packed));
+
+struct a2mp_info_req {
+       __u8    ctrl_id;
+} __attribute__ ((packed));
+
+struct a2mp_info_rsp {
+       __u8    ctrl_id;
+       __u8    status;
+       __le32  total_bandwidth;
+       __le32  max_bandwidth;
+       __le32  min_latency;
+       __le16  pal_capability;
+       __le16  amp_assoc_size;
+} __attribute__ ((packed));
+
+struct a2mp_assoc_req {
+       __u8    ctrl_id;
+} __attribute__ ((packed));
+
+struct a2mp_assoc_rsp {
+       __u8    ctrl_id;
+       __u8    status;
+       __u8    assoc[0];
+} __attribute__ ((packed));
+
+struct a2mp_phy_link_req{
+       __u8    local_ctrl_id;
+       __u8    remote_ctrl_id;
+       __u8    assoc[0];
+} __attribute__ ((packed));
+
+struct a2mp_phy_link_rsp{
+       __u8    local_ctrl_id;
+       __u8    remote_ctrl_id;
+       __u8    status;
+} __attribute__ ((packed));
+
+struct a2mp_disc_phy_link_req{
+       __u8    local_ctrl_id;
+       __u8    remote_ctrl_id;
+} __attribute__ ((packed));
+
+struct a2mp_disc_phy_link_rsp{
+       __u8    local_ctrl_id;
+       __u8    remote_ctrl_id;
+       __u8    status;
+} __attribute__ ((packed));
+
+
+#define AMP_STATUS_OK                          0x00
+#define AMP_STATUS_INVALID_CONTROLLER_ID       0x01
+#define AMP_STATUS_UNABLE_TO_CREATE_LINK       0x02
+#define AMP_STATUS_COLLISION_OCCURRED          0x03
+#define AMP_STATUS_DISC_PACKET_RECV            0x04
+#define AMP_STATUS_PHYSICAL_LINK_EXIST         0x05
+#define AMP_STATUS_INSUFFICIENT_SECURITY       0x06
+
+/* failure for Disconnect/Cancel Physical Link */
+#define AMP_STATUS_NO_PHYSICAL_LINK            0x02
+
+/* l2cap notify amp cmd define */
+#define AMP_HS_REQUEST 0x01
+#define AMP_HS_CANCEL  0x02
+#define AMP_HS_DISC    0x03
+
+/*amp controller available status */
+#define AMP_CONTR_UNKNOWN      0x00
+#define AMP_CONTR_AVAIL                0x01
+#define AMP_CONTR_UNAVAIL      0x02
+
+/*amp controller caps status*/
+#define        AMP_CONTR_POWERED_DOWN          0x00
+#define AMP_CONTR_ONLY_WORKS_WITH_BT   0x01
+#define        AMP_CONTR_NO_CAPACITY           0x02
+#define AMP_CONTR_LOW_CAPACITY         0x03
+#define AMP_CONTR_MEDIUM_CAPACITY      0x04
+#define        AMP_CONTR_HIGH_CAPACITY         0x05
+#define AMP_CONTR_FULL_CAPACITY                0x06
+#define AMP_CONTR_CAP_UNINITIALIZE     0x07
+
+#define DISCOVERY_REQ_SENT     0x01
+#define DISCOVERY_RSP_RECV     0x02
+#define DISCOVERY_REQ_RECV     0x04
+#define DISOCVERY_RSP_SENT     0x08
+#define CHANGE_NOTIFY_SENT     0x10
+#define CHANGE_NOTIFY_RECV     0x20
+
+#define PHY_LINK_IDLE                  0x00
+#define PHY_LINK_INFO_REQ_SENT         0x01
+#define PHY_LINK_ASSOC_REQ_SENT                0x02
+#define PHY_LINK_CREATE_REQ_SENT       0x03
+#define PHY_LINK_CREATE_REQ_RECV       0x04
+#define PHY_LINK_CREATE_RSP_SENT       0x05
+#define PHY_LINK_CREATE_RSP_RECV       0x06
+#define PHY_LINK_HCI_CREATE_SENT       0x07
+#define PHY_LINK_HCI_ACCEPT_SENT       0x08
+#define PHY_LINK_CONNECTED             0x09
+#define PHY_LINK_DISC_REQ_SENT         0x0A
+#define PHY_LINK_DISC_REQ_RECV         0x0B
+#define PHY_LINK_DISC_RSP_SENT         0x0C
+#define PHY_LINK_DISC_RSP_RECV         0x0D
+#define PHY_LINK_HCI_DISC_SENT         0x0E
+
+#define PHY_LINK_MAC_READY             0x01
+
+#define AMP_ROLE_CREATOR       0x01
+#define AMP_ROLE_RESPONDER     0x02
+
+#define PENDING_LOCAL_COMMAND  0x01
+#define PENDING_REMOTE_SIGNAL  0x02
+
+#define REGENERATE_GAMP_LK     0x01
+#define        GAMP_LK_VALID           0x02
+
+#define AMP_DISCOV_TIMEOUT     (20000) /* 20 seconds */
+#define AMP_RESPONSE_TIMEOUT   (20000) /* 20 seconds */
+#define AMP_PHY_LINK_TIMEOUT   (80000) /* 80 seconds */
+
+#define GAMP_KEY_ID            0
+#define PAL_KEY_ID             1
+#define ECMA_KEY_ID            2
+
+#define MAX_PAL_TYPE           3
+
+/* amp link key calc in kernel */
+#define GAMP_KEY_LENGTH                32
+#define SHA256_DIGEST_LEN      32
+
+struct controller_info {
+       __u8    id;
+       __u8    type;
+       __u8    status;
+       __u32   total_bandwidth;
+       __u32   max_bandwidth;
+       __u32   min_latency;
+       __u16   pal_capability;
+       __u16   amp_assoc_size;
+};
+
+struct controller_array {
+       __u32                   size;
+       struct  controller_info contr[0];
+};
+
+struct amp_phy_link {
+       struct hci_phy_link     *hci_link;
+       /*list in a2mp_conn*/
+       struct list_head        per_conn_list;
+       /*list in controller*/
+       struct list_head        per_contr_list;
+       struct a2mp_conn        *a2mp_conn;
+       struct amp_controller   *local;
+       atomic_t                refcnt;
+       __u8                    local_ctrl_id;
+       __u8                    remote_ctrl_id;
+       __u8                    handle;
+       /*identify to track phy_link when receive rsp signal*/
+       __u8                    identify;
+       /*phylink state*/
+       __u8                    state;
+       struct timer_list       a2mp_timer;
+       struct timer_list       timer;
+       __u8                    flag;
+};
+
+struct amp_phy_link_list {
+       struct list_head        head;
+       rwlock_t                lock;
+       __u8                    num;
+};
+
+struct amp_link_key_wrapper {
+       __u8                    valid;
+       struct amp_link_key     key;
+};
+
+struct a2mp_conn {
+       struct l2cap_conn               *conn;
+       spinlock_t                      lock;
+       struct list_head                list;
+       struct controller_array         *remote;
+       /*phy_link list per conn */
+       struct amp_phy_link_list        phy_link_list;
+       atomic_t                        req_cnt;
+       __u16                           mtu;
+       __u16                           feat_mask;
+       /*tx identify*/
+       __u8                            tx_ident;
+       /*remote amp contr avail status */
+       __u8                            contr_state;
+       __u8                            amp_role;
+       __u8                            discov_state;
+       struct timer_list               discov_timer;
+       __u8                            gamp_lk[GAMP_KEY_LENGTH];
+       struct amp_link_key_wrapper     dedicated_lk[MAX_PAL_TYPE];
+       __u8                            status;
+};
+
+struct cmd_context {
+       struct list_head        list;
+       struct a2mp_conn        *a2mp_conn;
+       __u8                    type;
+       __u8                    code;
+       __u8                    identify;
+       __u16                   cmd;
+       __u8                    handle;
+};
+
+struct cmd_context_list {
+       struct list_head head;
+       rwlock_t        lock;
+       __u8            num;
+};
+
+struct amp_controller {
+       /*amp device*/
+       struct hci_dev                  *dev;
+       struct list_head                list;
+       /*phy_link list per amp controller */
+       struct amp_phy_link_list        phy_link_list;
+       struct controller_info          info;
+       /*pending req context queue to handle in cmd complete*/
+       struct cmd_context_list         context_q;
+};
+
+struct amp_controller_list {
+       struct list_head        head;
+       rwlock_t                lock;
+       __u8                    num;
+};
+
+struct amp_a2mp_conn_list {
+       struct list_head        head;
+       rwlock_t                lock;
+       __u8                    num;
+};
+
+struct ampmgr_local {
+       /*spinlock to protect this global*/
+       spinlock_t      lock;
+       /*local amp contr available status*/
+       __u8    contr_state;
+       /*list head for local amp controller*/
+       struct amp_controller_list contr_list;
+       struct amp_a2mp_conn_list  a2mp_list;
+       __u8    handle_seed;
+       spinlock_t      crypt_lock;
+       struct crypto_shash *tfm;
+};
+
+int amp_mgr_init(void);
+void amp_mgr_exit(void);
+void amp_notify(struct l2cap_conn *conn, u8 cmd, void * hci_link);
+int amp_a2mp_channel_init(struct l2cap_conn *conn);
+void amp_a2mp_channel_exit(struct l2cap_conn *conn);
+void  amp_a2mp_process(struct l2cap_conn *conn, struct sk_buff *skb);
+__u8 amp_get_loc_ctrlid_by_phylink(struct l2cap_conn *conn, void * phylink);
+__u8 amp_get_rem_ctrlid_by_phylink(struct l2cap_conn *conn, void * phylink);
+void *amp_get_phylink_by_loc_ctrlid(struct l2cap_conn *conn, __u8 ctrlid);
+void *amp_get_phylink_by_rem_ctrlid(struct l2cap_conn *conn, __u8 ctrlid);
+#endif
diff --git a/net/bluetooth/ampmgr.c b/net/bluetooth/ampmgr.c
new file mode 100755
index 0000000..fb706e1
--- /dev/null
+++ b/net/bluetooth/ampmgr.c
@@ -0,0 +1,2217 @@
+/* Bluetooth amp-mgr */
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <net/sock.h>
+#include <linux/skbuff.h>
+#include <linux/notifier.h>
+#include <linux/crypto.h>
+#include <crypto/hash.h>
+#include <linux/err.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/ampmgr.h>
+
+static struct ampmgr_local ampmgr;
+
+static inline void amp_contr_list_link(struct amp_controller_list *l,
+                                               struct amp_controller *contr)
+{
+       write_lock_bh(&l->lock);
+       list_add_tail(&contr->list, &l->head);
+       l->num++;
+       write_unlock_bh(&l->lock);
+}
+
+static inline void amp_contr_list_unlink(struct amp_controller_list *l,
+                                               struct amp_controller *contr)
+{
+       write_lock_bh(&l->lock);
+       list_del(&contr->list);
+       l->num--;
+       write_unlock_bh(&l->lock);
+}
+
+static inline void amp_a2mp_phylink_link(struct amp_phy_link_list *l,
+                                               struct amp_phy_link *phy_link)
+{
+       write_lock(&l->lock);
+       list_add(&phy_link->per_conn_list, &l->head);
+       write_unlock(&l->lock);
+}
+
+static inline void amp_a2mp_phylink_unlink(struct amp_phy_link_list *l,
+                                               struct amp_phy_link *phy_link)
+{
+
+       write_lock(&l->lock);
+       list_del(&phy_link->per_conn_list);
+       write_unlock(&l->lock);
+}
+
+static inline void amp_a2mp_conn_link(struct amp_a2mp_conn_list *l,
+                                               struct a2mp_conn *a2mp_conn)
+{
+       write_lock(&l->lock);
+       list_add(&a2mp_conn->list, &l->head);
+       write_unlock(&l->lock);
+}
+
+static inline void amp_a2mp_conn_unlink(struct amp_a2mp_conn_list *l,
+                                               struct a2mp_conn *a2mp_conn)
+{
+
+       write_lock_bh(&l->lock);
+       list_del(&a2mp_conn->list);
+       write_unlock_bh(&l->lock);
+}
+
+static inline void amp_contr_phylink_link(struct amp_phy_link_list *l,
+                                               struct amp_phy_link *phy_link)
+{
+       write_lock_bh(&l->lock);
+       list_add(&phy_link->per_contr_list, &l->head);
+       write_unlock_bh(&l->lock);
+}
+
+static inline void amp_contr_phylink_unlink(struct amp_phy_link_list *l,
+                                               struct amp_phy_link *phy_link)
+{
+
+       write_lock_bh(&l->lock);
+       list_del(&phy_link->per_contr_list);
+       write_unlock_bh(&l->lock);
+}
+
+static inline void amp_ctx_list_link(struct cmd_context_list *l,
+                                       struct cmd_context *ctx)
+{
+       write_lock_bh(&l->lock);
+       list_add_tail(&ctx->list, &l->head);
+       write_unlock_bh(&l->lock);
+}
+
+static inline void amp_ctx_list_unlink(struct cmd_context_list *l,
+                                               struct cmd_context *ctx)
+{
+       write_lock_bh(&l->lock);
+       list_del(&ctx->list);
+       write_unlock_bh(&l->lock);
+}
+
+/*Fix me*/
+/* a simple logic to selelct local control for phy link create*/
+static  u8 amp_select_local_contr_id(void)
+{
+       struct amp_controller *amp_contr;
+
+       /* maybe we can select the ctrler according to the AMP status */
+       if (ampmgr.contr_list.num > 0) {
+               amp_contr = list_first_entry(&ampmgr.contr_list.head,
+                                               struct amp_controller, list);
+               return amp_contr->info.id;
+       } else {
+               BT_ERR("error in amp_select_remote_contr_id");
+               return 0;
+       }
+}
+
+/*Fix me*/
+/* a simple logic to selelct remote control for phy link create*/
+static u8 amp_select_remote_contr_id(struct a2mp_conn *a2mp_conn)
+{
+       struct controller_array         *remote = a2mp_conn->remote;
+       /* maybe we can select the ctrler according to the AMP status */
+       if (remote->size > 0) {
+               return remote->contr[0].id;
+       } else {
+               BT_ERR("error in amp_select_remote_contr_id");
+               return 0;
+       }
+}
+
+static struct amp_controller *amp_get_contr_by_id(u8 ctrlid)
+{
+       struct amp_controller *amp_contr = NULL;
+       struct list_head *p;
+
+       read_lock(&ampmgr.contr_list.lock);
+       list_for_each(p, &ampmgr.contr_list.head) {
+               amp_contr = list_entry(p, struct amp_controller, list);
+               if (amp_contr->info.id == ctrlid) {
+                       read_unlock(&ampmgr.contr_list.lock);
+                       return amp_contr;
+               }
+       }
+       read_unlock(&ampmgr.contr_list.lock);
+
+       return NULL;
+}
+
+static struct amp_phy_link *amp_get_phylink_by_ctrlid
+               (struct a2mp_conn *a2mp_conn,
+                       u8 local_ctrl_id, u8 remote_ctrl_id)
+{
+       struct amp_phy_link *phy_link = NULL;
+       struct list_head *p;
+
+       read_lock(&a2mp_conn->phy_link_list.lock);
+
+       list_for_each(p, &a2mp_conn->phy_link_list.head) {
+               phy_link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if ((phy_link->local_ctrl_id == local_ctrl_id) &&
+                       (phy_link->remote_ctrl_id == remote_ctrl_id)) {
+                       read_unlock(&a2mp_conn->phy_link_list.lock);
+                       return phy_link;
+               }
+       }
+       read_unlock(&a2mp_conn->phy_link_list.lock);
+
+       return NULL;
+}
+
+static struct amp_phy_link *amp_get_phylink_by_iden
+                       (struct a2mp_conn *a2mp_conn, u8 identify)
+{
+       struct amp_phy_link *phy_link = NULL;
+       struct list_head *p;
+
+       read_lock(&a2mp_conn->phy_link_list.lock);
+
+       list_for_each(p, &a2mp_conn->phy_link_list.head) {
+               phy_link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if (phy_link->identify == identify) {
+                       read_unlock(&a2mp_conn->phy_link_list.lock);
+                       return phy_link;
+               }
+       }
+       read_unlock(&a2mp_conn->phy_link_list.lock);
+
+       return NULL;
+}
+
+static struct amp_phy_link *amp_get_phylink_by_handle
+                               (struct a2mp_conn *a2mp_conn, u8 handle)
+{
+       struct amp_phy_link *phy_link = NULL;
+       struct list_head *p;
+
+       read_lock(&a2mp_conn->phy_link_list.lock);
+
+       list_for_each(p, &a2mp_conn->phy_link_list.head) {
+               phy_link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if (phy_link->handle == handle) {
+                       read_unlock(&a2mp_conn->phy_link_list.lock);
+                       return phy_link;
+               }
+       }
+       read_unlock(&a2mp_conn->phy_link_list.lock);
+
+       return NULL;
+}
+
+static struct amp_phy_link *amp_get_creator_progress_phy_link
+                               (struct a2mp_conn *a2mp_conn)
+{
+       struct amp_phy_link *phy_link = NULL;
+       struct list_head *p;
+
+       if (a2mp_conn->amp_role != AMP_ROLE_CREATOR)
+               return NULL;
+
+       read_lock(&a2mp_conn->phy_link_list.lock);
+
+       list_for_each(p, &a2mp_conn->phy_link_list.head) {
+               phy_link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if ((phy_link->state == PHY_LINK_INFO_REQ_SENT)
+                       || (phy_link->state == PHY_LINK_ASSOC_REQ_SENT)
+                       || (phy_link->state == PHY_LINK_CREATE_REQ_SENT)
+                       || (phy_link->state == PHY_LINK_HCI_CREATE_SENT)) {
+                       read_unlock(&a2mp_conn->phy_link_list.lock);
+                       return phy_link;
+               }
+       }
+       read_unlock(&a2mp_conn->phy_link_list.lock);
+
+       return NULL;
+}
+
+__u8 amp_get_loc_ctrlid_by_phylink(struct l2cap_conn *conn, void * phylink)
+{
+       struct a2mp_conn *mgr = (struct a2mp_conn *)conn->amp_handle;
+       struct amp_phy_link *link;
+       struct list_head *p;
+       __u8 any = (phylink == NULL) ? 1 : 0;
+
+       read_lock(&mgr->phy_link_list.lock);
+       list_for_each(p, &mgr->phy_link_list.head) {
+               link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if (any || (link->hci_link == phylink)) {
+                       read_unlock(&mgr->phy_link_list.lock);
+
+                       return link->local_ctrl_id;
+               }
+       }
+       read_unlock(&mgr->phy_link_list.lock);
+
+       return CTRL_ID_BREDR;
+}
+
+ __u8 amp_get_rem_ctrlid_by_phylink(struct l2cap_conn *conn, void * phylink)
+{
+       struct a2mp_conn *mgr = (struct a2mp_conn *)conn->amp_handle;
+       struct amp_phy_link *link;
+       struct list_head *p;
+       __u8 any = (phylink == NULL) ? 1 : 0;
+
+       read_lock(&mgr->phy_link_list.lock);
+       list_for_each(p, &mgr->phy_link_list.head) {
+               link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if (any || (link->hci_link == phylink)) {
+                       read_unlock(&mgr->phy_link_list.lock);
+
+                       return link->remote_ctrl_id;
+               }
+       }
+       read_unlock(&mgr->phy_link_list.lock);
+
+       return CTRL_ID_BREDR;
+}
+
+void *amp_get_phylink_by_loc_ctrlid(struct l2cap_conn *conn, __u8 ctrlid)
+{
+       struct a2mp_conn *mgr = (struct a2mp_conn *)conn->amp_handle;
+       struct amp_phy_link *link;
+       struct list_head *p;
+
+       if (ctrlid == CTRL_ID_BREDR)
+               return NULL;
+
+       read_lock(&mgr->phy_link_list.lock);
+       list_for_each(p, &mgr->phy_link_list.head) {
+               link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if (link->local_ctrl_id == ctrlid) {
+                       read_unlock(&mgr->phy_link_list.lock);
+                       return (void *)link->hci_link;
+               }
+       }
+       read_unlock(&mgr->phy_link_list.lock);
+
+       return (void *)NULL;
+}
+
+void *amp_get_phylink_by_rem_ctrlid(struct l2cap_conn *conn, __u8 ctrlid)
+{
+       struct a2mp_conn *mgr = (struct a2mp_conn *)conn->amp_handle;
+       struct amp_phy_link *link;
+       struct list_head *p;
+
+       if (ctrlid == CTRL_ID_BREDR)
+               return NULL;
+
+       read_lock(&mgr->phy_link_list.lock);
+       list_for_each(p, &mgr->phy_link_list.head) {
+               link = list_entry(p, struct amp_phy_link, per_conn_list);
+               if (link->remote_ctrl_id == ctrlid) {
+                       read_unlock(&mgr->phy_link_list.lock);
+                       return (void *)link->hci_link;
+               }
+       }
+       read_unlock(&mgr->phy_link_list.lock);
+
+       return (void *)NULL;
+}
+
+static void amp_set_a2mp_timer(struct amp_phy_link *phy_link, long timeout)
+{
+       BT_DBG("phy link state %d, timeout value %ld",
+                       phy_link->state, timeout);
+       mod_timer(&phy_link->a2mp_timer, jiffies +
+                               msecs_to_jiffies(timeout));
+}
+
+static void amp_clear_a2mp_timer(struct amp_phy_link *phy_link)
+{
+       BT_DBG("phy link state %d", phy_link->state);
+       del_timer(&phy_link->a2mp_timer);
+}
+
+static void amp_set_phylink_timer(struct amp_phy_link *phy_link, long timeout)
+{
+       BT_DBG("phy link state %d, timeout value %ld",
+                       phy_link->state, timeout);
+       mod_timer(&phy_link->timer, jiffies +
+                               msecs_to_jiffies(timeout));
+}
+
+static void amp_clear_phylink_timer(struct amp_phy_link *phy_link)
+{
+       BT_DBG("phy link state %d", phy_link->state);
+       del_timer(&phy_link->timer);
+}
+
+static inline int amp_collision_resolution(bdaddr_t *local, bdaddr_t *remote)
+{
+       int i;
+
+       BT_DBG("resolve collison");
+
+       for (i = 0; i < 6 && (local->b[i] == remote->b[i]); i++)
+               ;
+
+       return local->b[i] > remote->b[i];
+}
+
+static u8 amp_get_ident(struct a2mp_conn *a2mp_conn)
+{
+       u8 id;
+
+       spin_lock_bh(&a2mp_conn->lock);
+
+       if (++a2mp_conn->tx_ident > 128)
+               a2mp_conn->tx_ident = 1;
+
+       id = a2mp_conn->tx_ident;
+
+       spin_unlock_bh(&a2mp_conn->lock);
+
+       return id;
+}
+
+static int hmac_sha256(char *key, size_t klen,
+                       char *data_in, size_t dlen,
+                       char *hash_out, size_t outlen)
+{
+       int rc = 0;
+       struct crypto_shash *tfm = ampmgr.tfm;
+       struct {
+               struct shash_desc shash;
+               char ctx[crypto_shash_descsize(tfm)]; /* size = sizeof(struct shash_desc) + sizeof(struct sha256_state) */
+       } desc;
+
+       if (IS_ERR(tfm)) {
+               BT_DBG("hmac_sha256: crypto_alloc_shash failed");
+               rc = PTR_ERR(tfm);
+               goto err_tfm;
+       }
+       if (crypto_shash_digestsize(tfm) > outlen) {
+               BT_DBG("hmac_sha256: tfm size > result buffer");
+               rc = -EINVAL;
+               goto err_req;
+       }
+       crypto_shash_clear_flags(tfm, -0);
+       rc = crypto_shash_setkey(tfm, key, klen);
+       if (rc) {
+               BT_DBG("hmac_sha256: crypto_shash_setkey failed");
+               goto err_setkey;
+       }
+       desc.shash.tfm = tfm;
+       desc.shash.flags = 0;
+       rc = crypto_shash_digest(&desc.shash, data_in, dlen, hash_out);
+err_setkey:
+err_req:
+       /* crypto_free_shash(tfm); */
+err_tfm:
+       return rc;
+}
+
+static void amp_link_key_h2(u8 *link_key, u8 *digest, u8 key_id)
+{
+
+       u8      tmp[SHA256_DIGEST_LEN];
+
+       if (IS_ERR(ampmgr.tfm))
+               return;
+
+       spin_lock_bh(&ampmgr.crypt_lock);
+
+       switch (key_id) {
+       case GAMP_KEY_ID:
+               hmac_sha256(link_key, GAMP_KEY_LENGTH,
+                       "gamp", 4, tmp, SHA256_DIGEST_LEN);
+               break;
+       case PAL_KEY_ID:
+               hmac_sha256(link_key, GAMP_KEY_LENGTH,
+                       "802b", 4, tmp, SHA256_DIGEST_LEN);
+               break;
+       case ECMA_KEY_ID:
+               hmac_sha256(link_key, GAMP_KEY_LENGTH,
+                       "ecma", 4, tmp, SHA256_DIGEST_LEN);
+               break;
+       default:
+               break;
+       }
+       spin_unlock_bh(&ampmgr.crypt_lock);
+
+       memcpy(digest, tmp, GAMP_KEY_LENGTH);
+ }
+
+static void amp_create_generic_link_key(u8 *link_key, u8 *gamp_link_key)
+{
+       u8      tmp[GAMP_KEY_LENGTH];
+
+       memcpy(tmp, link_key, 16);
+       memcpy(tmp+16, link_key, 16);
+       amp_link_key_h2(tmp , gamp_link_key, GAMP_KEY_ID);
+}
+
+static void amp_create_dedicated_link_key(u8 *gamp_link_key,
+                                       u8 key_type, u8 *decidated_link_key)
+{
+       if (key_type == 0x03)
+               memcpy(decidated_link_key, gamp_link_key, GAMP_KEY_LENGTH);
+       else
+               amp_link_key_h2(gamp_link_key, decidated_link_key, PAL_KEY_ID);
+
+}
+
+struct l2cap_a2mp_packet *amp_build_cmd(struct a2mp_conn *a2mp_conn,
+                                               u8 code, u8 ident, u16 len, void *data)
+{
+       struct l2cap_a2mp_packet *send =  kzalloc((AMP_CMD_HDR_LENGTH + len), GFP_ATOMIC);
+
+       BT_DBG("code 0x%x, ident %d, len %d", code, ident, len);
+
+       if (!send) {
+               BT_DBG("mm alloc fail in amp_build_cmd");
+               return NULL;
+       }
+
+       send->code = code;
+       send->ident = ident;
+       send->len = cpu_to_le16(len);
+       /* Fix me */
+       /* simple logic, assume len < 670 always */
+       if (len > 0)
+               memcpy(send->data, data, len);
+       return  send;
+}
+
+static int amp_build_discover_rsp(struct a2mp_conn *a2mp_conn, void *data)
+{
+       struct a2mp_discover_rsp *rsp = (struct a2mp_discover_rsp *)data;
+       u8      *ptr = rsp->data;
+       struct list_head *p;
+
+       BT_DBG("mtu %d", cpu_to_le16(AMP_DEFAULT_MTU));
+
+       rsp->mtu = cpu_to_le16(AMP_DEFAULT_MTU);
+       rsp->ext_feature_mask = cpu_to_le16(AMP_DEFAULT_EXT_FEAT_MASK);
+
+       *ptr = 0x00;
+       *(ptr+1) = HCI_BREDR;
+       *(ptr+2) = 1;
+       ptr += 3;
+
+       read_lock(&ampmgr.contr_list.lock);
+       list_for_each(p, &ampmgr.contr_list.head) {
+               struct amp_controller *amp_contr = list_entry(p, struct amp_controller, list);
+
+               BT_DBG("AMP controller id %x, tpye %x, status %x",\
+                       amp_contr->info.id, amp_contr->info.type, amp_contr->info.status);
+
+               *ptr = amp_contr->info.id;
+               *(ptr + 1) = amp_contr->info.type;
+#if 1
+               *(ptr + 2) = AMP_CONTR_FULL_CAPACITY;
+#else
+               *(ptr + 2) = amp_contr->info.status;
+#endif
+               ptr += 3;
+       }
+       read_unlock(&ampmgr.contr_list.lock);
+
+       return ptr - (u8 *)data;
+
+}
+
+static int amp_build_change_notify(struct a2mp_conn *a2mp_conn, void *data)
+{
+       struct a2mp_change_notify *noitfy = (struct a2mp_change_notify *)data;
+       u8      *ptr = noitfy->data;
+       struct list_head *p;
+
+       BT_DBG("build change notify");
+
+       *ptr = 0x00;
+       *(ptr+1) = HCI_BREDR;
+       *(ptr+2) = 1;
+       ptr += 3;
+
+       read_lock(&ampmgr.contr_list.lock);
+       list_for_each(p, &ampmgr.contr_list.head) {
+               struct amp_controller *amp_contr = list_entry(p, struct amp_controller, list);
+
+               BT_DBG("AMP controller id %x, tpye %x, status %x",\
+                       amp_contr->info.id, amp_contr->info.type, amp_contr->info.status);
+
+               *ptr = amp_contr->info.id;
+               *(ptr + 1) = amp_contr->info.type;
+#if 1
+               *(ptr + 2) = AMP_CONTR_FULL_CAPACITY;
+#else
+               *(ptr + 2) = amp_contr->info.status;
+#endif
+               ptr += 3;
+       }
+       read_unlock(&ampmgr.contr_list.lock);
+
+       return ptr - (u8 *)data;
+
+}
+
+static int amp_disc_phy_link(struct a2mp_conn *a2mp_conn, struct amp_phy_link *phy_link)
+{
+       struct amp_controller *amp_contr = phy_link->local;
+       struct cmd_context *ctx;
+
+       BT_DBG("disc phy link 0x%p, phy link state %d", phy_link, phy_link->state);
+
+       amp_clear_phylink_timer(phy_link);
+       amp_clear_a2mp_timer(phy_link);
+
+       switch (phy_link->state) {
+       case PHY_LINK_INFO_REQ_SENT:
+       case PHY_LINK_ASSOC_REQ_SENT:
+               break;
+       case PHY_LINK_HCI_CREATE_SENT:
+       case PHY_LINK_CREATE_REQ_SENT:
+       case PHY_LINK_CREATE_RSP_RECV:
+       case PHY_LINK_HCI_ACCEPT_SENT:
+       case PHY_LINK_CREATE_RSP_SENT:
+       case PHY_LINK_CONNECTED:
+       case PHY_LINK_DISC_REQ_SENT:
+               /* send disc phy link cmd */
+               ctx = kzalloc(sizeof(struct cmd_context), GFP_ATOMIC);
+               ctx->type = PENDING_LOCAL_COMMAND;
+               ctx->code = AMP_CREATE_PHY_LINK_REQ;
+               ctx->cmd = HCI_OP_DISCONN_PHYSICAL_LINK;
+               ctx->a2mp_conn = a2mp_conn;
+               ctx->handle = phy_link->handle;
+               amp_ctx_list_link(&amp_contr->context_q, ctx);
+               hci_phylink_put(phy_link->hci_link, 0x13);
+               break;
+       default:
+               break;
+       }
+
+       /* free phy link */
+       amp_a2mp_phylink_unlink(&a2mp_conn->phy_link_list, phy_link);
+       amp_contr_phylink_unlink(&amp_contr->phy_link_list, phy_link);
+       kfree(phy_link);
+
+       BT_DBG("exit");
+
+       return 0;
+}
+
+static void amp_discov_timeout(unsigned long arg)
+{
+       struct a2mp_conn *a2mp_conn = (void *) arg;
+
+       BT_DBG("discovery state %d", a2mp_conn->discov_state);
+}
+
+static void amp_a2mp_timeout(unsigned long arg)
+{
+       struct amp_phy_link *phy_link = (void *) arg;
+
+       BT_DBG("phy_link state %d", phy_link->state);
+
+       if (phy_link == amp_get_creator_progress_phy_link(phy_link->a2mp_conn))
+               phy_link->a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+
+       amp_disc_phy_link(phy_link->a2mp_conn, phy_link);
+
+       /* FIXME: per spec, the ACL link shall be disconnected */
+}
+
+static void amp_phylink_timeout(unsigned long arg)
+{
+       struct amp_phy_link *phy_link = (void *) arg;
+
+       BT_DBG("phy_link state %d", phy_link->state);
+
+       if (phy_link == amp_get_creator_progress_phy_link(phy_link->a2mp_conn))
+               phy_link->a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+
+       amp_disc_phy_link(phy_link->a2mp_conn, phy_link);
+}
+
+static int amp_phy_link_add(struct a2mp_conn *a2mp_conn, u8 local_ctrlid, u8 remote_ctrlid)
+{
+       struct amp_phy_link *phy_link;
+       struct amp_controller *amp_contr;
+       struct a2mp_info_req req;
+       struct l2cap_a2mp_packet *send;
+
+       BT_DBG("local ctrl id %d, remote ctrl id %d", local_ctrlid, remote_ctrlid);
+
+       /* dec hs req ,or else phy_link create req will exists always */
+#if    0
+       atomic_dec(&a2mp_conn->req_cnt);
+#endif
+
+       /* only accept one phy link create  simultaneous */
+       if (a2mp_conn->amp_role == AMP_ROLE_CREATOR) {
+               BT_DBG("already in phy create progress");
+               return -1;
+       }
+
+       a2mp_conn->amp_role = AMP_ROLE_CREATOR;
+
+       amp_contr = amp_get_contr_by_id(local_ctrlid);
+       if (!amp_contr)
+               return 0;
+
+       phy_link = kzalloc(sizeof(struct amp_phy_link), GFP_ATOMIC);
+       if (!phy_link)
+               return 0;
+       phy_link->local_ctrl_id = local_ctrlid;
+       phy_link->remote_ctrl_id = remote_ctrlid;
+       phy_link->identify = amp_get_ident(a2mp_conn);
+       phy_link->local = amp_contr;
+       phy_link->a2mp_conn = a2mp_conn;
+
+       setup_timer(&phy_link->a2mp_timer, amp_a2mp_timeout,
+                                               (unsigned long) phy_link);
+       setup_timer(&phy_link->timer, amp_phylink_timeout,
+                                               (unsigned long) phy_link);
+
+       amp_a2mp_phylink_link(&a2mp_conn->phy_link_list, phy_link);
+       amp_contr_phylink_link(&amp_contr->phy_link_list, phy_link);
+
+       req.ctrl_id = remote_ctrlid;
+       send = amp_build_cmd(a2mp_conn, AMP_INFO_REQ, phy_link->identify,
+                               sizeof(struct a2mp_info_req), &req);
+       if (!send)
+               return -1;
+
+       l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+       kfree(send);
+
+       amp_set_a2mp_timer(phy_link, AMP_RESPONSE_TIMEOUT);
+       amp_set_phylink_timer(phy_link, AMP_PHY_LINK_TIMEOUT);
+
+       phy_link->state = PHY_LINK_INFO_REQ_SENT;
+
+       return 0;
+}
+
+static int amp_contr_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+       struct amp_controller_list *contr_list = &ampmgr.contr_list;
+       struct hci_dev *hdev = (struct hci_dev *) ptr;
+       struct list_head *head = &contr_list->head, *p, *n, *q;
+       struct amp_controller *amp_contr;
+       struct a2mp_conn *a2mp_conn;
+       struct cmd_context *ctx;
+
+       BT_DBG("device type %d, event id 0x%x", hdev->dev_type, (int)event);
+
+       if (event == HCI_DEV_UP) {
+               u8 contr_id = 1;
+
+               if (hdev->dev_type != HCI_BREDR) {
+                       write_lock_bh(&contr_list->lock);
+                       /* find first available amp ctrl id */
+                       list_for_each(p, &contr_list->head) {
+                               if (list_entry(p, struct amp_controller, list)->info.id != contr_id)
+                                       break;
+                               head = p; contr_id++;
+                       }
+                       amp_contr = kzalloc(sizeof(struct amp_controller), GFP_ATOMIC);
+                       amp_contr->info.id = contr_id;
+                       amp_contr->info.type = hdev->dev_type;
+                       amp_contr->info.status = AMP_CONTR_CAP_UNINITIALIZE;
+                       amp_contr->dev = hdev;
+                       hdev->amp_controller = amp_contr;
+                       rwlock_init(&amp_contr->context_q.lock);
+                       rwlock_init(&amp_contr->phy_link_list.lock);
+                       INIT_LIST_HEAD(&amp_contr->context_q.head);
+                       INIT_LIST_HEAD(&amp_contr->phy_link_list.head);
+                       contr_list->num++;
+                       list_add(&amp_contr->list, head);
+                       write_unlock_bh(&contr_list->lock);
+
+                       read_lock_bh(&ampmgr.a2mp_list.lock);
+                       /* only issue phy link create when local controller from unavailable to available*/
+                       if (ampmgr.contr_state == AMP_CONTR_UNAVAIL) {
+                               list_for_each(p, &ampmgr.a2mp_list.head) {
+                                       a2mp_conn = list_entry(p, struct a2mp_conn, list);
+                                       if ((atomic_read(&a2mp_conn->req_cnt) > 0)
+                                               && (a2mp_conn->contr_state == AMP_CONTR_AVAIL)) {
+                                               u8 local_ctrlid, remote_ctrlid;
+
+                                               local_ctrlid = amp_select_local_contr_id();
+                                               remote_ctrlid = amp_select_remote_contr_id(a2mp_conn);
+                                               amp_phy_link_add(a2mp_conn, local_ctrlid, remote_ctrlid);
+                                       }
+                               }
+                               ampmgr.contr_state = AMP_CONTR_AVAIL;
+                       }
+
+                       list_for_each(p, &ampmgr.a2mp_list.head) {
+                               a2mp_conn = list_entry(p, struct a2mp_conn, list);
+                               if (a2mp_conn->discov_state & DISOCVERY_RSP_SENT) {
+                                       /* need to send change notify if sent discover rsp before*/
+                                       struct cmd_context *ctx;
+
+                                       ctx = kzalloc(sizeof(struct cmd_context), GFP_ATOMIC);
+                                       ctx->type = PENDING_LOCAL_COMMAND;
+                                       /* Fix me, local command, mean need send change notify*/
+                                       ctx->code = AMP_CHANGE_NOTIFY;
+                                       ctx->identify = amp_get_ident(a2mp_conn);
+                                       ctx->cmd = HCI_OP_READ_LOCAL_COMMANDS;
+                                       ctx->a2mp_conn = a2mp_conn;
+
+                                       amp_ctx_list_link(&amp_contr->context_q, ctx);
+                                       hci_read_local_amp_info(amp_contr->dev);
+                               }
+                       }
+
+                       read_unlock_bh(&ampmgr.a2mp_list.lock);
+               }
+       } else if (event == HCI_DEV_DOWN || event == HCI_DEV_UNREG) {
+               struct l2cap_a2mp_packet *send;
+
+               if (hdev->dev_type != HCI_BREDR && hdev->amp_controller) {
+                       struct amp_phy_link *phy_link;
+                       amp_contr = (struct amp_controller *)hdev->amp_controller;
+                       hdev->amp_controller = NULL;
+
+                       write_lock_bh(&contr_list->lock);
+                       list_del(&amp_contr->list);
+                       if (!--contr_list->num)
+                               ampmgr.contr_state = AMP_CONTR_UNAVAIL;
+                       write_unlock_bh(&contr_list->lock);
+
+                       /* free phy link in contr */
+                       write_lock_bh(&amp_contr->phy_link_list.lock);
+                       list_for_each_safe(p, n, &amp_contr->phy_link_list.head) {
+                               phy_link = list_entry(p, struct amp_phy_link, per_contr_list);
+                               if (phy_link->state == PHY_LINK_CONNECTED)
+                                       l2cap_phylink_update(phy_link->a2mp_conn->conn,
+                                               L2CAP_PHYLINK_NOAVL, phy_link->hci_link);
+                               amp_clear_phylink_timer(phy_link);
+                               amp_clear_a2mp_timer(phy_link);
+                               list_del(&phy_link->per_conn_list);
+                               list_del(&phy_link->per_contr_list);
+                               kfree(phy_link);
+                       }
+                       write_unlock_bh(&amp_contr->phy_link_list.lock);
+
+                       /* purge contex_q in contr */
+                       write_lock_bh(&amp_contr->context_q.lock);
+                       list_for_each_safe(q, n, &amp_contr->context_q.head) {
+                                       ctx = list_entry(q, struct cmd_context, list);
+                                       list_del(&ctx->list);
+                                       kfree(ctx);
+                       }
+                       write_unlock_bh(&amp_contr->context_q.lock);
+
+                       /* amp_contr_list_unlink(contr_list, amp_contr); */
+                       kfree(amp_contr);
+
+                       /* need to send change notify if sent discover rsp before */
+                       read_lock_bh(&ampmgr.a2mp_list.lock);
+
+                       /*FIXME: can be optimised,
+                         the build change/cmd are irrelevant with a2mp_conn,
+                         so can be move out of for loop
+                       */
+                       list_for_each(p, &ampmgr.a2mp_list.head) {
+                               a2mp_conn = list_entry(p, struct a2mp_conn, list);
+                               if (a2mp_conn->discov_state & DISOCVERY_RSP_SENT) {
+                                       u8 rsp[64], len;
+
+                                       len = amp_build_change_notify(a2mp_conn, rsp);
+                                       send = amp_build_cmd(a2mp_conn, AMP_CHANGE_NOTIFY,
+                                                       amp_get_ident(a2mp_conn), len, rsp);
+                                       l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+                                       kfree(send);
+                               }
+                       }
+                       read_unlock_bh(&ampmgr.a2mp_list.lock);
+               }
+       }
+
+       return NOTIFY_DONE;
+}
+
+static struct notifier_block amp_mgr_nblock = {
+       .notifier_call = amp_contr_event
+};
+
+static int amp_create_phy_link_cfm(struct hci_dev *hdev, u8 handle, u8 status)
+{
+       struct amp_controller *amp_contr = (struct amp_controller *)hdev->amp_controller;
+       struct list_head *p, *n;
+       struct cmd_context *ctx;
+       struct amp_phy_link *phy_link;
+       struct l2cap_a2mp_packet *send;
+
+       BT_DBG("amp_contr %p, phy link handle %d, status 0x%x", amp_contr, handle, status);
+
+       if (!amp_contr)
+               return 0;
+
+       write_lock(&amp_contr->context_q.lock);
+       list_for_each_safe(p, n, &amp_contr->context_q.head) {
+               ctx = list_entry(p, struct cmd_context, list);
+               if ((ctx->cmd == HCI_OP_CREATE_PHYSICAL_LINK) && (ctx->handle == handle)) {
+                       phy_link = amp_get_phylink_by_handle(ctx->a2mp_conn, handle);
+                       if (!phy_link) {
+                               BT_ERR("ERROR: dont' exist handle phy_link in amp_create_phy_link");
+                               list_del(&ctx->list);
+                               kfree(ctx);
+                               write_unlock(&amp_contr->context_q.lock);
+                               return 0;
+                       }
+                       BT_DBG("phy_link:%p, phy_link->state:%d", phy_link, phy_link->state);
+                       if ((status == HCI_CREATE_PHYLINK_PEND)
+                               && (phy_link->state == PHY_LINK_HCI_CREATE_SENT)) {
+                               /* fix me */
+                               /* touch hci device here, need think over lock mechansim */
+                               struct amp_assoc        *info = &hdev->local_assoc;
+                               struct a2mp_phy_link_req *req = NULL;
+                               u16 length;
+
+                               BT_DBG("create phy link pend for PHY_LINK_HCI_CREATE_SENT");
+
+                               length = sizeof(struct a2mp_phy_link_req) + info->len;
+                               req = kzalloc(length, GFP_ATOMIC);
+                               req->local_ctrl_id = phy_link->local_ctrl_id;
+                               req->remote_ctrl_id = phy_link->remote_ctrl_id;
+
+                               memcpy(req->assoc, info->data, info->len);
+
+                               phy_link->identify = amp_get_ident(ctx->a2mp_conn);
+                               send = amp_build_cmd(ctx->a2mp_conn, AMP_CREATE_PHY_LINK_REQ,
+                                                       phy_link->identify, length, req);
+                               l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                               phy_link->state = PHY_LINK_CREATE_REQ_SENT;
+                               amp_set_a2mp_timer(phy_link, AMP_RESPONSE_TIMEOUT);
+
+                               kfree(req);
+                               kfree(send);
+                       } else if ((status == HCI_CREATE_PHYLINK_PEND)
+                                       && (phy_link->state == PHY_LINK_HCI_ACCEPT_SENT)) {
+                               struct a2mp_phy_link_rsp rsp;
+
+                               BT_DBG("create phy link pend for PHY_LINK_HCI_ACCEPT_SENT");
+
+                               rsp.local_ctrl_id = amp_contr->info.id;
+                               rsp.remote_ctrl_id = phy_link->remote_ctrl_id;
+                               rsp.status = AMP_STATUS_OK;
+
+                               send = amp_build_cmd(ctx->a2mp_conn, AMP_CREATE_PHY_LINK_RSP,
+                                       ctx->identify, sizeof(struct a2mp_phy_link_rsp), &rsp);
+                               l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                               phy_link->state = PHY_LINK_CREATE_RSP_SENT;
+                               kfree(send);
+                       } else if (!status) {
+                               /* hci phy link create command complete success status */
+                               BT_DBG("phy link mac ready");
+
+                               if (ctx->a2mp_conn->status & REGENERATE_GAMP_LK) {
+                                       __u8 amp_type = amp_contr->dev->dev_type;
+                                       /* regnerate gamp lk */
+                                       ctx->a2mp_conn->status &= ~REGENERATE_GAMP_LK;
+                                       amp_link_key_h2(ctx->a2mp_conn->gamp_lk,
+                                               ctx->a2mp_conn->gamp_lk, GAMP_KEY_ID);
+                                       ctx->a2mp_conn->dedicated_lk[amp_type-1].valid = 1;
+                               }
+                               switch (phy_link->state) {
+                               case PHY_LINK_CREATE_RSP_RECV:
+                               case PHY_LINK_CREATE_RSP_SENT:
+                                       phy_link->state = PHY_LINK_CONNECTED;
+                                       ctx->a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+                                       amp_clear_phylink_timer(phy_link);
+                                       atomic_dec(&ctx->a2mp_conn->req_cnt);
+                                       l2cap_phylink_update(ctx->a2mp_conn->conn,
+                                               L2CAP_PHYLINK_READY, phy_link->hci_link);
+                                       break;
+                               case PHY_LINK_CREATE_REQ_SENT:
+                                       BT_DBG("phy link create cmd complete before a2mp create rsp");
+                                       phy_link->flag = PHY_LINK_MAC_READY;
+                                       break;
+                               default:
+                                       break;
+                               }
+                               list_del(&ctx->list);
+                               kfree(ctx);
+                       } else  {
+                               BT_ERR("amp phy link create fail, status 0x%x", status);
+                               if (phy_link == amp_get_creator_progress_phy_link(ctx->a2mp_conn))
+                                       ctx->a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+
+                               if (phy_link->state == PHY_LINK_HCI_ACCEPT_SENT) {
+                                       struct a2mp_phy_link_rsp rsp;
+
+                                       rsp.local_ctrl_id = amp_contr->info.id;
+                                       rsp.remote_ctrl_id = phy_link->remote_ctrl_id;
+                                       rsp.status = AMP_STATUS_UNABLE_TO_CREATE_LINK;
+
+                                       send = amp_build_cmd(ctx->a2mp_conn, AMP_CREATE_PHY_LINK_RSP,
+                                               ctx->identify, sizeof(struct a2mp_phy_link_rsp), &rsp);
+                                       l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                                       phy_link->state = PHY_LINK_CREATE_RSP_SENT;
+                                       kfree(send);
+                               }
+                               list_del(&ctx->list);
+                               kfree(ctx);
+                               amp_clear_phylink_timer(phy_link);
+                               amp_clear_a2mp_timer(phy_link);
+                               list_del(&phy_link->per_conn_list);
+                               list_del(&phy_link->per_contr_list);
+                               kfree(phy_link);
+                       }
+                       break;
+               }
+       }
+       write_unlock(&amp_contr->context_q.lock);
+
+       return 0;
+}
+
+static int amp_disc_phy_link_cfm(struct hci_dev *hdev, u8 handle, u8 status, u8 reason)
+{
+       struct amp_controller *amp_contr = (struct amp_controller *)hdev->amp_controller;
+       struct list_head *p, *n;
+       struct cmd_context *ctx;
+       struct amp_phy_link *phy_link;
+
+       BT_DBG("amp_contr %p, phy link handle %d, status 0x%x", amp_contr, handle, status);
+
+       if (amp_contr) {
+               write_lock(&amp_contr->context_q.lock);
+               list_for_each_safe(p, n, &amp_contr->context_q.head) {
+                       ctx = list_entry(p, struct cmd_context, list);
+                       if ((ctx->cmd == HCI_OP_DISCONN_PHYSICAL_LINK)
+                                        && (ctx->handle == handle)) {
+                               /*todo??*/
+                               list_del(&ctx->list);
+                               kfree(ctx);
+                               break;
+                       }
+               }
+               write_unlock(&amp_contr->context_q.lock);
+       }
+
+       read_lock(&ampmgr.a2mp_list.lock);
+
+       /* for those disc conn can't found ctx, maybe it need global ampmgr to search a2mp_conn*/
+       /* search & found in ampmgr */
+       list_for_each(p, &ampmgr.a2mp_list.head) {
+               struct a2mp_conn *a2mp_conn;
+               a2mp_conn = list_entry(p, struct a2mp_conn, list);
+                       phy_link = amp_get_phylink_by_handle(a2mp_conn, handle);
+                       if (phy_link) {
+
+                               BT_DBG("phy link %p", phy_link);
+                               l2cap_phylink_update(a2mp_conn->conn,
+                                        L2CAP_PHYLINK_NOAVL, phy_link->hci_link);
+                               amp_clear_phylink_timer(phy_link);
+                               amp_clear_a2mp_timer(phy_link);
+                               amp_a2mp_phylink_unlink(&a2mp_conn->phy_link_list, phy_link);
+                               if (amp_contr)
+                                       amp_contr_phylink_unlink(&amp_contr->phy_link_list, phy_link);
+                               kfree(phy_link);
+                       }
+       }
+       read_unlock(&ampmgr.a2mp_list.lock);
+
+       return 0;
+}
+
+static int amp_local_assoc_ind(struct hci_dev *hdev, u8 status)
+{
+       struct amp_controller *amp_contr = (struct amp_controller *)hdev->amp_controller;
+       struct list_head *p, *n;
+       struct cmd_context *ctx;
+
+       BT_DBG("amp_contr %p, status %d", amp_contr, status);
+
+       if (!amp_contr)
+               return 0;
+
+       write_lock(&amp_contr->context_q.lock);
+       list_for_each_safe(p, n, &amp_contr->context_q.head) {
+               ctx = list_entry(p, struct cmd_context, list);
+               if (ctx->cmd == HCI_OP_READ_LOCAL_AMP_ASSOC) {
+                       struct l2cap_a2mp_packet *send;
+                       struct a2mp_assoc_rsp *rsp;
+                       struct amp_assoc                *info = &hdev->local_assoc;
+                       u16 length;
+
+                       BT_DBG("local assoc ind for READ_LOCAL_AMP_ASSOC");
+
+                       length = sizeof(struct a2mp_assoc_rsp) + info->len;
+                       rsp = kzalloc(length, GFP_ATOMIC);
+                       rsp->ctrl_id = amp_contr->info.id;
+                       rsp->status = AMP_STATUS_OK;
+
+                       memcpy(rsp->assoc, info->data, info->len);
+
+                       send = amp_build_cmd(ctx->a2mp_conn, AMP_ASSOC_RSP, ctx->identify,
+                                               length, rsp);
+                       l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                       kfree(send);
+                       kfree(rsp);
+                       list_del(&ctx->list);
+                       kfree(ctx);
+                       break;
+               }
+       }
+       write_unlock(&amp_contr->context_q.lock);
+
+       return 0;
+}
+
+static int amp_local_info_ind(struct hci_dev *hdev, u8 status)
+{
+       struct amp_controller *amp_contr = (struct amp_controller *)hdev->amp_controller;
+       struct list_head *p, *tmp, *n;
+       struct cmd_context *ctx;
+       struct l2cap_a2mp_packet *send;
+
+       BT_DBG("amp_contr %p, status %d", amp_contr, status);
+
+       if (!amp_contr)
+               return 0;
+
+       amp_contr->info.status = hdev->ctrl_info.amp_status;
+       write_lock(&amp_contr->context_q.lock);
+       list_for_each_safe(p, n, &amp_contr->context_q.head) {
+               ctx = list_entry(p, struct cmd_context, list);
+               if (ctx->cmd == HCI_OP_READ_LOCAL_COMMANDS) {
+                       if ((ctx->type == PENDING_REMOTE_SIGNAL)
+                               && (ctx->code == AMP_DISCOVER_REQ)) {
+                               __u8 i = 0;
+
+                               BT_DBG("local info ind for discovery req");
+                               read_lock(&ampmgr.contr_list.lock);
+                               list_for_each(tmp, &ampmgr.contr_list.head) {
+                                       struct amp_controller *contr = list_entry(tmp, struct amp_controller, list);
+                                       if (contr->info.status == AMP_CONTR_CAP_UNINITIALIZE)
+                                               i++;
+                               }
+                               read_unlock(&ampmgr.contr_list.lock);
+                               /* send discover rsp after read all contr status */
+                               if (i == 0) {
+                                       u8 rsp[64], len;
+
+                                       len = amp_build_discover_rsp(ctx->a2mp_conn, rsp);
+                                       send = amp_build_cmd(ctx->a2mp_conn,
+                                                       AMP_DISCOVER_RSP, ctx->identify, len, rsp);
+                                       l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                                       ctx->a2mp_conn->discov_state |= DISOCVERY_RSP_SENT;
+                                       kfree(send);
+                               }
+                       } else if ((ctx->type == PENDING_REMOTE_SIGNAL)
+                                       && (ctx->code == AMP_INFO_REQ)) {
+                               /* fix me*/
+                               /* touch hci device here,need think over lock mechansim */
+                               struct amp_info         info = hdev->ctrl_info;
+                               struct a2mp_info_rsp rsp;
+
+                               BT_DBG("local info ind for info req");
+                               rsp.ctrl_id = amp_contr->info.id;
+                               rsp.status = AMP_STATUS_OK;
+                               rsp.total_bandwidth = cpu_to_le32(info.total_bandwidth);
+                               rsp.max_bandwidth = cpu_to_le32(info.max_guaranteed_bandwidth);
+                               rsp.min_latency = cpu_to_le32(info.min_latency);
+                               rsp.pal_capability = cpu_to_le16(info.pal_caps);
+                               rsp.amp_assoc_size = cpu_to_le16(info.max_assoc_len);
+                               send = amp_build_cmd(ctx->a2mp_conn, AMP_INFO_RSP, ctx->identify,
+                                                       sizeof(struct a2mp_info_rsp), &rsp);
+                               l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                               kfree(send);
+                       }  else if ((ctx->type == PENDING_LOCAL_COMMAND)
+                                       && (ctx->code == AMP_CHANGE_NOTIFY)) {
+                               u8 rsp[64], len;
+
+                               BT_DBG("local info ind for change notify");
+                               len = amp_build_change_notify(ctx->a2mp_conn, rsp);
+                               send = amp_build_cmd(ctx->a2mp_conn,
+                                               AMP_CHANGE_NOTIFY, ctx->identify, len, rsp);
+                               l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                               kfree(send);
+                       }
+
+                       list_del(&ctx->list);
+                       kfree(ctx);
+                       break;
+               } else {
+                       continue;
+               }
+       }
+
+       write_unlock(&amp_contr->context_q.lock);
+       return 0;
+}
+
+static struct hci_cb amp_mgr_cb = {
+       .name                           = "ampmgr",
+       .create_physical_link_cfm       = amp_create_phy_link_cfm,
+       .put_physical_link_cfm          = amp_disc_phy_link_cfm,
+       .local_assoc_ind                = amp_local_assoc_ind,
+       .local_info_ind                 = amp_local_info_ind
+};
+
+/* Fix me */
+/* a simple logic to get physical link handle, maybe get duplicate phy_handle after rewind */
+static u8 amp_get_phy_handle(void)
+{
+       u8 id;
+
+       spin_lock_bh(&ampmgr.lock);
+
+       if (++ampmgr.handle_seed > 256)
+               ampmgr.handle_seed = 1;
+       id = ampmgr.handle_seed;
+       spin_unlock_bh(&ampmgr.lock);
+       return id;
+}
+
+/* register hci call back interface ,
+ * register amp controller hotplug notify block,
+ * collect local amp controller list
+ * init amp link key h2 function ctx
+ */
+int amp_mgr_init(void)
+{
+       struct amp_controller *amp_contr;
+       struct list_head *p;
+       u8      contr_id = 0;
+
+       hci_register_cb(&amp_mgr_cb);
+
+       rwlock_init(&ampmgr.contr_list.lock);
+       rwlock_init(&ampmgr.a2mp_list.lock);
+       spin_lock_init(&ampmgr.lock);
+       spin_lock_init(&ampmgr.crypt_lock);
+
+       INIT_LIST_HEAD(&ampmgr.contr_list.head);
+       INIT_LIST_HEAD(&ampmgr.a2mp_list.head);
+
+       ampmgr.contr_state = AMP_CONTR_UNAVAIL;
+
+       read_lock_bh(&hci_dev_list_lock);
+       list_for_each(p, &hci_dev_list) {
+               struct hci_dev *d = list_entry(p, struct hci_dev, list);
+
+               if (d->dev_type != HCI_BREDR && test_bit(HCI_UP, &d->flags)) {
+                       contr_id++;
+                       /* amp controller exist indicate amp controller available?*/
+                       /* Fix me*/
+                       ampmgr.contr_state = AMP_CONTR_AVAIL;
+
+                       amp_contr = kzalloc(sizeof(struct amp_controller), GFP_KERNEL);
+                       if (amp_contr == NULL) {
+                               read_unlock_bh(&hci_dev_list_lock);
+                               return -1;
+                       }
+                       /* rwlock_init(&amp_contr->lock); */
+
+                       amp_contr->info.id = contr_id;
+                       amp_contr->info.type = d->dev_type;
+                       /* simplify logic here,need refine */
+                       amp_contr->info.status = AMP_CONTR_CAP_UNINITIALIZE;
+                       amp_contr->dev = d;
+                       /* let hci device pointer back */
+                       d->amp_controller = amp_contr;
+                       rwlock_init(&amp_contr->context_q.lock);
+                       rwlock_init(&amp_contr->phy_link_list.lock);
+                       amp_contr_list_link(&ampmgr.contr_list, amp_contr);
+                       INIT_LIST_HEAD(&amp_contr->context_q.head);
+                       INIT_LIST_HEAD(&amp_contr->phy_link_list.head);
+
+               }
+       }
+
+       BT_DBG("amp controller count %d", ampmgr.contr_list.num);
+       read_unlock_bh(&hci_dev_list_lock);
+
+       hci_register_notifier(&amp_mgr_nblock);
+
+       ampmgr.tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
+       if (IS_ERR(ampmgr.tfm))
+               return -1;
+
+       return 0;
+}
+
+/* call when l2cap module unload */
+void amp_mgr_exit(void)
+{
+       struct list_head *p, *n;
+       struct amp_controller_list *contr_list = &ampmgr.contr_list;
+       struct amp_controller *amp_contr;
+
+       if (!IS_ERR(ampmgr.tfm))
+               crypto_free_shash(ampmgr.tfm);
+
+       hci_unregister_cb(&amp_mgr_cb);
+       hci_unregister_notifier(&amp_mgr_nblock);
+
+       /*Fix me, maybe phy link list in amp controller exist*/
+       write_lock_bh(&contr_list->lock);
+       list_for_each_safe(p, n, &contr_list->head) {
+               amp_contr = list_entry(p, struct amp_controller, list);
+               amp_contr->dev->amp_controller = NULL;
+               list_del(&amp_contr->list);
+               contr_list->num--;
+               kfree(amp_contr);
+       }
+       write_unlock_bh(&contr_list->lock);
+
+       return;
+}
+
+/*init amp_mgr a2mp channel */
+int amp_a2mp_channel_init(struct l2cap_conn *conn)
+{
+       struct a2mp_conn *a2mp_conn;
+
+       BT_DBG("l2cap_conn %p", conn);
+
+       if (conn->amp_handle)
+               return 0;
+       a2mp_conn = kzalloc(sizeof(struct a2mp_conn), GFP_ATOMIC);
+       if (!a2mp_conn)
+               return -1;
+       conn->amp_handle = (void *)a2mp_conn;
+       a2mp_conn->conn = conn;
+
+       rwlock_init(&a2mp_conn->phy_link_list.lock);
+
+       spin_lock_init(&a2mp_conn->lock);
+
+       INIT_LIST_HEAD(&a2mp_conn->phy_link_list.head);
+
+       setup_timer(&a2mp_conn->discov_timer, amp_discov_timeout,
+                                               (unsigned long) a2mp_conn);
+
+       amp_a2mp_conn_link(&ampmgr.a2mp_list, a2mp_conn);
+
+       a2mp_conn->contr_state = AMP_CONTR_UNKNOWN;
+       atomic_set(&a2mp_conn->req_cnt, 0);
+
+       return 0;
+
+}
+
+/*destroy amp_mgr a2mp channel*/
+void amp_a2mp_channel_exit(struct l2cap_conn *conn)
+{
+       struct a2mp_conn *a2mp_conn = (struct a2mp_conn *)conn->amp_handle;
+       struct list_head *p, *q, *n;
+       struct amp_phy_link *phy_link;
+       struct cmd_context *ctx;
+       struct amp_controller *amp_contr;
+
+       BT_DBG("l2cap_conn %p", conn);
+       if (!a2mp_conn)
+               return;
+
+       /*Fix me, need think over phy link list in amp controller*/
+       /*need think over how to disc phy link */
+       write_lock(&a2mp_conn->phy_link_list.lock);
+       list_for_each_safe(p, n, &a2mp_conn->phy_link_list.head) {
+               /*disc phy link without wait cfm*/
+               phy_link = list_entry(p, struct amp_phy_link, per_conn_list);
+               amp_clear_phylink_timer(phy_link);
+               amp_clear_a2mp_timer(phy_link);
+               if (phy_link->hci_link)
+                       hci_phylink_put(phy_link->hci_link, 0x13);
+               list_del(&phy_link->per_conn_list);
+               list_del(&phy_link->per_contr_list);
+               kfree(phy_link);
+       }
+       write_unlock(&a2mp_conn->phy_link_list.lock);
+
+       if (a2mp_conn->remote)
+               kfree(a2mp_conn->remote);
+
+       /*purge cmd ctx that refer a2mp_conn*/
+       read_lock(&ampmgr.contr_list.lock);
+       list_for_each(p, &ampmgr.contr_list.head) {
+               amp_contr = list_entry(p, struct amp_controller, list);
+
+               write_lock(&amp_contr->context_q.lock);
+               list_for_each_safe(q, n, &amp_contr->context_q.head) {
+                       ctx = list_entry(q, struct cmd_context, list);
+                       if (ctx->a2mp_conn == a2mp_conn) {
+                               list_del(&ctx->list);
+                               kfree(ctx);
+                       }
+               }
+               write_unlock(&amp_contr->context_q.lock);
+       }
+       read_unlock(&ampmgr.contr_list.lock);
+
+       if (a2mp_conn->discov_state & DISCOVERY_REQ_SENT)
+               del_timer(&a2mp_conn->discov_timer);
+
+       amp_a2mp_conn_unlink(&ampmgr.a2mp_list, a2mp_conn);
+       kfree(a2mp_conn);
+       conn->amp_handle = NULL;
+       BT_DBG("exit");
+       return ;
+}
+
+/* a simple implememt of amp_notify */
+void amp_notify(struct l2cap_conn *conn, u8 cmd, void * hci_link)
+{
+       struct a2mp_conn *a2mp_conn = conn->amp_handle;
+       struct l2cap_a2mp_packet *send;
+       struct amp_phy_link *phy_link = NULL;
+       struct list_head *p;
+
+       BT_DBG("cmd 0x%4.4x", cmd);
+
+       switch (cmd) {
+       case AMP_HS_REQUEST:
+               atomic_inc(&a2mp_conn->req_cnt);
+               if ((atomic_read(&a2mp_conn->req_cnt) > 0)
+                   && (a2mp_conn->contr_state == AMP_CONTR_AVAIL)
+                   && (ampmgr.contr_state == AMP_CONTR_AVAIL)) {
+                       u8 local_ctrlid, remote_ctrlid;
+
+                       local_ctrlid = amp_select_local_contr_id();
+                       remote_ctrlid = amp_select_remote_contr_id(a2mp_conn);
+                       amp_phy_link_add(a2mp_conn, local_ctrlid, remote_ctrlid);
+               } else {
+                       if (a2mp_conn->contr_state == AMP_CONTR_UNKNOWN) {
+                               struct a2mp_discover_req req;
+
+                               req.mtu = cpu_to_le16(AMP_DEFAULT_MTU);
+                               req.ext_feature_mask = cpu_to_le16(AMP_DEFAULT_EXT_FEAT_MASK);
+
+                               mod_timer(&a2mp_conn->discov_timer, jiffies +
+                                       msecs_to_jiffies(AMP_DISCOV_TIMEOUT));
+
+                               a2mp_conn->discov_state |= DISCOVERY_REQ_SENT;
+
+                               send = amp_build_cmd(a2mp_conn, AMP_DISCOVER_REQ,
+                                               amp_get_ident(a2mp_conn), sizeof(struct a2mp_discover_req), &req);
+                               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+                               kfree(send);
+                       }
+               }
+               break;
+       case AMP_HS_CANCEL:
+               /*only exist one phy link in creator progress*/
+               phy_link = amp_get_creator_progress_phy_link(a2mp_conn);
+               if (phy_link) {
+                       a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+                       amp_disc_phy_link(a2mp_conn, phy_link);
+               } else {
+                       if (a2mp_conn->discov_state & DISCOVERY_REQ_SENT)
+                               del_timer(&a2mp_conn->discov_timer);
+                       atomic_dec(&a2mp_conn->req_cnt);
+               }
+               break;
+       case AMP_HS_DISC:
+               /*this disc notify only receive when phy link connected*/
+               read_lock(&a2mp_conn->phy_link_list.lock);
+               list_for_each(p, &a2mp_conn->phy_link_list.head) {
+                       phy_link = list_entry(p, struct amp_phy_link, per_conn_list);
+                       if (phy_link->hci_link == hci_link)
+                               break;
+               }
+               read_unlock(&a2mp_conn->phy_link_list.lock);
+
+               if ((!phy_link) || (phy_link->hci_link != hci_link)) {
+                       BT_ERR("can't find match phy_link with specify notify");
+                       return;
+               }
+
+               /* Disconnect Physical Link request is an optional request*/
+#if 0
+               req.local_ctrl_id = phy_link->local_ctrl_id;
+               req.remote_ctrl_id = phy_link->remote_ctrl_id;
+
+               phy_link->state = PHY_LINK_DISC_REQ_SENT;
+
+               amp_set_a2mp_timer(phy_link, AMP_RESPONSE_TIMEOUT);
+
+               phy_link->identify = amp_get_ident(a2mp_conn);
+
+               send = amp_build_cmd(a2mp_conn, AMP_DISC_PHY_LINK_REQ, phy_link->identify,
+                                       sizeof(struct a2mp_disc_phy_link_req), &req);
+               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+               kfree(send);
+#endif
+               /* notify l2cap only connected phylink*/
+               if (phy_link->state == PHY_LINK_CONNECTED)
+                       l2cap_phylink_update(a2mp_conn->conn, L2CAP_PHYLINK_NOAVL, phy_link->hci_link);
+               amp_disc_phy_link(a2mp_conn, phy_link);
+               break;
+       default:
+               break;
+       }
+
+       return;
+}
+
+/* nothing to do in cmd rej?? */
+static int amp_command_rej(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       BT_DBG("command rej, ident %d", cmd->ident);
+       return 0;
+}
+
+static int amp_discover_req(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_discover_req *req = (struct a2mp_discover_req *)data;
+       struct list_head *p;
+       struct amp_controller *amp_contr;
+       u8  j = 0;
+       u16 mtu;
+
+       mtu = __le16_to_cpu(req->mtu);
+
+       BT_DBG("mtu 0x%4.4x", mtu);
+
+       if (mtu < AMP_DEFAULT_MTU)
+               return -1;
+
+       a2mp_conn->discov_state |= DISCOVERY_REQ_RECV;
+       a2mp_conn->mtu = mtu;
+       a2mp_conn->feat_mask = __le16_to_cpu(req->ext_feature_mask);
+
+       read_lock(&ampmgr.contr_list.lock);
+       list_for_each(p, &ampmgr.contr_list.head) {
+               amp_contr = list_entry(p, struct amp_controller, list);
+               if (amp_contr->info.status == AMP_CONTR_CAP_UNINITIALIZE) {
+                       struct cmd_context *ctx;
+
+                       ctx = kzalloc(sizeof(struct cmd_context), GFP_ATOMIC);
+                       if (!ctx) {
+                               BT_ERR("mm alloc fail in amp_discover_req");
+                               read_unlock(&ampmgr.contr_list.lock);
+                               return 0;
+                       }
+                       j++;
+                       ctx->type = PENDING_REMOTE_SIGNAL;
+                       ctx->code = AMP_DISCOVER_REQ;
+                       ctx->identify = cmd->ident;
+                       ctx->cmd = HCI_OP_READ_LOCAL_COMMANDS;
+                       ctx->a2mp_conn = a2mp_conn;
+
+                       amp_ctx_list_link(&amp_contr->context_q, ctx);
+                       hci_read_local_amp_info(amp_contr->dev);
+               }
+
+       }
+       read_unlock(&ampmgr.contr_list.lock);
+
+       /*send discover rsp signal, no need to query controller status via HCI command*/
+       if (j == 0) {
+               struct l2cap_a2mp_packet *send;
+               u8 rsp[64], len;
+
+               len = amp_build_discover_rsp(a2mp_conn, rsp);
+               send = amp_build_cmd(a2mp_conn, AMP_DISCOVER_RSP, cmd->ident, len, rsp);
+               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+               a2mp_conn->discov_state |= DISOCVERY_RSP_SENT;
+               kfree(send);
+       }
+
+       return 0;
+}
+
+static int amp_discover_rsp(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_discover_rsp *rsp = (struct a2mp_discover_rsp *)data;
+       struct controller_array *remote;
+       u8 count = 0, i = 0;
+       u8 *buffer = rsp->data;
+       u16 mtu;
+
+       mtu = __le16_to_cpu(rsp->mtu);
+       BT_DBG("mtu 0x%4.4x", mtu);
+
+       del_timer(&a2mp_conn->discov_timer);
+       a2mp_conn->discov_state |= DISCOVERY_RSP_RECV;
+
+       if (mtu < AMP_DEFAULT_MTU) {
+               BT_DBG("response mtu < AMP_MTU ");
+               return -1;
+       }
+
+       a2mp_conn->mtu = mtu;
+       a2mp_conn->feat_mask = __le16_to_cpu(rsp->ext_feature_mask);
+       count = (__le16_to_cpu(cmd->len) - sizeof(struct a2mp_discover_rsp))/3;
+
+       if (a2mp_conn->remote)
+               kfree(a2mp_conn->remote);
+
+       a2mp_conn->contr_state = AMP_CONTR_UNAVAIL;
+       remote = kzalloc((sizeof(struct controller_array) + sizeof(struct controller_info)*(count-1)),
+                               GFP_ATOMIC);
+
+       if (!remote)
+               return 0;
+       /*skip BR/EDR controller*/
+       buffer += 3;
+       remote->size = count-1;
+       for (i = 0; i < count-1; i++) {
+               remote->contr[i].id = *buffer;
+               remote->contr[i].type = *(buffer + 1);
+               remote->contr[i].status = *(buffer + 2);
+
+               if (remote->contr[i].type != HCI_BREDR)
+                       a2mp_conn->contr_state = AMP_CONTR_AVAIL;
+
+               buffer += 3;
+       }
+
+       a2mp_conn->remote = remote;
+
+       if ((atomic_read(&a2mp_conn->req_cnt) > 0)
+               && (a2mp_conn->contr_state == AMP_CONTR_AVAIL)
+               && (ampmgr.contr_state == AMP_CONTR_AVAIL)) {
+                       u8 local_ctrlid, remote_ctrlid;
+
+                       local_ctrlid = amp_select_local_contr_id();
+                       remote_ctrlid = amp_select_remote_contr_id(a2mp_conn);
+                       amp_phy_link_add(a2mp_conn, local_ctrlid, remote_ctrlid);
+       }
+
+       return 0;
+}
+
+static int amp_change_notify(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_change_notify *notify = (struct a2mp_change_notify *)data;
+       struct l2cap_a2mp_packet *send;
+       struct controller_array *remote;
+       u8 count = 0, i = 0;
+       u8 *buffer = notify->data;
+
+       count = (__le16_to_cpu(cmd->len) - sizeof(struct a2mp_change_notify))/3;
+
+       BT_DBG("contr count include br/edr is %d", count);
+
+       if (a2mp_conn->remote)
+               kfree(a2mp_conn->remote);
+
+       a2mp_conn->contr_state = AMP_CONTR_UNAVAIL;
+       remote = kzalloc((sizeof(struct controller_array) +
+                               sizeof(struct controller_info)*(count-1)), GFP_ATOMIC);
+       if (!remote)
+               return 0;
+       buffer += 3;
+       remote->size = count-1;
+       for (i = 0; i < count-1; i++) {
+               remote->contr[i].id = *buffer;
+               remote->contr[i].type = *(buffer + 1);
+               remote->contr[i].status = *(buffer + 2);
+
+               if (remote->contr[i].type != HCI_BREDR) {
+                       /* fix me, AMP_CONTR_AVAIL means exists amp controller?? */
+                       a2mp_conn->contr_state = AMP_CONTR_AVAIL;
+               }
+               buffer += 3;
+       }
+
+       a2mp_conn->remote = remote;
+       if ((atomic_read(&a2mp_conn->req_cnt) > 0)
+               && (a2mp_conn->contr_state == AMP_CONTR_AVAIL)
+               && (ampmgr.contr_state == AMP_CONTR_AVAIL)) {
+                       u8 local_ctrlid, remote_ctrlid;
+
+                       local_ctrlid = amp_select_local_contr_id();
+                       remote_ctrlid = amp_select_remote_contr_id(a2mp_conn);
+                       amp_phy_link_add(a2mp_conn, local_ctrlid, remote_ctrlid);
+       }
+
+       /* send notify rsp*/
+       send = amp_build_cmd(a2mp_conn, AMP_CHANGE_RSP, cmd->ident, 0, NULL);
+       l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+       kfree(send);
+
+       return 0;
+}
+
+/*nothing to do here????*/
+static int amp_change_rsp(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       BT_DBG("change rsp");
+       return 0;
+}
+
+static int amp_info_req(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_info_req *req = (struct a2mp_info_req *)data;
+       struct cmd_context *ctx;
+       struct amp_controller *amp_contr;
+
+       BT_DBG("ctrl id 0x%4.4x", req->ctrl_id);
+
+       amp_contr = amp_get_contr_by_id(req->ctrl_id);
+
+       if (!amp_contr) {
+               struct l2cap_a2mp_packet *send;
+               struct a2mp_info_rsp rsp;
+
+               rsp.ctrl_id = req->ctrl_id;
+               rsp.status = AMP_STATUS_INVALID_CONTROLLER_ID;
+
+               send = amp_build_cmd(a2mp_conn, AMP_INFO_RSP, cmd->ident,
+                                       sizeof(struct a2mp_info_rsp), &rsp);
+               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+               kfree(send);
+               goto exit;
+       }
+       ctx = kzalloc(sizeof(struct cmd_context), GFP_ATOMIC);
+       if (!ctx) {
+               BT_ERR("mm alloc fail in amp_info_req");
+               return 0;
+       }
+
+       ctx->type = PENDING_REMOTE_SIGNAL;
+       ctx->code = AMP_INFO_REQ;
+       ctx->identify = cmd->ident;
+       ctx->cmd = HCI_OP_READ_LOCAL_COMMANDS;
+       ctx->a2mp_conn = a2mp_conn;
+       amp_ctx_list_link(&amp_contr->context_q, ctx);
+       hci_read_local_amp_info(amp_contr->dev);
+exit:
+       return 0;
+}
+
+static int amp_info_rsp(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_info_rsp *rsp = (struct a2mp_info_rsp *)data;
+       struct controller_array *remote = a2mp_conn->remote;
+       struct amp_phy_link *phy_link;
+       u8 i;
+
+       BT_DBG("ctrl id 0x%x, rsp status 0x%x", rsp->ctrl_id, rsp->status);
+
+       phy_link = amp_get_phylink_by_iden(a2mp_conn, cmd->ident);
+       if (!phy_link) {
+               BT_DBG("can't find match phylink ");
+               return 0;
+       }
+
+       amp_clear_a2mp_timer(phy_link);
+
+       switch (rsp->status) {
+       case AMP_STATUS_OK:
+               for (i = 0; i < remote->size; i++) {
+                       if (remote->contr[i].id == rsp->ctrl_id) {
+                               remote->contr[i].total_bandwidth = __le32_to_cpu(rsp->total_bandwidth);
+                               remote->contr[i].max_bandwidth = __le32_to_cpu(rsp->max_bandwidth);
+                               remote->contr[i].min_latency = __le32_to_cpu(rsp->min_latency);
+                               remote->contr[i].pal_capability = __le16_to_cpu(rsp->pal_capability);
+                               remote->contr[i].amp_assoc_size = __le16_to_cpu(rsp->amp_assoc_size);
+                               break;
+                       }
+               }
+               if (phy_link->state == PHY_LINK_INFO_REQ_SENT) {
+                       struct a2mp_assoc_req req;
+                       struct l2cap_a2mp_packet *send;
+
+                       phy_link->identify = amp_get_ident(a2mp_conn);
+                       req.ctrl_id = rsp->ctrl_id;
+                       send = amp_build_cmd(a2mp_conn, AMP_ASSOC_REQ, phy_link->identify,
+                               sizeof(struct a2mp_assoc_req), &req);
+                       if (!send)
+                               return 0;
+                       l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+                       kfree(send);
+                       amp_set_a2mp_timer(phy_link, AMP_RESPONSE_TIMEOUT);
+                       phy_link->state = PHY_LINK_ASSOC_REQ_SENT;
+               }
+               break;
+       case AMP_STATUS_INVALID_CONTROLLER_ID:
+               amp_disc_phy_link(a2mp_conn, phy_link);
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+static int amp_assoc_req(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_assoc_req *req = (struct a2mp_assoc_req *)data;
+       struct cmd_context *ctx;
+       struct amp_controller *amp_contr;
+
+       BT_DBG("ctrl id 0x%4.4x", req->ctrl_id);
+
+       amp_contr = amp_get_contr_by_id(req->ctrl_id);
+
+       if (!amp_contr) {
+               struct l2cap_a2mp_packet *send;
+               struct a2mp_assoc_rsp rsp;
+
+               rsp.ctrl_id = req->ctrl_id;
+               rsp.status = AMP_STATUS_INVALID_CONTROLLER_ID;
+
+               send = amp_build_cmd(a2mp_conn, AMP_ASSOC_RSP, cmd->ident,
+                                       sizeof(struct a2mp_assoc_rsp), &rsp);
+               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+               kfree(send);
+               goto exit;
+       }
+
+       ctx = kzalloc(sizeof(struct cmd_context), GFP_ATOMIC);
+       if (!ctx) {
+               BT_ERR("mm alloc fail in amp_assoc_req");
+               return 0;
+       }
+
+       ctx->type = PENDING_REMOTE_SIGNAL;
+       ctx->code = AMP_ASSOC_REQ;
+       ctx->identify = cmd->ident;
+       ctx->cmd = HCI_OP_READ_LOCAL_AMP_ASSOC;
+       ctx->a2mp_conn = a2mp_conn;
+       amp_ctx_list_link(&amp_contr->context_q, ctx);
+       hci_read_local_amp_assoc(amp_contr->dev);
+exit:
+       return 0;
+}
+
+static int amp_assoc_rsp(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_assoc_rsp *rsp = (struct a2mp_assoc_rsp *)data;
+       struct amp_phy_link *phy_link;
+
+       BT_DBG("ctrl id 0x%x, rsp status 0x%x", rsp->ctrl_id, rsp->status);
+       phy_link = amp_get_phylink_by_iden(a2mp_conn, cmd->ident);
+       if (!phy_link) {
+               BT_DBG("can't find match phylink ");
+               return 0;
+       }
+       amp_clear_a2mp_timer(phy_link);
+       switch (rsp->status) {
+       case AMP_STATUS_OK:
+               if (phy_link->state == PHY_LINK_ASSOC_REQ_SENT) {
+                       struct amp_controller *amp_contr = amp_get_contr_by_id(phy_link->local_ctrl_id);
+                       struct cmd_context *ctx = kzalloc(sizeof(struct cmd_context), GFP_ATOMIC);
+                       struct amp_link_key dedicated_key = {.key_len = HCI_MAX_AMP_KEY_SIZE};
+                       struct hci_conn *hcon = a2mp_conn->conn->hcon;
+                       __u8 amp_type = amp_contr->dev->dev_type;
+
+                       phy_link->handle = amp_get_phy_handle();
+                       if (!ctx) {
+                               BT_ERR("null pointer in amp_assoc_rsp");
+                               return 0;
+                       }
+                       ctx->type = PENDING_REMOTE_SIGNAL;
+                       ctx->code = AMP_ASSOC_RSP;
+                       ctx->identify = cmd->ident;
+                       ctx->cmd = HCI_OP_CREATE_PHYSICAL_LINK;
+                       ctx->a2mp_conn = a2mp_conn;
+                       ctx->handle = phy_link->handle;
+                       amp_ctx_list_link(&amp_contr->context_q, ctx);
+
+                       if (!a2mp_conn->dedicated_lk[amp_type-1].valid) {
+
+                               if (!(a2mp_conn->status & GAMP_LK_VALID)) {
+                                       amp_create_generic_link_key(hcon->link_key,
+                                                               a2mp_conn->gamp_lk);
+                                       a2mp_conn->status |= GAMP_LK_VALID;
+                               }
+                               dedicated_key.key_type = hcon->key_type;
+                               amp_create_dedicated_link_key(a2mp_conn->gamp_lk,
+                                       hcon->key_type, dedicated_key.key);
+                               a2mp_conn->status |= REGENERATE_GAMP_LK;
+                               a2mp_conn->dedicated_lk[amp_type-1].key = dedicated_key;
+                       } else {
+                               dedicated_key = a2mp_conn->dedicated_lk[amp_type-1].key;
+                       }
+
+                       phy_link->hci_link = hci_phylink_create(amp_contr->dev, phy_link->handle,
+                                               &dedicated_key, rsp->assoc, (__le16_to_cpu(cmd->len) - 2),
+                                               hcon);
+                       phy_link->state = PHY_LINK_HCI_CREATE_SENT;
+               }
+               break;
+       case AMP_STATUS_INVALID_CONTROLLER_ID:
+               amp_disc_phy_link(a2mp_conn, phy_link);
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+static int amp_create_phy_link_req(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_phy_link_req *req = (struct a2mp_phy_link_req *)data;
+       struct amp_link_key dedicated_key = {.key_len = HCI_MAX_AMP_KEY_SIZE};
+       struct hci_conn *hcon = a2mp_conn->conn->hcon;
+       struct cmd_context *ctx;
+       struct amp_phy_link *phy_link = NULL;
+       struct amp_controller *amp_contr;
+       struct l2cap_a2mp_packet *send;
+       struct a2mp_phy_link_rsp rsp;
+       __u8 amp_type;
+
+       BT_DBG("remote id 0x%4.4x,local ctrl id 0x%4.4x",
+                       req->local_ctrl_id, req->remote_ctrl_id);
+
+       amp_contr = amp_get_contr_by_id(req->remote_ctrl_id);
+       amp_type = amp_contr->dev->dev_type;
+
+       if (!amp_contr) {
+               rsp.local_ctrl_id = req->remote_ctrl_id;
+               rsp.remote_ctrl_id = req->local_ctrl_id;
+               rsp.status = AMP_STATUS_INVALID_CONTROLLER_ID;
+
+               send = amp_build_cmd(a2mp_conn, AMP_CREATE_PHY_LINK_RSP, cmd->ident,
+                                       sizeof(struct a2mp_phy_link_rsp), &rsp);
+               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+               kfree(send);
+               goto exit;
+       }
+
+       /* collision resolve */
+       if (a2mp_conn->amp_role == AMP_ROLE_CREATOR) {
+               if (amp_collision_resolution(a2mp_conn->conn->src, a2mp_conn->conn->dst)) {
+                       BT_DBG("collison resolve to be winner");
+                       /* winner to be creator, send collision occured phy link rsp to remote*/
+                       rsp.local_ctrl_id = req->remote_ctrl_id;
+                       rsp.remote_ctrl_id = req->local_ctrl_id;
+                       rsp.status = AMP_STATUS_COLLISION_OCCURRED;
+
+                       send = amp_build_cmd(a2mp_conn, AMP_CREATE_PHY_LINK_RSP,
+                                               cmd->ident, sizeof(struct a2mp_phy_link_rsp), &rsp);
+                       l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+                       kfree(send);
+                       /* no need to progress*/
+                       goto exit;
+               } else {
+                       /* here lose to be creator, need exit previous creating progress*/
+                       /*only exist one phy link in creator progress*/
+                       BT_DBG("collison resolve to be loser");
+                       phy_link = amp_get_creator_progress_phy_link(a2mp_conn);
+                       if (phy_link) {
+                               a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+                               amp_disc_phy_link(a2mp_conn, phy_link);
+                       }
+               }
+       }
+
+       /*normal flow, respondor receive phy link req, send hci_accept*/
+       phy_link = kzalloc(sizeof(struct amp_phy_link), GFP_ATOMIC);
+       if (!phy_link)
+               return 0;
+       phy_link->local_ctrl_id = req->remote_ctrl_id;
+       phy_link->remote_ctrl_id = req->local_ctrl_id;
+       phy_link->handle = amp_get_phy_handle();
+       phy_link->a2mp_conn = a2mp_conn;
+       phy_link->local = amp_contr;
+
+       amp_a2mp_phylink_link(&a2mp_conn->phy_link_list, phy_link);
+       amp_contr_phylink_link(&amp_contr->phy_link_list, phy_link);
+
+       setup_timer(&phy_link->a2mp_timer, amp_a2mp_timeout,
+                                               (unsigned long) phy_link);
+       setup_timer(&phy_link->timer, amp_phylink_timeout,
+                                               (unsigned long) phy_link);
+
+       amp_set_phylink_timer(phy_link, AMP_PHY_LINK_TIMEOUT);
+
+       ctx = kzalloc(sizeof(struct cmd_context), GFP_ATOMIC);
+       if (!ctx)
+               return 0;
+       ctx->type = PENDING_REMOTE_SIGNAL;
+       ctx->code = AMP_CREATE_PHY_LINK_REQ;
+       ctx->identify = cmd->ident;
+       ctx->cmd = HCI_OP_CREATE_PHYSICAL_LINK;
+       ctx->a2mp_conn = a2mp_conn;
+       ctx->handle = phy_link->handle;
+       amp_ctx_list_link(&amp_contr->context_q, ctx);
+
+       if (!a2mp_conn->dedicated_lk[amp_type-1].valid) {
+
+               if (!(a2mp_conn->status & GAMP_LK_VALID)) {
+                       amp_create_generic_link_key(hcon->link_key,
+                                               a2mp_conn->gamp_lk);
+                       a2mp_conn->status |= GAMP_LK_VALID;
+               }
+               dedicated_key.key_type = hcon->key_type;
+               amp_create_dedicated_link_key(a2mp_conn->gamp_lk,
+                       hcon->key_type, dedicated_key.key);
+               a2mp_conn->status |= REGENERATE_GAMP_LK;
+               a2mp_conn->dedicated_lk[amp_type-1].key = dedicated_key;
+       } else {
+               dedicated_key = a2mp_conn->dedicated_lk[amp_type-1].key;
+       }
+
+       phy_link->hci_link = hci_phylink_accept(amp_contr->dev, phy_link->handle, &dedicated_key,
+                                               req->assoc, (__le16_to_cpu(cmd->len) - 2), hcon);
+       phy_link->state = PHY_LINK_HCI_ACCEPT_SENT;
+
+exit:
+       return 0;
+}
+
+static int amp_create_phy_link_rsp(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_phy_link_rsp *rsp = (struct a2mp_phy_link_rsp *)data;
+       struct amp_phy_link *phy_link;
+
+       BT_DBG("local ctrl id 0x%4.4x,remote id 0x%4.4x, status 0x%4.4x",
+                       rsp->local_ctrl_id, rsp->remote_ctrl_id, rsp->status);
+
+       phy_link = amp_get_phylink_by_iden(a2mp_conn, cmd->ident);
+
+       if (!phy_link) {
+               BT_DBG("can't find match phylink ");
+               return 0;
+       }
+
+       amp_clear_a2mp_timer(phy_link);
+
+       switch (rsp->status) {
+       case AMP_STATUS_OK:
+               if (phy_link->state == PHY_LINK_CREATE_REQ_SENT) {
+                       if (phy_link->flag == PHY_LINK_MAC_READY) {
+                               phy_link->state = PHY_LINK_CONNECTED;
+                               a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+                               amp_clear_phylink_timer(phy_link);
+                               atomic_dec(&a2mp_conn->req_cnt);
+                               l2cap_phylink_update(a2mp_conn->conn,
+                                       L2CAP_PHYLINK_READY, phy_link->hci_link);
+                       } else {
+                               phy_link->state = PHY_LINK_CREATE_RSP_RECV;
+                       }
+               }
+               break;
+       case AMP_STATUS_INVALID_CONTROLLER_ID:
+       case AMP_STATUS_UNABLE_TO_CREATE_LINK:
+       case AMP_STATUS_COLLISION_OCCURRED:
+       case AMP_STATUS_DISC_PACKET_RECV:
+       case AMP_STATUS_PHYSICAL_LINK_EXIST:
+       case AMP_STATUS_INSUFFICIENT_SECURITY:
+               a2mp_conn->amp_role = AMP_ROLE_RESPONDER;
+               amp_disc_phy_link(a2mp_conn, phy_link);
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+static int amp_disc_phy_link_req(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_disc_phy_link_req *req = (struct a2mp_disc_phy_link_req *)data;
+       struct amp_phy_link *phy_link = NULL;
+       struct l2cap_a2mp_packet *send;
+       struct cmd_context *ctx;
+       struct a2mp_disc_phy_link_rsp rsp;
+
+       BT_DBG("remote ctrl id 0x%4.4x,local ctrl id 0x%4.4x", req->local_ctrl_id, req->remote_ctrl_id);
+
+       phy_link = amp_get_phylink_by_ctrlid(a2mp_conn, req->remote_ctrl_id, req->local_ctrl_id);
+       if (!phy_link) {
+               BT_DBG("can't disc inexist phy link");
+               rsp.local_ctrl_id = req->remote_ctrl_id;
+               rsp.remote_ctrl_id = req->local_ctrl_id;
+               rsp.status = AMP_STATUS_NO_PHYSICAL_LINK;
+               send = amp_build_cmd(a2mp_conn, AMP_DISC_PHY_LINK_RSP, cmd->ident,
+                                       sizeof(struct a2mp_disc_phy_link_rsp), &rsp);
+               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+               kfree(send);
+               goto exit;
+       } else {
+               /* receive a create phy_link req, not send rsp yet, here can send a create phy_link rsp
+                * with "Failed - AMP Disconnected Physical Link Request packet received"
+                */
+               struct amp_controller *amp_contr = phy_link->local;
+
+               if (phy_link->state == PHY_LINK_HCI_ACCEPT_SENT) {
+                       struct list_head *p, *n;
+
+                       /* remove queue AMP_CREATE_PHY_LINK_REQ ctx, and send create phy link rsp, with fail*/
+                       write_lock(&amp_contr->context_q.lock);
+                       list_for_each_safe(p, n, &amp_contr->context_q.head) {
+                               ctx = list_entry(p, struct cmd_context, list);
+                               if ((ctx->code == AMP_CREATE_PHY_LINK_REQ)
+                                       && (ctx->handle == phy_link->handle)) {
+                                       struct a2mp_phy_link_rsp rsp;
+
+                                       rsp.local_ctrl_id = phy_link->local_ctrl_id;
+                                       rsp.remote_ctrl_id = phy_link->remote_ctrl_id;
+                                       rsp.status = AMP_STATUS_DISC_PACKET_RECV;
+
+                                       send = amp_build_cmd(ctx->a2mp_conn, AMP_CREATE_PHY_LINK_RSP,
+                                                       ctx->identify, sizeof(struct a2mp_phy_link_rsp), &rsp);
+                                       l2cap_a2mp_send_cmd(ctx->a2mp_conn->conn, send);
+                                       phy_link->state = PHY_LINK_CREATE_RSP_SENT;
+                                       kfree(send);
+
+                                       list_del(&ctx->list);
+                                       kfree(ctx);
+                               }
+                       }
+                       write_unlock(&amp_contr->context_q.lock);
+               }
+
+               /*send disc phy link rsp here*/
+               rsp.local_ctrl_id = phy_link->local_ctrl_id;
+               rsp.remote_ctrl_id = phy_link->remote_ctrl_id;
+               rsp.status = AMP_STATUS_OK;
+
+               send = amp_build_cmd(a2mp_conn, AMP_DISC_PHY_LINK_RSP, cmd->ident,
+                                       sizeof(struct a2mp_disc_phy_link_rsp), &rsp);
+               l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+               kfree(send);
+
+               /* disc phy link*/
+               l2cap_phylink_update(a2mp_conn->conn, L2CAP_PHYLINK_NOAVL, phy_link->hci_link);
+               amp_disc_phy_link(a2mp_conn, phy_link);
+       }
+exit:
+       return 0;
+}
+
+static int amp_disc_phy_link_rsp(struct a2mp_conn *a2mp_conn, struct a2mp_cmd_hdr *cmd, u8 *data)
+{
+       struct a2mp_disc_phy_link_rsp *rsp = (struct a2mp_disc_phy_link_rsp *)data;
+       struct amp_phy_link *phy_link;
+
+       BT_DBG("ctrl id 0x%4.4x,id 0x%4.4x, rsp status 0x%4.4x",
+               rsp->local_ctrl_id, rsp->remote_ctrl_id, rsp->status);
+
+       phy_link = amp_get_phylink_by_iden(a2mp_conn, cmd->ident);
+       if (!phy_link) {
+               BT_DBG("can't find match phylink ");
+               return 0;
+       }
+       amp_clear_a2mp_timer(phy_link);
+       switch (rsp->status) {
+       case AMP_STATUS_OK:
+               if (phy_link->state == PHY_LINK_DISC_REQ_SENT)
+                       phy_link->state = PHY_LINK_DISC_RSP_RECV;
+               break;
+       case AMP_STATUS_INVALID_CONTROLLER_ID:
+       case AMP_STATUS_NO_PHYSICAL_LINK:
+               amp_disc_phy_link(a2mp_conn, phy_link);
+               break;
+       default:
+               break;
+       }
+
+       return 0;
+}
+
+void  amp_a2mp_process(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+       struct a2mp_conn *a2mp_conn = (struct a2mp_conn *)conn->amp_handle;
+       struct a2mp_cmd_hdr cmd;
+       u8 *data = skb->data;
+       int len = skb->len;
+       int err = 0;
+
+       while (len >= AMP_CMD_HDR_LENGTH) {
+               u16 cmd_len;
+               memcpy(&cmd, data, AMP_CMD_HDR_LENGTH);
+               data += AMP_CMD_HDR_LENGTH;
+               len  -= AMP_CMD_HDR_LENGTH;
+
+               cmd_len = le16_to_cpu(cmd.len);
+
+               BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd_len, cmd.ident);
+
+               if (cmd_len > len || !cmd.ident) {
+                       BT_DBG("corrupted command");
+                       break;
+               }
+
+               switch (cmd.code) {
+               case AMP_COMMAND_REJ:
+                       amp_command_rej(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_DISCOVER_REQ:
+                       err = amp_discover_req(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_DISCOVER_RSP:
+                       err = amp_discover_rsp(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_CHANGE_NOTIFY:
+                       err = amp_change_notify(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_CHANGE_RSP:
+                       err = amp_change_rsp(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_INFO_REQ:
+                       err = amp_info_req(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_INFO_RSP:
+                       err = amp_info_rsp(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_ASSOC_REQ:
+                       err = amp_assoc_req(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_ASSOC_RSP:
+                       err = amp_assoc_rsp(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_CREATE_PHY_LINK_REQ:
+                       err = amp_create_phy_link_req(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_CREATE_PHY_LINK_RSP:
+                       err = amp_create_phy_link_rsp(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_DISC_PHY_LINK_REQ:
+                       err = amp_disc_phy_link_req(a2mp_conn, &cmd, data);
+                       break;
+
+               case AMP_DISC_PHY_LINK_RSP:
+                       err = amp_disc_phy_link_rsp(a2mp_conn, &cmd, data);
+                       break;
+
+               default:
+                       BT_ERR("Unknown signaling command 0x%2.2x", cmd.code);
+                       err = -EINVAL;
+                       break;
+               }
+
+               if (err) {
+                       struct l2cap_a2mp_packet *send;
+                       struct a2mp_cmd_rej rej;
+
+                       rej.reason = cpu_to_le16(0);
+                       send = amp_build_cmd(a2mp_conn, AMP_COMMAND_REJ, cmd.ident, sizeof(struct a2mp_cmd_rej), &rej);
+                       l2cap_a2mp_send_cmd(a2mp_conn->conn, send);
+                       kfree(send);
+               }
+
+               data += cmd_len;
+               len  -= cmd_len;
+       }
+
+       kfree_skb(skb);
+
+       return;
+}
--
1.6.3.3

