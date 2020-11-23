Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD658C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 03:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADD82074B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 03:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="InkR4na3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgKWDzQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Nov 2020 22:55:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:56417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbgKWDzP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Nov 2020 22:55:15 -0500
IronPort-SDR: WZbw+IYXHwtaO06h2f0JWiKcFlhj0M0n5AGRq4L7ePmxaOhszRx9yHJXSv1Zh1eBP5T3WxpHjD
 fSTQN2mwBCrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="171793367"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="171793367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 19:55:13 -0800
IronPort-SDR: HkLV75RsC0KHwqLVVl5p56n8qV2/e8YbmmwHQ1e0yk1Y5QifQF4ZKNjvleLmznzC0i6eeyhsyD
 1pa4gYftWWtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="332047050"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2020 19:55:13 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Nov 2020 19:55:13 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 22 Nov 2020 19:55:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 22 Nov 2020 19:55:12 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 22 Nov 2020 19:55:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtP4QrOHWN0ll/rB0TheJ0r5F9iT0tQVnViNU3i3qPmMm31WUiWgTubyCU808wpatCcj37xxOKX9GIULJrVt+rQNkQftY74Jq/1p5sJit7qPJk80ZNukD3IRztamuMSD7eZvNgTifreDsk+ZW61mWdQOuZdkP9oGuyJUkCcAxc0wJjfiY7awfI1emkQ3dKPl2noXoXQVT2B/dSVKewt7VbtiadnGTMwfORb1lOzJvNYwPdGCZrpssc81AQJEznkN2jr07waMIfEGVmwiHLPd0IHuD9BvGvMYOK0gew+XOSqfy2zos+XAYYksXUGSu6P73I0ltQOcs+h+vAna6Z+xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe7Dggoyy+ZZdzA8ig0blpDbupvSAaqTFV7NpPD2VZA=;
 b=WOIP3H2rya3u5qbZBnxA6Ew/WzsbM2iuXMvbm9w+R1K5LooeYeYhEE4pPnkUsRrdWTWAlo5aderEyRogdLNDjLTYG1yIx7hdstvg8k5gD65ZZMOV6hmlAq7wQVnjk79jq8L71idLcr90Uqvd/aXj19LEvU3/0OS77xLgPljy942gz21XjNftntConCv2LisVFlnXA7Av7p3rKcvKBr1VTNAO37NnSN2wluHPGs3xnqbRrZxpM712B8q+baU9ZFZw23N/h24kbPGYYVrFumepSEOoLDtPZPcsqK9toeQbYvwXWYfKhBkyrMDg337x5yFYwWm6UM9RboliTdocCFuGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe7Dggoyy+ZZdzA8ig0blpDbupvSAaqTFV7NpPD2VZA=;
 b=InkR4na3kQqyw9Fo6HkaBHul4HvFC3/9DRUlkWJUQaj7FH8GZNmlTdEmtnE7CJiTVQ0o0FmscHjjkYkRFnd0cJFgq61b544Ux7goyOlJQ6ea4BetB1/j3cJ4Mi9kPEJ2rGbbo+BJpqqUdkCvkLeOxLZAsdJJcGuaV0kvU/E4R3o=
Received: from SN6PR11MB2703.namprd11.prod.outlook.com (2603:10b6:805:59::18)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 03:55:11 +0000
Received: from SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::18b:82ac:74c7:126a]) by SN6PR11MB2703.namprd11.prod.outlook.com
 ([fe80::18b:82ac:74c7:126a%5]) with mapi id 15.20.3541.028; Mon, 23 Nov 2020
 03:55:11 +0000
