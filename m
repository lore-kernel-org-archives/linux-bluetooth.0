Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FEC0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 09:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjGLJDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjGLJCl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 05:02:41 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9291724
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 02:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYWfKgXSDNcLeQF9TO/4reHeNAtS1MI/AqLtpC7hw7uJU8PsbFblFf0klGfs6x2FxBaxB+tDXugcu8/EftRkDOmtI0oziPTPlbA6mUeqwsFIJPdnydHikc5vOJJ1LTFOX1Mw2uTIJFHrhZOw4lgnWndZG6OpxAoU1UFnptc58ieyM9NHCT1iUguy8vomIEofzqEmg+odzGYFkHKLa3CiOUjaCx3ta5crUHOFvQ56bXETAnGKtpeNBhrS4y/cWpSYBdW+WpcMmSW3UP7AsSrLWTd0my3SdMWPY4Qc4s51cWc9sYEowwslRtO4/elIJX01V+VNIqrdgn7UdjForHfZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=fTyVGqjqUGntI8aR+IMWbJ065cauIrexO9YcOk+meJ1VJHcHz/14HXDObUmpbB1Ii7sfPHmtqigORDInLkrzwvLQ4l6mMtcipRU3c8pLBEtNV7zGfGE5wUeyE5FIMc7/7nVjUiibEI6EehZt47AlXwZKDOjkbyijkAStdRO5FltP4SBHs17IOy3piq6uJ8C/43/V2AzhHD2zk9O+0cSc5rzROGhwjNkI9XVcw1It1BzlMn+1s6zvpi/nrPAHgHbYkKboYG8cOGgaR+TGbj6OYSAqPr1bRuuwHAGgtIcSKIy8f9mwDY9lLoIH0mn5qMtZiEjjXufkh7K1GKniCa6QTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=MLhcAUEK8zAX31awWpuZB1sL9Gv74DCNy4tCmvNf1fCSGc9qo6+s2k2m9VkFoY9DIYo+z93zaUmnKBWVYpI55W7Tkp+G6LYGDKaJKu4HLraX+uT0dPceERqSNqEFh7ztIxPEALxA038PZDsNCCMm2THTtZJSuy8WwvJQZtHe/nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8525.eurprd04.prod.outlook.com (2603:10a6:102:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 12 Jul
 2023 09:01:27 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 09:01:26 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 5/6] btio: Add support for getsockopt(BT_ISO_BASE)
