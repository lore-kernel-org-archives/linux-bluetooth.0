Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F99C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 08:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjEEIcH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjEEIcF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 04:32:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424F0191FC
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 01:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng0bynqTquRVw0d/VVNcYD7ogzAH9/ISsZ2DhT23bARCu8w1wjnCVwfDDPR159ywos6Zloa5RdZ169TR4ZLnNvv95ZCB9OVajgRWvZack26zSJwSP5YtO3Xt3d1Qr6PsbR7QGHMpIoKwwNfsmDD87gadTLmb0PPyYYy0U56ZtFJgJzgexdtDAm3YarH5E7hYRPrsaGJJ0rIo8HBhO9ZgwwaDewuz7Te5SJY5iglux8+7G8reztIH6EUIrODbiq67myTHEftLDX/2/Nj81xkA2Rd7pDr9U+qtFw6txFN9lpmQRqGvtM+Yd+j8km51NyLVHE5/AjEOUu07b0cUo5gWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pdkTX87giOIrwDhjQXeDQhDRzR4Q1mOAgAOmbhDLNA=;
 b=fme39QSue9ABekJ/oqKZ2zWWxOutJNOsFwrEE1NrhahbaKlgPd62MlaYGwjVHUgOrCTxd6W4BLHGl6FJ3fYhiGGYMWW3w5xqhaD8aFoqmN0pZROOgGj+7pUb7cmPw76ASfEf9+5qukdyXfO+2fdFWU+pgyX6b0S5Xp9+SJJea7lla56zRBODipBFZ9eDKfpImrTD26oY/mF4/mBf5W5h44KHuq9OjTaUvO/6jh5c35iE2HhLa+Er4q/aX2acMzCgscY9QxB0oXx/2BVQNiE0BO0XoATIg2XmJ8Tw6qAR4NpZITvYnO81uvjjD8nZTzWfSaNLjIa2VW8BNMGeI82plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pdkTX87giOIrwDhjQXeDQhDRzR4Q1mOAgAOmbhDLNA=;
 b=CaS9B8d1HFvgx6E/6ot5CMlrD7yaQdvi6zbpJSvTBJqFvGFoZMiPUxjFvDpOwX5KkCCfv/9T6if/yc19+NyXrxODtTz5DWKmrcVXCHOqeyGjpRKUXJlf2pP8OyTCvJgrqoxdLVWjyRritDqQc4O2PXHtS9CRR8a5esclLv/t92s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 08:30:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 08:30:28 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/5] shared/att-types: Add BT_ERROR_WRITE_REQUEST_REJECTED error code
