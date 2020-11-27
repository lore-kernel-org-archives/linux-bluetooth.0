Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08313C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 06:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A6A221FD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 06:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Oosd2X4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389717AbgK0GKD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Nov 2020 01:10:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:45312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgK0GKC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Nov 2020 01:10:02 -0500
IronPort-SDR: Qo5eSyrZyQ8dT3x41+TNDcJYeE6aTFFWT3zsnTDcbmn+kIQv0hzSRCpR+KvnkW4g4jOrnBSuOA
 jAKw1Tw0cK8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="168854654"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="168854654"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 22:10:01 -0800
IronPort-SDR: pEZPBZ9BaE1CtKxSURVq5+m9WZgS3Xds9FMogfJWVTVV3djtprm/8N52ltZCr91O0ub55e5jKd
 X+JWnFPni3pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="403807988"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2020 22:09:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Nov 2020 22:09:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Nov 2020 22:09:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 26 Nov 2020 22:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaxEUoo+qZYhpTpP0BHwL2ClcV3+nNXlZyFzaX5ZWHlPumLseyF1sFW/2JY3FsauLvEOhl9V8nJhlnEjBJaTRF+9ZAL8pWaqw25ibwt4JGQjAK7wUs3PEWOAjAUDcKEuQpJSRlJ+7x5EEU77MCzucAJKxAVRoTvO8RHZll4nQiK+RqCsm/BnYjSlbuI07nGYLDLHcQNsNep2zwYw8woVJk3IXVLCzg6Ctib5FmsbTIX4GRZCaAUF5jkbSO3nB1pLGa2dzxWMMkutgfNKOwpqnSPlrzAd1TZAD1lsYcPSFX3adD/dilSrX1MHXto3H8aes250+JKDuRMycq42/P0VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISr+O+b3FpUfHkA+I8nKO/MDOKGObwmApnerojCQAkk=;
 b=iQcAFz06NswZbj9Vlq33LZMCpBilJGS/Pqm9oRL65QR3ZyF+nAA8BgHMDPIHfbCKRRamVCoNpMeDiNG5A7a+e+c3qhgBtDmgoF3JCp6tmwx2Mr+I0PUHDUXvY9x8d+nCdczsBWftiQ8JtRV1aJ9GZ/WHCPQtB0lVSD7SpePpOC6ulCtZfdLMxV3YnQWf0CO5RgIk+Cx9h+5oK2HWjWjeUwZikq8hwoCqyjfFzfNS+XeucPIT8aoKkSbRNlNnOAhU1QADe2OQN4inkLe7MCVAoGLh2XpzFIXc0mbZ4m+dYL5E4kw6k/Kx/Rpmr/kisQynhYMCALpyYUjwi/2LWhlgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISr+O+b3FpUfHkA+I8nKO/MDOKGObwmApnerojCQAkk=;
 b=Oosd2X4xMjz5kwXDV7T3LcA/b9VZZ45+cqtO2VF91d28jYZI3qDMYQyZrkYbsOYzd31YfNfsDl9PkDruzX2ZX6dFK72uuSzOp9ghAdfUJvVrKg3dq0qT5WStJTs60bT4Uua9JXw8p9KrMBi2Vj8QZVqzkE1qISaBBjCUTmyU2mk=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SN6PR11MB2976.namprd11.prod.outlook.com (2603:10b6:805:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 27 Nov
 2020 06:09:46 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::18b:82ac:74c7:126a]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::18b:82ac:74c7:126a%5]) with mapi id 15.20.3541.030; Fri, 27 Nov 2020
 06:09:46 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
CC:     "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>
Subject: RE: [PATCH v3] Bluetooth: btintel parse TLV structure
Thread-Topic: [PATCH v3] Bluetooth: btintel parse TLV structure
Thread-Index: AQHWtB1rM6CQhzntHkOiqKGk6aUoPKnLvmXAgAlx94CABm8EsA==
Date:   Fri, 27 Nov 2020 06:09:46 +0000
Message-ID: <SN6PR11MB2703D767EBADAA02A3BB7BBE94F80@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20201106092119.20486-1-sathish.narasimman@intel.com>
 <SN6PR11MB27034462DA5BA784215D760794E20@SN6PR11MB2703.namprd11.prod.outlook.com>
 <SN6PR11MB27032D732BABC78757CAEC3A94FC0@SN6PR11MB2703.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB27032D732BABC78757CAEC3A94FC0@SN6PR11MB2703.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.243.48.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dead733f-c3bb-46b0-ad52-08d8929b0a8e
