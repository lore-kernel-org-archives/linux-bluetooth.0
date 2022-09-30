Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8976CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 19:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiI3T4q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiI3T4p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 15:56:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1B156568
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 12:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGIpdWSMj0avbiTfaaQ7i9V7kT2qv2E3YriXZAqByets5VkzefNjIX5wj31KmPUYOGic4uHOOBwgPVpzXzasJwOEXBYLws8MMJ8i4jirMQ8hXITTbzQvBPWMfDZCCEHVIW0aStkmgLmjwD+UYy0V1ULUhJdQ1tcGEshwB42uBQzX8q3cMsK8doxAd9mViekRof4tUw89Y/27tNxwpVBftbMM6KAtTt3Bok8vJQyBLeRB1+haG3KiP2TEbP3WGprUKVxWMlbu3kHVC0ehuM+FUIOxAUnea7zoGRKlDqXFBadNbqKhcRlu0lG1g2KHVSYnw0jeU7JKC61XMD9s4YcCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg2KgU3VVBsIhRSRCqm9PvJ89SN8sLF4FYT7p2SD/Zw=;
 b=mWUbx3k1tB85IF1tWQ8EDkuAmvfVsMaDZDfoEJyQ5zeSQ3v6JNva0YJSrIuCEAGqoaoK86+F+iziWVDKL52dCMTCsaT2ELgSSrBZ9/mps0L6MqPYkHKF6UZU6kR+CxqPDJrMNh15psCLgQjQGUIjhN319lHfjIvSuLwttXNbbfx/HrYQaTpPdLsFe5VLPIyjGH9J6/Tz2bueie0Kei+adU8N3aRbUEwfc9JOaY6UdL1+rJnuSMBWEiri2GrKhtdrKBb5WKJx8+VlOtZenNvKGz9WzVmNZ8zyjJlhFTFpXYj8reNnrQ090WvBz4jiNHvZveN2MWA2gWJOHvTDzE1NKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=none
 action=none header.from=arri.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg2KgU3VVBsIhRSRCqm9PvJ89SN8sLF4FYT7p2SD/Zw=;
 b=iGrp9RqYc9o9x5BY3zwrkjxXA+u9WpG3Dwk+d1Fuhg4VUdBajqD05r2bsxH+u31G+A51xqEyEGK4zrGrgG19xSJHXLEIQr87vsK8mpcWxV27FlykAjaSzlzHr9hXQ+gCGR5PB5iqxMmhRxNgB1/hy/TnEpnDEU4jygb91Pmjylk=
Received: from AM6P195CA0062.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::39)
 by DBAPR07MB6901.eurprd07.prod.outlook.com (2603:10a6:10:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 19:56:41 +0000
Received: from AM5EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::47) by AM6P195CA0062.outlook.office365.com
 (2603:10a6:209:87::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 30 Sep 2022 19:56:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT041.mail.protection.outlook.com (10.152.9.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 19:56:40 +0000
Received: from n95hx1g2.localnet (192.168.54.45) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 30 Sep
 2022 21:56:40 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothctl: Connecting to a GATT service using BR/EDR
Date:   Fri, 30 Sep 2022 21:56:39 +0200
Message-ID: <3455076.iIbC2pHGDl@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZKZBmxNK4P+PR-xFcOsDoYPFi8xL12oyYaCGMktirU1vg@mail.gmail.com>
References: <1906152.PYKUYFuaPT@n95hx1g2> <CABBYNZKZBmxNK4P+PR-xFcOsDoYPFi8xL12oyYaCGMktirU1vg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.45]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5EUR02FT041:EE_|DBAPR07MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4ea33b-f2a6-43f8-f902-08daa31de476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuBYVFR2e+DODKy7jwOO63HFdHZElf5naRu1XonGPGzCqWMIXFZYN1YMMF7bdRYs89ZXq3G7l6ezwS33g2LbNtHjSMAGLcGM1i9wXfXcYkaL2CD+PmFgk5NgZ3xOEFWXPYx+32diFewaYyc8xRDggIC/nX0T4Fq7kjdDWQmBugaVzA1xhdaLZKqFEkQSS2E5WoCTNL/zgnvIjjkD6ud/8bASsJmtM55WHlvWjt85iEw4yxtXThAD8Dq4BsbuN/ryjbUEmBDS21VncIcOClhwjT1UzjU52kehVveVar+KXY+D21BEPeTxj6TKHwwM++96rFhZcVZjGsTElGgrcdWwvqvUhi82K4pJa7/g36m22JFo44GlF1U92KDzqbSf5UNmis14KLfQM8enJqwblhHs23REdOQmkB1zQTqUhEV5D0MfQfjvBskZNBz0sFLadBOOGyMILaSyNlvdq2Jdu5MzXFXD/9vnT/bjMEQSQuGs0uLMx5U0hsGUlqwhTVmLbwrNums3jpRTU44+YGxLVK6oawoL8N4jrxW2yyucF7tjSW+qrQYK8Ttutw13aHXc6tq1onTkaeeSv7mVNcQd8krKshrjdpkTxh5V/8UCEoe6WMXcspfzNGrqG0gEd8BkWsz/bPFrZoe/7SuajeO/SZ8ad/3j8OxywNRCkMvQTsCS3g7beLtuqWXcgxAkBHUzDI5+T9zqxfLZaRywrTvRlcgekXS8jNmPrzi47vmi7eBbCoCXKjOUN+t7e9EZ0q9kBjAzgebmp8h9RqQhoBln2XcEtsv7/JHgiU17SSdjN8Q/Sg8=
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(396003)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(8936002)(316002)(16526019)(6862004)(70586007)(5660300002)(9576002)(40480700001)(336012)(70206006)(4326008)(83380400001)(86362001)(8676002)(426003)(36916002)(41300700001)(36860700001)(47076005)(33716001)(82310400005)(356005)(2906002)(186003)(82740400003)(4744005)(478600001)(9686003)(26005)(81166007)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:56:40.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4ea33b-f2a6-43f8-f902-08daa31de476
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6901
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Friday, 30 September 2022, 21:33:28 CEST, Luiz Augusto von Dentz wrote:
> Hi Christian,
> 
> Connecting over BR/EDR as a central is currently not supported, it
> will probably require some changes in order to enable it although the
> likes of bt_att/bt_gatt_client shall have proper support for it.

currently it takes several seconds to read 70 KiB over a FIFO like GATT 
characteristic. Is this normal? In which configuration I can get the
maximum throughput? Is it worth to tune the BLE parameters or should I
use BR/EDR  with a "classic" profile instead?

regards,
Christian



