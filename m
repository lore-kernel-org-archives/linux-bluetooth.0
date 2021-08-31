Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43178C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 21:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216656054E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 21:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbhHaVbQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:31:16 -0400
Received: from mail-bn8nam12on2134.outbound.protection.outlook.com ([40.107.237.134]:33088
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240401AbhHaVbO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 17:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2/Mv6XRf2PFgEbW0F6aVIatEsag5AzEGbTajVvcoPIHOWRefyqSMXNg61lLlOFjOfTn8OjddXprA9XdhpspGd8dONKMutHIbneKiPxcGYTrdCFxG536+uMayPnWHQVBdEb7wItlHJZk12dIsO4kxiLZHmAxiC+4VETdcinePEmy1zR+8qtgvkDA5Qi6srvoXoZ995f5+sp5vm3AOLyAxu1JO4arYP+PpYoO1KBGgLbS/S6IftvNJY8OvF1qOcxAjXqNQhzp4099b5R5CnqqQMK+rg9RXCvekDvtBQAb+oPBK35EE1wxBCgCnCRZNyouFiVuntzhznZrjbuL3ZGsVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1zLejdb/EDjRXWXI+zMQsxGOYaBoV6kz9eZxnNSYvDk=;
 b=OAZTNOcG+fAS/DAoybefH2j7jV3dnHtNEvHFUzcAEkq1FVlODkKh/hu7ohN8t2/5u7FmdAmAnQs4+wK5VNrF2xrJ/IJmTOAIRUjhjudgXIyHaEz0y7xwfFUUX1VQCmRPFrqjOLQ4aSBHOnr2+gUlc+zrDLRo0f95V5vroOvPUo1Xc63AZ4Dj/73r21M6U8jaDWmsSganoN29g2iPpUIhs5zp6JzIAWMVRQElueGkaVqXD9qgOJ4KuQURCJNVHPtWTX/6sl1lPhl517hwudUHdEO7AQOpDAAnkNcnxIT/tv9hhlpmgiiL4DYSu3Ph0SCJj/1xE9henTGRWf0YoqhcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pabigot.com; dmarc=pass action=none header.from=pabigot.com;
 dkim=pass header.d=pabigot.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=pabigot.com;
Received: from CY4PR22MB0581.namprd22.prod.outlook.com (2603:10b6:903:e2::10)
 by CY4PR2201MB1367.namprd22.prod.outlook.com (2603:10b6:910:62::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 21:30:16 +0000
Received: from CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::d9f0:a6ad:c10c:18ad]) by CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::d9f0:a6ad:c10c:18ad%3]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 21:30:16 +0000
Subject: Re: [BlueZ PATCH] lib: fix variable-length array declarations in hci
 structures
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <20210831163545.3646157-1-pab@pabigot.com>
 <3CBFA8E8-ABA1-495F-BFD4-A4E3CBC1E21B@holtmann.org>
