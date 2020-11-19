Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FA4C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EF221527
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 11:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PoIn064j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgKSLXD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:23:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:16532 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgKSLXB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 06:23:01 -0500
IronPort-SDR: P/LsJbtfHKs41m6Km+KZ7zjaZFqsXajcwONeb3kzv8GnxIJyxGi18v3Z61UM7qc/0Vph0irLQ+
 0k9eHODmUmUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170491199"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="170491199"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 03:23:01 -0800
IronPort-SDR: mg6KrsBjVsmEaAIUJ97e3eXD9jMK4DTO8pED6/C/7BmhGl42k2Kq1OqqVn7ZsHJwq9xzc1ao5z
 L4t4CiYCfzvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="431197678"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2020 03:23:01 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Nov 2020 03:23:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Nov 2020 03:23:00 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.52) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 19 Nov 2020 03:23:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLL9qJ/RaHpaX1xRS0Hbh/zvihREEW3+tz9pOKAbe9o9t7u0EVW1x/P39u9sg5GOaHS8qgkgzL8KjTv+f6WDn2Ffa1yGMcSGRkxO5rvklCzDpneqooXHMczCZIOXJWNFM3frng1P6d4ZMs0OuQeC6Epa6kjBZzKuTSyOcllrzQbC+y8X2eSf5WtEcaBjidh0GrORQ1dMAqM0TntjZBNRcizh6HUnaNfB+/GMsdZ7LMi+DYYNCqgaFYWmwDcFdpkCfk57GoxgX85nVttA3/ntZ/4e/bTB5BXz+XXTu/+y03ZpquSHGFkj3bhDNncT9Yik4K7c9ljlcsFK1wfGwCPB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf5+kFCcu/Skw+YyDz01/PEXKz4RcFPoiaDJFQEKDP4=;
 b=H05GUlcRR2+3H2uf5D8SEa/yNhgIOX0z0qgnHxTCE+8kEFl1232dDERAviEM3a+25ruQ2lp6xFx/WL6FGBHxQh5n+jt1gRvtyTtaEXuEz8wcMZLNgklRy0i3BNnvXnxP2BgPu3xSXJKp3XRi8V8Y2hcT34oMG8pCm7hADbR2OFEjegiTkV7FCU1rTWYm0Ccx69v+EiQ9m/VnyKiypxpZYBKSJboFrUiV7aXDwq6myXkwSk/BaKwsqIni2CEov/YoSuN/BGan7ia0FAEiGxZwyQae6lAMpI2j6Z5CvClQbXOP5RdFW07F5G2vU5obOjF5+WNKbAZ/UUof8xwhec4cPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf5+kFCcu/Skw+YyDz01/PEXKz4RcFPoiaDJFQEKDP4=;
 b=PoIn064jncw0VG/CYKTI07jvwHbVZiH1SZN7yBlpFU1ICA6iOPVYjThP7wQoVQ3My2ACTztaunCyocgn1A0lPRMpGqKjRvsgvPbwnn+Qkgx7i5BIKnFE6mAPpx0WogddSvT51fwoh+QIZO+mqEIgj1C51NaAYglLlDBg86BD8B8=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BYAPR11MB3653.namprd11.prod.outlook.com (2603:10b6:a03:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 11:22:59 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::85cf:4ba6:9402:b396]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::85cf:4ba6:9402:b396%5]) with mapi id 15.20.3564.028; Thu, 19 Nov 2020
 11:22:58 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>, Kiran K <kiraank@gmail.com>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v7 2/4] Bluetooth: btusb: Define a function to construct
 firmware filename
Thread-Topic: [PATCH v7 2/4] Bluetooth: btusb: Define a function to construct
 firmware filename
Thread-Index: AQHWoiWecCpkCBE4pUmZsIaKxhYwW6nC8BKAgAyXVwA=
Date:   Thu, 19 Nov 2020 11:22:58 +0000
Message-ID: <BYAPR11MB3141E23495F1ED7616728EEDF5E00@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <1602678517-9912-1-git-send-email-kiran.k@intel.com>
 <1602678517-9912-2-git-send-email-kiran.k@intel.com>
 <10C24267-486C-40F1-8328-2FAD3FD71C5A@holtmann.org>
