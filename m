Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB2FC77B73
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjE3OYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjE3OYV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:24:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47289E7F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJg5X+vz2cTy6M/LGIr/7myL7RoBHD613AI8pebJwroG8LSbj66CwNTReM5bgFfEr9KNwMlqngndUmza+M2Pe6J+F6cFMgIMrR9lWXY64+aqHqUwzUuypdIJiks8Iw1PCkFwLSudM3Z7q6WfwCgYerhXv4ivw11eg9vwXtccuUjvz50mKYmeaMAdICql4W3JBzRPRlnb/dW5Wwr3wdkeMaddmLblAXbWoGOo15PacG6NnjpZjvCV9LXAaVe0brlFSuOIq1+L9VcYzb9jtEaESiDDgMz9dSef0oHQ7/7eR+NE7mGT45aMCTDfmNMwTPTnjs/36UHvCoTDuqxBZEHaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHMMIZ9fKPTKi0Wz9ZeC0aPvdyq7spXPOigDBRkq0Os=;
 b=bYXnOW3D2ZuXbZN4RNt5OathIyrZP0IULw+Y/XvZH7EMWQRyTFybCHxYSoGHhxnuxQ1Ot4qE2p5zEBRew8xEO5FfptCuUP+BiPR8vtO3yUKAwdEzK2zGHemysO3g1tdAHwoDXTXJvS/QEEjuYOWvKN6bK9OsT8UXIH+1eCAnPclBj0LlYPsPtqGMW5HawWy2OEeFMPzSswjzYvghlCQZlPUnzQOOJ6L6AMmdiAX9UxIr4jjtqHAKFEDUv1EXXh3ep/T7ADzdA5gwdTCS1Qs2UMwDc0WxnwwqY4cKHhlp2LD6njGAWGnif/Vs8vmeEdlvGxMt4b+FjNp6lyzzaZFV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHMMIZ9fKPTKi0Wz9ZeC0aPvdyq7spXPOigDBRkq0Os=;
 b=OZ6X9VFcuHjpYcRVifDP6Hx+IprR5/rqE30rJc6fqz1afXurWITPntU2WlMQBk4pEJjdpCVcQBY6DJVO8D8RpjJNZbAhpOubLfhAJ4wVtdPCD+giTRKUTxnVENxI2UmLMr3BItv5GG7G1VNv937huUZz41Xiy/4LHRDP6IUQyfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9324.eurprd04.prod.outlook.com (2603:10a6:10:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 14:22:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 14:22:25 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Add support for connecting multiple BISes
Date:   Tue, 30 May 2023 17:21:59 +0300
Message-Id: <20230530142159.410567-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530142159.410567-1-iulia.tanasescu@nxp.com>
References: <20230530142159.410567-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7039fde9-8e59-47a4-7151-08db61194a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nc6KpYEWiIY4eh/6JSCrlFOariTd3UdrQFPbfhAGAgms5ErMKZ4Pq6SwHVh1uChZZjSe+wAliFabloTy7b4kmExg94AQvmipzO1ZfS6Q8llJUWdQI4gvY8eZVreP4MzN96hwjkALpyiAYrGh14eoFY/paiKai5FNez0e3Wdh8OJcRy+epvfU3Zp35SbG/VezPNhdu3OiJgRod1P/UWILH5akI1Iz1BDiBZaX2uIfTn0oylG8M8ZyAxo/3Y1JTqXCHNuPP/wxkjKfKijaJvaStphk7vO78/y1J/FkM6Dp6PIaka/62keWng29xHD7DeVchzakeEDbN70OTQihZwjSpk9FugvvN2rbX1N4xbCZfyi9n8M6cY0ntjyF6Vt06a9VAE7i5NH6hvjwcBpE5OdEVqxQi1zKbmNDCHkRVK9Hov+2OFbjF1v0sCn9w/ys1zPQFpGEE9cX/nnDqRuOpkT53R5004WmqpPDQHVGJwQAWhU3gaagZ5PGqJZQbuY6PzmWKlBIr07zOwC4aQag24N5BXdxV68CM9FVWnCz7ctUr8ztpleHOPpkGYsqU/11HiLrca25YrS9dF//gA2y0CJkfViRaU1QXZpbcAggQIJHfyq2S63mfPzHo0WAiIX7sCZk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(478600001)(30864003)(2906002)(186003)(1076003)(26005)(6506007)(6512007)(5660300002)(8936002)(8676002)(2616005)(38100700002)(83380400001)(38350700002)(6486002)(52116002)(41300700001)(86362001)(316002)(6666004)(4326008)(36756003)(44832011)(66476007)(66556008)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JNg/88Vt41MxQblG6NOTDjsY2mHoFwtxiQUf0aLjXqPHx5ZWRHcd47YnwdOO?=
 =?us-ascii?Q?bEYTXA/F39GPMfg/o3tVv1JH5QQ8rLBeEIX5yltvbiHolt/9IWq5w0ihA1C6?=
 =?us-ascii?Q?zcoY/5yCNp6uOu/ezOmtslqDnWK2yn6dmAB05DUuvqZAxRreS2LpKrrZHNw6?=
 =?us-ascii?Q?bIegBk20+MSBMAPDu/dcKhRVq3rSreFPMIPohHTj4syjUnvAQ+h1nSWcrjtT?=
 =?us-ascii?Q?ZYpIiKeJRvwuBOFHNLxkwwgPgqXJ/cA7UUPO24pO6IkTUYFb0OKLagomMvoY?=
 =?us-ascii?Q?sucfkNvbeEP5MZDQIgZahPuI2Azy8itbFPAJGMpV8QwozFPwm1zkBcUbvgtU?=
 =?us-ascii?Q?HQWubC9jLkm5C7c0yCMJ009AZaZ4T3Sng7A2yVlMYnC6MBfO1NBRPaIg5PQo?=
 =?us-ascii?Q?23ajQjorzKcKVpamk6ynlM0ZfbyXgamqy9BZhAA5rwxQ4t2cKKh+XymaAKQY?=
 =?us-ascii?Q?oCSvedypjszY8uFfhwak/s6hatMeDIUlPPxQutHXzAkQ6cY0rvqPCbhFpqtn?=
 =?us-ascii?Q?wAfQKLDQDgwEU/rDNSqG6VqHjWC5HwUdfYSNaEPP0nu4BVoWMTnYnZHO8HZU?=
 =?us-ascii?Q?i3RAIR/M6AVDRygoTVpYia09TY/pLKVb/2uHAArjy3sZNcFMWbGXCIYvUo0D?=
 =?us-ascii?Q?qDedglbwc4F7CVEMm25YOFe0w6dSk4CLgu17HYTcl232dEBY1yHigcsjPwt2?=
 =?us-ascii?Q?OHBA/xthHnkgQMJOS3FzVTU6P6k41nmrT2TaGZ5K9qLTGoOhPhcKAmadzJFc?=
 =?us-ascii?Q?CRBWySoLQzfgT0J8EzDSO2YW+MJ/kRgCtCIMVXlBsB3m6Vcwz1Pq0ALA04wH?=
 =?us-ascii?Q?vpnwxyQFYRg09Eo6poWJJXHRRZn5fY5jUlFXDKfV4ndfDp3nj86jv/Eoy1AS?=
 =?us-ascii?Q?h08Sdphlm5LqMzBXiyJqWCg7+Z4jjzW3j4CphWAQYfUaJJu8j0EjPZxHQNuH?=
 =?us-ascii?Q?WzOanNZYzK5JqGiuOrDn1oS9WPuE5XHrdS1Y0wpUA3+q1EVN0hHK0/Y6rMtR?=
 =?us-ascii?Q?RgT/PLTL7ydP9fcyp+q0T3+1xhxXOLyIn4z6cqSo4Fzlcp5ubsOuhZnYZlq0?=
 =?us-ascii?Q?JOlYiRdTMNVHKMtZCD8Mp5D8YW9uI7RiIgA8c7v7ZQ4az62NGlK8OPuKjUs1?=
 =?us-ascii?Q?5vxMuVwhkBWxEwjPFnnkSovnxQG1mMtIP6wqt57E5S2N6F6eFK2oaAdfsWEf?=
 =?us-ascii?Q?KA7dKOTCMsgZzfnXgKZUIwmBhZngKIJ/1P4inwRp4nmP1aa8Enl8QKPzFq0B?=
 =?us-ascii?Q?dx7TLdViJePT226NOf7/X1mEnFLAWBUDMjsFR8dM7Jgskb6wpsG+xWffzY08?=
 =?us-ascii?Q?S5Q6iE3gdxaC3/V8t6OeqjpZtfaPuAB0RNFtPIJHNv+7HcfB2ejxmbdK1z8/?=
 =?us-ascii?Q?X9tA7YnYSTmfzt/G1/OfEZbuGX2b6SousDg3BDu6gpyR13AEDI91uIn+vR85?=
 =?us-ascii?Q?6XzpFlDmALWvMK7P0Ot+CJgx3DtBb62JAAY5APIOWLQAP6VCpeY3Zhs1c904?=
 =?us-ascii?Q?B+Kl4Q5yGvA9VOQTGu9YVnWL7WRsNV26wG9xTDnI4ErY9kzdpkWMwLW5q6gz?=
 =?us-ascii?Q?HPFhfg+vniKCbakGt84dUwChgeAWCXhA2R1KJc5AwdMnWCHRkfDfUA9ynvT5?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7039fde9-8e59-47a4-7151-08db61194a4a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 14:22:25.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cqu6DoRrBkpfCb+noNI/9wV8z+SPsvd61C1bOvVAG2NIGXuLmHpv0yAOWEUuJ+sBVu4XIVErb8WzJCJ08mwTvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is required for some configurations to have multiple BISes as part
of the same BIG.

Similar to the flow implemented for unicast, DEFER_SETUP will also be
used to bind multiple BISes for the same BIG, before starting Periodic
Advertising and creating the BIG.

The user will have to open a new socket for each BIS. By setting the
BT_DEFER_SETUP socket option and calling connect, a new connection
will be added for the BIG and advertising handle set by the socket
QoS parameters. Since all BISes will be bound for the same BIG and
advertising handle, the socket QoS options and base parameters should
match for all connections.

By calling connect on a socket that does not have the BT_DEFER_SETUP
option set, periodic advertising will be started and the BIG will
be created, with a BIS for each previously bound connection. Since
a BIG cannot be reconfigured with additional BISes after creation,
no more connections can be bound for the BIG after the start periodic
advertising and create BIG commands have been queued.

The bis_cleanup function has also been updated, so that the advertising
set and the BIG will not be terminated unless there are no more
bound or connected BISes.

The HCI_CONN_BIG_CREATED connection flag has been added to indicate
that the BIG has been successfully created. This flag is checked at
bis_cleanup, so that the BIG is only terminated if the
HCI_LE_Create_BIG_Complete has been received.

This implementation has been tested on hardware, using the "isotest"
tool with an additional command line option, to specify the number of
BISes to create as part of the desired BIG:

    tools/isotest -i hci0 -s 00:00:00:00:00:00 -N 2 -G 1 -T 1

The btmon log shows that a BIG containing 2 BISes has been created:

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 31
        Handle: 0x01
        Advertising Handle: 0x01
        Number of BIS: 2
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

> HCI Event: LE Meta Event (0x3e) plen 23
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x01
        BIG Synchronization Delay: 1974 us (0x0007b6)
        Transport Latency: 1974 us (0x0007b6)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
        Connection Handle #1: 11

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration:

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 11
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration:

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 11

< ISO Data TX: Handle 10 flags 0x02 dlen 44

< ISO Data TX: Handle 11 flags 0x02 dlen 44

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 10
        Count: 1

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 11
        Count: 1

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h |  30 ++++++
 net/bluetooth/hci_conn.c         | 152 +++++++++++++++++++++----------
 net/bluetooth/hci_event.c        |  50 ++++++----
 net/bluetooth/iso.c              |  28 ++++--
 4 files changed, 187 insertions(+), 73 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9f37326c1c05..74ec1f40ab6b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -975,6 +975,7 @@ enum {
 	HCI_CONN_SCANNING,
 	HCI_CONN_AUTH_FAILURE,
 	HCI_CONN_PER_ADV,
+	HCI_CONN_BIG_CREATED,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -1116,6 +1117,32 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *
+hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hdev,
+				 bdaddr_t *ba,
+				 __u8 big, __u8 bis)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (bacmp(&c->dst, ba) || c->type != ISO_LINK ||
+			!test_bit(HCI_CONN_PER_ADV, &c->flags))
+			continue;
+
+		if (c->iso_qos.bcast.big == big &&
+		    c->iso_qos.bcast.bis == bis) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 								__u16 handle)
 {
@@ -1351,6 +1378,9 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 			      __u8 dst_type, struct bt_iso_qos *qos);
+struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
+			      struct bt_iso_qos *qos,
+			      __u8 base_len, __u8 *base);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, struct bt_iso_qos *qos);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1f906f8508bc..795b2daa5bac 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -790,6 +790,7 @@ struct iso_list_data {
 		struct hci_cp_le_set_cig_params cp;
 		struct hci_cis_params cis[0x11];
 	} pdu;
+	bool big_term;
 };
 
 static void bis_list(struct hci_conn *conn, void *data)
@@ -826,11 +827,8 @@ static int terminate_big_sync(struct hci_dev *hdev, void *data)
 
 	hci_remove_ext_adv_instance_sync(hdev, d->bis, NULL);
 
-	/* Check if ISO connection is a BIS and terminate BIG if there are
-	 * no other connections using it.
-	 */
-	hci_conn_hash_list_state(hdev, find_bis, ISO_LINK, BT_CONNECTED, d);
-	if (d->count)
+	/* Only terminate BIG if it has been created */
+	if (!d->big_term)
 		return 0;
 
 	return hci_le_terminate_big_sync(hdev, d->big,
@@ -842,19 +840,21 @@ static void terminate_big_destroy(struct hci_dev *hdev, void *data, int err)
 	kfree(data);
 }
 
-static int hci_le_terminate_big(struct hci_dev *hdev, u8 big, u8 bis)
+static int hci_le_terminate_big(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	struct iso_list_data *d;
 	int ret;
 
-	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", big, bis);
+	bt_dev_dbg(hdev, "big 0x%2.2x bis 0x%2.2x", conn->iso_qos.bcast.big,
+		   conn->iso_qos.bcast.bis);
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
 
-	d->big = big;
-	d->bis = bis;
+	d->big = conn->iso_qos.bcast.big;
+	d->bis = conn->iso_qos.bcast.bis;
+	d->big_term = test_and_clear_bit(HCI_CONN_BIG_CREATED, &conn->flags);
 
 	ret = hci_cmd_sync_queue(hdev, terminate_big_sync, d,
 				 terminate_big_destroy);
@@ -914,6 +914,7 @@ static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16 sync_handle)
 static void bis_cleanup(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+	struct hci_conn *bis;
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
@@ -921,8 +922,16 @@ static void bis_cleanup(struct hci_conn *conn)
 		if (!test_and_clear_bit(HCI_CONN_PER_ADV, &conn->flags))
 			return;
 
-		hci_le_terminate_big(hdev, conn->iso_qos.bcast.big,
-				     conn->iso_qos.bcast.bis);
+		/* Check if ISO connection is a BIS and terminate advertising
+		 * set and BIG if there are no other connections using it.
+		 */
+		bis = hci_conn_hash_lookup_bis(hdev, BDADDR_ANY,
+					       conn->iso_qos.bcast.big,
+					       conn->iso_qos.bcast.bis);
+		if (bis)
+			return;
+
+		hci_le_terminate_big(hdev, conn);
 	} else {
 		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
 				     conn->sync_handle);
