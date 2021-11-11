Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7EBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 15:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E897361105
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 15:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhKKPlw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 10:41:52 -0500
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:24833
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230177AbhKKPlv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 10:41:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5JC8drjgIKNtcuPp0dX1QYebOngMK4kmJnvAx3j6rEHT8wqjgs3CCfQyzKMrlYPD91K1lW2OvTArFGBGPAtJjPERlsBpcb8aBrI8dx100gKBDU2l/yZgrQZAaG2y4w1xuzfpBnwxtCzK19I/ScTF27p0uBMY7GoSaQJ8VtRgj5K4O/aadqxSepGX1at0WYG++vUuqLMAsdwY5RRd5OEhsEabvKogdah6loMqosCbRiXXfWkxJD3QBO576Z0kRnNdcyXw7aQZWf/37LVi2m6A0DnXOhlt8l/6rjDRtcp51T4+zIyBtyajelZKU+x4RIOJSPoyTEYK2J3KfGljg4dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NideyF2hp6vNGXa3+xFgnaFa6xxfZuz8k7Lc5p1+Rdw=;
 b=OOYm42H49fTkQShEkqu8VEEg0j4ZNPtqbXMnxLr9lHfaKohjpehzp25kPwRnhX3YzUzfI/WwLSPRF19SSFgvPozUH0s4aep4Xo9gwzz8PyFyOfi/94lM0QJ1ga85k5mBF2fSVYKi7bgJJwQClc6Tu0/Vj6gMI+kIqoH4KEqtbmorXyKGUuRxgWfQi3Yg033NEYLD6Jx6fcIFjUbNpGCS6sBpEyYQjL3YXBTbRYHEUgNMJBgt3Mx3QCo4IWgeh6Toi3wQVqyQOb8xk5NvGZYUlsnSVTA3hPZjHrmgvl6l/ahCNlYfWS01CIAixhtkZ1epaPS5A8ZRxPnVtirhhva5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=systech.com; dmarc=pass action=none header.from=systech.com;
 dkim=pass header.d=systech.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=systech.com;
Received: from BYAPR20MB2664.namprd20.prod.outlook.com (2603:10b6:a03:fd::26)
 by BY5PR20MB2932.namprd20.prod.outlook.com (2603:10b6:a03:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 15:38:59 +0000
Received: from BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::ec43:56a9:6f54:d0be]) by BYAPR20MB2664.namprd20.prod.outlook.com
 ([fe80::ec43:56a9:6f54:d0be%3]) with mapi id 15.20.4690.016; Thu, 11 Nov 2021
 15:38:58 +0000
Message-ID: <0b36af38-4069-0952-da99-4d384295a50e@systech.com>
Date:   Thu, 11 Nov 2021 07:38:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: BlueZ hciconfig: Segmentation Fault
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f657c955-2a04-d6ae-cc10-3b0476a33fa3@systech.com>
 <CABBYNZLcCEPUuqrzeQRiOWh34Z+E6wAJB8u4tfwX3Pog9N5=tg@mail.gmail.com>
From:   Jay Foster <jay.foster@systech.com>
Organization: Systech Corporation
In-Reply-To: <CABBYNZLcCEPUuqrzeQRiOWh34Z+E6wAJB8u4tfwX3Pog9N5=tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To BYAPR20MB2664.namprd20.prod.outlook.com
 (2603:10b6:a03:fd::26)
