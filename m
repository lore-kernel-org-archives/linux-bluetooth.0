Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 01/15] Bluetooth: Implement the first SMP commands
Date: Tue,  5 Apr 2011 22:51:42 -0300
Message-Id: <1302054716-24534-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302054716-24534-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

These simple commands will allow the SMP procedure to be started
and terminated with a not supported error. This is the first step
toward something useful.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
---
 include/net/bluetooth/smp.h |   26 ++++++++
 net/bluetooth/Makefile      |    2 +-
 net/bluetooth/smp.c         |  146 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 1 deletions(-)
 create mode 100644 net/bluetooth/smp.c

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index 8f2edbf..36bdd6e 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -1,3 +1,25 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
 #ifndef __SMP_H
 #define __SMP_H
 
@@ -73,4 +95,8 @@ struct smp_cmd_security_req {
 #define SMP_UNSPECIFIED		0x08
 #define SMP_REPEATED_ATTEMPTS		0x09
 
+/* SMP Commands */
+int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level);
+int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb);
+
 #endif /* __SMP_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index f04fe9a..9b67f3d 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -9,5 +9,5 @@ obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o hci_sock.o hci_sysfs.o lib.o
-bluetooth-$(CONFIG_BT_L2CAP)	+= l2cap_core.o l2cap_sock.o
+bluetooth-$(CONFIG_BT_L2CAP)	+= l2cap_core.o l2cap_sock.o smp.o
 bluetooth-$(CONFIG_BT_SCO)	+= sco.o
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
new file mode 100644
index 0000000..8b67a56
--- /dev/null
+++ b/net/bluetooth/smp.c
@@ -0,0 +1,146 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/smp.h>
+
+static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
+		u16 dlen, void *data)
+{
+	struct sk_buff *skb;
+	struct l2cap_hdr *lh;
+	int len;
+
+	len = L2CAP_HDR_SIZE + sizeof(code) + dlen;
+
+	if (len > conn->mtu)
+		return NULL;
+
+	skb = bt_skb_alloc(len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
+	lh->len = cpu_to_le16(sizeof(code) + dlen);
+	lh->cid = cpu_to_le16(L2CAP_CID_SMP);
+
+	memcpy(skb_put(skb, sizeof(code)), &code, sizeof(code));
+
+	memcpy(skb_put(skb, dlen), data, dlen);
+
+	return skb;
+}
+
+static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
+{
+	struct sk_buff *skb = smp_build_cmd(conn, code, len, data);
+
+	BT_DBG("code 0x%2.2x", code);
+
+	if (!skb)
+		return;
+
+	hci_send_acl(conn->hcon, skb, 0);
+}
+
+int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
+{
+	__u8 authreq;
+
+	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
+
+	switch (sec_level) {
+	case BT_SECURITY_MEDIUM:
+		/* Encrypted, no MITM protection */
+		authreq = HCI_AT_NO_BONDING_MITM;
+		break;
+
+	case BT_SECURITY_HIGH:
+		/* Bonding, MITM protection */
+		authreq = HCI_AT_GENERAL_BONDING_MITM;
+		break;
+
+	case BT_SECURITY_LOW:
+	default:
+		return 1;
+	}
+
+	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+		struct smp_cmd_pairing cp;
+		cp.io_capability = 0x00;
+		cp.oob_flag = 0x00;
+		cp.max_key_size = 16;
+		cp.init_key_dist = 0x00;
+		cp.resp_key_dist = 0x00;
+		cp.auth_req = authreq;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+	} else {
+		struct smp_cmd_security_req cp;
+		cp.auth_req = authreq;
+		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
+	}
+
+	return 0;
+}
+
+int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	__u8 code = skb->data[0];
+	__u8 reason;
+	int err = 0;
+
+	skb_pull(skb, sizeof(code));
+
+	switch (code) {
+	case SMP_CMD_PAIRING_REQ:
+		reason = SMP_PAIRING_NOTSUPP;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
+								&reason);
+		err = -EOPNOTSUPP;
+		break;
+
+	case SMP_CMD_PAIRING_FAIL:
+		break;
+
+	case SMP_CMD_PAIRING_RSP:
+	case SMP_CMD_PAIRING_CONFIRM:
+	case SMP_CMD_PAIRING_RANDOM:
+	case SMP_CMD_ENCRYPT_INFO:
+	case SMP_CMD_MASTER_IDENT:
+	case SMP_CMD_IDENT_INFO:
+	case SMP_CMD_IDENT_ADDR_INFO:
+	case SMP_CMD_SIGN_INFO:
+	case SMP_CMD_SECURITY_REQ:
+	default:
+		BT_DBG("Unknown command code 0x%2.2x", code);
+
+		reason = SMP_CMD_NOTSUPP;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
+								&reason);
+		err = -EOPNOTSUPP;
+	}
+
+	kfree_skb(skb);
+	return err;
+}
-- 
1.7.4.1

