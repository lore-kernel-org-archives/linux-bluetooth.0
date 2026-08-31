Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A13CF213;
	Mon, 31 Aug 2026 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174311; cv=fail; b=k1h1oB31uzFKJs6Y1UHOfdSQWzy8wRL6JJh1NRRBzXHxs38SFK/mCDTPSrXeyE0ZRBQOYi/ySA6WD/ubDIRj40GNCsjMozAWLEMKJ2/LedpGEqMlGdBiaou09uFVoKIg5o3/lDHXBUneU3CH/JpZn+ac5VQ1c6/TlIl2uT1fB30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174311; c=relaxed/simple;
	bh=NtTK6k0F9Xnthq8jKsrHQLfz5Bw2EzVk5Qp0E2FbyrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGKcqzqR+uCizGJfzASd5L7t1iXDBcHX7AKzguXJSqTtuCxrDYHsAl5ugjYJF5/b7t51Ibq7C4CJxMjRMZrIQPFlXF9PdFbVyodns04LbVMJU5fxF0blSJcSJIP6HxM508JY3j1lz4TMYpWNmGrwhqHNxUiCIKxmBX84M96yzv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsiGLWp7; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsiGLWp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788174309; x=1819710309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NtTK6k0F9Xnthq8jKsrHQLfz5Bw2EzVk5Qp0E2FbyrA=;
  b=jsiGLWp7w9Sk0iY0MHimpp/JBGwNOTZiB3BKnxxOdMdIA0Xe/kYHxQlv
   1dth95U8EMNXAhpjrIEZeZfnSNVKaqlhdYQgXLGlwygHKqSQ02lYhmeBu
   8p0xjFy8tULb/u5PyIJQ5zKaanU6uHE2JIXybIRDgJElIDPFnyrunj5SK
   Wy+QlB37EwtjWSHQh/rdO9qpMrfny8YVHudVpBTDgfdqOKrsLkSVMOcQE
   zL6VN0TYUmU7dnfuGAH2h+2a4EfRIFCVD5kfglQ8kTawbcTPKoZwUWpRJ
   MFIfs0xfAghhlYHuSVbK8r91PH1H/hec6h8Xjlf2Lq4Mpy9PzHUsdx93w
   Q==;
X-CSE-ConnectionGUID: Vr7eQZZ8Q5qbLyMptFTvyg==
X-CSE-MsgGUID: 5XqmMl/6STWIWgTStYNnsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88340738"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88340738"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:05:09 -0700
X-CSE-ConnectionGUID: c3TTxCEBSieNlAO1lL49+g==
X-CSE-MsgGUID: rkHx5qNSQTufs2aHc0N+Nw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 04:05:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:05:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 04:05:07 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 04:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5GQ6wOzUDX3DoPqfUE01HLPn2me1WGdBNkZ/byD9Ki/4kw79IutuMtHwfR2X74a5yGgOzUxehZW/pGwF0QPbGkrSSB+InA2yiO0TTvlLngvM4ifCDLaQXcOsMNJYwKL+C+1W1sLSmGjsIPhgjhpoVJNpqfdFpBANUscvWQhoQfHgbeihnYBrek1AZiNFf7JoLxQch6Xko1vLMEcFaHhKSOR1dIUcUf4w1Kn3reqyJh1mvyMhvR23Twn4AaLL667wQQ9qaaPcEja9LE1GiAOkn8dUu0CR/c1/eZlXkrKL6at2HlLsJ3k9a5nc1Jy26wKQRTGS2YBsP//z80EcGO/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNTb6JaTrh1KwsCpev4T17NNIaFEtqoezL6D5T6ZCaE=;
 b=kxnmH3CXu8PzMX0QXZWLrVRc/2HELHuPoq5gSN7w8yfyI0EgLwMoi99OJtUSfreTjToWBqRS19Uf/RISWk2NIoVMLoUXyYtYR61f/JuxCuR4JXEsfN+I++Y6hyuAem46ZTUvRDelxSIW228Rlc+YR8HypH7+yFbHJdCHD+DOuTf2MzPDp6WDEu+zy0rkCjl6RNXPNAZks/odalUYnuDEXK2bnRu9kGwP9KceVvJdWzU2W+7RVjLKuLSdJECV4nqwymX4Gl5iRx40O/SUa+gqcL44DvTZsghbFHrlBjNVJiSTCNj0v0zjnmPQUKlBVfdE6tVav/bXA1gjVz8r+deyGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:05:04 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::3e58:d5d:4e05:885e%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:05:03 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ali@iusegentoo.com" <ali@iusegentoo.com>,
	"kiraank@gmail.com" <kiraank@gmail.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Bag, Amit K" <amit.k.bag@intel.com>
Subject: RE: [PATCH v3 1/3] Bluetooth: btintel: validate version TLV value
 lengths
Thread-Topic: [PATCH v3 1/3] Bluetooth: btintel: validate version TLV value
 lengths
Thread-Index: AQHdOS94LnVvoyWBPkWsB6UCwppKFLa3/pew
Date: Mon, 31 Aug 2026 11:05:03 +0000
Message-ID: <PH0PR11MB7585135240BE7FA92D595420F5A92@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-1-acharyalaxman8848@gmail.com>
 <20260831095923.18830-2-acharyalaxman8848@gmail.com>
In-Reply-To: <20260831095923.18830-2-acharyalaxman8848@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DS0PR11MB6421:EE_
x-ms-office365-filtering-correlation-id: 8a04cd78-50ff-4b5c-8494-08df074fb578
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|4143699003|22082099003|18002099003|3023799007|11063799006;
x-microsoft-antispam-message-info: SOgk2VCQa2nGOpy2Agpp2i8rw8jIsyxVW/ZFhYAugMNrbSBeBjnh3tXDnrK+fAdxFTuNz6U3Q9Yvfk25UUFrlo/Wf4Z76GR3u1VIARO6rXWKprzA9LfUsjdVYdBw4wQJdHMb7NMSZaoCSEgwyHtJvj+PLJsOp9TCcSrPwg7erReGyxVk+4BUEneZzdw6Adxw2nfvvVWNELrulwJqAGpjZLCpvDf5sEILPaG7QZGsAO+/EpYIn8JosnMOaHQKq1vO2qsQibt0S3LacG8P86rVcr4vv0d52ZQbs+KveYJfCuwuF5ps4ge/pYtZc1mqJboayqhZPXTEnw1Mz4vU26NfHfvZqCYLi76CHQIin2ZPfCgoEjwwDdBxstsS74f2OPOhdzGJzn2PmR50p19j9GKlm67J9JjrnOpeoSuStpdROvtzXQn3U/bnzLBAi/h2AVNJmd7mSIy65oe6xKgRKIK7B1pK/1D7FF3/KZBv2Tdtl6ovQWtyDiT/GmUwu2RP4yVE3WCzoetDCySiFOzu+1xgFgy7c5e2NcpGOVg/GIlBc+YvU+YzOoA816PGKC1d6p2uVRktX6VDyeDreTP8Mvj4AqTBRvmDOnCa/xvxCq79B7M7INEXOvXl5VImg/Vz8IX6W1Rr5YCnXnnkxzovtLlIe4aVlVRKJ643wjZPbZWnxDerOsU2YTUkBs+UCgNG+DL3eQ4biAFStvi+yflS7GBpzlGWyYsTNN4Vm6q9Ntk2JiE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?npvHvSdaR1KH9mwAli4B1zCiIn60AdkyhprAtP8WyxWTKAuR17LhR7J2mz9/?=
 =?us-ascii?Q?7yf6JrJsnmpE1k9pkkc7QHeOD3ccz4mtyhKq9WCLVxZIlyIfMiufl1It4SQz?=
 =?us-ascii?Q?E4bd8eob3VeYVcKDPETAkUfTTsNEVV9/uv9TqsmqLELXvdVKLds4Xt/vJ3sO?=
 =?us-ascii?Q?IzrOuLKNC+ZFmg67JQPi+Xj8LHuwVkUcZnPjlJ+/I+s1rtfIf9zboeX91YtL?=
 =?us-ascii?Q?CTT0e0jcoOaa+XSVNP8pPu5Mx6das5/4oFSxym/kWMdC8X+dBZZE10gJTj4q?=
 =?us-ascii?Q?WwrMMOK3sPLYwmOH0MGI6PqpON31czaYQ2o+LTmzQXLbuuI3rv96hqz7rWbl?=
 =?us-ascii?Q?nUjGSJ+oteg/AfwWPg255mfFC16/XTAeENaLYKAsH5WjPFH22Qlc1Xl1UJS6?=
 =?us-ascii?Q?cnoc8PbHLFiB2i7IzXXvaWfehYHlHrEPlZWvJk0TeYWhn7x8Hd0Id7rWAK+a?=
 =?us-ascii?Q?jmijYe5nCaX5PXJOVxg+v0YUp0NZzfMAwF5wF759mUJYF3kPb+oMIKbyIixf?=
 =?us-ascii?Q?RZ8sn9/rTv+vkEok1P8IZnpCY1/mKPs0WtpCm+PODp8auAE++US+Azxcezu2?=
 =?us-ascii?Q?RfnN5lyVSNnANblocS5S8+4RQE/ZO1xfMvesGk/3NVvdlX/UReEECOls7W7j?=
 =?us-ascii?Q?xLQYpo/BkiBuxVZ0ujAcBppSo0aHBzXJXP2ViV+f058CSFZCvlz+J9gZ94Rv?=
 =?us-ascii?Q?Rf6Z0wzek+Jo/GLeqyQ8coLWtN4fmWuISyi0+Rxae+e5qYIq183e5ueb5YCR?=
 =?us-ascii?Q?QirgoxBzAxv3JplmYpS2jI4IqRAN/ACEP9oUng5rFdrPHk99j8+R/O2KCpRU?=
 =?us-ascii?Q?LcPViWWI5ISwt3usM3eZrToiIu9+L97+Ke4kQoiTXSm9zB5gAoP9O/QQsiWX?=
 =?us-ascii?Q?W5Y8Q4GA0PsPmVdA0BcSh3gumjQ6zsAmOTnxGzfF+gtt66HxkqVHJyOet4Ao?=
 =?us-ascii?Q?6Z9RiIugjT5xGqPW5E9rdGqf0rm/3Lycb3PWuKZTjyFXy/JHaam62xUYeUS7?=
 =?us-ascii?Q?bXalb0ZbnQJDr8JdsPRZr/XEDX6MKY94+5+EG/3QXj/2yNbhsw20FGwV9sm8?=
 =?us-ascii?Q?m+TeCzjWzl24oebmR49s7htAHGFjYW9LhBYoKOKSHoNkYbLxG8DLxyAVNmWn?=
 =?us-ascii?Q?LqTvZKMiOgdkqqtJ4qDehcixkiOXcD6Epmp6tBYVPbHhug8umoS6vaBWDR4K?=
 =?us-ascii?Q?BLeul4uAPYQ0uTC44IStZE+lxUUsia0tFk07nJFATb8xmW9rDPaFH2IQDMli?=
 =?us-ascii?Q?Oo8Js6Um6nLER+qlN9PWvLd3eNvUukO6LQehoOR4Aenh3Fy78XzI6zzeiZQE?=
 =?us-ascii?Q?hFLVHJ5Ok1TH93jvcduUbkgXYHACey5TKN8vwrlMR6dbECJ1hpLk/3npZV6e?=
 =?us-ascii?Q?xL5u/atguEmOpKHiagIxk0O+HJVfBbO566REe2MWi0J21Shh+C1dLRk94geH?=
 =?us-ascii?Q?zQZX//QzU6pwV8XB1xw2GdZ+vYI7m203NYpIEAdvhDqlP6q8HnaBHv5PTE7l?=
 =?us-ascii?Q?QnpdmLbCtcis7MWjI07JGxUdpHeqpp/R5s+kS3pxzG1rjQv05QPcUETQyt6l?=
 =?us-ascii?Q?9WaavdA/rRorKU6oU68pzARsm7bcGbifxDDrdiITr67b82rELDGJwlXy42QC?=
 =?us-ascii?Q?J201MpE2O4jpCsHxTHQrtnglMVA01jo23rYeM8ljeViJ7af1k5lJt/tiEmqh?=
 =?us-ascii?Q?JRTaj3ZtkiiOuA/VI3nAvVV9Cw3qihHQNO78UimNygLj/t1l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CYoXTE5fZpL2Enu+abPgeCWiYdV3S+ujW5FcmV6EvvBa9f8qeJXkLDLSOzUL8kwbh/wFLSawzC0EBzg3v4EEfWU1wsY+rl5eBan+msX8xzI3Z1hcOanqx1UgYbc+mSkPeLQjCUUt3y5ppMCCRtAjl/26wxf6t8daVl40S9rkUqLT84XQ/IULgpHcJ2A2C7Dqea9B3SLNkSIMr7P2FlD4iQUiOfJReK5x/hD38Q5vzgP2k7P28GGEAW0mNd6lqJ2HapqGu4uQItY0w/z6HgVBrc2ZBxSI0EOgiCHG/hl1ApxFHUb/MXotgmZK/b0EfnM1rMbGDrpiU+Zp9ypP3fxprw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a04cd78-50ff-4b5c-8494-08df074fb578
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 11:05:03.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qKA3pv9yhoX5bsC030F+vsdtHgD+UISucbXaWaCk8zXWcDzZNZiy1oEkojKe1ricipfENT+vHHEBVfgto6v3kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com