MIME-Version: 1.0
Received: from [172.16.4.182] (70.167.11.34) by BYAPR21CA0019.namprd21.prod.outlook.com (2603:10b6:a03:114::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.1 via Frontend Transport; Thu, 11 Nov 2021 15:38:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fffe3dca-15cb-4856-2676-08d9a5296073
X-MS-TrafficTypeDiagnostic: BY5PR20MB2932:
X-Microsoft-Antispam-PRVS: <BY5PR20MB293272280FA67B07485916F393949@BY5PR20MB2932.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6A/sYhTQw0uqasAjT7tZqQy2SX6UvINLQ9JQNcD5iXBS2nFJAGgeRjUVdn0lw3o9RmKgJVEx67lDbzS7AGxzjBGkLl2BZzFlUfwZuMr/IQ4MrHts7QKxUTdR2VqN8+lcGTgGR8IRvHQECa8JkYI/Z7SojydVcpHm76odFFHE88zuwXeUhcnBXQfMywkPTwPs6V3UVd96GzaYYgWxZkxzDr+gr1z6w6C58+YQ0J2I4Kp/4Z4xCUVyvlqvuKl5y5caEg+yA71HVgZuzaMQ8i8AqGvcd6c9Z66PX+h+uy+q7Uz89m243LcON0xrDs2u5gV2oBISw/cB4jsEBtK17G7EqUgalaAv/Tj63GT/c3pBIblj+B1SHW1d7auYurhZZOhxLDOYqyFm2Q6JYERp/rTMojMVO9EJdT3f70YHPUf5bjuSFuaC3UOIPGtVc8J35kVPF3DMTUEIoR3dZrzN73nZbT98Tc39BsmMMoyzqUWyQOO0txOZVPSoM9lqkkj899Eti3IdRGvASgUDRX3WDi5VlzOtL2kaW8EicBLOJOppmQDzJ+yNZsTkuyQj9fH4MPko1SvbNv0pXxVG5OEuB3ATbIdzlmGuhDr1/3S771oEDYgfwNCxVlHTAp9mhOeDIIp65xW28ww2vaU1es60Ok2oWJk4dyrQJsrmgyUTfyLTGScsz3SFgbjWDd9wXZiAnTbYwuYkcTi0vFrAsvbRzP8ppZ8FyGPvcUTIQJyV0i+mg5Xbvj7GKNlVINJ3Unjdpgl8NCWouGkDThoJjuQn4n3FmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2664.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39840400004)(376002)(396003)(36916002)(2906002)(6486002)(44832011)(52116002)(4001150100001)(66476007)(8936002)(16576012)(66556008)(956004)(83380400001)(2616005)(31696002)(4326008)(66946007)(38100700002)(53546011)(186003)(316002)(38350700002)(31686004)(26005)(8676002)(508600001)(6916009)(5660300002)(6666004)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N09sNndkVU9lTTc1TDBEU2FrR0tiSm1lUkFSSHBPS095ZGtmM1JDMXZUaHpW?=
 =?utf-8?B?WGRhTHNPWStPZVRCcVE3aEw5ZHV6UzYzNmFEQ21WRVdKa1hvYXlFbXJQY3lk?=
 =?utf-8?B?QnpwZFdpZHlETWVDMUpaQzV3ck1vbnBTeW5pTzRBSlFxeUF6NGQxaS9nMGcx?=
 =?utf-8?B?MkdqRXZQRklYVTJ1cXM4bDZTS0xtZ3pDb09LLzN2dlZjZU9uVmkyYkJzNjJn?=
 =?utf-8?B?Y0sydHptbzVYdTNVWEFHNkZOd2hiUlg3d3pPMlBmS09zb1IvdE9CS3htVG1q?=
 =?utf-8?B?bUFnSk5UM2VhOWNsUDFiSDhYSkNkdkxjOXJtRnRscmFpeXZZTzNiakxIQ2Jz?=
 =?utf-8?B?MTNoenZGUlA0V3lkZC9XWUFlS1BjMG8rSU5yeGtOdWRXeFo0T2JXQ0JVTFhW?=
 =?utf-8?B?Y2ZNdm1kZFZnZTRlU1dVNXl3TlVPamxtRzlpcWdrdk9UWGdGLzQwR0xHRXZt?=
 =?utf-8?B?eHNzelFza3llOVZ1OGZCS2JONmh2bmI3T3p5M2d6K3V3bTBsKzhNZ1ZaYVBU?=
 =?utf-8?B?S1l5WWlUZVFPbnNEUVJsM3VidnNMV0YwMHhqazEyRElwS2RLMXJVd2NxYlJy?=
 =?utf-8?B?dmJ0NmJTUHNjcWg0aEIyT0ROSWJvby9HQ20waTgzUUlpK3NManM4MFBrMkgv?=
 =?utf-8?B?Vm1vODRzbXJQR3l0TlE2NnVkSVpkMUZ5NWU4RXVZend6MzRPdVRPbmtnT1I5?=
 =?utf-8?B?eGNKNlRKUjdVaEt0bTF6U3ZTWFh5cnIxd0RqVzA5MVgrY09LcnZ6dEp1MWlv?=
 =?utf-8?B?Yk1aV0hHaHZlUmE0WG9LNi9kaW5RQWl4alRjcUJlWlBocitEdEw5YjBsNkRC?=
 =?utf-8?B?T3BKeC9KSHgxUXBvbmdOY2M4bkJvdEN5Zlo2aDlVZlBGYW13VnFjeUFrYWlx?=
 =?utf-8?B?NmZGTnJrbUptSUkydnpBTlJOOEg2K2lzMWtBQzdoSTZoQk5wYm0rWXlYaFd5?=
 =?utf-8?B?WmN4dWQzSnB3YzNlekdXV0laN3UvMUJ2bitxM25nTXF5TFRtcUFyck1JYkVF?=
 =?utf-8?B?MGRta2RBOU5Hb2QvaWhlL0tUWm9aek5TUW1URWZ0c2FLdHExbFRwVkM4M1Uy?=
 =?utf-8?B?ZENWNXhHTVZ4OThoSTRVUUlKRGkyRllNRGZESXRMNzhBNW45YjRmTHYrejhF?=
 =?utf-8?B?UkYwVU9mQUdYU1VkMTRWd0VBcjJ4NDhZMDZwY2tMeVl1UEVRN3JHTDZvazI2?=
 =?utf-8?B?aUVwdE1rUVpPL1FlRXdQVWZxK2IyWTcwV2dqQ3c4dUprbC9UN2xKZGIvWjNw?=
 =?utf-8?B?QThOSTMvOU0wTzhFdFpnSGZEV0VUblRrcTBTZTZYYnhsWFhuZm1lM2dLa09z?=
 =?utf-8?B?eWZTeFQ3NksvSE44VWNFSVM5bVFDV3JQckVPRFBBblpBNVBOc05pZldGYVJk?=
 =?utf-8?B?MmxlcklnM3lraGxaaW45bzFUMHNGclM1eWNFODJpU3FxcFJteWJiTTNEK3lh?=
 =?utf-8?B?TWJ1cW9VMTd6NzhCVHlNdkFmKzBFaVBqNDBMSGx4Q0pidDdsNmM5RjNpNkE2?=
 =?utf-8?B?TG5SbGJ0cVhDaEZyN1VZMm1BMGhRUG9RS2JBZkZyMGcxN0RDZWJIMUZMVC90?=
 =?utf-8?B?bndFVVRjQ3crSXBpQlZaUSthU3VPakJaeEtaVjRNNTMzOXNpTWRBMjM5WFox?=
 =?utf-8?B?Z2xXL2dJSUJBMUkyRjdXUzE2SFpXQlZiTUROcjZBQWJ1ZUZHbG82S2hMRmN5?=
 =?utf-8?B?ZUtQWlBIc2lldjNYTFFVazZJRjZTcXNodFowNWFoeXRpeTA4OU1HVmtzM3lp?=
 =?utf-8?B?VGtSTEs1endVcHBjSE5WYWEyTEdLcTlSOHNsRlU4MERLc0FRK0d4d1YyaUlK?=
 =?utf-8?B?Yk9XNnNDbk9pVURoSnQyaFk4bjJYc1d2dHdwY3JVQWI5VlRJVG1INkxUYThx?=
 =?utf-8?B?enhXSlArNy9tcTN2VnBPTUluenVia3JMdW1DKy84ZHJxL0NKa3VzUXFoM1Bq?=
 =?utf-8?B?d3BYMFlCMGFHVkY2emEyVFhSaGlwY3NOamRsTUVBQkwrWmNBZVVMQk9MT1JF?=
 =?utf-8?B?WVdTNFU5RmdSandHcVlXT2N5OXpLVkhSRkJQWnhVQkhJVnM1UE5FSmFqbXRa?=
 =?utf-8?B?MDkyM3NvNjZLVkxCOTVNbVE4TFBhMXpPc1l0R24zTm9DcFJKc0c1dGUvV3BD?=
 =?utf-8?B?QzhudG03aE9qbXh0akU0Z0RzMmQwTmRKN05QcHNxMkRzd1d5dEVjRm9qYjhn?=
 =?utf-8?Q?UiJADItvQ9nAphJrwJr9N+I=3D?=
