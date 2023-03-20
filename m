Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460BBC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjCTOjM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjCTOi7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:38:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00528E6A
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiB/X/v0h6fUuCgXSPxM6cCn/SLpgEy+du5b8ouNAR+U7gJXsdNTLNI5oTW4E2nYxfoY9ouaPl+ikRPIrcDQnqIzX2z2Y9gM4yUNG69n14f3S/I5nvX2Wn0UDlYRIwNj1hPfGhww5ur7LFww08AK3YmvRnrhjSmZZ4UgmMdDBmDN1JqHuRan2gL5VplrWHbcItqrhp2iLfrmrcbyM0czcCtGi8ajylO1FCuJKhDNC9LJ7bN8LozsRJC4q7gWspAjPmkR4Rv2y4el9K+z94GeSuT+tFECLqga+3afhjvNXbnfSVUC88S90JQ/Cnzo84Etkgnsk5B05EGzmtABJken7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUmK70d9jZkCrV2pNLqeh6/R9cNahaKXTCKtxVKDF50=;
 b=Hgh+BoxqELDWwhps1hOZjLmo7w1gNbW6NNgDHOhhETmiUXo1EAIgHfWrsGaOh/s6SsVZ1G8ol7FlXw96M+gklsMA+zleRH5dw/Y+etHqdk9t9+aF9Cw8DkJ0cFKqwESAr2DqPPVhBevXNYZdQio3L7pP55RCM7b5lxOI5vgiJsCRd3TW9AqvSccKPYMhtvGwK512X9s1qvJdgmuBbEu747gtJtyJ8V+Vklp9qLPTGxNYgSLv0mH4ksqQA6aaS35occph4i22R0r/SPv9OtTgRS8EwrVAFWoB+LdsL7d5gM2fKO5oJmXSE0ohbK0OIc3bQhrzuRzg3/bMZjWl+bjLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUmK70d9jZkCrV2pNLqeh6/R9cNahaKXTCKtxVKDF50=;
 b=XZvBWRlZKWGt6XAMot53xIor/Xn0jP9sI9ufCz7hPMg6hm6g6H7sNo0Di4cEq6KNJ6EOtxmYjhlC7UeDwySjPlXJg0LnCpdqkGV3epJBiPxBB5+VXF81JF+iBcV2xypciEem5kRuH6xOQ+B0pHnUd1dvy9nBQT6y7rQMOxPJ2Vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:39 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/8] profiles/audio/bap: Use unicast structure for ISO QoS options
