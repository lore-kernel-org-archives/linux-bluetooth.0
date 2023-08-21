Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2C5EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjHUMEd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjHUMEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:04:32 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A288A8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It6U9xbwwFLXNdwQr4QXqvrE/DqtED7WqaMbLdnaEfYdI/nqeMAcYHhgFhellrUxbtUMPnFmDkRAnKG9RnQ0AzV8GhPmbQeIOnl1uyacY5fMeG7DVonJWnBiuB96NX6qCbdq+TwBLawFrZGUGraZXloKs4kiArdKif8S39PHLFKyeSwwTGuZaeAdwyUc3I1AG8eqw6Qu7756AYEDjpgD/KKbBXn5/p7TKNw0ZXRswSm7JBgKfGRcznfru38QCeJbx7ktkvXInphRtI/i7oCYqrZBu5Brfitz1SCnidsMH5fqO4iTA48mAxE9G1R2G+W9Q8ujny+54lwTbqliwEulCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVdet1ZEX/EL8zmNFfMoFY0s/PO9xjuKS4lhh7KmUww=;
 b=ebBGKYz/k+XGgutG6ta0ojt5Bj7/YfwkoY9feA2c0Zs+2sworQPjngxYTtT5KtpPK9+0ecWLwyNWtL16P6BiR3pNyjUjAd/tbiGQ9vcec18x80T/w2DHqaFepSLG3RWF+3rk2PvUJUnUoj2ryC56PJnSXuZYbeMnMU7W8/+sxLdzteE7sPslzGS1Shu7aVG1OyD0Tzm5hMfyLHq/YxY+RooDw5IyXikHXKsKCP/WC0uW7TLYHZi9I7/8HdQhLmMiLvAbSDE8JGe+5nuC4eSaAFkmQ65tx9JdOFVEu/alDS/m6CBVXJ8Wx/DSicwhXtnuGdlEj5wkQJlh3vo+uJVBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVdet1ZEX/EL8zmNFfMoFY0s/PO9xjuKS4lhh7KmUww=;
 b=Ql+l/FiErZRHiX/1k/qvMZGd4a5v81QUjQqt+If6YaqhXrY8pEJVbTk/bImsRlPRr81rbw4xJ3hpZHr9OlvRF7h0JgoVHTXnZ0nlZTPLPfcjkpvl5NdrrsRQ543/L2pt03sVFaHfWxcz6QereyRuwk5azmYgQHP9DxivMa02inI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9586.eurprd04.prod.outlook.com (2603:10a6:10:31e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 12:04:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:04:30 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/4] monitor: Fix decoding issue for hci BIGInfo report
