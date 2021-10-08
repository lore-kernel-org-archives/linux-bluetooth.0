Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B40C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 14:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A8D60FD8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 14:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhJHOCK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 10:02:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:22122 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhJHOCJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 10:02:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="225285623"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="225285623"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 07:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="439940788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2021 07:00:13 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 8 Oct 2021 07:00:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 8 Oct 2021 07:00:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 8 Oct 2021 07:00:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byq6IzpPXHe7rW2ZFk3MGR5jZvKaWWDmPITgIXbPyKr9Oy4DJ6BcwbpD+op9zBu+pOH6C7N/xcn/C6Ci3YGXr31Cbr7NlqtqTCXYqBYwaBizJMYFd3fh/F7aZ1UitMrNgxU3em38ZmeS94Ss9Oxl270NLi3BJjpkLnkMQhYQ77khwOQXRedahr0nPXH3AAyQJfS0qSrqS/SHVQHyyxO0DRUs+nhxn43D6USdCXzV30SAauBbLIQ6WHo3qFzXDnA3H+bfCMvkJ5MOPYECky8Hx2GvGmlHcWkalmSFRBoMGRNawg986zPMH+PFiiZEvQxzfTFMy4F4bMatHoPSNNQlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct7OptAQpwztm7yJcnmpOuPx+rgwtS0dJytLeO0J/TU=;
 b=dWAFYg5UUyK4lx3aC7VgrS/ycyix6/c8+JXS8Q2LNeFCSuFu/zoQZhVZLV64a3F8o68xEKL66RadLLVaUZwPTp8Z/nRBKozmmSIwTg4l0m9W7tS0N2keqc9k0DbCJi12h8iHp/UrfQIY6ndNL9ev0d+B53mrtsbvJNvKbTrtgUDIqlt7Sme11+WWEKJ5CyawB2uo1+KDtlGqjPr9+MaaXpesF9spHy0cNue5ZVKsAH8kOJ+rn+qqavUu2hNRct/XER49seC94BSO/IVqn8vXtOSp0cxpuRIyt6AW6+V02Iv+FEMiZXhVnEvM6xzD8XoFtVPVFa3RLKtE/rzxKlDNIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct7OptAQpwztm7yJcnmpOuPx+rgwtS0dJytLeO0J/TU=;
 b=gUShofPJjvqkYRUFG2nCvWhPg+FSk2ZtMVNUpmTOIoHhxCD3Ne1/0bKmkA9pFH41d64q1aNwsb9MWnJUt4IknCsQAr4Aaf4e9Rxvy4OKQ4lmW4utVzIMNk1PA0+J1WdOmBfBGp96eji8wToY2u4mmHScocOtMA/Hb78IYFgLiE4=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5605.namprd11.prod.outlook.com (2603:10b6:8:26::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Fri, 8 Oct 2021 14:00:12 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::243e:658d:ac2e:4cb8]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::243e:658d:ac2e:4cb8%9]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 14:00:12 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH v1 1/7] Bluetooth: Refactor code to read supported codecs
 in getsockopt
Thread-Topic: [PATCH v1 1/7] Bluetooth: Refactor code to read supported codecs
 in getsockopt