x-ms-traffictypediagnostic: SN6PR11MB2976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB297678DD0628DFE6F7DDFF5F94F80@SN6PR11MB2976.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfTO21uchRwa8lNzjpQ+fN7ELRgsbBwnNVZ6wP8rcpiwjnP+xDZ5ymUyr2PIH1Vq13kKricTwaGmT+K+Gb8HO9U1IiBtzppHj71G4Uy1JQS33GUlqS/lFU/TJ3oCcZEEBsU5vmhYA5zstU+d7g57bURP5R+sI5dZkbuE4qQA2P3SDh/ybOBZVj4wCchGT28sR1pdGrir8u8SDKrMyhhvvBFoQK6TNLEHzg5tyfRRCPNsV0Gf+ZMh/KgRrOW7q+SF1II3C5co4N1rPfxogS3vnkUhg0oh6KxVRMPfWKx02lHrw0Jmet9KFJu3wtm46kW1tAQnkhD0QsZWxIT/mCebyKyaL2PVcI0pBMQg9Wh8sn1yEUZ5aZKlFWY1+6rtKoGh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(186003)(76116006)(52536014)(9686003)(64756008)(5660300002)(53546011)(66476007)(71200400001)(55016002)(66946007)(4326008)(107886003)(66556008)(7696005)(8676002)(2906002)(66446008)(8936002)(26005)(30864003)(6506007)(45080400002)(33656002)(478600001)(83380400001)(6916009)(316002)(86362001)(54906003)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e67KJmybnUY5BWNeY/eocnRQ7yBEPGyU0vSnDNARqDK/1hjREs17LCJsc7Ak?=
 =?us-ascii?Q?/YQJInVgd0kYGEbfMCqZe1TnhdB2KO9ZgnM30/4t/TJeiflmRR/BZ995AyF5?=
 =?us-ascii?Q?rTvRgCaau51O1jGeVBuU72HA6j1taBwTz8kv2uF40Yr57mtjL8AQa1LcotIx?=
 =?us-ascii?Q?Y1p43dVqWmql3EZmGWXgUaYwOpn82d/PkcONIVHtPnZqV148QiyAjXG5pYVr?=
 =?us-ascii?Q?QWR3hPrgcg/f+LUxX8KJ7CKQiuy8tSUn2K1LJdNsiqLz5lTYy9Qu6EdHDzcG?=
 =?us-ascii?Q?aKaXC/tp5ZAu7sL1hTUdQQpP3uEFRMXzR8qfhrm3CuWdMBGnCEjHYCSLPCAu?=
 =?us-ascii?Q?gJ7mbeHtHwU6wnu2bMd5fJQwQVoRSQoiUvR/4++0d2N3SuLInUyElirCLGvv?=
 =?us-ascii?Q?HROkpgbfdDjXN8hvO+03y+BJY9AOCssS5/ZL+aazRvGeMYMukxZSHqy2nL3w?=
 =?us-ascii?Q?Ea9Wcpxc754tBoS2VfqbLsWklH9be0dZvGm1U5B/VXho+9aHI0yyBoCx7V36?=
 =?us-ascii?Q?aeinVAnsWtc1NaCenbAvwrSxtfzh7DqpbJbe7VMOJXN318Uacrl+8qjLBhdN?=
 =?us-ascii?Q?PugrB+aSlrYdjV6gA21/dGSzxjIr+XngWfNreso0jtdXEAWUmJZNWrSgB896?=
 =?us-ascii?Q?MSW9px6+1eDL+NW3M4b+pN9wL6v4ltTZR0bgRL0v8tpL1rhW8qsmTCege9pw?=
 =?us-ascii?Q?UIgKv8XKnjAhSxWpeV2GQbuQyanI1dXvmrdGEFbw73Ks7oktn0PvbO/p4W/u?=
 =?us-ascii?Q?T1tKJHSHgSUbeiIOIbXsuM0xHI/gdzVoafkqEg5/vhlqpAlmKOyuonAEuPyf?=
 =?us-ascii?Q?k/r7zNQNXTOlQH1jMNIFs5rr63pdJ/rh/VzaBINhU/0fxh1nUn4P+1iyXf/H?=
 =?us-ascii?Q?bAOOn79weBKlF+reTnyWQL8COTpcyB0tZsIAG2uOfOoSS5KX0QdVgM4WFz/z?=
 =?us-ascii?Q?KJQmCjISwOE6Brcxfo/haCFQpjRnyJLbDcnoHpfMFPM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dead733f-c3bb-46b0-ad52-08d8929b0a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 06:09:46.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rh4a/hSlGlqHBASUORgFIfPPuBuCbC0db+qbwwsfqemOYcKYGbZcQLQZydGg7atnEVRewA2/n24jlVF49bjcxbqK9CGtJqKYTjSAEWjVhAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2976
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

