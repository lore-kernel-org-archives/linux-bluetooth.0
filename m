Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78629C001DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 14:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjHDOLq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjHDOLo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 10:11:44 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569D19AA
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 07:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pelz/UnhX3kKuw7hysf0y2jUdn9etnFJ8Iz0wVkqeupCABAyOdJDwM+OK1Xe3q8aEG8louwY2BBm2r+onqctwSKFLacR2QM2fZVKBRlTCeE+gSPk86dxnHnqLFXRTO+/IrNk/wu+xcfcKUcJekT9rJflZjTZwJsfEXM3hOpSSlVMFl0/uZAPIzKLtJvahqHWfllfM9UCMiwLKzxAmdT7gpaYTAIMmxmSKo8vWp9FlT2mK6Uc+AN+Axe1vw8ytsl6aDWEe1ZrGDfhPTrWQ7FXkchxefGrI/EgY5XiJStfyCUxwbi2ppuZi2+VGk9M7Gr1iV+/KBq+Tj6ZoHrq2K6gJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkx05TdJrX/V8R/3Swf+kScbEF7MBI13XnxQ/WRAe+4=;
 b=WjFopY2WzwRszpuXQrpv1yBwF2gygOcaB6nugMSz/IZuuM85cWOLuH3C5dZepYilPwShflaNSazo7FslRPPlbYzpNbAMBAeK180hFZvqBaTnkrAcNs3k/XFsLNhiCJ68VQ5sJLeCRkcGhngf7Ktq2aBq11pv1A0moB4bQtJUhsyddcaYIw0f5UspK1UuC/EFMIsAqevE8AjpPM73BtE5LOmYvDtuTPojPO57AXfQ7SDw5DGtwiknqqeDB+6iYXzZKddRHRT99gintiE2PrkMY5OoqHGeGPZEiYOD8+l2rK2fP9VNnjEfqL4qFgQGEexPM98JWKpyZYJB3MX5m7snMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkx05TdJrX/V8R/3Swf+kScbEF7MBI13XnxQ/WRAe+4=;
 b=P1yhagUId+shvTTdlXqLxonB04OLqBTsz6qqvvFGXiyv6om1mbazpzqILBWVR0zywIEJg91HDxsaoireZmSNKP4lhIlk+lFXsqD3+TOo+SBDww+fakch0pxEELBKlnXs8mp4TztElhjNXkcDhREH2wxHwrGFs5U3Dqt1FTpCW+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:11:40 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:11:40 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH 1/2] client/player: Configure BASE using separate structure.
