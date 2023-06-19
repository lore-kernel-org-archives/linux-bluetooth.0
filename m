Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B2DEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 14:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjFSOx7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSOx4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 10:53:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477BB9
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 07:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5MmXKYYVCyNCIPaM8Mgm16VFCHrllu38A8dV5gXPvnNQSL03mF7a0shi0G+S1HS6ychtHruj0STvnvs0C006E6p0y9xKxO4leitJAa2GOalTBKfdxGrAEjT7ZIrQceVnHhJ3SywYyluvuWK5vlaa33n+p3aPxR+YGi+PNw9zNGu9ZV4RukOTzNYjzgNmDC3inCCHGkIelmarZqfn+Kv3vQuQTs6DjpM0zp4T7K6NvQFsViF7Z3w3y6XjxyCTTc+XHaTwSGyprf/AyWnGE/8bFwXptD5YarCLY7IC7IoC2z7FVsVd3VJMfP5Joech1Dn8QCFTC/hfAvE1G5cfdbp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPvFxQ8ySbiaanSZ70W34iIxHkPgfMYFArSDZv8yDZY=;
 b=UM6KZAV9KKWlRVWEsNun88uXvBGbrE7uxmKGldwFxToFf2afBrQGkYPFlFnyVxPDJqCeXXEqFJteyBwKTIyd3p5Mkkp3w+dw7T88M0HgN7HAH2qnyO9Lgw7/quRxiVmDYYTalS+mj+J1FDY8zcPWmaoWzUZtNWipczjo+tjhlGz/C6NdaaZg3Vpt9ahVozBgFQlsU0NHl96DO/feOq4+wYpI5YGWY0RBsIdAMOjZriTt13YsJWuv2HLudQpsUUvUHc/gBZS/i/pinDn1xMIGmmkN3YNvA+fsRAE7FqESnm5MPmH+GBKmHfuPDUut1INPEWt5fravNAXNdPNeCJdNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPvFxQ8ySbiaanSZ70W34iIxHkPgfMYFArSDZv8yDZY=;
 b=Qe1piQAoqCfSsU3HM10K/Vigx62HlK8UBKJaXQ1U/xYVYF6rNLzdD2TqdN6r7E01q8EzcpaDB6+3LikmDrH/diq3JyrcJI6IqgODi4Y5KyBSJwL7/KJftdUP17GZpQPVyL+9AX1MXfdFgFC4EszrjIuZxUiOUJSAyHVPifYY+7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7579.eurprd04.prod.outlook.com (2603:10a6:10:1f5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:53:50 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:53:50 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mihai-octavian.urzica@nxp.com, claudia.rosu@nxp.com,
        andrei.istodorescu@nxp.com, vlad.pruteanu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Support multiple BIGs
Date:   Mon, 19 Jun 2023 17:53:16 +0300
Message-Id: <20230619145316.3185-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619145316.3185-1-iulia.tanasescu@nxp.com>
References: <20230619145316.3185-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0fe87e-5170-4299-5d08-08db70d4fe0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXCsby2bYrU2JJfvmryvhJs9Ak8KHvKe/1hG4iKbwjK0Kpi22kgCRpiXSXB6tEfgF/pL73ilssbQxdqgowapVQLcNplmujrB5Fj6kplShWJG0a6M5tpB+c4j1yq8poSypdP0xhsFdYGjsAFKGuAj3co7TYwnELopgrhJkFpbRfnXLb2TYLgH8GhJtd3fhx48gcZB2UqBFGP1gXbUHJUH1EdV6LUjnGAWGVbvzMX8SnIritSrTK7PuFy5n7PYjODF5hQ74renG/FaxelCg7+aKnauWZupW+ahaytDJaZr9MeVM4irBStwKdmvuS4SS/9W0Emj0T9o1K5GXthYKOdipFYf9gcE7pQBSDFbKnK+0Ba92kYlX58ZhMYkl8oUgrSyL3++0J85e7xUIGygBnFGFxlZYB0yLS7pxrVaEorhMynMe1R6XckRubuxGdSkH9un4p/WqajhmP+eIduonzQIl1FSfzm+r9DKLqEmeku29wQN80OHDhzGzXUNfI6FA5yNQ9wvfbAgOTrR2x4L05VxDLDtMY7cmKnIUB0fLs8O5dwlPsOF7P8xYI1eqm/OW7PTaQMX1Z2tG/J1ahC6xCxxXHVdAdxT9KPPiAB7PLw3nvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(66946007)(8936002)(8676002)(66556008)(66476007)(1076003)(26005)(186003)(6506007)(6512007)(36756003)(83380400001)(41300700001)(38100700002)(38350700002)(5660300002)(4326008)(6916009)(44832011)(316002)(52116002)(2616005)(6666004)(6486002)(478600001)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsvuNIoq9Ror8sMvCiNd6C8ojY2H6fGJ4tD+5X6nn8PbDdNT2tqXFDIxT1po?=
 =?us-ascii?Q?o8ohDTsOs/hgkpmTiFnTEm2hQg/I3AMzDx84g1ISBcpvKN95myyWuBOx+jEF?=
 =?us-ascii?Q?oxuJevvs1CciH78U5i4lg3rcg79BTxBYEJi7/72HHeupIUdZxMpHf8J0DxC7?=
 =?us-ascii?Q?VihEORExqZk6oRiaBG6jhbhlbFmR4ZST8nK0rM0GJV6W54f8Smf9Zr4O5MN6?=
 =?us-ascii?Q?ud8scdNBp1VBiB+zQubFm0kO2kLiOHBcuwIDuHAN9xOqNkmPTZHxTe19Ymhp?=
 =?us-ascii?Q?aAeHeFD38NwuMxXeAG4HBNAt9tevF3o9ifTxF9y9mvUqekV9OnTuO08LdzWb?=
 =?us-ascii?Q?cy61j/C8NbsZAksj+/PCKO5hkJ0tabUa4XGlTuwipU0vG5+GE0wUAg68aLiJ?=
 =?us-ascii?Q?vZHZq0VMUIPG8FUGPFTpCs/TfcvSWsVNOMTz8ttd/7af1C2dL3aR0PKxcahc?=
 =?us-ascii?Q?AFIQeCSGiWO95FQB6pIK96iuW0JerGk1zm22AW1PJOETFrFvMN6ppoh85n7y?=
 =?us-ascii?Q?k4qYZjL843+KDWsbKASEdBnYZ7Md8xM5c53TSqNiDHtvG8Ifqitxi1lSrh8P?=
 =?us-ascii?Q?QMO3RVAgth2Qahh04vsIFwrOy+oCqsYOE8+VDGck4cUSy3HalAcWLWNfFc5c?=
 =?us-ascii?Q?6SdVs1AJQKNuvR657M1G9m5TlqMP0G6AlqUUVIFOF0vxDDWdn65ykXS8/FfH?=
 =?us-ascii?Q?wop+t7tiBKKGHuiqebh4EeTgM2afDnF4zG4PJwQtsvshUamtj88DXAAFsRCo?=
 =?us-ascii?Q?5ruXhwWO+sjarCqeHFegBgx783OXwNFeS70ZGlABBXuls2EcOxt7oLiwq/bR?=
 =?us-ascii?Q?Sr8WrEPbrtcegMd5SSkfYnAJZonIksqDj9HV02kuCzYhOn4fZxYUJf1tqTV0?=
 =?us-ascii?Q?v9lMjMUxTshDd7VPmZnyvoRnypgQKAYoJPRHd5abO2Gi38dx8Nm5fLZNwWTW?=
 =?us-ascii?Q?s5l7M6I1/U39LXHUmSoEdurmquVFAXWU5rI/2HItc9zvtE/ujZqDzASkMI90?=
 =?us-ascii?Q?Grgh+ut/axXR+2ayxItgYTUF00pHX4BNuJ+3F1Se2lZysrlHmbP43dYzlKs7?=
 =?us-ascii?Q?n7Lk6PSzRdTQV8NIzIZ24XnlLnk/S2vpha7ssx94kRg8SdNj5rD13dUDGoQ+?=
 =?us-ascii?Q?ZsNW+OnhqFRDrEcJzCL/i2Y7FZQeyneav8ED8795znFKo/0QzskM4L/ZVeBT?=
 =?us-ascii?Q?NkI+mYi9ch2dBXXIxSl2tp/QjBoD8F8MC1Nz6hZmjiUBq7KTNuUWfwPFttMR?=
 =?us-ascii?Q?0Yeyq3gRdL3WDwQLp0wPjRHvzWKm54tkyYbAWF0Pi0TDLPlr7gdW9ADoKyM2?=
 =?us-ascii?Q?RNwZ5I23Mixdb41hWpKFvNUJ3XNWJpgXJy7qmoB9dR9uafPme/1GAYzPx1rp?=
 =?us-ascii?Q?qtBWnCwA60h2JK0kAP/W9hCSP2SG+x1mRwSkkhwUJn4yBrvrEsprFK3Pq/1b?=
 =?us-ascii?Q?Mgnja55hgGH6LRNUP6BqK4Z5WO3DCPLdGO9C4Xy0EmK2Iym8uyJ7xKKQ1vf5?=
 =?us-ascii?Q?4yMNAJ+cQmhxeFH+Vexi/eBDbYve6areNPSOOyhQq9yG2GbaUE9vtntpB/RG?=
 =?us-ascii?Q?ymdbzAkjzA5v17bPuGWlVKz3lWokOAAaym4GoT3yBsKImhUzQQ9+zO/xqCVL?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0fe87e-5170-4299-5d08-08db70d4fe0e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:53:50.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJqAT5zC1sKxA4fVmXRbrHAi1AKkqULD/q/nInUGDWGUhDhbSv6bYgqALd85GtRPqsB/U9Uz7X7wLRWtc8mi0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7579
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for creating multiple BIGs. According to
spec, each BIG shall have an unique handle, and each BIG should
be associated with a different advertising handle. Otherwise,
the LE Create BIG command will fail, with error code
Command Disallowed (for reusing a BIG handle), or
Unknown Advertising Identifier (for reusing an advertising
handle).

The btmon snippet below shows an exercise for creating two BIGs
for the same controller, by opening two isotest instances with
the following command:
    tools/isotest -i hci0 -s 00:00:00:00:00:00

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 31
        Handle: 0x00
        Advertising Handle: 0x01
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Success (0x00)

> HCI Event: LE Meta Event (0x3e) plen 21
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x00
        BIG Synchronization Delay: 912 us (0x000390)
        Transport Latency: 912 us (0x000390)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
        Handle: 0x01
        Advertising Handle: 0x02
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Success (0x00)

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h |  5 ++--
 net/bluetooth/hci_conn.c         | 40 ++++++++++++++------------------
 net/bluetooth/hci_event.c        | 35 +++++++++++++++++++++++-----
 net/bluetooth/hci_sync.c         | 28 +++++++++++-----------
 4 files changed, 63 insertions(+), 45 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 683666ea210c..f2030670ea72 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1096,8 +1096,7 @@ static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
-							bdaddr_t *ba,
-							__u8 big, __u8 bis)
+							bdaddr_t *ba, __u8 bis)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1108,7 +1107,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 		if (bacmp(&c->dst, ba) || c->type != ISO_LINK)
 			continue;
 
