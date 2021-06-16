Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C9C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 03:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E886F61369
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 03:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhFPDNI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 23:13:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:29920 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFPDNH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 23:13:07 -0400
IronPort-SDR: ghKklTbIKyvOFEEWeMd8furUuy8+M/5G9byFg9o3yazntHVtLpUMtYxL0diUvV3DL/GXImbrKp
 5MLNKAV45R4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291737540"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="291737540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 20:11:02 -0700
IronPort-SDR: 2ebks4uBI2TVQXPBxnbgVifJGupaCnCT+vIVMBCNnUN/OoISwzmaq7DfmyjQTCHLIqM4sHc+4D
 UGx3GWCTJAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="621551368"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 15 Jun 2021 20:11:02 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 20:11:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 20:11:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 20:11:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7Xx5YVxhbWAvhZTI7exyUZvuNWm25Ikb9ckH76SOIWI1nuObxfmLD6h/Ojcgm4hgg9gZWGlf3sFl9KmlAVnxojcsVPCS+35iiGAzNFmlqTdZBIkbqP+fNU+wMmEsePAPtqG1r8GfKxGa0rk4CvN3fP7mvmzCU9t+uOBulWNf8qcrNkfqdTNhH/BADiwm+eRQsEwN8WQA0ZSs5sUdrf3cbudFWdIfyesNwJoemixn+2vf2igPjHBk3dhzgdhR5fuUC2AAUq7rCKJifJZqw6x8KoW1Viq4S1OIJes9PWJizF+67xfIurWTWH9CBurMNhMDyidlwkGYwCLspPby/6Q8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX9dTEn731+M8LS9esAcvInvMKNc/YrJ85iX9fbIJ6Q=;
 b=jml0JU0v11HV+TK+JERCAXrq83/ekGxWTf4JMzFUqVm/+ns4XRR76VdWoj9MlVIbF1nwMwJCavIqe78zZmf0lUNeszVo1hoZCZk+L2TVZ0rmbuvRx46qOnvnX8BH8EhqHfA1+MB3zKbBIfe2N2Tqm8cfvwYggUw3jbXjmYF0Tx96nMGoAutPxwcNcJzXsni/h89E7/v1nGEpvEcga6nMyVGq5T+44LeMz/vXwMsrXqX/tW5gcN9hwEQMXZABgoL9S4bPJZPbVOJ/qGYC7GF3h2pTE8PktvM0PX0b8o+7pwWTlWL5C43+cxqGzHqj6h2BQGpg/dOLNe1/H4DkIATkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX9dTEn731+M8LS9esAcvInvMKNc/YrJ85iX9fbIJ6Q=;
 b=y34U8gU397t2l253vhNTWVT4sroLb4NYMwNSofL55WWVfQ8/gaekv7SfRTEzj6R32ZbMkzHLWV+xFfBBT+4F8hVIVLbrupS3c58DyMX6/Pcmit8alnrb2f3f4N+0n594GD/oDulPkUrHhe/7cwx9dDYY+/soBljAYZMcGWape0s=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM4PR11MB5568.namprd11.prod.outlook.com (2603:10b6:5:39a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Wed, 16 Jun 2021 03:11:00 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 03:11:00 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v9 07/10] Bluetooth: btintel: define callback to set data
 path
Thread-Topic: [PATCH v9 07/10] Bluetooth: btintel: define callback to set data
 path
Thread-Index: AQHXXGDBvoh7Lx/Y80O2QB58/K7zoKsVg5qAgAB8+yA=
Date:   Wed, 16 Jun 2021 03:10:59 +0000
Message-ID: <DM8PR11MB5573451838727540A14200D4F50F9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-7-kiran.k@intel.com>
 <4C624839-10D3-4114-9037-4FB9E93E1EB6@holtmann.org>
