Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCCBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2A060EFE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhHNGnR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 02:43:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:42208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhHNGnQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 02:43:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="195251496"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="195251496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 23:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="486303288"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2021 23:42:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 23:42:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 13 Aug 2021 23:42:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 13 Aug 2021 23:42:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQBm7HA0q7VlZ4m4z0s63xeKqgSQvnV37/ABJcCr/pyogHVy3KYr0wKXWVdWdObF+zDhpc1TrZzdlbaiqNsNsp9QQSSyuvrOZ1JcfPQFlrcCOZAJ7GJBpgBaU7jxe6drNf28AduApys8f7wj1Xn7gDOMoTasoBQc4zh3oKeG+OwDxBnmjvSC3jZb5hwiqZ/j+cSVdKyOS/j/pCSCvhyylEnOZuVQGL0VThrb6cxbupZuf6n7SovTNve8+fEzluE0hERROhSN1TFlVut3mZD//jbCP6w4KMVNJzXAknqybSdZsBTN3KGAT/I4HENSlzwlAEWUqaIxLrk8Fne+yXokWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACt2Q+L2A3r7Um9vBs3/VbVG651WQ0Q0kE6YD7vyDIQ=;
 b=KHLY2YSJPl3fp8kWWwFPYbhpjHX5vbuPdOiPSPIDi/lLHzrAYwf3LCTXP7s/JSXQyUuCo+wL9LzZVilw3kKU1eew9K4zlM3dpGSUJ6m/5YW775HHplLptBIthJCuH0clcx2mE2wwOWK31J+w5XVfDoLLP3cQLiENHPSWR3A5air5imQcB96tUPhzDuiexnbZXxy3qNUaFQNvkCOPg7sfsQb+2ySm/S5JlbBfzz19H9p7pW6IxZCL+XCK/Tu6WyT69ZwqnOY6e+J6pBVu8D26hjOIJIx3XBUuC+TructBeZdA9BgphmeprWWMZlTk9VYbLe54IaHD2HwsXgvqUo9soQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACt2Q+L2A3r7Um9vBs3/VbVG651WQ0Q0kE6YD7vyDIQ=;
 b=En4ueI6EGNtT1j3grhEGsB+f05GoTCqOGcS6vC7wowhPOzEIo21PaJSLeiO5kuzDSwACyhi8i/cWLU1d9CyCHle2WpPbNJYtVIrVRNk7woTw/84wzMlw5ZHibnxaqvdbg22QuqKgx5LiGt67+HMYJPe1WbuUjXeoQugcRuI2mEM=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5605.namprd11.prod.outlook.com (2603:10b6:8:26::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13; Sat, 14 Aug 2021 06:42:46 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.021; Sat, 14 Aug 2021
 06:42:46 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v11 10/10] Bluetooth: Add offload feature under
 experimental flag
Thread-Topic: [PATCH v11 10/10] Bluetooth: Add offload feature under
 experimental flag
Thread-Index: AQHXgsNzJwdxuUmQjUeDAWP8SkdvwqtblwAAgBcShiA=
Date:   Sat, 14 Aug 2021 06:42:46 +0000
Message-ID: <DM8PR11MB5573DC741369CD1D63530FF5F5FB9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-10-kiran.k@intel.com>
 <E940626A-E8CA-4AB2-AE1F-B3F1CCE07D4B@holtmann.org>
In-Reply-To: <E940626A-E8CA-4AB2-AE1F-B3F1CCE07D4B@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c96c1ec-0a90-451c-f7c7-08d95eeeba08
x-ms-traffictypediagnostic: DM8PR11MB5605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5605A9A74C85502A16C81D55F5FB9@DM8PR11MB5605.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8hr3X3JWHCB2fDudDLD9s0DO08yoEnQtWNlFEafVwwVCLBTX1wrxnToI9KNTx4oXDi/sjN0Gs+w6hQ82OY8tTWAaLrykKI4tC1w36tVJcYB6A8bLJbqg6wwSyrHQU8zWdU08gnIHvNEhm1mBYcm2ccn+HP3+lHaCfxBytwoA15b+VQP1Ai2obAOTOWTChuAmvw4bNdl14sjATzcXzJUHA0VK/XY/dsqODUANZKwglY/dQJIO0DUJZc0zW/HQY3GiKBWFNzBvqA2d7gxfWH7UjbSRVzjtPZ8Qpa6UbZWBtZuI7tVat7ApBZYp+eQuGYfjTJ7pu5BK7HG0u36kTQ029uLOqNv5FVdOnPNQoP1txwO25l2EqZ9WlGg5xTlb1NKc/jsiCxiX4GQDx8EzY3FZdo7BX67Yx4+PT/qq7W+JyCStGLQiYqp25JLL5X+xfes5kjZOLfBz9xMFRRYsAq6q4DAYu6mUDzRJvWiRfiZH1JqYGlUtpZy3Ip3jIrHqIIqDtuJBig+OylK/ugc8T14bTi+OUvcg/9QJ1wsTb0L564atxHLKIjC+UTi47EZ02eBmKZUBlIwXgTj2+9CO59KU7WSDtdpQZmuIvUWdDpQykz3+UMYBOPj6Uoqj8ZbFZa5qj4Sv8y8L+sWvbwU63w7nP2Jho8vChvqmsbO6MxO4YZAeMlQ36POkfKAK2QWx5T8+Hsa1xWeoCPUzD/FyKGttzdb+IUo1XHOuv2oO4Yv1I4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(66446008)(107886003)(66946007)(5660300002)(52536014)(66476007)(66556008)(64756008)(33656002)(4326008)(83380400001)(2906002)(8936002)(7696005)(186003)(8676002)(38100700002)(9686003)(26005)(54906003)(71200400001)(316002)(76116006)(55016002)(38070700005)(86362001)(6916009)(6506007)(122000001)(478600001)(53546011)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vGWEFH1Re41H1uAhIwRbdyQY6PIJ5ywsp1ZON20G8jSG5W9pdQiG2jJ+GxJa?=
 =?us-ascii?Q?HbEl5NHMYJOy5rz6ZaBPUGOViWAzYpGfPwFNp5tBMkcHQsah+yotLocNqTzb?=
 =?us-ascii?Q?zg4SSWi+pWt92e7aSp442UbkQV5Ks15cp43gbv99OFD0GXN5eYU5DJ6FhyAb?=
 =?us-ascii?Q?D1NX2Zi6W4c3gqp6eXiClzspAN/bYNCEFMLi148AKIBihNG/7FGB0WSMXqdC?=
 =?us-ascii?Q?dd3LVcbvJzhtabwNdIaKURYYOrd8jl5X+PfYbn3aeXvxX2t1L5FC85tF5G8M?=
 =?us-ascii?Q?9ehmvQZCOmgznf904iUAr5JJna6cp4/tuNE6yI3DGsOrJi1arX2ENJGh29fq?=
 =?us-ascii?Q?L/iQMs4xeb7MO/V7SoRvfD1L3wLPrCdH+61175n2U3QCkMTcn6UxKAImltaE?=
 =?us-ascii?Q?ep6BLeAJi3yMQVLYoC1UTRGi+ZlXq1G6acHxSXJ3+9YXufutFeFCJlOyqrPv?=
 =?us-ascii?Q?M8UwKd5kYUQ15BfVHTBIOhSHscAZfR7x9oS72nkbKfJqWrDt2gyxo9O4Oqx6?=
 =?us-ascii?Q?OV5LqPJYIu6NAwouvatHwRzth8aMVciIaEQP9byBgLWaV/dY5qZg7tgfCk5O?=
 =?us-ascii?Q?GZ1xSDtVdtMcbuDK5wziKjAFxB0yENGXptomtZXiQBQXfKIEK/odWTgizFmu?=
 =?us-ascii?Q?SLjZQXIEP/vlc0ZdW0wKYbCH7Wsr8RIMuF5DZ3Y9TCj8CHzPr77dc0tMkZaU?=
 =?us-ascii?Q?2NL4RmbnnxOkeKpBo9bbFvrRo2c1hFSwiMe2PgdCOKuWRH3RjUkho4K9EZQ8?=
 =?us-ascii?Q?OqJSGwe87rA/Xk8kYl2mE8s0QWEGs3zkgOrK6ndm7TWrlw+1f519N77Esur1?=
 =?us-ascii?Q?iK1AJEByGNHKx8Qikj8tmzxeC+lV143MvBkYV1lGDy/3RVmhhawBDuInBzAn?=
 =?us-ascii?Q?84XciJ94PpHK/M3McNlKz9yd4IjCqlBsElkUyH0PFLI64Jsb9hblyqvsAGpI?=
 =?us-ascii?Q?81T6i8JR05575USF69fmqPFLdRQbDQQ68fiVooaiGbsH6Pjz2moBKx07Fq8u?=
 =?us-ascii?Q?paV2ogQXswo7fgoyL83Y81Xo+aFanDgktjn/HxEJ+pmwN9i7PbvQIUPmYpHv?=
 =?us-ascii?Q?bWTlVJDC1lYVzQuTkNZ5pnyyEhPo8cOj2HQhvKazNnyGuadGr50mtvBHSV9u?=
 =?us-ascii?Q?MiHw95rgmmopqSq9IDarLLnp4qcxWmjue+5SYzKGry4WziUupiFt1snXsz+D?=
 =?us-ascii?Q?WdtdeSyiQwXGE7a0NUEAMMbXGnhR3C3Xj1yZunIwYXfM90Pi7cR5WhhgFneD?=
 =?us-ascii?Q?YDniuUpTlnKJGnfnN+KQgpRpl1alflHKlUlCt+DCVvUIHKW6yiHpODYR5ZLa?=
 =?us-ascii?Q?bCU9e9Fwn7gMmMiPwKsT+X5T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c96c1ec-0a90-451c-f7c7-08d95eeeba08
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2021 06:42:46.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Le9229i1BGN3bM6pVvu2XlVmZx9I6V0iYAHjj30/HUslPLQHKp0eqMSUNxBLP1E1BDLxpSRPZrD0csnypVx8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5605
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Friday, July 30, 2021 7:52 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>
> Subject: Re: [PATCH v11 10/10] Bluetooth: Add offload feature under
> experimental flag
>=20
> Hi Kiran,
>=20
> > Allow user level process to enable / disable codec offload feature
> > through mgmt interface. By default offload codec feature is disabled.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > changes in v11:
> > - Remove Kconfig
> >
> > include/net/bluetooth/hci.h |  1 +
> > net/bluetooth/mgmt.c        | 98
> ++++++++++++++++++++++++++++++++++++-
> > net/bluetooth/sco.c         | 10 ++++
> > 3 files changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 8af8892e18bc..dbbbb974ade6 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -330,6 +330,7 @@ enum {
> > 	HCI_ENABLE_LL_PRIVACY,
> > 	HCI_CMD_PENDING,
> > 	HCI_FORCE_NO_MITM,
> > +	HCI_OFFLOAD_CODECS_ENABLED,
> >
> > 	__HCI_NUM_FLAGS,
> > };
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c index
> > 3663f880df11..eb10f9597837 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -3791,6 +3791,12 @@ static const u8 debug_uuid[16] =3D { }; #endif
> >
> > +/* a6695ace-ee7f-4fb9-881a-5fac66c629af */ static const u8
> > +offload_codecs_uuid[16] =3D {
> > +	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
> > +	0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6, };
> > +
> > /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */ static const u8
> > simult_central_periph_uuid[16] =3D {
> > 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92, @@ -3806,7 +3812,7
> @@
> > static const u8 rpa_resolution_uuid[16] =3D { static int
> > read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> > 				  void *data, u16 data_len)
> > {
> > -	char buf[62];	/* Enough space for 3 features */
> > +	char buf[82];   /* Enough space for 4 features: 2 + 20 * 4 */
> > 	struct mgmt_rp_read_exp_features_info *rp =3D (void *)buf;
> > 	u16 idx =3D 0;
> > 	u32 flags;
> > @@ -3850,6 +3856,26 @@ static int read_exp_features_info(struct sock
> *sk, struct hci_dev *hdev,
> > 		idx++;
> > 	}
> >
> > +	if (hdev) {
> > +		if (hdev->get_data_path_id) {
> > +			/* BIT(0): indicating if offload codecs are
> > +			 * supported by controller.
> > +			 */
> > +			flags =3D BIT(0);
> > +
> > +			/* BIT(1): indicating if codec offload feature
> > +			 * is enabled.
> > +			 */
> > +			if (hci_dev_test_flag(hdev,
> HCI_OFFLOAD_CODECS_ENABLED))
> > +				flags |=3D BIT(1);
> > +		} else {
> > +			flags =3D 0;
> > +		}
> > +		memcpy(rp->features[idx].uuid, offload_codecs_uuid, 16);
> > +		rp->features[idx].flags =3D cpu_to_le32(flags);
> > +		idx++;
> > +	}
> > +
> > 	rp->feature_count =3D cpu_to_le16(idx);
> >
> > 	/* After reading the experimental features information, enable @@
> > -3892,6 +3918,21 @@ static int exp_debug_feature_changed(bool enabled,
> > struct sock *skip) } #endif
> >
> > +static int exp_offload_codec_feature_changed(bool enabled, struct
> > +sock *skip) {
> > +	struct mgmt_ev_exp_feature_changed ev;
> > +
> > +	BT_INFO("enabled %d", enabled);
> > +
> > +	memset(&ev, 0, sizeof(ev));
> > +	memcpy(ev.uuid, offload_codecs_uuid, 16);
> > +	ev.flags =3D cpu_to_le32(enabled ? BIT(0) : 0);
> > +
> > +	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED,
> NULL,
> > +				  &ev, sizeof(ev),
> > +				  HCI_MGMT_EXP_FEATURE_EVENTS, skip); }
> > +
> > static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> > 			   void *data, u16 data_len)
> > {
> > @@ -4038,6 +4079,61 @@ static int set_exp_feature(struct sock *sk, stru=
ct
> hci_dev *hdev,
> > 		return err;
> > 	}
> >
> > +	if (!memcmp(cp->uuid, offload_codecs_uuid, 16)) {
> > +		bool val, changed;
> > +		int err;
> > +
> > +		/* Command requires to use a valid controller index */
> > +		if (!hdev)
> > +			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> > +					       MGMT_OP_SET_EXP_FEATURE,
> > +					       MGMT_STATUS_INVALID_INDEX);
> > +
> > +		/* Parameters are limited to a single octet */
> > +		if (data_len !=3D MGMT_SET_EXP_FEATURE_SIZE + 1)
> > +			return mgmt_cmd_status(sk, hdev->id,
> > +					       MGMT_OP_SET_EXP_FEATURE,
> > +
> MGMT_STATUS_INVALID_PARAMS);
> > +
> > +		/* Only boolean on/off is supported */
> > +		if (cp->param[0] !=3D 0x00 && cp->param[0] !=3D 0x01)
> > +			return mgmt_cmd_status(sk, hdev->id,
> > +					       MGMT_OP_SET_EXP_FEATURE,
> > +
> MGMT_STATUS_INVALID_PARAMS);
> > +
> > +		val =3D !!cp->param[0];
> > +		changed =3D (val !=3D hci_dev_test_flag(hdev,
> > +HCI_OFFLOAD_CODECS_ENABLED));
> > +
> > +		if (!hdev->get_data_path_id) {
> > +			bt_dev_info(hdev, "offload codecs not supported");
> > +			return mgmt_cmd_status(sk, hdev->id,
> > +					       MGMT_OP_SET_EXP_FEATURE,
> > +
> MGMT_STATUS_NOT_SUPPORTED);
> > +		}
> > +
> > +		if (changed) {
> > +			if (val)
> > +				hci_dev_set_flag(hdev,
> HCI_OFFLOAD_CODECS_ENABLED);
> > +			else
> > +				hci_dev_clear_flag(hdev,
> HCI_OFFLOAD_CODECS_ENABLED);
> > +		}
> > +
> > +		bt_dev_info(hdev, "offload codecs enable %d changed %d",
> > +			    val, changed);
> > +
> > +		memcpy(rp.uuid, offload_codecs_uuid, 16);
> > +		rp.flags =3D cpu_to_le32(val ? BIT(0) : 0);
> > +		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> > +		err =3D mgmt_cmd_complete(sk, hdev->id,
> > +					MGMT_OP_SET_EXP_FEATURE, 0,
> > +					&rp, sizeof(rp));
> > +
> > +		if (changed)
> > +			exp_offload_codec_feature_changed(val, sk);
> > +
> > +		return err;
> > +	}
> > +
> > 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
> > 			       MGMT_OP_SET_EXP_FEATURE,
> > 			       MGMT_STATUS_NOT_SUPPORTED);
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c index
> > 5ff06ac05fef..ba66e082ba9e 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -964,6 +964,11 @@ static int sco_sock_setsockopt(struct socket *sock=
,
> int level, int optname,
> > 			break;
> > 		}
> >
> > +		if (!hci_dev_test_flag(hdev,
> HCI_OFFLOAD_CODECS_ENABLED)) {
> > +			err =3D -EOPNOTSUPP;
> > +			break;
> > +		}
> > +
> > 		if (!hdev->get_codec_config_data) {
> > 			err =3D -EOPNOTSUPP;
> > 			break;
> > @@ -1160,6 +1165,11 @@ static int sco_sock_getsockopt(struct socket
> *sock, int level, int optname,
> > 			break;
> > 		}
> >
> > +		if (!hci_dev_test_flag(hdev,
> HCI_OFFLOAD_CODECS_ENABLED)) {
> > +			err =3D -EOPNOTSUPP;
> > +			break;
> > +		}
> > +
> > 		if (!hdev->get_data_path_id) {
> > 			err =3D -EOPNOTSUPP;
> > 			break;
>=20
> these two and the flag definition itself need to be a lot earlier in the =
series.
>=20
Ack.

> Regards
>=20
> Marcel

Thanks,
Kiran


