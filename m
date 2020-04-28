Return-Path: <SRS0=u/yl=6M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD6C83000
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 12:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7B6206D6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Apr 2020 12:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=targetsg.onmicrosoft.com header.i=@targetsg.onmicrosoft.com header.b="Tqgkjwz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD1Myj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:54:39 -0400
Received: from mail-eopbgr130101.outbound.protection.outlook.com ([40.107.13.101]:45957
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbgD1Myi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Apr 2020 08:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOsOvFVctReiVm2sYJSnfn5Mwfp/HrUiCnFM9lsmNEVohmy76z4k9uRJJucFKA98oX5mE2CpxSUkI93YRQ5sUktLUP8YA1WaJDmOQHJVa/CuIo4DHlQiYcsNOb0LfS7BRm62+1gVYAXSQXAAE6MszAMJaqvjl2tsExBsjHsbtgcXj5YJ30htsXFPPe3mR4O4Qn0rmk3+uAUhQvONh97nTm1lDjQHG1lXAFGgTBCUR6m7SJ9EHG0etDfN4rcJxdeYAgyWKZaNbgR/dBuUXq6W66arwPhV4U39yXL6zWjGNTNYOMaTC/ZNOji91QgvJBz03RAWpXqahXW1JOULYIkEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr2Kiuzb27mO10H59F338oxwcf6dAZ4vb5RFKT+LdMg=;
 b=D3ud+2SvsRn0wIh2j8yWWDBsp786rWXn6wJ7GdDxiL/7qz7kQrHl88CsJg3jbTsB/VngkCO/nJp+CTAMHLwJi8vABiqB0ux6UIfpdUNfkfr7H5M9I2o9xhBiGjCXtM2WYYBFZiARNO7IAFJ+MH1HGKQA8tvcYBflmhwb+KktKeX95ZLShoqSN50Dz70LvEG0PtViSEQAACfBbfBvkGUyNo51fA0/LBMP92ZIVmi4nORwyNm+0ijo7FhT2mrTVsINr9PjVlOItKX1uocWIn3W39IX5UtVzwEo7Vm3fxbcIzLbWnw3dJWxRsSVDmm67yczi/TqJvHf4qklSGnBsoWDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=target-sg.com; dmarc=pass action=none
 header.from=target-sg.com; dkim=pass header.d=target-sg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=targetsg.onmicrosoft.com; s=selector2-targetsg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hr2Kiuzb27mO10H59F338oxwcf6dAZ4vb5RFKT+LdMg=;
 b=Tqgkjwz8ceLWeGokGSu6VLPUl59lDRe9CK0nYCCCG0nKuw2CexuQcY3x7D2S0DVq3OAn/Jd14cy0EE/pqLDvkxVWsASXvxq1AJnQwjGmxGvZhJ0JlTGo7RggsVO4RlAcT//mQO/sdpdQntiQgvttM6iLKsuMkvgFIbouQ2FDrME=
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com (2603:10a6:208:4f::30)
 by AM0PR02MB4499.eurprd02.prod.outlook.com (2603:10a6:208:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Tue, 28 Apr
 2020 12:54:33 +0000
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::4d5d:9388:b698:6509]) by AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::4d5d:9388:b698:6509%5]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 12:54:33 +0000
From:   Kai Ruhnau <kai.ruhnau@target-sg.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Characteristic ReadValue / WriteValue never finish
Thread-Topic: Characteristic ReadValue / WriteValue never finish
Thread-Index: AdYdVVYfYNIK9+NdQ2qzCgtUcfNppw==
Date:   Tue, 28 Apr 2020 12:54:32 +0000
Message-ID: <AM0PR02MB3841479A0B2378DF0B0109AAC5AC0@AM0PR02MB3841.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=target-sg.com;
x-originating-ip: [2003:c5:170e:9b00:650b:ac6d:6d2c:a661]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06c8ffeb-b15d-4aaf-0c6a-08d7eb734c5d
x-ms-traffictypediagnostic: AM0PR02MB4499:
x-microsoft-antispam-prvs: <AM0PR02MB4499F1555B8421EE0F7FF664C5AC0@AM0PR02MB4499.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3841.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(39830400003)(396003)(376002)(52536014)(8676002)(186003)(33656002)(81156014)(5660300002)(44832011)(6506007)(66556008)(64756008)(86362001)(7696005)(66446008)(66476007)(76116006)(66946007)(71200400001)(2906002)(6916009)(316002)(9686003)(508600001)(8936002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfuyOL0d/W4AIZh2H9k1jiQNtS3TqldHyIP80QpAPh9c/gPBUQvV4NRGsgEYhwICREWKwimINiPKLgQt32UYmpEM9g0RBWm9TPFJQd5mLFoF82DHHaniS4UaSwL/R0x9Z/Fj22Yin22nimcZRdO67dwqM3OvcJ0WObtVqXTvz1fhpo3j+q+Yp2Rn8NACUX1ZAIZhkaAyA0j2KMWeoOBR9k8d4pVTpF+pQ27X8WYMpRlb/6gvSExN5rE3xu+hASwC7K1ciGcoSBlXGBBNVumoeCydBWhyKHivn8VPwSJ42ZQR5nSzXojhyA7eMSijE9M9d4y6n5MVZv5GNwCZVFUiRi4KA01TvGOdh+GHqZ2uTJISDeN7byyDUi5fWnaQ4Wa36WouOCHULMvKfdDDizUxzlwQ9JbnV01nZvutNv97PQH7LGttG5HwEYA+sDY34RtB
x-ms-exchange-antispam-messagedata: XcdrpcqrBoI20WSQA65MhAE+PlvyrK6ipASp0zI1SfAwdxIeYcqPFBZb+EPiT5D5znwQlbokFKj4wcLzjSYzOWCe2FVW/e5zth0a0HG7PWZ7Uf7AH3CWmmIZXqC7N9a5bNEaUEHvfL2RbI7SzS5+HFn3v1XMwrtUsDZmVWuiWTCsdTd6jDasSEDKglW24VdH2PusHyL5xQBrcT51do61LwXTrjQGaETi+r05pnXtJdeGE1onD/ogwhbwrdL1bWOzkqWmxL7rbDrolgeB9l4+MBAnnYpl5b2t8YqPtODmdueUnJuuLHXIWj4WBSzqi5OMiA0XyhVKO1m7JqQ5kYVlcanTQb6cQvbgIaY9IGVnQz74gG/m+Bj4cxEVibk69SFVaF42AHXea6NABbBfhjDl9WgwuGHJEzc8s8XZ0biGMb3g8cQ8oXDRWSoQz8EjD3ktwRDBI/Hl7tM3syxwFBLATDlTlo118MpoodcKhOmTevhU8IjY2HkJmTuz/QcHzM2B5ZL8BE1pBQe2CwgUsHiM7iTDhBZCLetidhPAkswYqPJHNbbfTllxBwM3ehIv+ScgUp4r1cFFmKXoAcoNVkhlnLhFG7MSILS9tHFpjX5tvjqOrmOh08pLsGSiTDPkP2ixp8eimZjbu+V4l/TYxdCKOMyaiUYOWKezWdzsBRZtvmDmbw9WE1DiH7aJ/ODfjNgPpnE1Oq8d2BSTru6iuz6ZeA6aFkCd2Lc72uSn89IEXLR8ur6pojCAWvrImOmYlFheviK9Kt4c2kMOLDYLr9ReTx1G02jijoyVw790JabENLVu0bh6zyiiv690vtIFA2w6XnmZ6FonwtU2N54AZj6waai2rK7GCzQ3UZQpFlY7upk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: target-sg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c8ffeb-b15d-4aaf-0c6a-08d7eb734c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 12:54:33.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 52a4fe2f-f30a-452d-90b1-03ecc8ab0c0d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3VXNSrbvmsg95OHlyR6zBeQ2xm4vuhIdVxhEz21NyKh0YX6N5cF3dSfq2PCn0sVUdBUZ89T7jb8iL9wgjf7ejoUC0H6MVjBvv6P75ahrKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4499
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm running Linux 5.4.32 and Bluez 5.54 on my embedded platform and use fro=
m my=20
application the DBus interface to set up the local GATT database and work w=
ith=20
remote services.

In one scenario, I have an agent registered and call as peripheral the=20
ReadValue method of a central's encrypted characteristic before pairing has=
=20
been done. This results in my agent implementation receiving a=20
RequestConfirmation call for pairing. I complete that agent's method call w=
ith=20
an org.bluez.Error.Rejected error and unregister my agent. The initial=20
ReadValue method call, though, is never completed - my application neither=
=20
receives a DBus method return or an error for that method call.

Instead, using btmon, I can see that internally, the read request is=20
continuously retried every ~1.2 seconds. Each time, there is an Insufficien=
t=20
Authentication error, a Pairing Request, an immediate Authentication Failed=
,=20
and a Pairing Failed response.

I would have expected that after rejecting the first pairing request, the=20
ReadValue method call is completed with for example a=20
org.bluez.Error.NotAuthorized error, and not an uninterruptible loop.

These are the bluetoothd debug messages while in the loop:
bluetoothd[2370]: ../bluez-5.54/src/device.c:gatt_debug() Read By Type - st=
art: 0x0001 end: 0x0005
bluetoothd[2370]: ../bluez-5.54/src/gatt-database.c:gap_device_name_read_cb=
() GAP Device Name read request
bluetoothd[2370]: ../bluez-5.54/src/adapter.c:bonding_attempt_complete() hc=
i0 bdaddr 5A:2A:C3:75:E8:BB type 2 status 0x5
bluetoothd[2370]: ../bluez-5.54/src/device.c:device_bonding_complete() bond=
ing (nil) status 0x05
bluetoothd[2370]: ../bluez-5.54/src/device.c:device_bonding_failed() status=
 5
bluetoothd[2370]: ../bluez-5.54/src/adapter.c:resume_discovery()
[pause, then repeat]


Here's an excerpt from the btmon log starting at the reject and showing the=
 loop

@ MGMT Command: User Confirmation... (0x001d) plen 7  {0x0001} [hci0] 44.04=
5329
        LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
< ACL Data TX: Handle 1025 flags 0x00 dlen 6              #322 [hci0] 44.04=
5373
      SMP: Pairing Failed (0x05) len 1
        Reason: Numeric comparison failed (0x0c)
@ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0002} [hci0] 44.04=
5400
        LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
        Status: Authentication Failed (0x05)
@ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0001} [hci0] 44.04=
5400
        LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
        Status: Authentication Failed (0x05)
@ MGMT Event: Command Complete (0x0001) plen 10       {0x0001} [hci0] 44.04=
5426
      User Confirmation Negative Reply (0x001d) plen 7
        Status: Success (0x00)
        LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
@ MGMT Command: Remove Advertising (0x003f) plen 1    {0x0001} [hci0] 44.05=
2011
        Instance: 2
@ MGMT Event: Advertising Removed (0x0024) plen 1     {0x0002} [hci0] 44.05=
2029
        Instance: 2
@ MGMT Event: Command Complete (0x0001) plen 4        {0x0001} [hci0] 44.05=
2041
      Remove Advertising (0x003f) plen 1
        Status: Success (0x00)
        Instance: 2
> HCI Event: Number of Completed Packets (0x13) plen 5    #323 [hci0] 44.19=
0618
        Num handles: 1
        Handle: 1025
        Count: 1
> ACL Data RX: Handle 1025 flags 0x02 dlen 11             #324 [hci0] 45.08=
2137
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Device Name (0x2a00)
< ACL Data TX: Handle 1025 flags 0x00 dlen 14             #325 [hci0] 45.08=
4191
      ATT: Read By Type Response (0x09) len 9
        Attribute data length: 8
        Attribute data list: 1 entry
        Handle: 0x0003
        Value: 663930307378
< ACL Data TX: Handle 1025 flags 0x00 dlen 7              #326 [hci0] 45.08=
6693
      ATT: Read Request (0x0a) len 2
        Handle: 0x003b
> ACL Data RX: Handle 1025 flags 0x02 dlen 9              #327 [hci0] 45.14=
1328
      ATT: Error Response (0x01) len 4
        Read Request (0x0a)
        Handle: 0x003b
        Error: Insufficient Authentication (0x05)
> HCI Event: Number of Completed Packets (0x13) plen 5    #328 [hci0] 45.14=
1350
        Num handles: 1
        Handle: 1025
        Count: 2
< ACL Data TX: Handle 1025 flags 0x00 dlen 6              #329 [hci0] 45.14=
2787
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (=
0x2d)
> ACL Data RX: Handle 1025 flags 0x02 dlen 11             #330 [hci0] 45.20=
1290
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (=
0x2d)
        Max encryption key size: 16
        Initiator key distribution: EncKey IdKey LinkKey (0x0b)
        Responder key distribution: EncKey IdKey LinkKey (0x0b)
@ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0002} [hci0] 45.20=
1455
        LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
        Status: Authentication Failed (0x05)
@ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0001} [hci0] 45.20=
1455
        LE Address: 4E:FE:AC:7A:F8:93 (Resolvable)
        Status: Authentication Failed (0x05)
< ACL Data TX: Handle 1025 flags 0x00 dlen 6              #331 [hci0] 45.20=
1551
      SMP: Pairing Failed (0x05) len 1
        Reason: Pairing not supported (0x05)
> HCI Event: Number of Completed Packets (0x13) plen 5    #332 [hci0] 45.26=
1239
        Num handles: 1
        Handle: 1025
        Count: 2
 [pause, then goto 45.082137]
