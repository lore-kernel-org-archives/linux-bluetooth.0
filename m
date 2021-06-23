Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2953C4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 03:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774C461001
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 03:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFWD0X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jun 2021 23:26:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:9081 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhFWD0W (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jun 2021 23:26:22 -0400
IronPort-SDR: sIAg4yqjr/pgrzCTqhxsb5kM+006UumZnkGHEuS2ShiZLgBzl0nMwgQre4wi91+Kbh93czLCam
 VzAX7ugzT5YA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="204178687"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="204178687"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 20:24:05 -0700
IronPort-SDR: uLaBR5g3mTK9l+kaDJbz8GagPs9ZcCSCrEm8RN0VbiHZzJ3h44HnhT2TPcoyjiPcE7zSxNtvM+
 RVASxJFF6FHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="641848027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2021 20:24:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 20:24:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 20:24:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 22 Jun 2021 20:24:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 22 Jun 2021 20:24:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRJzD9gAvMKBsWkvYcv+4YLGK6FDxXYF/pBeCbJxtvaLAUg5VM3DGPXMr5BYRZ59xnMqiHCJOqOU0jW9V202QjWUu1Q4qlNruvo+Nu6Vk9i6/FQksV4dd8pof5Kvs2ueH1UUhUntZcYxcpR0/3hdbKyy0ESvqCm/+Je8wu5M1MM5BBIorRmW80EsXtqpQ9YCrlWMchn5U3hJM+cJjUYtKGYKt6gGuZsRKX48ZQl4iRKJx8JqNg+fewHHCJ0cf3u14dHUdVBgCXa4WJcZchOWSEr9XkldvFFdceYMA9MtgbaAEQaiRCYn+TEeP7Z2s+riMw4htqHqu09Uz3RWK4w/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAwWdHTEBUOpVGY+dEeVSPMjv3Xgvc8i99mKn4apsm8=;
 b=Jr653YexWi8p+P13AXet1uF+dXjvKd+4ZM0uasYf/b4h250NVJ+VtFQwmrUdx2BkKGm4PmywDwTbru0Ls5a3iqXri3mnRfDstTWSFUi2TeiuGHRpNH9iLlXVD6YwFS59JaphDUlL+35EUeBGvbp1iWLwJahtNQf6DB0Zd21dMFUleZIU1SWny+YOtNK/TUlyk+U6yPkA8Rf0Xy8WH7suorSTf2a5fdeRTZXKn+TecOilk7xavKEv5E2YB4lB9R7mc8a4tdYIN6Feh3TjFn1dF9hicI3sR5Aw6Z92w5B+oOW4DK3Me/9JIQq/7suz2e4eTyIEe3wPyOzOFOwdyvF3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAwWdHTEBUOpVGY+dEeVSPMjv3Xgvc8i99mKn4apsm8=;
 b=FJg4vKretI/AKa1NqN3ZWDnlDRAZjkeAi/AvJfqeRla1O72G8TyEAiZ9+bHyYl2IQrqDRJoXAmBR9dNy98jeO2hLsLZBl15QHKsntY7wJzHAakF3uBC1gmlvSyENDOvCj9y7mxwOeBp7Ns0+JyZM0DmxbDWMb+OpvTR/tEdyPg0=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5669.namprd11.prod.outlook.com (2603:10b6:8:36::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 23 Jun 2021 03:24:02 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c%9]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 03:24:01 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v9 10/10] Bluetooth: Add support for msbc coding format
Thread-Topic: [PATCH v9 10/10] Bluetooth: Add support for msbc coding format
Thread-Index: AQHXXGDO/3TdA4SJhkiMoaR3Yfh+MasVhL+AgAuANUA=
Date:   Wed, 23 Jun 2021 03:24:01 +0000
Message-ID: <DM8PR11MB5573E6535A15DBE24306AE1FF5089@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-10-kiran.k@intel.com>
 <AA50351C-7DF2-4732-8493-A57616918B11@holtmann.org>
