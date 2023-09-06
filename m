Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28160EB8FD2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 14:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjIFOAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbjIFOAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 10:00:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9557710C6
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 07:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqDKxwZDN5Fz+DKVp34YuvPFmjM6EqBFPjq9lOrmEv4Z/vMCT85k9kf/F5RyKGD0z9RQgY7hE5zQZ375KjM5qXLz9c1wQkkyuWY3yCMfIdOL0jNH5ntvO0d95CahJL4LZVxvvyW7/AHoK2D7HRdS0GFNbjKwAv9N1pXoyLAufR1dLQ+OHgJxOR+pAsxox+WsZR9Vz8lpBBtK3kpYyABwSENQ5gdfQD/YScpUE5k1xrdwf5aBxYV0itt8T4GtsMghJdV01QFWRcSKV3UAC7hTachqiJ5Z5/niRDYWb0OlYkuTB/WjA4wrkIJtPZMpianpNuaJVV/uI0U42y4wE3Etmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjRqTk1S0yT5PNsScdtfr1hLHpH+vkF17gn1aLAzb9w=;
 b=E3a4HT42JfWzDC5Q6SVVNYjxJHmoLxckSb3FodpMI0XRLA0P4dFO/mgJmoKcfrN6srFrPI0S4C/oRwpvZHwEIvmHw9TVpa+3ITeZroY0KWUuUkV2RIovYqtDxySeAmJ7WWZEHm3r/vjfFLGGWwBy62vT+mGDKFOb7U9XjB+J8CjbLtcMVznFQcgCQCEv+0J5fzU1/HoqDf6nTkTk0BfWOOnaVGza3V5gBsIFUksBU2uzzbuxiqJRpK03mHMx2ZF0kFfAGdIEtHwrmaigGGWM2x1qdl62Cip36twfRUsOrqmuGnhHxmSbgGDBmAmFZwfQVfMFsXHmWd4UrkGs3WumHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjRqTk1S0yT5PNsScdtfr1hLHpH+vkF17gn1aLAzb9w=;
 b=N95EcXDTW2YZK50wa4yGooKktQO8bCeMfpLL6LH4KyXfe4CCXHcAYT1aPN6tQI33m8nyvkl7CBiCzCjQGI71pfqmOPSyFBx7Pk8ZcnHOkLiC2Sl0FanoUkblajv2tMaU4IGXVmZBbZ34Qr77q5nyPzzSGsHAgTvoE9VucQ+2hZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8788.eurprd04.prod.outlook.com (2603:10a6:20b:42f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:00:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:00:15 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Fix BIS cleanup
Date:   Wed,  6 Sep 2023 16:59:53 +0300
Message-Id: <20230906135954.9165-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: da457815-2724-4d2d-770a-08dbaee19841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIYq2osCHP6er+ukQSPOVJtFppFeaySYmWHreiH/w1np7RTpe8WRgrpAStsLVeKcDtXuzRainz3CnNcSozfbHzqBOZheDsz0d3lqVgMSD/DEYfvQZ80s09VUf23H2+GwXGvj/3cJLT/FfJmo6V9+UkxogCByWFoUVI/5c7ORQgbUYhZzNfLPkF9k0m1oenPBfvCO+Zu1UNAhFWkeLIJMR+acmdGh/pFhPs2rpIH/GwHL7nhshcAzS4Wc9m/IGNW+D8WvQqrhOwSaEG//RixpenRRITM0KdEPgBCmRAYvpzZDc5hQ1rI4DOy3SYrfFfkex+Te9ZAC7RKtOJ3Hjrz/uZWGLiTC6jvkfqnWRCMS46GivCCjk04E+x9wY4x5oKoLP53WFoNR2OxdiqLM2Zm31xMFZ58KkP4DXzt/ckqXueZgEF2O8OvcrTjCywk2apnfJ3pIoMStrnr6I7CnnXbgFE6cDjvZ5GFMa0JwxlATN+hDVMp7cR73R4TtRK9cyz+4vSdcL8LFSfbd1iyyk4HFnrKOpHceliGo7zlyXTcXyXxTLgmNOuAPiIwllwgYTJBse4d3clNc5ViSqGW8sFAg52/KqCt3l9wAzBD0agoaHSv1Wn4b95F18jIKBZViGIbW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199024)(1800799009)(186009)(38350700002)(36756003)(38100700002)(86362001)(6666004)(26005)(478600001)(1076003)(5660300002)(52116002)(44832011)(6486002)(6506007)(55236004)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(8676002)(8936002)(6512007)(4326008)(2906002)(4744005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5mLBHnXMtkn8WINva4fhl4jjkCPdU73mhYv3PS1HK1eb41w/fmzlHWZkSZ0j?=
 =?us-ascii?Q?zXhQs5UrghKFGvP7qkaWQD12DSRsdwQJzNM3Lzr34zmB7BhBEKiu+XhVIvjc?=
 =?us-ascii?Q?+kS2gZl0YDPmGHemhi0Nq1IfhyTMiOrMCs4BaVcaMBF7oZoNiuuRvbxSrra0?=
 =?us-ascii?Q?k4e9vQVWe94jiFtuPG30BJN8Udx3S/+ZAMUH4Q735DKZezcudAggHRkAH8wM?=
 =?us-ascii?Q?IVaRzCM4mYWN4ih3SHOO+p2y9MG6s4PKSfDJkzRty1eLu5cTOTtydnLCidrf?=
 =?us-ascii?Q?9AKbNLzrhKZOp24tUtxTLkgBlkz7/wPN2ulhFqtCpOLnd64RbdbvIhS2Pe7d?=
 =?us-ascii?Q?SI/G0TjBdLIy5k7DHh3/rbjb4DfYNI0Lpu1K7H9K+6bNftZ4ovVuBE865T+T?=
 =?us-ascii?Q?DxnHF9fyqIUZiEidlMrq/zP3h3rQGeP1n9cUM1SKyeVkmrgupZFiR+/YPGi8?=
 =?us-ascii?Q?LEc87+DceZKXpErybkpZlHTNF9ms9UW7UZzdPl6859NBDkyZa2LzdWXkU70f?=
 =?us-ascii?Q?KqO0BP5vzyH4lSJrfkVKepl2LA1h+SLwCxNtAPbKeefes6Jro35Ji+lI+DuV?=
 =?us-ascii?Q?jftgfD8HrGvkg4mbjbsLi/JCybcQ+ovm83JY102eyz+YoQV4otGFcgCBGkI+?=
 =?us-ascii?Q?tb8fdG78QWZenvX92WMeO3mau/vTFD0KsOSMoY8yxqS2PJIbw9XBqemBFSYF?=
 =?us-ascii?Q?dhmdaIm+eAaIGbtWChaOLTZrWvfr5tMLAd9bzdfaL3jtMavDjCt3O4J0yAF4?=
 =?us-ascii?Q?4f57Dp4wb3qP43/yyYMH44oT8y2nQYqTb1goCh61D9+zvHbYDA6IhXz7moFe?=
 =?us-ascii?Q?LS/S6VwYFLhKm6CZqwYRB17QG2ZJihd/tw/+HjCTioEo60qTDgFY4oriKgpA?=
 =?us-ascii?Q?j6+xQJdl+smDFak+pJ9PTvKVCDxC/5FMyBprjJp0fyrGE/jZZ0BUu/4wIaOR?=
 =?us-ascii?Q?DrLKCP9D2j1Og+Xs6JRrusqPvfYfZ8bI65UweGiQsJx8ZLFKZEw0mRvPdWIO?=
 =?us-ascii?Q?qO9kuFDAmUb2ZysbAmHiQzpZL9BuUwXve19kZgqd/sjAi7sMY8GSxCuPgMKn?=
 =?us-ascii?Q?39XXJAIfgZpg+9GpL7nih1uDpBuN9BOAf2OwBpvqVpCqk+efcRHSPWRSkoXa?=
 =?us-ascii?Q?adhLvIDXjkzECDOWXaLTEQHopfbOecdIEpTyXaTXnAs+gJolkaWYq1UFlTJJ?=
 =?us-ascii?Q?EsrkRbnNXTNFNUuK0Q8Q87V3m/6LtWZe5aJzGjKbL0IKw9uiGrgYeJaXR1CL?=
 =?us-ascii?Q?vTr5BxWZOz7husGwaRKLjowZ1FaHxWBqiMA1LW1Z/w/7ydpXt0t++aRdtTza?=
 =?us-ascii?Q?dOp1NH/LBHeLTiDdO/40rkva/kj6XR81iTojQ8Fx0ki3PDNaIFas70CT2VkR?=
 =?us-ascii?Q?7a5pyt801Hcd5BSMiiAUi2jHd+Nwx7giDiHkumoOuav1xlX4xVzf27XqtSc2?=
 =?us-ascii?Q?Q82Ya/2xxr4T2Ljcx/xxXd9j24cWYNqyQs02+NvSCoMELxjuwO13s54KAnAx?=
 =?us-ascii?Q?yv+g02EVdAQlqzhQvssNeLY9KYA7zsRqC0JCqNatfEVbSJAE1iaw0wB+e0lj?=
 =?us-ascii?Q?UBTweQb0E6ltFwNhw56xpV1l257aK7qKliLmw0UWPno/TarMlur3ud8JRqru?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da457815-2724-4d2d-770a-08dbaee19841
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:00:14.9899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvfjuUNacjiTIJ5GiVSLc1z2/8e0wOHQd3yrXrtDB5F7Px1mXiBorBGMdElOBvfUJe9tWNRUAEwLSbuHQCZmJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8788
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the master BIS cleanup procedure - as opposed to CIS cleanup,
no HCI disconnect command should be issued. A master BIS should only be
terminated by disabling periodic and extended advertising, and terminating
the BIG.

In case of a Broadcast Receiver, all BIS and PA sync connections can be
cleaned up by calling hci_conn_failed, since it contains all function
calls that are necessary for successful cleanup.

Iulia Tanasescu (1):
  Bluetooth: ISO: Fix BIS cleanup

 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_conn.c         |  7 +++++++
 net/bluetooth/hci_sync.c         | 28 ++++++++++++----------------
 3 files changed, 21 insertions(+), 16 deletions(-)


base-commit: 2595dd981e7478108540095a81495c473ef47750
-- 
2.34.1

