Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A2C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 12:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjEJMJM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjEJMJK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 08:09:10 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA217D93
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 05:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfv5Ou66x3npmrThOGlfmAIfdDndwbWG0C0dIqoM6Wj+h9n5lwBw/BVQ/1rff5sO0X0ixfbmGI7jF7WkrUCGSP3go6GFThsHj6/l/otBASr1nrljb9b/dGamlh7edN9Mt+JUqKeHVxdDqDrhyR1iDuYwH3daNRem2IlyPRsnG5RpqLsnrXRwkQZgWUd3zyCzroaIoFv0yFFhsEiM6ZcBuXBkNqkhu389Criufo0CuZMURFQrJoV2+wMX0J/U+cG3W2yB6QnaK3HTAcBJuivrGKjJ/5b4gwI1aUMhX3subcRl6/ze4pzkxH3Oc1Vg9WshqgUinmmriesE0HKKA0OuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXadlo5qA89YL3uZ+7nwJQVkslnw6esNPlA10q+I+Bg=;
 b=L6NRzcHp5JOiwRMAG950ihLrOhtb/+zIY/dBD5xRiSoQfeDrCS+IV0ojLP+E6U7b66uRp2onmVeQDSxwMKBlrQMi30zClfjkYIJQhb9I2bwc3xfcIoTHWepTgqPIp8LZL3SGkQYPHceS6EhIE8nD2KGd65yAxkw3iZix2zyya5zy5/RV2ctZjW5RRGgiXYVh7Q/Yr4bfi+rMZxEft5TXnrJMiPD+z7B1aKNTE8SSQnkxi8kv7joJN460SsM/6fIyrhI9996tKbqHUgKXBb5KusGbbwCi8W9gK4vqHCv1j17HG7G9F0UU6jKfJPippIw6q2byMb2s+UI6HEO7VRHLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXadlo5qA89YL3uZ+7nwJQVkslnw6esNPlA10q+I+Bg=;
 b=jI20ej11mc9sPkC1lOH/k5ZeXhzFNmaBFv1+H+luo0WgEfbcyIzFGwkCKwKzpwcAlvkSDp/E1MHWVybzr6DL5C58llM2Ft79X5o+sF5rZQx+vN53Vrwoc2R00JHh8wj6c/iu+FPUm49sFZHdoeHAwJ9BGZahSIWGyItmpt56UNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 12:09:06 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a%7]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 12:09:06 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 0/1] Check for ISO support in controller