In-Reply-To: <10C24267-486C-40F1-8328-2FAD3FD71C5A@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.171.175.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 230e0157-aa9b-44fd-0c20-08d88c7d7849
x-ms-traffictypediagnostic: BYAPR11MB3653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3653676A22A937D06773E3BFF5E00@BYAPR11MB3653.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAlrSUJXQP4lHhVZLUiZPzhRMPPZl50KP3+pR0NBTLYrjhBRQM/C1jvy9/olUYDZQs0w8jDpfGTkW525leKudNXvERhtpQgFFzzlqKtAGKYH2FIXKYHgyizV4mgFIGCUceE5NCA/360knTlFwXVocA2zS09BLPFDm2j2ESCtt720SThBph2vq5xhngmvFYXVhoNgXfHKd7xux7por5VRQMbzXNx3n379fd6QpKZK4jtf3t/plF0TyLFw/AL0/IH/MFH1Rx0UsMHMjspOhg+DLrgiB6ZnBkenblSoiLj1CLmz+OM2sBwIjYWpVZoWIsuuT3Rhj0uRlVUUK7ULDXnltA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(2906002)(8936002)(53546011)(71200400001)(6506007)(8676002)(52536014)(7696005)(5660300002)(86362001)(66476007)(66446008)(64756008)(66556008)(66946007)(76116006)(316002)(110136005)(54906003)(26005)(186003)(83380400001)(478600001)(9686003)(107886003)(33656002)(4326008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QOePjotXh+kvcZQAtsbSOerGZj0GGJHIbl7VG5Km34LKkA5QdiqHUSKyYnf0ZHP4M3QY2HLdQ40YbBn29Sjyw3/YQjEGrTH2ObFl9MI5sZDpeSWsIuOy3XZoIxGJ/rZ6m78nHF//5cCa70oYneV9TjWlgksXpS9wFh8xd+ojaPzxIiStG2VpMoGGtSMRPFPEtcNiR5jhukJn5ZykZXLoeC7/Hoy9OkV1Sme5fYw0ZOEgjpYdfimmRZwk3RqoWwFNuGek9zjU8xo0VEZtm4l0d6+AKcagoD/B4omr7aL09Gn78X6D5y1/YKC5G9/EqJ3/6aJNiLcms+9Bp41XGdRSJjJzDA9ap8hJ9PvAkTsi0CE2/CZ41/acpyUwDng7monZF+JK1tMIRCU6a4anXWInm1EgthMF2faCYbpW1fv9CHF2eVrbfDIKAhgcoCjJ7EsK0r21OuC0nEt9t5+3+Wunf9KlfvUJzSflbzd/vGO40TnKfylabHhnUQ0EVlHBwyyXxlFfx4vTknxHEv6I60gy85GuystB6N/6e2Stz1URTBjSztgZlImyhxHhVk7f9inWcQPoq5jkdWB/glHNOuUtu+SJKl+KSPSVq5TLyIsPb1F2MZZBvOllHvYBj0blL5mD79mQXupE14qR7t6uAoxslPO8YNBRy7UbhcDOpLUBrwsJq0SYRxvSRcpnVg6gh90GPxQTLp6Qwd9YPN9Fl4gYVfIY4nkJNxvZ2U6USaKeQUGaKWl+9PENbBW71MAb4dSspCl7yXmfOaVh/JAffosBwbic9RWwB7YXZQfUqhsXCBl7nGDpv1ZMnnN0VsEM+OMAr8xFOvHZ7iJur4SMrzpYSYYnO4ZGhprD2l1IIv4D0T92n6sF2LnpuAZ1xeZ2kpUegZbITcZvDLj5XDmoRgJpmA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230e0157-aa9b-44fd-0c20-08d88c7d7849
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 11:22:58.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEf3zZlKmYq7VzfV9ZS9OyDBRp5bvDSvdebO+vEk/+Ll3k+TzqRlACKkVJTUxtokxmHAxcQpKFsTnfpU8EYL0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3653
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Wednesday, November 11, 2020 4:33 PM
> To: Kiran K <kiraank@gmail.com>
> Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>; Narasimman, Sathis=
h
> <sathish.narasimman@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; K, Kiran <kiran.k@intel.com>
> Subject: Re: [PATCH v7 2/4] Bluetooth: btusb: Define a function to constr=
uct
> firmware filename
>=20
> Hi Kiran,
>=20
> > Define a new function to construct firmware/ddc filename for new
> > generation Intel controllers
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > ---
> > drivers/bluetooth/btintel.h |  6 ++++++
> > drivers/bluetooth/btusb.c   | 19 +++++++++++++++++--
> > 2 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> > index 09346ae..c4e28a8 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -132,6 +132,12 @@ struct intel_debug_features {
> > 	__u8    page1[16];
> > } __packed;
> >
> > +#define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) &
> 0x0000ff00) >> 8))
> > +#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) &
> 0x003f0000) >> 16))
> > +#define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
> > +#define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000)
> >> 24)
> > +#define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4)
> | (s))))
> > +
>=20
> how is the endian safe?
>=20

It's not. Thanks for catching this. I will add a new patch, which does __le=
32_to_cpu() on TLV data before storing the values in structure.

> > #if IS_ENABLED(CONFIG_BT_INTEL)
> >
> > int btintel_check_bdaddr(struct hci_dev *hdev); diff --git
> > a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
> > 2e40885..ac532dd 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2360,6 +2360,21 @@ static bool
> btusb_setup_intel_new_get_fw_name(struct intel_version *ver,
> > 	return true;
> > }
> >
> > +static void btusb_setup_intel_newgen_get_fw_name(const struct
> intel_version_tlv *ver_tlv,
> > +						 char *fw_name, size_t len,
> > +						 const char *suffix)
> > +{
> > +	/* The firmware file name for new generation controllers will be
> > +	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
> > +	 */
> > +	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
> > +
> INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvi_top),
> > +					  INTEL_CNVX_TOP_STEP(ver_tlv-
> >cnvi_top)),
> > +
> INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver_tlv->cnvr_top),
> > +					  INTEL_CNVX_TOP_STEP(ver_tlv-
> >cnvr_top)),
> > +		 suffix);
> > +}
> > +
> > static int btusb_intel_download_firmware(struct hci_dev *hdev,
> > 					 struct intel_version *ver,
> > 					 struct intel_boot_params *params,
> @@ -2783,8 +2798,8 @@ static
> > int btusb_setup_intel_newgen(struct hci_dev *hdev)
> >
> > 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
> >
> > -	/* TODO: Insert function call here to get the ddc file name */
> > -
> > +	btusb_setup_intel_newgen_get_fw_name(&version, ddcname,
> sizeof(ddcname),
> > +					     "ddc");
> > 	/* Once the device is running in operational mode, it needs to
> > 	 * apply the device configuration (DDC) parameters.
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran


