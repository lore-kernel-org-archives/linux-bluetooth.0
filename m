Return-Path: <SRS0=YCPJ=M6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A37ECDE42
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Oct 2018 04:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1095D2145D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Oct 2018 04:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rivetnetworks.onmicrosoft.com header.i=@rivetnetworks.onmicrosoft.com header.b="UbkdzZ5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1095D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rivetnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJRMhC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:37:02 -0400
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:25950
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbeJRMhB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Oct 2018 08:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivetnetworks.onmicrosoft.com; s=selector1-rivetnetworks-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRdGE6bcOjXA64IxKxX1Ky8Sk26FaZQOmoQBNtsyTpY=;
 b=UbkdzZ5P/08xa15u/gY/351u1kQ3id/VrdMJoKtjJhtv9ypQHowD6QYm8EYCQVtoPnDIhX1l477Mqyg1b830JD7/kXeEz+tU4KKKpehVbzzNzAgkH6CHnPm54BXXQX3SOkMmUTo14yIJ0KgRpwJvIJMLQdF+tx7zxer5zoX3/sQ=
Received: from BYAPR04MB4824.namprd04.prod.outlook.com (52.135.240.95) by
 BYAPR04MB5222.namprd04.prod.outlook.com (20.178.48.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Thu, 18 Oct 2018 04:37:57 +0000
Received: from BYAPR04MB4824.namprd04.prod.outlook.com
 ([fe80::7:ada7:f569:56a8]) by BYAPR04MB4824.namprd04.prod.outlook.com
 ([fe80::7:ada7:f569:56a8%4]) with mapi id 15.20.1250.020; Thu, 18 Oct 2018
 04:37:57 +0000
From:   Owen Lin <olin@rivetnetworks.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME
 device
Thread-Topic: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME
 device
Thread-Index: AdRlyzBRyKmdvuKsTVKLVI10cyukzgA0Q1TQ
Date:   Thu, 18 Oct 2018 04:37:57 +0000
Message-ID: <BYAPR04MB482471C4A0CCF70A48406336C0F80@BYAPR04MB4824.namprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=olin@rivetnetworks.com; 
x-originating-ip: [118.160.118.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5222;6:ywmXR9EnUv9ucBzhvcM6Lk3GZUbkzjRvNjbjG77+XALbH8ME2lRlklHygFD39XaLknbsgznCFo5z+iYFD+Ax58G05MPCxvU/ntfMvwoOzGF8tkqKfYxK+PWkMS4/SF0CJHalRq5SDx+tcjL+8iFp2SAMvE0h6TX9NRluYm9IVdB+xRSOYaq30HpTuobKbPbE/4jV4JGOsHD+fqWwAcnqBEB/jTrsHpONUfETrnmMIKu4uZmD5qB2cTBp8D7jx+WHLhmuzxl8vIwH8fzsD1peNunG/TIAj/ryRYcIRE53cEhG7VdA4z/0ldpIx3IsIDirF7BNsHO198X9TIt5rh5fTLDhB5nDNQnse9kRnCIb4cb3W2H4fZi9yL4vstUa/UHIW1txUtd4AtU03kpD1USKbHYP/8fsA4N8lKPHJ538hSlOpDQcI7d5mDcEUaCjT945MSXiriJTvS1aWSiIZKLZrA==;5:9cM9LlL4y2c0byinOjSpRHnXPW7qLvdkg4bVU81IksXolGWlXibE6zikpzNm+hEGWZUlSr/e94EkjzYC/z1SFL2VXoQ/FMed31/v31jFaIbUXikWIoSDSJ77Csda0cGpV9J+Z051I+vLpoZ6KHfPPd42xz1VI5/W8djdfq0ezgM=;7:ztix4zeFyT+VcTQFBuWhW21IMEc5iPrpYPZAfMacAuW0s5xabZKrKfydCX1aiX8M4Nrccy8j5eLWvxXmQ9Kvb8l2lXbF9JYQWFaprkJ96rhAjWhp19e/5avoK0lEAE2F77XbpF5+UcRbxH5qDyyM5hpxjivzax7dXJXUvZae2pb2IdEJlGUQrWyUH/WAzQ9qlVyBlmChAKdJGvf0APRItFTuCf+/I5xD2QVjp6nvvs6RjCdE/85IgclL1n5i+pfa
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5e98b8c9-fba6-4bd3-4f1d-08d634b37a25
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(7168020)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5222;
x-ms-traffictypediagnostic: BYAPR04MB5222:
x-microsoft-antispam-prvs: <BYAPR04MB5222FBCCE9F26A9AFF93CE14C0F80@BYAPR04MB5222.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(163750095850);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB5222;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB5222;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39840400004)(376002)(396003)(366004)(136003)(199004)(189003)(256004)(33656002)(74316002)(2351001)(106356001)(5250100002)(5660300001)(39060400002)(3846002)(71200400001)(2501003)(68736007)(2900100001)(54906003)(26005)(6116002)(2906002)(86362001)(71190400001)(575784001)(4326008)(476003)(486006)(25786009)(105586002)(186003)(6436002)(8936002)(99286004)(6916009)(55016002)(14454004)(8676002)(97736004)(7696005)(7736002)(66066001)(81166006)(305945005)(81156014)(9686003)(53546011)(508600001)(53936002)(102836004)(316002)(5640700003)(6506007)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR04MB5222;H:BYAPR04MB4824.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: rivetnetworks.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: uTUNudxFDG+A41hWr2PFfOqxXEANWQD6N8ng8f6Fy6MPjwBwpuIz6Vxp4+FIEAcIjg0yUsuy2X/K2cBULyKCIJnbzE72NgivI0JcoW66NkwxOM7p+Z6mNL9TAzR0trFor4d5MjODDCoUEjtgNO0TuJ5ZZBWkshMbpUJ+1qHZWZTzMh4oCejSF5MrI0+/xmvzwS88HQZ85DVChhqcJsrp3hFlpYO8d9Yqq3c9x1bc2wtSJzm6JhLUI4JuahDyjKKLH9joNqpE6pku5ZPfyltGb+43sHNgTzKG9ff/Oy8rQK+98H205dJJjeoAJkWCcOucINpCHS9GyBcbYjopToe6l7tZrt2rLRieHOiHEZ53+So=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rivetnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e98b8c9-fba6-4bd3-4f1d-08d634b37a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 04:37:57.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e27518f-156c-4a83-913c-35a21658318b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5222
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From 83372e39753124ab1afbe651a45e3416bede25a6 Mon Sep 17 00:00:00 2001
From: Owen Lin <olin@rivetnetworks.com>
Date: Wed, 17 Oct 2018 11:36:03 +0800
Subject: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME de=
vice

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D03 Cnt=3D02 Dev#=3D  3 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 2.01 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0cf3 ProdID=3D535b Rev=3D 0.01
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms

Signed-off-by: Owen Lin <olin@rivetnetworks.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cd2e5cf14ea5..838af7dd5b73 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -264,6 +264,7 @@ static const struct usb_device_id blacklist_table[] =3D=
 {
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info =3D BTUSB_ATH3012 },
=20
 	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0cf3, 0x535b), .driver_info =3D BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info =3D BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info =3D BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe010), .driver_info =3D BTUSB_QCA_ROME },
--=20
2.16.2.windows.1
