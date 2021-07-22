Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83FCC63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4956127C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhGVFTc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48406 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVFTa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:30 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210722060005epoutp01c72823610515a02eac63e93e00e8a2a1~UB35wmVoN1867618676epoutp016
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:00:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210722060005epoutp01c72823610515a02eac63e93e00e8a2a1~UB35wmVoN1867618676epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933605;
        bh=pVu3zbdh7GNV1/bjbNgLaeBeBsSatd1pBebiBnWSZQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6lYubgxQIuMHnu6QsBi6ofkLgXGrNyyZpBwXs7vFGXgywAsOBTyIqqxU/fR3NJ7b
         JqZhGcLS4CvZmOpXAlYm4FmZ55TDi7W/iO+euMOZ0T3/tKQMyU7tn2oKugzVfqvQ+5
         OpUk8OLQ7KljAOfEbk1QCWjIJO71uQA6lZO9ubxY=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210722060003epcas5p2216baa8a9d1318fcb40fc42b0fb16cd0~UB34J_5Ul0442304423epcas5p2D;
        Thu, 22 Jul 2021 06:00:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.8A.09595.26909F06; Thu, 22 Jul 2021 15:00:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722053903epcas5p4e25daf9341dca446a0fbfd7b5d54324c~UBlis2u582580025800epcas5p4P;
        Thu, 22 Jul 2021 05:39:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722053903epsmtrp22ed007e7e05744f7c9348c2e4e0cf6a2~UBlimK_eo0680906809epsmtrp26;
        Thu, 22 Jul 2021 05:39:03 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-8d-60f909626f04
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.1A.08289.67409F06; Thu, 22 Jul 2021 14:39:03 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722053902epsmtip2d9f9c6699a9243cb9089c2af2b3128ee~UBlhw-Lf71363413634epsmtip2o;
        Thu, 22 Jul 2021 05:39:02 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH 4/4] Bluetooth: Update LE TX & RX PHYs when connection
 established
Date:   Thu, 22 Jul 2021 11:08:43 +0530
Message-Id: <20210722053843.6691-5-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722053843.6691-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmlm4S588Eg/bPVhZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGWce3SXteCtQsXXK8fYGhi3SXUxcnJI
        CJhI7L4xnb2LkYtDSGA3o8SZtVtZQRJCAp8YJWY8j4BIfGaU+LZnIjNMR8vLeUwQiV2MElcv
        HGaFcIA6tnXOAmtnE9CUeP3xCxOILSKgLPFs32Ewm1lAV+LM+3VsILawQIjE50eLwOIsAqoS
        Dx88ZAexeQWsJDavWcsIsU1eYvWGA2CbOQWsJeY0zmcDWSYh0M8usaVjOxtEkYtE5/mzUOcJ
        S7w6voUdwpaS+PxuL1RDM6PEjs0b2SGcHkaJBz+6obrtJc41PQM6mwPoPE2J9bv0IcKyElNP
        rYO6mk+i9/cTJog4r8SOeTC2isSGVZ1wyz4eWwh1hIfEsk9XoMHSxyhxf+k81gmMcrMQVixg
        ZFzFKJlaUJybnlpsWmCUl1quV5yYW1yal66XnJ+7iREcz1peOxgfPvigd4iRiYPxEKMEB7OS
        CK9K0dcEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzs8UApgfTEktTs1NSC1CKYLBMHp1QDk/n+
        c4f+ueuf//klZ80mo86SZe1L+Z9W/5kxtTIn5esXoy/reeO/3WFfWn0vfMPOm78uNwbeiwp+
        Ve+weJvL77ob57yPL9I4zPRf6qzULjFT9/5HLedCHyfNLriebpLy9pXf7Cyhu7b5sabXOM83
        +jY4zRJpKLihu2fDMo2L7BnCbomTFh4S2+7qeFzC4nPtJbH5qYbCZmUJkzdvvMXZcjHzIsv6
        jJP/hHycHhQy8n+R2PDMaG/MZr1l4ccD1irVt/C/F7jxWEk2+ODfEBHDVO7gq/GPotQ0Nks2
        cW3X/LbAZtbELWefvCtyXH/jxu8//ouWf//pnfltvY9wcdOkqndTz4iaTT3M/Wcb58KVyguU
        WIozEg21mIuKEwHWl0wKVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJMWRmVeSWpSXmKPExsWy7bCSvG45y88Eg469TBZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGWce3SXteCtQsXXK8fYGhi3SXUxcnJI
        CJhItLycxwRiCwnsYJQ4ciG1i5EDKC4l8XiZDkSJsMTKf8/ZIUo+MEq0zFUBsdkENCVef/wC
        1ioioCzxbN9hMJtZQF/i6YXrjCC2sECQxI7tZ8B6WQRUJR4+eAhm8wpYSWxes5YRYr68xOoN
        B5hBbE4Ba4k5jfPZQE4QAqpZ1O4xgZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
        3E2M4DDR0trBuGfVB71DjEwcjIcYJTiYlUR4VYq+JgjxpiRWVqUW5ccXleakFh9ilOZgURLn
        vdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAVDDBZue2koKnLgsn7Wd5lm3O+vV/1omtS6JeGX60
        PRX46uVKE/7pT/1Ph1xR635+40y5S5ndmsizlzlmXPnJNIuz6Ffzrs64hVk2rmlPJlcte3Dx
        Wm4VW1/62/Oq4bYx62ruyK+2KPsY4DJvlv5u3x+fZ+oIbpq7bZb4bwE2tj/3GdbMv3nHaEqO
        566/X36J6ayQn6G4YBfzv5I5LhY/L+5cvUit5nBPtZz7ylNdc2f7iRtZyoTd/LV3dfScFJPW
        i3Gv3u9af8tOYqN60rF332aF2xRPuyQQlWf3sV7aPb3pie9n3/lnbzVEHLHg8InWfvJnz7k3
        8m/vsNT7XZXz5P+hn+CnVyvH88/douLETz4lluKMREMt5qLiRAAs/g0KggIAAA==
