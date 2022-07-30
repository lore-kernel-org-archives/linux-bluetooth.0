Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1C7C00144
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiG3Ajp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiG3Ajo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:39:44 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4A54E101DC
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:39:43 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id D5FF482707_2E47DCEB;
        Sat, 30 Jul 2022 00:39:42 +0000 (GMT)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 168D482443_2E47DCEF;
        Sat, 30 Jul 2022 00:39:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rce3riA8l9NHp6YAs52QOnyJp6VaehmTqCEh0OqXU+fwhsuotg2ExPDarXxzk3cblKW+b48SytXwd+ryC1xZE4eZpyf5GNXMNUhE1HdSnzSbEyoN0DSe9gGO6Luy2RzEuAWeSXW7zwgRHqX2c7r69wb+eMpXxp4SY3ljjbZ/F+VOtJLrgwBQSqBy4M/+FEqUf5yQih4CEZw4MKBEvxwCNr17f345nZZPaqwlCxrlncUdYr0SXw1lV/ES+ynWVZg1pF/DIPzt+GlOR7yKkwPUCP+xEn4FAG3RT8xKy9/UQo30SrcIYFQ4FGxkJz8VVQuX9P7J/npthPWmfCePdrVolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bC+KLygas9L9jT3Ix15vrpNOUP5qTnv5lPN16okKz8=;
 b=cb3793L3X5coFzAxJCr+DmuNqEWE7s2BlQdxM6cRK01dcylyi9aYyG3hs5zOKZKkXuotAJPu5m+xn41fpFgz+aVwMdQISXPWqEaLPaHXVA/e3M5nj7u17zGHzha+7nTm+EjUxy9n1G6Y9Mp/NL8gfPZk6kVemAKGL3KIs7uhPuGbxlTOeuVaPqearECILZC8XsD3jQOK4uxOhhUgJSVm7TJnMh+S+tkEtThAaZIGAeR8rrKAs6AGCgxNG55V161qoTqBExjODJErgrKhvRU7uLrxxU40Zwfv5B3Y5EhWjmC7wcMy9/Dvrs6H3Lv0Z/I1YWakfgDxsEkTGNaWuQB76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bC+KLygas9L9jT3Ix15vrpNOUP5qTnv5lPN16okKz8=;
 b=fjTKh9ahRFzZS7gZVZG2wiJ/5LouXeDzyH63o/pAu7e3fdGfdQPERj50pcp/OlxTIdaEm0NuY0U8Q74Epe5eMsLM9w52J38PicklX57/HHnwFsW7cVSaFm01Pbk0PJKB1T52Lwe15TJR4guArC2kHUxzpIFj4ELwZyr3Cx5MGbw=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by DM5PR13MB1257.namprd13.prod.outlook.com (2603:10b6:3:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Sat, 30 Jul
 2022 00:39:39 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.020; Sat, 30 Jul 2022
 00:39:39 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: GattCharacteristic1 WriteValue fails parameter validation in a
 GATT Client
Thread-Topic: GattCharacteristic1 WriteValue fails parameter validation in a
 GATT Client
Thread-Index: AQHYo4jpjMkWkj7OKkekvgeb7zXQNq2V31YAgAApLMc=
Date:   Sat, 30 Jul 2022 00:39:39 +0000
Message-ID: <SJ0PR13MB5755BA5D1A4D173DC55FA7E9FE989@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB57559335C977722C016544F1FE999@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZKmoOK+RprcySXBN07k4M9i0apA7Obb0Z8Y+LSDbU=EkA@mail.gmail.com>
In-Reply-To: <CABBYNZKmoOK+RprcySXBN07k4M9i0apA7Obb0Z8Y+LSDbU=EkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 1fce4b66-b2d6-2b6f-83d3-7334ad0a0d2b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5754931c-5450-4c39-331a-08da71c3fc55
x-ms-traffictypediagnostic: DM5PR13MB1257:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N9PyuSm73DS+OtH+32MmCi2U0I4ivm9ObnSTlZnjX0CV+gihMB4uKMPA0q4MZBERwYtnYZswIDKY1IGN37NOJTmNst021CN0P8c2to1cZ6sk+KlCIRRDDL5IhPDWtVQg8N+dKa7gqCkGcJuEietA4PPI54SNFcjV7bCMVllrk7UEr4Qlu1ikb1hjuQFnS8MLbCzWcRFLZGs7nqsxFSmUayyBy7HRoMlv18SBW0HwEVOzYon6+A6i5uGOKF8tdh0PYbIDsnc7X3/TwUmZC9jcz2UBb1xgfkxJ4/e0cBjnloCwPbzq7E3RWxIBpIJKzfdnc57t/eDVsDaj5S5yjLPF14K9GeaySSGNAdcPRZHiH2iiQduWzBw2I4wTCDCJclAuiWc1/pEc5mrwm3P/7NznkRb9AX7Mhc8ZHf+D3yyTA28TlplsEPkW45ijgvKcG01C2laM89K8mFiy45Yf6f9IAPqhCaNdVrzYbgKhpOXgVy6Os+CHW4CXkwJndcNxxyhjpB8OCEf+QjQd0I8aXG5+cVkPeNBtWs+O81b/9gYSqTf428zWd65aipw/8z75Tp05GGlnzgUSroqAzpl9zK3OEv9eoez3fnH1zFlJ31LfsFP8b5tsyKC8Y0F3theAgnGtqfBKUqdPicB/K2MSm2tk/8QBGsNRaORIOpLl8OaMVjsstPLaIi2bg45+vpW+YtrLy0c1TVB76BA7AdRje3NVCjdL5LE176IwjEBLwjGrr1++Hda1x2Oy1vVyI5783Nwq3oEThxm9X7D6hxKIoHyPnCFbkChP2Moy2sUw8aUwUW9T+er9JszBOxJuHqC/xYJ8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39840400004)(366004)(396003)(376002)(83380400001)(52536014)(2906002)(8936002)(5660300002)(38070700005)(38100700002)(71200400001)(122000001)(478600001)(4326008)(91956017)(66476007)(8676002)(64756008)(316002)(66946007)(7696005)(66446008)(6506007)(66556008)(186003)(9686003)(55016003)(41300700001)(26005)(33656002)(6916009)(86362001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xXhbz3/pEiJRfz65lFAmCCag4SsXlrPBwWAyhHHJ00f6UTqqmVKQYyaZ+H?=
 =?iso-8859-1?Q?yDepEFfRUDjRT5wAt6S+ASpQoVU1PbTsI+aDFJGbfUMz0u/Yu3a92Gbblj?=
 =?iso-8859-1?Q?NCs0NFG/BzbO/hz16q6m4/zqrZgfsaJtL5APHttarvU0gXS0XIFx22f8vr?=
 =?iso-8859-1?Q?kw5J9dx0nTKi6Zr2iTvvLQ68NDdTMdcCcg40xsWDui5t7KpPai++ISjI1g?=
 =?iso-8859-1?Q?XW0URUys4KBJGq1f8ZgFifra/bMedTshDDQuOLxNu3n0+rCWs0lVTArgmd?=
 =?iso-8859-1?Q?eMpfTlcbEBpr2VBWmkC+BA3OFpgO8nBlrXuE3fLJaOBRAn8a5EXdLkcD+8?=
 =?iso-8859-1?Q?Blr3KEWUjPn/cxfRjkY74SBFRurS3hgMdtiNqPoOhh2bGklOQ2N2LDA4GY?=
 =?iso-8859-1?Q?hDM2jbV71AHddEJWM2kgCSmZPY0s7fGSevtTtuSBLes58yoCZwWiGqTCmB?=
 =?iso-8859-1?Q?pZ2ef6sdPP83pXOyvN6E3r4Ps2r6Fo0nK8saGepsnMYN9GFpdyCTu1Q8/R?=
 =?iso-8859-1?Q?wkw3/jk4doD2t7BxDUvLMs4biQZQFwVlIFfZGUfwk5/D35HLgeb8cAGsZ9?=
 =?iso-8859-1?Q?9JvfoU63MRweHQ/bW6npNw4bB6dcSqidB9QoWbZ2w56MJG6eRJ/9fg54BB?=
 =?iso-8859-1?Q?yIP8ouh4Bk9zDGNZAwueEM/t//UEq0EcriHTmNUE0FIIozNx8XjoNZp8AU?=
 =?iso-8859-1?Q?/FJX3LXs6TK3x6zR8KAXywwc5zRYtcdNRG4xuaLhRo49VawuersfJzLtOb?=
 =?iso-8859-1?Q?apPqRshKQkAhp/pn7SmY9r/LGejsad4TQ2lvSOFEcneTq+OR+dyKOo7qWh?=
 =?iso-8859-1?Q?vAwBpkT1xRBkjgb1xm11PdMaN9LD1F1eYi0vYHVwnbd8qvzpx4A0LmKcES?=
 =?iso-8859-1?Q?i5dmxuZIOKxSwt2G0qvUU9yUvU2E50nKnCOl4kilW36O0PPhBtbWndyrWv?=
 =?iso-8859-1?Q?IQgJ5uuM9J5/sevvshBWWowRiotjXA1k0nU3i6j5TfVqOx/yeFVZ4b6mpb?=
 =?iso-8859-1?Q?n+SNimIbFJ4QAFifT4Ytl/BsdGrWqwewC+cqCnyKR+rMfRz7YyueEiwpZ3?=
 =?iso-8859-1?Q?tdDABnWUunn3p655rk56UKUn8w7IgeWC2yey7iCJQHMUzHxRr7jd4Floqx?=
 =?iso-8859-1?Q?sPK4SpLpKqN58B/W5EXFz3rWL31IBjYCGxhKks7CWiNyadpqbxZTvq70R4?=
 =?iso-8859-1?Q?ExUeUhQ/eYAE3TL4adH6CuU8nHWwiYrXHkkuIN6D29d47wzlMnAcOfpmwE?=
 =?iso-8859-1?Q?NBxByRHnzLi1/Rg47CeYPEOvpbw8g5XdWl/SbgoKXUIqJi1ECdnOdD6U42?=
 =?iso-8859-1?Q?t5cEMb4wVHyW0SM5FO5komQ0D6GYzxvgbrmk//t0yqOp8dZT4wgbdMgbyV?=
 =?iso-8859-1?Q?4PDf8E7OggdX+IMZkdMmgG+Y9rIM0nqyJE5t5kB+y5BoGOCESQI4F65ZH5?=
 =?iso-8859-1?Q?r6eMG6i6zoMTdoU0KDC8hLDexonIydAKtfN9XwFzunUaN7Ql2SaExrBGJS?=
 =?iso-8859-1?Q?pzmj/+rAoyg7lQZ8zgCdhG9ueRVesTjoIZH3rcJnX5kme0JKrvGxIbcMHd?=
 =?iso-8859-1?Q?k4tLcHrSsnng+6epnJku3MA6l9L5dPBK4MT5YtjSSYpClUa/YGQJzHV8jz?=
 =?iso-8859-1?Q?KCiqjz2E13jgw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5754931c-5450-4c39-331a-08da71c3fc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2022 00:39:39.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPF3udNME4tWYJTqGNzMShHctQuh8J8ifYXMHdWhir7UL0VgInu+qrQmiOlzwWrqMJkNA0eDPKp+qQ0VmKXRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1257
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz Augusto von Dentz wrote:=0A=
> This is for a GATT Server, application implements WriteValue, or for=0A=
> GATT client, bluetoothd implementation of WriteValue?=0A=
This is for the GATT client.  I have to write a password to the server from=
 the client.=0A=
=0A=
I got a little further.  I found that libgio requires the error parameter i=
n the parameter list to be cleared before every invocation.  I don't yet ha=
ve some semaphores in, and my code was in a loop doing the WriteValue until=
 success, but the error value is not overwritten once it is set by g_dbus_c=
onnection_call_sync().=0A=
=0A=
I am setting "type" to "command" in the dictionary for the 2nd parameter be=
cause I want no response.=0A=
=0A=
It turns out if I clear the error on every loop, the error I see after Writ=
eValue is issued on the characteristic:=0A=
=0A=
             *  0x55e74e6ca860: print_error: Error message: GDBus.Error:org=
.bluez.Error.InvalidArguments: Invalid arguments in method call=0A=
             *  0x55e74e6ca860: print_error: Remote error=0A=
             *  0x55e74e6ca860: print_error: Raw message: org.bluez.Error.I=
nvalidArguments=0A=
=0A=
Unfortunately turning on debug in bluetoothd tells me nothing more.=0A=
=0A=
This happens to be the characteristic path:=0A=
=0A=
/org/bluez/hci0/dev_CC_F9_57_89_8C_2D/service0021/char0046:=0A=
=0A=
I sent this:=0A=
=0A=
method call time=3D1659138398.987176 sender=3D:1.3571 -> destination=3Dorg.=
bluez serial=3D11 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8A_FB/service0021/=
char0046; interface=3Dorg.bluez.GattCharacteristic1; member=3DWriteValue=0A=
   array of bytes "MyPasswd" + \0=0A=
   array [=0A=
      dict entry(=0A=
         string "type"=0A=
         variant             struct {=0A=
               string "command"=0A=
            }=0A=
      )=0A=
   ]=0A=
error time=3D1659138398.987326 sender=3D:1.3568 -> destination=3D:1.3571 er=
ror_name=3Dorg.bluez.Error.InvalidArguments reply_serial=3D11=0A=
   string "Invalid arguments in method call"=0A=
=0A=
=0A=
Here is what was added earlier for this characteristic:=0A=
=0A=
signal time=3D1659138398.895579 sender=3D:1.3568 -> destination=3D(null des=
tination) serial=3D131 path=3D/; interface=3Dorg.freedesktop.DBus.ObjectMan=
ager; member=3DInterfacesAdded=0A=
   object path "/org/bluez/hci0/dev_CC_F9_57_89_8A_FB/service0021/char0046"=
=0A=
   array [=0A=
      dict entry(=0A=
         string "org.freedesktop.DBus.Introspectable"=0A=
         array [=0A=
         ]=0A=
      )=0A=
      dict entry(=0A=
         string "org.bluez.GattCharacteristic1"=0A=
         array [=0A=
            dict entry(=0A=
               string "UUID"=0A=
               variant                   string "edf50100-681e-4b92-999c-e1=
6b3a8bc047"=0A=
            )=0A=
            dict entry(=0A=
               string "Service"=0A=
               variant                   object path "/org/bluez/hci0/dev_C=
C_F9_57_89_8A_FB/service0021"=0A=
            )=0A=
            dict entry(=0A=
               string "Value"=0A=
               variant                   array [=0A=
                  ]=0A=
            )=0A=
            dict entry(=0A=
               string "Flags"=0A=
               variant                   array [=0A=
                     string "read"=0A=
                     string "write"=0A=
                  ]=0A=
            )=0A=
         ]=0A=
      )=0A=
=0A=
=0A=
Luiz Augusto von Dentz wrote:=0A=
>You can use AcquireWrite and then write directly to the fd received.=0A=
If I do AcquireWrite, I do write(fd,buf,strlen(buf)), then close(fd)?=0A=
=0A=
I am only writing 8 characters + maybe a NULL.=0A=
=0A=
I will try the file handle method next.=0A=
=0A=
=0A=
=0A=