From:   "Peter A. Bigot" <pab@pabigot.com>
Organization: Peter Bigot Consulting, LLC
Message-ID: <c3b21654-8d46-4b12-7d9b-b3eeb12678f9@pabigot.com>
Date:   Tue, 31 Aug 2021 14:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <3CBFA8E8-ABA1-495F-BFD4-A4E3CBC1E21B@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::34) To CY4PR22MB0581.namprd22.prod.outlook.com
 (2603:10b6:903:e2::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.65.21] (67.1.116.23) by SJ0PR13CA0089.namprd13.prod.outlook.com (2603:10b6:a03:2c4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Tue, 31 Aug 2021 21:30:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a15ce9ba-87cb-4683-9227-08d96cc685f6
X-MS-TrafficTypeDiagnostic: CY4PR2201MB1367:
X-Microsoft-Antispam-PRVS: <CY4PR2201MB136797580F8728D867345AD0A0CC9@CY4PR2201MB1367.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uvHgz++tiHrMKdBN/BWIh0sqhaqMwVaPVaSNO5VsoxOUsq7SXZGeaIHJd6bk/WwDtTH7b6M7EdEg9oI4tzLjzcNRn4kaP2ZPWeznSdbKyjxpNP9w79D7mQvKxcq4H5m4N7xBbXpZm1AIC4fRXGhcjwNeYKbAGVesYoO08QJg51tr0AmdNqZtB6gyPEJ/iwAPwX7b4BYRABkw5Nc0qyfs3PGiiCGtgvMK4Ti6yUrCtmNVzEyR2ap4uLil34Z/0lmbo7thscU4EiM+8zPASzy6o2Pv9njH97r5Gu1G8gRM6YkviXrVKIb8sTaNgvO+9hUpqOWCx3EIdZUsz1BA/13hCI+JA5z/Ah7UQ4YHChmicdE39xuMa1B48uR+tCdfiAineVGYMBhLGqM80GhMzgbdL1UnGuiK9uiMJHsP5gF8VVhlYtj51zKdnL2cA/dZkyATHzOZI7/bAer9G8GweJCF46u0iHIuS+X3B2357yaW8yY+7daWHBpwW8gMiyeHFjpBa/OHTPMalYFuMJpXRuD5HdTN9X4z7/GTjEsu2tSGKY2RKyeUeBulryKZwG4I5JbEkDpAIDhpRhzvWlBXp5quzY+C82xRcPZPNOs3gvFqe86QKlte75GFQyXaAaCMyIFBSQvW0ZxnAIW1l0e5NZZ6kYqWmRnQlUT75uSVIJe7xOKqj/cLFVVtFyRNT/WuPE/ocNbqbUNYb5aehZDU4pQGt09lwB9rGvDicNeerCFnX473qU9EqEl7GLwNXGjnfcBu1IbapZDFvA+NVtRmoL+uBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR22MB0581.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39830400003)(366004)(136003)(86362001)(36756003)(16576012)(31696002)(2616005)(2906002)(26005)(8936002)(956004)(316002)(53546011)(8676002)(83380400001)(6486002)(5660300002)(186003)(36916002)(52116002)(6916009)(38350700002)(38100700002)(66476007)(478600001)(66556008)(66946007)(31686004)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkFrUFlxc3l5YXFob0FqNGxGU2dKUjJSUU5uY2xvMkxKaUZQd0FLQ3BjQnNH?=
 =?utf-8?B?R0JqN0NCYmUyM2YwTTF0b294bEg3RE1TVFVpeVVjSHdDVVA0Q09zakhDK2ty?=
 =?utf-8?B?SUlKU3dJcEl5OEF0YVVYajkvWEFHZFh0NW9WS0NJNGxsR3Zzc2Z3NjlZdXpG?=
 =?utf-8?B?YUZJTWk0QVdaWDZNcnp0aU5pbG9CaWlBTUd1RUEwUnFGK25FdHBSclIzRlhQ?=
 =?utf-8?B?MkdwODVPTzBXcU04eGQ0ZEt3ZWNEYmpiRzdGeUNUc2VORTR5TjNRWnRiMDB1?=
 =?utf-8?B?K2NPZE5WYTZ3a2FHNGYxdTdVcWppTUdtaXFlTEpja1NmTDNicjdYb0JCUkZx?=
 =?utf-8?B?cmkrZDVSZzQxYnovdk91Q2Z0Nnh6Z1dKenJSMlBCZHNFcHlhazJNWkJGNzB0?=
 =?utf-8?B?Z05nWnVDcUxyM1B1MmhiTzFXYkFBY2ZIQkphQnI0eUxjYndEN2dHYkdKUko3?=
 =?utf-8?B?ODQ0R1VGd0ZaS0xXQi91WTJsN0lEa1lQbjNsamgvcHRBQ09wcVpxaWcxYUtn?=
 =?utf-8?B?NGd6ejIvRGpjb0NFRmFqR1liSGFaQS9PRlp1cS94ektsQ1NXbXpjRklUMUxh?=
 =?utf-8?B?QWszWndDcWVGbXoxMytxZVY1azh0UXlMSENQK1VDRGJFUWNCQVYyc3pTYURG?=
 =?utf-8?B?a0grUWwzeXRjQm4veUVvUG1zRjkwM2srQUhQT3hHYjJTb1pTR2o3UWJaMm0r?=
 =?utf-8?B?clNaNW0xWUNoaWF1TDdLM1RTTzg4YzFKMCtZd2ZRVEl0SXQvRnVHQVdlbmQy?=
 =?utf-8?B?WUtkbWVjUU5EQTROdmNQbFVoTGZLM0JJbnFJVlorYjczY2ZlV050ek4wd1Fp?=
 =?utf-8?B?aUNhRTBiQ2Nzcll4dXE1RFROZFh3YVBzbHhrOWg0K2g1V3ZEMnFxVjV5eU5T?=
 =?utf-8?B?WFlxMlovb2ltNTY5MDJmMUp4TkUvWmZEaW1OT1J6WU8rcHBxYys2L3hzOWUr?=
 =?utf-8?B?d1Z1eWVKbkVTOTc4ejJkcnRidzYweUdCbFpOci8rM1RSMDdyWEczVTBKQzhx?=
 =?utf-8?B?dGpjc0RFTksyY2NSTEE1UTlJcng4TWtCblZxWCtXSUUxS29WTGZ4aDVhTElI?=
 =?utf-8?B?NmFjYVRJcUYza3U2eW5ZdURlVlF1VlF6K3RHbVNqTUxYVFNBS203V3l1SlFk?=
 =?utf-8?B?Y1lpN2NoUFhsOW02bDZnQlpTTVRkL2dmNDNXTGVGTmIzOURnbVdNVjVnOENl?=
 =?utf-8?B?aEprQ0g3bFRHUXMvRDhlR0ZnbHIwOE5GWEQrYlVENmJpN3pnY3ZFRjh4M3VO?=
 =?utf-8?B?TlRNQWF2NmV4NUxjZ1h0ZmhJY1A2M21mc0ZPSEZmZnBKL3VVVlBaUTRSNVhY?=
 =?utf-8?B?cWg2Mzl5M2puVzRkMXVldlJOSHJHRzNtTjAvMHBPQkFvMmJvbWhIWElDaCtZ?=
 =?utf-8?B?UGdXWlNOL0lqU3Z3cWRITy8vd25UM1krQ1RqVmhNQkgyVmZ0aWhyVWV3SGRu?=
 =?utf-8?B?QUxZQ3RsK2pYWERsTC9UNy8wK1kyeS9YdXFvcFY4N05MWm40c3VwcG1IQXll?=
 =?utf-8?B?RlZGRVpRZ24vbTZZbks1T2ZiUDlTcXpzRkxXR3picDg2bWhHeUNEc0R3c1cw?=
 =?utf-8?B?Nk8zdmszWlVmUCtBVVdVUXFIYld4RTR2a09wUnFKRit4WWd1bGhLaE1TUFBk?=
 =?utf-8?B?WC9SZEhPNWxhMDAwWHcwUTdtYlFoTXBBaFFxZGhKbDRSTzBheUVvZzZqQmVZ?=
 =?utf-8?B?dm0rb1VkUTZoWlV2T0tIdW8vWitpRncrK3UyWWN1SlVoVWNRaDUrY3pNTHVq?=
 =?utf-8?Q?XgbZRUpQtR5QGqVnnOXClFEuRTRnYAKDwj0tzkj?=
