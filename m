Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209ACC001DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 09:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGaJUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjGaJTs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 05:19:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FF2E43
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 02:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elT5oo4koas9l3yrSoma+mUTJYVTm3QJvr6Rp6lG0wVxPbJvuMYqirFl4mCuuIDV05XQg80Wodgq+cVOy/KvjSt9ze//YCO43LcF2ThUy6hyYEnqVqjjIW2gD4OmEAgCLeM7viFUhejj8Bl9vBNlEkCYk0fH8hGnTdovSFDdkzHjHiR9Zj5NKSkrUCYMklXZcyWNBP6Wep0MIq7GbeOycJEe8sRuJBfn7OJmqEUQwlKZcMdTgK8Jmrsu4e5xD+ZTBZwXLZcGWsl3ORhgxe+Zboedtc1nLR27bt/pV7MVwnRGUp9+5pjmLoVA4yZQ2pfsuiuzEeUnLNNtL42eQ7r3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nICzODnzpeT9eNoix4qcdZtqmcbOnDoBD3ZhIsSoB9o=;
 b=oTt5dHHSTTOQrlQ73q/wSy0Ent8yUMnHh/scWKihrL1HBWjd90/UfslVwi6QFQCFWHrroNZQycKhmcapdyDUpiuGS9R3FXdjEKtAC1kXYWb+N8UAmtPD7q0lhdPnLd47R53DU+/c2KxdduQNc5NVGpmPRvGxpswR8MR4NHuIyWrnDXVsRq66dAUGJUNtXIUT+656Zz4g7L917f41F4pJ9pfHd/JqCXSIHgzYDIGNprV6ScnZlqI81UQy6O9adPvcOKg7COvNhRCvlTsrfwFLiCyezhOz8/1tA5Vm5rANAwtNodPbPLlZx3/UXOEllAR7UKQ3RV8ooQz1yB3OLUW9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nICzODnzpeT9eNoix4qcdZtqmcbOnDoBD3ZhIsSoB9o=;
 b=UNy1D5fMwdF2n9vE9Qn3eHhK0J9V7LozKzgSVN7VE3zhkdhOqppbPhiWhKZPmZ0XQ0oqx/kp/2rObWp/uwkRlkXkRgQajXnbMhr8aUsCclMsRirmQw6cV9X32sVxSQYgjVR5rkAq8X5xxb74fcraIxiT0HHb8znbxLTtqRUAfPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AM9PR04MB8521.eurprd04.prod.outlook.com (2603:10a6:20b:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 09:17:32 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:17:30 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 1/1] Rename BAA_SERVICE to BCAA_SERVICE add BAA_SERVICE(0x1851)
