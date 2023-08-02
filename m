Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE3C00528
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 08:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjHBImN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjHBImM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B4194
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 01:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izfjZUEw7YWx5N3lzvGsa9WhMsY+yXx3z90BzfCQ4fm5mobVIoSAZOqBaYcLwsp5BBzZZPnwIXGBcaQcNYUDI+hFycOLfqAJq+UBJdcLek9HbbDctjg4Vv878wpkA1PvL3rSWkQEIyXLkwSJfDgTQhUHr2BYfO+So2hZej89EuiduFnoDVwMbJD/nb6H56VAKRvWjqOgX8TgIuSNPivbfpY5L0d2KAGmPPafrNSu+kMvW9wwxk/LHaFecJusZkKSghLPrFlHy3lwHjLVbNAJcZPCK5+rL8ddf0YqB+rt67YmXABxSdEoD4p0WCi1cDzT6JL52R6ETXZ/VpyzZ3lOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=T7LkF5wvMLM/H/Zc7PqXIA//4RHszL+KIoRdBEz0tZmb3OWeMzq2cMHzjmAJW0j5vCorLcU5yFI84rlqPtyaB2JtBZk2R9ybNsiM2pqjnAJeEjcU+GFOk+fdg5DRZ16KNo+/+Ov5Z53pii4LCRPT6E2QNLTA4XEUWLZuenLgozidwYjajv4CKcUTKoVch92j1UWzRLsgCufOybR7S1R0tUTeuHFJdsVAqxHLXK5Ikvnds4BU9Pjg3//0MvN2+AyhPd0qoYQC5yPbCHVK65TK/sS3WcwaGWS31hDwcr5dfeIZ7PWs60JQf59d8DSw5trSf0TT8wtIZS7mLrgoIPih2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=ceeOzJ9b6GW9beqA5iCVZetKCbRP3ddmdvqXoAfeDh4/ZTG0RyR0jD+96e2B2jeRFzIgPBzOg9m/u+J+M7f8scF1/ktNhRk033RKsL8DmsWMO5s7IpzN0jvyYJUM0a/g3X63TmafBGK5WXB6F0chzCrbDH5NKu4wesdKUC+yU5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8503.eurprd04.prod.outlook.com (2603:10a6:10:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:42:06 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:42:05 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 4/6] btio: Add support for getsockopt(BT_ISO_BASE)
Date:   Wed,  2 Aug 2023 11:41:38 +0300
Message-Id: <20230802084140.51105-5-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802084140.51105-1-claudia.rosu@nxp.com>
References: <20230802084140.51105-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2947e2-e9ba-44df-fb5f-08db933459c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMsMK4RniP0ijoOyrG/s1ZDrx/zun//41/2GLP9yeoflwWk3/pSUFRTUeaxn0FrO1dIy51akBSNi2FLMXcXYBwaSpmI1CpGdCvSgDyxrHPU8P6o4B7JzvTUqeqDTK4oeUYGuiJayOyrFGg2UWKmbmtf58yHEPDWr4dIO2EG6jT8wk+KGjdEWAdej52LhDDXkxJa9Ya7NzOKHx5ZiSUKkTC3rzgjSXtk3BP4wuCHJwq1WgEG2qHDCeCmHsnaEh0B6+clT/SJnDZYQAyQgvZ73D+S3d8H8FalXtf7ZA/gRFR5Sf7W/ETKo7DBJhv0n/qanoPgidIKmCXkGYGQIsvS93/jFpZoSjn9C5dzyqulmmzlXBYW5F4RkDe3OxnTnxehmjFu0c3w+NKE9VZlwyD/PqyxQWe0d1vMzgWKYHJepEO8uzas2OLfafz0qhx3Bse5ZH7cLf5ZGVOXzd0LXlq+jL6+IHAyG4mKYPhlyxjX0CKOcfk2MfD+vagycr1OjcL9s1VSYtWPBQbPhexkH4SZyQ/AFjxPZ3/WUQB2TY/mZzClM/i3ILijnSKDz0CHbgQ2I1Elsgzshyh44vgzT63xzv7pvIsXW9sD3rPeDJGvUQucbgQjpPGqO4qVj20IGyQcw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199021)(66476007)(66946007)(4326008)(6916009)(66556008)(316002)(6512007)(83380400001)(2906002)(86362001)(186003)(26005)(1076003)(5660300002)(6506007)(36756003)(2616005)(38100700002)(38350700002)(41300700001)(8936002)(8676002)(6486002)(52116002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NjvGYJYsIvH47nlJTlt8jd5crlEW2DYMIEJhZSOOYtrVpAoscTHOPEZSmpkJ?=
 =?us-ascii?Q?lZxJJtpk1UVjzOVwYSQuGZFQ0+ZXE6X30mZrjJgWPAEvcK76u0B958vWAID0?=
 =?us-ascii?Q?udCO1IUejkN2IpjUcMvlPystTbS73UnHwbA6fZ7KHAa6ELYJlaOj0e4xnXpe?=
 =?us-ascii?Q?EiMMISfnB144cbgeR46sNMj0wJ54D2tYR1VRz5JJO5zoG7OKttPgcHIngpFF?=
 =?us-ascii?Q?40nZVYl2SsCddrMt99rH/fowXw8DRYC1r+r8arbLIkvAGp3O67tVb2ySwxQy?=
 =?us-ascii?Q?z8nHkPGSNAhRM724WIXCfCDKxxFZtzhAZAHZbvo2HiO72/pssI+A3Bi7Zpse?=
 =?us-ascii?Q?havLiiOTzxy/JwJyS6MHfb1QZlQk4B4GrIVab6zRNO1xEnM7RrUrgHVbWcuX?=
 =?us-ascii?Q?sFIkwHfbZFAdiublXO+fYtzEzTu0tmYXHXGMEfQqFsYqyPZpijL1XIMKB8k8?=
 =?us-ascii?Q?9mAKL0eI3nj28+e0jHJtjc35gHTi0AT071ovTyHEomJIlHZj1gCAek5H/LcC?=
 =?us-ascii?Q?gDZTOnDfQZRbbdCBbyDxCSnJo0ihAnkP0JJCoGJA9o3j1p9pX0Tq0yWOJW32?=
 =?us-ascii?Q?QghgnC/nEn5M02hvrPbswJqumIsRIwYf/3fIRAZetfpe8iFqzUio41OlSOGz?=
 =?us-ascii?Q?R3wBQ6wK7m/RZrY5NTwPKc/gwDQYN3C651I1ZLmJiZVpV9i8RWJszoAgqWV3?=
 =?us-ascii?Q?9T+cbk2pej86OOraOAU6dhN1bbnoOSYIcVu1UprBd+kK+VqjEMh9b7ZMyL+o?=
 =?us-ascii?Q?vd9PONLAs0MPnpYA1c4o9cjNCZ8wX9VauOmyDn71pyAwwc1sVFcJe+UdjhiA?=
 =?us-ascii?Q?QFH4hcp3Ol9+qqgz6EsfWHHIDkH9BX7giuQA/1t/sHZQuCenNGdbWXVqpUwG?=
 =?us-ascii?Q?yeU8clUUr4E01hddryv+BeGip7XPEa7AGtcNh1nwNm5WS3wVc4h2n/eZloRO?=
 =?us-ascii?Q?00upVgrE/fOtVIb7vqkEeIN4IJJngRpxnfu2l2urM6SQqz/7qmjzVPLDS8hg?=
 =?us-ascii?Q?gS6mJ3RWfl/LyEJKIsJ21twWCx55Ra5DU3DjjrSl8HJ4n7SRvMqsbfDG3St7?=
 =?us-ascii?Q?LmO4yMty6hTYzswei1BXnMAXp/9J+/N/uhSltSnEaO4wAp6v7w4CJKSNC0I6?=
 =?us-ascii?Q?q8sgTJC8TzxJl68RGofch4Al3/Ngd8GlXpC7OQXhYZp/H0d0W8Z7VEsumZlD?=
 =?us-ascii?Q?zAPSCF8oKyh3MKuSdmxHsnXA64aIMDEdHMFeuWEhr9WfNqybE9FpWrGcB+9r?=
 =?us-ascii?Q?PKDduEHPTkrRGUDg7AXoHduLU3agx51JScaDPxaa/i8WXBat7t6PQo3XWrpm?=
 =?us-ascii?Q?rqi6ayWYyRDKpC7AMkFfAhiRN+VsyVhgE99aOP4UeIASKAIhKSuuENbXZGGq?=
 =?us-ascii?Q?dMQNOqDY4C+2xpyGlfrYnu0I8B71D0ctahvF24CEcptzEXEdv5Y4BIf4Cl1B?=
 =?us-ascii?Q?jwkZi9Slvcmv2ViU3edvia7ZqwkCfN+jMIPa0PqMmnGHNNaXJxTo+qrTyla5?=
 =?us-ascii?Q?CcP3WXQzHJMwKCjRzTLJ39pU5niv0bUzu9qcGwlMVXbBqmrnedXUt+UutdDD?=
 =?us-ascii?Q?O/h9KMDlYPtBVbYbXNFo4+XdhegNZZnAK5helQf2+Py47vqBG/3uJkL0W3bG?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2947e2-e9ba-44df-fb5f-08db933459c3
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:42:05.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5586IOoXVR8otNV5VKBh2TptH77e8QF6OUq5HB/clsUkeGXlOR0/N9uUIG9QvdOygEJywJP64swBlwZC9z+V2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8503
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

