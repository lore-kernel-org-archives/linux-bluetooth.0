Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D857FC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 18:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjHDSzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHDSzi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 14:55:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2024.outbound.protection.outlook.com [40.92.89.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB894EC1
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 11:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5z546opHzpRWQzowpWMrYYzZoj8JZ03Q0criPkWtopSrSglngBb2gs19VUzevxz1xi2Sl5UgUIsZxoqTfJ9tsUn0PlPKa3U5jlGv4S78cSC1yiMAC54VTGPzxLD1ewc6DFFAHig8vRfZK5rdiuUIcqQ4RLBRU6DjGTnsH1uoKhKHsiLko7LAnfSQezN2AxZ9BnYuaohf8ef4Rv53Os0hLqvCGS3qInXTidiSXs8F2kYDazCpYsXDytSarXLypnOb5kJKq4RVQSGkON8QIbZxA6uHGBIo4Kx2PJdvWovKmCokbFeNObMcqAwon1P5gN+MM6Luq7zuzlJC08FNsnApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjyNtm2xvSz91wD6PmlBksHiPaDrosh56mkw6mDaUDg=;
 b=Xa+89aFYeD9Wk/nwcuQHwOw9A9bey23BpkUrEii97XqZIJx0y3rSWJo9MJxEnunylPiPO4ZEanu++7HGSYDwup8Y7qoFUZXPTcuDmXWNDeWRYM2HZICWP0pXF8EsD/IHg3uifOOeU3nj6aKfkbk54504qzmo1cuwYTmgygJ4RGM76fcIwgN/Xl7ju+/AL46Ll6yMuCRDv3V2HnA5j0r9dqOvP7t2CrUej67oaIWxnLkwzPvZBhhOpSA+oK6Nbr+em19lY0pDPQRIeHHAMcZnrsfx35DZwrkEjRcp49gq1igJoXmDmMnCq6ET//8EXgrUTrTJ+OsrSwBFnyp7E3P4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjyNtm2xvSz91wD6PmlBksHiPaDrosh56mkw6mDaUDg=;
 b=q7CXNuKCkPUswt0v4l3HAzU+ORUimUEUWKkSyXOmrwYPHz7BsZdNz+GpJswy0AMrrI8vuVAuL2pu3M0ZuryKWIDyICsdft3sZzXp+jNT4ZVoCjTi8q58wa8uicNkAWEiAoWBCMKa3vUYJqTErJMMKVt9YBajED5PjD+AiRKblzb7fRayFo3lMvgpmYmQ7LbRjnmr9jDx8jz4rqcxNE7HdSk0s3YmE8xXCosXoChpKG2KiRyHsltLqqRDMLfbR6gYeGUdmGO90IP64teZHpMi3r3UEVsRfPpCU6pNrDTKb410RDoHSiBbL8XIpg8JUx4CHbrHUSPL+uB4dTKVNvVlzw==
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:30::18)
 by DB9P191MB1929.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 18:55:33 +0000
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33]) by AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 18:55:33 +0000
From:   Bruno Pitrus <brunopitrus@hotmail.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: regression: kernel 6.4.x breaks scanning/pairing (but not use) of LE
 devices
Thread-Topic: regression: kernel 6.4.x breaks scanning/pairing (but not use)
 of LE devices
Thread-Index: AQHZxwU/4AwgzlJVUUO91gqc7Q9eIg==
Date:   Fri, 4 Aug 2023 18:55:33 +0000
Message-ID: <2300626.ElGaqSPkdT@bruno-beit>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [vwi3Bg1d5eErhvLoHiIOOkmfPRmPxVkY]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6P191MB0501:EE_|DB9P191MB1929:EE_
x-ms-office365-filtering-correlation-id: d1f8d993-b7f9-423f-e878-08db951c61c9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJQZ8vpO75/YElPXmfJAcLyCTmGGZB9GvPRgR68i/2Cgta8qzwfZ3ktmhMWyHva4MF8O39J5QZpFx9p1jHW7w+LtnH9wuncNRpozH08tpytd251HVw+kJ4o5vq9Y3qu3Bq/Sc7g9j5BWPMO8JKucIVrODa3Maq3sorTJPpYcnbNDjE1Z0kxX6hACCRKMYW3QDTuP9Zme8JWj+WE33mFSz0+CHITsQmG1x9hW8z9P81GVg4mZIaC+4+uzb7bfOyB90JrKu4xQCApNv8OCb4HE1aH79IZJxkSF/lNfd6vxMZMy56As34S3R6KR+A344QftKg2J+y3QgCei7cJ+TjkpQROXq8+VeT9tGO4JBcHfP/qmsF9MmuIqHInOq771ntbgBhdORDuaXjsOnimMwt21idH+Xvd5CNo7am2vC7Y3Xpf8hu7d0MWb67uGbPSaya1UijrAGrNKYJ4EmNM90zIYHEBNVm2H7CjVDhpUAIDwJOlk7HF+D3QqvA6yvGLknuKiJfJvARRKQ9IwBC4Aabont7YPXPhd4jZqtPA7cJAYiHlr/LADxdq9/o6NfST1YOyp
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1250?Q?5rkwt8ftYgoxB+N8cefqBSET/LzxPE9Z/1146lN3TKpbBq/CC83Przzv?=
 =?windows-1250?Q?yUVmt2OXKI7eA0EP0CxjdXKs/eS6Qwkh5XiMX1p8N/9cJMGXwGB1ABHb?=
 =?windows-1250?Q?fXaS9yFt8OTm980KIt61TIIp1mdInAiKHw3tUO/+K+Q0leNohf6g/at+?=
 =?windows-1250?Q?QMZv1kaCrV3atC/5WvtgMabt2ajPp/eKeng3LHRo5vK/7WzWHKmadkN4?=
 =?windows-1250?Q?ETif8NOYM7YdBIiW+OWzrcb2PchoqdTZD6mT1n3Q5rvoaZxFU8VoCLe2?=
 =?windows-1250?Q?HCEB8W1t9Bzh8T0QvowxGca22MKeZveAbx+HV2ks1HaQoKLBAaXcGpQc?=
 =?windows-1250?Q?14sOaswL45gwnE36lYMNOC3rfX9x9aOTay0qq+ZapXqkEPJ6lCCll6Qa?=
 =?windows-1250?Q?GHpqbRaWLgzdIh7EiM/3EYLX8SdzG5DcpQlslPNeRWKHpM4uGaMBLUNe?=
 =?windows-1250?Q?QmDkkZWlNdA3EAV2U7KKQNn8tpPDCwJOc6YRGo8HO8Kf3sCyiszJOuCO?=
 =?windows-1250?Q?znULHAsweUa+MvNpdVHPRco+HvfVeJwHj+KV8IoYiisNKwxHVAGTGOGT?=
 =?windows-1250?Q?+7ZjARDp6zhVwLanqXJRZwigi0gRBhlnOaMsg3akQsCUe3R/hPtEHTZz?=
 =?windows-1250?Q?On49t/SVQhooN9C+Y9qCzWssTjVMFvD4Ep/tAcSc4BCeSK0PH/MLyKPb?=
 =?windows-1250?Q?+EOT9MFU59Bc7b13HsJyCGngmzeFbTgN/XQxV4nWxw1/qCk1g2bur5VC?=
 =?windows-1250?Q?sQnuZXArSKKW8VawVSF+l5qOZCfwp4LS7zKW2MXD38w73OF4lj0LsCLU?=
 =?windows-1250?Q?O4oKTIFkSXVAF/5iKzZHTvxI+WRSJF+iGzBULIrcNDvIKEXt3pQkV0NW?=
 =?windows-1250?Q?yHRYueGKD3lFQ3HhA++q/NLMzhlgBY1lUY3JfeeOiUIfyY+R1MNXapbz?=
 =?windows-1250?Q?RH9ORRknYBemH8Xa/a5QagY2EBwzizpMSfVaij2OV7N5U20BvcXCeFa0?=
 =?windows-1250?Q?JXDNHVJEIYy6pZ9BW08QABPAyKxv05YXW6IoQrQGs64VXUVtwYH5TThd?=
 =?windows-1250?Q?+dP55XYcBWdADQSuDMr+RQpjZ9KF6Xont+lEr89QqDb7zw+ATCyGedtF?=
 =?windows-1250?Q?9rCu3Y/YrE/CF5bI6+0d2UvDk4ZURKVmHgGN+8gUhd0Y4vLAdobt/9tK?=
 =?windows-1250?Q?GBZiARHfkJivNfRK97OaM7au0SyhOAidRA7oBsuu/aKpkgHMn1qwMnji?=
 =?windows-1250?Q?ovfqylijCztyqsDu59EyMfWocFRVqZYaUcmL6aKtQax/pwDVbK2YfsV4?=
 =?windows-1250?Q?5ByGuok/5dKstJ+N33tgXQT6rjs=3D?=
Content-Type: text/plain; charset="windows-1250"
Content-ID: <6E4E24B1B150F8438A116443BDD86D6A@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f8d993-b7f9-423f-e878-08db951c61c9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 18:55:33.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P191MB1929
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am using openSUSE Tumbleweed on a Dell Precision 3551 which has a bluetoo=
th adapter of ID 8087:0026 (Intel AX201).=0A=
I am using a Logitech M575 trackball mouse which only supports Bluetooth LE=
.=0A=
=0A=
With kernel 6.4.2 or newer, scanning for devices =97 using either the KDE g=
ui or bluetoothctl =97 most of the time returns only =93classic bluetooth=
=94 devices like computers and phones, and not the mouse.=0A=
If the mouse was paired before, it works correctly however.=0A=
=0A=
With previous kernel versions (6.3.9 and before), pairing the mouse worked =
correctly.=0A=
