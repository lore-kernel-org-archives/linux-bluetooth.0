Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10002C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 08:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EF1207FB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 08:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=BluetoothSIG.onmicrosoft.com header.i=@BluetoothSIG.onmicrosoft.com header.b="zyUvaw0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgEVIWQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 04:22:16 -0400
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:56199
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728208AbgEVIWP (ORCPT <rfc822;Linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 04:22:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AytFcUNUr/a4vznsYCgzzxpXb5Ex2wBrC0yh7ozRHAEL38KQ8PWJ1IV3nWaIN1Qr0qIkrJpW1ekyKxstnXUKcPJwZuQOdgYNdd6JMXNkQk1EZVqeiWWhnKFYGblikzHJwDXQ351ZPaagpaqZrVUzTQhXoezZmJnggC8sPYAx94XES68bl08am9i/CkR4gDO2xSlKZheWS6njnOadwq9OsQyxDbA5hbg93VBkvjG+P9RytHsEpbkgAIUzRCoszI3tb/YyuzfIK4tF1R3ZfcG+SA5h0nVneCKKFQdGi8YnVM3b56HTAFebFprItePTUykiQivIgq7yvtXZkmmiYB5PWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96bqP975Lqtg91JDHumKkjHLFzJxfgraQtG34I5QlIk=;
 b=m8pBv2xxueaN/Tphs3NxiVJEDPRkgv1knwzIiNscIypOfRugiIsnmmyZ8jcc3ItnsaP3wsiwVBU56/svnyIAFzGF3ifdAy6teiUVePwRf66UgitkjspxHVwtbPR8/UjI/mo+g4OZ+/lxPpxdBr296Xu+d1BVjn8KzSDwS7wptszJeYyVHTgm3tbTxayhE07Mb3+Lb2VYWMmlbv7YYViqDFbp6LUgFEWu7K64XClNjp6UDJwrL3RhCuoFZStxKwF5PE5idjpI1BfcNY1kcl2V6u+H/rAV7gvWVW92pMWIcM6FzOLVOD5aXxC7FtFjSXNffSzKHb75YW7i0zjy7O/yfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bluetooth.com; dmarc=pass action=none
 header.from=bluetooth.com; dkim=pass header.d=bluetooth.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=BluetoothSIG.onmicrosoft.com; s=selector2-BluetoothSIG-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96bqP975Lqtg91JDHumKkjHLFzJxfgraQtG34I5QlIk=;
 b=zyUvaw0Sl2axQbdjGp0Si3aTB1ORQ4hafElTZ5LjW40/07HWIz7xj1c+Fbs2L6TswyZaNzwTuGciudozpHzwRWI9hAN7pLc7GwQfokbwMILxUwhWb6OYA+Lm91CtL7V4vqiIiuOeluPx9/MgIPjraqrVeVMAWqRoD9E1rUS3ZYE=
Received: from MWHPR17MB1967.namprd17.prod.outlook.com (2603:10b6:300:85::20)
 by MWHPR17MB1598.namprd17.prod.outlook.com (2603:10b6:300:cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 08:22:13 +0000
Received: from MWHPR17MB1967.namprd17.prod.outlook.com
 ([fe80::3d71:790:b047:e941]) by MWHPR17MB1967.namprd17.prod.outlook.com
 ([fe80::3d71:790:b047:e941%5]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 08:22:13 +0000
From:   Martin Woolley <mwoolley@bluetooth.com>
To:     "Linux-bluetooth@vger.kernel.org" <Linux-bluetooth@vger.kernel.org>
Subject: Comments on the ConnectDevice API function
Thread-Topic: Comments on the ConnectDevice API function
Thread-Index: AdYwEgyeeFpEUtO5S3yfGGFiF3wWKw==
Date:   Fri, 22 May 2020 08:22:12 +0000
Message-ID: <MWHPR17MB19671EAD4D74EA7BC5915CA7C5B40@MWHPR17MB1967.namprd17.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=bluetooth.com;
x-originating-ip: [82.35.96.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55239f9f-35bd-4c92-b93f-08d7fe293ad9
x-ms-traffictypediagnostic: MWHPR17MB1598:
x-microsoft-antispam-prvs: <MWHPR17MB1598CE357A5865A4AFC91F97C5B40@MWHPR17MB1598.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +N5uHtktqqesg/hLEcOjJ+//pYBoW3mX3wgbGr5m86r44dl8uJmav3VeYf7LC8Xz1z2PD+ly65KwSx65RC7pmGEcON5j1M1913gmWtqjLPX/GmqVoKBH7uHD5qiy9DaqCGH8y+CvRBTsLSSTJ90CU5P4tmbWFBgw6gzIHpoEDrszZ6cBSxD3c8J9qR165NZZ2zA8MMtomSWSjdWuMYGI2WdbFLMH02Ku+NJNrybn7TzCNSp+gVrlZT58jhHpoOF5ob+TYJGMna7qNyvL5HDob5wuVXRt6srvrkGj85tRHh6BS91jsa0yBiXtC2e+diBlBRZHEuqa2xzfjB8jylDThQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR17MB1967.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39840400004)(136003)(346002)(366004)(376002)(66556008)(86362001)(6506007)(186003)(52536014)(478600001)(55236004)(55016002)(2906002)(5660300002)(71200400001)(26005)(9686003)(76116006)(64756008)(66446008)(66946007)(8936002)(66476007)(33656002)(7696005)(6916009)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FseMTbu7qQcTGGM5oezkeWYyMGqzwCnDXNPfgtZ5FJe6Ej8f6SMdaJb/kXOENE7UK+Ge/HTVWJsH7snfgr/0+/67wZYkAR0+ow+hemXu9qkXUiVS/M7Bb5Bcgwa6AR1HHB4utqmuD0sitkXbPgeVK2No4keYNCIF5gNcx7fqMaEBLZ/o3odhP/fuLjLnOnomqLshgDg48SvuWo6Jsu2HLPD3MM4NK95D/5n+xN/ix7Mq8SFyObZOaRkKplJDzG6GFhD6rVE/zdk6yxqOSnbNi1cCvipbaxZ4md5MAVcw0963dsRmZVmJOqjs8dBfIXy5fE8mnoRbAWI8SoGNppk8kT557zBie21K35kVEe+TjC8aVVx/aJdqYRUjVoKIeS/rnj8xqRgpy+baFD7kiNGC2JcRDPSvUrLyqeuWPuV13Nw5D5/p9aGnHSfRZI/rckrM+yX1LQpPXLcqj4kLOmHMIX+4ZuAGdaLAoDfjURQM9Uc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Bluetooth.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55239f9f-35bd-4c92-b93f-08d7fe293ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 08:22:13.0086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e4e0fec5-fc6c-4dd6-ae37-4bdb30e156b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFGuroxT9F8VUd8MGZe97QXTrkyBM/PFLMLj0o2Ro8B0LKoxtWfZTb8twWSnM1wzZzY5oPEQ2BPBvonr708wmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR17MB1598
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello

I've recently been working with BlueZ via D-Bus and have a situation which =
requires me to be able to connect to a device whose Bluetooth device addres=
s is known, but without first scanning. This is a link layer state transiti=
on with the specification allows.

BlueZ currently supports this via an API adapter function called ConnectDev=
ice, whose status is currently "experimental". From my experience of using =
this function, it seems to behave like this:

If the BlueZ instance has not scanned yet, so that the target device is not=
 known to it, the ConnectDevice call results in scanning taking place and t=
hen if the target device is found, it is connected to. Success!

But if scanning has previously been performed, regardless of the state of t=
he actual device (e.g. advertising and ready to accept connections), an exc=
eption is thrown with a message whose text value is "Already Exists".

I was wondering if I could influence the design of the API before the Conne=
ctDevice experimental status is removed?=20

I would like to suggest that there should be no need for a special API to c=
onnect directly to a device without first scanning. Why burden the applicat=
ion developer needing to call it just in case this condition applies, catch=
ing the BlueZ exception ("Already Exists") and responding by then calling t=
he normal Connect API?=20

An alternative would be to accommodate this special case (not scanned befor=
e) in the implementation of the standard device Connect(bdaddr) function or=
 if that makes no sense because Device objects must correspond to previousl=
y discovered, physical devices, then at least the adapter ConnectDevice fun=
ction could take care of the two possible paths and simplify matters for th=
e application developer.=20

Thanks in anticipation.

Martin Woolley=20
Senior Developer Relations Manager, EMEA=A0 |=A0 Bluetooth Special Interest=
 Group, Inc.