Thread-Index: AQHXvEvgPLkpkrywmUiAP7IhY0tF86vJIJkw
Date:   Fri, 8 Oct 2021 14:00:12 +0000
Message-ID: <DM8PR11MB55739EB4DA05AA8E4F16DF63F5B29@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20211008135853.8604-1-kiran.k@intel.com>
In-Reply-To: <20211008135853.8604-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cffc94d9-4e27-429d-528c-08d98a63f291
x-ms-traffictypediagnostic: DM8PR11MB5605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB56052C35088CA97CAE11FB5CF5B29@DM8PR11MB5605.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77BtfcWYIu0/EM66Lod4Zbwb1Cx0sgBkXhuXEjVyQ5O7Oru/41won8GHqFZ7xCFittIkzE3WFJLGnlszO4bRx5S2P4hEzebs1+PF1AZjqnBVFUL6YGp3VkOlV04c6y9NWS4OCxfgO94nFqtf5fLuqzI9QkH0bi8AnQmJxPJY4Rh9NXtpskpzS7EVc5YUqUYz32qOPpIJZbc1FJ5aE6OUofjVpUaY2nLLkahcxaKU0UPx3XpicWrKyfyYXjyUcBfgySyJ8ibLRrzSxwCI1XQV612XiTor55EWM/TS/FtDGNXqnOm50gLuTYuoKWOSmv+rAy9t25Z9z5ByLQutR5VNkWqEsFR1a76wriMEYOstCkVtyZafbKIvh8dECfiono1SH9K3lztf6OOT3MsuaYUoAKFLhOSYBJsPX0iHBilKSxXRHbhF5kjQfuDQqb6wKrZvoxVjxrJ0qQ0a4DqABxU0YY/cGrnMIQtDQ6LoENoKWpmWD9XCInjqW4AehHzWnemhAnR47RYxznN3aEEepPF5pN36loBb6P4IzhIg7duxa5PUI/WMNwKVA/kf7yNNvZKuFgEL3sgsp/yEHs/vCHBoRneiXBG522o0dyayReRJd6t/pSG8DjhkjwNVH5Ri5zJHrzQS2s0qgivR/KQDFhEmTtPDyRpI+sJh+yUVKI9GtUU7Og9UTOwTjkHsU+ghzNQvkSJiz5h58+Z9PEM+8w/aHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(508600001)(122000001)(38070700005)(186003)(86362001)(107886003)(38100700002)(9686003)(2906002)(5660300002)(4326008)(6506007)(8936002)(7696005)(316002)(53546011)(55016002)(6916009)(66476007)(66946007)(66446008)(26005)(64756008)(83380400001)(54906003)(52536014)(71200400001)(76116006)(66556008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7XPR86wL1W4dOEO6y7iMnMnPxApXUAakRPWeNWawYUQBusJNt346Q+vNqZCP?=
 =?us-ascii?Q?z5oqOElHN7ygyhjFQHFvCX5ld1vRllFJvOu13xmogFH8FqJASc1X+Rv+YFOz?=
 =?us-ascii?Q?FX4/Yv9TS82udK1PJS8pxUHvhmlYMTEBh3ph6C1T7HU+EgUv1j2D79AvLhAN?=
 =?us-ascii?Q?Jokgl2n1vLfeY5wQu0rDJjPuM9O49mUH0ThP9ipuKDyyvqFcsTGJbszbW3H4?=
 =?us-ascii?Q?nEmQXhyaYJ8c7UyBWBTdD9Qx53CNVLFSfSARuOX8buqNmaYUJ8tKyQYZsE49?=
 =?us-ascii?Q?zpBzymtwx/aX+0SPxInHComb6evBFOeDr2SZf73XxCQznByik8QLz82Jrtok?=
 =?us-ascii?Q?R+wlpoHd3Unwup1L548H2Sozfk6VamWnIkvF4cbj7fW0KMes72Pu7O79zt+R?=
 =?us-ascii?Q?U3Krlhn6one/pKtfCZR7HSotLpgQcAsvFjNsnpNh5wj2EzEURo9FpIMmaeWK?=
 =?us-ascii?Q?H9lAWSj4eMU9/k55n8vSBPy+QdI5HZmhuOSac2qyQkFCZyy0Ki1GVi/oOW+7?=
 =?us-ascii?Q?yNtD+Fkoa94GvKTO0+REjkzKsaXj0sMP4jxip+FxLdtIiOOyBf6IevecocLW?=
 =?us-ascii?Q?Fc5NLWM26HzoeP5tTvEY3OsTEwRzTy3ggvKKyz4r0SBWE3DfdcqTVhi8s0Jl?=
 =?us-ascii?Q?NBjNJCTQhYFqunmOxsfQiMdONMGoLSWQGz6CLFenooc4SuqlhTsHpGPXaj3P?=
 =?us-ascii?Q?GL63I3fLyaTqvddielZOBH21tUHmmRamRid01fn3zdnc3GLwPKqZdqgZ/JBW?=
 =?us-ascii?Q?g2YMBKKbjluBtS+IITENlk0OH7OPTBjND8ZOMltSoaDcR3Yx52OpOaMMu5YZ?=
 =?us-ascii?Q?7AtOBNlOfuPEXglG+5HaHauIE/0kpCBNXwrzdafHn9vIfv5iU5bHz8/bANEm?=
 =?us-ascii?Q?mgKgoL/kjZuOii4AW2aUF0BYMAF21uiaG9boruzieyHqu3bHzY7l+B7ugNYs?=
 =?us-ascii?Q?kvgOANDlp6bUATmp0B1NdWcU2Tx1evM6IrUw20/uL/c7euO2aKReg548F0Uz?=
 =?us-ascii?Q?qVJxTVK2NtBVQjltQhQ6JnOayhsNDoSi+IXqqpxF6YJ+MQQdYlgPC/VnXKL6?=
 =?us-ascii?Q?Ks3Lkok17u/hIoKU1Lqb3Va4ftS5+3BJOjZdjD0bfy0oI4lq/8D+6M1X4LCg?=
 =?us-ascii?Q?q9MXGXr6iOs/SfUSUnVG6sUitbBmgjMpCBTbguGOgrroONeC5lWkMPkrfd2Y?=
 =?us-ascii?Q?NkJQdZJzJzAOgPdWbggDC1iBsKoQcQHylOxhAzAxJzt6SBorme6UJ/M6xQ44?=
 =?us-ascii?Q?zHFTk5AlK9QI18yGeIsE6mvgA7y+zSrOpOezKvy3W7YesjVhbR7kDZx3Vqpt?=
 =?us-ascii?Q?r20=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cffc94d9-4e27-429d-528c-08d98a63f291
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2021 14:00:12.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AR9mpor2B3uyYC95rK0FkFoy4a8xrO+RDhrfS86pOChPNdYw6yURMjSx/UvbH6PUW/Xn3ZoLHQOccjA9DaHvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5605
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Please ignore this v1 patchset.  Need to remove ChangeId  in commit message=
 in patches. I will send update v2 version.

Thanks,
Kiran


> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Friday, October 8, 2021 7:29 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur
> Narayan, Chethan <chethan.tumkur.narayan@intel.com>; Von Dentz, Luiz
> <luiz.von.dentz@intel.com>; K, Kiran <kiran.k@intel.com>
> Subject: [PATCH v1 1/7] Bluetooth: Refactor code to read supported codecs
> in getsockopt
>=20
> This patch moves reading of supported codecs from cache to a new function
> to reuse over L2CAP sockets to be used in a2dp offload use case.
>=20
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Change-Id: I080ed7ca8abd824d3af10859afd808bad28ee86d
> ---
>  net/bluetooth/hci_codec.c | 88 +++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_codec.h |  2 +
>  net/bluetooth/sco.c       | 98 +++------------------------------------
>  3 files changed, 96 insertions(+), 92 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c index
> 38201532f58e..f4d8d3a253d8 100644
> --- a/net/bluetooth/hci_codec.c
> +++ b/net/bluetooth/hci_codec.c
> @@ -250,3 +250,91 @@ void hci_read_supported_codecs_v2(struct hci_dev
> *hdev)
>  error:
>  	kfree_skb(skb);
>  }
> +
> +int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user
> *optval,
> +			     int __user *optlen, int len)
> +{
> +	int n =3D 0, buf_len =3D 0, err =3D 0;
> +	struct hci_codec_caps *caps;
> +	struct bt_codec codec;
> +	u8 num_codecs =3D 0, i, __user *ptr;
> +	struct codec_list *c;
> +
> +	if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
> +		err =3D -EOPNOTSUPP;
> +		goto error;
> +	}
> +
> +	if (!hdev->get_data_path_id) {
> +		err =3D -EOPNOTSUPP;
> +		goto error;
> +	}
> +
> +	/* find total buffer size required to copy codec + capabilities */
> +	hci_dev_lock(hdev);
> +	list_for_each_entry(c, &hdev->local_codecs, list) {
> +		if (c->transport !=3D type)
> +			continue;
> +		num_codecs++;
> +		for (i =3D 0, caps =3D c->caps; i < c->num_caps; i++) {
> +			buf_len +=3D 1 + caps->len;
> +			caps =3D (void *)&caps->data[caps->len];
> +		}
> +		buf_len +=3D sizeof(struct bt_codec);
> +	}
> +	hci_dev_unlock(hdev);
> +
> +	buf_len +=3D sizeof(struct bt_codecs);
> +	if (buf_len > len) {
> +		err =3D -ENOBUFS;
> +		goto error;
> +	}
> +	ptr =3D optval;
> +
> +	if (put_user(num_codecs, ptr)) {
> +		err =3D -EFAULT;
> +		goto error;
> +	}
> +	ptr +=3D sizeof(num_codecs);
> +
> +	/* Iterate over all the codecs on required transport */
> +	hci_dev_lock(hdev);
> +	list_for_each_entry(c, &hdev->local_codecs, list) {
> +		if (c->transport !=3D type)
> +			continue;
> +
> +		codec.id =3D c->id;
> +		codec.cid =3D c->cid;
> +		codec.vid =3D c->vid;
> +		err =3D hdev->get_data_path_id(hdev, &codec.data_path);
> +		if (err < 0)
> +			break;
> +		codec.num_caps =3D c->num_caps;
> +		if (copy_to_user(ptr, &codec, sizeof(codec))) {
> +			err =3D -EFAULT;
> +			break;
> +		}
> +		ptr +=3D sizeof(codec);
> +
> +		/* find codec capabilities data length */
> +		n =3D 0;
> +		for (i =3D 0, caps =3D c->caps; i < c->num_caps; i++) {
> +			n +=3D 1 + caps->len;
> +			caps =3D (void *)&caps->data[caps->len];
> +		}
> +
> +		/* copy codec capabilities data */
> +		if (n && copy_to_user(ptr, c->caps, n)) {
> +			err =3D -EFAULT;
> +			break;
> +		}
> +		ptr +=3D n;
> +	}
> +	hci_dev_unlock(hdev);
> +
> +	if (!err && put_user(buf_len, optlen))
> +		err =3D -EFAULT;
> +
> +error:
> +	return err;
> +}
> diff --git a/net/bluetooth/hci_codec.h b/net/bluetooth/hci_codec.h index
> a2751930f123..6e849c7d75b9 100644
> --- a/net/bluetooth/hci_codec.h
> +++ b/net/bluetooth/hci_codec.h
> @@ -5,3 +5,5 @@
>  void hci_read_supported_codecs(struct hci_dev *hdev);  void
> hci_read_supported_codecs_v2(struct hci_dev *hdev);  void
> hci_codec_list_clear(struct list_head *codec_list);
> +int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user
> *optval,
> +			     int __user *optlen, int len);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c index
> 8eabf41b2993..0af814c13b5f 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -33,6 +33,8 @@
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/sco.h>
>=20
> +#include "hci_codec.h"
> +
>  static bool disable_esco;
>=20
>  static const struct proto_ops sco_sock_ops; @@ -1032,12 +1034,7 @@ stati=
c
> int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>  	struct bt_voice voice;
>  	u32 phys;
>  	int pkt_status;
> -	int buf_len;
> -	struct codec_list *c;
> -	u8 num_codecs, i, __user *ptr;
>  	struct hci_dev *hdev;
> -	struct hci_codec_caps *caps;
> -	struct bt_codec codec;
>=20
>  	BT_DBG("sk %p", sk);
>=20
> @@ -1103,98 +1100,15 @@ static int sco_sock_getsockopt(struct socket
> *sock, int level, int optname,
>  		break;
>=20
>  	case BT_CODEC:
> -		num_codecs =3D 0;
> -		buf_len =3D 0;
> -
> -		hdev =3D hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
> BDADDR_BREDR);
> +		hdev =3D hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
> +				     BDADDR_BREDR);
>  		if (!hdev) {
>  			err =3D -EBADFD;
>  			break;
>  		}
> -
> -		if (!hci_dev_test_flag(hdev,
> HCI_OFFLOAD_CODECS_ENABLED)) {
> -			hci_dev_put(hdev);
> -			err =3D -EOPNOTSUPP;
> -			break;
> -		}
> -
> -		if (!hdev->get_data_path_id) {
> -			hci_dev_put(hdev);
> -			err =3D -EOPNOTSUPP;
> -			break;
> -		}
> -
> -		/* find total buffer size required to copy codec + caps */
> -		hci_dev_lock(hdev);
> -		list_for_each_entry(c, &hdev->local_codecs, list) {
> -			if (c->transport !=3D HCI_TRANSPORT_SCO_ESCO)
> -				continue;
> -			num_codecs++;
> -			for (i =3D 0, caps =3D c->caps; i < c->num_caps; i++) {
> -				buf_len +=3D 1 + caps->len;
> -				caps =3D (void *)&caps->data[caps->len];
> -			}
> -			buf_len +=3D sizeof(struct bt_codec);
> -		}
> -		hci_dev_unlock(hdev);
> -
> -		buf_len +=3D sizeof(struct bt_codecs);
> -		if (buf_len > len) {
> -			hci_dev_put(hdev);
> -			err =3D -ENOBUFS;
> -			break;
> -		}
> -		ptr =3D optval;
> -
> -		if (put_user(num_codecs, ptr)) {
> -			hci_dev_put(hdev);
> -			err =3D -EFAULT;
> -			break;
> -		}
> -		ptr +=3D sizeof(num_codecs);
> -
> -		/* Iterate all the codecs supported over SCO and populate
> -		 * codec data
> -		 */
> -		hci_dev_lock(hdev);
> -		list_for_each_entry(c, &hdev->local_codecs, list) {
> -			if (c->transport !=3D HCI_TRANSPORT_SCO_ESCO)
> -				continue;
> -
> -			codec.id =3D c->id;
> -			codec.cid =3D c->cid;
> -			codec.vid =3D c->vid;
> -			err =3D hdev->get_data_path_id(hdev,
> &codec.data_path);
> -			if (err < 0)
> -				break;
> -			codec.num_caps =3D c->num_caps;
> -			if (copy_to_user(ptr, &codec, sizeof(codec))) {
> -				err =3D -EFAULT;
> -				break;
> -			}
> -			ptr +=3D sizeof(codec);
> -
> -			/* find codec capabilities data length */
> -			len =3D 0;
> -			for (i =3D 0, caps =3D c->caps; i < c->num_caps; i++) {
> -				len +=3D 1 + caps->len;
> -				caps =3D (void *)&caps->data[caps->len];
> -			}
> -
> -			/* copy codec capabilities data */
> -			if (len && copy_to_user(ptr, c->caps, len)) {
> -				err =3D -EFAULT;
> -				break;
> -			}
> -			ptr +=3D len;
> -		}
> -
> -		if (!err && put_user(buf_len, optlen))
> -			err =3D -EFAULT;
> -
> -		hci_dev_unlock(hdev);
> +		err =3D hci_get_supported_codecs(hdev,
> HCI_TRANSPORT_SCO_ESCO,
> +					       optval, optlen, len);
>  		hci_dev_put(hdev);
> -
>  		break;
>=20
>  	default:
> --
> 2.17.1

