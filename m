Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90764C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7453B61279
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhGVFT0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:48310 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhGVFTZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:25 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210722060000epoutp0153cb13f14046cbb3434b426c3f520216~UB31FXRM41856418564epoutp01B
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 06:00:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210722060000epoutp0153cb13f14046cbb3434b426c3f520216~UB31FXRM41856418564epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933600;
        bh=/2228MCU1cLnBCzQ8d6CApP325OQTIV4BTpZV3hnHNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhA7nDA8SexnpqKqRajUehcD2XB+z+2wkOkj3oBZLIJJP3FgL6m6WASQvi3tqYSP1
         tB3L04XiokS5x73MFudsPU5pQRJoX/Tkt1ahIAWSf+260SBhKMW3+pkp+B75RNXLNo
         vIcrrBBQW8n9CZ8HuaRgvyn4YC7McWfspVVAkL2g=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210722055959epcas5p38274291736291fb7a42cf446512b8f5d~UB30qxAge0717107171epcas5p3Z;
        Thu, 22 Jul 2021 05:59:59 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.8A.09595.E5909F06; Thu, 22 Jul 2021 14:59:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722053902epcas5p4a38e75d06dcebec336ac1b1743c1a540~UBlhqvWEZ0983809838epcas5p4b;
        Thu, 22 Jul 2021 05:39:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210722053902epsmtrp1af3d1a8321e6dae6662408572e220396~UBlhj_QRg2559625596epsmtrp1d;
        Thu, 22 Jul 2021 05:39:02 +0000 (GMT)
X-AuditID: b6c32a4a-ed5ff7000000257b-7f-60f9095ec2fe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.D2.08394.57409F06; Thu, 22 Jul 2021 14:39:01 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722053901epsmtip236702c4e9a917bfd2895c9b841f096ce~UBlglTf2j1364013640epsmtip2j;
        Thu, 22 Jul 2021 05:39:00 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH 3/4] Bluetooth: Add support for sending LE PHY Update event
 over mgmt
Date:   Thu, 22 Jul 2021 11:08:42 +0530
Message-Id: <20210722053843.6691-4-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722053843.6691-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmum4c588Eg647NhZ3VltbzLnWx2yx
        bV07swOzR9+WVYwenzfJBTBFcdmkpOZklqUW6dslcGXM3n2eqaBfpaLh2Vu2BsZ2uS5GTg4J
        AROJ1YdWsHYxcnEICexmlFixdQ8jhPOJUWL1zrcsEM43RokXO1tZYVoOTt8F1bKXUWL6zeUs
        cC0T/i9gAaliE9CUeP3xCxOILSKgLPFs32Ewm1lAV+LM+3VsILawQLjE/EVdYPUsAqoS1xe8
        BLN5Bawkln2+zAKxTV5i9YYDzCA2p4C1xJzG+WwgyyQEJrNLNK76xwZR5CKx4eZSqPOEJV4d
        38IOYUtJvOxvY4doaGaU2LF5I5TTwyjx4Ec3VLe9xLmmZ0DdHEDnaUqs36UPEZaVmHpqHdTV
        fBK9v58wQcR5JXbMg7FVJDas6oRb9vHYQmYI20Oif/8rsIOEBPoYJTZMkJ/AKDcLYcMCRsZV
        jJKpBcW56anFpgVGeanlesWJucWleel6yfm5mxjB8azltYPx4YMPeocYmTgYDzFKcDArifCq
        FH1NEOJNSaysSi3Kjy8qzUktPsQozcGiJM7LHg+UEkhPLEnNTk0tSC2CyTJxcEo1MAVmpZq4
        X04smzI3fcJaib1mD+2f7jng/4rZO75moWNhzL/l1xN+yHm7PZO84eiU7pOh1MDY0/fn8aLy
        y5sSF7fOO2Un7Kg8L0NP6GFMTFWp4R1Vrim/29g5rQ01/S7NNpL9W6pfqcS5fc37/MbJmlvm
        pEysW5H4dG7AypkNy7T4F1w5emgpq43BZ3F/Czbhuyq3XSJsq7X+C++vX3uFXdvg3pM1mRNc
        Hrif6NW8KH9st9CitQ/lmtW/J4vUtfOtKv2/Y+mu9UtlO1MnT83OXqMQaflfOlyjY3Y+h+6K
        jFUyIv0t1z+nhO9aKfjJqFls2jfOBW8sLdg9Hrzx4KrekLXHPLr7i+K+yeku3rszlViKMxIN
        tZiLihMBeEERK1YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSvG4py88EgwO7TS3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4MqYvfs8U0G/SkXDs7dsDYztcl2MnBwS
        AiYSB6fvYu1i5OIQEtjNKHH6+knmLkYOoISUxONlOhA1whIr/z1nh6j5wCix+PxPVpAEm4Cm
        xOuPX5hAbBEBZYln+w6D2cwC+hJPL1xnBLGFBUIl9p7qAqtnEVCVuL7gJQuIzStgJbHs82UW
        iAXyEqs3HGAGsTkFrCXmNM5nA7lBCKhmUbvHBEa+BYwMqxglUwuKc9Nziw0LDPNSy/WKE3OL
        S/PS9ZLzczcxgkNFS3MH4/ZVH/QOMTJxMB5ilOBgVhLhVSn6miDEm5JYWZValB9fVJqTWnyI
        UZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU/uaA+qSB3S+vH6fdUth3qUGnzjeDUK3
        edd+SSu9sXaOW62U6Y/miklSih9ePklzUDRa/Nx46d30/EQl+8qp3m/f1a0wcpwvwXI9a+NM
        H9eL9c/Pzp52bMITdlYV1WeyvEGJB3Skj23V8P0hPmvH0qYGG2YRE9v/69OuT1UxErldGTsl
        NtywjYmPQeSA6mTlI6/OLTqW1CrgvNLRb6X5rPeLmA2uyvZP1a195MK8dMbSC4zXuE/ums2+
        78FS4yUKk+478Z6oSuFlMj3y+kWm0UGrGzLqnH+7dWr8gk813JPLsN4Vf27HGjnzUr+ni5y7
        w8632HTNnS3nKHfVdtvn8Ijc47ckV2eWzVhwullaS4mlOCPRUIu5qDgRAM/lLaiEAgAA
X-CMS-MailID: 20210722053902epcas5p4a38e75d06dcebec336ac1b1743c1a540
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722053902epcas5p4a38e75d06dcebec336ac1b1743c1a540
References: <20210722053843.6691-1-ayush.garg@samsung.com>
        <CGME20210722053902epcas5p4a38e75d06dcebec336ac1b1743c1a540@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The HCI_LE_PHY_Update_Complete event should be sent to
upper layers in case of autonomous PHY update made by
the controller or HCI_LE_SET_PHY command succeeded.
This change will let user know immediately whenever
controller change LE PHYs for a particular connection.

> HCI Event: LE Meta Event (0x3e) plen 6
	  LE PHY Update Complete (0x0c)
		Status: Success (0x00)
		Handle: 0
		TX PHY: LE 2M (0x02)
		RX PHY: LE 2M (0x02)
@ MGMT Event: LE PHY Update Complete (0x002f) plen 12
		LE Address: 45:18:F8:CF:23:7E (Resolvable)
		Status: Success (0x00)
		Updated PHYs: 0x1800
		  LE 2M TX
		  LE 2M RX

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  7 +++++++
 net/bluetooth/hci_event.c        | 11 ++++++-----
 net/bluetooth/mgmt.c             | 34 ++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 257467f9d28d..3a5c310ec937 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1835,6 +1835,7 @@ void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 			      u8 instance);
 void mgmt_adv_monitor_removed(struct hci_dev *hdev, u16 handle);
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
+void mgmt_le_phy_update(struct hci_dev *hdev, struct hci_conn *conn, u8 status);
 int mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev, u8 status);
 int mgmt_remove_adv_monitor_complete(struct hci_dev *hdev, u8 status);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 23a0524061b7..54800c4883fc 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1100,6 +1100,13 @@ struct mgmt_ev_controller_resume {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_EV_LE_PHY_UPDATE_COMPLETE	0x002f
+struct mgmt_ev_le_phy_update_complete {
+	struct mgmt_addr_info addr;
+	__u8	status;
+	__le32	phys;
+} __packed;
+
 #define MGMT_WAKE_REASON_NON_BT_WAKE		0x0
 #define MGMT_WAKE_REASON_UNEXPECTED		0x1
 #define MGMT_WAKE_REASON_REMOTE_WAKE		0x2
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c3018202564..effe525e5272 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5970,17 +5970,18 @@ static void hci_le_phy_update_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
-	if (ev->status)
-		return;
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (!conn)
 		goto unlock;
 
-	conn->le_tx_phy = ev->tx_phy;
-	conn->le_rx_phy = ev->rx_phy;
+	if (!ev->status) {
+		conn->le_tx_phy = ev->tx_phy;
+		conn->le_rx_phy = ev->rx_phy;
+	}
+
+	mgmt_le_phy_update(hdev, conn, ev->status);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3663f880df11..683e4b66f810 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -172,6 +172,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_ADV_MONITOR_REMOVED,
 	MGMT_EV_CONTROLLER_SUSPEND,
 	MGMT_EV_CONTROLLER_RESUME,
+	MGMT_EV_LE_PHY_UPDATE_COMPLETE,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -3611,6 +3612,39 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+void mgmt_le_phy_update(struct hci_dev *hdev, struct hci_conn *conn,
+			u8 status)
+{
+	struct mgmt_ev_le_phy_update_complete ev;
+	u32 phys = 0;
+
+	memset(&ev, 0, sizeof(ev));
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+
+	ev.status = status;
+
+	if (conn->le_tx_phy == HCI_LE_READ_PHY_1M)
+		phys |= MGMT_PHY_LE_1M_TX;
+	else if (conn->le_tx_phy == HCI_LE_READ_PHY_2M)
+		phys |= MGMT_PHY_LE_2M_TX;
+	else if (conn->le_tx_phy == HCI_LE_READ_PHY_CODED)
+		phys |= MGMT_PHY_LE_CODED_TX;
+
+	if (conn->le_rx_phy == HCI_LE_READ_PHY_1M)
+		phys |= MGMT_PHY_LE_1M_RX;
+	else if (conn->le_rx_phy == HCI_LE_READ_PHY_2M)
+		phys |= MGMT_PHY_LE_2M_RX;
+	else if (conn->le_rx_phy == HCI_LE_READ_PHY_CODED)
+		phys |= MGMT_PHY_LE_CODED_RX;
+
+	ev.phys = cpu_to_le32(phys);
+
+	mgmt_event(MGMT_EV_LE_PHY_UPDATE_COMPLETE, hdev, &ev, sizeof(ev),
+		   NULL);
+}
+
 static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 			    u16 len)
 {
-- 
2.17.1

