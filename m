Return-Path: <SRS0=sa2S=XB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9678C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 21:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891E721670
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 21:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sorenson.onmicrosoft.com header.i=@sorenson.onmicrosoft.com header.b="ZzaGz82n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbfIFVOa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:14:30 -0400
Received: from mail-eopbgr710089.outbound.protection.outlook.com ([40.107.71.89]:28736
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389682AbfIFVOa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Sep 2019 17:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH5vfSAJuIEtY+ABqY4YivkR9ZLQECeDO+j4kf9K+17OQLE/rEojJC+osXnqgVjs3QQ/U8nIX80wTLPlH1RTb4s6Tpr6TQKoR0v3QA330tem2lk+NnUyR8vkHc4Ai+jtrQgKzFF5jer35KspZeeOBiG3V45riSc8FxoUiUx/cKVXv+Pw7n65cafnNVUIzzwiOcBiWz+XHJcmwQuxKXR3mlKVAK09Y6OAbyhXWUfgi3o9qo9TuafougtE1YCqu8l3A99sR/PuZnqlHSuFRaFK/RYcF9cKFMKjRI9lCnSPTNmewA7d/xX2DwmgpMSDfnSBr0g8ZNOE9inq84Cwm3+pmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=navkV98dupYmulQwUeeWdTD2BZd8Q3voBwIsJ8lhxCs=;
 b=ZPVW1XSFGMVy2+2NEweRNqefZr6rN3J9tDEJirGzrWncJWAUe4ms78FENamc7k+xKc4RQkXyeIv8QLyuAafh5R09KXH9/lI5z8/JCoSFZPSWQ/spSJZk/bE9rSJx3RpmZuA/M2lS2Av+JQmulvyv0dPENisDygCj0JOJm9KWZpJp8szS3+ZBG8zQub0bIIIbKyexgCiN3KDI3hASVe3bDSd1cLJ807J9JoTrnlYNyL7y9PfJ9RCKCrA8kXbLVumO1LJQhGYrXG5GQzl1BM0UZrMhEz3juP5jeyy+/UZi0y+gJ1iiEjap7e6xit6Wr4fX5gUv6bqi3vRzt7VaTsZMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sorenson.onmicrosoft.com; s=selector2-sorenson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=navkV98dupYmulQwUeeWdTD2BZd8Q3voBwIsJ8lhxCs=;
 b=ZzaGz82nrqR5tS0vGQFBPxRVbDsGfflktTYn9YGVGnVBJJhPYrt8wh1MyiulBM2C/GXe4I4lPb4QVAGttssMPmYkwNnVvw0107D60+q4WTwP7/JPeNPWpVR1lmcpUrF8NnGZ51EL8EDRrR2wGkVXFbmzlmdWIvc7y3aGidlekGg=
Received: from BYAPR04MB5096.namprd04.prod.outlook.com (52.135.235.30) by
 BYAPR04MB5032.namprd04.prod.outlook.com (52.135.235.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 6 Sep 2019 21:14:27 +0000
Received: from BYAPR04MB5096.namprd04.prod.outlook.com
 ([fe80::d64:bddc:f2e:21ee]) by BYAPR04MB5096.namprd04.prod.outlook.com
 ([fe80::d64:bddc:f2e:21ee%7]) with mapi id 15.20.2241.014; Fri, 6 Sep 2019
 21:14:27 +0000
From:   Thomas Green <TGreen2@Sorenson.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: k780 keyboard
Thread-Topic: k780 keyboard
Thread-Index: AdVk95O2aFIEbHzJRHC1fordVu8Q7Q==
Date:   Fri, 6 Sep 2019 21:14:27 +0000
Message-ID: <BYAPR04MB5096402D65551A2ECBDE92DB9FBA0@BYAPR04MB5096.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=TGreen2@Sorenson.com; 
x-originating-ip: [209.169.244.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beadb8fa-8561-4be5-f835-08d7330f3388
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR04MB5032;
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-microsoft-antispam-prvs: <BYAPR04MB50322A2250C6D6C58B01DD609FBA0@BYAPR04MB5032.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39850400004)(366004)(396003)(189003)(199004)(51874003)(8676002)(25786009)(26005)(6916009)(71190400001)(71200400001)(256004)(8936002)(6116002)(3846002)(66066001)(81166006)(81156014)(5640700003)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(478600001)(186003)(4744005)(5660300002)(14454004)(2351001)(7116003)(33656002)(2501003)(7696005)(76116006)(74316002)(305945005)(316002)(2906002)(86362001)(7736002)(6436002)(476003)(102836004)(55016002)(9686003)(486006)(99286004)(53936002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR04MB5032;H:BYAPR04MB5096.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: Sorenson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o+RLqUVWnhm3hr7SgRA3jAe3joOcw4o4k1QanbE4pkT6mvVXyIOPoVR2BSJfc9z22SPzuQGRKH38vMkWGWtqyMd4w/HtxE2owsrAthXb1vFFrdrtuEvXTs8MBGjDMe6mUu6R8vysWpJg5aAAOf8ktpr8Ma3Xp23fUlapCUMhYspxggOUIihMTrBCEmIjKvo1D+XR2tNfA6t+W834m6REnGfGiZPOVe91yedXLgALU4THnfiRnWKMp+GKpVn07mFC/laoJkd2u5jbYIDmU+iCinyGPPVBniUCj0xzIvcoA/WJy1j6Ox7Cxy80g3MZoh68aHgm9GmVHBcnBdamxbEm/hE5gtGc9G1EAis40vwxdal5PBfAAQiSFXyI8tqqrsMG9IljBi5yTlE/NqR5KaJ0Ef1yt7IhkIcHc4vRcXtFaak=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beadb8fa-8561-4be5-f835-08d7330f3388
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 21:14:27.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6b03ef08-a104-48c4-a951-f18d295428d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqaDffjMBmebnhgMNoTxXWFpKHRYOAKObNPXuQO9NWly5ptp1iwxrPui2r87/L0FjZ8CkspS+5+F2U72RsLPdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

All,

I'm having trouble with the Logitech K780 bluetooth keyboard.  It will appe=
ar in the scan, and I can pair then connect the keyboard.  The issue is tha=
t it seems the final set up of the keyboard isn't preformed, and as a resul=
t is unusable.  It would seem to me that the appropriate driver isn't being=
 set up and the /dev/input* files aren't being created.  I see the appropri=
ate udev events when the keyboard connects, and udevadm info -a on the devi=
ce returns all of the appropriate information.  I would guess then that the=
re is a specific udev rule that needs to be made for this keyboard (as othe=
r Bluetooth keyboards seem to work just fine).  Any hint on the driver or u=
dev rule that needs to occur for this particular Bluetooth keyboard?

Thanks in advance,

Tom