Date:   Mon, 21 Aug 2023 15:03:52 +0300
Message-Id: <20230821120353.28711-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
References: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f20b213-54a1-4a74-03b7-08dba23ec66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fOJTdh7pIEC0Ub58H4JYf/Z+0V5otQHifQ4b5opIZRBNwzOc+rgXuEREt+jSCD8XbCzvHLe2CZlSX1po8fqa42/gGsGJbwA/376uaji1fMm3GvyKzfgS39YPpioB76Lb24zZWw9CeSId4EszBkgjhiqs4xtXc4lDuTYjEyf55gL/bpr93Kz+R8sfchH2ZYRQuCjbvS7UpPqfOPTlXs7+ZJX+5AJVU75aYwHXE4e78hyAB/7TwkvXK+tR5miVYGIcYr/J5pzODEf95unPe7LNSKZwz76/0rTu8uGK/DlOhsIF/h8W3dQoCtQo/xu53AL1TiaOGJga52OBh1MjeofqgPIezemev9QIZaY17pfgHsaJBjN/X4AVb6B4ccA0F0h08VstDgYtL+5ifZGWNRf7HEuSG8O+ZGI7D9a6ajSDwCGQ90HTiULVnUsuoNeF5MnYtxBeCqRhy3U8ps5sHCH0S/xcLQn/IiRyALcnd7nHmzjhwJSIBukXuL8j1acy6qiplF9hewne6J7LRIPMiBQBKB0tgfkITLlh7zJ1Mfbry+4VzZR94SpGs4gRRcdG60gfa9AVpHD9dcrESLgzwdDbmV6yeLL16hkB4yjCTdVzaJ1FmhzHuLSpPJfFlQ6UtDC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(478600001)(1076003)(6666004)(55236004)(6486002)(6506007)(26005)(52116002)(6512007)(2616005)(4326008)(44832011)(8936002)(83380400001)(5660300002)(8676002)(2906002)(4744005)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wX88/Lbu9U+Bl1Pp/AzDaojag4buSFUR9tQ2oeZGbEiyRK+5lCxR/ifABsgW?=
 =?us-ascii?Q?AU+LNc0GKuoerSReocByIW7BBCgvl/E7HEDcbtMi5ncUv+c0IsCU5x3VE1Gp?=
 =?us-ascii?Q?zUNM332otHSmD/y4WPMj071ME2V3DnWkqD5Dt60XRyUpH89HCNqS8Q298sVi?=
 =?us-ascii?Q?GBlffpAdfX2yu0FXvN4eh2t1r/9/VdlvTVl3sZnRGPXU30cMfijfZD5r6SRz?=
 =?us-ascii?Q?j4c2zdMtAg81SgI+JPGEklB6xQkFQuiOK3nft666ZKbEZSOc4p1ASrzm535q?=
 =?us-ascii?Q?XzAfWyEdtWPrNTbvQJu82WL6336jEL7hasonYcuwlSWDUQyUGotJJMVJ+nXE?=
 =?us-ascii?Q?PECBo0T7h1qpNQjdglvXPMVflvRVoA3oT5RLR3fBfTnlBS3gWPqWhfgjMYSm?=
 =?us-ascii?Q?GMG3X+2QOo4n+RAcyi62rhjURgIxqeWh9g1aftLI/k/NLVgBysceb/Omxi+p?=
 =?us-ascii?Q?oyEzFmHIHCGp3n03jODsyStunSFgkB0ZuN/u/MTXnxc6gpjtERwDMyOfnMh8?=
 =?us-ascii?Q?2BkhyJ9fg68V1YYkPAyfDVM3WL9PQQPO1zrzuAYB82oNI63vfJ4j8iaua6PK?=
 =?us-ascii?Q?KwIospXaJloL/Jv9EiVRYext0KsVeNfwXaNIbwVVBU3fM1bZLQH4B0xJ/4vj?=
 =?us-ascii?Q?av36FBxrrbmxam/QuIvNglikBCgAw2XJO1n1b+ztOVOOD1lcpwm7zLeOohg0?=
 =?us-ascii?Q?Q2UFANH0G1wE5AihUiNYItEDEX/qOLXGjtCiuTZL6tKSDtQ+7NQRyzG4n5o0?=
 =?us-ascii?Q?0d2S3HTXZYTfWcmyQ0mddZcaEPCPh01SrHlhHBaS6h59n7DuFVlZd+8lOzoK?=
 =?us-ascii?Q?xfOmdEACTTbwyrN5jxl3d/w09gpUnqwVahDE8ssdmQuXWdwaG50fLgGv0D/D?=
 =?us-ascii?Q?HHRKt7l3KCsbDR2mfD9dg/1o361OiYFZar0L3otb/KW800At+2B+ekrZ+6yq?=
 =?us-ascii?Q?Xjsp3JgsTVh+3Ed0Ybh96XvYvxtgQ/oEC98x5Xc9O0hgJ2Xy69zmogIB5XOh?=
 =?us-ascii?Q?IXCU2Kn6nIKNn9aWqnu6mjDd/3ky+UHkyKvahXlGDUgtFFgtUgi3Hjq5Otsp?=
 =?us-ascii?Q?oaCBJGWd8wXy58Z8wGWmtBMHoJJEyBP774Zonjk21vMcEj/GDkwYNjTvKj+H?=
 =?us-ascii?Q?+UqcysdUYk+3CTs4EcqcrBzE6uR7Bbs0c/TsZ4jBPnDZDEaGnv3eN7GQOkBd?=
 =?us-ascii?Q?tzsRhJPuT8WghhAsaPCgn+FHZNu3ugKyqdZ9tyX5QyySMYameRslYEOrX03S?=
 =?us-ascii?Q?xyICeTiBZX7kSNtHXZJm7yWVzLaB6rQBun6rHThRx0XX2saat5GN1XcZtriQ?=
 =?us-ascii?Q?5KT3o9dC7fK+2nPOAYJ/2k1YKGj2V3CdSEfULKFoRSobpKVgzPy+HWldvhuf?=
 =?us-ascii?Q?zPqbog/D6+EmjYxbffsuF0LFAaiZvKC9MEFPXIVAlzINMKA8w4h+5zOBI0f6?=
 =?us-ascii?Q?t65Z0AYU6SoYA9kN0ST8XP9xL30YPt2rzLxgrYRw8JlANB8CL4kMplXKfMSo?=
 =?us-ascii?Q?P9pjCnqX9tI8jaJhkG+ywV/hneXLVcPKAmpLjGFcWkFa1d3bWkTwQj+5j3Zc?=
 =?us-ascii?Q?PxssGNilobMgzl/diOhGQ/XKe4irhF2oVMfQCeMOJOLQf/6hmYpypbfiz4R3?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f20b213-54a1-4a74-03b7-08dba23ec66c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:04:30.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTDUBoPiVDwjdGfSwg8GSNJW5CD13chUaJOqjVphjtiOBwOrqpyRnHXk0QqjIqlIZtjjuvOkTyOBFmU4IyD+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9586
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the fact that when decoding a BIGInfo hci report, the bn
fild is printed two times.

---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 96fc2662e..69600e93d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11783,7 +11783,7 @@ static void le_big_info_evt(struct timeval *tv, uint16_t index,
 	print_field("NSE: %u", evt->nse);
 	print_slot_125("ISO Interval", evt->iso_interval);
 	print_field("BN: %u", evt->bn);
-	print_field("PTO: %u", evt->bn);
+	print_field("PTO: %u", evt->pto);
 	print_field("IRC: %u", evt->irc);
 	print_field("Maximum PDU: %u", evt->max_pdu);
 	print_usec_interval("SDU Interval", evt->sdu_interval);
-- 
2.34.1

