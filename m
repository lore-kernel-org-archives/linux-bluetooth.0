Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB4BC41513
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 06:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348315AbjHQGtU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348319AbjHQGtQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 02:49:16 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2059.outbound.protection.outlook.com [40.107.14.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1644C270C
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 23:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYexTCIgNSTjcRtmaasB3ulk5uD7HuwA5mNIfmyerWy09vbayzRTX+Jn5ADhm/7Gkg0jALcqk9KLlNXkGA5tFLKQ0OQj1tLa/NRDC/gYmzB039upCzGwejk9QE654fEnSLijfZ17LtH8YXa3U6uY36AToSovXYxjnT090r50gjz0u9kR5dRu6LDA8GnyicyJqUyHN+rBx+sku0SpUlaQb83EfrvCddq0O+VDZw6TeFooSaYruMiv2hKFE58N2hz7cLYEoxJIRfYwNwmojJCBAtAxYbcbEnn+ogd4ZLnqFmp7vfNyDoLT2ug5rcEznKY9Cqxlk2Pn63WaCe4HKukivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FPm14RJWbA6++uGAKp0AduZc+YJ9BTMJLHqv8WMGQk=;
 b=jmJlcGCnvJjMy3HWymgPYKFyZKvk/ug2ON2AdoQIDhvlBcqv79sGyp//Aviy6XzOdVBmniMBoQb7zz7/qIKs7jp1QuNEoQsXQqSkr72k0qssGUhBGcTf3cdXi1/TN6fnVCTAPE19O/RhCeRRy7fjLXC9vlLNf59+8sOoLs0vnIPvWBbA0glM1GfB3nLwxN1zOgEwkhAjQQaovCxdtNVwIk7I3z4OgfGO+TQJixrLTiMlfmBOUcGTYoJqSawHGy2iWiyav1gj3jX9GWmc0V08B+AlshEDilnk8YO0KMGp+fjFNAjHOpGn/Nc6Y5Z4SayhpmCzEyYE6IaWMTOu67sW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FPm14RJWbA6++uGAKp0AduZc+YJ9BTMJLHqv8WMGQk=;
 b=nM3vk9V8aAT0XlhbrjSrIXDQEOuNBNsRIfJhUbzV3V8RsFCHLAk6H/D03pCtDU+RbOHmHgf4EMSxI7Ou7CG4axhnEWa0pcjGmiR3nkHrRJQF6eOzoXqqjCRCdcAo4R8Z+bLvnsAIiEbwstrb//3hIWn7Ayj4RCV8+xTuPzoQ+Ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 06:49:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 06:49:12 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] iso-tester: Add test for bcast receiver defer setup
Date:   Thu, 17 Aug 2023 09:48:52 +0300
Message-Id: <20230817064853.3706-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:208:1::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 661ef1db-3135-4a41-f83d-08db9eee10d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uc/YCIw89j4cDjkiHS5FESA6DmYMIURAw4zAMFy6nINWJZaBIUI5rqpm65eQ02pT67DpYS7FGrNL31YkL3ja8ZEkrxC7D2Bj9fU7BvG7W0MiAm5rboMETEZ2zuvfTBnlCoT/JxxFI1eECBtE8EvaHDvDiw7omZnl3v3Ua89TEHmdolb1HSclQxaZjspbUzfUe5m7NolAJUn5eiNj7XgAHhl9BUZE3+oDQBOzuWQH7N9ACdJJwfEKAus5xM9/CMA12BbAujXM64MLfQUQBTjJqkxij8D1qgDsQZhPQ8feoCHYMxkyIzSfRciCEHPtI01cuEE5PHb3IT6SYAV1cjCvuUCTlItxrWAW66tMoFhU3/Ebatrm76n6cH+3ZPXhKBhDq2LToQNC/LBVdlu3ytleDq4AGuScMruOAbKPQlh1fYvLlPoVIDKrLACB+iEq6PFVaAjdoxgGAkEKE86ZwK1RnfuXoD8qb6knQWp4g/JCL1ksHUp81WkJhUQPfmfSHr2EqzyaOMnx/poUTVbGDZeqCFhkyuYgkEbalRpkZT3B/gIW74ugh57dlhSDkwMyJiROB5AxEt7j8aj6nk+LB9EUZ81XzEvnC5wF/a+DUz5E8ek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(966005)(5660300002)(41300700001)(44832011)(38100700002)(38350700002)(4326008)(8936002)(8676002)(26005)(2906002)(55236004)(4744005)(83380400001)(478600001)(86362001)(6512007)(52116002)(36756003)(6506007)(6666004)(1076003)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LCk6IOS91F7OS0r9xo6A1zgXQXkKBDGRHBm53qPgYyMsz4rnfGIXvHTV7muc?=
 =?us-ascii?Q?QU6X64vWjc2hga2jMW8UhX7LNx90x/oFVqLYLE4t9iqBRuolcqbicZR6AhoC?=
 =?us-ascii?Q?zcXtx0cx1O3gwgm4JvdHvKbMuEd9cxlMbbUz1Qp3VayZgbNW+vpnF/4wQ1rO?=
 =?us-ascii?Q?PWsvAPAcT7Y25aFzSAJVhHzlWz2qtHfW4JT6/d5JAzV+Jrk0n/aQmAdic0qY?=
 =?us-ascii?Q?tfJK6ci9MOtIfvZPRwKn51zC5m46i6ZS5CI8QUN/0fb3ghiHUrm/DbzFYYsD?=
 =?us-ascii?Q?aC3AFneT4BElBOq/+jP0eeX5bR85roWwIUuOaT5vANpMtDLpt5ezX/mdhSQi?=
 =?us-ascii?Q?W9YxbXsSQOAUUd0d0e+sXTCMM4KFx+Pf2rqSp/6hdTnIdjPHxNILxuvyxmUo?=
 =?us-ascii?Q?pj1dxHEx7OFUi4aMthnsBYNe7oEg0oYcfd3LZJDwFzfjcPUXqLJ4LB3qLW2h?=
 =?us-ascii?Q?WaHjmTkeGOCUI20e0EY8fAXJiiGKxLNh/dqbgFTs3AFnHpsAyXtk/xaFSnB9?=
 =?us-ascii?Q?DpCYhFk0AfZhLFHLQQjHRc2HcWEN3ChT9IV1NwUs5M0QtrMB+Qn3EHIwMBnh?=
 =?us-ascii?Q?7tGz/b6mWVfkOqQc+BzxDSh1qMt0hUUtzWBtpFquAduC7CgPaooyPxCR2cWf?=
 =?us-ascii?Q?rYZySLhk/FAseAoMJG6O5P3QpvYxy79BHsNNFSzHpd6uSHo16Ug4SF8GLNSW?=
 =?us-ascii?Q?TZ0jQudDF3WtUMeJML3nyqM8QhN5vpk0o0P5n98XUThKRBL0F8oD9zB+paYQ?=
 =?us-ascii?Q?b/QlMOpP7nq6Ka4yRoAHKtFsjikvWxREDxYl6Sp43vYT+o932tWh1QfjjODB?=
 =?us-ascii?Q?+6DtfItk6Pd85k45P5zxvp9FhDfX/Ecfw2b1g16C7TymALnQh5JNfOp4u0qo?=
 =?us-ascii?Q?1l3FPllVOT2yU7l+7D+LnXEOAQK90S8d9lEmpCzuGupPNM+/4EU1SU2aiWUD?=
 =?us-ascii?Q?GadN5U++hfcFUZyjZUOXo723djAo5ONvosoaodQxzLK65lEdTEkxbyl59Bw3?=
 =?us-ascii?Q?4ilGJE/id10JTquSCSdUu7H0elDlgo69RnVYVySjRcDpcgci7if/lbvNfT/x?=
 =?us-ascii?Q?X9oNVLfnYfwQapsoj/TVEvUG335ScPeYA+W4R7HfWh9h9GN8QOHSEqSAHuAL?=
 =?us-ascii?Q?yefXQZqmCE4umqdeMc/DNDwXHc+emvEc1jmtJrKYvjs2OuODsB87SYKZmeMM?=
 =?us-ascii?Q?kd8ZKp6H/+NOGGFcR1r+KdfAReP6WBgK+Mc3d+WeqibTcI517mZMwRW7a10y?=
 =?us-ascii?Q?mSyZ7v+zNZH6wd9jyzN5WC84g7RuYsUgCUnCqfPtybAZeWdMjKCvhrRNUGBV?=
 =?us-ascii?Q?F5jqroLvHV1XqpwwLNZDB7I/X+d7AKZQQZzH6b4wLNPotBeKFeh4qrn/fSGA?=
 =?us-ascii?Q?OX2zAY4O64Mv+/71IreM0FnEPDnLtQVUB8rYeCJbgwt25iWMZq4sltXPdDVW?=
 =?us-ascii?Q?SsjujfQ89nVBIfkPhwHrW3va9BH8MGaxoLDJ12kD7KYx5fQpNAj7U2/MH5gp?=
 =?us-ascii?Q?mfrodZKTs5qqnI0pwkRAmF/Mu33G4wkonm53clYw6Xkh4ZCs0mbht+YNs88u?=
 =?us-ascii?Q?TNNq6LSPI59q3XyEuS1EfGmYGxvQJCXeCkA5mYJ6jaYq0b1lTS2Y65C+N4rF?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661ef1db-3135-4a41-f83d-08db9eee10d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:49:12.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO1GDi4ltvm4CsW6AkUsdZBDH53ZGo7XiiwHwGwW17hrXYV5H59YuhQv8cu7Ix3uZO5/TouEKONKiGdVnzvtcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following test to validate defer setup support for the
Broadcast Receiver scenario:

ISO Broadcaster Receiver Defer - Success

This patch depends on the kernel support introduced by
https://patchwork.kernel.org/project/bluetooth/cover/20230817064427.3647-1-iulia.tanasescu@nxp.com/

This patch version fixes CheckPatch errors.

Iulia Tanasescu (1):
  iso-tester: Add test for bcast receiver defer setup

 tools/iso-tester.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)


base-commit: f4aea37ee6cf6b6cb3f91e4d4c9f09611acfd610
-- 
2.34.1