Date:   Fri,  5 May 2023 11:29:40 +0300
Message-Id: <20230505082943.92033-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
References: <20230505082943.92033-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bcd736-5fac-4f47-339e-08db4d42fba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5ychZcSvqQu/dg0THTjTxy7UKiZ6FGNqUqfCQucDJLnesSTlLA09VH7J51QYvuvqOW5q/QVgBhit//8pLDUZurWaYfrXX7/lDx790OdPG62gkhvyx9DCzcRM44EVBtNydyU8gsh3zWLcKVyQKQmFotWcfD5aADme5GQYcQUXNnlFC6aHetBRZsESzpmJU5/sVDbFmCx+AdnS3BlJ+Za7dQvgWjqa8YmO5y/+PyRaXg/sS0tuuEu7sM+3/NePQvHumpHBvQ8OQKPJetCnqEpGQ6ghr+Sg5S8MnZcJBlN4t2OFsFcR4j9A8supu6eZ+eSPIRpDd2n919B2JQ2HtoOTS1xn76eJ4M5VBitHYbQiL2MR85zUHkD6rQPnDt0ta9G3D9ZrwuLLgp9mmsjucLCL4yDk3s05S72vnitzL2U7QoGHPTqzSvFinv5iPrU9GU4KtbapTAObpQyjLw5eJaZNuccEUIPVm2Z8pD1WJhJDHSLz3giPO3JTiPxY+fO3i3WrglaDbRD0hw0k7Bskh+FM0s6kXhEHFUVcxrvFKWaNLtQbViri3yXcisXz63/LfLwCS/bdmOTyOYeU9O7zVSgClOZ1UQYz2wmV7sCyGHqWv+kXgZRoMTzGqyMXnxy8ufi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(52116002)(6916009)(4326008)(66946007)(66556008)(66476007)(6666004)(478600001)(316002)(36756003)(86362001)(6486002)(83380400001)(2616005)(55236004)(6506007)(6512007)(1076003)(26005)(8676002)(5660300002)(8936002)(4744005)(44832011)(2906002)(41300700001)(38100700002)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YWIP6Gn9GBU9++6z4emVDrR9bTzjb3uZevLrrvU1/pawk/mBjoGBtXQYIMqh?=
 =?us-ascii?Q?I2Fb6fOBChkikk863DscH5GZHpTi6FTttkLesCgxgJi9oQ/mGjR211khgI1B?=
 =?us-ascii?Q?DGSh7UGFN7OpLem75NOAXtsd+rOoiqMt2YgdZ3xjqBp1jgWSD4P5ytg+LoXm?=
 =?us-ascii?Q?fgB6VdnbZj/3co7taxjSB/CICPbBGG2WTCyV18WPwy0wlWxmvj6FXUAK9aH2?=
 =?us-ascii?Q?xQkmVK45CWRCbV7/Nc3lQ+9innN1kJOG2TYtlg6t0oUKPw3MEzZbt3ZIEF0+?=
 =?us-ascii?Q?gk/urLtW5fiSUuTivz2Yg3LbQsNukomAjLzQhwQ0Fip5qkNkby9xa+wCdtMN?=
 =?us-ascii?Q?ARX8MfG6zzsaAD1e7Tmq+EwbE9NcVgkGiYJ1TRaQk7/UKs2tIGciyCdW6sKL?=
 =?us-ascii?Q?YiHXBT/US1+FqlPu2NwpAFd5IkRve4Vh2DqV4bVKmEm9vk6uXlGXHic4KZTh?=
 =?us-ascii?Q?jCnirH8BcZDPAzBdNtSpVM9kP+eMM0dcmiUjJT3h0HA7p1iorAWITnjuA47y?=
 =?us-ascii?Q?+Lxv3t1Ays9osaINbwWh5rVgcTnYnMgjUMf/H9Jy30VTGHJounPzJ36cSKMz?=
 =?us-ascii?Q?w/xDBOxi+skQfGdKM0fM3hyzZi7fuLFp0sHcBgHsl0BxUdA0z6bsv2NMfiGj?=
 =?us-ascii?Q?iVkpj3yYkGK9+LZxvgQ8EFr6jRH10eVJQMXsbolCD0eqcvPE0pi8JLDY/xry?=
 =?us-ascii?Q?b6C9saZWOQTNzHmlc0purp37gBQ4L22Txo1C78qcACOt3w8aQPJ5dpRH2xZ1?=
 =?us-ascii?Q?Bt0buVDOeJJ5N8Ucyc30k2kNG3Dr/iBVqVh+0g7+1PNkwMyppVqQvLhyXdYt?=
 =?us-ascii?Q?b3qu7uHWAfNCkNEwdZHxvpbdbm5QZNM+FRKv1H4LpA4Ztm0EzU+DI5iFtDOt?=
 =?us-ascii?Q?2gbz+2kKxfbGb0KZ3iTWK6XgeD3+zbeqJyQVw7MyjEiXU0Q4fHX2V/gBjScb?=
 =?us-ascii?Q?G99ALp6eeFxCSlViXo/V90Lb+BgVl3GQzhaSLjHHUqkP3wz4ePJ0kUMmzTk7?=
 =?us-ascii?Q?V91ZAsXnlSq1FgNh3PqzWQrfwlTePJuv1MF5W0EYNltoCJ8YycwUdB5x+BfR?=
 =?us-ascii?Q?UsEUucvcO6eaKAAzUEYzr4T2V+/jlIWIKez3OtZ4U9Y/OMSnP5QLZnMWdkaT?=
 =?us-ascii?Q?hyEZLh3wed0QhjgEkXSfo6fNPwYV0cL6aJjGtVmggtPBfC+KfGvGAzfmkWBb?=
 =?us-ascii?Q?UUrzUNIp3DuQUIyKdlH6Wb4lG1Os/X76INi9FQMjWEbeur6LFtU5cORmz+6q?=
 =?us-ascii?Q?oS2GqswvEcHPbGibu9rNXw+zs23t4QdBrPfgy0qC+w+AdnFfeflQDSrRqNUj?=
 =?us-ascii?Q?zuRmtp4k3fWSYpzjL2acKV8AZ89Lo+/e1msDLDEFhsU9VUTN+Dzlfw1uvmN1?=
 =?us-ascii?Q?YJlotKa3Tml+s5ca5DE6jIrZtEpTUXf1V9hFWvNI0g/GxC6GwbJBWDYtrm16?=
 =?us-ascii?Q?+L+ijq5TT0FfY+4rwdtfvcLFtIpzNk+l9530BihtscdFUA7+fj+AppPq0ZRI?=
 =?us-ascii?Q?7U/PUHhQO+ev993aJsj6KpdpfRrdLJwzB4bms72VnZH6bBmkhM2mKVFTqL4B?=
 =?us-ascii?Q?USP9ILO+sM7LQoNvU8PpG4KHRahEO9RTyxxK+DFfK/iNevfWA2XC7YxcwzYR?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bcd736-5fac-4f47-339e-08db4d42fba9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:30:28.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLwWAjSTng9Dnaf+RyI4HBvbF6GXApexCD7H9JZ9fY+kTPYUJa091M1pGI+RokGttq3DD7t0rQDv7criB3Hbiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds Write Request Rejected Common Profile and Service
Error Code.

---
 src/shared/att-types.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index a08b24155..69f45b6aa 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2014  Google Inc.
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -101,9 +102,10 @@ struct bt_att_pdu_error_rsp {
 /*
  * Common Profile and Service Error Code descriptions (see Supplement to the
  * Bluetooth Core Specification, sections 1.2 and 2). The error codes within
- * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as the
+ * 0xE0-0xFB are reserved for future use. The remaining 4 are defined as the
  * following:
  */
+#define BT_ERROR_WRITE_REQUEST_REJECTED         0xfc
 #define BT_ERROR_CCC_IMPROPERLY_CONFIGURED      0xfd
 #define BT_ERROR_ALREADY_IN_PROGRESS            0xfe
 #define BT_ERROR_OUT_OF_RANGE                   0xff
-- 
2.34.1