Date:   Wed, 12 Jul 2023 11:58:59 +0300
Message-Id: <20230712085900.5423-6-claudia.rosu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96bea680-a563-43d1-2541-08db82b69324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDGrklGD4bWWLQj6wN6SBehyMFrB2FczXwnl9mo/GbglCVDjRMwkVhJB74621CHJfx1VDrfYwy6TqYo9GDZZ3rtnB3tYGzhbs51EHq5wnSiXbT+jacSCigr7X93Vh/UNk7FrQthdR1p2LNjYoiS2gT8hFhMyp+qXKr+y4OPLAaNJppottGnZpuhrnEALmKnBLxnBTI2NUumQgL0cngrTItg2H1+sxBKDk2SUo0feGpmlHWnLCKXvT7dG1PXgTkXwPdpkZk8OwmYdAZK5Y+40MRyGF0KKIA7ZYHHydMRUsjE5A3b8fV8Mshq2ITGICjLK6l4eTkH0fWVg0VDBNSN8AHcyPjeDu9oNbSCHx4ReIKf7BFvj2sAscbK7jZEKieZsRAHTje4r3T5+8awkmIMczKNPj5DJBJcFDre4LcDbxa8X3R4+XQyoXyOTBhRnF/1eb4YMDgYb5cthGyk0bLPjTT6coTTKFE2XZXOz7lrzgQNxdTj6xqvtIAGvpay/sQkLlt80qgW5GRNEqzy7HY6/UCzRlzppj5VAzaVcXrcOohsStTesosNBp26I6E1WclGZkt6pUSxqJbBXO2umcMfo4i4JMm+ZrFvPaOHEQtbisjMYaU09t6ty6k0UyZmCt+DQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(55236004)(83380400001)(2616005)(2906002)(36756003)(86362001)(38350700002)(38100700002)(41300700001)(4326008)(52116002)(6916009)(6512007)(316002)(6486002)(5660300002)(8676002)(8936002)(478600001)(66946007)(66476007)(6666004)(66556008)(186003)(26005)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWCB1otFWESrjRKJeMgGlPw71Xjt7N3+9up4PdAXV9s0WxXIWjyYYOI/lK48?=
 =?us-ascii?Q?ZYbm+wpmfZkf3MaMdTJBO2l6yWL0HMzI8KBoHeZzDCl79tbyKtplphf5z9bs?=
 =?us-ascii?Q?W0n4GUOkKrMbgf8diZB+KLvoNVCeaLylnfk3NHnKdqJ7o59D8a5C3JIFd/Xu?=
 =?us-ascii?Q?nrPNCzBv5hke18BrdKo1HFvRVPedGvPCDRdKKQN0b4v08JkbFUEKYzj+1tzp?=
 =?us-ascii?Q?gaReLdP8Kup0xW0ay+piGFZzAkv5PSbbarAxdsALyBygZgHghqve13Od1UmM?=
 =?us-ascii?Q?urK5b4rm6dXmiPcI1XYOGTP85fG/qvEZArsaZ7hD+gHgXRLYEFsheJaGksBz?=
 =?us-ascii?Q?vNl/tBxJXeDdVwTmNCDLjrPcsxp0yhoIH59fk80u1mG/fFgDOJq4g8nSgD8m?=
 =?us-ascii?Q?AKYPYdHBuTm/ipZK3+geyxhTKkFSUvX+9CsaEU6YPxIJ7ssFrIudElH5YEnl?=
 =?us-ascii?Q?Jh62P9FoGxlJVbW8ngFq+tP0NHIzkHmgDYTZWRCvkTHWQfVxHtNJ+6jgheCt?=
 =?us-ascii?Q?yqDJMh9QFOyv0rmXTmjjnofGxqjOn4g6khKUF6EO0LTSWDfgGk691oCai+Vp?=
 =?us-ascii?Q?YuOxvk1dZ+Cfrr9kNT+PqxDLzGr1kjDLvFZF1dWY1PNKk/G74hsGjPJs//2a?=
 =?us-ascii?Q?SolDqsTaL1Nv0P2U7XHje0S2yCboWmY3dLEmykW8pINiiChEukHWh9sfgXbW?=
 =?us-ascii?Q?t3IZ8SdMqnCYGFjw3RXje37LcYLz5Vrgba2e4+ptz9lVZSQ1mt+0qpA/TTjz?=
 =?us-ascii?Q?eCpbggw2BMXqVG7aqOgd0YG1EBhc5Mbo0HhgLAHaL2s8U62p4BLij6Sf3TGc?=
 =?us-ascii?Q?7d/i+BHVvnhhUt/XgerCiDjr1+nWI5sdFwMZoK6+fVI+1wOpgDwbwyD1j5Ls?=
 =?us-ascii?Q?Bq9oXxYebts7QsDh57nu/WmcXxB38yZebJ7wGyBGLj4Q5WIHBuHPmi1UMP71?=
 =?us-ascii?Q?ed0wBEMaq1E8wlh+ke4IfvvBqd8C+uZ/shJ3RCasmtcifSG3ymEcKtHIJfdf?=
 =?us-ascii?Q?CQKR2azVbsa52lQBtvWIsD8wMX72vsbh9CzLrcKrPtIb2pmRBpI6F/bsWSDa?=
 =?us-ascii?Q?pLOAEWG/UxEX9a4VJhxCemgBuDfN6oLWpHtTAdIQLx/nYwGSWbKyOem8q72y?=
 =?us-ascii?Q?+ZBU6TCnivZ+Ob77TUXMB2p7d+2SzdLwiA57ihbKHX60nDxYMpISuYFwAEHV?=
 =?us-ascii?Q?qG1x7VXFogNXaYLhCYSPr0NsHiKqXVEn0WUgI/gnk/FJYyq2eRuCRpAGHzRJ?=
 =?us-ascii?Q?ncnzPYWFTrF6UbttO36ZWOtZvnx/4BgdGxgUxpYe0ruSc1SQB2np+yNYqsJ6?=
 =?us-ascii?Q?tiotGM9GohL94D8SN8p9itsa2C6wjwlYmQZes6mODYVGKb8Wv2I7O1DQ5Pv9?=
 =?us-ascii?Q?yjGAC6iwLZoUkhfBrJrMhCzpDD+pW4n9vpz1CYnmcb8/sAm8lwUkT89ZNBw1?=
 =?us-ascii?Q?o0ORZEOD9AfZ8jrXgocUid5ECkhrGmMQuxExkWiEjzmx158C9bqEas2g1u0f?=
 =?us-ascii?Q?ilFL/SfQaa4XKthLe1sWf5VwhoFKMaf9HrZsqYC40pRVRzqLnHvQ+3u9c2mn?=
 =?us-ascii?Q?qUsea/hdgo9YHJS0tsbrr1PyrHz4k1MDhGkSGOi1maUDlW0+ZBwhcFIpRY+V?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bea680-a563-43d1-2541-08db82b69324
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:01:26.9047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6qLlCrXJB7HwCte+/NoB+J5AHj5KCr/+WnOXH5P10nfJB2H3iHlL7Ux5i55xHXqT0s99dsjo2n9kGPG54MBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8525
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the posibility for a broadcast sink to retrieve the
BASE information received from a source afeter a PA synchronization,
using the getsockopt(BT_ISO_BASE) function.
This needs the patch from bluetooth-next:
Bluetooth: ISO: Add support for periodic adv reports processing

---
 btio/btio.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 179be6289..8178250d2 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1638,6 +1638,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	BtIOOption opt = opt1;
 	struct sockaddr_iso src, dst;
 	struct bt_iso_qos qos;
+	struct bt_iso_base base;
 	socklen_t len;
 	uint32_t phy;
 
@@ -1648,6 +1649,11 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		return FALSE;
 	}
 
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE, &base, &len) < 0) {
+		ERROR_FAILED(err, "getsockopt(BT_ISO_BASE)", errno);
+		return FALSE;
+	}
+
 	if (!get_src(sock, &src, sizeof(src), err))
 		return FALSE;
 
@@ -1694,6 +1700,8 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			*(va_arg(args, struct bt_iso_qos *)) = qos;
 			break;
 		case BT_IO_OPT_BASE:
+			*(va_arg(args, struct bt_iso_base *)) = base;
+			break;
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
 		case BT_IO_OPT_DEFER_TIMEOUT:
@@ -1896,8 +1904,9 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 			goto failed;
 		if (!iso_set_qos(sock, &opts->qos, err))
 			goto failed;
-		if (!iso_set_base(sock, &opts->base, err))
-			goto failed;
+		if (opts->base.base_len)
+			if (!iso_set_base(sock, &opts->base, err))
+				goto failed;
 		break;
 	case BT_IO_INVALID:
 	default:
-- 
2.34.1