Date:   Fri,  4 Aug 2023 17:10:58 +0300
Message-Id: <20230804141059.24352-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804141059.24352-1-silviu.barbulescu@nxp.com>
References: <20230804141059.24352-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0092.eurprd03.prod.outlook.com
 (2603:10a6:208:69::33) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS1PR04MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: c22b29f0-96dc-42cf-6215-08db94f4b904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxraCxUcgGCCNlCxZCwBHAOK6Ya7a0oprl1T4VjCRbkFEmnniQxJs412vWa5JsChC8toGgxOiASqfaBWhhPHtkKZ21Zd7mv/3dXSU9mVeX+cBFcXvK1dyfanS12xU3+ugpk4k0bfpD7Ks4zR3bIbBaSGfaOQFT8bJrux1cJ8cX0f2muDxXC+DCVS7maBqASfhyg2wO/Th+tK8bH5fd5MMsXmOXIo5iSknomveNdN/JN4lKnwV+MrOzrnZOEMHMqrqqSyLD0n1vggo8uw47YS6tO+DthiswEgCK01UHu4SzPL1rvWs1EwA893/E09Z7LD+Rzylyi0ek5Jki/CWycmyiYe25w0qr1/b9NwIWDeKZhQuYVbLOTpAqZwANSz3/yt0lN9No52deJfa240q/NeMi9ZVCW/1Mu1YBF48cj4C4pYjy4lVNjEUIZmMvsdZyYoIWiNzsyx61hIEvEMmsX1MRDaIs7ctivPUVby4vk+3AEUKiHlcy7Fcs3e6G9kO/nuI09+6uO2/MxxGdon7GECoM5lhE+cZcCqW0DTCAxbQ+3OM6DBkGvgzwN9ILVUTrELZ2GWYnEdyEQAWEC4BzbDhfW2rn45ezas87Jc/rcJb2t6GN0wqctOMjZIthwi6Hza
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(186006)(1800799003)(6486002)(52116002)(6666004)(6512007)(86362001)(26005)(1076003)(6506007)(36756003)(2616005)(83380400001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(4326008)(6916009)(2906002)(316002)(5660300002)(41300700001)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4Wi+jWZWIF9ssUY6T9eR9i5Zl67D28Lueg6S4h82b7CkI622IZLckjPQDnb?=
 =?us-ascii?Q?wgwEHq3Aw4c3Qei3ZJ1Lpqx8tdVkyki0yJHJSpK0xPvhnnPEwHjixEauEGr6?=
 =?us-ascii?Q?kU1mYnZ/3080EDPgOISSfgL7mPOga/hMzek/9cFbIcuZqSEzTD0ulaX8qCHb?=
 =?us-ascii?Q?KoHKYZU3SVdA9FOV4GaI64QzKJfBWwkjKA47pLYoAKG5rECn0sdroTKHdOip?=
 =?us-ascii?Q?unNLoqlOXkWJ/gnSgjBY7IGjeNUhyxYiCb0zV4dlOP3KqQvMaTxb/Kg7EtBY?=
 =?us-ascii?Q?NYWW7QFQQrs/BoB/8ajHQARKNtCL54zVnotRKXzGP88avtVX0ISngnPNHwtz?=
 =?us-ascii?Q?eD9O9bOkJ64Q3WVDm2KxWgCTf52nTtwIZ84IulBpj7XCfAgpDTKC86hnVHDh?=
 =?us-ascii?Q?e8wCzMsxVz5az3dMuctWucXEi74bE3VZvFthJmynugcJyy9zXApIOleCC3Kg?=
 =?us-ascii?Q?Vh87FPooaOAbls7dWN5Xx3a07/E5Rd0xB1RJmOOG1BoibJYPYxoE5kjEcAUg?=
 =?us-ascii?Q?LsfP9p46KfbxoGfsbLU5K3hsYGfQfmGxZ0WoqRlTVuZpdPbU6t9XTTj/3v9O?=
 =?us-ascii?Q?3OF4bPumo1Nc27sK9uqap2nKltWVxK5YeFNXIqvBli4jvslnheVKUcNj5H+T?=
 =?us-ascii?Q?ybaHgx4lDjcrfsEb3kXftZPf5arL+aHSs+0IYVLM0sLiO0IkKboC0XtMRZwL?=
 =?us-ascii?Q?O0xEJjnExAdewz3CbNXz4lbp3xcQ+3LT0aUe/5/DwSn//92W7HQcP08u9i9q?=
 =?us-ascii?Q?/3lMgdj0Hmb9TVLi2piDImR5x4gz09AdS75ZFViWvyP0oEfL7JTV5tJ9KQMl?=
 =?us-ascii?Q?3C34nCEc6bFHUtgMVw9AqQqYduT6JHkzsEjBZkzpnYboRyIWOgyLX/rcID5j?=
 =?us-ascii?Q?nUGMcNmFGIoEQQ1vFbEw9Eo7it30JnC/Qg49r8B5OlNdR9DmpwLPk9wDpApu?=
 =?us-ascii?Q?qyd3NdBgdWnHYgKWDLaU+/EC0r8IZnHRW81grYZ9GqZPBJYvjTlhvyInpImq?=
 =?us-ascii?Q?fXRUpqPMhgmoMtWWotSqXv+dUXe1icnt3+l+rLE55pPzKicenswaLYQTJC+2?=
 =?us-ascii?Q?JXuJBP23Uh52zJ014JauJlIR4CbRC50E9xzZDMQaqQoapn/UYHBlk2M/dZlH?=
 =?us-ascii?Q?NUaBk1vYM7kXA338jIMR55khoj8hN51/ItBbZJ1EiwPIYhWBYZhY1m2wt7IC?=
 =?us-ascii?Q?IM7QA2ioxmpJXPqRHivEFhM9gVAUD1c7jxrnwmvCAh5TgYvuJ3m24tfwUrrJ?=
 =?us-ascii?Q?1Ew8lgF49HjgxOuhDSslgdlwKCWrt/UnXIvL/sMRXJqPdQLGhCF5uEKXIb8m?=
 =?us-ascii?Q?92R37t9vVGtaX4y7aiVuCan0rQkkCrKwPP2w3IVm284SC3tQc58CMNqwmwTL?=
 =?us-ascii?Q?Dw0GrqSF9vH3m/tKpfTSq8T4wGd1fZNMGUJfzCMrxr9+WIXChpqUb3Y+SJsZ?=
 =?us-ascii?Q?57ybK6xi1KoPomNKplNnLQzikH0OrFY2C09/o5qx/SNFIh4D+yL3B5Re4CN6?=
 =?us-ascii?Q?4EkFdUZNKzzfYMdvWiErkcgVB0PH3HoBJ8SfZTI/YFNh0ufmCOf6gFrvbVhI?=
 =?us-ascii?Q?dTpQ0Zkad8vKmzif8MlxJPqueN60t7flXBaZ2MY3IIxAjEU936UyZLa2qWxt?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22b29f0-96dc-42cf-6215-08db94f4b904
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:11:40.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYrZV/oTxtfVkZcBGiq+8nue5e8sXjBoJUh/qkrsPg2Tbj5wF6NkVDv+tKXdXTg6/2kSle4wn6axia2tEwYmCIDLNw1iJLvHHNhBmgMvoEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9287
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Claudia Draghicescu <claudia.rosu@nxp.com>

Use preset configuration in capabilities.
Configure BASE using separate structure.

---
 client/player.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 9bc5f2a36..00ab33084 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1735,6 +1735,7 @@ struct endpoint_config {
 	struct iovec *meta;
 	uint8_t target_latency;
 	const struct codec_qos *qos;
+	struct iovec *base;
 };
 
 #define BCODE {0x01, 0x02, 0x68, 0x05, 0x53, 0xf1, 0x41, 0x5a, \
@@ -1766,6 +1767,7 @@ static void append_properties(DBusMessageIter *iter,
 	const char *key = "Capabilities";
 	const char *meta = "Metadata";
 	const char *keyBCode = "BroadcastCode";
+	const char *base = "BASE";
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
@@ -1902,6 +1904,14 @@ static void append_properties(DBusMessageIter *iter,
 	g_dbus_dict_append_entry(&dict, "Timeout", DBUS_TYPE_UINT16,
 						&bcast_qos.bcast.timeout);
 
+	bt_shell_printf("BASE:\n");
+	bt_shell_hexdump(cfg->base->iov_base, cfg->base->iov_len);
+
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &base,
+						DBUS_TYPE_BYTE,
+						&cfg->base->iov_base,
+						cfg->base->iov_len);
+
 	bt_shell_printf("BroadcastCode:\n");
 	bt_shell_hexdump(cfg->ep->bcode->iov_base, cfg->ep->bcode->iov_len);
 
@@ -2758,15 +2768,15 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		if (cfg->ep->broadcast) {
 			iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
 				sizeof(bcast_qos.bcast.bcode));
-			/* Copy capabilities for broadcast*/
-			iov_append(&cfg->caps, base_lc3_16_2_1,
-				sizeof(base_lc3_16_2_1));
-		} else {
-			/* Copy capabilities */
-			iov_append(&cfg->caps, preset->data.iov_base,
-							preset->data.iov_len);
+			/* Copy BASE for broadcast*/
+			iov_append(&cfg->base, base_lc3_16_2_1,
+			sizeof(base_lc3_16_2_1));
 		}
 
+		/* Copy capabilities */
+		iov_append(&cfg->caps, preset->data.iov_base,
+						preset->data.iov_len);
+
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
 
-- 
2.34.1

