Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672DCEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 12:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjGLMYl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 08:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjGLMYj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 08:24:39 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2EE9B
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 05:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMytz7PNTu8j62XABKUXQM1Z5GMU+IFv5nnrdco/alXsUxJPqGsJ4KfOG8ObfRMnYFVtfjb9+PJQY3B9M7WFvBUI0fhys4cKRAODPX0dwwm6PvvRB8rQH3VSa3AluMJ8AqjBAHnHfBnBwuAhrQRSWK2JqeZlNwy+n34n+8iDIiAcvx5NN1fLyGxBnr6A2iMe0m3a/J1tPD8XF4PVhDD6dKw2EvfccPEkRGUpATUARsjnHSo2eXmuI7frmgHbhMSVYLERBWF1D/e0QnQDKx6o30Wwrkz0Pmv05PAYqYnAFn5JiV9B0TAFXCWlUIxtSx9B97Yv6X7CTSBPgtqk5cb74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=LB4TF74fj+g/7IGMGbaZ8UVaPv+EY991ThQckKhvD3F29hv9DH07ybqJBK60rtdI+PugxfSfzmOiU1wICpioQWJr3JT92kZNEomFmi7ow/YLxYmWFk5UKLaEdiLFChQxdCUxgKME8/xpACGciEcRSx6IK2K6uwTiKTeil9pQzetkW/6pJ1/7Y6ExPpDzc7pQ+jiNtHrL/WAo10LKLr306l5XN/SpSEPZdFRO5C819acxa+oqMiFk4fRsYaIcwIp51DpapGZZDnmKInVvekz1kwFymXS7ecRq6zugSuOzc3lnkdcjnlJ9euP9CktzarXIq2CT8DcjF6fc/g0uYK0nIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=FWMsgouKeBWck7MEPfSXJao7j+t1pd8lWf4UZ7S39Cy+wdk1oKqsew1eH2boKGbqp79jK0P6TKyqSQwHUPmujGsbqrj9ARNeskwi2lmu5fjVl4M2xr3RWIxQKdpF5OlRuZ3FXlRP3w0sFIe0fHUTIjeWuSGEoMCy4GHJil2KPi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB6835.eurprd04.prod.outlook.com (2603:10a6:208:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 12:24:35 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:24:35 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 5/6] btio: Add support for getsockopt(BT_ISO_BASE)
Date:   Wed, 12 Jul 2023 15:21:34 +0300
Message-Id: <20230712122135.7734-6-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712122135.7734-1-claudia.rosu@nxp.com>
References: <20230712122135.7734-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:208:14::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: b9487e86-9021-4954-befc-08db82d2f414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNEqcbNIlJ0KScN3RVOgkbdh0kD701/EGzZ92y0yppAx5prC8RZ+Pz+T0xAnv7EWrAqPB/ftNxSr475eIyXcDIcjQ8fqANs+g69wy7D8PxBYtJywR9VTaf5+j6w/TJCWnn28CF5pyViJaaCZFeLNbNwYw2JymEVxyfxGjBgMT3HBthNMxJrh4VApsRkyIORsng2DAw4YF9M6S7Qq/6bzyE8jsysGI+fOPl2c4dWtO+vAGbeJI/mzWEemLVLMLA581SDBBOvBV2xqKINkRqmCh13gOAYVKH64I9p3GtTvbIcOQBodVlAyeiQzVnHqJ9n76qa7Z3QpRZyQTSqfcp1eXZBHW5nhsbRdfOrntaddM8ofrnYMbKu21oJYv4IRn5i/dc6I+5RWOyg/KqyIUB4hg9Yzkc807vqWL/wd/ZVS1AD7FbQmgdJairXhVkmqXcurTjWfxDbGP9NeLw4QPj9InC0B/xPdjo+rP/XrRtmtyWuhd217MOrRcwbYFDqAg6VELY5oN5EUIx1gxfTvktMvAjnnczUKOIzuB1UtF0dxtmLLMmIjiIihXoj6n9LRIvuT+Lfo/A7KKT3Ck4XRQ8COzcDAMM97jLckQOOcprGaNbQMowx1rEgrTEsRY/P8/3cL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(38100700002)(38350700002)(41300700001)(2616005)(2906002)(316002)(5660300002)(66476007)(4326008)(6916009)(66556008)(66946007)(6486002)(52116002)(6512007)(83380400001)(478600001)(36756003)(1076003)(6506007)(55236004)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECNyWuw910q33A8ycJwrjc3PhQYwrEVd+JNP6ucB+aJnHVNjPk8PSu2y98O1?=
 =?us-ascii?Q?Fmi3Y62oQSpNfk7syryJQZHZsCoMy2OF/KUtx2ZQAUonSmYYTqk9uX80X+iz?=
 =?us-ascii?Q?LwTkTmI+CtBC9SLF+2r1CSkQpS/0M77lqayhrRVG1J6yfyN5r6/Lrz8NgLnH?=
 =?us-ascii?Q?GTXM66j35nR9yWGK72u+bLrZJ8i2hTcDz1cPtJ74xyB8LJ6k1oHDioPlYMA7?=
 =?us-ascii?Q?bZHXkWlpPtwk86b5TJiqRpCehs4cA11+InlAdQt3Phv8CO/bzOzDwIVPrPsE?=
 =?us-ascii?Q?SaB9sCSHHkD66ichJhzhD/Cuw28Lj3QddW1SwDsjxDhWIDO+wQssehbUDLAs?=
 =?us-ascii?Q?r5NudsggTMxjOzqTNgZjmEgoWYJJATak9ThtSnArpUR3EiBrDJVdaKcxnZNW?=
 =?us-ascii?Q?o0/1YjdcvOwMu1YjTa6Q2Ma/NIRFfzOVf2+BbhKc9aKcaS3khuDFQI9GDpJv?=
 =?us-ascii?Q?kyzeItOP3iDsXYOrHUBNYvrKU97/Wch+RAApZNp/F2RvIy60ORwWo5vNgT8L?=
 =?us-ascii?Q?YYhGxNWeLP/xRWfgnLxMYGkDgo2jen9DDWgzbFJjLRV8moF7HlzXmwNTlWzq?=
 =?us-ascii?Q?n7Th6PsjSM7xB1jSVok3kfXk2H2UF+/R8ix3dKHnhb/6682szAtb1PMwJRpj?=
 =?us-ascii?Q?p5WDUuvHb1sow8xi/XhAwgOMU8zIeLO4awJuiuthQS137o4fA6TGz+Tk0Lyi?=
 =?us-ascii?Q?nVAHDnUQh4ocsBdtpOfAwcBDbhfcvQ11BMfbyLK5vV/iLK3gxlmVlud8eUvB?=
 =?us-ascii?Q?YX+tm3DJjnBnhmd1cIsAM4yFDlo9J0nb9+w3dxFgfW98P7KrxpE9sWaktOKE?=
 =?us-ascii?Q?+/32+k0CEX2IQebCY2wez+YrSG851U4cAWDOlrlN8gRRIBC5FSB0bL6OASkI?=
 =?us-ascii?Q?pC0RZuBc5+7shuFDhl32BLvNmWpxjz/vVtodVaT3VdLd+iGbMaHVVwW/xQMJ?=
 =?us-ascii?Q?+Td3aPrYNlGenfVxGYryYZUz3pLi7R1k1z2Y7q9t8rTPNKz/URrtpGQMVNrn?=
 =?us-ascii?Q?C8qmeBGJXI3ZRDs6ERXKNUjVFHQyWYASkf2BPzr9UthVMSTF7makEZ5Si0IT?=
 =?us-ascii?Q?KNwoF4q9SFPAekJMSxQmMN17MUo5YIivtYC6ZgtbNwh7/kkhRvJ9IeOSdpXS?=
 =?us-ascii?Q?2iw7bYkt2wnqHC+RrmFtpYaXgUi7SjROabSbw4ndOrkdtPq+J/MoE6hvUfH8?=
 =?us-ascii?Q?WcIxCUQ/r9T6aPNYdVsq2cM4wPSteYMfwJTrYkp2pHMfzzpnmmy0ELcne8eZ?=
 =?us-ascii?Q?vZBVS0cI9Cd3QHnnOxS4tyg2NrWZNXh8Uxl3M/7BMtV7SugA0QUpLBy4wt5r?=
 =?us-ascii?Q?Jw4aCsohpbtn39ZWdqIPQHYs2sID2ETQouSE0DZQuLnj6xUCnAHJmHEPXUnr?=
 =?us-ascii?Q?fXLp6Ge9slKEN/G4Wg2JpyswObuNWsxUSeRRDM3UKmx3Mze/iFa02dWBwlFL?=
 =?us-ascii?Q?4btr1p62VtnpDsoeUh6nrSU9gIUBQ3zSMIDt1+OeOl7xsJFQEET94N1PO5+B?=
 =?us-ascii?Q?PLjIY0OcbVym0BBPBvSyI7n5lGX0RQuqCZYYe574IR8pn9Ed1q9gEHNI0NhN?=
 =?us-ascii?Q?aEfDdO7jhyY4naSws/zsSNuFYlLJFT48SXlcml+OCrMGbCSLWqJyp3bdbifz?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9487e86-9021-4954-befc-08db82d2f414
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:24:35.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4vsW8dufRCqtSaQMDZ97bGSHZg5Z03SEfh7scBsm0nkDnfM2cyBO2a6tQfBJ1N54YI21NwCccGMPGcl35GxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835
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

