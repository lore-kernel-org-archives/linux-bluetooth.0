Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E24EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 11:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjHGLDz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjHGLDk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 07:03:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1881BE4
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 04:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8oAsaSYkuUNiZvVXC/dW0pj2BifNLWgaiL33iINuQRxIT4BMcjKX/NUo5sbioQNkx2fKwt0xcP0niHyz7kGhy2Pam9w3q03eGHaQNR1w4WCBS9lsWJMpaQKbZeu7SYF+65ipztKu4bJH5fkGxnu6UAmAkL69FpbgwdlKPE5e4NYYoBbg12FoNMmydVgUGP1ebgsO39tDo6E3Pp7m4dGYcIj6p8XdpDqoQbjY1iiDNIUVQYTsIsw4eyqAj3Pa/sAKp1BMOzI0/pA5qnxqORSTqcISWB/ZbSscqKmgaiMVaKT77cdSLOG0l/8ZPYOxJp0VGP0l7GztWjFEX9f6ytXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tkx05TdJrX/V8R/3Swf+kScbEF7MBI13XnxQ/WRAe+4=;
 b=lVcjNCtXvTFY6MolCINUize7JOkg2ApvUA5kySaK/FIRnL2MXefl5wAPe0MXOf+S97SGsqJtfe/O44RONsyn66fArhsE4yKtqe33m+8Mekir5+t5niQyYpe5WBGQBNMl3RzxLkK+Id0JnrSCyHUqOOsVKH5CrGOuSXBSS1T7+u3xsxu8UFOMyGvUr8DStADlzbuxLxMAdb4r8HAUBTBT/aGyE/7581WZnikJqLiJOZHmVQivcnt5A7hh658/ho2/BpokDguS9Yi6PO4mAHNZoMowHHYHFSjksiHWmnIrneETFFqC++/dTE+E5cnkm1Nm4xIMneX7GIC1vGILhRP+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tkx05TdJrX/V8R/3Swf+kScbEF7MBI13XnxQ/WRAe+4=;
 b=RoAVFWXzAIxLJ5aufbLlnu320bSKf8+NrgeVfOFbXAo7yuSqVU6ySLckZHvicxwiciVWfNtPxJV6KKZIprCTSzRrZ298UPd5bjyAdGuACOQTGR63qrhxuKTiqjY6WgdecYqttVN281fqXdMNLCudpnTmcOl2eQ02mqgXn99J3Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB8028.eurprd04.prod.outlook.com (2603:10a6:10:1e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:02:48 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:02:48 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v2 1/2] client/player: Configure BASE using separate structure