X-CMS-MailID: 20210722053903epcas5p4e25daf9341dca446a0fbfd7b5d54324c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722053903epcas5p4e25daf9341dca446a0fbfd7b5d54324c
References: <20210722053843.6691-1-ayush.garg@samsung.com>
        <CGME20210722053903epcas5p4e25daf9341dca446a0fbfd7b5d54324c@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The TX and RX PHYs will always be 1M if the established LE
connection is a legacy connection. These values may
differ in case of LE Extended connection.
This change will read and update the connection PHYs and
autonomously send LE PHY Update event if the connection
is LE Extended.

< HCI Command: LE Read PHY (0x08|0x0030) plen 2
		Handle: 0
> HCI Event: Command Complete (0x0e) plen 8
	  LE Read PHY (0x08|0x0030) ncmd 1
		Status: Success (0x00)
		Handle: 0
		TX PHY: LE 1M (0x01)
		RX PHY: LE 1M (0x01)
@ MGMT Event: LE PHY Update Complete (0x002f) plen 12
		LE Address: 45:18:F8:CF:23:7E (Resolvable)
		Status: Success (0x00)
		Updated PHYs: 0x0600
		  LE 1M TX
		  LE 1M RX

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
---
 include/net/bluetooth/hci.h | 12 +++++++++
 net/bluetooth/hci_event.c   | 51 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 06e10ccf2a1c..6073e8431ed5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1670,6 +1670,18 @@ struct hci_rp_le_read_max_data_len {
 	__le16	rx_time;
 } __packed;
 
+#define HCI_OP_LE_READ_PHY	0x2030
+struct hci_cp_le_read_phy {
+	__le16 handle;
+} __packed;
+
+struct hci_rp_le_read_phy {
+	__u8	status;
+	__le16	handle;
+	__u8	tx_phy;
+	__u8	rx_phy;
+} __packed;
+
 #define HCI_OP_LE_SET_DEFAULT_PHY	0x2031
 struct hci_cp_le_set_default_phy {
 	__u8    all_phys;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index effe525e5272..37ab2f2a1d06 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1196,6 +1196,31 @@ static void hci_cc_le_set_default_phy(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cc_le_read_phy(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_rp_le_read_phy *rp = (void *)skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
+
+	if (rp->status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (!conn)
+		goto unlock;
+
+	conn->le_tx_phy = rp->tx_phy;
+	conn->le_rx_phy = rp->rx_phy;
+
+	mgmt_le_phy_update(hdev, conn, 0);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cc_le_set_adv_set_random_addr(struct hci_dev *hdev,
                                               struct sk_buff *skb)
 {
@@ -3642,6 +3667,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cc_le_read_transmit_power(hdev, skb);
 		break;
 
+	case HCI_OP_LE_READ_PHY:
+		hci_cc_le_read_phy(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
 		break;
@@ -5229,6 +5258,17 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		goto unlock;
 	}
 
+	/* If this LE connection is not an extended connection, then LE
+	 * PHYs will always be 1M at the time of connection establishment.
+	 * So, set 1M as initial LE PHY values.
+	 * But if this is LE Extended connection, then the PHY values
+	 * can be 1M, 2M or CODED. So, In this case, read and update
+	 * the values after the conn->state becomes connected and
+	 * then, send the LE_PHY_UPDATE_COMPLETE event.
+	 */
+	conn->le_tx_phy = HCI_LE_SET_PHY_1M;
+	conn->le_rx_phy = HCI_LE_SET_PHY_1M;
+
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
 		mgmt_device_connected(hdev, conn, NULL, 0);
 
@@ -5267,6 +5307,17 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		hci_connect_cfm(conn, status);
 	}
 
+	/* If this is LE Extended connection and HCI_LE_READ_PHY
+	 * command is supported, then update the LE PHYs.
+	 */
+	if (use_ext_conn(hdev) && hdev->commands[35] & 0x10) {
+		struct hci_cp_le_read_phy cp;
+
+		cp.handle = __cpu_to_le16(conn->handle);
+
+		hci_send_cmd(hdev, HCI_OP_LE_READ_PHY, sizeof(cp), &cp);
+	}
+
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
 					   conn->dst_type);
 	if (params) {
-- 
2.17.1

