Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF6CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9640160EB5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhHQWHz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:07:55 -0400
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com ([40.107.236.100]:40801
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229869AbhHQWHz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 18:07:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1rTYZtRDtRGQ71+u1BpsY+VF0UZn/p2fSI1sxTBwgJwGILCwnP5EL6/KLWGe9VRnvinqv8hm3ehqOZidUaG85Dn+sqVRgklq2Mb2sPbFcOOPenRAK6sy+PYbjTRhV+33Ojcenjqg8aczGAW6owemdCPiAwhzvhT6OZ9TQ4LED7D/x8qxIT2fIjklo0SQjCkXtdjedbWnOJdKt89u2Yr1e3Scdx+yxwD9RJfqTwnbYndOAck36bfp83Gy91/gcb9ePP6bYq3zjrGCSbMKTc9oeG/ID6ETIHv+stCBq6aHhajZ5Jgk8hQDxXvgPurZFLzt7AuoaxitWYFWRwJY5qZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P10wbH2RcvEyANMipGl5kfVHruTJMPP4XLIkQ5g8a8=;
 b=Alv3+kOFDFmGFbYvyvzYFOm0IbVtT8rqrr6S4BvsNyNWdNlO3PmG2fHaq1tL0YoaglV2hBeJC/tHz+No4EnTqkHBbDDLUQs8wkb8h3N/akKqcq14xYdyvLvKTl9a8Oolb5Ng6sNFw9EAC47dr5iUo5FsOXku0bOa/BT1aqUjWatrb7y6mnJS60kL42GhGJcal6VIY/U13iTdeKFYy2bpbXg90LZnsnfTJZkVfS/zb4cu1UCl54kQyzyj32jbfB/zIPT0TWUcnByicBJH/kuaMsfOWiAvhGahyW4MgWRvZncoIEWKrbMEHDDTMEONc3eL04azQkx8/GLgDTUuC/ENaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pabigot.com; dmarc=pass action=none header.from=pabigot.com;
 dkim=pass header.d=pabigot.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=pabigot.com;
Received: from CY4PR22MB0581.namprd22.prod.outlook.com (2603:10b6:903:e2::10)
 by CY4PR2201MB1349.namprd22.prod.outlook.com (2603:10b6:910:64::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Tue, 17 Aug
 2021 22:07:19 +0000
Received: from CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::741f:43e5:f1b6:55d6]) by CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::741f:43e5:f1b6:55d6%2]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:07:19 +0000
To:     linux-bluetooth@vger.kernel.org
From:   "Peter A. Bigot" <pab@pabigot.com>
Subject: how to cleanly shutdown an application using HCI_CHANNEL_USER
Organization: Peter Bigot Consulting, LLC
Message-ID: <e17b2044-62cb-cbf7-64b8-c647aa7f6ee7@pabigot.com>
Date:   Tue, 17 Aug 2021 15:07:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To CY4PR22MB0581.namprd22.prod.outlook.com
 (2603:10b6:903:e2::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.65.21] (67.1.203.46) by SJ0PR03CA0284.namprd03.prod.outlook.com (2603:10b6:a03:39e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 22:07:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c53bdbb5-2caf-49f9-50c4-08d961cb61a8
X-MS-TrafficTypeDiagnostic: CY4PR2201MB1349:
X-Microsoft-Antispam-PRVS: <CY4PR2201MB1349D90A3DE4DA258BAA0EFCA0FE9@CY4PR2201MB1349.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WHYowisHlNEP0yQe4w44Ps5L2Lst9sqCO173dsR+xsjKh5F6gWKqhC0Y8KYSnXmBUUzkwnHnI277TAcf9B4H630rvpobeeymEwXOgIDFkUz77eX+VYG3epiOwGlH2vPAfWL3o2/pzscXM5XRDOCqT/1mqJaEfIkM5VpXlflGCjx/PhAUIGknWGluzNs2QDijh1zDdE/i+tu1cD+a20J3/kOGsZIYyCsibvDRX5SV6TcBB0tN9m8HCXn//UyoG4GgELotvY7kENshGcw5O1SYNr2JX6X37zTItz+wedUzfPeIeaGVaI77QNrQREedg3Gjk42ImzyedC7oMxA9bn4F3zD1UT/fyEg8TZfhK6zRWpLcvQ8roKXHxneapPISNo95UPUs8t3/b0IRyS9JDJ5Io/dBRIr7A60RL290Q9/bEyIFJR2xQ7dpxYJbg/xE172EDI9jJjHbHV9XeynSXma+ECNcsAaHuPLAKnUMDV+1Sl1YMxMSufRiSkcYtgExUasObM9U0xlffvVyHw2H5G+B0V0LVHCenz9fouvOqmq21UuCFsMbQRKl8kQZbLcfLJKWyNzOtjxHc38gofNTHPs6Qj4/GeYeKkj3PzIb5ZYV9jyZR4/N7qemickAYLIzgjH4V2M8MUwYdIotyCuPg+WpZ+Gy1VIwavFZhBZf3+75BDIgPcSMUbyVR3qADkKzfrBwOQDdXAq7yptK8U2Zo3Cvicz7dr+XFoFOHaBa2iegq6tzfFiLXWRAKJ6C0tyMk3j5xGnZ5ejX0wIJ3Gqeqoa4Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR22MB0581.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39830400003)(366004)(346002)(136003)(8936002)(66556008)(66476007)(186003)(16576012)(6916009)(66946007)(4744005)(26005)(316002)(31686004)(5660300002)(478600001)(83380400001)(38350700002)(2906002)(956004)(2616005)(8676002)(36756003)(52116002)(36916002)(31696002)(38100700002)(6486002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21GVmZOeTRuQ2dzQjFmVG9DVjdsb2RVN2E4ZDBvSkJxV2d0M3VwTGtpRDJR?=
 =?utf-8?B?ZWJia1pUWjJVTjZWQmpxcWNqNUhybEdvSzJUZWU1UGErWVlXZndzNE5QL2t2?=
 =?utf-8?B?c0JCREJDWDAxMmxLTE5MUjRHRVducHFxdEY3Z2liazJUZFZQNmo4Q1lIL0hu?=
 =?utf-8?B?ZXVzdWxEaWJHai9GelJvSXJkajBFbWtCUTViMkdIcmczWDZaU21KM2xZd0hE?=
 =?utf-8?B?R08wTVNmeUlGM01jTjJWWWtZVmp1Qk5mWkZoRXAxVjY4cU1NNlIrV3lSSWNq?=
 =?utf-8?B?UUgvQmYwSkluTHNGRytFU2RwemFpSEpmbjRDOUFVZUFsUGp6OUZBd29HcTRQ?=
 =?utf-8?B?dkRPN1UxRVRUT0xXb3pZQTFWdjkwdm15K1FaMVRuZVVuU1R5RzlqbW5HNzlQ?=
 =?utf-8?B?ZUF2TWdYYmxVK2FPV3hUY3ZoL0orM1lyc0F1QlhGeFowWE81WjVNUmNPMHFo?=
 =?utf-8?B?bmozcUR5dWFsTFFBaDM3eEJSZ1JoUndPNE1xaEUxSStuRm1DWVdoamlUa1I0?=
 =?utf-8?B?MTZZK1pYQVhneVZEVzFtNW94VnZmUnREN0JXS0tUcFMySzhuOHFOcWt6aFRa?=
 =?utf-8?B?TnU1RVZnWHJJL1BwNllDZUliVnVveUdiTTlqRmhGK3VpUm5KN2wxWFVUOHFi?=
 =?utf-8?B?azM5anJBWU5UNncvVVdMWTI3YzJFQXhLVUNwZC9qSEt2cTlaZWd2R3ZpN2M1?=
 =?utf-8?B?MWFlWmZ5dktzQWYrOXhFUWpiMjBFYUk2bEo0a1A0ZUtQMXFzREdMRUlLR2Iy?=
 =?utf-8?B?NkM3YTE3WDJnSDhNZ2VoallnSTRoNEEyOWFEYkp6SFQ2djNaNm14TEZuSlFt?=
 =?utf-8?B?dVltMjF4WWhUUHFnTHV3WHhzeVJTRE5VdExvWm4yckFQcWR5bkprSkU4RENB?=
 =?utf-8?B?V0ZCbEc2ODAxNzU5UmF2amtCUXhyY2M5cWtmS3NjdXlxMlBVUDhsb1FMZVdH?=
 =?utf-8?B?VnRLMkRoVGwybHh0L2d2b2wvUUxBYWpIMFhPMm1HdnFBRCswY1JGRmxKbEFK?=
 =?utf-8?B?d08xRnl4cXdsamFxaWEwa3psVThUcVQxSkw5Y2NKUDYweldOdHlidk5OQ2Fi?=
 =?utf-8?B?Q1ZFRnB0cHVJQ3lOV1ZkWlBLMElpeGlrYjJVTmlmWlZ6YXRmdFdQWFgvUUFp?=
 =?utf-8?B?Zm9icHpQZk9GeWZ4SkpzZTZtNldDL0tMTFBJVFI4U1JGQnZCZ24xSXBIVGw0?=
 =?utf-8?B?MlVtWVo3amc1Y0NTQkNjQ2oyV3VvNXJNcmQrZXFJeWlreXV5WE85RndwRGNP?=
 =?utf-8?B?eFlZMjdnRk9MeGY3dGtRQkMrY2FKeGQxVSsvYS9iRGx1N0J1alNGQWtVRVZW?=
 =?utf-8?B?YktWVUp0TDlSZ0crL055aFpqbDN3SCtaZ0cvNGZaSTdEanpHYitPNEkwNllY?=
 =?utf-8?B?ZU1iZHRQbWlMSEpSTWJkZzVHUUFIdHUxMnRHb1lwMWUzK1pMVnNBYWtGNnRP?=
 =?utf-8?B?bFRxb296RURGZDIxWkNQaHhRVk1HTytNcjR5cXR6eWV6alEzT3pzQ2ZUV1JB?=
 =?utf-8?B?K1lJMHhFeHdPOFI4eXZJcEcxWGNFMVB2ZEIyYzc0MWV4UGVnL3FZTy9VSGNl?=
 =?utf-8?B?bG1oOUFxZXl5NG9SSjZ4RVB1UkRNWTAvc0NPT212cGp2RmtQdFg5Z2QyVTQ1?=
 =?utf-8?B?Tmk3Y3F5QlZWT2dOeFJhbEJ6cHVteHNYZ0taVmUwOHoyQjRrazh3cVFwVk9j?=
 =?utf-8?B?UUswS1VTbU5KdUk2NHJ5bWMvNjN6Smp0U2tpd0UyaFZwRnhESGJGaitWWnhF?=
 =?utf-8?Q?+Xe5E9F6E0Q7zS4kVlMpWi1/wVdfiezIw2MlPSy?=
X-OriginatorOrg: pabigot.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53bdbb5-2caf-49f9-50c4-08d961cb61a8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR22MB0581.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:07:19.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 93ff3220-27ea-4632-aa49-46b51ff93a85
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQPfC6vRJFSIzrDPz5w7AMOv0ChRpDPBY6NzoDGQLPtnDBVeX3qb+IrJmR7N0RuC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1349
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I'm using an AF_BLUETOOTH socket bound with HCI_CHANNEL_USER from a
user-mode application with cap_net_admin=ep.  As expected this
requires the device be down, and brings the device up automatically.

When I close that socket and exit the application, the device appears
to remain up forever.  Which prevents me from re-starting the
application.

I tried to issue HCIDEVDOWN before closing, but that produces EBADFD
because ioctls cannot be performed with HCI_CHANNEL_RAW.

I can bring the interface down from within the application if, after
closing the socket, I wait a second or so, then create a new bound
HCI_CHANNEL_RAW socket and issue HCIDEVDOWN on it.

Is there some other way to cleanly shut down an application that used
HCI_CHANNEL_USER so that the device is returned to down state on exit?
Or is this supposed to happen automatically (I see code that suggests
it should)?

Kernel version is 5.11.0-7620-generic (System76), and I'm using go
1.16, if that's relevant.

Thanks!

Peter
