Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57EEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6E160F14
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 15:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhHDPWc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:22:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:10814 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238324AbhHDPWb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 11:22:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="194220940"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="194220940"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 08:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="437461228"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2021 08:22:18 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 4 Aug 2021 08:22:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 4 Aug 2021 08:22:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 4 Aug 2021 08:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTO9YTttpXtdTHyJcEXRgTn0xzMrvxzZES7vNGfOE7V6RJDly5M3szMJSacoJ4UfpYzDChrFEAi7iduzX8GNnkpqW5Jp3uDQO+4xTUjSYEGnb07pXlyk0m45X8pzTbMPOuauRfQB2gXZFtVTGyyW7MtGtE0dG/F66JHD5uTD8b+Vii1+MVaJXRw/ijCNlZsMerx7tVU/vSNU6kZEPKwLcGVfrQ3GgpNU9w1adkoMouUaY2bINidMoMav8RSlGfkIgKDCkl4fy8qmZHP+qe/pCw9MA8esz8GMC/H09p2IT6cENMMdz1qhl6iZ+XYabdh7BSCRgDs6MGegS/RUknkgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UIEv1HG/pEHEzSTTqGnWhhzFuAbYvZFMVwbMecsoUM=;
 b=fvMRNf/2TVsNAIWZMzA+AEnbPesw+mBlSOqWjsbqZai5wOWYybyL59oIl0HmmwsWDeX/0RkwIfvhQmcGXzWI1zi9GluUhdeDEIUcqqvTw8uyI3Xzrhkym98U5InlmKFSd49aordujFH5UPJD88YZvbJIuPv308qlacAwYSa+gEgLI3BCjE5plAuENbvRnWICFH7vrayWVdaATFraR1c6y/hoMYa6A4Us0vKZ0wa774mB0IV/+RJF/zzpB88d6DlNAVJzAEdOpLiCAI7toADroQ2jN3TETKAQ93sD7KmnlOBie4ARx2C873XyHVNYivVS1XXAgVRpcUTmLoClt43NFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UIEv1HG/pEHEzSTTqGnWhhzFuAbYvZFMVwbMecsoUM=;
 b=NxlfEG0ZMgLD5bEA54LU+aib+5WLmvJKft8A4MMjdsW/GSCiSEpr2EegWxF0fwzLQOuATkgwBVbkl5wzHxz2ZNm/Pt3lVDkD+RHnpGGvaveMq/VDypiyLPWG1Prm5oOjZjlPfZ4PvrK321oaTsIeTpi7L9saZXtRjSGXcIFUEqc=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5624.namprd11.prod.outlook.com (2603:10b6:8:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.22; Wed, 4 Aug 2021 15:22:14 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 15:22:14 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "An, Tedd" <tedd.an@intel.com>
Subject: RE: [PATCH v6 02/12] Bluetooth: btintel: Add combined setup and
 shutdown functions
Thread-Topic: [PATCH v6 02/12] Bluetooth: btintel: Add combined setup and
 shutdown functions
Thread-Index: AQHXiOrtXY8vEZgo+ky8hBKHxBg+8Ktjc+4Q
Date:   Wed, 4 Aug 2021 15:22:14 +0000
Message-ID: <DM8PR11MB55734A91C7215B1523409D80F5F19@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210804044032.59729-1-hj.tedd.an@gmail.com>
 <20210804044032.59729-3-hj.tedd.an@gmail.com>
In-Reply-To: <20210804044032.59729-3-hj.tedd.an@gmail.com>
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
x-ms-office365-filtering-correlation-id: b12fb290-8712-4277-321d-08d9575ba394
x-ms-traffictypediagnostic: DM8PR11MB5624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB56246D29F9DD43FE12CA0DBAF5F19@DM8PR11MB5624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZjuVJwOEvIlf9Qu6TMIzQYogicYzgrapXTV4hD9/0v5VXB+rpzFPYFgCUBg4YGayyh6yKAYbDm3GMzL4xRmfNOVzdXtM2476+9MDjmyTuKZmjFYMhDSjuLz8ZHKdPWaZ6Db0gbqyUAh8knGPdQV7M9ind0vk9/hCtzD5yIGciPnNsMbop6pVoHBbraZ1oIEWNzfztrXMoEEe+zwUjw7PvRWlt97tcMGn5DZTcM80sOg5tvC9VcHcm7kmv//aA0+Wlnv+B5vEuaX/dA8Kw33fftroQ5D+pJ163IeY16UMzrkNNOTY65sg/N42X+QZVjr91JzsyIAJehnphsQ/i92i+pGmajv2nqO62Y0eiJLZrU+PArE0WxaOBrBwUbcDqPuBZQ3Cq6tJseer9nBDpA9+wZ7O7LXbHEDd16hul2VJzjt9pBO3d+dlUgUxe1JrIZjTcFBdlUvBy5VYFTtYOfu7RyullD3V09m2vtV1dbtrlJVfFLEOj/XBE48kTH3woSOxxuslNpPnyuQocLGgydYw1/lQTp1ML5aIIrA8uXDqDHQhyDe9w9o14EEiWfM8poPyi6/bFaqR8qC1lbaTsxZaBYBym+O8wIx4xHw4ZF0n2bTnuWLKZW3v7Sx+541UhAlfd7Z1z+jRLe9/+iz4GXFHf+d/VDQp/sGOVq8pjb/Qx//2m8ayZ9CBjR5fmpQE/0niIAqDhvDg6m3WKfgNREF8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(107886003)(186003)(52536014)(2906002)(9686003)(71200400001)(8676002)(4326008)(55016002)(122000001)(53546011)(30864003)(6506007)(33656002)(7696005)(38100700002)(110136005)(86362001)(5660300002)(478600001)(38070700005)(316002)(76116006)(66556008)(8936002)(66476007)(66446008)(66946007)(83380400001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R+Ly9u/tBiSVSekoSWV3HHzViJlNidHI0OzgtZkX/GPzZG0JqH/o7yIfxi2B?=
 =?us-ascii?Q?OSkQDaoab1Z9CIr1DKLXmiGzGs2/lSmZREXLJlbYHRt1X/f5jgfloHdgaOTE?=
 =?us-ascii?Q?0yKGL5JhZ+qv0g8SDCFNsFuBFPe3GxtPiQfUho7O3XegXpAOFP/6H2nBxG4Q?=
 =?us-ascii?Q?sfcEFTpIYkWMTDgYrXj6B1hIGkTROOyAauhZUrX9DJ43DTiDiDt2GAbl9YQm?=
 =?us-ascii?Q?8CoWrO1EdwlJCyH+Tj/j2FijyAlEa+AHtCIrFCwcWnIDPxJUuwGKbRlHaUR6?=
 =?us-ascii?Q?ekRNE2xxReoTbfVHw+rmrfGAtIlmjBb2zU1NOYGfDUfhr3TmHxfg+XN4a57O?=
 =?us-ascii?Q?ou/E9PfWvEcLHSF/KjyvS5A5trPA7n24rO3mCo9ljagumi9F2ErNjWk4fKx1?=
 =?us-ascii?Q?wYukObnom+E5XnljAbmdNRtyMjQiujlHaM5XWw8yJ4RMvsp0dn6VQKXbbLm+?=
 =?us-ascii?Q?NS8BtSbagG0MvHq9WpxiLQ8J0T+IKTM5I89U88O9tTdnMRIJ9qoD9MqoxTjL?=
 =?us-ascii?Q?1eMF8rxNYP/fk7zGmrNmlWRJ8dR9yo9OmvEYSjisS/M20M8cQTmCKfg40HEm?=
 =?us-ascii?Q?eYFwlWxsFypXbBx0VFAbPQItRmJMZVcEora0ouQZoJqGBV4wNoc22bHaQpcB?=
 =?us-ascii?Q?u48Ud22K7nQCz9Q5E4kZGYrdwaunpcvVEzO6BymX820XKRwIJW2f0fLv2wzv?=
 =?us-ascii?Q?L0ToMJ6W1RvYuspWqmMIVA4HswYUH3uvffpsIV+43icpxhRPQYXP5XWQxj3/?=
 =?us-ascii?Q?bNf1WXkHiJijfdzfMz/9UTZc2Qn0DSxrMrDB+2WnWWFQNtVZx2Xk7JncOK3c?=
 =?us-ascii?Q?2aMuz/JRtt4IE8pAl94H3fMWc3Xx/2n6SvOTBPq6etwcHkJMxOmvWkvpCrbX?=
 =?us-ascii?Q?vTnl+OqUddnv67K0GLc2LdTj//qW5Fii5TMgcxg16BmE7Qe9pn/7whPpmz9T?=
 =?us-ascii?Q?zeNTbr2hMEz34YkbjrFli18lYG8OL3bA3aob5fnXOOesFkhF3pNRjJjHAY3q?=
 =?us-ascii?Q?PuQoIrsHrmPoShZVbtsXxKJUqktZssSQFS5cemiVRnP2giA44ImweRu+iK01?=
 =?us-ascii?Q?DGfv0U7LYWQil9MJrt3PKsLdFjeKg+tf1I/1la8vVbNlspBTZq5995lr/HMm?=
 =?us-ascii?Q?GfUHkarZYJuRhS1W9S+C+fCaxC9g36GsJmTD7VjJg3zizcPQctYgTFAWYjzv?=
 =?us-ascii?Q?RYV1jPlgMHStufJr7Jf7Q9V8sdFIAChUgIK7DeADw+g53ZM51gXxBDW6IxeX?=
 =?us-ascii?Q?USI4idj4f0JMHzNX+2d2Ym/ZW7XCNRh59IZ2i5ZEUexyQVFwWq0ckWdPsIAh?=
 =?us-ascii?Q?OQEnikWpeYrcxdYiNLNca9paUMxD85zpISWyWxLICeshIu0DCvYN44CicABa?=
 =?us-ascii?Q?yx5uakfSNMxugjccuTXjQlf+Qqf/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12fb290-8712-4277-321d-08d9575ba394
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 15:22:14.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmRSHIzgcg0KyPOe+/MQ0a+9cm5ve6C4C1ihxi1o+qLEGVevrl74iMJFvlhPqIEHY6Bz8yluo83naJP6Xujy8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> -----Original Message-----
> From: Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
> Sent: Wednesday, August 4, 2021 10:10 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: An, Tedd <tedd.an@intel.com>
> Subject: [PATCH v6 02/12] Bluetooth: btintel: Add combined setup and
> shutdown functions
>=20
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>=20
> There are multiple setup and shutdown functions for Intel device and the
> setup function to be used is depends on the USB PID/VID, which makes
> difficult to maintain the code and increases the code size.
>=20
> This patch adds combined setup and shutdown functions to provide a single
> entry point for all Intel devices and choose the setup functions based on=
 the
> information read with HCI_Intel_Read_Version command.
>=20
> Starting from TyP device, the command and response parameters for
> HCI_Intel_Read_Version command are changed even though OCF remains
> same. However, the legacy devices still can handle the command without
> error even if it has a extra parameter, so to simplify the flow, the new
> command format is used to read the version information for both legacy an=
d
> new (tlv based) format.
>=20
> Also, it also adds a routine to setup the hdev callbacks in btintel.
>=20
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 230 ++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |   6 +
>  2 files changed, 236 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> e44b6993cf91..3d98fc2a64b9 100644
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
> @@ -483,6 +491,107 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
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
> +		/* Make sure skb has a minimum length of the header */
> +		if (skb->len < 2)
> +			return -EINVAL;

Can we use sizeof(*tlv) instead of 2 ?

> +
> +		tlv =3D (struct intel_tlv *)skb->data;
> +
> +		/* Make sure skb has a enough data */
> +		if (skb->len < tlv->len + sizeof(*tlv))
> +			return -EINVAL;
> +
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

I think we need to restrict copying to only sizeof(version->otp_bd_addr) by=
tes here.

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
> @@ -1272,6 +1381,127 @@ int btintel_set_debug_features(struct hci_dev
> *hdev,  }  EXPORT_SYMBOL_GPL(btintel_set_debug_features);
>=20
> +static int btintel_setup_combined(struct hci_dev *hdev) {
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

Need to check for skb->len before accessing data.

> +		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* For Legacy device, check the HW platform value and size */
> +	if (skb->len =3D=3D sizeof(ver) && skb->data[1] =3D=3D 0x37) {
> +		bt_dev_dbg(hdev, "Read the legacy Intel version
> information");
> +
> +		memcpy(&ver, skb->data, sizeof(ver));
> +
> +		/* Display version information */
> +		btintel_version_info(hdev, &ver);
> +
> +		/* Check for supported iBT hardware variants of this
> firmware
> +		 * loading method.
> +		 *
> +		 * This check has been put in place to ensure correct forward
> +		 * compatibility options when newer hardware variants come
> +		 * along.
> +		 */
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

Possibility of memory leak here

> +		}
> +
> +		return err;

Ditto..  plus possibility of returning uninitialized err.

> +	}
> +
> +	/* For TLV type device, parse the tlv data */
> +	err =3D btintel_parse_version_tlv(hdev, &ver_tlv, skb);
> +	if (err) {
> +		bt_dev_err(hdev, "Failed to parse TLV version information");
> +		return err;
> +	}
> +
> +	if (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt) !=3D 0x37) {
> +		bt_dev_err(hdev, "Unsupported Intel hardware platform
> (0x%2x)",
> +			   INTEL_HW_PLATFORM(ver_tlv.cnvi_bt));
> +		return -EINVAL;
> +	}
> +
> +	/* Display version information of TLV type */
> +	btintel_version_info_tlv(hdev, &ver_tlv);
> +
> +	/* TODO: Need to filter the device for new generation */
> +	/* TODO: call setup routine for tlv based bootloader product */
> +
> +	return err;
> +}
> +
> +static int btintel_shutdown_combined(struct hci_dev *hdev) {
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
> +	return 0;
> +}
> +
> +int btintel_configure_setup(struct hci_dev *hdev) {
> +	/* TODO: Setup hdev callback here */
> +	hdev->manufacturer =3D 2;
> +	hdev->setup =3D btintel_setup_combined;
> +	hdev->shutdown =3D btintel_shutdown_combined;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_configure_setup);
> +
>  MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION); diff --git a/drivers/bluetooth/btintel.h
> b/drivers/bluetooth/btintel.h index d184064a5e7c..dda890d94a07 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -175,6 +175,7 @@ int btintel_read_debug_features(struct hci_dev
> *hdev,
>  				struct intel_debug_features *features);  int
> btintel_set_debug_features(struct hci_dev *hdev,
>  			       const struct intel_debug_features *features);
> +int btintel_configure_setup(struct hci_dev *hdev);
>  #else
>=20
>  static inline int btintel_check_bdaddr(struct hci_dev *hdev) @@ -307,4
> +308,9 @@ static inline int btintel_set_debug_features(struct hci_dev *hd=
ev,
>  	return -EOPNOTSUPP;
>  }
>=20
> +static inline int btintel_configure_setup(struct hci_dev *hdev) {
> +	return -ENODEV;
> +}
> +
>  #endif
> --
> 2.25.1

Thanks,
Kiran


