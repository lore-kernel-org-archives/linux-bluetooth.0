Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D0DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Apr 2022 20:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355052AbiDZUZX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353740AbiDZUZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Apr 2022 16:25:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A948889
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 13:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeHY/cWGGqKuUykdUabfiiRj8pb6QF9qdY8NwVP9ZII/eV2AGCaVDMN5RYOqFHyIrBuruGtLYyOL3bg5QSavolZqgYnZmwZBJOMEBjmKw684wsn4JO4wU82EWbfppHqCwdUZu+lDXhyTpbhjn9ej7prEhW7enwSgt3cByphavfg8MpGjg3ulZYtyZ7xpz2Gq/lJ/PBLJPhb2ik4cI6Fe2ewFaOVXITb5bnxjhawMZ0UUousnP0ecEbyXW8qT3AO5gFyroO3fH9QE8GwtRWly0Wyh077R5VDKSV1olhp/idiqWg81JMlyuKOiy4+WcJFTUXaiSCQsdx7oSWh++xXuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pru7Yh+v+Ag7duYShPrG6MmwoWgU8Gs/S/wvHo79c40=;
 b=UuwG5g7jN5Dp3xUPaCbglXhbdhbCv0bQBB1jc/7vITqx5zQs18+4KM5YdaIkjfNB3InJYJQR1EW8WCS1SaqKxcI2oezyvWYbRrO9A/wcQj7Ncu66zftcQF/oNtpL7DEmw44BGxkeZNFYdxHaJRUXk/V9SbOHAj0RONi+K0l6Sxhuh7ugq4MfEhVNWwvtxyzQe4Kc7pVc8EiljMdP+ZEAev7H9lMTwZXXrqr2WOxMnwuURalhxEDjZtsRAmIT83qRXzPi+jSXeDi+grzKMZr7U2XtXB2QUF919aLqAz5Ic4ffq7G90+bE5k2SqPQ2WwKZTMY8AbaXWE1+VdCz3YPPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=life.net.br; dmarc=pass action=none header.from=life.net.br;
 dkim=pass header.d=life.net.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lifeservicos.onmicrosoft.com; s=selector1-lifeservicos-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pru7Yh+v+Ag7duYShPrG6MmwoWgU8Gs/S/wvHo79c40=;
 b=ZhUT+PlUzT9iwAafXVqoFIvDok+Vroz7H5FUe/a2MhIiqF8AFq7KwKGh6Xmd1mpDqJXDnCaGDZbrB62KGMEaJQBF9It1t2xrklih0uXKuWsglLo5tA3tJ9aU0ixykYJewZw3TMQSnaCtYxj4HDXXlQN6Q3/DlSdCqM/8+3vwsok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=life.net.br;
