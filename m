Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD8BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9CE61178
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 15:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhKJPtx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 10:49:53 -0500
Received: from mail-dm6nam08on2051.outbound.protection.outlook.com ([40.107.102.51]:20993
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231795AbhKJPtx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 10:49:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e51qfhElCfWdTaJKXtoweObpQKPJjJP8u8krdWMvPfpQrGqtcG5Gwm+oAmbxPeRjd3icl5MD2WOP7LKzls38zRKIsNiU3nJ55s96BJyLopm0vanMVTuzDRGR+wqxlevoXSiL9BI2pDKdHmq5YYkLRDgsTg9WHCc0uoYzg/MvVxHJ2vVPozmOHqUVBHqLYtkKWG0CxicpPCBJm2WIFq3oUp+4P/Exmkw5JykanLd0KHNOGbjnn//4UlGvlKYasKIxKZMmAB5JOXNTWpDjxK4KPVPtBIVwdMGOf+wZcKYWMICiwA4qrTZb8kW8hIFrlDPtiNLjn2GVMvWzOE1bQNR6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWoZ8Up9u1H1hbiO+UfV+SknCnKWMpP8NtrP8OzeNSM=;
 b=lX/3MGHucN13oQFFN/32MORH+dVE/dKL9NzjNE9slHGT13HW73il19jADhy9jLYj8z+9PelZFhvAeYlWtSbg1Z9iA1F4t6t6vDmas9XP4ASlGN09iHbVV5D0koLfEQ2/fO6tD12kOkfkHUQBOzXE4VZdJ+SzCBPy11a7uAhFlm8KZD3FPj77c+SJxoux6SqMeXXE/ZPt8ci+KScQWPQRiR/QBS0rgMYHjSywik3UJi6MWBURiTFh/9pn9JaxIEY0VtUJ7jlXJENhxtXFNs5D3jbMH2XQ6g60998r5FKZMXQKo9YfDDo3/c0TWTm00nP75k4Qre/VAt72MD6hY2iV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=systech.com; dmarc=pass action=none header.from=systech.com;
 dkim=pass header.d=systech.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=systech.com;
Received: from BYAPR20MB2664.namprd20.prod.outlook.com (2603:10b6:a03:fd::26)
 by BYAPR20MB2247.namprd20.prod.outlook.com (2603:10b6:a03:159::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 15:46:58 +0000
Received: from BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::ec43:56a9:6f54:d0be]) by BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::ec43:56a9:6f54:d0be%3]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 15:46:58 +0000
Message-ID: <f657c955-2a04-d6ae-cc10-3b0476a33fa3@systech.com>
Date:   Wed, 10 Nov 2021 07:46:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Jay Foster <jay.foster@systech.com>
From:   Jay Foster <jay.foster@systech.com>
Organization: Systech Corporation
Subject: BlueZ hciconfig: Segmentation Fault
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To BYAPR20MB2664.namprd20.prod.outlook.com
 (2603:10b6:a03:fd::26)
