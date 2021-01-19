Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4CFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 06:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D2E20644
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 06:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbhASGfe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:35:34 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:18530
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729382AbhASGfK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 01:35:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdWbTFRZKEt0xXFsQNfvwHbD4Wopwrd591SgUHR4Z4EwjxdvHhYMfH1bfVIlM3wdQd+Vlz2yC0ONK0g2Nt3KC7GR8jp/wZG/uIsX5sEJtfs1C2umMVAVo8j5d7EiAos4s3ePIIs5brv0QFNFCwLhA/Jk7LtHO9B6y7e+vRUKCerNH2WuXnxD83leF0FcDUNh8+EvQUC/R3wSlj1s7UJCWNHARZxYAc63Vjs9GANKCBXTnLx2NcFZ+i9eRCwOX5cN/508FYpXautB6ZDSVkGL8tTObmPbCy4rJn8CaF0/VF7UyapQ9QwGeV0ska72vuvZ75r/n0osX/Z6v/mgoBUhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BfLMrSvEcstMmITC1b4XpysFgBQuOTBMUt1nJVpPYo=;
 b=J9NBp9S/dPuuM21OrELK6BVgn5c5wY+kdHbuVSoBDgG5tdxzC+hoCVDq0ZPUfUgQsDwye9RYJ/vZrisVeN2e62YXQLS43Ue/2LK7kdi+QF76eMrAy2sX94PHjn6UsewfHxg+C/0vr1C6wEkh2966TLxj1v8xWDueXpzwbBuEHesiKBfl5/bGQm697O9fWnHM0EO82yuRNlhkYuKCWVpSglnBdg4fVvNTM4wIF9M1nh01laKeIINH2uA6IyoQ4U96s0JP5AmJK52JCcN0FaXEhDhwX+yYCRP+RXVK1DisQEm2jDch+Dxl+aQtd05HzgDlD/yhFQeyVeEM1h0zj+NZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BfLMrSvEcstMmITC1b4XpysFgBQuOTBMUt1nJVpPYo=;
 b=orGbHhDHwJElKwQvSFBzJ5FzijZOk4x4KfwBFqPYWmoz0HIOlxPvtr+JRnsJ8ZtNcR5v4dKoq43ipiVl6zVloSNxJJkXZKZtjFpub8NQ72bTtkOGJyeVWBI9987CHzhq2aCqA/KJ3fNsOKP9rJNpuOBUl4UzTB3DbZ67IGXnZ5c=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5917.eurprd04.prod.outlook.com (2603:10a6:803:ec::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 06:34:19 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::28e2:4285:5d7f:7a82]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::28e2:4285:5d7f:7a82%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:34:19 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: BT large file transfer failed when do suspend/resume test
Thread-Topic: BT large file transfer failed when do suspend/resume test
Thread-Index: AdbkLWygZS16CF8vSlqlxcAFRAOtGQAMP8gAAA9HdQAA9mSRgAAT6+qQAVbVnIAAAeYKEA==
Date:   Tue, 19 Jan 2021 06:34:19 +0000
Message-ID: <VI1PR04MB4960710ABF79A6569E66107792A30@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <VI1PR04MB496003E449FB10B12959ADC292D00@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <CANFp7mXtX4H=tQ5usRiOXRBzfuQORc6-MCznbjmsMBRAQMo36w@mail.gmail.com>
 <VI1PR04MB4960E51607240EC6B681526492AF0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <CANFp7mUWv1=SW_CL8YZgBP-emXC9aRXTeteE1+Ds7qrP3jWcBw@mail.gmail.com>
 <VI1PR04MB4960FFA7AB29E413CF7C8A3292AA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <CANFp7mXeFOSGWLqPRoCGcH95u=m_W=HVn8Ey34u9SOqi31Xj7Q@mail.gmail.com>
