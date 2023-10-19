Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E49CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 07:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjJSHR0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHRZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 03:17:25 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0669F
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 00:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du0D4wFSsR0Zzcu4i2oJvGDSOmV2YbORWZep2FxIWSatoultMO2koNRGfFV8YqDjC1Gqp6ysRoxcmMytTki0OiuTmpteZoE0Tojsnx6lwErP2owTuoyEinJ+pTaPfay3E3p5u4ZQmykjKxfFWfIzCtqBN3K7M3+te7UroR/1q5guFx7bQMlTMD1goAhcojjk2TAwGIN048gOY9ThSG7AXGThJLQAJlevdOcz1//e4yrttoGSDjEXngRiz5QAIjFwOrSJCBXXkCCkWvQovizG63yOMjALUoxl223ontuokE2OeH5zbXoM8dljhYTTH2asJ5wHHmnMpbYN52+2WCsNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b20Oi4h3MFQGeRV8GZbUqsSnf7ucchHtivgCCJkQz5Q=;
 b=XzIeeo9dAvzKwaXfWG5IFkgz18Zx6EQZNS7SPZ6K4SItUZGuE9XXMtvYibEbNJ8huLOjY/xLD12gNbl4b/lImJ9C54KkkWXzFLc9j3oV6oehbjkW7Eaq8X/Cz2ciprssjGDarXArucyi8IOo/hVcI2aWW2Hg7WoY6P1jPJhFDoZOQidsn0HQjP3Hv6hrU6ZXh+/lqE0MWw3SYY2KQwu/yfOnX1GOENASkfxZGLKFvMyuzj8Na036A5CUL/f5lisCSBNBarWOWXEZdYXr6OQn6JsTTaHj/rQjNWZtr3cIoH5/bCawYjOrARbLllX0TPrWGGaGdfEvYjAfNtKXL4ARkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b20Oi4h3MFQGeRV8GZbUqsSnf7ucchHtivgCCJkQz5Q=;
 b=oS89iJkeMQfMqWFkeVBXtUKMb5xu8Vk3Hm8dpI++LqDuHzFDAE6pWDMKXZX7c0cJ/6tcky8JfWMBiDK0WjuU5w3XGwS98M0FpIgTPHFvHStdTpfF1i8BAsohnalat+xklFCmX87wSbO3sZTcPYUmf6xgah8hXfErABpahtH/D4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 07:17:20 +0000
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28]) by PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::9cef:1ea8:7a49:f28%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 07:17:20 +0000
From:   Purendra-Singh <purendra.singh@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, nitin.jadhav@nxp.com,
        luiz.dentz@gmail.com, purendra.singh@nxp.com
