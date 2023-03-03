Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC5C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 14:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCCOwM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Mar 2023 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCCOwL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Mar 2023 09:52:11 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B162331
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Mar 2023 06:52:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejg7bwvAoBY2RCDGcKTV1UJQ4X586sSskiDVEdunG8E10gIYl9IPgQtCDskTpswv5jEjLEqoTJl7Cw6SLuOjX8gwoESfbOAPoodreSLhxTQsd86Np9XPB/xeDsC51kFcWgZue05rx7IvaCJm9BcjQRIOYTTQZxGcN5RTJzZZvBvvBaVHOeWRdtmQTNGic7yFJo3Cr5jbYzyPb4dXGcnHHbcG99QRXbOWMl9IbhUjE3ynA4kPdTfF1edS6dnVbDZkbIimHCe2dg5M8C9WokHcYNpY+BBPA5YT+9zOuLud1Hsg1BSlADeAlF0xWl1SlDM3f+c3XyswjtQ9P5wle+Yh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i592rpKJjM6wzROgrriMlJZT88L/8D2AZs59TsohHR0=;
 b=muZMYcfCH+CyznkQ0C6zG19/Z39S67XLXHM6kGrZRopSyDmy+uOIWGT9YDCAzA7KwxaZTaGQqe5b7AtkAaNIthkjqdVqgFmmhXrujx6B4LqWe8j3Y7NEawaUS2VybGkQ9mLI/DYq/PTwm2RxBY2rzRgGj/TeS5xJuxyDwXyvKCiDmT8oojaUgofMeEThPWAuJZ4H9ymzBr+XarBc2HeFlZ16mMlT+Fc4N+ETWMgToQtXJbTQQrBWCTsmssy0Cx3uUcGaJvRfLCEq/992HNe94OBGhS3RLcabUIxAzVxuWxwQ3vki3qe97nasMHMQMKtrp3FYewyZYFS+s5Q0G40xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i592rpKJjM6wzROgrriMlJZT88L/8D2AZs59TsohHR0=;
 b=Jix39++pqQTtUKxwU0Ac0jm3jSqfN07o9r3bQBwXTvn6IO59r9mCVwbFDrtpdSPdcY8zr7Cs0+t4a4ihvqAS46Nkv0I9Ziqkhn95Rqc2u3u01hfGE5XYwkHxKAfh/P6DCcPc3rJcGjnxOFRX+7Pbi0jbnR9ZIblZkw5jjpfNSCg=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB6942.eurprd04.prod.outlook.com (2603:10a6:803:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 14:52:07 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%9]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 14:52:07 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: ISO socket bugs/lack of support
Thread-Topic: ISO socket bugs/lack of support
Thread-Index: AdlN362Wx0mYOcCoTaS1BG6xSTMgdA==
Date:   Fri, 3 Mar 2023 14:52:07 +0000
Message-ID: <AS8PR04MB8898256F1388824FC19F67BFECB39@AS8PR04MB8898.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8898:EE_|VI1PR04MB6942:EE_
x-ms-office365-filtering-correlation-id: 1d97fd9b-d841-4db2-5f70-08db1bf6dc5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDU/i3Yc3DtfkbGT0MbbJqmrhQOdMM6B0UCwTfIb8t9iD0xHW+OByNnr4bQKe5ROp3lWmk6zEDN77AH/tf8zbbl7rVl/UueXnCHb6kd/0sA1TKwC83BxReS4VMR5HuLWEI29h7Ik+7OqtB/YJGaYxJ3gXFUcoRvKX2s5KLsdPos3pBuMj+Iin5MlH3ZyAtfI/9xY4GwwzKd9XNZvoieJY2G1NoHmlBENYbrqd0bvSYxXJvWc/OFLDOfklCMrcOSeijJs2xeLhaO/RV/RikZ0q32jhLFe4onsaKfQis+5mdW1MeYAmNdSqa6I1dHooUngmXmIE4nIU4tNhGzWg+TTfU3hf42VwNGdJsUNXbdlsP5UhmlhwLUkxlBSJuJlsPJRmom2YHKs6dpSwNDmzSD88ZiuIWWpfqWNo/oCCXCM0Wv1XH6RbQLOKeQzJTsPG6Cc0Q3anB81ycNoei9cKFqgoj+XCv4qD19zVet1g9eq9AniBnZPTibVpOEpEVRJU6PtdGHQZpu6ZzXhKYKHfiyipuq/9ZICcY/elCw0udRnk32QpifKpfrzU/XHphsU4JRHTKm18rddcQpo2Nya1EghP/1Vs0LPird1LuxEmHoDvBRX1NUMxUAxLjXfp1xgXpg6jFPt8H2Rw7fiQclNlTg8Yq02ibsxWOTutnLEpvBHBrLxwFvk7u8xkQckAsIK5p8i31ubDysoF/++eRkuLlK6+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(83380400001)(122000001)(7696005)(8936002)(5660300002)(478600001)(86362001)(66946007)(38100700002)(71200400001)(33656002)(55016003)(38070700005)(26005)(186003)(9686003)(6506007)(55236004)(2906002)(66476007)(66446008)(66556008)(52536014)(64756008)(44832011)(8676002)(76116006)(41300700001)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sVB9WdHQj6ZrA62/GmH851pbjtxMOFiyM1B+t42bHEc6e1/fijPIgb71wH+N?=
 =?us-ascii?Q?mAIdVJ3HQkOH3oEHjLCcQSaeudMGZVxgN+m6AYDCuSWUp82OdB+toR86PGbb?=
 =?us-ascii?Q?yIVl0mnN5nEAYFdSkSOaELKXxcQNNGQKIg30gH5mzoTaz/+BBkzHAqCMbh28?=
 =?us-ascii?Q?UFm9tyky9GkvMwG5w2uqzMqvKH/Stg+6HrpvJNFqtsBIoHr/inA1iEiNY6U+?=
 =?us-ascii?Q?N41pM9gKtrXnxex0lyY0p1oF7YPChBliXXwwDHuHkKlz3MHGM732wXBaUCrg?=
 =?us-ascii?Q?uHX0fw69lGGikBedBgBbQ1ziQEKhwnFOAXl4DA9ZbH1sxpTJsSaHK4kQoq4m?=
 =?us-ascii?Q?7EPxnP/Trc4V1U1/QaOtvR1znoBlCohTjNR6aowmXxbg9l3B2dPHq4TiGF0T?=
 =?us-ascii?Q?zjKlUW0vGwtuNma5exY8iv3yJj+R3uSfURZZJQcm68rnLxEcZLbWtE4twPp3?=
 =?us-ascii?Q?iw936PGLAhANKll+B8FB6VQQQqLg/B0sKeUpbbi8LfWGrStSOAilTYeUzbUf?=
 =?us-ascii?Q?BX6Ae1qN7YxSpN2/sau++6HO7p0MwJyBgJUxmfMDIIj8WC7KGVBY8pDJw3tW?=
 =?us-ascii?Q?YI8J3UEPCQ4c3U2t/X+8Rns/8fU3waqvqz99A/Waq4MgYsjAQgrPhqDrY5Wn?=
 =?us-ascii?Q?MCAPCgqKt27YNsr+PEeVuoKz2sXqI5pio7SRAbugmLUV8u9fjoubZXs21bpg?=
 =?us-ascii?Q?QOX1AIwY90bo1qPO9obxmOgfr1huYM0nMIhNB1luA7BwSrcF0COYrLOtYKsE?=
 =?us-ascii?Q?K3p+2wVHBltWt5dCTqsc9dM8RuvQJZAOxB0z/LnFq3oA35/bX53C4y5NSQNz?=
 =?us-ascii?Q?JX3rOPS3d0KlAgbSoaQCF2wPlDeJm5dBGvjMZKuenVNUPNIoiQdF3nMLDQsg?=
 =?us-ascii?Q?umI91b86fMQ7vcQY/LW7K2vOIidMC55Vpv4T6bKEjGSXfqPM1Mpo14UhSl5U?=
 =?us-ascii?Q?l/Ewz54pgnVyHIw8qZC+VrtO2DsVh0x5XC+fWIPWo5NXH7tUNVsK9GI+FM8O?=
 =?us-ascii?Q?J76r7hG7ep0gHjx4PthRI5uokEisBVr3vlCaZ5nnBLnpMicFby6xy+GbvvAE?=
 =?us-ascii?Q?/TFrWiKpug4XsPMD/gFNqaO1Yb5MeDopcKbuS1R5MfrVkEGe4A6tpOda6sgm?=
 =?us-ascii?Q?Tl8+aMIe/WQMgsqKFngoIcMLE1WgbSVmbxeozdxxmIxujCwHTtDezFMbHKMH?=
 =?us-ascii?Q?NfHIulC2j8xmsXSKw8+9d0H9gshb4EoRBzC4Bov2ulAMlvroKvZJyIO7N7JZ?=
 =?us-ascii?Q?2wmVYyIEtL0XdFRdk+JbzeoDNH2isjgJqyg8Cf8ifn+QzZxFhX+iz7IgFT9J?=
 =?us-ascii?Q?HmVqo2Gr8jE9r8qkCEf2dgCJZmxh/iWcJUIgOJgDgZLQHTOkL348LnAMf+wS?=
 =?us-ascii?Q?w3GSmnelXY7gk1/0zoxBf0Fij+ldT53loSQ0kbsPwyheaeXMABR2KSx/qzBu?=
 =?us-ascii?Q?1126ESMNWhz9TrYWIQ7lQLXDJsR9LXo7MPRUhnJdxttJjaXlnXiam5upxoah?=
 =?us-ascii?Q?ys4tdMyuOfV+g0WzA5h+mBJnUKeMXKt03/AqIpnxFqqFfz/+YRFfLkjqCF7A?=
 =?us-ascii?Q?thDVIonyt5Qz9wTYxbT0SuC+foJ/ZFzpHgViKEUM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d97fd9b-d841-4db2-5f70-08db1bf6dc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 14:52:07.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fh91WA/QtXEFp4XYM1bf+JN2eb8dRTcOxj2Q/F0BROI8e50iNTn5Q0kUlVF45MVgxjiZLDHSv9b9MgqjpN94A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6942
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Earlier this week I submitted a BlueZ patch ([1]) containing an initial imp=
lementation of the Broadcast Audio Scan Service.

In order to perform some of the BASS procedures, the BASS Server is require=
d to send specific HCI commands and to handle HCI events accordingly - for =
example, the "Set Broadcast_Code" operation of the Broadcast Audio Scan Con=
trol Point characteristic requires the BASS Server to issue the LE BIG Crea=
te Sync command with the Broadcast_Code parameter set to the characteristic=
 value written by the BASS Client.

My approach was to open an HCI socket and to send the command directly from=
 the BASS handler function. After my proposed implementation was reviewed, =
I was told I should use an ISO socket instead and let the Bluetooth kernel =
perform the BIG synchronization procedure. I investigated this solution and=
 the problem that I encountered was that the kernel sends HCI commands with=
 fixed parameters - calling the "listen" API on an ISO socket will always a=
ttempt to send the LE BIG Create Sync command with the Broadcast_Code param=
eter set to 0. I couldn't find a way to provide my desired parameters to th=
e HCI command.

I also discovered 2 kernel issues when calling "listen" on an ISO socket:

The first issue is that the "hci_pa_create_sync" function attempts to send =
the LE Periodic Advertising Create Sync command with the Sync_Timeout param=
eter set to 0 - according to the Bluetooth Core specification version 5.3, =
this parameter should be in the 0x000A - 0x4000 range. This is why the Cont=
roller will reject this command, as shown in the following btmon capture:


< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x01
        Adv address type: Public (0x00)
        Adv address: C0:07:E8:8B:69:F2 (OUI C0-07-E8)
        Skip: 0x0000
        Sync timeout: 0 msec (0x0000)
        Sync CTE type: 0x0000

> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)

Updating the "hci_pa_create_sync" function and setting the "sync_timeout" f=
ield of the command parameters to a value in the required range solves the =
problem.

The same issue appears when the kernel attempts to send the LE BIG Create S=
ync command with the BIG_Sync_Timeout parameter set to 0:


< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ple=
n 25
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x00)
        Broadcast Code: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 0 ms (0x0000)
        Number of BIS: 1
        BIS ID: 0x01

> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Parameter Out Of Manadatory Range (0x30)

Updating the "hci_le_big_create_sync" function and setting the "timeout" fi=
eld of the command parameters to a valid value solves the issue.

Hopefully someone can confirm the kernel issues I described and the fixes c=
an be committed. I would also like to ask for some guidance regarding the I=
SO socket usage when it comes to personalizing HCI command parameters - is =
there a way to set the parameters from BlueZ? Or should this support be imp=
lemented in the Bluetooth kernel?

Thank you in advance

Iulia

[1]	[BlueZ,0/2] Add initial BASS support - Patchwork (kernel.org)