Date:   Mon,  7 Aug 2023 14:02:23 +0300
Message-Id: <20230807110224.6024-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
References: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBBPR04MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: aebe540d-fe5d-4395-9be2-08db9735d5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34sy0yWs+eIcawElmGKR6AeHvXZEUTfcIf+Tcgyo4ve3vH6D39dqMBWeuy4Mn4e3Xis7c/XejfzOQRX4beHcGdqmG+kVw1hcQoosZF3huE6sJp3VzLMXKdDBcRsKK85quaa18ajjryl7tzOX62pVCHPHokwtnZlNriJ1ziH7/tM5Bjz2JN3bt0WeS76QvZlvNxpVVNlwgoHuSOrZQ5y8Q6wL5ofa4kA9eGLK6S/feuEjABg3vRRpvwhgqmaIuXAC/tY70uL9u9aWOYqkm2/xQwELBGFN4+WCUdi93tvKdtPL/L3+Ef4X/+DGtTlvq5i+VDB5AhA1X6S8eS9ojfAeaPW2S7jeoY23M6cNPA/7FqY+1pmaxAYJdOMrpg9shDSEMo/JTwBA355Rp3b92YRTIgfhIArAGOyf1kjajGyh29uaO8fUVaBPeWwsSJOZDQfZ5oLsnPbQlGu14uTm3zNFPlCD4bgTigdkf89Jqw/DIRZtKn8GLPt68WKICCvvrV2Vp8ya+THkdAFEMAhHlwc3LiA/4copJhLKNPICmFzlKnUO7haHoNaaU4oUqoh/R+0QneLcUyuAuHvyz2gTkSF7BA+Vbw+bbFjqjust4ebFKRgbTLViHkqpsQaNDx21DkC4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(38350700002)(38100700002)(6486002)(66556008)(66476007)(52116002)(66946007)(6666004)(478600001)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SlVU7O4+CJudJAK9Oj1dTCIpnOzbFM4WvAosrF508CmBnarBmLEAapOStUZN?=
 =?us-ascii?Q?NZTFoeSLonkWeUwHhlhodi1X6/eo8yi3A4SxnoRKuEV7z6m9a9hz+HgGWICB?=
 =?us-ascii?Q?Ev3A4GzsesWfNkL9h+DXsq7dVFzjPwT10o7tQKl1SMhJAsJCJk6MevDMZrd+?=
 =?us-ascii?Q?KQdiTdInfdlYeHYU8trFdnCjsjAtPe0hVFn7zwrgf7bUjFqGMv+ab4pCsVT1?=
 =?us-ascii?Q?rsIr/RPnaP/QikKmjzAkWOUXvtBHjqWNwYYdTT+3m3Am/mfHHe6tV/68gUcA?=
 =?us-ascii?Q?9fZVNMF5WU9eDAgA//ZAt0KMvSxRlKf4twVNiesM2JRX3Z2MJQjlv6EDGmWW?=
 =?us-ascii?Q?udsVlniY7Ad5fzr/E2GmLak4g9SdMN3pw0Chj+rcVifkKyvzddDyionFSh6S?=
 =?us-ascii?Q?OuT5JASxT3cy2d1T4S6PgV+bSV9i7i8R3OIg3XGrcdNWiSjHEdDcjsdhYEMn?=
 =?us-ascii?Q?ajxQQZXzlydkbUnJFpYjBicT3a6FCJWOIzRYgwtkLWowrHpbmevnOqNe0V6L?=
 =?us-ascii?Q?4xGmB0ZREeUfYrr6LUQLUiGKp7H2nTkcYj33TXkMiOpYVehNYuk0rrS8whW3?=
 =?us-ascii?Q?jeARbbsUzIcxR4uHI2DeueBmps7IyQPbdc4MfpJqZU/RXRQF2fZxWUVh9k7E?=
 =?us-ascii?Q?FNJKOhZoYO0MRmQ4JuddDhtkkJOsxl7PjuMgTFSDdvwjpG/wh6utezYTsFCX?=
 =?us-ascii?Q?DhhL2KZv1kVBGf563fCKni6OJUaf0eiAesIPIF1bpn6mk5eku9nz1AxGKHDH?=
 =?us-ascii?Q?3frES+kdH8hFm7gCg2oRVzmmheZ7zhtlOcLVC25u9iHrBd9j147zde1d0V9i?=
 =?us-ascii?Q?MCXkKKUgD1KlxQpDVtWskk/yBjc9lLJuJjLiZ7jlJQTpMfFxz+79b/VLTkqV?=
 =?us-ascii?Q?QWbnELvmRRrv+5tjQHgNJj1CusBor6oY9Q7NKCqQvdREG6VjSN1hefG6Iamy?=
 =?us-ascii?Q?+ybuQsnk9sv3ziK2bbrbX3MVrplv1Xpmej9QRFoyBelvK1dlHAEhPt2NDupn?=
 =?us-ascii?Q?egTsB55w3DzexI2c6FOq8u4DELhSDXKYQdIfsDsegYDdc4oNM1OX4Iu0iY71?=
 =?us-ascii?Q?x9UHtMCIfb6Xsan+JcRfFgo1/CYjrPWGR8Lkawm9TntvqYKJEnz/BlqWx0cN?=
 =?us-ascii?Q?vNUpBkR38sPJK0rwqA9EhxoR8TRbW9xbdgw60zokq91q9Fj3LDL+YxYrM1vI?=
 =?us-ascii?Q?VbIaP6emNp5aQuD6Eledlm1ioVAEX5f9Ubz4LBXpBHvkV3Oizi4FwqIKBWQj?=
 =?us-ascii?Q?F6WZvKvsPFQPUbSXNYJsirlWkcvDNrdVE7YxHuFWzYWHrZYjGVPkek+yhopP?=
 =?us-ascii?Q?5PO6O2Klk8NAk9y9c33PrDxIqcxFawMFDGWfE953plDy0hOE9FVT0bx8wwEj?=
 =?us-ascii?Q?mfU/qsFOF/Zos4E4haekLCOU0rgqwuv1kFRGdz9ARPB0VecettJ1u527Q6sA?=
 =?us-ascii?Q?rz6XPWNo12MXzVkyzXiMYIvK0laH9a//lvyMTnlD77sJzmJstEgyfBj7DH/R?=
 =?us-ascii?Q?4RciPh35+V0M41lL/chVduHPtBk1fwTsI1F/hAo6ivAAkSGAq79UEmeN6kFG?=
 =?us-ascii?Q?zosIt5BU9tlt5Uzxl7+zkWi7gkFTbMGNQFl9gbPUPkGHesioFzOnVlnqMpvG?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebe540d-fe5d-4395-9be2-08db9735d5c2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:02:47.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq4x2S30zOXfUahpOpsH8Jw+wboSOtuhyfEj3PxFCz5lWDoClZn4YCyCXfvJEh1lEveTxZw666my6lyNt5PjIKrFDS847uA+AHa/hRb+vhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8028
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