From:   "Narasimman, Sathish" <sathish.narasimman@intel.com>
To:     "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
CC:     "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>
Subject: RE: [PATCH v3] Bluetooth: btintel parse TLV structure
Thread-Topic: [PATCH v3] Bluetooth: btintel parse TLV structure
Thread-Index: AQHWtB1rM6CQhzntHkOiqKGk6aUoPKnLvmXAgAlx94A=
Date:   Mon, 23 Nov 2020 03:55:10 +0000
Message-ID: <SN6PR11MB27032D732BABC78757CAEC3A94FC0@SN6PR11MB2703.namprd11.prod.outlook.com>
References: <20201106092119.20486-1-sathish.narasimman@intel.com>
 <SN6PR11MB27034462DA5BA784215D760794E20@SN6PR11MB2703.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB27034462DA5BA784215D760794E20@SN6PR11MB2703.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [60.243.48.142]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc24200e-619d-4a02-f6fc-08d88f6393ae
x-ms-traffictypediagnostic: SA2PR11MB5212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5212A1222AA4D1F58184F5E594FC0@SA2PR11MB5212.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YKJD6yzqE0CC15e/wF8ZFchDJdNVtc+e/mOwt05Kb2Or4J+erZOVkw7uZ8XNwImaPF7CwWIgFCUrI1TSDYocQ6JCu+szL5D4RTCrbTexqtvpGytPR36blk38KVfNnKeAccLkmnYJFDU+a3AuoWN9CrXf5IEFQ3lnzbEiQpHAgXXKE3Fqy+h7RUOheN3G8AwVjH+Y16vGplgokQR+bgoVqFYw67S1pt6u6Vb+AYyUDZC1rpJ9BE7up5W/Ocfp60Sk5B85iWmcK5ZYzibrFmeEavKC5JLUvSH1OIRmYPEWzSpFCLte80Se60HXTNcm7JLGvAVQXgKFdoo8JO78ugOq15pgIM6tzaRuqIT26TAR/2W8n7trD97F7Hqw9kN5Y4zI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(66446008)(76116006)(86362001)(26005)(8936002)(316002)(4326008)(71200400001)(7696005)(2906002)(5660300002)(30864003)(33656002)(83380400001)(8676002)(53546011)(6506007)(186003)(55016002)(66946007)(52536014)(54906003)(478600001)(9686003)(107886003)(45080400002)(6916009)(66556008)(64756008)(66476007)(491001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: eK+de0upRMN81lWMoKSkNRQLb5J6b5XKAhWhd1y+3fKqZfq22cuOrbmP0IRPPaZJe/uOzSurfnvq9pHvQCPT3svgB+pD3FonG+5lFXmNcnSUY8qmDIgLQq7AYH7c1CgCVfVZP2viHo6aWKq7O/5ev7WOx/jt4g66HeH4o4j0wnVX3X0ZSSYQvH7TzVR+41T0O5KgaxgLGAsiXykEz830rOXW+iFlgiNbYARt4FlArBu83pll2LpxdMju+kTrOMViQcoVRrUjfpsTNm4bI4T3b2x5UPdCxSX4qiCJ06E3R3+WLFoiPye3pPv2vCtLjcmEbekYiArUcMFeRSuHE3YRzNJaIBOq28uIa+Cs1iM8MAyw8wV7zaWJJta8Roe/UiIqEwEDd5gHiOScFt3bqmu2bNLfiw16lqzYqosUfzOoHnkhk1qGr8uQjhiSmTElkUO/QSoxBw3dmxkZvSWObKQNAMgagxE4TNyZX9/kQF+xCt3B/iQ/MqSs8gXaIrWB8R1QpqrdWECvBBLnViUSb7Xa01H3sW03hXAi5eEn2GSv17URsiWBXvRlEdU3s6m32Eft8uVL5abW0QgCsHJQMnZNyFljbHPYR+uNXtnbQsyuEzF/02WIZcFhQvba9vnLfDimec3imVbFDx6PKegqIVwGug==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc24200e-619d-4a02-f6fc-08d88f6393ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 03:55:11.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJ/M8QiwWrUhXChQkqa/IOnuvhPinB4re/Y+k5A45Eh+WUHLM3ecC+EmYIS5h4TF21aHiGUk5u4ndzeShAbFtlfQyEBa+n378AMVc0kDFUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

> -----Original Message-----
> From: Narasimman, Sathish
> Sent: Tuesday, November 17, 2020 9:11 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>;
> Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran
> <kiran.k@intel.com>
> Subject: RE: [PATCH v3] Bluetooth: btintel parse TLV structure
>=20
> Hi
>=20
> > -----Original Message-----
> > From: Narasimman, Sathish <sathish.narasimman@intel.com>
> > Sent: Friday, November 6, 2020 2:51 PM
> > To: linux-bluetooth@vger.kernel.org
> > Cc: Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>;
> > Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Narasimman,
> > Sathish <sathish.narasimman@intel.com>
> > Subject: [PATCH v3] Bluetooth: btintel parse TLV structure
> >
> > Latest intel firmware supports TLV structure in operational mode for
> > intel read version. so made changes accordingly to support both
> > bootloader and operational mode . These changes are only to specific
> > intel bluetooth controller for example ThP, CcP.
> >
> > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > ---
> >  drivers/bluetooth/btintel.c | 105
> > +++++++++++++++++++++++++++---------
> >  drivers/bluetooth/btintel.h |  16 ++++++
> >  drivers/bluetooth/btusb.c   |  41 ++++++++++----
> >  3 files changed, 129 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index
> > 88ce5f0ffc4b..67267afc83e1 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -401,31 +401,9 @@ void btintel_version_info_tlv(struct hci_dev
> > *hdev, struct intel_version_tlv *ve  }
> > EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
> >
> > -int btintel_read_version_tlv(struct hci_dev *hdev, struct
> > intel_version_tlv
> > *version)
> > +static void btintel_parse_tlv(struct sk_buff *skb,
> > +			      struct intel_version_tlv *version)
> >  {
> > -	struct sk_buff *skb;
> > -	const u8 param[1] =3D { 0xFF };
> > -
> > -	if (!version)
> > -		return -EINVAL;
> > -
> > -	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> > -	if (IS_ERR(skb)) {
> > -		bt_dev_err(hdev, "Reading Intel version information failed
> > (%ld)",
> > -			   PTR_ERR(skb));
> > -		return PTR_ERR(skb);
> > -	}
> > -
> > -	if (skb->data[0]) {
> > -		bt_dev_err(hdev, "Intel Read Version command failed
> > (%02x)",
> > -			   skb->data[0]);
> > -		kfree_skb(skb);
> > -		return -EIO;
> > -	}
> > -
> > -	/* Consume Command Complete Status field */
> > -	skb_pull(skb, 1);
> > -
> >  	/* Event parameters contatin multiple TLVs. Read each of them
> >  	 * and only keep the required data. Also, it use existing legacy
> >  	 * version field like hw_platform, hw_variant, and fw_variant @@ -
> > 496,6 +474,85 @@ int btintel_read_version_tlv(struct hci_dev *hdev,
> > struct intel_version_tlv *ver
> >  		/* consume the current tlv and move to next*/
> >  		skb_pull(skb, tlv->len + sizeof(*tlv));
> >  	}
> > +}
> > +
> > +int btintel_read_version_new(struct hci_dev *hdev, struct
> > +btintel_version *ver) {
> > +	struct sk_buff *skb;
> > +	struct intel_version *version =3D &ver->ver;
> > +	const u8 param[1] =3D { 0xFF };
> > +
> > +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		bt_dev_err(hdev, "Reading Intel version info failed (%ld)",
> > +			   PTR_ERR(skb));
> > +		return PTR_ERR(skb);
> > +	}
> > +
> > +	if (skb->data[0]) {
> > +		bt_dev_err(hdev, "Intel Read Version command failed
> > (%02x)",
> > +			   skb->data[0]);
> > +		kfree_skb(skb);
> > +		return -EIO;
> > +	}
> > +
> > +	/* The new Intel read version is backward compatible for Thp and
> > CcP
> > +	 * type cards. when the controller is in bootloader mode the
> > controller
> > +	 * response remains same as old intel_read version. For ThP/CcP
> > cards
> > +	 * TLV structure supports only during the Operation Mode. The best
> > way
> > +	 * to differentiate the read_version response is to check the length
> > +	 * parameter and the first byte of the payload, which is a fixed valu=
e.
> > +	 * After the status parameter if the payload starts with 0x37(This is
> > +	 * a fixed value) and length of the payload is 10 then it is identifi=
ed
> > +	 * as legacy struct intel_version. In the latest firmware the support
> > +	 * of TLV structure is added during Operational Firmware.
> > +	 */
> > +	if (skb->len =3D=3D sizeof(*version) && skb->data[1] =3D=3D 0x37) {
> > +		memcpy(version, skb->data, sizeof(*version));
> > +		ver->tlv_format =3D false;
> > +		goto finish;
> > +	}
> > +
> > +	/* Consume Command Complete Status field */
> > +	skb_pull(skb, 1);
> > +
> > +	ver->tlv_format =3D true;
> > +
> > +	bt_dev_info(hdev, "Parsing TLV Supported intel read version");
> > +	btintel_parse_tlv(skb, &ver->ver_tlv);
> > +
> > +finish:
> > +	kfree_skb(skb);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(btintel_read_version_new);
> > +
> > +int btintel_read_version_tlv(struct hci_dev *hdev, struct
> > +intel_version_tlv *version) {
> > +	struct sk_buff *skb;
> > +	const u8 param[1] =3D { 0xFF };
> > +
> > +	if (!version)
> > +		return -EINVAL;
> > +
> > +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		bt_dev_err(hdev, "Reading Intel version information failed
> > (%ld)",
> > +			   PTR_ERR(skb));
> > +		return PTR_ERR(skb);
> > +	}
> > +
> > +	if (skb->data[0]) {
> > +		bt_dev_err(hdev, "Intel Read Version command failed
> > (%02x)",
> > +			   skb->data[0]);
> > +		kfree_skb(skb);
> > +		return -EIO;
> > +	}
> > +
> > +	/* Consume Command Complete Status field */
> > +	skb_pull(skb, 1);
> > +
> > +	btintel_parse_tlv(skb, version);
> >
> >  	kfree_skb(skb);
> >  	return 0;
> > diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> > index 09346ae308eb..952da44b79de 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -132,6 +132,15 @@ struct intel_debug_features {
> >  	__u8    page1[16];
> >  } __packed;
> >
> > +struct btintel_version {
> > +	bool tlv_format;
> > +	union {
> > +		struct intel_version ver; /*Legacy Intel read version*/
> > +		struct intel_version_tlv ver_tlv;
> > +	};
> > +} __packed;
> > +
> > +#define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) &
> 0x003f0000) >> 16))
> >  #if IS_ENABLED(CONFIG_BT_INTEL)
> >
> >  int btintel_check_bdaddr(struct hci_dev *hdev); @@ -151,6 +160,7 @@
> > int btintel_set_event_mask(struct hci_dev *hdev, bool debug);  int
> > btintel_set_event_mask_mfg(struct hci_dev *hdev, bool debug);  int
> > btintel_read_version(struct hci_dev *hdev, struct intel_version *ver);
> > int btintel_read_version_tlv(struct hci_dev *hdev, struct
> > intel_version_tlv *ver);
> > +int btintel_read_version_new(struct hci_dev *hdev, struct
> > +btintel_version *ver);
> >
> >  struct regmap *btintel_regmap_init(struct hci_dev *hdev, u16
> opcode_read,
> >  				   u16 opcode_write);
> > @@ -248,6 +258,12 @@ static inline int btintel_read_version_tlv(struct
> > hci_dev *hdev,
> >  	return -EOPNOTSUPP;
> >  }
> >
> > +static inline int btintel_read_version_new(struct hci_dev *hdev,
> > +					   struct btintel_version *ver)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static inline struct regmap *btintel_regmap_init(struct hci_dev *hdev,
> >  						 u16 opcode_read,
> >  						 u16 opcode_write)
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 1005b6e8ff74..c63bc8a0c84f 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2554,7 +2554,8 @@ static int btusb_intel_download_firmware(struct
> > hci_dev *hdev,  static int btusb_setup_intel_new(struct hci_dev *hdev) =
 {
> >  	struct btusb_data *data =3D hci_get_drvdata(hdev);
> > -	struct intel_version ver;
> > +	struct btintel_version bt_ver;
> > +	u8 hw_variant;
> >  	struct intel_boot_params params;
> >  	u32 boot_param;
> >  	char ddcname[64];
> > @@ -2577,19 +2578,33 @@ static int btusb_setup_intel_new(struct
> > hci_dev
> > *hdev)
> >  	 * is in bootloader mode or if it already has operational firmware
> >  	 * loaded.
> >  	 */
> > -	err =3D btintel_read_version(hdev, &ver);
> > +	err =3D btintel_read_version_new(hdev, &bt_ver);
> >  	if (err) {
> >  		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> >  		btintel_reset_to_bootloader(hdev);
> >  		return err;
> >  	}
> >
> > -	err =3D btusb_intel_download_firmware(hdev, &ver, &params,
> > &boot_param);
> > +	/* If TLV format is supported then it is in Operational Firmware. TLV
> > +	 * structure is supported only in operational mode in latest
> > Firmware.
> > +	 */
> > +	if (bt_ver.tlv_format && bt_ver.ver_tlv.img_type =3D=3D 0x03) {
> > +		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
> > +		clear_bit(BTUSB_BOOTLOADER, &data->flags);
> > +		goto finish;
> > +	}
> > +
> > +	err =3D btusb_intel_download_firmware(hdev, &bt_ver.ver,  &params,
> > +					    &boot_param);
> >  	if (err)
> >  		return err;
> >
> > -	/* controller is already having an operational firmware */
> > -	if (ver.fw_variant =3D=3D 0x23)
> > +	/* In case if old firmware is used, it should be backward compatible
> > +	 * to check for operational firmware. only on latest firmware the
> > +	 * support for TLV structure is added. so check for tlv is not
> > +	 * required here.
> > +	 */
> > +	if (bt_ver.ver.fw_variant =3D=3D 0x23)
> >  		goto finish;
> >
> >  	rettime =3D ktime_get();
> > @@ -2641,7 +2656,7 @@ static int btusb_setup_intel_new(struct hci_dev
> > *hdev)
> >
> >  	clear_bit(BTUSB_BOOTLOADER, &data->flags);
> >
> > -	err =3D btusb_setup_intel_new_get_fw_name(&ver, &params,
> > ddcname,
> > +	err =3D btusb_setup_intel_new_get_fw_name(&bt_ver.ver, &params,
> > ddcname,
> >  						sizeof(ddcname), "ddc");
> >
> >  	if (!err) {
> > @@ -2665,17 +2680,25 @@ static int btusb_setup_intel_new(struct
> > hci_dev
> > *hdev)
> >  	btintel_set_debug_features(hdev, &features);
> >
> >  	/* Read the Intel version information after loading the FW  */
> > -	err =3D btintel_read_version(hdev, &ver);
> > +	err =3D btintel_read_version_new(hdev, &bt_ver);
> >  	if (err)
> >  		return err;
> >
> > -	btintel_version_info(hdev, &ver);
> > +	if (bt_ver.tlv_format)
> > +		btintel_version_info_tlv(hdev, &bt_ver.ver_tlv);
> > +	else
> > +		btintel_version_info(hdev, &bt_ver.ver);
> >
> >  finish:
> >  	/* All Intel controllers that support the Microsoft vendor
> >  	 * extension are using 0xFC1E for VsMsftOpCode.
> >  	 */
> > -	switch (ver.hw_variant) {
> > +	if (!bt_ver.tlv_format)
> > +		hw_variant =3D bt_ver.ver.hw_variant;
> > +	else
> > +		hw_variant =3D INTEL_HW_VARIANT(bt_ver.ver_tlv.cnvi_bt);
> > +
> > +	switch (hw_variant) {
> >  	case 0x12:	/* ThP */
> >  		hci_set_msft_opcode(hdev, 0xFC1E);
> >  		break;
> > --
> > 2.17.1
>=20
> Gentle reminder
>=20
> Regards
> Sathish N

Gentle reminder

Regards
Sathish N