X-OriginatorOrg: systech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffe3dca-15cb-4856-2676-08d9a5296073
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2664.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 15:38:58.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 47224f68-59f8-42cf-9b0c-62ae261b2df6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L0UuxhmWtMgL2UTnM3y0Ng9t0SNGtRYSHsPIm3F2GAEwyCFjEb9/3EPln8bq/3yQlCKX+sHt2lz0550RbSypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR20MB2932
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/10/2021 4:29 PM, Luiz Augusto von Dentz wrote:
> Hi Jay,
>
> On Wed, Nov 10, 2021 at 7:47 AM Jay Foster <jay.foster@systech.com> wrote:
>> From: Jay Foster <jay.foster@systech.com>
>>
>> hciconfig segfaults in the Bluez 5.62 release.
>>
>> The 'hciconfig lm' command, used to show the current link mode settings,
>> de-references a NULL pointer when calling strcasestr().  This results in
>> a segmentation fault.  This is a regression in release 5.62 from the updates
>> to implement the appropriate language changes.
>>
>> The hci_str2bit() function handles a NULL str value, but strcasestr()
>> does not.
>>
>> Signed-off-by: Jay Foster <jay.foster@systech.com>
>>
>> --- a/lib/hci.c    2021-10-13 11:38:34.000000000 -0700
>> +++ b/lib/hci.c    2021-11-08 09:19:59.880207913 -0800
>> @@ -323,7 +323,7 @@ int hci_strtolm(char *str, unsigned int
>>        int ret = hci_str2bit(link_mode_map, str, val);
>>
>>        /* Deprecated name. Kept for compatibility. */
>> -    if (strcasestr(str, "MASTER")) {
>> +    if (str && strcasestr(str, "MASTER")) {
>>            ret = 1;
>>            *val |= HCI_LM_MASTER;
>>        }
> You will probably need to rebase:
>
> Applying: BlueZ hciconfig: Segmentation Fault
> error: lib/hci.c    2021-11-08 09:19:59.880207913 -0800: does not exist in index
> Patch failed at 0001 BlueZ hciconfig: Segmentation Fault
>
>
Regenerated patch using git.
From: Jay Foster <jay.foster@systech.com>

hciconfig segfaults in the Bluez 5.62 release.

The 'hciconfig lm' command, used to show the current link mode settings,
de-references a NULL pointer when calling strcasestr().  This results in
a segmentation fault.  This is a regression in release 5.62 from the updates
to implement the appropriate language changes.

The hci_str2bit() function handles a NULL str value, but strcasestr()
does not.

Signed-off-by: Jay Foster <jay.foster@systech.com>

diff --git a/lib/hci.c b/lib/hci.c
index 5141f20..0436759 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -323,7 +323,7 @@ int hci_strtolm(char *str, unsigned int *val)
      int ret = hci_str2bit(link_mode_map, str, val);

      /* Deprecated name. Kept for compatibility. */
-    if (strcasestr(str, "MASTER")) {
+    if (str && strcasestr(str, "MASTER")) {
          ret = 1;
          *val |= HCI_LM_MASTER;
      }

