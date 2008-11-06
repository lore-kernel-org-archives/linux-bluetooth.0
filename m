Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Netlink patch.
From: Alok <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-koN6P/QcUS9aN/wJeuZ7"
Date: Thu, 06 Nov 2008 19:20:17 +0530
Message-Id: <1225979417.15398.13.camel@greatbear>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-koN6P/QcUS9aN/wJeuZ7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel, 

Attaching a patch which implements a generic netlink command
GET_DEVLIST(HCIGETDEVLIST). 
 
1. Will the netlink plugin expose an API like 
int hci_get_devlist(struct hci_dev_list_req *dl) ? 

2. If netlink registration fails would we fallback to raw sockets in the
plugin ?

Let me know if anything in the patch needs modification. 

Thanks, 
Alok.

--=-koN6P/QcUS9aN/wJeuZ7
Content-Disposition: attachment; filename=0001-Adding-netlink-support-to-bluetooth.patch
Content-Type: application/mbox; name=0001-Adding-netlink-support-to-bluetooth.patch
Content-Transfer-Encoding: 7bit

>From 6033fdc20d549e8b67dea76e3a644fd0d4a7e1d9 Mon Sep 17 00:00:00 2001
From: Alok Barsode <alok.barsode@azingo.com>
Date: Thu, 6 Nov 2008 17:33:05 +0530
Subject: [PATCH] Adding netlink support to bluetooth.
 Adding files netlink.c and netlink.h to net/bluetooth for netlink support.
 Adding support for GET_DEVLIST.

Signed-off-by: Alok Barsode <alok.barsode@azingo.com>
---
 include/net/bluetooth/bluetooth.h |    3 +
 net/bluetooth/Makefile            |    2 +-
 net/bluetooth/af_bluetooth.c      |    6 ++
 net/bluetooth/netlink.c           |  122 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/netlink.h           |   30 +++++++++
 5 files changed, 162 insertions(+), 1 deletions(-)
 create mode 100644 net/bluetooth/netlink.c
 create mode 100644 net/bluetooth/netlink.h

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 6f8418b..b02c7aa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -178,4 +178,7 @@ extern void bt_sysfs_cleanup(void);
 
 extern struct class *bt_class;
 
+extern int nlbluetooth_init(void);
+extern void nlbluetooth_cleanup(void);
+
 #endif /* __BLUETOOTH_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index d1e433f..f014d48 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_BT_BNEP)	+= bnep/
 obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
 
-bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o
+bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o netlink.o
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 8907eff..b6487dc 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -436,6 +436,10 @@ static int __init bt_init(void)
 	if (err < 0)
 		return err;
 
+	err = nlbluetooth_init();
+	if (err < 0)
+		return err;
+
 	err = sock_register(&bt_sock_family_ops);
 	if (err < 0) {
 		bt_sysfs_cleanup();
@@ -456,6 +460,8 @@ static void __exit bt_exit(void)
 	sock_unregister(PF_BLUETOOTH);
 
 	bt_sysfs_cleanup();
+
+	nlbluetooth_cleanup();
 }
 
 subsys_initcall(bt_init);
