Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A17CDB474
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJPPtN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjJPPtL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:49:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236DAB
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNbEvm40i8trzT0vkjfFU++/s/1j/Lbw5IDyqMS+QF0aY7EROmqd2l6JljhF/AdcYtZrhMsHrhpjBB1fnrFKzUy/6wGbki723iCsTQkipY5bjWY8+lE13lbtAaNuNAPcawvhozmzjSj3UiumHt93bYHsuXh0vJOlrG8ncNR0aupCxBHf2+h/1X63nhCwtGzfyA7fsOfcWcoXHcZDuVQDYsAQJyN2htspX/v1+xTXonfDKL/858sEtf4BRBUQWDX58650PKqj6gUp9uRdbpINzLpy0SRlBbEM9dUbM2P24vT2hiDALARsfuOXLFtPXjjwSAU3aTLqqs1zn3F7lDCFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGS69yGwOfg0Qsm8CLpeUQxjDhGNaIeIb76iH/MTu30=;
 b=N64zh1oW9mU580Fr9/H3IOy5XgevMqzozlS4BvYYvIH+6XEj0KiL6/3AeAn02R0RJWxFVj1rpYm/c5kmXFARa9TlgZnqOpNR9s9UMqFfW1i9AeSFBFVY6OFVPVyykZpnxj00qCpIwKYHW8cXnO7WX/WD2zonba99A7a83apIGjKMpDQmlwqnoORuQdO4HqysyM61C/Zm1UuTJE6vqaUTY0V8KniakTqAKMbHkbMPiu94Vkopt0K1SqVafq5YlgJxv9n/AsH/ZO7c17SbvSUvom6OwKqpvpBmEy7fkEsizo204tFtqpweE8EHC+jUIzMGGXWCMaXJKuvnmUlO6mtYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGS69yGwOfg0Qsm8CLpeUQxjDhGNaIeIb76iH/MTu30=;
 b=JkRlKEd1t0KxHpvm3tzVfF8MP6+FkwvUOmRYrUzHMZ6SNMCO9Y7ksV16ts8M+sniYpZg69ATIhwaXFBtvWJGQxffPaWfbg3UaTy9ik2zuXyj49HYKTrgQkzXdk10i7EZ3a+cXeAi3N6c40DCIXyiNcSkXruDk0ZMfXJt/nTsEPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:49:09 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:49:09 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/4] btio: Handle closed channel in server_cb
