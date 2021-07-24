Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AA2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B7A60E96
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 07:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhGXG4a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 02:56:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:7017 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234515AbhGXG43 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 02:56:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="191592542"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="191592542"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 00:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="502991432"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2021 00:37:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sat, 24 Jul 2021 00:37:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sat, 24 Jul 2021 00:37:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sat, 24 Jul 2021 00:37:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSZX1zM3SokbpmNsZENOwF101P5oVaa19QPcy9tJ/1CuFkrSksYrTymzH05UoZtWNJ+eBO7fmNQF96DEu8z1u1keXkXsaeideuPmlS/8warCu1RXQvU+Joi2dkNzYp1VXb3RUZp7hvILS6Gy8AlNc8ADX4sKPIYZBG/xaq38ttGETLenTKnaIjyEshx/A/iYWY0S5xi9QEc9AnEExsH+qpB/mS0Phr3igwYByM5tlC3gQbn+OyXAMpfe+pWgYR226V0KVESOgjAdtP6cPw7DHUPTzSmcyRGDIYYSpccQWqbkZfvxOEBD02+umkshbr5J+d4SQ7mhl7YXg1jZ7cmYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtkvA0dBspYcyoDi3VgOe8nHUMm2V6xKFBIdcgvICCQ=;
 b=cqhgDnz6hR5ffsFh3xM088qZs6doJzYLGQ6iRi3yM2DQZuBKET3/9N11GnewzD24QHmc2dSmenRumTjRXQYTjqk6XIQMACceZ2tCXeHFOLgk0L6M5MeuZLzMXnZ/LDksIR5A5j1AB8bcUiCKNmcI7Ap3b/TZ3JNuKQot1ptXPNzCohMMU5noA1pYiMiaOdVfyWPXq+feUhx7jyUdkthrMekhXKavYFruwIZaIqIZYXnPK0mycWnllVk0yWRV3QrCHBoRQCce2Y4J/FdKoSw/7kSYOGMiyT5ktcaygdeuuFukOilpZyMv6ZB+6ArK8g47Q+k1bxhVG5e/jbJFB547Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtkvA0dBspYcyoDi3VgOe8nHUMm2V6xKFBIdcgvICCQ=;
 b=gDzH+w8sJlYDTrX1EAtwt0mkAfCEMw5i42YjkPYFNPkj9flrFr7XQPB+tfpytg0JrN/ScIXR8JzbMOFia/kY3qj5kGkcQ3ULCg5r7W1RINAwxicYifW6PzmcKpFagaBVE6bxBBG8AVkUxbvD4CbAWJoMnATBvlZkSxghehioltE=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5607.namprd11.prod.outlook.com (2603:10b6:8:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25; Sat, 24 Jul 2021 07:36:55 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10%9]) with mapi id 15.20.4352.029; Sat, 24 Jul 2021
 07:36:55 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "An, Tedd" <tedd.an@intel.com>
Subject: RE: [RFC PATCH v3 2/9] Bluetooth: btintel: Add combined setup and
 shutdown functions
Thread-Topic: [RFC PATCH v3 2/9] Bluetooth: btintel: Add combined setup and
 shutdown functions
Thread-Index: AQHXgF3L+RzzDohG1UGWhLq5awfju6tRvDjg
Date:   Sat, 24 Jul 2021 07:36:55 +0000
Message-ID: <DM8PR11MB55731D7E45AF507134424321F5E69@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210724073005.714003-1-hj.tedd.an@gmail.com>
 <20210724073005.714003-3-hj.tedd.an@gmail.com>