-		if (c->iso_qos.bcast.big == big && c->iso_qos.bcast.bis == bis) {
+		if (c->iso_qos.bcast.bis == bis) {
 			rcu_read_unlock();
 			return c;
 		}
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7d4941e6dbdf..8cd2ef0ab1d0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -927,9 +927,7 @@ static void bis_cleanup(struct hci_conn *conn)
 		/* Check if ISO connection is a BIS and terminate advertising
 		 * set and BIG if there are no other connections using it.
 		 */
-		bis = hci_conn_hash_lookup_bis(hdev, BDADDR_ANY,
-					       conn->iso_qos.bcast.big,
-					       conn->iso_qos.bcast.bis);
+		bis = hci_conn_hash_lookup_big(hdev, conn->iso_qos.bcast.big);
 		if (bis)
 			return;
 
@@ -1449,25 +1447,23 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 
 static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
 {
-	struct iso_list_data data;
+	struct hci_conn *conn;
+	u8  big;
 
 	/* Allocate a BIG if not set */
 	if (qos->bcast.big == BT_ISO_QOS_BIG_UNSET) {
-		for (data.big = 0x00; data.big < 0xef; data.big++) {
-			data.count = 0;
-			data.bis = 0xff;
+		for (big = 0x00; big < 0xef; big++) {
 
-			hci_conn_hash_list_state(hdev, bis_list, ISO_LINK,
-						 BT_BOUND, &data);
-			if (!data.count)
+			conn = hci_conn_hash_lookup_big(hdev, big);
+			if (!conn)
 				break;
 		}
 
-		if (data.big == 0xef)
+		if (big == 0xef)
 			return -EADDRNOTAVAIL;
 
 		/* Update BIG */
-		qos->bcast.big = data.big;
+		qos->bcast.big = big;
 	}
 
 	return 0;
@@ -1475,28 +1471,27 @@ static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 {
-	struct iso_list_data data;
+	struct hci_conn *conn;
+	u8  bis;
 
 	/* Allocate BIS if not set */
 	if (qos->bcast.bis == BT_ISO_QOS_BIS_UNSET) {
 		/* Find an unused adv set to advertise BIS, skip instance 0x00
 		 * since it is reserved as general purpose set.
 		 */
-		for (data.bis = 0x01; data.bis < hdev->le_num_of_adv_sets;
-		     data.bis++) {
-			data.count = 0;
+		for (bis = 0x01; bis < hdev->le_num_of_adv_sets;
+		     bis++) {
 
-			hci_conn_hash_list_state(hdev, bis_list, ISO_LINK,
-						 BT_BOUND, &data);
-			if (!data.count)
+			conn = hci_conn_hash_lookup_bis(hdev, BDADDR_ANY, bis);
+			if (!conn)
 				break;
 		}
 
-		if (data.bis == hdev->le_num_of_adv_sets)
+		if (bis == hdev->le_num_of_adv_sets)
 			return -EADDRNOTAVAIL;
 
 		/* Update BIS */
-		qos->bcast.bis = data.bis;
+		qos->bcast.bis = bis;
 	}
 
 	return 0;
@@ -1534,8 +1529,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	/* Check BIS settings against other bound BISes, since all
 	 * BISes in a BIG must have the same value for all parameters
 	 */
-	conn = hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big,
-					qos->bcast.bis);
+	conn = hci_conn_hash_lookup_big(hdev, qos->bcast.big);
 
 	if (conn && (memcmp(qos, &conn->iso_qos, sizeof(*qos)) ||
 		     base_len != conn->le_per_adv_data_len ||
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7c199f7361f7..d6ec00b12030 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1639,7 +1639,7 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_dev *hdev, void *data,
 
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
-		if (adv)
+		if (adv && !adv->periodic)
 			adv->enabled = true;
 
 		conn = hci_lookup_le_connect(hdev);
@@ -3938,24 +3938,47 @@ static u8 hci_cc_le_set_per_adv_enable(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
 	struct hci_ev_status *rp = data;
-	__u8 *sent;
+	struct hci_cp_le_set_per_adv_enable *cp;
+	struct adv_info *adv = NULL, *n;
+	u8 per_adv_cnt = 0;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
 		return rp->status;
 
-	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE);
-	if (!sent)
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE);
+	if (!cp)
 		return rp->status;
 
 	hci_dev_lock(hdev);
 
-	if (*sent)
+	adv = hci_find_adv_instance(hdev, cp->handle);
+
+	if (cp->enable) {
 		hci_dev_set_flag(hdev, HCI_LE_PER_ADV);
-	else
+
+		if (adv)
+			adv->enabled = true;
+	} else {
+		/* If just one instance was disabled check if there are
+		 * any other instance enabled before clearing HCI_LE_PER_ADV.
+		 * The current periodic adv instance will be marked as
+		 * disabled once extended advertising is also disabled.
+		 */
+		list_for_each_entry_safe(adv, n, &hdev->adv_instances,
+					 list) {
+			if (adv->periodic && adv->enabled)
+				per_adv_cnt++;
+		}
+
+		if (per_adv_cnt > 1)
+			goto unlock;
+
 		hci_dev_clear_flag(hdev, HCI_LE_PER_ADV);
+	}
 
+unlock:
 	hci_dev_unlock(hdev);
 
 	return rp->status;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 97da5bcaa904..affc661eb7d0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3,6 +3,7 @@
  * BlueZ - Bluetooth protocol stack for Linux
  *
  * Copyright (C) 2021 Intel Corporation
+ * Copyright 2023 NXP
  */
 
 #include <linux/property.h>
@@ -1319,9 +1320,11 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
 static int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_per_adv_enable cp;
+	struct adv_info *adv = NULL;
 
 	/* If periodic advertising already disabled there is nothing to do. */
-	if (!hci_dev_test_flag(hdev, HCI_LE_PER_ADV))
+	adv = hci_find_adv_instance(hdev, instance);
+	if (!adv || !adv->periodic || !adv->enabled)
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1386,9 +1389,11 @@ static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
 static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_per_adv_enable cp;
+	struct adv_info *adv = NULL;
 
 	/* If periodic advertising already enabled there is nothing to do. */
-	if (hci_dev_test_flag(hdev, HCI_LE_PER_ADV))
+	adv = hci_find_adv_instance(hdev, instance);
+	if (adv && adv->periodic && adv->enabled)
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -1458,22 +1463,19 @@ int hci_start_per_adv_sync(struct hci_dev *hdev, u8 instance, u8 data_len,
 						   sync_interval);
 			if (IS_ERR(adv))
 				return PTR_ERR(adv);
+			adv->pending = false;
 			added = true;
 		}
 	}
 
-	/* Only start advertising if instance 0 or if a dedicated instance has
-	 * been added.
-	 */
-	if (!adv || added) {
-		err = hci_start_ext_adv_sync(hdev, instance);
-		if (err < 0)
-			goto fail;
+	/* Start advertising */
+	err = hci_start_ext_adv_sync(hdev, instance);
+	if (err < 0)
+		goto fail;
 
-		err = hci_adv_bcast_annoucement(hdev, adv);
-		if (err < 0)
-			goto fail;
-	}
+	err = hci_adv_bcast_annoucement(hdev, adv);
+	if (err < 0)
+		goto fail;
 
 	err = hci_set_per_adv_params_sync(hdev, instance, min_interval,
 					  max_interval);
-- 
2.34.1

