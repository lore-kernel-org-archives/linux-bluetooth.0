Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08A5C636CD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Feb 2023 06:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjBJGbr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Feb 2023 01:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjBJGbq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Feb 2023 01:31:46 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE712ED6D
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Feb 2023 22:31:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCRWQ0WVDOA65D2imRlMi1KXlEZqclpnBmeSeWu5Ry6+LfQRoE9x/niA/P0DkGu2RxysNSl8DOKYRdyE65yaD28H7JrLphyQjoB8G5q4rAVcDZ2epAB0cAI6iCcfWN5cOc/oH+ncB1qvTm5n6h/EhwCFjaxWMQVkn4sqp5GAJs0sXbKePdygKIuC/XRCjtC4t7lKWrufQuCA6Rij6OzgUmbvJyomhZ9zgNmMVVEdMvn++jSEhU1ZQ+oHhBtluej7Gd3GtOX9KcBnKkKnJY/NaX8UxGlr4w3oN0i2d1wCAaqjkNukvrK4lkEFErQ8yDFBb3qwKr7GsCFyyC68i0hRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IsLi2vsnCzgjn6e272C4t6x0bctc45TT9ibP1UfgDs=;
 b=D3VHW0Swdx1OoOkfEdfrxbYSHwhx+J3jeXU0DFgd/Z7CS4LSeOJHmf7BXRT6cnm+wzNEhnm6kMmetC/+hW5RiYsDJrBcuw0qGtBzHJrnZ5i2VGrBBW8UKAe6vVWz3QukAJU30Y9TpL5pWNxyWoUw5Pq53HDx0Zdjc82HcWgmhVwYpcnkTs2K75nMRWfwFIvTk0A+H3QvYoEH0FWpA4M3x1zhOLoIrsDZXyx/LKH/r/7Yw6yJGFVtvAhwXWcAynQamcGb9MO8jsLtFht1SWrHwBYH3wxkYvdCp41HM60tcvV9+vCVPhFit5KkwKXf2Bs/k5GDWMv3OX0xw2lct1mbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.19.86.146) smtp.rcpttodomain=gmail.com smtp.mailfrom=nordicsemi.no;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nordicsemi.no; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordicsemi.no;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IsLi2vsnCzgjn6e272C4t6x0bctc45TT9ibP1UfgDs=;
 b=ZGLT1VdJp5HXIuy4+QwkKVPIjsxvk+jb/q0VNFQ2FVn3ebrQSAbFdbVJANm37KnUNq0Nq/nRml0qex5+CjKw+EFnuNcHkT22EOMGzoXIsvOwKkvFX7gVFSV57kelK/S19okr3w05DHgYwoYgOTInHX02Lj2uRFNa+K+GAc6ZhAhGSZUrsJ/vh08aUcfx3xraj2Hg0A221iFcyf5/J9aojMCfNEel1zEQaYe6Al/xX5p3HAAIEzudOJGmlV8blOCg7sHF7+FflgJRCW2AHqSNspIAMRqdTL8QWkgxNu+xKIBaT6LffpaIQ2VABywy/TnNyZcuhR0D/qjS8gQdUKMUfg==
Received: from AM6PR0502CA0061.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::38) by VI1PR05MB7102.eurprd05.prod.outlook.com
 (2603:10a6:800:186::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 06:31:41 +0000
Received: from AM7EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::e2) by AM6PR0502CA0061.outlook.office365.com
 (2603:10a6:20b:56::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21 via Frontend
 Transport; Fri, 10 Feb 2023 06:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.19.86.146)
 smtp.mailfrom=nordicsemi.no; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nordicsemi.no;
