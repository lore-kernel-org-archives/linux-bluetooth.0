Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D15C001DE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjHHQ27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjHHQ1V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:27:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FB11F5E
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dby5z8trP3SRp2DCrj46TQhPvroAkLgscEHTMnsuehWobDZ4NWynSY1mf4ArnE8DPQzh9ekk7ptpwTZx7mclyLFF1r+y+REIIrJdIiOIguT+KM/FYV0zCpBVLhGvCjjwdEgCE68OQxNKZPUpidkRCaFkNKxk6iFcUhOYntGd8bbH8SlLpjiteYfyEFJ3KFAdbGvW8XnV5m5LJbIwM/ezN+g6DZpbJSs50xpn0Xd/x9pJSiyY0wIsw/6vdfEfn/YhdWwncspsY+FTsfrKPt33w8EiFzSawXpUYGIbPzIIygawxxV4Ef6e0iXqVKRmL31ozB6UN2Jsa44mPPDDnbfGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=iY4J6/NtqeMi4HJWrn9cHQWEAZRin4LvL53kZhDkIc2QOlwyveuKBkIAtBAeLxspFkkMsTUGLpxcFkysxfPVneAOxAa8xf+AC5hcgfQOBFXBykcbVTSFl8jXCXnAu4Qn/m3ZN2PZDhb/Y9DEn2uzXlTSXnauyv836cvDbfOAfHz3Hwu/IaaIkTU4DAZfkU7bNB3LZ0zIsMf4aSGRJZ94KGBtDn0+yENEE/IZ0HFveo7Y3eELvVqG7wSEb3sad3wPwDH3tInxbzbR/nEomt7kO1M9sUok4r8hlmgUDW9UZkR/1lrj1fn9C9l60sBREv/4nBjSHVcO8xUNOGToX+6WRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=pPWcJECbqOINy1tBjLXPKFDOfyxuJMnXEjBMAm2TD99BARw4PO9+g85ZzgJ3QQuAfJe4Vu7PmFtulwfwsqOvvgeh948bL/lTpFLE89k0AAvQLujgmwGNnhTJeXxGwPUP8CN6xPZZkE3EQfJRhylUIWrbZ07G33kxnv6h29qjTiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:53:04 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:53:04 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 2/7] btio: Add support for getsockopt(BT_ISO_BASE)
Date:   Tue,  8 Aug 2023 14:50:35 +0300
Message-Id: <20230808115040.4403-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808115040.4403-1-claudia.rosu@nxp.com>
References: <20230808115040.4403-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: cc509657-7464-483b-e9b0-08db980605fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQSyhgyfwlRPkBF4fhVKOuDCb2h/kD31xCCbFncA5m2NZOeTjgTBdgPWf+cm21kda6acivCAOBuC1O9gnor5YfqQOu1DXptZTGpkdtPB8c/vd9Re39m+90Qkyg221NZOusfFQPhM27UME8dHjYuFZIXnqOL/niX7IvwT87JekVuJPz6ZMhuNr8C3OpaW0s8DE402SpI8TmVUILJ/tkYOX9GcTvpIu7owQ59mNn0VkW4OdwWEBCFfJSfCmODXlsda7wcTaFqsat0nkN8KFbK5GGbLkRQ4rumkPcailrpo/BQnmtRTImrSecxg6NbaRDxt2FmfHST+3oxCq9AF74r7l7aM1C8u7a4KjWPJ9Im1QZiUzb8nZNZjR7hNcM7/2X1GWLjbF9Ej9/JW9MO3d12OhuyiA55eRy07a7oNzSDujhOH4w8ZKGR7iMstrUqKlVugDpKUeUene4oo7QPnsi16FN4pF1j8p85t6G0YEb2HLJfGzvTc7sJASsI8J37psiChGRY+e8FiJ5Bj3lG/KY5xrcMZNP0C10ZNS7PsuzvraDOsbZF7hLufkN8Jn9AFzsBPYRWxjkMIcvP/I6HBMPMmCoU7IehzLnOog2kKVFDIHgC/Df+tHrzlMi5QijnXAJtY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xT6DDSDbWMcVjBsOmTsZ+Di+5L+KRb+quyWX22YJGyMviJNtELn/teIC/UD2?=
 =?us-ascii?Q?L+cKHGvFypEgpO1urRzQ7OE47tJ30+ss1xjPDgpsNzwzkJMUkfsYlQy7JLB8?=
 =?us-ascii?Q?kaU6swjD6Eznz6/hipRQIUPzG3AGbQgELwY95Pv6L9aUFOmDZmfcpcwBN449?=
 =?us-ascii?Q?BgN4WwzOCNmicu2p9P7M4zIuswhwi9RmoLESVsZHXLex3s1xdXdESz0+BImt?=
 =?us-ascii?Q?kmNqznRFYEBWS7pKGONhS1Jnq6vCG61FeiWeF66vn8tvlXtCtpbOe3cL27Ts?=
 =?us-ascii?Q?/ZMNENDf2cAwU8tqVtkqbiSUzuYxWTzwQFq1BHGKSJYmOME6N1hn33ymg1C8?=
 =?us-ascii?Q?sBglIXWzkmnkEH04Vw5ya08E0em9mhHh+9wgaWkTK48zzyC4qoYiBMDrs6QU?=
 =?us-ascii?Q?ZcqvWgMJ6r72mU2GVY5e4BKzg5SJNcT0npP+eK/r//SZGe5yfZPRz+iLVbsO?=
 =?us-ascii?Q?8cfKgXeZHZ4sS74oT76B0YVyRlAbCBOtYQGy/bzTHjJrUj6meoGKwTq0zAL6?=
 =?us-ascii?Q?dSVAAQxK3toIQKSL9ma3jmIX+1D1ziZXiH6m+cMPP3O6/3VaOIJngPVCcY9r?=
 =?us-ascii?Q?FpoW5i7X7vMMw783uTZWY9lWhWEnl1N+f9/BXBsAGey8qOwtxMxkiPekuYRj?=
 =?us-ascii?Q?GnEEIif8u4M0X9z0hvzJvf8N8i4f+Ge1y4Z4gtChJuukxqmvnzXmyEPpZIcC?=
 =?us-ascii?Q?h64B6npopbpuc/TBN2Vo094RnZZrDDcxuhGzQzd1y2EmOw1FC4b3F0jjLrem?=
 =?us-ascii?Q?FWmgGQlgEeUChE3f0ygo1dT7xhbPP0fOV4yMx71eTcLKZOGYgYhJzsd51Yx+?=
 =?us-ascii?Q?iD68XSTBmrKjNPt6MZU5rKh9YpPgp+q5dfNhX5l16kxq9GJow1CWO9/Smkz7?=
 =?us-ascii?Q?BQtb8ADnVKwbPlhpO3XYkkYOfcnxyJQJnxyWeMv80c28VLSDm4x7Tu0MpK05?=
 =?us-ascii?Q?tlc/HQFFAyxd/mZJvBdXvcXz+HLryMXkjzlvswU/3CknYT+fhx+v8nExOug3?=
 =?us-ascii?Q?2l5aSYCqTNgExXyG4kwsnw6HHXjU1FIuhRnaFxGkNGUY4c8NMPdNCUeNJK+9?=
 =?us-ascii?Q?qWEVH3HJu+Zt+nS09Ml93J28SjfIVSuIyrmpOMTzYuDky38PN5tJrgTCITRN?=
 =?us-ascii?Q?LMW9C3ZouBxQd63msZQGNnEZaU12j/DyhloxDTvYM+Agza+We0m/+GxeVdon?=
 =?us-ascii?Q?aTWTMyDPO7N+8PIAl1bAeNyskeEsxWGMvy7IXvRitMnmkIORHCSN0zuDs7+n?=
 =?us-ascii?Q?xb34I+NLE3QEkQFnxO0ybw02QBtsjdEx6kD+W6YQywk6CYHE7h2bIvWRgVuf?=
 =?us-ascii?Q?G79GzRywhd4ST+2esEw0ABgOZb349VSrKPRffnHlIPiSF5D6KHryjz0bHPZ3?=
 =?us-ascii?Q?4e109Ng46aHsBAbF6z84retC70jOEbXI/+NgEiDHr02+7T4uvjtHYw8imcNX?=
 =?us-ascii?Q?tSEoIYqSO/g43fhD3G6RV0UGz3IDOQfw4L6MyUg7Nxxw0kozj+evGOFz1gms?=
 =?us-ascii?Q?uOEqLYNbIj5a99gDhn7I7W1aazTPKqjZS0grHDfIPPEMfwRr0F4E71vRosTo?=
 =?us-ascii?Q?G2g/SVDco/KjEAL8P0xMUtsv5R/lc8v52WubWp2BhJm0i1ldO9daip8SkskM?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc509657-7464-483b-e9b0-08db980605fb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:53:04.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn4HJ35WiRqb93QvEn71gbuLn53bwGJX/QNDB8dxX4T2gMXbR3H0F6FbMCNbysSembEQzETvACZL1Albi4OTJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
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

