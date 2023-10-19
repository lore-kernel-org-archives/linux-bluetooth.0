Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86DBCDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 07:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjJSHRl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHRk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 03:17:40 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94929126
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 00:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtQfySq4azBb6zldux6ibGvNlyoIeH3OOkvMg/bIPVCTpWp4GmWowosWtQ3nHZuf16F0c61FJW8p3NnZBHQTOvM/pfQv403NKiFsiMyxkjOIz4qszJ10a6wck7rdr6FgGrtztv+dGZDD92h0ByREhA7uMtg2tv51PzreW+CCjF/hWrAbXMYGI/AmKegV/ygRTwtBxUoAYvb/RG5L7uiJvh1q4Tc7YC/4FDx5IzY5AMCNzAyXSS1+nnUcjSEMFyl8AAe5eXsOgFMQ9E2h0LguG/KsV0rTB0sTk0wylgRz9OW+3wyttZcnkJzxspNtVzkdvZSpWhfxc0JOCE8sN5zXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr4H23bCwKzftKW4lMJU+auTU2iLS3ESGa08OZBP01c=;
 b=PAOkqmZYE1OEMAV946RwqXsA+9zbAaRRMOAMEyQA4K8cfQ9DFr5pTKRlmwY6eLbBTcaGs5mMLmeKq0moeX9Tda9W72BW39xTSQqKijLxwrIqrie6hXWJNnixvvG9ng6+X23VlLnamyixrhlJGvb91uyFYJ4SgYn74AAsf8cx4arLzYIv0bE6WAfSrn0zMaO25f3w62cc8ZFPuxFpBTWZXpWEz/e4wWq10uGJ4OyCrQ/8weqcv83wtSTKayz5OogigqXtHvn4gekM2jyAUsp+ZUQn3m++8yh1DA+7hDIUsWjq+44DYPnVV99flZEF/fe+CMpl142ZWWoTAPFJOSWEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr4H23bCwKzftKW4lMJU+auTU2iLS3ESGa08OZBP01c=;
 b=VMM04w2qJ88enGH39JI8gidPmoJgiL2+urUbzV+52CF2X53HgZtIjg2Eyb/E8leXy5ZUIS313zTDRoLIxjgElW0CWgThXp+hPZSLJfTkvOM64oa4t+btUTi8xPn3mSB68WKj7Wj4j+JyxtxZoUyM3Ze9TNGbFO5TbjG1DS5+rM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 07:17:36 +0000
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28]) by PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 07:17:35 +0000
From:   Purendra-Singh <purendra.singh@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, nitin.jadhav@nxp.com,
        luiz.dentz@gmail.com, purendra.singh@nxp.com
