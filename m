Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9633EC63793
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D74B61279
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 05:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGVFTT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:19:19 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44113 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhGVFTS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 01:19:18 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210722055952epoutp0441bd2f7540c2b032e7012684a2074b80~UB3uglv-10482404824epoutp04c
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 05:59:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210722055952epoutp0441bd2f7540c2b032e7012684a2074b80~UB3uglv-10482404824epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626933592;
        bh=gLi5izO2emW1/Xuquhpo4cj7f9PNlRDquW1Z4C/UgsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEdaBFLaotVuNE+8ocJdI90Blv6qty5EBJ9mzRExaJ2+zhUKIbB96/whqHcuXGEz0
         +IJteh8Rs0FkT4NTXYRbCn4PWxCeGP4JhTRJfXSVRMeN7k754FSX9iavpGC5eTqil1
         SCj+mkwo3jHsqJfR96UI6Vh/rO4Yk7HfJNHvC+2o=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210722055952epcas5p263d136220bf91e26f153cb81471528f8~UB3uFaSU-0624506245epcas5p2o;
        Thu, 22 Jul 2021 05:59:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.7A.09595.85909F06; Thu, 22 Jul 2021 14:59:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210722053859epcas5p4b9441d43196ee1111b33b7c8d4827262~UBlfeAX5k2579925799epcas5p4F;
        Thu, 22 Jul 2021 05:38:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210722053859epsmtrp2e2816c99467e7f80a3617885c652dd17~UBlfS4Uyn0680906809epsmtrp2p;
        Thu, 22 Jul 2021 05:38:59 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-68-60f90958aa51
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.C2.08394.37409F06; Thu, 22 Jul 2021 14:38:59 +0900 (KST)
Received: from ayush.garg-20-10-15 (unknown [107.109.98.149]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210722053858epsmtip25b95660dc4369213d87375de0496c47c~UBleXzwbA1183911839epsmtip2b;
        Thu, 22 Jul 2021 05:38:58 +0000 (GMT)
From:   Ayush Garg <ayush.garg@samsung.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     anupam.r@samsung.com, nitin.j@samsung.com
Subject: [PATCH 1/4] Bluetooth: Fix incorrect parsing of LE_PHY params
Date:   Thu, 22 Jul 2021 11:08:40 +0530
Message-Id: <20210722053843.6691-2-ayush.garg@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210722053843.6691-1-ayush.garg@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmpm4E588Eg8XPOCzurLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mo4tqSPreC9YMWrx4vYGxiv8nUxcnBI
        CJhI9E1S7WLk4hAS2M0oseP0LCYI5xOjREffBCjnG6PE/s59zF2MnGAdG47tYoFI7GWUeLOs
        gxWu5cHKj2wgVWwCmhKvP35hArFFBJQlnu07DGYzC+hKnHm/DqxGWMBNYv/2dYwgNouAqsTu
        9TvBNvAKWElMa5rJCLFNXmL1hgNgcU4Ba4k5jfPZQJZJCExnl7i28h4bRJGLxKFrE6FsYYlX
        x7ewQ9hSEp/f7YVqaAb6bvNGdginB+jUH91QHfYS55qesYKCgxno7PW79CHCshJTT62DuppP
        ovf3EyaIOK/EjnkwtorEhlWdcMs+HlsIDSMPiQ3rNrNDgqWPUWJi91G2CYxysxBWLGBkXMUo
        mVpQnJueWmxaYJSXWq5XnJhbXJqXrpecn7uJERzPWl47GB8++KB3iJGJg/EQowQHs5IIr0rR
        1wQh3pTEyqrUovz4otKc1OJDjNIcLErivOzxQCmB9MSS1OzU1ILUIpgsEwenVAOTb9Dlo3GC
        pZnMWzX/LPmtOT8rls/odJrYhvltS4JFg9dF9Kjn8hsVep96FcNbP+fWoU/yxufbd3ls2Blv
        s9fH46H2wqC1PGGfTyVd2uZ11m3/dufrKw6HGpYc39ihWK20dXJyguucm9PUE4u/9tam/5h8
        QlfHxvNWVfyLutXz4pdXSaldOq3IvH/ijS1RD3Oy9Bgkrx9csuE/77uGjz2da3f+i80Pa7Gy
        T6hyV9vEur/K9rP8l4OK5UYMKa9Ltnt/FotUSJXbXMKp9+gRh5up0IlD0RvWGqS9zS3c3bxK
        LXrb1H97rmxaO0fD7f3q8xePvN9v47UnJE/zM9OdGVOvu2y4nHRzRdrOins2nlstlViKMxIN
        tZiLihMB32xmLVYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJMWRmVeSWpSXmKPExsWy7bCSvG4xy88Eg3vXRC3urLa2mHOtj9li
        27p2Zgdmj74tqxg9Pm+SC2CK4rJJSc3JLEst0rdL4Mo4tqSPreC9YMWrx4vYGxiv8nUxcnJI
        CJhIbDi2i6WLkYtDSGA3o8Taz+uYuhg5gBJSEo+X6UDUCEus/PecHaLmA6NE49wprCAJNgFN
        idcfvzCB2CICyhLP9h0Gs5kF9CWeXrjOCGILC7hJ7N++DsxmEVCV2L1+JzOIzStgJTGtaSYj
        xAJ5idUbDoDFOQWsJeY0zmcDuUEIqGZRu8cERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL
        89L1kvNzNzGCQ0VLcwfj9lUf9A4xMnEwHmKU4GBWEuFVKfqaIMSbklhZlVqUH19UmpNafIhR
        moNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTFJ0ds5NENrFzq9rwndk6rSDhRuhR7y0H
        7J9/2r7q2NJn93Uy71a8XFtvkXQn79Yy3lY5RcfQmDSBRX3GPuc8H1wJ/LxOtTvroenfY38l
        r/fd7Pv64Gt8WX7N8wPGxvO0vuTUZP1u/7l2r7Ko+54gkdfKF9glSjeu/jz/QqJNl6H+Mdtq
        aQORGdXOW5clbtjVf3D2iS+X7tYcb1g6waJK+lr7nLmXZW5JbDg9Y5b1OqZl4nYTJy7+viBY
        ctmcs6+/nm3acHlSva24iuuvU0opbe//zNVI/FAn/nHBMta87PAQ1b5lVolMIlfeRCibzl8o
        91GIu2TNBWudPZW3Ty/9Xam2/SLXjmn212bnuutHvFFiKc5INNRiLipOBAANeaEFhAIAAA==
X-CMS-MailID: 20210722053859epcas5p4b9441d43196ee1111b33b7c8d4827262
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210722053859epcas5p4b9441d43196ee1111b33b7c8d4827262
References: <20210722053843.6691-1-ayush.garg@samsung.com>
        <CGME20210722053859epcas5p4b9441d43196ee1111b33b7c8d4827262@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change is fixing the parsing of PHY LE CODED which is
represented with value 0x03 instead of 0x04 in LE PHY Update
Complete event.

> HCI Event: LE Meta Event (0x3e) plen 6
	  LE PHY Update Complete (0x0c)
		Status: Success (0x00)
		Handle: 0
		TX PHY: LE Coded (0x03)
		RX PHY: LE Coded (0x03)

Reviewed-by: Anupam Roy <anupam.r@samsung.com>
Signed-off-by: Ayush Garg <ayush.garg@samsung.com>
---
 include/net/bluetooth/hci.h |  4 ++++
 net/bluetooth/hci_conn.c    | 21 +++++++++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b80415011dcd..56542a09ec43 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1681,6 +1681,10 @@ struct hci_cp_le_set_default_phy {
 #define HCI_LE_SET_PHY_2M		0x02
 #define HCI_LE_SET_PHY_CODED		0x04
 
+#define HCI_LE_READ_PHY_1M		0x01
+#define HCI_LE_READ_PHY_2M		0x02
+#define HCI_LE_READ_PHY_CODED		0x03
+
 #define HCI_OP_LE_SET_EXT_SCAN_PARAMS   0x2041
 struct hci_cp_le_set_ext_scan_params {
 	__u8    own_addr_type;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2b5059a56cda..383efd969840 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1915,22 +1915,19 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 		break;
 
 	case LE_LINK:
-		if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
-			phys |= BT_PHY_LE_1M_TX;
-
-		if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
-			phys |= BT_PHY_LE_1M_RX;
 
-		if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
+		if (conn->le_tx_phy == HCI_LE_READ_PHY_1M)
+			phys |= BT_PHY_LE_1M_TX;
+		else if (conn->le_tx_phy == HCI_LE_READ_PHY_2M)
 			phys |= BT_PHY_LE_2M_TX;
-
-		if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
-			phys |= BT_PHY_LE_2M_RX;
-
-		if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
+		else if (conn->le_tx_phy == HCI_LE_READ_PHY_CODED)
 			phys |= BT_PHY_LE_CODED_TX;
 
-		if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
+		if (conn->le_rx_phy == HCI_LE_READ_PHY_1M)
+			phys |= BT_PHY_LE_1M_RX;
+		else if (conn->le_rx_phy == HCI_LE_READ_PHY_2M)
+			phys |= BT_PHY_LE_2M_RX;
+		else if (conn->le_rx_phy == HCI_LE_READ_PHY_CODED)
 			phys |= BT_PHY_LE_CODED_RX;
 
 		break;
-- 
2.17.1

