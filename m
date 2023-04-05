Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6587C76188
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 11:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbjDELrJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbjDELrH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 07:47:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E14EF3
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 04:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQcBc12YDThIzKLcrQViA0Uvg3KwO2udl4kChR90kwz59gbRpKd3ZNQI7XdPpK4xtv/5drP2LiId8Zb8KjyulnMOfnU41TwMRM+zIlxjsng1P1OTYDFj5q2I2TvIAC7RmZArekqpzfwcPUiKz/9pPmQE/KEbfBZsSksLA4m+8EvFIIQ9s4VNwSqqF/YJrERBtgw8CZRitFFK+R7zpxFaWI+DgxLLY3p0oHGeb0Tijp2A/Dyw7Z1+L0cN9E1P1FzH1qxjMH6VXHWoVml6ZhCOh9Zd6geg4Y3AUAJq1LDC+efv3pJV2s7Tc958pRBk+uMyIGTpg1xTkEya2VP3zteWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuTjuYurmda1nCXFsZ3tU5xPBKWue+0jGPmCZ9afL3c=;
 b=CRjPS4RXcIA4uS21nrG6tSePb37N6chW03f0RHEdbsFp8WRnsHhdINCN7n294Nmmt4iEZtmg+20pCQZTm7Sr4A0/KNGx8tVi6Wjd/Mm6CApKiFwdhGqQQOOH9Ug54hakOlLEo6qjr7m966/mVItgPxpQ9+CIU5KIk9hyblK9xHYuT83KkApCdEV+S4h7w8UKXKJudPDCMBD2nPa8VmXHhr29IkaiYnraLN2RGbZylX/6O5KDEe/CzoJF+rNZQNdr/ACcqsli0hctRTvKFCfHecO8vEhoaM8x/80MdYDRrC1+o4dqp8bD12xWFjuDqRhQjRCqID19QXv2vqyrUvsxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuTjuYurmda1nCXFsZ3tU5xPBKWue+0jGPmCZ9afL3c=;
 b=DR70aq/z3slMZOaPXPvI7eY3hiTSNnd4lKkEFqlBPIHFRNva8X6UNN6WzOfvvnngOYAwJWz2MeQFB3fpyQTQQxUaGQUwu5hxDAZfnXK4cWnfuK2EmnZ8PcPt50C9tLumtReKZT7IDYqT4HZs5Pgds7Yl2FFHslAIBhIb1lbD8QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7447.eurprd04.prod.outlook.com (2603:10a6:10:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Wed, 5 Apr
 2023 11:46:55 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 11:46:55 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/1] monitor/att: Add decoding support for BASS
Date:   Wed,  5 Apr 2023 14:46:42 +0300
Message-Id: <20230405114642.14823-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZK7_SCq4hN27GjV1i=TxN3DLfy0+nrMLN3ZwP99AqL76A@mail.gmail.com>
References: <CABBYNZK7_SCq4hN27GjV1i=TxN3DLfy0+nrMLN3ZwP99AqL76A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0061.eurprd07.prod.outlook.com
 (2603:10a6:207:4::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d93977-b7b9-469b-7222-08db35cb746d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJ//b2CRJ2DR35EHP+fQouKygJLVno+HRbNQ3HnWvJVYIGqriizSQUU3UX7zGouepoZ8dCTHy4481eNuCh8Q0zHSnvsyI7SKQxJMaLkgejqsakrHyreOVqjGJ4Vu9j4coYE6ulmHO80/TnnVb2nq30KVGsmzJ+sEw2TDSJc1HzWwm3X3eehK2kzg+ai6nDaBboedqAgXzbxE5/zLzCpgwyxLhJMEgngJBkn11HgngiBil3ozNw9UFbX0vk+xq9sBnZYL74uPb0FW05kSgTt42Gqcz7T8cLpqUf1QFOxR4IbMq8Lh6mMu9ejsZj4V0yzsIO4vobGHBqsEaT3AD7BP9mQKyuGkUyOnfJZNysj9RCsZHrW5K7OjtVCUxJGxp+wkwafw7U3AWDsqMGR1/VbTsYMN/z2QNNCJG7/Y609azyzSy4n/MK1EyL8iGixmcu4bxj9X85BKyQ3wREBqkivCETgjfJhD/TDxliFnCy83MVfAti+skJDsWXSa9nN/jM2itPoSpByYady80MWI0ghbODaIe+5p0qPvlTl2ryhzGhxso9E8zJ4YRuTNuEO/O2sMdR2S5vF2bN+0c3e4qdbqD84AhMm59Tm7ATum+EkeTlCftXkkqy6aIkjNj8hqxk6v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199021)(2616005)(6486002)(6506007)(52116002)(478600001)(4270600006)(316002)(26005)(6666004)(1076003)(186003)(6512007)(55236004)(19618925003)(44832011)(558084003)(38100700002)(36756003)(5660300002)(38350700002)(4326008)(2906002)(6916009)(41300700001)(66476007)(8676002)(86362001)(8936002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fp5qDJyENllJ8dyQOHZgVsJMobkwf5ZIKIZOsWU72NAwdb4KnefR261NyrTL?=
 =?us-ascii?Q?ipxQv/xoAuuZUfH/RU9nR5n5ZuIV4m1Ebpfn6uTBBrpeZwsnSiKpCtM7/wD9?=
 =?us-ascii?Q?bnJWh7M7D162l5P8n42xNUuwhGxF6EDFyEhHYt4zeLSY9GBFwn6f9sSlcs66?=
 =?us-ascii?Q?W1K6bu68QGcKYh1G7SjduBLpNMrDVWl2mZlh2SunkuR4gkJ8f6AhVn/bFzk2?=
 =?us-ascii?Q?gwZjICQ+SID2NVLL38YjiWBk5jp8RD+GghDKW87pV2ypN+oQMATTUlHdrYhh?=
 =?us-ascii?Q?EzIdi65pRxHpG4Rp/eMMhOFLeqsAtEoly5yTSNTaIgQOUC8+RUG2cR2T5Lsh?=
 =?us-ascii?Q?s37kQ3bV4bP9dNHz6SK7luv9D8AcS2wqlEH8N2y3ArzXvt4H0C1n5Kxq94ec?=
 =?us-ascii?Q?5f6JguGXyaEabJWGeMS1+ll84ZJR7kRZloNTHXLYbDNQYh/qi6V+jjkFsrDu?=
 =?us-ascii?Q?fKY9EpW5u05SV/zmZw294Y3TVGKRiIWsW9z9hqZvynFas5pdFJr3opD34tC1?=
 =?us-ascii?Q?0SU8sq3Dh3dU6St4cJOh4iGUkLqT4GwY3AlAvGcc0lSIEDdtx9gZPXkx0SnW?=
 =?us-ascii?Q?GJHbQzx4TJSx0pDRVJqjRgJJ1Y7dZKeh32JlUXzRRQSbfjx9me0I3i7UDPFd?=
 =?us-ascii?Q?2Jy0aJjipZq+abA5VdKL/E4Fvave+lwxyfNR2DJlL5j5WZa5gi0chW0OEZgw?=
 =?us-ascii?Q?OSwTcleDJr5bD/LgfDjxRC5ANj6PeeUKY09gRUmYPYIEQ2oiFdI7Nxg9xR83?=
 =?us-ascii?Q?TUCsBKXWplNt18F/j0yggb9J0d4gHNu93jCITDRJJAs2zw0EuceM0nZIPYSp?=
 =?us-ascii?Q?UkwLJaKtM2Ha+8XPa9rMupoSgvUEm8l8p+uI3VkYPLhA/jbRFcSb48vA8pPg?=
 =?us-ascii?Q?0nijlmiORmG5//govpcAjp5c+SsHg15ise35JhJvZ0j6NIpBk/hUAtFR2S6P?=
 =?us-ascii?Q?3kzaXlunQksD8Bb5VPB6g2f0F/9UY/EMjdnoJicdQM/03v5RKBU+oqTBZh+s?=
 =?us-ascii?Q?pnq8clBec5XJTfKQMHKWlwVhdwBSXGugRCE28gYzMJHtK6UC4iRxzBt6zXDZ?=
 =?us-ascii?Q?5fTR3ltYp2dyJPMeujMl8U0+fHk0RZDo34N8E8Xtt19qHclaZYzgonM2bwLy?=
 =?us-ascii?Q?lOLfMPki6cvIIRU3eZ+RclN2BHP39S4Jo5P5TIJPSv4VbQpFWaHMREXwyNUu?=
 =?us-ascii?Q?iq/KcpMhwZKUcPx1v5Ax1hNHdM6OS4H5HOrAr35ANwrpxrPZ7NUBCE4EYRIB?=
 =?us-ascii?Q?9VEAQFwfYkDb1mVB9HpXPxBicAA8ace5/LB2bv3vqOeNWXToaRwgAf7KLth9?=
 =?us-ascii?Q?eLLS5IAt+4j6APNc7HJhR6qUbp4PBGdwbiOCorQufks+WFMQ3794hSLU6vSX?=
 =?us-ascii?Q?EHjQAoq0jA2dS2Fcvbv96nOY9TzMPLD4OQtGMzBlwc3s3MZ8pc4aF6eRK1ES?=
 =?us-ascii?Q?XPAKnLXlhxmtTjRitHMLh81n0Qsw7bpMokGlnzHnAs4QgPBPohv+brYmJG09?=
 =?us-ascii?Q?QqztX+QNHjP1ErFgd5QTiLNzlA+kUR7JheuMNSaxQChnzr0JWM5mL0WTVNyu?=
 =?us-ascii?Q?Qc+71uTBhTk5LBZRNxRHiIqs47Ns/1eXG7X78cASbyGD6DaGl5zDoTde8Mfr?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d93977-b7b9-469b-7222-08db35cb746d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 11:46:55.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT6UAkXWI+qkfMBpulrjgAunBXyX8LWC+PIKAeQFbvC8MRjMvh9qrnR8SuCxdzJYQzLzNgWbGYHfk12vTAJJYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7447
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you, I resubmitted the patch.

Regards,
Iulia