In-Reply-To: <AA50351C-7DF2-4732-8493-A57616918B11@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.181.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f15e8b57-675e-4591-8c36-08d935f658e9
x-ms-traffictypediagnostic: DM8PR11MB5669:
x-microsoft-antispam-prvs: <DM8PR11MB5669CF7DF62A3461FB2776C0F5089@DM8PR11MB5669.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ppsq7c8FjkCeZ5cMYSFAcQqyZW8WU9WldCDUzy+0mRTmtfc9S8TVf7F78litDwkPEN8rDnvmlOFd3mmDQUNg50aa7IfdwQebEOvC9u9cCJsxp9ircYSMNVZaCIZfNgJGBkK+SqYJxtw1g8MXZXCOdTJrlWBOJkQKqd8megRiT7GiKeLzmyUZUZ2/MORLgjupJ5ddt6NcZm8vUEom0GBKX/1NmhJ/P6p0bs5Xb89hkKq/vT2f1stXwcdDMNgAdsqFGBMYc2aszses/k4y/shb7s+AYYGMQpxMqt6C0MV90PKDpMX9YKH0XdmjIEmWv+QZq0cXPLT+UON9SxVMGJwfnKT1JYl/cJl0a5gPaX/gXfpRhM5pYFGUY4XRz4brgPP6lKePfQuxiIfEE+y6rNeyEmFWlv5gI/AksRJpY6Xuefuy7wLvnPVJA32i4C9xVsmeJunWz7K+xsflqaLc35KEazHh+hDoTYMVhBN9hv4KVfFmA9Z9MRc6UdPZNhKSiWqy76vMQiprq6meT7LyC/eINNsWb7U9OJeC1i6YE+d8i6m40s3Mcj19Lv4WJq01Q/ujkGnGt0SW0DKE+vPfHkAA1siyLc/4t98tRjNW1VN1pI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(478600001)(8676002)(7696005)(66476007)(316002)(66446008)(66556008)(33656002)(6916009)(2906002)(52536014)(66946007)(64756008)(76116006)(5660300002)(53546011)(86362001)(122000001)(38100700002)(26005)(6506007)(4326008)(55016002)(186003)(8936002)(83380400001)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jpV4YwYiiX7VnVu9AjY+1b/SaG+96tYWOP0zSCdpOTwti6eFAAAmcFTWixM0?=
 =?us-ascii?Q?YIrsSdyO9eedMVvhFeK7yZS+DfgIw2oQHqnfJsIJ5aKWcgNhj1zGLFE90L07?=
 =?us-ascii?Q?LtCLsh8lihEiHKj//1Aab0GhtlkzPQfEbjjxUbVYNwM+VqBnqUAoaWnr4M9p?=
 =?us-ascii?Q?KV6gC9A4ui56H7DqnUTewwI4Yps9OnBbGq0sYS9WFOKD7c3JWw7lHMWT8toI?=
 =?us-ascii?Q?x+HiHBp0yA7jp051tFclOtc6rlwp5KzI9aouqVubzTkZpyjCDdPR4++ayhgV?=
 =?us-ascii?Q?wpQj3WrJu/5t1yGM0BY8YA3UDgDx7MJ5tzMNMUbPrNL0i0WPyxS/fvB+yt8u?=
 =?us-ascii?Q?dQy3TonN3RZ8W4c5thfuc0lKy5kmvZxYe9krvbz/w84BBTDSE+rfnZyw5PJI?=
 =?us-ascii?Q?eRhJo7rl7yYT8M4gvZQuSCtFcAKf3KIgl+9NQtcpW0HtYqgzADIFeCc3Hc4Y?=
 =?us-ascii?Q?P4Tn+wkxVl8/rBDIKcYs7CfLEOQOcB0lRosw8Hc91XD1tFJdKxEgqS9Q7cPu?=
 =?us-ascii?Q?RjS/cbnjStlSitXZHZOdt4cz6iVpA2Ii2zOZuzla3IiVoqCt7bs3Ca3ww32z?=
 =?us-ascii?Q?FPqU+ZfjOT5H6ChfCBGBQeRq3+hG/6a/TReT1wfz3cAsKFlBCpwtKHgZrQrU?=
 =?us-ascii?Q?4njDVTlqkeIGtTCbww0RWVVBH9ivZRkpMJGoN1iSRsMKBp57WRvcgiSu8Z6R?=
 =?us-ascii?Q?7XLb+ePcgRSziOWqVRgEtkoa2dVjZPYMOrpTD3x8+tQ1gdKo1xPGUuLI5yJg?=
 =?us-ascii?Q?H6Jc0dPVQqZe1Lr7hXy/csIMP/JEE5aVFKk5jCIMDGEmHF/ebYtk63onvzkw?=
 =?us-ascii?Q?HGudqQaUDsTP9Jrgv1J0nxy9bZCKX+XeFX762AkwObFC8esQz5YLSou/HCGJ?=
 =?us-ascii?Q?oKnIl8P5/HZOwrCEdH7mzXWjjHUUPzGy9ONj+cPUajVBdgPUydhUhanTB4BV?=
 =?us-ascii?Q?24/DZ84Hy2H25zorV64qpqVq0ubgVk1tW6Zfx5jRlll0om8KMsvmqm+mRb2J?=
 =?us-ascii?Q?+tg4qbVU2dAxTA5NTE+1lRAY05DgqI/l/smL4mvVOxxz/ETBYqBoMoQQNHdB?=
 =?us-ascii?Q?TDs7u7Q3UD8s0n8IuNByz0wPe29S684vQ+xKhyLOKZwcG7LaLqjY0L4s+HAh?=
 =?us-ascii?Q?wvZBQwFjwuQWNpmN/HdR03UC4CjrOIwOmklq51prOWWm+gxgQ4pLUOg9sKtr?=
 =?us-ascii?Q?PBmR/CKme+MMoZC439X4/zSUYCNndfbAkXnz4rgFlIiHJ+axhidDLEDEWSwp?=
 =?us-ascii?Q?SPnJA9ktsX36cFArSnf9KmQ8kx0G2G8wb+L0iCYW2FY9ycdWjAs3iLC9AGIl?=
 =?us-ascii?Q?D+F/EU474mn3NeeiRZcczQ8u?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15e8b57-675e-4591-8c36-08d935f658e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 03:24:01.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yWTRSI6+ZbKaf+zDVRJ0mNw1mP8GxvoxgFCFlLixtloy3XNtvixV5lWhnu41XHZCJCZ5hC8g8egku6EHwtTgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5669
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Wednesday, June 16, 2021 1:14 AM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v9 10/10] Bluetooth: Add support for msbc coding
> format
>=20
> Hi Kiran,
>=20
> > In Enhanced_Setup_Synchronous_Command, add support for msbc coding
> > format
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h |  1 +
> > net/bluetooth/hci_conn.c          | 27 ++++++++++++++++++++++++++-
> > 2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h
> > b/include/net/bluetooth/bluetooth.h
> > index af2809121571..056699224da7 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -175,6 +175,7 @@ struct bt_codecs {
> >
> > #define CODING_FORMAT_CVSD		0x02
> > #define CODING_FORMAT_TRANSPARENT	0x03
> > +#define CODING_FORMAT_MSBC		0x05
> >
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c index
> > 9569b21adb88..73c134459361 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -328,6 +328,32 @@ bool hci_enhanced_setup_sync(struct hci_conn
> *conn, __u16 handle)
> > 	cp.rx_bandwidth   =3D cpu_to_le32(0x00001f40);
> >
> > 	switch (conn->codec.id) {
> > +	case CODING_FORMAT_MSBC:
> > +		if (!find_next_esco_param(conn, esco_param_msbc,
> > +					  ARRAY_SIZE(esco_param_msbc)))
> > +			return false;
> > +
> > +		param =3D &esco_param_msbc[conn->attempt - 1];
> > +		cp.tx_coding_format.id =3D 0x05;
> > +		cp.rx_coding_format.id =3D 0x05;
> > +		cp.tx_codec_frame_size =3D __cpu_to_le16(60);
> > +		cp.rx_codec_frame_size =3D __cpu_to_le16(60);
> > +		cp.in_bandwidth =3D __cpu_to_le32(32000);
> > +		cp.out_bandwidth =3D __cpu_to_le32(32000);
> > +		cp.in_coding_format.id =3D 0x04;
> > +		cp.out_coding_format.id =3D 0x04;
> > +		cp.in_coded_data_size =3D __cpu_to_le16(16);
> > +		cp.out_coded_data_size =3D __cpu_to_le16(16);
> > +		cp.in_pcm_data_format =3D 2;
> > +		cp.out_pcm_data_format =3D 2;
> > +		cp.in_pcm_sample_payload_msb_pos =3D 0;
> > +		cp.out_pcm_sample_payload_msb_pos =3D 0;
> > +		cp.in_data_path =3D conn->codec.data_path;
> > +		cp.out_data_path =3D conn->codec.data_path;
> > +		cp.in_trasnport_unit_size =3D 1;
> > +		cp.out_trasnport_unit_size =3D 1;
>=20
> so s/trasnport/transport/
>=20
> Please spellcheck your structs.

Ack.

>=20
> > +		break;
> > +
> > 	case CODING_FORMAT_TRANSPARENT:
> > 		if (!find_next_esco_param(conn, esco_param_msbc,
> > 					  ARRAY_SIZE(esco_param_msbc)))
> > @@ -383,7 +409,6 @@ bool hci_enhanced_setup_sync(struct hci_conn
> *conn, __u16 handle)
> > 		cp.in_trasnport_unit_size =3D 16;
> > 		cp.out_trasnport_unit_size =3D 16;
> > 		break;
> > -
>=20
> We can not have these random hunks in patches. You need to review your
> final set before sending it out.

Ack.

>=20
> Regards
>=20
> Marcel

Thanks,
Kiran


