Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCDAC00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 11:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjJXLEn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjJXLEm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 07:04:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9841B109
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 04:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd/VzsutSPYsPXYEM2C7ED8zfu7x0qm9XB61ZMHDEOg4nFXoBx3/qwvVbu32+z3B073pPEhsH4xxmQ22rRNcD4d+fweXgTnFIgW1nSyJgPibX2ZnMUzfaPfaa+hm/meWifTMKtsD1tTUshbA6SP32gKAm1NDr4Y02YI842xIs2GfqUNkx1FXtouooCu85CF8InLn5a92YVLEzOA9hKQnTyLa4xROIXwfdHzhusUDtqe3un7/6/uWQZdIFRsY+iER+JcbWWEz/1n1jND+bBidJZi0XnNfBwxaJHWf3GLYW4EkT2ImQF1FZLMzsGtaL3qShRPu2hLdzvXakBRIkjHRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrD6V+iBUNIidA/paz6lPQuDrvOlE+aK3nG1qnu4FSE=;
 b=RqkAMh793P0Ah2Jn1BtzXsAoyXQOpadPJgehGE3h9wbDA/UqlsDzDzlwLTmg049x7b8HemLZw6Kf88mBxMoq4RqdirQdXd/HeBqvUelcz3ll8mGw3mOSUWeLchSIwAP1JGfpLApen89O7afGMxJ4cUuHfYUkFywTuPg3ZokKdnDiR4thsB2m1QxH7O+D/pWOeSfnf0c67jZhz+dV81XgIIBupbRiEHo2T/pohjlNXF1mjCmvhUGSx9BJmRQ9cqK4dC9UDnmkR/Ut2WNV7lClHG6SEDwy/TAwdhDEuQPuFqF+OrW2C0iCVwGkqU68BdC0ap8kXnTSLmik1PJHbHGuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrD6V+iBUNIidA/paz6lPQuDrvOlE+aK3nG1qnu4FSE=;
 b=nDH0OCKMDbeBpRqDW9N989vNb6TASwaDFUmYWcw7pUpM6EdyijDQBc5JJSzadOIAU+76URVvsE6NLTb+SrjQ6i80CdNRs+fEk07Irxy9XnG/Hm4+pHRKMIzoeWG4rHAYJNBzPVAk+GbaNsh1qDKyfuTGobCv5Wx+KCF4LgOS42k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 11:04:37 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 11:04:37 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] btio: Allow binding a bcast listener before accept