In-Reply-To: <CANFp7mXeFOSGWLqPRoCGcH95u=m_W=HVn8Ey34u9SOqi31Xj7Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: marcel@holtmann.org,johan.hedberg@gmail.com,luiz.dentz@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a112224f-2c06-452f-3878-08d8bc44403d
x-ms-traffictypediagnostic: VI1PR04MB5917:
x-microsoft-antispam-prvs: <VI1PR04MB591779AC80F9947B17BDABCA92A30@VI1PR04MB5917.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzYpp/zEXNRTASnqdZ3Y0C5VH/RpTjdGwq0Sha4n0e8VZoHKV09obLrXLvqGft7HExiF8kEc3CMIXCagbp1BDaopPL5F7oQFcLZ+fPjHAOWpDtD4jTBbYJrmZsqrsOxvuCLkfTZ7lgnxunJh9DE6CXgThUJgQQyNI0QoFiBXq8XqfopuLSaWGZ5VVX1L4ai3FwIYc8FcraSfu0r7vh2MIifcaSIHlMF8arAj5YrI3ISi4wviyhSTuuon+3GmpicpFKQWtJQRNaVLdKLdGoThZaxaVBFwx5CHltbkxC4GvjYaKMp8jTvkP2PJ42HhBUjWsbdeJ5BWu0gQlKPWLvCyQn+pONlIyN+EsBU5mdYS/FrGEsLcm9jQfwUcpwVwtKmqIhBugHmDFLrGvtPtbjqEEPHMNOyox4kZfp8ZpGD8Z5Ia40u//5d2RnPayPqDyrjAAMLfoqeKoTMALB78/BCxcuABlB3VTT1dYrlL+PGpV+Mm7419h74ISVwgNoM3Nqa68iw6wCCbzHUd4d4tZDz7M8fTXU4A7ek29ZeCmsCl3SAyUxpn4xsHNfuz+nNR14R8tX6RkonwUjU9JxfRy7ut67N7+7afvo01I+hgm2Xrhu0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(8936002)(55016002)(86362001)(64756008)(52536014)(15650500001)(66476007)(498600001)(5660300002)(76116006)(6506007)(71200400001)(4326008)(66946007)(2906002)(110136005)(9686003)(33656002)(966005)(30864003)(26005)(66446008)(7696005)(8676002)(84040400001)(45080400002)(186003)(44832011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4fkqU7s2c9dYgE6eWrb7rYlmGtjW7c1N6MUh3OW2ybb01S4hqJW3kpwyveBP?=
 =?us-ascii?Q?ecFpLPHOMw7aE61LwbF++YOCW1VGsA/C7XDr5pcX2F8KA8qV8f+htX8XRc0Z?=
 =?us-ascii?Q?KYzTMKNnvrRRqrJ/yjgW/CKV4+ezfGNH2bVazgajJKAFLKCsPb6tRcXrMAQT?=
 =?us-ascii?Q?Lz3Xd5XICQG+S3VadjH/H5pzTaLC9dzsbws5IeFuwGXREKDZOPeonsdrv02U?=
 =?us-ascii?Q?RVrjM+CjoHZHFLfgUdhuJhNitRFG/Z60j/4Fr5+FH62vrO5LRnisCKeE+1HN?=
 =?us-ascii?Q?HvjMv0s7fX+AqNrCKRQ1vAOF1C+Fq124hR90nXHyQ5oo4hNxDl5njzhP3eOh?=
 =?us-ascii?Q?paps20RXbc4hQchT6lurJgeeNy6xDz/deGts4RIFChKzup2WQL+uEMOV9zJT?=
 =?us-ascii?Q?bb1o4fIUxCdJg9dvxJ95hUEnZ2d1qfTme+/ELdXn+UE/lUmIhud/Nyak9upo?=
 =?us-ascii?Q?Q5rCxbZ72DQNJ6wojbmV98UbyOCvC8v1ZYH3KNdKuqxCqXdQmWxuhsmFBwU8?=
 =?us-ascii?Q?KB95zYr0qzxU+ea8WuhMFkJ2ELVysIR0x+WerE+QCKrbVHoaXGLjmS3xpor+?=
 =?us-ascii?Q?0D50eezVUwMkJFrRrxkmhAC5OzB5bphyvg5wnOPx9+zccqTsOFLRuC8j8qkA?=
 =?us-ascii?Q?Cw5ajibMHBNVEtDZeBgPihGnwc9iPmOaB3ROJs8RTIpUdQRH25ah17epC4VL?=
 =?us-ascii?Q?1ptsVBj6HvSNT39KG4agJATmlxQXkPsGTWjJTDXLFlX+ibDV72Xg9LaYf2lS?=
 =?us-ascii?Q?UYzTfdtM8yWpbNIoeB+BQeSk7g7izYlj8fFaH85mOEGMnLDCfDXQieDbVJjU?=
 =?us-ascii?Q?5deUnk0gFqKlAcbJB8Sgg+xWwMvYMEEQY/+L1x+5Ret7i9IHDNuHl4vLk5fw?=
 =?us-ascii?Q?HHJ5T06n5Ifzc5BTeNyWVP44HF1EgQXeLocfbDLzu7PgoBHom20Ya5jzDIei?=
 =?us-ascii?Q?9uWxacPJHN5naE0iM0ecXHKoOoidE0xw3o98DQAddl8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a112224f-2c06-452f-3878-08d8bc44403d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 06:34:19.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ajgojl4kG6QVprg7mrfws3vveV5RSEEaOO0rszG8fKqfMJl/KO2fKQ1kGdXpE7xyv4p0uDbqnwSN7mhwgsVp4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5917
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

