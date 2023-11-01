Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8C8C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 15:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjKAPbe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjKAPbe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 11:31:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E21FD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 08:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZc/9NwiSTajQYq1aUkYsIMHK2N+E2rh+oQz7rnfhhy7mU+PRfPv5t3DyChnTqAD+WzB8xAka6WNGkIL4sVr+AikSijkkhFdwQEZTkKGfKFAWH8WfOsK/BghgP0sCNmXHgECvUVj9/l4QV4HVu+VtApBTs2chYRcWYqY9o3o8nFDVv08fjHVbJh4BNdzLOH/LH27ugQbkpcAD9c3WLyRce5poL/Jj3sU8l5TnRslV1jDqHQ8lwkkCTuRhKfs6rS+3h9PTI8nsFbY2bTqSJFg4YATt04C4pJGUmEnxOqk6/a8rjoNywAcu8VEbHX037kZnl+/8RJgpj28EnvMgui3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH8gkqGfOau8AwK80plgHqs+LcivT/pIzjJ9MHdkeyA=;
 b=k8C0hDZt6WFc401g0VwcXrqyMkYNpGsSxmNA1sAarCVlKiJ7yxMV7NICHpQ6+DqQ0eVaodK1kzgC3lQ7C0XjaqmBgI0pu0hGVJ48ebTCPhD3FFy1gB9ocpRkf3OA7kE6NeitfZ6KUQ9KRlOz9x5VyxzJ2YbPqjdDp+Suk9Gq+LCoPFD41QsjgKUKruNhEDc7ygnI8rVzi7GDDEMxKng1sAq6+wPuYf+5k0QyJDI7IzfifiguRMhguFOEZNiYOPoQOaZLJgANyC9MP7yCfgvq1ZHvZKRtCMLaJOOx5ETy1k9suzd9qc1pwjZuy9LC7iZQy3F5hpE8SuXjxfOWZDWIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH8gkqGfOau8AwK80plgHqs+LcivT/pIzjJ9MHdkeyA=;
 b=ZYUnYuOtxzrZqZjZmus6fusDVpiyzUklHEfIr6UXd5pwcahA8TvcCPO0XPGwWKznutqoZcWrSKTGYQkNIFszkLCv7/5GcC4JDJepgVtajfoILy/nGV76ePMEiHAviua/ja9KDQaLHP+UHm/HeutwGlhiym4ue0AfjHwIwWAoaa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:31:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.017; Wed, 1 Nov 2023
 15:31:26 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast AC 13 reconnect
