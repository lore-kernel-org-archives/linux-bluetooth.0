Return-Path: <SRS0=5m6h=C6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFDCC43465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 03:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3A020795
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Sep 2020 03:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="aCCVb2N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgIUDEN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Sep 2020 23:04:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:54918 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgIUDEM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Sep 2020 23:04:12 -0400
IronPort-SDR: 2Zn0NidZr0NStf0tudzIDywcWEAAhHiKYjxF555Ql0OuiVlIJA3LyMhIuxqWHtPoN7HID0spP+
 6eTPy6lrMPwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="245134170"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="245134170"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 20:04:09 -0700
IronPort-SDR: Lv9dkA8TM4MP09WVuCpgMZDpZzrunECkqyGpZNixutWK0o38IEv+DiI7dU/e85WFvPIVNu3SiO
 dgUPtXPksyTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="321540740"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2020 20:04:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Sep 2020 20:03:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 20 Sep 2020 20:03:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 20 Sep 2020 20:03:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDd9vn17WNUQGcush3w0lrNqtJUSq2lyd1TW02m+JRg3wbp0Vz+OO8WZqh7z3hFJJUyuTFuX9D6uUvPCLSMpeRf/2wspEqeaPLyAIyTIfpbuY02no+BENz/JdURW0Ve0wYHFOgJwgGANfpj//Kj3QjtY3TrmFP3BOuK/TGx8CKYSBV+R00543IEQmU0MysAJzC1ZZpxVefm7ZCh+ozHe6W7jX4O5KdoRp1Kl6W+Fmd5S9gCONP9wDaVFAt+RQmkx+CJJdpwIuR6LPrSqOmvgdsKe4WEtCL7jhk5DQ4xdrhpGuipxju8bdTWUPKdnoP1YEQ6KAlMbuyy+GOUJ+HRVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUaSbaAN//PPpfk0fApwPF0suG0Sf+jA4NmUJeeVnrE=;
 b=fuqdN8e1XgB6ex4zajzWFN8UOhivdV6omI/0dbT/yrec4iYBrzVZG5JcnMCV798j3nxf25XNobigtBEZLPMkAK+jhORiKDoscZrTF/IBE58bkMqB00IUwMkxYpR5+s+ODghvXecp5x1zgqDrYdMyiFzNh2+0GswqEtCWnpUrwGoQOi+H9HyHQ2CYHrXACvGDh6FDM+duv1UwfUAsbl1xI3t2aOvtbTMPBH96GJgmjUtNEZ/ir28OOZD4WkqzT9taU+qfKF8RX/SNB7hR1O1q9Kl+USZtmSuACi/NRQCvH7HCUGS4ErXrySKilY5kdeKEOArVuoG1F4wUOs2fu+YOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUaSbaAN//PPpfk0fApwPF0suG0Sf+jA4NmUJeeVnrE=;
 b=aCCVb2N5XBFL6g1Dk2LznXmpFCZpouw78D6EBdWaL2JhRQa4rllL3YKB00I98ClSsOP4QRGAYuaPx47gNMolOnuCch+9HKarYVZ0d5i7oXn/gUGIimr7w78BXOBW40OeR8CyTLeNLMIiLEpMIGCI8X/FVfwbgFj7CyslubfOxWw=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BYAPR11MB3494.namprd11.prod.outlook.com (2603:10b6:a03:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 03:03:54 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::c8d8:a3c5:9876:d589]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::c8d8:a3c5:9876:d589%7]) with mapi id 15.20.3391.019; Mon, 21 Sep 2020
 03:03:54 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kiraank@gmail.com" <kiraank@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [bug report] Bluetooth: btintel: Add infrastructure to read
 controller information
Thread-Topic: [bug report] Bluetooth: btintel: Add infrastructure to read
 controller information
