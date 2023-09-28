Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629A1E732DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 14:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjI1O2p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjI1O2n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 10:28:43 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA1BF5
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 07:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqfkviox7Bdw6R/ukXV2htAgWwjvh9fJKNe7aSQ46UgOboQUiuLyEIg9dDgFLITyMvkbz5jLwlNROf9lsFoJ7NHD6odHwjb8WTS/1IuCwFKBHBrnd7sizCebc7S6p58wb82LQ8e1jPz6TFQoJBOaWjIrapjoSMSGmmLO6DI5YtWKw7YML65gWdbksqSfIH0+TwfXqvPITTZAZfk/s7x8e2nQ4b3H03K0WE4NNEcO5e80gE6LQQ/tJHIU5hv4R8hHgEB98x83N6LUTVKbetfDGPf1QmEiDRZ9EjrazxyEfwIDo6Aid0AEqK0k8xgDCPEo9V5McvXHkguQp3U/Vvurmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF017Pll7NAWqLimeff5EGryomJrYCdgC4+a4gvOc28=;
 b=bNzGHmKlYB+0Rcmq97IvV9NjwYVaeaoRGDIo3zqZIJ8pNIP9ojwFZTFtdeTcgoufwXcyboxYqiXIFkxMtLRXtLEPdBqAX+l6/qc9jRj9PPkS42eSfLlma0xn2a5Ko02XzCtqfLJGIPmW8CxvEb/n1d1bGzOzkG9UYWYebs+UjbvGlflxlRkKnlhNupOrpCBSoGmnEBmfiixiPtyDKtAUogFZhp6Y+zFDPCiIsP0FhEiPGoSvE1SRKUbYDTa9iZxGIN5tCsL2/PXS9FIur/P6WGNoZN0ugI0wkAAcMlDAiIHZ4fCz9WUiKCwG6OLbzeUP+ENoxFJgUdoYwqQ7gTm8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF017Pll7NAWqLimeff5EGryomJrYCdgC4+a4gvOc28=;
 b=C20yt4yUNMU1aOhZc1LCADwsR/uE8C6IlfrwVjRN99jaQHe5bIhWH/ZTuINyKGmAIQR+kQUy/LCtuPmjTKNkUkilSl8KWdo2OPiKDoUB1+EhB9Z8n34HV7I3A2/a+2e1w2EYsQYyz5ybYjoxMcD1b0LDoGdbd1adB3nEdEYLw4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Thu, 28 Sep
 2023 14:28:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:28:39 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Test bcast receiver with PA sync, no BIS
