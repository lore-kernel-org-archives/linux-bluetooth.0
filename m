Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF96C4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 09:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8258160F47
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 09:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhGWIih (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:38:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:49203 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231760AbhGWIig (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 04:38:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="233681616"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="233681616"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 02:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="416287360"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 23 Jul 2021 02:19:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 02:19:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 02:19:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 23 Jul 2021 02:19:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 23 Jul 2021 02:19:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3nPZvQQ1q2mf33GrBDDK5yc4VX5WGUVCZfrtgMotU/RnFawnpUEQ6Ev+D3vLsBB6X2UUW64swYhx12UR6KpFTdj34AfngfJ8+6cI9PzVY0I16RghoWdQhz3ozl4yIKjSvqyIKW+MHBJGsKIUi/BN0MogQSfnFarizFP8Guu46Sj/u5bwtw1ePXMTQ0CvyE/eAkZeuzq9JYjvfyZvJIk+LXN1NeudoqvUJvcbKNlyFUuPeIhDZni7J+dxoPwThWkRvva75zIYl666YngUi92bmFMbdafUoHT+VaiJChHLyXDSG6RbaHE7bkjUtxOtcLbv60sxRv0f4u7i2/87GmihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnFaJ3/r5DXJH1+9hxWR6Swv6hFNWGIWOaGLk0I1bFg=;
 b=NxjtUr0t8hnDQRNoKoLEfm1wiCTyA6gLjYFqVJv9xrRZT81PnicBgkOGz4yF9y9IhtYarhZ8EGibZ18m5vY/aj84zNs7BeqnILLxIDuvYoLJF2yQUBvbP22jo5SGVRWNb/ZFCD9j13pnML/hN8Sc6vpAtiYgCZDecomGYsH9AKsfltCoRF2zprVz5nTFMcPQ9Oz9GUOoNK2HF6dyolrVNYXt//oKq6Pk/UYuS2V29DNDkifBtjkQktokaSqCyifVZ4wffb8CtrPBlTCvdGvE6XKU6ASYSw5zsKt9I8BtjS1TBxdjtU40uEsMizWv5LOJAwoB+CCUVga3TM/3pwJZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnFaJ3/r5DXJH1+9hxWR6Swv6hFNWGIWOaGLk0I1bFg=;
 b=zco2D4Wq4tJIepBi8r/s2EUOg0xooTXpP2G2yzx+TBEOYnIjICbG9R2ZY6YiQ37UxJJL3pYidwt4Sma4vvybjDrWxJ6+4aAB/UyKPoum+D+9v61ed4gtTbvXPQowoKcvic8WLl355h776LOaoIJaet8f3tQnaXq+9ognBl58qDo=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5624.namprd11.prod.outlook.com (2603:10b6:8:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.28; Fri, 23 Jul 2021 09:19:06 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10%9]) with mapi id 15.20.4352.028; Fri, 23 Jul 2021
 09:19:06 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v2] Bluetooth: btintel: Support Digital(N) + RF(N-1)
 combination
Thread-Topic: [PATCH v2] Bluetooth: btintel: Support Digital(N) + RF(N-1)
 combination
