Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D53E5EFD;
	Fri, 27 Mar 2026 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616479; cv=fail; b=nftneMlb4uVFob+RlDp5atYsVw9rtsbAlLDFGMn++kEt/IZPq8SRGsTlu5oX0HgwG2Fv+2tHpihxRAlwhLDIH+Kw8wyO8zCjOzAvBI7A/BIOpw033w7ySv6s8Viw66KxV130hqL91H9FPp4MBwdrpqo1SOW0jGnC1ASGhuyEC4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616479; c=relaxed/simple;
	bh=XuvM5MW1+omQc4+7h5YY4JpNIuX19uwXt8p8pudwEg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rvUOBoTei8V8G8M6ypeHqk6AwKd/rS1ZPujwjeJvzYCk8nhDn465x41p6uaEYXG3BR5ABC9Bv1Pq0Bit5nymiZtdIt/WYUV+l0hi8luskP1+k+kwHGs3YCpkYLWR2Pzz2lvJpqJ52c/hnL8m15T/paGs/HVW9gFNxwHJ3Z/TVYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNm5HpeC; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNm5HpeC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774616478; x=1806152478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XuvM5MW1+omQc4+7h5YY4JpNIuX19uwXt8p8pudwEg8=;
  b=LNm5HpeCIZdElfVOto0+0mYp5cmruJvdt9c4qR5XIIzUVNXaWeDjviPA
   hIjRHR3VD6UTbahhhq9U/qKEOXRBYOERqqbTDK6ONFqhYlezx67MMY+uv
   qbQtkBtQrL0Rk/6Wvk9/CGoNaLnd4+ae4j+tsjLG7EkcO3bkSF4LeYVtV
   oJjSIRNG+bLbM9LqFjAgVGFbT5IS8QZuxiP6CBqlVJWqwsYGNaGJg0RJb
   ChhfdiRKmjaekAHSxNn+L0AITEjKluPN8uuQgze98de7sowg0G2ac9u7a
   7YuEFLxH8pKdUxwUU9vy+C7JWhXr8LkGffKlh4U9nTmQqPGbQjhMUQ1e6
   w==;
X-CSE-ConnectionGUID: uhtDh+aZTcKQX91nUsgThQ==
X-CSE-MsgGUID: Wel/nE60ToqF6CPEHTLWIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93269344"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="93269344"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 06:01:17 -0700
X-CSE-ConnectionGUID: uYlSjOEdQ8uW0utJt/u1DA==
X-CSE-MsgGUID: 4X6T1YJHSxW5ZnyIPVufwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255804035"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 06:01:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:01:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 06:01:16 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:01:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOy/3WTJ9aJ+b+k66u70w9aVzU5R/L/HBf5o4FaKu9ZkYCD3IHw60Q2U1k/ebYJ+STVEFcCxT4AV0EwMKN7rQ+L2lcVim9cPfYnm3sVfURknfYkg9pcsYd5x9GXhoHSneHAc9MSa9h/uoEKJUWEvV1S+Co9ToTUmbun+3i8oUTSTMTX1uircbOI9/sMKxrmr8H7d5D3rGwE0B11BLpaLyZDkvPG42wAMoUnLLWwQo0x5pBJ/3J9JHQQDNcng8vHH/Z+hjXNhtFKg/T5Ta+SC682BDh06RcF7qvQPMS0iTCB+rnaGcMNt/s838+ITyDhTDSaBtcwas2vfv2UV148AUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHW3mCZXIO6FXkfqm3M6TSo81Dijig68UP4xKFd8qdE=;
 b=RnOYcLk2I7nqdNFzajbPiMCOZli/mikORMj1Y2JYgpux+Iie4ttnJzSl94vXmjC8mKl2N1nmanOCbI9BZ2FGs9TOUJYATOVAsrvBD/LDw17HGZq8RiSD/KiVaZu73tPS/uju/ozyvP2ugbSTZyVI1Yw2hVfjpVZQTLfc9pQkXzrI06wGkv0iEWnO2A064uERMk44MtLLotDx6PZl7w2e3TO5+tc1RwPk9QFWN1jXMuqxaPOMMRh6UI20elzgRVprkITJuN0end3iRk4+KbXdT79DN3/28SaR6wuU+JgLl9US4/PO9LpQyr5DJl1FFPqJK8NpLSRuj/ZV0oQBpqN5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 13:01:10 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%3]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 13:01:10 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, "marcel@holtmann.org"
	<marcel@holtmann.org>
CC: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Srivatsa,
 Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH] Bluetooth: btintel_pcie: validate RX buffer tags
Thread-Topic: [PATCH] Bluetooth: btintel_pcie: validate RX buffer tags
Thread-Index: AQHcusAK14JupnS560yTXJSwbb6xg7XCXZdQ
Date: Fri, 27 Mar 2026 13:01:10 +0000
Message-ID: <PH0PR11MB758543B1D8B748997C24F45DF557A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260323121730.75256-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260323121730.75256-1-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH0PR11MB7562:EE_
x-ms-office365-filtering-correlation-id: 184b12f5-52d3-4a79-75fd-08de8c00eb0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: NGc0wRFKDRw6VO2fiCFyfEgclPw3ANW8jzFqdVCMo47VrjfdxeX9wzmkeqZ303MXz+UylXJ7z6gwEJKfxabH/vWpGmty9kk9iV+0ijbI6NYqdO/bbv/M6BPJ6AibRuDkgzsty/3YWFtwnzxgeJBQdsV0SVYdIf1Wt67BPMNFleXCGGeKIKrS5PFW0zJ5pTMntP+hQOH+tgAhb3d7GgBiFbpFqCMAcWk+woVXY0h9aS7MpBRPEjkzRbjUGayDqyLKCuxiKsZktjFOPEIhZJAsOSwe+pQgeq8l9wQR8TL+mfe6kKdjKgi7EMkSz1/R+E736aInv6brPGecyVcmw8A9GHapISW++IHafJvFalq4sTN/cWN0/1dzjzqoLH7kEtD78yJnKWJ5TFtRMf0wE66gO56jY2hKIrktvWRbyIWCCgWpOmC79YdOPc/oDgN7AFVS7zasONOKbXShXtLvJmmCevpAPt3NFoEDmS30rGs/7W4yUDOAYFr/uq/EPtrHx9sXl8EPLm1D/5osdfXTCZa+qUkicIEZfoquVB36pBZ2f+14jVh4uJnLLPRPlsPzxbkipYfna+heWRKWeQy97b7UuOO65tLvQn/lVPwwAGEFMgZ8r4/3v0f0DlNxyjfET/6o3w0fHBpyKUUPnDnbUvwKtIRkWEWaOpxLXoq5b5C7KO6Aoi9zs8fNxsJKLATcR883PWMimvb1KvR9Pcuu2h4jBvzlyYqzYAxPnmw5TDKrpgHL2fEyQEsz27zmx0tXVw3hacw1Wo8GhUjAXKRPICrXQtMVVXX2/HXn1NommSIdegs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uv4Q4bG4qcTZ8VtD5gwzBcydLjbN70wCEMayH5luZXKoagSQRKr/O38+9wtd?=
 =?us-ascii?Q?fqyR9L84MGM3Txsh6rmAOzCQeig4bSqvIiVwGoCbcT7xzA0P2CcCTZc8Yd+m?=
 =?us-ascii?Q?itDtXujZRUsa867WurTsy0k7nPGqpNs2e331h1tkCmm7pVA2wbnEX2ezJch5?=
 =?us-ascii?Q?+mnjTJsXF5gSdmfMrINZeFU66DB+WIZ1d8xRmYptaVBl+RoBKkHuAOwh/y4r?=
 =?us-ascii?Q?kd1mfUINdDSHJw6GvcGKaydwkmaxg5uL1t/PPcPqzStaGl+cDQILqIR7DEQn?=
 =?us-ascii?Q?wTgTJX5G4ZN7RLqfrXUDuwqJ98vLyk6TfTaEIYUemk/MuEvg4Tg+O1gr2ec9?=
 =?us-ascii?Q?w6BpOTQZNJB0WjoQbT/Z/fkjOLfZOuhUzfqqUk9oXUg0lYrVjf8S/ymq1Ub2?=
 =?us-ascii?Q?14wnW2p2ygXlDJp6tfm7dKkqs2MfljqrPqkmmZjPqQIUChtWYi1yvbzvD9Ji?=
 =?us-ascii?Q?qQr8+hnibhLkHvmsw4nhX2Jxg9ytABoafHoSUKaBqSF7adhrIBSM27PMGDYC?=
 =?us-ascii?Q?T2tWJYWzaqfFNnVm0D3aOn9WrtutRY6TNY72rFlxV5br67rkQrrMRE+tYRE2?=
 =?us-ascii?Q?T7W9Q6ZOIZcw29oZSqh7o1ZG2E2B2H4DF38cavlXB54F9zfxbFo48RWlIXPC?=
 =?us-ascii?Q?Yjj6L8mm5tJvg9dsbyCxFZuvidoot9I2zRMth3qI5BYgWArShTVYJNLPngzy?=
 =?us-ascii?Q?T9haKn8Tr3AqpcFDNOUNk6qhvc1qAjiEdCJFy333cbQkR59NYAd7uM9e7k12?=
 =?us-ascii?Q?B+ZGtPf7h6lxiby51BTmnCEkzS3DPh7H9nPa9cCsadDxMxfNwvFifoRhNPAR?=
 =?us-ascii?Q?m5Y01CFk2bUYQXzj5es/N0tYBjQo+Ebc4koMxhYYUlR54t7yAjIetrqPzKbD?=
 =?us-ascii?Q?3HhAD0KItXCpGwAapzeknRBqLuZr7eLjiDUCB/9fWG1vWkDyafSe4TFDLKJe?=
 =?us-ascii?Q?jtEJzp3VTE9J4eWT1XR3JHoNwDlXZL8tK0jSu+hY/K+tbhKw7ypB7z5CeTp+?=
 =?us-ascii?Q?roMqP9dTTXyMQl5a+4pFS/Wp68IEjTzqVSHbBDe4ZV5Qjn/WyMStW/XteW5L?=
 =?us-ascii?Q?R9OvYw1T6Ev6C/8EYLi60FaszTeL2UQyiKD8oB566uUWXRXjrMstj2A/9Dvm?=
 =?us-ascii?Q?UKu/KAB6WjAc4YfcxSCr4lnTnIad/S6sTwKIrt/O/4HH69Dgy82xuDmyySov?=
 =?us-ascii?Q?MOscvwRAx+ptz7GgNOmBTb5w8469z3UP1Uw9l48vIpfQ/bAYxhDBboxzzy0s?=
 =?us-ascii?Q?WtjqrNbrtU1FJCSKwnsKA7Es16UA0UE6CL1CRzmeeB5U7zFuEQZk6BZVzmYS?=
 =?us-ascii?Q?x7DRLwREvSE5yZzOPtgge2hSFpjTgUyun0V1moSPWQT3nKMDX2QLASZxbf/1?=
 =?us-ascii?Q?rI/JAVEvePVwbhwfCXEiOb91x+bgE2T7Kw1tsuVEc2ZvFfmlQRv4BGVOj/gf?=
 =?us-ascii?Q?lqJaoUyOInTT3tsp3dOKt01cKDqq12HpmNaizwDzjLqXnxuDbveHBiJOIbCz?=
 =?us-ascii?Q?zlJwAre4b343Q+yq6RBlwvSemE50WKPj/O8MuLOiTGvlEHOqIVmZk2YYA7YG?=
 =?us-ascii?Q?XXYSJt3tlDnB8JCVqOsQkYEL9Dhm3c1rRxeCB2H1N1N1MY5yBR6Aamw2GHi+?=
 =?us-ascii?Q?DNvsEzxCOePtgGLL6dwFVHkiz77G1KVgBK/RXULrEHpxIhOe5lkZ9LomYXGz?=
 =?us-ascii?Q?PSq8s3JAxPxO8iLFfhbE5azlOhXb5zzooaGquQ4oApx3DXWW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N21Rf1sVB2AIbWzIHyi81W3Y/XxIa8Kf17m+h5VzttR5zDnobZCkSNzYX05/0neF8Ap41CPNGIkRMAbpc6TgIO0NEi8bjQ5Gq8FV+eRsR3TIChnwssm//fJ2eXkLqLgnvb9AoMyFV7JZ4icpWoihnOEON7NJ91s2GFSESTSmGElPT2sfqTCq2VNdLTDAFQyV6fBbwF3luTkd1PGGwfnc29pWbvO3t7FCSFStVefuMVZtO2YYjp43pHm5FrkwLpd15gDEByUMAA4MUCSe07uOuHxBFKiTj74ouXztHLwJ8YP3fM5CK6v3MOeQzOcO3dakIh/Y0oqEWzso+zEm6DVFtA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184b12f5-52d3-4a79-75fd-08de8c00eb0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 13:01:10.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ld310chJfGkqZYM36M2Q8QFsryqXwP57VOxT1eVzGbf3MGa7NNXYeLAbXz3WkfRhc+nr4pQeQmF7fyxY1jnDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com

