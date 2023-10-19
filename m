Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6909BCDB483
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 14:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbjJSOut (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjJSOus (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 10:50:48 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E24EC2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 07:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH2bOSMHLqDFaW3HOvZad131qSenyaZkHr7kfGoSwFajmGLKjs3Si7Gdg4aQjOPPZWvjd3MEFQ3hmnOG7KhLvE0ZV38XlpnJaq/JEI8ITuSsFzMD18oeIDrntRvSklaSv83RrBnLgE+6IWTbZgRXzTXZry9aqVvX41GzXA/kRs679DKMNaFU4Bx1ZOnh+wrMzxSxuvldGXv85lwP8ELeYE7LOyp5xucQlJ2+ZfwQvup1M/uD1skzpCymgE+xkqV5xdAuXwwXMLKoX3DrEb1XxuR/vpBimfRv0JMnqw/lbZ/WunMFcgLZaYHz+4+zmiSdr0KBxonCtxDWhLfWZSTnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0abbjMJg6Rr7CdhsfzcCnXCe5MAQ2eP6UgWv0iodUQ=;
 b=PoOGsymaOSlSmWagYqqLOzDJww9H4LgIieobqGAU64r/b5hXkxqhdVJFnaRT8b+iY0Yb83GYfAjTH1+thIjBobIghKrBbOYSHQ1eNHmXzo7oJJDTcakFh0DKAMmxnEFDZ15lQn/ETlwzMkMgve2NQ1jSp2ybcbg0odPVm22vPXfpU2vthW3u7IQiVssUGnGMj1TwlhHg8kZTkLMVwud2b1mV4390JHKHrwpmstMWpiCwk2JG3HKc0SSpFI0evYUn072N21Kw6DYV/cbhCPOM8UKBco7eKmwRJNE9QyJZDwVjqmEi899/1D9w59g1YP17c5NDpp0V/hmV2sg2FquaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0abbjMJg6Rr7CdhsfzcCnXCe5MAQ2eP6UgWv0iodUQ=;
 b=F2VAs8PmaXzmTrJHna2wzLoEgbMzSW6pJVv9GwyCxUBA/RutuEw3nj+EwpAXkmpWaadh0DC+IPj/q2chGPSNBmpeuVFvkigUYt16QKUyGBNaWXIIaietmx0gMl46Q6AL1a5C4c7T84myR2OK67kSNJ/RtEhCsrdvObrgdoGAwa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Thu, 19 Oct
 2023 14:50:44 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 14:50:44 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast receiver PA bind
Date:   Thu, 19 Oct 2023 17:50:36 +0300
Message-Id: <20231019145037.4776-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0215.eurprd07.prod.outlook.com
 (2603:10a6:802:58::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: be701fa3-c425-4d9b-1b10-08dbd0b2c5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MSB8LSBiCCDFwzUt+dEMIY6+pISkOSEw+aEHejOtrhdMky92EpCpPOTa247Aj2mYyQHdQowm1vMpXYRLT6FEAEgYLR2bmktXsL5Ty14C81E+qlz+Va63Mn5G1fu1TuIIuEFP1cweo/ZcyfjymBlvj7skrJbs1G1v3ELFC9OlUQd7UofXq6bepykRZcsvczoZj9aP0754U14Tz9VDqJU8L/WNa5OvLUahWzKXUkVntHpaQeG11lmNtW+tkwCMFHCo44cS8vlcxviHXc+hnW/mmFAwtR8whQyLcpbOffO8blPzMAXcOkOrB6KNWyhycwP5uYJnZg7+5mhv438TwBBtNxGyAPvQEkEi/nX8vOyvJruTbUr1gpVOqPy1tIqaoAR+yFp6OsCbvLJHrEmpe/5Y3dznY01wW5ZWW4K37Bkx3FUxf1zLidgCNewS7XDffS0IwEq+cVsOV64hQTB65uj8MISfE7ae44EXTn9HiW7OVDKwOOx7tD6qmCSjdJI/RArC4ZTDfWL4qFt0FtTP5anNr0o/VKkvxcsQZTlS/QXTQDSxwtvIWI6RJ1kvDW5ZyDx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(2616005)(66476007)(6916009)(66946007)(66556008)(316002)(86362001)(1076003)(38100700002)(83380400001)(6512007)(26005)(6666004)(6506007)(2906002)(8936002)(4744005)(6486002)(478600001)(44832011)(41300700001)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYNebhofsbUS/arWc7ABmCJPX9Y9y9zZVEPFwGffuQ7NCUZGXouBxr6PdHcX?=
 =?us-ascii?Q?8RSmrvDzTCfDypI2jpfOPssTHMAcBRi8P7HUlImWZ4HxEjTp6/rbhWCaTd1I?=
 =?us-ascii?Q?LP/d8L88Sk7hiZGMGyhCEG7ssPxQm7BQcnzCeWLmjPHpzqbDVWk1kN+g9r/s?=
 =?us-ascii?Q?lQBL0X83YgyJWC35+Yxej6eMHhIIYgleti9MifLcAffs/4LYxEy5a7GbxwR9?=
 =?us-ascii?Q?h2zM5FzMXMIxHJ3w91OdBUJ5fXSajvdNp9xy43waenFlmp8rjXw8qmJhB6nc?=
 =?us-ascii?Q?9EVsuO8qgKPPdZoLnnONzFEnRcWvlTQpn3yB8LSdaisdK2CcZ/4tyZLEr/jU?=
 =?us-ascii?Q?ex1doSp1vdgjFGBK1Fc8pEKnm+Czj53djdNR6Sh00/PGjxgmicgdS/8E/TkI?=
 =?us-ascii?Q?GL3sKOeEIeVJCECeDhkuhrOxNefrpZlh6gzHivnDj6JV6NtLMqpeCA+gTUWq?=
 =?us-ascii?Q?B1vE4ymLDFsYypmGVesV7t9gOG5hRVL3jo5fJTZ5fHyMwz/h0OPfxnWBNEBo?=
 =?us-ascii?Q?Mz1gb94bz6eDYdiHCJm4yvuHPGp4ApZdDMAIsY03f7eLtUiRbFZGoIVK6evp?=
 =?us-ascii?Q?/Ec4u5B8BdotqRAI3okN+ZorbutQgdDUdeUlCyDHNqL5Ynpqzgys2JkCKecO?=
 =?us-ascii?Q?wa/3LcsxGK2Ba/0HD7t9hRJkZdgzbN2hvnE7K+cAZJDyjhXDKkIFEuTMNGlq?=
 =?us-ascii?Q?SrQGg81SAynn56mylWnflcJyjQhfq2N7P6QtFH7tfjPzje53pcmOzdm7I+H5?=
 =?us-ascii?Q?WW8w/+NlGZpncIQcR0yDfIkG15obfx02bFqQ6w+fpSWm9xzIUNlmP7RY0YC9?=
 =?us-ascii?Q?NHljJVMNvpiz592m9tNTNJfsPMkJv1Wn/lN/eIsvBBAl8BYI2SUGm97iJh+3?=
 =?us-ascii?Q?CVRU7fh332+r5FylIIyZ6YD/wR0dXxrRvZRYbwg6sj5/a8IO+L5aLuLbVoL4?=
 =?us-ascii?Q?PZYoBsldWJ4qRKKj93jWTD8/9PfrRpwaHHh2GUsEonSrZii6vhSnfwEVcE20?=
 =?us-ascii?Q?JsROffnmQSSuPXXUf3cJuPwqG2q7Nn4AvAN9QH+Ov4CAdL9qjAH9y2e17TDh?=
 =?us-ascii?Q?+aVfsTwQuQfycqkFFa7UKsFy/TvWVLHatQQJRN7/4Cpz/xjNey8tKUS0yA+6?=
 =?us-ascii?Q?duJJl2uf3C+/bxbpdr5hNw0yWB3vv+7DSkGLqDjhzp2pcHxHsoZ6LwtamWmp?=
 =?us-ascii?Q?d/ilUL3Ht9qCrZa/ecnmtDCDIVw3Okh/qKiIlP4uE/yv1d6E4TWiRqGKSPCH?=
 =?us-ascii?Q?DJzKDQ3PMccmFl1WEDOSomQD26g8Cp/iGHuLpGdEJViUagqkTj1rSFoy67nn?=
 =?us-ascii?Q?aud79bi+R89G2WEDQYMNEKizKLLFEq7IqiqbWzx7/ruUhtPo9Xiq58MX5hH7?=
 =?us-ascii?Q?1af0ESfbcmpBcQcSt/uIMr6/dh3IMkTDjB7ihZ9bHxcCVFdmXHuwo/OxuH8U?=
 =?us-ascii?Q?E8ZPbj01qHlhnoqNwLXDkaeMGbHcT6S9P4IhsmEu/5Qls9HVFGSnG01GB516?=
 =?us-ascii?Q?N3LFdBX41bheKEyn/+FQ5dJYyF8QOgGTZrhhYAnay1VcmztsiuratFeOUwi7?=
 =?us-ascii?Q?LHSvaQQszEhsYQ6tb2vmGH7nOFQusrePsQV2hYfgajp2Vm7A346VY9I90EaF?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be701fa3-c425-4d9b-1b10-08dbd0b2c5ea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:50:44.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nC2unCu9SlQvvI0QHrVqkM8KcBF9QJqZU4+QC/j5u126YfI0HD4hXdnpn6NDMkLBpzvofSS5BzreygnH4HXhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a test for binding a Broadcast Receiver to a number of
BISes after PA sync has been established.

This test depends on the kernel update introduced by
[PATCH v3 0/1] Bluetooth: ISO: Allow binding a PA sync socket.

Iulia Tanasescu (1):
  iso-tester: Add test for bcast receiver PA bind

 tools/iso-tester.c | 70 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)


base-commit: 0c757e8eeef69ff2b1eefa59e590f171c9fe1c88
-- 
2.39.2

