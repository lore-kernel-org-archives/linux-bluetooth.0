Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEF760EFE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhHNGkF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 02:40:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:10101 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236139AbhHNGkE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 02:40:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="215695044"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="215695044"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 23:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="508592089"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 13 Aug 2021 23:39:35 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 23:39:35 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 23:39:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 13 Aug 2021 23:39:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 13 Aug 2021 23:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYTu2tUQYQXKUTkflpukeOaci57w0Mw3UUlYLtIAjWOQbHftrDTXduM1D8QJ7if2f7K6pKzY7EeZkkE72Vd88SDd2kuxETTXD8ML90R4/HCmzfhDbo34Dd4149rs6TN3dBas9SwZjq+WxdUqERVpvHNaLXJlaDWxzd7QIxdVOJ35V4ytDLvBienUWz/kRIkqDGb6SGP8KOx7tW8kwQUXd9duyvKlc2HOKlj6hk5JnsCE7+jX6m4hoZa0ZjlwZgll9ijg6Uv1PJwEShBCR9OkkP+t0UPHFSjZe/pXCufytPLxTRnDp1SY7xd4l0xU2/QdExR5uEkQlUCltVDLn/x83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2M+MOc1rG5t25VXqIpWAsVpLlEWpSOahmW7TDn824E=;
 b=Pc2whmwqXlZCwwE6PMYhqDPTJrs43cOsVhvAwU64XVBbk/YgfHCT9S4WIXv/zmiNCoE9zED1SpoHwIyuy4QoIRNaX8OWTghpylhE3jcgtIMEAAuBYW3fP5G+cAtJ8cgnmX+IseRlwEEXMKjoR9Ta3SV3rNF+bAf/thB9N/uKbO/M3dSXwFUhPKyWeRI6ywfs2WUEtBe9kVWyCDRC97K+SFshZT3RytXAI7R5kXERhsXp+uJ+s3D1dy/op+pTpjAcfcQ6YT1N2Ad4a5o8nB0CBczA1cB01lIxeZc8wnYdnXiMtOoM6AeR5ghCOKLW0EbX7UNRCoKfmCBOrUyYdYrdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2M+MOc1rG5t25VXqIpWAsVpLlEWpSOahmW7TDn824E=;
 b=dQtlurVhEYs8UGjMt2ZuPF8UcWn9n7CYKXdkq4hpM9+xUdcifQHtqJ7t1VG0JkwfZRfykM2esdBLOCh9FAvm92Iu/K+iBD+LM3CuxeDfis/VecZTKMEcWvdlzzIdIZi5lp+2py1j3HPUJnNbT4dnpva2tz6yFloBBKSA10Z4gxE=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5605.namprd11.prod.outlook.com (2603:10b6:8:26::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Sat, 14 Aug 2021 06:39:33 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.021; Sat, 14 Aug 2021
 06:39:33 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     "K, Kiran" <kiran.k@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v11 06/10] Bluetooth: Allow setting of codec for HFP
 offload usecase
Thread-Topic: [PATCH v11 06/10] Bluetooth: Allow setting of codec for HFP
 offload usecase
Thread-Index: AQHXgsNsUDQlIlwej0OhupKFeyJzC6tblbAAgAPCm/CAE078MA==
Date:   Sat, 14 Aug 2021 06:39:33 +0000
Message-ID: <DM8PR11MB557322D6EB556D81B1AF44E9F5FB9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-6-kiran.k@intel.com>
 <2E192E47-B47A-4464-A5D5-3DC34DD22ECF@holtmann.org>
 <DM8PR11MB557397CD63E11B0901F6FBF2F5EE9@DM8PR11MB5573.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB557397CD63E11B0901F6FBF2F5EE9@DM8PR11MB5573.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45f00d7-2db1-4bb2-146e-08d95eee46ca
