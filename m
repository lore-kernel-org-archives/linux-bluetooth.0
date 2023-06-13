Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F7EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 14:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242582AbjFMOUv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242774AbjFMOUr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 10:20:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EB119A
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 07:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5H3ct6ip+uaCaVaEY7+oyTsEZD7AnIWt74FUc+gs7nqpf1cKYdE+0FLM0bbL6fjAfWF/6BkTMPWkXy1qugdpAkHeaL9h05t+YPsVOhk7Y2IM6ojcCH/Dysq6BJzrRgjZoXM8SX9317VqlBX4M+5dZpB/DFj5dWCwdEOO4gQCP8/Oi2T/VQOr9tlbgd8EokMDqORwBlngcuxz+TCT/WFbm/tlbXXUt47BFujjFLj9RADKZPZyXNmpo7UgPqcARcCHu2K23rQcTNT8sCB/HfgyemQlBoNkLrRYSA6APgkzmRzlu/w66lTNA5A8lZe09RIlF2lOHcp4nY7VAW4r871xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ca6d9EoR05vAJFvSNPQLUtn12v2JE1aMve4f95eZT4=;
 b=oWlePhYPE75ldDXn88WEawU6T60+8VCheZueOB49hW9uFbdp4bvyhT7TCYpxZcvgZgcUJnfDPYkQmbROl/bVOh4ZCg0moOHbet9DoVvmAzoMCDakg5jE/2DhfG7pO9WketWeHLLkYDaXd4ZkZIXk4nCoUd80ug2/JapF7+/cke/xmvskwBlIlfCJ0HuHiuGnogfM5HM2wXaqPgubB3mb4/kO8m/H60dVHuzIuWy6jGqc0Y8echAvCcmi21sHSur4wE9vwuuHnSqvhE4Q3HbJrAmepTRYEW/Y7BhNnWsmo+p+obBLjtI8SONdcmtJIxGVV8D9XhzhKGcdKIufU+YmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ca6d9EoR05vAJFvSNPQLUtn12v2JE1aMve4f95eZT4=;
 b=D4XQ/3Hms8fNjEPSD/ereVy3tgPFd0iKSWT30HovxmpNUn3uV5m3tJKhHF+YBiI60VwektoPvQ59nrAdh+sN0VfCW6Y2BEsmQLB2T0z9wsVb4JU2XFNcRMZmPJMiWWDjD0zHOu4p7uPoUyATWxtmPWNTyDqCyD0QqNXsBGNJQuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7076.eurprd04.prod.outlook.com (2603:10a6:208:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 14:20:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 14:20:39 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, silviu.barbulescu@nxp.com,
        andrei.istodorescu@nxp.com, mihai-octavian.urzica@nxp.com,
        vlad.pruteanu@nxp.com, Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Support multiple BIGs
Date:   Tue, 13 Jun 2023 17:20:17 +0300
Message-Id: <20230613142017.9337-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613142017.9337-1-iulia.tanasescu@nxp.com>
References: <20230613142017.9337-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: e53c04f8-2171-44f0-96fb-08db6c195d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSy64CdOPIEda8+0DIvIWfCq1tqkYbYMU1lRLD3zh7usDVsPSeGdrdXezl9H5gcEZhLX2JVcg2umu6UMPPg505qs23lCL7F2Ql73cO2PbjckqAC0z53SIffutIK8rEaY5iuxp5mC0g8Z1tWkFaHrV1HaiLk9+/P8tHA/+EsLqxZs/0wDot88X5/L210+Gf5BJquIyYVqYlIhkXO6tGvSeNsk0gTi505peOjk4MjLVbDNIl2JZr/skQHo+oRsN4PzKZTWZ4xshdv250O0pUKsqeD+jrfT5XbKg17fpDPgtherfd6lRmii8wlZ6JkMtVN0cnIx8c4Xunx63J8MaF8BfTs8dkHsFrZaSFqedyQenOSkXOmHC0ohVmElRQtFPZb6VsvRduUysg3t+1vr0XQfpQWKQarhBoDrcSUmaMNJ3zpdY7fhkWu4zPmaEItLxd9JzbPniflBwI23GkCMnoQw+ORt+880X0GFgZNmKJaUj5KlsRMCLcRMPH9tCITJ4kAH9MugORaK1+QjiRDuK4dYDz+yfDxuzKUPDSWUSrKS/G+MV85BmFtCT3j6BRka36KUd6atjsgqcoP+s7xXHM9CJX1ARPypdbK7eYYOgh3+XqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(6666004)(52116002)(6486002)(36756003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(6506007)(6512007)(1076003)(26005)(186003)(5660300002)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(2906002)(8936002)(8676002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+zOjdoTuvNstmc8a0g04g5kYPF1IHJdy5bCXECKF7TOfweP/n6a49vKTB0i?=
 =?us-ascii?Q?kOwuNpYVZZzewkq0lhrMqZkBWXTrmvI6j3gbUJDE6VPqsBiN15NVP5g52J4n?=
 =?us-ascii?Q?2BEc0mMMdSQBzpomBE3ltGHIy5hfYCumdZsIMQdGxBCmwNqlJOOk65krL4Jo?=
 =?us-ascii?Q?en2gRoGhb6ehix8nvEsO7agOaVXb+CCM2sl1RuvvSeiDd883SgFHiqdO/GQR?=
 =?us-ascii?Q?TlOtvW/d8aSVtUwL5WWF78kYwGOLtB40NbMG+6rOA2LxYr6hZdhwFoOMWs2f?=
 =?us-ascii?Q?RhCbKhkZUHHdLsV08/N7r14tWU7l+9tHltEkJmsjfRHmDILZsFzYUggpx7Q/?=
 =?us-ascii?Q?uchl2YwOuENZoLfFLCvsmCgKQt5D6nG3edrtS3lzagY8l1CCG2VPxBiqPCzW?=
 =?us-ascii?Q?aKmvXq8Zfer3/Rum86wFMWfr82HhGUGr5SMhJ2ODUVdiAXCXl+eHSN1A+t9X?=
 =?us-ascii?Q?saZ2GjvPi4fjYuo0iw4abYJMzT7dWiTmj/Kcw5aIXNiUjHnS7jj3CixyuW6J?=
 =?us-ascii?Q?ff/oV2u+RfLAh6d+1tCmsIa667CXnZAqUkdMZbUKN9VMSRWLRp5UMbPmxI6a?=
 =?us-ascii?Q?99iHxF+QA4/l42vAI7ERhGa/fBKfz/m9EywCCJXaAzblRVetkl4DR86RAlN2?=
 =?us-ascii?Q?HNoWJkphkBMstVFmxjRP41OTgVaVScmv/6K/ZMDMuktS70zYCfrx+3gDIAnw?=
 =?us-ascii?Q?DyWZli3ScBazAhVb4+RNY3Kg4rf2ocw3n8J9MhZm+mlzIb6u/5gltyBtlfhH?=
 =?us-ascii?Q?X01H9gOPP+2VIawyulyB88zSClMoe/kspafABTIVObKsCjO67k1nyAX6u++h?=
 =?us-ascii?Q?PoyaSa5+8wQ9+vleAqTTqaGc1OiEcTrT2XiT1q/BMTywE8yLB586YRzH01zQ?=
 =?us-ascii?Q?+eAbjutSq7IyoB2HxOdDz4NPmjZQ/c+gtJUAZZaCIBxjPRai2j1wMgJleXec?=
 =?us-ascii?Q?3oQ/hQuLFQrIjPXjkbdOs9Sb2NVgtbfUXMhNjsn/S0Tv/FbX7YTCEUaqOQH6?=
 =?us-ascii?Q?nBCogbU36ZGZQcrIDfK0uY0nJETujGDkTRODY4G6e4jLuIanAe5z0O6wXTNZ?=
 =?us-ascii?Q?Qnx6CmcqngqhSWXa58lU0+kHRJtdaEP5QYLY9TqYXGmLOZogJgEKjDPs+l94?=
 =?us-ascii?Q?Vq1gK1rr8fNMy3qxC0/SjiHHzUUKZispYOPuhe4Tt/HRxWaJT02YThzjDWTy?=
 =?us-ascii?Q?n+Bh0KaREPkqTHbC66OWt7OxZA921B9jDu5FLlRREaeXpsp1f1sMBPShlnQ7?=
 =?us-ascii?Q?R1nlBc59K3p6NL41ULnI5d3xumxTyHTcvfYWSrQzFRgYfogIZ4d2Tbq85hUT?=
 =?us-ascii?Q?v8e5dsncsB6r5xHtfZIKa+rvdm5TgHTp3LWktXpi4pu7wjT1sPqzETY8Ft5D?=
 =?us-ascii?Q?diQS9j5gripyzGG0y1R9OaCVg+Sr3l6lSqOCH93w8gDwLbLeISyEKk46aCRh?=
 =?us-ascii?Q?GVWw4qHJ0DyeAYcdMXqYjJKoiTiSqVaSySNEqc+bcFkqnEVgB7F6yYmtkQNt?=
 =?us-ascii?Q?LsJRe1lXunCAuk5LcgYetjf2PdTZYA4fWah9i1jUWOY5qCIheblDR0eVx1j6?=
 =?us-ascii?Q?JoMspbKcG6wuG2OGfSoLQTv2YZEByvzB/DrIkR1VhN3E2pYjkBBZPlJpBjiY?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53c04f8-2171-44f0-96fb-08db6c195d37
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:20:39.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpFWJ7OcXBXMoffCNBG/7hBWQ9/auuBQSBK9c/osCpbJtqTu2upSHtFVavqgEm4kUdOsX1tr4krQfjiZO4FTkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7076
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
 include/net/bluetooth/hci_core.h |  6 ++---
 net/bluetooth/hci_conn.c         | 40 ++++++++++++++------------------
 net/bluetooth/hci_event.c        | 30 ++++++++++++++++++++----
 net/bluetooth/hci_sync.c         |  9 +++++--
 4 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 683666ea210c..b5af9be70771 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -240,6 +240,7 @@ struct adv_info {
 	bool	enabled;
 	bool	pending;
 	bool	periodic;
+	bool	per_enabled;
 	__u8	mesh;
 	__u8	instance;
 	__u32	flags;
@@ -1096,8 +1097,7 @@ static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
-							bdaddr_t *ba,
-							__u8 big, __u8 bis)
+							bdaddr_t *ba, __u8 bis)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1108,7 +1108,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
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
index 7c199f7361f7..45525963e932 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3938,24 +3938,44 @@ static u8 hci_cc_le_set_per_adv_enable(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
 	struct hci_ev_status *rp = data;
-	__u8 *sent;
+	struct hci_cp_le_set_per_adv_enable *cp;
+	struct adv_info *adv = NULL, *n;
 
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
+			adv->per_enabled = true;
+	} else {
+		if (adv)
+			adv->per_enabled = false;
+
+		/* If just one instance was disabled check if there are
+		 * any other instance enabled before clearing HCI_LE_PER_ADV
+		 */
+		list_for_each_entry_safe(adv, n, &hdev->adv_instances,
+					 list) {
+			if (adv->per_enabled)
+				goto unlock;
+		}
+
 		hci_dev_clear_flag(hdev, HCI_LE_PER_ADV);
+	}
 
+unlock:
 	hci_dev_unlock(hdev);
 
 	return rp->status;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 97da5bcaa904..2fd7ab377d30 100644
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
+	if (!adv || !adv->per_enabled)
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
+	if (adv && adv->per_enabled)
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
-- 
2.34.1

