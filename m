Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C57BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AB720760
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="K0wHeUcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgGBRYR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:24:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:26787 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgGBRYR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 13:24:17 -0400
IronPort-SDR: lzxIlYem1C2jE5FpQXUKrufeDhMeTBXLA6z2sD5QJLNRBUH4PPhN43xwbE9994naY8E9d4I0Ht
 CArKCKPu4idw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="212014811"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="212014811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 10:24:16 -0700
IronPort-SDR: u6C72pysQ3Kk/b6iNfvek/e+1iKwPfxfJFigTZabkV3jlrILFjmTm8hEOBMKq9FrAwPN0O/mSL
 iPYo78WQmZfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="313088323"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2020 10:24:16 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 10:24:15 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 10:24:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Jul 2020 10:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSnbhzIfKUIOMA6bpV4O9wnypbIftNq1lEz4eUelCOGJkYNPzvvBufHz8fE6q8fjSeZs5eQvCY09Qptyhn9aCQ1VA4wdH8EsOoFP7XlLUfZj9SskS5aI1W8YXIbt+25DqCgoE0EMKNkk2LZWH3C8WDAkdv1TyFelE3GXcTRb4HEGndRNWGsD0UThClU9S5YRhmeA8xXHKgJbv/sv0gYcix4eS5kefGxeb1ZJnDc/U09XUSqt5v5qvAr7zFDWMbSQtDr8sEA/YTdXTHjEV/HYMcD3h9fkQaBWAdLYecNlkCrSUGD7Ika/gm1tLmgtusdpDMVF7wyIZZSptboEhRkbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a09VmOj/5WsnV84MDFG3n6Y+fFOmBkorq5drbILtQ6k=;
 b=QHqI6TO3GzEbFUSAQWYtosxZwADmgOF5LhAaPpgrL9nQkifpK5wXK6iYsiA//Tbsm2gm++bwY/zqcbCdL2YDLoD1awWPdwMD/Cppx0Tc82o3a4ygZhHg36NuGFsTwIDew93rHtr47xEBjPk+j5m8XUoEX94LXLnvU5cs9Go4dCZ/WD2WQmBdOl07mug5YxCmFCS/Sx54Hy//hvSN9Urv7S9WK8MkipM9l9m22jN2vV+6UexOikbpm90eZWEejp6Pl1Rfy/ANd47PwzeEZrjSPuLoR0Ag/PYYRtCWU2QOSfMtYq2FP8kCuNaY52iabbxuqLU7IxnEMtIIhheysNrgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a09VmOj/5WsnV84MDFG3n6Y+fFOmBkorq5drbILtQ6k=;
 b=K0wHeUcvbc/MaqjTVTKXB3iBssTowmXcb7bLf6V8Rda6J7ZvDuv05br14G1Kin+N6WTzjp29TeMIt+lgdGEo9t+K+gjBoF0K2ch3yd/kiLZiN13n07B8/0FPyz7zGTHOIHWW8p3rjLskb+PpPvMG/3/tGiTGAPeM9anaPaq5Pmg=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BYAPR11MB2709.namprd11.prod.outlook.com (2603:10b6:a02:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Thu, 2 Jul
 2020 17:24:13 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f%5]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 17:24:13 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "kiraank@gmail.com" <kiraank@gmail.com>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: RE: [PATCH 5/5] Bluetooth: btintel: Parse controller information
 present in TLV format
Thread-Topic: [PATCH 5/5] Bluetooth: btintel: Parse controller information
 present in TLV format
Thread-Index: AQHWUGinV5pHoaB/c0WTx+kkMcqVYKj0SiIAgAA/QpA=
Date:   Thu, 2 Jul 2020 17:24:13 +0000
Message-ID: <BYAPR11MB314181852BC86CF78A9E54B2F56D0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <20200702120315.26768-1-kiran.k@intel.com>
 <20200702120315.26768-6-kiran.k@intel.com>
 <0CCCE1DA-3700-4B8C-A75B-D98D07F51782@holtmann.org>
