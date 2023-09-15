Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C31EE6457
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Sep 2023 13:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjIONTC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjIONTB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 09:19:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD7C1713
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 06:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfOGBY+aSWIwnM62vm8sfoZWmfXxIUc3/uZQ+vcfMDoeXtHxM9dV3pugQ7aeHyN9WS9nr/3xmlNAlq+NA4y1gWRIAIaw42KyJjZis+NvMk9G5mGjERsNDQtuFCwYtoiEn+M8lPERHsIt9MoLq6kz1QEvqv+WB5MYjAOkJdDoDvVcLnE59HpNvvTg3/dBNu+q37co1kRVFz1lp4fyvQiNN73A0lEFs53KdzQS5gDKIgNETv7U+/pa/EywtRbNOVyRdMJwJ3oKLIa7/vn8t6AFZq7HTZNeAzFFBV8oA/Jamq1wUle4sHZyR0ZOYT3V4A7TF2wziC+CV/wUqdxVx1E+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=invofblVWV2AnHn8GE4ACLUT6+IOXFWybVLUrQ5KkZw=;
 b=VeZ/NBIqPqSsnau9w1VyenScBQ2BTFO8A5YnSGqR4uFZjlQndw7uYhANswxKeHmZ74HYmMywCHNeZZZ4x638WRNgtAVykFWkN+taaZjXo5+Jsj4Yv5B6RatIZVdFgY9iRkne0HTlz/8JGQHvuJ+WKtKkXcVoPom0YBD5Tj/g30X+z7aYFebV4/ELDUEknZPJAJvYFdRu/HVKYABsQGnF1iz4kNqQJPdUVkNzarlEBE2kCQhZIDC6WukB8tvFaP1HvN3nGzTir3e0+/Z5t3guYduCqAWyKOThoAEzOkGdbEkk0fBoaVmEICRAEoknTXpobYSPOmdfYz3UKJYIve1X5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=invofblVWV2AnHn8GE4ACLUT6+IOXFWybVLUrQ5KkZw=;
 b=n+tBrPkBQcXOo5Ii3EPDzxQ7I7zZ9d17LUfFR5Oh/7bSzI0xbopjkw6lWwtoLvbUUNS4ap8jEgBI20rvfBZVfP74bgcmpgmaOcvLYkFEBtMgRtvH24SX54uk5OskZIQZmKhVS2V7B6txBP4+I0IFD1skYtGv6GgIloI5FWkQDHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 13:18:52 +0000
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::e160:6b82:9656:6366]) by VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::e160:6b82:9656:6366%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 13:18:52 +0000
From:   maheshtalewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, mahesh.talewad@nxp.com,
        luiz.dentz@gmail.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v3 0/1] Implementation of MICP and MICS Unit Testcases