@@ -1491,10 +1500,10 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				    struct bt_iso_qos *qos)
+				    struct bt_iso_qos *qos, __u8 base_len,
+				    __u8 *base)
 {
 	struct hci_conn *conn;
-	struct iso_list_data data;
 	int err;
 
 	/* Let's make sure that le is enabled.*/
@@ -1512,24 +1521,27 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (err)
 		return ERR_PTR(err);
 
-	data.big = qos->bcast.big;
-	data.bis = qos->bcast.bis;
-	data.count = 0;
-
-	/* Check if there is already a matching BIG/BIS */
-	hci_conn_hash_list_state(hdev, bis_list, ISO_LINK, BT_BOUND, &data);
-	if (data.count)
+	/* Check if the LE Create BIG command has already been sent */
+	conn = hci_conn_hash_lookup_per_adv_bis(hdev, dst, qos->bcast.big,
+						qos->bcast.big);
+	if (conn)
 		return ERR_PTR(-EADDRINUSE);
 
-	conn = hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big, qos->bcast.bis);
-	if (conn)
+	/* Check BIS settings against other bound BISes, since all
+	 * BISes in a BIG must have the same value for all parameters
+	 */
+	conn = hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big,
+					qos->bcast.bis);
+
+	if (conn && (memcmp(qos, &conn->iso_qos, sizeof(*qos)) ||
+		     base_len != conn->le_per_adv_data_len ||
+		     memcmp(conn->le_per_adv_data, base, base_len)))
 		return ERR_PTR(-EADDRINUSE);
 
 	conn = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	set_bit(HCI_CONN_PER_ADV, &conn->flags);
 	conn->state = BT_CONNECT;
 
 	hci_conn_hold(conn);
