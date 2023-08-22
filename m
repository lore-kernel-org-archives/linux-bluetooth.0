Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C2AEE49A3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Aug 2023 14:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjHVOcy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbjHVOcx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 10:32:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF604E49
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 07:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVy49WRY/e6y4KemKtXszcHu3DJd0XQOygqC2QuF87seQgRgfgyma2qpysnkNkYFwsS19kRe8zHHPR76vAQThtd0OraCOT/9t1lqt9BcdpKq2dCO6T+P7caJeiyVb87kR/lDWQsQWzYG9BVtR+wPYEhPZDCKcPbZtmW5VzPFhsDBMLtI5bywwjN4xzgJ4YXAQfrt7xl9DM1pszGoi1xvMqYewiKH4tScbYcBiRumCr6VtZ4ob3R+zPW5+J1ImDvFnd4HZTX4desDm9nxKwa2GYzo3CHPEqt7M4Tn96EX2ykxz/RoHnHkx+jCCRj0p00flHT73zLK3L6OkC+0gj9ApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7He6Dog5FMn1fYWSNp8KmvZpTnrkqJdC40wBPVct2Yc=;
 b=USdDDI32hc3SEyCHFn7RCBELcBVEuajAbnfV6rW6lwdQxesVIU9UmI9wjHpdCTi4LA++rWZYArnfV7EH7w0OhEI4oZEGj/nZMDw55hTzG2SI8Pf41OcG/UyAz+p6IT9W3AmSgrioOS4l7iZlPe1ZQBXMIR0E8FPDupDv8fJIh0I5e18roVpLZB5/3F8+a+DcPS/1FvPlhTWDekjQNOYEOoLqdTKJC0rDFWURRm6B15KOrJUliwooYJKOFVdUs4LwBd2hhqgUk+4Jv1V2I/ZgQrWgjfWuivbBUBMf4ogF8N5m3pNHrBr1gg3oGDjCTYux0VVxPwRsAYqWqp6RkY0ysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7He6Dog5FMn1fYWSNp8KmvZpTnrkqJdC40wBPVct2Yc=;
 b=gUUAXyp8TbhdCF7chc+XaNm6F0/LhLcehT1KaniDxLkKE2FZpPrdQ8ko4eoKMkAa8QKjQJKO4n6Z0qG4CYCY770cw1NljSQfelaZbVlhLdi0Mdo+3M7xKpdttrLSwIKhzpFvEnaXtAox14tmakpc4U9TibC/JJWnHDU2eSanGc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 14:31:55 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:31:55 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v8 3/6] media: Add broadcast sink media endpoint
