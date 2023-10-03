Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1430FE7AD58
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbjJCOhx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbjJCOhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:37:52 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF8AB
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBU97v4uY3Ie5xEnX5Tq+FVRLEylBXrULBwfkT1yD1BYfPp/cEwz96ViLuCoGMQjKKWlIXRXvvkHVGyI4a4r+3HtpgLK4tNIj2rbCEpoIou6LcoI7JylX9Qig7302mi9wtuRb6lvKLqNVte8pPxEO7aEe6EDxObF9+3ZOtfbw5w2Fy1IIPKHjETTfycbMd74aQlEwanp0WuC35dfkMkIigUH6RXi+9P1mPxEyVcEDsfHJNJ2tfuuHFeX+ih3U6qPa6qysayeTs8f1ZC1J0OU7eSzGcPJS1j38gNk7VgQ8AJgHoeL726uLygsIy71uNZsiQzGJBLK405NdSiX8/TQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17SPUyvtHlFN7eSR/SdGzcvd+XbJQcSrexU17oOEc+o=;
 b=n7hqrpuJqXLlnEWVtYiweWKwYZx0ddL6fy6h4Xr+7NMgAqgtW1ckJHYt9HEOXfuZ3fJcU39sgmB6lVfFTdkMM8ez0UnvT5eIdDwJHApKSw3W4YBbU3qDugvX2PLk1I4tOB4nS4HjD05cWBeyDUR/n9k+yGlTiCZeSqBIZTr7JztC/Q/zSjZjZXTAPm9o+VT93D+QRYAmoXzkap64yuZOIX4/aMl3NCd8+glzJX/QmQnEq78BA39w1L0nruwNq0PITVvWBhEEVzdA0Sr/1Fmk6shCo8YZxR+weRoEM8bXE6C/0Zsh2Hm0GjCCxQzgDWijPMfkE9ccjLCaSVSA8Hs9PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17SPUyvtHlFN7eSR/SdGzcvd+XbJQcSrexU17oOEc+o=;
 b=HMoJGCy/TH1cgYxJKeHhNixJdwOCo/bKRDvJSQ7qhh8BtLx+4m/7fVzjhW8l+x0D8az9HbqmA9q/k6ne+83nnbfk2VXgaV75vrJ70M6tKaWkzcim4/Kwr7wjOG2spdKGakLVlViODiwWlMXmllBL7DOyKCuis8yjKdBx+bopHwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 14:37:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:37:47 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Match QoS adv handle with BIG handle