Date:   Wed, 10 May 2023 15:08:42 +0300
Message-Id: <20230510120843.10336-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0025.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::38) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 307d26d0-2af0-4da1-b688-08db514f5a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHSuvRF0W1/JebhWwntXh7BvpwagK7i5jmcWqkTPonxinbOWz9MOevXSAheiDXGG3184W1+0CdkUHgmg80YFw2i3tNn95H0JWMiao4X7EVFBmoowWEokTeYQ9SwYSQfPZwDA8h7bGM4fNqzzS6suEsc4p1ChWREyDqPmVHMsH+CBYM+1vtOH9soGFGi/5jQUtajw/Rvhb2/VezSJlWfMp2krN1zevQjdKc5QfcuN0GW6ZLo3mu+pm8iWfgyXSrIHjLcrKNG8/4zuTu/wehaS+4YwtUT4b0LX56jBbkYupama9lD3e34qaTusdesSR7XNkPiIJ+2+Z8dcKU/sKyH5v5ucCjkukVUtk04Ef1PxMfbEBGIpk0AM3kssCMRzL8spY9vZkL+2uW8saFeM4c38yH1L1Kziaw4Q4jdudP/VsluXnhYO6IZwbeozbOubyPwaE/MMx8kVQsplH8xCCCg5T8yvQ5Gp7r/ol289xak4CPdesEu1YYmym6oqo9P5ckFlIsktCOCBeJ2vZGA8aHX/GQeF/ZcWfXaSAqJR8ElhqwgEQw/uYITV0PjPaFe6ZlohcpdXJiMWSSe8hJF7ABLxX49m+Vvbla6kBdJ8QnHNt7APRJbUsqQgEKbSfjrvLm1G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(6486002)(52116002)(6666004)(38350700002)(38100700002)(6916009)(66946007)(2616005)(66556008)(66476007)(4326008)(316002)(41300700001)(86362001)(8676002)(186003)(8936002)(6506007)(478600001)(5660300002)(26005)(6512007)(1076003)(4744005)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJH/we1MjkhCBIDGRri+Ere8LILQxMoc1/hzYuGWLxBX4lyCX+92kn1ZXG3B?=
 =?us-ascii?Q?JXEZ1N+D6pCO397DjUaigWzzu4yd48JILDYtEeXMr14GaNH8eY3WBHsDDscV?=
 =?us-ascii?Q?Hpes7dK5uN/VwrZhzJavOj1E3labruhR+Ea+mzWBtCIQRwhCgJyDlELNYPor?=
 =?us-ascii?Q?nj6hawQ+8EM/cXDgpR+yRIVZOJeOn0gQaoUguVYXX+1OOBlPItmhjO0O3Jv5?=
 =?us-ascii?Q?lW5qiKC9MxbH/HJPNWziYAI/vQ/xdT3DGF7hN0B5XUALeepG8kMOgnVJiv6l?=
 =?us-ascii?Q?kZgrlBBssd5V57JEb1dvWkh5eNGCm/7+HN+B7gP+NtGqEXn58c9p3QFux07n?=
 =?us-ascii?Q?Qfq0ID0tetQalIa8tz/E6pURmqMOAnM/+2OUkWxnMJb7KECpy6StOysdEMey?=
 =?us-ascii?Q?KY876soBJErIrGz33vEKdYWAGQMVYt3/ixv7VWXoOQnQG7GuZFzeMDAqvYbv?=
 =?us-ascii?Q?dMS8qyAWHN/9mB15lGYwegrOvtaIsI4EKix6nkXVfKHvkPE0xapw8BZ4/zu8?=
 =?us-ascii?Q?OLlsUMIuD96yRcM0sQKvg51KbT1peppECULmRDviY+PbqCr2LFTb0Dpq4WTt?=
 =?us-ascii?Q?f2KinqaAregXPxOrbKh28MlsIs1zZPrURQaTd/hGci6vkI6X9mmKmhwSHP7B?=
 =?us-ascii?Q?Tor9Op0bJ4r6e3355u4VNVykeQa3eG7B9oAf4CU9y0ft1snclK1Xxg1DCiPl?=
 =?us-ascii?Q?vzLgFzC/QSZaaLGyIlSmoH3v3TexItmuN8p4KLA40QMi7SXl7oI8FtlfJ+2u?=
 =?us-ascii?Q?LyFQA89SIMeTbVdyTnwvd3OLhQMnLjznlPPS0Buc//WZoljx9f+4i8s4AwbH?=
 =?us-ascii?Q?aCEz0vtR/2k8ecDQe2zXOIX9T2VzHfOJ8zlMekeP1KBOnrUNygIFHHRRSadg?=
 =?us-ascii?Q?dTwWEIs/BWLIZFZbhJl2IzYv7AvAh1Duvp56zdRx1/Ixpu+sEvQ+ApqSe4s5?=
 =?us-ascii?Q?pg2k/GMlyI/Ns5d4y3+m4y0dced/LoZVjSXrnjAyvQ5tNeovcP0c6eU+pEcn?=
 =?us-ascii?Q?k8A1GYf0gSSgoMEF6YjsT4iL2SIqY0USMJUHhOjEPuEleHoBLN+NxJRjYymg?=
 =?us-ascii?Q?iQMoI1kgFe6LEooI5hpv8aYbFCiLoHcSf6G0XbhWPmvD/+TNELWmbjqhRksu?=
 =?us-ascii?Q?EsntfBLwr56gAeHc8xywQ3AQ1Eclwo4baFETWS6TgOivD2S2ULVH2XNdU+kx?=
 =?us-ascii?Q?O54kVU6Yt4+FjtNCgnlza66rb06wV2NMTECfDVEhVIOwxFp7NWpZFFgu+U65?=
 =?us-ascii?Q?9PS3qPA9FdtD/tQ4DEHu5JF7ubGnzE2WG75q9WKEFQuMMNzc5KS6+KWCRJMx?=
 =?us-ascii?Q?9v8dUeHfyJ8XJWIiZW7UPFZHnBpk2IRRk6T70zDlXFY9aHrWVnvxO6jRTiPe?=
 =?us-ascii?Q?jcS/Gy4QNBzJ5Bd5zMIA+pajk6ymdfkSbW4TERaHGyTtR7tbT0mg4mCE5UMA?=
 =?us-ascii?Q?sRvB88Qw/dFjdhUvHE1xxS6cjQ8qMRcWjbaj+TfGnRRO+uf0xSNSZvoiPolB?=
 =?us-ascii?Q?TZwus4x6+6Afiea7PsgQx8nlyFHPgKV8TsjiK91S74Gczrs3nXfYcQFAjN2o?=
 =?us-ascii?Q?Hn9HU0aDJzvwZ0Iit2qjI5zoYIx5PklA6bxwEiv+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307d26d0-2af0-4da1-b688-08db514f5a30
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 12:09:06.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjS4h3MiSdkW6pnHscqJIHeNXUkTm3Kaiq2MvEt/Wt9lDnwQHcHrvMS5n2hSnzqPJvPATahBaBENmA5BZmkxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch checks for ISO_BROADCASTER and ISO_SYNC_RECEIVER in controller.
Claudia Draghicescu (1):
  Check for ISO_BROADCASTER and ISO_SYNC_RECEIVER bits in adapter's
    supported features

 include/net/bluetooth/hci.h      | 1 +
 include/net/bluetooth/hci_core.h | 1 +
 include/net/bluetooth/mgmt.h     | 2 ++
 net/bluetooth/mgmt.c             | 6 ++++++
 4 files changed, 10 insertions(+)

-- 
2.34.1

