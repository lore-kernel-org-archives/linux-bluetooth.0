Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2599BC33CA2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B7420838
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 20:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=technicolor.onmicrosoft.com header.i=@technicolor.onmicrosoft.com header.b="H9R64iC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgAHUPe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:15:34 -0500
Received: from mail-eopbgr760092.outbound.protection.outlook.com ([40.107.76.92]:54319
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgAHUPd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 15:15:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnBCrt2jdDwfW+beH2z+hkl7daVwhUqPgmUSERTMWnOw1OBDFqMzGeYo/6obNa/kHfnXDkiWNUnv0nk1s78a9Dl/gxpW+LzTEptQvDjoqfDXF/xiYkHlc2BGQUyMeFw9Hc22z70zuk1+xQy72gYwkhfhbST0C6HWYAASdkWJ6e/HLHf2VB64bi0f+2YLVIY/r9GWkah2QWml8K33wdRxgVPmejxy+jEbH07l7vCEn6+u3J/VoUZh25QjUyPTDt1n6IKE7XifP0Q+aXNTmcaFTfbAIXN9RoQrvnvOOxf7v8ozQ+T+NAvdaTlT1QQWeCsOvTRWI/qjBiyunvViCdBNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEqSi63NKLmte8UfAhcNtFhdik6zCnYOp8TApeyhN/o=;
 b=f0ecq0GfHNwMdjOu/RNCuDyRidKAbWUEOPlT3txkUbgGORB+PzEyKbCGY5mGAAgcFMZ6ay4iK+Y6iJ610A12YkZXAp2hcJVnQ3v3NhjduyX0oGHRmjGtbVKmYz950h+BSiPx3WOMx+2CSIRIK4JjTelTneLmJfkJpQO6/v/DOtjM5exuNRU/6thVROsIpwED0T4s3Bs0faL4QfVHpJ0Q0ZZ8zR5XsWSolaS72VJWGMAUjwR0KK6/ldkpc2ghdgypvmcY9IVpceQWcESONKTawVU4h8EebJe1YflT2JjGHQb2k+jCcLTMxdWkcB2lM3rS1kQuhvr2mDZW25sQHtbz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.203.95.25) smtp.rcpttodomain=gmail.com smtp.mailfrom=moving-picture.com;
 dmarc=bestguesspass action=none header.from=moving-picture.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technicolor.onmicrosoft.com; s=selector2-technicolor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEqSi63NKLmte8UfAhcNtFhdik6zCnYOp8TApeyhN/o=;
 b=H9R64iC08ev/nv/Eg2i5kHQHUISBHVFKRaoIRGd+XvVq2S4Cyy3HLMZ5P9rulx4H45G8jd2Ij74/aYa3d3lkuvERQE/dPKPfSMIgJZBDRG7pg/6WHWu+Zc5DpO1DQD/Se+3VOIVHP2TMlGMoUxid3bxtmd4blWlh/o65OKWJlMM=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by DM5PR0201MB3576.namprd02.prod.outlook.com (2603:10b6:4:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Wed, 8 Jan
 2020 20:15:30 +0000
Received: from SN1NAM04FT050.eop-NAM04.prod.protection.outlook.com
 (2a01:111:f400:7e4c::200) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Wed, 8 Jan 2020 20:15:30 +0000
Authentication-Results: spf=pass (sender IP is 193.203.95.25)
 smtp.mailfrom=moving-picture.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=moving-picture.com;
Received-SPF: Pass (protection.outlook.com: domain of moving-picture.com
 designates 193.203.95.25 as permitted sender)
 receiver=protection.outlook.com; client-ip=193.203.95.25;
 helo=email.moving-picture.com;
Received: from email.moving-picture.com (193.203.95.25) by
 SN1NAM04FT050.mail.protection.outlook.com (10.152.89.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 20:15:29 +0000
Received: from frijj.mpc.local (10.64.66.72) by LNDWSCAS01b.ad.mpc.local
 (10.14.193.79) with Microsoft SMTP Server id 14.3.408.0; Wed, 8 Jan 2020
 20:15:04 +0000
Subject: Re: Limiting what devices can pair over Bluetooth?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <85C0B54E4752CA4F873E7C78CF0B26F5020662DB2C@LNDWSMBX02.ad.mpc.local>
 <CABBYNZ++9739ptHJm+tiUUJANN_MfRpurvfdD=a4Qw3OHE-Epg@mail.gmail.com>
From:   James Pearson <james-p@moving-picture.com>
Message-ID: <ac3d2402-abad-96dc-b042-8c8c7d592124@moving-picture.com>
Date:   Wed, 8 Jan 2020 20:15:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.5
MIME-Version: 1.0
In-Reply-To: <CABBYNZ++9739ptHJm+tiUUJANN_MfRpurvfdD=a4Qw3OHE-Epg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.66.72]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.203.95.25;IPV:;CTRY:GB;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(478600001)(8936002)(4326008)(8676002)(36756003)(81156014)(316002)(2906002)(5660300002)(81166006)(186003)(31696002)(16526019)(70206006)(70586007)(53546011)(356004)(26005)(336012)(6916009)(31686004)(86362001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0201MB3576;H:email.moving-picture.com;FPR:;SPF:Pass;LANG:en;PTR:soho95-25.sohonet.co.uk;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d31707ea-e8ab-4cd0-7df8-08d7947781dc
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3576:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35762F4D4E1A840CB71CFAC0CD3E0@DM5PR0201MB3576.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVs6bm5GUunQhfPILnzjZoOzp9IKql4r2g8eMvGXCodFboGJL5D5ffm/+Z5SjNgy9dHnLa5i08w6kVfemzECHjGVTELDBx1wffmksJp5xtkBc7eHBVuHZe4kT6r+JljLFls9Fr8k5d7hDXpL+pQpS0O04wWwIMLsqsS8M6QsowLFwiDk4GHrOJ0rFk3B6CHDvSVkj9t3uMx1n55Ig1Z0HTYRtkuxX+wObLQYMtxhoM+5hlV6ClOcr74sxoS4bwukTT0i7zRhDs/fM9SGqh0trGmGsmQs9Cvolk09lmEc7oOIpq0T9PSRIu+h8YT/OKyS+yft0YUlNCecz89owYyM2HPyBtwArDlbTqcfDTkD4gRbZqoyP5uva9Zkp++8wrlWLx9qPIh/VhJjWL5jqL8rswhMvrONZxgyyumW+pXl7kow1vhmtGgJpVIWJTE6NkD3
X-OriginatorOrg: moving-picture.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 20:15:29.2881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d31707ea-e8ab-4cd0-7df8-08d7947781dc
X-MS-Exchange-CrossTenant-Id: 036da35c-ba43-4e4a-9bff-72ec0f508621
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=036da35c-ba43-4e4a-9bff-72ec0f508621;Ip=[193.203.95.25];Helo=[email.moving-picture.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3576
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz Augusto von Dentz wrote:
> Hi James,
> 
> On Wed, Jan 8, 2020 at 3:47 AM James Pearson
> <james-p@moving-picture.com> wrote:
>> 
>> We don't normally enable Bluetooth on Linux (CentOS 7) installs for
>> security reasons, but we have a case where we would like to use a
>> Wacom tablet over Bluetooth
>> 
>> I would like to be able to configure things so Bluetooth can _only_
>> be used to pair with Wacom tablets (or just HID devices?)
>> 
>> As I never used Bluetooth in anger before, I'm struggling to find
>> out where to start looking - does anyone know how to do this - or
>> any pointers for where I should start looking?
> 
> Are you asking this from the system or user perspective, from the 
> system we don't have a configuration where you can restrict the
> types of devices that the user can pair, on the other hand there is
> nothing stopping the user interface (gnome, kde, etc) to implement
> such policy on their bluetooth settings, though be aware targeting a
> subset of HID devices may not be possible.

Ideally I would want to limit this at the system level - although I can 
not find anything user interface-wise that mentions limiting access 
either (although I might be looking in the wrong places?)

My aim is to prevent Bluetooth being used (in any way) to transfer 
files/data on/off the workstation

I've found that if I blacklist the bnep, cmtp and rfcomm kernel modules 
(just leaving the bluetooth and hidp kernel modules enabled) then the 
Wacom tablet still works over Bluetooth

Would this be sufficient to prevent any kind of file transfer over 
Bluetooth ?

Thanks

James Pearson