Received: from RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:68::10) by
 CP2P152MB3716.LAMP152.PROD.OUTLOOK.COM (2603:10d6:102:11::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Tue, 26 Apr 2022 20:22:10 +0000
Received: from RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM
 ([fe80::91c7:36e5:f6ea:89ae]) by RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM
 ([fe80::91c7:36e5:f6ea:89ae%9]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 20:22:09 +0000
Message-ID: <a6282d53-0b3c-160d-da11-578d4ffd26a0@life.net.br>
Date:   Tue, 26 Apr 2022 17:22:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: LE Audio and LC3 support?
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <RO2P152MB4617632DBD67266CE4D1D3DE9BFB9@RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM>
 <CABBYNZJ9MygU4nDU+L+BbExAwnD_qAhM_3SKpPX=twvN6N2GLw@mail.gmail.com>
From:   Arthur Fragoso <arthur@life.net.br>
In-Reply-To: <CABBYNZJ9MygU4nDU+L+BbExAwnD_qAhM_3SKpPX=twvN6N2GLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP5P284CA0072.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:97::23) To RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:10:68::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e8a046-9771-44bf-0bbd-08da27c2704c
X-MS-TrafficTypeDiagnostic: CP2P152MB3716:EE_
X-Microsoft-Antispam-PRVS: <CP2P152MB371640AA036C9A598A71B0FF9BFB9@CP2P152MB3716.LAMP152.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwI4iwFB78900o/GIzoTWwjsQj5sW0nG4YN06DwFaaYFfF/mF4KSOtLxjtBTGF3IfEC7QFyiEmwVtbyzRrBHo8B3q/Oze3gwoSHJL1nboYetdPIU1xPJYXGZ5Zq/OxP4mdnHu3ObcxtRlbhTCIJgKabl9vEDP2yBukfr+a4t7wrbQQ1VRvhYRqsNy2It4AQwoMW4qLpWPLtrCGE7T68vApcLcZdzI2syyLi0HdBx3LCii+mQoA6QXUmGd/OGCSSPGAPv96NuwiFnxMUhpnTXrbD3fgnxGW2y18S7wB6B3kQtbiDQ26xdK1AR3nUpJyQQ7uTUi8td99JCG21LQlfb9u/YLXPPWajr7AVGS1JP3/G0VfskyCkesFWuch0CtY3ATtgBt33XeWU+0NHJ+gGJ+Xq3Adib8WNxdk9HeBcAjbGHZje2wJoKissHgw2WITSgz4x11wDJMiLUmfLq0yndSoxgeP2HSiKUwWinelpF+MEWi0m12xT/sKElQ148MIaFlbpqX5vr4kWKSvBuU9qtmNxGQmbEXL7xX3OHuYQvKZCZ7wQ2tDkKImKo5qg/6t1gHlCoEUZsU3RXOTo+BoOgerAtmbwPCfwAGnc0KZZOgkCzyczlHiPcHV2wjKoOGInXuRhvWT2Sf0Z/4gvi8pfr4QihpyGSROLb97DH+GlHaiaoq7XBgMKvr/G4gFLGJvIaxxfZbwWQkoh+25snzBP0LvdXbxh8sm1tkpKw2+s4e7k1YxSu8V3RnhdB0O2ZFx5V1DScYyXg696RuY6CFAmNHF13LTW4jl2CsNLzjmqn0rwIwePs0sirvZzGfb7IT6gASmkSZdiFdJJp4ynpY+hSOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(966005)(31686004)(316002)(6506007)(53546011)(2616005)(4744005)(26005)(8676002)(2906002)(508600001)(6512007)(6916009)(5660300002)(52116002)(66946007)(66556008)(66476007)(31696002)(4326008)(86362001)(38100700002)(38350700002)(8936002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnlvQkk5R08rbldjQWkxMkpzeThMcWMvNC91Nmh4cThLUnJWcDkwM0I4aVFE?=
 =?utf-8?B?MWxjWFdwNjFRQStRUnBQTVo2V3JKME5TR3ovMXJKaFZMSlJpbkV3UEsveHp5?=
 =?utf-8?B?NmlYOXVSR1djNVZrMjBWS1ZYTkpmdUtuMmpKM0YzSFZCTUZ3R1VUTEpYMllK?=
 =?utf-8?B?TnVSU1dNK21iVGxieXlRU2NGQVlBb1NlVitmeGFMRGxkYnlQczh4NGhyZFNx?=
 =?utf-8?B?QjMzR1dxb3NXMmtLN3FRWkZEZzZEWVA3a0Z4K2NqVG1kWG1KTC90b1JXOXg2?=
 =?utf-8?B?eXZYTHdHa0lveU84M2VhL2ZpOTJzR2dpaHlJU2haRXlHcklVNUxVT0MwMlNx?=
 =?utf-8?B?ZEpHNjN3ZzM1VHptQm45Tjlxa3k0M0JyWXZXa3Z5RVRBMXpKMjdMNEcvalNp?=
 =?utf-8?B?a3hEWXlvZEtPTlVrbmR2bmp5eG00bHk0azNKTWF4YVRqbDgwVy92aVlXd0VF?=
 =?utf-8?B?Z21EVnZGaXRaQWdqVFJLbm1jTXpaT1I3aHFIRzRPU0VOeGJmeG80L3VXd3dy?=
 =?utf-8?B?SHdqSkRGVmVCbkNNTmY5dXZaaTRPTEV0RXJReXU2dnZ4Tm9sZ0FKaDhjbnBS?=
 =?utf-8?B?ak1wL0srOEhjd3UxWlQ4NkVpbWdKUDdmUjJoTlF5Z2svZUhZUk1vUFZSNHpP?=
 =?utf-8?B?VUI0Nm10dFExaDJyMHdrdThnSmN4aXFENGs3VXhsMmlKaTZXYkNuTDVYOHJy?=
 =?utf-8?B?cVVaWmkvVHFSazByWmxlTzNKTitXYUtybmNNQXB2cnZid21XUVJpMXQvejlr?=
 =?utf-8?B?NVBuN3IvVnpwaWoySFVyQnNKaGdIZGZNRW1ZNGJUSDNkS0M1V3Jud2xsYzNQ?=
 =?utf-8?B?dmpRWlF5SUxLRWlLa2xJWVV5UXliUWF3enVuVE9NNGQ2V2V3NmVpNlNTRzE4?=
 =?utf-8?B?OHJhSHR5NnFJRWROTzZjQ1N0QVNvU3FUaGh1TEhTOGlYN2lLMVA1MzNZL3FZ?=
 =?utf-8?B?RzhrNmgwNUxJNGEyL2lSSjNjN09yN1U0M2RsV2kyZTNyRUhZa0k2SDlhZzZo?=
 =?utf-8?B?NDNnalA5SnFyT1BiUFd6NC9iYU5Tcmx6ZWltb096MDhHOXc0ZGRqaDBmVmdC?=
 =?utf-8?B?QWs3MHErUXN5LzlNaU9vYTBiQlVPUUkxYzhjSVpxQ0V6NGNiZmdMdTlwcUtG?=
 =?utf-8?B?MmFBN1RBMDNhdEN3R05qakplRmxyMVVQNHNLSGhuOEJMYVZWNU93NUlLT3lH?=
 =?utf-8?B?SjRXYkNzcWU3YS9ZWXUwcmFtV0NlNThYVWtNRXlLNnpuYTNXL2Q0ZjFIb0pm?=
 =?utf-8?B?c3hQQTgzUlk0ZGM4YXVua3RzUXpkd0ZJT1RWVGRLUnRVYncyaytmR1FtYThw?=
 =?utf-8?B?c0FEdWplN3Z3Q2tYanhwWXljYm8wcS9sQzVpZ2NFdS8yOUUrNkVIa3E2MHI1?=
 =?utf-8?B?VFFOeFhHUXdNem5BTW5UcHhTS1piSkJhdERodGtWU3AxNFh6VlNFZ0YzVUV2?=
 =?utf-8?B?T1lUSHYyWk9VWUsvOFl2TDJ3L3dTZ1JXZEU1cVRWV29HS2NQSlVhU3k3M2ZH?=
 =?utf-8?B?RFp5WkxEbzlUYVFsOGRyQVlXT1pNOTl4TWhIa0VMdFE4ajdWTVMxWTBRT2FK?=
 =?utf-8?B?a21UZWhRSzg1S21GbitiWlNhNjBlT29BeVRjRE5WQ1VVTTAwTnA5VFJmUXZV?=
 =?utf-8?B?c3pDRDJ3aEZHWFI5ZnpDNkVIdkNQWTZIZ09GZXFETk1wcTQxYTZkbFhPYXFx?=
 =?utf-8?B?c1FLOUlqWkY0V2ZHTzd0K01DYUFNWGdjQmlUSy9LYk5iU3FsR09wbnhjYWc0?=
 =?utf-8?B?Y0JFclE4RFBJbTVHTnpjNmN5c0xSSlVRd29YL1RNdTJZWjk2M2I3SjVPNHd6?=
 =?utf-8?B?ZWlqbGl2V3BxTnJ0WU9HQTVRWnc0ZnNJQ2I4L0Z3TUtTekI3WjVFelVadVJL?=
 =?utf-8?B?b09LTFVQd3QvQXZYTHNuYmw4UTlOaC9HdHM0K2pSZGFObWN2L1dvdTM1aUph?=
 =?utf-8?B?Zkd0WWhTQlBmSXg4bFFGUWN3dFVQMWZzeWlLWmJmcnZETWkzd1BrUVNydi93?=
 =?utf-8?B?MFpyM2VHWHhnWTJYT25EdW5BWmpOb3piRncyTHBXaTExM1M4cVRoSGxCUDN4?=
 =?utf-8?B?ZkZRSW1LSkkvVkZCR2tvUStEMjU2d1psZSsveU9oU2RhU0RXYnZiR0ppNFRG?=
 =?utf-8?B?c0srd2V1ZFZaVWRRTzBRcTJwOVJlNVhOUFVsc2dkQjEwU2lVZ05WUWdMd3NP?=
 =?utf-8?B?OHFiN2lqMlp1Mkp0bkg5Mjd1RUVyRzQ1L1piM2VxaDE4M3hzRnozRmJic2ZC?=
 =?utf-8?B?NmRDeXdTSHlUWXBTenZTVUF5NWZ0R2lxMGZjejJOcUFEZWgzUW4xakpldm4w?=
 =?utf-8?B?VFh4S0NJL3RCMzcvNTFERXl3ZkxkbTV0bnI4Y3N6RUdoVkpWL0tsKzlOd2xu?=
 =?utf-8?Q?nbsIWNzEe3raMME0=3D?=
X-OriginatorOrg: life.net.br
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8a046-9771-44bf-0bbd-08da27c2704c
X-MS-Exchange-CrossTenant-AuthSource: RO2P152MB4617.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 20:22:08.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 985e32eb-3341-40a8-9eb8-dfbc06ddcc28
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af1SulWlYgVB8A8y0vWDwADY64Xz0osvgSd3wo4aFu0qIPPLntYXSxZvBycOSFvQCqvAbg6jK4CHNo1TGjXvPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP2P152MB3716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 2022-04-26 at 15:09, Luiz Augusto von Dentz wrote:
> Hi Arthur,
> 
> On Tue, Apr 26, 2022 at 1:50 AM Arthur Fragoso <arthur@life.net.br> wrote:
>>
>> Hello,
>>
>> I was gathering information about LE Audio & LC3 supported systems and including it in the wikipedia article https://en.wikipedia.org/wiki/LC3_(codec)
>>
>> I saw Android 13 added support for it, but I was wondering if the Linux kernel had support for it. (and at what version)
>>
>> I tried to look at the source code and commits description and I'm unsure.
>>
>> In the pipewire gitlab, there is a good discussion about it with good information and links about implementation.
>>
>> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/1211
>>
>> And if this is currently not implemented, are there plans to implement it?
> 
> We are working on it, I should be able to send the kernel changes
> later this week.
> 

Hi Luiz Augusto,

Thanks for letting me know, and thanks for the work.

Take your time.

Best regards,

Arthur H Fragoso