Date:   Mon, 20 Mar 2023 16:37:10 +0200
Message-Id: <20230320143713.25449-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
References: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1128bf-a51b-4a8c-d243-08db2950a797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTnxfU8MH13Mzd1NryCUz7J7YZIJDeAKx0XUy1VIMzaxIY4h01HQy+8hXy3rdoPIy97Qq7bOuYJxwDNGwVJzYrcJYJng5dv6IrVmagDL75HsQUymMza+4t+Pf3/lsz6fAdSKBZWiv1sYd4m1sSM9JeBO3TWhT48GceK0VbHfxq9egpTOD2YWmHMaBD/8r+gkg3XsGX4r+/kB+4pPpvPdF5Fu/hS/XBoCUIieixJHjynnX9tyXEslKccwc491U3Iw5e2DWzCpAQ0RL84kDZ7q+LeJ3m9LW+A8I4GbWUMZ3nHy+mBCLbqsnozXWigGhdBcUw0yHjvzJQo+X+fi5sUKVeXBZh0MYBXTqIZLcyOqABhWoewoyj3wCH1SDp6jpeG/Qupbdb7OqMxa4GZasqXTLPUO8+92rut0JuQvJLbzhzxfBzz9W6q2cA8aUlGBGGUCOQrIA91m4BLTLdChJX2cUGb0Oww/Fi0BQwHvyc/uRLXMb/afXbt3jZP/N/DVhOddnMmdrxgLy7VDsrw8F59Q92/9O+PVwvnuKQbzdNVNK0xGQPvMiLrvjzQKkc6TJRxrMU7gkdsgL/kx1suc3wci0C+VxZ/mtFAltJR67Lw85+werM9YpkNp9r7EFu+H/cY6S3++kIXItVithP87QPVXO5hQzhgH1wjLKGV3dCgo1QkEaXAhYl19z3dps+A9oXvLGCMj7oHszLBbrbpeHHz7Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ootdZmeK3ORveHf8Qy7QBn+O9oWZJqVR3ceu1engWBMN2p3PLTF3EJgoXQV?=
 =?us-ascii?Q?iWh+sALToIyzezLrxG9W1o4xayxlockBCRg9D6C6wAWIDE3lw4KQvNGoRoWv?=
 =?us-ascii?Q?rKjDJjChlpGObCrrRE/Xk2g0vt56CYuNcdex5wd+JIT9et41CGJKW21A92ea?=
 =?us-ascii?Q?2VHtVijOn1e9wsmnq+Qs5zXELTZUnzUZPmIPt8sjX3KjUJWmaebCSvsciMp6?=
 =?us-ascii?Q?mVqvDNCVks7E2kwPdsQXX+XeLzEZ9T4utXEik4LpHihDv30/tI9MfIxod8D9?=
 =?us-ascii?Q?iYUB4MoarZeFk5GmMMqsk1/xbp0Ff1ZoDyQo3j/U2b9TaPS7O0bprYehEwse?=
 =?us-ascii?Q?Zi1vqXkKGFcWgUrMq7RP3T/N4Ac72TZcNGcQ9oonDE4hJsDouWtwGU/vaqJA?=
 =?us-ascii?Q?W+ze4Mzz8Ue7nCY5sRmeGzpZ52FzCPI3OjR4dPzEvnYMpPCE2vSVsd9iL4Dz?=
 =?us-ascii?Q?KeMFxpRDVcW/SDfAvu0NnW6PA7qdonzuRshdsCt3o4vlv01DVwQyYrDNzfM5?=
 =?us-ascii?Q?fW+WU8VUBpATfe48nlels64ELwgr7Jsi2rSX6TB3LxwU4O3E4aYCWEdob5gA?=
 =?us-ascii?Q?5FmdgfXJaj6hZDJ5DI/g7ajd64zDa5aoUVbZqPj3FV2Fpe66uVP1UOpJKZ7S?=
 =?us-ascii?Q?fk81kz44EbIgStZLae6nEI92pu6z7oGaS99haM5OU4V+AjIvI5PUz3A5yy5K?=
 =?us-ascii?Q?l6HLyTvxxHc8tovjniWTrRjkJMlk0CV69tF2QUo/onOal8pLyOStI0OPmPsJ?=
 =?us-ascii?Q?wNU+/z6Dzuq6IT1J4sOFBqH6SrpnKX/6zQ6O7GaheNWyjHLPQuIqGJyjTU3s?=
 =?us-ascii?Q?gUkx+aL87GdLdu4ebk3fK3UHnHPfMcuXm3INyu/kHFL1uFzJrB++b4IMkMt4?=
 =?us-ascii?Q?wLak4PXzQ/2Wl6BN4Z32VMxSzycOndciNQjq4hQbbaCZyFOOB/0ah8shY2KL?=
 =?us-ascii?Q?VgFVjHoUfdCe2ZZjZKnAj3XQ5FiSc6QZgg1G7GO/SaOieEIV+e716IICDg0Q?=
 =?us-ascii?Q?YwOvWVgjw80FjHsEz+SuxeVmbi7RIlr182aluNSo+0EizbOV+YcPz/NMMlZh?=
 =?us-ascii?Q?7w9MgLuENWSTaKphQQOa6IvUZo6UtC/wxbxit+C0wg7XMXz+vAmg2L8QW27q?=
 =?us-ascii?Q?qroh3OW05bQ9ys/POu1kwprMNsnsDSqZpGUHdADWDy6T8A2u13xRkWPo+VbE?=
 =?us-ascii?Q?dJpJh6X29kNEIspRRwRogLLiM2UzjtldJua5g+qVe3xzBwW+Xt6zHXYdGL5y?=
 =?us-ascii?Q?TnibETCV4lW3LC+i3cwKjEr9ju8IoMh8J1KHwj8Eef1Ejl0EyZ20tAFKDhh1?=
 =?us-ascii?Q?J+7d4/iWxs/f8p/IOwoulgEc5tnISS1Gc+8hslxgvp0GM1Ru8t0Grw/W0+oa?=
 =?us-ascii?Q?6YGiEIZUM6YHezthwBdDGsMJRcWGEoOUZ+2Vqna6CXFkD3dDZ0Gglj3SOWDv?=
 =?us-ascii?Q?euvG4U6/v5hlE2feTn+46V26OikbBZDg5MKBE5cNDOc3lPyTY3I+eXQc9eqb?=
 =?us-ascii?Q?iZA0AjhYveib4iCEvHKXW6T3DuYDv+o73var+lHDHup7yZNnpW4i9v1zfiR3?=
 =?us-ascii?Q?T7WKyBO3SCkXsCrl9H7rlPbCFr+JtDhEmoLySEq3+fGdgKE4rOvPw1App79a?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1128bf-a51b-4a8c-d243-08db2950a797
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:38.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4V/qjY/KFoPt1bTVwIjup8qIO08LGNrc5+hJE8Gu1+Q7ZOpXvD9EiQGmGLdPh2qKOVX8n2QUrUDjZJoDNqwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Convert the generic bt_iso_qos structure into the dedicated unicast
structure for ISO QoS options.