diff --git a/net/bluetooth/netlink.c b/net/bluetooth/netlink.c
new file mode 100644
index 0000000..1739bf0
--- /dev/null
+++ b/net/bluetooth/netlink.c
@@ -0,0 +1,122 @@
+/*
+ * This is the netlink-based bluetooth interface.
+ *
+ * Copyright 2008 Alok Barsode <alok.barsode@azingo.com>
+ */
+
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <asm/unaligned.h>
+  
+#include <net/genetlink.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include "netlink.h"
+
+/* family definition */
+static struct genl_family nlbluetooth_fam = {
+	.id = GENL_ID_GENERATE,
+	.hdrsize = 0,
+	.name = "bluetooth",
+	.version = VERSION,
+	.maxattr = NLBLUETOOTH_ATTR_MAX
+};
+
+static struct nla_policy nlbluetooth_policy[NLBLUETOOTH_ATTR_MAX + 1] = {
+	[NLBLUETOOTH_ATTR_DEVID] = { .type = NLA_U16 },
+	[NLBLUETOOTH_ATTR_DEVNUM] = { .type = NLA_U16 },
+	[NLBLUETOOTH_ATTR_DEVOPT] = { .type = NLA_U32 },
+	[NLBLUETOOTH_ATTR_DEVLIST] = { .type = NLA_NESTED },
+};
+
+static int nlbluetooth_get_devinfo(struct sk_buff *skb, struct genl_info *info)
+{
+	__u16 dev_num;
+	int num = 0;
+	void *hdr;
+	struct sk_buff *msg;
+	struct list_head *p;
+	struct nlattr *nl_list;
+	
+	if (info->attrs[NLBLUETOOTH_ATTR_DEVNUM]) {
+		dev_num = nla_get_u16(info->attrs[NLBLUETOOTH_ATTR_DEVNUM]);
+		if (!dev_num)
+			return -EINVAL;
+	} else
+		return -EINVAL;
+
+	msg = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+
+	if (!msg)
+		return -ENOBUFS;
+
+	hdr = genlmsg_put(msg, 0, info->snd_seq+1, &nlbluetooth_fam, 0, NLBLUETOOTH_CMD_GET_DEVLIST);
+
+	if (hdr == NULL)
+		return -ENOMEM;
+
+	nl_list = nla_nest_start(msg, NLBLUETOOTH_ATTR_DEVLIST);
+	if (!nl_list)
+		goto nla_put_failure;
+
+	read_lock_bh(&hci_dev_list_lock);
+	list_for_each(p, &hci_dev_list) {
+		struct hci_dev *hdev;
+
+		hdev = list_entry(p, struct hci_dev, list);
+
+		NLA_PUT_U16(msg, NLBLUETOOTH_ATTR_DEVID, hdev->id);
+		NLA_PUT_U32(msg, NLBLUETOOTH_ATTR_DEVOPT, hdev->flags);
+		if (++num >= dev_num)
+			break;
+	}
+	read_unlock_bh(&hci_dev_list_lock);
+
+	nla_nest_end(msg, nl_list);
+
+	NLA_PUT_U16(msg, NLBLUETOOTH_ATTR_DEVNUM, num);
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_unicast(msg, info->snd_pid);
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+static struct genl_ops nlbluetooth_ops = {
+	.cmd = NLBLUETOOTH_CMD_GET_DEVLIST,
+	.flags = 0,
+	.policy = nlbluetooth_policy,
+	.doit = nlbluetooth_get_devinfo,
+	.dumpit = NULL,
+};
+
+/* initialisation/exit functions */
+int __init nlbluetooth_init(void)
+{
+	int err;
+
+	err = genl_register_family(&nlbluetooth_fam);
+	if (err)
+		return err;
+
+	err = genl_register_ops(&nlbluetooth_fam, &nlbluetooth_ops);
+	if (err)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	genl_unregister_family(&nlbluetooth_fam);
+	return err;
+}
+
+void nlbluetooth_cleanup(void)
+{
+	genl_unregister_family(&nlbluetooth_fam);
+}
diff --git a/net/bluetooth/netlink.h b/net/bluetooth/netlink.h
new file mode 100644
index 0000000..2b81037
--- /dev/null
+++ b/net/bluetooth/netlink.h
@@ -0,0 +1,30 @@
+/*
+ * This is the netlink-based bluetooth interface.
+ *
+ * Copyright 2008 Alok Barsode <alok.barsode@azingo.com>
+ */
+#ifndef __NETLINK_H
+#define __NETLINK_H
+
+#define VERSION 1
+
+enum nlbluetooth_attr {
+	NLBLUETOOTH_ATTR_UNSPEC,
+	NLBLUETOOTH_ATTR_DEVID,
+	NLBLUETOOTH_ATTR_DEVNUM,
+	NLBLUETOOTH_ATTR_DEVOPT,
+	NLBLUETOOTH_ATTR_DEVLIST,
+	/* Add attributes here */
+	__NLBLUETOOTH_ATTR_MAX,
+	NLBLUETOOTH_ATTR_MAX  =  __NLBLUETOOTH_ATTR_MAX - 1
+};
+
+enum nlbluetooth_cmds {
+	NLBLUETOOTH_CMD_UNSPEC,
+	NLBLUETOOTH_CMD_GET_DEVLIST,
+	/* Add command here */
+	__NLBLUETOOTH_CMD_MAX,
+	NLBLUETOOTH_CMD_MAX  = __NLBLUETOOTH_CMD_MAX - 1
+};
+
+#endif /* __NETLINK_H */
-- 
1.5.4.3


--=-koN6P/QcUS9aN/wJeuZ7--