Date:   Tue, 22 Aug 2023 17:29:32 +0300
Message-Id: <20230822142935.6016-4-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822142935.6016-1-claudia.rosu@nxp.com>
References: <20230822142935.6016-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 24672170-7aca-47a5-8f28-08dba31c887f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpDWGlwLJbtrC4SSB48Aup7l6kgySFRy6WeQOp6ZP3TieO+4jFOZbXd4DdOT6QlViOjqwUAL5OIrtzslfONBcuyZKFL/z4itfDHf1MYDQQKmskK6+8Vc5Y8T4McZoJsGq/d6IpV0TrcEM3ShYWJRks5XbPTq743ti6VF5wdBiYzUB5yPrLtBhtyhWy0b1ERglE2uVnMYlL4S0p01dJvgN4j/XkKONFxYM5sqMX14Itgws2YMpHw1j4YgTXUS/JVBj8twJj9+j5fkKv3gHnToJRkkn0tfcIDQWlp/1+J3Uq5STIp2dgkqcgox4k4wwVoLWH/LgNPCUD/y5q/9bC8fS6Q7JU6eLHVD8iiLr7BpLIRHE1ccf58E5rFwIu545VshQiQO/z5/nFqxCLUOWawfQAFnz+X+QLMwL3XaRdVKZ/+NRN+psGEU9OAbA6NCo+dE3fwDScvbjfRgolymiMDvAZ9ekJI39TCDeYu+v5TAV7N5lJ0zHgkozXAyE/KII9aKm1KYtseprC2Z8tVmKkp18ujeDSumVmif/4RqOy5FaCAPM3wKiH4l52s7nF9wz+slc3fXK1QNrCpWTy1eQRMNW6aVcwYjd0dTVrY4wRnqAU/dlZCZoIcSfMU/DbkESmi+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(55236004)(83380400001)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3jccg7iKdhCcRlgADj3Ql51asVCZWL0ut4u0P0h3sjTWEHY9Fi9IwzJsaiwa?=
 =?us-ascii?Q?6jk19Fqjm0f4OAHUB1ZoOfyeTVUYoIQNmQylvcLBC4VaP9wNjpGl/027bbGU?=
 =?us-ascii?Q?Y8Cck/Xa/fyn6pjgu8xQAeZFXI9ROBxiF2O41SzkYxqKvBtUij1Mq7PtkpQL?=
 =?us-ascii?Q?Qhhe8fWFHcIETaTet+oyBBsnbHv8VIHEin6KHqFLI0FPZNuhqPpcBUXRGY/w?=
 =?us-ascii?Q?5zgmjDwDJdW7XKKIgg0+G/ulrL0ybFgS5h9ZLpB510BWg3HrgC6CY2gelKbk?=
 =?us-ascii?Q?7a1cgFvNmAVpWqmB/T4EbHjVmuJhd+HYbb7pp1GU7ukOb04rd18ydP4CkNNH?=
 =?us-ascii?Q?5TZF4I6Dgax/M2wT8+TKcEruIcRhhwYiBZeSYFAxDvU73HNfraXNxZhKWnAy?=
 =?us-ascii?Q?dFK9Gj5s3nYsGCvTvy4PfTl7a9PpcqefP8kTn4d+i5JLjUsS1tuhnVCnMWhz?=
 =?us-ascii?Q?rRa4gtkNgm5eB4K0MXi+UI1PxFe/FG2UlH3qbWidbqW+hlABz3oXJJ6++qY6?=
 =?us-ascii?Q?3SFl5V+D1hWnSJXAizRX9c5RCRd/aoa48DVXXSEsb2oVaIfzcWNDwE3Zunpv?=
 =?us-ascii?Q?ZEDqcRDK3ibCYQv2B5+Mv0d5BeZjpJloV/bysXSqpEAgFnI86kdvj3Frc7FL?=
 =?us-ascii?Q?+noO/DVymXkVCyCgMBGivre7CQ/CkZ3XEzs9j/Ta85/6+0+ImGpHXRxxhTF8?=
 =?us-ascii?Q?tG/bzjkoE3SOrmwijcZFpFPUB4AP3Ati+54KQnfZl9Ss9BAHxByZ1L5dZscU?=
 =?us-ascii?Q?r51AgpMrxUBGr4UfuuEnpuK9Yui8dxqVkKrO8LL/hrAOI6typQw9k1nRvdNA?=
 =?us-ascii?Q?8e7FiheYBarHw6Ld3WVEh6m3EDPBIeSq2wMslF5iRu/V2cfxRuwj+GifUcAT?=
 =?us-ascii?Q?OZRhRcGaar73QsPmK16LrUhd3zpRVuIOyuTCo9PTP3yKi2C/DXi5KJDj4nGx?=
 =?us-ascii?Q?doB3dqMcwEGE6oDtW7nEyBYIdKf9kE+9G+9lRIqtpAuRbLXoKBSMjlbIqUri?=
 =?us-ascii?Q?nzr5MACSLxgWJwsjYCAGWWHA/z8FSwbM7XtrYACcJvV+zZXKNwV8FUPa2IHI?=
 =?us-ascii?Q?5ZuHGVdM+TUMrv9WfItd06W6Y8G0PdP2xmzztYSmo99JiR/XP/8HynR+Ac8q?=
 =?us-ascii?Q?dh6lBRKURlFbr4oQ1TLzmnDIDWb6mcKrnLFrEGL3LY3NNYS4tLwZkC+O5AnT?=
 =?us-ascii?Q?6ckTW0AynGr4aktyBmiISpYvhueRQh0nfXNRi2EgFhD95ZMerIIT7eso9+eD?=
 =?us-ascii?Q?/vaKcYxQU+zXeNYqj0/yEg+X8Y6W9qY1TVZwg1oN8R1SR8tJV5bpgAz4DB90?=
 =?us-ascii?Q?PdCqx6YgXAlXkouVukhfhLMBIzwu5rvb6aK09+r5ouLup7CyEgNAMXAtReDM?=
 =?us-ascii?Q?gOlkHLm3uq4c9sMA1A5yAKrnQFM+F7tfEm4QwgT794rZ/wjXgjl/1CDd4EO3?=
 =?us-ascii?Q?icgqRQY5oMptJjuq9mwZen7p2w/Dxc/RSRLMrmzRyVaCgLJ2/Py3R+I9992k?=
 =?us-ascii?Q?KcyL4c2onyQb2xpHgKC+dJj2KZ1vG5elu0qkUaRH062Bx9GNyW+AZjolzrwY?=
 =?us-ascii?Q?Gxj16m+7mP2EIxGel9c5bx16+h/Q+YdtmxrgVyIy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24672170-7aca-47a5-8f28-08dba31c887f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:31:54.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfTmaiOAkfcv4Px9yARh9pePkhz2K/LY/IJrYVC17FTx5a18wk3itOKrV7VCQbfWZijpqMyn+dDd2MzISFnueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the possibility to register a broadcast