Hi Luiz, Pengpeng,

>Subject: [PATCH] Bluetooth: btintel_pcie: validate RX buffer tags
>
>The RX completion path trusts urbd1->frbd_tag as a direct index into the f=
ixed
>rxq->bufs[] table. The table only has rxq->count entries, while frbd_tag i=
s a
>wider firmware-provided field and is not range-checked before use.
>
>Validate the completion tag before indexing the RX buffer table so a
>malformed completion cannot walk past the descriptor-backed buffer array.
>
>Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>---
> drivers/bluetooth/btintel_pcie.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_=
pcie.c
>index 37b744e35bc4..4f6b3f00a49a 100644
>--- a/drivers/bluetooth/btintel_pcie.c
>+++ b/drivers/bluetooth/btintel_pcie.c
>@@ -1410,6 +1410,12 @@ static void btintel_pcie_msix_rx_handle(struct
>btintel_pcie_data *data)
> 		urbd1 =3D &rxq->urbd1s[cr_tia];
> 		ipc_print_urbd1(data->hdev, urbd1, cr_tia);
>
>+		if (urbd1->frbd_tag >=3D rxq->count) {
>+			bt_dev_err(hdev, "RXQ: invalid FRBD tag %u",
>+				   urbd1->frbd_tag);
>+			return;
>+		}
>+
> 		buf =3D &rxq->bufs[urbd1->frbd_tag];
> 		if (!buf) {
> 			bt_dev_err(hdev, "RXQ: failed to get the DMA buffer
>for %d",
>--
>2.50.1 (Apple Git-155)
>

Tested-by: Kiran K <kiran.k@intel.com>

Thanks,
Kiran