In-Reply-To: <0CCCE1DA-3700-4B8C-A75B-D98D07F51782@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.79.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 684e5e96-e2a5-4a43-4f8c-08d81eacbd53
x-ms-traffictypediagnostic: BYAPR11MB2709:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB270901584C1B6A1839BBC413F56D0@BYAPR11MB2709.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APenwBCz8T0oWUAoT3iJ1cokZpOkP0x77PBM8IB1JbftFh8sR7QPzFUWellX1+rvKuYPUPj1p1ScI6oamBf42lzGQEacKAL7++UOq7aclg3z6ywlLOQx+kb+d+IgjjvgwskIPI8XfyiV1uhh95uXznmglaC86O/btHa8Ep5DxrBnJ00HsO5PrvlRccGw5NhfYq2WoUYCOg3HG5lanAauLRqB/eu9HV0DyrVXHNzMee9C4QnumF9X6qS1Pbnsu64ThWqJ+iPIMJE3LCfG06p19GEPy+4jkMZTZ4Cq+L5CxImo14wQqoGsi/h5aYe6RPRc3J5qy54M8sfaVKLycRQgIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(7696005)(76116006)(54906003)(8676002)(66946007)(55016002)(66446008)(2906002)(9686003)(5660300002)(6916009)(64756008)(66556008)(107886003)(66476007)(52536014)(478600001)(316002)(4326008)(71200400001)(53546011)(6506007)(83380400001)(33656002)(86362001)(26005)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hxyyFCMpOzZMb5rlxPkEFv3eo7JCQMTfN9aCfRh2MwwYtn7fEHJfpEJteYmBnwLjM+18xGSvlYPh4oKY7iRh9fuxiCdM4VGrfD7oshAMNfbYT3Y+cZ/a33A6igqs2Iz7YW7kMfWPFPKQROQniYq5U+o7B+yrml0wZp/OpApuk7a6Fu5xjh/0MqS/EN1xNxWwGTTKXP36lnEqOfQGo1sexgeN2bfDe6x8UJTeezLHYWLpQbVPd9xTktQRnMCGItHgL16l1Xkq+NDaWrHVJH7Cts5lkwVMCsYWCedohs2HW72T/ku8+2lqsuB+utR7VaZh6IFyMLDuANFIo3BnIdJzSavdpu531vl9c9LElsb+nOJAOCvMBpD6DuSWwCPa90qyGs9EF5ALfJTie4/Hst04/Uin2h8ETauThzFS7sjDI+oF3Y2MTho0Nrcqx7oijfREOcPt+FA2lrJUJ7PAz0zmTJpLweil93Uc5PmXDmnMjHo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684e5e96-e2a5-4a43-4f8c-08d81eacbd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 17:24:13.0368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9gBTWVWuEbeAabV2L8C55dtI85YdsgXb/rj8c6Noh3jYeCavg58SyJD4gLrTEE6h/p9gIHaZFUr9fWC6K6Opg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2709
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org <linux-bluetooth-
> owner@vger.kernel.org> On Behalf Of Marcel Holtmann
> Sent: Thursday, July 2, 2020 7:04 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishan=
kar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; kiraank@gmail.com; Bag, Amit K
> <amit.k.bag@intel.com>; Raghuram Hegde <raghuram.hegde@intel.com>
> Subject: Re: [PATCH 5/5] Bluetooth: btintel: Parse controller information
> present in TLV format
>=20
> Hi Kiran,
>=20
> > New generation Intel controllers returns controller information in TLV
> > format. Adding capability to parse and log it for debug purpose
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> > Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 161 ++++++++++++++++++++++++++++++++----
> > drivers/bluetooth/btusb.c   |   4 +-
> > 2 files changed, 148 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index d0c6576212d7..f0b087d97a83 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -209,27 +209,59 @@ void btintel_version_info(struct hci_dev *hdev,
> > const struct btintel_version *ve {
> > 	const char *variant;
> > 	const struct intel_version *ver;
> > +	const struct intel_version_tlv *ver_tlv;
> >
> > -	if (version->is_tlv_supported)
> > -		return;
> > +	if (!version->is_tlv_supported) {
> > +		ver =3D &version->intel_version;
> > +
> > +		switch (ver->fw_variant) {
> > +		case 0x06:
> > +			variant =3D "Bootloader";
> > +		break;
>=20
> The break; has to be indented with the variant =3D.

Ack.  checkpatch.pl didn't report any warning/error for this issue :(.  I w=
ill fix it in the next patch.
>=20
> > +		case 0x23:
> > +			variant =3D "Firmware";
> > +		break;
> > +		default:
> > +			goto done;
> > +		}
> >
> > -	ver =3D &version->intel_version;
> > +		bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
> > +			    variant, ver->fw_revision >> 4,
> > +			    ver->fw_revision & 0x0f, ver->fw_build_num,
> > +			    ver->fw_build_ww, 2000 + ver->fw_build_yy);
> > +		goto done;
> > +	}
> > +
> > +	ver_tlv =3D &version->intel_version_tlv;
> >
> > -	switch (ver->fw_variant) {
> > -	case 0x06:
> > +	switch (ver_tlv->img_type) {
> > +	case 0x01:
> > 		variant =3D "Bootloader";
> > -		break;
> > -	case 0x23:
> > +		bt_dev_info(hdev, "Device revision is %u", ver_tlv-
> >dev_rev_id);
> > +		bt_dev_info(hdev, "Secure boot is %s",
> > +			    ver_tlv->secure_boot ? "enabled" : "disabled");
> > +		bt_dev_info(hdev, "OTP lock is %s",
> > +			    ver_tlv->otp_lock ? "enabled" : "disabled");
> > +		bt_dev_info(hdev, "API lock is %s",
> > +			    ver_tlv->api_lock ? "enabled" : "disabled");
> > +		bt_dev_info(hdev, "Debug lock is %s",
> > +			    ver_tlv->debug_lock ? "enabled" : "disabled");
> > +		bt_dev_info(hdev, "Minimum firmware build %u week %u
> %u",
> > +			    ver_tlv->min_fw_build_nn, ver_tlv-
> >min_fw_build_cw,
> > +			    2000 + ver_tlv->min_fw_build_yy);
> > +	break;
> > +	case 0x03:
> > 		variant =3D "Firmware";
> > -		break;
> > +	break;
> > 	default:
> > -		return;
> > +		goto done;
> > 	}
> >
> > -	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
> > -		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
> > -		    ver->fw_build_num, ver->fw_build_ww,
> > -		    2000 + ver->fw_build_yy);
> > +	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u",
> variant,
> > +		    2000 + (ver_tlv->timestamp >> 8), ver_tlv->timestamp & 0xff,
> > +		    ver_tlv->build_type, ver_tlv->build_num);
> > +done:
> > +	return;
> > }
> > EXPORT_SYMBOL_GPL(btintel_version_info);
> >
> > @@ -346,6 +378,8 @@ int btintel_read_version(struct hci_dev *hdev,
> > struct btintel_version *version) {
> > 	struct sk_buff *skb;
> > 	u8 *data, param, status, check_tlv;
> > +	struct intel_version_tlv *ver_tlv;
> > +	struct intel_tlv *tlv;
> >
> > 	if (!version)
> > 		return -EINVAL;
> > @@ -373,9 +407,106 @@ int btintel_read_version(struct hci_dev *hdev,
> struct btintel_version *version)
> > 	if (skb->len =3D=3D sizeof(version->intel_version) && check_tlv =3D=3D=
 0x37) {
> > 		memcpy(&version->intel_version, skb->data, sizeof(version-
> >intel_version));
> > 		version->is_tlv_supported =3D false;
> > -	} else {
> > -		version->is_tlv_supported =3D true;
> > +		goto done;
> > 	}
> > +
> > +	bt_dev_info(hdev, "Supports tlv firmware download sequence");
> > +	version->is_tlv_supported =3D true;
> > +	ver_tlv =3D &version->intel_version_tlv;
> > +
> > +	/* Consume Command Complete Status field */
> > +	skb_pull(skb, 1);
> > +
> > +	/* Event parameters contatin multiple TLVs. Read each of them
> > +	 * and only keep the required data. Also, it use existing legacy
> > +	 * version field like hw_platform, hw_variant, and fw_variant
> > +	 * to keep the existing setup flow
> > +	 */
> > +	while (skb->len) {
> > +		tlv =3D (struct intel_tlv *)skb->data;
> > +		switch (tlv->type) {
> > +		case INTEL_TLV_CNVI_TOP:
> > +			ver_tlv->cnvi_top =3D (tlv->val[3] << 24) |
> > +				(tlv->val[2] << 16) |
> > +				(tlv->val[1] << 8) |
> > +				(tlv->val[0]);
>=20
> We have get_unaligned functions for that.
>=20
Ack.=20
> > +			break;
> > +		case INTEL_TLV_CNVR_TOP:
> > +			ver_tlv->cnvr_top =3D (tlv->val[3] << 24) |
> > +				(tlv->val[2] << 16) |
> > +				(tlv->val[1] << 8) |
> > +				(tlv->val[0]);
> > +			break;
> > +		case INTEL_TLV_CNVI_BT:
> > +			ver_tlv->cnvi_bt =3D (tlv->val[3] << 24) |
> > +				(tlv->val[2] << 16) |
> > +				(tlv->val[1] << 8) |
> > +				(tlv->val[0]);
> > +			break;
> > +		case INTEL_TLV_CNVR_BT:
> > +			ver_tlv->cnvr_bt =3D (tlv->val[3] << 24) |
> > +				(tlv->val[2] << 16) |
> > +				(tlv->val[1] << 8) |
> > +				(tlv->val[0]);
> > +			break;
> > +		case INTEL_TLV_USB_VENDOR_ID:
> > +			ver_tlv->usb_vid =3D (tlv->val[1] << 8) | (tlv->val[0]);
> > +			break;
> > +		case INTEL_TLV_USB_PRODUCT_ID:
> > +			ver_tlv->usb_pid =3D (tlv->val[1] << 8) | (tlv->val[0]);
> > +			break;
> > +		case INTEL_TLV_IMAGE_TYPE:
> > +			ver_tlv->img_type =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_TIME_STAMP:
> > +			ver_tlv->timestamp =3D (tlv->val[1] << 8) | (tlv->val[0]);
> > +			break;
> > +		case INTEL_TLV_BUILD_TYPE:
> > +			ver_tlv->build_type =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_BUILD_NUM:
> > +			ver_tlv->build_num =3D (tlv->val[3] << 24) |
> > +				(tlv->val[2] << 16) |
> > +				(tlv->val[1] << 8) |
> > +				(tlv->val[0]);
> > +			break;
> > +		case INTEL_TLV_SECURE_BOOT:
> > +			ver_tlv->secure_boot =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_KEY_FROM_HDR:
> > +			ver_tlv->key_from_hdr =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_OTP_LOCK:
> > +			ver_tlv->otp_lock =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_API_LOCK:
> > +			ver_tlv->api_lock =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_DEBUG_LOCK:
> > +			ver_tlv->debug_lock =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_MIN_FW:
> > +			ver_tlv->min_fw_build_nn =3D tlv->val[0];
> > +			ver_tlv->min_fw_build_cw =3D tlv->val[1];
> > +			ver_tlv->min_fw_build_yy =3D tlv->val[2];
> > +			break;
> > +		case INTEL_TLV_LIMITED_CCE:
> > +			ver_tlv->limited_cce =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_SBE_TYPE:
> > +			ver_tlv->sbe_type =3D tlv->val[0];
> > +			break;
> > +		case INTEL_TLV_OTP_BDADDR:
> > +			memcpy(&ver_tlv->otp_bd_addr, tlv->val, tlv->len);
> > +			break;
> > +		default:
> > +			/* Ignore rest of information */
> > +			break;
> > +		}
> > +		/* consume the current tlv and move to next*/
> > +		skb_pull(skb, tlv->len + sizeof(*tlv));
> > +	}
> > +done:
> > 	kfree_skb(skb);
> > 	return 0;
> > }
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 364da6d44ee3..f30b43e15a26 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2519,13 +2519,13 @@ static int btusb_setup_intel_new(struct hci_dev
> *hdev)
> > 		return err;
> > 	}
> >
> > +	btintel_version_info(hdev, &version);
> > +
> > 	if (version.is_tlv_supported) {
> > 		bt_dev_err(hdev, "Firmware download in tlv format is not
> supported");
> > 		return -EOPNOTSUPP;
> > 	}
> >
> > -	btintel_version_info(hdev, &version);
> > -
> > 	err =3D btusb_intel_download_firmware(hdev, &version, &params);
> > 	if (err)
> > 		return err;
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran


