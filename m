Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86320C282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 14:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4319C2067D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 14:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=technicolor.onmicrosoft.com header.i=@technicolor.onmicrosoft.com header.b="ber9aJO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgAIOxv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:53:51 -0500
Received: from mail-co1nam11on2092.outbound.protection.outlook.com ([40.107.220.92]:15998
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730123AbgAIOxv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 09:53:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a87RU1L9nESVESFek8vb0CrVATMlBMMD0OUqVkFIhzmLxiKbqm1DRpfAwc8oFAVLpF7VfjsFQDdVeSF4UiUkVY2FFqJE3lyHbd3P8u9pJOS8oQIcz4MgWFgoD2yK3xtGwhLhWXNqfHMH1KDItuIyBP58xyISnzZR83PMVe8KlnU04FOzjOS606jj9T2JIH4dGH417zZezzXZ4Qh33WAZPLZX9VCYDQIpKf3DOv3FaRQiLysyf5DkKwJJscb3xx9G6ollq7/K7fUV24rOSzzjrqvPckZd9N2QIYeBvMSU6nbEXMUkkMyTzTnfQRpci0yIcdcV4K1l/jAiO49RKx7+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl02X2MSsB6Y8zCo0BrJLVZ7x7My2N6msAvd9peqmRM=;
 b=jIv0VxsW37upLamv99U3A8Fw9JyiNYjN3sYTo21Bx32sl7WgktRfGP0EbPGp28no0RYHXt5jd3S5VLJZCgK5SPbz/37YZn+Q4xuIYdc5kCJn15VudHkS11a7NKS4IocV6i4F3cjPGM6iDTr0L9bb5CSfyEnzDHo4Vshhd7OczQbByzq2YOLXh4yK6icNKAtPSaJV4wHTFUxkOkL/56j9b7Tgt85P1mV29Os0bh/liDM/sD0ddFWAiOML0r1m96rOMkfLBdPTWVk+fH/KX7mtaddJMos12yqN/u3tnL1dOXK6pilmxdplt8lIK5Kd0K+XhK36KA0cT3t9lgaKJDS5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.203.95.25) smtp.rcpttodomain=gmail.com smtp.mailfrom=moving-picture.com;
 dmarc=bestguesspass action=none header.from=moving-picture.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technicolor.onmicrosoft.com; s=selector2-technicolor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl02X2MSsB6Y8zCo0BrJLVZ7x7My2N6msAvd9peqmRM=;
 b=ber9aJO1OVj8oBykLcvYKQai2AJSmVTVcfhkYR13IGD3EzMmrBLPq36wTTp8SivGZNhhuha9RUjFhE0sBM12XhwELj4gKACGkyBHob41Uoo+V4pqix8dblY3upDaz2fseLLeVpokl/QXU/hU+o2ildVV0XinBovmb79xI2Y2n+g=
Received: from BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27)
 by DM5PR02MB2363.namprd02.prod.outlook.com (2603:10b6:3:51::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Thu, 9 Jan 2020 14:53:49 +0000
Received: from BN3NAM04FT011.eop-NAM04.prod.protection.outlook.com
 (2a01:111:f400:7e4e::201) by BYAPR02CA0050.outlook.office365.com
 (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15 via Frontend
 Transport; Thu, 9 Jan 2020 14:53:49 +0000
Authentication-Results: spf=pass (sender IP is 193.203.95.25)
 smtp.mailfrom=moving-picture.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=moving-picture.com;
Received-SPF: Pass (protection.outlook.com: domain of moving-picture.com
 designates 193.203.95.25 as permitted sender)
 receiver=protection.outlook.com; client-ip=193.203.95.25;
 helo=email.moving-picture.com;
Received: from email.moving-picture.com (193.203.95.25) by
 BN3NAM04FT011.mail.protection.outlook.com (10.152.92.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2623.9 via Frontend Transport; Thu, 9 Jan 2020 14:53:48 +0000
Received: from frijj.mpc.local (10.64.66.72) by LNDWSCAS01b.ad.mpc.local
 (10.14.193.79) with Microsoft SMTP Server id 14.3.408.0; Thu, 9 Jan 2020
 14:53:43 +0000
Subject: Re: Limiting what devices can pair over Bluetooth?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <85C0B54E4752CA4F873E7C78CF0B26F5020662DB2C@LNDWSMBX02.ad.mpc.local>
 <CABBYNZ++9739ptHJm+tiUUJANN_MfRpurvfdD=a4Qw3OHE-Epg@mail.gmail.com>
 <ac3d2402-abad-96dc-b042-8c8c7d592124@moving-picture.com>
 <CABBYNZKAkZLvce-MfpscV6Y=9+UBVXAdcVgKAWTH8HupW8_qVA@mail.gmail.com>
From:   James Pearson <james-p@moving-picture.com>
Message-ID: <10177aaf-cc9a-d807-9265-58bbb69c8386@moving-picture.com>
Date:   Thu, 9 Jan 2020 14:53:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <CABBYNZKAkZLvce-MfpscV6Y=9+UBVXAdcVgKAWTH8HupW8_qVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.66.72]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.203.95.25;IPV:;CTRY:GB;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(86362001)(81166006)(31686004)(8936002)(5660300002)(36756003)(81156014)(2906002)(31696002)(8676002)(336012)(6916009)(2616005)(316002)(26005)(478600001)(356004)(4326008)(186003)(70206006)(70586007)(16526019)(36906005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR02MB2363;H:email.moving-picture.com;FPR:;SPF:Pass;LANG:en;PTR:soho95-25.sohonet.co.uk;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1d61f5-add8-45e1-3470-08d79513bbd4
X-MS-TrafficTypeDiagnostic: DM5PR02MB2363:
X-Microsoft-Antispam-PRVS: <DM5PR02MB23636C22518FF73B360309D0CD390@DM5PR02MB2363.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02778BF158
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXOAsDkBUzBv4ACbquSQ5uT71PXd/go3X84gLOE3L4aIwV7kT4h5SgAH1aQ/DLU2rLZ98WtxQWG3SrmYXzryn0nevKMl19fzu2koZeJ7L5pXk1pWgybfMvdu1ijf8Yj/J9vpP8P2tIGyERNdRbDYEvgyi4GB/3nmLltXqa9VMZLqXIxx0uXithmt7Vj8h2LRalkwpdDieGmTzyMfI+6ZK7VLWsB4H46BWRnwoVRuiN51DDpF+yNQ+arH6FUCKalPqN5hjQsKAPBX5lcuWlbBaOAZVcKLvdH87Do4Dyngs1CPCqVBCaxb8DVXIrhyhTaYzhjKVd1zEXGp/GFF7z2sTPtXVbNM0GNGX88bJ8nLjZSmNMxEPne39NGqX5QiVJdvkpjz/Uv8ZX/xKHDmccs9lQdqu1HDrPYKCElQqKg9q3jAtoLTuNmeYp5qJrYc/dly
X-OriginatorOrg: moving-picture.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 14:53:48.0655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d61f5-add8-45e1-3470-08d79513bbd4
X-MS-Exchange-CrossTenant-Id: 036da35c-ba43-4e4a-9bff-72ec0f508621
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=036da35c-ba43-4e4a-9bff-72ec0f508621;Ip=[193.203.95.25];Helo=[email.moving-picture.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2363
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz Augusto von Dentz wrote:
> 
>> My aim is to prevent Bluetooth being used (in any way) to transfer
>> files/data on/off the workstation
>>
>> I've found that if I blacklist the bnep, cmtp and rfcomm kernel modules
>> (just leaving the bluetooth and hidp kernel modules enabled) then the
>> Wacom tablet still works over Bluetooth
> 
> bnep is for tethering, depending on the system that might be useful,
> and if you block RFCOMM you no only block usage of file transfer but
> also HFP, but perhaps you don't care about those so that would be fine
> to disable. Btw, for getting file sharing you would just need to
> disable obexd though it doesn't seems it is a user service which you
> can disable with systemctl.
> 
>> Would this be sufficient to prevent any kind of file transfer over
>> Bluetooth ?

Looks like with these kernel modules disabled, I can still use 
'bluetooth-send' to send a file to a paired (Android) phone ... removing 
the OS provided obexd binary prevents bluetooth-send from running, but 
it doesn't stop a user running their own copy of obexd

So it looks like, in our case, we won't be able to use a Wacom tablet 
over Bluetooth - without opening up a whole can of worms ... which is a 
shame

Thanks

James Pearson
