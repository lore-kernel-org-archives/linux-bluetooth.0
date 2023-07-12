Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9FAEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 09:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGLJDh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjGLJCl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 05:02:41 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A331170E
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 02:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf/qpJjD5RMAjNHgsuac5mlAYY0XDU5iWlk9G38es3Wy8yUVkh7oh6Stx3I4FQpHkjUItVChyhzClv1Yy5hUXhcafaezkH7WP25s7ke8OF1/AQkv02Omm0w7v2t4g6ZL/OL/BKOVuNi22VuWe+k5m0E8JcoMmvXxRWMYRUMqH4n2vLoEZMXNblPl0Rhs9+NLkVLFH/eAr7p4tW05lKnSOfPQjRnlfWLSb4fEe2UCHmTD9xeHCa6mA0cGSGjoqXkGGpZAHdrpYCj3hXp7oeJHmG7a92+ooRc5RSo5jWtlLusA78QcClL6h1THInwGW0IVVhJwMCvYMLGkN6sv8EThtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnlVnDTXYHd5IQpCKTicqkBWS3QA9gQp/s5E3zwfSRM=;
 b=EA/GxgLm1YWB9J98GVmWXOwNGbOFEaWqnxqsbD3+5yo7bI4vxRnH8rme59t3eDFUpjxfg3fI0Z7mGLx4+YadoiSDOooYPkyVvzpo5AOzVnAm+x6a6Xbpjl08DMeKbzx6/UvXkELo9DZIbUk8jGGeqxjGuVj7QfPBl4TxVScwZ7gloSvIZcL4yy6HvmtaFDboI5qJKMcgI+0EGCY4sCWiTGheD8PVv6KY2JUN2iefr5iKVPJDLctGF7kR9WIuLL2g6qs7yFR5LtK7dHm74/K1Hs53O8yFhmKRVsHUEG3mWYWpEGesqDXL8gu6N/2DrrIdGaeeeM2zO3IbDDba33REOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnlVnDTXYHd5IQpCKTicqkBWS3QA9gQp/s5E3zwfSRM=;
 b=rxyDhtxR5NFgTPrfQUhF0YyNIMNcFQOlg58xNsrPW4+odQ5wFjqVisaqE2RBRgpte6bUcC33i0fuVOZmNlpnTwMnQurG3ljqmFdJE07g//I6yR+YUlUysL8R00eK51bNzaG4zrIWTqZBeHtrlangIWJFNA3S0zqmlbs6T//uyVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 09:01:23 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 09:01:23 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 4/6] transport: Update transport properties for a broadcast stream
