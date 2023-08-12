Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C21C0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Aug 2023 10:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjHLK6M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Aug 2023 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHLK6K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Aug 2023 06:58:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A1A7
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Aug 2023 03:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E06Me5oJYI1v8Uwqrl0g/jSwh9znq7a6+YKsxb0+foutlo1ccj1W2p8yFe0GV5Txgw6JBp7Pa2LiEgKHO76tBpGWwZIJ6iss/LQueZqmkMyyBFVLkU1BO81WplHL9txgdoYBqHhGFkoAAJSQVNndj5R73bUjL0dtGmedHLn4M2xFn6Z2/tb3nNJ+9XEkj7ja3Pne0d0bmkb+2VSTM1srxC1zq3hDvpRco27MInnNT0m5XePOdzjR514uvKoft6ziq3cST4jV6wuULGoLagO50J7jcZusTYWZBC5LFNugEcYoTfRFeSBcINgnFIDUKJLR53Zwd7t85qFU2uMuLxxRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axlQtOfyfkh3A1zcbEryDshKNHBTO93dphhBmAat2Lc=;
 b=QBPEGymlWIrT+4ZBbq1ySdFcqFneBBxcTI89AdUlRAR6d21N/c4drVKe0X1xkAH3TXTW2yB1i1ZBTyIR/giZYTv29GdXrvTNUa2vcs75Tmu7rSMY+MGFwrYxKMHtPW9p3EHfUUn9NikbQT4bS34AqRU+gqG/jm+tZrP9dcoYu/kzyqVrf6Ei9x1/7D42QRn6M93ac1bcxve7QlvwTqaz6um8wjqtabSBuVwJbCbdUS8quFLNcIQqK0zeRevwefdZcnL6jxVVq2WFjLjpCgHnW3ULdFAvBlD2I8shWLaPwPI66BQgJKqVZZJjVr5yDfjOcaTGcedytUxezSE9Z1DPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axlQtOfyfkh3A1zcbEryDshKNHBTO93dphhBmAat2Lc=;
 b=J6G4iy8LKxBtdZ0Wr5Z9UHUSE59k1z0Yt4XF+qryNE0z9z7KPJkfHIZKeJ48Ng6JeP1REwMmAyY2TPWXbqITEQGTYA4C9csGAzxFdhRM6vgd0dlntLgrT9Pp6sR3kxeBXavdDwjYChLb3xV4yxEHvR0RT6BcQNW8Iace4qYgPsvJm1ePrb4Nq93oN0d9VMnUuGHc6zB5XkVqcCin9ACm1wJHpT9W7v6UhHTZ/eeJ3Pw8CwQyU8gEmWC8BDfyDqwoBNGSFBVGZSkhzSjA2UPZKpJRbi8inQK4HmJzrpiQppHgiDepvkXbdM34sNIVgGDYQVUyv4ThKni74VTVnYDoDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8817.eurprd04.prod.outlook.com (2603:10a6:20b:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Sat, 12 Aug
 2023 10:58:07 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::855b:2111:730d:68b4%7]) with mapi id 15.20.6678.023; Sat, 12 Aug 2023
 10:58:07 +0000