X-OriginatorOrg: pabigot.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15ce9ba-87cb-4683-9227-08d96cc685f6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR22MB0581.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 21:30:16.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 93ff3220-27ea-4632-aa49-46b51ff93a85
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y7XCBBxWmQVIGEAbvbOLzB0FUuZ7ruUUvNqZPVnUSAshDR5TuC8eDym1zHrIaKL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1367
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 8/31/21 2:23 PM, Marcel Holtmann wrote:
> Hi Peter,
>
>> Use of zero as the size for arrays as the last element of a structure
>> is a GNU C extension, which as of GCC 10 produces diagnostics when
>> values in the extended array are referenced.  Switch to the C99
>> standard idiom for flexible array members, already in use in a few
>> other headers.
>>
>> Signed-off-by: Peter A. Bigot <pab@pabigot.com>
>> ---
>>
>> No changes from previous submission except the BlueZ subject prefix
>> that I hope will get this into bluez.
>>
>> lib/hci.h | 16 ++++++++--------
>> 1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/hci.h b/lib/hci.h
>> index 3382b87bf..a61568bce 100644
>> --- a/lib/hci.h
>> +++ b/lib/hci.h
>> @@ -729,7 +729,7 @@ typedef struct {
>> typedef struct {
>> 	uint8_t		flt_type;
>> 	uint8_t		cond_type;
>> -	uint8_t		condition[0];
>> +	uint8_t		condition[];
>> } __attribute__ ((packed)) set_event_flt_cp;
>> #define SET_EVENT_FLT_CP_SIZE 2
> does this break any API assumptions? Since as long as libbluetooth exists these headers are API.

The size of the structure remains the same; there should be no API
changes.  I've done this sort of change multiple times over the years
and nobody's reported any problems.

Peter