MIME-Version: 1.0
Received: from [172.16.4.182] (70.167.11.34) by SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 15:46:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db6c878-2fa0-46ad-0153-08d9a46153d0
X-MS-TrafficTypeDiagnostic: BYAPR20MB2247:
X-Microsoft-Antispam-PRVS: <BYAPR20MB22477081122EA4CB3A9938AB93939@BYAPR20MB2247.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BPtYi0K/6X9FDPEUpjZh4/U4aStEAhAl9kT/aPe/nsl+F2eQgqnZ/l4MSFKIyqVTVw0+UIlRoY98AZfzalRbO987Gxir7xZsYWOhLOWAxuB/HuC9qYv1A9ly5pBhuBR8WsFIfV3skGNvlJoMr4E1hfvh8l+mSuUyHwzmAc5bHnxUdbNjI9Yh1pkuhm2BKGgPGpaI83Cc2fNeYDPFkYzxCASBPpG6LS7d/RblvtSPm5br91AP8y4qUkdph/iwdyqCxCf8q8sMxQTY2mUrFVzamBcaG2EHGJ/dRzF7LOLkOUjsk/ONbb4Cm1bI6Y//64mJkYlu11J+BIUzH/7T3AIuJJIW8dCio6tDelCynWRUlqA4eu+N5RMsJiFql5G7fl3Uwevs+Vc+1Z1npRzVFGR0s+BlqOSayCDEtn+yiyTx7cuv1dOeMNN9Jyn2AjABQ4eS+3cPLTNh0lPU+FymA88KT7iPF6mVw2nZGLy+fONLrlPoymsEP6HTc/bcyGDbdWavIZjaBe9Sd8xLXV5Eh3O3nJOzcMl/AF4bPQr4kJrpTGnfkgaHzlwHJdwPlar83CCbpl4raYEhUVmyxuQ4WrTB8q+ue9NSF6HeAFIjR5cHb+vd+tNEX9YEw/DGR3KXdOkTEkLRGue6vv/wWbvTZrIf+/pgd2ciRFJZ10/k9VqLZjShFI8LK4tyhbfISeE6g5tfa2XTFJuxsg2lgTbRmDY8MMFx3ZjZwtsSoM3kv2NaSpE5Be7tGhTCc6ToXLWQRg9QyfGfNmd27RKOLgr4CQc6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2664.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(39840400004)(396003)(956004)(16576012)(107886003)(31696002)(5660300002)(508600001)(52116002)(4001150100001)(86362001)(6666004)(36916002)(2616005)(38100700002)(31686004)(38350700002)(8936002)(186003)(316002)(83380400001)(6486002)(26005)(66476007)(4744005)(66946007)(44832011)(36756003)(6916009)(2906002)(66556008)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dENCSG84QmFObVdabm5rb1RYbmpOU2xWU21VbGNZQTdOWDUxdTllc3ZIVmVJ?=
 =?utf-8?B?L1JzbzdUNzdJbktac3NkZ1Y4VE94aUxDSnlNUTRXTERrekZIZDNGbmdsamxV?=
 =?utf-8?B?eDBkOXN2U25DRzJtcnNkUGovUGE1OTIvaWZjYzVmKy94bUtJR2lzTTBCaG45?=
 =?utf-8?B?eFdrWFFQRDg2WHRmT1ZTTVNxb3VZTDl4aFJGWlJYZWNld2hXZUtSS1ZodDhI?=
 =?utf-8?B?V2kraWlsdExtZ2I4cnZJN1BudTA3UWFid0lKbEhqRjVMdVdNSWg2b1R1QVdE?=
 =?utf-8?B?b09HK2xZS2lUVis1THFIdzJLbldnYVNTR2hPNWlwaTU0MU5TOVlPSDh5bm5u?=
 =?utf-8?B?M1E2VFZnZUZSYUVQT0JzV1ZseGVwQmxMZ1F6N3VPeUlWamFGV1R6UklPek1o?=
 =?utf-8?B?WTk1bEdra2ZaNEVqYktrdHorSUt3YlpKM1Rxd0FOTUJZbzFPcnoxWDQrOWI4?=
 =?utf-8?B?ZkxvUDhHWE1INDlGbTJSUXB3WGx1MUJGSGN6M2l3dVRuam5pZHFSL3hjdTYy?=
 =?utf-8?B?WDE4Mnc2RnByYVVsSUdIMXIrLzZIaTZSOUowODh5WHNSSzVQNTNrRUlpYjlP?=
 =?utf-8?B?alY3SGNNU0gydFBRb0l5dktwZVJhazBsZU92VmxBSHN0bHFOelFYVjZhd3Vy?=
 =?utf-8?B?bHQ3N3hTY1NTMkdvUVBFNFN4cUJ4ZVRKVk44SHNoM2g2N1Znd0k4cTV6VDdu?=
 =?utf-8?B?d2ZLdjdQek9xOXd5UmdWVXo4dG5mbkZRVUVHd29VTGFhYjRVcU1NQkNTT3Jp?=
 =?utf-8?B?R3VFL3U2SlhHOGpzenBINU4wVkU0VEtkWXoxeVpYdjBoM3FsVXYrVTdBTWpU?=
 =?utf-8?B?ZTN3T01NWDZtRms0cEZrSVhVZ0ZYZWdlTkRJOXVkYmpPV2pqL3NZSGJHU25y?=
 =?utf-8?B?aEVrTHQxSi9rUDYwa1M2Vy9xbHNrWXUwaENNWE8wYnhoS1BPQXBDbjVhNmxi?=
 =?utf-8?B?MzBqNk9EZVhlNldwd0k5ODVVVENiWXRLVEtTcXJqS3prUURSSk5uSG1YSXY4?=
 =?utf-8?B?b0NYUkJJT2Y0MHB5MUZlWWpQWVB6T1cwQ3dKaUFwaU1Ecno0UEZ6T1ZWQ25H?=
 =?utf-8?B?QnZNdUttQitJVXozeEdJUnMxWGRpUmtkWkhsSFpIYURFMXJQWGp5cmV2Nmhy?=
 =?utf-8?B?Yy9ETkxhRGdJZGVCVERpVmlRb0llVFpGM2loR1NrQWQ1OGlrK2N5M29nWHBP?=
 =?utf-8?B?U0tSQWd2UHIySEJCZ1B6SkhSVis1dUF0YlhObkdqS3pjNy82RllzRkxmZ2pV?=
 =?utf-8?B?MEZvS3A4TVJPSmdxSlFaejF3TWpqS3U2ZlBTVUVVMEVqOXpsTmkwaWptZEwx?=
 =?utf-8?B?THNiWG4wYUdsUzVkYkN4empSVGhmbzJGeG9TWExzcGhiQk1RcHRGbFl2eVRR?=
 =?utf-8?B?TlFFN1FBV2I1eEh5Qkw1Yjl1Qjc2U0FBZ05tVkcrZ0c4V2xTSGVXU2V2R1Rp?=
 =?utf-8?B?aGZCWHJXNTJyNjRkendYNlRndTBBOWdaMVE3a1grRHpjRHVxbEg1bzY5dXhI?=
 =?utf-8?B?SVV3Q0VkWmQ3S2tmSkNhQjZHNThzQWR2bFJFVXphS0lobmJabUtEWkU4R2FH?=
 =?utf-8?B?RmpRdyszU1dpNEZMaHNBYmp6YzNjMmMzbnNicVd5N0xYNUpwT1ViMkRpSnBW?=
 =?utf-8?B?YzYvaVh6WkdnZW9hV0RHbGwvQWc5aTk0dHJlZkdWUnZQaUdLOWRPcU83SjBK?=
 =?utf-8?B?NzdKeVNNekQ1djRFZ3hQc3U2T29wNlU0UEZRampSVjlQYUJvT284WDFhYlo5?=
 =?utf-8?B?QTN1eE1EUWNINHhaMjNqdVVWRFVWd0NjaUc5cHgrSHQ1R0d5Q2x4TUl4Rldw?=
 =?utf-8?B?QmloYm0rRmJ0Unl4ZkJaTEVzRzdnOXhDT2gvSnBZUGFqbG9IeWdOQ01vd2VK?=
 =?utf-8?B?OEFRbTFaZGI0dnZYZzlVSkh4NVprd3VuLzd1a29HNU1UZ01SdEhKQXJjZ1FG?=
 =?utf-8?B?V2dyQWFLdktTOUJMZVFRODYxMFNVUys3RFZCdUVjanp2SVhnRjJKdzNnT0VD?=
 =?utf-8?B?bER4Z3M3Q1FsRWZ6SHNSeTlQODdpL25jaU1PZUdxOEdVdGtnaXJhS2gyUXpD?=
 =?utf-8?B?YTg5aU5qTlQrM2F1U0RmVnFjM3BBWFlLcmpjaDNLaXhZeE9UQ0UxTnJZZUNv?=
 =?utf-8?B?YjJYenJ0S09HL3RQL0tQVUJRSmgwSnBkbWR2bnFOMFdFUFY0WjB6Z2pQYUNK?=
 =?utf-8?Q?j+xBg664wXvSoh2xts2xxBU=3D?=
