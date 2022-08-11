Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA6C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 15:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiHKPKb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKPKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 11:10:30 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1079811A2C
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 08:10:28 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id A34308275C_2F51BE4B
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 15:10:28 +0000 (GMT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 3EA008267E_2F51BE4F
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 15:10:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+H5Krvfk+Kq3QN5NBq/oV2RnMPi5a5PEX3ktuSIClaHkAqeiVhGQFXOwY2bZUYeiGhEXHuYMNjH7cbT6CVCDCoC7yElqNCVZ/wpAF55GAei45fHQwPs74RnbhAiaWm70lbQfp1CrxwLrlrs6vDj68xgYLfOWNTVndp8PYCjfagyXErcGOedRI1gNlTSE0GAkJeJzwzagvU1kOajVaiVUqQUj2jDOT03u5hifTYkp9Bq6bAMODts1ThnDG7+XWvtnMrJO6AolV+Zq/aiuST6cSu99ndY30ER7NWOvUxavm7/NZH0Ze8AeWWtyzG8G3m4r9BbJ6OTzgPzaAxyqfhP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEe54j5dCj1KSooSB0oZnIhrE8VzD+vUl9wq2t2LF2c=;
 b=OS3AYKlCwgjm/bc/SP+6otZGib72axWYpUyAbpge4wNVD345TGFK/ZjxOPBjSvGzE0EYFif1o2xCdcm4yXLLS8A5WDCcEhEmIuvbr6hmLNg6xB0wfR6OFPU9XR/SKA4si7Oc3zPbl4d40pdqiRoGpUX7mUg0T3uQecnykIPoju3CKCf46V49Um1oAej8iTd6HZU94yaP+dSgjF+tY5kcS1bJvSBPZzGVuJPqQIBiCvXBJTqO+c1/azjVkkFlgn+QaEZtnOzaGFDyrFqoQ7ZNe0bnUj0apdp14QADNVVlEk3XokQ3NMZLu44p8IknHhzS9geqmI8J7ZbtgG+ker+M6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEe54j5dCj1KSooSB0oZnIhrE8VzD+vUl9wq2t2LF2c=;
 b=pK141uC5jrGKnVPHELncvBvomu0sdIsqjVuoUbjochOd8Z1BlLx3nprhxYuxBgU5ahB1CWITdS86BJWZ13Wcm2s1y7W81xlxAUxLJ8su/VRBplUiUDoBQpaXnViQZjf3RhdTPFgMqzK03UE/r+4lvGmMKLdYmznKSa7JlA6SMfc=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by MWHPR13MB0974.namprd13.prod.outlook.com (2603:10b6:300:15::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.6; Thu, 11 Aug
 2022 15:10:25 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.020; Thu, 11 Aug 2022
 15:10:25 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Are Parameter types in GATT meaningless?
Thread-Topic: Are Parameter types in GATT meaningless?
Thread-Index: AQHYrZBA3LbGM3mLxkmzbo+KLXGmQg==
Date:   Thu, 11 Aug 2022 15:10:25 +0000
Message-ID: <SJ0PR13MB57558411E93695C02DCF7166FE649@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73182fae-8596-43b7-9f19-08da7bab9e50
x-ms-traffictypediagnostic: MWHPR13MB0974:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxqvHvRv7gJ+XQ4eaGdMcXacXXq4dxCGQRiGZX1XmS4/eCQGb9DDASKFG4Eo2MWWi8kMvd+OoCiP2KmnNiEe5NNRzikG+/3HPgjdbq/Ze6OBQYC449HUB4YOrRBmABBGeqojkoumCgH1qybHLABzxDY5TdLmAXgelc1gEKhELf6gq8Gn5Xfk+B2+1k8DZ7mRtqejIkaS9l4CCbhlSF6im+GB/x9baafIe+Bl8BClXQyYNcwAPLuusSTz6zDblPpXHaDD1ncMiJxSYu8ag2QHV8yZKDILz9na7oBpk+fuBXK0cnAmRao2crHVHXAyRGfGkcp3MHcWXnQTyfKKNTej7BOPl9YaYRg8Qeso9e1D0rt31zwuEqy1xJkPlPeH3fjaLPFufStC25lyJnYUwbEn8/2INDzEDFIHBb8wxAr1YM7yVk3g/uRF5C+GKH8QYZWaE419J8TbyN5lQaPxdPbX3Mck0LZSQPAirTQ7ekv3gWYJztU/489L3fOVSbBTGJn5/Av6Xh/SCkkFGDTlYNgKH3hRnwIKeMqDehP0DZbSx+TsfVddu8PXbiw8OGS5H+BHkX/XqWVkax/bJN0iEFVIYq/o+Od0zhcw0urK0OKvLuevNBsPoiHRiNoWZDmMzTtjZlAMceWM5jUYpOEdy0CpnPqdjXD/lZA07f2C1dYKwIFDlrzqiy3TTbeYVPnovkcb6yXb4t2zSYNvLbfgdwI9bgAUFuwL0/PBTtmHYIOcQJAPehKGPv90UpkWxFjgOaURGTnPwPwaIxa7MSbbuo6Zz6lk2ZlEPxPHAeWXFrMlhOLJvUp7xbzDXZnANoMu5mY1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39840400004)(366004)(376002)(136003)(396003)(86362001)(66476007)(64756008)(76116006)(66446008)(66556008)(6916009)(66946007)(8676002)(91956017)(8936002)(33656002)(38070700005)(122000001)(38100700002)(83380400001)(6506007)(7696005)(71200400001)(41300700001)(9686003)(478600001)(26005)(55016003)(316002)(5660300002)(2906002)(186003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a8OvJTTutLzvSXK7LFJgrQrRW9+hV4uI9oJqbPhbcHxcpEGTPL6SZcS0d8?=
 =?iso-8859-1?Q?WfzDKxRURf6FS5DijFW22FqFA9Q+yYaN9RbJMI1O17cpL5eDaYnXFR7sdM?=
 =?iso-8859-1?Q?eCuGj9HtFStib1mJ6Ob4k2+9jbK7cKEx3hCTIQsJfls9jHd4c8lKNdFDan?=
 =?iso-8859-1?Q?+a01ZAZ/x3EvJPIGrin5/y067nV13VMM6nxfHSirVAzg/n+sH0Xj9vq7Vm?=
 =?iso-8859-1?Q?y0VsI2ARo86ZsHpUgSrhQI0YxUtPm78qlst+3FHeY9i9Pjln4VD2Gcndmd?=
 =?iso-8859-1?Q?ZdGp1Zu5x+mhK49Nb6OWJCWsXC7A7so3sqGsQdW+sqaVmzbxbHklXKTTVV?=
 =?iso-8859-1?Q?IqiaItgjeZAtGmiSGKTiB+I1j9peEPi6qZnOWUmRznwY5FZzidZvtftBLv?=
 =?iso-8859-1?Q?Q007gwpUdp5SHTI5HlN6LQG9+86DHvoU6FXcHofoAwajMxQGefNYubtDVx?=
 =?iso-8859-1?Q?v9lbVG2dvZ7C1XhwYA4Wn47yH1balDES0OKKLoQJisr2wBFS9swkhx8KBX?=
 =?iso-8859-1?Q?1R7HS7Sqz6CPDZvziZM3XNj1Mc49lYJMMaHZPx3i4ZiC8gKm2xJnJj3ovV?=
 =?iso-8859-1?Q?+MEawafiNYCM3GKEgdLg503sSEDk6HMM2W9GcE+2rsf/vpUlG4t0X0LAnX?=
 =?iso-8859-1?Q?NQtceY9bssiHfgCHu4Dc59mwZVrBVbr4KoVrn1ECtbLatGtbRB8ts309M7?=
 =?iso-8859-1?Q?LiyLzpHIFvivD+cjkp+2me6PO/eYN1qqpQmOlkvE8omlL45l49z2mYRcLI?=
 =?iso-8859-1?Q?tGdsjYfIGG3xpY2IjgUsKyga2Emv/kS8+WHIQGICb6LBwphE3YYQEogT9L?=
 =?iso-8859-1?Q?nVos7Ij9SzdoTl2hg66z0Ifrp4ult192otEUHfhK6sxysF1GRokwBBrhlN?=
 =?iso-8859-1?Q?SmrSAcHrufsTaI8A/e74/I+XjDhwqhXFkQkAbKST1SS765ju0pi3CwIi4/?=
 =?iso-8859-1?Q?pr4u0HBdG/1CkjFEaVwzkR3DCQpvVYa7y4+lf/b83a4wLgvg3KmpChCZz3?=
 =?iso-8859-1?Q?wLgksELpDSNNVdABLiHGInTXRYxNzNXDBe1k82D2NHbes0so88hJmka6O6?=
 =?iso-8859-1?Q?8mOhRx3RZ1EuP8TZHBv6EK+lmDNYUFTu5KdPcvOmW9/PF3EUVMcSnzpqFj?=
 =?iso-8859-1?Q?PPky+DUBahy+QP9Ujxd4s54IEGZZV46x9+RQu7HSBUbnfPeD8j0VbwywAT?=
 =?iso-8859-1?Q?XLXr4CmaZHo5vN6orGOWFfWKydQDnR4zCIl1qI77b2vNNcrJDZUF/nbhdp?=
 =?iso-8859-1?Q?hzqSSu6lCRgXyaDDSq2gKOMIZdgvQBiFBNPUW65aP37ic9QCJkNZaF3MZ7?=
 =?iso-8859-1?Q?atkct2JnPPtkbB+LLyeOvWNOwkuIbkWyY/kKgISJw2wE56lurroZ3kcjCl?=
 =?iso-8859-1?Q?RBDQRqT7TeOlbbApQpCUnaisYvkmSS5Fplnj3QJIkWISWNsGiijiHmTHwP?=
 =?iso-8859-1?Q?AgTt/Dg+dOdJIsZVWs+XklcBkNFtg4oBrHurw2D7KCYdB7fXFXv6b4e4fj?=
 =?iso-8859-1?Q?Ny7GfaU6cDtMNlqwx+GKkob/Cpswjp9xoajr2H0n3vnLYkdgE50xZ+4oAM?=
 =?iso-8859-1?Q?bUk3rmIyc0FnBy1jGFUXcPh5UYWLIE9zaBsi467e4oKyCr3K3UT093L/U9?=
 =?iso-8859-1?Q?HbLOaw39CCi2k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73182fae-8596-43b7-9f19-08da7bab9e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 15:10:25.1741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNSXLFCH9KBLOZV6OdATlsGOGKJyuETohLBZXWnih+hMo1CDrYoW/7W3g7QvCG8mZuSRcApE7obzOcXHP/WkAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB0974
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The manufacturer of the GATT service gives the types of two different servi=
ces:=0A=
=0A=
uint16=0A=
=0A=
uint8[32]=0A=
=0A=
Should uint16 be uint8[2]?=0A=
=0A=
=0A=
I am using the libgio interface to D-BUS.=A0 This uses GVariants.=0A=
I am using the WriteValue method of GattCharacteristic1.=0A=
=0A=
For the uint16 case, I find that if I use:=0A=
=0A=
(aya{sv})=0A=
=0A=
then I do not get an immediate error from a bad parameter type list (signat=
ure).=0A=
=0A=
If I use:=0A=
=0A=
(qa{sv})=0A=
=0A=
Then I get the error:=0A=
=0A=
Error message: GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Method=
 "WriteValue" with signature "qa{sv}" on interface "org.bluez.GattCharacter=
istic1" doesn't exist=0A=
=0A=
For the uint8[32] case I use (aya{sv}) which is what I would expect, and I =
get no error from the WriteValue.=0A=
=0A=
Are byte arrays used in all cases with GATT from a D-Bus perspective?=0A=
=0A=
Here is the message that fails which was logged by dbus-monitor:=0A=
=0A=
=A0 uint16 2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=0A=
=A0 =A0array [ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=0A=
=A0 =A0 =A0 dict entry( =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
=A0 =A0 =A0 =A0 =A0string "type" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
=A0 =A0 =A0 =A0 =A0variant =A0 =A0 =A0 =A0 =A0 =A0 string "request" =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
=A0 =A0 =A0 ) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =0A=
=A0 =A0]=A0=0A=
error time=3D1660229364.819130 sender=3D:1.0 -> destination=3D:1.197 error_=
name=3Dorg.freedesktop.DBus.Error.UnknownMethod reply_serial=3D16 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A=
=A0 =A0string "Method "WriteValue" with signature "qa{sv}" on interface "or=
g.bluez.GattCharacteristic1" doesn't exist =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=0A=
"=A0 =0A=
=0A=
While this message/parameter list does not provoke an error:=0A=
=0A=
=A0 =A0array of bytes [ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0=0A=
=A0 =A0 =A0 00 02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0=0A=
=A0 =A0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =0A=
=A0 =A0array [ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =0A=
=A0 =A0 =A0 dict entry( =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=0A=
=A0 =A0 =A0 =A0 =A0string "type" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =0A=
=A0 =A0 =A0 =A0 =A0variant =A0 =A0 =A0 =A0 =A0 =A0 string "request" =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
=A0 =A0 =A0 ) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0=0A=
=A0 =A0] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =0A=
=0A=
=0A=
=0A=
=0A=
=0A=
John Klug=