Hi Luiz,

>Subject: [PATCH v3 1/3] Bluetooth: btintel: validate version TLV value len=
gths
>
>btintel_parse_version_tlv() verifies that a complete TLV is present in the
>response, but it does not ensure that the value is long enough for the spe=
cific
>TLV type. A short value can therefore cause an out-of-bounds read through
>get_unaligned_le16(), get_unaligned_le32(), or memcpy().
>
>Reject values shorter than the minimum required by each known TLV type.
>Also reject responses that do not contain the Command Complete Status fiel=
d.
>
>Fixes: 57375beef71a ("Bluetooth: btintel: Add infrastructure to read contr=
oller
>information")
>Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>
>Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
>---
> drivers/bluetooth/btintel.c | 37
>++++++++++++++++++++++++++++++++++++-
> 1 file changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c ind=
ex
>cbeb27033..998c99b17 100644
>--- a/drivers/bluetooth/btintel.c
>+++ b/drivers/bluetooth/btintel.c
>@@ -573,12 +573,44 @@ int btintel_version_info_tlv(struct hci_dev *hdev,  =
}
>EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
>
>+static u8 btintel_version_tlv_min_len(u8 type) {
>+	switch (type) {
>+	case INTEL_TLV_CNVI_TOP:
>+	case INTEL_TLV_CNVR_TOP:
>+	case INTEL_TLV_CNVI_BT:
>+	case INTEL_TLV_CNVR_BT:
>+	case INTEL_TLV_BUILD_NUM:
>+	case INTEL_TLV_GIT_SHA1:
>+		return sizeof(u32);
>+	case INTEL_TLV_DEV_REV_ID:
>+	case INTEL_TLV_TIME_STAMP:
>+		return sizeof(u16);
>+	case INTEL_TLV_IMAGE_TYPE:
>+	case INTEL_TLV_BUILD_TYPE:
>+	case INTEL_TLV_SECURE_BOOT:
>+	case INTEL_TLV_OTP_LOCK:
>+	case INTEL_TLV_API_LOCK:
>+	case INTEL_TLV_DEBUG_LOCK:
>+	case INTEL_TLV_LIMITED_CCE:
>+	case INTEL_TLV_SBE_TYPE:
>+		return sizeof(u8);
>+	case INTEL_TLV_MIN_FW:
>+		return 3;
>+	case INTEL_TLV_OTP_BDADDR:
>+		return sizeof(bdaddr_t);
>+	default:
>+		return 0;
>+	}
>+}
>+
> int btintel_parse_version_tlv(struct hci_dev *hdev,
> 			      struct intel_version_tlv *version,
> 			      struct sk_buff *skb)
> {
> 	/* Consume Command Complete Status field */
>-	skb_pull(skb, 1);
>+	if (!skb_pull(skb, 1))
>+		return -EINVAL;
>
> 	/* Event parameters contain multiple TLVs. Read each of them
> 	 * and only keep the required data. Also, it use existing legacy @@ -
>598,6 +630,9 @@ int btintel_parse_version_tlv(struct hci_dev *hdev,
> 		if (skb->len < tlv->len + sizeof(*tlv))
> 			return -EINVAL;
>
>+		if (tlv->len < btintel_version_tlv_min_len(tlv->type))
>+			return -EINVAL;
>+
> 		switch (tlv->type) {
> 		case INTEL_TLV_CNVI_TOP:
> 			version->cnvi_top =3D get_unaligned_le32(tlv->val);
>--
>2.51.2

Tested-by: Kiran K <kiran.k@intel.com>

Thanks,
Kiran