> > > > > >
> > > > > > Platform: L5.10 + Bluez5.55 + Marvell BT chip
> > > > > >
> > > > > > Background: Our test team usually try suspend/resume test when
> > > > > > transferring large file through BT, to see if the file
> > > > > > transfer can be continued
> > > > > after suspend/resume. It can works well before L5.10 But we
> > > > > found on L5.10, the BT connection lost if we try to
> > > > > suspend/resume, so the file transfer(through OBEX Object Push)
> > > > > shows failed. Then we found your patches when debugging.
> > > > > >
> > > > > > Questions:
> > > > > > 1. Before L5.10, kernel always keep BT connected during
> > > suspend/resume.
> > > > > So why we need to disconnect all the BT devices when system
> > > > > suspend
> > > now?
> > > > >
> > > > > Bluetooth has often been a source of spurious wakes in the past.
> > > > > Using rfkill or masking the wake interrupt were used in the past
> > > > > to make this more reliable but this was resulting in instability
> > > > > on the controller (controller needs to drop traffic if host is
> > > > > asleep and there's no
> > > clean way to do that).
> > > > >
> > > > > The new suspend behavior is the following:
> > > > > - All devices get disconnected during suspend.
> > > > > - Only HID devices can wake the device from suspend (i.e. Remote
> Wake).
> > > > > The BT controller will be configured to scan (page scan and/or
> > > > > LE passive
> > > > > scan) based on currently paired devices. If the device is not
> > > > > configured for wakeup (i.e. power/wakeup in sysfs is
> > > > > "disabled"), we will not configure this scanning either (see the
> > > > > hdev->prevent_wake implementation in btusb for an
> > > > > example)
> > > >
> > > > So for HID devices, they also been disconnected when suspend and
> > > > auto
> > > reconnected when resume, right?
> > >
> > > HID will not be auto-reconnected because the peripheral is
> > > responsible for reconnecting. Most HID devices do not page scan
> > > unless they are pairing (or at least that's what I've found in practi=
ce).
> >
> > What's the peripheral mean here?
> >
>=20
> The connected Bluetooth device (i.e. mouse, keyboard, etc).
>=20
> > >
> > > >
> > > > > - On resume, devices that support a2dp-sink will be
> > > > > automatically reconnected
> > > > >
> > > >
> > > > I just tried a2dp-sink devices(BT headphones), and it wasn't
> > > > reconnected
> > > after system resume.
> > > > I checked your patches which to supported a2dp-sink auto
> > > > reconnect, and
> > > found them may didn't been included in bluez5.55,  can you help
> > > confirm that?
> > >
> > > It looks like bluez5.55 was released on Sep 06
> > > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
g
> > > it.ke
> > >
> rnel.org%2Fpub%2Fscm%2Fbluetooth%2Fbluez.git%2Ftag%2F%3Fh%3D5.55&
> > >
> amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7C1f3ec177fe974c90e1a508
> > >
> d8b68c4584%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637460
> > >
> 060872077285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > >
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DEDn
> > >
> MnLjPIN29nQpmH1%2Fk%2BBnhMq5IZ3xG7BXIEq0xs6A%3D&amp;reserved
> > > =3D0) and my change was merged Sep 14
> > > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
g
> > > it.ke
> > >
> rnel.org%2Fpub%2Fscm%2Fbluetooth%2Fbluez.git%2Fcommit%2F%3Fid%3D
> > >
> 6611b72600c370ec31795ab48a222594c4afb7ee&amp;data=3D04%7C01%7Cshe
> > >
> rry.sun%40nxp.com%7C1f3ec177fe974c90e1a508d8b68c4584%7C686ea1d3b
> > >
> c2b4c6fa92cd99c5c301635%7C0%7C0%7C637460060872077285%7CUnknown
> > > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> haW
> > >
> wiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D2jYeDwzoy87GA2V2SqilgdA502jeI
> > > ZdGd4aeyXH125M%3D&amp;reserved=3D0).
> > >
> >
> > Okay, got it, so you patches don't been included in bluez5.55.
> >
> > > >
> > > > > This results in more reliable behavior from Bluetooth around
> > > > > suspend while allowing Remote Wake to work properly.
> > > > >
> > > >
> > > > Yes, it' reasonable, but I think it may need to reconnect all the
> > > > devices
> > > which are disconnected due to suspend, right?
> > > > Otherwise for the user, when we connect the BT, which means we do
> > > > want to use the BT device, but every time when system get into
> > > > suspend, we will
> > > need to reconnect the device manually, it's really inconvenient.
> > >
> > > Depending on the profile implemented, not all peer devices will page
> > > scan once disconnected. HID devices at least will not page scan and
> > > are expected to initiate the reconnect themselves (i.e. suspend,
> > > resume and then click your mouse; the mouse will reconnect).
> > >
> > > If reconnecting to arbitrary profiles is desirable, you can merge
> > > this patch
> > > (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
p
> > > atch
> > >
> work.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20201207154903.blue
> > >
> z.1.I3e043a481273442748bcff0728b2f0e208017cd2%40changeid%2F&amp;d
> > >
> ata=3D04%7C01%7Csherry.sun%40nxp.com%7C1f3ec177fe974c90e1a508d8b68
> > >
> c4584%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637460060872
> > >
> 077285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> > >
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DaNXOfCTXs%
> > > 2BISAbYBH2die47qfpqXRmqehSnW1mC8M7U%3D&amp;reserved=3D0).
> > >
> >
> > But for the most Bluetooth profile, like A2DP-sink/A2DP-
> source/OPP/HFP/HSP, I think it is necessary to re-connect it, right?
> > So I think it's better to add the auto reconnect support for all those =
profiles
> instead of the A2DP a2dp-sink only here.
> > Please correct me if I'm wrong.
> >
>=20
> I think it should be user configurable and I'm not sure what defaults mak=
e
> sense for general Linux distributions. For ChromeOS, we only want a2dp-si=
nk.