Thread-Index: AQHWjZ/gVkmoNz+emESKM63nVsqm26lya27g
Date:   Mon, 21 Sep 2020 03:03:54 +0000
Message-ID: <BYAPR11MB3141AF55929E6AE9CC0225DDF53A0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <20200918093902.GA882111@mwanda>
In-Reply-To: <20200918093902.GA882111@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.182.228.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c1c491e-6d32-4faa-63cb-08d85ddaf992
x-ms-traffictypediagnostic: BYAPR11MB3494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3494E12C3CB75B8DD943B5E3F53A0@BYAPR11MB3494.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9joGlFKt1W59naR+OFTdDV7rLZzmwDllxtm24rQQqgdLItPtI9dbPnbpHamHKdTgKeVICiaXqiBGv2JAd7MHRoJsLgPGQBavhBbB9AOdbn6hpTrLWXba/1XOfnCIbX5Y2Rr6UTjuodDyCZ5XYgoQYaEB7qWKt1nmxSW4uAEveBnoXzykpY+LjELo/kUcxRFLkubCArai8XH2SlGeGRco8hiCi4PvoEdJQ4Ekcxl9bED8UItwuGIzzkYWUKebKgKblbSXopCxqHVetkegbwBO6TzbK0NNoECf8dtMLMsZV1Zj9JkW9yXjNb9GnaXgjuOudHIFCnGiABvW4PlBdXkbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(71200400001)(5660300002)(53546011)(6506007)(316002)(107886003)(86362001)(33656002)(8676002)(478600001)(52536014)(55016002)(7696005)(64756008)(186003)(66446008)(4326008)(66556008)(66476007)(54906003)(76116006)(9686003)(8936002)(66946007)(26005)(2906002)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NZNi4JGUoIodIH0EE7sGoUKTPBp8/57ryu5+YoHh2SoGnYS+vCN3U9QogkKTDSdwuXZAfI/feIem/npDmwsYXr16G0QJj1gjol+SG0l2ebzUs+SDctSFuYRnf0SyczDstY516rxBVuaWjAo5Brva0TuwFp+nvNFKUBlOzp9UCn6GWvyIiyQUaoCLSn6xDXjPbPTqC6flL6wUfmxp74Le/UQXMq6CRFQ6a6Ud0NLiwAAiyrhGcNpB2M/dbIicH3fkXzq1o8uw/gaF1G3H1PcyzawCXMpd2y6EIx+mUEJfii4/LN7V528gTykz4nh9+6+kXGZerKTc2ggKSw+YqMpQYN4s3qVCtCfabViXKsJ1/Ea/244N8T/Va4Fc9by7jkDz2gYzxIXSuDI7NKwChArPsjz9wEeCm8AIhnmxxM0EjUd9ylHHAwb+yf8uYA+OqRVOSPy2EhVSeGygqLPtf6vIDBB2W28UVTRLLS9OOICehZ1W/EmWIHDd+hno+7AChD00ffLaikPLgemDX9Uu4w+PZKYMbGAfXiiJ/Epwwg6IIvBs+1fURzKCThSB1C5j8u5Hs5zAfOHrUXvM5G0zx9sjU++Q42dYGyAl5czqhrivnNhUhFmQzzFlWSTyEYkkwTTJDJkAlK82H1nV/d92v1AoDQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1c491e-6d32-4faa-63cb-08d85ddaf992
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 03:03:54.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWIfAMO69FQTh0tvi7hBVrMPPO6ZJnIPdvzzdFf2YvNXvXRDp36j7Ur1GvpHNrhoEoI0P/y/2wjM0MSoAyBQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3494
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

Thanks for the comments.  For some reason, the static analysis tool I am us=
ing didn't report these issues. I will submit a patch soon to address these=
 issues.