Date:   Mon, 16 Oct 2023 18:48:57 +0300
Message-Id: <20231016154900.3094-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
References: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0102.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::43) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: fda69e90-e83f-482a-81ba-08dbce5f6f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDOm8qREBJM87h7Aicp+n8fixMIKxqHW6fTRl4TDNzVlBV8RMmHD6P+6TBIr0hZj4bAvIFZHGNqFbQAECtb6jAm/CQFJIOHW8HsFHeYcWhFUSBCGG0lStTQJ7rRc3/zX//gBIzFublvdXmGvspdjs1SMQjOMGk1wcQYIKZQEODQvUfqofG7Xt4mXCy2drr/PYUXjF49FS3teUISk4P/b/ae9c1eQ/Gzz8e+m8NutNT9gyqBdlSeBehTHt3bh62DzkHoTeg2lhuk4aX/SA78xaoyv60BOPOVSOX7stg+GJbKwMGnqFgsnTSrtZoEE6w0cRJGVcO1auGjzzixJ9RdJjLyX5gJaRcKBY7QmXWbPYD50ShA4IDZ47jyLCmPUUGvof0cB9G+hNd6LoPQ9K2tOWA84xXMsUl7paHrmcvHZT65wElmbApG1oPfsVLLmM3NRgx63RnA2Db+oxAEHnM85uvrm85Y8RBoMzX7ysrTDY31dkNbMHq3zNQ6fAhZj/4GJz5inq2HpA2SpjzfnicwcvPh8jtmtoYgx9kklRxerHCPMpwxGowEAoNnUYEbhp/gx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(6916009)(316002)(66476007)(86362001)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(4744005)(41300700001)(6512007)(6666004)(6506007)(4326008)(2616005)(26005)(1076003)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsM/mJho3SYLzi5rX1CmMQXpPAtoM+iW91PQSv/7nxZKjcaupHp1HjCj3II3?=
 =?us-ascii?Q?tjQAZznPkNg7cfoH9j8b38BMLxWtiLvU8DBdvph3J7REz7I5IC7HUzB0EO2r?=
 =?us-ascii?Q?hWRlFa/XR/nxWYzMz3ZBIT/UJYOU/2CcajAzqS/iVastIz+CzhLmbDf+MpCr?=
 =?us-ascii?Q?7dMCZHGtYuKrh3w4qhyDCf/tmXUytTNYMubIZcUkNx/DsR/Uei8qw26+B/9t?=
 =?us-ascii?Q?jPar+CSVem7QHRiB5xQ6zKGYfEm8tr/NXZ5G2BNBUAsyknv9hGZpH4j8n8ia?=
 =?us-ascii?Q?hlbKJ/v41Bic+5CE7J8zxm/X63hHuCjiNiYiBsyKZprZCbtY0CUg0+TWqv59?=
 =?us-ascii?Q?Hys/9dfXXvWomH4rWW8PqgAfx19Rs/aWH1v9ADc/F3SurFJOg3DkAvAL9DCg?=
 =?us-ascii?Q?p68loSYC2+Vln/nUIRFl2myPv3WZ5UrmitZgaxKghs2h9biUEm+czl0hKkwo?=
 =?us-ascii?Q?Eb03BCte7qM7NmmfD03ab8o53ZUceTgLDhBMKF19jYt1LKch93Gl2Os71Vuq?=
 =?us-ascii?Q?1Y0lSKasai9pDaLjhfayprD9SwdEWkb3FHHfC3bXyXPBp9OiZeE4a7DmPkGf?=
 =?us-ascii?Q?COfJjRiovxJVqp4P9KEQ0E5mUrHd5YzDQbtml3Y2tBCQ49bOUiR46a52eGd4?=
 =?us-ascii?Q?EYLpL+K3gz0KlSHkTU/83WLH2ctEZk+nRTfOoCS6lsXyDBnrOUdiWcx045Li?=
 =?us-ascii?Q?wnFTNVVZSUJavacSvIW4dZBu6Lkgq9IWdlRnlXnWvOYx+ET74OrtYYpSNDCi?=
 =?us-ascii?Q?D7UiO6NQbuF9r+KwKFfWOwv5hTjKi3rScbuMS7yjURRTuVtRqiP3yZN5X9wV?=
 =?us-ascii?Q?GeazFx7q8qM9PsRpRoTy6q2qrzX9kPRr9+cwVtLhGsRijhRRMmTlMydY0Gi0?=
 =?us-ascii?Q?ZSEEjuUmmMU3xm0ArZ9rUQlLn4qeHuOohD4HYJ/dchbDbSjkIp/TpfjhYkr2?=
 =?us-ascii?Q?q+Y+02m3+dNfOd8klFBpuMSp7nCmiqiKyH/rUCFQB4K9pshqxqwa/6U1T3jT?=
 =?us-ascii?Q?M2LXh7Cqd74CEpkmJ3VaPDf611lln1h3Td/op2YujOH+vTIzTJ80+aBSWc/A?=
 =?us-ascii?Q?y0bLRWqm3WKdtsuqXockmB9h1KSbPwLJVM/RR36/fnDsLvlZ4rKVeeaD5+Ar?=
 =?us-ascii?Q?BuMjt1Brzn2fFZV3e1uzmkxSKAS23MV3OT59CAkILEtgoqVxakVRcH2K3CsB?=
 =?us-ascii?Q?Q6lkNpxQfoGHzmot48LLTuKd4Ct8enx2OKZ0PJJCGf8LNFU4ggoJni7hu2DC?=
 =?us-ascii?Q?wd4axol2LLTJVXVSSMPcNlpJyNUQBEPHAHrE+61muHwiWJkjVNAZZCDmQBW9?=
 =?us-ascii?Q?kiDfkXyxYfjf1lLtdspWug7UefTBz+XXhbF92s1JKIZYomFUS1MYzMQXU/p4?=
 =?us-ascii?Q?f0xu+Q1nn/PLfVvmKJoIrgoQyhUyIvv45LJlsSOYyzQHCgNXy7rn1UpOPoTG?=
 =?us-ascii?Q?ofQOxmfKfqdBnQ9GQD/srLGAvAQLa5P7J3v3g+3DJJ7/+nSBmGDRgXUMDyEV?=
 =?us-ascii?Q?4O9gZ0DCMzqx8GjLOEEWb6metl5HJuNgIz21qUYryMAymkhtNln4DjpsEujX?=
 =?us-ascii?Q?Ag6Tr+f7gVTmxV5q8VAj3hmCoRsqeXPtgZU06UKG7ohnFt9sWCijKsWmYM/h?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda69e90-e83f-482a-81ba-08dbce5f6f87
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:49:09.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8XYfzrP49EG4kSJptoO6KEbZETfC1BfjFH+exPpWJKQu3ZlWBG15qSoRXJX8zeukXe43rdyP2+jZVB2WWJE4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This handles G_IO_ERR and G_IO_HUP conditions in server_cb

---
 btio/btio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index d45b8240d..c63a6d1df 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -247,7 +247,8 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 	GIOChannel *cli_io;
 
 	/* If the user closed the server */
-	if ((cond & G_IO_NVAL) || check_nval(io))
+	if ((cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) ||
+			check_nval(io))
 		return FALSE;
 
 	srv_sock = g_io_channel_unix_get_fd(io);
-- 
2.39.2