Date:   Tue, 24 Oct 2023 14:04:29 +0300
Message-Id: <20231024110430.3323-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0063.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: c04fddf8-867a-4beb-12c1-08dbd4810346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usPGGEIBD6AkT5h+0q93TqYW1p1YUbMwT2d8WR5q6pQtDmtKwwIJAkD0/Mb9O5ttC8PWwTdYGMEjKuONVMQZz60rctVAv4oOkl8z3Gx9mqS9Vvh+jImQelm03ThYPUJ690rl91ao6ND2ZjlZVUIFn/92hglPbGyJKoHFYZhPLoeU+cXFR7CoptmlA2DpRP5bhD/2eUj8QS1ycPafEtz7QRrkQE3rUbVV01PV/8Atzd4Miha77DAF+KSVcOSM4L0cy+ht3NMIoAWNyLdJ/B5DxmxD2rvFzflO0hR+/RFFwjSLx2zbiG8VcBXF6/QJJ7qXig1hbvXHKXp95aGvTUh2ila41DCqi93Zbimol1kEJd5aCZC5+WzfpD5X30Uq38vU9cuJGu/X6nG/KhqgB6XMJYJzmkFcTZbwJ0P3R3YRqOtFScYiPAUP953ig6k7ztc0fCcFMIy4DdUzkxZc7YYp+y+cjzck8lAGSrVBNOVz1CKc49WpOD8o8iQ4Vje+RPDHalkKmUWYcA0u521Bxh1b+N9nZxGGw+9P+j7TM30aOkYNC7sHzRDDxMUKinO0rFz1xyliPebua3NoG3Y4DTXlNCqbr7fMb3eVa5jnPwEiN3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(316002)(6916009)(66946007)(66556008)(66476007)(86362001)(38100700002)(2013699003)(26005)(83380400001)(8936002)(2616005)(1076003)(6512007)(6666004)(8676002)(6506007)(6486002)(4744005)(2906002)(478600001)(44832011)(5660300002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZuMN77bd5IwB2pgq4hwOylJTwqcEIuufHsHtPcCzuqu5nH61/DGIQwy3D75r?=
 =?us-ascii?Q?r/lcPlXHwiaAIXoHcQOMfvb7hlx3+rEpx40At0DQsf//973Wp24OyQbWAxy1?=
 =?us-ascii?Q?HI2UsHxTc0BywaXjJzPhZNN/Hx20atru0yOR8zWDd942cRClb7ItuMh9ADmT?=
 =?us-ascii?Q?drqKLxmGr65Ajn3zMI/wBelWXC+cKcTIybZX3lGv6h/f8HjdBORUGlfQyEDG?=
 =?us-ascii?Q?03o8PEj+wuDO94Rwkz9q+wVGbL4/qCc0/YoOhs+LXQcMqC9vZ1he8zljT7Aj?=
 =?us-ascii?Q?EFUqFRJm9V9oaStkBNR9/4AgnhQy+vSN1jcMN3cmksgVjvsarsUlLCdhsMRH?=
 =?us-ascii?Q?kzG9tlU+EvnZQMklKN69Wkjtd+aDG3KDrzjVoRiYOZM6AhyS4P18rP4THpcG?=
 =?us-ascii?Q?OHo0wzCt5LjiMZlZTkmyVK0mm2Rz4Wkfs1e4zlb4js49iQFdZnkLOEK6w+CU?=
 =?us-ascii?Q?oU9OgbWTgvhcCwaIGuSZ/GaSejpCqrBKqiLLDpAh1GpjdNC5d1Dm/SDMxQOO?=
 =?us-ascii?Q?u7r9ov32zCuDNFm3HE4qxJueQqPvAATJ4WkKFIAHJW6ZuNktQ9Kzs7lLQWHT?=
 =?us-ascii?Q?+9hXTQZXRGrp/cVB5zWYmKKeHcaUf/9827L6ZxAgOErBEGQJuCyiaZqOlflC?=
 =?us-ascii?Q?q7l3l0rY4cC0GeLSvwFmespdZ3DrX1pljT/t1l9p6fZrhIPm+wTBhkvlkPYg?=
 =?us-ascii?Q?mMX6quWm8OYT9ypBZx0o72eLdaSCPUp22pLZhryOtvESt5q3BEgpUQy8IW2N?=
 =?us-ascii?Q?KlUoG3FY1EPysl/lIHzIwcrmiiN9IAYHmKj2sSK4/0c1rIECwR5f596cDreK?=
 =?us-ascii?Q?kTJOjw6mno8vnuG2wrG2F4V+uLMU4VAX72SuL1QJqcjqaF06LsQtTp1/bQKK?=
 =?us-ascii?Q?OtKZvlSrjAE+N9vGL19nMRZhdnJaTZ25ReuA0YKFX4Bm2YUDrqR/Vgfy2goS?=
 =?us-ascii?Q?mPgGvayuxpq+o1JizS9IRs0tSWVjhenbXZ45Qkp35WS+ywuigAb9E0Oj98Wl?=
 =?us-ascii?Q?F5LUTGh1Pdql1r7Njx53JWzCWChpDP9cBbJrJGP8lhcA4ep0X4c/xdW2eSJR?=
 =?us-ascii?Q?IH6FL3jUgIDk/byWZqNjoy8Hns4GiCunrG7qciDepTsNpCitYwV6qYlg8Dgs?=
 =?us-ascii?Q?27mlJLC9Ocjgz9zxWkcZlIqKdyl0NpUBvZcU6heMP+Z3MIJn2k0ybB+x4cAH?=
 =?us-ascii?Q?ySvp9Cj3M49dp1e4+xMexXLexQ74op16qoPMSKrbwFtbsKcqjmSCtKTMBbxv?=
 =?us-ascii?Q?F9kp5I9mB6rcYCRFyTLNnur0GrbRG0dQVWIoUNyipZakLXD7HVNsJqGYrIIm?=
 =?us-ascii?Q?bHL8saEmRX2NKtjcFwxUCq5JDk4LLAVB+TeUvaLQsOMcDXROQPb0zkoLy9OQ?=
 =?us-ascii?Q?NVQrbUNOlAFstFwBf7BVow18jtR2LSUVEZG66eOmOSq1eLnHqdqa3tn1x3bO?=
 =?us-ascii?Q?Xpfulgxv+p84RIna+zhTj9ha3hUYB9ZCQpxon9JV/O8rFNRGORv5xGMKGtSr?=
 =?us-ascii?Q?YN95b+rgRoX8oDJvhTCPucI9SCJazFBD4bDyXz6Ltc+iMwL+9duK+I34q/Gp?=
 =?us-ascii?Q?3rKD3lnAf65TkclUkrkuuLpz28Oh03OJniLN0FP8sIAfgkC2lo343sclk8dx?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04fddf8-867a-4beb-12c1-08dbd4810346
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:04:37.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcycK99wF1WLzfhKpIuFVCuUb3sdbKIafMcfBvfh1qCa5nuNri24puAr5Jl87i25EoejweUH3Ikez05o409BTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds btio support for binding a PA sync io to a number of
BISes, before proceeding with BIG Create Sync.

This depends on the kernel update introduced by
[PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket.

This patch version fixes scan-build warning.

Iulia Tanasescu (1):
  btio: Allow binding a bcast listener before accept

 btio/btio.c          | 55 +++++++++++++++++++++++++++++++++++++++++++-
 btio/btio.h          |  2 +-
 profiles/audio/bap.c |  2 +-
 src/shared/bass.c    |  9 ++++----
 4 files changed, 61 insertions(+), 7 deletions(-)


base-commit: 0c757e8eeef69ff2b1eefa59e590f171c9fe1c88
-- 
2.39.2

