Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2099CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3FE60EFE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 06:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhHNGeU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 02:34:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:25604 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhHNGeT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 02:34:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="212548257"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="212548257"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 23:33:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="518476095"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2021 23:33:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 23:33:49 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 13 Aug 2021 23:33:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 13 Aug 2021 23:33:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 13 Aug 2021 23:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPmXmHbl8M11Y7QonB71zaOfdgw2Bdbf4jz4aiuItvfcghqGZbW1Fi1K981SO42DaPjVxp1tLGVnWcCzTAavRG95Dy7JN557hL5xneEcx3TN+H3ureZT58guBoD78bsXRDSII2tfPUom+dFq4KDSf2q7ZQjJtYyP0WXdS97OeG2vbV8wOp37ah6a3dac97mDpqw/Jjp4WIo8SXhAnKg94wSD7GDrNhBIKeu9MJ8vOBlMsOQjiQb/KdXTkylFuXvqKVG3Xn8ZVuVh72n9qOoO+6zxAiFuxIC3XZuyGQHUtVzyQHSem9XXzGbptildrtjyoRxSuEOr0hvDqcZgsrJ2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKcN1qoWaaaWyircvypFWvw7PK2OhjLyPCdYeSEPrcg=;
 b=gmjfJ39gjp63fBtJuCLnP5pnZboirpPnamaFVKtsop3F/pr1rOirVfdyC8zlgu2czTODd4IfzZ8cY24QLdxU+S8UStCt1y4po/0PfJj2wwmvHQeLCEaQnX2IdYSPPuvLjDTIRKFhAuFLwjE+g1DbsGrIcBu9kJKnYPC3TP5CLppoLk/ng0VP68uxjzaLbPA2O6e8o6pZdNyY0NnsUbgecyo5TXEssFieWdXq93g0GebKpCJkLhin3NZuGE6jOCQi6U2/YYEKzLRGo1F8Ucou6JFZ5pLMIeN0eX5g+5lblBgyuNNgFLlocFdWsvYnO3xqTHnAMHkLpGmSaiODshO2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKcN1qoWaaaWyircvypFWvw7PK2OhjLyPCdYeSEPrcg=;
 b=oACAMaAAeIbjt6X5k6h02CbaH5s3U5YiJAeKL6z+Jg5VZuFxrmrEy5FcqpmQcVDS30IxicNlENlsnU3o2U1BNHNcXsLrTmiB7oUD5FLdnpQK1oObJ5E71s9AIg27xj6V3RxhkJGj8e21lDURoJx4IQ6Wu0RqENRYoW26fOTuv+M=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5639.namprd11.prod.outlook.com (2603:10b6:8:24::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Sat, 14 Aug 2021 06:33:48 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::c134:db0a:48b:a88c%3]) with mapi id 15.20.4415.021; Sat, 14 Aug 2021
 06:33:48 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v11 04/10] Bluetooth: Allow querying of supported offload
 codecs over SCO socket
Thread-Topic: [PATCH v11 04/10] Bluetooth: Allow querying of supported offload
 codecs over SCO socket
Thread-Index: AQHXgsNuP4nas++zU0OUeCZXf+Zos6tblNcAgBcSJ1A=
Date:   Sat, 14 Aug 2021 06:33:48 +0000
Message-ID: <DM8PR11MB55730E581A04C278B111B7E6F5FB9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-4-kiran.k@intel.com>
 <DF716A96-0774-4CD2-B2B9-95D41F1B0842@holtmann.org>
In-Reply-To: <DF716A96-0774-4CD2-B2B9-95D41F1B0842@holtmann.org>
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
x-ms-office365-filtering-correlation-id: 79f3215d-c13b-4160-b4dc-08d95eed792a
x-ms-traffictypediagnostic: DM8PR11MB5639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5639E6F170ED9FB587AED77EF5FB9@DM8PR11MB5639.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVi0PPwestbAvZNfJrx6aRKmJHdqACIGlSuV+eG/iOvbLJy7+PeYZw4K13vqlrUtr3SfQ56/gX0m2wPzroT6t/QZFdK9OkmvaFSpNW0+HxfgliEM26lJHBOKhIXeZXZB7nuUtv506Tynzhtohtdteh/wse5G2RryYqjyXEaG3Gg9/eQTiuW+UgCxTv84YD+TPE3VMJPkgDvtP4siRm/iy2oHUu3lhzoDAazVnGQ2Blo9jmd1VmlrPEGp5AlGlCf7eBjKwJjoaBUQeYnzZHh/doImsuYr13QFmI8yaYtt1jqFLOnQcaJR8+Azhot0UH5wNp8UTVlB6u6I2KmyRjY2zHpquChSfxcCjjlw62S5EgI4DIJsIgr5VwjzpA94s+vpGiJUVBBWz/ooVs7koAojl+D97/EpiRtz5QzdZ8dx6s+/RK0XFr/5lcd7/ukW9jlUWpBVFQBYTLTh9YOnwmnzhWzPVZfcDwTdlZ+lnsqC3fAtkWXkfxRIkP7tEwihHyUmhrCutqGkgDyT7Q/CIeffdgkuQSkGwHZUMPzzB5sXNyX36Dw7F8Ir2EHiejXTPY/VAl65SdQmsgkMTqnihlJndGPjP4Zw+LNcDD0fXTpfzUiNPi4n09pdRiSF+Z+s+bjvNggK7oSNvwxiOqa8dtQb1u64WnFotx0aXU2DB17OzDv2CiehcpVLxkRTMq09SaCjGNgTPuhkxzzRIYX8qFidzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(71200400001)(33656002)(478600001)(38070700005)(54906003)(7696005)(26005)(6506007)(53546011)(4326008)(5660300002)(107886003)(6916009)(8676002)(9686003)(66946007)(55016002)(76116006)(316002)(38100700002)(86362001)(66446008)(83380400001)(2906002)(64756008)(66476007)(52536014)(122000001)(66556008)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AMCER3T272GI6zaHq6HosCgtwPmNOkbxLtE6Blt/y5yTvQAPLISHM+t5fQI/?=
 =?us-ascii?Q?tWtvMrjvLBZDf5mPv9swKpdm1g3ZNgolHQWVEIf6vHWVehv1JADXGJiAYORo?=
 =?us-ascii?Q?+3AfUEtZlzw5+c5f58FQbg7nOvkHT4mL8j02bWwUd7liRYtV+NNcG2iaIVzX?=
 =?us-ascii?Q?XiQZasUg6PBasfO1V3T2X11C/gAmfZ6wW/ZkoH3+7XRwpaYAuPpgRWPwhlY5?=
 =?us-ascii?Q?uUUAHQxnPYy+/Ev3u4XUX46TT6WyblhFlGOA23Illn8ZLy4WNnYAFbLvoB2D?=
 =?us-ascii?Q?bVbpVmXN4GSUySFUHzCP1lcZWaXyiCv2NVOCysuT1Fy1IklqiP/lPo7rwlEh?=
 =?us-ascii?Q?jHyilO1QAZsa6Srr+BTXtlzWAphRbmv4hf3XjGXmXIUtV60d32NmB8XES16k?=
 =?us-ascii?Q?1H4PjyS+H3ZFWTA5nQgmed5TjRQE8YQdLdB+0JWuaQyxC5LdsbKSUXPr+2fV?=
 =?us-ascii?Q?0rASdUJZVqkserz5e6MlTEpdaJ+oa8u4LUZ+HJDEyiRUii7KrgtMzcklieY3?=
 =?us-ascii?Q?9rg6XjWOOt1TQbO9jfjB9E5oQTVq9DNxUGKRLlH7AqHfftd3crFWpEBDeH4u?=
 =?us-ascii?Q?Sxb6Qs8c4yf6UhY5TsL9fsw6b5nRUBIm+OYW60ppU4YvLuIMj6Fg5mc44sUO?=
 =?us-ascii?Q?hLPhk+WomhIpU8lZqy7qtCM31lz43AvjReQzZjK6A3rp9yfaUqgpznni6cne?=
 =?us-ascii?Q?LNnIZ0HffLc+5tbkWESYkiNHLoGGtExwSwxKQQj17EOvqv/LJlJUaGyLS2b1?=
 =?us-ascii?Q?ZiS+DBxjp5U70nT6VCxHrWxFxFnD9iNhdjO1EZrk/38gsf+AdaZx/It+LC20?=
 =?us-ascii?Q?+4feOC5w0g5aYK9LklpRm1+qHEAbJGzv3v5LZjDW4sH0JHkCmS3sO4gFiZNi?=
 =?us-ascii?Q?7AGNxGW9BKOTH46uZGkP9TscpajZBlV46ya95ATSZuAEDfC+SODgdPGxENxh?=
 =?us-ascii?Q?y8F8gZCtkuG8H3hH3ShLB9l1MANxzQ9gbCVeLFTJkTtX/erNVaC3L/iECxVW?=
 =?us-ascii?Q?EZR8CgEVN0Wt6G9kGBnfaU7RdAguPvIOuoKGg8Hap73Rk6vdUQp3rNQHrQxt?=
 =?us-ascii?Q?wODpBLl4P8SKsniYmXDr9lLuuRhbJlxtDyxp/hgU1Dz7QzgYRZ4FjiaoBs91?=
 =?us-ascii?Q?A+Oq082ENiNDRWc8uo17d0V+D4LkrBmlc8RXmgUX62RCodUn2MKOmrKTuJ57?=
 =?us-ascii?Q?3lUzZyieUp6Z7CbchRbnGhPkFlpoww4vvlGB9yYrIWMN0qYegDZ1CBfW8UNS?=
 =?us-ascii?Q?UjnIdpiXP+4Gv5T6ZSQTcDWRI5zSFmpc6PfUas5XhJzKkAQvruhLFKYp7sZ8?=
 =?us-ascii?Q?QziZkTF0kR7hrVFJPe0iw8ci?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f3215d-c13b-4160-b4dc-08d95eed792a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2021 06:33:48.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8gnOZFpWr5IzSD5tl+tv7C9Rb6BynOVgaf205COOr3tGaskioBRDP6McnMrCbMCrbl+wTibWp8vNShYpzYa5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5639
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Friday, July 30, 2021 7:44 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>
> Subject: Re: [PATCH v11 04/10] Bluetooth: Allow querying of supported
> offload codecs over SCO socket
>=20
> Hi Kiran,
>=20
> > Add BT_CODEC option for getsockopt systemcall to get the details of
> > offload codecs supported over SCO socket
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > * changes in v11:
> >  - Remove Kconfig related changes
> > * changes in v10:
> >  - In getsockopt, prepare data in advance and call copy_to_user
> >    istead of calling put_user on each field of struct bt_codec
> >
> > include/net/bluetooth/bluetooth.h | 20 +++++++
> > include/net/bluetooth/hci.h       |  4 ++
> > include/net/bluetooth/hci_core.h  |  1 +
> > net/bluetooth/sco.c               | 91 +++++++++++++++++++++++++++++++
> > 4 files changed, 116 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h
> > b/include/net/bluetooth/bluetooth.h
> > index 9125effbf448..64cddff0c9c4 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -153,6 +153,26 @@ struct bt_voice {
> >
> > #define BT_SCM_PKT_STATUS	0x03
> >
> > +#define BT_CODEC	19
> > +
> > +struct	bt_codec_caps {
> > +	__u8	len;
> > +	__u8	data[];
> > +} __packed;
> > +
> > +struct bt_codec {
> > +	__u8	id;
> > +	__u16	cid;
> > +	__u16	vid;
> > +	__u8	data_path;
> > +	__u8	num_caps;
> > +} __packed;
> > +
> > +struct bt_codecs {
> > +	__u8		num_codecs;
> > +	struct bt_codec	codecs[];
> > +} __packed;
> > +
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index b4e35cf5f4b1..22e872e60ff8 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -2621,6 +2621,10 @@ static inline struct hci_sco_hdr
> *hci_sco_hdr(const struct sk_buff *skb)
> > #define hci_iso_data_len(h)		((h) & 0x3fff)
> > #define hci_iso_data_flags(h)		((h) >> 14)
> >
> > +/* codec transport types */
> > +#define TRANSPORT_ACL		0x00
> > +#define TRANSPORT_SCO_ESCO	0x01
> > +
> > /* le24 support */
> > static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3]) { diff
> > --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 6742e6ad7b37..71c409c8ab34 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -617,6 +617,7 @@ struct hci_dev {
> > 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> > 	void (*cmd_timeout)(struct hci_dev *hdev);
> > 	bool (*prevent_wake)(struct hci_dev *hdev);
> > +	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
> > };
> >
> > #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c index
> > ffa2a77a3e4c..2f32693f09c1 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -953,6 +953,12 @@ static int sco_sock_getsockopt(struct socket *sock=
,
> int level, int optname,
> > 	struct bt_voice voice;
> > 	u32 phys;
> > 	int pkt_status;
> > +	int buf_len;
> > +	struct codec_list *c;
> > +	u8 num_codecs, i, __user *ptr;
> > +	struct hci_dev *hdev;
> > +	struct hci_codec_caps *caps;
> > +	struct bt_codec codec;
> >
> > 	BT_DBG("sk %p", sk);
> >
> > @@ -1017,6 +1023,91 @@ static int sco_sock_getsockopt(struct socket
> *sock, int level, int optname,
> > 			err =3D -EFAULT;
> > 		break;
> >
> > +	case BT_CODEC:
> > +		num_codecs =3D 0;
> > +		buf_len =3D 0;
> > +
> > +		hdev =3D hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
> BDADDR_BREDR);
> > +		if (!hdev) {
> > +			err =3D -EBADFD;
> > +			break;
> > +		}
> > +
> > +		if (!hdev->get_data_path_id) {
> > +			err =3D -EOPNOTSUPP;
> > +			break;
> > +		}
>=20
> so I did say that this needs to be put behind an experimental feature set=
ting.
> I am not committing to an userspace API until we have more feedback.

Ack.
>=20
> Regards
>=20
> Marcel

Regards,
Kiran