@@ -1743,12 +1755,21 @@ static int hci_le_create_big(struct hci_conn *conn, struct bt_iso_qos *qos)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_create_big cp;
+	struct iso_list_data data;
 
 	memset(&cp, 0, sizeof(cp));
 
+	data.big = qos->bcast.big;
+	data.bis = qos->bcast.bis;
+	data.count = 0;
+
+	/* Create a BIS for each bound connection */
+	hci_conn_hash_list_state(hdev, bis_list, ISO_LINK,
+				 BT_BOUND, &data);
+
 	cp.handle = qos->bcast.big;
 	cp.adv_handle = qos->bcast.bis;
-	cp.num_bis  = 0x01;
+	cp.num_bis  = data.count;
 	hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
 	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
 	cp.bis.latency =  cpu_to_le16(qos->bcast.out.latency);
@@ -2020,16 +2041,6 @@ static void hci_iso_qos_setup(struct hci_dev *hdev, struct hci_conn *conn,
 		qos->latency = conn->le_conn_latency;
 }
 
-static void hci_bind_bis(struct hci_conn *conn,
-			 struct bt_iso_qos *qos)
-{
-	/* Update LINK PHYs according to QoS preference */
-	conn->le_tx_phy = qos->bcast.out.phy;
-	conn->le_tx_phy = qos->bcast.out.phy;
-	conn->iso_qos = *qos;
-	conn->state = BT_BOUND;
-}
-
 static int create_big_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn = data;