Date:   Fri, 15 Sep 2023 16:18:30 +0300
Message-Id: <20230915131831.119124-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6991:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e9900d-1125-42f6-dcc5-08dbb5ee4e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSpNaFM3/Y1zolEOGtl3DbEsBW2jq6yL3Le1VUGYsF/7sHMSSo9E7r+ZgTGejX682w8o7Fas2NSuUXAXB1VKaNwvTb5NQjrWCngyHV3hRiSU6/2m3aK99hJgsptitf5CVXzU4yRAoM7LF0fI46WlmEUJALvcj0KOvKDFPfYeTfrJxnxIT3CL1JRnlLjfxAmyrk9GJ7BUsshfBriqopjlLEvIxOiKMqNsc2ukGtg+ucA/mDJfmyE8XfLdHnhDv8HTES8qQ1t/X2rlz9el6H3cZmFqWIGZbomNQfyE5KcWvHA9kyGw1QnOrAdveGwj3KJuXgZLbWb6KsY/qdRQR7duoIlYC8V+rOfgmobNh86UMd4wA3nS5hoIBGVZcUdSDtUmhONiiPlwsIqqCIw28DT/5qPugwWGqq0iwnEQLraIWvYfy7rSMuRtHDXYRhnJkqHAph6gy6zLahJhWa8tyNadea9FGq3ei4eSQsBCkqNB5mfIfLk9PRH2vi6SRMerLQBLD+NN2OtdSs+ws2CKH5JYyPG94+H7f6T5k0ddf47Un2D7rDFUJbMhqfdd1uZmWUJmlgGrJE7aL4tyTYDIfAHvP8xywgFDGGZRzUmUEkbQE2XVZOfR4WXTbzGVzt0E/2JOvEI3ibrV7g1R/t4x8TL9yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6991.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(1076003)(4744005)(52116002)(6486002)(55236004)(38350700002)(2616005)(6666004)(66946007)(6506007)(86362001)(478600001)(26005)(41300700001)(66556008)(66476007)(2906002)(6512007)(5660300002)(316002)(4326008)(36756003)(6916009)(8676002)(8936002)(38100700002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3YlYrSiTevZCAR3GbEt/UhCBdoOOXZvixTwZq9WsXvvXeLjPuIjvhp21LUR?=
 =?us-ascii?Q?iin5oZ3j3xbl6HMM6yYh+hlUq/YGQckptq1byT6U68M8gX43vJUBhU6kHU2e?=
 =?us-ascii?Q?gYFL0r9flRk+L2dIYVMlcQTr9HxCWIfGtAAQSnRwD5dlEEP4wi165XOZ+r0I?=
 =?us-ascii?Q?CiaIrjs2Nl9LDK1wAW3woItD2AXAoV9VEnEnh2yqC2smW3ZWPYrMHkQtCI5G?=
 =?us-ascii?Q?hjoyshbZuTBsJgAL1KJvotpn96QlYvuQl/VSf9QNO0GZmPFS1XE1qVLW2TcT?=
 =?us-ascii?Q?RrFgypRR4e4De7XbgkdJVkbmuhri3tw51OEAAkWN1kDLf6/XaLolY/kwGppM?=
 =?us-ascii?Q?emvbpfodiutUPrpVnCF5qhyFVGgD/t1XEZefINWUSvbEXW3sSrmrs19YZTlZ?=
 =?us-ascii?Q?GX9fERf3+X2HciGJD8ucFq3N7JXddySX5amSrrUYui7uytFYOdy5xzPBN5zH?=
 =?us-ascii?Q?A/TigbKYrDg0LRa1dyjBI+T5BlMDIUtDq5FYPFaAd5cyZFRQclY91BGZ9wiB?=
 =?us-ascii?Q?si07H4CTT8q32QLaG8PWD73hnLv+n8vIlOXJLYUnR/EDuknArJ5bA65UAH7i?=
 =?us-ascii?Q?r8t7SJFMEzbhr2kn3egr/nwIk6OgLG++Yxm4ff7Q9WIMT22fAEHnBwItljud?=
 =?us-ascii?Q?7qdMU5ADG1i2+0pe6kSN8kOxC2Nvre1lBRi23+Dekmb3E4hGHfkDqe7grW4X?=
 =?us-ascii?Q?EP8vv/oYtGOXoAyJ4eJbBZJRf0sAUKvWnMSRj0Xykq2ILU5BmwRw7g3So6Ez?=
 =?us-ascii?Q?+Rn3t4OuXI/fFZO9WkL5Q2VhBOwCP7AsnjmlQiUm7gc7FfTa8xmy78uIXYDm?=
 =?us-ascii?Q?aj2Ze0iH+AaLtJ9P4Zx1avw8/wrf906iho67dP+S2lTitwQHD/fOtzT7ffFs?=
 =?us-ascii?Q?Fg1Xxb1X3AzU2bVZ3yAOyAIL2xeKuW6N17ou0jL0nMOoudK0NIVauKDcaZ/a?=
 =?us-ascii?Q?uxJH3vw0KuJAVtJ2pEHO8Q+iJ0EMWLcPe99uWDHd9zdXmNx4UXTLUH5wZeQ/?=
 =?us-ascii?Q?hYyKVVgqXKcs5VT11hb5MbZQ+T8tiro59w4blzzV3pDQuVZIUcQF+ZlxZLn3?=
 =?us-ascii?Q?/DwRX+Q8suY6aCfXV6q77ZrYl6AU8p/T3mcN8qcNeIlqbAIngwTLgSa6SZWq?=
 =?us-ascii?Q?6Qqg5UpGqWqH+dKSyGvQWULI6/Z8IzikdquzJTNofdw17klMtHJxq95+OuSI?=
 =?us-ascii?Q?hMbKLLNbc2GE2sreNoEithys9yE/DoVSnLBPsVRzC5azjIVKBNqNfrY5k1Mk?=
 =?us-ascii?Q?IZkuMnb2Rtvp6NBMiTffL5SJoUloIZZQpcWLBw7eKIzCQMikqxX9ooQCFDkD?=
 =?us-ascii?Q?acgaUVxshlWl3SlteZ8YzhQCFHwIHQSAUNDKukAan2v4SLQCA1se+5mI5MFp?=
 =?us-ascii?Q?Ys9lMjOlsi3tlXtj/gRbdUm/KvGeuG98gnow6ivUzJ84GH7LgGrP2cNr7gX+?=
 =?us-ascii?Q?doN+aLnxyU53mvPFpHhQbqlT2lN8we4IBUTD6Ojf4f11zKHZBbxfj7LDSHcW?=
 =?us-ascii?Q?drjM38QDtMF/9whKVLgrEmCfojvWFq1FLw+IiFe6gA5fCRLXZgK2AzC8tFMy?=
 =?us-ascii?Q?IS0VqmDWOYy7bs4796BSEFk+Wey7cpl4Qqs8Affy+iTGtAYaGi/1dtx9Ls9q?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e9900d-1125-42f6-dcc5-08dbb5ee4e33
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6991.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:18:52.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKZss7xBCD2OSL3HrRbL/el/9EIN9rYZYBKA5ZJpYNDpt3ULdxuEZYbiJfDV7XCZPiB+X+U+4Nfl4D1vbUcq3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

This Patch contains both MICP and MICS Unit testcases in a
single file[unit/test-micp.c].
Implemented Unit Test cases for Mandatory testcases as per
testspecs[MICS.TS.p0ed2.pdf & MICP.TS.p3.pdf].
All Unit Test cases are tested and all are Passed.
		
Thank you in advance for your review.
Thanks and regards,
Mahesh Vithal Talewad

maheshtalewad (1):
  unit/test-micp.c : MICP-MICS unit test case implementation

 Makefile.am      |   6 +
 unit/test-micp.c | 847 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 853 insertions(+)
 create mode 100644 unit/test-micp.c

-- 
2.34.1

