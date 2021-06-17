Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14214C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 07:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2A8613C1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 07:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhFQHzt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:55:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:54724 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhFQHzt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 03:55:49 -0400
IronPort-SDR: JYB3lgXOjjZhTfdE6d9BOK7+EJ7zTCr59wAWs6Nff5RoSR4qcBQ8HezwXVlMk88lej9VXJoDiy
 kAPKkgtB6now==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="204492997"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="204492997"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 00:53:41 -0700
IronPort-SDR: zoimMITIj8eAFnZarOFr/QYV33Mq8y8qqja13PMHSRycJYA9/YXP4NTwDgRn9OWksgSZhJw8e2
 rzBDYtaBGZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="404579941"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2021 00:53:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 17 Jun 2021 00:53:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 17 Jun 2021 00:53:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 17 Jun 2021 00:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPiYoZ3IVRyQAsjDtKDa4IWZZTzCuea8kbZP8dW1Yat4v0LChRTetpzOpYPrZlsYK1oq3ILqTsWJKVbjDW4C2bSktxRVhXUP4OfPlze6dUMfSq8BN+ywMFPMdMn0L4BGlsNml3buAoqP5IUGGB8ji5c8zP3A3iKQAcK3rSWYXybSUmlVmWSaFRyquBO5r+o9Fu0Iq3WYIGAqxvO9iQhf/RvveKZrZzeiPzUcaWn7D2JT1+3wvWEPEuUi9jWzpr8Q7/b9b3aJOBONuZnLpEQWgTeywGLPU6upqP5GEMD9EhMIrVc3Ybd7jV04wPcbtdbThjF0saXkNG8XFJH8JsRw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCVvCw72biUlgehVTd3IDl4TaQrBv+6VawB7dWGSyMY=;
 b=aG9B5uvx+3zPA6fTcP+gTpdEmrHWWs3AZpguwdKMnvauTurNX0uqfLxfY97hDWw+YLZVMPIAg1mNZC3jfo7FOmjr6OLASfOpIi/jZ7x1ftv+dLtLg2VJr714+QlAdEz2vHaa4NRCVf6LqVi2eu8+rdWgM5aHUYeIi+Mp3Sf6irOgsFzXlLX7/P1cgFvrqa2vojdS9MOq94ZFskXOMkD6atv0ZDKrgci352zwr8iDK+SA5EBjjSZ2ZOpH95492I4y/h8+n1wOKr6jJTTbm9Fuv9qVfsItAgUOIXuXXMRrHTqNtzI1RJeeOLP9FYB0PvbsJUKpMXqQxyAQbbpy4Ne3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCVvCw72biUlgehVTd3IDl4TaQrBv+6VawB7dWGSyMY=;
 b=BtarWLmejtIjyUOcosVpmOb1qhvU87nTTkQLybN7zHtet4D8+bydiMrMgzAb+rIUEJPfcwnHSOeuglM8fPaLjFXjG8+0Ehf7LO4CNoOMJc6nPK1KNfa/6Je5kj/WP29pvmYkOF1y58Jxh/DbE95xKMUSaDM5UxFWqCU0F24HeYc=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Thu, 17 Jun 2021 07:53:38 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c%7]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 07:53:38 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v9 07/10] Bluetooth: btintel: define callback to set data
 path
Thread-Topic: [PATCH v9 07/10] Bluetooth: btintel: define callback to set data
 path
Thread-Index: AQHXXGDBvoh7Lx/Y80O2QB58/K7zoKsVg5qAgAB8+yCAACS7AIABuOrg
Date:   Thu, 17 Jun 2021 07:53:38 +0000
Message-ID: <DM8PR11MB5573C680C3BD9F7954B5C9B6F50E9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-7-kiran.k@intel.com>
 <4C624839-10D3-4114-9037-4FB9E93E1EB6@holtmann.org>
 <DM8PR11MB5573451838727540A14200D4F50F9@DM8PR11MB5573.namprd11.prod.outlook.com>
 <4D9B420C-BD66-4E74-81EB-F0090D575115@holtmann.org>