Received-SPF: Pass (protection.outlook.com: domain of nordicsemi.no designates
 194.19.86.146 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.19.86.146; helo=mail.nordicsemi.no; pr=C
Received: from mail.nordicsemi.no (194.19.86.146) by
 AM7EUR03FT050.mail.protection.outlook.com (100.127.141.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6086.21 via Frontend Transport; Fri, 10 Feb 2023 06:31:41 +0000
Message-ID: <9d6f1cd9314e2258c3eb12efb90eba37a97b4299.camel@nordicsemi.no>
Subject: Re: [PATCH] Bluetooth: btusb: Do not require hardcoded interface
 numbers
From:   Tomasz =?iso-8859-2?Q?Mo=F1?= <tomasz.mon@nordicsemi.no>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Carles =?ISO-8859-1?Q?Cuf=ED?= <carles.cufi@nordicsemi.no>
Date:   Fri, 10 Feb 2023 07:31:31 +0100
In-Reply-To: <CABBYNZJY97dFQ9cdZR+JimNN+N=cyQ3yohZQW30bM1fQUuY2pQ@mail.gmail.com>
References: <20230207115741.122854-1-tomasz.mon@nordicsemi.no>
         <CABBYNZJY97dFQ9cdZR+JimNN+N=cyQ3yohZQW30bM1fQUuY2pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Originating-IP: [10.241.138.38]
X-ClientProxiedBy: exch02.nvlsi.no (192.9.200.127) To exch01.nvlsi.no
 (192.9.200.126)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT050:EE_|VI1PR05MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cec852-3cec-45b5-0ef8-08db0b307896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfzfmWb8p/9b8vsiw+6AD4ciR4eA8rA1Yu86pZS9IVSxmTAxHBSa168FaiFr98rHfOAxWDsXlY96mO1rqwZQjpBiQX2Pr6MCC49BxjSSaNYo7BGQ+8u7pFNTQh+ltL+La2ubS/xLOKL0/GZo5VEXlqSYnTtZoLVUDoBoOSaWWWVPNi/462bO9HUmQtSV+86KeUkK8YIgpvyMDweT1/ukZgJPrhufcIUdXHEo9Vnjl35bU226sPP47wOrYEZy+ieryQ7aXXBMdbQqY6k51nIAVG4iU9x73cSV54kTBI0L9Sh7OLr2nnsz+7uknrhfoyOpVvYpvaAQTIplzimgEIJ/QsgkqN0eXHHL6Nc91OT2ZeXexmrPNcVD6VeijlB/lINdmLZP7E0+EX2JP/SYwQem/dtt0AEMZEwQ/xvHoW6gJmnsaaIgRl1H8f8mVuG1nJdveDPL2Qh0RXj9fBC6whKnSRX/vV3266IS4QgsNQZDYuiL4hoFGy5Rr67XffsuZJ+q+uqReH5Q9A9uuLK5uAHtmG2O7oajLZO3ZRqCpMTz03RnVixnM6MIs8xZMc5M5IIILqkyfKC9X332RgZQDXV8fqwEKBIzXp1f8XQbbqQHxE2hqXIpyBgNb8vVF/t2AqvOK/3M3nqFc7HTQTApaP/OCGE+zR+H+ipTSLKe4cu7M5M=
X-Forefront-Antispam-Report: CIP:194.19.86.146;CTRY:NO;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nordicsemi.no;PTR:mx01.nordicsemi.no;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(136003)(396003)(346002)(451199018)(46966006)(36840700001)(66574015)(47076005)(316002)(36736006)(54906003)(82740400003)(7636003)(36860700001)(36756003)(2906002)(9316004)(82310400005)(86362001)(356005)(118246002)(4326008)(8676002)(6916009)(83380400001)(70586007)(70206006)(41300700001)(8936002)(40480700001)(5660300002)(186003)(26005)(478600001)(7696005)(956004)(6486002)(2616005)(6666004)(53546011)(107886003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: nordicsemi.no
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 06:31:41.1868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cec852-3cec-45b5-0ef8-08db0b307896
X-MS-Exchange-CrossTenant-Id: 28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=28e5afa2-bf6f-419a-8cf6-b31c6e9e5e8d;Ip=[194.19.86.146];Helo=[mail.nordicsemi.no]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7102
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2023-02-09 at 13:32 -0800, Luiz Augusto von Dentz wrote:
> On Tue, Feb 7, 2023 at 3:58 AM Tomasz Mo=C5=84 <tomasz.mon@nordicsemi.no>=
 wrote:
> > Remove hardcoded interface number check because Bluetooth specification
> > since version 4.0 only recommends and no longer requires specific
> > interface numbers.
> >=20
> > While earlier Bluetooth versions, i.e. 2.1 + EDR and 3.0 + HS, contain
> > required configuration table in Volume 4 - Host Controller Interface
> > Part B - USB Transport Layer, Bluetooth Core Specification Addendum 2
> > changes the table from required to recommended configuration.
>=20
> Can you give it a little more context, is this supposed to be the case
> for LE only controllers? I assume this shouldn't cause any regressions
> for other controllers right?

Why do you think it is the case for LE only controllers? The Bluetooth
Host Controller interface is not limited to LE.

I believe this doesn't cause any regressions for other controllers.
Because I don't know anything nor have access to the Apple-specific
(Broadcom) devices that have BTUSB_IFNUM_2 flag set, I left the
BTUSB_IFNUM_2 check intact. It might be that the BTUSB_IFNUM_2 is not
necessary after all (and was only added because of this no longer
necessary hardcoded interface check), but you really need the actual
hardware to tell.

Note that this patch is merely removing the no longer necessary check
and otherwise leaving the communication intact. The hardcoded interface
check is preventing btusb from attaching to Bluetooth HCI controller in
a composite device that have some other interface under the number 0.

The composite devices that previously failed due to check do work with
this patch, because the specification (Bluetooth Core Specification
Version 5.3 Vol 4, Part B 2.2.2 Controller function in a composite
device) says host **should** address control packets to Interface (and
not Device) while at the same time the specification explicitly says
that the device **shall** recognize the HCI command packets directed to
Device.

Because **should** equals to recommended and **shall** is mandatory
requirement, the btusb driver is actually compliant even if it always
directs the control transfers to Device.

--=20
Tomasz Mo=C5=84        | Senior Firmware Engineer
P +48 882 826 111 | Wroc=C5=82aw, Poland
nordicsemi.com    | devzone.nordicsemi.com
