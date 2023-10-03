Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFAE7AD58
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjJCOtp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJCOto (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:49:44 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84137AB
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4QeKsjIPK4hKsnmxw3RirQLk1GQ+58CoHnO/SBLf+zHFqNVkEtJuO3Sv4Sq6ymt6bHcDMpHnOhqHgougOQMnPvDMzcQaLoKiR/Lel3RE/F6aPzlkLU3p0ZoUtkLLY/JIQjPTa/7m+hfITqOUzcGAykKdYZToc1pf3dXBsyBCwglDnGkmWERD+9jWvCEEbBSbjXGCRVVUoE2FtDAjkq5aKz8ZMejUSiCDKqckJ1YBLOSsOJ5FrrE5T6lR503Dv8WUcQufSvhN+C37uiGh7g2aD0qOYpXtQQiRrk9TtgV5UK8EAo+BAE3tAo+SPxyAQNFaBA9R81eHUTQW7Qt9rowbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifQcjIDZTtfM19T6lWEmPswcuHz4tkdjYLLadUQDpLc=;
 b=hOokmwmzOA7aIXrewLHKFchz6599LqGN+9c85e45u1GCdzkJng4Pm0kCIMxd4XZkAucOCYP0fQaAebwvApgKSvmTMkAzizmF0tGni9DnO2OATNwmrC06tkqxoERhAd4ztzUqzOl3WkVK8zZzllWZqd+FX3SM9jm9qel4jC0vtgOOhRuVD6yoDkx558YjtVwebPHi3XGbTpyl9nnM8gGddTPa0qgSFvgXAzGUuPL1vZhZcLPk3rKJDJzZMMnBRNfgTjbTLWQhAzQNH1ugI4IRHR7QwM+PIBLlAC+b8/Z3FEOyi2KqMw4HMsHsPrHPQiXsG7YrvfMcvL9gpEC3S0X4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifQcjIDZTtfM19T6lWEmPswcuHz4tkdjYLLadUQDpLc=;
 b=gw8Vpy4BU5KTc4YTpP/vLvjwuGknb/AM7DDwwBj/pC1D5NqwhKVCaUJrnyVNHWIOAR1JWf3vWY5eRVfBBqi/0+7oyJRNBkvnO0jSgk7q4PcoiY0nDZz6tLYVpjh9q9GTwcTpWLv0oUEA1Eas5LSayslpQiyY2VpkZ2I0vnogI2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 14:49:38 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:49:38 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Allow binding a bcast listener to 0 bises
Date:   Tue,  3 Oct 2023 17:49:32 +0300
Message-Id: <20231003144933.3462-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: f34d0f30-c246-4618-e068-08dbc41ff78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcNWZxTymXkuCbcOls1v6+j7PyfpRB5OGq5L5jQCgtzEYr2jRW86G71qhtDmiZyDbZXxDLUNBeXw+oXx2yhb4pPRx1htlzMv/PMlIgGd2ddHXvJXXC70HYbGHlgAZzJ3zRoNpSw6rXWTLbrhbswEAEG48Sa1/HuokOkUJCUguoEXvPcuXQ2TSWYG9MOmClqPf1ZsOFPc40Rystrd6xBY5Uhqf6/s9x7T5VwL8f/yNKGfZangFZwk2/3dkp0GB8dyWfCQL7fHIV2iLLB4QNC1VJqg1KkTnLEsN9YR+weKPD5MIM0sSlw6fAq3+NpqKpRCyOf3khSDM5rvFJA26io19sCWpm4ioGt/1aKOy32wpk5W4a1/ePkC0VqoDBP4bJISxwUPn5CCS+xJa+6zKXSpW8GCwRysmtJeIAzplDmnWYl4p+U0qJ+nAgPgzP/8MDTGKTol9BhrId7OAnh1W51Vjn5woJZrT/qNGw4xv7UOBrhq5RH9vYRSbeOQJQW11pjfw/DUr2fvIHcI1u70ft0mhnSRpx+0OdHkJhbQThiNtt3e8wEc1dJw1h/jzAWJj+1a5RthA8H3vsXjht/wBBD6CbyZla7th2AlJ1Mer+YmHzm9YhgsQwLrxfDuaZ10La8h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66946007)(66556008)(66476007)(41300700001)(6916009)(316002)(478600001)(38100700002)(6486002)(2906002)(8676002)(86362001)(4326008)(4744005)(5660300002)(8936002)(44832011)(36756003)(83380400001)(6512007)(6506007)(6666004)(2616005)(26005)(1076003)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qekwimN1G7oarUOmtpV53bm6lon8n/M+RxMVL+uDhUKRI0mxYgQprudl/3Yo?=
 =?us-ascii?Q?6Wn5s0ixk9QUhXqQsJXH9LzmtBo/D8yVbYDEBX28hgU54zkU+JTS5OISQ1Ad?=
 =?us-ascii?Q?efIgTqnjv8i0x04x70eNBMfwMB+W3+kej9fCCi16VCd4pFI/BhUz6EcuDTzi?=
 =?us-ascii?Q?tZCMf8smmEFM1mRj+VwzsAa16RsQjTbZE9tTK8hMZMaEwZUBUTBvpnKYED61?=
 =?us-ascii?Q?6cgdfM0vfnBRxbRShJ6yDOvPLI0ljiU7R+xeOBnk/g05PNjEs7zsFaFNSxQm?=
 =?us-ascii?Q?2S4yadBiMIzrUXy61d0UR4aghFRLXjGovBA5XSevR9bgWA/Apgi3amTdxQCt?=
 =?us-ascii?Q?8+kl26VtfblszwBl8O5obz6Kb4PHmfFwX+ICM/FYQ27jLAz5+75pWxVGrhaX?=
 =?us-ascii?Q?qTXNgYaX4hYDYQe4oJnP+cLKVYRgjqQFiMXUnHWFCxwCk/D6+1WgbjwNz637?=
 =?us-ascii?Q?L8fqQFg97KosbfIz7klytixokbE03HrI3LQnQGbepmS5I0oOVaykR54wWZjr?=
 =?us-ascii?Q?e1duD+O85VnWmh4SOKiYtzw3MCBWNaHoI/MRql6pYfT+hB1CvOKhmzI6XHQ5?=
 =?us-ascii?Q?K4NkRjG+/U+GTzkUy1ARHz1k0hS3h5cXWyh570/nmCA9Fz+ypgvCLRbRVhca?=
 =?us-ascii?Q?mdiep6q2zOHZZDJ8/Lhecx5VdZ0a3MVlUOdJxagyGcbnIoFVZMao5lcFILVy?=
 =?us-ascii?Q?qq2oFjXynHwnBjhyVlpZmLqt0qA+od4DVNnD+h3LOsC+sHQlv9pHm5IILSfm?=
 =?us-ascii?Q?T/HyUCvYCmNNxwRSco+xieBF8A1zlV8uxI2v+kEQVWIEtLyFhJmQEjOnuhmF?=
 =?us-ascii?Q?sPimThdYjaEqhAUMBpGhWyEAvnIOlL4cVhldOX2a450snZiVMgHWn1cxhcIv?=
 =?us-ascii?Q?Fj9BlJ3mb5GyR3HlNOr8B4nW61zrXgNknrixDasSpnP/Ro2pflaU3w7BGd/8?=
 =?us-ascii?Q?+QhBhiUYDaV+RqC+x0CsBf0ObC44lCS4b0W5qagU4e4i0wsb3KHhrxUKP43i?=
 =?us-ascii?Q?3nVSTg8cLIVqnxpzz280LhL9EmIeD+tz7UMNyVwXQoMh4uB8IW6uiWLjTAlF?=
 =?us-ascii?Q?Z4KDcY3ybZJ0X3gAqdkOBzD29YxpTExCO6s/QkooF/f/3pHpZVF46XEcqyZq?=
 =?us-ascii?Q?tW4mP3tfyX0Gi3qCdiBs3CglZfV7qFVmKb/BywAmcslO2WBx0vUGESrY99mv?=
 =?us-ascii?Q?NpNCGjRQXReeDUhYNBZj56IlhWKjWKhAxYm1KfcZEfXQdFi8OBaBY898K4rq?=
 =?us-ascii?Q?0QABvUAxshm+gOdU8TSih9LCqW6oU2xIrJ3kwL4gdXSlK97h+eZ73j1gnbC5?=
 =?us-ascii?Q?tzk3OQu2rtoSHmRwRLJvuzvYxIciJow82HGU1sD2MmDx3nJtYDzDQsSb1LuO?=
 =?us-ascii?Q?SQlDtfzcTwdKl5b1w1jP9qCJ6hjvpjtkHkm5RkVKbsxF0YPOzc5C/fbWx75m?=
 =?us-ascii?Q?WLEihpIpCadOltxJ9COfPIpvBHGzhcWcehWhEyGNRLs7rXTYSJZHq6maYKmi?=
 =?us-ascii?Q?MHVtftHEjxxz1S5f2qSvFuG5dirNCSqN/WIDkCpvCg/uSpIXlZm98OVBj2Z5?=
 =?us-ascii?Q?K5JO5NLYyOhezQ2SYBZVyvCnM5Akz09qpLq+coka8nMiXY/2XK8+Xg1S8hNA?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34d0f30-c246-4618-e068-08dbc41ff78a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:49:38.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tM+fmO5l2e+FuxMm2StUjWNUB+HZba5QhzPwd9t6A2ttX+3APVjPwAResNieClnlGQCFjMzAF7XnzqK9iT2sVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7104
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some Broadcast scenarios require for a broadcast listener to listen for
a broadcaster only for PA sync.

This patch adds support for binding to a broadcaster address without
asking for any BIS to sync with.

Iulia Tanasescu (1):
  Bluetooth: ISO: Allow binding a bcast listener to 0 bises

 net/bluetooth/hci_conn.c | 2 +-
 net/bluetooth/iso.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)


base-commit: 091e25d6b54992d1d702ae91cbac139d4c243251
-- 
2.39.2

