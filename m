Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A4BC001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 14:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjGZOxt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjGZOxs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 10:53:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C049A2116
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 07:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxlNYHz0KSKHY0IwFZO0bN+HUzuvaVd+yOfm6/it6GL1e6oNjDJFC11nRm4s7pkr99dn7s5GI49inuRtMtqwJzUnDh3dgQvcqdnUhWLMZzz2nPlBTtFdP7SQBJml19O/PJ9hhL2i9tpkMiO4WFa9x4nXiFDaht++4cmkLXtsBN+5cPJCQlum3OtQCAJb/qDDXmB8bhg3YnlDerDW7JMt9CobbTuy+D9VN9cs7D7HjaPX3ALNhezGq16oMGSmfV4pfuCj0ygzoQZTOBQLd4xTGYtK7ead8N0y4H6eaOtn1hpyge1B+BcgQGDMquvtIlKcBzof+f8uCCcnDHQhUodjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFcltwF9l+Zmotvck66214SRT/nX9MVppkew8FRCO3Q=;
 b=ZcSeNprIRGRSESSejVkMyxde7LeHhweualk7hRPReqirtxWEJ9PG5hAQwpe+x/E2Rqidxiob/r+3hQFKZ9WNAr4CY4mXKG4ih/GitrPRyS0c7LVhZTse+E/ChCUxhcSFAMaipgH+yjKvA/4LNIK1SuZbDN5OGvkk+S/hxqZook8cclA9016qYk7T6om692XpagwoTG78ppltJgY8bS3cZ/Mr3iCRdtJK4kntv0fOFWr3tEDwACgQnU8VVbJ/CEgbK9S1E0Mpjb64qc+1/BXsYKUI2U8jG3M88IFmmhkrFDpCwWLSCw2JmuC2IWzbEY6KqyM7cY3CI14zTFUxloF5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFcltwF9l+Zmotvck66214SRT/nX9MVppkew8FRCO3Q=;
 b=AC4f6iwP++KDo2j7qg5HVBWzgwTkAod2r59099PvCmay7Mu6yEMZUb/S7grH87rUwz85JiMue29Y5wkQV3XM5ULa1+/PKTdH+sfOfhAjkH7FRRxY19hWSLAEijVz6bqSQ2pL3wZf2hLtr5Dac7SIKLVz8PHVmSkcLVwvguD6j/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by PAXPR04MB9707.eurprd04.prod.outlook.com (2603:10a6:102:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 14:53:43 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 14:53:43 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 1/1] Rename BAA_SERVICE to BCAST_AA_SERVICE add BASIC_AA_SERVICE
Date:   Wed, 26 Jul 2023 17:53:03 +0300
Message-Id: <20230726145303.137597-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726145303.137597-1-silviu.barbulescu@nxp.com>
References: <20230726145303.137597-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::14) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|PAXPR04MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 704a3a09-ef50-4b6c-99e6-08db8de81b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djRsAp3JePzBysSEdhZPUeynoJqq24STNtg99TL4Qk4wuyOsGMQNSnt/HZM1jXp30AMZCzPgfXqP17b9mB4zP1HXYfOdwHn/rqdd9Ptm+D/9yIx7Jmb1kumyTcrJOGfDJI4kHMGb4RhrDPEOjmDyCiHUe7vuVp6teABbqS/2RsRizJ6ZUOGm2aGyMjGPK7u88epr6K+tMIQSxI/fY2OwtM3u5jAsDZpHEwC2ndmtLDSr8gAYpnI+9tkL/ezvNw1J3PSrkQ18AgIchFGH9QAceszE3/bh/ebpuBqVC5KcIqCVKFpd7Zdwr9b32jAY4quCQCH6ZthkwaXQuXm8tystfFjQ9YSKOFXC2ybI/yxYMcoCK8KsLdMYGy8ylCRe27m8rP0ZjCfAQQWw75Z7zLWI7sGvr+7epBHQruQfxPC/2nYx3dGdU1wmklQ0IBQR1va9VdO2wio7J6MXBgv1qEtEHZ1/HJrQMTIuqBXo3zDrw8F2zYrhTL/W8+PUV5ES5uEU2J1cld0T0bmrmw0OZEX1hRn72CCQ0gtxCa3dI8xMG9qNJ8OQxieAHps5ccspJTZkAt19i9SzdxlPmbK9MWS8NTScHQHHwYDC8lDg0iPajWrYcgV1QmnewEfhkQeC//Et
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2906002)(41300700001)(316002)(8676002)(8936002)(5660300002)(36756003)(86362001)(6512007)(6506007)(1076003)(26005)(478600001)(6666004)(6486002)(52116002)(83380400001)(186003)(2616005)(66946007)(6916009)(4326008)(66476007)(38100700002)(38350700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hTF1JFxahIPMilR+hq7+l5XnRiFstb5ok9x7C0FEJt7ilvmgYDxuCfe95d+D?=
 =?us-ascii?Q?KkOO5AKK7WdCcqOSK3OejUkgl8NiH0y2VSFZxEzgew/0iMLTtHEFn4znnQZM?=
 =?us-ascii?Q?Cx2lnQxnTQPWWck+hOBY5js5ThlKWTYVH68D7pxMtCYiPeuAsn/h5RyviaN5?=
 =?us-ascii?Q?0KP9Q41kbpKE6vVRLTaoeWEM66otrqoW0c4xKw0+fzUuxTI4TTE5fILu8bXv?=
 =?us-ascii?Q?mHMmGhxx7J0r3iJYuwIsfAgOBgvqiJOjSsOWFzy8jYfujd7bmBIA/gQHMbQ2?=
 =?us-ascii?Q?vwuakVOynpmPYBwkMcDdMoA/9CR1VLfPVHyySxkRJaAFdIPHLChqsk/mdLb5?=
 =?us-ascii?Q?HjAlkdD4z5116rj5OH7V7z1ML3XijQIL6LFQr1clwutMnfWuVytgFI44PW2n?=
 =?us-ascii?Q?H2PrashaOhCTJ25DzdeIgRoZuA2arZUcooLtmnX0jeiIaCfRJq96ee5h28eF?=
 =?us-ascii?Q?1mmgLVOvJJ6VDS1RnRfadaCyH9VzWnhjOpE8uSmOW39Cq7cgPHZStzgaOiVJ?=
 =?us-ascii?Q?0ZlKPDV4CPYRdV2xcHKf3GRdsuNmbpXTkPPiXZ2k54aLaqDMc2mCDULK1Pry?=
 =?us-ascii?Q?X/9i8nEXKr9h0n9Z9SDS4dj7Qjoauzzjfjdj91b4XB+9YwuhOWiWtruyt2tt?=
 =?us-ascii?Q?iUD3yLPOGp65bwbYX5mw8PkPovUJLVhRSffcC9HiUbiv3F/zUDi0UczeTVdY?=
 =?us-ascii?Q?FOf4ZauDszW8MmWPH1SwskrVKnLumSIBpyLI33ptn72MnonNsARleiFHlW3y?=
 =?us-ascii?Q?eWvLHFF5STWx03ycPkR8z7dbXgPjm2cYJ0Fctg633sncI98I/spguk3v5o8F?=
 =?us-ascii?Q?ngWybcXqNY2CItHa09ZCX1ZjnGaW+ffz+/Vplq30RKd885DxxxB932eA3+hj?=
 =?us-ascii?Q?YrW9MK5kpS9Ildb6E3QUC7SHNGRZSxOGVryYHFtyZzhM17lA/fUhwFC0SeRj?=
 =?us-ascii?Q?NxYGsElgLXdWyXrvi1tQGFC03uxHGCahbH7ViwJjRfKHkmCzoT7EL7FDkFhC?=
 =?us-ascii?Q?QcS4G/o5HsBXpyt7OQLqfweWgM7fPtJW4G+A7MRp7DAiqT9Bsm29G/uNVsZv?=
 =?us-ascii?Q?FK2FnCp9kzsGgU4Vuf7PdbjfLEAWaMQlk1ir3HBD8QB0srXQ/cn10MJ1DElJ?=
 =?us-ascii?Q?YH6tIYeco8J0KQgmeK2IsjPRnwFwNb0E/uQAv95/8K2AN6LO4j6SvVW6SkDa?=
 =?us-ascii?Q?FZJ5Ah251jLc49jfcNubTpDGPWGY/9P8UCHnNReNYN2cD7U3tvBy+Y6bV5To?=
 =?us-ascii?Q?Hj6vXZKRWW5TgEawcY+qoRc1Cg9b5RVhKvv2+5SDwzfmCAebTtYjuL2QywAo?=
 =?us-ascii?Q?br61TXSiPhZMD2NR0aF0K7ehzmXG/IN76X3vA9jI+nPrizqNWtubbLEPFsxK?=
 =?us-ascii?Q?ROpepPg7XNjgVpAkHzewD3LzEC5kSLElTWq5vY+eTAwDzZHx+b6oIDJ9EDkK?=
 =?us-ascii?Q?0k8q/HTDonoD3FUh12pHej4Fdzl2symqCR5+7mBcJcV6e5rVgYJU2egtOzTU?=
 =?us-ascii?Q?pGv7pvOa98kVuG1SDxKSnoFK+Flvdzl/jHy/olmn5I994pXZs2UE3o39TIWo?=
 =?us-ascii?Q?BuujKmVv0bqYOkdwClOlynnwdwhyoyOS5d3e6CqiSLx53Wnj7iMLF4b+hPJ8?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704a3a09-ef50-4b6c-99e6-08db8de81b15
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:53:43.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBLI/OC5SF4NKWfmhK2qo2KsjzVpilKrPN7GSOfqkIuGbe1fJXurjCRXPPOSyfEyANQ8V1BWBRJMDdVsFdIVMIflvK5TuwGouFCg16Ef2TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9707
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename BAA_SERVICE to BCAST_AA_SERVICE and added BCAST_AA_SERVICE(0x1851)
as UUID for the broadcast sink.

---
 client/player.c            | 8 ++++----
 lib/uuid.h                 | 7 +++++--
 profiles/audio/bap.c       | 2 +-
 profiles/audio/media.c     | 2 +-
 profiles/audio/transport.c | 4 ++--
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/client/player.c b/client/player.c
index e5084967a..508f73001 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1180,7 +1180,7 @@ static const struct capabilities {
 	 * Channel count: 3
 	 * Frame length: 30-240
 	 */
-	CODEC_CAPABILITIES(BAA_SERVICE_UUID, LC3_ID,
+	CODEC_CAPABILITIES(BCAST_AA_SERVICE_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
 						3u, 30, 240)),
 };
@@ -1464,7 +1464,7 @@ static struct preset {
 	PRESET(A2DP_SINK_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
 	PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
 	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
-	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
+	PRESET(BCAST_AA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
 };
 
 static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_t *cid)
@@ -2455,7 +2455,7 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
+	if (!strcmp(ep->uuid, BCAST_AA_SERVICE_UUID)) {
 		ep->broadcast = true;
 	} else {
 		ep->broadcast = false;
@@ -3189,7 +3189,7 @@ static struct endpoint *endpoint_new(const struct capabilities *cap)
 
 	ep = new0(struct endpoint, 1);
 	ep->uuid = g_strdup(cap->uuid);
-	ep->broadcast = strcmp(cap->uuid, BAA_SERVICE_UUID) ? false : true;
+	ep->broadcast = strcmp(cap->uuid, BCAST_AA_SERVICE_UUID) ? false : true;
 	ep->codec = cap->codec_id;
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
diff --git a/lib/uuid.h b/lib/uuid.h
index cd3b3655f..cd9e62f1a 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -157,8 +157,11 @@ extern "C" {
 #define PAC_SOURCE_UUID		"00002bcb-0000-1000-8000-00805f9b34fb"
 #define PAC_SOURCE_LOC_CHRC_UUID			0x2bcc
 
-#define BAA_SERVICE		0x1852
-#define BAA_SERVICE_UUID	"00001852-0000-1000-8000-00805f9b34fb"
+#define BCAST_AA_SERVICE				0x1852
+#define BCAST_AA_SERVICE_UUID	"00001852-0000-1000-8000-00805f9b34fb"
+
+#define BASIC_AA_SERVICE				0x1851
+#define BASIC_AA_SERVICE_UUID	"00001851-0000-1000-8000-00805f9b34fb"
 
 #define PAC_CONTEXT					0x2bcd
 #define PAC_SUPPORTED_CONTEXT				0x2bce
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index d7ce9e038..1d7a4a794 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -186,7 +186,7 @@ static gboolean get_uuid(const GDBusPropertyTable *property,
 	else if (queue_find(ep->data->srcs, NULL, ep))
 		uuid = PAC_SOURCE_UUID;
 	else
-		uuid = BAA_SERVICE_UUID;
+		uuid = BASIC_AA_SERVICE_UUID;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index bcf4eae26..e5c18970e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1364,7 +1364,7 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ PAC_SOURCE_UUID, endpoint_init_pac_source,
 				experimental_endpoint_supported },
-	{ BAA_SERVICE_UUID, endpoint_init_broadcast_source,
+	{ BCAST_AA_SERVICE_UUID, endpoint_init_broadcast_source,
 			experimental_broadcaster_ep_supported },
 };
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index aa3a718b0..a997fab73 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -552,7 +552,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	owner = media_owner_create(msg);
 
 	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
-						BAA_SERVICE_UUID)) {
+						BCAST_AA_SERVICE_UUID)) {
 		req = media_request_create(msg, 0x00);
 		media_owner_add(owner, req);
 		media_transport_set_owner(transport, owner);
@@ -1631,7 +1631,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
 				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
-				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
+				!strcasecmp(uuid, BCAST_AA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
 		properties = bap_properties;
-- 
2.34.1