Subject: [PATCH BlueZ v1 0/1] Changed Obex default timeout
Date:   Thu, 19 Oct 2023 10:16:50 +0300
Message-Id: <20231019071651.4773-1-purendra.singh@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PA4PR04MB8016.eurprd04.prod.outlook.com
 (2603:10a6:102:cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB8016:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: e2af188d-0efd-401e-4a10-08dbd0736ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTQX9m/DqSHkbtEFDDz8ZMl7A/52FwpQKBYG/axz4Lyzmw0ItUHO1cR7YUyOFgF/5hvIUAh6jctSecS8v0ebQL/rtVQMwH7O+1gg9jQGXboisO5eeXI89OKtuLbz25bCs+pBREZ+eTAXIfD+g4Sunfx/hBL7IgSf6rILNH1rJIXt/451GTwcEc9V201XDi9jYM/9s6KviMAcjn8WYHsS6S8LrA6i8bqoNQTWu/I76U7jgRuBqe2rr/n5FDHF/wYEUVmDIjbnXFgm+Y+opXQpADlZrgWyFsm+9/CfxpJ27QCbOi8+06+A8m9TEoyVhY9b1lpnIbgkxHGQ4AjLmHWFnksOjfHBZBvH0NAXoHN1qyLRgP/AEBDlQsyWBATKZuwhb/8pjnLApt5DFwQs/98rMEL8c9B+Ss11jB56TKdmc3sqJ6n+4rE+Wvf/CLCDXtn9bjRicJcbJB/EF840opIet/BrWxNAyrr2pip/Kh+GdwZLtrB4YXeZJyMP6pxc/2LQCO5s47x4oTalVrXmCxyCojVShdNHmxaRUSIITrbPFsB8Nlb+Ml/CrrFp4Z3PM+VVi32ERfFsWl7EUfiBnGe5ctMwOphfKVpA7v6Y4mNjQD0Ph9cVGwEZtAOU6b511w0r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB8016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(66556008)(66946007)(66476007)(6916009)(316002)(8936002)(6666004)(6486002)(478600001)(8676002)(86362001)(4326008)(5660300002)(4744005)(36756003)(2906002)(6506007)(38100700002)(2616005)(52116002)(55236004)(6512007)(83380400001)(1076003)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gGNFjYjvX8zYprczM6p6AO0zHBlOnl96Dx6jbBtZ+X+IRTbXE0M8NxOfSb01?=
 =?us-ascii?Q?qsqR69/KGZHOOxsL4pW/iDEM951IrwjwEhP2+jHZlViFTJEc4kAEg25zDNeK?=
 =?us-ascii?Q?HvcR11Q+8wsAD6ToNFcOvj6NOo3hLq8i/wT7/kSenDqKsNzKPazXU0C9UKR1?=
 =?us-ascii?Q?I8A5gBvOo7AByUOlagbPRYr399CTcakeZKjTQJgNw9X7YMYcqHLG4wn47Ad+?=
 =?us-ascii?Q?jspM3y+6/dbzCj8IvQhViPUOsaF+weA2uWFsWCA9ldisFdO7H+or4H8rVrkQ?=
 =?us-ascii?Q?aVenQ3Y27c/kPJBN5DfNckO+8/lytuP9WQ99Iv6+5cVZ37Iu5zZ8UH3QG5NQ?=
 =?us-ascii?Q?kfBk58i8g44uctyzcALbPONHRXNhupeFMeqYh6h7RYFDRc1qnKdIesFm1taa?=
 =?us-ascii?Q?4LTiHUs80m6+9Fg0Qe1jZmngOJfDYvkeFdnXt60os0che6Ym9BOal+m6/8qd?=
 =?us-ascii?Q?I/PEWotTyh3QZvKcTzWHz1iVuK41RRlwp0zL80hu/cj8e9AvMZQUZwXW5lMf?=
 =?us-ascii?Q?r+M17nUYS3bQrCZjvoHJ//U8iA9xQWe1cRqR2viI06OiStmD4TrEjXIghRyj?=
 =?us-ascii?Q?/CN6iyxRttiNXVCeElf/PfCJao0AufgqMUdnhy4XAZMHtzi67sSo0F1M8FtB?=
 =?us-ascii?Q?DIJNNPZOGm1ZKUe+c4//c5nsj7tjsPjI5SKl9T8wUtVnj6RmFFAwiMYULW4B?=
 =?us-ascii?Q?Froc2qUDoNtQzkwTyN3Fa9qUL/lET9n7+Zt9wtBisNahB5o0qPl7StG8pNla?=
 =?us-ascii?Q?zFkRMxT+859TuysfsaoGFimhg6YuXk3z+O8veAw9Fv3vlwetFLY5CIp/lZJb?=
 =?us-ascii?Q?BhD4GhO4mKW7GvfMhphenO89Mg8KWLyHVIldDUynUH1PL4L4JAWsbT4H9lLV?=
 =?us-ascii?Q?sUHgSupB4IVozB6Aiii3e379SzmAzZSHBVwtPX9UeDIjmd80Q8SvcvdphvAk?=
 =?us-ascii?Q?tM6toiSFk/jvIJVi1HHt1lD11BNppeFdFpdcVZjxkUu+E+obIU6ZtqNMYrHq?=
 =?us-ascii?Q?dOD5y/VSc/1AkXodkay8nto0QDvik9yCW/2hOk7j+5XEQwusIyKunzkQGEzE?=
 =?us-ascii?Q?ephGaVmtxEEzx5xPpe+lr2W8t7Yv/gl5uLdbJDybESvMXh8/hd/Xs6LaiAhP?=
 =?us-ascii?Q?TSJ9WY01pJHCqqh5tGY9NpNrnR+4T2udxFS0ncge8Gf3BUEcpMFwItBllz4+?=
 =?us-ascii?Q?3zIkfAQYSjiH4jeLCz2pN1XaJN54Xm1X6z+pbaVIhCdNGO31YGjy/xuTTGL+?=
 =?us-ascii?Q?TqGOnh2Zo1j7VUAfXFhi5fsHZ8AeQx8zoDPHnCe+J0JYmVLZroqVYiC2764P?=
 =?us-ascii?Q?nTsD+mBJ5Xq5Hk2fGPVNqtUfCy2K15nz1jmSjqlt8XlCbkNgC7kc80InM7O8?=
 =?us-ascii?Q?Se9IaLtwFGdPgTm2XTB6iXVhi9mA3LPuwdr+qoKqEcMJYcfvZpMvzn98U2+m?=
 =?us-ascii?Q?GDAgsvkOvuHZjGvazzmVe6V9d1hZqLTXL7USG3aqtwO+GqcIEAsK+YjA/KYG?=
 =?us-ascii?Q?Li3CqKe+rKv4P3FvdE5VoZMblTIxeVk+UiaZy29wrXRVloOw+r1tlz1dInfU?=
 =?us-ascii?Q?n5rtFt9UqHGH5Rujq/6Mt8an4itxzZrBkDZQLPDa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2af188d-0efd-401e-4a10-08dbd0736ecc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB8016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 07:17:20.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jathwJ5dEEBX66RbREAImLMOdRt8O8csvcu96c0F6E5mNcMg0hX/uEF5Rj6KKdsX/98A4xt5184qYQ3doNY/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This patch is related to changing the obex default timeout.
It is obeserved that some reference devices send file reception
status delayed, which causes timeout. Even though the file is
completely transferred we observed status error, changing the timeout
is resolving the issue.

Thankyou in advance for your review.

Regards,
Purendra Singh

Purendra-Singh (1):
  gobex/gobex.c : Changed default obex timeout

 gobex/gobex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