Thread-Index: AQHXd5Z88gNoN9g3r0+UYytM0Ck49atQV/1g
Date:   Fri, 23 Jul 2021 09:19:06 +0000
Message-ID: <DM8PR11MB5573B555EDA9D6354D47A6A7F5E59@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210713032755.19351-1-kiran.k@intel.com>
In-Reply-To: <20210713032755.19351-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80aaeb7b-90fb-4a6d-e098-08d94dbaebbf
x-ms-traffictypediagnostic: DM8PR11MB5624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB56248A8951F25DFA3C531937F5E59@DM8PR11MB5624.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6kxF5bczcSsz4teymSO92zYETnX7padTQ+k73xdjkk/Lv3wRdxZdN/iKnCQ01cFeNpv/sMGTSnq5oyyKUvpJNEFNmB0PsJCETM0xxxylUDHJZCk4uWY5baIc+GA9PhEs1wr5p7wgNHMOd9iw2xetG5IQXCoyRQ2Hcj6WP6xwmtHiA5VD9XL9Q9WE4KbRSKbvIBTg566cQG+q4iVyuu8Uxxr9YM3SeY/OQQfwGhrNsRXhuA3+9MZ2RTVt1ihN0dsl0rWXxmz6zTvJdRLiNHaxKkIsvuHqMu8NY0mMkFefmbGzGKYKkHivMzd1gTmL4SGyvZ1c8JuRwhr5K6vUPnaadRXbawG9E2Ytrt+kDxmbeNyQeKwDWKt0hRx0JeG69d71ZYBIhSaZqaS/mR1FIPhDi/viFxO3MYAon7kg60u3kl2W1HiJ/5GIJNXtbQS8jXlfq1wBrbA4K6fL7qIusv3G/d3QDPNoUpaUivcrxadJi5ixMyJgwNjh/JmrDrzGdSfS+KBfNGC5HjAmPMZHwGt782MNeAVh9EC245DeD1T631k0uf60mGfVa+tJa5SPTG7j9MxL2Bfz+wLwnHX6KPhqwoA0AwzE+5cXuUefvz//VMmE7C7SkT3TQzUDT34FKSwgb71bzwhBiHkT0iaxKYsNEKNImhHQeqeB4P5rPgv+AvOWiO/jKzGzU3CydR9Ee0KCfPE20k/gTHBWEv0nVlqDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(8676002)(54906003)(7696005)(45080400002)(26005)(33656002)(478600001)(53546011)(4326008)(71200400001)(86362001)(55016002)(9686003)(107886003)(8936002)(66446008)(64756008)(316002)(6506007)(2906002)(66476007)(66946007)(186003)(76116006)(52536014)(38100700002)(6916009)(30864003)(5660300002)(83380400001)(122000001)(66556008)(38070700004)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QHIHU4gImlXS/IkJYsFROrnJmmEQESuslSE4Hn7fAQgsWpwHDDXHdCWz9E5m?=
 =?us-ascii?Q?EyUkSlvudmeLBM0oGdeFR6iobr9GJR3w9LaKtVhcbGUhic1REJ2lSNrYSQlD?=
 =?us-ascii?Q?xB0BXOjFtiiEcMSVMCFwiQbACbdhetCtUCIhhsnjQvPNb8L6T1DrvZEvLSL8?=
 =?us-ascii?Q?b5SBopYrvjwzPdzeVt8Cao+XZVq1j3HCJUyHGB1UV22qfi3X74TXD/oroOXQ?=
 =?us-ascii?Q?JK7O4v3kkzJNuoSjlTGNfIC3ukYAOQNm9iBUwUaL+bDEJ1+mzeQMnFFicW3j?=
 =?us-ascii?Q?7kTYzw8o1Wgzh1CUD5fBeoKzjqAsGeY4YfhYevARuRvRZR3D3m4ZuxN7530y?=
 =?us-ascii?Q?gc732YCuP63c7iKI51rX2xLVEmae1J4/W8Fy2gqwqCLKbHaIxtKpjxznrZDi?=
 =?us-ascii?Q?b0pLJV7z0qKUkGA43XFcUtg/CH4RjzbSRXF44BAmF48PqOVtCSeUjAaIAD9Z?=
 =?us-ascii?Q?wDLMpw67Xa95uovCauIL2PlBuMWEkoZzs8dvpXv8bn18RCNOX45Q2VHRR88j?=
 =?us-ascii?Q?0bfWvcrdqRXZoPDpzsqO0tlJ02eegNAJWV1ROgCR/FskF7/GEV2eNGNfzr4Y?=
 =?us-ascii?Q?nCT4+VmNhDK5YrvA1ckGH6Xg+aJ5WdW+rKSWfnIq+ahbLn/9QiSoZk0K1UX6?=
 =?us-ascii?Q?SfNvwODETrGTYAqt8eVBzFzViE7H1kUUQoZMz1ahuw/7KtOsdzasjiZ3uMy+?=
 =?us-ascii?Q?eSwOAfuasu3gcSSBnQq2+RvKWNtGMX/tu4aV9LGDuFGYUPR1xLThQLoLtu3v?=
 =?us-ascii?Q?XxRigzwzbzwK/jGCOitlC69X+HIUVjfYwJTPrQVinsNK2TE9ozDwxIqCO7Uk?=
 =?us-ascii?Q?Pg52HQ13qXdXSBz7JJsrQB2ttTKz+Te3zzMeWSIHVJQzVU/UvcpnLBAEs092?=
 =?us-ascii?Q?AvWRVfCXkYxnhcZK2Sj3FzNGJ14VI9JrCHNQiCF+4Yv1pPG6Y6jOyoL/UnNd?=
 =?us-ascii?Q?G4E9HF059bJmSw69Uj89E5CUD3L2uty3zL+0HSZHfD1yKeZ3zWT/R3dMuU0c?=
 =?us-ascii?Q?NFmvjOvr/mUD9FbF2guDDgrEzbx9VhMmzkmVlVK3wWmtRm9nYH+w/dim8I+e?=
 =?us-ascii?Q?WmJk2V/TJEZzRFiFazDTgQcFtWLJReyeOtBRdsA//ygoKcYa85L+FQFcIb14?=
 =?us-ascii?Q?0b4szMJOmelTTnrT40kdJXiYn0u2gUCX4PP6XWrRYuONkfaJ9Fxm/CEOSnRp?=
 =?us-ascii?Q?bIUTbxZEuYXw9RYZjRxXkHDa8X9hVx4TBC9hzVPnsioDNCK5YPsu2NdnIfIx?=
 =?us-ascii?Q?rubCI3JXJJVX4dR+mbXja+jguyRlKVTBaAU//t3ER0Pszl7e+0JADW9+rDLp?=
 =?us-ascii?Q?H70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aaeb7b-90fb-4a6d-e098-08d94dbaebbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 09:19:06.2997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5yQfYwo/Qg8SYvO1gI7oTFn/ubFUloVC2OpvL7h+ADlujFqYDyznzDJAh4KN2LIQYtIRLVbB9TsDOGwAty41g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5624
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Friendly reminder to review this patch.

