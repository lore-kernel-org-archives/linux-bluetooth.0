Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F83CD8CA5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 15:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjJJPjN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjJJPjM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 11:39:12 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A4397
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 08:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMyhav33Qa6f2kZdVKA2YaPCUq3g5VPHukxLDL1FSFtva4XhV2m3T5JADon4IuMHGVQzLnvklAnYv7Xq4T9p5DZaYPIGpsI3rUDcb7uD93sLKjlXYz7KWvfKyrUpWESXdBKPMVQa2gcFb7wtPslJvU0lxJa+v5oLqVsS+JgKonfSWKKgXJRtqZSSzTMVnlz1H3Sq8EbvsMqfXfeCFEb0CvGJS1usWcB9e/5/loqwPn/g1egpWK6G8ry0gGe7AOG6CNjQqHg0C/F8yfDReRARXLLIoL2gYr5MZ66ZyEXQspssp9HvpYXw0c7IV/VMruVYu9cGX7YvrleZ5RlGSk+qVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4SNvxbyABZJ2GbfFfHCmgVXXGb+MWFM9Pw1f0hN4IA=;
 b=Uv3thGTX35FMuOzuXOm/s9ju26SUGhMI8dsdArQuPeGNOskmhuCSKBgpPwVk/AfOad/gC5VOVtVE7gQUq1MdjSKy51Bpq+gqL1PrX6gtvn+T4oki3dc5eCthF0yXsNSYRPF651cXGFsHqXR2F1vYifGExaCEkwAfunjbDxwxyAyDp2Ht0qb3Dj8u8VsGChYQb8N2bpW1cJzNbCmCGtjTKMyUQgAlPGMRfpPVaLMKDlIhKgUiOdtv9ip9ECAuIua72TIh7SskiFWIbq74BT/7SKdMG9s6RXlcXAF8aIm1O6nEHet3AJqfm2Cf3j8zNVSYkTkeENYYcL25JKWqe+iWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4SNvxbyABZJ2GbfFfHCmgVXXGb+MWFM9Pw1f0hN4IA=;
 b=ChcGNRle4wsiafUrYqX3K9jF+PcnRRUj+g2Yno2jJ4ow87gol4Jg+Q3e6h1+VCkEgmLBFRLQmW6NsOFwbefWhDeJUtFlDxwVao96Lv24x0ack9kcJs7sFCwaNOkz14kc37R2jcMN56qxzS88k+dJVIN7cxk2jxo4RoV6LArPktA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9437.eurprd04.prod.outlook.com (2603:10a6:102:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:39:07 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:39:07 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] test-bass: Add unit tests for the SPE suite