Regards,
Kiran

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Friday, September 18, 2020 3:09 PM
> To: kiraank@gmail.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: [bug report] Bluetooth: btintel: Add infrastructure to read cont=
roller
> information
>=20
> Hello Kiran K,
>=20
> The patch 57375beef71a: "Bluetooth: btintel: Add infrastructure to read
> controller information" from Sep 14, 2020, leads to the following static
> checker warning:
>=20
> 	drivers/bluetooth/btintel.c:490 btintel_read_version_tlv()
> 	error: 'tlv->len' from user is not capped properly
>=20
> drivers/bluetooth/btintel.c
>    426          /* Consume Command Complete Status field */
>    427          skb_pull(skb, 1);
>    428
>    429          /* Event parameters contatin multiple TLVs. Read each of =
them
>    430           * and only keep the required data. Also, it use existing=
 legacy
>    431           * version field like hw_platform, hw_variant, and fw_var=
iant
>    432           * to keep the existing setup flow
>    433           */
>    434          while (skb->len) {
>                        ^^^^^^^^
> I feel like these days we are trying to not trust firmware...  Smatch is
> complaining because it distrusts all skb->data information, but unless th=
e
> devs at Google have a way to connect a fuzzer to this then trusting is
> probably harmless.  Anyway, the rest of this email assumes that fuzzing i=
s
> possible.
>=20
> If skb->len is less than sizeof(*tlv) then it will read beyond the end of=
 the skb.
>=20
> while (skb->len >=3D sizeof(struct intel_tlv)) {
>=20
> But struct intel_tlv is variable length so it's more complicated than jus=
t testing
> while we need aditional tests below.
>=20
>    435                  struct intel_tlv *tlv;
>    436
>    437                  tlv =3D (struct intel_tlv *)skb->data;
>=20
> if (struct_size(tlv->len, val, tvl) > skb->len)
> 	return -EINVAL;
>=20
> The length has to be at least 1.
>=20
> if (tvl->len < 1)
> 	return -EINVAL;
>=20
>    438                  switch (tlv->type) {
>    439                  case INTEL_TLV_CNVI_TOP:
>=20
> Ever test which is reads more than 1 byte has to have a check:
>=20
> if (tvl->len < sizeof(u32))
> 	return -EINVAL;
>=20
>    440                          version->cnvi_top =3D get_unaligned_le32(=
tlv->val);
>    441                          break;
>    442                  case INTEL_TLV_CNVR_TOP:
>=20
> Here too, etc.
>=20
>    443                          version->cnvr_top =3D get_unaligned_le32(=
tlv->val);
>    444                          break;
>    445                  case INTEL_TLV_CNVI_BT:
>    446                          version->cnvi_bt =3D get_unaligned_le32(t=
lv->val);
>    447                          break;
>    448                  case INTEL_TLV_CNVR_BT:
>    449                          version->cnvr_bt =3D get_unaligned_le32(t=
lv->val);
>    450                          break;
>    451                  case INTEL_TLV_DEV_REV_ID:
>    452                          version->dev_rev_id =3D get_unaligned_le1=
6(tlv->val);
>    453                          break;
>    454                  case INTEL_TLV_IMAGE_TYPE:
>    455                          version->img_type =3D tlv->val[0];
>    456                          break;
>    457                  case INTEL_TLV_TIME_STAMP:
>=20
> if (tvl->len < sizeof(u16))
> 	return -EINVAL;
>=20
>    458                          version->timestamp =3D get_unaligned_le16=
(tlv->val);
>    459                          break;
>    460                  case INTEL_TLV_BUILD_TYPE:
>    461                          version->build_type =3D tlv->val[0];
>    462                          break;
>    463                  case INTEL_TLV_BUILD_NUM:
>    464                          version->build_num =3D get_unaligned_le32=
(tlv->val);
>    465                          break;
>    466                  case INTEL_TLV_SECURE_BOOT:
>    467                          version->secure_boot =3D tlv->val[0];
>    468                          break;
>    469                  case INTEL_TLV_OTP_LOCK:
>    470                          version->otp_lock =3D tlv->val[0];
>    471                          break;
>    472                  case INTEL_TLV_API_LOCK:
>    473                          version->api_lock =3D tlv->val[0];
>    474                          break;
>    475                  case INTEL_TLV_DEBUG_LOCK:
>    476                          version->debug_lock =3D tlv->val[0];
>    477                          break;
>    478                  case INTEL_TLV_MIN_FW:
>=20
> if (tvl->len < 3)
> 	return -EINVAL;
>=20
>    479                          version->min_fw_build_nn =3D tlv->val[0];
>    480                          version->min_fw_build_cw =3D tlv->val[1];
>    481                          version->min_fw_build_yy =3D tlv->val[2];
>    482                          break;
>    483                  case INTEL_TLV_LIMITED_CCE:
>    484                          version->limited_cce =3D tlv->val[0];
>    485                          break;
>    486                  case INTEL_TLV_SBE_TYPE:
>    487                          version->sbe_type =3D tlv->val[0];
>    488                          break;
>    489                  case INTEL_TLV_OTP_BDADDR:
>    490                          memcpy(&version->otp_bd_addr, tlv->val, t=
lv->len);
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^
> tlv->len comes from the network and it's 0-255.  If it's more than 6
> then this will corrupt memory.  There is no caller for this function yet =
in linux-
> next so if tvl->len is less than 6 will that leave uninitialized memory i=
n -
> >otp_bd_addr?
>=20
> 	if (tlv->len !=3D sizeof(version->otp_bd_addr))
> 		return -EINVAL;
>=20
>    491                          break;
>    492                  default:
>    493                          /* Ignore rest of information */
>    494                          break;
>    495                  }
>    496                  /* consume the current tlv and move to next*/
>    497                  skb_pull(skb, tlv->len + sizeof(*tlv));
>    498          }
>    499
>    500          kfree_skb(skb);
>    501          return 0;
>=20
> regards,
> dan carpenter
