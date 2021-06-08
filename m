Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C48C4743E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E241960C3E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhFHMDq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:03:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:60964 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhFHMDq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 08:03:46 -0400
IronPort-SDR: BUU4OoTw9V7aENiCwsKFqMuBf4iCvZZu0u+bmJfuaLMc7ajwoxC9+yIxgW6mHjrgUqYTxu8hMj
 P++pIwcBftEw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="226171886"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="226171886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 05:01:53 -0700
IronPort-SDR: Kb0gC9ePRH3ynWECeNkKnyrdN0aH71tyuK+qF+ucM4rnkLldslZQ9jjt61N1ttS/SB+n0rDYOK
 +LNwbENvc+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="447870827"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2021 05:01:53 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 05:01:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 05:01:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 05:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsffqNlRDkm8A51JCBZs+jyrslMVxv19Dl0sOfgaLnPdzaCLvKR27uLuqTlolpTeezmDjEHJ9W2+kvar5el3PW1SBtKGMrwnqfucVIfmSRoY9xnNyrKIq4IMfL4fAkGgLQszlj0uqjM1Otp1GeBPdRvXELNCscfs7i9E5u4KezqHe9AwKyoyj38lq5XKAaotkp6iZXpLD1c9xASWI2Eqqct1/cdKVZwCYyysoG5UkTIT6F2MqsiNQb2BDaUKWpHZkP5/1zHmA8S7qI0P3GFKN2SnV1zE9gvW4KdmGpXj7oVkW/DHhYezbm/Udr1qhLuAUYSGzVaAmcJGxfSvpBWNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcUtJ4/4M4pPQtK6SYtWpNkrLuocAM38eBnxc6Sykh8=;
 b=i/FBDumsqy1mBF4Q7H3zgTFp5cMPjoZDP5XewlY1BLY4PraMLet9+KZg04TiPP34oJHTn6KyiK9TUZ93CH5D6NApgLLyvrMts9SDMAI7VGdsmzUGjC0L86GN7WIqXZucCWuDypSDksCEpXaCnMl4wcVIWzoW7m/z5sBJ/DY4U2ba+64RqbvUuu2FPr1gXYNdm3i7iScrvIWrwoslMxakTCPMilvB5bLqJ+Q4hcRY5KIB9CLEKVWYCgffW8/vKPzIXC9qi45Bw/V8LGx/fh3LjDXGtUhsHm0gbgwxXT6Ol360wH8tin7CjA9LyEvzxG8j7a0XEDsL01AScyw5bovQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcUtJ4/4M4pPQtK6SYtWpNkrLuocAM38eBnxc6Sykh8=;
 b=rkbeZhI9946slAJnKgLW1gt5bLgHluntTmx+PY9yvw6/3gCou4VVXDH2ihnX3xDlOrPJ6QHKOMtk4YMisgftjNrpxbHsTPOY6nSsh9a8ht/n6JmgOWBkg/rgfllz8bAReI12vm8gWsozi+c/6wr2YwT9rFrxy7jZs38VwLJaqJE=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Tue, 8 Jun 2021 12:01:43 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 12:01:43 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v8 5/9] Bluetooth: Add BT_CODEC option for getsockopt for
 SCO socket
Thread-Topic: [PATCH v8 5/9] Bluetooth: Add BT_CODEC option for getsockopt for
 SCO socket
Thread-Index: AQHXS9IEdU2cPFWGyU6pRlqFOl/QaqsCc74AgAevPcA=
Date:   Tue, 8 Jun 2021 12:01:43 +0000
Message-ID: <DM8PR11MB5573537BBBC5EFEDAC5B6DCEF5379@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <20210518104232.5431-5-kiran.k@intel.com>
 <C925CD9C-0CD3-493B-8A5B-42025D2655E6@holtmann.org>
In-Reply-To: <C925CD9C-0CD3-493B-8A5B-42025D2655E6@holtmann.org>
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
x-ms-office365-filtering-correlation-id: 331c9a38-eefd-4d48-1d9a-08d92a752eca
x-ms-traffictypediagnostic: DM8PR11MB5653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB565300106B3D89181C2C484CF5379@DM8PR11MB5653.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opfTaOwz/95bBf7n7rynf3LWs1RsRpv0Hdy4SKCkpqX9q8yM9qv6GTbqx0PFfIuz7gd1BsotYO2crYsgwXZdVTN6k7udInc5Rw93NVKmIvPiFNfIaws4MRgd2QkE7dZU/cJpgBIJQugSblrQPrsHfpHObBaVBer7FZPW8f91cQYwPZSM33LPUhK+VaOuMKePoqs4zw0ODuqBCphKBhva5Yg3pM1xnuasOm89iT1o0Rs/SNALPcyGGEW42B3cFIbOeuVqx0MAOWQ3ODgI4q4c+U8AP4BS1rnIbZ0ojFbN6CKZo+cyx/OWUE8GXLB1adrpfCmdUDjTu9G1dhQ6Z9TqY7/UyiPNI6Xahd53J17bJ1H4uqmRtjWnwzAbCK+I1gxrpx2qZbBTEbWKpXTd8zT8ifGou8s2feSjzuA4nlmL8B0XBd+EaweoJe3aDtn3TcujpZk+0KRx+BTFL25hHtxFC7HHBUnCv3eowBMzY1DGdyKU4c3C8vog0K0xRuse9dqRzXR8ApVV0qaymUWMyo+d77q0oVZpkip0CNXa0iEtHgcS6TPhau7zNJNfLvJEfGwjuYoOAkvZ6Rm66VG8NYwOiosvxQpJTb/gCCd84K65Gzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(136003)(39860400002)(9686003)(316002)(26005)(5660300002)(2906002)(66446008)(66556008)(38100700002)(8936002)(52536014)(66476007)(86362001)(186003)(54906003)(55016002)(64756008)(4326008)(107886003)(33656002)(7696005)(83380400001)(478600001)(76116006)(71200400001)(6916009)(122000001)(8676002)(6506007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cc/1f651osEaytWlHHpAGske9F3exLZMomK9Xl4253ewrF7XYdanSQjicec0?=
 =?us-ascii?Q?SeFCubAS32OASGWG5mpzr0vkg9JIOEYJhMUcaKQy509sUclYZxadQOs6nvOe?=
 =?us-ascii?Q?dUCqTbknXDLeEeWYWX7Qqyrg4QIJfYege8EobgKluUYQJDpNxy6RUjhFXVw9?=
 =?us-ascii?Q?tn3CqIbJsfRYrcfmhr6NXLa+EgRQZJbvJGCjCTIOWcIsWKRMeVTrQKab3HK/?=
 =?us-ascii?Q?RkAMeKgTwtNkL0HsJX9YnclAG9YLHttiQ9fDI/tLFOZHiKRLEAjhu5K6WUaf?=
 =?us-ascii?Q?zZEaN9JRZFEgZqOQ3TeNyXXZrrWuOD0dAqw7xmVq7bmDkizw/HEFEypbNqTQ?=
 =?us-ascii?Q?N7cn/EZS5vahdPgr91jwgYKDOHM4wO75F3a3oweqWLduPjWk+mPzuGRbkN9a?=
 =?us-ascii?Q?6OdMrYCxwjSCnlWusqFddzdUPGF40VH7INHg8l5T5sTYq4TUUg2Xo2jhk4k7?=
 =?us-ascii?Q?GBDs6gBtnl+ZUNerZwDSUA+QxQR2AXK6ntbDXLWxQOcSuVMS+m62cGhFVPtZ?=
 =?us-ascii?Q?/yhJEdcTQcPtn+QBJtWIH203FZsdq2xgj5Vj+om6SK4rLAXhQx9d2m6OcEjw?=
 =?us-ascii?Q?jTZrtirFQELQ6Cif9p+VaYZY2RzAfw0tjk/kgtUoKODPsljJ8/Oy0tNGMhkQ?=
 =?us-ascii?Q?9tao4jRrnVwsOAVQBPZVn6SR2dyKBOBPlInhLdtF+kUGv13Jmrv7pfdpyWpi?=
 =?us-ascii?Q?t/OgnvkfYKiSH5rvCchn1XcixFfxbH5S9TkO8nG79tWIdHDBAAqcD0mJSYZy?=
 =?us-ascii?Q?e2Xb7IgM7KYri+/MTAS6/HewOzq2KDyorL5fJYAkJvQfONGH68d/7+Wtcdo7?=
 =?us-ascii?Q?ay9F1IYe1Q5+8v0PySEjNiVUoZ4cT0q9TiLFhxqkm/NEBDgWMtM7LVu73RBl?=
 =?us-ascii?Q?uCRcyT1yAAoWpAEN0Kyv9h/nfCGwI0G+zPTsjTD+W/tvxnNwPJzWhgQGAOZR?=
 =?us-ascii?Q?XmgIwgpjY7irYNIXzEfFslxYp2KduqE+U7n1U18JikrJYxohkeDmGtMB78e+?=
 =?us-ascii?Q?0n+TMylox85zBxHa5zI6xrsxcMU+1ikQsLLGDxspvwwFip+TmTmFU17Faf/n?=
 =?us-ascii?Q?NXNqQ92rBNffBC45PjfBdCLV49XV6D3jvotR6AcmEdnE4mhJ/O7JiLciDYpH?=
 =?us-ascii?Q?q/53LwpbSqUnHGz7m3bN+Gz0WVle4w9XqCTmhi6/3TD+XbCvNql/gK56Qvra?=
 =?us-ascii?Q?4wI+CsfHPTK4zpOxi/GSOgPjD55W0GdiBBru0MldEUqCChalVqBlXso7w9r0?=
 =?us-ascii?Q?nRVjAN4+M3HbgxB+7LYZAoUVdICVkMoQAZIheFAQiDI5/A3zjcwOkGToDhPa?=
 =?us-ascii?Q?NwfC9Z8e7rgUz3eMSMgWTUQf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331c9a38-eefd-4d48-1d9a-08d92a752eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 12:01:43.3626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IX3+VPiyQRfoEDwRAQTRlg3mebsL/tlPsJOpE3qL1V6D0IP6bOBYYxyr0PopwJE3R/XD/65NZfKirSAbvq/THA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5653
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

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
> > +	__le16	cid;
> > +	__le16	vid;
> > +	__u8	data_path;
> > +	__u8	num_caps;
> > +} __packed;
> > +
> > +struct bt_codecs {
> > +	__u8		num_codecs;
> > +	struct bt_codec	codecs[];
> > +} __packed;
> > +
>=20
> what is encapsulating what here?

bt_codec encapsulates caps.
bt_codecs  is aggregation of bt_codec.

>=20
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 731d48ca873a..9658600ae5de 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -2626,6 +2626,10 @@ static inline struct hci_sco_hdr
> *hci_sco_hdr(const struct sk_buff *skb)
> > #define hci_iso_data_len(h)		((h) & 0x3fff)
> > #define hci_iso_data_flags(h)		((h) >> 14)
> >
> > +/* codec transport types */
> > +#define TRANSPORT_BREDR		0x00
> > +#define TRANSPORT_SCO_ESCO	0x01
> > +
>=20
> This is confusing. SCO_ESCO is also BREDR.

Ack. I will remove the suffix BREDR.

>=20
> > /* le24 support */
> > static inline void hci_cpu_to_le24(__u32 val, __u8 dst[3]) { diff
> > --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c index
> > 3bd41563f118..d66293d1cba4 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -948,6 +948,11 @@ static int sco_sock_getsockopt(struct socket *sock=
,
> int level, int optname,
> > 	struct bt_voice voice;
> > 	u32 phys;
> > 	int pkt_status;
> > +	struct codec_list *c;
> > +	u8 num_codecs, i, __user *ptr;
> > +	struct hci_dev *hdev;
> > +	struct hci_codec_caps *caps;
> > +	__u8	data_path;
> >
> > 	BT_DBG("sk %p", sk);
> >
> > @@ -1012,6 +1017,110 @@ static int sco_sock_getsockopt(struct socket
> *sock, int level, int optname,
> > 			err =3D -EFAULT;
> > 		break;
> >
> > +	case BT_CODEC:
> > +		num_codecs =3D 0;
> > +		len =3D 0;
> > +
> > +		hdev =3D hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
> > +BDADDR_BREDR);
> > +
>=20
> Remove extra empty line.

Ack

>=20
> > +		if (!hdev) {
> > +			err =3D -EBADFD;
> > +			break;
> > +		}
> > +
> > +		if
> (!test_bit(HCI_QUIRK_HFP_OFFLOAD_CODECS_SUPPORTED, &hdev->quirks))
> {
> > +			err =3D -EOPNOTSUPP;
> > +			break;
> > +		}
> > +
> > +		if (!hdev->get_data_path_id) {
> > +			err =3D -EOPNOTSUPP;
> > +			break;
> > +		}
>=20
> See it is pointless to check a quirk, you can use the callback for it.
>=20

Ack

> > +
> > +		hci_dev_lock(hdev);
> > +		list_for_each_entry(c, &hdev->local_codecs, list) {
> > +			if (c->transport !=3D TRANSPORT_SCO_ESCO)
> > +				continue;
> > +			num_codecs++;
> > +			for (i =3D 0, caps =3D c->caps; i < c->num_caps; i++) {
> > +				len +=3D 1 + caps->len;
> > +				caps =3D (void *)&caps->data[caps->len];
> > +			}
> > +			len +=3D sizeof(struct bt_codec);
> > +		}
> > +		hci_dev_unlock(hdev);
> > +
> > +		if (len > 255) {
> > +			err =3D -ENOMEM;
> > +			break;
>=20
> I think this is the wrong error code. You need to indicate that size is w=
rong.
> ENOMEM really means that memory allocation failed.

I will change error code to ENOBUFS
>=20

Thanks,
Kiran

