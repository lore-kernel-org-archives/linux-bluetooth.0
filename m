Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07FEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD9A60EFE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhHNGdY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 02:33:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:27004 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhHNGdX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 02:33:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="301250545"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="301250545"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 23:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="674750071"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2021 23:32:55 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 13 Aug 2021 23:32:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 13 Aug 2021 23:32:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 13 Aug 2021 23:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcaAsEDUJgy4WIk2Qy7F0DuDBSprIO8UaexBT1+vIEaJMzXF4+ws/vp9Dl6U0Atv8RpX6afnNjZMnpV0E+4lis63r4+5UcEu8kjPLP3F494IZSKgSdb5DeT11d3QHRWmSTyEY4YIdXSUxt/GP3Br3Rnl4yeOqejdWgDcZtZj89xSymMl31nVT+AY4MF5GLqz86Rz5UyMozR+AAt/GklWP8Lp/CLFdevN5U4sHDqBmeCGLumyTU47FaiWat3Qx7O6Dm2w/2qPFIhOKPhV0jZeHIdoEcKruVx8VFC6MFGua3KEvTHlHqo1joi9tcPiPHecDCmX43ILMwoIkKhg8z6a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9coxitoFb71ghuE9wyYhgFy92ysiXbl7ZphC4vEJ4p0=;
 b=KDxrVjNnqz6b2b4ir78g2q+tQ+eU+I6sPHNj+XW0rAOUM+qY1HyF2JWEQ5lr+nfiasBkdfCcVtFc+5rJ/m1jMDxIFyI6Ho+ov71rxlHENCXBekdJcu6L9L2SclwWh81nx4NM+kozVO7ngr4VvWNJTpRX5I0GT9IwvxlzfImQvLk1CZ7ojQAdQs288Pzufto+OaDA7x6i/QMruqpenOOwM/gTfBUQJ8IWj0Ev7lT/uDoT+V2lVFh0esn8tR6QvfwUjvQq19vGlJdbiBNl+ZmnfTA4cQhrmFdcW0n7SVQyMzOF4lritjUxNDTUNFeVoCIZMTQMV2cefZtOAztOV0832g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9coxitoFb71ghuE9wyYhgFy92ysiXbl7ZphC4vEJ4p0=;
 b=pcIuoyxbfR4hbnc4Nx9FFeIyjU7f8/u8cYEXFoby5SY0VlSq8AeI5wMaTJr3Z+ydP32vB9yByOghE5fJ7EKicfxYYZeW+R+Gt5kjP1DyRy/qmBjXiZt13EJ4wy3kEMbvZi5zN1Ri8EpqQDNQkJCp0upWr8svEDcgVQyv7qlI1uE=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5639.namprd11.prod.outlook.com (2603:10b6:8:24::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Sat, 14 Aug 2021 06:32:51 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.021; Sat, 14 Aug 2021
 06:32:51 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v11 03/10] Bluetooth: btintel: Read supported offload
 usecases
Thread-Topic: [PATCH v11 03/10] Bluetooth: btintel: Read supported offload
 usecases
Thread-Index: AQHXgsNvVVWd71xaO0iF+CDavTVlMatbk7IAgBcS5UA=
Date:   Sat, 14 Aug 2021 06:32:50 +0000
Message-ID: <DM8PR11MB5573F9B6EDDBB7999D1860E4F5FB9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-3-kiran.k@intel.com>
 <3710CF06-1420-4C39-ADD1-FA39E4909FA9@holtmann.org>
