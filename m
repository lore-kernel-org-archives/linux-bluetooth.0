Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54830C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 11:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CDA61358
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 11:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhFHL5q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 07:57:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:59385 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhFHL5p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 07:57:45 -0400
IronPort-SDR: U4LfDyDec62JSKwUMiZ8kpNMrqDE8s2PsPZXaTOz3BEX2vK/rLMUkRc8W9pZ0jnvXnIfdQAvaz
 YBQECxnJDRcw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="191936038"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="191936038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 04:55:51 -0700
IronPort-SDR: 1gCpffrDmlMpQSi0B9C9lHgFVAUGr7nXKqHIoGz9BOLzljZG8Rn5pzVXekl50wdaTjMRIR+3Dj
 8wKua3cKromg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,257,1616482800"; 
   d="scan'208";a="447868966"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2021 04:55:49 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 04:55:48 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 04:55:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 04:55:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 04:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dio9HySDZrEp72tG/6NnjPSfjSZmJ9/XZRxzrDKyza/okNge7BIN6R7b1NZBDrHaABBMc/S2AYqJsCTk4KAhI3vHGfQBXRygKbOInHogq9ZBnsszQ3c6nwTVqHI4ykQetK1VTEfmGtIpmrdhsgNTy3rJYVAj5JPyXq3g4NgSrBRxd/Fj5fZJ+zXEqxDchrjpe1ea3GUavAy7/9hXa8mmfptX8uGs51nNerlbN3nWPXcz4UZvo9KyXt7jX2Y5x9nS/xTFcyrstgJzxxwFPeo7f28aprvGGQj0RopFA/OOziqgEpPQ2Tw5LAN6HGmKYqvAOAxB/tlxbkgCmgh8i1lNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7ojSRFP4RiV1Kbvf12hN5IeCaQ0DyRE/93H6+lHTlE=;
 b=DdKRm8nnkk5Pt/9cp1RffOgKm6Io9AU5VBUIJ4WeWL5llOF01KgCKACTnkQKFVVlT6f8aViJYmBM2z5VrKWnfTrZG4f3EM1JyPKnaubI4zRLzG2Pkk0nU0VrvOjUv7DG2ecNWmx5zalSDsLc7nMBiELSAMaKYjGgQOBGFaZ6CZud4vcOmp2nEx+Dhpket55HIwnl8p7PZzfV5PnIEdmeObeHBvwYtSVF0u3FZStC7l8rV1O6wFhY0xaNKerzy0bY2NJ/kNcoroxcfp+PQcPvttScP2LWl8HA8Wlvg4WAsYj274Z+y4NMhBBWPZOVtJ+9zVO0Ddsae0eBj/EvCjYt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7ojSRFP4RiV1Kbvf12hN5IeCaQ0DyRE/93H6+lHTlE=;
 b=TtHVN/Rl+Sww+t9VctiWJwlWhBnTA8rcLq7Xn8rDztKy8hS9OFUwm26FsHo7v+skwWSZmrz2Ptlws59rMPsn2JnnHxhQjcaLZ44GGXthtD3WJM274buGj/E93kzjBgomuUbGWdrtmtTew2pTjULuQq9cxFoyzbj3/o1rWbOh1gk=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Tue, 8 Jun 2021 11:54:41 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 11:54:41 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v8 1/9] Bluetooth: enumerate local supported codec and
 cache details
Thread-Topic: [PATCH v8 1/9] Bluetooth: enumerate local supported codec and
 cache details
Thread-Index: AQHXS9InxhcOGKEB4UyX83ZyjjBSQ6sCcHGAgAexhqA=
Date:   Tue, 8 Jun 2021 11:54:40 +0000
Message-ID: <DM8PR11MB5573C69D2C1A299A172EBDB1F5379@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <23D52481-5703-48EC-93DC-1674C0B3CBB8@holtmann.org>
In-Reply-To: <23D52481-5703-48EC-93DC-1674C0B3CBB8@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.169.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e57de3a5-85bc-4af8-6393-08d92a743315
x-ms-traffictypediagnostic: DM8PR11MB5637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5637302278424C07F22399B1F5379@DM8PR11MB5637.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KV3FeZDuB2utVahaoolXs+4dsgvH0fy6MSFTjg1cptd46g5uX1spuO5pDMOCf0ILrzfkFmYB1u9lEYonqW463tTn180pwnbBGZJU0TXUsGv/5A6hTRXwuhYPCdUrE+BrFibNKdGI222iR6BhnbfTCfeyA/N7ZHIoO1WCM2Pk2T/9oUa1jat4A/mcMdGqqNW4IsRDKzfWCVVQrmH4Uykqt9YYINccF0CUGXyYChHNyqjsO3fG6uDWsQ9y4dEo8R8iD46WtnQqAqBFmMGCD0bAH/aTc1mjBVdz0SSYYCebwAww+Kc3hniyw1QIx7hI8L0ElsfOKJpb+HugwlReiEQrm6B1CgVYsx06hSigabOAWrIOxmRsIuqvHTVXhPuoc20amhHUgmcn32Q+XUf4fte7UbkIPVSlNx7/ZVcup3TXX0mCGOYjCih86ZTSZWooWt6DpO0OZ7Shd1BwMr01KJyIqzqaHkjfPdyD5ER0dCGO74rIHEbl/5MSyKDKYciosOCBeDTsqqvB31KsM3qgitXE/cG8lJnmymDCmfQKnq14X9X66i8EesDck83cac+smAMF59Q3hHlaL1Ba1MVPgpBIzyuqqJJyDT2zuqWIRf7TyU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(396003)(346002)(71200400001)(66946007)(66556008)(66446008)(26005)(5660300002)(4744005)(186003)(86362001)(76116006)(7696005)(8676002)(38100700002)(107886003)(55016002)(9686003)(6916009)(122000001)(8936002)(2906002)(4326008)(316002)(54906003)(52536014)(64756008)(6506007)(33656002)(478600001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiaIICCkzHNPe/vvu38/EpeoIyGkURL8MCt+od4yIXMoR/J3IW4wr4r5LRyA?=
 =?us-ascii?Q?oM3rsccXv3K6sY8bECfo/WByNuj1LnEknAVh4qZ6Q1/hvm41+ZNrMZU2RMU7?=
 =?us-ascii?Q?8qp9mXEeeTK+zP7GNg2M0tbIIL/Nido4WG77Cg5nBuuhc5bVCqrQw4bMocCo?=
 =?us-ascii?Q?M+8Ex46R8IxGIvleUVYtIdrbSP6FUIl2dwyM5nrV522em2vm3uEKLViKobyf?=
 =?us-ascii?Q?AsGa/GPhyC5anrqvJTvQUNR1D3UAd6XBlMuxIpQZAZ1eC8d8X0aXKU8Wlclv?=
 =?us-ascii?Q?J+nZiseD5aR1/xag4x6ED6zgeQdL5hoMuyqajr44HtM7neYbRVLTJP4h2wiP?=
 =?us-ascii?Q?qjsoRP06NTUttcIlEWtwvo2iOOInR0H1rLjTVliKQEZupEqWnjHqwgSgkKob?=
 =?us-ascii?Q?PSWH7CfD4cz58XhNkV6fNGvzoxGstOQB5rmmx7wvNY2+o4tYG7uijhzKYa43?=
 =?us-ascii?Q?+P+GnnnFPE3lKWMH6f13IOj3Xa+7+h3GBSgG7coRozYF46gEComFRP1F9MbU?=
 =?us-ascii?Q?YW8Y0BLh3U3BMaBeG60ktpYYYq/ykVqyE+VQC+vgqUpA19WP1DL0a5+e122B?=
 =?us-ascii?Q?Qn/ilq4uWWniFA1lW45oLXWNx5IrgGjRAaZj9yfaNfRw/US2fdisipPndg6K?=
 =?us-ascii?Q?6509MN8IHUT/LUFFyKAW8W53y0mtn9+qA4XpTg+x8Vp8iW48GmXnfNhnNN/e?=
 =?us-ascii?Q?+V2/fPMzdU5LEOALuiDeNMDJYiuF/OA1WWxqBKh3d1fQr6CSHxgLHOXNjcXu?=
 =?us-ascii?Q?cVl8qKR+WwSjLIHpA6BCoyWwzceGWm5tRd8aph6T/VCAAa8Uqx1zf5uyb/cy?=
 =?us-ascii?Q?bZRTWeUTnTuVw7PMUKq0F8VBeXFv6V91dXitrXwtsGk4RX3iEdBX+GTBCAV1?=
 =?us-ascii?Q?A0Pg4rwNG30jiOfA95nolEbR/tUWj+qqtULZ0tfDUYPWOIQEX26wNESI8pL6?=
 =?us-ascii?Q?BgeUi6VcwXT/hbljGhrojU0iLu9geqXLCSTWRpbabBrzL6duJa4TwwEusYov?=
 =?us-ascii?Q?jexvOaB9b0Uocjdxj4W4fDKqH/eGHuJBWXhScMphMMkdVp2YA+U6rB74KwgQ?=
 =?us-ascii?Q?me8aYf3lXzeEHIx+wecwXdh8+RaFPVl5KC9ANLz1HGEELjniJC45R+nH+ZkB?=
 =?us-ascii?Q?hrlj44Kad79ZIDaSkHf6v253AJIY/jiGpV/weGIMypt2x4My5HeMBFfMNCPw?=
 =?us-ascii?Q?kNySB33+Lz7AweiEnMWjh1Hl28VFThYg9+98FC+wUsk/BEcziMBkDkkmvEJY?=
 =?us-ascii?Q?pDgIE0ES8kPPbcdpw0Th4bSB19hjeHBsCQyntn7+KwaUjmrFaJv9VfwltYZm?=
 =?us-ascii?Q?WAccsB5pfYXGghChEZ3N2Vhj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57de3a5-85bc-4af8-6393-08d92a743315
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 11:54:41.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIDyZa64h4k8q7QIoBLScgWgxnXvcIGP5x54hCYfu7//EaTur25rxb5+PqphdxdWDRCr8G7l+TquqMt/dWAWYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> > #define HCI_OP_READ_LOCAL_CODECS	0x100b
> > +struct hci_std_codecs {
> > +	__u8	num;
> > +	__u8	codec[];
> > +} __packed;
> > +
> > +struct hci_ven_codec {
> > +	/* company id */
> > +	__le16	cid;
> > +	/* vendor codec id */
> > +	__le16	vid;
> > +} __packed;
>=20
> I am pretty sure that I said to use vnd and not ven. The shortcut ven for
> vendor is not something we used at all.
>=20
Ack. I overlooked at it.  I will fix this in the next patchset.
=20
Regards,
Kiran