Date:   Tue, 10 Oct 2023 18:38:54 +0300
Message-Id: <20231010153855.13825-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a0cf9f-9990-4e21-810d-08dbc9a70a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/7fBhJpvFrey/k7svT5r88VgxarlCVl/QSNY/FKVyLfgbpdsyAIeYmq8kj+J4w5yK3MLPGxJIV1lDMB/HcR7F6HLDnUNKjI3a8zDy0lnYZXl09LDVdu0y5H3Nuptd7IE3xsknu8RLu9uZdDQVc93gjdzBTUVWgdsEelKuKTkHDzc5d+CVwb9xe02B+JRzpZ9Eey46MiA5kCpexw+RHcISE9WVHvg34SCElcW/+hu9pQYTfS5ACOoAVfYvp3YcMbutP7QaD9yXB5IlBukvrzmgaL1oo9YMv2qE/yAZYVKg9LJH5Qto0F3haJv9Gxz89NlvclaFtacQ4MbE1LDbt9NuIWARkJO4UOnDrZIdx4S2Va++MO4BLbrlPcTo3xI3p1UnmdY0c8E/RUJQNPDdFjYMYLiyW9YfUQ9aaIyIGTSXG0R8lELGubqFn15ek0DaVSUnUnjG6BzLmFidKXPKPgeVhwhZ9VvZtNGv3HspfrBIUka01n3kvWlpWvokLH8h1zT3ubeJXu3v6ghbh3SQllfvV/I30lbucDL72SxrLsQsMpJEK26gdhj4X5eCKrET0z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(4744005)(6512007)(86362001)(1076003)(2616005)(6666004)(6506007)(478600001)(36756003)(38100700002)(26005)(83380400001)(6486002)(41300700001)(5660300002)(44832011)(66476007)(66556008)(66946007)(316002)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VRCdx9/SWkUuFUnVWr7UWe7CRZpArTbkPytStvtfODADS2VhHblViF7X4CBb?=
 =?us-ascii?Q?VWTCY5lGZZ+APPZTSo+WaCK8G/1xSUTOIQk/m/I8r1SBgTht9mOVARu0gDsp?=
 =?us-ascii?Q?u7LecxfcdCFIFAtcZRCuGe/+HvMC3xKuDxIAcOlVioSKbWlaeNIQM3B5HIWP?=
 =?us-ascii?Q?wRIQ+f4PNCfvoggBVjXrC0IA6QPw7H+KYtKHIguK9c7/9T/T8ezDCmJevc5U?=
 =?us-ascii?Q?figWrausBfejk5bL+uvOiSj5v2nCIN9ftmSGqqzWwe5eyBaN/pPMImzTZsYT?=
 =?us-ascii?Q?z5pZ4n0jyPUysQKlvtolDoW3PXBQmPJ4s0GjpOwoMGF/z2HY9RCmQsrSvDGZ?=
 =?us-ascii?Q?t51bF8a15uRy1ZNDnC6c7TViHg4tIk4DeoKYSi1/KOnZXt5CRXRzOHytgElp?=
 =?us-ascii?Q?m50XdlwQHrZWQYxPhOXmDyBh8ahVRP2v3DBlDHhRDKnGhPTN0+0E6gwqt+hn?=
 =?us-ascii?Q?hCNypBgYpmSGRDoQ07e+f9rAEHKeCtdApf8hF0N/j46fqNR81zpbNI/HPgEe?=
 =?us-ascii?Q?Wxqwhan4FJfkGnCNIdK3umLHOZFXDDYJkcA01mYjnQcWfhKFZcJbTUWFXA/A?=
 =?us-ascii?Q?E6A8ulEJ9Yxl+kLP8w5e7BgTOtTGh13r5zxPNwbrmyIbe1Ow75WmrM5mmzEG?=
 =?us-ascii?Q?C2CWHhbyTCMG4NLedWkQ6bHxKcLqqg6osH8ZcrY9cs3Fai7ozoZc2q2oyRFt?=
 =?us-ascii?Q?N1/1mMjq0B0MfuE0rJf0CLdYZAPTjhbduitBgVn8Es9dG2TzfSGyZtqz+N6B?=
 =?us-ascii?Q?Ph/1mwMlL12SjAn4sS3tVGK0iSH/B/OHdgfvj6NFW8deHHi/qS29Zf2eKOs8?=
 =?us-ascii?Q?/NhhQoXUPz7yu6TqPCAZbjV9rdtRgOVG4Y13d8bfbN5CMPcL5/cegfd6NHn2?=
 =?us-ascii?Q?Ik3l7t7VzXlSo8y0pmpekH+0GP0LKpGtrF/nreQG1WIKsDUivDMom6i9New0?=
 =?us-ascii?Q?2k/yDdflZLShx545tTIoOqBQMYkgAvhWqz5xaQ4FPAeC44jOlPkFYdmf/tI9?=
 =?us-ascii?Q?PTRbs7k5yzqAM0/4gZNCXGJG6K632Pg64+jTSGingzKjymCrSbbiY1Rlyeg5?=
 =?us-ascii?Q?JRVpB1hqB187d30GhXCTzbjn+f/STBFxDPwDzYPkd4Q21N8pKUtj1EJduvm4?=
 =?us-ascii?Q?we4uQHDDi/OmjXR1P+RnpkCHrvlbErl2yTP/AGk/O535MGSd6KcLfqn0N0tT?=
 =?us-ascii?Q?rwDUyetZiKpToCFRB6OMNXxiRaV9dUTkMy0cYHJyAaSLkg4VGfpI80AtHYnx?=
 =?us-ascii?Q?YmQIVEsERyZ4P2lfV1rF6eeb5WZGgzQhu4OLegdIn3EfS6YoVlHXCXH6P/0U?=
 =?us-ascii?Q?gffsevyeKnIxqtBXNksW2szTVtPS/mVlMdSvCEypMsMn5p/LTuh5TywIpx67?=
 =?us-ascii?Q?v1dalC0+gcJpdakbkWD5LUcIT+hruDA98nE4ecaTwlR4tuulznIxSjjEEr3g?=
 =?us-ascii?Q?+lWOdUYjBbLoEQc5p0Q1W79FtnzNfUfU4QjJdUA3lLoCZgsempycxheeSPOJ?=
 =?us-ascii?Q?5b0UWHVUAvMS8b03wtNVypjtlA8kTzOuhYwvcLOTgihdJVxUoqmQoErgpFkJ?=
 =?us-ascii?Q?OERLijEj1WdhfaA7iHArsIbk3ubvqSB5wv3sZhQlunj8sjp0Da04G1oeKmmF?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a0cf9f-9990-4e21-810d-08dbc9a70a6c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:39:07.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NY425qNiBbIC34tiJIlSeeySIBt1T95z/S590c9Qy4OdfIy0PVvYN/uiHrx/Ghyjn2ZDh6taTF8A3oXQgIOXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9437
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds BASS unit tests for the Service Procedures Error
Handling suite.

Iulia Tanasescu (1):
  test-bass: Add unit tests for the SPE suite

 unit/test-bass.c | 430 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 428 insertions(+), 2 deletions(-)


base-commit: d4a0d223eaa5d220263be1f3ad0cd396869f6245
-- 
2.39.2

