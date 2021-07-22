Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BBC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5165B61244
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhGVFTY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40171 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhGVFTV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:21 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210722055956epoutp0382a6d08fe18b1745b5fb852b3c1756b2~UB3xk-DVt0618306183epoutp03j
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210722055956epoutp0382a6d08fe18b1745b5fb852b3c1756b2~UB3xk-DVt0618306183epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933596;
        bh=lPkysQYmSXHnQUX3l0i1LE71r9ldEKU/cKhT+tvmFus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuVMzmF5UFWBOWbweHQN7WjH15NtI02lofZjnYdRGN/XiLHX6L4L9ViAUEIIqymXy
         o1zIE3QtmJSp6r/LSMR6GbO4ZbvaJO+8YfDdi0x9twZKNGZ4RZaLXQ4c1rlHEpumio
         2pddBijYQdFluqvaQHrUxX8LJXsLSVk5zjjuti5c=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210722055955epcas5p4887dc1e3b9aeeb168500d0274a7a0cb6~UB3xPTnYg2202722027epcas5p4f;
        Thu, 22 Jul 2021 05:59:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.EA.11627.B5909F06; Thu, 22 Jul 2021 14:59:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722053900epcas5p48430eb1335c3e566be02135e63749f33~UBlgeMHFp0983809838epcas5p4X;
        Thu, 22 Jul 2021 05:39:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722053900epsmtrp1e9874d8e255cf2b4dbba56cc6d88ff4e~UBlgXYMrz2559625596epsmtrp1Y;
        Thu, 22 Jul 2021 05:39:00 +0000 (GMT)
X-AuditID: b6c32a4b-acdff70000022d6b-04-60f9095b8313
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.C2.08394.47409F06; Thu, 22 Jul 2021 14:39:00 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722053859epsmtip27a258cd43b7952354943057821bc4e0e~UBlfaQ5_M0950409504epsmtip2T;
        Thu, 22 Jul 2021 05:38:59 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH 2/4] Bluetooth: Implement BT_PHY setsocket option
Date:   Thu, 22 Jul 2021 11:08:41 +0530
Message-Id: <20210722053843.6691-3-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722053843.6691-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmhm40588Eg5kX5C3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mo4MLeBvWC2dsW8nqssDYyTlbsYOTkk
        BEwkZjTtZe9i5OIQEtjNKLHr5RkmkISQwCdGiVe/fCAS3xgl5j26zwbTcaGliRkisZdR4s+8
        W4wQDlDHhOtLwdrZBDQlXn/8AmaLCChLPNt3GMxmFtCVOPN+HdAkDg5hAUeJPWs8QMIsAqoS
        9ze9ZgGxeQWsJNY2X2SGWCYvsXrDATCbU8BaYk7jfDaQXRICk9klet/1QBW5SPQv2sAEYQtL
        vDq+hR3ClpJ42d/GDtHQzCixY/NGKKeHUeLBj26of+wlzjU9YwW5iBno6vW79CHCshJTT62D
        OppPovf3E6gFvBI75sHYKhIbVnXCLft4bCHUQR4Sq5Y9Y4aEYx+jxLn5dRMY5WYhbFjAyLiK
        UTK1oDg3PbXYtMA4L7Vcrzgxt7g0L10vOT93EyM4lrW8dzA+evBB7xAjEwfjIUYJDmYlEV6V
        oq8JQrwpiZVVqUX58UWlOanFhxilOViUxHnZ44FSAumJJanZqakFqUUwWSYOTqkGptkeRw68
        O9cUXy7Bl6LBNuGSfa6O2iRm7p83yz4u7xTMXVS0syfEiOeX7xzNCwXXfjDNU+Z4eOhmVfus
        WTa7GKpUnjEeYt+QeDtwR25AWqTEBfG8CsMMJasjM2zcd/KsSvlr63JxivDdl4pvlr6JvftZ
        TXvB7rN3zO2uXDLn6+uNePP+mO1xv8Jf3LkLz17asuTWryPb/PayvVozcQqb2NR4mXm/2OyW
        J/z4yjlhUqDMnn1GC/YfW+n7add/1ddt0T8iaqflfi/kFWapFrFc4M37/vUzJ49tud9nNTdx
        bS+/H+O5aHrzdccpG+7sm77cak6MxOyrnZwrTyw+vD1nunbOMwH53n2OWjsuyboefDRZiaU4
        I9FQi7moOBEAQoTD/VQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSvG4Jy88Eg2U9qhZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGUcmNvAXjBbu2Jez1WWBsbJyl2MnBwS
        AiYSF1qamLsYuTiEBHYzStw5OoW1i5EDKCEl8XiZDkSNsMTKf8/ZIWo+MEo8W7yDDSTBJqAp
        8frjFyYQW0RAWeLZvsNgNrOAvsTTC9cZQeYICzhK7FnjARJmEVCVuL/pNQuIzStgJbG2+SIz
        xHx5idUbDoDZnALWEnMa57OBtAoB1Sxq95jAyLeAkWEVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwoGhp7mDcvuqD3iFGJg7GQ4wSHMxKIrwqRV8ThHhTEiurUovy44tKc1KLDzFK
        c7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBSirROVIu5vWXtnF/q2woO7ezViBL5/Hf2
        BO2Qt9Lz/2mI6L/hW/BXXVpgIYPmjPlVP0OPm6kuFr3T6LzBy6T1b+d7V5+PHyxsC7emfNd9
        3ZTKN6VTvNBAYk2anPzzB3Ze6eKWRwXuuBtP/bSN67Lpt31FDcXnfH9rTGQ7u60/XMN9hmaJ
        0dWNXEb7J+0pyMveNmma2q6P67W23HnefvHlMf0X/Q+WVJTY1065ksQdlGPys9OoQz7j/0kF
        53MLwhbZ8b7d+PfdoXPeKxa+afGbfWGi0tFj51a9VBVbd6n0sW1Rs3xi3rZTdWXaX+o3L8zY
        +9PiwnnXOSq52dvn13dLT699cCXzSqVP8uFDnPO5lViKMxINtZiLihMB1fGE3YMCAAA=
X-CMS-MailID: 20210722053900epcas5p48430eb1335c3e566be02135e63749f33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722053900epcas5p48430eb1335c3e566be02135e63749f33
References: <20210722053843.6691-1-ayush.garg@samsung.com>
        <CGME20210722053900epcas5p48430eb1335c3e566be02135e63749f33@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds BT_PHY setsocket option which can be used
to set the PHYs for the underline LE connection.

< HCI Command: LE Set PHY (0x08|0x0032) plen 7
		Handle: 0
		All PHYs preference: 0x00
		TX PHYs preference: 0x02
		  LE 2M
		RX PHYs preference: 0x02
		  LE 2M
		PHY options preference: Reserved (0x0000)
> HCI Event: Command Status (0x0f) plen 4
	  LE Set PHY (0x08|0x0032) ncmd 1
		Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 6
	  LE PHY Update Complete (0x0c)
		Status: Success (0x00)
		Handle: 0
		TX PHY: LE 2M (0x02)
		RX PHY: LE 2M (0x02)

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
---
 include/net/bluetooth/bluetooth.h |  7 ++++
 include/net/bluetooth/hci.h       | 12 +++++++
 include/net/bluetooth/hci_core.h  |  1 +
 net/bluetooth/hci_conn.c          | 56 +++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_sock.c        | 21 +++++++++++-
 5 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 9125effbf448..af53a98e4236 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -140,6 +140,13 @@ struct bt_voice {
 #define BT_PHY_LE_2M_RX		0x00001000
 #define BT_PHY_LE_CODED_TX	0x00002000
 #define BT_PHY_LE_CODED_RX	0x00004000
+#define BT_PHY_LE_CODED_S2      0x00008000
+#define BT_PHY_LE_CODED_S8      0x00010000
+
+#define BT_PHY_LE_TX_MASK (BT_PHY_LE_1M_TX | BT_PHY_LE_2M_TX | \
+			     BT_PHY_LE_CODED_TX)
+#define BT_PHY_LE_RX_MASK (BT_PHY_LE_1M_RX | BT_PHY_LE_2M_RX | \
+			     BT_PHY_LE_CODED_RX)
 
 #define BT_MODE			15
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 56542a09ec43..06e10ccf2a1c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1677,10 +1677,22 @@ struct hci_cp_le_set_default_phy {
 	__u8    rx_phys;
 } __packed;
 