Date:   Thu, 28 Sep 2023 17:28:31 +0300
Message-Id: <20230928142832.3174-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0255.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: b716ddbd-349b-401e-52a4-08dbc02f3550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFhikqKB6jZ0AhEBKAjz5zmQVLgn5CVtfDTeTX4Bi5tT0xsoR3Zzo8SG7Go72v9jX1YIRUTMvD6nnAt76pQcPKay4zZwBSlsMa0msJTQmPI8JTOWQdgT0ApzJUnCre0h/qNYNgydrOPIm5Km6mwzw4cNOfpDfmiCIEvlTru2H/3KvyWjVUXKw9fBWPIUAn14V5VS6OzQfhRoK/ZHHrdSSrxjlOanyWBRUy2ATWGZvW+F2fe5yd+505sAhAQJ5t6cHGgg3giyQ1H9GZCImv05kpcrQGSA9IkUjwKqK2HNZtF0g7VOFgTZAahNvKioKCnHev2Au4jlfAaAynRaGcKjsBtlUB4tHr9PHCPDxf3Qw9snUTuv+P6PtwnjGLcFVwWYzC8ylsT/fnzhWEeeRoJ/si6l5yIXIfj/bsOLy0eq5QVz2QWllc++7KDoi+4TUZ9TeE2o39/n/pvxcYVn6m7QEG6bduzpT8mOEPBz30wVPeHyrhyF4noOtzmVhBITFJsKFJQg90Dn/Y5FxGBCzaFbBQrmmyyt30gSNy8H/gavcuWhMJnPUolCQU57YPxH3pVJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(6666004)(478600001)(6512007)(6486002)(6506007)(86362001)(26005)(5660300002)(66556008)(8676002)(36756003)(66476007)(8936002)(44832011)(66946007)(4744005)(41300700001)(4326008)(316002)(6916009)(2906002)(83380400001)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3tcGNydpLkUIec5kCprwdGKom3q0/KulkV7Nm53Xg/otruT7lK/ugmWBJvqc?=
 =?us-ascii?Q?H3cct/6FqoBLniuyacwdy7zl4osD/nXuz0o8/rYE4SiXhV30Qe4KjSqM4Hkq?=
 =?us-ascii?Q?oni22CzzUwqiB5rDdg53VnUySaoB8NLVzS/9POONwUhHwG1TfgsDUh67MVxO?=
 =?us-ascii?Q?6KlSwpCiZrEUiyrm/U3GbF22c5zGOGI4bQMO/ilSt4AfLR6dmMCctLPMh+vK?=
 =?us-ascii?Q?mF7aREMtMro2ZcrpAM5too/lPrXE9fMKqyOetWy67IXItCPYYIi3ObfRddwN?=
 =?us-ascii?Q?D44zO+YPkuqSkF+P4st9SKpc/wBQIGkHPwni1A0RE8/wgGH6g+i03cF58EL+?=
 =?us-ascii?Q?LBUpkCpESdw2IyCJKx5yfP6kfPPbxQP+0J0mVsJBS6cqbPRdvnxA6LA7Te09?=
 =?us-ascii?Q?VG8C/eWoyiGvUKQLZ43h4Az8bm8g9nPVFYYwwEjb1j+GvCaFEZ4HPdzMFGYX?=
 =?us-ascii?Q?VLpBX6C8lCLeK0mnFRjQBJ+s7/atT9+3nXLEMW6AhGzgaecDSA8nysrauLKK?=
 =?us-ascii?Q?vYBeWIbcXwDZfK2YFP67GpzNiBaUhpGSIcpS3oZDXXIXxf8kUbz704y/yB2B?=
 =?us-ascii?Q?V35Ys0uy20ZDWCBPve3aOwBznApnmv+VeDtSdfTesU3mLm54LEL7avSQZUGa?=
 =?us-ascii?Q?wHYaalN7qO50oF0FAXEI5Hx2x3uj6A80jiWm9xBuzzc/HEi9FG2PGws/bnmd?=
 =?us-ascii?Q?iA5WsLfJlLpNEuEjSu3m9m5Pfn3brYPspAQW3QyxO2rdAnuRbkAHitai1ymx?=
 =?us-ascii?Q?NxHvBW7Ap0ZBxlqvOCM3UXPI0eTMnVLeah/3lQ9AkqoAsibG+3ztQtDkxJ0o?=
 =?us-ascii?Q?/YHpuYc4X4feOSFdjZktec4G2tWshQhUh2PCSlzKBtYUmWACTsQNeZJJYkgC?=
 =?us-ascii?Q?0vHjDVEruEZ66oaxitODqTNMwar8bDlHnPPwuz60zU7jGeD3LSYikfWr4Jgc?=
 =?us-ascii?Q?3HHAtidMPP8NkU2K5lNrlYmbDoiyd7sXBeXAtRUQ5efw2HfCHz9zHvuAw+WD?=
 =?us-ascii?Q?mJAODNzEfShGOxvSOHKwefnZo15DBlHcgI7ipAHOLKPzus8EcU0aJcXgFiaE?=
 =?us-ascii?Q?8R9b9mSJy/P1Spjjzkr/pvyfCTUg6fdHd68NXtrKoGpeolI/UgiRlomsnLQz?=
 =?us-ascii?Q?37tPNVgtxCsXt7i1Q3v6P1V/AaWiVaKalxRUp+gtIj7wRXsibqgmNK9z1uJW?=
 =?us-ascii?Q?L9AETtu/IpgjcbTLERAmap+SkLbieI9BcSOO8qVkyx6+DiHjIwVgie876Xgc?=
 =?us-ascii?Q?+dJ2wDwnzwrvrX6FUnrtXUynxPOO2FA3pVrc4afXZ/hD7aanrlIKrZCmu6g8?=
 =?us-ascii?Q?uWcNYh7Ub49h2ft2i92VJq9HVEK/uOIZ3iocRlycAIO9TrT+WL35UnZm0BfN?=
 =?us-ascii?Q?/TpDu59heI4re1Guj+ODNUr5MjLoWtHqOrWq9bs+RSlMaLW+7g6yKUpqSk6w?=
 =?us-ascii?Q?l+FtyndX/Dg+69I7GyeCIFFx/in+KLlmDmw/qcVOyxpghBeDX9VjUqOGnxiP?=
 =?us-ascii?Q?NGVVGYeevLKeC8akc9Ya3CJbsT3whLK/UIER/RSPkbkQoHvRweObaI2LM65b?=
 =?us-ascii?Q?vtSD5X1pmqLR+kq92uVH2vbOzTZ77VBkl3BKER+XK8E+oG1d3c65UDz+/cr2?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b716ddbd-349b-401e-52a4-08dbc02f3550
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:28:39.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI5VxVdaxPCH8NEGYSnLjKbZ2/UZ/5CzQfloqQXMqzFOmpFQ8RLwU0ccyZAbRcwTmLi7L9mRgldHB+/JqR5BNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some BASS test scenarios require the BASS Server to only sync to the
PA transmitted by a source, and not any BIS.

This patch implements a test to exercise this scenario, where a broadcast
receiver is able to successfully perform PA sync, without listening for
any BIS.

Iulia Tanasescu (1):
  iso-tester: Test bcast receiver with PA sync, no BIS

 tools/iso-tester.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)


base-commit: 5ab5352531a9cc7058cce569607f3a6831464443
-- 
2.39.2