Message-ID: <343448b1-03ac-4d24-bda7-aedf08bdfee6@suse.com>
Date:   Sat, 12 Aug 2023 18:57:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Firmware for MT7922 missing in initrd; bluetooth disabled after
 update
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        =?UTF-8?Q?J=C3=BCrgen_Hofmann?= <hofmann@shiphrah.com>
Cc:     linux-bluetooth@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Chris Lu <chris.lu@mediatek.com>
References: <8ddaee26-b4d7-f694-ac8b-2aaf4d3c5f8e@shiphrah.com>
 <c69edd3b-bace-42a0-91e5-d8606a443853@molgen.mpg.de>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <c69edd3b-bace-42a0-91e5-d8606a443853@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:405:3::23) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: e3603638-8be5-4a47-d6a6-08db9b230279
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F47yE91HGDCAwc2Zu6XH9SZ3/iGGkpMDvsDiKwaWwnSbutjV88SET3WXwYfGEYiwXP+fXhZ9PHm4rppIG6Bh/RvNvlahoM2jwnPQFdBT9WuzrirXgTqRmznJGwR0yh3s1Vw9vPBnvRkB8aFLw3Si9QNDwZE5vFl9M2D4q2gh6ca0hd4mbilQiWjVgbyusPeGef/R2OBplpJOf8wIcjQFBOX7c5pfMDkSxEGvQJZufmehQaqauuUwvY1aHVs5k1WWwJz/2d5j/+YRWmM+3kM1yf33exzytE2e46QQHcYj+VTvrjkPxYfzIWgRUX+W3wKNce6TV/GI119mgRKk38i489eVkhJNR16IKHfuKRVA013Arer4+XQuFT/O4PV71nkqzbdhPmlprj6puGSYxhiwr7AYk8TRHVnR+GMRzebHoNM5q0L0Z354xpTZQGzOfydSLvq1dS9/8lqKBbDGhAP+Dqu0JwF5B1LfMByCYp43/bu0BXF6aZl4oCsddaAxAVY7yECWQiXsrRGng36cmL24d4IhUQgeIrpDOpi6sUzzHZJFYIn54nbn20uL7zMKUWOnz6El7M0/vCQZeiIM3jitgN2PAbVDa/V9pBlR/JNYlAKxOu6sDxGMe9D6/fkO6MIRMwJLuhh8vCDpGiCBVTgDQ05iTuPnD8sIOShwn5HyWKdS5Ss1E5zVnpTP9l55tBk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(1800799006)(186006)(451199021)(110136005)(6666004)(966005)(478600001)(2616005)(4326008)(38100700002)(5660300002)(2906002)(83380400001)(15650500001)(66574015)(53546011)(6486002)(316002)(6506007)(8936002)(66476007)(66556008)(66946007)(6512007)(54906003)(36756003)(31696002)(86362001)(41300700001)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRHNThKakhKZE90Rzl2aUw3Vms4N3NJbUFXdXVHWFd3S1FXd1VOWnZtNmFO?=
 =?utf-8?B?czRwR0RYR3pjSThPZEpxZVl5QlA3UHNQaEorNUEvK04zYjlMaWFpTXoyRHN2?=
 =?utf-8?B?SE05Z01MTkhZd2ZzZTJwdHRCcUxYMnA2WHFuM2lVWjhMM1ozcGxtYmd1MHFG?=
 =?utf-8?B?eEZIZUlDdzdjbjYwUS9TYTVoNEU4M2d4WmJINktZbFdzalRKdnFZdGcrbXVO?=
 =?utf-8?B?ZEJTYjFrRjJkbGhkemZFbjNrSmF2eWhXSlVpVFU5d2hKVG4vNGhKQnNWcXNa?=
 =?utf-8?B?M0dYVE16YmJuVFhldjVKOVNuRTkwR0NjQjJoN0krYjZrWjl2czVYT05RbE1Z?=
 =?utf-8?B?UEI0UXVLOWFSSS9KaUQwclhsMHRnL1RBMDJtZEhYM2toWENJT2RiU0xvWGRQ?=
 =?utf-8?B?cVBmdkViSVlqVU5NV1R0b3NNL2pXWFNCLzFtemM2eTJVOWNHSHJIUHhCeHpq?=
 =?utf-8?B?WWV1eXNpQklON3lla3NCQ2pEZ2JiNzVYRDhHWS9xZG45R0E1dFdtM3dTVGhr?=
 =?utf-8?B?cGhXUWpLVnZzcFhWRnRtZU84RVRHOUtiVFA4UHRDRUY1emlKYUZDZnIzbFpq?=
 =?utf-8?B?a3UvREdSWTVKcVpXTUxOamRldEd1YW1XRGc5VmVzMWZpdmtPY0J3ZGJFYlpt?=
 =?utf-8?B?TEtYTmc3SmNpUFl2YWhTRnZZNjljK0xpWFRKQ3NyWWsxclNqVDNWQ2VkVE1n?=
 =?utf-8?B?a21lSnk1UldWNGIrSzduRHBkbDV2aTUyRlZ5eVZkSmVKRTljN1hJL3BRWEJH?=
 =?utf-8?B?eHpZMkg3R2NYK25LbXhFWVArZUVGVm5UNnI2UWpFQmU5M3J6MWRZTXVyVkRs?=
 =?utf-8?B?MjJtT1FmUVEzc0V5amRHTUkvUlZtQmhUdDZ3djFRcEdva1dxU2d2YzFBVGEx?=
 =?utf-8?B?K3k2TEFMRVN5czEvVlorQ1h6ZVVzbjhCcjRHeU1Wa01ablNUcUthTXg1OFNs?=
 =?utf-8?B?T3YrWnQwOGJGeDhVdkx3VzZsYU1xOWhUTFRTZE1qMDdEUUdUTEdvZjhhMFR3?=
 =?utf-8?B?cEZiOTlPd083OWNjYjhxbmdMY1piNGt2MW1KS2pONm02alNzcWFUbHNnZEhZ?=
 =?utf-8?B?RjFSamdhNFJSTFd0Q3ZrakhPUnVpWFNWeGRFZDVqVEtwbXQwUi90bjJoZ2g5?=
 =?utf-8?B?T1FyU29uZ0F5Q1RzQ0tPUHBBWG5zVEdTZWQwNmFiVWZ5THdKcTRMMjMyUEFP?=
 =?utf-8?B?cWhHbkFjbVZJRkVueEh3NHRNOSt1UTRjOWJiT2M3aGxxb3J0ZnhnTHFMUGZZ?=
 =?utf-8?B?WG1wcmVWSWcxZFZYbFdJNkYvUFZUSHozZXp0Vm4rVE9lOStFU0s4aXVuT1M0?=
 =?utf-8?B?Wk9wWjR2dk8xcXdLS1VZY2lxL1pMUUtWZndXYWt3U1NFajhseUtqT1YzM1RK?=
 =?utf-8?B?ZlhoV053d2hOUExOV05FV0k3Z1ZqUm8raHl3N0FvcmFVaTNicDcyOTVyVEs1?=
 =?utf-8?B?clA4dCs2YVdmUnc4SmQrRjZkb0hUbEs1anhBZEVIeDhGTkFTbFN4OERUamRE?=
 =?utf-8?B?ZUsyb1ZGdlIvUFRka1NQNlNQL044ZlpwQW95MjJRckdOZCtYcS9iTFFEYnZW?=
 =?utf-8?B?MUw3WVAzdEg5NXF3aTI2Sk9zNEJibXdrM2pnZ1NtcE5IbG5Za2lxa0FrZFRC?=
 =?utf-8?B?RUcyUjdWRzl0b1ZaSGJ2YUc0T25NdGRUTjNocUVMZTlsVGpwSU9oM05UWjJ6?=
 =?utf-8?B?UkRGNjY1Zmt2SVVpYU9oNzBic1dURk9LcithWmpJSjY2RXJoZVF1N2tUMThz?=
 =?utf-8?B?YnkwV2ZzaHJRUmdxUFFxK056azJtbzhqSVpmWWdEZTh2dkROaTBkTnNiQVBJ?=
 =?utf-8?B?aEpwMkJlWlNic09nSWxyQkp3RkF5WkR3c3lSdnBySTFjdnQzd1hDQlZPNTJa?=
 =?utf-8?B?dHNPa1pMUVUyV2R2RWtBZ2NJbHZlRHhBR0VNNkFWYlBkMFNTc0JBN2lYZW5K?=
 =?utf-8?B?YUdES2x3bDg1SVZiR2pkMytPZEVHcy9TM3lCSkZXSXJNZVQrWXRmTCtzSkpR?=
 =?utf-8?B?SFJJcjQ2NnJGVHFMRVY3OCtTTG1QdDdHUHlVZVp1VkcxSThIYmxDVjNnejdW?=
 =?utf-8?B?aGlXQzBDZTh1RWhaWTk1WjFyWDdCekc3NFBTWWNBRndoSE5zYUhGNU5yakZq?=
 =?utf-8?Q?tmt5ehA/1RJ5WoNKAkmWATILZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3603638-8be5-4a47-d6a6-08db9b230279
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 10:58:07.4202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCCTZ9HdYSJn8B9ngdH9PsP+1DtH2ORyVlxbYvT6+U71qhBhDXjYQgzDFVng1VEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8817
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 2023/8/12 17:02, Paul Menzel wrote:
> [Cc: +Qu, +Chris]
> 
> Dear Jürgen,
> 
> 
> Am 10.08.23 um 22:24 schrieb Jürgen Hofmann:
> 
>> I updated openSuse Tumbleweed 20230806 with a bluetooth keyboard 
>> attached to the PC. After the update to 20230808 and rebooting 
>> bluetooth was disabled and it was impossible to enable it again. 
>> Before the update bluetooth was working fine.
> 
> Sorry, I do not know what software versions changed updating to openSUSE 
> Tumbleweed. Could you please mention that for the Linux kernel and BlueZ 
> and the initrd generator?
> 
>> The attached bluetooth keyboard caused the bluetooth module being 
>> added to initrd. However, the corresponding firmware for MT7922 is not 
>> added.
>>
>> dmesg shows:
>>
>> [    4.368031] bluetooth hci0: Direct firmware load for 
>> mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin failed with error -2
>>
>> In fact the file is present on the system
>>
>> ls -l /usr/lib/firmware/mediatek/BT_RAM_CODE*
>> -rw-r--r-- 1 root root 512104  3. Aug 17:36 
>> /usr/lib/firmware/mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin.xz
>> -rw-r--r-- 1 root root 343052  3. Aug 17:36 
>> /usr/lib/firmware/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin.xz
>>
>> but missing in initrd
>>
>> lsinitrd | grep BT_RAM_CODE
>> -rw-r--r--   1 root     root       343052 Aug  3 17:36 
>> usr/lib/firmware/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin.xz
>>
>> Manually adding the file to initrd makes bluetooth work again.
>>
>> I reported the bug here
>> https://bugzilla.suse.com/show_bug.cgi?id=1214133
>> and was requested to report here.
>>
>> If I can be of any help or you need further information please let me
>> know.
>  From Qu’s answer in the thread *[PATCH v3 1/2] Bluetooth: btusb: Add 
> new VID/PID 0489/e102 for MT7922* [1] it sounds to me, support for chip 
> was only added recently, and is going to be in Linux v6.6.

I think this is a different one.

The new pid (0xe102) is only introduced in some recent laptops (with 
ryzen 7040 series CPUs I guess?).

Unless the user is compiling a custom kernel with the extra vid/pid 
added, it should not work from the very beginning.
Thus I believe it's something different.

Thanks,
Qu
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: 
> https://lore.kernel.org/linux-bluetooth/8a261418-17ca-405f-b340-7e6634c169bc@suse.com/