@@ -2152,27 +2163,80 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	}
 }
 
-struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos,
-				 __u8 base_len, __u8 *base)
+struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
+			      struct bt_iso_qos *qos,
+			      __u8 base_len, __u8 *base)
 {
 	struct hci_conn *conn;
-	int err;
+	__u8 eir[HCI_MAX_PER_AD_LENGTH];
+
+	if (base_len && base)
+		base_len = eir_append_service_data(eir, 0,  0x1851,
+						   base, base_len);
 
 	/* We need hci_conn object using the BDADDR_ANY as dst */
-	conn = hci_add_bis(hdev, dst, qos);
+	conn = hci_add_bis(hdev, dst, qos, base_len, eir);
 	if (IS_ERR(conn))
 		return conn;
 
-	hci_bind_bis(conn, qos);
+	/* Update LINK PHYs according to QoS preference */
+	conn->le_tx_phy = qos->bcast.out.phy;
+	conn->le_tx_phy = qos->bcast.out.phy;
 
 	/* Add Basic Announcement into Peridic Adv Data if BASE is set */
 	if (base_len && base) {
-		base_len = eir_append_service_data(conn->le_per_adv_data, 0,
-						   0x1851, base, base_len);
+		memcpy(conn->le_per_adv_data,  eir, sizeof(eir));
 		conn->le_per_adv_data_len = base_len;
 	}
 
+	hci_iso_qos_setup(hdev, conn, &qos->bcast.out,
+			  conn->le_tx_phy ? conn->le_tx_phy :
+			  hdev->le_tx_def_phys);
+
+	conn->iso_qos = *qos;
+	conn->state = BT_BOUND;
+
+	return conn;
+}
+
+static void bis_mark_per_adv(struct hci_conn *conn, void *data)
+{
+	struct iso_list_data *d = data;
+
+	/* Skip if not broadcast/ANY address */
+	if (bacmp(&conn->dst, BDADDR_ANY))
+		return;
+
+	if (d->big != conn->iso_qos.bcast.big ||
+	    d->bis == BT_ISO_QOS_BIS_UNSET ||
+	    d->bis != conn->iso_qos.bcast.bis)
+		return;
+
+	set_bit(HCI_CONN_PER_ADV, &conn->flags);
+}
+
+struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
+				 __u8 dst_type, struct bt_iso_qos *qos,
+				 __u8 base_len, __u8 *base)
+{
+	struct hci_conn *conn;
+	int err;
+	struct iso_list_data data;
+
+	conn = hci_bind_bis(hdev, dst, qos, base_len, base);
+	if (IS_ERR(conn))
+		return conn;
+
+	data.big = qos->bcast.big;
+	data.bis = qos->bcast.bis;
+
+	/* Set HCI_CONN_PER_ADV for all bound connections, to mark that
+	 * the start periodic advertising and create BIG commands have
+	 * been queued
+	 */
+	hci_conn_hash_list_state(hdev, bis_mark_per_adv, ISO_LINK,
+				 BT_BOUND, &data);
+
 	/* Queue start periodic advertising and create BIG */
 	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
 				 create_big_complete);
