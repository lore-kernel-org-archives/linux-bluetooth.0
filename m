Return-Path: <SRS0=K0Cw=M5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ECDC5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C68214DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Oct 2018 03:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rivetnetworks.onmicrosoft.com header.i=@rivetnetworks.onmicrosoft.com header.b="SQ4zPccu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C68214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rivetnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJQLe4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:34:56 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:41412
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbeJQLe4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 07:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivetnetworks.onmicrosoft.com; s=selector1-rivetnetworks-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/S2D0oeUvHIy3ioQFZ477aBpTqzJRDn94BR+zcj9Pk=;
 b=SQ4zPccuKYK5m4w3w1yAAD+OQqwM8WVGrIQRm1KveNolf2wXxoViIb/OH5Ddyx6TA0V1JbRdyqIEYzTBA6TPiyekDb+pqzNoZe/meRlwUdu9FgI/B3qZ6xJRvhTsjnR1v26Gn64x6zJuQiKhNX/Wilqcr1vV81ATP2gHsCpu8qk=
Received: from BYAPR04MB4824.namprd04.prod.outlook.com (52.135.240.95) by
 BYAPR04MB5016.namprd04.prod.outlook.com (52.135.235.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 17 Oct 2018 03:41:17 +0000
Received: from BYAPR04MB4824.namprd04.prod.outlook.com
 ([fe80::7:ada7:f569:56a8]) by BYAPR04MB4824.namprd04.prod.outlook.com
 ([fe80::7:ada7:f569:56a8%4]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 03:41:17 +0000
From:   Owen Lin <olin@rivetnetworks.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME
 device
Thread-Topic: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME
 device
Thread-Index: AdRlyzBRyKmdvuKsTVKLVI10cyukzg==
Date:   Wed, 17 Oct 2018 03:41:16 +0000
Message-ID: <BYAPR04MB4824479589D351B829CF3391C0FF0@BYAPR04MB4824.namprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=olin@rivetnetworks.com; 
x-originating-ip: [118.160.118.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5016;6:3hn9yXkvwBT17yRUv5W/I8oIQcmu99Ngqi9BWYeXdToR1USoNUJldwsXM39bP9ctvFa8DeRywEO3G9SCjG9Ged0K+m7syqciD4xFukbrJVXc53bKgsyTNBWbi6RbjXJcQtpqjCYAqTdnpd1Zh87OnxYsL+x1S/iSzIUoPzufng6hkfzd0i0eFuZEfj16vkdCY+2tc9z9x+oqMSqtUhiwaonglCEVg+4zsPG+XH98zrFFAnoAEQRkyuQIlNxotA0QqWo9J0nDd+1NbIASz1lNB4A/WgybaKTp6FiTIHdHoVZXDovZXIYbdbQLBvsHEg1WNL0906FsSayG6jX/n9sGFkEW+rdvcJT9NAnP+rkzUZ/tnAkq3Sx9DZaqZj/KOFNL/bwtVwM1XRq/vnft6TlJUxOL5Z3tykTBCt1+3CJPnO07aZ9SM9ljTsSzXEomTKVzlkczxQly3VHzIExNUpzJEA==;5:9l6QKrghNh5aHamJmV6hiRvpHoslWiVwpMAny76G+MKY13YQ+0OUIEdP4R6LKmGt6+RUZhsxr2Zc0gF6lNek3iYeuj+2O4faqu4a6pO/5EXMN7mDpOs3JdSitMcsfvCE++lWlNhrjYVGpMv/jg0bFYelKXV+SWuL/Z2bActDswk=;7:5FJe0ncKGy5lGS7qZrK3dZx+9C0MvxYbRMACw8cWLp+NpJwebTJVvREL20rS3rFvgFnwDI663ElQyuljF5PQOrJqeUv1mifQ+HW5Nr+Y2DvoxWdkb+KVqPaSz8ISmrGiE0Efzt185fpV3V5iriKKkDaetUUhOKIIf0EcnwjFziI/49McnqIc7SHprUqUuZW+pdcYEQk4IDj3Crk5/Qaf6irwo+PwEenCJdFb6odGh0D2u1sIGnEUm99SiAPkw2Li
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ca556624-d49e-4454-4f5f-08d633e26524
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(7168020)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5016;
x-ms-traffictypediagnostic: BYAPR04MB5016:
x-microsoft-antispam-prvs: <BYAPR04MB5016EA0C41E2B6BEA0576E8BC0FF0@BYAPR04MB5016.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051)(76991088);SRVR:BYAPR04MB5016;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB5016;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39840400004)(396003)(136003)(199004)(189003)(508600001)(6116002)(86362001)(575784001)(256004)(54906003)(4326008)(3846002)(5250100002)(6436002)(2501003)(5640700003)(105586002)(106356001)(8936002)(81166006)(33656002)(316002)(9686003)(2351001)(81156014)(39060400002)(8676002)(26005)(55016002)(71190400001)(71200400001)(6506007)(186003)(7696005)(66066001)(55236004)(2906002)(53546011)(6916009)(68736007)(97736004)(5660300001)(102836004)(476003)(14454004)(305945005)(99286004)(7736002)(53936002)(74316002)(2900100001)(486006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR04MB5016;H:BYAPR04MB4824.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: rivetnetworks.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: I+kdLO/ZNneZNSmiApL72jWriM3hFLpo4NuNc6Xr1p6Gwlf6MypscJxF/+iISvKDHUqxqM+nVNIobn61avYogimaLKEPkX8OPq1j3+GQZ1DHuq52bNXGQ86SJKsDSf4q0A8iDqYHAj5m5joD23Oa8qOTyxM+GIhVmPK9dukN1oZHtu49jTH5yvq780FERQ6mN4ZvxkP3SHosGMAd+RRWh42fKMg0AktSS48Xha2zWTESlzUOvoJBfJZ63tqearLidkYggzx4vn5OO4UNDQFAWuNZa/pZeBPvSJCN2pFIcIbcimkEHSVad0Bj1aPhosLlPCpD729yIOTuEsrxZQd5EXWxvLjwP6yeWyu2YtKAWqk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rivetnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca556624-d49e-4454-4f5f-08d633e26524
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 03:41:17.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e27518f-156c-4a83-913c-35a21658318b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5016
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From 83372e39753124ab1afbe651a45e3416bede25a6 Mon Sep 17 00:00:00 2001
From: Owen Lin <olin@rivetnetworks.com>
Date: Wed, 17 Oct 2018 11:36:03 +0800
Subject: [PATCH v1] Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME de=
vice

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