In-Reply-To: <4D9B420C-BD66-4E74-81EB-F0090D575115@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2405:201:d012:c818:2c35:dfb8:25d9:ba5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63ba2f32-fd63-4855-f44f-08d931650468
x-ms-traffictypediagnostic: DM8PR11MB5653:
x-microsoft-antispam-prvs: <DM8PR11MB565392AC9390178B9387814AF50E9@DM8PR11MB5653.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: chJZG/sCjU2YsuXs+Dd7ysPZyxsttdh99Ntc0Yv+BXZ0Bi4Sp1j1xvwKVXReMa86OQomom7Xo9emcBC7HHtxwqvK46QmmO6oT/AMGYr8Fo4brX5lrsLZh3sBwyFGrfizyPEJp+FSReeTGCT+0lpaLQBRd0V2qlCamJzB5iH6R2QHfTb7APUrlc/M5zwewhRzAyJ+LQDr1y6UzCMymYbETNE8VqPc3ObGLx4BNbRlUGhJjO3dPbhMZzGajuQ50g60q6sSoEfaGQ4RyQt93uZz2MQVs06iOGivMBh0jON3y0XH5fhTURx2nLqOiF6P7CkPepaON70YE4xSsp/S95bfttiCTHoi6fvCSGDWa/1HWCpI/oL+Wjfyp07X2qdqJoh1d3ugA6NtGsGiiUnX8hbllA9Yf/rLzacILoC3rCs2JrloLhsViB1sCE1aeHDY7mlN2S2Os9aUFrpI47L9lkR4AzjkvPP6lGCuLtzhtJrnzHWROB9sqbnb5yOUCrnYPP9xYB2LkcO5tIGmrSZ23WsP2fTBRianbP/6ohflvQqWDxzR/gkiwdAsD6eQj4Q8Nlj+lmqibGErwfVZnI5q0ikWA7frc1vww2aXVtfhryAQomg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(346002)(136003)(86362001)(5660300002)(71200400001)(64756008)(478600001)(8676002)(8936002)(66946007)(6916009)(2906002)(66556008)(66446008)(52536014)(186003)(53546011)(7696005)(38100700002)(6506007)(316002)(83380400001)(76116006)(122000001)(9686003)(4326008)(66476007)(33656002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WQ4COskCYTFs6h/K1PNn+fPhitEAsYy38Q/F7b7TuH16SiFkGxPU3sw8pacY?=
 =?us-ascii?Q?Jyk4WfEVfThnCzZwm/v1dZYOJWqZwjQel5WPuSw6Ay5A8OiPxCflPs3e6J8k?=
 =?us-ascii?Q?zNQoosSFFKRiiu+RNWJQprMcXqilknBO8E+H6qVwDmqbjj0E/P2jgGWTrL1T?=
 =?us-ascii?Q?lnzlI3iBLDLgqD8BHfHfDGxb72xoYdAVpo5MLQqkvQbBbzCXpMYaoUxB/BPU?=
 =?us-ascii?Q?YWp+B0CUg7Okz1T4U1J2zxxkc9uaQBOq7FL6/GueqetOp1FdATbXdPmtPlm1?=
 =?us-ascii?Q?b62T7X/ZIdEOL7/aBYAdZnUEJz5hRjr2mZPQR9ykK5fF82LjAeklhQC32RRV?=
 =?us-ascii?Q?zCwR91j/LOVw0b8G4zG5hKTviUjWSN6kP1UCI4eZQRduyYxmxK2sLdZvF4qX?=
 =?us-ascii?Q?gYX9xb7BvwD3hnJ50ih6U+6bOKFWMa98AfLS6ETSeGJEpYfqVfqzjf2cL8ws?=
 =?us-ascii?Q?8czl1lGqEdFNb3UOKeGPfQ+VwxOah96zHvry0TNx+y3M9ajirH8rwX38ILHj?=
 =?us-ascii?Q?hM9n+vJs08oOE1eESM74yDFOv23yJhix5cmH9quBeXMLFAHoifOoHOnu7gHm?=
 =?us-ascii?Q?pIenSndAA1vHE1Wn0s0nsi2MQGwqOIpoJWRqY8Xfq8pX8FLqfxpcr2RnP1AQ?=
 =?us-ascii?Q?xrm7ewfNaGUeRY1PM99vkIUS2EMEkWqE6LsQIyOnxebai+e8gxUz8oPY025f?=
 =?us-ascii?Q?zPOBfUcbRA9RkAPkC6uXbw9IK0lqQd5RXs7c+SWOpSgCKOlCCAfTaLnNlqxB?=
 =?us-ascii?Q?zP1/l1JPasyC5NQwEGBXF7OVnGxDdEFJFgaCNZJtPmgjdSEMVEl+laGNOozo?=
 =?us-ascii?Q?+32UHIcT6B1j4LTZKDQHXZ1knlVJfRDbNCMxGrjVvPMOf4e03YSZ8CwF4dO1?=
 =?us-ascii?Q?UMMRVnAH7bPkWSu7/dXwK23I0N5qjCeAYHtZZCH3IjsktIjNaUhy0h9MzVaF?=
 =?us-ascii?Q?pNoknG8Jqz0pcsfB55mik6TZl40qJ6ViOt88O2/QQlScMGsH7H+/8OlFMRdb?=
 =?us-ascii?Q?qKqMxNO7TX/PS31B3+ETkDoduXA50Pxk6sP8MRINMyGeBWCk3+PEpQ8uSH+5?=
 =?us-ascii?Q?vyG8ZN2uX+ZGUwVQRtIdglCPjzEJkvoUoqqqvgQtFtg5Zq2qzJnEoUqots5p?=
 =?us-ascii?Q?KoLMsZ+inCXYMpdl1scAwT+g+pA3Q/InsyQQG3hOjs4b4h7m8Q8+D93rSJtv?=
 =?us-ascii?Q?3ede8wSH8HPDZDmL2iJ6cjedcUW/25zCTuHnIAXbuJ0RSBy8FVOsoLudzqMr?=
 =?us-ascii?Q?P4XBHIdUvvlhNuxTB3kSmhkbbbOxD2ihSH+R2i0hiP3OHK+SCWy6zLeA4UJb?=
 =?us-ascii?Q?dlLfgh3mWNVilmZI8PrVtvNzKWFfVEDCeEdUaraSZaBiK2/GGBljeKnvIEYP?=
 =?us-ascii?Q?LMRTybzdaMFCIGZWEUFlTfKwgQE5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ba2f32-fd63-4855-f44f-08d931650468
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 07:53:38.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWaTSFrBMTL616762sYvw8+6BZCJ8pK0O6nwSBsMLAJJKHkl3RcPDRQ2OUrPxO4csCW35fhoO9rPoRKG1Kd+lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5653
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Wednesday, June 16, 2021 10:48 AM
> To: K, Kiran <kiran.k@intel.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH v9 07/10] Bluetooth: btintel: define callback to set =
data
> path
>=20
> Hi Kiran,
>=20
> >>> Adds callback function which is called to set the data path for HFP
> >>> offload case before opening SCO connection
> >>>
> >>> Signed-off-by: Kiran K <kiran.k@intel.com>
> >>> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> >>> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> >>> ---
> >>> drivers/bluetooth/btintel.c | 50
> >> +++++++++++++++++++++++++++++++++++++
> >>> drivers/bluetooth/btintel.h |  8 ++++++
> >>> drivers/bluetooth/btusb.c   |  4 ++-
> >>> include/net/bluetooth/hci.h |  8 ++++++
> >>> 4 files changed, 69 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/bluetooth/btintel.c
> >>> b/drivers/bluetooth/btintel.c index 95c6a1bef35e..3eba5c587ef6
> >>> 100644
> >>> --- a/drivers/bluetooth/btintel.c
> >>> +++ b/drivers/bluetooth/btintel.c
> >>> @@ -1308,6 +1308,56 @@ int btintel_read_offload_usecases(struct
> >>> hci_dev *hdev, } EXPORT_SYMBOL_GPL(btintel_read_offload_usecases);
> >>>
> >>> +int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
> >>> +			  struct bt_codec *codec)
> >>> +{
> >>> +	__u8 preset;
> >>> +	struct hci_op_configure_data_path *cmd;
> >>> +	__u8 buffer[255];
> >>> +	struct sk_buff *skb;
> >>> +
> >>> +	if (type !=3D SCO_LINK && type !=3D ESCO_LINK)
> >>> +		return -EINVAL;
> >>> +
> >>> +	switch (codec->id) {
> >>> +	case 0x02:
> >>> +		preset =3D 0x00;
> >>> +	break;
> >>> +	case 0x05:
> >>> +		preset =3D 0x01;
> >>> +	break;
> >>> +	default:
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	cmd =3D (void *)buffer;
> >>> +	cmd->data_path_id =3D 0x01;
> >>> +	cmd->len =3D 1;
> >>> +	cmd->data[0] =3D preset;
> >>> +
> >>> +	cmd->direction =3D 0x00;
> >>> +	skb =3D __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH,
> >> sizeof(*cmd) + 1,
> >>> +			     cmd, HCI_INIT_TIMEOUT);
> >>> +	if (IS_ERR(skb)) {
> >>> +		bt_dev_err(hdev, "configure input data path failed (%ld)",
> >>> +			   PTR_ERR(skb));
> >>> +		return PTR_ERR(skb);
> >>> +	}
> >>> +	kfree_skb(skb);
> >>> +
> >>> +	cmd->direction =3D 0x01;
> >>> +	skb =3D __hci_cmd_sync(hdev, HCI_CONFIGURE_DATA_PATH,
> >> sizeof(*cmd) + 1,
> >>> +			     cmd, HCI_INIT_TIMEOUT);
> >>> +	if (IS_ERR(skb)) {
> >>> +		bt_dev_err(hdev, "configure output data path failed (%ld)",
> >>> +			   PTR_ERR(skb));
> >>> +		return PTR_ERR(skb);
> >>> +	}
> >>> +	kfree_skb(skb);
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(btintel_set_data_path);
> >>> +
> >>> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> >>> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver "
> >>> VERSION); MODULE_VERSION(VERSION); diff --git
> >>> a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h index
> >>> 9bcc489680db..9806970c9871 100644
> >>> --- a/drivers/bluetooth/btintel.h
> >>> +++ b/drivers/bluetooth/btintel.h
> >>> @@ -183,6 +183,8 @@ int btintel_set_debug_features(struct hci_dev
> >>> *hdev, int btintel_read_offload_usecases(struct hci_dev *hdev,
> >>> 				  struct intel_offload_usecases *usecases); int
> >>> btintel_get_data_path(struct hci_dev *hdev);
> >>> +int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
> >>> +			  struct bt_codec *codec);
> >>> #else
> >>>
> >>> static inline int btintel_check_bdaddr(struct hci_dev *hdev) @@
> >>> -325,4
> >>> +327,10 @@ static int btintel_get_data_path(struct hci_dev *hdev) {
> >>> 	return -EOPNOTSUPP;
> >>> }
> >>> +
> >>> +static int btintel_set_data_path(struct hci_dev *hdev, __u8 type,
> >>> +				 struct bt_codec *codec)
> >>> +{
> >>> +	return -EOPNOTSUPP;
> >>> +}
> >>> #endif
> >>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >>> index 1e51beec5776..afafa44752a1 100644
> >>> --- a/drivers/bluetooth/btusb.c
> >>> +++ b/drivers/bluetooth/btusb.c
> >>> @@ -3012,8 +3012,10 @@ static int btusb_setup_intel_newgen(struct
> >> hci_dev *hdev)
> >>> 	err =3D btintel_read_offload_usecases(hdev, &usecases);
> >>> 	if (!err) {
> >>> 		/* set get_data_path callback if offload is supported */
> >>> -		if (usecases.preset[0] & 0x03)
> >>> +		if (usecases.preset[0] & 0x03) {
> >>> 			hdev->get_data_path =3D btintel_get_data_path;
> >>> +			hdev->set_data_path =3D btintel_set_data_path;
> >>> +		}
> >>> 	}
> >>
> >>> 	/* Read the Intel version information after loading the FW  */ diff
> >>> --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >>> index 31a5ac8918fc..42963188dcea 100644
> >>> --- a/include/net/bluetooth/hci.h
> >>> +++ b/include/net/bluetooth/hci.h
> >>> @@ -1250,6 +1250,14 @@ struct hci_rp_read_local_oob_ext_data {
> >>> 	__u8     rand256[16];
> >>> } __packed;
> >>>
> >>> +#define HCI_CONFIGURE_DATA_PATH	0x0c83
> >>> +struct hci_op_configure_data_path {
> >>> +	__u8	direction;
> >>> +	__u8	data_path_id;
> >>> +	__u8	len;
> >>> +	__u8	data[];
> >>> +} __packed;
> >>> +
> >>
> >> if this is a standard HCI command, why is this done as hdev-
> >set_data_path?
> >> This makes no sense too me.
> > Intel uses  HCI_CONFIGURE_DATA_PATH to command to set the preset ID
> (NBS, WBS, ...). Here len and data[] are vendor specific. I should have
> prefixed these fields with vnd_. I will address this in next patchset.
>=20
> if the command is defined by the Bluetooth SIG, it is handle in the core.
> However if it needs vendor specific input that we need a callback for jus=
t that
> data.

The current design uses HCI_CONFIGURE_DATA_PATH inside  set_data_path callb=
ack and its not used at core.  I have leveraged SIG command here  to minimi=
ze defining  of new vendor command as vnd_data[] gives flexibility to pass =
in non-standard values. Other vendors may not have same command/flow to con=
figure data path.=20

If we are not supposed to use Bluetooth SIG command at driver level, then I=
 need to come up with a new vendor specific command.  Please help with your=
 input.
>=20
> Regards
>=20
> Marcel
Thanks,
Kiran