In-Reply-To: <3710CF06-1420-4C39-ADD1-FA39E4909FA9@holtmann.org>
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
x-ms-office365-filtering-correlation-id: 8ac948da-b859-4ac3-4618-08d95eed5714
x-ms-traffictypediagnostic: DM8PR11MB5639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5639C3CE13283868E9D6B036F5FB9@DM8PR11MB5639.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /N5Ry3EWIE7dbc4nZrKyzBjGg2Nell6HQxF0nGN3yzfVItsaOps4C/7GbHDPcmyj2IMHNt4txOZbC6kvLdXLzp3GCQUUOvnpEJTyJSPzwlCoX2UelQ5Q4TYG98ULre3ktkTZjS1rPZ5VtYbIF0+u/LH5qU++B9ZBfvGsLs7TEVRlzvyNt4rUOsgjhDgKio2q8NT9pKlsxJcjYtbiwyivBoNp0/KxrMrffkPHUxJHnNJEB0SrfpO5GS8ckhUSs4d4X/dJV9i03sdy4YxsEFmzar0NG+Y1YE+0pW3lcMvJmFDsh1SqI4I33Ce80rUHb2pnv1tRTb1sS3lvDtb/pf+7V1ijD0VvEnPiM2JDmUPT8InKnACPJgvjBfeHM8JTKAbxvr5o3S6NOQKiFk9nfU+U5FgfwxuQCS+TZaAv3/mLp7NDV8qDINJC2n3OK11X5a+Wic2kPoVQci/OWZDcahsT+gYGwlxX3BX+0dGEBISRfbjGKN6RIb6hiy74YF9KUAwVAsPUNEEsarte3EKXim5jQQN8X+pnZTWNVPCNkUztIEwvVW3Y+Lq771FvEz5yCuUwIL9jNVt6YUNqLxAvbYVP4PKg8W/0sgWFSMeJwWs0syyM/++mVSoz5NP4Ywdcqn2XyXzb5HOt8V2IqJNPeo54QqJhk6geb4pzoEGhkJkpDXDhhTV54GPDzFd56WFXCROmLOfilFozJ3htHTVkW5QS8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(71200400001)(33656002)(478600001)(38070700005)(54906003)(7696005)(26005)(6506007)(53546011)(4326008)(5660300002)(107886003)(6916009)(8676002)(9686003)(66946007)(55016002)(76116006)(316002)(38100700002)(86362001)(66446008)(83380400001)(2906002)(64756008)(66476007)(52536014)(122000001)(66556008)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bLqG7O9jyEZv9HUwYT8fETFWjSPqZTG81kIBYjLLrEGNw9ERGCLuHHE6YghZ?=
 =?us-ascii?Q?uPj5hczl7ZBG4MMmub8Ij/pEWe6Xxs54ZLqzR1hRV3mLgqj2R+KsfjQpOwYX?=
 =?us-ascii?Q?C1oiRI3pwCHXrkPBBAw2shggD551btbXQ1Xj4LpqczvF8qHs7vy/HrStFijc?=
 =?us-ascii?Q?87MoU4FXOIEIp/TOACll0IraFR2f1nuB9VVU1n4EvptpyxKTfLVZix8YpJsg?=
 =?us-ascii?Q?UoM8XCX7pDxDOvrcHkrHp/K7bHV6/eSjxNrtR1DSHFkSeQYRgjl2IJUMsvWe?=
 =?us-ascii?Q?9T6Kv819999box1nM0NddXYXNxwsK3Xo8LZOL9KfkITuIjYMzDODduHKH7ZN?=
 =?us-ascii?Q?gPP0UoC9Cj3SLFuY7YG/zacB7WmReayF9JGEfHqijqZGZqC1ntOsbuVAGE1J?=
 =?us-ascii?Q?AtFq76ROFPUaUCTIaLBUyg2FCQ73SZNzS9XJ6L0aFC1K/6AbKcQWn77bVwFR?=
 =?us-ascii?Q?aEC8uLbFxrpG8QNUDr++d8JWIIYUUzlCDXjnOa5u4gbLT2fPCqjvXQtrxRnb?=
 =?us-ascii?Q?reJaaGQE6i5mPYyIl4bLPVz2YcY9wfFOGnL5l2ddwPjzf1dliuLFL/AyJ/D1?=
 =?us-ascii?Q?WnLoWAQ39+ooMuD/jwOdvVFSSRC1NE9uflgFxCHoZLj8WsWoA06/gk+9P48l?=
 =?us-ascii?Q?aqh6d3mxIDVM+0IsnIl9JahTn+vBHxpQl0sRFESHoVQpyy+FpxRMTC7pu5jv?=
 =?us-ascii?Q?7HoaYc1h+IZR2Y2VV76CVPftWJFtSZ7/8iYV25bY25icJV1SWAVG3vHnsaqo?=
 =?us-ascii?Q?swlL96srZ5RGIOoBL85AMwvdF+/j2GcJZuEOgCTPYFLur33Mc74rgrdJkwHi?=
 =?us-ascii?Q?RShz7ftodJ3uwTwZf6q3L+6e2lAT+RXsJC60AUZ6eiDu0C+7KhaPX3c+geYh?=
 =?us-ascii?Q?zTtK4Wq8XR+tE0K281WTnSPWbwSrxDqi/wyW3b/Pfp97FPEPV2GRRv9FF0Fp?=
 =?us-ascii?Q?xBc0DAEWZTr1qj8YjG6YnvIjFjhET0n29Xk4KEysxk7m5LqQ/+oW01HFEqRt?=
 =?us-ascii?Q?v58CaUKOztLLf6FETQ8HiRxhqd6c0UT/YFXlcMSAJN0iCFFHAEk05uhywMbQ?=
 =?us-ascii?Q?42J11T8NQMCJIoRjrKeNBVOdnuhtJW5XbH4BlBaPDrqucnvkVRPNRN/FM8g0?=
 =?us-ascii?Q?q08ZgFdI2LpUf89A0Czm2jzcjb4z5XJUHJm4Rwr7EPHYuSJJI29HMjwXkMQr?=
 =?us-ascii?Q?Jp+dNO7T+Gs76Yx2K4m5QxMsMcQ6GXauuCxoHW1AEQD/QTSbP63ROM89M8E5?=
 =?us-ascii?Q?li0HHWFY7Ar+L56RC8LrR2Wdm+mh6WNHFGxChpb/3VyWs4odqgPAd9qHtiFi?=
 =?us-ascii?Q?GzVvFhBFhl9YwzooXXhI4q/z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac948da-b859-4ac3-4618-08d95eed5714
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2021 06:32:50.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbgVQhtBNzGs3yS7HYs3PMa5TEHMBDx49SofIs0KrGd+9vw3OCeN1tVEZ3EywrJXcBZ+AvWAjIuRaKDvtMnYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5639
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Friday, July 30, 2021 7:40 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>
> Subject: Re: [PATCH v11 03/10] Bluetooth: btintel: Read supported offload
> usecases
>=20
> Hi Kiran,
>=20
> > Read offload usecases supported by controller.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > * changes in v11:
> >  - Remove Kconfig related changes
> > * changes in v10:
> >  - restructure patch to have  definition and call of callaback in the
> >    same patch
> > * changes in v9:
> >  - define a separate patch for core changes
> >
> > drivers/bluetooth/btintel.c | 30 ++++++++++++++++++++++++++++++
> > drivers/bluetooth/btintel.h | 10 ++++++++++
> > drivers/bluetooth/btusb.c   |  3 +++
> > 3 files changed, 43 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index e44b6993cf91..a6b81914766e 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -1272,6 +1272,36 @@ int btintel_set_debug_features(struct hci_dev
> > *hdev, } EXPORT_SYMBOL_GPL(btintel_set_debug_features);
> >
> > +int btintel_configure_offload_usecases(struct hci_dev *hdev) {
> > +	struct sk_buff *skb;
> > +	int err =3D 0;
> > +	struct intel_offload_usecases *usecases;
> > +
> > +	skb =3D __hci_cmd_sync(hdev, 0xfc86, 0, NULL, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		bt_dev_err(hdev, "Reading offload usecases failed (%ld)",
> > +			   PTR_ERR(skb));
> > +		return PTR_ERR(skb);
> > +	}
> > +
> > +	if (skb->len < sizeof(*usecases)) {
> > +		err =3D -EIO;
> > +		goto error;
> > +	}
> > +
> > +	usecases =3D (void *)skb->data;
> > +
> > +	if (usecases->status) {
> > +		err =3D -bt_to_errno(skb->data[0]);
> > +		goto error;
> > +	}
> > +error:
> > +	kfree_skb(skb);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(btintel_configure_offload_usecases);
> > +
> > MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> > MODULE_DESCRIPTION("Bluetooth support for Intel devices ver "
> > VERSION); MODULE_VERSION(VERSION); diff --git
> > a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h index
> > d184064a5e7c..45ca5c4ccf37 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -132,6 +132,11 @@ struct intel_debug_features {
> > 	__u8    page1[16];
> > } __packed;
> >
> > +struct intel_offload_usecases {
> > +	__u8	status;
> > +	__u8	preset[8];
> > +} __packed;
> > +
> > #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) &
> 0x0000ff00) >> 8))
> > #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) &
> 0x003f0000) >> 16))
> > #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
> > @@ -175,6 +180,7 @@ int btintel_read_debug_features(struct hci_dev
> *hdev,
> > 				struct intel_debug_features *features); int
> > btintel_set_debug_features(struct hci_dev *hdev,
> > 			       const struct intel_debug_features *features);
> > +int btintel_configure_offload_usecases(struct hci_dev *hdev);
>=20
> so usecases is not, it would be offload_use_cases. However
> btintel_configure_offload is just fine as a function name. With the work =
from
> Tedd, this would be removed anyway and all done internally via the hdev-
> >setup().

Ok. I will rebase my patches over Tedd's patches.
>=20
> Regards
>=20
> Marcel

Regards,
Kiran