+#define HCI_OP_LE_SET_PHY	0x2032
+struct hci_cp_le_set_phy {
+	__le16	handle;
+	__u8	all_phys;
+	__u8	tx_phys;
+	__u8	rx_phys;
+	__le16	phy_opt;
+} __packed;
+
 #define HCI_LE_SET_PHY_1M		0x01
 #define HCI_LE_SET_PHY_2M		0x02
 #define HCI_LE_SET_PHY_CODED		0x04
 
+#define HCI_LE_PHY_CODED_S2		0x01
+#define HCI_LE_PHY_CODED_S8		0x02
+
 #define HCI_LE_READ_PHY_1M		0x01
 #define HCI_LE_READ_PHY_2M		0x02
 #define HCI_LE_READ_PHY_CODED		0x03
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a53e94459ecd..257467f9d28d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1702,6 +1702,7 @@ struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u32 timeout);
 
 u32 hci_conn_get_phy(struct hci_conn *conn);
+int hci_conn_set_phy(struct hci_conn *conn, u32 phys);
 
 /* ----- HCI Sockets ----- */
 void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 383efd969840..3b69c7cb9523 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1935,3 +1935,59 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 
 	return phys;
 }
+
+int hci_conn_set_phy(struct hci_conn *conn, u32 phys)
+{
+	struct hci_cp_le_set_phy cp_phy;
+	u16 phy_opt = 0;
+
+	if (conn->type != LE_LINK)
+		return -ENOTCONN;
+
+	/* Check whether HCI_LE_Set_PHY command is supported or not */
+	if (!(conn->hdev->commands[35] & 0x40))
+		return -EOPNOTSUPP;
+
+	hci_dev_lock(conn->hdev);
+
+	memset(&cp_phy, 0, sizeof(cp_phy));
+	cp_phy.handle = cpu_to_le16(conn->handle);
+
+	if (!(phys & BT_PHY_LE_TX_MASK))
+		cp_phy.all_phys |= 0x01;
+
+	if (!(phys & BT_PHY_LE_RX_MASK))
+		cp_phy.all_phys |= 0x02;
+
+	if (phys & BT_PHY_LE_1M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (phys & BT_PHY_LE_2M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (phys & BT_PHY_LE_CODED_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_CODED;
+
+	if (phys & BT_PHY_LE_1M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (phys & BT_PHY_LE_2M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (phys & BT_PHY_LE_CODED_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_CODED;
+
+	if (phys & BT_PHY_LE_CODED_S2)
+		phy_opt |= HCI_LE_PHY_CODED_S2;
+
+	if (phys & BT_PHY_LE_CODED_S8)
+		phy_opt |= HCI_LE_PHY_CODED_S8;
+
+	cp_phy.phy_opt = cpu_to_le16(phy_opt);
+
+	hci_send_cmd(conn->hdev, HCI_OP_LE_SET_PHY, sizeof(cp_phy), &cp_phy);
+
+	hci_dev_unlock(conn->hdev);
+
+	return 0;
+}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c99d65ef13b1..eda5d61e37be 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -875,7 +875,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct bt_power pwr;
 	struct l2cap_conn *conn;
 	int len, err = 0;
-	u32 opt;
+	u32 opt, phys;
 
 	BT_DBG("sk %p", sk);
 
@@ -1071,6 +1071,25 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_PHY:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		if (copy_from_sockptr(&phys, optval, sizeof(u32))) {
+			err = -EFAULT;
+			break;
+		}
+
+		err = hci_conn_set_phy(chan->conn->hcon, phys);
+
+		if (err)
+			break;
+
+		BT_DBG("phys %u", phys);
+		break;
+
 	case BT_MODE:
 		if (!enable_ecred) {
 			err = -ENOPROTOOPT;
-- 
2.17.1