> -----Original Message-----
> From: Narasimman, Sathish <sathish.narasimman@intel.com>
> Sent: Monday, November 23, 2020 9:25 AM
> To: 'linux-bluetooth@vger.kernel.org' <linux-bluetooth@vger.kernel.org>
> Cc: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>;
> Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran
> <kiran.k@intel.com>; Narasimman, Sathish
> <sathish.narasimman@intel.com>
> Subject: RE: [PATCH v3] Bluetooth: btintel parse TLV structure
>=20
> Hi
>=20
> > -----Original Message-----
> > From: Narasimman, Sathish
> > Sent: Tuesday, November 17, 2020 9:11 AM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>;
> > Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran
> > <kiran.k@intel.com>
> > Subject: RE: [PATCH v3] Bluetooth: btintel parse TLV structure
> >
> > Hi
> >
> > > -----Original Message-----
> > > From: Narasimman, Sathish <sathish.narasimman@intel.com>
> > > Sent: Friday, November 6, 2020 2:51 PM
> > > To: linux-bluetooth@vger.kernel.org
> > > Cc: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>;
> > > Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Narasimman,
> > > Sathish <sathish.narasimman@intel.com>
> > > Subject: [PATCH v3] Bluetooth: btintel parse TLV structure
> > >
> > > Latest intel firmware supports TLV structure in operational mode for
> > > intel read version. so made changes accordingly to support both
> > > bootloader and operational mode . These changes are only to specific
> > > intel bluetooth controller for example ThP, CcP.
> > >
> > > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > > ---
> > >  drivers/bluetooth/btintel.c | 105
> > > +++++++++++++++++++++++++++---------
> > >  drivers/bluetooth/btintel.h |  16 ++++++
> > >  drivers/bluetooth/btusb.c   |  41 ++++++++++----
> > >  3 files changed, 129 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btintel.c
> > > b/drivers/bluetooth/btintel.c index
> > > 88ce5f0ffc4b..67267afc83e1 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -401,31 +401,9 @@ void btintel_version_info_tlv(struct hci_dev
> > > *hdev, struct intel_version_tlv *ve  }
> > > EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
> > >
> > > -int btintel_read_version_tlv(struct hci_dev *hdev, struct
> > > intel_version_tlv
> > > *version)
> > > +static void btintel_parse_tlv(struct sk_buff *skb,
> > > +			      struct intel_version_tlv *version)
> > >  {
> > > -	struct sk_buff *skb;
> > > -	const u8 param[1] =3D { 0xFF };
> > > -
> > > -	if (!version)
> > > -		return -EINVAL;
> > > -
> > > -	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> > > -	if (IS_ERR(skb)) {
> > > -		bt_dev_err(hdev, "Reading Intel version information failed
> > > (%ld)",
> > > -			   PTR_ERR(skb));
> > > -		return PTR_ERR(skb);
> > > -	}
> > > -
> > > -	if (skb->data[0]) {
> > > -		bt_dev_err(hdev, "Intel Read Version command failed
> > > (%02x)",
> > > -			   skb->data[0]);
> > > -		kfree_skb(skb);
> > > -		return -EIO;
> > > -	}
> > > -
> > > -	/* Consume Command Complete Status field */
> > > -	skb_pull(skb, 1);
> > > -
> > >  	/* Event parameters contatin multiple TLVs. Read each of them
> > >  	 * and only keep the required data. Also, it use existing legacy
> > >  	 * version field like hw_platform, hw_variant, and fw_variant @@ -
> > > 496,6 +474,85 @@ int btintel_read_version_tlv(struct hci_dev *hdev,
> > > struct intel_version_tlv *ver
> > >  		/* consume the current tlv and move to next*/
> > >  		skb_pull(skb, tlv->len + sizeof(*tlv));
> > >  	}
> > > +}
> > > +
> > > +int btintel_read_version_new(struct hci_dev *hdev, struct
> > > +btintel_version *ver) {
> > > +	struct sk_buff *skb;
> > > +	struct intel_version *version =3D &ver->ver;
> > > +	const u8 param[1] =3D { 0xFF };
> > > +
> > > +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> > > +	if (IS_ERR(skb)) {
> > > +		bt_dev_err(hdev, "Reading Intel version info failed (%ld)",
> > > +			   PTR_ERR(skb));
> > > +		return PTR_ERR(skb);
> > > +	}
> > > +
> > > +	if (skb->data[0]) {
> > > +		bt_dev_err(hdev, "Intel Read Version command failed
> > > (%02x)",
> > > +			   skb->data[0]);
> > > +		kfree_skb(skb);
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	/* The new Intel read version is backward compatible for Thp and
> > > CcP
> > > +	 * type cards. when the controller is in bootloader mode the
> > > controller
> > > +	 * response remains same as old intel_read version. For ThP/CcP
> > > cards
> > > +	 * TLV structure supports only during the Operation Mode. The best
> > > way
> > > +	 * to differentiate the read_version response is to check the lengt=
h
> > > +	 * parameter and the first byte of the payload, which is a fixed va=
lue.
> > > +	 * After the status parameter if the payload starts with 0x37(This =
is
> > > +	 * a fixed value) and length of the payload is 10 then it is identi=
fied
> > > +	 * as legacy struct intel_version. In the latest firmware the suppo=
rt
> > > +	 * of TLV structure is added during Operational Firmware.
> > > +	 */
> > > +	if (skb->len =3D=3D sizeof(*version) && skb->data[1] =3D=3D 0x37) {
> > > +		memcpy(version, skb->data, sizeof(*version));
> > > +		ver->tlv_format =3D false;
> > > +		goto finish;
> > > +	}
> > > +
> > > +	/* Consume Command Complete Status field */
> > > +	skb_pull(skb, 1);
> > > +
> > > +	ver->tlv_format =3D true;
> > > +
> > > +	bt_dev_info(hdev, "Parsing TLV Supported intel read version");
> > > +	btintel_parse_tlv(skb, &ver->ver_tlv);
> > > +
> > > +finish:
> > > +	kfree_skb(skb);
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(btintel_read_version_new);
> > > +
> > > +int btintel_read_version_tlv(struct hci_dev *hdev, struct
> > > +intel_version_tlv *version) {
> > > +	struct sk_buff *skb;
> > > +	const u8 param[1] =3D { 0xFF };
> > > +
> > > +	if (!version)
> > > +		return -EINVAL;
> > > +
> > > +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> > > +	if (IS_ERR(skb)) {
> > > +		bt_dev_err(hdev, "Reading Intel version information failed
> > > (%ld)",
> > > +			   PTR_ERR(skb));
> > > +		return PTR_ERR(skb);
> > > +	}
> > > +
> > > +	if (skb->data[0]) {
> > > +		bt_dev_err(hdev, "Intel Read Version command failed
> > > (%02x)",
> > > +			   skb->data[0]);
> > > +		kfree_skb(skb);
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	/* Consume Command Complete Status field */
> > > +	skb_pull(skb, 1);
> > > +
> > > +	btintel_parse_tlv(skb, version);
> > >
> > >  	kfree_skb(skb);
> > >  	return 0;
> > > diff --git a/drivers/bluetooth/btintel.h
> > > b/drivers/bluetooth/btintel.h index 09346ae308eb..952da44b79de
> > > 100644
> > > --- a/drivers/bluetooth/btintel.h
> > > +++ b/drivers/bluetooth/btintel.h
> > > @@ -132,6 +132,15 @@ struct intel_debug_features {
> > >  	__u8    page1[16];
> > >  } __packed;
> > >
> > > +struct btintel_version {
> > > +	bool tlv_format;
> > > +	union {
> > > +		struct intel_version ver; /*Legacy Intel read version*/
> > > +		struct intel_version_tlv ver_tlv;
> > > +	};
> > > +} __packed;
> > > +
> > > +#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) &
> > 0x003f0000) >> 16))
> > >  #if IS_ENABLED(CONFIG_BT_INTEL)
> > >
> > >  int btintel_check_bdaddr(struct hci_dev *hdev); @@ -151,6 +160,7 @@
> > > int btintel_set_event_mask(struct hci_dev *hdev, bool debug);  int
> > > btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);  int
> > > btintel_read_version(struct hci_dev *hdev, struct intel_version
> > > *ver); int btintel_read_version_tlv(struct hci_dev *hdev, struct
> > > intel_version_tlv *ver);
> > > +int btintel_read_version_new(struct hci_dev *hdev, struct
> > > +btintel_version *ver);
> > >
> > >  struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16
> > opcode_read,
> > >  				   u16 opcode_write);
> > > @@ -248,6 +258,12 @@ static inline int
> > > btintel_read_version_tlv(struct hci_dev *hdev,
> > >  	return -EOPNOTSUPP;
> > >  }
> > >
> > > +static inline int btintel_read_version_new(struct hci_dev *hdev,
> > > +					   struct btintel_version *ver) {
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +
> > >  static inline struct regmap *btintel_regmap_init(struct hci_dev *hde=
v,
> > >  						 u16 opcode_read,
> > >  						 u16 opcode_write)
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 1005b6e8ff74..c63bc8a0c84f 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -2554,7 +2554,8 @@ static int
> > > btusb_intel_download_firmware(struct
> > > hci_dev *hdev,  static int btusb_setup_intel_new(struct hci_dev *hdev=
)  {
> > >  	struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > -	struct intel_version ver;
> > > +	struct btintel_version bt_ver;
> > > +	u8 hw_variant;
> > >  	struct intel_boot_params params;
> > >  	u32 boot_param;
> > >  	char ddcname[64];
> > > @@ -2577,19 +2578,33 @@ static int btusb_setup_intel_new(struct
> > > hci_dev
> > > *hdev)
> > >  	 * is in bootloader mode or if it already has operational firmware
> > >  	 * loaded.
> > >  	 */
> > > -	err =3D btintel_read_version(hdev, &ver);
> > > +	err =3D btintel_read_version_new(hdev, &bt_ver);
> > >  	if (err) {
> > >  		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> > >  		btintel_reset_to_bootloader(hdev);
> > >  		return err;
> > >  	}
> > >
> > > -	err =3D btusb_intel_download_firmware(hdev, &ver, &params,
> > > &boot_param);
> > > +	/* If TLV format is supported then it is in Operational Firmware. T=
LV
> > > +	 * structure is supported only in operational mode in latest
> > > Firmware.
> > > +	 */
> > > +	if (bt_ver.tlv_format && bt_ver.ver_tlv.img_type =3D=3D 0x03) {
> > > +		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
> > > +		clear_bit(BTUSB_BOOTLOADER, &data->flags);
> > > +		goto finish;
> > > +	}
> > > +
> > > +	err =3D btusb_intel_download_firmware(hdev, &bt_ver.ver,  &params,
> > > +					    &boot_param);
> > >  	if (err)
> > >  		return err;
> > >
> > > -	/* controller is already having an operational firmware */
> > > -	if (ver.fw_variant =3D=3D 0x23)
> > > +	/* In case if old firmware is used, it should be backward compatibl=
e
> > > +	 * to check for operational firmware. only on latest firmware the
> > > +	 * support for TLV structure is added. so check for tlv is not
> > > +	 * required here.
> > > +	 */
> > > +	if (bt_ver.ver.fw_variant =3D=3D 0x23)
> > >  		goto finish;
> > >
> > >  	rettime =3D ktime_get();
> > > @@ -2641,7 +2656,7 @@ static int btusb_setup_intel_new(struct
> > > hci_dev
> > > *hdev)
> > >
> > >  	clear_bit(BTUSB_BOOTLOADER, &data->flags);
> > >
> > > -	err =3D btusb_setup_intel_new_get_fw_name(&ver, &params,
> > > ddcname,
> > > +	err =3D btusb_setup_intel_new_get_fw_name(&bt_ver.ver, &params,
> > > ddcname,
> > >  						sizeof(ddcname), "ddc");
> > >
> > >  	if (!err) {
> > > @@ -2665,17 +2680,25 @@ static int btusb_setup_intel_new(struct
> > > hci_dev
> > > *hdev)
> > >  	btintel_set_debug_features(hdev, &features);
> > >
> > >  	/* Read the Intel version information after loading the FW  */
> > > -	err =3D btintel_read_version(hdev, &ver);
> > > +	err =3D btintel_read_version_new(hdev, &bt_ver);
> > >  	if (err)
> > >  		return err;
> > >
> > > -	btintel_version_info(hdev, &ver);
> > > +	if (bt_ver.tlv_format)
> > > +		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
> > > +	else
> > > +		btintel_version_info(hdev, &bt_ver.ver);
> > >
> > >  finish:
> > >  	/* All Intel controllers that support the Microsoft vendor
> > >  	 * extension are using 0xFC1E for VsMsftOpCode.
> > >  	 */
> > > -	switch (ver.hw_variant) {
> > > +	if (!bt_ver.tlv_format)
> > > +		hw_variant =3D bt_ver.ver.hw_variant;
> > > +	else
> > > +		hw_variant =3D INTEL_HW_VARIANT(bt_ver.ver_tlv.cnvi_bt);
> > > +
> > > +	switch (hw_variant) {
> > >  	case 0x12:	/* ThP */
> > >  		hci_set_msft_opcode(hdev, 0xFC1E);
> > >  		break;
> > > --
> > > 2.17.1
> >
> > Gentle reminder
> >
> > Regards
> > Sathish N
>=20
> Gentle reminder
>=20
> Regards
> Sathish N

Please help to review the patches

Regards
Sathish N