x-ms-traffictypediagnostic: DM8PR11MB5605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB560539A0921B515C604AAF5CF5FB9@DM8PR11MB5605.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n/lLGl/IRB6ZaGRYysdsjBDjWpnjs4y/uDfj1h0HesJDcOMDlWQsFDdX0Fy0u1vTxMVoGmf54OQelNFHUL7dScsxin/auIVhGo5hlT5omtvvEIxkp9vk3asINVf1Mq5ww1pW/D3aq6eJ/rSKBiCoZKFhlfCgmF6VwTZqjtaCIrkqBvMDaf+7s421vq9t22vpS9t1s1f6MoPCHhpIJnoN9HhOT+HzrLoXmqjvuFABZ9WZei4JeFY2qve1YOZ0BvMcNGq9wBNwWLQcBmHbsGeFmwZ04nPidQHzPT7yvBz+OZKs9+7A5Nr8snfZBG+8P04jgort4Ws9mhi13MgVUCFxsD1Psor0Mf9OP3zQZb8p46HUG2l6oAM9K6U1jSyRVYoHmY/9WBJHyAYn/CwkIA3d7ShiXjKUy6G5AulF2cOgcVxrRmEc2B46TFKhxyZ19R/MIPIWHF70EyyCWcvIfddZKG8QgP4hWxSgTIRYIlJkfkUhOkL+7Dz7x8+J5h1qVtJlkMN6yfz5B00OpQFtuE9g+b7vQR0SnkkQlQ89ppKMPzOVASbmg3wlIJHBIv/pRSno90X1kEFdfTUA10AugCvEjZMspesfJnSjXKy0H/XXqzTvHxOHzeE7Dx6KIqqkt5zBV4sP03FbuaWuq1o6yNtXyV/bCLc25kbvkv3trBQX6hwi859Oft7ZitX0KhsYXOjXBrvI1/CmuotDZpsxZGmDaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(66446008)(107886003)(66946007)(5660300002)(52536014)(66476007)(66556008)(64756008)(33656002)(4326008)(83380400001)(2906002)(8936002)(7696005)(186003)(8676002)(38100700002)(9686003)(26005)(54906003)(71200400001)(316002)(76116006)(55016002)(38070700005)(110136005)(86362001)(6506007)(122000001)(478600001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RlfOhnv2VZjYGiUzNBVNP7jZpWmb94nXdXKngMTXVfrSIzNRm8NxuepLvIA?=
 =?us-ascii?Q?HXfK3NKYY9yLfDFwt7ohqD+0xxQFZjIuf+ckOAyprbt9nP73I44TKQc6qrAQ?=
 =?us-ascii?Q?vqqtLI22bBhc3nXDCIZzByY38XiFPtbav1vTLbxI2xHQh5R+FWvSA+lLunhs?=
 =?us-ascii?Q?twnAmLnqRm3vRVz6RZ02uQPKcatKeap0N8HL5e0/uUpx/MUSOsgcuKfEfHT6?=
 =?us-ascii?Q?aldWo/F0sMSAvaVwbOhOw/nyN3Q3JjhbURdTivBwBZtV1RlcwMGbFfjKavSB?=
 =?us-ascii?Q?f+PTcRWSXRwPYwipHSh4/c4lV781+9XXn1NZbX0tVzW1bdXTkwS9Cco+5wqX?=
 =?us-ascii?Q?XhVvP7V/ensIm3JGbhVkcaOBKW18C53rrSp+LrkgEsdkYIC7M1LmGC0d+7AE?=
 =?us-ascii?Q?O7uQ+OAnpmBgeNmLI9a/XLqj38Ox5ZK2JD3JNdcnLS83BTgweSDYYPdTrehA?=
 =?us-ascii?Q?SQaiRO0DRuJ86hPtlCrypsbDAS3Pva04vbiqs6rc7f+EI69WB3NaalddRV1Q?=
 =?us-ascii?Q?3VHTc9zk7am9mjwsDiSAnR8wyPMP4qRzqxNxk2hN75Nmznhc6rPTOTccnNo0?=
 =?us-ascii?Q?OSrtM8Or3h4bfjNgoNOy0F3Qw7vwxcGHLsOyN9+ZHpRphqMvAvPsIsXvjA1x?=
 =?us-ascii?Q?VNGkKJMaV667ab/Ga7CCZQthsh4F+H2vhGR/o+1w50O+3dJiGT55AlP7CnHw?=
 =?us-ascii?Q?G5nFOjmRV5bGcIa1+tO8AZV+DjJgQGCIMbtmzdRlLQqoSqo1+D7Nzs911iP/?=
 =?us-ascii?Q?Lmmird1uY+IUXsc25f2zhxHKJUWsP4MRDWjHXxjevULksfqbPDTvFtp8tnMw?=
 =?us-ascii?Q?DqWLx6teUWB36oU94epcp/dxAZWTwVqs9Hb+cBPrZ5/ITZtYWYl61arX7pUx?=
 =?us-ascii?Q?tmjXbM78uDmfUtXhRxRHGweMYPYAguFUPMMWeDtTT4A/fEIOkzdHV2CMPeJE?=
 =?us-ascii?Q?lXjMtepQrfiYpAVDzR4NdMyNaBRRooWuAUV+fzD1IEmjAUsVQ01HvKFNU/KE?=
 =?us-ascii?Q?ZP5KltYOO1KaWDD7ZcLxZsEUxRyby4QgbgqTpKskybl7aZtsJhp0nOroL9n/?=
 =?us-ascii?Q?lCLQvKCxu1cbqSnrKlnB+QF89sso5XDnZ+Gp75wlXoCjw3I2Muq840HwtOGm?=
 =?us-ascii?Q?bayB8l/xSamGI0XusjXbHyoHDZnbpwaVTQXd2JD2DZiXpgd3sQaBNU6cyUkz?=
 =?us-ascii?Q?ZQ8T3/mopvjdzrRa/Aan3fT0iEKaFo9mTkbCrsvXPGlaHMgL+wfYmk+vTcKy?=
 =?us-ascii?Q?Rr1XJ2GvTOwXyk9UTakXYqJmTSj7JizNxeyOSPWLfvQMIerF15iLxTOAc2mg?=
 =?us-ascii?Q?TtFjrul34mleAmVtY1wQYkQ4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45f00d7-2db1-4bb2-146e-08d95eee46ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2021 06:39:33.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndCkXlt31UcKIUbiZZK0zq3T1daLhreRTF3nsjwDyieRKsNy1p9/+wfcOBv2yfVvid80/XaUYP1WHm4Uy8XjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5605
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Monday, August 2, 2021 5:16 AM
> To: Marcel Holtmann <marcel@holtmann.org>
> Cc: BlueZ <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>
> Subject: RE: [PATCH v11 06/10] Bluetooth: Allow setting of codec for HFP
> offload usecase
>=20
> Hi Marcel,
>=20
> >
> > Hi Kiran,
> >
> > > For HFP offload usecase, controller needs to be configured with
> > > codec data and capabilities. This patch uses Bluetooth SIG defined
> > > command HCI_CONFIGURE_DATA_PATH to specify vendor specific data
> and
> > > allows userspace modules to set the codec via setsockopt systemcall.
> > >
> > > Signed-off-by: Kiran K <kiran.k@intel.com>
> > > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > > ---
> > > * changes in v11:
> > >  - Remove changes related to Kconfig
> > > * changes in v10:
> > >  - patch refactor - having callback definition and usage in the same
> > > patch
> > >
> > > include/net/bluetooth/bluetooth.h |   2 +
> > > include/net/bluetooth/hci.h       |   8 ++
> > > include/net/bluetooth/hci_core.h  |   3 +
> > > net/bluetooth/sco.c               | 118 +++++++++++++++++++++++++++++=
+
> > > 4 files changed, 131 insertions(+)
> > >
> > > diff --git a/include/net/bluetooth/bluetooth.h
> > > b/include/net/bluetooth/bluetooth.h
> > > index 64cddff0c9c4..1a48b6732eef 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -173,6 +173,8 @@ struct bt_codecs {
> > > 	struct bt_codec	codecs[];
> > > } __packed;
> > >
> > > +#define CODING_FORMAT_CVSD	0x02
> > > +
> > > __printf(1, 2)
> > > void bt_info(const char *fmt, ...);
> > > __printf(1, 2)
> > > diff --git a/include/net/bluetooth/hci.h
> > > b/include/net/bluetooth/hci.h index 22e872e60ff8..c998607fc517
> > > 100644
> > > --- a/include/net/bluetooth/hci.h
> > > +++ b/include/net/bluetooth/hci.h
> > > @@ -1250,6 +1250,14 @@ struct hci_rp_read_local_oob_ext_data {
> > > 	__u8     rand256[16];
> > > } __packed;
> > >
> > > +#define HCI_CONFIGURE_DATA_PATH	0x0c83
> > > +struct hci_op_configure_data_path {
> > > +	__u8	direction;
> > > +	__u8	data_path_id;
> > > +	__u8	vnd_len;
> > > +	__u8	vnd_data[];
> > > +} __packed;
> > > +
> > > #define HCI_OP_READ_LOCAL_VERSION	0x1001
> > > struct hci_rp_read_local_version {
> > > 	__u8     status;
> > > diff --git a/include/net/bluetooth/hci_core.h
> > > b/include/net/bluetooth/hci_core.h
> > > index 71c409c8ab34..eafa6f8114cb 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -618,6 +618,9 @@ struct hci_dev {
> > > 	void (*cmd_timeout)(struct hci_dev *hdev);
> > > 	bool (*prevent_wake)(struct hci_dev *hdev);
> > > 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
> > > +	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
> > > +				     struct bt_codec *codec, __u8 *vnd_len,
> > > +				     __u8 **vnd_data);
> >
> > why are these two independent callbacks? I seem to remember saying
> > that it looks like we only need one.
>=20
> get_data_path_id,  gets called during getsockopt(BT_CODEC,...) when
> populating codec details to user space.
>=20
> get_codec_config_data, gets called during setsockopt(BT_CODEC,...)
>=20
Not sure if I was clear here. The two callbacks serves different purpose. g=
et_data_path_id gets called during getsockopt(BT_CODEC,...) and fetches dat=
a_path_path_id.
get_codec_config_data gets called during setsockopt(BT_CODEC,...) to fetch =
the vendor specific codec data. This is data is used to configure the codec=
 before opening SCO connection. This data is passed on to controller via HC=
I_CONFIGURE_DATA_PATH command.=20
> >
> > Regards
> >
> > Marcel
>=20
> Regards,
> Kiran
>=20

Thanks,
Kiran