X-OriginatorOrg: systech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db6c878-2fa0-46ad-0153-08d9a46153d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2664.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 15:46:57.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 47224f68-59f8-42cf-9b0c-62ae261b2df6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2Ym6eKSbdik1oBv90pwli4LsvOaA5af1mY4jTlLx3OW9KkpFfLg3VPCIxkSnVahufn4XaF/z5tjTwABAOo3LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2247
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jay Foster <jay.foster@systech.com>

hciconfig segfaults in the Bluez 5.62 release.

The 'hciconfig lm' command, used to show the current link mode settings,
de-references a NULL pointer when calling strcasestr().  This results in
a segmentation fault.  This is a regression in release 5.62 from the updates
to implement the appropriate language changes.

The hci_str2bit() function handles a NULL str value, but strcasestr() 
does not.

Signed-off-by: Jay Foster <jay.foster@systech.com>

--- a/lib/hci.c    2021-10-13 11:38:34.000000000 -0700
+++ b/lib/hci.c    2021-11-08 09:19:59.880207913 -0800
@@ -323,7 +323,7 @@ int hci_strtolm(char *str, unsigned int
      int ret = hci_str2bit(link_mode_map, str, val);

      /* Deprecated name. Kept for compatibility. */
-    if (strcasestr(str, "MASTER")) {
+    if (str && strcasestr(str, "MASTER")) {
          ret = 1;
          *val |= HCI_LM_MASTER;
      }

