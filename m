Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36DEC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 16:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiHAQLe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiHAQLd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 12:11:33 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8C9F2120AC
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 09:11:32 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 29AF282780_2E7FB34B;
        Mon,  1 Aug 2022 16:11:32 +0000 (GMT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 4D65782648_2E7FB33F;
        Mon,  1 Aug 2022 16:11:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN5vnjal+OZ4D7ya3DyVeSBc831W0/4sz+V3tFCPwBSRkXwjNHL19qsLlq/naUgbR4reXoVXOy5oTUrMoZ/nkNHiaz3IoMiY2d2T/T7247zo94ZtzuUYJqARNwfP7VkqWgIGE5EgS7fn+TOJe/oqYkEacTxGpyaGUKplrNY5o2lcNDcXKtbpCMAcHhEGSamNJ2yvu3jbwVEX5tN6b30+CE7/7WuC6U2qqJhxkcJrdu3YdiF3v13y81cE+O4Yi6CfGarc1dvibA0q6Ifq65GPmBipOfXLi9vMrvmKTka8Qh2xZVemtUGzRktEi7bGuaHn0RgDnO7VMALKve1oW91R2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q88rUV2wYSTjvrp5baIechGTEX25PUK//BUMt3fAKFQ=;
 b=nQWAFSz9YBM2MUPPgzF9dmcG6+mpePExSwn9x8kFJIk6pnyckcZuEKxPA+6vpG/CKyxfflNd6oDkrWNyXDf22xEHrI0eVjZQh9lEMKVIKmu9+ywOrs+TVKqCmfKxJQG0ea6crcufGTgcsaYvmVbkZ1gVRTKvZY6yaxJIl9e3FDPq/OqwAg1kRQqQp7UxTEu2fm0Ijwvn9yQIufhhwbNiXxbWcr5AW2uwzyhzGVCs5bfSwHFd4s1oNBTdwmDqqJrv+26dotAOxHanQv2i3x+fMs1rbLShgQSIyAy9eKfN61HZu1zmYdActB6sDkZhl0DV0Pod+3cxQIPtY98VqAavGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q88rUV2wYSTjvrp5baIechGTEX25PUK//BUMt3fAKFQ=;
 b=g02vbV9/teta1njPNqecm5qp4oTQhuDQ7wn+C0i6zwneZ5Gq69/FG+A7R8RKpAi3JDBYds0iy6A0oTaw3syD7kdWMG3c9kj9xyfIPDgpk51MF7OdVFXHMfmdM0WQ7g7/YiDpLzYTWPnwH9vDvsNyl30x+OcrMm0ZiWiOG3dpC40=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BLAPR13MB4579.namprd13.prod.outlook.com (2603:10b6:208:327::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.10; Mon, 1 Aug
 2022 16:11:28 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.020; Mon, 1 Aug 2022
 16:11:28 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: GattCharacteristic1 WriteValue fails parameter validation in a
 GATT Client
Thread-Topic: GattCharacteristic1 WriteValue fails parameter validation in a
 GATT Client
Thread-Index: AQHYo4jpjMkWkj7OKkekvgeb7zXQNq2V31YAgARbAc4=
Date:   Mon, 1 Aug 2022 16:11:28 +0000
Message-ID: <SJ0PR13MB575566D9D75BB003E05B65E1FE9A9@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB57559335C977722C016544F1FE999@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZKmoOK+RprcySXBN07k4M9i0apA7Obb0Z8Y+LSDbU=EkA@mail.gmail.com>
In-Reply-To: <CABBYNZKmoOK+RprcySXBN07k4M9i0apA7Obb0Z8Y+LSDbU=EkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60cc58a6-45ec-411f-80f7-08da73d87ddc
x-ms-traffictypediagnostic: BLAPR13MB4579:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9e83W9zWLmFU69TyJpaNe+BvEm9n95F8b5xAfaYXV853WpxehhSfuFYkD/23RJjeWXS9llXtaY4e+Par3lD3sdibrC5uQrh28Cg0enhscBkPUh6oqbNnl1RUVmipL6mMnF3HMdZdGsslPHlD+nBqBUqVf3exwYiWjtjkcJuKQEBkdUpdi3WEjGCjNeW8LDJzigT0nAPtEsxrW8QNh8MCt3quYYlvbHivP8tw8fVdWtUxmZNrWInwvU7vKfwu2zv48GqYHuirQQsH8Zi/gpD/EbiDJtEQSjepiaoBusHTBNcZMKZSAkFPg3seqtLiaOlnRKImUVEHHsXfoEKhWeXTpLb7zHXF7Won75Xx0bP3AFgpWtPOJwXB7ZwIKj6jYV92pHudTYPgwwoVIdpI/gkPBDxQkZAB+gCAC/OktpBUtNNTb4WnOWh9p7EojWD1KhORvjHOhFkuGvgyqhFyLUjY4AMbTaXXIZDHsRvTsGiMxQQ7bMkwe2D5aX+B9SXJmzZZ1wFBlt9s34QdcE350WosauNS0SOVos64ooYnt6r1JLIeEFcXVjyKwb0Yfwzw7Fb1KLWEG4IGpqalQeQOC82v8XpGRD7X/Lit11YTMctNd25Ke/Ncr5QvNRoVuyWZXgBon6UnYkFL/OmHyYCV4eia5HmG6QZjkxGOKXqUAC4V729gmSSagNHHTg3e6r35oiroYKZXhj+j7vEdAuZhK1lzZdUtOo3bg9P+GQSSMelvPiIoli+xYWe/OY4LpMHefR1UDLmufe95t/hA4PxefsVTkfPfb+Uqwf1LoE8oBhu6dDTNvvyOrV3XCDPS+y6+jpH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39840400004)(376002)(366004)(346002)(7696005)(26005)(6506007)(38070700005)(9686003)(33656002)(86362001)(55016003)(122000001)(38100700002)(186003)(83380400001)(316002)(478600001)(52536014)(8936002)(5660300002)(6916009)(71200400001)(64756008)(4326008)(8676002)(66476007)(91956017)(66446008)(76116006)(66556008)(2906002)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IwvY8Ceaa2EMtreX8ZVPbdCMY3tWbldJOFXNe4UuVop0muVNllUxhkqV7w?=
 =?iso-8859-1?Q?f8sArjzLIUjRElfsIBeT3/D0cOsDjARtZPS1n5qylno1+Wjv8oR5Njh7o3?=
 =?iso-8859-1?Q?ONowEnSO9k40W6VALW4JE4IYxI9FANBvv7iqGuC3FdZm5gYri27aT2shK3?=
 =?iso-8859-1?Q?SkagQ5RXmdf2zaiH38crENxEa3/Arh/3B8n3oiUZozdwby2dQIjulYnvP8?=
 =?iso-8859-1?Q?N/RM1DO71R4jss5l1KeUXSYU26D2/oNlIR+Ab4fTUwV9EtBNp5vfOgm1R2?=
 =?iso-8859-1?Q?8xB/+xpV+JelwLqnaZLj8IJcYGtQoHKEUW6b6VtLIO3FGx6lbLJd85T0T3?=
 =?iso-8859-1?Q?Nf7S3DQwqh81plKxW9oArF0XKSk7n80Bf6SoIq/CkcTtJVaZ+87G9G0eE+?=
 =?iso-8859-1?Q?aY7FD3fjdcSOdZ6qq3dBlpvnCEZ8uvsJkPFNvpPTc3rVwwi+/UK4GxXnCY?=
 =?iso-8859-1?Q?xP0ZTaSbpnRWDENNpeIe1zT/wb8HIuS7q8Irzwr8hoMigk/ud4SMNRKBME?=
 =?iso-8859-1?Q?89NTX1WMnV5uijvw4+wbpLf/RxETOofl52scor+kTTq4M1vGYCfIe0o/fF?=
 =?iso-8859-1?Q?ShFW/PnnaLECrI3D4+XmYsJi/t5qYqL+DRC3tvV68f1QqCmmFw4jz7OjSG?=
 =?iso-8859-1?Q?p51MxrYBDV4apNPt3jIC5Dc9f9M29hGp5b7+L95OILT/cA8aVeJkFszmOr?=
 =?iso-8859-1?Q?+gs2Tp4tgvvEPAiZuQs93dB4uRPwmPYXhDd+SbePgQniTbCtJGgqGHV9kA?=
 =?iso-8859-1?Q?Y+vSir8tCwSzm1ZN+Ei5KHGoiRDpZte707wIVCPSeYAtVyJGnzDo7CzhEq?=
 =?iso-8859-1?Q?K4Ol0nO18qcT6frkTiXSL9QI1B1oMTcvmsFUldx9n4HeDhmlHqkQfcikH8?=
 =?iso-8859-1?Q?Ay3JOrC5i4Qqbjas9g0To1evylLfHcjMUmjjwIkq1LouyCErk7ueI/DKKH?=
 =?iso-8859-1?Q?UrF7GAttzfSDF1VqyCq+ohT0x56SyQpcbb8sT2jCbCUDhultq00LijdIvM?=
 =?iso-8859-1?Q?eRLWPmS4o/7nqpqAp7SfJ+4Hq0m0tmYl1Pc7cf3n2EKnjOUyC2VnF4Bi9r?=
 =?iso-8859-1?Q?U1RVHSHM01oF9H5RSJdNnQfl85Rzf6GlLD1sxqnHJDmBOdaUJZoFXod2GH?=
 =?iso-8859-1?Q?0+3VC2e9XVoLMTV3tK9PlNtb79HHYg52uaCnZ5Cvm8VHR72EKn3svn5C2X?=
 =?iso-8859-1?Q?9ecKFL2hdoDgsv3UsszXvXaKGXW0l5SdEwzkf07SrByiD9s0ynQFiofqoK?=
 =?iso-8859-1?Q?zembAtD8xp8PjJq4LHQnCrjNuXUJD0H2ujwQ/FgK7KoKORCHdgLZnXIWNK?=
 =?iso-8859-1?Q?gi+2tGoq3TQKrS9g0eNkkUPCIJPhaKpzAlNUlT3v4OFxJ9Vi0X+Rw4d4IY?=
 =?iso-8859-1?Q?/o3OYONOgpeUPuGqCoojuSmHafmV7BblqzBqmqCC3/Df5eZToszIJBgUo2?=
 =?iso-8859-1?Q?3bnVa+zchxt2XqSVrGRzY5AYTucYhKLiG1yz6zrD9VxLUsJtfTnrwOYl5r?=
 =?iso-8859-1?Q?ogELcPKnhKvjz+p4E8BV1KUznTgR2zCLLR/UwpNgmxlh9G2PWQm+Q+UsbU?=
 =?iso-8859-1?Q?qRQBBPpQMWYG2HlKdP2Ka/829bwwoeY1uHunMzIql+AWphaZrNUaJLCZgy?=
 =?iso-8859-1?Q?HOzPRH87pIBj0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cc58a6-45ec-411f-80f7-08da73d87ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 16:11:28.7454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0udb65cVaWtZzT0dB5fCee5hVT+V3YW5W5jj6APaGoLWZ1FA/e6SBU6dXqz+Ht7FbaylStAsY2w91NdEAbEc2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4579
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz Augusto von Dentz writes:=0A=
=0A=
>You can use AcquireWrite and then write directly to the fd received.=0A=
=0A=
I tried AcquireWrite as you suggest.=A0 The result was "NotSupported".  I =
=0A=
should mention that I have tried Nordic's NRF Connect on Android with =0A=
the same GATT Server, and it is able to write to this =0A=
UUID/characteristic just fine.=0A=
=0A=
=0A=
Using "dbus-monitor --system" I see both read and write flags on my charact=
eristic "service0021/char0046" with the correct UUID:=0A=
=0A=
=0A=
signal time=3D1659368288.691466 sender=3D:1.3649 -> destination=3D(null =0A=
destination) serial=3D968 path=3D/; =0A=
interface=3Dorg.freedesktop.DBus.ObjectManager; member=3DInterfacesAdded =
=0A=
=0A=
=A0 =A0object path "/org/bluez/hci0/dev_CC_F9_57_89_8B_D8/service0021/char0=
046"=0A=
=A0 =A0array [=0A=
=A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0string "org.freedesktop.DBus.Introspectable"=0A=
=A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 )=0A=
=A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0string "org.bluez.GattCharacteristic1"=0A=
=A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "UUID"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0variant =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
string "edf50100-681e-4b92-999c-e16b3a8bc047"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 )=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "Service"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0variant =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
object path "/org/bluez/hci0/dev_CC_F9_57_89_8B_D8/service0021"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 )=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "Value"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0variant =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
array [=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 )=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "Flags"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0variant =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
array [=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "read"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "write"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 )=0A=
=A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 )=0A=
=A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0string "org.freedesktop.DBus.Properties"=0A=
=A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 )=0A=
=A0 =A0]=0A=
=0A=
=0A=
=0A=
However, AcquireWrite replies with "Not Supported" which is the text I see =
in the error message in my program:=0A=
=0A=
=0A=
method call time=3D1659368290.693590 sender=3D:1.3987 -> =0A=
destination=3Dorg.bluez serial=3D10 =0A=
path=3D/org/bluez/hci0/dev_CC_F9_57_89_8B_D8/service0021/char0046; =0A=
interface=3Dorg.bluez.GattCharacteristic1; member=3DAcquireWrite =0A=
=0A=
=A0 =A0array [=0A=
=A0 =A0]=0A=
error time=3D1659368290.693700 sender=3D:1.3649 -> destination=3D:1.3987 er=
ror_name=3Dorg.bluez.Error.NotSupported reply_serial=3D10=0A=
=A0 =A0string "Operation is not supported"=0A=
=0A=
Any ideas on where in the BlueZ source I could look for this?  Does anyone =
have an example of doing a GATT Write from a client?=0A=
=0A=
=0A=
=0A=
John Klug=0A=
