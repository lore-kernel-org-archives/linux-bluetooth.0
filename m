Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89DDC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 23:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355290AbiFUX5y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 19:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354928AbiFUX50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 19:57:26 -0400
Received: from mail2.multitech.com (spx.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 011DF18B28
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 16:57:23 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 7B9205861AC_2B25AE3B;
        Tue, 21 Jun 2022 23:57:23 +0000 (GMT)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id DD416585135_2B25AE2F;
        Tue, 21 Jun 2022 23:57:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd3VTpFWaJpI70StHd7DpVCgm+rA0zvbYenvKB8hzotsdDPtJUbujlLlCEoa+SBMjbdZEeOOX8Tcwf6WEmwcjq0kUlaFfDjLnESh/AH7w1da46VR9AnumWdDB/UTC7ai68MJ1lFzMvnheNyI5QFAQ8FvQkFLa0wJgkqv8XVtUCpwQbbTSKlzz9TtO+ac5nt9lP9Yc7IlfsCIORai2oydSRAhILc+3Kiatx/jZZFCjonD7a4UwxzWF/JSZXgEWnNKHrOMp8/hnKbteJCpXjIS0hWIzRGPlmsPj5K4O2qwrgCu7afNpKA1qOq1/F/RoA84Hl0KOnEkxIqipvyCLcYsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4a2owb8/mcYwGBzUtglyLthVfMreXjsi+HEnFop4b0=;
 b=T/rJJBAPv8XqUMRTihF7j4tffJkJ4wEkAXDa4srLIHFA3grxMEpA+w/SvHDKoYzaL/TQSO3DFGne37W1Kr1X7W497Zh6ls6Nz3NSu0Cm10qqZEP/JcCo2FU7NQKI8PT2ETwMxul0wCCp/etdHBapWTIO+k3zzdEjcdryx2agfAj99RzdUBShboCmwpjkvZJtyilCofoXLCBmuDrKm+10obswKrTxIkr8Z/Bs4GDSjsV+eTg42FG2Pozg9rmnZtzk1K2GTh+Ba50kIb7waN0JXZSLM/7ajvJTS4R2Psc+WYGdQzAhIIqz4WbfXDq1iyXF3qKsWkOUA09oTT/jfYQ1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4a2owb8/mcYwGBzUtglyLthVfMreXjsi+HEnFop4b0=;
 b=R3ZkKNTDamC9vf4xE8qcHuoJXi0KR0fM34ALEkpzxFYRMqmRB9GpDLmWaxjKV2nlqbFgyzBGGVtIQWB4PqdhJns8XIxbBLNIUEI9+Lx3pDHO0e0eZN3BLAK8D9aeg4vuC/bVkWHR/D+j7H8m45BsUwZQL+vBPXzP2QBJEMls54Q=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BY5PR13MB3425.namprd13.prod.outlook.com (2603:10b6:a03:1a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 23:57:20 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.009; Tue, 21 Jun 2022
 23:57:17 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: Is there an attribute for the name field in bluetoothctl?
Thread-Topic: Is there an attribute for the name field in bluetoothctl?
Thread-Index: AQHYhb2zHja7qealAUSxpq1rsMtkZK1ahSeAgAADEf0=
Date:   Tue, 21 Jun 2022 23:57:17 +0000
Message-ID: <SJ0PR13MB57552921E32DE0017E2584E7FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755B778B99B396FF0FF6E55FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZL=kGNjpR-E94tuTtU23PYn0d4qyxoDkc-O_EuxS6eZMA@mail.gmail.com>
In-Reply-To: <CABBYNZL=kGNjpR-E94tuTtU23PYn0d4qyxoDkc-O_EuxS6eZMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 61c31d34-5787-fce6-7c1f-b6dcbe5e6648
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4c79f45-0059-4559-3dfd-08da53e1c5d0
x-ms-traffictypediagnostic: BY5PR13MB3425:EE_
x-microsoft-antispam-prvs: <BY5PR13MB342538B91E52DA358D252476FEB39@BY5PR13MB3425.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ay0pqjfJAaf+dmFsnWbT0d3LJuPDVFJI/WHaAucuQQO4c2bOt8ZlY3ejYn3MDh5n3+iEKnSBnX7FHvPQ3bC6jcZi+jXQpLWHbMOZKoLyN0O0nWB3tWmPXkX7JmXiQodRDLXaieYSkpYmVn0jrt5DXHZKj9banbMz58f/TNR/zxVdz4EYhZoOHVfwkvQHMhhGz/EwTHcNIYxaVkbEs6dhnsFDmzgOUCieDm6QAPvRHKErX8zt0tsjaPSMfAubSOCab934ZHjmZciyOMxLatS2CG+719n55btB0+DLMvIODR5G4/0vS+JOv4SShinabx6nNVPrDSoojesJAK/C6cZt0nEbw9MwMavV3QleoBKt4j4RbXefezmyVIqt+FqRhiIhdrpcEKHqxe4aovUnPMpoLvIPPmR3JWTBsGBBybxcyF799KO7zQR0xmNHi14Eqqj1UE/aNgFZzdI5es+PFwPw2CXMQkQJK0VALJCp4KLvILJAAFtVJF9ICwYYuGL2kyVzbQhNiS6x1cuLFks1qH5dL0IqwEctXoFHNZcTi2R7leq9myDHg/B8K7squ0PgeJIDrnz6SgOeh7kcj+VVeUX4bgQ31g6qHIl4GxVCNFmZCADffOzXddBDi9+8w/r0Dx3kj4K4vwxLeObUXwHJUiX2rlhLqUoJT7wj9QZn0nylPvwrPTCG6AbqPqlVy7Z8U/NwVv/QiNY3nUkTnHP8u1OjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(366004)(136003)(376002)(346002)(4326008)(76116006)(52536014)(33656002)(86362001)(55016003)(5660300002)(8676002)(316002)(6916009)(478600001)(8936002)(71200400001)(38070700005)(66946007)(66446008)(66476007)(2906002)(64756008)(6506007)(91956017)(66556008)(41300700001)(26005)(7696005)(9686003)(186003)(38100700002)(83380400001)(122000001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AIoqOickBheT2yrN7+p8OwTyteyzJ99pfQURInOEPU5O+SabaTw3KsYUEC?=
 =?iso-8859-1?Q?lviCqT1JccVAynArBV0epeQmLZ4r2jpwtL6R+VGEr1fxYHCwuGk+76Y1We?=
 =?iso-8859-1?Q?g3OqViIXAr1eW0ZHNyTWngKxEvI9dGcPAxIYK1Pv37dxNlzbldCvFgaSTA?=
 =?iso-8859-1?Q?HqAPfjgRb9ifJobBy+TQk/vCKkG76UBLJkDdaNrOEKOv1UanH7FxH81nvf?=
 =?iso-8859-1?Q?KJzL2ku38kbmElysS6222r11Ls4BM3l6QmETL5+U2R4r8EdU5NhET1M9Oe?=
 =?iso-8859-1?Q?KFrcBJJXLBo7CdpQs3aJdO9f86Ax1eJP4nAJgml7IfQfs3iUvtJcSE60v4?=
 =?iso-8859-1?Q?Bl4FIiaj36SroM56YLBXe/OVi+rbljQW5WttD7UXTInsp4NKjF0aPL595u?=
 =?iso-8859-1?Q?8AYb+lnO/3ovCaaCCtwlxAOwk6IcGDCipu1vkn3EEpigOKnTkVP0e/WebV?=
 =?iso-8859-1?Q?k5EPWxfZgn8SG2YlOmtibkD8+OprppCyYbXkTZJcVDw6n+O0AR/EJe0mw4?=
 =?iso-8859-1?Q?QKEk/FSmjX5pJZrLekXhvrp0NKo4DqeCN9PqkLUCz3iFQUPbiUxlDdnN2N?=
 =?iso-8859-1?Q?J7czd5HJSex4My9CJ5Z8td1vq/zn1I41MVtOfvAtEYX//c8EYKwp63p1p9?=
 =?iso-8859-1?Q?RYQR+QSdmC5MedikNgkKOiNojFmIjM5s5aueUFa3I4Le5H7FRYGfaw+ft8?=
 =?iso-8859-1?Q?HQmyo28bTNUQurih3sKrdBCpZxhuhnoXhqu6sUn90bTH5LMQWMoshF07MM?=
 =?iso-8859-1?Q?2H22Ncb+FwJr/oBoHBOO7qkAfQSr3m9Y8ouevqIBR4ZdrCcJnKq+Mm8tk3?=
 =?iso-8859-1?Q?GjTY6SKuTvmhOqh3XyXEn7JNOCWT2jX+fi7SGjunxMVoR4D/7VHQq08bJj?=
 =?iso-8859-1?Q?YToc7mkBBkGchuU3q0pIFgLhh81uHbkOOXuPTAn6divMHCuSStPFhpBu9a?=
 =?iso-8859-1?Q?XmB4vz+fDfNUDKwNepk3sjQR9XAflpfBkkSPpCL+0Gu95OWHYF4pNFnkb5?=
 =?iso-8859-1?Q?Osyjglx1SlXMg2DyoTUBiPXY6/mKHrdcM2dSXrPkPUbf2UdL3pRSacvUtN?=
 =?iso-8859-1?Q?O9uxx3n/3hVYGAtMOBlkrk00hy5xE9hlSX4q14+Dxpt2MNNtP81uUCCcTT?=
 =?iso-8859-1?Q?t2/QXNd2rw6ZMzY+50mg3SDJL/C0r5oDXrmKYZOPGYbI7mk97P5yXKBiEm?=
 =?iso-8859-1?Q?f7w2mg10xQhYDYRQcuxOzOjh6NPnNQhCYbzIbSDnrmpWklzH67jt8XKW3X?=
 =?iso-8859-1?Q?RmQ3iDG3T0q0QAST0b7dzRcdJ1qrWm6vLCmhTqlWtEI6PEhH7Os1zx2wow?=
 =?iso-8859-1?Q?YLJ4ATIXgRj43aGakLWx3DfjPja5uusLTPi10vgHBasTCg7yLb3M16hBFI?=
 =?iso-8859-1?Q?sBtAR1XEpXohjJSxqcrINl7YXYEYwN1zZpuxkBePBhF6fIW6yAcaoLDEmn?=
 =?iso-8859-1?Q?mXOdDRPkupYvsH3K0gn7aQ+JLJWwxvQOtjgqfp9XNTOSserwkM2g+PVkQE?=
 =?iso-8859-1?Q?NJ8hS6GlWqhAEpGmHha+mZnJ1gjlW2n94WqjTO3UchruIpcBEkVD6iBRLR?=
 =?iso-8859-1?Q?LmdOHn11Lshc8PKUtIe2tdEzhHK7hxYXC6NARnFgd3R71LwqL9Ne3rCKxD?=
 =?iso-8859-1?Q?rrK6kXHVDBtGf2Tz6LtmT/dmwSewY4/u6bq0314ZBMSPsPyY02hGxrl0sW?=
 =?iso-8859-1?Q?a1lgeaEbzep04T4xMKFPqZO6fsaCK3jqOd10gpxtvi1zybBSLfeQQG77Nf?=
 =?iso-8859-1?Q?YiPOknshTb2h0zpoSyiEp6bsfaPXNZz5M+l9K+ywgP3v20AG66o0wbZ180?=
 =?iso-8859-1?Q?KhAMOkHjlg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c79f45-0059-4559-3dfd-08da53e1c5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 23:57:17.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auBqEvedRAJWdjwBBzwNwdHWQBGfRTSeViKOZ0O4vZF0ph7QAvst2+RnujC+yy098a5o0T66Ve8Sb/Fe7GY4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3425
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The value from gatttool does not match the prompt ([CC2650 SensorTag]# )=0A=
=0A=
2A00 is "SensorTag 2.0"=0A=
=0A=
This was defined by TI and is in their documentation with the value gatttoo=
l presents.=0A=
=0A=
How do I get the value "SensorTag 2.0" with bluetoothctl for the UUID 2A00?=
=0A=
=0A=
=0A=
John Klug=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>=0A=
Sent: Tuesday, June 21, 2022 6:40 PM=0A=
To: John Klug <John.Klug@multitech.com>=0A=
Cc: Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>=0A=
Subject: Re: Is there an attribute for the name field in bluetoothctl? =0A=
=A0=0A=
Hi John,=0A=
=0A=
On Tue, Jun 21, 2022 at 4:05 PM John Klug <John.Klug@multitech.com> wrote:=
=0A=
>=0A=
> Gatttool Example:=0A=
>=0A=
>=A0=A0=A0 [CC:78:AB:7E:87:07][LE]> char-read-uuid 2a00=0A=
>=A0=A0=A0 handle: 0x0003=A0=A0 value: 53 65 6e 73 6f 72 54 61 67 20 32 2e =
30=0A=
>=A0=A0=A0 [CC:78:AB:7E:87:07][LE]> char-read-uuid 00002a00-0000-1000-8000-=
00805f9b34fb=0A=
>=A0=A0=A0 handle: 0x0003=A0=A0 value: 53 65 6e 73 6f 72 54 61 67 20 32 2e =
30=0A=
>=0A=
> From Bluetoothctl:=0A=
>=0A=
>=A0=A0 [CC2650 SensorTag]# attribute-info 2a00=0A=
>=A0=A0 Attribute 2a00 not available=0A=
>=A0=A0 [CC2650 SensorTag]# attribute-info 00002a00-0000-1000-8000-00805f9b=
34fb=0A=
>=A0=A0 Attribute 00002a00-0000-1000-8000-00805f9b34fb not available=0A=
=0A=
Certain attributes are controlled by the daemon so they are not=0A=
exposed over D-Bus, this is not unique to BlueZ since I remember=0A=
saying that on iOS it also don't allow applications to access some=0A=
attributes directly.=0A=
=0A=
Anyway the name is actually parsed and you can even see it on your=0A=
prompt and you can also give it an alias with set-alias command.=0A=
=0A=
> John Klug=0A=
=0A=
=0A=
=0A=
-- =0A=
Luiz Augusto von Dentz=