In-Reply-To: <20210724073005.714003-3-hj.tedd.an@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0050cad-5ad7-4727-3555-08d94e75cfb4
x-ms-traffictypediagnostic: DM8PR11MB5607:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5607C9A0060FE2F0A639A6BAF5E69@DM8PR11MB5607.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ElsnKhUoPNXDVLhx59RLL+51fdTp/0ipR36c3bm2B2mNpwRSeWvpygyc2OnPvHKFxg9Gd15IIQ5ZRtDnHkeIG7ZEnw8dqBoIqdk5suV+1VpoChT8or2nQh4gPxYiyLBlRaYwUio6m1zNTC0z04uLQf1H0TI97Jp1/7/xfHbaTvE/v3UE2tFOzfWCxT/lOQq8cpx8aA3APyspCJ1agvo3XFgT7A98kClENYf0CRKzrFbfGR7vVqTdMVSYAj6CGfb4AonkN5FjMasipAmwAUz7+R3w6zPs4RWtn8NyNFmdse0oPe3z+4JPvWOTctUfsgXV/XRLFfhy7I0XDOttipaFglaI5EeJInA5Gtx88of2gXIIRGtbApHCErdbdxItzEntRRIArHggTgqAEXGZj0MgFjz1rePlLMBzlQuAqXgB178CiobuMwNfLfguP2weolCwTuL8sZTpkMbhM82TZL2341hd+IdtZWRTJCE9Lopn0KqB4x3/QZBwihx1DAs3mTCPMlw36xhk2nMCl2bTabJeblEULzLbDdUHu0aln4b2FsXSMzYPti7QkV8K8QXc+djejVNi/1c03AU+Zyj3uaGhW0bCmraxKwhJrxyW4K6yBxQm9egzpeVLDKS6Q3AQTFxcBVgOR1wJc420tVexwpaDF1s+jZflV+K2IGmtXY/ZL52ODtVd6I2fL/jdh+tQIGaABq2mOX41UqL0497EqJ/OO3kIZJWxERlxSDeNC9IATwPPcBpGAjJqMUcpc5aDvzae4T9wVxZ3cYb8ortSQ7rmA4F7omCd229hg6IfYucPdZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(966005)(122000001)(55016002)(4326008)(6506007)(186003)(7696005)(478600001)(66556008)(52536014)(5660300002)(66946007)(83380400001)(66476007)(64756008)(76116006)(107886003)(71200400001)(53546011)(9686003)(316002)(33656002)(8936002)(2906002)(8676002)(110136005)(38100700002)(66446008)(86362001)(30864003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4D6T2GNmOklB7cZ1a3F0yzD0N62/isAEwojj65JzrhEIWtAxr6C5+f03k3oa?=
 =?us-ascii?Q?+V3Y9xVZMQugeBsCeeKp31wRhE3JWLhfqtQABHiAHS4x1OCs0JGo/W0pDcZ1?=
 =?us-ascii?Q?cdJiiHDuD7nVajNcXbmoTiG/R6L61m+ZXcVxiFT0sAJ91z2ivcrIVVv/4w/1?=
 =?us-ascii?Q?GnkMFEO0s0RWV+gAlECMkECW9VojaFfbqDIAz+RrDvuryr5e1KIGi9Cw0EC0?=
 =?us-ascii?Q?xKePMZrorWk+wfHYMp47rOkM+NOk7Gc0sjpnQ9b97jRTQSKmD81abGaReP+j?=
 =?us-ascii?Q?J26ZaQtzmpget+DYwA5zVbRUdzKwOfpAr5UA0sD4xYqTXh+cXNvz3PJJgEAg?=
 =?us-ascii?Q?8zjSnaG3FQkFySuf9Q2wwUIlx75Or1rOTm5TfcxMCd4vepeB88YDvUa+izBk?=
 =?us-ascii?Q?OEIn1NTcbX90w3UCbUl3ziGhje6onpvvZtg9wlrQYVZTDfpklXhyqDi6GU6j?=
 =?us-ascii?Q?5mJwR4tzJXeKPEPbM61LQFUydvdwepzwl3S5Vt930GHOWod4OkWxOdm1C8lm?=
 =?us-ascii?Q?MJmPbu27n3sQA8l0cuoo5qsw9jYRhGpWoldbrkndQUXjUyZWg4Gs6er2hGrw?=
 =?us-ascii?Q?SZt18J0gZJckAdhM9dTnpn+dJaDU9nzTxJe/LeDlmaRt6OFMNpm5lx5F8nv7?=
 =?us-ascii?Q?6sI1lUEheDXIjWKyLG3gXfksOKPZg1OF2WZct4uhwVrFdsRIzSUKCjt2xAwy?=
 =?us-ascii?Q?O2+0xv4Vaqfvlo0tsRQdHxN99gU2nz024MqK8RBcfyYikCP5kJON3WMlyv1r?=
 =?us-ascii?Q?WxjxKRJWVJ6bqyf9VNmpB9Lp9QDa4JqfAyO6CxnBMzQu4ucRpdSW1GQ3o+1s?=
 =?us-ascii?Q?xvK86kB9LFKpUhIIDFLEFFvBALL6bFqy6pNw75y9E2G8IuX94qCYuLsfMQP1?=
 =?us-ascii?Q?khL5ZEltG36UlquyGc9yrDfwabpf85HqZW4JGm5pTLAPVAd83ZF5M45A1JFc?=
 =?us-ascii?Q?xHttuTuD6l7gFaZq7lJFlZI6s5lkyDlwqHfKH25GTO3NvA/52H6ScnZpCqdQ?=
 =?us-ascii?Q?Ce3Nlo9aTZCwQtBqRSDojULf2qeepObQn50Xt5jB8mMUiv7Ki3qudyjxL231?=
 =?us-ascii?Q?tcQl2M8NHlLBgpmdcz/1KNGJB3s0/4NKmlux1QWNYLDxdjKf3paUygORomNt?=
 =?us-ascii?Q?BBO6LNanucuCzzmIcJYqRExcUGmIApZEs5GIVK223AnySeQ/otC0biRquXy+?=
 =?us-ascii?Q?S6lh1BXBIh/2jPRi1xnxoWZtBSCDT9iJcS/M5c3mMk/jX5h2FFKZDN/k5EBR?=
 =?us-ascii?Q?xWYYYUOJohOHGkMmutAg6rfLI/ufc6XZlzu1lmN0FWMCX9XB+TjwS6SZSCL7?=
 =?us-ascii?Q?JA5bvB7WSdA3Mz2b4vEmBNYWR4FPnRplkcfVo9zi+mqjlZU05xanQNUI29SV?=
 =?us-ascii?Q?+Xqw/QI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0050cad-5ad7-4727-3555-08d94e75cfb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2021 07:36:55.1822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VakqN3pg+Ag4x80O2pEPZdq5mOrREwsu5h7pwmVG/tSqeLXKFXzUbEmVV1K61o5743Nsjx8uTQRxy3RS40kOuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5607
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

There is already a patch published to have a generic setup function for RAM=
 products.
https://patchwork.kernel.org/project/bluetooth/patch/20210713032755.19351-1=
-kiran.k@intel.com/

Thanks,
Kiran


> -----Original Message-----
> From: Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
> Sent: Saturday, July 24, 2021 1:00 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: An, Tedd <tedd.an@intel.com>
> Subject: [RFC PATCH v3 2/9] Bluetooth: btintel: Add combined setup and
> shutdown functions
>=20
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>=20
> There are multiple setup and shutdown functions for Intel device and the
> setup function to use is depends on the USB PID/VID, which makes difficul=
t
> to maintain the code and increases the code size.
>=20
> This patch adds combined setup and shutdown functions to provide a single
> entry point for all Intel devices and choose the setup functions based on=
 the
> information read with HCI_Intel_Read_Version command.
>=20
> Starting from TyP device, for HCI_Intel_Read_Version command, the
> command parameter and response are changed even though OCF remains
> same. Luckly the legacy devices still can handle the command without erro=
r
> even if it has a extra parameter, so it uses the new command format to
> support both legacy and new (tlv based) format.
>=20
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 210 ++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |  12 +++
>  2 files changed, 222 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> e44b6993cf91..5513a2ba2504 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -236,6 +236,8 @@ int btintel_version_info(struct hci_dev *hdev, struct
> intel_version *ver)
>  	 * compatibility options when newer hardware variants come along.
>  	 */
>  	switch (ver->hw_variant) {
> +	case 0x07:	/* WP - Legacy ROM */
> +	case 0x08:	/* StP - Legacy ROM */
>  	case 0x0b:      /* SfP */
>  	case 0x0c:      /* WsP */
>  	case 0x11:      /* JfP */
> @@ -250,9 +252,15 @@ int btintel_version_info(struct hci_dev *hdev, struc=
t
> intel_version *ver)
>  	}
>=20
>  	switch (ver->fw_variant) {
> +	case 0x01:
> +		variant =3D "Legacy ROM 2.5";
> +		break;
>  	case 0x06:
>  		variant =3D "Bootloader";
>  		break;
> +	case 0x22:
> +		variant =3D "Legacy ROM 2.x";
> +		break;
>  	case 0x23:
>  		variant =3D "Firmware";
>  		break;
> @@ -483,6 +491,98 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
> struct intel_version_tlv *ver  }
> EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
>=20
> +static int btintel_parse_version_tlv(struct hci_dev *hdev,
> +				     struct intel_version_tlv *version,
> +				     struct sk_buff *skb)
> +{
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	/* Event parameters contatin multiple TLVs. Read each of them
> +	 * and only keep the required data. Also, it use existing legacy
> +	 * version field like hw_platform, hw_variant, and fw_variant
> +	 * to keep the existing setup flow
> +	 */
> +	while (skb->len) {
> +		struct intel_tlv *tlv;
> +
> +		tlv =3D (struct intel_tlv *)skb->data;
> +		switch (tlv->type) {
> +		case INTEL_TLV_CNVI_TOP:
> +			version->cnvi_top =3D get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_CNVR_TOP:
> +			version->cnvr_top =3D get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_CNVI_BT:
> +			version->cnvi_bt =3D get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_CNVR_BT:
> +			version->cnvr_bt =3D get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_DEV_REV_ID:
> +			version->dev_rev_id =3D get_unaligned_le16(tlv->val);
> +			break;
> +		case INTEL_TLV_IMAGE_TYPE:
> +			version->img_type =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_TIME_STAMP:
> +			/* If image type is Operational firmware (0x03), then
> +			 * running FW Calendar Week and Year information
> can
> +			 * be extracted from Timestamp information
> +			 */
> +			version->min_fw_build_cw =3D tlv->val[0];
> +			version->min_fw_build_yy =3D tlv->val[1];
> +			version->timestamp =3D get_unaligned_le16(tlv->val);
> +			break;
> +		case INTEL_TLV_BUILD_TYPE:
> +			version->build_type =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_BUILD_NUM:
> +			/* If image type is Operational firmware (0x03), then
> +			 * running FW build number can be extracted from
> the
> +			 * Build information
> +			 */
> +			version->min_fw_build_nn =3D tlv->val[0];
> +			version->build_num =3D get_unaligned_le32(tlv->val);
> +			break;
> +		case INTEL_TLV_SECURE_BOOT:
> +			version->secure_boot =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_OTP_LOCK:
> +			version->otp_lock =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_API_LOCK:
> +			version->api_lock =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_DEBUG_LOCK:
> +			version->debug_lock =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_MIN_FW:
> +			version->min_fw_build_nn =3D tlv->val[0];
> +			version->min_fw_build_cw =3D tlv->val[1];
> +			version->min_fw_build_yy =3D tlv->val[2];
> +			break;
> +		case INTEL_TLV_LIMITED_CCE:
> +			version->limited_cce =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_SBE_TYPE:
> +			version->sbe_type =3D tlv->val[0];
> +			break;
> +		case INTEL_TLV_OTP_BDADDR:
> +			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
> +			break;
> +		default:
> +			/* Ignore rest of information */
> +			break;
> +		}
> +		/* consume the current tlv and move to next*/
> +		skb_pull(skb, tlv->len + sizeof(*tlv));
> +	}
> +
> +	return 0;
> +}
> +
>  int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_=
tlv
> *version)  {
>  	struct sk_buff *skb;
> @@ -1272,6 +1372,116 @@ int btintel_set_debug_features(struct hci_dev
> *hdev,  }  EXPORT_SYMBOL_GPL(btintel_set_debug_features);
>=20
> +int btintel_setup_combined(struct hci_dev *hdev) {
> +	const u8 param[1] =3D { 0xFF };
> +	struct intel_version ver;
> +	struct intel_version_tlv ver_tlv;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	/* Starting from TyP device, the command parameter and response
> are
> +	 * changed even though the OCF for HCI_Intel_Read_Version
> command
> +	 * remains same. The legacy devices can handle even if the
> +	 * command has a parameter and returns a correct version
> information.
> +	 * So, it uses new format to support both legacy and new format.
> +	 */
> +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version command failed
> (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	/* Check the status */
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* For Legacy device, check the HW platform value and size */
> +	if (skb->data[1] =3D=3D 0x37 && skb->len =3D=3D sizeof(ver)) {
> +		bt_dev_dbg(hdev, "Read the legacy Intel version
> information");
> +
> +		memcpy(&ver, skb->data, sizeof(ver));
> +
> +		/* Display version information */
> +		btintel_version_info(hdev, &ver);
> +
> +		/* Identify the device type based on the read version */
> +		switch (ver.hw_variant) {
> +		case 0x07:	/* WP */
> +		case 0x08:	/* StP */
> +			/* Legacy ROM product */
> +			/* TODO: call setup routine for legacy rom product */
> +			break;
> +		case 0x0b:      /* SfP */
> +		case 0x0c:      /* WsP */
> +		case 0x11:      /* JfP */
> +		case 0x12:      /* ThP */
> +		case 0x13:      /* HrP */
> +		case 0x14:      /* CcP */
> +			/* TODO: call setup routine for bootloader product
> */
> +			break;
> +		default:
> +			bt_dev_err(hdev, "Unsupported Intel hw variant
> (%u)",
> +				   ver.hw_variant);
> +			return -EINVAL;
> +		}
> +
> +		return err;
> +	}
> +
> +	/* For TLV type device, parse the tlv data */
> +	btintel_parse_version_tlv(hdev, &ver_tlv, skb);
> +
> +	/* Display version information of TLV type */
> +	btintel_version_info_tlv(hdev, &ver_tlv);
> +
> +	/* TODO: Need to filter the device for new generation */
> +	/* TODO: call setup routine for tlv based bootloader product */
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(btintel_setup_combined);
> +
> +int btintel_shutdown_combined(struct hci_dev *hdev) {
> +	struct sk_buff *skb;
> +
> +	/* Send HCI Reset to the controller to stop any BT activity which
> +	 * were triggered. This will help to save power and maintain the
> +	 * sync b/w Host and controller
> +	 */
> +	skb =3D __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
> HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "HCI reset during shutdown failed");
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	/* Fix me: All legacy ROM and RAM works?
> +	 * This code was only for legacy ROM
> +	 */
> +	/* Some platforms have an issue with BT LED when the interface is
> +	 * down or BT radio is turned off, which takes 5 seconds to BT LED
> +	 * goes off. This command turns off the BT LED immediately.
> +	 */
> +	skb =3D __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "turning off Intel device LED failed");
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_shutdown_combined);
> +
>  MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION); diff --git a/drivers/bluetooth/btintel.h
> b/drivers/bluetooth/btintel.h index d184064a5e7c..68ffa84fa87a 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -165,6 +165,8 @@ int btintel_read_boot_params(struct hci_dev *hdev,
>  			     struct intel_boot_params *params);  int
> btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
>  			      const struct firmware *fw, u32 *boot_param);
> +int btintel_setup_combined(struct hci_dev *hdev); int
> +btintel_shutdown_combined(struct hci_dev *hdev);
>  int btintel_download_firmware_newgen(struct hci_dev *hdev,
>  				     struct intel_version_tlv *ver,
>  				     const struct firmware *fw,
> @@ -283,6 +285,16 @@ static inline int btintel_download_firmware(struct
> hci_dev *dev,
>  	return -EOPNOTSUPP;
>  }
>=20
> +static inline int btintel_setup_combined(struct hci_dev *hdev) {
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int btintel_shutdown_combined(struct hci_dev *hdev) {
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int btintel_download_firmware_newgen(struct hci_dev *hdev,
>  						   const struct firmware *fw,
>  						   u32 *boot_param,
> --
> 2.26.3

