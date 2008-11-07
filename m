Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Netlink patch.(modified)
From: Alok <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <491302D7.5010408@nokia.com>
References: <1225979417.15398.13.camel@greatbear>
	 <491302D7.5010408@nokia.com>
Content-Type: multipart/mixed; boundary="=-rtfgBwlBJEN3nIaAwJTY"
Date: Fri, 07 Nov 2008 12:17:39 +0530
Message-Id: <1226040459.17263.6.camel@greatbear>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-rtfgBwlBJEN3nIaAwJTY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel,

Attaching a modified netlink patch.
Forgot to free the buffer :) Thanks to ville for spotting it. 

-Alok. 

--=-rtfgBwlBJEN3nIaAwJTY
Content-Disposition: attachment; filename=0001-Adding-netlink-support-to-bluetooth.patch
Content-Type: application/mbox; name=0001-Adding-netlink-support-to-bluetooth.patch
Content-Transfer-Encoding: 7bit

>From 7e3014a5514fa009ba40a95a9a86723564cc5302 Mon Sep 17 00:00:00 2001
From: Alok Barsode <alok.barsode@azingo.com>
Date: Fri, 7 Nov 2008 12:06:43 +0530
Subject: [PATCH] Adding netlink support to bluetooth.
 Adding files netlink.c and netlink.h to net/bluetooth for netlink support.
 Adding support for GET_DEVLIST.

Signed-off-by: Alok Barsode <alok.barsode@azingo.com>
---
 include/net/bluetooth/bluetooth.h |    3 +
 net/bluetooth/Makefile            |    2 +-
 net/bluetooth/af_bluetooth.c      |    6 ++
 net/bluetooth/netlink.c           |  124 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/netlink.h           |   30 +++++++++
 5 files changed, 164 insertions(+), 1 deletions(-)
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
index 0000000..5c9166f
--- /dev/null
+++ b/net/bluetooth/netlink.c
@@ -0,0 +1,124 @@
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
+	if (!info->attrs[NLBLUETOOTH_ATTR_DEVNUM])
+		return -EINVAL;
+
+	dev_num = nla_get_u16(info->attrs[NLBLUETOOTH_ATTR_DEVNUM]);
+
+	if (!dev_num)
+		return -EINVAL;
+
+	msg = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+
+	if (!msg)
+		goto out_err;
+
+	hdr = genlmsg_put(msg, 0, info->snd_seq+1, &nlbluetooth_fam, 0, NLBLUETOOTH_CMD_GET_DEVLIST);
+
+	if (hdr == NULL)
+		goto out_free;
+
+	nl_list = nla_nest_start(msg, NLBLUETOOTH_ATTR_DEVLIST);
+	if (!nl_list)
+		goto out_free;
+
+	read_lock_bh(&hci_dev_list_lock);
+	list_for_each(p, &hci_dev_list) {
+		struct hci_dev *hdev;
+
+		hdev = list_entry(p, struct hci_dev, list);
+
+		nla_put_u16(msg, NLBLUETOOTH_ATTR_DEVID, hdev->id);
+		nla_put_u32(msg, NLBLUETOOTH_ATTR_DEVOPT, hdev->flags);
+		if (++num >= dev_num)
+			break;
+	}
+	read_unlock_bh(&hci_dev_list_lock);
+
+	nla_nest_end(msg, nl_list);
+
+	nla_put_u16(msg, NLBLUETOOTH_ATTR_DEVNUM, num);
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_unicast(msg, info->snd_pid);
+
+out_free:
+	nlmsg_free(msg);
+out_err:
+	return -ENOBUFS;
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


--=-rtfgBwlBJEN3nIaAwJTY--

