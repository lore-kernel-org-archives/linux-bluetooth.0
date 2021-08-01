Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Aug 2021 23:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104FA60560
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Aug 2021 23:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhHAXqK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Aug 2021 19:46:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:16855 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231908AbhHAXqH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Aug 2021 19:46:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="298947936"
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; 
   d="scan'208";a="298947936"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 16:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; 
   d="scan'208";a="509763969"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2021 16:45:57 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 1 Aug 2021 16:45:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 1 Aug 2021 16:45:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 1 Aug 2021 16:45:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 1 Aug 2021 16:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S46ZeePN9WUvWNdhtJpRjaF0ohUUSKIY/lJlWP09+ZmmEHLoscxsvHE1lrYQ6Al2ASgNEYT5zIsj58W0NxxsD/9R3JuIZt94zHIEUIrvNVF22y7smp5rkNUbevIIxrB/3iOgRZml2xXL2D28Pppv7UkKEcZg0CMSsZFtPYvEsPpYi0tICVkIgkI2J/klONA/hn19iPPjpvU5rRAP7x6W3f0hEVAjeQGVho/xKem3cR3pqa37P1+ZjfidddCEUOg4WvkDC7NYKc2ETE4NxewZyJeVZOq98wI34dgCflP8DqsbxHKv3fNgQAHU+sfpuIkJkHZhYHprKIXKET4tKl/gKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xilFT/ivgge46sAbcAmro+ZmolsB53x9O/cfe3IIyE4=;
 b=MyTsaJJZEPzlbYYT5HrUwRXRWcFVzGgaBKAi4Vk2HitoUhIri8PmreVQx2y2iA2ulyLe0Jq+aNk2LObYA+9DakFUFhNnbxjuSANKfJJifouJsOoUPFzAqViWnD1ydx/gHPq6Xqyz6KdtqtZiV+a60xFMxElxEJwK1WDLV8xZDXgQDMUuFLrzIYIlQ3aRL2vm9iCYZSVpbCIOzLm/YWwovxv0lSauAamP3pWOQHDlX4qSJRzbUvlSIYSLei1I+13kv+JgYw8GuGML/RucvoUkXXYewimM1zKFl/1VXwHojyWUd6OMOCsHWHTFvSqgN29F0uCWJlj9NMTifDoK/kCl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xilFT/ivgge46sAbcAmro+ZmolsB53x9O/cfe3IIyE4=;
 b=SJ/ILcvx+zwHz3L10xjWorWIXc23Tb+GpW5muOflVSRWdAfvquP9euU5pSM29PkokwzSEajByUp61dcNfIgDsDQMyIj6i2dD0RqJatk8aAGwSzQeuEZnX3N02KUAZ0PC7Liow76/3GQ35KLkiUU3cFsi3FvJgrP8vQDhg6kaMbg=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM4PR11MB5568.namprd11.prod.outlook.com (2603:10b6:5:39a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Sun, 1 Aug 2021 23:45:55 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10%9]) with mapi id 15.20.4373.026; Sun, 1 Aug 2021
 23:45:55 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v11 06/10] Bluetooth: Allow setting of codec for HFP
 offload usecase
Thread-Topic: [PATCH v11 06/10] Bluetooth: Allow setting of codec for HFP
 offload usecase
Thread-Index: AQHXgsNsUDQlIlwej0OhupKFeyJzC6tblbAAgAPCm/A=
Date:   Sun, 1 Aug 2021 23:45:55 +0000
Message-ID: <DM8PR11MB557397CD63E11B0901F6FBF2F5EE9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-6-kiran.k@intel.com>
 <2E192E47-B47A-4464-A5D5-3DC34DD22ECF@holtmann.org>