In-Reply-To: <4C624839-10D3-4114-9037-4FB9E93E1EB6@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.181.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4cbd7dd-c705-4a8d-4c91-08d930745dfe
x-ms-traffictypediagnostic: DM4PR11MB5568:
x-microsoft-antispam-prvs: <DM4PR11MB55684C35AF1E012DAD4763BCF50F9@DM4PR11MB5568.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNWwcXQ7VdOUA9njIyHNEN+LLWEZHKkBI9pR1Q2HMwuL0JIYAsOrWo2bcaC9VQ/4QZW16u+w4WsltrL5rLhXtGW0gwOqO+Pz47B8XGSUdHTfHUI6Ue2ZYqrHw8a4b6cdYxbD1va8Y9UgBDK+9wgq0tBMDX95tc7z5j160wFBqBmZ/xoBniCxmBzF/0/Icn0nWy9qTDgbjEdFQvd9DzJ4nkkvql9o2K1qg4OeuaAVBFLpYQy6FOjSA118szMAok5aIHhT4MIjEnUtRSstP8GMiwPpiB3nK9OKcDHNnQPzjHwVPZVwdZMV7lvw8zbNq+q6mQ8/+D/X/4JbgHN8jP3q8IWMZahERV2edIJpq8Aqa9/mjsO0QdXG/LPsEBRAoHLoN19tSrOrze92yx44B0esuAGtfFKllD1zpxhUuxSC0a3s0y7+JgCkksUFkJ0lYoqI/Y5F/9MWLKwXulTEyzrOPGt3Ba+Eqa4unTEGUZRDeMZsaMbkOJyiVuVMivv9mjCC05kvaWjIM/6xVX8ZMDFa3CxQpDzPXouQwClGJaeOuzRt0PKgTTAGKYIw6UY/K/0lQeIG5VhOvGvcmwrnK6t6cUbRfLuYdrSG+XAWMgxtug8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39860400002)(2906002)(316002)(55016002)(5660300002)(38100700002)(52536014)(186003)(9686003)(26005)(478600001)(122000001)(4326008)(7696005)(33656002)(76116006)(66946007)(66556008)(66446008)(64756008)(66476007)(6506007)(8936002)(71200400001)(86362001)(8676002)(83380400001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M69+rPCd/kcTSpWTZh+Ihm4QoBXxXZnfVXnKo8blDxs7Dem7cpiTaO/lmu/o?=
 =?us-ascii?Q?bS3uvanI1s8qmfpw3zvd+dUY0hc7Aq5+JBSs8qw47kpbL1ugdXBeEFqn+mw/?=
 =?us-ascii?Q?GQWLwkOG2oEm0z23NZ+29t/4M5ZX0In6Lg/z51Duts7qWHD7m7y0AsDiAv5y?=
 =?us-ascii?Q?4jy0g3yV8T6jptB4klzfq6B9JOJpHUa7oRwkh9qR2plsFAm45pE2eab6+UVZ?=
 =?us-ascii?Q?rGKhjY446h/YA1SKoMvhbehm7aMRgG1R75sBs1MvqL0+DfIIvH+RI8VIJH0P?=
 =?us-ascii?Q?XoLd+3RoPedlBh6101xZqs1kD2nvU06kuRbXMsTYc0Lw8f+4GK4iSWeN/Ndj?=
 =?us-ascii?Q?c/sbCVZmQbFfRKbA0b3RjQkiRMk4hB2LCd8CZyshIbsl/SyeHAAuT2mcdVbE?=
 =?us-ascii?Q?8Q7Q7aylos9NaJfljfv/j6UyMvHpNO0iNCDSq3imh2JrwrZEOZ9a39FVvTOZ?=
 =?us-ascii?Q?hdjllzLH/XKNHfLGp++Uv9aYo2pfRyebD8/muspGgoEaCwl907xoDTFXSFHs?=
 =?us-ascii?Q?pyTProoP+rGGlHoLv17xN0PzbRmuTcJKYUoox4Brk+t9Xw9AvgsYpNCLNUlO?=
 =?us-ascii?Q?4gkm1vlnyBTFzuhXpRXXbPBpFu4euZ4sUf/yWkPgIkPh8P1mx7GSK+0j4zap?=
 =?us-ascii?Q?0qiiQTKWNAfKnOi/dSAZi1QOKqcsxrSMHW7NqTc+Cow7W65Qf0ANvjnpFCZh?=
 =?us-ascii?Q?1bFZR1enoVHQHjk/UhU3Y1wvgwJdMo5PgIudi+uB8/eB7OiquCFaz7K4CuhZ?=
 =?us-ascii?Q?CBcy4t4vUxNykYboD+ilPv4UYHBws4074s6Gv+GtFRWU/HV3w3rPZAW702xx?=
 =?us-ascii?Q?isu7RY3yp5YjvwOhW7aGsgKAKDTH0UTeIhc9vqYRABZQlmIVKQFv0/xnR26b?=
 =?us-ascii?Q?f2MWNFX7gQ44Y6B4gU/MA80yuyaXVPLhfSy6PR3HoyoZbwhxKCMfrm+oBqsT?=
 =?us-ascii?Q?iUitARhMNrHPq0x90BoaLfqPluvlLxqVnMIshMBsPe80wIQZLW/xjioBwl7j?=
 =?us-ascii?Q?i2UP3qHbmXW3mU1H7ht3DqM3mdIh/Bly82rJhVMAFPSMfNLdEWnUAecdltBj?=
 =?us-ascii?Q?KVvVDQGQ6lQUjmdBYBL7pI9phoIpkcc9rB7+fcnij4nMq2reqS0PHa4jrhCH?=
 =?us-ascii?Q?zj6PZEsqpB3tQcU4qNufOjroXu8c/lO7PbGBOZTD2Z2DS95UOhPVU8K6Fqpv?=
 =?us-ascii?Q?1gYJYtrjFWUGHJzzy2vZo7VfWO7hqhDVNuo1D0Dn3zhlqhmskXZoqwrDv+jD?=
 =?us-ascii?Q?g15vb6fuczBfFwONrn5I4rZO4kmojHexFMuO0llIoXiA4Xp7rcERRgPFQuSa?=
 =?us-ascii?Q?ac5Sev2iP/Kx9cUl1ANaECca?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cbd7dd-c705-4a8d-4c91-08d930745dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 03:11:00.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3CRe0P5XnchdgPXrXZhcDmcFfMPepFjKj/HP/6Yj+LcxggP6tz4YzDChpXUiAvK2d/yQ4vSGHooAgd1eXFiwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5568
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

>=20
> Hi Kiran,
>=20
> > Adds callback function which is called to set the data path for HFP
> > offload case before opening SCO connection
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > drivers/bluetooth/btintel.c | 50
> +++++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/btintel.h |  8 ++++++
> > drivers/bluetooth/btusb.c   |  4 ++-
> > include/net/bluetooth/hci.h |  8 ++++++
> > 4 files changed, 69 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index 95c6a1bef35e..3eba5c587ef6 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -1308,6 +1308,56 @@ int btintel_read_offload_usecases(struct
> > hci_dev *hdev, } EXPORT_SYMBOL_GPL(btintel_read_offload_usecases);
> >
> > +int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
> > +			  struct bt_codec *codec)
> > +{
> > +	__u8 preset;
> > +	struct hci_op_configure_data_path *cmd;
> > +	__u8 buffer[255];
> > +	struct sk_buff *skb;
> > +
> > +	if (type !=3D SCO_LINK && type !=3D ESCO_LINK)
> > +		return -EINVAL;
> > +
> > +	switch (codec->id) {
> > +	case 0x02:
> > +		preset =3D 0x00;
> > +	break;
> > +	case 0x05:
> > +		preset =3D 0x01;
> > +	break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	cmd =3D (void *)buffer;
> > +	cmd->data_path_id =3D 0x01;
> > +	cmd->len =3D 1;
> > +	cmd->data[0] =3D preset;
> > +
> > +	cmd->direction =3D 0x00;
> > +	skb =3D __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH,
> sizeof(*cmd) + 1,
> > +			     cmd, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		bt_dev_err(hdev, "configure input data path failed (%ld)",
> > +			   PTR_ERR(skb));
> > +		return PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +
> > +	cmd->direction =3D 0x01;
> > +	skb =3D __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH,
> sizeof(*cmd) + 1,
> > +			     cmd, HCI_INIT_TIMEOUT);
> > +	if (IS_ERR(skb)) {
> > +		bt_dev_err(hdev, "configure output data path failed (%ld)",
> > +			   PTR_ERR(skb));
> > +		return PTR_ERR(skb);
> > +	}
> > +	kfree_skb(skb);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(btintel_set_data_path);
> > +
> > MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> > MODULE_DESCRIPTION("Bluetooth support for Intel devices ver "
> > VERSION); MODULE_VERSION(VERSION); diff --git
> > a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h index
> > 9bcc489680db..9806970c9871 100644
> > --- a/drivers/bluetooth/btintel.h
> > +++ b/drivers/bluetooth/btintel.h
> > @@ -183,6 +183,8 @@ int btintel_set_debug_features(struct hci_dev
> > *hdev, int btintel_read_offload_usecases(struct hci_dev *hdev,
> > 				  struct intel_offload_usecases *usecases); int
> > btintel_get_data_path(struct hci_dev *hdev);
> > +int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
> > +			  struct bt_codec *codec);
> > #else
> >
> > static inline int btintel_check_bdaddr(struct hci_dev *hdev) @@ -325,4
> > +327,10 @@ static int btintel_get_data_path(struct hci_dev *hdev) {
> > 	return -EOPNOTSUPP;
> > }
> > +
> > +static int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
> > +				 struct bt_codec *codec)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > #endif
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 1e51beec5776..afafa44752a1 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3012,8 +3012,10 @@ static int btusb_setup_intel_newgen(struct
> hci_dev *hdev)
> > 	err =3D btintel_read_offload_usecases(hdev, &usecases);
> > 	if (!err) {
> > 		/* set get_data_path callback if offload is supported */
> > -		if (usecases.preset[0] & 0x03)
> > +		if (usecases.preset[0] & 0x03) {
> > 			hdev->get_data_path =3D btintel_get_data_path;
> > +			hdev->set_data_path =3D btintel_set_data_path;
> > +		}
> > 	}
>=20
> > 	/* Read the Intel version information after loading the FW  */ diff
> > --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 31a5ac8918fc..42963188dcea 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1250,6 +1250,14 @@ struct hci_rp_read_local_oob_ext_data {
> > 	__u8     rand256[16];
> > } __packed;
> >
> > +#define HCI_CONFIGURE_DATA_PATH	0x0c83
> > +struct hci_op_configure_data_path {
> > +	__u8	direction;
> > +	__u8	data_path_id;
> > +	__u8	len;
> > +	__u8	data[];
> > +} __packed;
> > +
>=20
> if this is a standard HCI command, why is this done as hdev->set_data_pat=
h?
> This makes no sense too me.
Intel uses  HCI_CONFIGURE_DATA_PATH to command to set the preset ID (NBS, W=
BS, ...). Here len and data[] are vendor specific. I should have prefixed t=
hese fields with vnd_. I will address this in next patchset.
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran

