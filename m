Return-Path: <SRS0=evc1=YX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B54CA9EAF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 08:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE14020717
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Oct 2019 08:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="gff++p7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfJ3INc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:13:32 -0400
Received: from mail-eopbgr90101.outbound.protection.outlook.com ([40.107.9.101]:29280
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbfJ3INb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Oct 2019 04:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBzjoNayqdPK6nIIiJ1Nlev6sahj6w13uKQ+1Su3snNcM+4Td95QC53u7BlT+s5dfB4diY8aefrmpvvZlEBBNUzawqiTeLZbLN7fYAInqnew72hytfPppicK68gWb1yIrcgyKvneuvYBgn80e69xMX4pSx/zPjc0+2uDRqKYx+3QCgv/hmmWQGQggh5cocY1iE0pV4LWUfv1G3hcjhGJJf6/1WQQcduaU8vJIAm0eJ3/IhD3+R0nqkuWP9mn+QqmYzwUlhlt7t1Y0nsN0QxNt9LxPHijV5uimLpnbai6lFY7vpndaN3MJmaZ0QQ2BD5K8R+wrrv2nyftZRerYKBPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rU9NnmNDzyJ0pJFx6Ke44jml2B17LDZeQMTwjafRCc=;
 b=XxIJ39r8B7v29SZe/gNpKBvAseuGGsNuGeVsj45UuIuB1FBE7U392hsv7wQnyb1Isv4FVzAbTMuWLdcMXUCJlKFCTGua03BpkKiwtgCrCz8/xWvOZdHzhqxmcf1PthUAwin2ddXL575v1fQ2stdx85aNGrKDnpAlD+8CLurCEQPBZPy9C2cz4ypxhe0JK6v3SPaX51sVUsK3Cc6swf52Gmjm/QMczgUU8PcRm42XOeg2wdIiApxP4wvZL6NuZ0JumafPucWIENFhU3Z6LiGW3M2JBRhNWC6dY+boadF9ooISj/4Hr89sjXwuSRpVwW4WN2WOcMSEkp0LGDA2ef4kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rU9NnmNDzyJ0pJFx6Ke44jml2B17LDZeQMTwjafRCc=;
 b=gff++p7kklb4hA2au3fmP4HqIsTdEi86pKLTPsI/JbiyjvW6vbdWva21AQrrB2AIwuQHjicM1nv9cLLg+XFE0IXzs8cFhZyaQ/HtF36JKPnwL7slo5JRw8OH+8W9eFGvSzxHnXYaLO3a9uD+YG5fkzYybG1THeFqi+mqPpS1LUI=
Received: from PR1PR07MB4858.eurprd07.prod.outlook.com (20.177.210.146) by
 PR1PR07MB5066.eurprd07.prod.outlook.com (20.177.211.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Wed, 30 Oct 2019 08:13:28 +0000
Received: from PR1PR07MB4858.eurprd07.prod.outlook.com
 ([fe80::4811:3c4f:58e1:dfbd]) by PR1PR07MB4858.eurprd07.prod.outlook.com
 ([fe80::4811:3c4f:58e1:dfbd%6]) with mapi id 15.20.2408.014; Wed, 30 Oct 2019
 08:13:28 +0000
From:   "Sanchez Frias, Cesar (Nokia - ES/Madrid)" 
        <cesar.sanchez_frias@nokia.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluez 5.50 Qualification tests
Thread-Topic: Bluez 5.50 Qualification tests
Thread-Index: AdWO+ePxNPJsnmlkQy6SBiTMI3kSTA==
Date:   Wed, 30 Oct 2019 08:13:28 +0000
Message-ID: <PR1PR07MB4858E3C5706803AD2DF72194C7600@PR1PR07MB4858.eurprd07.prod.outlook.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cesar.sanchez_frias@nokia.com; 
x-originating-ip: [88.4.88.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54464f79-eaa4-43e5-5827-08d75d110bb1
x-ms-traffictypediagnostic: PR1PR07MB5066:
x-microsoft-antispam-prvs: <PR1PR07MB50663F60047F65D65A1CCA60C7600@PR1PR07MB5066.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(53754006)(71190400001)(81166006)(316002)(478600001)(8676002)(5660300002)(81156014)(25786009)(52536014)(8936002)(256004)(33656002)(6436002)(4744005)(305945005)(71200400001)(76116006)(64756008)(7736002)(6916009)(74316002)(14454004)(7116003)(5640700003)(2351001)(6116002)(86362001)(476003)(66446008)(2906002)(66476007)(102836004)(2501003)(55016002)(3846002)(99286004)(66066001)(186003)(66946007)(486006)(9686003)(26005)(6506007)(66556008)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:PR1PR07MB5066;H:PR1PR07MB4858.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKWI56e1FAWwnYDPPaYjbR2f5hFXaNx9tjfjuTNKZQTb+hNB01bmPU9lM6THApdxOmsmAnKIs9td0qakf/+ViQbunveWRg3goy2cvbIOsaUoC+bPwDXsOnx2vxcXpsAK3Vyk2LM0H1VZktdc+vrDX1UzgNcIEH5J19I3xxjl7Qz5fBnjk5a1eOwTuIUVhFk/tjBUrwbUat+09gOvFfPi9RkXoq96qC6N0ELSQcNxLyuGMx/3QfWXZjddP9BQ64dy8kh8/6Z/8vM+JcCcQAJ5lJR1aWwBpwJOtzvJEsapcT4e8wlEZMdrJZlxFixw6HuU3OjpJ/ShucDpvoqluKn7uRt3pt1LQ6xh0nPE9bNaK8M409/xyCPU8AyAmjAcK8R/08QbE688KABC018S7iGqIYpG+IJqxs80THiuVLw6K4SSxXiD+gxeEVahJBUSLS3U
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54464f79-eaa4-43e5-5827-08d75d110bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 08:13:28.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRaOyyHv3k3dwcYLxT+l8EBS8WX8yO86TM5adn8vDZCEvkZhDdSbo9fo5WcyxSfnRCUOYZNx6S+ZSCNit6r0WmMMSh/IJgpd/AL3+oD4qNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR07MB5066
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everybody,

We are currently passing BlueZ 5.50 (LE Host Subsystem) qualification proce=
ss.

I would like to know if anyone has already passed test cases "L2CAP/LE/CFC/=
BV-13-C" and "L2CAP/LE/CFC/BV-15-C".

Test case "L2CAP/LE/CFC/BV-13-C" seems to require authorization at GATT ser=
vice level instead of GATT characteristic level. Does it have sense? As far=
 as I have seen there is no way in BlueZ tools (bluetoothctl, gatttool) to =
add authorization requirement to services, is it?

KR,
C=E9sar