media endpoint if the controller has support for ISO Sync Receiver.

---
 profiles/audio/media.c | 42 +++++++++++++++++++++++++++++++++++++-----
 profiles/audio/media.h |  3 ++-
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 15c64c8d6..66f512e00 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1058,17 +1058,21 @@ static struct media_transport *pac_bcast_config(struct bt_bap_stream *stream,
 						struct media_endpoint *endpoint)
 {
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
-	struct btd_adapter *adapter = bt_bap_get_user_data(bap);
+	struct btd_adapter *adapter = endpoint->adapter->btd_adapter;
+	struct btd_device *device;
 	const char *path;
 
-	if (!adapter) {
-		error("Unable to find adapter");
+	if (!adapter)
 		return NULL;
-	}
+
+	if (!strcmp(endpoint->uuid, BCAA_SERVICE_UUID))
+		device = NULL;
+	else
+		device = btd_service_get_device(bt_bap_get_user_data(bap));
 
 	path = bt_bap_stream_get_user_data(stream);
 
-	return media_transport_create(NULL, path, cfg->iov_base, cfg->iov_len,
+	return media_transport_create(device, path, cfg->iov_base, cfg->iov_len,
 					endpoint, stream);
 }
 
@@ -1238,6 +1242,12 @@ static bool endpoint_init_broadcast_source(struct media_endpoint *endpoint,
 	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SOURCE, err);
 }
 
+static bool endpoint_init_broadcast_sink(struct media_endpoint *endpoint,
+						int *err)
+{
+	return endpoint_init_pac(endpoint, BT_BAP_BCAST_SINK, err);
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
@@ -1351,6 +1361,17 @@ static bool experimental_broadcaster_ep_supported(struct btd_adapter *adapter)
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
+static bool experimental_bcast_sink_ep_supported(struct btd_adapter *adapter)
+{
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
+		return false;
+
+	if (!btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECEIVER))
+		return false;
+
+	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+}
+
 static struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
@@ -1366,6 +1387,8 @@ static struct media_endpoint_init {
 				experimental_endpoint_supported },
 	{ BCAA_SERVICE_UUID, endpoint_init_broadcast_source,
 			experimental_broadcaster_ep_supported },
+	{ BAA_SERVICE_UUID, endpoint_init_broadcast_sink,
+			experimental_bcast_sink_ep_supported },
 };
 
 static struct media_endpoint *
@@ -3245,3 +3268,12 @@ struct btd_adapter *media_endpoint_get_btd_adapter(
 {
 	return endpoint->adapter->btd_adapter;
 }
+
+bool media_endpoint_is_broadcast(struct media_endpoint *endpoint)
+{
+	if (!strcmp(endpoint->uuid, BCAA_SERVICE_UUID)
+		|| !strcmp(endpoint->uuid, BAA_SERVICE_UUID))
+		return true;
+
+	return false;
+}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 1de84a8ff..0eeb5746a 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -22,5 +22,6 @@ const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 struct btd_adapter *media_endpoint_get_btd_adapter(
 					struct media_endpoint *endpoint);
-
+bool media_endpoint_is_broadcast(
+	struct media_endpoint *endpoint);
 int8_t media_player_get_device_volume(struct btd_device *device);
-- 
2.34.1