I saw your patch series below didn't been accepted till now, right?
And I believe the ChromeOS is just a use case, for the general Linux, I don=
't think it's a good choice to add these profiles one by one when users nee=
d.
Since I'm not experienced in Bluetooth, maybe we need some more experienced=
 man to provide some reasonable suggestions.

Hi Marcel & Johan & Luiz, can you help to comment it, and the wakelock ques=
tion below?
@marcel@holtmann.org,@johan.hedberg@gmail.com,@luiz.dentz@gmail.com

>=20
> I've linked the patch series making it more configurable in previous emai=
ls
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc=
h
> work.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20201207154903.blue
> z.1.I3e043a481273442748bcff0728b2f0e208017cd2%40changeid%2F&amp;d
> ata=3D04%7C01%7Csherry.sun%40nxp.com%7Cb06b00a1abc5495a3d2508d8bc
> 374c07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63746629297
> 2854206%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Db5gZJ7bbD
> e51F0YfGdFQSjUAjLNwhh95jYJuGhsvhjo%3D&amp;reserved=3D0).
> If you agree that behavior is necessary, please make your case to the blu=
ez
> maintainer (Luiz).
>=20
> > > >
> > > > > > 2. I found that the device been disconnected due to suspend
> > > > > > won't been
> > > > > auto-connected after resume, shouldn't we get the BT device
> > > > > auto-connected after resume like wifi devices done?
> > > > >
> > > > > We do this currently only for Bluetooth headphones (reconnect on
> > > > > a2dp-sink service). I'm not familiar with Obex so I don't know
> > > > > if this would work for that as well. I did send up a patch
> > > > > making reconnect on resume configurable based on service uuid
> > > > > that may be relevant to
> > > > > this:
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 2Fpa
> > > > > tch
> > > > >
> > >
> work.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F20201207154903.blue
> > > > >
> > >
> z.1.I3e043a481273442748bcff0728b2f0e208017cd2%40changeid%2F&amp;d
> > > > >
> > >
> ata=3D04%7C01%7Csherry.sun%40nxp.com%7C9d41a6725ac1432355c408d8b2
> > > > >
> > >
> 759700%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6374555654
> > > > >
> > >
> 22685536%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > > >
> > >
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6zZda8Yu
> > > > > RRbAMkwOxiSwjbJIpvi%2ByMSDWCzVkFkkpzs%3D&amp;reserved=3D0
> > > > >
> > > >
> > > > Why here only add a2dp-sink device auto reconnect support?
> > > > Why not add all the devices auto reconnect support which are
> > > disconnected due to suspend?
> > > >
> > > > > > 3. For the large file transfer, if the BT been disconnected
> > > > > > during suspend,
> > > > > the transfer will fail, do we have any methods to avoid this issu=
e?
> > > > >
> > > > > If you have an active transfer, does it make sense to be suspendi=
ng?
> > > > > Perhaps you should hold a wakelock while a transfer is ongoing.
> > > > > I am not sure how Obex and other services should behave here so
> > > > > I will defer to Luiz and Marcel's opinion on this topic.
> > > >
> > > > I'm not sure whether it's reasonable, our drivers seems can be
> > > > suspended
> > > during transfer file and A2DP playing.
> > > > Maybe we really need a wakelock here.
> > > >
> >
> > I checked the wakelock related code in kernel suspend steps, but it see=
ms
> that the wakelock cannot prevent the Bluetooth disconnect behavior.
> > Because when we run echo mem > /sys/power/state command to put the
> > system get into suspend mode, it will call pm_notifier_call_chain_robus=
t()
> in suspend_prepare(), the Bluetooth will be disconnected here as you add
> the pm_notifier callback.
> > In the next few steps, pm_wakeup_pending will be called to determine
> whether the suspend operation should be continued, if we registered the
> wakelock, we will not enter the suspend state.
> > But the Bluetooth has been disconnected already. Therefore, even if a
> wakelock is added, we will also meet this BT large file transfer fail iss=
ue. Am I
> right?
> >
>=20
> From what you've described, that seems to be the case. I would expect
> wakelocks to prevent suspend notifiers as well so this seems like a bug i=
n the
> suspend code. You should submit a patch to check that there isn't a pendi=
ng
> wakeup in enter_state since that's the case:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2Fkernel%2Fpower%2Fsuspe
> nd.c%23L562&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cb06b00a1
> abc5495a3d2508d8bc374c07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637466292972854206%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&
> amp;sdata=3DAhNB3i17HgSy9JoAqnD47oA5up19LY9fF8Zone90aqo%3D&amp;r
> eserved=3D0
>=20

I don't think it is a bug in the suspend code, it may need to call suspend =
notifier before wakelock checking due to some limitation.
I just wonder why we must do Bluetooth disconnect in suspend notifier, can =
we put the BT disconnect behavior later than wakelock checking?
Hi Marcel & Johan & Luiz, can you give some advices about this?

Best regards
Sherry
