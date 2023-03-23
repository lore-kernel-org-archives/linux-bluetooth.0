Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F2CC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 22:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCWWRp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjCWWRl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 18:17:41 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846161F49A
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 15:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJwNxjF/rD9rb8pJm8r2WXvaoKDbR8OmkH4D8QxgnE3LmFKZwmc17Y7KYVvYog5w3uWrLipbD6AgWD5wVYlMNJg4ReewAgTknPgJeFqU3v/SUUrQAcf0rs3KU8CTIrsWVCE2J1RxBgfjqWsLsVQz27Dr1KPaGW4zejXo1AwWuIwik3REhzufH12Jt9XdzkwL7mTmh4ENaK8F1IutpuuHN3ZylkrCmoTLbKkxV8CGGL+vos/Vn4U7a21RBase9Rb/baNswstRsybE3ZyPftstFhRjNvVGj2H0JwNF4NlvtO2BW8iCrVNIvXZbihd9p4fZ1mYdRvGKNhNlvc+tdhAoOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zycP4GMGHa1TO0Obj8XtuxbFOk/DUNUoz7ItOy5ddsg=;
 b=fp5BqX8HmuIVVz8mi9vnoafFTXqJAS/F+mf1z1jpHbDyQdUYZEZXGeX33jedW5kbJNF/6PmU1SaiCXlIOc1v/zIEdlHkMlIDjMHJy8p9y7Qeqw6FjkvC+SAcGCSeGO59vIlofWHRq1y6MPGKm8G7EaZHVCPaA2MAeG1FN7WsmZMeou3ubBQX/V5F/Jvn6Yskdc+W7DWuHLTqBwkGNrra7XhbIslUcQsN1/CRrKdTd88MXPUdscb6BjVxmFci3HTvdiw/65QmGS+qdpv78bNJdVULrNTomlsBd5vW96d+kyyEJpWc11diu+jHEj1iJYoJyvIoNYLxlIkSzjrexlWzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=systech.com; dmarc=pass action=none header.from=systech.com;
 dkim=pass header.d=systech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=systech.com;
Received: from BYAPR20MB2664.namprd20.prod.outlook.com (2603:10b6:a03:fd::26)
 by IA1PR20MB5050.namprd20.prod.outlook.com (2603:10b6:208:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Thu, 23 Mar
 2023 22:17:33 +0000
Received: from BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::fb:1ffb:38fe:e0a0]) by BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::fb:1ffb:38fe:e0a0%6]) with mapi id 15.20.6222.010; Thu, 23 Mar 2023
 22:17:33 +0000