Date:   Tue,  3 Oct 2023 17:37:39 +0300
Message-Id: <20231003143739.2925-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003143739.2925-1-iulia.tanasescu@nxp.com>
References: <20231003143739.2925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0281.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::48) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: d1399659-798a-4e3a-6f04-08dbc41e4fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtN+5ZK0v3inuj4kUFEIZfV7PEF97SZXveszuFO+PNH6RdawmtRw+OqZ6f0fyzICKiGxoAfewv1W+n7zi18vJS99uLL2aFC7/bxkGoVgICKsb6DfxO0y1xW09xlHV7GNTX1SIrMcfMq1Pov2/VL/nFEC8bSQe1lNMjNi30iHRQjJoTdlEczUZI6SnxoNGq1Et5SwGKwB9pBC4gVdpu9wucQ4LNtk0HP70u+SDWT/Jj4dCjGHy2zC0TSUAAw9HqTa3HujEiDNL7Sv6Gl8PRLRreSDWyHl0hlWINToaryn7G24YpZlX+1DEQXoy5SGvsYguHfQoGd3G6CtN0GxzEpvk+oPsmGxxtJCGt4zK0V5FlAIPnxjO8uj9zjRjHHIGWrzyr1zSN+YGvIORSb1xPgDzIt9xJMVxwuIMVEpz8ncfHOBqrT9JdJZAyc04Ne98dRUCvfm+ahp7ifakPr4qNg2JlUzVjVKdFgAfn+JA8ca9arfCjXPOg8xXoEpSRWycoi8W8VIINTTpiZeTuHqdKBcPk0YCdvK2CRz0f2lil/ABMUEHRNDESN4DOKENrm5rTg1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6506007)(6666004)(6486002)(6512007)(2616005)(1076003)(26005)(2906002)(41300700001)(316002)(6916009)(5660300002)(4326008)(66946007)(44832011)(8936002)(66476007)(66556008)(8676002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxfUSWqhN9WWTXlFRic++HlitXOqKjvtt1MchNT2dgOYAjz1mzbdnkHSEVva?=
 =?us-ascii?Q?3Kc/QxlNVQsFXiH0yYu4+s3L064NmS34pprIKsOt1hpwjFE62xGjA9as/Sh3?=
 =?us-ascii?Q?YjP59CJfo1ZSFQcwLbDxJvhSb3TVdbU3arLjIZgQRaeYARPRRi/NecAAGvM0?=
 =?us-ascii?Q?/hUdjzPC4H5HgR3cDLmGzUtzMbzX7eElv3gVoKE/aJXamqa0TwoKqz328jqa?=
 =?us-ascii?Q?iwZxfz/qIKgFxNFjvYsG3MPjsfp8JnflzfeJTMP4xVpfJ7964HpIeNn+bF5m?=
 =?us-ascii?Q?Y6YS5R9aCoscud1svy8UksG6mv1SOEUB15pPDna4egGqm0l0rYuaYbmQtCEL?=
 =?us-ascii?Q?8x93uOxS7YNTvTUTFU+YWSoK7wbnFKovm50uTdMpkz1UReYsYh2uts+iXTN6?=
 =?us-ascii?Q?sEhtPeyzFqBKlWZs/V1B3wHxB/FUF9AAn7n723IpTfmKPCgU2m2msF+vnMHL?=
 =?us-ascii?Q?w2bRgsmfRE1hmhELcnsmlahqH5Bpn9Yj2I3BQl8bECK5H0X+H3LOsAUR2RX3?=
 =?us-ascii?Q?YwetQkM4TP/h60CKATOHEwN5ilFMFN1GzbR+k6DtrHTtJiP7/DFFeJt3NDjG?=
 =?us-ascii?Q?tfWNMvEsGLmKKXZYRZTOT/zW3lkx6bFmQGQmT2WBWwWhh5POY/ClJfsYaC0L?=
 =?us-ascii?Q?mjhGIHtjC+c5Z/eWqX/lGEc3rVhHFBqPuv+PVJbO5A7x4ZXSeAV5NDRSmsG2?=
 =?us-ascii?Q?gJxxm7+wFnSJqiMlnvKFrs8Y5yyzbusn6EJgzs2TV6epUO7KISwF1q6ZDswJ?=
 =?us-ascii?Q?RTCiqe8k2yYGS1g/Gju5rgBnUEFN8W5Zq5e5WsJb1ncRk+tlpXIlYZbE37eC?=
 =?us-ascii?Q?Q1+L7y34Tl0DDTovpX5KVmoixZMRgCymnLhynL3a7gxj8D3BxH4fSHczMs6P?=
 =?us-ascii?Q?B+d5g/yf5m1PS0Knh+zsB8vsQMMJhX3Zn/kogDf2+7C9H1OyloRVsdo1czfk?=
 =?us-ascii?Q?Hk6njj2+jbUXALL0WExZbSqksGlJX1NDJ0tvMV3kdv/pM0CqUpZrQxZX5j80?=
 =?us-ascii?Q?Rm8t+RzPZZhbvqvaGBuUphgR1MBy1oWBfRC6mb+++KBzUwnYRVFZ/tIB+tea?=
 =?us-ascii?Q?pvLCRuAgelC8OxTIe/DUkut84AobZhCWDsu7uWacgD4Ubfow90r3S3gfx4BI?=
 =?us-ascii?Q?kUknkv3FgE+OGSLdMAKFKo0W0d/0jyBiRJ2kQHr5xxPl/P4MNzw+24L1uYc4?=
 =?us-ascii?Q?Vc3tqV1TmDS/5SmaqvCGxyno3rCICMOgYJnafxnpH3A7HvrNroBMUzevRNt+?=
 =?us-ascii?Q?g//aeWMQnbyleC5PimTPpEoRjBrK9iQ+6UTOs+M4c2lJ1WcCPcxGHrVndp//?=
 =?us-ascii?Q?4FoshPkUOmW2W74HyVzD75a7UBF4es9P5xWs2vuomV+iHOpVEJfovjdz2y1Y?=
 =?us-ascii?Q?nIHynhwBBnWAx1SKO+NH89X/Pj+skgB4Wdkp5Pz8BJBf2+HRI67kAEwHJhIU?=
 =?us-ascii?Q?t1haM3/to5nirUtTSK++Qr2jHsU+LEcpFlyzT1b+l4Cd+Idwmy4eAs2F/KaO?=
 =?us-ascii?Q?s3BSDMaDuLrJ5zbeYxTRxRY1+QRDn3llozwRHM4t1lBP72C51xyUb63Re9yM?=
 =?us-ascii?Q?ARVwra7PPqwAnKsY483E6Iz3cJN20ugGs2UFnUS8PkmlLoFzVDECPyn/CVOd?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1399659-798a-4e3a-6f04-08dbc41e4fb1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:37:46.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khMOvG9BNCLNJrOPzd42ATeUHd2az9QvAhiLRdcWz+KBjkNfEScr0ltyEfOberDY+UWMUvgZnAC2/Ml2DKPKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In case the user binds multiple sockets for the same BIG, the BIG
handle should be matched with the associated adv handle, if it has
already been allocated previously.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e62a5f368a51..7890ec449a7b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1494,6 +1494,18 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 	/* Allocate BIS if not set */
 	if (qos->bcast.bis == BT_ISO_QOS_BIS_UNSET) {
+		if (qos->bcast.big != BT_ISO_QOS_BIG_UNSET) {
+			conn = hci_conn_hash_lookup_big(hdev, qos->bcast.big);
+
+			if (conn) {
+				/* If the BIG handle is already matched to an advertising
+				 * handle, do not allocate a new one.
+				 */
+				qos->bcast.bis = conn->iso_qos.bcast.bis;
+				return 0;
+			}
+		}
+
 		/* Find an unused adv set to advertise BIS, skip instance 0x00
 		 * since it is reserved as general purpose set.
 		 */
-- 
2.39.2

