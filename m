Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EA4C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCWVIF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWVID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 17:08:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2494D3C13
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjLhOjyJDpy0Xb339CK8YaXZlzkqA3S4z0JUBW+TR9VcqLfJ/gXXjRdmDtVmeF46aiVNpyKwbsVeN5AyGC88tNfOl1cBEGfIWM3I/bA3XdzRYxbC6zsx1dl8Iva+M/kpdNG66sjqWtWH2CIwS+HAKlVCRQppbex130bP5CUgXegpID1mjWEj1CWAyW4bvL01pP4c1yc0376KqxZwmJBTxsra5WgqKhVZBtMzrImO/HrfFI6XYjsd//35ZNCWus1wHSwjsmUs+IAzm07N148JiJvzitFPzDLTKhV/z0QVoBD6gxAjcIaQy/HcF5r95NScsOzIsDIAzJBr5WF2aMQCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHsgoy4HRE2rAdCEFbau+JD6dVCTP6cxZgDYffOI6Q4=;
 b=Y4PYsfTePC+wXJ9Z68xZBgELNA5wWLb1bETB2HSrEHQNwJcxQmUXNAEIe59c+XuoJtExNi7TilYASc9gsmcDJDKvD80wJPbFIZrO2xtAj84oxiWnefTlPGL7pj1BP81DTJ51nBAgTEwtun2XKogvCeLInrV5IDTHR9qyGyUozBpiB67uSyG84NLK5yyrXoX3J08bio+lEYEzNgkl8n/DqQEM21KANRmV2hdPuv6vfj5BqTiPE1Wl9XSQiaJ+3+SJah9iEMSfDQkh9RdDh8GrKJ1i5mo4+VCfO9jVJbTJ3mdLMZsXUfQtFGBtZImzrR0FdX31NB+3zCuQ/aKXlNGRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=systech.com; dmarc=pass action=none header.from=systech.com;
 dkim=pass header.d=systech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=systech.com;
Received: from BYAPR20MB2664.namprd20.prod.outlook.com (2603:10b6:a03:fd::26)
 by IA0PR20MB5635.namprd20.prod.outlook.com (2603:10b6:208:43d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Thu, 23 Mar
 2023 21:07:55 +0000
Received: from BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::fb:1ffb:38fe:e0a0]) by BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::fb:1ffb:38fe:e0a0%6]) with mapi id 15.20.6222.010; Thu, 23 Mar 2023
 21:07:55 +0000