Date:   Wed,  1 Nov 2023 17:31:21 +0200
Message-Id: <20231101153122.5618-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::37) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: a9126866-92f9-43f2-1f38-08dbdaef9c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnvuAXFkcnsbYi5YNs8NaSxYmxoV3LxM+RO9f+k0WalGqTIB6uOAu55DJeccZsScDQaOVJ2w/M21fKZhKjZpBzy4Eo096GeG6bbMFnO6edpS64p6f85PbwnOzUTK+liTazAAdXBrYiup7wRwEXPzY9fse5CZTnwEGZwTpaQJaO/1exiFJ2m8pYefj/n/7IwPPqu9DW91CCsThXOyzPZ3w807Ixt1CDWhsyTesBPQY/Xifan/En9wq+SUsoNEIbyxIJ0wzIlNe1AD2pDv31hBVldQMj6uABAHX97u2CwSII8mB3pHRIddjRdYL/RHEzeEo6XGk8Vawwg84W62v8H7lf6cYB67OrT8T9jfZrl8jg6pTP47aT5F7anKsgQ/0mxtA8K33lxsHGitjknppN1XuiV7qcyJLWEPP6TTbBCR3UQXZpI2UJe/nDY9kYFQVyf1aVi4LwsHq3zHpA9kMS8JEusVdvo7sPk3gHtvO/G3SrOaNYaDGeiyb6RL/96GWxIF17qelWO5bn+qMbS7cjEJ1UcRTVX+mJHDZrpetmbWHtiO0eX8338tP0xdLkFkr+CJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(86362001)(38100700002)(6666004)(83380400001)(5660300002)(6512007)(6506007)(4744005)(36756003)(41300700001)(2906002)(1076003)(478600001)(6486002)(66946007)(6916009)(66556008)(66476007)(316002)(2616005)(26005)(8676002)(44832011)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xovHVap4msA4sD6bTYfSqpfJkemVdsVj+9A880i3CSK0l6TqQ6YlPeLdIZgK?=
 =?us-ascii?Q?RdqrrdwOcws3FDw1quMWigqvvy2y05MurPn0A7c2ckbvKeQXSrgSCbJT5eXZ?=
 =?us-ascii?Q?WR/JFgfMOgs+TSQ4WFIxUA7pKXXyfezyjxlKLRi9l9K4fZget1a9xSGUf5gW?=
 =?us-ascii?Q?mqY335ksg+CeTdwrq4mBSxKVHq+TNAwirdK+v9I9tJ2L5EJ1CuRgya2HW6vx?=
 =?us-ascii?Q?q5n3AgzRuF6IZemf/IckkKpGStzjnDQ/fux9/vkxXoYnEjWYPd6krfOnr6KJ?=
 =?us-ascii?Q?0u8sjaVebPljYqUGJj1WrcOM46sECfJtrUkesr75a6AelSxUn+PHfvbMecRS?=
 =?us-ascii?Q?FauIfHJIkNb7srqUM3vptIwM2DL4CVrWyo1MjlnYt7Y/WIyE2rKCdzfk3F8a?=
 =?us-ascii?Q?BWU/xptPvkW7ma3uM6S2kHx6vlaBD+byXbShh3wwaB1U1A84THpiPjlo8yfs?=
 =?us-ascii?Q?nDSEyMOUu93QTNWq5Rp73/73F8Hn9QV1i5jkPLgduehchNlP5UujHdHgm3Zr?=
 =?us-ascii?Q?bR4EWjQs00LsTcq7+oo93UFuwgk+yJ2fifAj9RSJ0lZiATdtjBySOS8+/u1W?=
 =?us-ascii?Q?2lzOTMrUAylotE2xIMgA0T22BxGDXYbgFhj6PANaEnypGMk6Lu2nMwDkKpP8?=
 =?us-ascii?Q?NeFXnpGaqd2ZUboWDOeOw9PFtW4YROpF7/aRF4Ars5F1a3v9jfXB5pxrynam?=
 =?us-ascii?Q?HgZU0aXI7McjznUwg2LMrIqGAdvapOFKoxVnGKXfjGSFgX+v7ctY8puIytRp?=
 =?us-ascii?Q?fE4aPlOB/m6L7Hvq7+2HVOQaBH9w+F90JvCWuAvmd3tTo+QI8aB32wiHd5+f?=
 =?us-ascii?Q?PkxcoSRnoOKxjKPl1DOvSiZFD0RncPSn2xbLXKtATuS90W+UJypT+48hzNFF?=
 =?us-ascii?Q?eu1MZm+keUNmJEnpR/eTVTyb4VylYPwj4RgUBBuGoFzp2pUOqbyol4thsvvf?=
 =?us-ascii?Q?153JfwmHMjZzLbs+Xz5AoO2bIV5CQKGr+HoaKBQ4y53BVslX7q5SL5pFdm5T?=
 =?us-ascii?Q?SuHbj8bw4ptIBsKShaa55DgJsvfNSwA90cCG2GVRmMayYJYhCaFtqcZjxXcj?=
 =?us-ascii?Q?o6tXnkd+8j1STCPvP9TY5H905pP/XKkQS02TK3ZDwUnK0lNBeM/Rw+GJQLDQ?=
 =?us-ascii?Q?y1Rb86u0D9nrhkCEQb8XRX1BhZ+xJ2btuNET/C7pTYscBqphA4fGGMeWat4z?=
 =?us-ascii?Q?tKIlpfGp2DUK85UbXCUWKkL52thTGY29YXHWqQZcYVwkRTT9DWFHfHNsFkda?=
 =?us-ascii?Q?52TuzhYgZwyIqLkA/7TX0ZtkXgP+Kqy4Ols+zrrYrGi64NtOnrzKv8ryj+Xu?=
 =?us-ascii?Q?u8RAuj1UCmr6kQoB11GqazWwD6n6EnLVkBRZWk5dNzuHCAqdAhlG/tKAfuEp?=
 =?us-ascii?Q?XgJoK5y7puAtWGQuJvJHt2kcZK2yUQ3+NDofSVQkHbGmk0VHeWvveZHg0I/4?=
 =?us-ascii?Q?dpFfIPSkd7wSo7K21qH4ra+yr6AaVEgwdvOS1DN7R9Eqm/fWp3KbR3GGoIdv?=
 =?us-ascii?Q?GyNY/3nJuNSsxpDXs5y7cDkVrwpBB67E9NwvODe4FoToSJXyeTEn2bJTK89c?=
 =?us-ascii?Q?4qpwCDaB7xPgWq2CB/887Mj37HpVd1UBgHQu2qzihxQxYV8VoKz+Ut/jA5dH?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9126866-92f9-43f2-1f38-08dbdaef9c96
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:31:26.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogQPTcRGcpElMgkPn4f1He41ovhD6uRiKe2/WuuKMzL+uArJL80lPrh3GJlElABzMkYBzoeFeMIi1QMDNeaseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a test for the Broadcast AC 13 reconnect scenario: 2 BIS
sockets are connected, one of them is closed and then reopened, and
it is reassociated with the free BIS hcon inside the kernel space.

This depends on the kernel support added by patch
Bluetooth: ISO: Reassociate a socket with an active BIS.

Iulia Tanasescu (1):
  iso-tester: Add test for bcast AC 13 reconnect

 tools/iso-tester.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