Message-ID: <cdb725d7-57e3-1759-6a4a-53a01dc8cd8b@systech.com>
Date:   Thu, 23 Mar 2023 15:17:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Jay Foster <jay.foster@systech.com>
Subject: [PATCH BlueZ] btmgmt: Fix typo in command help text
Organization: Systech Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To BYAPR20MB2664.namprd20.prod.outlook.com
 (2603:10b6:a03:fd::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2664:EE_|IA1PR20MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: d0819fda-92ec-4307-42b2-08db2bec661f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdYyitRYH98x+PgpkulFEPge3PVYyW2xruNBvp02iyTCsCYcXPAcDqsbSJ3hI6wOR6q36Wd10CYaKlu9TJ/8O4DLUDspJvuPtWWph/beZm2DRqDi40+Bj7eNowmXRfzaeiP1Nsf/cj1rLf/HDahjjaEaFgm514Sue0AdzirU4LizOJenjCooYcuc6U0NKWWtPK8fVswCFl8ynlBJSJRWRZ+WCF0oaxXkQy7DYrBnS0sy0Fata+TD6b0pJ5ICPDJCpVsXdsPUhGog9tr9vCGBBPnSwOHzSMETHqAdE3vBk7vqR8eJtC/nKdf34KY4ZOV8x8Gh0grvaePVrWSgQVB10ob7U1Xoxe4VZCixg98Q9gaJnRaEluSAP072pmqAsYGQOZsS5ndXVn0t5/69dQpsSskwQLyMQ0/18hHoUfJFcj8s3PZ1Hsy8hAixAQcdXpU9zKM7ZQCRjm0Hg5IcoXwuvO4PsSXiDwAoK6HzLjgAOq48e+0+TDnb8fMqLnm9shwSp51WAXeKRCwzwat8w16cM3xyFiu4dd1fD6+QRYESXyi2dy3UKfhtIaAE2uLnZWvaOmpqwDqRJXcJP2ErHOFlN5Lq2T4pw1I6jMme52wOmIkUerhOotRbGA0xfTgrpCFWMCsxGmKaeGDCHndgPOXlFkSiRxGSOE8AfVyC4wimlJbCYWIuGpcP4STOfJWSZDviBEPBj3h6ea2Ffw2YtuW+I/ey6AoqEuaDcZ4UVbLn0ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2664.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39840400004)(451199018)(478600001)(66476007)(8676002)(66556008)(66946007)(6916009)(5660300002)(44832011)(41300700001)(26005)(8936002)(53546011)(6666004)(6512007)(6506007)(186003)(316002)(36916002)(6486002)(83380400001)(86362001)(31696002)(36756003)(38100700002)(2906002)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjlMdG85cStPdzl0cHNwNk9aUXE2ak9uT0UyUUEzM1lIZUNPSUhaTi9ndVY4?=
 =?utf-8?B?Vkp4SkZCU1VEVHBYK1cyNC9VRTVUZm56Y1hobmlvNVpLODNPMDZkTnBvalRP?=
 =?utf-8?B?WFZaWlVsQVNOa3BUMGhoS3RjUFBZbGhsazNpYkt3MVJ3UTQrRGVxZW53OHNY?=
 =?utf-8?B?S3g1eW1jMTBEVjI4VGZsVkw2MlorTU95aldmRnN3anp1MnFGaXdNSGZySlNq?=
 =?utf-8?B?WEFPQzdFVjJVZjBCTDNTcVFkbExIS3loN3FNRHdtMGdLMjZ0VW4vdUYzN2ll?=
 =?utf-8?B?RzBLUTBlajBUZGN2am1RQSsvL1pnbk9aMllzTzBrU2YyeDhjK05kZFg0QU9r?=
 =?utf-8?B?blEyeXd0YnVRQWpReGFlSmRKaXo1S2tYdytQR2RsTkluRXlDdWsvSy92eXd0?=
 =?utf-8?B?TjJzeUU1U3lxZlYrNTBQMWZpc1BrQ1N5TkJtUSs2clBRL3JSNlgyUkNIcTBL?=
 =?utf-8?B?L1Ntbldyd2tleGdIS3lCZmxIYUc5dDI3SHVKQTNWU2VISTkzc2NlRW5LYnoz?=
 =?utf-8?B?WXJXRHdXS1J3eVJ4L1QzUTBUcFVYS2JJSG5XbXNIcU5Ebk4xRzRUMGhBdERH?=
 =?utf-8?B?Nzk5aHhGMnNxUzNFSHBudEVyWmhlYjNMRm5aVzZYMGFycTFjOUxSMzhxS1BB?=
 =?utf-8?B?TVVVRU5FQWx4azZXT1dXYUVmMDdWK0VzdUlZUnRWalA1K2hSVnRrR2ZDU3NV?=
 =?utf-8?B?RUhjTzBPVllkVzRZWDJrYUlnR3NNWEFWUFRrSCtXQmd0dFFRUU1ibnY2aWRI?=
 =?utf-8?B?S1lGMWNTclltU3pRdzYvWUZzeHZqMis2ZGlyQytvY1BqRllFZzRMUjRNWmcw?=
 =?utf-8?B?a0pvcVBMSUhVYk83R1NMSGFEQTZlUWZNVzVDUUV3dmY4OE5zYm5NK0JzeVFY?=
 =?utf-8?B?eXRkdWxJY3U3eHdrOXRYcWt5NStyb0h4RjBwRHZEUk56R08yODR4bTBtbzA5?=
 =?utf-8?B?anJPMXZEUGxQbjBEUGNGVEkxaVFhSVhSK2lwYldGRDJETVVpdmQ4N2N5OXlK?=
 =?utf-8?B?R2dBbFBnakJ4RXV1L1JOdTliWUxUcWJwVm5sZXNabkdSN0lqQ1VRME9EdzI3?=
 =?utf-8?B?eW1wa1JQcHd3amdFUkc4SVMxbWtEN25mV2ltYy9rcmppbjNnOXo1UjEwVzlE?=
 =?utf-8?B?a0xaQnZvc3VLOUtQVUMyeEUvbnFGakU1Q2s1bTJUYUZKRlR2b3dIcHJDbExQ?=
 =?utf-8?B?clRjZ2VaejFiL1RDZEl6M2ozQU5QZWxzcDFWVnF1QnVXUnFYMDlkQjZsZ2JW?=
 =?utf-8?B?OVdsczVRckdPMktNNzM1aWIzbFhNZ290Z3hYU3V2dmg0VmVPVnV5a3pWZU8r?=
 =?utf-8?B?NjNqMmFqZDlhWlJ6aU9OamUxQ05ZR0xxQlV2bVVYMHpqYS96SkpJQkhRbmF4?=
 =?utf-8?B?V1ZOQ294dllBZXMyN1MwMldLalptRExyUVRGZWRtSzU0Q0VGTHZPaVNLZ1Nh?=
 =?utf-8?B?VmgvTEpYeWU1NGlNUWlsVmZWaFNqRTNIQ1RzUnJNY1VPb2h0MEJwb3dyWUt0?=
 =?utf-8?B?ZmtBRTQ4QkxPaUZZc0ZGRTdnNUloYitRRGx1MkVIRi9vMVMwSEdoczN4WTRC?=
 =?utf-8?B?V1NQNXdiQzc5VENGLzhWRjhacVJFWmZVcmlOTFJscmxIWVd5NDd6OGp3azlI?=
 =?utf-8?B?STNjQllVcEpXMHh3WE8vamJPdVkzc0NzdVZRdlZpalF4MTd3NTJuMGxXN1p4?=
 =?utf-8?B?YTNnME5ETFVxWGRhT0ZGYkJLSWhBVklxWXltZ0FXeW9hV0QyemtoVE91ZTdy?=
 =?utf-8?B?SGtHWURJYXhkd21xbGVKM1NrY2R4eVIvdkZKR0VuNHlkaDdiVitXMC9qZW5i?=
 =?utf-8?B?d3krQTFSdnM5eTJhTDAxMXF6QVZZY21BeGUwUDJ6VEluSjV3ZXhnMzY4eTE3?=
 =?utf-8?B?cGdpek1oU3EvSiswMXRxTHA4OWllVUhxUUJKbkZNaHBrZWhTd1NWZEtTcjdH?=
 =?utf-8?B?blFXOHluREd0QjhxdjlkcUlLRU43N1dJYVZxek1aL29FV2tIalptVHdBaGJ5?=
 =?utf-8?B?QlhuZFhqaHFNb3VabjRoWWFQR3BNSXVJYWRvd216UndJQ3ZRNDhZZ1FXSkpK?=
 =?utf-8?B?QktVL1RncVRPb1pxS1dlNmhqWFVldXdKMFRXV0V3VTluNHZhS0s5Nno3bGpj?=
 =?utf-8?B?SWJUQ0FHWnhZM1VxeDFpL3U1a082L3B2MW5PRlNpWkZCZTZnWkZFRmRWQldq?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: systech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0819fda-92ec-4307-42b2-08db2bec661f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2664.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 22:17:33.1382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 47224f68-59f8-42cf-9b0c-62ae261b2df6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0yGrYnEWnY8U3AhmA0U0fUSALDvoY/RL3n0nOslyGI9y+UFQZxsGqOYaMD5qvoFhMKsCzCwSnCcW1BvDCCYpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB5050
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 From 040b97a6db691acfd8ac985b5b99a60343d8d8bc Mon Sep 17 00:00:00 2001
From: Jay Foster <jay.foster@systech.com>
Date: Thu, 23 Mar 2023 15:12:08 -0700
Subject: [PATCH] Fixed typos in btmgmt help text.

Signed-off-by: Jay Foster <jay.foster@systech.com>
---
  tools/btmgmt.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 323c267..1efbc75 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -5897,7 +5897,7 @@ static const struct bt_shell_menu main_menu = {
      { "ssp",        "<on/off>",
          cmd_ssp,        "Toggle SSP mode"        },
      { "sc",            "<on/off/only>",
-        cmd_sc,            "Toogle SC support"        },
+        cmd_sc,            "Toggle SC support"        },
      { "hs",            "<on/off>",
          cmd_hs,            "Toggle HS support"        },
      { "le",            "<on/off>",
@@ -5959,7 +5959,7 @@ static const struct bt_shell_menu main_menu = {
      { "ext-config",        "<on/off>",
          cmd_ext_config,        "External configuration"    },
      { "debug-keys",        "<on/off>",
-        cmd_debug_keys,        "Toogle debug keys"        },
+        cmd_debug_keys,        "Toggle debug keys"        },
      { "conn-info",        "[-t type] <remote address>",
          cmd_conn_info,        "Get connection information"    },
      { "io-cap",        "<cap>",
-- 
2.5.5

