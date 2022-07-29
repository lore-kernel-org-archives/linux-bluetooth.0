Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6EC00144
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jul 2022 20:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiG2Uln (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiG2Ull (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 16:41:41 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0D63E5A8A5
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 13:41:38 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 0E588833DE_2E44602B
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 20:41:38 +0000 (GMT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 5CE3982443_2E44601F
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 20:41:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VByb6i0pQ9jepOQD/rS0dT5Bh3U25++0jniKfzTbIk+8SZtcazBNczpQ/SY3CjEIOAdYR47oCXCKWB0Uy4oQA0yRHjkkvWIsJjZXMcv//Li766eefJWYmwyqwia58Z+9vb91I2qYNCuC5u0yGlnHAT+vYkQGnRUUJRiiE8QKQuxAKsrGore9MX+ixkAf1wd3lJ3lmaI2t1WKSapRX1A+3Nam1wUcrAT9M0054rW+iOFWkh1cjNh6HUVPjwJIpUdGoe9xoz9BZYnQzgamXnP38bVxwnSZCBMlKXFmhnvAZqABWA3N27PCPtjHOSPH+5T7Y6xxh3m63bEJdMp/3fmzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ+eD5sgSXnCYvInQNi4Octy7KLW3ORfFPAQ/9nfUNc=;
 b=JgHU2ezkTPsvAIPNWBaA87IH2AsGpLDvC9nZbKrFRgFq8NLDAJEJptE6voM1JKNZZjLyXV4E2hBVQn0z2Yu7n4PRick0UtevspMb/rGoJUjEpNkT8vr/J94XPHGZyUGMIbPv5sdULqqLlZSZE+0DbKigvek46GOiZ9+vHiyTtt7SCgMT/Czj08oWfVyO/1URTfxq06WmCPANr3zcol3/m4t+Q9rrZ5tsEaCYrGXCWJq+TyCXQMB2xp+4DUBvIA+HJ+O4O+egm3jSUyq6P/OPi71noapYyNgAeSF3CB5aqtHhQsTlnZ84Z8qtUSL/Gyg7+dwff2Xy6vj9OIoKiIwUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ+eD5sgSXnCYvInQNi4Octy7KLW3ORfFPAQ/9nfUNc=;
 b=MZBI0MNILIRCBkJrOHWhIp9sAru97YDnAzasrlh0NNp4WFHscA09KMKSIgHHlEZTIay6BWUHn/SY3sXhRioZBaLJ+4ul7cbgpMw9ai0VzXVRlRb76ZGt8UjDku8jcZees+rFs1mszbskwxHoTO1OGUHVsdKJWNZ/NCZf992a3uw=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by MN2PR13MB3912.namprd13.prod.outlook.com (2603:10b6:208:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.4; Fri, 29 Jul
 2022 20:41:34 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.020; Fri, 29 Jul 2022
 20:41:33 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: GattCharacteristic1 WriteValue fails parameter validation in a GATT
 Client
Thread-Topic: GattCharacteristic1 WriteValue fails parameter validation in a
 GATT Client
Thread-Index: AQHYo4jpjMkWkj7OKkekvgeb7zXQNg==
Date:   Fri, 29 Jul 2022 20:41:33 +0000
Message-ID: <SJ0PR13MB57559335C977722C016544F1FE999@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 234253c0-7006-3983-a613-c9e04447b15d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebcdc2a7-79b4-432c-6aac-08da71a2b971
x-ms-traffictypediagnostic: MN2PR13MB3912:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECRPW8wycNND9RPnGKu50iAtDpjDrtDg8giEldbk8Ny6q2DCBjS+yaAjvJnN00bxTsdDBE0LhyEDZK1ypx0L+s6E6Ita4H5+xAVZ7X1XXo7FPNh2r9TaGwYj4tyZrRdSzeAaPlupivX+UptWFJo/9S3BAaB0Sm7DtCu6IcjAv1edIFngG3KZcjKLtCwbemSYCEVeyxFOo2jxWmPqvQrrL+NTT3TkTE9HpAkra+jZdPITjc3bBt3IpcLUVFZoVIuBRelghYQQqC8VM68a+VeXloyxCCUVYTO1HaSeRkzQgiFen7rekHnaJOpXfisyUNlED7ZqxvujcFXx8KnGX2aN8Cy2y0R6iSvQHZD4KY1g+byHbXTRTAuK1h7CvDSGsriN0HiySGXuBL5eBgvW72ov7tkNmhRnT329Yjw1+cb+TrtQIuH8N77DCltclqClvPDXHf3+O9mYj0ZR/puyiKuZXoqof8fzg/QuWz5EvoY3F3RAj++l/1+y1OAWdwnPxcR7KRMR+E99NsDuxFnd0/i08QwSSAWf35fVRpSvy92UyZ45/ihYFx50HYmpnOSCDAOHfSzcLozX7QVJcLJPOxq6gFVlPJ/VL4fj9Fjpr21vdowpje2Y20x2NGZGSxno+9QyAWX1T7ez1MPBcJpLrzpSuivsibov3zxt7DTdJkSQEKpadqGmuEPHZj6kbu6ED0CoKM35238ROd1YvFIwupArvXU7G9+hA75oVzmkuXd7itCiv2wsqX+6geHneXUNCHQ8Dqr87VmJDj0hNTPBcLoLwjXg05nkqbjY2nMWAlyfhhfYm0PAk/UXPHegR9wyQXOB2Lsf9hzHGbxIhWoC20FrT6gLXBNa46zsnEPLGdyGe/peyKObWGHA0icMrNohFggb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(136003)(39840400004)(6506007)(66946007)(64756008)(8676002)(66556008)(66476007)(76116006)(6916009)(91956017)(122000001)(38100700002)(71200400001)(478600001)(9686003)(316002)(4744005)(66446008)(86362001)(2906002)(55016003)(8936002)(26005)(186003)(52536014)(966005)(38070700005)(83380400001)(5660300002)(7696005)(33656002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HAdC0UVoRxXc/4uTKhXc0idMKoDxAtvyfkSpjil1EkD+sPVhEOru/4ALFo?=
 =?iso-8859-1?Q?upU6NnUFvzIUamHG7RtNH3aDe8EDgIS8N3d5F5N9OMVqyg+JiPjznafcMm?=
 =?iso-8859-1?Q?GBjhixyyr0vPPBKcNfgypDlts8oemfeYuLjBUIpEu6m1Hrj3+Leq7q5qLq?=
 =?iso-8859-1?Q?smyOCpQa6Q5SguqBNpLXgQwyAfj3BDxFmzfgcZ9MQBu8UqAsWmH54/rZDw?=
 =?iso-8859-1?Q?bCspczR0iyMe/yUaIdnNV+A26zAoN0s8BKUk3HcuOyXyColeQ9ZiQBYGG8?=
 =?iso-8859-1?Q?Psp3/tcM1zZmqBzKAL5TDI5nFUf0rxzpKGudK7hHXFR4B558LmdjSlRupe?=
 =?iso-8859-1?Q?EQBrtfkxZHh3QlqCkAnYdUsfpGPOZ+l0gYdTkr8qBJy67TAikuUsSKxeNM?=
 =?iso-8859-1?Q?lKYn+qIj23XafREdl0XP6tO9igS4vlv4kftfndVsAybK3b++ZRVnv2w66w?=
 =?iso-8859-1?Q?T6VHS7mSSxYkklj1hgW+9covTlcVbWjX0IF+a7h+mSxxASbOaRVH0AsPub?=
 =?iso-8859-1?Q?oVsdKir9AgzleFk7v/N+vVERtFRl1CMbz7g2mOqcBNThiHTyHAYNTkttrG?=
 =?iso-8859-1?Q?gmYpl+nmycMDxvdwLuPViGjN6BWTclWaoUrKZXvGPAAAKMfYKY5cZt8/d+?=
 =?iso-8859-1?Q?Bb7B3t1NIB738y2ifBJ06HNv8jOYzBcS7aUEBFmptSu1gs6no0WPZmZZZI?=
 =?iso-8859-1?Q?lYOwBZHyeiiv6jrWxsbBs0h1bCAD3xFjPKgmIvLB/xYQCY2JV9mesSUXv8?=
 =?iso-8859-1?Q?SIdpiYslMTTQbMmnJ3DVZkwT2MKeeicR0qpBuhDOqqrDzASq5aNVyr4NwH?=
 =?iso-8859-1?Q?dSqtTHIj7KbDEMdPTqngzaDUZjyypROdQ6G9aRSPhtxFMGk/IuEwGml6h6?=
 =?iso-8859-1?Q?RUni05uUmKBfnAL3T7Uq7oiVF46ikKaQSEhbvV0r6QOwyQCXYDIm6dxrvI?=
 =?iso-8859-1?Q?CKzqBplDI5GBM1x2vUPM+tEhRYAkDQq/dx5n6Bk8DpMgSTJ4QZVgkUL32I?=
 =?iso-8859-1?Q?qnB2Wvu7rpG0MR/0h3hduHaGIweWLMZgmpmcDj5ThF1nW3ph3JFHyyYUzK?=
 =?iso-8859-1?Q?qlmFrlpTCBYjCVm9OJkTL/Jkvq7GM7c9Q+CX2/1KTMeNbrKsQ8t8584SYd?=
 =?iso-8859-1?Q?SqYQjqgl1VeZvyeJnFuYUHTeG2UTqmFw77ViJ79UbjfHcsYUUVaXWa6Aij?=
 =?iso-8859-1?Q?KwhR2N83/bZSyxDXMd6zfn68SrrAwghq0QAhhbz3lPQH6A4/rmbTExiL6C?=
 =?iso-8859-1?Q?ARzbHBvoLrd0b5JIYHdnqYCmLmj5hU6pa4cT1SN3G95AwNDoBc5OwUlWES?=
 =?iso-8859-1?Q?U070OadDI5ipDhZIEUfzsGl4BtZPKM1evxagnBguDC4gCxJCePOfgFEYmG?=
 =?iso-8859-1?Q?ZIrsFDqbRH174jR4pqhWQySCoXLi2Tl+cZqPpzH9WFsakKjDZkkTgq1s7t?=
 =?iso-8859-1?Q?nBDKsunKpods+0q9oK0ghhqTzjp6SCR+K1OIY7mj0K+LtCq1xVS+5EHLiS?=
 =?iso-8859-1?Q?XAEP0UknWwkqWlp98LR80D/ryMc5ZXDy+ylBLSS8CgLuJukaWST25zaj1F?=
 =?iso-8859-1?Q?Ry/pPzCqWl+XzK0p1aWDvAcCsMqKtII+AyXwHJJceiVVJ1VJJ1o9ZfYCOf?=
 =?iso-8859-1?Q?akPRxfWsuhzXc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcdc2a7-79b4-432c-6aac-08da71a2b971
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 20:41:33.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8A2V6Ai31oj4nRKREWdp0VOoUo9pAf0KLhbPdY4pPgmvwzCQXRrfdFydrF5FjVt+Poaiir3+qCcjgWoqC8l+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3912
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I see this is in the example-gatt-server, but not in a client.=A0 Does anyo=
ne have this in an example?  Ideally written in C or C++ with libgio.=0A=
=0A=
My issue is that the parameter list is rejected when I use libgio:=0A=
=0A=
Error=A0message: Method "WriteValue"=A0with=A0signature "aya{sv}"=A0on=A0in=
terface=A0"org.bluez.GattCharacteristic1"=A0doesn't exist=0A=
=0A=
Turning on bluetoothd=A0 -d, I am not seeing this error.=A0 I see my servic=
e appear.=A0 gdbus introspection shows the interface and the WriteValue met=
hod, but the call to WriteValue does not seem to generate any debug output =
in bluetoothd.=0A=
=0A=
I wrote this up in https://discourse.gnome.org/t/how-does-one-find-the-vali=
d-signatures-in-d-bus-for-an-interface-method/10579/6=0A=
=0A=
I have tried both Ubuntu 20.04 on a PC, and on an ARM 32bit processor I hav=
e tried Linux 5.4.199 with BlueZ 5.64.=0A=
=0A=
How does one write to a gatt characteristic in a client if one is not to us=
e WriteValue?=
