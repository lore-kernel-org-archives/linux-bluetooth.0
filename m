Return-Path: <SRS0=lkeQ=RT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E71DC43381
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Mar 2019 02:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06685218A1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Mar 2019 02:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kmM+N2mI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfCPC5W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Mar 2019 22:57:22 -0400
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:53761
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbfCPC5W (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Mar 2019 22:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TOlbg7A3AxDH9RqxJGSuHJkrrehYs4sL6eFnFMwAHA=;
 b=kmM+N2mIJngARPq68R1LvxTBWvcSGhrFr8CAC+gGAcsfvoevvhv1HJaqKVqXszbNIwAjWMD4GZ4RbbLBgMPx4hIB0LeIXSRbQJjehvWca9EOAMs0Qf43xbkBQA8cvvpET12d/4fUwKNbstcQ9LOjLTxAbxHfusYxpC2BIVu8DaQ=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3408.eurprd04.prod.outlook.com (52.134.3.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Sat, 16 Mar 2019 02:57:19 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::d572:5bb9:4021:1f69]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::d572:5bb9:4021:1f69%4]) with mapi id 15.20.1709.011; Sat, 16 Mar 2019
 02:57:19 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH Bluetooth 1/1] Bluetooth: L2CAP: add return check for
 security level set
Thread-Topic: [PATCH Bluetooth 1/1] Bluetooth: L2CAP: add return check for
 security level set
Thread-Index: AQHU2t2ee6mCq6YSV0OHq3p6ZHO+bKYMvAEAgADV/MA=
Date:   Sat, 16 Mar 2019 02:57:18 +0000
Message-ID: <VI1PR0402MB3600FAB124E16F4FC8F10982FF450@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1552619793-29992-1-git-send-email-fugang.duan@nxp.com>
 <D29353D9-E94C-43C8-AE22-08B9ACC3C693@holtmann.org>
In-Reply-To: <D29353D9-E94C-43C8-AE22-08B9ACC3C693@holtmann.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdecc1ef-29c3-4eff-2cf4-08d6a9bb1ab0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3408;
x-ms-traffictypediagnostic: VI1PR0402MB3408:
x-microsoft-antispam-prvs: <VI1PR0402MB34080C52E43D9BFE194E34D9FF450@VI1PR0402MB3408.eurprd04.prod.outlook.com>
x-forefront-prvs: 09781D4C35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(8936002)(66066001)(6246003)(26005)(105586002)(55016002)(53936002)(9686003)(86362001)(106356001)(8676002)(81156014)(102836004)(81166006)(15650500001)(76176011)(6506007)(3846002)(229853002)(6116002)(446003)(33656002)(11346002)(186003)(7696005)(71190400001)(71200400001)(476003)(4744005)(6916009)(6436002)(2906002)(74316002)(305945005)(25786009)(7736002)(316002)(54906003)(99286004)(4326008)(486006)(68736007)(5660300002)(256004)(14444005)(14454004)(97736004)(478600001)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3408;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 59JNLTjLAFKk+4FN0q/GG/zHlMVm0Dg37U80xDOGekJOPq27uaALEsRIdov7ea2a7tlMRCcJ4GLvLi+iPVeARVZuonYQ6QI+OcaoIemKlRWJAKwFUJaMpapc6UfXendggjEazgK/038KfkNr6y+ceLNgZTbSV1NI9/lt6sBtrVr2Rsit+l2iV26dKFmiQ48jQmKDSTCHclrw32yWyNyjA9PiP18v6treO2diqJBY4QKa2zoMo4zfgVxh258MOr9wK2sRUlPAnAX1NMxNUHAgfW3VOmRZggDXQ36xB0+c6y4l3IOl3H6wcLpehzXif5lDTjTPiUt0/zqgkrebP6VpeBrsl6RlWcCyfBwt3BMUEfuCXa8VmraDyBwfF5tAExr7qzKfL94yjy83DQSHxCmxvAGLP0oIPa/xqLiQphg8daw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdecc1ef-29c3-4eff-2cf4-08d6a9bb1ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2019 02:57:19.0004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3408
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org> Sent: Friday, March 15, 2019 10=
:11 PM
> Hi Andy,
>=20
> > Add return check for security level set for socket interface since
> > stack will check the return value.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > ---
> > net/bluetooth/l2cap_sock.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> patch has been applied to bluetooth-next tree.
>=20
> Regards
>=20
> Marcel

Thanks!