Date:   Mon, 31 Jul 2023 12:16:42 +0300
Message-Id: <20230731091642.3712-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091642.3712-1-silviu.barbulescu@nxp.com>
References: <20230731091642.3712-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AM9PR04MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: ab983d88-7b6d-43eb-cb62-08db91a6f749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZXFD2kgRI9Rzn7Yp6IXMEjsEr7R937ej/e6ji0U8EQveTRI+yxvD3TXttSK3ZCDuVJSEmH2L0P8OC4iJvH4hy3p3w0p9mExeCAFNHZS/fEMgQPZaxrg1sxhXBujN2xleUI60uWYZR5ppnH1VEtEDPWNsPRx9KqosujxyUNXcLGwFwgfKce4aMQalBQBbbxEBaI8F06A+uMWsdCaLyJJXj4+xuRdZREhoYAz8beg9t8J4GcNE4J7txLi0oC/qgdcDS9bVxUtCs8Wf1K8K0Rxt9KtdsFYA5SVnGjU7WO6y94+JEhCslUvIYKdArIOIiko/Gnq0REqY7um4MMcYAoInPV6eiIyI0ymmqeqYTutyq/RRg78r5BoItDBw4MfiHBGrphGROjVVBVEFM9LDEZcVFYK+E/+wUriTkUIZEqT/n8YGd27ibJT/8oDJV1325O1zCoW4fdNaZBGlG8C3KwdMH0gT7DNp8f06SNwj7YafRyfi0dokDV+c379uvUlnUWnUQV+YuYcjbjqYC682kufqTkNPt2stEo8dCZRmUY7ktTaZckpbp8joWYmnM0ILhg3UJWaqZKuxlRbuGoQflJzx7RTEPwtfS7dv8Y2pAr/40zCMqAV3YCeCT9H96PNqKlt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(451199021)(4326008)(41300700001)(5660300002)(6916009)(66946007)(8936002)(8676002)(478600001)(316002)(66556008)(66476007)(2906002)(6486002)(6666004)(52116002)(6512007)(38350700002)(38100700002)(6506007)(1076003)(26005)(186003)(36756003)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MuDyFfYK9Izm0ZXZLebjyeS/e3LIBDAESFIaOzASPvTgHWEHZSRshaSBQKfo?=
 =?us-ascii?Q?OBhIvZu0pnEaDh+IqDWZOGVO4xtF2lSP+NqY3+NxGnoOD9WDokL5nHYKUW1J?=
 =?us-ascii?Q?w2aCf7fzjH35eXNsnMTSCuRU7W5B+p9ZwiuEXVTJ88ZYFFdh7hRlTFxwK6Hk?=
 =?us-ascii?Q?iUqbfxQKJsDJQ2DjCsuXbppDzwvpYOWShU7YOL7SsahT04FRPQK6+m5AvAIB?=
 =?us-ascii?Q?FBRY+rW4PXlfFA6qIQ3tQFfxmdmK+aeqLdCj4/5l9Kq03Y1UyfjQBs1HRU+F?=
 =?us-ascii?Q?t+vp5TqH/PFZ6HHDlRdXmi2bEbKETulwdanTiHc20OTn401Aatm0+upcLAKs?=
 =?us-ascii?Q?zLV363FE4YaYfjlQuY+yMDhxgA/Dk78daQ8FJmxiNo4exF7M53N45LqJvGva?=
 =?us-ascii?Q?4hBKibmfKNNEO1vrJxaPQp+EVyeFlqkS3Eo5j6HS1yeACmaQxfjxGxHuTb28?=
 =?us-ascii?Q?CnwCMPLhauEMFPHmRKBj9Md+7evT8c4oU1+qbjzjz0gYfqLpCFvx7JEDk2zm?=
 =?us-ascii?Q?EvBQO07V0qmtt4vbGM3oNCTzbS9QRhHxCMWDknUliJlD75Wu+SpresO9sAkB?=
 =?us-ascii?Q?jBgNUWZdvomdXOGmy951nte6hiWllmFkimcoRUuZS/DrLXZnj0xewxsyz56r?=
 =?us-ascii?Q?ItJLKcuX2lUXLw5+hhnBFLrWDdY3dbIIlXMP6KkslbWxLN2kHjFv88gadSHs?=
 =?us-ascii?Q?zvSSg3TIlHMLPfDDpSctLS2ilO0gM1abWRsZTKYUWsd2oIhuPbZFfuvOSXJX?=
 =?us-ascii?Q?j0W1Z0cQXwlPRoeWUAS3cEl/KZ/gKGaF5XlKsADLwEon2v+BPOKauwmyrxwE?=
 =?us-ascii?Q?gYW+TEb/z5Sdf4HhC6IZ+yf8wf8h7AKqy5ijTnslsehyX88HJAiJzTcaFWLN?=
 =?us-ascii?Q?2Ftt+T2/RwNQAQJfIDGVev8/2G7yqIDNLW57G5T2RgjjR6Ne63NMa+KajTAb?=
 =?us-ascii?Q?y2GFeY6eDVv8rZxzPC7UAUO7ZCBMrrOn6PZzg7U8EWJAzUoG6+CU0ewYhsT1?=
 =?us-ascii?Q?wnBgANjban/sKK3ji+feeWXaImNtw7uxcnWVp8EHbNrym2UIAspYx+6WfeA1?=
 =?us-ascii?Q?tmMK1rhrF6LTcYZmWAPoOCy534Fvff88zM/pZKuTWlOYi7wOuOsqZNQCIM8v?=
 =?us-ascii?Q?EycwQIYYPoE3Ia9CzTIUIujTT990Qh5h5bMZsAtikdcfRZuiFZUXMcSXWuoG?=
 =?us-ascii?Q?xqfy0QonoxoWqvEdUck8i+EnVkDLROY036L9mf0oM6CGcKdSuVwmaEI0UP1K?=
 =?us-ascii?Q?Z6GSqELysu2B+1SxF5oF9eDKgjpdisM8eQWGvKKCCPfpXEUl/OVCvsWDUmij?=
 =?us-ascii?Q?2LBkI9Uw0tLFDHZELJxgIRVqSelLwvWZ+xvlgXJxITeYra1aifxWkEOgEpzo?=
 =?us-ascii?Q?UrxjsfYnIs6yil6A30ooFZrYkr1ol2cpuXIcy1MqlCgy+bqrgRvFPbD6YPh8?=
 =?us-ascii?Q?3L1j5BraXiLNN6eejBt+B5SE7jdeHyHbTZ7bw7AlUNh8uyfDCFEZcVt9dMmZ?=
 =?us-ascii?Q?wZbci/seRd7jLEKZKncvsJH2cNS0/uqLy+RgmZsVoKL8zlDNVdQiPhcpJ2KC?=
 =?us-ascii?Q?sblXfb1a1CqTKAayoFqF2UecCWJ6A/AVFX0i9+HvCkD754v+s9gt615CfdEp?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab983d88-7b6d-43eb-cb62-08db91a6f749
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:17:30.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie18NJoRNXdD+1AszVXnWHtotTBBwnGOnPUFDR77DAc85hKxUGSLiICbK+C5BVeeZe2MhyvDpquWxfg2Zhms24WNw+gysPLo4KbqN151070=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8521
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Rename BAA_SERVICE to BCAA_SERVICE and added BAA_SERVICE(0x1851)
as UUID for the broadcast sink.

