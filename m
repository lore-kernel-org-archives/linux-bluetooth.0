Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460AC001DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 14:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjGZOCQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjGZOCC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 10:02:02 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC532717
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 07:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htuiz1O8SDmBmaHiR9aOhne+Hdb7uGCJh2TQ0HDH0foT8dAuD0qfEOC0KHaexhoh7F6ZAXesRgk8OKkf/iSvQsNcV04QrjfCvp8vsBo1XpcySerSpF4/3W8kMIWaSY9+ivXMFvUlK/BISmQBwr4TE+4JT6IyA0ULnuj/wKciZkn6dwsGw043aNniTxnwq8I0X/3t2ZtWrN2qhsHegWPY/fQ5vzga07xteNfW09zQEv+FiM4nV3AmJHD++xF2vAf2Gm8HTyjaOenfSI9565wA3dXTLXYrNWx4s9SIJGKq0SvtVY9RB9/BGtfdBf0np6sXQ+uz/bpS/tRuDbSiZv+dfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFcltwF9l+Zmotvck66214SRT/nX9MVppkew8FRCO3Q=;
 b=Z1GN0/1OTUAVZdY8KeCLVVOqQ6FmZ0xKUD4yjEGgUUVGiI1X6xfnG6Od7L8F0vJ2YrLuLQJAePGlL7McvuoHVMMJdyHTL222IofL5pXi+9rIC78hjt+82amtoIVi3+ryCM+ZJutV0s2XdndZ24ZzF91rEy4Ct+yK3DdNM9LcAI64OuxkypUJgyvCeYJXG3LW+LlVWPFLPhEC1fg1vcQfebTiH4VKrdRWXNtTZGLlZwfX2TTRuhvLnFPUjoR+uWeXwdMunEtqxzCKpUB3rmFye0Q8wupfM2X9KqZc6UjAdhTCHaNcamP9+B4yEPElo3jSrqXKfyBSMpYkpIol3rW+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFcltwF9l+Zmotvck66214SRT/nX9MVppkew8FRCO3Q=;
 b=qZDChJQP8/knP7x9fGJgJSJIzg25Uqacgnjv/taaffgI+jiOeZxLm9XEpAw1bTzhSXf2NqQOBx9rlVg/DwHIEaA9N+kjgPnlj7vnQpErZhDgWDn7NUAmmdAbwIHvyUvoIaX89CU7EfmDAIFFFB+smKYEh8YgJqQq+mmfyjAhg5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by PAWPR04MB9887.eurprd04.prod.outlook.com (2603:10a6:102:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 14:01:55 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 14:01:55 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Rename BAA_SERVICE to BCAST_AA_SERVICE, add BASIC_AA_SERVICE
Date:   Wed, 26 Jul 2023 17:01:23 +0300
Message-Id: <20230726140123.136672-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726140123.136672-1-silviu.barbulescu@nxp.com>
References: <20230726140123.136672-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::25) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|PAWPR04MB9887:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bc6b12-56df-456a-8a48-08db8de0de82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtUlqeTtB9WSY5E2+hDgivs9FJfgq5a6M53SDzIzzxCjaO9ByiTwIwI3xot3fd95DrmZ+dcqFiKa2eYlSmgVySSyynEHGAaHX39wXxTKxy6SqBd/j80HQbmvAzUnuCiB/LKr9xpnI0ASzvM/Bq7gcRXu9rUiv+8xc3os8OefNoo5UDjdPKnf5geuRrvkqLRO4FaPApuz3ZL5P4dBlg+zNDTv1dfIVmXKqlKr2Z80JFtR95+g1qeKKidpWD0J7bmApR1TxyTOKmEuXwvFrcXAmZC8+4i0dvz77hlt5/ZUXTUgAtIPAAqnYR04/EuLpT4Jv+6/KuAFJw+p79qenJ8WlsY1Snsynh59Pd8Ge3JqDXoRuVt7J+CbxCGDidnL67arj2N8MULHmlEG1cuGwoVVuCbm4YbAer8y8lJAAezlYN6TswzPjGvZwNfg3I0usPjtjWs/hmJFUun15WifcXyZ3fXWb4/W4bfAgEYQir+/cXY13KGKPoQaSv/pMScNEBcwJpde+l8FnNpQk2xUJDa1HU7f5PMAcLU+semDl76orpWAt2uENGLqxqKSBXvt5tqO/RVPs6x6RS7zjCKDEG0FM/wa5QeMkBZruuOY+Ty12bzGP2aEOQwyJ3D+eENFTEA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(1076003)(26005)(186003)(6506007)(2616005)(83380400001)(8676002)(316002)(4326008)(66556008)(8936002)(6916009)(41300700001)(5660300002)(66476007)(66946007)(6486002)(6666004)(6512007)(52116002)(2906002)(478600001)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0da3ws90KDnK/uaM0wTSdGgUDttbF5oLyq57DA5r7dPKybIr1JHJf9y2z/vQ?=
 =?us-ascii?Q?MoHeUMAO+cSWzNQCsj9p8IjYOsmJqShL6tNFB0tEX/LB8a34Pf2Zy9nM49gC?=
 =?us-ascii?Q?7+XpRQuyJFqW5B4X45QhfQaD9w41p2KDaGMRL6CR6KmZASwB6u7jKY2SOASw?=
 =?us-ascii?Q?hNC9zGq+NLCc9wSryFoES4bzBQnphVPsYL5AGjv1LwrFbBm12MF1Jryv2TfT?=
 =?us-ascii?Q?TNMIQ5N1dinPHZidJQEuEt9G7wpLbgk645doKxafiAV5rbpwYbm5ikHuef2n?=
 =?us-ascii?Q?Hc6b6a+DAEPfIRqoFBd3Tqz7HndX9gGXPPyQIg14NJV9q5b0k5Msytxxf8Kc?=
 =?us-ascii?Q?RcCFwmDHbIuJ2SWomvsRbTVEv7Y84T3TlUdnfuHeOq3ZfJh7wjDdR9dcDDpk?=
 =?us-ascii?Q?QkLPfzQg6j+LTrQr0rAm17YL3uKT9vlqaJGewVBBQZrtHaVseOYDHU1rmpF+?=
 =?us-ascii?Q?cwxG5+cuhEr/NAlTBN2cFSV5obL7irgkt0gtOol59dcvKqUvE7VqQBdnbZaw?=
 =?us-ascii?Q?0TnID4WbSXj8XOsv3YkS+XhaldX5MrLRdUCI7aqp1hI4GRMg/HNyCV+wHZcR?=
 =?us-ascii?Q?WlC0qaDB5GOQ10i8czPqrj48pTn4DxUfB6Zl7gve/hNWi6IminVde539gTFg?=
 =?us-ascii?Q?eBEf1LhcjPiPCdBV9PDgY6NleafOQr4jC2xUui7p7Q8+OlefkI4j3HnLOEyM?=
 =?us-ascii?Q?h0jiPVls48p/NYGCfsR4ND2cTJQQb6h3EXclH/vO65MhYfduIhUpaaUnR2FI?=
 =?us-ascii?Q?aCrACVTFAOM87TmUTfxf86iytsuWIRPWQca5McA5/aeObiWC1WGne2F4VXjB?=
 =?us-ascii?Q?z3AI9hW1b+jFxuIXSU6o2eRsvuO53zOHjZX0d8tlQmGJYitazuZil0fYeXh8?=
 =?us-ascii?Q?DwtsClsq/o8jHOtTk4laaDG/8aAaqNmFvUGZXIG/lqko6TFQS+1GGhChyoNS?=
 =?us-ascii?Q?e42cW7CEl5y0EBVZIF4veBPH+YEVH5RZzdiBQyWjFKcIevilr4zy2Zi8yy0l?=
 =?us-ascii?Q?Ev04GMjBnu5t4mXwkHkc84k4LMOEa/f4TCDK3fVvB1W/Gwc6Cg5LWJTQsNyL?=
 =?us-ascii?Q?2gAWGK4dYUWbT3xv2DQNwmWHQ8qis3RqL8tDsK/4YD8I4rWaXZxSBzfMW2PR?=
 =?us-ascii?Q?1Rjh/BwfMx/6giQvzjEYKYu+xXhZKTAYVP6ohgHfeBrDDSUhwmBTQKeK0Zib?=
 =?us-ascii?Q?EqoMz3HxQ/n9cdiPkNOOXFBdt/KKd2vlPKnYfKeETA2k0KHOqTHnWszZp/WC?=
 =?us-ascii?Q?yXrpo6yJtIfb7VsK077g1K77NWB6v4f3kZY9ZOph4xd7P8XEDg+/JMW9lhjY?=
 =?us-ascii?Q?raahw6VUqSB5WWPtQ7NiRXH+qDkuuHQOmPlcSyPYFbtey2omnsF4R/SxN3do?=
 =?us-ascii?Q?Pj8pG8uQDgjZO9Zx+JmtyyUyAQetsSN/GUx2MBDH7InZPXO4i1NYPRoDqNJP?=
 =?us-ascii?Q?ROlrKbvd6jin9N3Udlf/WsX5K6ajO6EtV9mMPpLa4LJA8dup0EJIMbeLwXrl?=
 =?us-ascii?Q?QdpcGTbeEZDpLqBXQZ0DMgjCguRQ/vpgYHkj5yw8R7AeAkVyrAqJsCHSzzoH?=
 =?us-ascii?Q?zCCFGsEUaQlTvMcTcdbl5GdjoUELqExN0cLDOhz7HGiMVX26qhGlFIE+SjLI?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bc6b12-56df-456a-8a48-08db8de0de82
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:01:54.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjcPc9qiuerFMvvT5i+5xlRPKmzq2jlIRHdW5+jgNU2V8uWgbS/C3cJmYGXR4P4RWPtfW9aIkKwRuPRx2/7CoLCT2XH08grQQxr9a/D8Spc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9887
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

