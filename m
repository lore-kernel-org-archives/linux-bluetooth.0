Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6617C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 07:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EFA020738
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 07:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oulu.fi header.i=@oulu.fi header.b="NvhBmfhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHSH3X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:29:23 -0400
Received: from mail-eopbgr130133.outbound.protection.outlook.com ([40.107.13.133]:51424
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbgHSH3T (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 03:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKCuxRjzuVASuHWREhH/TvwGjO9Xjf8Asx9SkZaL0uonqbNG31MMEwR8J1pQxQ82lDWOQd+UDeeUc2LEMeYH2+RRkaFKDbgRfux7kUMdqMW8/SqBBEKf/QccM+ylVh7nyKUvLafCh2Pte1g3eCF8pxFTmcycGjmIbGf1X3m4RX1xdxFrecpVfI1y9ypR04Cslx0OuPrAAGswJa+z4MPZCAwzmZ0gL0XOYtexlaDxRruaaIGIZfTKo1w+/q32fyyV2iEU6zfpIisgaRCnY7tpM5IY8gDjhg2IaR4wf7xvTkwD0VrlZdmNN+E1MPOaQdr7bg+BouEukZIUlTSVbPA31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTuHZu4ghcuEmjpo2HwGhzPbVqtMAFvCR16xDlsKyrk=;
 b=fmPwHY1JJm34mYgZBa/sHcQBct/edS1QZ8X3mjICSAGi+WPdXfTKzSMxfk/IrWt0PIryqt/juWCew8q1u5TLgGsMyG5qUabQ0xuSeLNuva8DT60f4du1OJfeU/YCt3MBayHkUgwFh5E3fOqjoutP4axGfxfj7s1q2W9C1iDBOAe/7S627wxOphb8iNEYCY9tBhD78wktxSdv9dWjiZ/cB4NLEtj4iVSEIduzYa28QT0rtk0A+Q26Wi1/euMA04CsWANg6FObyOqWIYp9fg2EG5B4EDq3+10mPbk9mtYOrFCf7YVC1qD2CZQplSwvf5GHRoEjZp7Ndh7L3kyh1eRVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oulu.fi; dmarc=pass action=none header.from=oulu.fi; dkim=pass
 header.d=oulu.fi; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oulu.fi; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTuHZu4ghcuEmjpo2HwGhzPbVqtMAFvCR16xDlsKyrk=;
 b=NvhBmfhT+D+pfFb5wbeh3OPxflM9yXriUbUXlxnrWpBbEKkgZSPwq+c9nOqiDpxsrYXtHDamL0lIehQt3ho3ibBuk1C1LOfY6wwZqiccJkufV5Pu95ys5p/UWdmvrlnYT5F31VUAfRShpzhEINOcH4HLG7uVupfXFvovV0ClOkQ=
Received: from HE1PR05MB3338.eurprd05.prod.outlook.com (2603:10a6:7:2e::29) by
 HE1PR0502MB3754.eurprd05.prod.outlook.com (2603:10a6:7:8a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.24; Wed, 19 Aug 2020 07:29:15 +0000
Received: from HE1PR05MB3338.eurprd05.prod.outlook.com
 ([fe80::686b:c547:31bc:fdf4]) by HE1PR05MB3338.eurprd05.prod.outlook.com
 ([fe80::686b:c547:31bc:fdf4%6]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 07:29:15 +0000
From:   =?iso-8859-1?Q?Jari_J=E4=E4skel=E4?= <Jari.Jaaskela@oulu.fi>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE Secure Connections: Disconnection after pairing
Thread-Topic: LE Secure Connections: Disconnection after pairing
Thread-Index: AQHWdfmu1mjwZR5E3ketvt6EmmVpvA==
Date:   Wed, 19 Aug 2020 07:29:15 +0000
Message-ID: <HE1PR05MB3338001B735642B334087FCBFC5D0@HE1PR05MB3338.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oulu.fi;
x-originating-ip: [37.136.11.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bfd1059-768e-4546-84b3-08d8441193b5
x-ms-traffictypediagnostic: HE1PR0502MB3754:
x-microsoft-antispam-prvs: <HE1PR0502MB375428EBF0DCE7607EF2556AFC5D0@HE1PR0502MB3754.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1DrwgiGjD/zdfU05/AEUnc41gV6Q1fU2n301BdBiEEo9NJLtaKd/GEdwpMD+kkIncrzXbIosKEP4Fb6x2eGfxXFv+QC8yXFAgY8bkh7xpq4Tr3/o/fHhdlwrrndvSBJwyXdWfUX8GirH3DAB7ANhbmNwWezdbz/Nw0cI9TS10zrsQ8WWEARDve1IgFzham+SdHL2QlnmYtSqogBVYj8RA3aeW0g8YBXTYWtmyYeeeGX84p0vBvCHZQCbXqXi0U5R224LqAP59tLcAWYs526oHd1VU9RHd/0bzuvG20piTFA94+OJWiFFX+KYx/lKJF0uH1GLn3kujC5E7MWvH6aON7lmokaYQu3G9cC2xV+OoH9Aza/MoRf8pNaWvXoNAn18PBY/lrxLmiMY1uDhxsA1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR05MB3338.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(8676002)(6506007)(66556008)(66446008)(64756008)(8936002)(26005)(5660300002)(7696005)(4744005)(55016002)(66476007)(478600001)(9686003)(966005)(2906002)(316002)(786003)(186003)(71200400001)(86362001)(33656002)(76116006)(66946007)(6916009)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XKIHxxu/fIJEqg4RcVQqhtebmsoyOwDpPJuYHvy4Rhibe7cmnkcWv8B2IU9Fo6zbVKFLQ5hm0/2Cm0SPYCs9/JLErBnrPFnHnRLrLWYBwms8qDniQ1doUGJZzjQcZUqd83P/JryB9AN5CPjPGulyjWOQqzHwqGn9z3RDLCSxYiTYIUaR3BLsSQOAYiQ1Jy5+37tOslgEBWGT6lN8/vY175aPL7R+TLv1lVFigLSo3WVSX/ZXrlweN2+YNVuDNIu0LWv0pRwJAtS6ptbYB3WYkCASOmLpgyZlUj91ADblIA3MWKfmy5vLEYFysv4DSvBsB34QtJwN4CH34RNbYvR/Ixb+8MPs+yDdfMs6UX3P+a4aYfn5J7gQSEijYh1NtQxd0sIhWwhcvxyBjhE1dyVTMSj9uB4TTBtSOj5sDm1ZjPzWWreK3jS1iDLCogS7dMMwLPFqTmi7SN539i2KMpfw4juJ7eT9Jc/4YdUMg2SMn7gQKIoNzSR4XKE8tt5psAej9gm46kT46rKAnqCgqfPpK5Cf5+8Ok26Qa/qfZtkdJk28xrxZ6bhsb0IyFIAN7VI16UlkwWlPCGZWQqEwmfY1Wwlkq1F80+fZfj2By0yWK7tF3rRq8Ynp+Zv7f5+Ie4i1BzC77FGcgJFB2aSoyBo6tQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oulu.fi
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR05MB3338.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfd1059-768e-4546-84b3-08d8441193b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 07:29:15.4815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f9ce49a-5101-4aa3-8c75-0d5935ad6525
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXKvGcF68zzSKjBIE84DxjWqYKuCIAQtzf6evf6TktAGH6MvonZB+0unYK1ToCSVLcR4f23HA7oWV3Q/ZNU8g8p+4kyTWe3zNcvMUgnszgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3754
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey,=0A=
=0A=
I encountered this issue in July, and I reported it as a bug here:=A0https:=
//bugzilla.kernel.org/show_bug.cgi?id=3D208637.=0A=
See the bug report for logs.=A0=0A=
=0A=
Here's the description:=0A=
=0A=
I have been trying to establish secure connection to a gatt service. Pairin=
g completes successfully (using out-of-band data), and the client can read =
characteristic that has encrypt-authenticated security level, but the conne=
ction is lost soon after pairing (as seen in the btmon log). This seems to =
happen because the controller responds with reason Connection Timeout (0x08=
).=0A=
=0A=
Hardware: Raspberry Pi 4 Model B (Bluetooth chip: Cypress CYW43455).=0A=
Tested on: 4.19.118-v7l+, 5.4.42-v7l.=0A=
Tested BlueZ: 5.53, 5.54, master (commit 6ea1b038eedeca31c3796ac921e25509d4=
8d70ec)=0A=
=0A=
Best regards,=0A=
Jari J=E4=E4skel=E4=0A=