@@ -2181,10 +2245,6 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(err);
 	}
 
-	hci_iso_qos_setup(hdev, conn, &qos->bcast.out,
-			  conn->le_tx_phy ? conn->le_tx_phy :
-			  hdev->le_tx_def_phys);
-
 	return conn;
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d00ef6e3fc45..c24958af525a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6910,6 +6910,7 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 {
 	struct hci_evt_le_create_big_complete *ev = data;
 	struct hci_conn *conn;
+	__u8 bis_idx = 0;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -6918,33 +6919,42 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		return;
 
 	hci_dev_lock(hdev);
+	rcu_read_lock();
 
-	conn = hci_conn_hash_lookup_big(hdev, ev->handle);
-	if (!conn)
-		goto unlock;
+	/* Connect all BISes that are bound to the BIG */
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (bacmp(&conn->dst, BDADDR_ANY) ||
+		    conn->type != ISO_LINK ||
+		    conn->iso_qos.bcast.big != ev->handle)
+			continue;
 
-	if (conn->type != ISO_LINK) {
-		bt_dev_err(hdev,
-			   "Invalid connection link type handle 0x%2.2x",
-			   ev->handle);
-		goto unlock;
-	}
+		conn->handle = __le16_to_cpu(ev->bis_handle[bis_idx++]);
 
-	if (ev->num_bis)
-		conn->handle = __le16_to_cpu(ev->bis_handle[0]);
+		if (!ev->status) {
+			conn->state = BT_CONNECTED;
+			set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
+			hci_debugfs_create_conn(conn);
+			hci_conn_add_sysfs(conn);
+			hci_iso_setup_path(conn);
+			continue;
+		}
 
-	if (!ev->status) {
-		conn->state = BT_CONNECTED;
-		hci_debugfs_create_conn(conn);
-		hci_conn_add_sysfs(conn);
-		hci_iso_setup_path(conn);
-		goto unlock;
+		hci_connect_cfm(conn, ev->status);
+		rcu_read_unlock();
+		hci_conn_del(conn);
+		rcu_read_lock();
 	}
 
-	hci_connect_cfm(conn, ev->status);
-	hci_conn_del(conn);
+	if (!ev->status && !bis_idx)
+		/* If no BISes have been connected for the BIG,
+		 * terminate. This is in case all bound connections
+		 * have been closed before the BIG creation
+		 * has completed.
+		 */
+		hci_le_terminate_big_sync(hdev, ev->handle,
+					  HCI_ERROR_LOCAL_HOST_TERM);
 
-unlock:
+	rcu_read_unlock();
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 34d55a85d8f6..485348fcc030 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -284,13 +284,24 @@ static int iso_connect_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst,
-			       le_addr_type(iso_pi(sk)->dst_type),
-			       &iso_pi(sk)->qos, iso_pi(sk)->base_len,
-			       iso_pi(sk)->base);
-	if (IS_ERR(hcon)) {
-		err = PTR_ERR(hcon);
-		goto unlock;
+	/* Just bind if DEFER_SETUP has been set */
+	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+		hcon = hci_bind_bis(hdev, &iso_pi(sk)->dst,
+				    &iso_pi(sk)->qos, iso_pi(sk)->base_len,
+				    iso_pi(sk)->base);
+		if (IS_ERR(hcon)) {
+			err = PTR_ERR(hcon);
+			goto unlock;
+		}
+	} else {
+		hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst,
+				       le_addr_type(iso_pi(sk)->dst_type),
+				       &iso_pi(sk)->qos, iso_pi(sk)->base_len,
+				       iso_pi(sk)->base);
+		if (IS_ERR(hcon)) {
+			err = PTR_ERR(hcon);
+			goto unlock;
+		}
 	}
 
 	conn = iso_conn_add(hcon);
@@ -315,6 +326,9 @@ static int iso_connect_bis(struct sock *sk)
 	if (hcon->state == BT_CONNECTED) {
 		iso_sock_clear_timer(sk);
 		sk->sk_state = BT_CONNECTED;
+	} else if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+		iso_sock_clear_timer(sk);
+		sk->sk_state = BT_CONNECT;
 	} else {
 		sk->sk_state = BT_CONNECT;
 		iso_sock_set_timer(sk, sk->sk_sndtimeo);
-- 
2.34.1