Thanks,
Kiran


> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Tuesday, July 13, 2021 8:58 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: K, Kiran <kiran.k@intel.com>
> Subject: [PATCH v2] Bluetooth: btintel: Support Digital(N) + RF(N-1)
> combination
>=20
> New generation Intel controllers(N) need to support RF from (N-1)
> generation. Since PID comes from OTP present in RF module,
> *setup* function gets mapped to BTUSB_INTEL_NEW instead of
> BTUSB_INTEL_NEWGEN. This patch converges INTEL_NEW and
> INTEL_NEWGEN mappings and defines a new generic *setup* function. All
> the required information to load the correct driver is read from controll=
er in
> generic *setup* and branchs out appropriately.
>=20
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> changes in v2:
>  * For compatibility b/w CNVi and CNVr, instead of overriding the callbac=
ks
>    find out the required information at run time and branch out appropria=
tely
>  * review comments
>=20
>  drivers/bluetooth/btintel.c | 149 ++++++++++++++++++++++++++++++------
>  drivers/bluetooth/btintel.h |  10 +++
>  drivers/bluetooth/btusb.c   | 149 +++++++++++++++++++-----------------
>  3 files changed, 215 insertions(+), 93 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> e44b6993cf91..b1a4e02c0680 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -58,8 +58,10 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
>  	 * address 00:03:19:9E:8B:00 can be found. These controllers are
>  	 * fully operational, but have the danger of duplicate addresses
>  	 * and that in turn can cause problems with Bluetooth operation.
> +	 * Also mark controllers having zero bdaddress
>  	 */
> -	if (!bacmp(&bda->bdaddr, BDADDR_INTEL)) {
> +	if (!bacmp(&bda->bdaddr, BDADDR_INTEL) ||
> +	    !bacmp(&bda->bdaddr, BDADDR_ANY)) {
>  		bt_dev_err(hdev, "Found Intel default device address
> (%pMR)",
>  			   &bda->bdaddr);
>  		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks); @@ -
> 483,30 +485,15 @@ int btintel_version_info_tlv(struct hci_dev *hdev, stru=
ct
> intel_version_tlv *ver  }  EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
>=20
> -int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_=
tlv
> *version)
> +static int btintel_parse_version_tlv(struct hci_dev *hdev, struct sk_buf=
f
> *skb,
> +				     struct intel_version_tlv *version)
>  {
> -	struct sk_buff *skb;
> -	const u8 param[1] =3D { 0xFF };
> -
> -	if (!version)
> -		return -EINVAL;
> -
> -	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> -	if (IS_ERR(skb)) {
> -		bt_dev_err(hdev, "Reading Intel version information failed
> (%ld)",
> -			   PTR_ERR(skb));
> -		return PTR_ERR(skb);
> -	}
> +	int err =3D 0;
>=20
> -	if (skb->data[0]) {
> -		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> -			   skb->data[0]);
> -		kfree_skb(skb);
> -		return -EIO;
> -	}
> +	memset(version, 0x00, sizeof(*version));
>=20
>  	/* Consume Command Complete Status field */
> -	skb_pull(skb, 1);
> +	skb_pull(skb, sizeof(__u8));
>=20
>  	/* Event parameters contatin multiple TLVs. Read each of them
>  	 * and only keep the required data. Also, it use existing legacy @@ -
> 516,27 +503,62 @@ int btintel_read_version_tlv(struct hci_dev *hdev, stru=
ct
> intel_version_tlv *ver
>  	while (skb->len) {
>  		struct intel_tlv *tlv;
>=20
> +		if (skb->len < sizeof(*tlv)) {
> +			err =3D -EILSEQ;
> +			break;
> +		}
> +
>  		tlv =3D (struct intel_tlv *)skb->data;
> +
> +		if (skb->len < (sizeof(*tlv) + tlv->len)) {
> +			err =3D -EILSEQ;
> +			break;
> +		}
> +
>  		switch (tlv->type) {
>  		case INTEL_TLV_CNVI_TOP:
> +			if (tlv->len !=3D sizeof(__le32)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			version->cnvi_top =3D get_unaligned_le32(tlv->val);
>  			break;
>  		case INTEL_TLV_CNVR_TOP:
> +			if (tlv->len !=3D sizeof(__le32)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			version->cnvr_top =3D get_unaligned_le32(tlv->val);
>  			break;
>  		case INTEL_TLV_CNVI_BT:
> +			if (tlv->len !=3D sizeof(__le32)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			version->cnvi_bt =3D get_unaligned_le32(tlv->val);
>  			break;
>  		case INTEL_TLV_CNVR_BT:
> +			if (tlv->len !=3D sizeof(__le32)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			version->cnvr_bt =3D get_unaligned_le32(tlv->val);
>  			break;
>  		case INTEL_TLV_DEV_REV_ID:
> +			if (tlv->len !=3D sizeof(__le16)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			version->dev_rev_id =3D get_unaligned_le16(tlv->val);
>  			break;
>  		case INTEL_TLV_IMAGE_TYPE:
>  			version->img_type =3D tlv->val[0];
>  			break;
>  		case INTEL_TLV_TIME_STAMP:
> +			if (tlv->len !=3D sizeof(__le16)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			/* If image type is Operational firmware (0x03), then
>  			 * running FW Calendar Week and Year information
> can
>  			 * be extracted from Timestamp information @@ -
> 549,6 +571,10 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struc=
t
> intel_version_tlv *ver
>  			version->build_type =3D tlv->val[0];
>  			break;
>  		case INTEL_TLV_BUILD_NUM:
> +			if (tlv->len !=3D sizeof(__le32)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			/* If image type is Operational firmware (0x03), then
>  			 * running FW build number can be extracted from
> the
>  			 * Build information
> @@ -569,6 +595,10 @@ int btintel_read_version_tlv(struct hci_dev *hdev,
> struct intel_version_tlv *ver
>  			version->debug_lock =3D tlv->val[0];
>  			break;
>  		case INTEL_TLV_MIN_FW:
> +			if (tlv->len !=3D 3) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			version->min_fw_build_nn =3D tlv->val[0];
>  			version->min_fw_build_cw =3D tlv->val[1];
>  			version->min_fw_build_yy =3D tlv->val[2]; @@ -580,21
> +610,96 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct
> intel_version_tlv *ver
>  			version->sbe_type =3D tlv->val[0];
>  			break;
>  		case INTEL_TLV_OTP_BDADDR:
> +			if (tlv->len !=3D sizeof(version->otp_bd_addr)) {
> +				err =3D -EILSEQ;
> +				break;
> +			}
>  			memcpy(&version->otp_bd_addr, tlv->val, tlv->len);
>  			break;
>  		default:
>  			/* Ignore rest of information */
>  			break;
>  		}
> +
> +		if (err)
> +			break;
> +
>  		/* consume the current tlv and move to next*/
>  		skb_pull(skb, tlv->len + sizeof(*tlv));
>  	}
> +	return err;
> +}
> +
> +int btintel_read_version_tlv(struct hci_dev *hdev, struct
> +intel_version_tlv *version) {
> +	int err;
> +	struct sk_buff *skb;
> +	const u8 param[1] =3D { 0xFF };
> +
> +	if (!version)
> +		return -EINVAL;
> +
> +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version information failed
> (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	err =3D btintel_parse_version_tlv(hdev, skb, version);
>=20
>  	kfree_skb(skb);
> -	return 0;
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(btintel_read_version_tlv);
>=20
> +int btintel_generic_read_version(struct hci_dev *hdev,
> +				 struct intel_version_tlv *ver_tlv,
> +				 struct intel_version *ver, bool *is_tlv) {
> +	int err =3D 0;
> +	struct sk_buff *skb;
> +	const u8 param[1] =3D { 0xFF };
> +
> +	skb =3D __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version information failed
> (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed
> (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	if (skb->len < sizeof(struct intel_version))
> +		return -EILSEQ;
> +
> +	if (skb->len =3D=3D sizeof(struct intel_version) &&
> +	    skb->data[1] =3D=3D 0x37) {
> +		*is_tlv =3D false;
> +		memcpy(ver, skb->data, sizeof(*ver));
> +	} else {
> +		*is_tlv =3D true;
> +		err =3D btintel_parse_version_tlv(hdev, skb, ver_tlv);
> +	}
> +
> +	kfree_skb(skb);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(btintel_generic_read_version);
> +
>  /* ------- REGMAP IBT SUPPORT ------- */
>=20
>  #define IBT_REG_MODE_8BIT  0x00
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h in=
dex
> d184064a5e7c..366cb746f9c4 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -175,6 +175,10 @@ int btintel_read_debug_features(struct hci_dev
> *hdev,
>  				struct intel_debug_features *features);  int
> btintel_set_debug_features(struct hci_dev *hdev,
>  			       const struct intel_debug_features *features);
> +int btintel_generic_read_version(struct hci_dev *hdev,
> +				 struct intel_version_tlv *ver_tlv,
> +				 struct intel_version *ver,
> +				 bool *is_tlv);
>  #else
>=20
>  static inline int btintel_check_bdaddr(struct hci_dev *hdev) @@ -307,4
> +311,10 @@ static inline int btintel_set_debug_features(struct hci_dev
> *hdev,
>  	return -EOPNOTSUPP;
>  }
>=20
> +static int btintel_generic_read_version(struct hci_dev *hdev,
> +					struct intel_version_tlv *ver_tlv,
> +					struct intel_version *ver, bool *is_tlv)
> {
> +	return -EOPNOTSUPP;
> +}
>  #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
> a9855a2dd561..6c5050bdcfcc 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -60,7 +60,6 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_WIDEBAND_SPEECH	0x400000
>  #define BTUSB_VALID_LE_STATES   0x800000
>  #define BTUSB_QCA_WCN6855	0x1000000
> -#define BTUSB_INTEL_NEWGEN	0x2000000
>=20
>  static const struct usb_device_id btusb_table[] =3D {
>  	/* Generic Bluetooth USB device */
> @@ -368,9 +367,9 @@ static const struct usb_device_id blacklist_table[] =
=3D {
>=20
> BTUSB_WIDEBAND_SPEECH },
>  	{ USB_DEVICE(0x8087, 0x0029), .driver_info =3D BTUSB_INTEL_NEW |
>=20
> BTUSB_WIDEBAND_SPEECH },
> -	{ USB_DEVICE(0x8087, 0x0032), .driver_info =3D
> BTUSB_INTEL_NEWGEN |
> +	{ USB_DEVICE(0x8087, 0x0032), .driver_info =3D BTUSB_INTEL_NEW |
>=20
> BTUSB_WIDEBAND_SPEECH},
> -	{ USB_DEVICE(0x8087, 0x0033), .driver_info =3D
> BTUSB_INTEL_NEWGEN |
> +	{ USB_DEVICE(0x8087, 0x0033), .driver_info =3D BTUSB_INTEL_NEW |
>=20
> BTUSB_WIDEBAND_SPEECH},
>  	{ USB_DEVICE(0x8087, 0x07da), .driver_info =3D BTUSB_CSR },
>  	{ USB_DEVICE(0x8087, 0x07dc), .driver_info =3D BTUSB_INTEL }, @@ -
> 2521,8 +2520,8 @@ static int
> btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
>  		return -EINVAL;
>=20
>  	/* The firmware variant determines if the device is in bootloader
> -	 * mode or is running operational firmware. The value 0x03 identifies
> -	 * the bootloader and the value 0x23 identifies the operational
> +	 * mode or is running operational firmware. The value 0x23 identifies
> +	 * the bootloader and the value 0x03 identifies the operational
>  	 * firmware.
>  	 *
>  	 * When the operational firmware is already present, then only @@ -
> 2536,14 +2535,14 @@ static int
> btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
>  	if (ver->img_type =3D=3D 0x03) {
>  		clear_bit(BTUSB_BOOTLOADER, &data->flags);
>  		btintel_check_bdaddr(hdev);
> -	}
> -
> -	/* If the OTP has no valid Bluetooth device address, then there will
> -	 * also be no valid address for the operational firmware.
> -	 */
> -	if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> -		bt_dev_info(hdev, "No device address configured");
> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +	} else {
> +		/* In Boot mode, bd address is part of tlv data. Check for
> +		 * valid bd address
> +		 */
> +		if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
> +			bt_dev_info(hdev, "No device address configured");
> +			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev-
> >quirks);
> +		}
>  	}
>=20
>  	btusb_setup_intel_newgen_get_fw_name(ver, fwname,
> sizeof(fwname), "sfi"); @@ -2842,10 +2841,9 @@ static int
> btusb_intel_boot(struct hci_dev *hdev, u32 boot_addr)
>  	return err;
>  }
>=20
> -static int btusb_setup_intel_new(struct hci_dev *hdev)
> +static int btusb_setup_intel_new(struct hci_dev *hdev, struct
> +intel_version *ver)
>  {
>  	struct btusb_data *data =3D hci_get_drvdata(hdev);
> -	struct intel_version ver;
>  	struct intel_boot_params params;
>  	u32 boot_param;
>  	char ddcname[64];
> @@ -2860,27 +2858,16 @@ static int btusb_setup_intel_new(struct hci_dev
> *hdev)
>  	 */
>  	boot_param =3D 0x00000000;
>=20
> -	/* Read the Intel version information to determine if the device
> -	 * is in bootloader mode or if it already has operational firmware
> -	 * loaded.
> -	 */
> -	err =3D btintel_read_version(hdev, &ver);
> -	if (err) {
> -		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> -		btintel_reset_to_bootloader(hdev);
> -		return err;
> -	}
> -
> -	err =3D btintel_version_info(hdev, &ver);
> +	err =3D btintel_version_info(hdev, ver);
>  	if (err)
>  		return err;
>=20
> -	err =3D btusb_intel_download_firmware(hdev, &ver, &params,
> &boot_param);
> +	err =3D btusb_intel_download_firmware(hdev, ver, &params,
> &boot_param);
>  	if (err)
>  		return err;
>=20
>  	/* controller is already having an operational firmware */
> -	if (ver.fw_variant =3D=3D 0x23)
> +	if (ver->fw_variant =3D=3D 0x23)
>  		goto finish;
>=20
>  	err =3D btusb_intel_boot(hdev, boot_param); @@ -2889,7 +2876,7
> @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
>=20
>  	clear_bit(BTUSB_BOOTLOADER, &data->flags);
>=20
> -	err =3D btusb_setup_intel_new_get_fw_name(&ver, &params,
> ddcname,
> +	err =3D btusb_setup_intel_new_get_fw_name(ver, &params, ddcname,
>  						sizeof(ddcname), "ddc");
>=20
>  	if (err < 0) {
> @@ -2913,17 +2900,17 @@ static int btusb_setup_intel_new(struct hci_dev
> *hdev)
>  	btintel_set_debug_features(hdev, &features);
>=20
>  	/* Read the Intel version information after loading the FW  */
> -	err =3D btintel_read_version(hdev, &ver);
> +	err =3D btintel_read_version(hdev, ver);
>  	if (err)
>  		return err;
>=20
> -	btintel_version_info(hdev, &ver);
> +	btintel_version_info(hdev, ver);
>=20
>  finish:
>  	/* All Intel controllers that support the Microsoft vendor
>  	 * extension are using 0xFC1E for VsMsftOpCode.
>  	 */
> -	switch (ver.hw_variant) {
> +	switch (ver->hw_variant) {
>  	case 0x11:	/* JfP */
>  	case 0x12:	/* ThP */
>  	case 0x13:	/* HrP */
> @@ -2944,14 +2931,13 @@ static int btusb_setup_intel_new(struct hci_dev
> *hdev)
>  	return 0;
>  }
>=20
> -static int btusb_setup_intel_newgen(struct hci_dev *hdev)
> +static int btusb_setup_intel_newgen(struct hci_dev *hdev, struct
> +intel_version_tlv *version)
>  {
>  	struct btusb_data *data =3D hci_get_drvdata(hdev);
>  	u32 boot_param;
>  	char ddcname[64];
>  	int err;
>  	struct intel_debug_features features;
> -	struct intel_version_tlv version;
>=20
>  	bt_dev_dbg(hdev, "");
>=20
> @@ -2961,27 +2947,16 @@ static int btusb_setup_intel_newgen(struct
> hci_dev *hdev)
>  	 */
>  	boot_param =3D 0x00000000;
>=20
> -	/* Read the Intel version information to determine if the device
> -	 * is in bootloader mode or if it already has operational firmware
> -	 * loaded.
> -	 */
> -	err =3D btintel_read_version_tlv(hdev, &version);
> -	if (err) {
> -		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> -		btintel_reset_to_bootloader(hdev);
> -		return err;
> -	}
> -
> -	err =3D btintel_version_info_tlv(hdev, &version);
> +	err =3D btintel_version_info_tlv(hdev, version);
>  	if (err)
>  		return err;
>=20
> -	err =3D btusb_intel_download_firmware_newgen(hdev, &version,
> &boot_param);
> +	err =3D btusb_intel_download_firmware_newgen(hdev, version,
> +&boot_param);
>  	if (err)
>  		return err;
>=20
>  	/* check if controller is already having an operational firmware */
> -	if (version.img_type =3D=3D 0x03)
> +	if (version->img_type =3D=3D 0x03)
>  		goto finish;
>=20
>  	err =3D btusb_intel_boot(hdev, boot_param); @@ -2990,7 +2965,7
> @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
>=20
>  	clear_bit(BTUSB_BOOTLOADER, &data->flags);
>=20
> -	btusb_setup_intel_newgen_get_fw_name(&version, ddcname,
> sizeof(ddcname),
> +	btusb_setup_intel_newgen_get_fw_name(version, ddcname,
> +sizeof(ddcname),
>  					     "ddc");
>  	/* Once the device is running in operational mode, it needs to
>  	 * apply the device configuration (DDC) parameters.
> @@ -3009,11 +2984,11 @@ static int btusb_setup_intel_newgen(struct
> hci_dev *hdev)
>  	btintel_set_debug_features(hdev, &features);
>=20
>  	/* Read the Intel version information after loading the FW  */
> -	err =3D btintel_read_version_tlv(hdev, &version);
> +	err =3D btintel_read_version_tlv(hdev, version);
>  	if (err)
>  		return err;
>=20
> -	btintel_version_info_tlv(hdev, &version);
> +	btintel_version_info_tlv(hdev, version);
>=20
>  finish:
>  	/* Set the event mask for Intel specific vendor events. This enables
> @@ -3027,6 +3002,56 @@ static int btusb_setup_intel_newgen(struct
> hci_dev *hdev)
>=20
>  	return 0;
>  }
> +
> +static bool btintel_is_newgen_controller(struct hci_dev *hdev, u32
> +cnvi) {
> +	bt_dev_dbg(hdev, "CNVi - %x", cnvi & 0xFFF);
> +
> +	switch (cnvi & 0xFFF) {
> +	case 0x400: /* Slr */
> +	case 0x401: /* Slr-F */
> +	case 0x410: /* TyP */
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static int btusb_setup_intel_generic(struct hci_dev *hdev) {
> +	struct intel_version_tlv ver_tlv;
> +	struct intel_version ver;
> +	bool is_tlv;
> +	int err;
> +
> +	err =3D btintel_generic_read_version(hdev, &ver_tlv, &ver, &is_tlv);
> +	if (err) {
> +		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
> +		btintel_reset_to_bootloader(hdev);
> +		goto done;
> +	}
> +
> +	if (!is_tlv) {
> +		err =3D btusb_setup_intel_new(hdev, &ver);
> +	} else {
> +		/* In OP mode Quasar/Pulsar ram products returns TLV data.
> +		 * Find out CNVi and then  branch out appropriately
> +		 */
> +		if (btintel_is_newgen_controller(hdev, ver_tlv.cnvi_top)) {
> +			err =3D btusb_setup_intel_newgen(hdev, &ver_tlv);
> +		} else {
> +			err =3D btintel_read_version(hdev, &ver);
> +			if (err) {
> +				bt_dev_err(hdev, "Intel Read version failed
> (%d)", err);
> +				goto done;
> +			}
> +			err =3D btusb_setup_intel_new(hdev, &ver);
> +		}
> +	}
> +done:
> +
> +	return err;
> +}
> +
>  static int btusb_shutdown_intel(struct hci_dev *hdev)  {
>  	struct sk_buff *skb;
> @@ -4649,21 +4674,7 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (id->driver_info & BTUSB_INTEL_NEW) {
>  		hdev->manufacturer =3D 2;
>  		hdev->send =3D btusb_send_frame_intel;
> -		hdev->setup =3D btusb_setup_intel_new;
> -		hdev->shutdown =3D btusb_shutdown_intel_new;
> -		hdev->hw_error =3D btintel_hw_error;
> -		hdev->set_diag =3D btintel_set_diag;
> -		hdev->set_bdaddr =3D btintel_set_bdaddr;
> -		hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> -		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev-
> >quirks);
> -		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev-
> >quirks);
> -		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> -	}
> -
> -	if (id->driver_info & BTUSB_INTEL_NEWGEN) {
> -		hdev->manufacturer =3D 2;
> -		hdev->send =3D btusb_send_frame_intel;
> -		hdev->setup =3D btusb_setup_intel_newgen;
> +		hdev->setup =3D btusb_setup_intel_generic;
>  		hdev->shutdown =3D btusb_shutdown_intel_new;
>  		hdev->hw_error =3D btintel_hw_error;
>  		hdev->set_diag =3D btintel_set_diag;
> @@ -4672,10 +4683,6 @@ static int btusb_probe(struct usb_interface *intf,
>  		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev-
> >quirks);
>  		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev-
> >quirks);
>  		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> -
> -		data->recv_event =3D btusb_recv_event_intel;
> -		data->recv_bulk =3D btusb_recv_bulk_intel;
> -		set_bit(BTUSB_BOOTLOADER, &data->flags);
>  	}
>=20
>  	if (id->driver_info & BTUSB_MARVELL)
> --
> 2.17.1