---
 client/player.c            | 8 ++++----
 lib/uuid.h                 | 7 +++++--
 profiles/audio/media.c     | 2 +-
 profiles/audio/transport.c | 4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/client/player.c b/client/player.c
index e5084967a..9bc5f2a36 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1180,7 +1180,7 @@ static const struct capabilities {
 	 * Channel count: 3
 	 * Frame length: 30-240
 	 */
-	CODEC_CAPABILITIES(BAA_SERVICE_UUID, LC3_ID,
+	CODEC_CAPABILITIES(BCAA_SERVICE_UUID, LC3_ID,
 					LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY,
 						3u, 30, 240)),
 };
@@ -1464,7 +1464,7 @@ static struct preset {
 	PRESET(A2DP_SINK_UUID, A2DP_CODEC_SBC, sbc_presets, 6),
 	PRESET(PAC_SINK_UUID, LC3_ID, lc3_presets, 3),
 	PRESET(PAC_SOURCE_UUID, LC3_ID, lc3_presets, 3),
-	PRESET(BAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
+	PRESET(BCAA_SERVICE_UUID,  LC3_ID, lc3_presets, 3),
 };
 
 static void parse_vendor_codec(const char *codec, uint16_t *vid, uint16_t *cid)
@@ -2455,7 +2455,7 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (!strcmp(ep->uuid, BAA_SERVICE_UUID)) {
+	if (!strcmp(ep->uuid, BCAA_SERVICE_UUID)) {
 		ep->broadcast = true;
 	} else {
 		ep->broadcast = false;
@@ -3189,7 +3189,7 @@ static struct endpoint *endpoint_new(const struct capabilities *cap)
 
 	ep = new0(struct endpoint, 1);
 	ep->uuid = g_strdup(cap->uuid);
-	ep->broadcast = strcmp(cap->uuid, BAA_SERVICE_UUID) ? false : true;
+	ep->broadcast = strcmp(cap->uuid, BCAA_SERVICE_UUID) ? false : true;
 	ep->codec = cap->codec_id;
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
diff --git a/lib/uuid.h b/lib/uuid.h
index cd3b3655f..817a5e843 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -157,8 +157,11 @@ extern "C" {
 #define PAC_SOURCE_UUID		"00002bcb-0000-1000-8000-00805f9b34fb"
 #define PAC_SOURCE_LOC_CHRC_UUID			0x2bcc
 
-#define BAA_SERVICE		0x1852
-#define BAA_SERVICE_UUID	"00001852-0000-1000-8000-00805f9b34fb"
+#define BCAA_SERVICE				0x1852
+#define BCAA_SERVICE_UUID	"00001852-0000-1000-8000-00805f9b34fb"
+
+#define BAA_SERVICE					0x1851
+#define BAA_SERVICE_UUID	"00001851-0000-1000-8000-00805f9b34fb"
 
 #define PAC_CONTEXT					0x2bcd
 #define PAC_SUPPORTED_CONTEXT				0x2bce
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index bcf4eae26..15c64c8d6 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1364,7 +1364,7 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ PAC_SOURCE_UUID, endpoint_init_pac_source,
 				experimental_endpoint_supported },
-	{ BAA_SERVICE_UUID, endpoint_init_broadcast_source,
+	{ BCAA_SERVICE_UUID, endpoint_init_broadcast_source,
 			experimental_broadcaster_ep_supported },
 };
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index aa3a718b0..cf5662d1d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -552,7 +552,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	owner = media_owner_create(msg);
 
 	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
-						BAA_SERVICE_UUID)) {
+						BCAA_SERVICE_UUID)) {
 		req = media_request_create(msg, 0x00);
 		media_owner_add(owner, req);
 		media_transport_set_owner(transport, owner);
@@ -1631,7 +1631,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 		properties = a2dp_properties;
 	} else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
 				!strcasecmp(uuid, PAC_SOURCE_UUID) ||
-				!strcasecmp(uuid, BAA_SERVICE_UUID)) {
+				!strcasecmp(uuid, BCAA_SERVICE_UUID)) {
 		if (media_transport_init_bap(transport, stream) < 0)
 			goto fail;
 		properties = bap_properties;
-- 
2.34.1