---
 profiles/audio/bap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index dfdf87255..49003d351 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -741,7 +742,7 @@ static void bap_iso_qos(struct bt_bap_qos *qos, struct bt_iso_io_qos *io)
 static bool match_stream_qos(const void *data, const void *user_data)
 {
 	const struct bt_bap_stream *stream = data;
-	const struct bt_iso_qos *iso_qos = user_data;
+	const struct bt_iso_unicast_qos *iso_qos = user_data;
 	struct bt_bap_qos *qos;
 
 	qos = bt_bap_stream_get_qos((void *)stream);
@@ -756,7 +757,7 @@ static void iso_confirm_cb(GIOChannel *io, void *user_data)
 {
 	struct bap_data *data = user_data;
 	struct bt_bap_stream *stream;
-	struct bt_iso_qos qos;
+	struct bt_iso_unicast_qos qos;
 	char address[18];
 	GError *err = NULL;
 
@@ -882,7 +883,7 @@ static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream,
-				struct bt_iso_qos *qos, int defer)
+				struct bt_iso_unicast_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = device_get_adapter(data->device);
 	GIOChannel *io;
@@ -939,7 +940,7 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 }
 
 static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
-						struct bt_iso_qos *qos)
+						struct bt_iso_unicast_qos *qos)
 {
 	struct btd_adapter *adapter = device_get_adapter(data->device);
 	GIOChannel *io;
@@ -974,7 +975,7 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer)
 {
 	struct bt_bap_qos *qos[2] = {};
-	struct bt_iso_qos iso_qos;
+	struct bt_iso_unicast_qos iso_qos;
 
 	DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "false");
 
@@ -1178,7 +1179,7 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	/* Attempt to get CIG/CIS if they have not been set */
 	if (ep->qos.cig_id == BT_ISO_QOS_CIG_UNSET ||
 				ep->qos.cis_id == BT_ISO_QOS_CIS_UNSET) {
-		struct bt_iso_qos qos;
+		struct bt_iso_unicast_qos qos;
 		GError *err = NULL;
 
 		if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
-- 
2.34.1