Subject: [PATCH BlueZ v1 1/1] gobex/gobex.c : Changed default obex timeout
Date:   Thu, 19 Oct 2023 10:16:51 +0300
Message-Id: <20231019071651.4773-2-purendra.singh@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019071651.4773-1-purendra.singh@nxp.com>
References: <20231019071651.4773-1-purendra.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PA4PR04MB8016.eurprd04.prod.outlook.com
 (2603:10a6:102:cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB8016:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 43457885-7301-49ed-d460-08dbd073779b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaNstj6yg3a8UyKt8Y7DcDaF5X9oVMI/KuSpp+zHkndlnyGr5YCOhhf8KfCCSGx8UVnFgcFrsv7dQnOO87yLkcUGXgsSnaZQhv1pbw/zPSjS0AYmAeOdGzXooqM/Qb7kNRfAov/7sbn7pNcdNxFDG2VqdEfy7BSg2o4KNGc0zcYYYd2cp3rE2vKGiBb+EzPNuJcfcFFwe0JKn4R4Q1sVuSkHh7Fulc4IH5ObJsFUNQFdSNskyG8B9Pw3wAYexfwRyRNU4tKc4JUtQK567SI1dZLBqmN2Efg3o68UwRChF/Zcdu1tAbaMYIu2mSb1u3oK8eKwqp49nR1ImLFQKl/xesIUhzXOLdo7P6kny3sfOFgE91aBFuDT12I+cpFbNvvAg98+rMPbmi2hdhiaNzqbufdfCxrvMY//dGYDic8gWKQIQ4oSv88ycCX+Cgm//7FyDh/iwZG8ITp8pNZYGAd+YpSFFJA3S3q42HriWzLXWXpU44BFTifzgFDaqwi1DmQ3xyxM+7l6LgJsO1FWZ0IZr69IB0l0pgQnDnPwGTG8c634JLOjRtQ+fBON9DG9Q6ZEBFO8So9Coums9lBQHMxS758WZNw7k+tZjTkh2IQDRSAcTinCef9kCRyTq/qd3Ljm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB8016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(66556008)(66946007)(66476007)(6916009)(316002)(8936002)(6666004)(6486002)(478600001)(8676002)(86362001)(4326008)(5660300002)(4744005)(36756003)(2906002)(6506007)(38100700002)(2616005)(52116002)(55236004)(6512007)(83380400001)(1076003)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lq5v06sFEYSRkmS0RM4jjtKLZzOkTYajDNWPevSEp67VMz5WB/nY0F7qMmnT?=
 =?us-ascii?Q?fcdndQzPrxyAtJSAi2tG/Wmgj5m8Djh8k2BiwMH/CfDl6o6yggSmFV8QJuBh?=
 =?us-ascii?Q?QNDQzKc9SK6nuUvY5GyaqMFPXmOoeNhHyr29Pmwk2NO1y1s5LGu4pNiez2D4?=
 =?us-ascii?Q?d9tvK3gHGDrI/WvwKwn39J+lb7ch5cZyCy2wfmXTErUOAyqHxQ3McJGx5vU1?=
 =?us-ascii?Q?aw2+6AhH7HlzKCc81Kb/c3XErmPF9fRzzlUadPBRIMQ9+3nK1ZuKIszk/yGJ?=
 =?us-ascii?Q?PsrvOyp40pcvb4C+5QL/ehmELIJsHBi8/zQIAu1gkkvoc/Y68/HK606DnPVY?=
 =?us-ascii?Q?c0pxoLHfLxyOUbOAWvMwOzWZbXG9riI9aq0BOdrh9kKk6N51BXDehQmm4dg7?=
 =?us-ascii?Q?mUNt/kBWjmPmpqZmN51VEbnbVFOseOsHzosEtIZTaYRF3zmf5zCQYbaIBIcQ?=
 =?us-ascii?Q?QaeIST7dt6dN6IWxben/Uz4n13f153yLPfwG5yVWtFI62EyoFMqywG/lPaLR?=
 =?us-ascii?Q?3av6XYiwD+mdnsRzONiybPG3xKXdjQLskCyqPTGauMW2iWUZpM3bAfele8rw?=
 =?us-ascii?Q?+OF5w1elWJfHHe/He648VTTYdOhlwUU+IczAiZ81BNQnAIC90W468wP6BSYX?=
 =?us-ascii?Q?6LO3HwG+7vhSmYmmM+wOZZGjVS6KLR0Z+vQ/rS/GW7NsCoICfHmimk63dhDb?=
 =?us-ascii?Q?JzfUvohvMlNnj0Bdx7aZCauBhQ41XFt19Hvu5wxzStcQbiyWIP3Ntilj99EF?=
 =?us-ascii?Q?JMmGixbvn7908tdNJ09ZRCB64uZc1hF9o5ul4/1FWg46BIVjPmVAG8RoCL6L?=
 =?us-ascii?Q?GNyGvq7YdZYY3qePlNcxWKVwGnWkKQvlzrS8lXQUfOj/jkhPQKfrKWVV0M3E?=
 =?us-ascii?Q?j3jbiOsjQw1tyD7lWb0d1qF5SROnQ6TU0jyeyB/L38b6ufWkhxRNXexqJQfm?=
 =?us-ascii?Q?klFHtZWZUoHRJkamvG8AcGI+pjjDKvY4ueOjgmRTpWAsn8GYalQqcJz3rHcu?=
 =?us-ascii?Q?eZt//CWSf1rqm58f5mHfsRbV2jc4EUEkfFvecJgycTQW88uqwzV42dmZiXFZ?=
 =?us-ascii?Q?LssXxoJdgByQfxfBuI52n4W8u9PQ0JaVmMY8T1io1Y0a6XE4UktjeOZRlIs/?=
 =?us-ascii?Q?Snmx/sgG8z8CU1kvyIEPa2i1R/fZpAHg5LbnmMn+KsOtHvQsK7nCKSziDxrY?=
 =?us-ascii?Q?YPvHnY00KIsnyJrG4ncP3TT6phHNRN2ftmAoD/SMGUpDSTb+uxj8shJGUoys?=
 =?us-ascii?Q?Yz7MPbfYWCwNaHiZUFy2zASPqhH0fqmdq+tzr4Ro8CiIGvmX18C/OtMD5PZp?=
 =?us-ascii?Q?Z57MPdO8ohZA7rN8LqFyBAG1rifTPrTIyKdB0Z87muxDv4mT0NcZHUuUzPXI?=
 =?us-ascii?Q?GOo4MomVdJu+vCjXNyQ52Z7h0cm/5l+65uJWJql00CDgLH5N/ZQsJfHqXvVN?=
 =?us-ascii?Q?LZ62Z86hSdG2h7X0pxTGF3Len1ZNXfhL3Zh3YJmedTNWjbw65WM+mxVdy+M6?=
 =?us-ascii?Q?8ZojCCe2D9Cdg/O/sYrSyCO9mJny0K2WMplYc7DOEffMUCbo5r17w72rhn9W?=
 =?us-ascii?Q?x6HipgEYqhOoMmdM57tIKILTu6cgE3X4tUEFWMpW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43457885-7301-49ed-d460-08dbd073779b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB8016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:17:35.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXHxhyXYYmFfMsXY4cM/tvio7lBXhG+YaiKHD2LJPlPJWTwtg/UqyNfYKS8X2ZE404yfWVYMu30w+09feYKOuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Description: File received status of some reference devices
is delayed, that causes timeout and file transfer status error.
---
 gobex/gobex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index e9b89cead..f0e1c2c83 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -22,7 +22,7 @@
 #define G_OBEX_MINIMUM_MTU	255
 #define G_OBEX_MAXIMUM_MTU	65535
 
-#define G_OBEX_DEFAULT_TIMEOUT	10
+#define G_OBEX_DEFAULT_TIMEOUT	500
 #define G_OBEX_ABORT_TIMEOUT	5
 
 #define G_OBEX_OP_NONE		0xff
-- 
2.34.1