Date:   Wed, 12 Jul 2023 11:58:58 +0300
Message-Id: <20230712085900.5423-5-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712085900.5423-1-claudia.rosu@nxp.com>
References: <20230712085900.5423-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0004.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::12) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4dd448-ba2a-441a-6624-08db82b69147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzbtjDSyq4MfyU7mlEuyjQC8Ul5d285fv3f2aLNcIRC6rgmbguTPtTxUuz6ESDBo3LDsOlbVVxc00Ux6Z8loz73cBVvWcPt/jeWdES6mVc4pvJrnIs5jOV+8BTwoT9blEbIYF8H631O80AWKRx4pbt0vHRJ9GZlNFbNN4kONBEZDZo+kz98Tzjo6K2dKBeHqfGvFM2um5JhH8DXth7U/ngwzDPUz5ceIIRQXo3I65TcSjvWEmgTHH7Yx+X5Cy0ZsPIMTD8kZnFTDXDM+79GPnspJntF26mZrpp7Gyp6mlnJCB+VBqxgPYAxrnTgeYQyJ4xBZgOSksY6D6bMlwGHL8tf89N8ufJ4Ia8uSw3SRSQ9k/0We1WYg0GT1IoInghbjqzUuVnWycp5zRQ5m1EVt3RE6VW7ITZ7vqFGVTbTULghLmEbDPbGgSCDc6rsEJ/pekkLZIdzK9SHr8HUNDev/fd2K5WDpnlFHRWWWoNOasN/PeWJBX4UL2H32yNGQU/FC9WOL2drC2uvtpt7qexGKpomRWMYc2uRauFiWVzaell7cuAC6MtPN7De5sKGYSF8pE76md7dQVs3DEyFW1wQKcqa1dD1qT+isRZJuPDXk6FlUY469H+9CBGR/XqWcp/NL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(55236004)(83380400001)(30864003)(2616005)(2906002)(36756003)(86362001)(38350700002)(38100700002)(41300700001)(4326008)(52116002)(6916009)(6512007)(316002)(6486002)(5660300002)(8676002)(8936002)(478600001)(66946007)(66476007)(6666004)(66556008)(186003)(26005)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBd5Wac3w4Jg4Tw8OS2GkqNrwpQEDiUzSiKFHqe5EYEtycjmndYVjkJOIoBA?=
 =?us-ascii?Q?GTLTryAXTZrp1LeaYgt32ETkS6ABeyKDFBn86qSf9K/AG3OsFbYusK6z3Kwk?=
 =?us-ascii?Q?VPTx6tfDULq8Hl60dCkIC1I++V0EnOZ5+oe1RiV9B6C9qlgWqiBq25INIa2n?=
 =?us-ascii?Q?/bpkVtv3gM70zQJtQZNVK3WZxzL0VtrVKdo5VC7jcOG2FC4IJJirECOzndnN?=
 =?us-ascii?Q?t0CxSJOUHZAwpWpkukgefds5c7w48YOYvHOe61E6N9l5d2qnIqbxEp7AumxP?=
 =?us-ascii?Q?tq9H1jkfIygpmoYyxukW05OPSWxV0VljXr2rhgcuzLApkoSBETFn0eytHYNN?=
 =?us-ascii?Q?aIvQijhP+dadaDp6PBrwXY0uMXhIzxUkaFf7yXtwUd87wvsYVLggWFP4/7lt?=
 =?us-ascii?Q?EmrDdeTev1+OwmB/SWtQpqny6XydRMv3p2LB/QW73zFFDmp/YOBqxApLcIxM?=
 =?us-ascii?Q?zwmj1FXh6Hiq/2tG/P43WTE/ae8MQjql94S4/W9yOxfcvK0PPSdbHt1E2yHD?=
 =?us-ascii?Q?ewJ1qRPhxhLoM2m8RhATHmBex+TWbW2oWOYTg8tp1pDKbh4AHqtheoIhXnSD?=
 =?us-ascii?Q?1LWV7LK1+VQ5KAspEJIV1KyRu6vwWxjmpEIlmbYR4aT0sll2bxo0xvxP/E9T?=
 =?us-ascii?Q?Jb2MRaB/yZ8pRNXEWhiiYXpZrfnWuNMQnghL5/FevubuNAW7cOPE8d81A8JD?=
 =?us-ascii?Q?al/RA0jY1nqiu7A9W20YplgwueiRLcB2yRlkh0ijPUp5AgNd52uJuxono7KQ?=
 =?us-ascii?Q?xK5REE/9EhDQ0G2OJi/d7XjJoktl4gQTV1xcz29TSiRnG3tqMVR4hguMcyg1?=
 =?us-ascii?Q?nTOsaCKBTcuSSKdB8hEZ+p2+zUBn+ryaEGGLeLj0VwpFIhmcV3mgK5CvjRN5?=
 =?us-ascii?Q?vSVvSdYORRf6LJyptIWqc7FjzA1o0z6PGWCppaWXcsG2Ezr9szZLweubQ8d3?=
 =?us-ascii?Q?vHXHyWkWsFfaW6j3ZUIGy53tWynO2ldoxb3T4koCj9LY11fyGql78vgVYUt+?=
 =?us-ascii?Q?2IwTksss0c06IF3tHXB+z56w5Arp3BTJaEqxmd/O7bOiQovAx0HdH8fWgsG2?=
 =?us-ascii?Q?pdsEsHGldZjcI5wndwon0JXUndA7rVZp5Dl09C9fSBEZR1WZTWiB1umMaLu2?=
 =?us-ascii?Q?lZSs0FGvIxLpuQf7KAyBr3lHTAIrxiyx0kj/AI7n9RvLKwNoZv2XrbKXcTxM?=
 =?us-ascii?Q?fCgZABOEBVpOix+CW66HdtlFXz9GbPd0M7/eraFnqbqPWDYb2HegaiijJtQl?=
 =?us-ascii?Q?EA1MqcpCpVnkfulsnLC1MXMkgkiSKI2DrBhV+nrfRWk+odg+DsSyCWLotXUu?=
 =?us-ascii?Q?zrGaB29Qhlp/NqDrRlExdj52WEsOgcFFBmG9AmWFf0++y0xqFdWKnCjf+dHn?=
 =?us-ascii?Q?0eqd7PCm99lQgMryNllxQXb9T1ReJ84ViMdkpUW1qzEwBtlg8rR7VpdTnsZT?=
 =?us-ascii?Q?aHuKLTe/Hf2RPByLAhMX06ZJQuUV7RKDa+jRJ2Fnpt+y09B/j4czCX2hHtwA?=
 =?us-ascii?Q?ealhEgAhoK4k+vBpLXOzKv422T6OMaJTXdMgl2Ib5xKWSTy/yqsbLimG6VS2?=
 =?us-ascii?Q?4DPk/2zCfrjiMKFHmq3PkWWbYQflzAxFMqjPHcQY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4dd448-ba2a-441a-6624-08db82b69147
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:01:23.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqW6a6pFP7UAftBvuehcmWrYWNzMeafHC9Cc3zhk9aQZJ7jvTlMh3KYq/pRcgv1Y/WnowIVEmB/8YHe92g71LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch gets the QOS broadcast stream parameters and passes them
to upper layers.

