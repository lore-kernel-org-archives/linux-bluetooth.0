Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1703BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C5260EE2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 10:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhHLK4E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 06:56:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:6920 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236478AbhHLK4D (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 06:56:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202515122"
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="202515122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 03:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="590591758"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 12 Aug 2021 03:55:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 12 Aug 2021 03:55:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 12 Aug 2021 03:55:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 12 Aug 2021 03:55:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF63YktAMLhZHwJHDvupI+t22RouZZSLrlZUBW2YoIA1Yw4llR1+ZMtknCXlPC03FrvqomjIeQ7RIuCTPuZ46yWgskv1WyKYaXo3WFw5cQtJN01kzLaGwCsEcVMIswQEJwx4scvPdz7OJaupIcOMyH/9TUIg9QmjbLHTW6Gx5KeFneAnUr/a6grbmdq0d8nwLLZCx9fjD6OUx80BfWB+9p7E35XZqw8Mv5b/nYmT27DUchQQe1lvOIqhvcHI1Hlf3/L6GvBEp0i9MdEN5OWSEQ+R8ptXpSvAXjdk25L1ONzJUB9lHR4+G+9oDTkC64JtsfQU/BAHrwOsdq5Y+ksyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK2x6CuaG5m6P0aJDZSHyYzU03N2lY32UJ91GM/CkZ8=;
 b=DDhVstWREquX7FT/pDKFYAuPYMJ3X8HcPn0IFtZIBgWFvaCNOPhda/gOYbB+AlZUfqJdXghwU+G6BpuymYLgW9p+ve/ns6nurAgun0IghLMVWR4kffZ7W0nWkIUunrle56Ralu031MXfuokC4YNnR4OWrFHKQvNsApo7CCC9P16bQDlSlPxlvy1vQ9sySkeOnJ9NEHagEkIIwJ7KoEO0qKZJByFhxXpOtL+cCLurkK+/nmcT971Fq99v977P391nxEdtFD2uNh2wdJ8gS1dJVlZZZ1rYWXkBROEx7GH9d4EOmH4CZJmCdqvfflFps2/5WmFl3aydnUj1xwUwq/sRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK2x6CuaG5m6P0aJDZSHyYzU03N2lY32UJ91GM/CkZ8=;
 b=bG8dKHb/kAd8VYKah6a87wCRAwf2D4QgCa0wpvEez/xLtrVUEw6yFDoQ1hgm1SI6JhR/Ex8YVRofjN9Rzp5bWNZWaP9niYpyeQ8o8i7ZgHjZu7lCgOGLSpzEYGwYvsNjCrcI7DUusNEBmb8tvAM8Qdc81HejAdqMKmPWuktBFFA=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM4PR11MB5566.namprd11.prod.outlook.com (2603:10b6:5:39c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Thu, 12 Aug 2021 10:55:35 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 10:55:35 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
Thread-Topic: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
Thread-Index: AQHXiVcmy61Y/5HvckOI5dFZpf8b3qtk5AYAgAGqIMCACS/vsA==
Date:   Thu, 12 Aug 2021 10:55:35 +0000
Message-ID: <DM8PR11MB55733AD00D7FB779732063B4F5F99@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210804173939.25496-1-kiran.k@intel.com>
 <CB7F6AB9-E997-4C77-B19D-D018F8044001@holtmann.org>
 <DM8PR11MB55738B15758672E2982D748AF5F39@DM8PR11MB5573.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB55738B15758672E2982D748AF5F39@DM8PR11MB5573.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9141035b-08a3-489b-0e6c-08d95d7fb6c3
x-ms-traffictypediagnostic: DM4PR11MB5566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB556621A93EFA8C04F7360533F5F99@DM4PR11MB5566.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8tMUirhSoKdgYhCPC00cBTCCRVD9Vz0ywexgyAgn+YiPMWhZzayM9nUVa1ZtbUHS0CAroeI1x8Bc8RD0tlYng5+N99ZBw9sh521zO8SL2kg4K4EpwoaC2fy2rR8gIRyjv93K/vlaF4HRTfajUil5bvay/CaFr2APXrgivKWc0GSwdZKEMT/WsPhkU/f1IcySx13/X43eB/7Yc1I5nEj9c992rhsMhASAIijQI7KE0oVrfEC2qvOWcuOjYQlucSrYcP9IP4tt3APQYk8yREYXiXLVMXvA3ng8Dhd3XM4CjgVRcaIyqdon1q1YCowcFOX1Mw7/Ffnb821KRKrU7M6ApGnXw7Xiw71j62vS3dlIrOJeW2xg0UDMTLYVMna8uKwLh9uoyU8UL+gPLub3I3EsHcXTGTNNI5DZMGiWlydTQ4rjulI8H6WeiMK1j97PuNikUK+kPcD1HXEyUNsSSj63C0k4BKZIoyjb21hZoze8j2ZCMZqhItLhEReSs+tKSSVb1ZHa7zFrNKJpuITz1CaSMgCJt5t16ZjZWKW5QgWL1ClxbGIAfmQVY/4FqRyMU7HdwYve3/qHvtZZ2AEjD7Udr7hbrRIFATENd6Xj5qH4nlCWr55N7qJ4Sr5uxs1/7pLyTIwwURfKIR2OH1qE1bLrYYaCe/fFs6J6dbeVBg9UJqysXdxNJg8XPXxvR8x7ZYCthJWFa0QgZmW/viYhedLvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(6506007)(83380400001)(9686003)(33656002)(8936002)(86362001)(55016002)(53546011)(66476007)(64756008)(122000001)(66556008)(66446008)(66946007)(316002)(8676002)(6916009)(2906002)(38070700005)(107886003)(38100700002)(54906003)(71200400001)(26005)(52536014)(5660300002)(4326008)(76116006)(478600001)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fKRN3Um3JjUidmkjxlhURZz4BVXZdQ8V5VecAm8hkXRyYn9vEdtxwAvFek0P?=
 =?us-ascii?Q?68J8RYiZTlmn4w8bntgMzyzD+5NoclSUXbBcZh07AiJz1qR7FArLomDB5W7j?=
 =?us-ascii?Q?zgJaRj6L8TDZjImfEMcFIZ0UA339Lnuq0XF/G1Avz7ySBOaO/5Go+DEYR5pd?=
 =?us-ascii?Q?MaxiYGfP4uOH0HRzIFYHnp3/9TV7VtkYDbmlHyChNPHM1rdz9hflAwVacR9t?=
 =?us-ascii?Q?jwBvCXV7beN6YvBjEA/MmG51C3XoKJyzQ5AURDGhqdRLfT5rJz5TCvi5Pwe4?=
 =?us-ascii?Q?7ZWvNDg/kRZCWatPkbXun/oQ2M4jnCKBcqPqoQ8jR+7kumNLhY6YdmykWdRy?=
 =?us-ascii?Q?eBrm5auep96fSZOSNZmwL0eroC7zDjXbrGcdwS2EMzIsOTeKxzGF75VBWtvb?=
 =?us-ascii?Q?ApcxrzMUA/HMKi0/L3I5j1lpOSSnnCV3vLAGRSmiXwcR44VsQpTFTBKf+pS4?=
 =?us-ascii?Q?54LGojsHmvRc4T7MkgQbvnAtEnGhaFRbmyyXw5pQrPVGW7+YKRIQA4RXFzE2?=
 =?us-ascii?Q?EamTT1cw74LGL1U7jcjdEHE5+aqMRDhf/BTff6IVyQ411S2oeUbsNKTYvQlr?=
 =?us-ascii?Q?42Nt99i6SmkRKOIH9niRTNH0SXnkNs5nGscOgCMSVOesPOccADA+htv04IZN?=
 =?us-ascii?Q?Uk1Op0DblsqjnU9JY5j+YEHXhxhnzFPhxQ4+1eHT37Ctx2nqgeuWX4pIyywG?=
 =?us-ascii?Q?K9AZsXFTxwLYFX42UjgHaDvcYk+aYunqxmreiXG3F2MUJjS24/aNYPPf1Ruf?=
 =?us-ascii?Q?oLK4tkOEBZcQlcpsqItHLKa1sjWcthx59qm2KSKgZ/2TTp1Oj4/2aPJU1QCG?=
 =?us-ascii?Q?eB0U3oMO9L8yJCV6SqBVFdfn43SB5Vv+ExgqSjlHTgR+ojQH0Pagb/mIgYxz?=
 =?us-ascii?Q?nCKCNC6SbmbD63Q55Dk/zqk0xJH3PTTcCp8f7Al1fiSB1QOSquij9DsZV8rd?=
 =?us-ascii?Q?Mw8H43PEyZ6nSOSwwZ7vNDtRmQtsEej5NVV2t6+Uc6iuN2e4iziqI5gBRhBr?=
 =?us-ascii?Q?7v19qRxrV4W4BMFTVo4/Pc+6B3hi8wHKXatCy9nx4uSG/4gTIBsxq+p0MGPI?=
 =?us-ascii?Q?uQ3RUcy2QtQ6XOy1wMKSFRGUl/Fw+/LzPvzZ/qjRcPDtdJGOoG7uubS3Azpl?=
 =?us-ascii?Q?p5qWfQATp8ETULlhgZwmthxtScISNPoS1b1X+CIsXFJxnamSS4qG36KvBcP5?=
 =?us-ascii?Q?V5Lf6O4LwdTL1F3H0KIByLSjQPZ10Z2tFYmDJWjM+45ylshua4OMa5/QIrsn?=
 =?us-ascii?Q?Tpc60iM3ZJGaiNwc5e3XvESuVvDMZ4v+ATFF57fcBV3D3jBQVcwYhkeSiF4E?=
 =?us-ascii?Q?BeQTxcChjH0OAXP1axhsRf3j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9141035b-08a3-489b-0e6c-08d95d7fb6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 10:55:35.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lfI9YfuRdkSF4BDbs+Lq64dvf6lupHJBdzu1joSwARSC5GrPt8DNNaRI9a+okv01sZ8bQ3ljgR6sIj7Mdldnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5566
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: K, Kiran
> Sent: Friday, August 6, 2021 8:14 PM
> To: 'Marcel Holtmann' <marcel@holtmann.org>
> Cc: BlueZ <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>
> Subject: RE: [PATCH v1] Bluetooth: Fix race condition in handling NOP
> command
>=20
> Hi Marcel,
>=20
> > -----Original Message-----
> > From: Marcel Holtmann <marcel@holtmann.org>
> > Sent: Thursday, August 5, 2021 6:41 PM
> > To: K, Kiran <kiran.k@intel.com>
> > Cc: BlueZ <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishankar
> > <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> > <chethan.tumkur.narayan@intel.com>
> > Subject: Re: [PATCH v1] Bluetooth: Fix race condition in handling NOP
> > command
> >
> > Hi Kiran,
> >
> > > For NOP command, need to cancel work scheduled on cmd_timer, on
> > > receiving command status or commmand complete event.
> > >
> > > Below use case might lead to race condition multiple when NOP
> > > commands are queued sequentially:
> > >
> > > hci_cmd_work() {
> > >   if (atomic_read(&hdev->cmd_cnt) {
> > >            .
> > >            .
> > >            .
> > >      atomic_dec(&hdev->cmd_cnt);
> > >      hci_send_frame(hdev,...);
> > >      schedule_delayed_work(&hdev->cmd_timer,...);
> > >   }
> > > }
> > >
> > > On receiving event for first NOP, the work scheduled on
> > > hdev->cmd_timer is not cancelled and  second NOP is dequeued and
> > > hdev->sent
> > to controller.
> > >
> > > While waiting for an event for second NOP command, work scheduled on
> > > cmd_timer for first NOP can get scheduled, resulting in sending
> > > third NOP command not waiting for an event for second NOP. This
> > > might cause issues at controller side (like memory overrun,
> > > controller going
> > > unresponsive) resulting in hci tx timeouts, hardware errors etc.
> > >
> > > Signed-off-by: Kiran K <kiran.k@intel.com>
> > > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > > ---
> > > net/bluetooth/hci_event.c | 3 +--
> > > 1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index ea7fc09478be..14dfbdc8b81b 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -3271,8 +3271,7 @@ static void hci_remote_features_evt(struct
> > > hci_dev *hdev, static inline void handle_cmd_cnt_and_timer(struct
> > > hci_dev
> > *hdev,
> > > 					    u16 opcode, u8 ncmd)
> > > {
> > > -	if (opcode !=3D HCI_OP_NOP)
> > > -		cancel_delayed_work(&hdev->cmd_timer);
> > > +	cancel_delayed_work(&hdev->cmd_timer);
> > >
> > > 	if (!test_bit(HCI_RESET, &hdev->flags)) {
> > > 		if (ncmd) {
> >
> > so this is conflicting with the patch introducing the ncmd timeout hand=
ling.
> >
> My patch specifically addresses the issue observed in case of NOP command=
.
> It prevents the issue by handling NOP same as any other SIG command.
>=20
> It looks commit de75cd0d9b2f3250d5f25846bb5632ccce6275f4 tries to
> recover when controller goes bad.
>=20

Do you have any further comments here ? Waiting for your input.=20

> > commit de75cd0d9b2f3250d5f25846bb5632ccce6275f4
> > Author: Manish Mandlik <mmandlik@google.com>
> > Date:   Thu Apr 29 10:24:22 2021 -0700
> >
> >     Bluetooth: Add ncmd=3D0 recovery handling
> >
> >     During command status or command complete event, the controller
> > may set
> >     ncmd=3D0 indicating that it is not accepting any more commands. In =
such a
> >     case, host holds off sending any more commands to the controller. I=
f the
> >     controller doesn't recover from such condition, host will wait fore=
ver,
> >     until the user decides that the Bluetooth is broken and may power c=
ycles
> >     the Bluetooth.
> >
> >     This patch triggers the hardware error to reset the controller and
> >     driver when it gets into such state as there is no other wat out.
> >
> > Nowhere in your commit description you are addressing why is this the
> > right to do.
> >
>=20
> Will fix it in the next version if you are OK with the current fix. Pleas=
e let me
> know.
>=20
> > Regards
> >
> > Marcel
>=20
> Thanks,
> Kiran

Thanks,
Kiran