Message-ID: <e74f4f62-ff59-b2a3-47d9-2b3edad9265f@systech.com>
Date:   Thu, 23 Mar 2023 14:07:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Jay Foster <jay.foster@systech.com>
Subject: [PATCH BlueZ] btmgmt: Fix typo in command help text
Organization: Systech Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To BYAPR20MB2664.namprd20.prod.outlook.com
 (2603:10b6:a03:fd::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2664:EE_|IA0PR20MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d11112-1c0a-4bc4-9042-08db2be2abcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/8BDG7cAiR4JN24lEh0Ay2EZ3DX1vyHQ1L0Qi1nNy7UTJ62NjkiLTdelC6cH4Oq2ilD8nWyh0ULl40KKHpjLKyF14xJI7rTeVBfisSYSFYBsfYr93H+Ymoqp4uCgSeIfoxAH45YM9xbg6j788ZHpPXO3zvPjSsM5fpyusYwVyDbcvhbvEFV1chs5RnEPm4RAcEap2CXtaG83wElNyyxR97Zyd94KUx02P/mx4LlSyawiP0SJ6Zgi6BQF+mQ/criUfFjrDQGHS8/AowRk2YeYkfBDmp9CKGiwqK9t4h763z18KosRJSr5TrGgtRBQ1wBKNacu0J3uJW3qBW/CVO0/eYu5OW6wzODbCUwn2fsVt6ti/MNGIUG9+kOS/uAZnzbiXqP7T1BvP02El08/BtA9JtQ5K7E8T3cUZR8LvSERy7ri1dJZCymOBymezQJfDMgibOlkRXQ2/nTxL0pamqX2absQaFVmIRm6CrMVRUOBG3y2RcY798daN30lkMc1RoliW6GHOaA0kc7dKWvv///TJ82aduGhaGBT6gk5R3jWjmP3y6i69SPHm/AM/Ke+qJglRoYci6Kua5iifc3qvbVtfQ1kmB4dC9+mOXwEy1wE3wWlQrmbjj51cqe5Rpkm0lYb7QdyR37CCEwsI33XCgrRtdCHuxV4yRIz20y9xMHdumVxz5giB47aKhSYbK8wy0df0M4gjay3IbycIHaEshwRxjWjhtPsiawUfdiojLpQYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2664.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(39840400004)(366004)(376002)(451199018)(38100700002)(478600001)(6512007)(6486002)(44832011)(4744005)(5660300002)(6666004)(186003)(31696002)(86362001)(26005)(36756003)(36916002)(6506007)(2906002)(8936002)(2616005)(8676002)(6916009)(66556008)(66476007)(66946007)(316002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRQaUk0ajRwZzJHVkVXdkN2cmg2bXFOelo3cUlyU0piNk9JTEhUbUJORFFS?=
 =?utf-8?B?Y2U1WHpjYVNyQUoxZmhFVVZlK0JERTdSbVNMdkd2bUlHSm9ZK3VKNExvcmFL?=
 =?utf-8?B?TGlySTdsNjRab3Iwb2xGYVJBZWhFVHpqMGM4RVBaQVRCaDN0NWxGMmwzQlNM?=
 =?utf-8?B?eWs1VFA4MEhQa2EvTkVtb2VOVHU3MEhIQWRpK2NEZ2JYT3RnNEpvKzdld3VM?=
 =?utf-8?B?U3htOUtqOWVMM3VyVStoTzdWeEd2TjRKRzhhdmRvQWRtN0VJNVYyZEo5TEdo?=
 =?utf-8?B?czMxdGU1SEdUaTBBQWYzUCsxcjE2ZGZvSlJDNHFJSzdXR2I0WURoTFZnNWxF?=
 =?utf-8?B?ZlJSZW9EOUZHL2lhY2k2akw4RG1VTTdFd1RDNkdFbHRFQzYwTkN5MGhkME9M?=
 =?utf-8?B?ckZIenhhM0Rtdkh2dE1pMWFNcU9kMjJsSVVneWt6OGFwWm9pbnBCOUtwblFI?=
 =?utf-8?B?Z3JveGhzTXRVMEs4UDVNQm5ZbUZQZXdPR3o0cEJpR1RVcUpQenJKUlNrajZv?=
 =?utf-8?B?Z0IvYTRERXJoVjZodit4ckdHdG5JUy9pb2U2VHNKeDU5SlhDdm5VckdjdVFN?=
 =?utf-8?B?VXJiUjBoZTJMb0RUQXExb3dtWlBuZk1aaFJDSmNSSEJIQzUyMWVyRW9uYU5q?=
 =?utf-8?B?cmh1QVRqZlRCMVFJcWlMNW9td1BKTC9MSVFyS0FUenhuNk5lejFFZEdabXgw?=
 =?utf-8?B?U1dJOEYzY2pOYkh3OWlkNmRVL3JNZ3dGeFN3UG1lb2tpV3g0Z2FsQUdwWkY3?=
 =?utf-8?B?RU42M2xJbVVuQ1R3ejJMMGVySlVFQVNBMjg1VHFhRmRMN0IrTVUxb1ZJOFl2?=
 =?utf-8?B?eDVZYjZOaEY3UWNYaTZVNnY3UGxGL0YvVXBZOFNPVEVlZGIzeUVscmdVTm81?=
 =?utf-8?B?Q0FqTzk4WTJsOStpQis3VzNsKzBOR284RnNTSVpEckxUMEN0NHQrdFZpVC9U?=
 =?utf-8?B?cHYwTkJQdlUyTTdYRXhpUzI1MUorT3NDbjVXaWoyU3lPU3VCdjBQaHZYRU5D?=
 =?utf-8?B?NTlsaXZHdCtRYnBRQ0l2cThCN2RML0pnM2dLWmVMZlg2M3E1V3FCVnpqSzA3?=
 =?utf-8?B?bnVRUGpwMVFOblU3K3RXY3BaNWtvdUFSa0d3K3FwOEMreDRVYU5ld2dFKytW?=
 =?utf-8?B?WlBZV0N2Vk8vYmxIM0Vxc2hBL3BhYys0dlNwcGNieTdEU0s4aVYrZG5LWXVE?=
 =?utf-8?B?cjlNbzZkYkJKWVp2NW0xMjRXN0FCSWdpNHp3U1BPSm9tQ1JNc2F1cS9SVXYr?=
 =?utf-8?B?c3RiNXlVVFB3RHMyOWpaV09tY0lZbzVmL1JqbTQwbG50aERJY0RMK1ViMUo4?=
 =?utf-8?B?Q09yUzBhb1ZzUG4zUDB5TDNZQmM5Y1RMbVFId2ZRdTFKV0QvZkxGZDF2K0Fi?=
 =?utf-8?B?clBjSnhFZVhFV05WSDRSWEY5S1FLSmloNGMzNXpwazQ5ZEgxY1VoV2hhbCtp?=
 =?utf-8?B?R1VhNmJ1Ry8vOFpwNWlBdG03Q0Ixd0ltSkZnQ2JpQUpFeWozYW42V0RUYWZy?=
 =?utf-8?B?WG5ROE1LRDBSWjBXVTRoOC9rdFNvazdDMVNLSFJHcEIxV3ZkRW5JY0cvb1BF?=
 =?utf-8?B?M09LdHNLWDlONW1WS0RvUENVNC9SNVphZDMveGg3b0VYL1lwUnRHT0dBR3NT?=
 =?utf-8?B?SExsKzFrNHAvbW1hQVJUclk5VWw3VmZZS25aTW5lc0RHY2hSZWtkTlNKR0hq?=
 =?utf-8?B?RVJHOHd6SCsrYkZ3VUxPOXFLYUF6L29ld1l6eUNSMlFTYWExcmQ5cWJJSFQ4?=
 =?utf-8?B?OGZiT3NBbUM4Zk5HS1VEaWtFRlUwMXZaS3JZakNCeUZIaTVkVjNjaVVHWG5p?=
 =?utf-8?B?c3lXeFFZZmRibHRRb2x4OXJtVGhXeDQyU0VnM1U0SkpQZmhxcitCVkVWSElv?=
 =?utf-8?B?TlorVlNtWUh5aWl5OTVsSmVQdGhMay9OWmhseTRzVTJTM2xCMVVrM3ZKa0M0?=
 =?utf-8?B?bXhZZkdUVUJaNFY2c2c1ckZHalcyZWs5bmVsQ2RudzQrczVYUkE4dlpvMzU3?=
 =?utf-8?B?TGtSWFZ5TmtGTUcyT2l4WjVlaWRITVdiYVhIZ2JsUXN0cHhldHY1WkhCZHZP?=
 =?utf-8?B?bmgyeDZURGYrcVhtOVNyT0NwSjY4eHlnWlNidTM4c1Fvc0ZCL0Q1RGZVOXh2?=
 =?utf-8?B?TlYrV1ZyMU1HL3UrRkJVT2tySHh4aHJCRVBOMG43aGJNK3Jqc01KVzFJVjZ4?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: systech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d11112-1c0a-4bc4-9042-08db2be2abcd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2664.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:07:55.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 47224f68-59f8-42cf-9b0c-62ae261b2df6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uLpQtwDeNr3npeBTUofDxurBw1BTXsUBro2UpQNGok+D/nX7agjoOHO03cGTOoB4NNWedqETt/6ybJ8cm//8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5635
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jay Foster <jay.foster@systech.com>

Fix a couple of typos in the btmgmt command help text.

Signed-off-by: Jay Foster <jay.foster@systech.com>
---
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 323c267..1efbc75 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -5897,7 +5897,7 @@ static const struct bt_shell_menu main_menu = {
      { "ssp",        "<on/off>",
          cmd_ssp,        "Toggle SSP mode"        },
      { "sc",            "<on/off/only>",
-        cmd_sc,            "Toogle SC support"        },
+        cmd_sc,            "Toggle SC support"        },
      { "hs",            "<on/off>",
          cmd_hs,            "Toggle HS support"        },
      { "le",            "<on/off>",
@@ -5959,7 +5959,7 @@ static const struct bt_shell_menu main_menu = {
      { "ext-config",        "<on/off>",
          cmd_ext_config,        "External configuration"    },
      { "debug-keys",        "<on/off>",
-        cmd_debug_keys,        "Toogle debug keys"        },
+        cmd_debug_keys,        "Toggle debug keys"        },
      { "conn-info",        "[-t type] <remote address>",
          cmd_conn_info,        "Get connection information"    },
      { "io-cap",        "<cap>",
--
2.5.5