---
 profiles/audio/transport.c | 244 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index aa3a718b0..e7f21ff9c 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -551,8 +551,8 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 
 	owner = media_owner_create(msg);
 
-	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
-						BAA_SERVICE_UUID)) {
+	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
+				BT_BAP_STREAM_TYPE_BCAST) {
 		req = media_request_create(msg, 0x00);
 		media_owner_add(owner, req);
 		media_transport_set_owner(transport, owner);
@@ -853,6 +853,9 @@ static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		return bap->qos.bcast.io_qos.sdu != 0x00;
+
 	return bap->qos.ucast.io_qos.phy != 0x00;
 }
 
@@ -868,6 +871,18 @@ static gboolean get_cig(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_big(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.bcast.big);
+
+	return TRUE;
+}
+
 static gboolean get_cis(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -880,6 +895,18 @@ static gboolean get_cis(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_bis(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.bcast.bis);
+
+	return TRUE;
+}
+
 static gboolean get_interval(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -899,6 +926,9 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 	dbus_bool_t val = bap->qos.ucast.framing;
 
+	if (media_endpoint_is_broadcast(transport->endpoint))
+		val = bap->qos.bcast.framing;
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
 	return TRUE;
@@ -910,6 +940,12 @@ static gboolean get_phy(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint)) {
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.io_qos.phy);
+		return TRUE;
+	}
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
 					&bap->qos.ucast.io_qos.phy);
 
@@ -922,6 +958,12 @@ static gboolean get_sdu(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
+	if (media_endpoint_is_broadcast(transport->endpoint)) {
+		dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.io_qos.sdu);
+		return TRUE;
+	}
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
 					&bap->qos.ucast.io_qos.sdu);
 
@@ -1040,6 +1082,121 @@ static gboolean get_links(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_sync_interval(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+				&bap->qos.bcast.sync_interval);
+
+	return TRUE;
+}
+
+static gboolean get_packing(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+				&bap->qos.bcast.packing);
+
+	return TRUE;
+}
+
+static gboolean get_bcode(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	if (bap->qos.bcast.bcode && bap->qos.bcast.bcode->iov_len)
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.bcode->iov_base,
+					bap->qos.bcast.bcode->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+	return TRUE;
+}
+
+static gboolean get_options(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.options);
+
+	return TRUE;
+}
+
+static gboolean get_skip(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.skip);
+
+	return TRUE;
+}
+
+static gboolean get_sync_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.sync_timeout);
+
+	return TRUE;
+}
+
+static gboolean get_sync_cte_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.sync_cte_type);
+
+	return TRUE;
+}
+
+static gboolean get_mse(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+					&bap->qos.bcast.mse);
+
+	return TRUE;
+}
+
+static gboolean get_timeout(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+					&bap->qos.bcast.timeout);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable bap_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
@@ -1059,6 +1216,17 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
+	{ "BIG", "y", get_big, NULL, qos_exists },
+	{ "BIS", "y", get_bis, NULL, qos_exists },
+	{ "SyncInterval", "y", get_sync_interval, NULL, qos_exists },
+	{ "Packing", "y", get_packing, NULL, qos_exists },
+	{ "BCode", "ay", get_bcode, NULL, qos_exists },
+	{ "Options", "y", get_options, NULL, qos_exists },
+	{ "Skip", "q", get_skip, NULL, qos_exists },
+	{ "SyncTimeout", "q", get_sync_timeout, NULL, qos_exists },
+	{ "SyncCteType", "y", get_sync_cte_type, NULL, qos_exists },
+	{ "MSE", "y", get_mse, NULL, qos_exists },
+	{ "Timeout", "q", get_timeout, NULL, qos_exists },
 	{ }
 };
 
@@ -1341,6 +1509,71 @@ static gboolean bap_resume_wait_cb(void *data)
 	return FALSE;
 }
 
+static void bap_update_bcast_qos(const struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct bt_bap_qos *qos;
+
+	qos = bt_bap_stream_get_qos(bap->stream);
+
+	if (!memcmp(qos, &bap->qos, sizeof(struct bt_bap_qos)))
+		return;
+
+	bap->qos = *qos;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BIG");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BIS");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncInterval");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Packing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Framing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"BCode");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Options");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Skip");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncTimeout");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SyncCteType");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"MSE");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Timeout");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Interval");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Latency");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"PHY");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SDU");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"RTN");
+}
+
 static guint resume_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1493,7 +1726,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		if (owner && owner->pending)
 			return;
 		bap_update_links(transport);
-		bap_update_qos(transport);
+		if (!media_endpoint_is_broadcast(transport->endpoint))
+			bap_update_qos(transport);
+		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
@@ -1503,6 +1739,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			return;
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			bap_update_bcast_qos(transport);
 		break;
 	}
 
-- 
2.34.1