In-Reply-To: <2E192E47-B47A-4464-A5D5-3DC34DD22ECF@holtmann.org>
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
x-ms-office365-filtering-correlation-id: c27c7a47-baec-409a-ff04-08d95546812c
x-ms-traffictypediagnostic: DM4PR11MB5568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB55685DAB7C7DB9F7590021B7F5EE9@DM4PR11MB5568.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kL9IkDgZ9DgGbHrdI2ipfUR/3Gyhs45KKITTLJXR3UdoYBh8vyS8grS1VZEFYLiM93fVghONRyMJ55Hx8t4a76JozfK7DwF0P54VO+NZ03AFbVQYa7JQZoPLq3y11zfagC4MPgoOBK0N/OFdM6HCTXtSmam6eeAmaHqmI1W3AetBEVN1sISzSVutOaahyyyQvMtCBAaq3ipmYAdzhAa2bHnusG2Xuepa/t0xXbeMj8efUTnQxt6KbAMSlZdF2yd2Eatlwt1vhEiv65tfJoiVZsANGeWimBZoq6R3csbQPoCV8SWgV/nZEg0QJLERF7JLDLXggv0JXUhEESrrQMvI+9gXRhW2oa4LzFwGwdM42CYeBhkcvLbkORRUwbhnugPt1h3i4y91F6DGF3sLrS0ONB9rZGm/6HCGFBOegdtVJy5BGmu8ijNP3ImoB4MafsqanfdFQXnr12AhD5+84R5aY66YgK7adPir8YuNln9Ey20AzqO/zQwutW734kux5HSi/9GOovtaxnZ1O4fPouwfwpy7Um8SsdGpT/AZIBv7GbxB+tg6lj/FdeYxD76jNVLhS2b95gW7fxjCVIjERet0mX0oFfkz6YOH3t0GqL96a9s7Na/ntHUx6CkRlPNhg0S15PwEHYgAImt4G0AqWSJUw5MwHU07+kuvPmBS72GGfmCNP1sjBZg/zpKQhWDLZBNkJGWXDwHo7rnmMbLRVJeV8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(55016002)(54906003)(66446008)(86362001)(316002)(2906002)(71200400001)(66946007)(76116006)(508600001)(52536014)(66556008)(33656002)(5660300002)(4326008)(64756008)(66476007)(8936002)(38070700005)(8676002)(107886003)(6916009)(186003)(7696005)(38100700002)(122000001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?puCWBvD/giy5gwRun8P10Ak82em5EUlrMhKJZT85NixUcoWOBK/hE9uX3Ji9?=
 =?us-ascii?Q?660OcAO9YE/D2RD5L0d1h0+BsCKzhX/51gt1KyRkImb4GFlbFZGnC5fTfRpy?=
 =?us-ascii?Q?dYNyXTwQN0RAcu8xpqMv6/IGJ3LAENDjCWiSnB6pHLBcZoDPLKHOwS66J4Q/?=
 =?us-ascii?Q?0SnM0i2bszKvblkIN28WZQklQLW0HyNaBr0fsOKyLVohKQKF4lKwhAkRMvtL?=
 =?us-ascii?Q?HT4lWOm/dSk+e0lBkHmNt27QK2MgqUdgQPHrGGdtPJ88Bf087OPzMXpqw7pJ?=
 =?us-ascii?Q?kLrwp6kHAjBUYuj1vKBWCJ5mx0Nl4Zi4XO2zJOGOGWaw9iACxwbdTph6qy4U?=
 =?us-ascii?Q?9AWlndhsnWAbTbdn1iMTzimXs7D/vjnR5tXw6FyZWyLbR53WI2QHbfxm28nC?=
 =?us-ascii?Q?JteuK6eGs1kkqpmSA+3N1qUeIpgMlgmCdzvIcTj6zCaByHaExK8DJDs4/+7+?=
 =?us-ascii?Q?48iOHTtkG/jhXgqbq9VfZXFUgRqIz+n/yuAnBpbelaPD8XppSMHalyWA3499?=
 =?us-ascii?Q?OcDwer/MmL/KJRUZaFeJH2z8aNHQa2a8CKwsAC2R+x6LaV9Gie6suoyY4jLa?=
 =?us-ascii?Q?HoSi7e/I633MY9ji8o7JagiWBj2PasazJMKCLmTZGKaQ2obG6r9Y56r9HyaC?=
 =?us-ascii?Q?hWuPQzfj4jMficQUVx49OWuoQnC/mTsmyKF5hMkG8NRBSRqDLg2P2r/c4CR0?=
 =?us-ascii?Q?9QCW87e/n/gtzmFbW1hPLdOnmIynMJyn3/nU2kYKUuQMAMw+EmMG3zFMisQo?=
 =?us-ascii?Q?w3cXozxVZZGldfS667ioVY4omUzaVCr6FBnXXJLZscl1ak/QcFiwxJ7zLXPB?=
 =?us-ascii?Q?/sYhaJpdEBlVQywD4sFT6FTMGiG2Ruy+yulrK3EYm1g3D/F7hIDKIpsojDv7?=
 =?us-ascii?Q?XYkxXGBt6CFx1+TqED+87KYgaYaxTjoQ8XJN+4H+7SKeKAApkMsXlAw5ghC7?=
 =?us-ascii?Q?qH63y4gT+YNU+ciaAx6Z3pNp//ZDu7TFmo1d0/48iCL8Gb7iLwH83Sl7B8zy?=
 =?us-ascii?Q?zS0QvFCwyLtIsigwz/E0ErsUJnF+VGx2OKn+Q4u8TJKsWR5tnRRmxFDxpC2v?=
 =?us-ascii?Q?X0VSYMyIKdxmicuEZtc616DjuRcrniSpdMyA6d42HtdyOUqVQ3M2cXbVk8bS?=
 =?us-ascii?Q?qiLoMkrmELRNwwB2EFYAZba4niN17Z8bfFsk5U+LL47OVDGyVR3tiQOHC0Gj?=
 =?us-ascii?Q?wZoiy+jej+6eqXX6kCmwyBUoqOWLDDLrXdJ74++TxYjivL8vZFpMJ33whHZN?=
 =?us-ascii?Q?PCyRwn6+88r3n/Zf1AyhOITYSqVJcWxqAqm+EldYIr+iW1TUqcSewaazJTa4?=
 =?us-ascii?Q?wL6dRBfTuFY53PrviIlPL5Ic?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27c7a47-baec-409a-ff04-08d95546812c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2021 23:45:55.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cs9rNo/q9zXYuk3M6SC2itkhlY//BjmmHSDTg929CTTtQo5UATTrqQuSTiDwCOUhCoUqPWcLEsM4EhSEf6We9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5568
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

>=20
> Hi Kiran,
>=20
> > For HFP offload usecase, controller needs to be configured with codec
> > data and capabilities. This patch uses Bluetooth SIG defined command
> > HCI_CONFIGURE_DATA_PATH to specify vendor specific data and allows
> > userspace modules to set the codec via setsockopt systemcall.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > * changes in v11:
> >  - Remove changes related to Kconfig
> > * changes in v10:
> >  - patch refactor - having callback definition and usage in the same
> > patch
> >
> > include/net/bluetooth/bluetooth.h |   2 +
> > include/net/bluetooth/hci.h       |   8 ++
> > include/net/bluetooth/hci_core.h  |   3 +
> > net/bluetooth/sco.c               | 118 ++++++++++++++++++++++++++++++
> > 4 files changed, 131 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h
> > b/include/net/bluetooth/bluetooth.h
> > index 64cddff0c9c4..1a48b6732eef 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -173,6 +173,8 @@ struct bt_codecs {
> > 	struct bt_codec	codecs[];
> > } __packed;
> >
> > +#define CODING_FORMAT_CVSD	0x02
> > +
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 22e872e60ff8..c998607fc517 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1250,6 +1250,14 @@ struct hci_rp_read_local_oob_ext_data {
> > 	__u8     rand256[16];
> > } __packed;
> >
> > +#define HCI_CONFIGURE_DATA_PATH	0x0c83
> > +struct hci_op_configure_data_path {
> > +	__u8	direction;
> > +	__u8	data_path_id;
> > +	__u8	vnd_len;
> > +	__u8	vnd_data[];
> > +} __packed;
> > +
> > #define HCI_OP_READ_LOCAL_VERSION	0x1001
> > struct hci_rp_read_local_version {
> > 	__u8     status;
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 71c409c8ab34..eafa6f8114cb 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -618,6 +618,9 @@ struct hci_dev {
> > 	void (*cmd_timeout)(struct hci_dev *hdev);
> > 	bool (*prevent_wake)(struct hci_dev *hdev);
> > 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
> > +	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
> > +				     struct bt_codec *codec, __u8 *vnd_len,
> > +				     __u8 **vnd_data);
>=20
> why are these two independent callbacks? I seem to remember saying that i=
t
> looks like we only need one.

get_data_path_id,  gets called during getsockopt(BT_CODEC,...) when populat=
ing codec details to user space.

get_codec_config_data, gets called during setsockopt(BT_CODEC,...)=20

>=20
> Regards
>=20
> Marcel

Regards,
Kiran


